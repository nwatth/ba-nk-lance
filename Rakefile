require 'rubygems'
require 'bundler/setup'
require 'erb'
require 'yaml'
require 'phantomjs'
require 'capybara/poltergeist'


require './lib/bank'
require './lib/kbank'
require './lib/line_notify'

# Services
require './services/balance_checker'

# Resque Tasks
require 'resque/tasks'
require 'resque/scheduler/tasks'

$redis = Redis.new(url: ENV["REDIS_URL_0"])

task :console do
  require 'irb'
  require 'irb/completion'
  ARGV.clear
  IRB.start
end

namespace :resque do
  task :setup do
    require 'resque'

    p '===== REDIS URL ====='
    p ENV["REDIS_URL_1"]

    # you probably already have this somewhere
    Resque.redis = Redis.new(url: ENV["REDIS_URL_1"])
  end

  task :setup_schedule => :setup do
    require 'resque-scheduler'

    # If you want to be able to dynamically change the schedule,
    # uncomment this line.  A dynamic schedule can be updated via the
    # Resque::Scheduler.set_schedule (and remove_schedule) methods.
    # When dynamic is set to true, the scheduler process looks for
    # schedule changes and applies them on the fly.
    # Note: This feature is only available in >=2.0.0.
    # Resque::Scheduler.dynamic = true

    # The schedule doesn't need to be stored in a YAML, it just needs to
    # be a hash.  YAML is usually the easiest.
    template = ERB.new(File.new('./schedule.yml.erb').read)
    Resque.schedule = YAML.load(template.result)

    # If your schedule already has +queue+ set for each job, you don't
    # need to require your jobs.  This can be an advantage since it's
    # less code that resque-scheduler needs to know about. But in a small
    # project, it's usually easier to just include you job classes here.
    # So, something like this:
  end

  task :scheduler => :setup_schedule
end

