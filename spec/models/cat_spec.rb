require "rails_helper"

RSpec.describe Cat, :type => :model do

  describe 'validations' do
    it 'has a valid factory' do
      expect(FactoryGirl.build(:testcat)).to be_valid
    end

    it 'is invalid without a rescue_id' do
      expect(FactoryGirl.build(:testcat, rescue_id: nil)).to_not be_valid
    end

    it 'is invalid with a blank rescue_id' do
      expect(FactoryGirl.build(:testcat, rescue_id: '')).to_not be_valid
    end
  end

  describe 'id_string' do
    it 'returns a string with both name and rescue_id if both are set' do
      test_testcat = FactoryGirl.build(:testcat)
      expect(test_testcat.id_string).to eq("#{test_testcat.name} (#{test_testcat.rescue_id})")
    end

    it 'returns a string with just rescue_id if name is not set' do
      test_testcat = FactoryGirl.build(:testcat)
      test_testcat.name = ''
      expect(test_testcat.id_string).to eq("#{test_testcat.rescue_id}")
    end
  end

  describe 'changed rescue_id' do
    it "prevents rescue_id from being changed" do
      test_testcat = FactoryGirl.create(:testcat)
      test_testcat[:rescue_id] = 'new_id'
      expect(test_testcat).to_not be_valid
    end
  end
end