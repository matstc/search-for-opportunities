require 'httparty'
require 'uri'

class SocialSearch
  include HTTParty
  @@JSON_URI = 'search.socialactions.com/actions.json'
  @@RSS_URI = 'search.socialactions.com/actions.rss'
  base_uri @@JSON_URI
  #default_params :output => 'json'
  format :json

  attr_reader   :query

  GROUP_FUNDRAISER = 1
  CAMPAIGN = 2
  PLEDGED_ACTION = 3
  EVENT = 4
  AFFINITY_GROUP = 5
  VOLUNTEER = 6
  MICROCREDIT_LOAN = 7
  PETITION = 8

  def self.all_action_types
    [
      ["fundraiser", GROUP_FUNDRAISER],
      ["campaign", CAMPAIGN],
      ["pledged action", PLEDGED_ACTION],
      ["event", EVENT],
      ["affinity group", AFFINITY_GROUP],
      ["volunteer", VOLUNTEER],
      ["microcredit", MICROCREDIT_LOAN],
      ["petition", PETITION]
    ]
  end

  def self.all_created_days
    [1,2,7,14,30]
  end

  def self.default_created_days
    30
  end

  def initialize
    @query = {:limit => 20, :page => 1}
  end

  def action_types= types
    @query[:action_types] = types.join(",")
  end

  def created_days= days
    @query[:created] = days
  end

  def page= page
    @query[:page] = page
  end

  def match_style= match_style
    @query[:match] = match_style
  end

  def limit= limit
    @query[:limit] = limit
  end

  def find(keyword)
    @query[:q] = keyword
    results = SocialSearch.get('', :query => @query)
    results.map do |result|
      MethodicHash.new(result)
    end
  end

  def rss_uri
    build_uri @@RSS_URI
  end

  def json_uri
    build_uri @@JSON_URI
  end

  def reusable_query
    reusable = @query.dup
    reusable.delete :limit
    reusable.delete :page
    reusable
  end

  private
  def build_uri base
    HTTParty::Request.new(Net::HTTP::Get, HTTParty.normalize_base_uri(base), SocialSearch.default_options.dup.merge({:query => reusable_query})).uri
  end

end
