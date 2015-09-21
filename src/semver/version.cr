module Semver
  struct Version
    include Comparable(self)

    getter :major
    getter :minor
    getter :patch
    getter :pre_release
    getter :build_metadata

    PRE_RELEASE_FORMAT = /(?:-(?<pre_release>[a-zA-Z0-9.\-]+))?/
    BUILD_METADATA_FORMAT = /(?:\+(?<build_metadata>[a-zA-Z0-9.\-]+))?/
    VERSION_FORMAT = /(?<major>[0-9]+)(?:\.(?<minor>[0-9]+))?(?:\.(?<patch>[0-9]+))?#{PRE_RELEASE_FORMAT}#{BUILD_METADATA_FORMAT}/

    def initialize(@major : Int32, @minor : Int32, @patch : Int32, @pre_release = nil, @build_metadata = nil)
    end

    def initialize(version : String)
      if (md = VERSION_FORMAT.match(version)); md.is_a?(Regex::MatchData)
        @major = md["major"].to_i
        @minor = (md["minor"]? || "0").to_i
        @patch = (md["patch"]? || "0").to_i
        @pre_release = md["pre_release"]?
        @build_metadata = md["build_metadata"]?
      else
        raise ArgumentError.new("Invalid format")
      end
    end

    def to_s(io : IO)
      io << [@major, @minor, @patch].join(".")

      if @pre_release
        io << "-"
        io << @pre_release
      end

      if @build_metadata
        io << "+"
        io << @build_metadata
      end
    end

    def inspect
      to_s
    end

    def ==(other : self)
      return (
        (major == other.major) &&
        (minor == other.minor) &&
        (patch == other.patch) &&
        (pre_release == other.pre_release) &&
        (build_metadata == other.build_metadata)
      )
    end

    def <=>(other : self)
      return 0 if self == other

      if (n = (major <=> other.major); n != 0)
        return n
      end

      if (n = (minor <=> other.minor); n != 0)
        return n
      end

      if (n = (patch <=> other.patch); n != 0)
        return n
      end

      return compare_pre_release(pre_release, other.pre_release)
    end

    private def compare_pre_release(a, b)
      if a.nil? && b.is_a?(String)
        return 1
      elsif a.is_a?(String) && b.nil?
        return -1
      elsif a.is_a?(String) && b.is_a?(String)
        left = a.split(/-|\./)
        right = b.split(/-|\./)

        [left.size, right.size].max.times do |i|
          a = left[i]? || "0"
          b = right[i]? || "0"

          if a.match(/^[0-9]*$/) && b.match(/^[0-9]*$/)
            an = a.to_i
            bn = b.to_i
            return an <=> bn if an != bn
          end

          [a.size, b.size].min.times do |n|
            c = a[n] <=> b[n]

            return c if c != 0
          end
        end
      end

      return 0
    end
  end

  VERSION = Semver::Version.new(1, 0, 0)
end
