require 'deploy/repository'
require 'docker/dockerrun/tag'
require 'docker/dockerrun'

module Docker
  class Repository < ::Deploy::Repository
    private

    def tag_dockerrun!
      Dockerrun::Tag.new(@tag).call
    end

    def version!
      super
      tag_dockerrun!
    end

    def commit!
      puts "Committing version.txt and #{Dockerrun::FILE_NAME}..."
      unless system("git add public/version.txt #{Dockerrun::FILE_NAME}") && system("git commit -m \"#{commit_message}\" ")
        fail 'Failed to commit.'
      end
    end

    def commit_message
      @commit_message ||= "#{last_commit_message} - release"
    end
  end
end
