module Day03
  VERSION = "0.1.0"

  def self.claims
    File.read_lines("data/input").map {|input| Claim.new(input)}
  end

  class Claim
    getter :claim_number, :coordinates, :dimensions

    @claim_number : Int32
    @coordinates : NamedTuple(x: Int32, y: Int32)
    @dimensions : NamedTuple(x: Int32, y: Int32)

    def initialize(input)
      matches = input.scan(/\d+/)
                      .not_nil!
                      .map {|m| m[0].to_i}
      @claim_number = matches[0]
      @coordinates = {x: matches[1], y: matches[2] }
      @dimensions = {x: matches[3], y: matches[4] }
    end
  end
end
