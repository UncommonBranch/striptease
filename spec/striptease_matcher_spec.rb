require 'spec_helper'
require File.expand_path('../../lib/striptease/rspec', __FILE__)

class TestRecord
  attr_accessor :foo, :bar

  def valid?
    return if foo.nil?
    self.foo = foo.strip
  end
end

describe TestRecord do
  it { should strip_whitespace_from(:foo) }
  it { should_not strip_whitespace_from(:bar) }
end
