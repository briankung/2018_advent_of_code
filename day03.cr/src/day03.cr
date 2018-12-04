class Day03
  def initialize(input : Array(String))
    @input = input
  end

  def coordinate_plane
    self.claims[0..0].reduce({} of Int32 => Hash(Int32, Array(Day03::Claim))) do |plane, claim|
      x, y = claim.coordinates[:x], claim.coordinates[:y]
      length, height = claim.dimensions[:x], claim.dimensions[:y]

      (0...length).each do |x_offset|
        (0...height).each do |y_offset|
          plane[x + x_offset] ||= {} of Int32 => Array(Day03::Claim)
          plane[x + x_offset][y + y_offset] ||= [] of Day03::Claim

          plane[x + x_offset][y + y_offset] << claim
        end
      end

      plane
    end
  end

  def claims
    @input.map {|input| Claim.new(input)}
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

    def to_s
      "{claim_number: #{@claim_number}, coordinates: {x: #{@coordinates[:x]}, y: #{@coordinates[:y]}}, dimensions: {x: #{@dimensions[:x]}, y: #{@dimensions[:y]}}"
    end

    def ==(other)
      @claim_number == other.claim_number && @coordinates == other.coordinates && @dimensions == other.dimensions
    end
  end
end
