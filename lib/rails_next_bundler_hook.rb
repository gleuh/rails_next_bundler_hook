require "rails_next_bundler_hook/version"

module RailsNextBundlerHook
  Bundler::Plugin.add_hook('before-install-all') do |dependencies|
    if ENV['RAILS_NEXT']
      module Bundler::SharedHelpers
        def default_lockfile
          gemfile = default_gemfile
    
          case gemfile.basename.to_s
          when "gems.rb" then Pathname.new(gemfile.sub(/.rb$/, ".locked"))
          else Pathname.new("#{gemfile}_rails_next.lock")
          end.untaint
        end
      end
    end
  end
end
