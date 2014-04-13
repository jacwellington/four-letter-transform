require './flw_breadth.rb'

BWORDS = %w(BAAL BAAS BABA BABE BABU BABY BACH BACK BACS BADE BADS BAEL BAFF BAFT BAGH BAGS BAHT BAHU BAIL BAIT BAJU BAKE BALD BALE BALK BALL BALM BALS BALU BAMS BANC BAND BANE BANG BANI BANK BANS BANT BAPS BAPU BARB BARD BARE BARF BARK BARM BARN BARP BARS BASE BASH BASK BASS BAST BATE BATH BATS BATT BAUD BAUK BAUR BAWD BAWL BAWN BAWR BAYE BAYS BAYT BEAD BEAK BEAM BEAN BEAR BEAT BEAU BECK BEDE BEDS BEDU BEEF BEEN BEEP BEER BEES BEET BEGO BEGS BEIN BELL BELS BELT BEMA BEND BENE BENI BENJ BENS BENT BERE BERG BERK BERM BEST BETA BETE BETH BETS BEVY BEYS BHAI BHAT BHEL BHUT BIAS BIBB BIBS BICE BIDE BIDI BIDS BIEN BIER BIFF BIGA BIGG BIGS BIKE BILE BILK BILL BIMA BIND BINE BING BINK BINS BINT BIOG BIOS BIRD BIRK BIRL BIRO BIRR BISE BISH BISK BIST BITE BITO BITS BITT BIZE BLAB BLAD BLAE BLAG BLAH BLAM BLAT BLAW BLAY BLEB BLED BLEE BLET BLEW BLEY BLIN BLIP BLIT BLOB BLOC BLOG BLOT BLOW BLUB BLUE BLUR BOAB BOAK BOAR BOAS BOAT BOBA BOBS BOCK BODE BODS BODY BOEP BOET BOFF BOGS BOGY BOHO BOHS BOIL BOIS BOKE BOKO BOKS BOLA BOLD BOLE BOLL BOLO BOLT BOMA BOMB BONA BOND BONE BONG BONK BONY BOOB BOOH BOOK BOOL BOOM BOON BOOR BOOS BOOT BOPS BORA BORD BORE BORK BORM BORN BORS BORT BOSH BOSK BOSS BOTA BOTE BOTH BOTS BOTT BOUK BOUN BOUT BOWL BOWR BOWS BOXY BOYF BOYG BOYO BOYS BOZO BRAD BRAE BRAG BRAK BRAN BRAS BRAT BRAW BRAY BRED BREE BREI BREN BRER BREW BREY BRIE BRIG BRIK BRIM BRIN BRIO BRIS BRIT BROD BROG BROO BROS BROW BRRR BRUS BRUT BRUX BUAT BUBA BUBO BUBS BUBU BUCK BUDA BUDI BUDO BUDS BUFF BUFO BUGS BUHL BUHR BUIK BUKE BULB BULK BULL BUMF BUMP BUMS BUNA BUND BUNG BUNK BUNN BUNS BUNT BUOY BURA BURB BURD BURG BURK BURL BURN BURP BURR BURS BURY BUSH BUSK BUSS BUST BUSY BUTE BUTS BUTT BUYS BUZZ BYDE BYES BYKE BYRE BYRL BYTE).map{|word| word.downcase}
describe WordTransformBfs do
  before(:each) do
    @word_transform = WordTransformBfs.new
  end
  it "has a list of four letter words" do
    @word_transform.four_letter_words.each do |word|
      expect(word.length).to eq(4)
      expect(word.include? " ").to eq(false)
    end
  end
  context "get downcase characters" do
    it "returns an array of downcase characters" do
      expect(@word_transform.get_downcase_characters_list("ABcD")).to eq(['a', 'b', 'c', 'd'])
    end 
  end
  context "find words one away" do
    it "returns a word one character away" do
      test_input = %w(aals balk baBe BACS sail ball).map{|word| word.downcase}
      test_expected_include = %w(aahs ball baby back tail bale)
      test_input.each_with_index do |input_word, index|
        words_one_away = @word_transform.find_words_one_away(input_word, @word_transform.four_letter_words)
        includes_word = words_one_away.map{|word| word.downcase}.include?(test_expected_include[index])
        #puts "input: " + input_word + " - test_include: " + test_expected_include[index] + " - includes?: " + includes_word.to_s
        #puts "words one away: " + words_one_away.inspect
        expect(includes_word).to eq(true)
      end
    end
  end
  context "transform a word" do
    it "raises an error on not four letter words" do
      words_to_test  = %w(abcde abcdef abc bl)
      words_to_test.each do |word|
        expect{@word_transform.transform_a_word_depth_first(word, word)}.to raise_error
      end
    end
    it "raises an error on transforming to four letter non words" do
      words_to_test  = %w(aaaa bazq mlnd bizq)
      words_to_test.each do |word|
        expect{@word_transform.transform_a_word_depth_first('ball', word)}.to raise_error
      end
    end
    it "transforms words" do
      words_start = %w(aals ball)
      words_end = %w(aahs bade)
      expected_path_lengths = [2, 3] 
      new_lists = [false, false]
      words_start.each_with_index do |word_start, index|
        new_list = new_lists[index]
        if new_list
          @word_transform.four_letter_words = new_list
        end
        word_end = words_end[index]
        transform_list = @word_transform.transform_a_word_depth_first(word_start, word_end)
        expect(transform_list.length).to eq(expected_path_lengths[index])
      end
    end
  end
end

