class ApplicationController < ActionController::Base

  include Pundit
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  rescue_from Pundit::NotAuthorizedError, with: :permission_denied
  
  def after_sign_in_path_for(current_user)
    students_url
  end

  def respond_modal_with(*args, &blk)
    options = args.extract_options!
    options[:responder] = ModalResponder
    respond_with *args, options, &blk
  end

  def current_log_remark(student)
  	student.log.remark
  end

  def permission_denied
    redirect_to after_sign_in_path_for(current_user), alert: 'Sorry, you are not allowed to access this page/feature.'
  end

  def check_subscription!
    subscription_date = Settings::Configuration.first.subscription_date
    if subscription_date >= (subscription_date + 1.year)
      redirect_to page_unavailable_index_url
    end
  end
  
end
