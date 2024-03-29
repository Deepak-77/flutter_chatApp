import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final imageProvider = ChangeNotifierProvider.autoDispose((ref) => ImageProvider());

class ImageProvider extends ChangeNotifier{

  XFile? image;


  void imagePick() async{
    final ImagePicker _picker = ImagePicker();
    image =  await _picker.pickImage(source: ImageSource.gallery);
    notifyListeners();
  }



}