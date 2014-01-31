class DebatesController < ApplicationController

  # Tags should be loaded from xml and accessible easily
  def index
  @tags = ["Computers", "French Laws", "Philosophy", "USA Laws", "Politic", "Religion", "Technology", "Food", "Hardware", "Sport", "Medicine", "Animals"]
  @debate = Debate.new
  end
  
  def show
  	@debate = Debate.find(params[:id])
  end

  def new
    @tags = ["Computers", "French Laws", "Philosophy", "USA Laws", "Politic", "Religion", "Technology", "Food", "Hardware", "Sport", "Medicine", "Animals"]
  	@debate = Debate.new
  end

  def create
    @tags = ["Computers", "French Laws", "Philosophy", "USA Laws", "Politic", "Religion", "Technology", "Food", "Hardware", "Sport", "Medicine", "Animals"]
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
