module Mina::Helpers::Bash
  class CommandFormatter
    def initialize(command)
      if command.last == '&'
        format_background_command(command)
      else
        command
      end
    end

    private

    def format_background_command(command)
      "(#{cmd})"
    end
  end
end