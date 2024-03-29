import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../provider/crud_provider.dart';
import '../provider/room_provider.dart';
import 'chat_page.dart';


class UserDetail extends StatelessWidget {
  final types.User user;
  UserDetail(this.user);
  @override
  Widget build(BuildContext context) {
    print(user.metadata!['userToken']);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Consumer(
              builder: (context, ref, child) {
                final postData = ref.watch(postStream);
                return Column(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(user.imageUrl!),
                          ),
                          SizedBox(width: 20,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(user.firstName!),
                              Text(user.metadata!['email']),
                              ElevatedButton(
                                  onPressed: () async {
                                    final response = await ref.read(roomProvider).createRoom(user);
                                    Get.to(() => ChatPage(room: response, user: user,));
                                  }, child: Text('start chat'))
                            ],
                          )

                        ],
                      ),
                    ),
                    SizedBox(height: 50,),
                    Container(
                      child:  postData.when(
                          data: (data){
                            final post = data.where((element) => element.userId == user.metadata!['userId']).toList();
                            return GridView.builder(
                                shrinkWrap: true,
                                itemCount: post.length,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5,
                                    childAspectRatio: 3/2
                                ),
                                itemBuilder: (context, index){
                                  return Image.network(post[index].imageUrl);
                                }
                            );
                          },
                          error: (err, stack) => Center(child: Text('$err')),
                          loading: () => Center(child: CircularProgressIndicator(
                            color: Colors.purple,
                          ),)
                      ),
                    ),
                  ],
                );
              }
          ),
        ),
      ),
    );
  }
}