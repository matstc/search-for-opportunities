require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SocialSearch do
  before(:each) do
    @search = SocialSearch.new
  end

  it "should query social actions for keyword" do
    @search.find("education")
    @search.last_query[:query][:q].should == 'education'
  end

  it "should only ask for actions of a certain age" do
    @search.created_days = 3
    @search.find("education")
    @search.last_query[:query][:created].should == 3
  end

  it "should only ask for certain action types" do
    @search.action_types = [SocialSearch::CAMPAIGN]
    @search.find("education")
    @search.last_query[:query][:action_types].should == '2'

    @search.action_types = [SocialSearch::CAMPAIGN, SocialSearch::VOLUNTEER]
    @search.find("education")
    @search.last_query[:query][:action_types].should == '2,6'
  end

  it "should return the correct url used to handle the query" do
    @search.action_types = [SocialSearch::VOLUNTEER]

    @search.rss_uri.host.should == "search.socialactions.com"
    @search.rss_uri.path.should == "/actions.rss"
    (@search.rss_uri.query =~ /action_types=#{SocialSearch::VOLUNTEER}/).blank?.should == false
  end

  it "should return the correct url used to handle the query" do
    @search.action_types = [SocialSearch::VOLUNTEER]

    @search.json_uri.host.should == "search.socialactions.com"
    @search.json_uri.path.should == "/actions.json"
    (@search.json_uri.query =~ /action_types=#{SocialSearch::VOLUNTEER}/).blank?.should == false
  end

  it "should not include limit or page number in reusable query" do
    @search.limit = 12
    @search.page = 2
    @search.action_types = [SocialSearch::VOLUNTEER]

    @search.reusable_query.should == {:action_types => SocialSearch::VOLUNTEER.to_s}
  end
end
