require 'rails_helper'

describe Api::V1::UserLogTypesController, type: :controller do
  let(:in_type) { Fabricate(:user_log_type, name: 'in_test') }
  let(:out_type) { Fabricate(:user_log_type, name: 'out_test') }

  describe 'GET index' do
    context 'when someone wants get user log types' do
      before do
        in_type
        out_type
        get :index
      end

      it 'returns 200' do
        expect(response).to have_http_status(200)
      end

      it 'response has format as' do
        expect(response.body).to match_response_schema('api/v1/user_log_types/index')
      end
    end
  end
end
