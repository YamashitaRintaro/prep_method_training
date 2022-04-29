require 'rails_helper'

RSpec.describe 'PasswordResets', type: :request do
  describe 'GET /new' do
    it 'returns http success' do
      get new_password_reset_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /create' do
    it 'returns http success' do
      get password_resets_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get edit_password_reset_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /update' do
    it 'returns http success' do
      get password_reset_path
      expect(response).to have_http_status(:success)
    end
  end
end
