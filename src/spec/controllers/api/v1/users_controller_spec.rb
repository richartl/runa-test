require 'rails_helper'

describe Api::V1::UsersController, type: :controller do
  let(:admin) { Fabricate(:user) }
  let(:employee) { Fabricate(:user) }

  before(:each) do
    admin.add_role User::ADMIN_ROLE.to_sym
    employee.add_role User::EMPLOYEE_ROLE.to_sym
  end

  describe 'GET index' do
    context 'when employee wants get users' do
      before do
        allow(controller).to receive(:authenticate_user).and_return(true)
        allow(controller).to receive(:current_user).and_return(employee)
        get :index
      end

      it 'returns 401' do
        expect(response).to have_http_status(401)
      end

      it 'response has format as' do
        expect(response.body).to match_response_schema('api/v1/errors/general')
      end
    end

    context 'when admin wants get users' do
      before do
        allow(controller).to receive(:authenticate_user).and_return(true)
        allow(controller).to receive(:current_user).and_return(admin)
        get :index
      end

      it 'returns 200' do
        expect(response).to have_http_status(200)
      end

      it 'response has format as' do
        expect(response.body).to match_response_schema('api/v1/users/index')
      end
    end
  end
end
