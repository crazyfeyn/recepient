import 'package:flutter_application/data/model/ingredient.dart';
import 'package:flutter_application/data/model/recipe.dart';

class Example {
  static List<Recipe> ingredients = [
    spaghettiCarbonara,
    chickenCurry,
    caesarSalad,
    beefTacos
  ];
  static Recipe spaghettiCarbonara = Recipe(
    title: "Spaghetti Carbonara",
    ingredient: Ingredient(
      name: "Spaghetti",
      quantity: 200,
      type: "Pasta",
      isSelected: true,
    ),
    description:
        "A classic Italian pasta dish made with eggs, cheese, pancetta, and pepper.",
    preparation: [
      "Cook the spaghetti in a large pot of boiling salted water until al dente.",
      "In a separate pan, cook the pancetta until crispy.",
      "Beat eggs and cheese together in a bowl.",
      "Drain the pasta and toss with the pancetta, then quickly mix in the egg and cheese mixture.",
      "Serve immediately with freshly ground black pepper."
    ],
    estimatedTime: DateTime.now().add(Duration(minutes: 25)),
    category: ["Italian", "Pasta"],
    imageUrl:
        "https://media.istockphoto.com/id/1144823591/photo/spaghetti-in-a-dish-on-a-white-background.jpg?s=612x612&w=0&k=20&c=SeEWmJfPQlX1zVUHPKjL-cgYeMs9cZ97-kdZMm7feA4=",
    videoUrl: "https://example.com/spaghetti_carbonara_video.mp4",
    userId: "user1",
    id: "recipe1",
    isSaved: false,
    likes: 150,
    rate: 4.7,
    comments: [],
  );

// Recipe 2: Chicken Curry
  static Recipe chickenCurry = Recipe(
    title: "Chicken Curry",
    ingredient: Ingredient(
      name: "Chicken",
      quantity: 500,
      type: "Meat",
      isSelected: true,
    ),
    description:
        "A flavorful and spicy chicken curry made with a blend of Indian spices.",
    preparation: [
      "Marinate the chicken with yogurt and spices.",
      "Cook onions, garlic, and ginger in a pan until soft.",
      "Add the marinated chicken and cook until browned.",
      "Add tomatoes and simmer until the chicken is cooked through.",
      "Serve with rice or naan."
    ],
    estimatedTime: DateTime.now().add(Duration(minutes: 40)),
    category: ["Indian", "Spicy"],
    imageUrl:
        "https://media.istockphoto.com/id/1144823591/photo/spaghetti-in-a-dish-on-a-white-background.jpg?s=612x612&w=0&k=20&c=SeEWmJfPQlX1zVUHPKjL-cgYeMs9cZ97-kdZMm7feA4=",
    videoUrl: "https://example.com/chicken_curry_video.mp4",
    userId: "user2",
    id: "recipe2",
    isSaved: true,
    likes: 200,
    rate: 4.8,
    comments: [],
  );

// Recipe 3: Caesar Salad
  static Recipe caesarSalad = Recipe(
    title: "Caesar Salad",
    ingredient: Ingredient(
      name: "Romaine Lettuce",
      quantity: 150,
      type: "Vegetable",
      isSelected: true,
    ),
    description:
        "A fresh and crisp Caesar salad with homemade croutons and dressing.",
    preparation: [
      "Chop the romaine lettuce and place in a large bowl.",
      "Prepare the dressing by mixing mayonnaise, lemon juice, garlic, anchovy paste, and Parmesan cheese.",
      "Toss the lettuce with the dressing and croutons.",
      "Serve with additional Parmesan cheese and freshly ground black pepper."
    ],
    estimatedTime: DateTime.now().add(Duration(minutes: 15)),
    category: ["Salad", "Healthy"],
    imageUrl:
        "https://media.istockphoto.com/id/1144823591/photo/spaghetti-in-a-dish-on-a-white-background.jpg?s=612x612&w=0&k=20&c=SeEWmJfPQlX1zVUHPKjL-cgYeMs9cZ97-kdZMm7feA4=",
    videoUrl: "https://example.com/caesar_salad_video.mp4",
    userId: "user3",
    id: "recipe3",
    isSaved: false,
    likes: 120,
    rate: 4.5,
    comments: [],
  );

// Recipe 4: Beef Tacos
  static Recipe beefTacos = Recipe(
    title: "Beef Tacos",
    ingredient: Ingredient(
      name: "Ground Beef",
      quantity: 300,
      type: "Meat",
      isSelected: true,
    ),
    description: "Delicious beef tacos with homemade salsa and guacamole.",
    preparation: [
      "Cook the ground beef with taco seasoning until browned.",
      "Warm the taco shells in the oven.",
      "Prepare the salsa by mixing tomatoes, onions, cilantro, and lime juice.",
      "Assemble the tacos by filling the shells with beef, salsa, and guacamole.",
      "Serve with a side of sour cream and lime wedges."
    ],
    estimatedTime: DateTime.now().add(Duration(minutes: 20)),
    category: ["Mexican", "Tacos"],
    imageUrl:
        "https://media.istockphoto.com/id/1144823591/photo/spaghetti-in-a-dish-on-a-white-background.jpg?s=612x612&w=0&k=20&c=SeEWmJfPQlX1zVUHPKjL-cgYeMs9cZ97-kdZMm7feA4=",
    videoUrl: "https://example.com/beef_tacos_video.mp4",
    userId: "user4",
    id: "recipe4",
    isSaved: true,
    likes: 180,
    rate: 4.6,
    comments: [],
  );
}
