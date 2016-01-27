#ZM: Okay
get "/decks/new" do
  erb :"decks/new"
end

#ZM: Okay
get "/decks/index" do
  @all_decks = Deck.all
  erb :"decks/index"
end

#Should this be here or in a cards controller??
#ZM: Do you have a cards controller? It's okay to be here since there is a direct
# dependency. If you are going to make full CRUD for a card I would make a new controller though. 
get "/decks/:id/cards/new" do
  @deck = Deck.find_by(id: params[:id])
  erb :"cards/new"
end

#OK fine this should definitely be in a cards controller
post "/decks/:id/cards/new" do
  @deck = Deck.find_by(id: params[:id])
  new_card = Flashcard.new(params[:card])

  #ZM: If you use the new syntax, make sure that you save it before you use the << 
  @deck.flashcards << new_card
  redirect "/decks/#{@deck.id}/cards/new"
end

get "/decks/:id" do
  @deck = Deck.find_by(id: params[:id])
  erb :"decks/show"
end

post "/decks" do
  new_deck = Deck.new(params[:deck])
  if new_deck.save
    redirect "decks/#{new_deck.id}/cards/new"
  else
    redirect "/oops"
  end
end
