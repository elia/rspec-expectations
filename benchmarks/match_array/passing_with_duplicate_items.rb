$LOAD_PATH.unshift "./lib"
require 'benchmark'
require 'rspec/expectations'

extend RSpec::Matchers

sizes = [10, 100, 1000, 2000]

puts "rspec-expectations #{RSpec::Expectations::Version::STRING} -- #{RUBY_ENGINE}/#{RUBY_VERSION}"

puts
puts "Passing `match_array` expectation with lists of integers including duplicate values"
puts

Benchmark.benchmark do |bm|
  sizes.each do |size|
    actual    = Array.new(size) { rand(size / 2) }
    expecteds = Array.new(3)    { actual.shuffle }
    expecteds.each do |expected|
      bm.report("#{size.to_s.rjust(5)} items") do
        expect(actual).to match_array(expected)
      end
    end
  end
end

__END__

Before new composable matchers algo:

   10 items  0.000000   0.000000   0.000000 (  0.000665)
   10 items  0.000000   0.000000   0.000000 (  0.000027)
   10 items  0.000000   0.000000   0.000000 (  0.000015)
  100 items  0.000000   0.000000   0.000000 (  0.000250)
  100 items  0.000000   0.000000   0.000000 (  0.000176)
  100 items  0.000000   0.000000   0.000000 (  0.000181)
 1000 items  0.010000   0.000000   0.010000 (  0.013612)
 1000 items  0.020000   0.000000   0.020000 (  0.013409)
 1000 items  0.020000   0.000000   0.020000 (  0.018222)
 2000 items  0.060000   0.000000   0.060000 (  0.057428)
 2000 items  0.060000   0.000000   0.060000 (  0.058242)
 2000 items  0.060000   0.000000   0.060000 (  0.063026)

After:

   10 items  0.000000   0.000000   0.000000 (  0.001835)
   10 items  0.000000   0.000000   0.000000 (  0.000327)
   10 items  0.000000   0.000000   0.000000 (  0.000336)
  100 items  0.030000   0.000000   0.030000 (  0.025134)
  100 items  0.030000   0.000000   0.030000 (  0.032476)
  100 items  0.020000   0.000000   0.020000 (  0.024273)
 1000 items  2.600000   0.040000   2.640000 (  2.649328)
 1000 items  2.510000   0.020000   2.530000 (  2.523448)
 1000 items  2.470000   0.000000   2.470000 (  2.476770)
 2000 items 11.590000   0.110000  11.700000 ( 11.719525)
 2000 items 10.750000   0.080000  10.830000 ( 10.845655)
 2000 items 11.140000   0.080000  11.220000 ( 11.241852)

