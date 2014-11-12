# encoding: utf-8

require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'rom'

require 'rom/adapter/memory'
require 'rom/adapter/sequel'
require 'rom/adapter/mongo'

include ROM

root = Pathname(__FILE__).dirname

Dir[root.join('shared/*.rb').to_s].each { |f| puts f; require f }

require root.join('support/db')

RSpec.configure do |config|
  config.before do
    @constants = Object.constants
  end

  config.after do
    (Object.constants - @constants).each { |name| Object.send(:remove_const, name) }
  end
end
