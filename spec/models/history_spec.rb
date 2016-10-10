require "rails_helper"

RSpec.describe History do 

	before(:each) do
		@u = FactoryGirl.create(:user)
		@h = History
		@h1 = FactoryGirl.create(:history)
  end

	it "should increment with data if user visit admin-panel" do
		History.register(user_id: @u.id)
		expect(@h.last.user_id).to eq(@u.id)
	end
	
end