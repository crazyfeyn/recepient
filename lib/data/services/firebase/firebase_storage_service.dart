import 'dart:io';

import 'package:dio/dio.dart';

class FirebaseStorageService {
  Future<String?> uploadVideo(File videoFile, String fileName) async {
    const String storageUrl =
        'https://firebasestorage.googleapis.com/v0/b/retsept-app-db287.appspot.com/o';

    try {
      Dio dio = Dio();
      String mimeType = 'video/mp4'; // Set the correct MIME type for your video

      // Read the video file
      MultipartFile video = await MultipartFile.fromFile(
        videoFile.path,
        filename: fileName,
      );

      FormData formData = FormData.fromMap({
        'file': video,
      });

      // Send a POST request to Firebase Storage
      Response response = await dio.post(
        '$storageUrl/videos/$fileName?uploadType=media',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': mimeType,
          },
        ),
      );

      if (response.statusCode == 200) {
        // Construct and return the download URL
        final String downloadUrl = '$storageUrl/videos/$fileName?alt=media';
        print('Video uploaded successfully: $downloadUrl');
        return downloadUrl;
      } else {
        print('Failed to upload video: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error uploading video: $e');
      return null;
    }
  }

  Future<String?> uploadImageToFirebase(File imageFile, String fileName) async {
    // Your Firebase Storage URL (replace with your actual Firebase project ID)
    const storageUrl =
        'https://firebasestorage.googleapis.com/v0/b/retsept-app-db287.appspot.com/o';

    try {
      Dio dio = Dio();
      String mimeType = 'image/jpeg'; // or 'image/png' based on your file type

      // Read the image file and prepare it for upload
      MultipartFile image = await MultipartFile.fromFile(
        imageFile.path,
        filename: fileName,
      );

      FormData formData = FormData.fromMap({
        'file': image,
      });

      // Send a POST request to Firebase Storage
      Response response = await dio.post(
        '$storageUrl/images/$fileName?uploadType=media',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': mimeType,
          },
        ),
      );

      if (response.statusCode == 200) {
        // Successful upload, extract the download URL
        final downloadUrl =
            'https://firebasestorage.googleapis.com/v0/b/retsept-app-db287.appspot.com/o/images/$fileName?alt=media';
        print('Image uploaded successfully: $downloadUrl');
        return downloadUrl;
      } else {
        print('Failed to upload image: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }
}
