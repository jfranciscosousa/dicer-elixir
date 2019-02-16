if Gem.loaded_specs.key?("rubocop")
  require "rubocop/rake_task"

  namespace :lint do
    RuboCop::RakeTask.new(:ruby)
  end

  desc "Run all linters"
  task lint: %i[lint:ruby]
end

task :start do
  ruby "src/main.rb"
end
