require 'rspec'
require "./lib/codebreaker"
describe Codebreaker do

  before :all do
    @c = Codebreaker.new
  end

  context "#generate_code" do
    it "is an array" do
      expect(@c.code).to be_an Array
    end


    it "makes a code of length == argument" do
      expect(@c.generate_code(4).size).to eq 4
    end

    it "is made of colors" do
      @c.code.each do |part|
        expect(Codebreaker::COLORS).to include part
      end
    end
  end

  context "#win?" do
    it "returns true for matching code" do
      guess = @c.code
      expect(@c.win? guess).to be true
    end
  end

  context "#process_guess" do
  	it "returns an array" do
  		guess = @c.generate_code(@c.codelength)
  		expect(@c.process_guess guess).to be_an Array
  	end

  	it "returns the symbols, :hit, :semi_hit, and :miss" do
  		guess = @c.generate_code(@c.codelength)
  		report = @c.process_guess guess
  		report.each do |part|
  			expect([:hit, :semi_hit, :miss]).to include part 
  		end
  	end
  end
  

  context "@store_round" do
  	it "rounds_of_guessing is an array" do
  		expect(@c.rounds_of_guessing).to be_an Array
  	end

  	it "stores a RoundOfGuessing object in rounds_of_guessing" do
  		guess = @c.generate_code(@c.codelength)
  		@c.store_round guess
  		expect(@c.rounds_of_guessing[0]).to be_a RoundOfGuessing
  	end
  end

  it "RoundOfGuessing objects have a guess" do
  	guess = @c.generate_code(@c.codelength)
  	@c.store_round guess
  	puts "rounds_of_guessing.guess: #{@c.rounds_of_guessing[0].guess}"
  	expect(@c.rounds_of_guessing[0].guess).to_not be nil
  end

  it "RoundOfGuessing objects have a report" do
  	puts "rounds_of_guessing.report: #{@c.rounds_of_guessing[0].report}"
  	expect(@c.rounds_of_guessing[0].report).to_not be nil
  end
end