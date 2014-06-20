require 'base64'
# home controller
class HomeController < ApplicationController
  def index
    group = [13,14]
    user = 'webonise4@webonise.com'
    ts = Time.now.to_i
    secret = 'e47d33919f45f0501595f996bc6b09552ed5cc56f0f68051bc743ea32ad7ffd0'
    @sso = Base64.encode64("#{user}:#{group}:#{ts}:#{secret}")
  end
end
