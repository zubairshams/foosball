class Team < ActiveRecord::Base
  has_and_belongs_to_many :users

  validates :name, presence: true
  validates :users, length: { minimum: 1, maximum: 2, message: 'must be one or two in a team.' }
end
