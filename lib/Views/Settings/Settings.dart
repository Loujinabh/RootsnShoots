import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plant_diary/API/Auth.dart';
import 'package:plant_diary/Config/Colors.dart';
import 'package:plant_diary/Utils/Navigation.dart';
import 'package:plant_diary/Views/Login/Login.dart';
import 'package:plant_diary/Widgets/PageHelpers/SettingsRow.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final String name = "Loujin AbuHejleh";
  final String email = "loujin.abh@gmail.com";
  bool notificationsSwitch = false;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double marginX = MediaQuery.of(context).size.width * 0.06;
    double marginY = MediaQuery.of(context).size.height * 0.035;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFB7E6B9), Color(0xFFF5D8A8)]),
        ),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.3,
              width: screenWidth,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: screenHeight * 0.25,
                      width: screenWidth,
                      decoration: const BoxDecoration(
                        color: Colors.white60,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: marginY * 1.7),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () =>
                                              Navigator.of(context).pop(),
                                          child: Icon(
                                            Icons.keyboard_double_arrow_left,
                                            color: AppColors.secoundry,
                                            size: screenHeight * 0.045,
                                          ),
                                        ),
                                        Text(
                                          "Settings",
                                          style: TextStyle(
                                            fontSize: screenHeight * 0.037,
                                            fontWeight: FontWeight.w900,
                                            color: AppColors.secoundry,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: screenHeight * 0.145,
                            width: screenWidth * 0.32,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                    height: screenHeight * 0.125,
                                    width: screenWidth * 0.271,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: AppColors.secoundry,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "LA",
                                        style: TextStyle(
                                          fontSize: screenHeight * 0.058,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.contrast,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    height: screenHeight * 0.048,
                                    width: screenWidth * 0.105,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(
                                        width: 3,
                                        color: Colors.white60,
                                        strokeAlign:
                                            BorderSide.strokeAlignOutside,
                                      ),
                                      color: AppColors.secoundry,
                                    ),
                                    child: GestureDetector(
                                      onTap: () => {},
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 1.8),
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: AppColors.iconcolor,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: marginY * 1.3,
                                width: screenWidth * 0.5,
                                child: ElevatedButton(
                                  onPressed: () => {},
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white60,
                                    backgroundColor:
                                        AppColors.secoundry.withOpacity(0.70),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  child: Text(
                                    name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenHeight * 0.0215,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: marginY * 0.2,
                              ),
                              SizedBox(
                                height: marginY * 1.3,
                                width: screenWidth * 0.5,
                                child: ElevatedButton(
                                  onPressed: () => {},
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white60,
                                    backgroundColor:
                                        AppColors.secoundry.withOpacity(0.70),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  child: Text(
                                    email,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenHeight * 0.0215,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: marginY),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.contrast,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(25)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: marginY, horizontal: marginX * 1.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SettingsRow(
                          title: "Language",
                          buttonFunction: () {},
                        ),
                        SettingsRow(
                          title: "Notifications",
                          customButton: CupertinoSwitch(
                            thumbColor: AppColors.contrast,
                            activeColor: AppColors.secoundry,
                            trackColor: AppColors.thridry,
                            value: notificationsSwitch,
                            onChanged: (value) {
                              setState(() {
                                notificationsSwitch = value;
                              });
                            },
                          ),
                        ),
                        SettingsRow(
                          title: "Help",
                          buttonFunction: () {},
                        ),
                        SettingsRow(
                          title: "Terms & Services",
                          buttonFunction: () {},
                        ),
                        SettingsRow(
                          title: "Log Out",
                          buttonFunction: () {
                            signOut();
                            Navigator.of(context).popUntil((route) => false);
                            navigateToNewScreen(context, Login());
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
