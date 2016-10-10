class History < ApplicationRecord

	belongs_to :user

	def register
		h = self.new(params.require(:history).permit(:user_id))
		h.save

end
