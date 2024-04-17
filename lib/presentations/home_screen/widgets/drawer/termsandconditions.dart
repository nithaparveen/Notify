import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../global_widget/color_constants.dart';
import '../../../../global_widget/global_textstyles.dart';

class TermsAndConditionScreen extends StatefulWidget {
  const TermsAndConditionScreen({super.key});

  @override
  State<TermsAndConditionScreen> createState() =>
      _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {
  final descriptionstyle =
  GoogleFonts.poppins(color: textcolorlight, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolorlight,
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
          'Terms and Conditions',
          style: maintextdark,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: primarycolorlight,
                    borderRadius: BorderRadius.circular(20),
                    gradient:
                    LinearGradient(colors: [Color(0xffAF8260), Color(0xff803D3B)]),
                    border: Border.all(
                      color: primarycolordark,
                      width: 3,
                    )),
                width: MediaQuery.of(context).size.width * 0.99,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("1. Introduction", style: maintextlight),
                      Text(
                        '1.1 Welcome to NOTELY the App. By using our App, you agree to comply with and be bound by these terms and conditions.',
                        style: descriptionstyle,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("2. Use of the App", style: maintextlight),
                      Text(
                        '2.1 You must be at least 13 years old to use this App.\n2.2 You are responsible for maintaining the confidentiality of your account and password.\n2.3 You agree not to use the App for any illegal or unauthorized purpose.',
                        style: descriptionstyle,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("3. User Content", style: maintextlight),
                      Text(
                        '3.1 Users may post content, such as notes and tasks. You retain ownership of your content.\n3.2 By posting content, you grant My Company a non-exclusive, transferable, sub-licensable, royalty-free, worldwide license to use, modify, publicly perform, publicly display, reproduce, and distribute such content on and through the App.',
                        style: descriptionstyle,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("4. Limitation of Liability", style: maintextlight),
                      Text(
                        '4.1 We are not liable for any direct, indirect, incidental, special, or consequential damages resulting from the use or inability to use the App.',
                        style: descriptionstyle,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("5. Changes to Terms", style: maintextlight),
                      Text(
                        '5.1 We reserve the right to update or modify these terms and conditions at any time without prior notice.',
                        style: descriptionstyle,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("6. Governing Law", style: maintextlight),
                      Text(
                        '6.1 These terms and conditions are governed by and construed in accordance with the laws of [Your Country/Jurisdiction].',
                        style: descriptionstyle,
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}