class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception

	before_action :configure_permitted_parameters, if: :devise_controller?

	def after_sign_in_path_for(resource)
		user_path(resource)
	end

	def after_sign_up_path_for(resource)
		user_path(resource)
	end

	def update_resource(resource, params)
		resource.update_without_password(params)
	end

	protected


	def configure_permitted_parameters
		added_attrs = [:name, :email, :password, :password_confirmation, :remember_me]
		#added_bttrs = [:name, :password, :remember_me]
		devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
		devise_parameter_sanitizer.permit(:sign_in, keys: [:name, :password, :remember_me])
	end

	def configure_account_update_params
		devise_parameter_sanitizer.permit(:account_update, keys:[:name, :introduction])
	end
end
