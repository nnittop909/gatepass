module ApplicationHelper
	def flash_class(level)
    case level
      when :notice then "alert alert-info"
      when :success then "alert alert-success"
      when :error then "alert alert-error"
      when :alert then "alert alert-alert"
    end
  end

  def status_class(status)
    case status
      when "suspended" then "label label-warning"
      when "dropped" then "label label-danger"
      when "clear" then nil
      when nil then nil
    end
  end

  def site_name
    "GatePass Monitoring"
  end

  # Returns the full title on a per-page basis.
  # No need to change any of this we set page_title and site_name elsewhere.
  def full_title(page_title)
    if page_title.empty?
      site_name
    else
      "#{page_title} | #{site_name}"
    end
  end

  def whitelisted_roles
    User.whitelisted_roles.map {|i| [i.titleize, i]}
  end

  def blacklisted_roles
    User.blacklisted_roles.map {|i| [i.titleize, i]}
  end

  def roles_select
    User.roles.keys.to_a.map {|i| [i.titleize, i]}
  end

  def statuses_select
    User.statuses.keys.to_a.map {|i| [i.titleize, i]}
  end

  def whitelisted_statuses
    User.whitelisted_statuses.map {|i| [i.titleize, i]}
  end
end
