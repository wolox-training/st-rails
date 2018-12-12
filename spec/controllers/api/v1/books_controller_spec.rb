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

        it 'serializes with BookSerializer' do
          expect(JSON.parse(response.body)['page']).to have_been_serialized_with(BookSerializer)
        end

        it 'includes all book ids' do
          expected_book_ids = Book.pluck(:id)
          response_book_ids = JSON.parse(response.body)['page'].map {|b| b['id']}
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
    subject(:http_request) { get :show, params: params}
    let!(:book) { create(:book) }

    context 'When user is authenticated' do
      include_context 'Authenticated User'

      before do
        http_request
      end

      context 'When fetching an existing book' do
        let(:params) { {id: book.id} }

        it 'serializes with BookSerializer' do
          expect(JSON.parse(response.body)).to have_been_serialized_with(BookSerializer)
        end

        it 'responds with 200 status' do
          expect(response).to have_http_status(:ok)
        end
      end

      context 'When fetching a non existing book' do
        let(:params) { {id: 0} }

        it 'responds with 404 status' do
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    include_examples 'Unauthenticated User'
  end

end
