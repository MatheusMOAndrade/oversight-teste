import 'package:oversight/stores/budget_service/budget_service_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../navigation/navigation.dart';
import '../../../service/budget_service/models/buget_service_model.dart';
import '../../../service/budgets/models/budget_model.dart';
import '../../../service/company/models/company_model.dart';
import '../../../service/customer/models/customer_model.dart';
import '../../../service/mailer/models/budget_service_mailer_model.dart';
import '../../../service/mailer/models/mailer_model.dart';
import '../../../service/oversight_services/models/oversight_service_model.dart';
import '../../../themes/oversight_colors.dart';

import '../../../themes/oversight_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../use_cases/company_use_case.dart';
import '../../widgets/widgets.dart';
import 'components/service_selection_flow.dart';

class BudgetServicesPage extends StatefulWidget {
  final String budgetId;
  final String customerId;
  final BudgetModel budgetModel;

  const BudgetServicesPage({
    super.key,
    required this.budgetId,
    required this.customerId,
    required this.budgetModel,
  });

  @override
  State<BudgetServicesPage> createState() => _BudgetServicesPageState();
}

class _BudgetServicesPageState extends State<BudgetServicesPage> {
  late final BudgetServiceCubit _cubit;

  List<BudgetServiceMailerModel> budgetServiceMailerList = [];

  @override
  void initState() {
    _cubit = GetIt.I.get();
    _cubit.init(
      widget.budgetId,
      widget.customerId,
    );

    super.initState();
  }

  var _messageToken = '';

  List<ServiceModel> getBudgetServices(
    List<ServiceModel> budgetServices,
  ) {
    return budgetServices.toList();
  }

  List<BudgetServiceModel>? getBudgetServicesModels(
    List<BudgetServiceModel>? budgetServicesModels,
  ) {
    return budgetServicesModels?.toList();
  }

  int getBudgetServiceQuantity(
    ServiceModel budgetServices,
    List<BudgetServiceModel>? budgetServiceModels,
  ) {
    bool isEqual = budgetServiceModels
            ?.any((element) => element.serviceId == budgetServices.id) ??
        false;

    BudgetServiceModel? budgetServiceModel = budgetServiceModels
        ?.firstWhere((element) => element.serviceId == budgetServices.id);

    if (isEqual) {
      return budgetServiceModel!.quantity;
    }

    return 1;
  }

  String convertServicesToHTML(List<BudgetServiceMailerModel> budgetServices) {
    String htmlContent = '';
    for (var service in budgetServices) {
      htmlContent += '<p>${service.name}</p>\n';
      htmlContent += '<p>Valor unitário: ${service.value} reais</p>\n';
      htmlContent += '<p>Quantidade: ${service.quantity}</p>\n';
    }
    return htmlContent;
  }

  @override
  Widget build(BuildContext context) {
    final String budgetName = widget.budgetModel.name;
    final String budgetDescription = widget.budgetModel.description;

    return Scaffold(
      backgroundColor: OversightColors.cultured,
      appBar: OversightAppBar(
        style: const OversightAppBarStyle(
          backgroundColor: OversightColors.cultured,
          elevation: 2,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Serviços do orçamento',
              style: OversightTextStyles.kBodyStrong.copyWith(
                color: OversightColors.primaryCian,
                fontSize: 23,
              ),
            ),
            IconButton(
              onPressed: () async {
                bool result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => ServiceSelectionFlow(
                      budgetId: widget.budgetId,
                      budgetModel: widget.budgetModel,
                    ),
                  ),
                );

                if (result) {
                  _cubit.init(
                    widget.budgetId,
                    widget.customerId,
                  );
                }
              },
              icon: const Icon(
                color: OversightColors.primaryCian,
                Icons.add,
                size: 30,
              ),
            ),
          ],
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Color.fromRGBO(56, 163, 165, 1),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VSpace(16),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DetailsExpandedCard(
                    title: 'Detalhes do orçamento',
                    details: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Título: $budgetName',
                                style: OversightTextStyles.kBodyStrong.copyWith(
                                  fontSize: 16,
                                  color: OversightColors.primaryCian,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                'Descrição: $budgetDescription',
                                style: OversightTextStyles.kBodyStrong.copyWith(
                                  fontSize: 16,
                                  color: OversightColors.primaryCian,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              BlocBuilder<BudgetServiceCubit,
                                  BudgetServiceState>(
                                bloc: _cubit,
                                builder: (context, state) {
                                  if (state is BudgetServiceLoaded) {
                                    double budgetValue = state.budgetSum! *
                                        (1 +
                                            widget.budgetModel.incomingMargin /
                                                100);

                                    String formattedBudgetValue =
                                        budgetValue.toStringAsFixed(2);

                                    return Text(
                                      'Valor total: R\$ $formattedBudgetValue',
                                      style: OversightTextStyles.kBodyStrong
                                          .copyWith(
                                        fontSize: 16,
                                        color: OversightColors.primaryCian,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    );
                                  }

                                  return const SizedBox();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  color: OversightColors.primaryCian,
                  thickness: 1,
                ),
                const VSpace(16),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Text(
                    'Serviços adicionados',
                    style: OversightTextStyles.kBodyStrong.copyWith(
                      fontSize: 20,
                      color: OversightColors.primaryCian,
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: BlocBuilder<BudgetServiceCubit, BudgetServiceState>(
                      bloc: _cubit,
                      builder: (context, state) {
                        if (state is BudgetServiceLoaded) {
                          List<ServiceModel> budgetServices = getBudgetServices(
                            state.matchedServiceList,
                          );

                          List<BudgetServiceModel>? budgetServiceModels =
                              getBudgetServicesModels(
                            state.budgetServiceModel,
                          );

                          return Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: budgetServices.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return OversightActionsCard(
                                    isBudget: false,
                                    itemName: budgetServices[index].name,
                                    quantity: getBudgetServiceQuantity(
                                      budgetServices[index],
                                      budgetServiceModels,
                                    ),
                                    price: budgetServices[index].value,
                                    menuItemList: [
                                      BubbleMenuItem(
                                        text: 'Delete',
                                        action: () {
                                          _cubit.deleteBudgetService(
                                            widget.budgetId,
                                            budgetServices[index].id.toString(),
                                          );

                                          _cubit.init(
                                            widget.budgetId,
                                            widget.customerId,
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

                        if (state is BudgetServiceSkeletonLoading) {
                          List<ServiceModel> budgetServices = getBudgetServices(
                            state.matchedServiceList,
                          );

                          return Skeletonizer(
                            enabled: true,
                            child: Column(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: budgetServices.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return OversightActionsCard(
                                      isBudget: false,
                                      itemName: budgetServices[index].name,
                                      quantity: 0,
                                      price: 1000,
                                      createdAt: 'XX/XX/XXXX',
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
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<BudgetServiceCubit, BudgetServiceState>(
            bloc: _cubit,
            builder: (context, state) {
              return OversightButton(
                title: 'Enviar e-mail para o cliente',
                isLoading: false,
                responsiveText: true,
                iconPosition: IconPosition.left,
                onPressed: () async {
                  OversightAlert().showOversightAlert(
                    context,
                    title: 'Deseja enviar o orçamento?',
                    mainButtonTitle: 'Enviar',
                    secondaryButtonTitle: 'Voltar',
                    body: const VSpace(20),
                    mainButtonAction: () async {
                      if (state is BudgetServiceLoaded) {
                        List<ServiceModel> budgetServices = getBudgetServices(
                          state.matchedServiceList,
                        );

                        List<BudgetServiceModel>? budgetServiceModels =
                            getBudgetServicesModels(
                          state.budgetServiceModel,
                        );

                        CustomerModel customer =
                            state.relatedCustomerModel ?? const CustomerModel();

                        CompanyModel company =
                            state.relatedCompanyModel ?? const CompanyModel();

                        getBudgetMailerModel(
                            budgetServices, budgetServiceModels);

                        String budgetServiceToHTML =
                            convertServicesToHTML(budgetServiceMailerList);

                        double budgetValue = state.budgetSum! *
                            (1 + widget.budgetModel.incomingMargin / 100);

                        String formattedBudgetValue =
                            budgetValue.toStringAsFixed(2);

                        _messageToken = await _cubit.getToken(widget.budgetId);

                        String htmlTemp = htmlTemplate(
                            budgetServiceToHTML,
                            budgetName,
                            budgetDescription,
                            formattedBudgetValue,
                            _messageToken);

                        //print(htmlTemp);

                        String html = escapeHtmlTags(htmlTemp);

                        print(html);

                        //Add other parameters

                        MailerModel mailerModel = MailerModel(
                          html: htmlTemp,
                          from: company.email,
                          subject: 'Orçamento $budgetName',
                          text: '',
                          to: customer.email,
                        );

                        await _cubit.postMail(mailerModel);

                        navigator?.pop();

                        _cubit.init(
                          widget.budgetId,
                          widget.customerId,
                        );
                      }
                    },
                    secondaryButtonAction: () => Navigator.of(context).pop(),
                  );
                },
                style: OversightButtonStyle(
                  textStyle: OversightTextStyles.kBodyStrong.copyWith(
                    fontSize: 16,
                  ),
                  backgroundColor: OversightColors.secondaryCian,
                  width: 350,
                ),
              );
            },
          ),
          const VSpace(25)
        ],
      ),
    );
  }

  void getBudgetMailerModel(List<ServiceModel> budgetServices,
      List<BudgetServiceModel>? budgetServiceModels) {
    for (var service in budgetServices) {
      BudgetServiceMailerModel budgetServiceMailerModel =
          BudgetServiceMailerModel(
        name: service.name,
        quantity: getBudgetServiceQuantity(
          service,
          budgetServiceModels,
        ).toString(),
        value: service.value.toString(),
      );
      budgetServiceMailerList.add(budgetServiceMailerModel);
    }
  }

  String htmlTemplate(
    String budgetServiceToHTML,
    String budgetName,
    String budgetDescription,
    String budgetValue,
    String messageToken,
  ) {
    String htmlContent = '''

  <!DOCTYPE html>
  <html>
  <head>
    <style>
    body {
        height: 842px;
        width: 595px;
        margin-left: auto;
        margin-right: auto;
    }
    </style>
  </head>
  <body>

  <h2>$budgetName</h2>

  <h3>Descrição: </h3>
  <p>$budgetDescription</p>

  <h3>Serviços do orçamento:</h3>

  $budgetServiceToHTML

  </br>
  </br>
  <h3>Valor final:</h3>
  <p>$budgetValue reais</p>

  <p id="acceptButton">Aceitar Orçamento</p>
  http://0.0.0.0/mail?message-token=$messageToken&approved=true

  <br/>
  <br/>
  <p id="declineButton">Recusar Orçamento</p>
  http://0.0.0.0/mail?message-token=$messageToken&approved=false

  </body>
  </html>
 ''';

    return htmlContent;
  }

  String escapeHtmlTags(String input) {
    return input.replaceAll('<', r'\<').replaceAll('>', r'\>');
  }
}
