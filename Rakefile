#: Rakefile for the AoC tasks project

require 'rake/testtask'

Rake::TestTask.new('test') do |t|
  t.test_files = FileList.new(
    'tests/**/test*.rb'
  )
  t.verbose = true
end

Rake::TestTask.new('test-day1') do |t|
  t.test_files = FileList.new(
    'tests/day1-tests/test*.rb'
  )
  t.verbose = true
end

Rake::TestTask.new('test-day2') do |t|
  t.test_files = FileList.new(
    'tests/day2-tests/test*.rb'
  )
  t.verbose = true
end
