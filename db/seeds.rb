  def parse_cards_from_file(file)
    cards = []
    text = File.read(file).split(/\n/)

    text.reject! { |string| string == ""}

    definition_counter = 0
    term_counter = 1

    all_cards = []

    for i in (0..(text.length/2)-1)
      card_data = {}
      card_data[:question] = text[definition_counter]
      card_data[:answer] = text[term_counter]
      definition_counter += 2
      term_counter +=2
      all_cards << card_data
    end

    all_cards
  end

#in real life I would iterate over every file in this directory but idk

harry_potter_deck = Deck.create(name: "Harry Potter Trivia")
harry_potter_cards = parse_cards_from_file('db/decks/harry_potter.txt')

harry_potter_cards.each do |card_data|
  harry_potter_deck.flashcards << Flashcard.create(card_data)
end


computer_science_deck = Deck.create(name: "Computer Science")
computer_science_cards = parse_cards_from_file('db/decks/computer_science.txt')

computer_science_cards.each do |card_data|
  computer_science_deck.flashcards << Flashcard.create(card_data)
end

mammals_deck = Deck.create(name: "Mammals")
mammals_cards = parse_cards_from_file('db/decks/mammals.txt')

mammals_cards.each do |card_data|
  mammals_deck.flashcards << Flashcard.create(card_data)
end

kb = User.new(username:"KB", email:"kdiangelo@gmail.com", password:"12345")
kb.save

jenna = User.new(username:"Jenna", email:"jenna@gmail.com", password:"abc123")
jenna.save

un = User.new(username:"Un", email:"un@mail.com", password:"password")
un.save
