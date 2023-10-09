import 'package:admin_mosquito_project/appbarmain.dart';
import 'package:admin_mosquito_project/maindrawer.dart';
import 'package:admin_mosquito_project/utils/colour.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Userspage extends StatefulWidget {
  const Userspage({super.key});

  @override
  State<Userspage> createState() => _UserspageState();
}

class _UserspageState extends State<Userspage> {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  void deleteUsers(docId) {
    users.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMain(title: 'Users'),
      drawer: MainDrawer(),
      body: SafeArea(
        child: StreamBuilder(
            stream: users.orderBy('name').snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot usersSnap = snapshot.data.docs[index];
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: whitePerl,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 10,
                                spreadRadius: 5,
                              ),
                            ]),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                    usersSnap['image_url'],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  usersSnap['name'],
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: litBlack,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  usersSnap['email'],
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: litBlack,
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Text('Signed in with ${usersSnap['provider']}',
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: litBlack,
                                    fontSize: 15
                                  ),
                                ),
                              ],
                            ),
                            // Row(
                            //   children: [
                            //     IconButton(
                            //       onPressed: () {},
                            //       icon: Icon(Icons.delete),
                            //       iconSize: 30,
                            //       color: Colors.grey,
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return Container();
            }),
      ),
    );
  }
}
