class JustificationsController < ApplicationController
	before_action :signed_in_user,  only: [:create] 

	def create
    @debate = Debate.find(params[:justification][:debate_id])
    parent_type = params[:justification][:parent_type]

    if parent_type == "Answer"
      @justification = create_justification_for_answer
    elsif parent_type == "Objection"
      @justification = create_justification_for_objection
    elsif parent_type == "Tag"
      @justification = create_justification_for_tag
    end
		
  	if @justification.save
  		flash[:success] = "Justification added to the debate"
    else
      flash[:error] = "Justification cannot be blank"
  	end
  	redirect_to @debate
  end

  private

    def create_justification_for_answer
    @answer = Answer.find(params[:justification][:parent_id])
    current_user.justifications.build( answer_params.merge(
                                    :answer_id  => @answer.id,
                                    :voices     => 1)) 
                                    # TODO: Change to the user voices from credibility
    end

    def create_justification_for_objection
    @objection = Objection.find(params[:justification][:parent_id])
    current_user.justifications.build( answer_params.merge(
                                        :objection_id  => @objection.id,
                                        :voices     => 1)) 
                                    # TODO: Change to the user voices from credibility
    end

    def create_justification_for_tag
    @tag = Tag.find(params[:justification][:parent_id])
    current_user.justifications.build( answer_params.merge(
                                    :tag_id     => @tag.id,
                                    :voices     => 1)) 
                                    # TODO: Change to the user voices from credibility
    end    

	  def answer_params
	      params.require(:justification).permit(:name, :content)
	  end
end
