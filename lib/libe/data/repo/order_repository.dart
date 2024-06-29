
import 'package:shoestores/libe/common/http_client.dart';
import 'package:shoestores/libe/data/order.dart';
import 'package:shoestores/libe/data/payment_receipt.dart';
import 'package:shoestores/libe/data/source/order_data_source.dart';

final orderRepository = OrderRepository(OrderRemoteDataSource(httpClient));

abstract class IOrderRepository extends IOrderDataSource {}

class OrderRepository implements IOrderRepository {
  final IOrderDataSource orderDataSource;

  const OrderRepository(this.orderDataSource);
  @override
  Future<SubmitOrderResult> submitOrder(SubmitOrderParams params) =>
      orderDataSource.submitOrder(params);

  @override
  Future<PaymentReceiptData> getPaymentReceipt(int orderId) =>
      orderDataSource.getPaymentReceipt(orderId);

  @override
  Future<List<OrderEntity>> getOrders() {
    return orderDataSource.getOrders();
  }
}
