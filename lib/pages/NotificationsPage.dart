import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:plateshare/screens/InicioScreen.dart';
import 'package:plateshare/screens/RecipeFormScreenOne.dart';
import 'package:plateshare/util/AppColors.dart';
import 'package:plateshare/widgets/RecipeContainer.dart';

import '../services/firebase_service.dart';

class NotificationsPage extends StatefulWidget {
  final String emailData;
  final String nameData;
  final String usernameData;
  final String profilePicData;
  final String userId;

  const NotificationsPage({
    Key? key,
    required this.emailData,
    required this.nameData,
    required this.usernameData,
    required this.profilePicData,
    required this.userId,
  }) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<Map<String, dynamic>> listaNotificaciones = [];

  @override
  void initState() {
    super.initState();
    getNotifications();
  }

  Future<void> getNotifications() async {
    final notificacionesDB = await getAllNotifications(widget.userId);

    notificacionesDB.sort((a, b) {
      final dateA = a['date'] as Timestamp?;
      final dateB = b['date'] as Timestamp?;

      if (dateA == null && dateB == null) {
        return 0;
      } else if (dateA == null) {
        return 1;
      } else if (dateB == null) {
        return -1;
      }

      return dateB.compareTo(dateA);
    });

    setState(() {
      listaNotificaciones = notificacionesDB;
    });
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Container(
        width: screenSize.width,
        height: screenSize.height,
        decoration: const BoxDecoration(
          color: AppColors.accentColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 50,
                  width: screenSize.width,
                  color: AppColors.primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Notificaciones',
                        style: GoogleFonts.acme(
                          textStyle: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontFamily: 'Acme',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: listaNotificaciones.map((notification) {
                    final imageUrl = notification['image'] as String?;
                    final text1 = notification['data'] as String?;
                    final text2 =
                        notification['type'] == 1 ? 'Comment' : 'Favorite';
                    final text3 = notification['date'] as Timestamp?;
                    final dateFormatter = DateFormat('yyyy-MM-dd HH:mm:ss');
                    final formattedDate = text3 != null
                        ? dateFormatter.format(text3.toDate())
                        : '';

                    final currentDate = DateTime.now();
                    final notificationDate =
                        text3 != null ? text3.toDate() : currentDate;

                    final difference = currentDate.difference(notificationDate);
                    final differenceInSeconds = difference.inSeconds;
                    final differenceInMinutes = difference.inMinutes;
                    final differenceInHours = difference.inHours;
                    final differenceInDays = difference.inDays;

                    String timeDifference;
                    if (differenceInSeconds < 60) {
                      timeDifference = '$differenceInMinutes seg';
                    } else if (differenceInMinutes < 60) {
                      timeDifference = '$differenceInMinutes min';
                    } else if (differenceInHours < 24) {
                      timeDifference = '$differenceInHours hr';
                    } else {
                      timeDifference = '$differenceInDays dias';
                    }

                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          border: Border.all(
                            color: AppColors.greyAccentColor,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            imageUrl != null
                                ? Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: imageUrl != null
                                        ? CircleAvatar(
                                            radius: 25,
                                            backgroundImage:
                                                NetworkImage(imageUrl),
                                          )
                                        : Placeholder(
                                            fallbackHeight: 50,
                                            fallbackWidth: 50,
                                          ),
                                  )
                                : SizedBox(width: 10),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 0, 5, 0),
                                    child: Text(
                                      text1 ?? '',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: GoogleFonts.acme(
                                        textStyle: const TextStyle(
                                          fontSize: 17,
                                          color: AppColors.blackColor,
                                          fontFamily: 'Acme',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      Text(timeDifference),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 5, 5, 0),
                                        child: Icon(
                                          notification['type'] == 1
                                              ? Icons.comment_outlined
                                              : Icons.favorite,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
