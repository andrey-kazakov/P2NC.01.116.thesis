#!/usr/bin/env ruby
# frozen_string_literal: true

require 'csv'

ENDPOINT = 'http://172.31.46.136:3000/posts/1.json'
REQUESTS_IN_BATCH = 1024
BATCHES = 64
CONCURRENCY = 32

MEASUREMENT = ENV.fetch('MEASUREMENT')
INTERPRETER = ENV.fetch('INTERPRETER')

DIRECTORY = "measurements/#{INTERPRETER}/#{MEASUREMENT}"
TMP_DIRECTORY = "#{DIRECTORY}/tmp"

system('mkdir', '-p', TMP_DIRECTORY, exception: true)

def batch_number_to_file_name(batch)
  "#{TMP_DIRECTORY}/#{'%03d' % batch}.csv"
end

puts "Measuring #{ENDPOINT}..."
end_times = []
start_time = Time.now.utc

BATCHES.times do |batch|
  system(
    'ab',
    '-n', REQUESTS_IN_BATCH.to_s,
    '-c', CONCURRENCY.to_s,
    '-e', batch_number_to_file_name(batch),
    '-k',
    ENDPOINT,
    out: '/dev/null',
    err: '/dev/null',
    exception: true
  )
  end_times << (Time.now.utc - start_time)
  puts "Batch #{batch} measured"
end

headers = %w[batch p50 p75 p90 p99 end_time batch_rps average_rps]
CSV.open("#{DIRECTORY}/result.csv", "w", write_headers: true, headers:) do |output|
  BATCHES.times do |batch|
    percentiles = Hash[*[50, 75, 90, 99].zip([]).flatten]
    CSV.foreach(batch_number_to_file_name(batch)) do |percent, time|
      percentiles[percent.to_i] = time if percentiles.key?(percent.to_i)
    end

    end_time = end_times[batch]
    delta_end_time = end_time - (batch.zero? ? 0 : end_times[batch - 1])

    output << [
      batch,
      percentiles[50],
      percentiles[75],
      percentiles[90],
      percentiles[99],
      end_time,
      REQUESTS_IN_BATCH / delta_end_time,
      (REQUESTS_IN_BATCH * (batch + 1)) / end_time
    ]
  end
end

puts "Consolidated report written to #{DIRECTORY}/result.csv"
