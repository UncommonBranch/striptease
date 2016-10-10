require 'spec_helper'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'striptease_sqlite_database'
)

describe Striptease do
  context '.strip_whitespace' do
    class Record < ActiveRecord::Base
      strip_whitespace :foo, :bar
    end

    around(:each) do |example|
      ActiveRecord::Schema.define do
        create_table :records do |table|
          table.column :foo, :string
          table.column :bar, :string
          table.column :baz, :string
        end
      end

      example.run

      ActiveRecord::Schema.define { drop_table :records }
    end

    it 'strips whitespace from specified attributes' do
      record = Record.create!(foo: ' foo ', bar: ' bar ', baz: ' baz ')

      expect(record.foo).to eq('foo')
      expect(record.bar).to eq('bar')
      expect(record.baz).to eq(' baz ')
    end
  end
end
