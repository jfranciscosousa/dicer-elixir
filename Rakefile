require "rubocop/rake_task"

namespace :lint do
  require "rubocop/rake_task"
  RuboCop::RakeTask.new(:ruby)
end

desc "Run all linters"
task lint: %i[lint:ruby]

task :start do
  ruby "src/main.rb"
end
