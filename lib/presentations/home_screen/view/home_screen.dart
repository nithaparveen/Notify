import 'package:flutter/material.dart';
import 'package:notify/global_widget/global_appbar.dart';

import '../../../global_widget/global_textstyles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlAppbar(title: 'Notify' , titleTextStyle: GLTextStyles.mainfont,),
    );
  }
}
