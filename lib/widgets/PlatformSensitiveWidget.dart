import 'dart:io';

import 'package:flutter/cupertino.dart';

abstract class PlatformSensitiveWidget extends StatelessWidget{
  Widget buildAndroidWidget(BuildContext context);
    Widget buildIosWidget(BuildContext context);
    @override
  Widget build(BuildContext context) {
    if(Platform.isIOS)
    return buildIosWidget(context);
    else return buildAndroidWidget(context);
    
  }

}