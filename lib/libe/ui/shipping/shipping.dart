import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoestores/libe/data/order.dart';
import 'package:shoestores/libe/data/repo/order_repository.dart';
import 'package:shoestores/libe/ui/cart/price_info.dart';
import 'package:shoestores/libe/ui/receipt/payment_receipt.dart';
import 'package:shoestores/libe/ui/shipping/bloc/shipping_bloc.dart';
import 'package:shoestores/libe/ui/widgets/empty_view.dart';


class ShippingScreen extends StatefulWidget {
  final int payablePrice;
  final int shippingCost;
  final int totalPrice;

  const ShippingScreen(
      {Key? key,
      required this.payablePrice,
      required this.shippingCost,
      required this.totalPrice})
      : super(key: key);

  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  StreamSubscription? subscription;
  final firstNameController = TextEditingController(text: 'سعید');
  final lastNameController = TextEditingController(text: 'شاهینی');
  final phoneNumberController = TextEditingController(text: '09123445678');
  final postalCodeController = TextEditingController(text: '1234567890');
  final addressController = TextEditingController(
      text: 'سعادت آباد، میدان کاج، خیابان مروارید، پلاک ۱۳');

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تحویل گیرنده'),
        centerTitle: false,
      ),
      body: BlocProvider<ShippingBloc>(
        create: (context) {
          final bloc = ShippingBloc(orderRepository);
          subscription = bloc.stream.listen((event) {
            if (event is ShippingSuccess) {
              if (event.data.bankGatewayUrl.isNotEmpty) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => 
                        // PaymentGatewayScreen(
                        //       bankGatewayUrl: event.data.bankGatewayUrl,
                        //     )
                        EmptyView(message: "", image:Container())
                            ));
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentReceiptScreen(
                      orderId: event.data.orderId,
                    ),
                  ),
                );
              }
            } else if (event is ShippingError) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(event.exception.message)));
            }
          });
          return bloc;
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: firstNameController,
                decoration: const InputDecoration(label: Text('نام')),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: lastNameController,
                decoration: const InputDecoration(label: Text('نام خانوادگی')),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: phoneNumberController,
                decoration: const InputDecoration(label: Text('شماره تماس')),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: postalCodeController,
                decoration: const InputDecoration(label: Text('کد پستی')),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(label: Text('آدرس')),
              ),
              const SizedBox(
                height: 12,
              ),
              PriceInfo(
                  payablePrice: widget.payablePrice,
                  shippingCost: widget.shippingCost,
                  totalPrice: widget.totalPrice),
              BlocBuilder<ShippingBloc, ShippingState>(
                builder: (context, state) {
                  return state is ShippingLoading
                      ? const Center(
                          child: CupertinoActivityIndicator(),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OutlinedButton(
                                onPressed: () {
                                  BlocProvider.of<ShippingBloc>(context)
                                      .add(ShippingSubmit(
                                    SubmitOrderParams(
                                        firstNameController.text,
                                        lastNameController.text,
                                        postalCodeController.text,
                                        phoneNumberController.text,
                                        addressController.text,
                                        PaymentMethod.cashOnDelivery),
                                  ));
                                },
                                child: const Text('پرداخت در محل')),
                            const SizedBox(
                              width: 16,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<ShippingBloc>(context)
                                    .add(ShippingSubmit(
                                  SubmitOrderParams(
                                      firstNameController.text,
                                      lastNameController.text,
                                      postalCodeController.text,
                                      phoneNumberController.text,
                                      addressController.text,
                                      PaymentMethod.online),
                                ));
                              },
                              child: const Text('پرداخت اینترنتی'),
                            ),
                          ],
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
