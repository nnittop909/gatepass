class Users::SessionsController < Devise::SessionsController
	before_action :authenticate_user!
  layout 'signin'
end
