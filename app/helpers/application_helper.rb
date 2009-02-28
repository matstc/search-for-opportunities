# Methods added to this helper will be available to all templates in the application.
#require 'spec/general_helper'
module ApplicationHelper
  def display_if_present(obj, &block)
    yield if !obj.blank?
  end

  def is_criterion_enabled? id, value=nil, default=nil, hash=params
    value = value.to_s if !value.nil?
    default = default.to_s if !default.nil?

    return true if hash[id] == value and !value.nil?
    return true if hash[id].blank? and value == default and !value.nil?
    false
  end
end
