module UsersHelper
  def user_avatar user
    if user.avatar.blank?
      image_tag "avatar.jpg", size: Settings.avatar_size
    else
      image_tag user.avatar.avatar.to_s
    end
  end
end
