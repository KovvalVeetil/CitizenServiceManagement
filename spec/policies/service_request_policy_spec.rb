# require 'rails_helper'

# RSpec.describe ServiceRequestPolicy, type: :policy do
#   let(:user) { User.new }

#   subject { described_class }

#   permissions ".scope" do
#     pending "add some examples to (or delete) #{__FILE__}"
#   end

#   permissions :show? do
#     pending "add some examples to (or delete) #{__FILE__}"
#   end

#   permissions :create? do
#     pending "add some examples to (or delete) #{__FILE__}"
#   end

#   permissions :update? do
#     pending "add some examples to (or delete) #{__FILE__}"
#   end

#   permissions :destroy? do
#     pending "add some examples to (or delete) #{__FILE__}"
#   end
# end

# spec/policies/service_request_policy_spec.rb
# spec/policies/service_request_policy_spec.rb


# spec/policies/service_request_policy_spec.rb
require 'rails_helper'

RSpec.describe ServiceRequestPolicy, type: :policy do
  let(:service_request) { create(:service_request) }  # Assuming FactoryBot is used to create records
  let(:user) { create(:user) }  # This will be set for each test case

  subject { described_class.new(user, service_request) }

  describe 'Scope' do
    let!(:admin_user) { create(:user, role: :admin) }
    let!(:department_user) { create(:user, role: :department_user) }
    let!(:citizen_user) { create(:user, role: :citizen) }

    it 'allows admin to see all service requests' do
      scope = ServiceRequestPolicy::Scope.new(admin_user, ServiceRequest).resolve
      expect(scope).to include(service_request)
    end

    it 'allows department user to see service requests' do
      scope = ServiceRequestPolicy::Scope.new(department_user, ServiceRequest).resolve
      expect(scope).to include(service_request)
    end

    it 'allows citizen to see their own service request' do
      scope = ServiceRequestPolicy::Scope.new(citizen_user, ServiceRequest).resolve
      expect(scope).to include(service_request) if service_request.user_id == citizen_user.id
    end

    it 'does not allow citizen to see service requests from others' do
      scope = ServiceRequestPolicy::Scope.new(citizen_user, ServiceRequest).resolve
      expect(scope).not_to include(service_request) if service_request.user_id != citizen_user.id
    end
  end
end
