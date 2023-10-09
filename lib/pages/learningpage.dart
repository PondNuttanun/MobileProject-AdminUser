import 'package:admin_mosquito_project/appbarmain.dart';
import 'package:admin_mosquito_project/maindrawer.dart';
import 'package:admin_mosquito_project/utils/colour.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Learningpage extends StatefulWidget {
  const Learningpage({super.key});

  @override
  State<Learningpage> createState() => _LearningpageState();
}

class _LearningpageState extends State<Learningpage> {
  final CollectionReference lesson =
      FirebaseFirestore.instance.collection('lesson');

  void deleteLesson(docId) {
    lesson.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMain(title: 'Lesson'),
      drawer: MainDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        backgroundColor: darkRed,
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'List Learning', // Added heading text
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: litBlack,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.83,
                child: StreamBuilder(
                    stream: lesson.orderBy('l_name').snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot lessonSnap =
                                snapshot.data.docs[index];
                            return Container(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: midGreen,
                                  ),
                                  padding: EdgeInsets.all(15),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          lessonSnap['l_imgs'],
                                          width: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              lessonSnap['l_name'],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                    color: whitePerl,
                                                  ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: whitePerl,
                                                    padding: EdgeInsets.all(8),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                  String? videoUrl =
                                                      lessonSnap['l_video'];
                                                  if (videoUrl != null) {
                                                    String? videoId =
                                                        YoutubePlayer
                                                            .convertUrlToId(
                                                                videoUrl);
                                                    if (videoId != null) {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              YoutubePlayer(
                                                            controller:
                                                                YoutubePlayerController(
                                                              initialVideoId:
                                                                  videoId,
                                                              flags:
                                                                  YoutubePlayerFlags(
                                                                autoPlay: true,
                                                                mute: false,
                                                                isLive:
                                                                    true, // Set to true to center the video
                                                                forceHD: false,
                                                                enableCaption:
                                                                    true,
                                                                // showVideoProgressIndicator:
                                                                //     true,
                                                              ),
                                                            ),
                                                            showVideoProgressIndicator:
                                                                true,
                                                            progressIndicatorColor:
                                                                darkRed,
                                                            bottomActions: [
                                                              CurrentPosition(),
                                                              ProgressBar(
                                                                  isExpanded:
                                                                      true),
                                                            ],
                                                            onReady: () {
                                                              // Add your code here if needed
                                                            },
                                                            onEnded: (data) {
                                                              // Add your code here if needed
                                                            },
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      // Handle case where videoUrl is not a valid YouTube URL
                                                    }
                                                  } else {
                                                    // Handle case where lessonSnap['l_video'] is null
                                                  }
                                                },
                                                  child: Text(
                                                    "Get started",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                          color: greenPrimary,
                                                        ),
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    Navigator.pushNamed(
                                                        context, '/update',
                                                        arguments: {
                                                          'l_name': lessonSnap[
                                                              'l_name'],
                                                          'l_video': lessonSnap[
                                                              'l_video'],
                                                          'l_imgs': lessonSnap[
                                                              'l_imgs'],
                                                          'id': lessonSnap.id,
                                                        });
                                                  },
                                                  icon: Icon(Icons.edit),
                                                  iconSize: 25,
                                                  color: whitePerl,
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    deleteLesson(lessonSnap.id);
                                                  },
                                                  icon: Icon(Icons.delete),
                                                  iconSize: 25,
                                                  color: whitePerl,
                                                ),
                                              ],
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
