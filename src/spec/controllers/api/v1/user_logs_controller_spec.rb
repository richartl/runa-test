require 'rails_helper'

describe Api::V1::UserLogsController, type: :controller do
  let(:admin) { Fabricate(:user) }
  let(:employee) { Fabricate(:user) }
  let(:in_type) { Fabricate(:user_log_type, name: 'in_test') }
  let(:out_type) { Fabricate(:user_log_type, name: 'out_test') }

  before(:each) do
    admin.add_role User::ADMIN_ROLE.to_sym
    employee.add_role User::EMPLOYEE_ROLE.to_sym
  end

  describe 'POST create' do
    let(:in_request) do
      {
        user_id: employee.id,
        user_log_type_id: in_type.id
      }
    end

    let(:out_request) do
      {
        user_id: employee.id,
        user_log_type_id: out_type.id
      }
    end
    context 'when the user is not authorized' do
      before do
        post :create, params: in_request
      end

      it 'returns 401' do
        expect(response).to have_http_status(401)
      end

      it 'response has format as' do
        expect(response.body).to match_response_schema('api/v1/errors/general')
      end
    end

    context 'when a employee wants create in log' do
      before do
        post :create, params: in_request
        allow(controller).to receive(:authenticate_user).and_return(true)
        allow(controller).to receive(:current_user).and_return(employee)
      end

      it 'returns 401' do
        expect(response).to have_http_status(401)
      end

      it 'response has format as' do
        expect(response.body).to match_response_schema('api/v1/errors/general')
      end
    end

    context 'when a admin wants create in log' do
      before do
        allow(controller).to receive(:authenticate_user).and_return(true)
        allow(controller).to receive(:current_user).and_return(admin)
        post :create, params: in_request
      end

      it 'returns 201' do
        expect(response).to have_http_status(201)
      end

      it 'creates user log' do
        expect(UserLog.last).to_not eq(nil)
      end

      it 'user log is in type log' do
        expect(UserLog.last.user_log_type.name).to eq('in_test')
      end

      it 'response has format as' do
        expect(response.body).to match_response_schema('api/v1/user_logs/create')
      end
    end

    context 'when a admin wants create out log' do
      before do
        allow(controller).to receive(:authenticate_user).and_return(true)
        allow(controller).to receive(:current_user).and_return(admin)
        post :create, params: out_request
      end

      it 'returns 201' do
        expect(response).to have_http_status(201)
      end

      it 'creates user log' do
        expect(UserLog.last).to_not eq(nil)
      end

      it 'user log is in type log' do
        expect(UserLog.last.user_log_type.name).to eq('out_test')
      end

      it 'response has format as' do
        expect(response.body).to match_response_schema('api/v1/user_logs/create')
      end
    end
  end

  describe 'GET index' do
    let(:employee_request_index) do
      {
        user_id: employee.id
      }
    end

    let(:admin_request_index) do
      {
        user_id: admin.id
      }
    end
    let(:user_in_log) { Fabricate(:user_log, employee: employee, admin: admin, user_log_type: in_type) }

    context 'when a employee wants to see his log' do
      before do
        allow(controller).to receive(:authenticate_user).and_return(true)
        allow(controller).to receive(:current_user).and_return(employee)
        user_in_log
        get :index, params: employee_request_index
      end

      it 'returns 200' do
        expect(response).to have_http_status(200)
      end

      it 'response has format as' do
        expect(response.body).to match_response_schema('api/v1/user_logs/index')
      end

      it 'responses are of employee' do
        response_json = JSON.parse response.body
        expect(response_json['data'][0]['relationships']['employee']['data']['id'].to_i).to eq(employee.id)
      end
    end

    context 'when a admin wants to see his employees logs' do
      before do
        allow(controller).to receive(:authenticate_user).and_return(true)
        allow(controller).to receive(:current_user).and_return(admin)
        user_in_log
        get :index, params: admin_request_index
      end

      it 'returns 200' do
        expect(response).to have_http_status(200)
      end

      it 'response has format as' do
        expect(response.body).to match_response_schema('api/v1/user_logs/index')
      end

      it 'responses are of admin' do
        response_json = JSON.parse response.body
        expect(response_json['data'][0]['relationships']['admin']['data']['id'].to_i).to eq(admin.id)
      end
    end
  end
end
