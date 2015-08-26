class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!, :set_team
  #  before_action :set_team, only: [:index,:edit, :new, :show]
  
    def set_team
      @team = current_user.teams.first rescue nil
      #team_id = params[:team_id] || params[:message][:team_id] rescue team_id = 1
      #@team = Team.find(team_id) rescue  @team = Team.first
    end
end
