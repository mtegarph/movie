import 'package:pokedex/configs/AppColors.dart';
import 'package:pokedex/models/pokemon.dart';

const List<Pokemon> pokemons = [
  Pokemon(
    name: "Bulbasaur",
    types: const ["grass", "poison"],
    image: "assets/images/bulbasaur.png",
    color: AppColors.lightTeal,
  ),
  Pokemon(
    name: "Ivysaur",
    types: const ["grass", "poison"],
    image: "assets/images/ivysaur.png",
    color: AppColors.lightTeal,
  ),
  Pokemon(
    name: "Venusaur",
    types: const ["grass", "poison"],
    image: "assets/images/venusaur.png",
    color: AppColors.lightTeal,
  ),
  Pokemon(
    name: "Charmander",
    types: const ["fire"],
    image: "assets/images/charmander.png",
    color: AppColors.lightRed,
  ),

  Pokemon(
    name: "Pikachu",
    types: const ["electric"],
    image: "assets/images/pikachu.png",
    color: AppColors.lightYellow,
  ),
];
