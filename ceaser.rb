def ceaser_cipher(input, key)

	# this is an array if the alphabet indexed by an array
  alphabet = ("a"..."z").to_a

	# sentence is an array
  sentence = []
  output = ""

	words = input.split("")

	 words.each do |word|

	 	if alphabet.include? (word)

              # string = the index of alphebet array + key value
	 		  string = alphabet.index(word) + key
		    target_string = alphabet[string]

	 	else

        target_string = word

	  end

	sentence.push(target_string)
	end

  puts output = sentence.join("")

end

ceaser_cipher("This is a simple sentence", 5)
ceaser_cipher("I tell you what!", 8)
