require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'validations' do
    it { should validate_presence_of(:content) }
  end
  
  context 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:link) }
  end
  
  it 'should have a valid factory' do
    expect(build(:comment)).to be_valid  
  end
end
