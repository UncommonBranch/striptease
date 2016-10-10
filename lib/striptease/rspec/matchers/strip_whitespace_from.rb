require 'rspec/expectations'

RSpec::Matchers.define :strip_whitespace_from do |attribute|
  match do |record|
    record.public_send "#{attribute}=", ' foo '

    record.valid?

    record.public_send(attribute) == 'foo'
  end
end
