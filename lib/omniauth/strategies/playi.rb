require 'omniauth-oauth2'
class OmniAuth::Strategies::Playi < OmniAuth::Strategies::OAuth2
  option :name, 'playi'
  option :client_options, site: 'https://www.play-i.com'
  uid { raw_info['id'] }
  info do
    {
      username: raw_info['username'],
      name: raw_info['name'],
      email: raw_info['email']
    }
  end
  extra do
    {
      'raw_info' => raw_info
    }

  end
  def raw_info
    @raw_info ||= access_token.get('/oauth/me.json').parsed
  end
end