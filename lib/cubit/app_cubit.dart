import 'package:bloc/bloc.dart';
import 'package:honest_guide/cubit/app_cubit_states.dart';
import 'package:honest_guide/model/data_model.dart';
import 'package:honest_guide/services/data_services.dart';

class AppCubits extends Cubit<CubitStates> {
  AppCubits({required this.data}) : super(InitialState()) {
    emit(WelcomeState());
  }

  final DataServices data;
  late List<DataModel> culturePlaces;
  late List<DataModel> naturePlaces;
  late List<DataModel> refreshmentPlaces;
  late List<DataModel> eventPlaces;

  Future<void> getData() async {
    try {
      emit(LoadingState());
      culturePlaces = await data.getCultureInfo();
      naturePlaces = await data.getNatureInfo();
      refreshmentPlaces = await data.getRefreshmentInfo();
      eventPlaces = await data.getEventInfo();
      emit(LoadedState(
        culturePlaces: culturePlaces,
        naturePlaces: naturePlaces,
        refreshmentPlaces: refreshmentPlaces,
        eventPlaces: eventPlaces,
      ));
    } catch (e) {
      // Handle error
    }
  }

  DetailPage(DataModel data) {
    emit(DetailState(data));
  }

  MapPage() {
    emit(MapState());
  }

  goHome() {
    emit(LoadedState(
      culturePlaces: culturePlaces,
      naturePlaces: naturePlaces,
      refreshmentPlaces: refreshmentPlaces,
      eventPlaces: eventPlaces,
    ));
  }

  goAbout() {
    emit(AboutPageState());
  }

  goPodcast() {
    emit(PodcastPageState());
  }
}
