require 'active_record'
require 'sqlite3'

ActiveRecord::Base.establish_connection(
  :adapter => defined?(RUBY_ENGINE) && RUBY_ENGINE == 'jruby' ? 'jdbcsqlite3' : 'sqlite3',
  :database => File.join(File.dirname(__FILE__), 'test.db')
)

class CreateSchema < ActiveRecord::Migration
  def self.up
    create_table :posts, :force => true do |t|
      t.integer    :author_id
      t.string     :title
      t.text       :body
      t.timestamps
    end

    create_table :users, :force => true do |t|
      t.string :first_name
      t.string :last_name
      t.timestamps
    end

    create_table :comments, :force => true do |t|
      t.integer :author_id
      t.integer :post_id
      t.text    :body
    end
  end
end

CreateSchema.suppress_messages do
  CreateSchema.migrate(:up)
end

class Post < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  has_many :comments

  scope :by_author_last_name, -> {
    joins(:author).order("users.last_name")
  }
end

class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
end

class Comment < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  belongs_to :post
end
