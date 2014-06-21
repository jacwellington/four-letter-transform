Intro
==
This is a library to transform one four letter word into another four letter word. The way it transforms the word is by giving the shortest list of intermediate words that differ from the previous by one letter. For example to get from 'area' to 'coal', it goes from 'cold' to 'coll' to 'cold'. It uses a breadth first search algorithm and memoizes answers to a 'word_cache' file. To use this library require flw_depth.rb, create a new 'WordTranformBfs' and then call 'transform_a_word_breadth_first' on it. You can also run 'rspec test_four_letter_word.rb' to test it.

TODO
==
+ This was done in my spare time for myself. It obviously needs to be cleaned up a bit and commented better.
+ Turn into a gem.
+ Allow it to use Redis instead of a file as a memo cache.
