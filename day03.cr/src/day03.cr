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
          x_coord, y_coord = x + x_offset, y + y_offset

          if !plane[x_coord]?
            plane[x_coord] = {} of Int32 => Array(Day03::Claim)
            plane[x_coord][y_coord] = [] of Day03::Claim
          end

          if !plane[x_coord][y_coord]?
            plane[x_coord][y_coord] = [] of Day03::Claim
          end

          plane[x_coord][y_coord] << claim

          if plane[x_coord][y_coord].size > 1
            plane[x_coord][y_coord].each {|claim| claim.overlapping = true}
          end
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
    property :overlapping

    @claim_number : Int32
    @coordinates : NamedTuple(x: Int32, y: Int32)
    @dimensions : NamedTuple(x: Int32, y: Int32)
    @overlapping : Bool

    def initialize(input)
      matches = input.scan(/\d+/)
                      .not_nil!
                      .map {|m| m[0].to_i}
      @claim_number = matches[0]
      @coordinates = {x: matches[1], y: matches[2] }
      @dimensions = {x: matches[3], y: matches[4] }
      @overlapping = false
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

claims = day.coordinate_plane.flat_map do |x_coord, x_hash|
  x_hash.flat_map do |y_coord, claims|
    claims
  end
end.uniq

claim = claims.find { |claim| claim.overlapping == false }

puts "Answer to part 2 is: #{claim.not_nil!.claim_number}"
