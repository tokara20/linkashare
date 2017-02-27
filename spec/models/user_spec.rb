require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it do 
      should validate_length_of(:username)
              .is_at_least(3)
              .is_at_most(15)
    end
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
  end
  
  context 'associations' do
    it { should have_many(:links) }
    it { should have_many(:approvals) }
    it { should have_many(:approved_links) }
    it { should have_many(:comments) }
  end
  
  it 'should have a valid factory' do
    expect(build(:user)).to be_valid  
  end
end
