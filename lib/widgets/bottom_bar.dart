import 'package:fitfoot_web/widgets/responsive.dart';
import 'package:flutter/material.dart';

import 'bottom_bar_column.dart';
import 'info_text.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
  });
  static const Color gradientStartColor = Color(0xff4c1c96);
  static const Color gradientEndColor = Color(0xffff804d);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(0.0)),

          gradient: LinearGradient(
              colors: [
                gradientStartColor,
                gradientEndColor
              ],
              begin: FractionalOffset(0.2, 0.2),
              end: FractionalOffset(1.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
      padding: const EdgeInsets.all(30),
      //color: Colors.blueGrey[900],
      child: Column(
              children: [
              ResponsiveWidget.isSmallScreen(context)?const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BottomBarColumn(
                        heading: 'ABOUT',
                        s1: 'Contact Us',
                        s2: 'About Us',
                        s3: 'Careers',
                      ),

                      BottomBarColumn(
                        heading: 'Help',
                        s1: 'Payment',
                        s2: 'Cancellation',
                        s3: 'FAQ',
                      ),
                      BottomBarColumn(
                        heading: 'Social',
                        s1: 'Twitter',
                        s2: 'Facebook',
                        s3: 'Youtube',
                      ),
                    ],
                  ),
                  // Container(
                  //   color: Colors.white,
                  //   width: double.infinity,
                  //   height: 2,
                  // ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InfoText(
                        type: 'Email',
                        text: 'muneeeb117@gmail.com',
                      ),
                      SizedBox(height: 5),
                      InfoText(
                        type: 'Address',
                        text: '57 Allama Iqbal Avenue',
                      )
                    ],
                  ),
                ],
              ):  Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const BottomBarColumn(
                      heading: 'ABOUT',
                      s1: 'Contact Us',
                      s2: 'About Us',
                      s3: 'Careers',
                    ),
                    const BottomBarColumn(
                      heading: 'Help',
                      s1: 'Payment',
                      s2: 'Cancellation',
                      s3: 'FAQ',
                    ),
                    const BottomBarColumn(
                      heading: 'Social',
                      s1: 'Twitter',
                      s2: 'Facebook',
                      s3: 'Youtube',
                    ),
                    Container(
                      color: Colors.white,
                      width: 2,
                      height: 150,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InfoText(
                          type: 'Email',
                          text: 'muneeeb117@gmail.com',
                        ),
                        SizedBox(height: 5),
                        InfoText(
                          type: 'Address',
                          text: '57 Allama Iqbal Avenue',
                        )
                      ],
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.white,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Copyright © 2023 | Muneeb',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
    );
  }
}
