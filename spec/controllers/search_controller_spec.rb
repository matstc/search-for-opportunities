require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SearchController do
  it "should list search results" do
    keyword = "kiva"
    action_types = "1,2"
    created_days = "4"
    action = mock_model(SocialSearch)

    SocialSearch.stub!(:new).and_return(action)
    action.should_receive(:find).with(keyword).and_return([MethodicHash.new])
    action.should_receive(:action_types=).with([1,2])
    action.should_receive(:created_days=).with(4)
    action.should_receive(:page=).with(1)
    action.should_receive(:match_style=).with("all")

    get :search, :keywords => keyword, :action_type_1 => 1, :action_type_2 => 2, :created_days => created_days
    controller.instance_variable_get(:@actions).nil?.should == false
  end
end
