class TeamUsersController < ApplicationController
  before_action :set_team_user, only: [:show, :edit, :update, :destroy]
  before_action :set_team, only: [:index,:edit, :new, :show]
  # GET /team_users
  # GET /team_users.json
  def index
    @team_users = TeamUser.all
  end

  # GET /team_users/1
  # GET /team_users/1.json
  def show
  end

  # GET /team_users/new
  def new
    @team_user = TeamUser.new
  end

  # GET /team_users/1/edit
  def edit
  end

  # POST /team_users
  # POST /team_users.json
  def create
    @team_user = TeamUser.new(team_user_params)
    @team_user.user_id=User.where("email = ?",params[:team_user][:email]).first.id
    @team_user.team_id=team_id = params[:team_id] || params[:team_users][:team_id] rescue team_id = 1

    respond_to do |format|
      if @team_user.save
        format.html { redirect_to team_team_users_url(team_id: team_id), notice: 'ユーザーを追加しました。' }
        format.json { render :show, status: :created, location: @team_user }
      else
        format.html { render :new }
        format.json { render json: @team_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /team_users/1
  # PATCH/PUT /team_users/1.json
  def update
    team_id = @team_user.team_id

    respond_to do |format|
      if @team_user.update(team_user_params)
        format.html { redirect_to team_team_users_url(team_id: team_id), notice: 'ユーザー情報を更新しました' }
        format.json { render :show, status: :ok, location: @team_user }
      else
        format.html { render :edit }
        format.json { render json: @team_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /team_users/1
  # DELETE /team_users/1.json
  def destroy
    team_id = @team_user.team_id
    @team_user.destroy
    respond_to do |format|
      format.html { redirect_to team_team_users_url(team_id: team_id), notice: 'ユーザーを削除しました。' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team_user
      @team_user = TeamUser.find(params[:id])
    end

    def set_team
      team_id = params[:team_id] || params[:team_users][:team_id] rescue team_id = 1
      @team = Team.find(team_id)
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def team_user_params
      params.require(:team_user).permit(:team_id, :user_id, :admin)
    end
end
