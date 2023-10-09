import 'dart:io';
import 'package:admin_mosquito_project/utils/colour.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class AddLeaning extends StatefulWidget {
  const AddLeaning({super.key});

  @override
  State<AddLeaning> createState() => _AddLeaningState();
}

class _AddLeaningState extends State<AddLeaning> {
  final CollectionReference lesson =
      FirebaseFirestore.instance.collection('lesson');

  TextEditingController lessonName = TextEditingController();
  TextEditingController lessonImgs = TextEditingController();
  TextEditingController lessonVideo = TextEditingController();

  void addLesson() async {
    if (lessonName.text.isNotEmpty &&
        _image != null &&
        lessonVideo.text.isNotEmpty) {
      final imgurl = await uploadImage(_image!);
      final data = {
        'l_name': lessonName.text,
        'l_imgs': imgurl,
        'l_video': lessonVideo.text,
      };
      lesson.add(data);
      // รีเซ็ตข้อมูลในฟอร์มหลังจาก submit
      lessonName.clear();
      lessonImgs.clear();
      lessonVideo.clear();
      _image = null;
    } else {
      displayMessage('Please fill in all fields');
    }
  }

  File? _image;
  final picker = ImagePicker();
  // String downloadUrl;

  Future imagePicker() async {
    try {
      final pick = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        if (pick != null) {
          _image = File(pick.path);
          lessonImgs.text = pick.path;
        } else {
          displayMessage('No Image Selectet');
        }
      });
    } catch (e) {
      displayMessage(e.toString());
    }
  }

  Future uploadImage(File _image) async {
    String url;
    String imgId = DateTime.now().microsecondsSinceEpoch.toString();
    Reference reference =
        FirebaseStorage.instance.ref().child('images').child('lesson$imgId');
    await reference.putFile(_image);
    url = await reference.getDownloadURL();
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Lessons',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold,
                color: whitePerl,
              ),
        ),
        backgroundColor: darkRed,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Text(
                'Add Images',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: litBlack,
                    ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  width: 370,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: _image == null
                              ? Center(
                                  child: Text('No Image Selected'),
                                )
                              : Image.file(
                                  _image!,
                                  fit: BoxFit.fitWidth,
                                ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            imagePicker();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              darkRed,
                            ),
                          ),
                          child: Text(
                            'Select Image',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: whitePerl,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
                        controller: lessonName,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Lesson Name",
                          hintText: 'Please input Lesson Name',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
                        controller: lessonVideo,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Link Lesson in Youtube",
                          hintText: 'Please input Link Lesson in Youtube',
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceEvenly, // จัดตำแหน่งปุ่มให้อยู่ตรงกลาง
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (lessonName.text.isNotEmpty &&
                                  _image != null &&
                                  lessonVideo.text.isNotEmpty) {
                                addLesson();
                                Navigator.pop(context);
                              } else {
                                displayMessage('Please fill in all fields');
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                darkRed,
                              ),
                            ),
                            child: Text(
                              "Submit",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: whitePerl,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context); // กลับไปหน้าก่อนหน้า
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                darkRed,
                              ),
                            ),
                            child: Text(
                              "Cancel",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: whitePerl,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void displayMessage(String message) {
    Fluttertoast.showToast(msg: message);
  }
}
