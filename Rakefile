require 'bundler/gem_tasks'

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new

  desc 'Runs Rubocop style checker with xml output for Jenkins'
  task 'rubocop:jenkins' do
    system("bundle exec rubocop \
            --require rubocop/formatter/checkstyle_formatter \
            --format Rubocop::Formatter::CheckstyleFormatter \
            --no-color --out rubocop.xml")
  end
rescue => _
  puts 'Rubocop not loaded.'
end

task :default => :rubocop
