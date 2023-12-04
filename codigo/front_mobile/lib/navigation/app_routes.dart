import 'dart:developer';

import 'package:oversight/presentation/pages/budgets/budgets_list_page.dart';
import 'package:oversight/presentation/pages/users/user_list_page.dart';
import 'package:oversight/presentation/pages/users/user_page.dart';
import 'package:oversight/service/budgets/models/budgets_tab_model.dart';
import 'package:oversight/service/user/models/user_tab_model.dart';

import '../../../presentation/pages/customers/customer_list_page.dart';
import '../../../presentation/pages/home/home_page.dart';
import '../../../presentation/pages/login/login_page.dart';
import '../../../presentation/pages/oversight_services/oversight_services_page.dart';

import '../../../service/customer/models/customer_tab_model.dart';
import '../../../service/oversight_services/models/oversight_services_tab_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../api/endpoints.dart';
import '../presentation/pages/customers/customer_creation_page.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  Endpoints.login: (_) => const LoginPage(),
  Endpoints.home: (context) => const HomePage(
        tabs: [
          CustomerTabModel(
            tab: CustomerList(),
          ),
          BudgetsTabModel(
            tab: BudgetsListPage(),
          ),
          OversightServicesTabModel(
            tab: OversightServicesPage(),
          ),
          OversightUserTabModel(
            tab: UserList(),
          )
        ],
      ),
  Endpoints.customers: (_) => const CustomerCreation(),
  Endpoints.users: (_) => const UserPage(),
}.map((key, value) {
  return MapEntry(key, (BuildContext context) {
    if (kDebugMode) log('route $key');
    return value(context);
  });
});
