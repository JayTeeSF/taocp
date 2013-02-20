#!/usr/bin/env ruby

module Gcd
  class Problem

    def self.help
      puts <<-EOM
      irb -r ./gcd.rb
      > Gcd::Problem.example
      EOM
    end

    def self.example
      quotient = 2166
      dividend = 6099
      puts "Given m = #{quotient} and n = #{dividend}: g = Gcd::Problem.new(#{quotient}, #{dividend})"
      g = Gcd::Problem.new(2166, 6099)
      puts "What is the GCD (g.answer)?"
      g.answer
    end

    attr_reader :quotient, :dividend, :step_num, :verbose
    def initialize( quotient, dividend, options = {} )
      @quotient = quotient.to_i
      @dividend = dividend.to_i
      @step_num = options[ :step_num ] || 1
      @verbose = options.has_key?( :verbose ) ? options[ :verbose ] : true
    end

    def remainder
      if dividend > quotient
        quotient
      else
        quotient - ( raw_div * dividend )
      end
    end

    def answer
      return dividend if done?
      puts "Quotient <- dividend (#{dividend}), dividend <- remainder (#{remainder})"
      return Gcd::Problem.new( dividend, remainder, :step_num => step_num + 1, :verbose => verbose).answer
    end

    private

    def precise_result
      Float(quotient) / dividend
    end

    def raw_div
      quotient / dividend
    end

    def done?
      puts "(#{step_num}) Quotient (#{quotient}) / dividend (#{dividend}) has a remainder of #{remainder}"
      0 == remainder
    end

  end
end

if 2 == ARGV.size
  g = Gcd::Problem.new( ARGV[0], ARGV[1] )
  g.answer
elsif 1 == ARGV.size
  if ARGV[0][/e/i]
    Gcd::Problem.example
  else
    Gcd::Problem.help
  end
end
