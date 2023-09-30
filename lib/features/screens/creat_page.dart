import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_riverpod/common/image_upload.dart';
import 'package:crud_riverpod/features/controller/idCreatController/creatController.dart';
import 'package:crud_riverpod/models/detialsModel.dart';
import 'package:crud_riverpod/theme/color_bundel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'home_page.dart';

class CreatPage extends ConsumerStatefulWidget {
  DetailModel datas;
  CreatPage({super.key, required this.datas});

  @override
  ConsumerState<CreatPage> createState() => _CreatPageState();
}

class _CreatPageState extends ConsumerState<CreatPage> {
  String ImageUrl = "";


  File? image;
  final picker = ImagePicker();

  Future getImager() async {
    var pickImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickImage != null) {
        image = File(pickImage.path);
      } else {
        print("no image selected");
      }
    });
  }

  Future uploadImage() async {
    getImager();
    String uniquefilename = DateTime.now().microsecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('pics/');
    Reference referenceImagetoUpload = referenceDirImages.child(uniquefilename);

    await referenceImagetoUpload.putFile(File(image!.path));
    var downloadUrl = await (referenceImagetoUpload).getDownloadURL();
    print(downloadUrl);

    ImageUrl = downloadUrl;
    print(ImageUrl);
    setState(() {});

    return;
  }

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  addName() {
    ref.read(CreateControllerProvider).addName(DetailModel(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          address: addressController.text,
          email: emailController.text,
          id: '',
          imageUrl: ImageUrl == ""
              ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyyfF2YnYWv_rHjWA2b8BbSvCSogNTKfufbQ&usqp=CAU"
              : ImageUrl,
        ));
  }

  @override
  var selectedCategory;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorBundle.themeColor,
        ),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                SizedBox(
                  height: w * 0.03,
                ),
                Container(
                  child: InkWell(
                    onTap: () {
                      getImager();

                      setState(() {
                   uploadImage();
                      });
                    },
                    child: ImageUrl == ""
                        ? CircleAvatar(
                            radius: w * 0.08,
                            backgroundImage:
                                AssetImage("assets/personAvatar.webp"),
                          )
                        : CircleAvatar(
                            radius: w * 0.08,
                            backgroundImage: NetworkImage(ImageUrl),
                            // child: Image.network(""),
                          ),
                  ),
                ),
                SizedBox(
                  height: w * 0.03,
                ),
                TextField(
                  controller: firstNameController,
                  decoration: InputDecoration(
                      hintText: "First name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                ),
                SizedBox(
                  height: w * 0.03,
                ),
                TextField(
                  controller: lastNameController,
                  decoration: InputDecoration(
                      hintText: "Last name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                ),
                SizedBox(
                  height: w * 0.03,
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: "E-Mail",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                ),
                SizedBox(
                  height: w * 0.03,
                ),
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(
                      hintText: "Address",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                ),
                SizedBox(
                  height: w * 0.1,
                ),
                GestureDetector(
                  onTap: () {
                    if (firstNameController.text != "" &&
                        lastNameController.text != "" &&
                        emailController.text != "" &&
                        addressController.text != "") {
                      addName();
                      firstNameController.clear();
                      lastNameController.clear();
                      emailController.clear();
                      addressController.clear();
                    } else {
                      firstNameController.text == ""
                          ? ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Enter First Name")))
                          : lastNameController.text == ""
                              ? ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Enter Last Name")))
                              : emailController.text == ""
                                  ? ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text("Enter E-mail")))
                                  : ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text("Enter Address ")));
                    }
                  },
                  child: Container(
                    height: w * 0.1,
                    width: w * 0.8,
                    decoration: BoxDecoration(
                        color: ColorBundle.themeColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 2),
                            blurRadius: 2,
                          )
                        ]),
                    child: const Center(child: Text("Submit")),
                  ),
                )
              ])),
        ));
  }
}
