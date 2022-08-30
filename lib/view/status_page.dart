import 'package:chat_app/provider/auth_provider.dart';
import 'package:chat_app/view/auth_page.dart';
import 'package:chat_app/view/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/loginProvider.dart';

class StatusPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer(
            builder: (context, ref, child) {
              final authData = ref.watch(authStream);
              final isLoad = ref.watch(loadingProvider);
              return authData.when(
                  data: (data){
                    if(data == null){
                      return AuthPage();
                    }else{
                      return MainPage();
                    }

                  },
                  error: (err, stack) => Center(child: Text('$err')),
                  loading: () => Center(child: CircularProgressIndicator(),)
              );
            }
        )
    );
  }
}