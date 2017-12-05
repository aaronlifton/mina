require 'mina/helpers/bash/command_formatter'
module Mina
  module Helpers
    module Bash
      def format_command(command)
        CommandFormatter.new(command).format
      end
    end
  end
end