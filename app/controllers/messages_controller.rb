class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :set_team, only: [:index, :new, :show]

  # GET /messages
  # GET /messages.json
  def index
    @alls = @team.messages.where(tag: params[:tag])
    @messages = @team.messages.page(params[:page])
    #@messages = @team.messages.page(params[:page]).per(25).order("id DESC")
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    #@message = Message.new
    @message = @team.messages.build
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    @message.user_id = current_user.id

    respond_to do |format|
      team_id = @message.team_id
      if @message.save
        format.html { redirect_to team_messages_url(team_id: team_id), notice: '投稿が完了しました。' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: '投稿が更新されました。' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    team_id = @message.team_id
    @message.destroy
    respond_to do |format|
      format.html { redirect_to team_messages_url(team_id: team_id), notice: '投稿は削除されました。' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    def set_team
      team_id = params[:team_id] || params[:message][:team_id] rescue nil
      @team = Team.find(team_id) rescue  @team = Team.first
      @team
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:body, :tag, :user_id, :team_id)
    end

=begin
    def index
      #ViewのFormで取得したパラメータをモデルに渡す
      @projects = Project.search(params[:search])
    end
=end

end
