module Mina
  module Helpers
    module Format
      def format_code(code, options = {})
        default_options = {
          strip: true,
          quiet: false,
          indent: nil
        }
        options = default_options.merge(options)

        code = if !options.empty?
          if options[:strip]
            code = unindent(code)
            code = wrap(code)
          end
          if options[:indent]
            code = wrap(code)
            code = indent(options[:indent], code)
          end
          code
        else
          format_code(code)
        end
        (options[:quiet] ? code : echo_cmd(code))
      end

      def indent(count, str)
        str.gsub(/^/, ' ' * count)
      end

      def unindent(code)
        if code =~ /^\n([ \t]+)/
          code = code.gsub(/^#{$1}/, '')
        end

        code.strip
      end

      def echo_cmd(code, ignore_verbose = false)
        if fetch(:verbose) && !ignore_verbose
          "echo #{Shellwords.escape('$ ' + code)} &&\n#{code}"
        else
          code
        end
      end

      def wrap(command)
        if command[-1] == '&'
          wrap_background_command(command)
        else
          command
        end
      end

      private

      def wrap_background_command(command)
        "(#{command})"
      end
    end
  end
end
