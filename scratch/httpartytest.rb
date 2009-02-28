require 'rubygems'
require 'httparty'

class SocialSearch
  include HTTParty
  base_uri 'search.socialactions.com/actions.json'
  default_params :output => 'json'
  format :json

  def self.find_by_keyword(keyword)
    get('', :query => {:q => keyword})
  end

end

