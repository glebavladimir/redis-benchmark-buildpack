require 'rubygems' if RUBY_VERSION < "1.9"
require 'sinatra'
require 'open3'
require 'json'
require 'pp'
require 'cf-app-utils'
require 'yaml'

enable :lock

$stdout.sync = true

class RedisBenchmarkApp < Sinatra::Base
  get '/' do
    # Get 
    redis_benchmark_opts = YAML.load_file("spec.yml")
    #pp redis_benchmark_opts

    # Get Redis service credentials
    redis = CF::App::Credentials.find_by_service_name('redis')
    #pp redis

    # Concatenate Redis Benchmark command
    cmd = './cmd/redis-benchmark'
    cmd.concat(' -q ') if redis_benchmark_opts['benchmark']['quiet'].to_s.downcase == "true"
    cmd.concat(' -h ')
    cmd.concat(redis['host'])
    cmd.concat(' -p ')
    cmd.concat(redis['port'].to_s)
    cmd.concat(' -a ')
    cmd.concat(redis['password'])
    cmd.concat(' -c ')
    cmd.concat(redis_benchmark_opts['benchmark']['clients'].to_s)
    cmd.concat(' -n ')
    cmd.concat(redis_benchmark_opts['benchmark']['requests'].to_s)
    cmd.concat(' -d ')
    cmd.concat(redis_benchmark_opts['benchmark']['size'].to_s)
    #pp cmd

    system(cmd)
  end
end
