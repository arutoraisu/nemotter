class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create

    @team = Team.new(team_params)
    return redirect_to "/teams/new", notice: 'チーム名を入力してください' if @team.name.blank?
    @team_user = @team.team_users.build
    @team_user.user_id=current_user.id
    @team_user.admin=1

    respond_to do |format|
      if @team.save
        format.html { redirect_to team_messages_url(team_id: @team.id), notice: 'チームを作成しました。' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    name=@team.name
    return redirect_to "/teams/#{params[:team_id]}/edit", notice: 'チーム名を入力してください。' if name.blank?
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to team_team_users_url(team_id: @team.id), notice: 'チームを更新しました。' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    team_id = current_user.teams.first.try(:id) rescue team_id=nil
    return redirect_to "/", notice: 'チームを削除しました。' if team_id.blank?



    respond_to do |format|
      format.html { redirect_to team_messages_url(team_id: team_id), notice: 'チームを削除しました。' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_team
    @team = Team.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def team_params
    params.require(:team).permit(:name, :remark)
  end
end
