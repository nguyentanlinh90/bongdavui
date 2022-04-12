import 'package:bongdavui/business/firebse_helper.dart';
import 'package:bongdavui/config/theme/app_colors.dart';
import 'package:bongdavui/config/theme/app_text_styles.dart';
import 'package:bongdavui/constants/app_sizes.dart';
import 'package:bongdavui/constants/firebase_store_path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../config/routes/route_name.dart';
import '../../../widgets/stateless/button_back.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Stream<QuerySnapshot> fields = FirebaseFirestore.instance
      .collection(FirebaseStorePath.fields)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    List images = [
      'https://thegioithethao.vn/images/products_soccer/2021/04/09/large/san-bong-vov-wesport1_1617945476.jpg',
      'https://thegioithethao.vn/images/products_soccer/2021/04/09/large/san-bong-vov-wesport2_1617945469.jpg',
      'https://thegioithethao.vn/images/products_soccer/2021/04/09/large/san-bong-vov-wesport1_1617945472.jpg',
      'https://thegioithethao.vn/images/products_soccer/2021/04/09/large/san-bong-vov-wesport_1617945474.jpg'
    ];

    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
          title: Container(
            child: TextField(),
          ),
          leading: const ButtonBack(),
          actions: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(RouteName.newFieldRoute);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.s_16),
                child: Container(
                    alignment: Alignment.center,
                    child: FaIcon(
                      FontAwesomeIcons.plus,
                      size: AppSizes.s_30,
                    )),
              ),
            ),
          ]),
      body: Container(
          child: StreamBuilder<QuerySnapshot>(
        stream: fields,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error.toString());
            return Text('Something wrong \n ${snapshot.error.toString()}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          }
          final data = snapshot.requireData;
          return ListView.builder(
            itemCount: data.size,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot ds = data.docs[index]; //
              return Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /* Ink.image(
                      image: NetworkImage(ds['images'][0]),
                      height: 150,
                      fit: BoxFit.fill,
                    ),*/
                    Container(
                        margin: const EdgeInsets.all(AppSizes.s_10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Sân bóng ${ds['name']}',
                                style: AppTextStyles.h5().copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppSizes.s_20),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                FirebaseHelper.deleteDocument(
                                    data.docs[index].reference);
                              },
                              child: FaIcon(FontAwesomeIcons.trashCan),
                            )
                          ],
                        ))
                  ],
                ),
              );
            },
          );
        },
      )),
    );
  }
}
