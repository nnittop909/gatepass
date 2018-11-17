class Log < ApplicationRecord
  belongs_to :student, class_name: "User", foreign_key: "user_id"

  enum remark:[:signed_in, :signed_out]

  def time
  	log_time
  end

end
