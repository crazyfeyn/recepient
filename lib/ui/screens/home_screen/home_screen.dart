import 'package:flutter/material.dart';
import 'package:flutter_application/data/model/user_model.dart';
import 'package:flutter_application/data/services/user/firebase_user_service.dart';
import 'package:flutter_application/data/utils/app_constants.dart';
import 'package:flutter_application/logic/bloc/home/home_bloc.dart';
import 'package:flutter_application/ui/screens/home_screen/widgets/tripple_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel? user;

  @override
  void initState() {
    super.initState();
    getCurrentUserInfo();
  }

  Future<void> getCurrentUserInfo() async {
    try {
      var uId = await FirebaseUserService.getId();
      if (uId != null) {
        user = await FirebaseUserService().getUser(uId);
        AppConstants.uId = uId;
        AppConstants.userModel = user;
        setState(() {});
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<HomeBloc>().add(FetchRecipesEvent());
  }

  Future<void> _refreshRecipes() async {
    context.read<HomeBloc>().add(FetchRecipesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: RefreshIndicator(
            onRefresh: _refreshRecipes,
            child: BlocBuilder<HomeBloc, HomeState>(
              bloc: context.read<HomeBloc>(),
              builder: (context, state) {
                if (state is LoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is ErrorState) {
                  return Center(child: Text(state.message));
                }
                if (state is LoadedState) {
                  print(state.recipes);
                  return TrippleWidget(
                    recipes: state.recipes,
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}
