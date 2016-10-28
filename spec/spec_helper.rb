$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'coveralls'
Coveralls.wear!

require 'nanoc'
require 'nanoc/cli'
require 'nanoc/spec'

require 'nanoc/toolkit'

RSpec.configure do |c|
  c.include(Nanoc::Spec::HelperHelper, helper: true)
end
