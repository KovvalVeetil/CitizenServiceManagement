require 'rails_helper'

RSpec.describe ServiceRequest, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      request = build(:service_request)
      expect(request).to be_valid
    end

    it 'is invalid without a citizen_name' do
      request = build(:service_request, citizen_name: nil)
      expect(request).not_to be_valid
    end

    it 'is invalid with an unsupported category' do
      request = build(:service_request, category: 'invalid_category')
      expect(request).not_to be_valid
    end
  end

  describe 'scopes' do
    it 'returns pending requests' do
      create(:service_request, status: 'pending')
      create(:service_request, status: 'resolved')
      expect(ServiceRequest.pending.count).to eq(1)
    end
  end
end
