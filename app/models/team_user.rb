class TeamUser < ActiveRecord::Base

  belongs_to :user
  belongs_to :team
  delegate :email, to: :user, allow_nil: true
end
