import 'dart:io';

import 'package:bongdavui/constants/app_sizes.dart';
import 'package:bongdavui/constants/firebase_store_path.dart';
import 'package:bongdavui/models/field_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../config/theme/app_colors.dart';
import '../../config/theme/app_text_styles.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_strings.dart';
import '../../widgets/stateless/app_dialog.dart';
import '../../widgets/stateless/box_space.dart';
import '../../widgets/stateless/button_back.dart';
import '../../widgets/stateless/input_field.dart';
import '../../widgets/stateless/responsive_button.dart';

class NewFieldPage extends StatefulWidget {
  const NewFieldPage({Key? key}) : super(key: key);

  @override
  _NewFieldPageState createState() => _NewFieldPageState();
}

class _NewFieldPageState extends State<NewFieldPage> {
  CollectionReference fields = FirebaseFirestore.instance.collection('fields');

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imageFileList = [];
  String? _retrieveDataError;
  dynamic _pickImageError;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        title: Text(
          AppString.addField,
          style: AppTextStyles.h4().copyWith(color: AppColors.white),
        ),
        leading: const ButtonBack(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.02, vertical: size.height * 0.02),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    (_imageFileList == null ||
                            _imageFileList!.length == 0 ||
                            _pickImageError != null)
                        ? buttonAddImage(context)
                        : gridImage(),
                    BoxSpace(height: size.height * 0.01),
                    InputField(
                      controller: nameController,
                      label: AppString.nameField,
                      maxLength: 50,
                    ),
                    BoxSpace(height: size.height * 0.01),
                    InputField(
                      controller: phoneController,
                      label: AppString.phoneField,
                      maxLength: 10,
                      textInputType: TextInputType.phone,
                    ),
                    BoxSpace(height: size.height * 0.01),
                  ],
                ),
              ),
            ),
            ResponsiveButton(
                type: AppConstants.typeNormal,
                btText: AppString.addField,
                onTap: () {
                  addField();
                }),
          ],
        ),
      ),
    );
  }

  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext? context}) async {
    final List<XFile>? pickedFileList = await _picker.pickMultiImage(
      // maxWidth: maxWidth,
      // maxHeight: maxHeight,
      imageQuality: 100,
    );
    setState(() {
      _imageFileList = pickedFileList;
    });
  }

  Widget _previewImages() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFileList != null) {
      return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          shrinkWrap: true,
          itemCount: _imageFileList!.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              color: AppColors.primaryColor,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Image.file(File(_imageFileList![index].path)),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _imageFileList?.removeAt(index);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          primary: AppColors.white,
                          padding: const EdgeInsets.all(0)),
                      child: const FaIcon(
                        FontAwesomeIcons.xmark,
                        size: AppSizes.s_30,
                        color: AppColors.black,
                      ))
                ],
              ),
            );
          });
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image 1.',
        textAlign: TextAlign.center,
      );
    }
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file;
        _imageFileList = response.files;
      });
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  Center gridImage() {
    return Center(
      child: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
          ? FutureBuilder<void>(
              future: retrieveLostData(),
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return const Text(
                      'You have not yet picked an image 2.',
                      textAlign: TextAlign.center,
                    );
                  case ConnectionState.done:
                    return _previewImages();
                  default:
                    if (snapshot.hasError) {
                      return Text(
                        'Pick image/video error: ${snapshot.error}}',
                        textAlign: TextAlign.center,
                      );
                    } else {
                      return const Text(
                        'You have not yet picked an image 3.',
                        textAlign: TextAlign.center,
                      );
                    }
                }
              },
            )
          : _previewImages(),
    );
  }

  InkWell buttonAddImage(BuildContext context) {
    return InkWell(
      onTap: () {
        _onImageButtonPressed(
          ImageSource.gallery,
          context: context,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(AppSizes.s_16),
        child: Column(
          children: [
            FaIcon(
              FontAwesomeIcons.fileImage,
              size: AppSizes.s_50,
              color: AppColors.primaryColor,
            ),
            Text(
              AppString.addImage,
              style: AppTextStyles.h5().copyWith(color: AppColors.primaryColor),
            )
          ],
        ),
        decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(color: AppColors.blackGrey, width: 1),
            borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Future<void> addField() {
    if (nameController.text.isNotEmpty && phoneController.text.isNotEmpty) {}
    FieldModel $fieldModel =
        FieldModel(nameController.text, [phoneController.text]);

    return fields
        .add($fieldModel.toJson())
        .then((value) => {
                  uploadImage(_imageFileList!, value.id, context)
                } /*showDialog(
            barrierDismissible: true,
            context: context,
            builder: (context) {
              return AppDialog(
                  title: AppString.congratulation,
                  content: AppString.contentNewFieldSuccess,
                  yes: AppString.yes);
            })*/
            )
        .catchError((error) => print('Error: $error'));
  }
}

Future<String> uploadFile(String path, XFile image) async {
  Reference storageReference =
      FirebaseStorage.instance.ref().child('$path/${image.name}');
  UploadTask uploadTask = storageReference.putFile(File(image.path));
  await uploadTask.whenComplete(() => {print('lin lin lin')});

  return await storageReference.getDownloadURL();
}

void uploadImage(List<XFile> _imageFileList, fieldID, context) async {
  if (_imageFileList.isNotEmpty) {
    //await Future.wait(_imageFileList.map((image) => uploadFile("${FirebaseStorePath.fields}/$fieldID", image)));
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('${FirebaseStorePath.fields}/$fieldID');
    int countImage = _imageFileList.length;
    for (int i = 0; i < countImage; i++) {
      final path = _imageFileList[i].path;
      final file = File(path);
      final name = _imageFileList[i].name;
      // final metadata = SettableMetadata(contentType: "image/jpeg");
      UploadTask uploadTask =
          storageRef.child(name).putFile(file /*, metadata*/);
      // await uploadTask.whenComplete(() => {print('lin lin lin')});
      // Listen for state changes, errors, and completion of the upload.
      uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
        switch (taskSnapshot.state) {
          case TaskState.running:
            final progress = 100.0 *
                (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
            print("Upload is $progress% complete.");
            break;
          case TaskState.paused:
            print("Upload is paused.");
            break;
          case TaskState.canceled:
            print("Upload was canceled");
            break;
          case TaskState.error:
            // Handle unsuccessful uploads
            break;
          case TaskState.success:
            countImage--;
            print('linhnt ' +countImage.toString());
            if (countImage == 0) {
              showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (context) {
                    return AppDialog(
                        title: AppString.congratulation,
                        content: AppString.contentNewFieldSuccess,
                        yes: AppString.yes);
                  });
            }
            break;
        }
      });
    }
  }
}
