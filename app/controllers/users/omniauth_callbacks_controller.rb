# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # callback for facebook
  def facebook
    callback_for(:facebook)
  end

  # callback for twitter
  def twitter
    callback_for(:twitter)
  end

  # callback for google
  def google
    callback_for(:google)
  end

  # common callback method
  def callback_for(provider)
    @user = User.from_omniauth(auth_data, current_user)
    if @user.persisted?
      if current_user == @user
        redirect_to edit_user_registration_path, notice: "#{provider.to_s.capitalize}と連携しました"
      else
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
      end
    else
      session['devise.omniauth_data'] = auth_data.except('extra')
      msg = @user.errors.full_messages.join("\n")
      redirect_to new_user_registration_url, alert: msg
    end
  end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  def failure
    redirect_to root_path
  end

  private
    def auth_data
      request.env['omniauth.auth']
    end

  protected
    # The path used when OmniAuth fails
    # def after_omniauth_failure_path_for(scope)
    #   super(scope)
    # end
    def after_sign_in_path_for(resource)
      if resource.sign_in_count == 1
        flash.alert = '好きなユーザー名を設定してください'
        edit_user_registration_path
      else
        super(resource)
      end
    end
end
