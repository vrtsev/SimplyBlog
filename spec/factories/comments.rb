FactoryGirl.define do

	factory :comment do

		sequence(:content) { |i| "Content SimplyBlog #{i}"}
 		association(:user)
 		association(:post)
 		
  end
	
end