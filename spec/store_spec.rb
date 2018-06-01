require_relative '../store'
require_relative 'spec_helper'

RSpec.describe 'Testing' do 
  it 'creates counter' do
    aggregate_id = Store.new_uuid
    Store.create_counter(aggregate_id)
    expect(CounterRecord.last.aggregate_id).to eql(aggregate_id)
  end

  it 'increases counter with positive amount' do
    aggregate_id = Store.new_uuid
    Store.create_counter(aggregate_id)
    Store.increase_counter(aggregate_id, 3)
    expect(CounterRecord.find_by(aggregate_id: aggregate_id).amount).to eql(3)
  end

  it 'decreases counter with positive amount' do
    aggregate_id = Sequent.new_uuid
    Store.create_counter(aggregate_id)
    Store.decrease_counter(aggregate_id, 3)
    expect(CounterRecord.find_by(aggregate_id: aggregate_id).amount).to eql(-3)
  end

  it 'raises error if increases with negative amount' do
    aggregate_id = Sequent.new_uuid
    Store.create_counter(aggregate_id)
    expect {
      Store.increase_counter(aggregate_id, -3)
    }.to raise_error('Amount must be positive')
  end

  it 'raises error if decreases with negative amount' do
    aggregate_id = Sequent.new_uuid
    Store.create_counter(aggregate_id)
    expect {
      Store.decrease_counter(aggregate_id, -3)
    }.to raise_error('Amount must be positive')
  end
end
