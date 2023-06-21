import 'package:ecommerce/app/functions.dart';
import 'package:ecommerce/config/urls.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PayPalPaymentScreen extends StatefulWidget {
  const PayPalPaymentScreen({
    super.key,
    required this.orderId,
  });

  final String? orderId;

  @override
  // ignore: library_private_types_in_public_api
  _PayPalPaymentScreenState createState() => _PayPalPaymentScreenState();
}

class _PayPalPaymentScreenState extends State<PayPalPaymentScreen> {
  late WebViewController _webViewController;
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PayPal Payment'),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: '${Urls.baseUrl}${Urls.pay}?orderId=${widget.orderId}',
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (String url) {
              if (url.contains('/success')) {
                print('Yes');
                popScreen(context);
              }
              setState(() {
                _isLoading = false;
              });
            },
            onWebViewCreated: (WebViewController controller) {
              _webViewController = controller;
            },
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            _isLoading = true;
          });
          _webViewController.reload();
        },
      ),
    );
  }
}
