FactoryGirl.define do

	factory :diary do

		title "title SimplyBlog"
		sequence(:content) { |i| "Content SimplyBlog #{i}"}
 		association(:user)
  end
	
end