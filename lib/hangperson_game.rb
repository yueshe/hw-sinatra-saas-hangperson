class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @lives = 7
    @guess_arr = Hash.new
    @word_with_guesses = ''
    word.chars { |i|
      @guess_arr[i] = 0
      @word_with_guesses =  @word_with_guesses + '-'
    }
    @wrong_guess_arr = Hash.new
    @check_win_or_lose = :play
  end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  attr_accessor :word_with_guesses
  attr_accessor :check_win_or_lose

  def guess(i)
    if @lives <= 0
      return true
    end
    if i == nil
      raise ArgumentError, "the letter you guess cannot be nil", caller
    elsif i.length == 0
      raise ArgumentError, "the letter you guess cannot be empty", caller
    elsif !(i =~ /[A-Za-z]/)
      raise ArgumentError, "the letter you guess must be a letter", caller
    end
    k = i.downcase
    if (@guess_arr.has_key?(k) == false) 
      @lives = @lives - 1
      if (@lives <= 0)
        @check_win_or_lose = :lose
        return true
      end
      if (@wrong_guess_arr.has_key?(k) == false)
        @wrong_guess_arr[k] = 1
        @wrong_guesses = @wrong_guesses + k 
        return true
      else
        return false
      end
      return true
    elsif (@guess_arr[k] == 0) 
      @guesses = @guesses + k
      @guess_arr[k] = 1
      count = 0
      @word.chars { |j|
        if j == k
          @word_with_guesses[count] = k
        end
        count = count + 1
      }
      if @word_with_guesses == @word
        @check_win_or_lose = :win
      return true
      end
    else
      return false
    end
  end

  
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
