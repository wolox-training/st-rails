class OpenLibraryService
  include HTTParty
  base_uri 'https://openlibrary.org'

  def initialize(format = 'json', jscmd = 'data')
    @options = { query: { format: format, jscmd: jscmd } }
  end

  def book_info(identifier, identifier_type = 'ISBN')
    @options[:query][:bibkeys] = "#{identifier_type}:#{identifier}"
    parsed_book_info(request_book_info)
  end

  private

  def request_book_info
    self.class.get('/api/books', @options)
  end

  def parsed_book_info(api_book_info)
    book_info = api_book_info[@options[:query][:bibkeys]]
    return {} if api_book_info.blank?

    {
      isbn: book_info['identifiers']['isbn_10'].first,
      title: book_info['title'],
      subtitle: book_info['subtitle'],
      number_of_pages: book_info['number_of_pages'],
      authors: book_info['authors'].map { |a| a['name'] }
    }
  end
end
