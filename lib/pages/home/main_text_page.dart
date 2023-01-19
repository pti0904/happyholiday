import 'package:flutter/material.dart';
import 'package:happyholiday/pages/home/text_page_body.dart';
import 'package:happyholiday/pages/home/text_with_map.dart';
import 'package:happyholiday/utils/dimensions.dart';
import 'package:happyholiday/widgets/big_text.dart';
import 'package:happyholiday/widgets/small_text.dart';
import 'package:happyholiday/utils/colors.dart';
import 'package:happyholiday/intersitital_helper.dart';

class MainTextPage extends StatefulWidget {
  const MainTextPage({Key? key}) : super(key: key);

  @override
  State<MainTextPage> createState() => _MainTextPageState();

}

class _MainTextPageState extends State<MainTextPage> {
  InterstitialHelper adsMobHelper = InterstitialHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.height10*6, bottom: Dimensions.height10/2),
              padding: EdgeInsets.only(left: Dimensions.width10*2, right: Dimensions.width10*2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      BigText(text: "설날", color: AppColors.mainColor, size: Dimensions.font26,),
                      Row(
                        children: [
                          SmallText(text: "추후업데이트", color: Colors.black54),
                          Icon(Icons.arrow_drop_down_rounded)
                        ],
                      )
                    ],
                  ),
                  BigText(text: "새해복 많이 받으세요♥", color: Colors.black),
                ],
              ),
            ),
          ),
          Expanded(child: SingleChildScrollView(
            child: TextPageBody())),
        ],
      )


    );
  }


}