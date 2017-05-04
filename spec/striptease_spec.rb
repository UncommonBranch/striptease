require 'spec_helper'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'striptease_sqlite_database'
)

describe Striptease do
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

  context '.strip_whitespace' do
    before { class Record < ActiveRecord::Base; end  }

    it 'delegates to .strip_whitespace_from' do
      expect(Record.strip_whitespace).to eq(Record.strip_whitespace_from)
    end
  end

  context '.strip_whitespace_from' do
    context 'when there are no format validations on the attributes' do
      before do
        class Record < ActiveRecord::Base
          strip_whitespace_from :foo, :bar
        end
      end

      it 'strips whitespace from specified attributes' do
        record = Record.create!(foo: ' foo ', bar: ' bar ', baz: ' baz ')

        expect(record.foo).to eq('foo')
        expect(record.bar).to eq('bar')
        expect(record.baz).to eq(' baz ')
      end
    end

    context 'when there are format validations on the attributes' do
      before do
        class Record < ActiveRecord::Base
          strip_whitespace_from :foo, :bar
          validates :foo, format: /[a-z]/
          validates :bar, inclusion: %w(this that)
        end
      end

      it 'strips whitespace from specified attributes' do
        record = Record.create!(foo: ' abc ', bar: ' this ', baz: ' baz ')

        expect(record.foo).to eq('abc')
        expect(record.bar).to eq('this')
        expect(record.baz).to eq(' baz ')
      end
    end
  end
end
