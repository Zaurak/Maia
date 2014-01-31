require 'spec_helper'

describe "DebatePages" do
 
 # =begin
 #  describe "GET /debate_pages" do
 #    it "works! (now write some real specs)" do
 #      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
 #      get debate_pages_index_path
 #      response.status.should be(200)
 #    end
 #  end
 # =end

  subject { page }

  	describe "debate page" do
  	
		  let(:debate) {FactoryGirl.create(:debate) }
	  before { visit debate_path(debate) }

	  it { should have_content(debate.description) }
	  #it { should have_title(debate.description) }
	end

  describe "new debate page" do

    before { visit newDebate_path }

    it { should have_content('New Debate') }
    it { should have_title(full_title('New Debate')) }
  
	let(:submit) { "New Debate" }

	describe "with invalid information" do
      it "should not create a debate" do
        expect { click_button submit }.not_to change(Debate, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Description",         with: "Should the government to approve the adoption in gay families?"
      end
      it "should create a debate" do
        expect { click_button submit }.to change(Debate, :count).by(1)
      end
    end

  end
end
