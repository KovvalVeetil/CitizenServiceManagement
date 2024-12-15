require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = build(:user, :citizen)
      expect(user).to be_valid
    end

    it 'is invalid without a valid role' do
      user = build(:user, role: 'invalid_role')
      expect(user).not_to be_valid
    end
  end

  describe 'role methods' do
    it 'returns true for the correct role method' do
      admin = build(:user, :admin)
      citizen = build(:user, :citizen)
      dept_user = build(:user, :department_user)

      expect(admin.admin?).to be true
      expect(admin.citizen?).to be false
      expect(citizen.citizen?).to be true
      expect(dept_user.department_user?).to be true
    end
  end
end
