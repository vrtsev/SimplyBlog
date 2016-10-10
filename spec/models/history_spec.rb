require "rails_helper"

RSpec.describe History do 

	before(:each) do
		@h = History
  end

	it "should be created" do
		expect(@h.exists?).to eq true
	end

	it "should increment with data if user visit admin-panel" do
		u = FactoryGirl.create(:user)
		History.register(user_id: u.id)
		expect(@h.last.user_id).to eq(u.id)
	end
	
end