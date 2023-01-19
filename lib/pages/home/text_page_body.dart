import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class TextPageBody extends StatefulWidget {
  const TextPageBody({Key? key}) : super(key: key);

  @override
  State<TextPageBody> createState() => _TextPageBodyState();
}

class _TextPageBodyState extends State<TextPageBody> {
  static const menuItems = <String>['반말', '극존대', '존대말'];
  List<String> _menuItemsList = List.from(menuItems);
  late List<DropdownMenuItem<String>> _dropDownMenuItems;

  String? _btn1SelectedVal = '극존대';
  TextEditingController senderController = TextEditingController();
  TextEditingController receiverController = TextEditingController();
  String? hello;
  String? body;
  String? goodbye;
  String? fullText;
  List<TextSpan> spans = [];
  String? reciever;
  String? sender;
  String? desiredType = '';

  List<Map<String, dynamic>> message = [{
    'type': '',
    'format': '',
  }];
  final TextEditingController menunameController = TextEditingController();
  final TextEditingController helloController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  final TextEditingController goodbyeController = TextEditingController();
  void readData(){
    String desiredType = _btn1SelectedVal!;
    Map<String, dynamic> desiredFormat = message.firstWhere((format) => format['type'] ==
        desiredType, orElse: () => {'type': '', 'format': ''});
    if (desiredFormat != null) {
      print(desiredFormat['format']);
      hello = desiredFormat['format'].toString().split('|')[0];
      body = desiredFormat['format'].toString().split('|')[1];
      goodbye = desiredFormat['format'].toString().split('|')[2];
      fullText = '${hello}${receiverController.text}\n${body}${senderController.text}${goodbye}';
    } else {
      print("Message format of type $desiredType not found");
    }
  }
  void addDataToMessage() {
    setState(() {
      Map<String, String> newMessageFormat = {
        'type': menunameController.text,
        'format': helloController.text + '|' + bodyController.text + '|' + goodbyeController.text,
      };
      message.add(newMessageFormat);
    });
  }

  @override
  void initState() {
    _dropDownMenuItems = _menuItemsList.map((String value) => DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    )).toList();
    super.initState();
  }
  void addMenuItemlistandDropdownItem (String menuname) {
    setState(() {
      _menuItemsList.add(menuname);
      _dropDownMenuItems = _menuItemsList.map((String value) => DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      )).toList();
    });
  }

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
                decoration: InputDecoration(
                  labelText: "보내는이",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: Dimensions.width10 * 2,
                  right: Dimensions.width10 * 2,
                  top: Dimensions.height10),
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
                  top: Dimensions.height10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.width15),
                border: Border.all(color: AppColors.mainColor, width: 2),
                color: Colors.white,
              ),
              child: ListTile(
                title: SmallText(
                  text: '모드설정: \n(모드를 새로 설정하면 완성본이 나옵니다)',
                  color: Colors.black,
                ),
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
                        fullText =
                            '${receiverController.text}${hello}\n${body}${senderController.text}${goodbye}';
                      } else if (_btn1SelectedVal == '반말') {
                        hello = ' 요즘 잘 지냈어?? ';
                        body =
                            '2022년 한해 너무 고생 많았고\n새해 복 많이 받아~ \n내년에는 올해보다 더 자주봅시당~ \n\n2023년 한해 화이팅 해보자!!\nfrom ';
                        goodbye = '';
                        fullText =
                            '${receiverController.text}${hello}\n${body}${senderController.text}${goodbye}';
                      } else if (_btn1SelectedVal == '존대말') {
                        hello = '님!!\n';
                        body =
                            '다사다난했던 2022년 한해가 \n저무네요. 올 한 해 수고 많으셨습니다. \n다가오는 2023년 새해에도 늘 \n건강하심과 더불어 행운 가득한 한 해가 \n되시기를 기원합니다. \n새해복 많이 받으십시오~^^ \n\n';
                        goodbye = ' 올림';
                        fullText =
                            '${receiverController.text}${hello}\n${body}${senderController.text}${goodbye}';
                      } else {
                        readData();

                      };
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
                  BigText(text: '완성본', size: Dimensions.font26),
                  SizedBox(
                    height: Dimensions.height10 / 5,
                    child: Container(
                      color: AppColors.paraColor,
                    ),
                  ),
                  RichText(
                      text: TextSpan(
                          text: "${receiverController.text}",
                          style: TextStyle(
                              color: AppColors.starColor, fontSize: 20),
                          children: <TextSpan>[
                        TextSpan(
                            text: "${hello}\n",
                            style: TextStyle(color: Colors.red, fontSize: 20)),
                        TextSpan(
                            text: body,
                            style:
                                TextStyle(color: Colors.black, fontSize: 20)),
                        TextSpan(
                            text: senderController.text,
                            style: TextStyle(
                                color: AppColors.starColor, fontSize: 20)),
                        TextSpan(
                            text: goodbye,
                            style:
                                TextStyle(color: Colors.black, fontSize: 20)),
                      ])),
                  SizedBox(
                    height: Dimensions.height10 / 5,
                    child: Container(
                      margin: EdgeInsets.only(top: Dimensions.height10),
                      color: AppColors.paraColor,
                    ),
                  ),
                ],
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              BigText(text: '양식 추가하기'),
              IconButton(
                onPressed: () {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => AddMent(addMenuItemlistandDropdownItem: addMenuItemlistandDropdownItem,
                                  addDataToMessage: addDataToMessage,
                              menunameController: menunameController,
                              helloController: helloController,
                              bodyController: bodyController,
                              goodbyeController: goodbyeController,

                            )));
                  });
                },
                icon: AppIcon(
                  icon: Icons.add,
                  backgroundColor: AppColors.mainColor,
                ),
              ),
              BigText(text: '복사하기'),
              IconButton(
                  onPressed: () {
                    setState(() {
                      FlutterClipboard.copy(fullText!);
                    });
                  },
                  icon: AppIcon(
                    icon: Icons.copy,
                    backgroundColor: AppColors.mainColor,
                  ))
            ])
          ],
        ),
      ),
    );
  }
}

class AddMent extends StatelessWidget {
  final List<DropdownMenuItem<String>>? menuItems;
  final TextEditingController menunameController;
  final TextEditingController helloController;
  final TextEditingController bodyController;
  final TextEditingController goodbyeController;
  final Function addDataToMessage;
final Function addMenuItemlistandDropdownItem;
  AddMent({Key? key, this.menuItems,
    required this.addMenuItemlistandDropdownItem,
    required this.addDataToMessage, required this.menunameController,
    required this.helloController, required this.goodbyeController, required this.bodyController}) : super(key: key);

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
        child: Column(
          children: [
            TextField(
              controller: menunameController,
              decoration: InputDecoration(
                labelText: "모드 이름 설정(중복 금지!)",
              ),
            ),
            TextField(
              controller: helloController,
              decoration: InputDecoration(
                labelText: "인사말(받는 사람 이름 뒤)",
              ),
            ),
            TextField(
              controller: bodyController,
              maxLines: 6,
              decoration: InputDecoration(
                labelText: "(받는 사람 이름 뒤)본문 내용 설정",
              ),
            ),
            TextField(
              controller: goodbyeController,
              decoration: InputDecoration(
                labelText: "마지막 인사(본문, 보내는 사람 이름 뒤)",
              ),
            ),
            IconButton(
                onPressed: () {
                  addDataToMessage();
                  addMenuItemlistandDropdownItem(menunameController.text);
                  _clear();
                  Navigator.pop(context);
                },
                icon: Icon(Icons.add))
          ],
        ),
      ),
    );
  }
  void _clear() {
    menunameController.clear();
    helloController.clear();
    bodyController.clear();
    goodbyeController.clear();
  }


}
