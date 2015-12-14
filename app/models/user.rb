class User < ActiveRecord::Base
  has_and_belongs_to_many :teams
  
  validates :first_name, :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
