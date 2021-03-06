require 'rails_helper'

def mock_open_library_request_valid_isbn(isbn)
  WebMock.stub_request(:get, 'https://openlibrary.org/api/books')
         .with(query: { format: 'json', jscmd: 'data', bibkeys: "ISBN:#{isbn}" })
         .to_return(status: 200, headers: { 'Content-Type' => 'application/json' },
                    body: File.read('spec/support/fixtures/open_library_response_success.json')
                              .gsub('{isbn}', isbn))
end

def mock_open_library_request_invalid_isbn
  WebMock.stub_request(:get, 'https://openlibrary.org/api/books')
         .with(query: { format: 'json', jscmd: 'data', bibkeys: 'ISBN:1' })
         .to_return(status: 200, headers: { 'Content-Type' => 'application/json' }, body: '{}')
end
