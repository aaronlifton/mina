require 'mina/helpers/bash/command_formatter'
module Mina
  module Helpers
    module Bash
      def format_commands(queue)
        raise ArgumentError.new("command queue must be an array") unless queue.is_a?(Array)
        queue[stage]
          .map { |cmd| CommandFormatter.new(cmd) }
          .join(' && ')
      end
    end
  end
end