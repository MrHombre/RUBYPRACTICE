#Adding a comment

def f(p)
  words = p.downcase.split(/\W+/)


  new_array = []



  words.each do |word|
    new_array << [word, words.count{|x| x == word}]  #Creating a loop
                                                     #Takes the new_array addes our 'unique words'
                                                     #Counts the frequency of the words.
  end


  new_array.uniq
end
