# a little monkey patching to use a different json parser. the default one does not handle unicode characters correctly.
# see http://www.digitalhobbit.com/archives/2008/08/27/rails-and-json-containing-unicode-characters/
#
require 'json'
require 'httparty'
module HTTParty
  module Parsers
    module JSON
      def self.decode(json)
        ::JSON.parse(json)
      end
    end
  end
end
