class Team < ActiveRecord::Base
  has_many :projects
  
  def self.locate_by_name(name)
    ScrumBoard::Client.find_team_by_name(name)
  end
end