import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:oversight/navigation/enums/form_modes.dart';
import 'package:oversight/presentation/pages/users/user_page.dart';
import 'package:oversight/service/user/models/user_model.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../stores/user/user_cubit.dart';
import '../../../themes/oversight_colors.dart';
import '../../../themes/oversight_text_styles.dart';
import '../../widgets/buttons/button/oversight_button.dart';
import '../../widgets/buttons/button/oversight_button_style.dart';
import '../../widgets/cards/actions_card/oversight_actions_card.dart';
import '../../widgets/drawer/oversight_drawer.dart';
import '../../widgets/input/input_search/oversight_input_search.dart';
import '../../widgets/input/input_search/oversight_input_search_style.dart';
import '../../widgets/navigation/app_bar/oversight_app_bar.dart';
import '../../widgets/navigation/app_bar/oversight_app_bar_style.dart';
import '../../widgets/spacer/vspace.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  late final UserCubit _cubit;
  UserModel _userModel = const UserModel();
  List<UserModel> _userList = <UserModel>[];

  @override
  void initState() {
    _cubit = GetIt.I.get();
    _cubit.init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OversightColors.cultured,
      endDrawer: const OversightDrawer(),
      appBar: OversightAppBar(
        style: const OversightAppBarStyle(
          backgroundColor: OversightColors.cultured,
          elevation: 2,
        ),
        title: Text(
          'Usuários',
          style: OversightTextStyles.kBodyStrong.copyWith(
            color: OversightColors.primaryCian,
            fontSize: 25,
          ),
        ),
        action: [
          Builder(builder: (context) {
            return OversightButton(
              icon: Icons.menu,
              style: const OversightButtonStyle(
                backgroundColor: OversightColors.transparent,
                secondaryColor: OversightColors.primaryCian,
                pressedColor: OversightColors.transparent,
                width: 48.0,
                height: 48.0,
                iconSize: 22.0,
              ),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            );
          }),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const VSpace(16),
            SearchBar(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              updateUserList: (changedList) {
                setState(() {
                  _userList = changedList;
                });
              },
              cubit: _cubit,
              userList: _userList,
            ),
            BlocBuilder<UserCubit, UserState>(
              bloc: _cubit,
              builder: (context, state) {
                if (state is UserLoaded) {
                  List<UserModel> users = state.userList.toList();
                  return Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: users.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return OversightActionsCard(
                            isBudget: false,
                            itemName: users[index].name,
                            menuItemList: [
                              BubbleMenuItem(
                                text: 'Editar',
                                action: () {
                                  UserModel user = users[index];
                                  _userModel = user;

                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => UserPage(
                                      user: _userModel,
                                      formMode: FormMode.update,
                                    ),
                                  ));
                                },
                              ),
                              BubbleMenuItem(
                                text: 'Deletar',
                                action: () {
                                  _cubit.deleteUser(
                                    users[index].id.toString(),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  );
                }
                if (state is UserSkeletonLoading) {
                  List<UserModel> users = state.userList.toList();
                  return Skeletonizer(
                    enabled: true,
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: users.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return OversightActionsCard(
                              isBudget: false,
                              itemName: users[index].name,
                              menuItemList: [
                                BubbleMenuItem(
                                  text: 'Edit',
                                  action: () {},
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }
                return const Padding(
                  padding: EdgeInsets.only(top: 64.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: OversightColors.black,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  const UserPage(formMode: FormMode.create),
            ),
          );
        },
        tooltip: 'Add',
        backgroundColor: OversightColors.primaryCian,
        child: const Icon(
          Icons.add,
          color: OversightColors.white,
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  final UserCubit cubit;
  final List<UserModel> userList;
  final Function(List<UserModel>) updateUserList;
  final EdgeInsets padding;

  const SearchBar({
    Key? key,
    required this.cubit,
    required this.userList,
    required this.updateUserList,
    required this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      bloc: cubit,
      listener: (context, state) {
        if (state is UserLoaded && userList.isEmpty) {
          updateUserList(state.userList);
        }
        if (state is UserListChanged) {
          updateUserList(state.userList);
        }
      },
      child: Padding(
        padding: padding,
        child: OversightInputSearch(
          placeholder: 'Buscar Usuários',
          style: const OversightInputSearchStyle(
            height: 48,
          ),
          onQueryChanged: (value) {
            cubit.filter(userList, value);
          },
        ),
      ),
    );
  }
}
