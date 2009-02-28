require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ApplicationHelper do
  
  before(:each) do
    self.extend(ApplicationHelper)
  end
  it "should say a criterion is enabled if params contain its value" do
    is_criterion_enabled?(:name, '5', nil, {:name => '1'}).should == false
    is_criterion_enabled?(:name, '5', nil, {:name => '5'}).should == true
  end

  it "should say a criterion is enabled if there is no entry for it but its value is the default" do
    is_criterion_enabled?(:name, nil, nil, {}).should == false
    is_criterion_enabled?(:name, 5, 4, {}).should == false
    is_criterion_enabled?(:name, 5, 5, {}).should == true
  end

  it "should not care if it is a string or a number" do 
    is_criterion_enabled?(:name, 5, nil, {:name => '5'}).should == true
  end

end

