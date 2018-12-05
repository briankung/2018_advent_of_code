class Day03
  @coordinate_plane : Hash(Int32, Hash(Int32, Array(Day03::Claim))) | Nil

  def initialize(input : Array(String))
    @input = input
    @coordinate_plane = coordinate_plane
  end

  def coordinate_plane
    self.claims.reduce({} of Int32 => Hash(Int32, Array(Day03::Claim))) do |plane, claim|
      x, y = claim.coordinates[:x], claim.coordinates[:y]
      length, height = claim.dimensions[:x], claim.dimensions[:y]

      (0...length).each do |x_offset|
        (0...height).each do |y_offset|
          if !plane[x + x_offset]?
            plane[x + x_offset] = {} of Int32 => Array(Day03::Claim)
            plane[x + x_offset][y + y_offset] = [] of Day03::Claim
          end

          if !plane[x + x_offset][y + y_offset]?
            plane[x + x_offset][y + y_offset] = [] of Day03::Claim
          end

          plane[x + x_offset][y + y_offset] << claim
        end
      end

      plane
    end
  end

  # Do I want to do this? Yes. Should I do this? No. Not unless I want to wait
  # forever

  # def print
  #   print_string = ""
  #
  #   (0...self.max_x).each do |x|
  #     if self.coordinate_plane[x]?
  #       (0...self.max_y).each do |y|
  #         if self.coordinate_plane[x][y]?
  #           print_string += self.coordinate_plane[x][y].size.to_s
  #         else
  #           print_string += "0"
  #         end
  #       end
  #     else
  #       print_string += "0" * self.max_y
  #     end
  #
  #     print_string += "\n"
  #   end
  #
  #   puts print_string
  # end

  def claims
    @input.map { |input| Claim.new(input) }
  end

  def max_x
    self.claims.map {|c| c.coordinates[:x] + c.dimensions[:x] - 1 }.max
  end

  def max_y
    self.claims.map {|c| c.coordinates[:y] + c.dimensions[:y] - 1 }.max
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

day = Day03.new(File.read_lines("data/input"))

count = 0

day.coordinate_plane.each do |x_coord, x_hash|
  x_hash.each do |y_coord, claims|
    count += 1 if claims.size >= 2
  end
end

puts "Answer to part 1 is: #{count}"
