require 'spec_helper'

describe Debate do

	before { @debate = Debate.new(description: "This is the question that user post ") }

  subject { @debate }

  it { should respond_to(:description) }
  
  it { should be_valid }

  describe "When description is not present" do
  	before {@debate.description = " " }
  	it { should_not be_valid }
  end 

  let(:user) { FactoryGirl.create(:user) }
  before { @debate = user.microposts.build(description: "Lorem ipsum") }

  subject { @debate }

  it { should respond_to(:description) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @debate.user_id = nil }
    it { should_not be_valid }
  end

end
