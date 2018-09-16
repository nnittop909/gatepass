class ProfilePhoto < ApplicationRecord
  belongs_to :user, optional: true

  has_attached_file :avatar,
                    styles: { 
                    	large: "250x250>",
                   		medium: "120x120>",
                    	small: "40x40>"},
                     default_url: ":style/default.png",
                    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
                    :url => "/system/:attachment/:id/:style/:filename"
  validates_attachment :avatar, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
  before_save :set_filename

  def filename
    extension = File.extname(self.avatar_file_name)
    [self.user.id_number, extension].join("")
  end

  def set_filename
    self.avatar_file_name = filename
  end

  def upload_error
    if self.errors[:avatar].any?
      errors.add(:profile_photo, "Unable to upload #{self.avatar_file_name}. Only accepts jpg, jpeg, png, and gif images.")
    end
  end
end
