class TagsController < ApplicationController
	def autocomplete_user_name
		tags = User.select([:name]).where("name LIKE ?", "%#{params[:name]}%")
    result = tags.collect do |t|
      { value: t.name }
    end
    render json: result
	end
end