class RecipeController < Sinatra::Base

	configure :development do 
		register Sinatra::Reloader
	end

	set :root, File.join(File.dirname(__FILE__), "..")

	set :views, Proc.new { File.join(root, 'views') }

	$recipes = [{
	      title: "Strawberry Nutella Smores",
	      ingredients: "1 marshmallow,
	      				½ teaspoon nutella,
	       				2 lemon thins,
	       				2 strawberry slices",
	      body: "Toast marshmallow over a fire. Spread chocolate-hazelnut spread on one lemon thin; top with the marshmallow, strawberry and the second lemon thin."
	  },
	  {
	      title: "Five-Spice Tilapia",
	      ingredients: "1 pound tilapia fillets
				 1 teaspoon Chinese five-spice powder, ¼ cup reduced-sodium soy sauce, 3 tablespoons light brown sugar, 1 tablespoon canola oil3 scallions, thinly sliced
				 Onions Green Bunch",
	      body: "1. Sprinkle both sides of tilapia fillets with five-spice powder. Combine soy sauce and brown sugar in a small bowl. 
	      		 2. Heat oil in a large nonstick skillet over medium-high heat. Add the tilapia and cook until the outer edges are opaque, about 2 minutes. Reduce heat to medium, turn the fish over, stir the soy mixture and pour into the pan. Bring the sauce to a boil and cook until the fish is cooked through and the sauce has thickened slightly, about 2 minutes more. Add scallions and remove from the heat. Serve the fish drizzled with the pan sauce."
	  },
	  {
	      title: "Chinese Fried Rice",
	      ingredients: "3⁄4 cup finely chopped onion,
						2 1⁄2 tablespoons oil,
						1 egg, lightly beaten (or more eggs if you like),
						3 drops soy sauce,
						3 drops sesame oil,
						8 ounces cooked lean boneless pork or 8 ounces chicken, chopped,
						1⁄2 cup finely chopped carrot (very small),
						1⁄2 cup frozen peas, thawed,
						4 cups cold cooked rice, grains separated (preferably medium grain),
						4 green onions, chopped,
						2 cups bean sprouts,
						2 tablespoons light soy sauce (add more if you like)",
	      body: "1. Heat 1 tbsp oil in wok; add chopped onions and stir-fry until onions turn a nice brown color, about 8-10 minutes; remove from wok.
				 2.Allow wok to cool slightly.
				 3. Mix egg with 3 drops of soy and 3 drops of sesame oil; set aside.
				 4. Add 1/2 tbsp oil to wok, swirling to coat surfaces; add egg mixture; working quickly, swirl egg until egg sets against wok; when egg puffs, flip egg and cook other side briefly; remove from wok, and chop into small pieces.
				 5. Heat 1 tbsp oil in wok; add selected meat to wok, along with carrots, peas, and cooked onion; stir-fry for 2 minutes.
				 6. Add rice, green onions, and bean sprouts, tossing to mix well; stir-fry for 3 minutes.
				 7. Add 2 tbsp of light soy sauce and chopped egg to rice mixture and fold in; stir-fry for 1 minute more; serve.
				 8. Set out additional soy sauce on the table, if desired."
	  },
	  {
	      title: "Cinamon Cookies",
	      ingredients: "1 cup sugar,
						1⁄2 cup butter,
						1 large egg,
						1 teaspoon vanilla,
						1 1⁄2 cups flour,
						1 1⁄2 teaspoons cinnamon,
						1 teaspoon baking powder,
						1⁄4 teaspoon salt,
						cinnamon sugar",
	      body: "1. In a mixer bowl, cream together sugar and butter; beat in egg and vanilla.
				 2. Combine flour, cinnamon, baking powder and salt.
				 3. Add to butter mixture.
				 4. Blend well.
				 5. Cover and refrigerate 2 hours or till firm enough to roll into balls.
				 6. Shape dough into small balls about 3/4-inch in diameter.
				 7. Roll in cinnamon sugar to coat.
				 8. Set cookies 1-inch apart on lightly greased cookie sheets.
				 9. Bake at 350° for 10 minutes or till the edges are lightly browned.
				 10. Cool slightly on pans, then remove to racks to cool completely."
	  },
	  {
	      title: "Shrimp Veracruzana",
	      ingredients: "2 teaspoons canola oil,
	      				1 bay leaf1 medium onion, halved and thinly sliced,
						2 jalapeño peppers, seeded and very thinly sliced, or to taste4 cloves garlic, minced
						1 pound peeled and deveined raw shrimp, (16-20 per pound,
						3 medium tomatoes, diced¼ cup thinly sliced pitted green olives
						1 lime, cut into 4 wedges",
	      body: "1. Heat oil in a large nonstick skillet over medium heat. 
	      		 2. Add bay leaf and cook for 1 minute. 
	      		 3. Add onion, jalapenos and garlic and cook, stirring, until softened, about 3 minutes. 
	      		 4. Stir in shrimp, cover and cook until pink and just cooked through, 3 to 4 minutes. 
	      		 5. Stir in tomatoes and olives. Bring to a simmer, reduce heat to medium-low, replace cover and cook until the tomatoes are almost broken down, 2 to 3 minutes more. 
	      		 6. Remove the bay leaf. Serve with lime wedges."
	  },
	  {
	      title: "Crab Cake Burgers",
	      ingredients: "1 pound crabmeat,
	      				1 egg, lightly beaten,
	      				½ cup panko breadcrumbs,
	      				¼ cup light mayonnaise,
						2 tablespoons minced chives,
						1 tablespoon Dijon mustard1 tablespoon lemon juice,
						1 teaspoon celery seed,
						1 teaspoon onion powder,
						¼ teaspoon freshly ground pepper,
						4 dashes hot sauce, 
						1 tablespoon extra-virgin olive oil,
						2 teaspoons unsalted butter",
	      body: "1. Mix crab, egg, breadcrumbs, mayonnaise, chives, mustard, lemon juice, celery seed, onion powder, pepper and hot sauce in a large bowl. Form into 6 patties. 
	      		 2. Heat oil and butter in a large nonstick skillet over medium heat until the butter stops foaming. Cook the patties until golden brown, about 4 minutes per side."
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
		@page_header = "Read the full recipe below:"
		id = params[:id].to_i 
		@recipes = $recipes[id]
		erb :"recipes/show" 
	end

	post "/recipes" do 
		new_recipe = {
			title: params[:title],
			ingredients: params[:ingredients],
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
		$recipes[id][:ingredients] = params[:ingredients]
		$recipes[id][:body] = params[:body]
		redirect "/recipes/#{id}" 
	end

	delete "/recipes/:id" do 
		id = params[:id].to_i
		$recipes.delete_at(id)
		redirect '/recipes'
	end


end
