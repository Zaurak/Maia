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
end
