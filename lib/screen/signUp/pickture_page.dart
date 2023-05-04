import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pick_up_game/common/color.dart';
import 'package:pick_up_game/component/bottom_button.dart';
import 'package:pick_up_game/component/custom_text.dart';

class ProfilePicturePage extends StatefulWidget {
  final VoidCallback onNext;
  final void Function(String)? onPictureChanged;
  final VoidCallback onPrevious;

  const ProfilePicturePage({
    required this.onNext,
    required this.onPictureChanged,
    required this.onPrevious,
    Key? key,
  }) : super(key: key);

  @override
  _ProfilePicturePageState createState() => _ProfilePicturePageState();
}

class _ProfilePicturePageState extends State<ProfilePicturePage> {
  File? _imageFile;
  bool? _isLoading;

  Future<String?> uploadImage(File imageFile) async {
    try {
      final storage = FirebaseStorage.instance;
      final ref = storage
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final task = await ref.putFile(imageFile);
      final url = await task.ref.getDownloadURL();

      return url;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> _uploadImage() async {
    if (_imageFile == null) return;
    setState(() {
      _isLoading = true;
    });
    final url = await uploadImage(_imageFile!);
    setState(() {
      _isLoading = false;
    });
    if (url != null) {
      widget.onPictureChanged?.call(url);
      // Save the image URL to Firestore
      String userId = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'profilePictureUrl': url,
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      File? _img = File(pickedFile.path);
      _img = await _cropImage(imageFile: _img);
      setState(() {
        _imageFile = _img;
      });
      await _uploadImage();
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage = await ImageCropper()
        .cropImage(sourcePath: imageFile.path, cropStyle: CropStyle.circle,
   );
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      padding: const EdgeInsets.all(20),
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(mainText: '나만의 프로필', subText: '을\n입력해주세요'),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  InkWell(
                    onTap: () => _pickImage(ImageSource.gallery),
                    child: _imageFile == null
                        ? Container(
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            height: 200,
                            width: 80,
                            child: Icon(
                              Icons.person_pin,
                              size: 200,
                              color: Colors.grey,
                            ),
                          )
                        : Center(
                            child: CircleAvatar(
                              radius: 80,
                              backgroundImage: FileImage(_imageFile!),
                            ),
                          ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextButton(
                      onPressed: () => _pickImage(ImageSource.gallery),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.7, color: Colors.grey),
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 4),
                          child: Text(
                            '사진 변경하기',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[700]),
                          ),
                        ),
                      )),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NextAndPrevioussButton(onPressed: widget.onPrevious, flex: 1, text: '이전', color: Colors.grey.shade300,textColor: Colors.grey),
                  NextAndPrevioussButton(onPressed: widget.onNext, flex: 2, text: '다음',color: PRIMARY_COLOR,textColor: Colors.white)


                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
