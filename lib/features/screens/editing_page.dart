import 'dart:io';

import 'package:crud_riverpod/common/image_upload.dart';
import 'package:crud_riverpod/features/controller/idCreatController/creatController.dart';
import 'package:crud_riverpod/models/detialsModel.dart';
import 'package:crud_riverpod/theme/color_bundel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'home_page.dart';

class EditingPage extends ConsumerStatefulWidget {
 final DetailModel datas;
   EditingPage({super.key,required this.datas});

  @override
  ConsumerState<EditingPage> createState() => _EditingPageState();
}

class _EditingPageState extends ConsumerState<EditingPage> {

  String ImageUrl = "";
  late XFile photo;
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
    Reference referenceDirImages =referenceRoot.child('pics/');
    Reference referenceImagetoUpload = referenceDirImages.child(uniquefilename);

    await referenceImagetoUpload.putFile(File(image!.path));
    var downloadUrl = await (referenceImagetoUpload).getDownloadURL();
    print(downloadUrl);

    ImageUrl = downloadUrl;
    print(ImageUrl);
    setState(() {

    });

    return;
  }

  TextEditingController ?firstNameController;
   TextEditingController ?lastNameController;
    TextEditingController ?addressController;
     TextEditingController ?emailController;

updateDetails(){
  ref.read(CreateControllerProvider).updateDetails(
     widget.datas,
    ImageUrl.toString(),
    emailController!.text,
    addressController!.text,
    firstNameController!.text,
    lastNameController!.text,

  );
  // final userDetaile=StateProvider<DetailModel>((ref)
  // {
  //   return DetailModel(
  //     firstName: firstNameController.text,
  //     lastName: lastNameController.text,
  //     address: addressController.text,
  //     email: emailController.text,
  //     id: editIndex);
  // });
  // final update= ref.read(userDetaile.notifier);
  //
  // final updated=update.state.copyWith(
  //     lastName: lastNameController.text,
  //     address: addressController.text,
  //     email: emailController.text,
  //     id: editIndex
  // );
  // ref.read(userDetaile.notifier).state=updated;
}
  @override
  void initState() {
    firstNameController=TextEditingController(text: widget.datas.firstName);
    lastNameController=TextEditingController(text: widget.datas.lastName);
    addressController=TextEditingController(text: widget.datas.address);
    emailController=TextEditingController(text: widget.datas.firstName);
    ImageUrl=widget.datas.imageUrl.toString();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorBundle.themeColor,
      ),
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
              children:  [
                SizedBox(height: w*0.03,),
                Container(
                  child: InkWell(
                    onTap: () {
                      getImager();

                      setState(() {
                        uploadImage();

                      });
                    },
                    child:ImageUrl==""?  CircleAvatar(
                      radius: w*0.08,
                      backgroundImage:  AssetImage("assets/personAvatar.webp"),
                    ) :
                    CircleAvatar(
                      radius: w*0.08,
                      backgroundImage: NetworkImage(ImageUrl),

                    ),
                  ),
                ),
                SizedBox(height: w*0.03,),
                TextField(
                  controller: firstNameController,
                  decoration: InputDecoration(
                    hintText: "First name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),

                    )
                  ),
                ),
                SizedBox(height: w*0.03,),
                TextField(
                  controller: lastNameController ,
                  decoration: InputDecoration(
                    hintText: "Last name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),

                    )
                  ),
                ),
                SizedBox(height: w*0.03,),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "E-Mail",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),

                    )
                  ),
                ),
                SizedBox(height: w*0.03,),
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(
                    hintText: "Address",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),

                    )
                  ),
                ),
                SizedBox(height: w*0.1,),
                InkWell(
                  onTap: () {

                  },
                  child:InkWell(
                    onTap: () {

                      updateDetails();
                      firstNameController!.clear();
                      lastNameController!.clear();
                      emailController!.clear();
                      addressController!.clear();

                    },
                    child: Container(
                      height: w*0.1,
                      width: w*0.8,
                      decoration: BoxDecoration(
                        color: ColorBundle.themeColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 2),
                            blurRadius: 2,
                          )
                        ]
                      ),
                      child: const Center(child: Text("Update")),
                    ),
                  ),
                )
          ]
            ),
        )
      )
    );
  }
}
