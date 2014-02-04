class ObjectionsController < ApplicationController
	before_action :signed_in_user,  only: [:create] 

	def create
		@answer = Answer.find(params[:tag][:answer_id])
  	@objection = current_user.tags.build(
  														answer_params.merge(
  															:answer_id 	=> @answer.id,
  															:voices			=> 1)) # TODO: Change to the user 
  																								 # voices from credibility
  	if @objection.save
  		flash[:success] = "Objection added to the debate"
  	elsif Tag.tag_list.include? params[:tag][:name]
  		flash[:error] = "This Objection has already been proposed"
    else
      flash[:error] = "Objection cannot be blank"
  	end
  	redirect_to @debate
  end

  private

	  def answer_params
	      params.require(:tag).permit(:name)
	  end
end
