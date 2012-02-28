require_relative '../lib/dish'

require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'
require 'turn'
 
Turn.config do |c|
 # :outline  - turn's original case/test outline mode [default]
 c.format  = :outline
 # turn on invoke/execute tracing, enable full backtrace
 c.trace   = true
 # use humanized test names (works only with :outline format)
 c.natural = true
end
 
#VCR config
VCR.config do |c|
  c.cassette_library_dir = 'spec/fixtures/dish_cassettes'
  c.stub_with :webmock
end