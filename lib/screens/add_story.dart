import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:video_player/video_player.dart';

class AddStory extends StatefulWidget {
  const AddStory({super.key});

  @override
  State<AddStory> createState() => _AddStoryState();
}

class _AddStoryState extends State<AddStory> {
  final String apiKey = '4f583d1e868a139e8a60dbd4b10b9cb9';
  late VideoPlayerController videoPlayerController;
  File? selectedImage;
  File? selectedVideo;
  String? exportUrl;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);

      if (pickedFile != null) {
        setState(() {
          selectedImage = File(pickedFile.path);
          selectedVideo = null;
        });
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("No image selected")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error picking image: $e")));
    }
  }

  Future<void> pickVideo(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickVideo(source: source);

      if (pickedFile != null) {
        selectedVideo = File(pickedFile.path);
        selectedImage = null;

        videoPlayerController = VideoPlayerController.file(selectedVideo!);
        await videoPlayerController.initialize();
        setState(() {}); // Update UI after initializing
        videoPlayerController.play();
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("No video selected")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error picking video: $e")));
    }
  }

  Future<void> uploadImageToImgBB() async {
    if (selectedImage == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Image not found")));
      return;
    }

    try {
      String base64Image = base64Encode(selectedImage!.readAsBytesSync());
      String url = 'https://api.imgbb.com/1/upload';

      Map<String, String> body = {
        'key': apiKey,
        'image': base64Image,
      };

      final response = await http.post(Uri.parse(url), body: body);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        exportUrl = jsonResponse['data']['url'];
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Upload successful'),
        ));
      } else {
        print('Failed to upload image: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  void dispose() {
    if (selectedVideo != null && videoPlayerController.value.isInitialized) {
      videoPlayerController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final desController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                  const Text(
                    "New Story",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  TextButton(
                    onPressed: () async {
                      await uploadImageToImgBB();
                    },
                    child: const Text(
                      "PUSH",
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (selectedImage != null)
                ClipRRect(
                  child: Image.file(
                    selectedImage!,
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                )
              else if (selectedVideo != null)
                videoPlayerController.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: videoPlayerController.value.aspectRatio,
                        child: VideoPlayer(videoPlayerController),
                      )
                    : const CircularProgressIndicator()
              else
                const Text("No media selected"),
              const SizedBox(height: 20),
              PopupMenuButton<String>(
                icon: const Icon(Icons.add, size: 40, color: Colors.white),
                onSelected: (String value) {
                  if (value == 'image') {
                    pickImage(ImageSource.gallery);
                  } else if (value == 'video') {
                    pickVideo(ImageSource.gallery);
                  }
                },
                itemBuilder: (BuildContext context) => [
                  const PopupMenuItem(
                    value: 'image',
                    child: Text("Select Image"),
                  ),
                  const PopupMenuItem(
                    value: 'video',
                    child: Text("Select Video"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}





// import 'dart:convert';
// import 'dart:io';
// import 'package:clone_instagram/screens/provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:clone_instagram/shard/widgets/button_nav.dart';
// // import 'package:file_picker/file_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import 'package:uuid/uuid.dart';
// import 'package:video_player/video_player.dart';

// class AddStory extends StatefulWidget {
//   const AddStory({super.key});

//   @override
//   State<AddStory> createState() => _AddStoryState();
// }

// class _AddStoryState extends State<AddStory> {
//   final String apiKey = '4f583d1e868a139e8a60dbd4b10b9cb9';
//   late VideoPlayerController videoPlayerController;
//   File? selectedImage;
//   File? selectedVideo;
//   String? exportUrl;
//   final ImagePicker _picker = ImagePicker();
 



//   Future<void> pickImage(ImageSource source) async {
//     try {
//       final pickedFile = await _picker.pickImage(source: source);

//       if (pickedFile != null) {
//         setState(() {
//           selectedImage = File(pickedFile.path);
//           selectedVideo = null;
          
//         });
//       } else {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text("Not selected image")));
//       }
//     } catch (e) {
//       print("=======================================");
//       print(e);
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("Erorr on Jokkkkkkkkkkkkker $e")));
//     }
//   }


//    Future<void> pickVideo(source) async {
//     try {
//       final pickedFile = await _picker.pickVideo(source: source);

//       if (pickedFile != null) {
//         setState(() {
//           selectedVideo = File(pickedFile.path);
//           selectedImage=null;
//           videoPlayerController = VideoPlayerController.file(selectedVideo!);
//           videoPlayerController.initialize();
//           videoPlayerController.play();
          
//         });
//       } else {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text("Not selected image")));
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("Erorr on uploading $e")));
//     }
//   }

//   Future<void> uploadImageToImgBB() async {
//     if (selectedImage == null) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("Image not found")));
//       return;
//     }

//     try {
//       String base64Image = base64Encode(selectedImage!.readAsBytesSync());
//       String url = 'https://api.imgbb.com/1/upload';

//       Map<String, String> body = {
//         'key': apiKey,
//         'image': base64Image,
//       };

//       final response = await http.post(Uri.parse(url), body: body);

//       if (response.statusCode == 200) {
//         var jsonResponse = jsonDecode(response.body);
//         String imageUrl = jsonResponse['data']['url'];
//         exportUrl = imageUrl;
//         Navigator.of(context).pop();

//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text('Done'),
//         ));
//       } else {
//         print('فشل رفع الصورة: ${response.statusCode}');
//         print(response.body);
//       }
//     } catch (e) {
//       print('حدث خطأ أثناء رفع الصورة: $e');
//     }
//   }

//    @override
//   void initState() {
//     super.initState();
//     final userProvider = Provider.of<UserProvider>(context, listen: false);
//     userProvider.fetchuser( userid: FirebaseAuth.instance.currentUser!.uid);
//   }
//   @override
// void dispose() {
//   if (selectedVideo != null) {
//     videoPlayerController.dispose();
//   }
//   super.dispose();
// }
//   @override
//   Widget build(BuildContext context) {
//     final desController = TextEditingController();
//     final userprovider = Provider.of<UserProvider>(context);

//     void pushPOST() async {
//       try {
//         showDialog(
//           context: context,
//           barrierDismissible: false,
//           builder: (BuildContext context) {
//             return const Center(child: CircularProgressIndicator());
//           },
//         );
//         await uploadImageToImgBB();
//         final uuid = Uuid().v4();
//         await FirebaseFirestore.instance.collection('posts').doc(uuid).set({
//           'userName': userprovider.getuser!.userName,
//           'uid': userprovider.getuser!.uid,
//           'userImage': userprovider.getuser!.userImage,
//           'imagePost': exportUrl,
//           'postId': uuid,
//           'likes': [],
//           'des': desController.text,
//           'time':Timestamp.now(),
//         });
//         setState(() {
//           selectedImage = null;
//           desController.clear();
//           Navigator.of(context)
//               .pushReplacement(MaterialPageRoute(builder: (_) => ButtonNav()));
//         });
//       } on FirebaseAuthException catch (error) {
//         Navigator.of(context).pop();
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text("Error: ${error.message}")));
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text("An unexpected error occurred: $e")));
//       }
//     }

//     return SafeArea(
//       child: Scaffold(
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Expanded(
//             child: Column(
//               // mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     IconButton(
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                         icon: const Icon(
//                           Icons.close,
//                           color: Colors.white,
//                         )),
//                     const Text(
//                       "New Story",
//                       style: TextStyle(color: Colors.white, fontSize: 22),
//                     ),
//                     TextButton(
//                         onPressed: pushPOST,
//                         child: const Text(
//                           "PUSH",
//                           style: TextStyle(color: Colors.blue, fontSize: 16),
//                         )),
//                   ],
//                 ),
//                 Column(
//                   children: [
            
            
//                   selectedImage != null?  ClipRRect(
//                         child: Image.file(
//                           selectedImage!,
//                           width: double.infinity,
//                           height: 300,
//                           fit: BoxFit.cover,
//                         )): selectedVideo != null ? Container(
//                           child: videoPlayerController.value.isInitialized  ? VideoPlayer(videoPlayerController) : CircularProgressIndicator(),
//                         )  : Text("Notfound all"),
            
//                       SizedBox(
//                         height: 200,
//                       ),
            
            
//                       PopupMenuButton<String>(
//                         icon: Image.asset('assets/upload.png',width: 60,),
//                         onSelected: (String value) {
//                           if (value == 'option1'){
//                             pickImage(ImageSource.gallery);
//                           } else if  (value == 'option2'){
//                             // pickImage(ImageSource.);
//                             pickVideo(ImageSource.gallery);
//                           }
//                         },
//                         itemBuilder: (BuildContext context) {
//                           return <PopupMenuEntry<String>>[
//                             PopupMenuItem(
//                               value: 'option1',
//                               child: Text("Select Image")),
//                             PopupMenuItem(
//                               value: 'option2',
//                               child: Text("Select Video")),
//                           ];
//                         },),
            
                  
//                     const SizedBox(
//                       height: 50,
//                     ),
                   
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
