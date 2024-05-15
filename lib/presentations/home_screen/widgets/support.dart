import 'package:flutter/material.dart';


import '../../../core/constants/color_constants.dart';
import '../../../core/constants/global_textstyles.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: primarycolordark,
          ),
        ),
        backgroundColor: bgcolor,
        centerTitle: true,
        title: Text(
          'Support',
          style: maintextdark,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: primarycolorlight,
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(colors: [Color(0xffAF8260), Color(0xff803D3B)]),
                  border: Border.all(
                    color: primarycolordark,
                    width: 3,
                  )),
              width: MediaQuery.of(context).size.width * 0.95,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text("Contact Information", style: maintextlight),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.email_outlined,
                          color: primarycolorlight,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'contact@luminartecnolab.com',
                          style: subtextlight,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}