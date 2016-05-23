require 'deploy'
require 'docker/repository'

module Docker
  module Release
    class Runner < ::Deploy::Runner
      def run
        trap_int
        precheck!
        perform!
      end

      private

      def precheck!
        check_for_unstaged_changes!
      end

      def perform!
        synchronize_repo!
      end

      def repo
        @repo ||= Docker::Repository.new
      end
    end
  end
end
