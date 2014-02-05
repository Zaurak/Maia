class Vote < ActiveRecord::Base
	belongs_to 	:user
	belongs_to 	:debate
	belongs_to	:answer
	belongs_to	:tag
	belongs_to 	:objection
	belongs_to	:justification
	validates 	:user_id, 		presence: true
	validates 	:clarity, 		presence: true
	validates		:usefulness,	presence: true
	validates		:completness,	presence: true

	def self.votes_for(contribution)
		contribution_type = contribution.class.name.split('::').last

	 	if contribution_type == "Answer" 
			votes = Vote.where(answer_id: contribution.id).all
		elsif contribution_type == "Justification" 
			votes = Vote.where(justification_id: contribution.id).all
		elsif contribution_type == "Objection" 
			votes = Vote.where(objection_id: contribution.id).all
	 	elsif contribution_type == "Tag" 
			votes = Vote.where(tag_id: contribution.id).all
	 	end 

	 	voices = {}
	 	voices[:clarityp] 		= 0
	 	voices[:claritym] 		= 0
	 	voices[:usefulnessp] 	= 0
	 	voices[:usefulnessm] 	= 0
	 	voices[:completnessp] = 0
	 	voices[:completnessm] = 0

	 	votes.each do |vote| 
	 		if vote.clarity == 1
	 			voices[:clarityp] += 1
	 		elsif vote.clarity == -1
	 			voices[:claritym]	+= 1
	 		end

	 		if vote.usefulness == 1
	 			voices[:usefulnessp] 	+= 1
	 		elsif vote.usefulness == -1
	 			voices[:usefulnessm]	+= 1
	 		end

	 		if vote.completness == 1
	 			voices[:completnessp] += 1
	 		elsif vote.completness == -1
	 			voices[:completnessm]	+= 1
	 		end
	 	end

	 	return voices
	end
end
