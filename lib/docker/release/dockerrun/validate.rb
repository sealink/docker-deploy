require 'docker/release/tag_dockerrun'

module Docker
  module Release
    module Dockerrun
      class Validate
        include Singleton

        def call
          existence
          parsability
        end

        private

        FILE_NAME = TagDockerrun::FILE_NAME

        def existence
          abort "./#{FILE_NAME} not found!" unless File.exist? FILE_NAME
        end

        def parsability
          JSON.parse File.read(FILE_NAME)
        rescue JSON::ParserError => error
          abort "{#{FILE_NAME} is not parsable: #{error.message}"
        end
      end
    end
  end
end
