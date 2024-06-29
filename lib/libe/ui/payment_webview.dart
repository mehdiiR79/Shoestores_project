


// class PaymentGatewayScreen extends StatelessWidget {
//   final String bankGatewayUrl;
//   const PaymentGatewayScreen({Key? key, required this.bankGatewayUrl})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return WebView(
//       initialUrl: bankGatewayUrl,
//       javascriptMode: JavascriptMode.unrestricted,
//       onPageStarted: (url) {
//         debugPrint('url: $url');
//         final uri = Uri.parse(url);
//         if (uri.pathSegments.contains('checkout') &&
//             uri.host == 'experdevelopers.ir') {
//           final orderId = int.parse(uri.queryParameters['order_id']!);
//           Navigator.of(context).pop();
//           Navigator.of(context).push(
//             MaterialPageRoute(
//                 builder: (context) => PaymentReceiptScreen(
//                       orderId: orderId,
//                     )),
//           );
//         }
//       },
//     );
//   }
// }
