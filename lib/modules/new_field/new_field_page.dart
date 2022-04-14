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
import 'package:loading_overlay/loading_overlay.dart';

import '../../config/theme/app_colors.dart';
import '../../config/theme/app_text_styles.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_strings.dart';
import '../../widgets/items/itemImage.dart';
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
  List<XFile>? _imageFileList = <XFile>[];
  String? _retrieveDataError;
  dynamic _pickImageError;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

  bool _isLoading = false;

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
      body: LoadingOverlay(
        isLoading: _isLoading,
        color: AppColors.primaryColor,
        progressIndicator: const CircularProgressIndicator(
          color: AppColors.primaryColor,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.02, vertical: size.height * 0.02),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      //_viewGridImage(),//gridImage(),
                      _viewGridImage(),// gridImage()
                      BoxSpace(height: size.height * 0.01),
                      buttonAddImage(context),
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
                    setState(() {
                      _isLoading = true;
                      addField(() {
                        setState(() {
                          _isLoading = false;
                          _imageFileList = [];
                          nameController.text = '';
                          phoneController.text = '';
                        });
                      });
                    });
                  }),
            ],
          ),
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
      return initGridView();
      // return GridView.builder(
      //
      //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //       crossAxisCount: 3,
      //     ),
      //    // physics: const NeverScrollableScrollPhysics(),
      //     shrinkWrap: true,
      //     itemCount: _imageFileList!.length,
      //     itemBuilder: (BuildContext context, int index) {
      //       return ItemImage(item:_imageFileList?[index] ,remove: (){
      //         _removeItem(index);
      //       },);
      //     });
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
  GridView initGridView(){
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      children: List.generate(_imageFileList!.length, (index) {
        return ItemImage(item:_imageFileList?[index],remove:(){
          _removeItem(index);
        });

      }),
    );

  }
   _removeItem(int index) {
    setState(() {
     // _imageFileList!.reversed.toList().removeAt(index);
      _imageFileList!.removeAt(index);
    });

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
        //_imageFile
       // _imageFileList = response.files;
        _imageFileList!.addAll(response.files!);

      });
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }
Widget _viewGridImage(){
    return Center(
      child: !kIsWeb && defaultTargetPlatform == TargetPlatform.android?
      _imageFileList!.isNotEmpty?initGridView():Container():_previewImages()
    );
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
            const FaIcon(
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

  Future<void> addField(VoidCallback callback) {
    if (nameController.text.isNotEmpty && phoneController.text.isNotEmpty) {}
    FieldModel $fieldModel =
        FieldModel(nameController.text, [phoneController.text]);

    return fields
        .add($fieldModel.toJson())
        .then((value) =>
            uploadImage(_imageFileList!, value.id, context, callback))
        .catchError((error) => print('Error: $error'));
  }
}

void uploadImage(
    List<XFile> _imageFileList, fieldID, context, VoidCallback callback) async {
  if (_imageFileList.isNotEmpty) {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('${FirebaseStorePath.fields}/$fieldID');

    int countImage = _imageFileList.length;
    List<String> urlDownloads = [];

    for (int i = 0; i < countImage; i++) {
      final path = _imageFileList[i].path;
      final file = File(path);
      final name = _imageFileList[i].name;

      UploadTask uploadTask = storageRef.child(name).putFile(file);

      var urlDownload = await (await uploadTask).ref.getDownloadURL();
      urlDownloads.add(urlDownload);
      if (urlDownloads.length == countImage) {
        FirebaseFirestore.instance
            .collection(FirebaseStorePath.fields)
            .doc(fieldID)
            .update({FieldModel.images: urlDownloads})
            .then((value) => {
                  callback(),
                  showDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (context) {
                        return AppDialog(
                            title: AppString.congratulation,
                            content: AppString.contentNewFieldSuccess,
                            yes: AppString.yes);
                      })
                })
            .catchError((error) => {print('Failed lin: $error'), callback()});
      }

      // });
      /*uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
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
            print('333');

            print('linhnt 3' + countImage.toString());
            if (countImage == 0) {
              print('linhnt 1 ' + urlDownloads.toString());
              print('linhnt 2 ' + urlDownloads.length.toString());
              FirebaseFirestore.instance
                  .collection(FirebaseStorePath.fields)
                  .doc(fieldID)
                  .update({'images': urlDownloads})
                  .then((value) => {
                        showDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (context) {
                              return AppDialog(
                                  title: AppString.congratulation,
                                  content: AppString.contentNewFieldSuccess,
                                  yes: AppString.yes);
                            })
                      })
                  .catchError((error) => print('Failed lin: $error'));
            }
            break;
        }
      });*/
    }
  }
}
