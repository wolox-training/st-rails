require 'rails_helper'

RSpec.describe Api::V1::BooksController, type: :controller do
  describe 'GET #index' do
    subject(:http_request) { get :index }
    let!(:books) { create_list(:book, 3) }

    context 'When user is authenticated' do
      include_context 'Authenticated User'

      before do
        http_request
      end

      context 'When fetching all the books' do
        it 'paginates records' do
          expect(JSON.parse(response.body)).to be_paginated
        end

        it 'is serialized with BookSerializer' do
          expect(JSON.parse(response.body)['page']).to have_been_serialized_with(BookSerializer)
        end

        it 'includes all book ids' do
          expected_book_ids = books.pluck(:id)
          response_book_ids = JSON.parse(response.body)['page'].map { |b| b['id'] }
          expect(expected_book_ids.sort).to eql(response_book_ids.sort)
        end

        it 'responds with 200 status' do
          expect(response).to have_http_status(:ok)
        end
      end
    end

    include_examples 'Unauthenticated User'
  end

  describe 'Get #show' do
    subject(:http_request) { get :show, params: params }
    let(:book) { create(:book) }

    context 'When user is authenticated' do
      include_context 'Authenticated User'

      before do
        http_request
      end

      context 'When fetching an existing book' do
        let(:params) { { id: book.id } }

        it 'is serialized with BookSerializer' do
          expect(JSON.parse(response.body)).to have_been_serialized_with(BookSerializer)
        end

        it 'responds with 200 status' do
          expect(response).to have_http_status(:ok)
        end
      end

      context 'When fetching a non existing book' do
        let(:params) { { id: 0 } }

        it 'responds with 404 status' do
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    let(:params) { { id: book.id } }
    include_examples 'Unauthenticated User'
  end

  describe 'GET #info' do
    subject(:http_request) { get :info, params: params }

    context 'When user is authenticated' do
      include_context 'Authenticated User'

      context 'When fetching an existing book' do
        before do
          open_library_stubbed_service = instance_double(OpenLibraryService)
          allow(open_library_stubbed_service).to receive(:book_info).and_return(
            JSON.parse(File.read('spec/support/fixtures/open_library_service_parsed_response.json')
                           .gsub('{isbn}', params[:isbn])).symbolize_keys
          )
          allow(OpenLibraryService).to receive(:new).and_return(open_library_stubbed_service)
          http_request
        end

        let(:params) { { isbn: Faker::Number.number(10) } }
        it 'responds with the book info' do
          expect(JSON.parse(response.body)).to eql(
            JSON.parse(File.read('spec/support/fixtures/open_library_service_parsed_response.json')
                           .gsub('{isbn}', params[:isbn]))
          )
        end

        it 'responds with 200 status' do
          expect(response).to have_http_status(:ok)
        end
      end

      context 'When fetching a non existing book' do
        before do
          open_library_stubbed_service = instance_double(OpenLibraryService)
          allow(open_library_stubbed_service).to receive(:book_info).and_return({})
          allow(OpenLibraryService).to receive(:new).and_return(open_library_stubbed_service)
          http_request
        end

        let(:params) { { isbn: '0' } }
        it 'responds with and empty json' do
          expect(JSON.parse(response.body)).to eql({})
        end

        it 'responds with 404 status' do
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'When isbn param is not present' do
        before do
          http_request
        end

        let(:params) { { isbn: nil } }

        it 'responds with 400 status' do
          expect(response).to have_http_status(:bad_request)
        end
      end
    end

    let(:params) { { isbn: '0385472579' } }
    include_examples 'Unauthenticated User'
  end
end
