module ApplicationHelper
  def format_date(date)
    date&.strftime('%m/%d/%Y')
  end

  def format_datetime(date)
    date&.strftime('%e %B at %l %P')
  end

  def checked(name)
    params[:filter].present? && params[:filter].include?(name.to_s)
  end

  def get_avatar(photo)
    photo.exists? ? photo.url : 'profile-icon.png'
  end

  def number_of_available_user_notifications(club, user)
    club.notifications.where.not(creator: user).count
  end
end
