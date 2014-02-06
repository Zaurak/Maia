class DebatesController < ApplicationController
  before_action :signed_in_user,  only: [:create] 

  def index
  @tags = Tag.tag_list
  @debate = Debate.new
  @debates = Debate.search(params[:search]).paginate(page: params[:page])
  @hot_debates = Debate.all.sort { |a, b| b.voices <=> a.voices }.first(3)
  @recent_debates = Debate.order(created_at: :desc).first(3)
  end
  
  def show
  	@debate = Debate.find(params[:id])
  end

  def new
    @tags = Tag.tag_list
  	@debate = Debate.new
  end

  def create
  	@debate = current_user.debates.build(debate_params.merge(
                                          voices: 0))
  	if @debate.save
      flash[:success] = "New debate saved!"
      redirect_to @debate
  	else
  		flash[:error] = "You must enter a valid debate question."
      redirect_to debates_path
  	end
  end

  def destroy
  end

  private

  def debate_params
      params.require(:debate).permit(:description)
  end
end
