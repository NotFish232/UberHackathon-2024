// Importing necessary packages
import 'package:flutter_bloc/flutter_bloc.dart';

// HomePageState class
class HomePageState {
  // Variable for pageIndex
  final int pageIndex;

  // Constructor
  const HomePageState(this.pageIndex);
}

// HomePageBloc class
class HomePageBloc extends Cubit<HomePageState> {
  // Constructor
  HomePageBloc() : super(const HomePageState(0));

  // Method to switch the page
  void switchPage(int pageIndex) {
    // Checking if the pageIndex is different from the current state's pageIndex
    if (pageIndex != state.pageIndex) {
      // Emitting a new HomePageState with the updated pageIndex
      emit(HomePageState(pageIndex));
    }
  }
}
