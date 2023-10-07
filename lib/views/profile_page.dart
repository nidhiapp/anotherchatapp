import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_chatapp_chitchat/UIHelpers/dialogs/flushbar_plus_circularbar.dart';
import 'package:new_chatapp_chitchat/UIHelpers/utils/app_colors.dart';
import 'package:new_chatapp_chitchat/UIHelpers/utils/constants.dart';
import 'package:new_chatapp_chitchat/data/firebase_constants.dart';
import 'package:new_chatapp_chitchat/models/chat_user_model.dart';
import 'package:new_chatapp_chitchat/view_models/profile_page_provider.dart';
import 'package:provider/provider.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key, required this.user});
  final ChatUserModel user;

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String? _image;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            appBar: AppBar(automaticallyImplyLeading: true),
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.only(top: 65, left: 15, right: 15),
                  // height: h! * 0.8,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 196, 185, 188),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Center(
                                    child: Text(
                              "  User Profile",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w700),
                            ))),
                            CircleAvatar(
                                radius: 20,
                                backgroundColor:
                                    Color.fromARGB(255, 75, 122, 100),
                                child: Icon(
                                  Icons.person_3_outlined,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                      ),
                      SizedBox(height: h! * 0.07),
                      Stack(
                        children: [
                          _image != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(80),
                                  child: Image.file(
                                    File(_image!),
                                    width: w! * 0.4,
                                    height: h! * 0.2,
                                    fit: BoxFit.fill,
                                  ))
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(h! * 0.4),
                                  child: CachedNetworkImage(
                                    height: h! * 0.2,
                                    width: w! * 0.4,
                                    fit: BoxFit.fill,
                                    imageUrl: widget.user.image,
                                    errorWidget: (context, url, error) =>
                                        CircleAvatar(
                                      child: Icon(Icons.person),
                                    ),
                                  ),
                                ),
                          Positioned(
                            top: h! * 0.13,
                            left: w! * 0.29,
                            child: InkWell(
                              onTap: () {
                                customModalBottomSheet();
                              },
                              child: CircleAvatar(
                                  child: Icon(
                                Icons.edit,
                                color: Colors.black,
                              )),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: h! * 0.02,
                      ),
                      Container(
                        width: w! * 0.7,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromARGB(163, 143, 191, 220)),
                        child: TextFormField(
                          onSaved: (newValue) =>
                              FbConstants.myself.name = newValue ?? '',
                          validator: (newValue) =>
                              newValue != null && newValue.isNotEmpty
                                  ? null
                                  : "required field",
                          initialValue: widget.user.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                          decoration: InputDecoration(
                            focusColor: Color.fromARGB(185, 216, 154, 83),
                            hintText: "user's name",
                            prefixIcon: Icon(
                              Icons.person,
                              color: AppColors.redcolor,
                              size: h! * 0.04,
                            ),
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: AppColors.whitecolor),
                          ),

                          //  Text(
                          //     widget.user.name,
                          //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                          //   ),
                        ),
                      ),
                      SizedBox(
                        height: h! * 0.02,
                      ),
                      Container(
                        width: w! * 0.7,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromARGB(163, 143, 191, 220)),
                        child: TextFormField(
                          onSaved: (newValue) =>
                              FbConstants.myself.email = newValue ?? '',
                          validator: (newValue) =>
                              newValue != null && newValue.isNotEmpty
                                  ? null
                                  : "required field",
                          initialValue: widget.user.email,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                          decoration: InputDecoration(
                            focusColor: Color.fromARGB(185, 216, 154, 83),
                            hintText: "user's email",
                            prefixIcon: Icon(
                              Icons.email,
                              color: AppColors.redcolor,
                              size: h! * 0.04,
                            ),
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: AppColors.whitecolor),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: h! * 0.02,
                      ),
                      Container(
                        width: w! * 0.7,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromARGB(163, 143, 191, 220)),
                        child: TextFormField(
                          onSaved: (newValue) =>
                              FbConstants.myself.about = newValue ?? '',
                          validator: (newValue) =>
                              newValue != null && newValue.isNotEmpty
                                  ? null
                                  : "required field",
                          initialValue: widget.user.about,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                          decoration: InputDecoration(
                            focusColor: Color.fromARGB(185, 216, 154, 83),
                            hintText: "about user",
                            prefixIcon: Icon(
                              Icons.info,
                              color: AppColors.redcolor,
                              size: h! * 0.04,
                            ),
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: AppColors.whitecolor),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: h! * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.phone_outlined,
                            color: AppColors.redcolor,
                            size: h! * 0.04,
                          ),
                          SizedBox(
                            width: w! * 0.01,
                          ),
                          Text(" N/A",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500))
                        ],
                      ),
                      SizedBox(height: h! * 0.05),
                      Consumer<ProfilePageProvider>(
                        builder: (context, value, child) {
                          return Container(
                              height: h! * 0.08,
                              width: w! * 0.4,
                              child: Stack(children: [
                                Center(
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                        FbConstants.updateCurrentUserInfo();

                                        UIHelpers.flushbarErrormessage(
                                            "your profile has been updated",
                                            context);
                                        debugPrint("inside validator");
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: StadiumBorder(),
                                        backgroundColor: AppColors.primarycolor,
                                        minimumSize:
                                            Size(w! * 0.01, h! * 0.01)),
                                    label: Text("Update"),
                                    icon: Icon(Icons.edit),
                                  ),
                                ),
                                if (value
                                    .isLoading) // Add this condition to show the CircularProgressIndicator
                                  Center(
                                    child: CircularProgressIndicator(),
                                  ),
                              ]));
                        },
                      ),
                      SizedBox(
                        height: h! * 0.02,
                      )
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }

  void customModalBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(40.0))),
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Container(
              height: h! * 0.2,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      "Pick Your Profile Image",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: h! * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () async {
                            final ImagePicker picker = ImagePicker();
// Pick an image.
                            final XFile? image = await picker.pickImage(
                                source: ImageSource.camera,imageQuality: 80);

                            if (image != null) {
                              debugPrint(
                                  'Image Path: ${image.path}----- Mime Type:${image.mimeType}');
                              setState(() {
                                _image = image.path;
                              });
                               FbConstants.updateProfilePicture(File(_image!));
                              Navigator.pop(context);
                            }
                          },
                          child: Column(
                            children: [
                              const Icon(
                                Icons.camera,
                                color: Color.fromARGB(246, 121, 39, 39),
                                size: 40,
                              ),
                              Text("camera")
                            ],
                          )),
                      SizedBox(
                        width: w! * 0.3,
                      ),
                      InkWell(
                        onTap: () async {
                          final ImagePicker picker = ImagePicker();
// Pick an image.
                          final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery,imageQuality: 80);

                          if (image != null) {
                            debugPrint(
                                'Image Path: ${image.path}----- Mime Type:${image.mimeType}');
                            setState(() {
                              _image = image.path;
                            });
                            FbConstants.updateProfilePicture(File(_image!));
                            Navigator.pop(context);
                          }
                        },
                        child: Column(
                          children: [
                            const Icon(
                              Icons.image,
                              color: Color.fromARGB(246, 121, 39, 39),
                              size: 40,
                            ),
                            Text("Gallery")
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
