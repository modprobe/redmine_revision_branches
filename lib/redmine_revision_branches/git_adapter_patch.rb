require 'redmine/scm/adapters/xitolite_adapter'

module Redmine
  module Scm
    module Adapters
      class XitoliteAdapter
        def branch_contains(hash)
          cleaned_hash = hash.sub(/[^\w]/, '')
          cmd_args = ['branch', '--contains', cleaned_hash]
          begin
            branches = git_cmd(cmd_args, bypass_cache: true) do |io|
              io.readlines.sort!.map{|t| t.strip.gsub(/\* ?/, '')}
            end
          rescue ScmCommandAborted
            branches = Array.new
          end
          branches.uniq
        end
      end
    end
  end
end
