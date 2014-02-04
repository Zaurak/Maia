class DebatesController < ApplicationController
  before_action :signed_in_user,  only: [:create] 

  def index
  @tags = Tag.tag_list
  @debate = Debate.new
  @debates = Debate.search(params[:search]).paginate(page: params[:page])
  end
  
  def show
  	@debate = Debate.find(params[:id])
  end

  def new
    @tags = Tag.tag_list
  	@debate = Debate.new
  end

  def create
  	@debate = current_user.debates.build(debate_params) # to create a debate user should be registered   
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
