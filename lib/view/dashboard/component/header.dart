import 'package:fitfoot_web/view/dashboard/component/portfolio.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../responsive.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Dashboard',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(
          width: 30,
        ),
        Spacer(
          flex: Responsive.isDesktop(context) ? 2 : 1,
        ),
        // Container(
        //   margin:  const EdgeInsets.only(left: defaultPadding),
        //   padding:const EdgeInsets.symmetric(
        //       horizontal: defaultPadding, vertical: defaultPadding / 2),
        //   decoration: BoxDecoration(
        //       color: secondaryColor,
        //       borderRadius:const BorderRadius.all(Radius.circular(10)),
        //       border: Border.all(color: Colors.white)),
        //   child: const PortfolioCard(),
        // )
      ],
    );
  }
}
