class DebatesController < ApplicationController
  def index
	@tags = ["Computers", "French Laws", "Philosophy", "USA Laws", "Politic", "Religion", "Technology", "Food", "Hardware", "Sport", "Medicine", "Animals"]
  end
end
