import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../themes/oversight_colors.dart';
import '../../../../themes/oversight_text_styles.dart';
import 'package:flutter/material.dart';

import '../../../navigation/enums/form_modes.dart';
import '../../../service/oversight_services/models/oversight_service_model.dart';
import '../../../stores/service/service_cubit.dart';
import '../../widgets/widgets.dart';
import 'oversight_service_creation_service.dart';

class OversightServicesPage extends StatefulWidget {
  const OversightServicesPage({super.key});

  @override
  State<OversightServicesPage> createState() => _OversightServicesPageState();
}

class _OversightServicesPageState extends State<OversightServicesPage> {
  late final ServiceCubit _cubit;

  ServiceModel _serviceModel = const ServiceModel();

  List<ServiceModel> _servicesList = <ServiceModel>[];

  List<ServiceModel> getServiceList(List<ServiceModel> serviceList) {
    return serviceList.toList();
  }

  @override
  void initState() {
    _cubit = GetIt.I.get();
    _cubit.init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OversightAppBar(
        style: const OversightAppBarStyle(
          backgroundColor: OversightColors.cultured,
          elevation: 2,
        ),
        title: Text(
          'Serviços',
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
              updateServiceList: (changedList) {
                setState(() {
                  _servicesList = changedList;
                });
              },
              cubit: _cubit,
              serviceList: _servicesList,
            ),
            BlocBuilder<ServiceCubit, ServiceState>(
              bloc: _cubit,
              builder: (context, state) {
                if (state is ServiceLoaded) {
                  List<ServiceModel> services = getServiceList(
                    state.serviceList,
                  );

                  return _buildList(services);
                }

                if (state is ServiceSkeletonLoading) {
                  List<ServiceModel> services = getServiceList(
                    state.serviceList,
                  );

                  return Skeletonizer(
                    enabled: true,
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: services.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return OversightActionsCard(
                              isBudget: false,
                              itemName: services[index].name,
                              quantity: 0,
                              price: 1000,
                              menuItemList: [
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
              builder: (BuildContext context) => ServiceCreation(
                onRedirectAction: () {
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

  Widget _buildList(List<ServiceModel> services) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: services.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return OversightActionsCard(
              isBudget: false,
              itemName: services[index].name,
              // createdAt: services[index]
              //     .createdAt
              //     .split('T')[0]
              //     .split('-')
              //     .reversed
              //     .join('/'),
              menuItemList: [
                BubbleMenuItem(
                  text: 'Edit',
                  action: () {
                    ServiceModel service = services[index];

                    _serviceModel = service;

                    // _addressModel = addressList.firstWhere(
                    //   (element) =>
                    //       element.serviceId == _serviceModel.id,
                    // );

                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (BuildContext context) =>
                    //         ServiceCreation(
                    //       service: _serviceModel,
                    //       serviceId:
                    //           services[index].id.toString(),
                    //       formMode: FormMode.update,
                    //     ),
                    //   ),
                    // );
                  },
                ),
                BubbleMenuItem(
                  text: 'Delete',
                  action: () {
                    _cubit.deleteService(
                      services[index].id.toString(),
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
}

class SearchBar extends StatelessWidget {
  final ServiceCubit cubit;
  final List<ServiceModel> serviceList;
  final Function(List<ServiceModel>) updateServiceList;
  final EdgeInsets padding;

  const SearchBar({
    Key? key,
    required this.cubit,
    required this.serviceList,
    required this.updateServiceList,
    required this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ServiceCubit, ServiceState>(
      bloc: cubit,
      listener: (context, state) {
        if (state is ServiceLoaded && serviceList.isEmpty) {
          updateServiceList(state.serviceList);
        }
        if (state is ServiceListChanged) {
          updateServiceList(state.serviceList);
        }
      },
      child: Padding(
        padding: padding,
        child: OversightInputSearch(
          placeholder: 'Buscar serviços',
          style: const OversightInputSearchStyle(
            height: 48,
          ),
          onQueryChanged: (value) {
            cubit.filter(serviceList, value);
          },
        ),
      ),
    );
  }
}
