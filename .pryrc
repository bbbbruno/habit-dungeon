# frozen_string_literal: true

begin
  require 'awesome_print'
rescue LoadError
else
  AwesomePrint.pry!
end
