class SettingPolicy < ApplicationPolicy

  def index?
  	user.admin? || user.developer?
  end

end