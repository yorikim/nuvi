require 'cocoapods-downloader'

module Pod
  module Downloader
    class Base
      override_api do
        def execute_command(executable, command, raise_on_failure = false)
          require 'shellwords'
          command = command.map(&:to_s).map(&:shellescape).join(' ')
          output = `\n#{executable} #{command} 2>&1`
          check_exit_code!(executable, command, output) if raise_on_failure
          output
        end

        def ui_action(_ui_message)
          yield
        end

        def ui_sub_action(_message)
          yield
        end

        def ui_message(_message)
        end
      end
    end
  end
end
