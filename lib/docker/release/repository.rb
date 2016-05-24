require 'deploy/repository'
require 'docker/release/tag_dockerrun'

module Docker
  module Release
    class Repository < ::Deploy::Repository
      private

      def tag_dockerrun!
        TagDockerrun.new(@tag).call
      end

      def version!
        super
        tag_dockerrun!
      end

      def commit!
        puts 'Committing version.txt and Dockerrun.aws.json...'
        unless system('git add public/version.txt Dockerrun.aws.json') && system("git commit -m \"#{commit_message}\" ")
          fail 'Failed to commit.'
        end
      end
    end
  end
end
