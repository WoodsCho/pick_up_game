import 'package:flutter/material.dart';
import 'package:pick_up_game/component/bottom_button.dart';
import 'package:pick_up_game/component/custom_text.dart';
import 'package:pick_up_game/screen/signUp/pickture_page.dart';

import '../../common/color.dart';

class NameInputPage extends StatefulWidget {
  final VoidCallback onNext;
  final void Function(String)? onNameChanged;

  const NameInputPage({required this.onNext, required this.onNameChanged, Key? key}) : super(key: key);

  @override
  _NameInputPageState createState() => _NameInputPageState();
}
class _NameInputPageState extends State<NameInputPage> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_onNameChanged);
  }

  @override
  void dispose() {
    _nameController.removeListener(_onNameChanged);
    _nameController.dispose();
    super.dispose();
  }

  void _onNameChanged() {
    widget.onNameChanged?.call(_nameController.text);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Stack(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(mainText: '닉네임', subText: '을\n입력해주세요'),
              SizedBox(height: 60,),
              TextFormField(controller: _nameController,
              style: TextStyle(
                fontSize: 25,
                color: PRIMARY_COLOR
              ),
              maxLength:20,
              cursorHeight: 30,
              decoration: InputDecoration(helperText: '픽업게임에서 사용할 닉네임을 입력해주세요'),)
            ],
          ),
          Align(
              alignment:Alignment.bottomCenter
              ,child: NextButton(onPressed: _nameController.text.isNotEmpty ? widget.onNext : null, width: double.maxFinite,))


        ])
      ),
    );
  }
}
