require 'rails_helper'

RSpec.describe ServiceRequestsController, type: :controller do
  let(:user) { create(:user) }
  let(:admin_user) { create(:user, role: :admin) }
  let(:department_user) { create(:user, role: :department_user) }
  let(:service_request) { create(:service_request, user: user) }

  before do
    sign_in admin_user # Assuming Devise authentication
  end

  describe 'GET #index' do
    let!(:service_requests) { create_list(:service_request, 3, user: user) }

    it 'returns all service requests' do
      get :index
      expect(response).to have_http_status(:ok)
      expect(json_response.length).to eq(3)
    end
  end

  describe 'GET #show' do
    it 'returns the requested service request' do
      get :show, params: { id: service_request.id }
      expect(response).to have_http_status(:ok)
      expect(json_response['id']).to eq(service_request.id)
    end
  end

  describe 'POST #create' do
    let(:valid_params) do
      {
        citizen_name: 'John Doe',
        address: '123 Main St',
        category: 'others',
        description: 'Description of issue',
        status: 'pending'
      }
    end

    before do
        sign_in user
      end

    it 'creates a new service request' do
      post :create, params: { service_request: valid_params }
      expect(response).to have_http_status(:created)
      expect(json_response['citizen_name']).to eq('John Doe')
    end

    it 'does not create a service request with invalid data' do
      post :create, params: { service_request: { citizen_name: '', category: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PUT #update' do
    let(:new_attributes) { { citizen_name: 'Jane Doe', status: 'resolved' } }

    before do
        sign_in admin_user
      end

    it 'updates the service request' do
      put :update, params: { id: service_request.id, service_request: new_attributes }
      expect(response).to have_http_status(:ok)
      expect(service_request.reload.citizen_name).to eq('Jane Doe')
    end

    it 'returns an error when the service request is invalid' do
      put :update, params: { id: service_request.id, service_request: { citizen_name: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the service request' do
      delete :destroy, params: { id: service_request.id }
      expect(response).to have_http_status(:no_content)
      expect { service_request.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  private

  def json_response
    JSON.parse(response.body)
  end
end
