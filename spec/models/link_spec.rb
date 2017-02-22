require 'rails_helper'

RSpec.describe Link, type: :model do
  context 'validations' do
    it { should validate_uniqueness_of(:url) }  
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
  end
  
  context 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:approvals) }
    it { should have_many(:approvers) }
    it { should have_many(:comments) }
  end
end
