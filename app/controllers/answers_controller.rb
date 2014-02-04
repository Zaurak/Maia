class AnswersController < ApplicationController
	before_action :signed_in_user,  only: [:create] 

	def create
		@debate = Debate.find(params[:answer][:debate_id])
  	@answer = current_user.answers.build(
  														answer_params.merge(
  															:debate_id 	=> @debate.id,
  															:voices			=> 1)) # TODO: Change to the user 
  																								 # voices from credibility
  	if @answer.save
  		flash[:success] = "Answer added to the debate"
  	else
  		flash[:error] = "The answer cannot be empty"
  	end
  	redirect_to @debate
  end

  private

	  def answer_params
	      params.require(:answer).permit(:content)
	  end
end
