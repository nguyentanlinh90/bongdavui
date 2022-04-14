import 'dart:io';

import 'package:bongdavui/constants/firebase_store_path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../models/field.dart';

class FirebaseHelper {
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;
  static final _firebaseStorage = FirebaseStorage.instance.ref();

  static getReferenceFirebaseStorage() {
    return _firebaseStorage;
  }

  static void deleteDocument(reference) async {
    await _firebaseFirestore.runTransaction((Transaction myTransaction) async {
      myTransaction.delete(reference);
    });
  }

  //for Field
  static Future<void> addDocumentField(
      FieldModel fieldModel, Function(bool isAdded, String fieldId) callback) {
    return _firebaseFirestore
        .collection(FirebaseStorePath.fields)
        .add(fieldModel.toJson())
        .then((value) => callback(true, value.id)
            .catchError((error) => callback(false, error.toString())));
  }

  static Future<void> updateDocumentField(
      String fieldId,
      Map<String, Object?> data,
      Function(bool isUpdate, String message) callback) {
    print('bdv data');
    print(data);
    return _firebaseFirestore
        .collection(FirebaseStorePath.fields)
        .doc(fieldId)
        .update(data)
        .then((value) => callback(true, 'Update Success')
            .catchError((error) => callback(false, error.toString())));
  }

  static Future<void> uploadFile(String path, File file,
      Function(bool isAdded, String url) callback) async {
    final storageRef = _firebaseStorage.child(path);
    try {
      UploadTask uploadTask = storageRef.putFile(file);
      final String urlDownload = await (await uploadTask).ref.getDownloadURL();
      callback(true, urlDownload);
    } on FirebaseException catch (error) {
      callback(false, error.toString());
    }
  }

  static Future<void> uploadImages(String path, List<XFile> files,
      Function(bool isUpload, List<String> urlDownloadList) callback) async {
    final storageRef = _firebaseStorage.child(path);

    try {
      //list url images to download, used to add to field
      List<String> urlDownloads = [];

      for (var i = 0; i < files.length; i++) {
        final File file = File(files[i].path);
        UploadTask uploadTask = storageRef.child(files[i].name).putFile(file);

        var urlDownload =
            await (await uploadTask).ref.getDownloadURL();
        urlDownloads.add(urlDownload);

        if (urlDownloads.length == files.length) {
          callback(true, urlDownloads);
        }
      }
    } on FirebaseException catch (error) {
      callback(false, [error.toString()]);
    }
  }
}
