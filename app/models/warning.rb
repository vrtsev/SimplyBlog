class Warning < ApplicationRecord
	def publ
		obj = self.public
		self.public = true if obj == false
		self.public = false if obj == true
		save
	end
end
