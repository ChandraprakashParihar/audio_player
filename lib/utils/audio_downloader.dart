import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioDownloader {
  /// Downloads an audio file from the given [url] and saves it to the device.
  /// Ensures file permissions are granted before downloading.
  Future<File?> downloadAudio(String url, {String? filename}) async {
    try {
      // Validate URL
      if (url.isEmpty || !Uri.tryParse(url)!.isAbsolute) {
        throw Exception("Invalid URL");
      }

      // Request storage permission
      if (!await _requestStoragePermission()) {
        throw Exception("Storage permission denied.");
      }

      // Get storage directory
      Directory directory = await _getDownloadDirectory();
      String filePath =
          '${directory.path}/${filename ?? 'downloaded_audio.mp3'}';
      File file = File(filePath);

      // Check if file already exists
      if (await file.exists()) {
        debugPrint("File already exists at: $filePath");
        return file;
      }

      // Send HTTP GET request
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 30));

      // Check response status
      if (response.statusCode == 200) {
        await file.writeAsBytes(response.bodyBytes);
        debugPrint("Download complete: $filePath");
        return file;
      } else {
        throw Exception("Failed to download file: ${response.statusCode}");
      }
    } on SocketException {
      throw Exception("Network error: Please check your internet connection.");
    } on HttpException {
      throw Exception("HTTP error: Unable to fetch the file.");
    } on TimeoutException {
      throw Exception("Timeout: Server took too long to respond.");
    } catch (e) {
      throw Exception("Download error: $e");
    }
  }

  /// Requests storage permission from the user.
  Future<bool> _requestStoragePermission() async {
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) return true;

    // For Android 11+, use manageExternalStorage permission
    if (Platform.isAndroid && status.isDenied) {
      status = await Permission.manageExternalStorage.request();
      return status.isGranted;
    }

    return false;
  }

  /// Gets the appropriate download directory for different platforms.
  Future<Directory> _getDownloadDirectory() async {
    if (Platform.isAndroid) {
      return await getExternalStorageDirectory() ??
          await getTemporaryDirectory();
    } else {
      return await getApplicationDocumentsDirectory();
    }
  }
}
