import 'package:bloc/bloc.dart';
import 'package:honest_guide/cubit/app_cubit_states.dart';
import 'package:honest_guide/model/data_model.dart';
import 'package:honest_guide/services/data_services.dart';

class AppCubits extends Cubit<CubitStates> {
  AppCubits({required this.data}) : super(InitialState()) {
    emit(WelcomeState());
  }

  final DataServices data;
  // ignore: prefer_typing_uninitialized_variables
  late final places;
  Future<void> getData() async {
    try {
      emit(LoadingState());
      places = await data.getInfo();
      emit(LoadedState(places));
      // ignore: empty_catches
    } catch (e) {}
  }

  // ignore: non_constant_identifier_names
  DetailPage(DataModel data) {
    emit(DetailState(data));
  }

  MapPage() {
    emit(MapState());
  }

  goHome() {
    emit(LoadedState(places));
  }

  goAbout() {
    emit(AboutPageState());
  }
}
