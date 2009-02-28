class SearchController < ApplicationController
  layout nil

  def search
    @keywords = params[:keywords]
    @search = SocialSearch.new
    @search.action_types = extract_action_types
    @search.created_days = extract_created_days
    @search.page = extract_page_number
    @search.match_style = extract_match_style
    @actions = @search.find(@keywords)
  end

  def extract_match_style
    params[:match_style] || "all"
  end

  def extract_page_number
    params[:page] || 1
  end
  
  def extract_action_types
    action_types = []
    params.each {|k,v|
      if k =~ /^action_type_\d+/
        action_types << v.to_i
      end
    }
    action_types
  end

  def extract_created_days
    daystr = params[:created_days]
    return SocialSearch.default_created_days if daystr.blank?
    daystr.to_i
  end
  
end
