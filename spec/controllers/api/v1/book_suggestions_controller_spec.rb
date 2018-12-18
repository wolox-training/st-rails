require 'rails_helper'

RSpec.describe Api::V1::BookSuggestionsController, type: :controller do

  describe 'Post #create' do
    subject(:http_request) { post :create, params: params}

    context 'When creating a valid book suggestion' do
      let(:params) { {book_suggestion: {
                      author: "Vallie Kulas", 
                      title: "The Moon by Night", 
                      link: "http://veum.co/paris", 
                      editor: "Noone", 
                      year: "2012", 
                      price: "59.75", 
                      synopsis: "This book is about..."}}}

      it 'is serialized with BookSerializer' do
        http_request
        expect(JSON.parse(response.body)).to have_been_serialized_with(BookSuggestionSerializer)
      end

      it 'responds with 201 status' do
        http_request
        expect(response).to have_http_status(:created)
      end

      it 'creates a new book suggestion' do
        expect do 
          http_request
        end.to change {BookSuggestion.count}.by 1
      end
    end

    context 'When creating an invalid book suggestion' do
      let(:params) { {book_suggestion: {
                      author: "", 
                      title: "", 
                      link: "", 
                      editor: "", 
                      year: "", 
                      price: "", 
                      synopsis: ""}}}

      it 'responds with 400 status' do
        http_request
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns error messages' do
        http_request
        expect(JSON.parse(response.body)['errors']).to be_present
      end

      it 'does not create a new book suggestion' do
        expect do 
          http_request
        end.to change {BookSuggestion.count}.by 0
      end
    end

    context 'When user is authenticated' do
      include_context 'Authenticated User'

      context 'When creating a valid book suggestion' do
        let(:params) { {book_suggestion: {
                        author: "Vallie Kulas", 
                        title: "The Moon by Night", 
                        link: "http://veum.co/paris", 
                        editor: "Noone", 
                        year: "2012", 
                        price: "59.75", 
                        synopsis: "This book is about..."}}}

        it 'creates a book with the logged in user id' do
          http_request
          expect(BookSuggestion.last.user_id).to eq User.last.id 
        end

      end

    end


  end

end
