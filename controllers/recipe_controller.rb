class RecipeController < Sinatra::Base

	configure :development do 
		register Sinatra::Reloader
	end

	set :root, File.join(File.dirname(__FILE__), "..")

	set :views, Proc.new { File.join(root, 'views') }

	$recipes = [{
	      title: "Apple Pie",
	      image: "word",
	      body: "Method
				1. For the pastry, place the flour, sugar and lemon zest into a bowl and rub in the butter until the mixture resembles breadcrumbs. Add the beaten egg and stir with a round-bladed knife until the mixture forms a dough.
				2. Set aside one-third of the pastry for the lid.
				3. Roll out the remaining pastry on a lightly floured surface until the thickness of a pound coin and 5-7cm/2-3in larger than the pie dish. Lift the pastry over the rolling pin and lower it gently into the pie dish.
				4. Press the pastry firmly into the dish and up the sides, making sure there are no air bubbles. Chill the fridge for a few minutes.
				5. Preheat the oven to 200C/180 (fan)/Gas 6. Place a baking tray into the oven to preheat.
				6. For the filling, mix the sugar, cinnamon and cornflour in a large bowl. Stir in the apples.
				7. Place the apple filling into the pie dish, making sure that it rises above the edge. Brush the rim of the dish with beaten egg.
				8. Roll out the reserved ball of pastry. Cover the pie with the pastry and press the edges together firmly to seal. Using a sharp knife, trim off the excess pastry, then gently crimp all around the edge. Make a few small holes in the centre of the pie with the tip of a knife. Glaze the top with beaten egg.
				9. Lightly knead the pastry trimmings and re-roll. Cut into leaf shapes place all around the edge of the pie, slightly overlapping each other, and glaze with more egg. Sprinkle the pie with sugar and bake in the centre of the oven for 45–55 minutes or golden-brown all over and the apples are tender."
	  },
	  {
	      title: "Post 2",
	      body: "This is the second post"
	  },
	  {
	      title: "Post 3",
	      body: "This is the second post"
	  },
	  {
	      title: "Post 4",
	      body: "This is the second post"
	  },
	  {
	      title: "Post 5",
	      body: "This is the second post"
	  },
	  {
	      title: "Post 6",
	      body: "This is the third post"
	  }]

	  get '/recipes' do 
		@page_header = "Take a Look at the Recipes Below:"
		@recipes = $recipes
		erb :"recipes/index" 
	end

	get '/recipes/new' do 
		erb :"recipes/new"
	end


	get '/recipes/:id' do 
		@page_header = "Specific Post"
		id = params[:id].to_i 
		@recipes = $recipes[id]
		erb :"recipes/show" 
	end

	post "/recipes" do 
		new_recipe = {
			title: params[:title],
			body: params[:body]
		}
		$recipes << new_recipe
		redirect '/recipes'
	end

	get "/recipes/:id/edit" do 
		@id = params[:id].to_i
		@recipes = $recipes[@id]
		erb :"recipes/edit"
	end

	put "/recipes/:id" do 
		id = params[:id].to_i

		$recipes[id][:title] = params[:title]
		$recipes[id][:body] = params[:body]
		redirect "/recipes/#{id}" #string interperlation only works with double quotes
	end

	delete "/recipes/:id" do 
		id = params[:id].to_i
		$recipes.delete_at(id)
		redirect '/recipes'
	end


end
