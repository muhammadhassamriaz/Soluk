// import 'package:app/module/influencer/workout/widgets/components/ingredients.dart';
import 'package:app/module/influencer/workout/model/fav_meal_modal.dart' as fav;
import 'package:app/utils/pickers.dart';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(TestInitial());

  addIngredients(fav.Ingredients ingre) {
    emit(FavoriteIngredients([...state.ingredients, ingre]));
  }
addUpdateIngredients(List<fav.Ingredients> ingredients) {
    emit(FavoriteIngredients(ingredients));
  }
  clearIngredients() {
    emit(const FavoriteIngredients([]));
  }

  updateIngredients(fav.Ingredients item, fav.Ingredients ingre) {
    List ingredients = state.ingredients;
    int index = ingredients.indexOf(item);
    ingredients[index] = ingre;
    emit(FavoriteIngredients([...ingredients]));
  }

  removeImage() {
    emit(const FavoriteImage(null));
  }

  deleteIngre(fav.Ingredients item) {
    List ingredients = state.ingredients;
    ingredients.remove(item);
    emit(FavoriteIngredients([...ingredients]));
  }

  pickImage(ImageSource source) async {
    String? path = await Pickers.instance.pickImage(source: source,quality: 50);
    if (path != null) {
      emit(FavoriteImage(path));
    }
  }
}
