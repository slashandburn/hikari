require 'spec_helper'
require 'action_controller'

RSpec.describe Hikari::ViewHelpers::ActionView do
  it 'should be loaded into ActionView' do
    ActionView::Base.send(:include, Hikari::ViewHelpers::ActionView)
    av = ActionView::Base.new
    expect(av).to respond_to(:link_to_sorted)
  end
end

RSpec.describe Hikari::ViewHelpers::ActionView::HikariViewHelper do
  it 'should default to asc' do
    field  = :title
    view_helper = Hikari::ViewHelpers::ActionView::HikariViewHelper.new field, {}
    expect(view_helper.params).to eq({sort: 'title_asc'})
  end

  it 'should set desc when given' do
    field  = {title: :desc}
    view_helper = Hikari::ViewHelpers::ActionView::HikariViewHelper.new field, {}
    expect(view_helper.params).to eq({sort: 'title_desc'})
  end

  it 'should add swap sort order' do
    field = :title
    params = ActionController::Parameters.new(sort: "title_asc")
    view_helper = Hikari::ViewHelpers::ActionView::HikariViewHelper.new field, params
    expect(view_helper.params).to eq({'sort' => 'title_desc'})
  end

end
