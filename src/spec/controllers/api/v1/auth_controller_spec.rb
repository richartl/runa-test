require 'rails_helper'

describe Api::V1::AuthController, type: :controller do
  let(:user) { Fabricate(:user) }
  let(:login_params) do
    {
      email: user.email,
      password: user.password
    }
  end

  let(:incorrect_login_params) do
    {
      email: user.email,
      password: 123
    }
  end

  let(:numbers_as_email) do
    {
      email: 1234,
      password: 123
    }
  end

  let(:email_blank) do
    {
      email: '',
      password: 123
    }
  end

  context 'when the access credentials are correct' do
    before do
      post :authenticate_user, params: login_params
    end

    it 'returns 200' do
      expect(response).to have_http_status(200)
    end

    it 'response has format as' do
      expect(response.body).to match_response_schema('api/v1/auth/login_response')
    end

  end

  context 'when the access credentials are incorrect' do
    before do
      post :authenticate_user, params: incorrect_login_params
    end

    it 'returns 401' do
      expect(response).to have_http_status(401)
    end

    it 'response has format as' do
      expect(response.body).to match_response_schema('api/v1/errors/general')
    end
  end

  context 'when send numbers s email' do
    before do
      post :authenticate_user, params: numbers_as_email
    end

    it 'returns 422' do
      expect(response).to have_http_status(422)
    end

    it 'response has format as' do
      expect(response.body).to match_response_schema('api/v1/errors/general')
    end
  end

  context 'when send email blank' do
    before do
      post :authenticate_user, params: email_blank
    end

    it 'returns 422' do
      expect(response).to have_http_status(422)
    end

    it 'response has format as' do
      expect(response.body).to match_response_schema('api/v1/errors/general')
    end
  end
end
