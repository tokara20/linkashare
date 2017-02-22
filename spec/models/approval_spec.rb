require 'rails_helper'

RSpec.describe Approval, type: :model do
   context 'validations' do
    it { should validate_uniqueness_of(:link_id).scoped_to(:user_id) }
  end
  
  context 'associations' do
    it { should belong_to(:approver) }
    it { should belong_to(:approved_link) }
  end
  
  it 'should have a valid factory' do
    expect(build(:approval)).to be_valid  
  end
end
