require 'rails_helper'

RSpec.describe OpenLibraryService do
  
  
  describe '#book_info' do
    subject(:book_info) { OpenLibraryService.new.book_info(isbn) }

    context 'When ISBN is valid' do
      let(:isbn) { '0385472579' }

      before do
        mock_open_library_request_valid_isbn
        book_info
      end

      it 'makes an external request' do
        expect(WebMock).to(have_requested(:get, 'https://openlibrary.org/api/books').
          with(query: { format: 'json', jscmd: 'data', bibkeys: "ISBN:0385472579" }))
      end

      it 'returns a hash with the book main info' do
        expect(book_info).to eq(JSON.parse(File.read('spec/support/fixtures/open_library_service_parsed_response.json')).symbolize_keys)
      end

    end

    context 'When ISBN is invalid' do 
      
      let(:isbn) { '1' }

      before do
        mock_open_library_request_invalid_isbn
        book_info
      end
      
      it 'makes an external request' do
        expect(WebMock).to(have_requested(:get, 'https://openlibrary.org/api/books').
          with(query: { format: 'json', jscmd: 'data', bibkeys: "ISBN:1" }))
      end

      it 'returns an empty hash' do
        expect(book_info).to eq({})
      end

    end

  end
end
