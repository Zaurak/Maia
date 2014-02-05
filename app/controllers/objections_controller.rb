class ObjectionsController < ApplicationController
	before_action :signed_in_user,  only: [:create] 

	def create
    @debate = Debate.find(params[:objection][:debate_id])
    parent_type = params[:objection][:parent_type]

    if parent_type == "Answer"
      @objection = create_objection_for_answer
    elsif parent_type == "Justification"
      @objection = create_objection_for_justification
    elsif parent_type == "Tag"
      @objection = create_objection_for_tag
    end
		
  	if @objection.save
  		flash[:success] = "Objection added to the debate"
  	elsif Objection.objection_list.include? params[:objection][:name]
  		flash[:error] = "This Objection has already been proposed"
    else
      flash[:error] = "Objection cannot be blank"
  	end
  	redirect_to @debate
  end

  private

    def create_objection_for_answer
    @answer = Answer.find(params[:objection][:parent_id])
    current_user.objections.build( answer_params.merge(
                                    :answer_id  => @answer.id,
                                    :voices     => 1)) 
                                    # TODO: Change to the user voices from credibility
    end

    def create_objection_for_justification

    end

    def create_objection_for_tag
    @tag = Tag.find(params[:objection][:parent_id])
    current_user.objections.build( answer_params.merge(
                                    :tag_id     => @tag.id,
                                    :voices     => 1)) 
                                    # TODO: Change to the user voices from credibility
    end    

	  def answer_params
	      params.require(:objection).permit(:name)
	  end
end
