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
        log 'The new release has been pushed.'
      end

      def synchronize_repo!
        log 'Preparing the tagged version for release.'
        repo.prepare! @tag
      end

      def repo
        @repo ||= Repository.new
      end
    end
  end
end
