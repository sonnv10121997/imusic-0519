class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    handle_auth_from Settings.omniauth.facebook
  end

  def google_oauth2
    handle_auth_from Settings.omniauth.google_oauth2
  end

  def failure
    redirect_to root_path
  end

  private

  def handle_auth_from provider
    @user = User.from_omniauth request.env["omniauth.auth"]
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      if is_navigational_format?
        set_flash_message :notice, :success, kind: provider.capitalize
      end
    else
      session["devise.#{provider}_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
