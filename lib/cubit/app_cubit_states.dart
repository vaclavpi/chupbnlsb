import 'package:equatable/equatable.dart';
import 'package:honest_guide/model/data_model.dart';

abstract class CubitStates extends Equatable {}

class InitialState extends CubitStates {
  @override
  List<Object?> get props => [];
}

class WelcomeState extends CubitStates {
  @override
  List<Object?> get props => [];
}

class AboutPageState extends CubitStates {
  @override
  List<Object?> get props => [];
}

class PodcastPageState extends CubitStates {
  @override
  List<Object?> get props => [];
}

class LoadingState extends CubitStates {
  @override
  List<Object?> get props => [];
}

class LoadedState extends CubitStates {
  LoadedState({
    required this.culturePlaces,
    required this.naturePlaces,
    required this.refreshmentPlaces,
    required this.eventPlaces,
  });

  final List<DataModel> culturePlaces;
  final List<DataModel> naturePlaces;
  final List<DataModel> refreshmentPlaces;
  final List<DataModel> eventPlaces;

  @override
  List<Object?> get props =>
      [culturePlaces, naturePlaces, refreshmentPlaces, eventPlaces];
}

class MapState extends CubitStates {
  @override
  List<Object?> get props => [];
}

class DetailState extends CubitStates {
  DetailState(this.places);
  final DataModel places;
  @override
  List<Object?> get props => [places];

  get length => null;
}
