require 'rails_helper'

RSpec.describe Api::V1::BooksController, type: :controller do

  context 'When user is authenticated' do
    include_context 'Authenticated User'

     describe 'GET #index' do
      context 'When fetching all the books' do
        let!(:books) { create_list(:book, 3) }

        before do
          get :index
        end

        it 'response is paginated' do
          expect(JSON.parse(response.body)).to be_paginated
        end

        it 'response to be serialized with BookSerializer' do
          expect(JSON.parse(response.body)['page']).to have_been_serialized_with(BookSerializer)
        end

        it 'response page include all book ids' do
          expected_book_ids = Book.pluck(:id)
          response_book_ids = JSON.parse(response.body)['page'].map {|b| b['id']}
          expect(expected_book_ids.sort).to eql(response_book_ids.sort)
        end

        it 'responds with 200 status' do
          expect(response).to have_http_status(:ok)
        end
      end
    end

    describe 'Get #show' do
      let!(:book) { create(:book) }

      context 'When fetching an existing book' do

        before do
          get :show, params: {id: book.id}
        end

        it 'response to be serialized with BookSerializer' do
          expect(JSON.parse(response.body)).to have_been_serialized_with(BookSerializer)
        end

        it 'responds with 200 status' do
          expect(response).to have_http_status(:ok)
        end
      end

    #   context 'When fetching a non existing book' do

    #     before do
    #       get :show, params: {id: 0}
    #     end

    #     it 'responds with 404 status' do
    #       expect(response).to have_http_status(:not_found)
    #     end
    #   end
    end


  end

  include_examples 'Unauthenticated User'

end
