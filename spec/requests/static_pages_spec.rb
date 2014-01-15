require 'spec_helper'

describe "Static Pages" do
  	subject { page }
	
	describe "Home page" do
		before { visit root_path }

		it { should have_content('Maia') }
	end

end
