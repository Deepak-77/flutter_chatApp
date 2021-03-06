import 'dart:io';

import 'package:chat_app/provider/auth_provider.dart';
import 'package:chat_app/provider/loginProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../provider/image_provider.dart';

class AuthPage extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final mailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final isLogin = ref.watch(loginProvider);
      final isView = ref.watch(isViewPro).isView;
      final image = ref.watch(imageProvider).image;
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              Text(
                isLogin ? 'Login Form' : 'SignUp Form',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              if (isLogin == false)
                TextFormField(
                  controller: nameController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Please provide username';
                    } else if (val.length > 20) {
                      return 'maximum character is 19';
                    }
                    return null;
                  },
                  decoration: InputDecoration(hintText: 'username'),
                ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: mailController,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Please provide email';
                  } else if (val.contains('@')) {
                    return 'Please provide valid email';
                  }
                  return null;
                },
                decoration: InputDecoration(hintText: 'email'),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passController,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Please provide password';
                  } else if (val.length > 16 || val.length < 6) {
                    return 'Invalid Password';
                  }
                  return null;
                },
                obscureText: isView,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        ref.read(isViewPro).toggle();
                      },
                      icon: Icon(Icons.remove_red_eye),
                    ),
                    hintText: 'password'),
              ),
              SizedBox(
                height: 20,
              ),
              if (isLogin == false)
                InkWell(
                  onTap: () {
                    ref.read(imageProvider).imagePicker();
                  },
                  child: Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    height: 150,
                    width: 150,
                    child: image == null
                        ? Center(
                            child: Text('please select image'),
                          )
                        : Image.file(File(image.path)),
                  ),
                ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    _form.currentState!.save();
                    if (_form.currentState!.validate()) {
                      if (isLogin) {
                        final response=await ref.read(authProvider).userLogin(
                            email: mailController.text.trim(),
                            password: passController.text.trim()
                        );

                        if (response!= 'success') {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration: Duration(seconds: 1),
                              content: Text(response)));
                        }

                      } else {

                        if (image == null) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: Duration(seconds: 1),
                              content: Text('Please select an image')));
                        } else {
                          await ref.read(authProvider).userSignUp(
                              email: mailController.text.trim(),
                              password: passController.text.trim(),
                              userName: nameController.text.trim(),
                              image: image);
                        }
                      }
                    }
                  },
                  child: Text('Submit')),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(isLogin ? 'Not a member?' : 'already a member?'),
                  TextButton(
                      onPressed: () {
                        ref.read(loginProvider.notifier).toggle();
                      },
                      child: Text(isLogin ? 'SignUp' : 'Login'))
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
