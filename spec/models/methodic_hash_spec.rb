require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MethodicHash do
  SITEURL = 'siteurl'
  FAKEDATE = '2009/02/16 11:01:42 -0500'

  it "should create a reader method for a key in a hash" do
    action = MethodicHash.new({:created_at => FAKEDATE})
    action.created_at.should == FAKEDATE
    action.unexisting_field58920485.should == nil
  end

  it "should return a social action wrapping the value if the value is a hash" do
    action = MethodicHash.new({:site => {:name => SITEURL}})
    action.site.class.should == MethodicHash
    action.site.name.should == SITEURL
  end

  it "should find values in hash even if key is a string" do
    action = MethodicHash.new({"created_at" => FAKEDATE})
    action.created_at.should == FAKEDATE
  end

  it "should parse date from result string if any" do
    action = MethodicHash.new({"created_at" => Date.today.strftime(MethodicHash::DATE_FORMAT)})
    action.friendly_creation_date.should == "today"

    action = MethodicHash.new({"created_at" => (Date.today - 1).strftime(MethodicHash::DATE_FORMAT)})
    action.friendly_creation_date.should == "yesterday"

    action = MethodicHash.new({"created_at" => (Date.today - 2).strftime(MethodicHash::DATE_FORMAT)})
    action.friendly_creation_date.should == "2 days ago"
  end

  it "should parse date as empty string if format is wrong" do
    action = MethodicHash.new({"created_at" => 'blah blah'})
    action.friendly_creation_date.should == nil
  end
end
