//message type에따라 Map 만들기

import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class TextPageBody2 extends StatefulWidget {
  const TextPageBody2({Key? key}) : super(key: key);

  @override
  State<TextPageBody2> createState() => _TextPageBodyState2();
}

class _TextPageBodyState2 extends State<TextPageBody2> {
  static const menuItems = <String>['반말', '극존대', '존대말'];
  final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
      .map((String value) =>
      DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      ))
      .toList();
  String? _btn1SelectedVal = '극존대';
  TextEditingController senderController = TextEditingController();
  TextEditingController receiverController = TextEditingController();
  String? hello;
  String? body;
  String? goodbye;
  String? fullText;
  List<TextSpan> spans = [];


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,

      child: Container(
        height: Dimensions.height10 * 90,
        color: Colors.grey[100],
        child: Column(

          children: [


            Container(

              margin: EdgeInsets.only(
                left: Dimensions.width10 * 2,
                right: Dimensions.width10 * 2,
              ),

              padding: EdgeInsets.all(Dimensions.width10 * 1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.width15),
                border: Border.all(color: AppColors.mainColor, width: 2),
                color: Colors.white,
              ),
              child: TextField(
                controller: senderController,
                decoration: InputDecoration(labelText: "보내는이", ),
              ),
            ),

            Container(margin: EdgeInsets.only(
                left: Dimensions.width10 * 2,
                right: Dimensions.width10 * 2,
                top: Dimensions.height10 ),

              padding: EdgeInsets.all(Dimensions.width10 * 1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.width15),
                border: Border.all(color: AppColors.mainColor, width: 2),
                color: Colors.white,
              ),
              child: TextField(
                controller: receiverController,
                decoration: InputDecoration(labelText: "받는사람"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: Dimensions.width10 * 2,
                  right: Dimensions.width10 * 2,
                  top: Dimensions.height10 ),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.width15),
                border: Border.all(color: AppColors.mainColor,width: 2),
                color: Colors.white,
              ),
              child: ListTile(
                title: SmallText(text: '모드설정: \n(모드를 새로 설정하면 완성본이 나옵니다)',color: Colors.black,),
                trailing: DropdownButton<String>(
                  value: _btn1SelectedVal,
                  onChanged: (String? newValue) {
                    setState(() {

                      _btn1SelectedVal = newValue;
                      if (_btn1SelectedVal == '극존대') {
                        hello = '님!!\n';
                        body =
                        '다사다난했던 2022년 한해가 \n저물어가고 있습니다. \n다가오는 2023년 새해에도 늘 건강하심과 \n더불어 희망찬 새해를 맞이하여 가내 두루 \n평안하시고 만복이 깃드시기를 \n머리 숙여 기원드립니다.\n\n-------------- ';
                        goodbye = ' 올림--------------';
                        fullText = '${receiverController.text}${hello}\n${body}${senderController.text}${goodbye}';

                      } else if (_btn1SelectedVal == '반말') {
                        hello = ' 요즘 잘 지냈어?? ';
                        body = '2022년 한해 너무 고생 많았고\n새해 복 많이 받아~ \n내년에는 올해보다 더 자주봅시당~ \n\n2023년 한해 화이팅 해보자!!\nfrom ';
                        goodbye = '';
                        fullText = '${receiverController.text}${hello}\n${body}${senderController.text}${goodbye}';
                      } else if (_btn1SelectedVal == '존대말') {
                        hello = '님!!\n';
                        body = '다사다난했던 2022년 한해가 \n저무네요. 올 한 해 수고 많으셨습니다. \n다가오는 2023년 새해에도 늘 \n건강하심과 더불어 행운 가득한 한 해가 \n되시기를 기원합니다. \n새해복 많이 받으십시오~^^ \n\n' ;
                        goodbye = ' 올림';
                        fullText = '${receiverController.text}${hello}\n${body}${senderController.text}${goodbye}';
                      }
                    });
                  },
                  items: _dropDownMenuItems,
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(
                  left: Dimensions.width10 * 2,
                  right: Dimensions.width10 * 2,
                  top: Dimensions.height10 * 1),
              padding: EdgeInsets.all(Dimensions.width10 * 1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.width15),
                border: Border.all(color: AppColors.mainColor, width: 2),
                color: Colors.white,
              ),
              child: Column(

                children: [
                  BigText(text:'완성본', size: Dimensions.font26),
                  SizedBox(height: Dimensions.height10 /5,
                    child: Container(
                      color: AppColors.paraColor,
                    ),),
                  RichText( text: TextSpan(
                      text: "${receiverController.text}",
                      style: TextStyle(color: AppColors.starColor, fontSize: 20),
                      children: <TextSpan>[
                        TextSpan(
                            text: "${hello}\n",
                            style: TextStyle(color: Colors.red, fontSize: 20)),
                        TextSpan(
                            text: body,
                            style: TextStyle(color: Colors.black, fontSize: 20)),
                        TextSpan(
                            text: senderController.text,
                            style: TextStyle(color: AppColors.starColor, fontSize: 20)),
                        TextSpan(
                            text: goodbye,
                            style: TextStyle(color: Colors.black, fontSize: 20)),
                      ]

                  )
                  ),
                  SizedBox(height: Dimensions.height10 /5,
                    child: Container(
                      margin: EdgeInsets.only(top:Dimensions.height10),
                      color: AppColors.paraColor,
                    ),),
                ],
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end,

                children:
                [ BigText(text: '양식 추가하기'),IconButton(onPressed:(){
                  setState(() {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (c) => AddMent2(
                          menuItems: menuItems,
                        )
                    ));

                  });
                }, icon: AppIcon(icon: Icons.add, backgroundColor: AppColors.mainColor,),),
                  BigText(text: '복사하기'),IconButton(onPressed:(){
                  setState(() {
                    FlutterClipboard.copy(fullText!);
                  });
                }, icon: AppIcon(icon: Icons.copy, backgroundColor: AppColors.mainColor,))]
            )

          ],
        ),
      ),
    );
  }
}

class AddMent2 extends StatefulWidget {
  AddMent2({Key? key, this.menuItems}) : super(key: key);
  final menuItems;

  @override
  State<AddMent2> createState() => _AddMent2State();
}

class _AddMent2State extends State<AddMent2> {
  TextEditingController menunameController = TextEditingController();
  TextEditingController helloController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  TextEditingController goodbyeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(

        margin: EdgeInsets.only(
          left: Dimensions.width10 * 2,
          right: Dimensions.width10 * 2,
        ),

        padding: EdgeInsets.all(Dimensions.width10 * 1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.width15),
          border: Border.all(color: AppColors.mainColor, width: 2),
          color: Colors.white,
        ),
        child: TextField(
          controller: menunameController,
          decoration: InputDecoration(labelText: "보내는이", ),
        ),
      ),
    );
  }
}
