module Students
	class ProfilePhotoPolicy < ApplicationPolicy

		def create?
			user.admin? || user.developer?
		end
	end
end