require 'pry-debugger'
class WordTransformBfs

  DEPTH_LIMIT = 10
  def initialize()
    data = ""
    File.open("four_word_list.txt", "r") do |file|
      data = file.read
    end
    File.open("word_cache", "r") do |file|
      @word_cache = Marshal.load(file)
    end
    @four_letter_words = data_to_four_letter_words data
  end

  def four_letter_words
    @four_letter_words
  end
  def four_letter_words=(new_list)
    @four_letter_words = new_list
  end

  def transform_a_word_breadth_first(word_start, word_end)
    # Check for user errors
    unless word_start.length == 4 and word_end.length == 4 and @four_letter_words.include?(word_end)
      raise ArgumentError, "End word is not an English, four letter word."
    end

    # Find paths
    finished_paths = breadth_first_find_shortest_paths(word_start, word_end)

    # Return sorted paths
    unless finished_paths.empty?
      sorted_paths = finished_paths.sort { |x,y| x.length <=> y.length}
      return sorted_paths.first
    else
      return []
    end
  end

  def breadth_first_find_shortest_paths(word_start, word_end)
    one_away_words = find_words_one_away(word_start)
    shortest_path = [word_start]
    if one_away_words.include?(word_end)
      shortest_path << word_end
      return [shortest_path]
    else
      d_limit = 2
      current_word = word_start
      while d_limit <= DEPTH_LIMIT do
        finished_paths = recursive_depth_limited_find_all_paths(word_start, word_end, 1, shortest_path, d_limit)
        if !finished_paths.empty?
          return finished_paths
        end
        d_limit = d_limit + 1
      end
    end
    binding.pry
    return []
  end

  def recursive_depth_limited_find_all_paths(word_current, word_end, depth, traverse_path, d_limit)
    one_away_words = find_words_one_away(word_current)
    finished_paths = []
    if depth > d_limit or one_away_words.empty?
      finished_paths = []
    elsif one_away_words.include?(word_end)
      traverse_path << word_end
      finished_paths <<  traverse_path
    else
      one_away_words.each do |one_away_word|
        found_paths  = recursive_depth_limited_find_all_paths(one_away_word, word_end, depth + 1, traverse_path.dup << one_away_word, d_limit)
        if found_paths and !found_paths.empty?
          finished_paths.concat(found_paths)
        end
      end
    end
    return finished_paths
  end

  def get_downcase_characters_list(word)
    downcase_letters = []
    word.downcase.split("").each_with_index do |letter, index|
      downcase_letters[index] = letter
    end
    downcase_letters
  end

  def find_words_one_away_uncached(word, word_list = @four_letter_words)
    @word_cache = {} if !@word_cache
    start_letter = get_downcase_characters_list(word)
    one_word_different_list = []
    word_list.each do |word| 
      letters_different = 0
      word.downcase.split("").each_with_index do |letter, index|
        if letter != start_letter[index]
          letters_different = letters_different + 1
        end
      end
      if letters_different == 1
        one_word_different_list << word
      end
    end
    return one_word_different_list
  end

  def find_words_one_away(word, word_list = @four_letter_words)
    @word_cache[word]
  end

  private
  def data_to_four_letter_words(data)
    return data.gsub(/\s+/m, ' ').strip.split(" ").map{|word| word.downcase}
  end

end

