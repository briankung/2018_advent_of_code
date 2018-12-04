require "./spec_helper"

describe Day03 do
  it "has Claims" do
    Day03.claims.size.should eq(1229)
  end
end

def day
  Day03::Claim.new("#1 @ 469,741: 22x26")
end

describe Day03::Claim do
  it "takes a claim string" do
    day
  end

  it "has a bunch of attributes" do
    day.claim_number.should eq(1)
    day.coordinates.should eq({x: 469, y: 741})
    day.dimensions.should eq({x: 22, y: 26})
  end
end
