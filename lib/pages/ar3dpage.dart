import 'package:admin_mosquito_project/appbarmain.dart';
import 'package:admin_mosquito_project/maindrawer.dart';
import 'package:admin_mosquito_project/utils/colour.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AR3Dpage extends StatefulWidget {
  const AR3Dpage({super.key});

  @override
  State<AR3Dpage> createState() => _AR3DpageState();
}

class _AR3DpageState extends State<AR3Dpage> {
  final CollectionReference ar3d =
      FirebaseFirestore.instance.collection('ar3d');

  void deleteAR3D(docId) {
    ar3d.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMain(title: 'AR 3D Model'),
      drawer: MainDrawer(),
      body: StreamBuilder(
          stream: ar3d.orderBy('ar_name').snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot ar3dSnap = snapshot.data.docs[index];
                  return Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(25, 15, 25, 25),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: darkRed,
                        ),
                        padding: EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Expanded(
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: NetworkImage(
                                  ar3dSnap['ar_imgs'],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    ar3dSnap['ar_name'],
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: whitePerl,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic,
                                        ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: whitePerl,
                                      padding: EdgeInsets.all(8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: () async {
                                      if (await canLaunch(ar3dSnap['ar_url'])) {
                                        await launch(ar3dSnap['ar_url']);
                                      } else {
                                        throw 'Could not launch ${ar3dSnap['ar_url']}';
                                      }
                                    },
                                    child: Text(
                                      "View Model",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: greenPrimary,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return Container();
          }),
    );
  }
}
