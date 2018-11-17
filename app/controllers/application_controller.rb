class ApplicationController < ActionController::Base

  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  
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
  
end
