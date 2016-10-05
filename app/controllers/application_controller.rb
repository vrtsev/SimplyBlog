class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  around_action :with_time_zone, if: 'current_user.try(:time_zone)'

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
    end

    def check_admin
      if current_user.admin
      else
        redirect_to 'posts/index'
      end
    end

  	def with_time_zone(&block)
  		time_zone = current_user.time_zone
  		logger.debug "Используется часовой пояс пользователя: #{time_zone}"
  		Time.use_zone(time_zone.&block)
  	end

  	def time_zone
  		unless @time_zone
  			tz_id = read_attribute(:time_zone)
  			as_name = ActiveSupport::TimeZone::MAPPING.select do |_,v|
  				v == tz_id
  			end.sort_by do |k,v|
  				v.ends_with?(k) ? 0 : 1
  			end.first.try(:first)
  			value = as_name || tz_id
  			@time_zone = value && ActiveSupport::TimeZone[value]
  		end
  		@time_zone
  	end

  	def time_zone=(value)
  		tz_id = value.respond_to?(:tzinfo) && value.tzinfo.name || nil
  		tz_id ||= TZInfo.Timezone.get(ActiveSupport::TimeZone::MAPPING[value.to_s] || value.to_s).identifier rescue nil
  		@time_zone = tz_id && ActiveSupport::TimeZone[ActiveSupport::TimeZone::MAPPING.key(tz_id) || tz_id ]
  		write_attribute(:time_zone, tz_id)
  	end
end
