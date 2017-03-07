module Jekyll

  module Tagging

    module Version

      MAJOR = 1
      MINOR = 1
      TINY  = 0

      class << self

        # Returns array representation.
        def to_a
          [MAJOR, MINOR, TINY]
        end

        # Short-cut for version string.
        def to_s
          to_a.join('.')
        end

      end

    end

    VERSION = Version.to_s

  end

end
