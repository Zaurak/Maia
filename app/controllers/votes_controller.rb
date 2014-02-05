class VotesController < ApplicationController
	before_action :signed_in_user,  only: [:create] 
  before_action :check_params,    only: [:create]

	def create
    @parent_id  = params[:vote][:parent_id]
    parent_type = params[:vote][:parent_type]

    if parent_type == "Debate"
      @vote = create_vote_for_debate
    elsif parent_type == "Answer"
      @vote = create_vote_for_answer
    elsif parent_type == "Objection"
      @vote = create_vote_for_objection
    elsif parent_type == "Justification"
      @vote = create_vote_for_justification
    elsif parent_type == "Tag"
      @vote = create_vote_for_tag
    end

  	redirect_to @debate
  end

  private

    def create_vote_for_debate
      if Vote.find_by(user_id: current_user.id, debate_id: @debate.id)
        flash[:error] = "You already voted for this contribution"
      else
        vote = current_user.votes.build( vote_params.merge(
                                          :debate_id => @debate.id)) 
        if vote.save
          @debate.update_attribute(:voices, @debate.voices + total_vote_voices)
          flash[:success] = "Vote added to the debate"
        else
          flash[:error] = "An error occured while saving the vote."
        end
      end
    end

    def create_vote_for_answer
      answer = Answer.find(@parent_id)
      if !Vote.find_by(user_id: current_user.id, answer_id: answer.id).nil?
        flash[:error] = "You already voted for this contribution"
      else
        vote = current_user.votes.build( vote_params.merge(
                                          :answer_id => answer.id)) 
        if vote.save
          answer.update_attribute(:voices, answer.voices + total_vote_voices)
          flash[:success] = "Vote added to the debate"
        else
          flash[:error] = "An error occured while saving the vote."
        end 
      end
    end

    def create_vote_for_objection
      objection = Objection.find(@parent_id)
      if !Vote.find_by(user_id: current_user.id, objection_id: objection.id).nil?
        flash[:error] = "You already voted for this contribution"
      else
        vote = current_user.votes.build( vote_params.merge(
                                          :objection_id => objection.id)) 
        if vote.save
          objection.update_attribute(:voices, objection.voices + total_vote_voices)
          flash[:success] = "Vote added to the debate"
        else
          flash[:error] = "An error occured while saving the vote."
        end 
      end
    end

    def create_vote_for_justification
      justification = Justification.find(@parent_id)
      if !Vote.find_by(user_id: current_user.id, justification_id: justification.id).nil?
        flash[:error] = "You already voted for this contribution"
      else
        vote = current_user.votes.build( vote_params.merge(
                                          :justification_id => justification.id)) 
        if vote.save
          justification.update_attribute(:voices, justification.voices + total_vote_voices)
          flash[:success] = "Vote added to the debate"
        else
          flash[:error] = "An error occured while saving the vote."
        end 
      end
    end

    def create_vote_for_tag
      tag = Tag.find(@parent_id)
      if !Vote.find_by(user_id: current_user.id, tag_id: tag.id).nil?
        flash[:error] = "You already voted for this contribution"
      else
        vote = current_user.votes.build( vote_params.merge(
                                          :tag_id => tag.id)) 
        if vote.save
          tag.update_attribute(:voices, tag.voices + total_vote_voices)
          flash[:success] = "Vote added to the debate"
        else
          flash[:error] = "An error occured while saving the vote."
        end
      end
    end

    def total_vote_voices
      params[:vote][:clarity].to_i + params[:vote][:usefulness].to_i + params[:vote][:completness].to_i
    end

	  def vote_params
	      params.require(:vote).permit(:clarity, :usefulness, :completness)
	  end

    def check_params
      @debate = Debate.find(params[:vote][:debate_id])
      if params[:vote][:clarity] == "0" && params[:vote][:usefulness] == "0" && params[:vote][:completness] == "0"
        flash[:notice] = "Your vote would have no impact, it has not been added"
        redirect_to @debate
      end
    end
end
