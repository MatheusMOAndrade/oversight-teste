import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../service/budget_service/models/buget_service_model.dart';
import '../../../../service/oversight_services/models/oversight_service_model.dart';
import '../../../../stores/service/service_cubit.dart';
import '../../../../themes/oversight_colors.dart';
import '../../../../themes/oversight_text_styles.dart';
import '../../../widgets/widgets.dart';

class ServiceSelectionPage extends StatefulWidget {
  final List<BudgetServiceModel> selectedBudgetServices;
  final List<ServiceModel> selectedServices;
  final VoidCallback onNextPage;

  const ServiceSelectionPage({
    required this.selectedBudgetServices,
    required this.selectedServices,
    required this.onNextPage,
    super.key,
  });

  @override
  State<ServiceSelectionPage> createState() => _ServiceSelectionPageState();
}

class _ServiceSelectionPageState extends State<ServiceSelectionPage>
    with AutomaticKeepAliveClientMixin<ServiceSelectionPage> {
  late final ServiceCubit _serviceCubit;

  @override
  void initState() {
    _serviceCubit = GetIt.I.get();
    _serviceCubit.init();

    super.initState();
  }

  List<ServiceModel> getServiceList(List<ServiceModel> serviceList) {
    return serviceList.toList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        const VSpace(20),
        BlocBuilder<ServiceCubit, ServiceState>(
          bloc: _serviceCubit,
          builder: (context, state) {
            if (state is ServiceLoaded) {
              List<ServiceModel> services = getServiceList(
                state.serviceList,
              );

              return Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: services.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return OversightSelectionCard(
                            itemName: services[index].name,
                            details: services[index].value.toString(),
                            onCheck: (isChecked) {
                              if (isChecked) {
                                widget.selectedServices.add(services[index]);

                                widget.selectedBudgetServices.add(
                                  BudgetServiceModel(
                                    serviceId: services[index].id,
                                    quantity: 1,
                                    budgetedUnitValue:
                                        services[index].value.toDouble(),
                                  ),
                                );
                              } else {
                                widget.selectedServices.remove(services[index]);

                                widget.selectedBudgetServices.remove(
                                  BudgetServiceModel(
                                    serviceId: services[index].id,
                                    quantity: 1,
                                    budgetedUnitValue:
                                        services[index].value.toDouble(),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
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
        const VSpace(20),
        OversightButton(
          title: 'Próxima',
          isLoading: false,
          responsiveText: true,
          iconPosition: IconPosition.left,
          onPressed: widget.onNextPage,
          style: OversightButtonStyle(
            textStyle: OversightTextStyles.kBodyStrong.copyWith(
              fontSize: 16,
            ),
            backgroundColor: OversightColors.primaryCian,
            width: 350,
          ),
        ),
        const VSpace(20),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
