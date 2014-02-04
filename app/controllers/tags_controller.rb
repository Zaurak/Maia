class TagsController < ApplicationController
	before_action :signed_in_user,  only: [:create] 

	def create
		@debate = Debate.find(params[:tag][:debate_id])
  	@tag = current_user.tags.build(
  														answer_params.merge(
  															:debate_id 	=> @debate.id,
  															:voices			=> 1)) # TODO: Change to the user 
  																								 # voices from credibility
  	if @tag.save
  		flash[:success] = "Tag added to the debate"
  	elsif Tag.tag_list.include? params[:tag][:name]
  		flash[:error] = "This tag has already been proposed"
    else
      flash[:error] = "Tag cannot be blank"
  	end
  	redirect_to @debate
  end

  private

	  def answer_params
	      params.require(:tag).permit(:name)
	  end
end
