# Your code goes here!
class Anagram
    def initialize(word)
        @word = word
    end

    def match(words)
        words.select { |word| anagram?(word) }
    end

    private

    def anagram?(word)
        word.downcase != @word.downcase && word.downcase.chars.sort == @word.downcase.chars.sort
    end
    end

    # Path: test/anagram_test.rb
    require 'minitest/autorun'
    require_relative '../lib/anagram'

    class AnagramTest < Minitest::Test
    def test_no_matches
        detector = Anagram.new('diaper')
        assert_equal [], detector.match(%w(hello world zombies pants))
    end

    def test_detect_simple_anagram
        detector = Anagram.new('ant')
        anagrams = detector.match(%w(tan stand at))
        assert_equal %w(tan), anagrams
    end

    def test_does_not_confuse_different_duplicates
        detector = Anagram.new('galea')
        assert_equal [], detector.match(%w(eagle gallery ballerina))
    end

    def test_eliminate_anagram_subsets
        detector = Anagram.new('good')
        assert_equal [], detector.match(%w(dog goody))
    end

    def test_detect_anagram
        detector = Anagram.new('listen')
        anagrams = detector.match(%w(enlists google inlets banana))
        assert_equal %w(inlets), anagrams
    end

    def test_multiple_anagrams
        detector = Anagram.new('allergy')
        anagrams = detector.match(%w(gallery ballerina regally clergy largely leading))
        assert_equal %w(gallery largely regally), anagrams
    end

    def test_anagrams_are_case_insensitive
        detector = Anagram.new('Orchestra')
        anagrams = detector.match(%w(cashregister Carthorse radishes))
        assert_equal %w(Carthorse), anagrams
    end

    def test_same_word_isnt_anagram
        detector = Anagram.new('banana')
        assert_equal [], detector.match(%w(banana))
    end

end