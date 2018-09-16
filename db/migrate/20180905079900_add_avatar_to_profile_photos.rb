class AddAvatarToProfilePhotos < ActiveRecord::Migration[5.1]
  def up
    add_attachment :profile_photos, :avatar
  end

  def down
    remove_attachment :profile_photos, :avatar
  end
end
