class DebatesController < ApplicationController
  def index
  @tags = ["Computers", "French Laws", "Philosophy", "USA Laws", "Politic", "Religion", "Technology", "Food", "Hardware", "Sport", "Medicine", "Animals"]
  @debate = Debate.new
  end
  
  def show
  	@debate = Debate.find(params[:id])
  end

  def new
  	@debate = Debate.new
  end

  def create
  	@debate = current_user.debates.build(debate_params) # to create a debate user should be registered   
  	if @debate.save
      flash[:success] = "New debate saved!"
      redirect_to @debate
  	else
  		flash[:error] = "You must enter a valid debate question."
      redirect_to "/debates/index"
  	end
  end

  def destroy
  end

  private

  def debate_params
      params.require(:debate).permit(:description)
  end
end
