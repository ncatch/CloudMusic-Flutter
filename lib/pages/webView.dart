/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-08 10:45:51
 * @LastEditTime: 2021-05-08 11:15:29
 * @LastEditors: Walker
 */
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewComponent extends StatefulWidget {
  final String url;

  WebViewComponent({Key? key, required this.url}) : super(key: key);

  @override
  WebViewState createState() => WebViewState();
}

class WebViewState extends State<WebViewComponent> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    try {
      if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    } catch (e) {
      SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebView(
        initialUrl: widget.url,
      ),
    );
  }
}
