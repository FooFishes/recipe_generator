import 'package:hive/hive.dart';
import 'package:recipe_generator/data/models/recipe_model.dart';

class DatabaseService {
  static Box<RecipeModel>? _recipeBox;

  static Future<Box<RecipeModel>> get instance async{
    if(_recipeBox != null) {
      return _recipeBox!;
    }
    Hive.registerAdapter(RecipeModelAdapter());
    _recipeBox = await Hive.openBox<RecipeModel>('recipes');
    return _recipeBox!;
  }

  Future<void> saveRecipe(RecipeModel recipe) async {
    final box = await instance;
    await box.add(recipe);
  }

  Future<List<RecipeModel>> getFavoriteRecipes() async {
    final box = await instance;
    final favourites = box.values.where((recipe) => recipe.isFavorite).toList();
    return favourites;
  }

  Future<void> toggleFavorite(String recipeId) async {
    final box = await instance;
    final recipe = box.values.firstWhere((recipe) => recipe.recipeId == recipeId);
    recipe.isFavorite = !recipe.isFavorite;
    await recipe.save();
  }

  Future<void> deleteRecipe(String recipeId) async {
    final box = await instance;
    final recipe = box.values.firstWhere((recipe) => recipe.recipeId == recipeId);
    await recipe.delete();
  }

  Future<void> clearAllFavorites() async {
    final box = await instance;
    await box.clear();
  }
}