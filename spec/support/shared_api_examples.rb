shared_examples 'Unauthenticated User' do
  context 'When user is not authenticated' do
    before do
      http_request
    end

    it 'responds with 401 status' do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
