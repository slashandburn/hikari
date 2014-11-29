require 'spec_helper'
require 'action_controller'

RSpec.describe Post, :type => :model do
  before(:example) do
    User.delete_all
    Post.delete_all
  end

  describe 'field sorting' do
    it 'should prefer params sort' do
      p1 = Post.create(:title => "aaaa")
      p2 = Post.create(:title => "bbbb")
      params = ActionController::Parameters.new(sort: "title_asc")

      result = Post.sort(params[:sort], 'title DESC')
      expect(result.first).to eq(p1)
      expect(result.last).to  eq(p2)
    end

    it 'should sort descending' do
      p1 = Post.create(:title => "ccc")
      p2 = Post.create(:title => "ddd")
      params = ActionController::Parameters.new(sort: "title_desc")

      result = Post.sort(params[:sort], 'title ASC')
      expect(result.last).to eq(p1)
      expect(result.first).to  eq(p2)
    end
  end

  describe 'scope sorting' do
    it 'should set default scope asc' do
      a1 = User.create(last_name: 'aaa')
      a2 = User.create(last_name: 'zzz')
      p1 = Post.create(author: a1)
      p2 = Post.create(author: a2)

      result = Post.sort('', 'by_author_last_name ASC')
      expect(result.count).to eq(2)
      expect(result.first.author).to eq(a1)
      expect(result.last.author).to  eq(a2)
    end

    it 'should set default scope desc' do
      a1 = User.create(last_name: 'aaa')
      a2 = User.create(last_name: 'zzz')
      p1 = Post.create(author: a1)
      p2 = Post.create(author: a2)

      result = Post.sort('', 'by_author_last_name DESC')
      expect(result.count).to eq(2)
      expect(result.first.author).to eq(a2)
      expect(result.last.author).to  eq(a1)
    end
  end
end
