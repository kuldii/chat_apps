import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:chatapp/app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/change_profile_controller.dart';

class ChangeProfileView extends GetView<ChangeProfileController> {
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    controller.emailC.text = authC.user.value.email!;
    controller.nameC.text = authC.user.value.name!;
    controller.statusC.text = authC.user.value.status!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.red[900],
        title: Text('Change Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              authC.changeProfile(
                controller.nameC.text,
                controller.statusC.text,
              );
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            AvatarGlow(
              endRadius: 75,
              glowColor: Colors.black,
              duration: Duration(seconds: 2),
              child: Container(
                margin: EdgeInsets.all(15),
                width: 120,
                height: 120,
                child: Obx(
                  () => ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: authC.user.value.photoUrl! == "noimage"
                        ? Image.asset(
                            "assets/logo/noimage.png",
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            authC.user.value.photoUrl!,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: controller.emailC,
              readOnly: true,
              textInputAction: TextInputAction.next,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 20,
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: controller.nameC,
              textInputAction: TextInputAction.next,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                labelText: "Name",
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 20,
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: controller.statusC,
              cursorColor: Colors.black,
              textInputAction: TextInputAction.done,
              onEditingComplete: () {
                authC.changeProfile(
                  controller.nameC.text,
                  controller.statusC.text,
                );
              },
              decoration: InputDecoration(
                labelText: "Status",
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 20,
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GetBuilder<ChangeProfileController>(
                    builder: (c) => c.pickedImage != null
                        ? Column(
                            children: [
                              Container(
                                height: 110,
                                width: 125,
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        image: DecorationImage(
                                          image: FileImage(
                                            File(c.pickedImage!.path),
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: -10,
                                      right: -5,
                                      child: IconButton(
                                        onPressed: () => c.resetImage(),
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red[900],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "upload",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Text("no image"),
                  ),
                  TextButton(
                    onPressed: () => controller.selectImage(),
                    child: Text(
                      "chosen",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: Get.width,
              child: ElevatedButton(
                onPressed: () {
                  authC.changeProfile(
                    controller.nameC.text,
                    controller.statusC.text,
                  );
                },
                child: Text(
                  "UPDATE",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
