require "./spec_helper"

def day
  day = Day03.new(File.read_lines("data/input"))
end

describe Day03 do
  it "has Claims" do
    day.claims.size.should eq(1229)
  end

  it "has a coordinate_plane" do
    day.coordinate_plane.should be_a(Hash(Int32, Hash(Int32, Array(Day03::Claim))))
  end
end

def claim
  Day03::Claim.new("#1 @ 469,741: 22x26")
end

describe Day03::Claim do
  it "takes a claim string" do
    claim
  end

  it "has a bunch of attributes" do
    claim.claim_number.should eq(1)
    claim.coordinates.should eq({x: 469, y: 741})
    claim.dimensions.should eq({x: 22, y: 26})
  end
end
