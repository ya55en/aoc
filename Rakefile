#: Rakefile for the AoC tasks project

require 'rake/testtask'

Rake::TestTask.new('test-2020') do |t|
  t.test_files = FileList.new(
    'tests/2020_tests/**/test*.rb'
  )
  t.verbose = true
end

Rake::TestTask.new('test-2020-day1') do |t|
  t.test_files = FileList.new(
    'tests/2020_tests/day1-tests/test*.rb'
  )
  t.verbose = true
end

Rake::TestTask.new('test-2020-day2') do |t|
  t.test_files = FileList.new(
    'tests/2020_tests/day2-tests/test*.rb'
  )
  t.verbose = true
end

Rake::TestTask.new('test-2020-day3') do |t|
  t.test_files = FileList.new(
    'tests/2020_tests/day3-tests/test*.rb'
  )
  t.verbose = true
end
