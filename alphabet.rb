#!/usr/bin/env ruby

# alphabet.rb
#
# this module grabs alphabet letters from the alphabet.yml file and allows
# you to print them out or builds and returns a hash map of their data.

require 'yaml'

module Alphabet

  YAML_FILE = File.dirname(__FILE__) + '/alphabet.yml'
  DOCUMENT = YAML.load_file(YAML_FILE)

  def self.print_letter(letter)
    curr = DOCUMENT[letter]
    width = curr[0]['width']
    height = curr[1]['height']
    chars = curr[2]['chars']
    (1..height).each do |n|
      puts chars[(n-1)*width,width]
    end
    puts chars
  end

  def self.get_letter_chars(letter)
    curr = DOCUMENT[letter]
    width = curr[0]['width']
    height = curr[1]['height']
    chars = curr[2]['chars']
    return chars
  end

  def self.get_chronological_letter_chars(letter)
    curr = DOCUMENT[letter]
    width = curr[0]['width']
    height = curr[1]['height']
    chars = curr[2]['chars']
    chrono_chars = ''
    width.times do |m|
      height.times do |n|
        chrono_chars += chars[(m + (n*7)), 1]
      end
    end
    return chrono_chars
  end

  def self.letter_to_hash(letter)
    curr = DOCUMENT[letter]
    width = curr[0]['width']
    height = curr[1]['height']
    chars = curr[2]['chars']
    char_map = Hash.new
    (1..width).each do |n|
      (1..height).each do |m|
        pos = (n-1) + (m-1)*width
        char = chars[pos]
        char_map[[n-1,m-1]] = char
      end
    end
    return char_map
  end

end
