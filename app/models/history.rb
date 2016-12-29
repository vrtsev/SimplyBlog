class History < ApplicationRecord
	belongs_to :user

	def self.register(params)
		h = self.new(params)
		if h.save
	    logger.info "[AdminControl] User : #{h.user_id} has been registered to history"
	  end
	end
end
