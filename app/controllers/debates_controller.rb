class DebatesController < ApplicationController
  def index
  @tags = ["Computers", "French Laws", "Philosophy", "USA Laws", "Politic", "Religion", "Technology", "Food", "Hardware", "Sport", "Medicine", "Animals"]
  @debate = Debate.new
  #@debates = Debate.all
  @debates = Debate.search(params[:search])
  end
  
  def show
  	@debate = Debate.find(params[:id])
  end

  def new
  	@debate = Debate.new
  end

  def create
  	@debate = Debate.new(debate_params)
  	if @debate.save
  		redirect_to @debate
      flash[:success] = "New debate saved!"
  	else
  		flash[:error] = "You must enter a valid debate question."
  		render 'new'
  	end
  end

  def debate_params
      params.require(:debate).permit(:description)
  end
end
