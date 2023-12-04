import '../../api/dio_client.dart';
import '../../api/endpoints.dart';
import '../../di/locator.dart';
import '../../../service/customer/models/customer_model.dart';
import '../../../service/user/cache_service.dart';
import 'package:dio/dio.dart';

abstract class ICustomerService {
  Future<List<CustomerModel>> getCustomerList();

  Future<void> addCustomer(CustomerModel customer);

  Future<void> deleteCustomer(String id);

  Future<void> editCustomer(CustomerModel customer, String id);
}

class CustomerService implements ICustomerService {
  final DioClient dioClient = locator.get<DioClient>();
  final CacheService cacheService = locator.get<CacheService>();

  @override
  Future<List<CustomerModel>> getCustomerList() async {
    final token = await cacheService.getData(key: "token");

    final query = await dioClient.get(
      Endpoints.customers,
      options: Options(
        headers: {
          "session-token": token,
        },
      ),
    );

    final jsonData = query.data["data"] as List;

    final list = jsonData
        .map(
          (customer) => CustomerModel.fromJson(customer),
        )
        .toList();

    return list;
  }

  @override
  Future<void> addCustomer(CustomerModel customer) async {
    final token = await cacheService.getData(key: "token");

    final query = await dioClient.post(
      Endpoints.customers,
      data: customer.toJson(),
      options: Options(
        headers: {
          "session-token": token,
        },
      ),
    );

    await cacheService.deleteData(key: "customerId");
    await cacheService.saveData(
        key: "customerId", value: query.data["data"]["id"]);
  }

  @override
  Future<void> deleteCustomer(String id) async {
    final token = await cacheService.getData(key: "token");

    await dioClient.delete(
      '${Endpoints.customers}/$id',
      options: Options(
        headers: {
          "session-token": token,
        },
      ),
    );
  }

  @override
  Future<void> editCustomer(CustomerModel customer, String id) async {
    final token = await cacheService.getData(key: "token");

    await dioClient.put(
      '${Endpoints.customers}/$id',
      data: customer.toJson(),
      options: Options(
        headers: {
          "session-token": token,
        },
      ),
    );

    await cacheService.deleteData(key: "customerId");
    await cacheService.saveData(key: "customerId", value: id);
  }

  Future<bool> checkCustomerEmailExist(String customerEmail) async {
    final token = await cacheService.getData(key: "token");

    final query = await dioClient.get(
      Endpoints.customers,
      options: Options(
        headers: {
          "session-token": token,
        },
      ),
    );

    final requiredId = (query.data["data"] as List)
        .where((element) => element == customerEmail);

    return requiredId.isNotEmpty;
  }

  Future<String> getStreetByCep(String cep) async {
    final query = await dioClient.get(
      "https://viacep.com.br/ws/$cep/json/",
    );

    return query.data["logradouro"];
  }

  Future<void> callCustomerDamageControl(String customerId) async {
    print("damage control");
    final token = await cacheService.getData(key: "token");
    var url =
        'https://wuywp32168.execute-api.us-east-1.amazonaws.com/triggerLambda/CustomerDamageControl';

    try {
      var response = await dioClient.post(
        url,
        data: {
          'session-token': token,
          'customer-id': customerId,
        },
        options: Options(
          headers: {"Access-Control-Allow-Origin": "*"},
        ),
      );

      if (response.statusCode == 200) {
        print('Request successful');
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Request error: $e');
    }
  }
}
