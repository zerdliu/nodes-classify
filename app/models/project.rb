class Project < ActiveRecord::Base
  validates :name, :uniqueness => true
  has_many :servers
end
