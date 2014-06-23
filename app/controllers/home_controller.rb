require 'base64'
# home controller
class HomeController < ApplicationController
  def index
    @cateogries = { officials: 'document', coaches: 'forum' }
    group = '11,12'
    user = 'webonise@webonise.com'
    ts = Time.now.to_i
    # secret = 'e47d33919f45f0501595f996bc6b09552ed5cc56f0f68051bc743ea32ad7ffd0'
    secret = '3631f3087eacbd4af8a5f3626cfce9d5eee69b8b7c5f179569aaaf912cf8f817'
    @sso = Base64.encode64("#{user}:#{group}:#{ts}:#{secret}")
  end
end
