import 'package:oversight/presentation/pages/customers/customer_creation_page.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../navigation/enums/form_modes.dart';
import '../../../navigation/navigation.dart';
import '../../../service/address/models/address_model.dart';
import '../../../service/customer/models/customer_model.dart';
import '../../../stores/address/address_cubit.dart';
import '../../../stores/customer/customer_cubit.dart';

import '../../../../themes/oversight_colors.dart';

import '../../../../themes/oversight_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../widgets/widgets.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({super.key});

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  late final CustomerCubit _cubit;
  late final AddressCubit _addressCubit;

  CustomerModel _customerModel = const CustomerModel();

  List<CustomerModel> _customerList = <CustomerModel>[];

  @override
  void initState() {
    _cubit = GetIt.I.get();
    _cubit.init();

    _addressCubit = GetIt.I.get();
    _addressCubit.init();

    super.initState();
  }

  void showCustomerEmailExistSnackbar() {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Current Customer Email already exist.'),
      ),
    );
  }

  List<Map<String, dynamic>> toMap(List<CustomerModel> customers) {
    List<Map<String, String>> list;

    list = customers.map((customer) {
      return {
        "name": customer.name,
      };
    }).toList();

    return list;
  }

  List<CustomerModel> getCustomerList(List<CustomerModel> customerList) {
    return customerList.toList();
  }

  List<AddressModel> getAddressList(List<AddressModel> addressList) {
    return addressList.toList();
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
          'Clientes',
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
              updateCustomerList: (changedList) {
                setState(() {
                  _customerList = changedList;
                });
              },
              cubit: _cubit,
              customerList: _customerList,
            ),
            BlocBuilder<CustomerCubit, CustomerState>(
              bloc: _cubit,
              builder: (context, state) {
                if (state is CustomerLoaded) {
                  List<CustomerModel> customers = getCustomerList(
                    state.customerList,
                  );
                  List<AddressModel> address = getAddressList(
                    state.addressList ?? [],
                  );

                  return _buildListView(customers, address);
                }

                if (state is CustomerLoadingSkeleton) {
                  List<CustomerModel> customers = getCustomerList(
                    state.customerList,
                  );

                  return _buildSkeleton(customers);
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
        onPressed: () async {
          bool? result = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => CustomerCreation(
                onRedirectAction: () async {
                  setState(() {});
                },
              ),
            ),
          );

          if (result != null) {
            _cubit.init();
          }
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

  Column _buildListView(
    List<CustomerModel> customers,
    List<AddressModel> address,
  ) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: customers.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return OversightActionsCard(
              isBudget: false,
              itemName: customers[index].name,
              createdAt: customers[index]
                  .createdAt
                  .split('T')[0]
                  .split('-')
                  .reversed
                  .join('/'),
              menuItemList: [
                BubbleMenuItem(
                  text: 'Edit',
                  action: () async {
                    CustomerModel customer = customers[index];

                    _customerModel = customer;

                    AddressModel relatedAddress = address.firstWhere(
                      (element) => element.customerId == _customerModel.id,
                    );

                    bool? result = await navigator?.push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => CustomerCreation(
                          customer: _customerModel,
                          address: relatedAddress,
                          customerId: customers[index].id.toString(),
                          formMode: FormMode.update,
                        ),
                      ),
                    );

                    if (result != null) {
                      _cubit.init();
                    }
                  },
                ),
                BubbleMenuItem(
                  text: 'Delete',
                  action: () {
                    _cubit.deleteCustomer(
                      customers[index].id.toString(),
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

  Widget _buildSkeleton(
    List<CustomerModel> customers,
  ) {
    return Skeletonizer(
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: customers.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return OversightActionsCard(
                isBudget: false,
                itemName: customers[index].name,
                createdAt: customers[index]
                    .createdAt
                    .split('T')[0]
                    .split('-')
                    .reversed
                    .join('/'),
                menuItemList: [
                  BubbleMenuItem(text: 'Edit', action: () async {}),
                  BubbleMenuItem(
                    text: 'Delete',
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
}

class SearchBar extends StatelessWidget {
  final CustomerCubit cubit;
  final List<CustomerModel> customerList;
  final Function(List<CustomerModel>) updateCustomerList;
  final EdgeInsets padding;

  const SearchBar({
    Key? key,
    required this.cubit,
    required this.customerList,
    required this.updateCustomerList,
    required this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<CustomerCubit, CustomerState>(
      bloc: cubit,
      listener: (context, state) {
        if (state is CustomerLoaded && customerList.isEmpty) {
          updateCustomerList(state.customerList);
        }
        if (state is CustomerListChanged) {
          updateCustomerList(state.customerList);
        }
      },
      child: Padding(
        padding: padding,
        child: OversightInputSearch(
          placeholder: 'Buscar clientes',
          style: const OversightInputSearchStyle(
            height: 48,
          ),
          onQueryChanged: (value) {
            cubit.filter(customerList, value);
          },
        ),
      ),
    );
  }
}
