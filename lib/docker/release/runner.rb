require 'deploy'
require 'docker/release/repository'

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
        check_for_changelog!
      end

      def perform!
        synchronize_repo!
      end

      def repo
        @repo ||= Repository.new
      end
    end
  end
end
