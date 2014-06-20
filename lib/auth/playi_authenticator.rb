require 'auth/oauth2_authenticator'
  class Auth::PlayiAuthenticator < ::Auth::OAuth2Authenticator

  def register_middleware(omniauth)
    omniauth.provider :playi, SiteSetting.playi_client_id, SiteSetting.playi_client_secret
  end
  def after_authenticate(auth_token)
    result = Auth::Result.new
    oauth2_provider = auth_token[:provider]
    oauth2_uid = auth_token[:uid].to_s
    data = auth_token[:info]
    result.email = email = data[:email]
    result.name = name = data[:name]
    result.username = username = data[:username]
    oauth2_user_info = Oauth2UserInfo.where(uid: oauth2_uid, provider: oauth2_provider).first
    if !oauth2_user_info && @opts[:trusted] && user = User.find_by_email(email)
      oauth2_user_info = Oauth2UserInfo.create(uid: oauth2_uid, provider: oauth2_provider, name: name, email: email, user: user)
    end
    result.user = oauth2_user_info.try(:user)
    result.email_valid = @opts[:trusted]
    result.extra_data = {
      uid: oauth2_uid,
      provider: oauth2_provider
    }
    result
  end
end