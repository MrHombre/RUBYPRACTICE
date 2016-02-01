require 'minitest/autorun'
require_relative 'word_frequencies'

describe 'f' do
  it 'should return each word and the number of times, each word appears in the string' do
    expect(f("To be, or not to be.")).must_equal([["to", 2], ["be", 2], ["or", 1], ["not", 1]])

    expect(f("Hello World!")).must_equal([["hello", 1], ["world", 1]])
  end
end
