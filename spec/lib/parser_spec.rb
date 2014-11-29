require 'spec_helper'
require 'action_controller'

RSpec.describe Hikari::Parser do
  it 'should split the given sort string' do
    g = Hikari::Parser.new('first_name_asc')
    expect(g.field).to eq('first_name')
    expect(g.order).to eq('ASC')
  end

  it 'should split the default order' do
    g = Hikari::Parser.new(nil, 'last_name ASC')
    expect(g.field).to eq('last_name')
    expect(g.order).to eq('ASC')
  end

  it 'should work without sort' do
    g = Hikari::Parser.new('first_name')
    expect(g.field).to eq('first_name')
    expect(g.order).to eq('ASC')
  end

  it 'should take a hash' do
    g = Hikari::Parser.new({last_name: :desc})
    expect(g.field).to eq('last_name')
    expect(g.order).to eq('DESC')
  end
end
