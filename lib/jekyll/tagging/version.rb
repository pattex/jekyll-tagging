module Jekyll

  module Tagging

    module Version

      MAJOR = 0
      MINOR = 3
      TINY  = 1

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
