
desc 'Run tests'
task :test do
  result = system("ruby -Ilib -Itest -e 'ARGV.each { |f| load f }' test/commute/*")
  exit(result ? 0 : 1)
end
