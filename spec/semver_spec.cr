require "./spec_helper"

describe Semver::Version do
  describe "#initialize" do
    it "should initialize with Int32" do
      version = Semver::Version.new(0, 0, 1, "rc1")
      version.to_s.should eq("0.0.1-rc1")
    end

    it "should initialize with String" do
      version = Semver::Version.new("0.0.1-rc2")
      version.to_s.should eq("0.0.1-rc2")
    end
  end

  describe "#==" do
    it "should equal same version" do
      a = Semver::Version.new("1.0.0-rc2")
      b = Semver::Version.new("1.0.0-rc2")

      a.should eq(b)
    end
  end

  describe "#<=>" do
    it "should follow spec" do
      v1 = Semver::Version.new("1.0.0-alpha")
      v2 = Semver::Version.new("1.0.0-alpha.1")
      v3 = Semver::Version.new("1.0.0-alpha.beta")
      v4 = Semver::Version.new("1.0.0-beta")
      v5 = Semver::Version.new("1.0.0-beta.2")
      v6 = Semver::Version.new("1.0.0-beta.11")
      v7 = Semver::Version.new("1.0.0-rc.1")
      v8 = Semver::Version.new("1.0.0")
      v9 = Semver::Version.new("2.0.0")

      assert v1 < v2
      assert v2 < v3
      assert v3 < v4
      assert v4 < v5
      assert v5 < v6
      assert v6 < v7
      assert v7 < v8
      assert v8 < v9
      assert v8 < v9
    end
  end
end
