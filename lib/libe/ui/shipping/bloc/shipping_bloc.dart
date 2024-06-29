import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shoestores/libe/common/exceptions.dart';
import 'package:shoestores/libe/data/order.dart';
import 'package:shoestores/libe/data/source/order_data_source.dart';

part 'shipping_event.dart';
part 'shipping_state.dart';

class ShippingBloc extends Bloc<ShippingEvent, ShippingState> {
  final IOrderDataSource orderDataSource;

  ShippingBloc(this.orderDataSource) : super(ShippingInitial()) {
    on<ShippingEvent>((event, emit) async {
      if (event is ShippingSubmit) {
        try {
          emit(ShippingLoading());
          await Future.delayed(const Duration(seconds: 1));
          final result = await orderDataSource.submitOrder(event.params);
          emit(ShippingSuccess(result));
        } catch (e) {
          emit(ShippingError(AppException()));
        }
      }
    });
  }
}
