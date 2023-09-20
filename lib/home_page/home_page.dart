// Importing necessary packages
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber/home_page/bloc.dart';
import 'package:uber/ride_page/ride_page.dart';
import 'package:uber/drive_page/drive_page.dart';
import 'package:uber/account_page/account_page.dart';
import 'package:uber/plan_page/plan_page.dart';

// _HomePageState class
class _HomePageState extends State<HomePage> {
  late final HomePageBloc _bloc;

  @override
  void initState() {
    // Initializing the HomePageBloc
    _bloc = HomePageBloc();
    super.initState();
  }

  @override
  void dispose() {
    // Closing the HomePageBloc
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
          bloc: _bloc,
          builder: (_, HomePageState state) {
            // Checking the pageIndex to determine which page to display
            if (state.pageIndex == 1) {
              return const AccountPage();
            }
            if (state.pageIndex == 3) {
              return const RidePage();
            }
            if (state.pageIndex == 4) {
              return const DrivePage();
            }
            if (state.pageIndex == 5){
              return const PlanPage();
            }
            MediaQueryData mediaQuery = MediaQuery.of(context);
            return Center(
              child: SizedBox(
                height: mediaQuery.size.height * 0.75,
                child:Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 250,
                    height: 125,
                    child: ElevatedButton(
                      onPressed: () => _bloc.switchPage(3),
                      child: const Text('Ride', style: TextStyle(fontSize: 25)),
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    height: 125,
                    child: ElevatedButton(
                      onPressed: () => _bloc.switchPage(5),
                      child: const Text('Plan Trip', style: TextStyle(fontSize: 25)),
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    height: 125,
                    child: ElevatedButton(
                      onPressed: () => _bloc.switchPage(4),
                      child: const Text('Drive', style: TextStyle(fontSize: 25)),
                    ),
                  ),
                ],
              ),
            ));
          }),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
        currentIndex: 0,
        onTap: _bloc.switchPage,
      ),
    );
  }
}

// HomePage class
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
