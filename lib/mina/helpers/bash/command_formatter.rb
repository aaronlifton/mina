module Mina::Helpers::Bash
  class CommandFormatter
    attr_reader :command

    def initialize(command)
      @command = command
    end

    def format
      if @command[-1] == '&'
        format_background_command(@command)
      else
        @command
      end
    end

    private

    def format_background_command(command)
      "(#{command})"
    end
  end
end