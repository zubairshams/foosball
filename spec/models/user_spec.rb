require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_and_belong_to_many(:teams) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
end
