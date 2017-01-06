require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "semantic"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

def update_version!(file_path)
  old_file = File.read(file_path)
  version_str = old_file[VERSION_PATTERN, 1]
  old_version = Semantic::Version.new(version_str)
  new_version = yield old_version
  modified = old_file.sub(VERSION_PATTERN, new_version.to_s)
  File.open(file_path, 'w') {|f| f.write(modified) }
  warn "#{old_version} => #{new_version}"
end

VERSION_FILE = 'lib/hatena/bookmark/restful/version.rb'
VERSION_PATTERN = /(\d+\.\d+\.\d+)(-([0-9A-Za-z-]+(\.[0-9A-Za-z-]+)*))?(\+([0-9A-Za-z-]+(\.[0-9A-Za-z-]+)*))?/.freeze # Stolen from Semantic::Version::SemVerRegexp
namespace :version do
  namespace :major do
    desc "bump major version"
    task :bump => VERSION_FILE do |t|
      update_version!(t.prerequisites.first) do |new_version|
        new_version.tap do |version|
          version.major += 1
          version.minor = 0
          version.patch = 0
        end
      end
    end
  end

  namespace :minor do
    desc "bump minor version"
    task :bump => VERSION_FILE do |t|
      update_version!(t.prerequisites.first) do |new_version|
        new_version.tap do |version|
          version.minor += 1
          version.patch = 0
        end
      end
    end
  end

  namespace :patch do
    desc "bump patch version"
    task :bump => VERSION_FILE do |t|
      update_version!(t.prerequisites.first) do |new_version|
        new_version.tap do |version|
          version.patch += 1
        end
      end
    end
  end
end
