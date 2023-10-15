import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:plant_diary/API/Auth.dart';
import 'package:plant_diary/Config/Colors.dart';
import 'package:plant_diary/Utils/Navigation.dart';
import 'package:plant_diary/Utils/ShowSnackbar.dart';
import 'package:plant_diary/Views/Login/Login.dart';
import 'package:plant_diary/Widgets/FormFields/StyledFormTextField.dart';

class RegisterTwo extends StatelessWidget {
  final String name;
  final String email;

  const RegisterTwo({Key? key, required this.name, required this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double marginX = MediaQuery.of(context).size.width * 0.06;
    double marginY = MediaQuery.of(context).size.height * 0.035;

    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                height: screenHeight,
                width: screenWidth,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/background.jpg'),
                  ),
                ),
              ),
            ),
            Center(
              child: GlassmorphicContainer(
                width: screenWidth * 0.9,
                height: screenHeight * 0.5,
                borderRadius: 20,
                blur: 4,
                alignment: Alignment.bottomCenter,
                border: 2,
                linearGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFFffffff).withOpacity(0.2),
                    const Color(0xFFFFFFFF).withOpacity(0.05),
                  ],
                ),
                borderGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFFffffff).withOpacity(0.07),
                    const Color((0xFFFFFFFF)).withOpacity(0.3),
                  ],
                ),
                // Inner Content
                child: registerStepTwo(context, marginX, marginY),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget registerStepTwo(BuildContext context, double marginX, double marginY) {
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: marginX,
        vertical: marginY,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          StyledFormTextField(
            controller: passwordController,
            isHidden: true,
            icon: Icons.person,
            hintText: 'Password',
          ),
          StyledFormTextField(
            controller: confirmPasswordController,
            isHidden: true,
            icon: Icons.email,
            hintText: 'Confirm Password',
          ),
          SizedBox(
            width: double.infinity,
            height: marginY * 1.4,
            child: ElevatedButton(
              onPressed: () {
                var password = passwordController.text.trim();
                if (password.length < 6) {
                  showSnackBar("Password must be longer than 5 characters");
                  return;
                }
                if (confirmPasswordController.text.trim() != password) {
                  showSnackBar("Password does not match");
                  return;
                }

                signUpWithEmailAndPassword(context, email, password, name);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white60,
                backgroundColor: AppColors.main,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text("SIGN UP"),
            ),
          ),
          Divider(
            thickness: 1,
            color: Colors.white60,
            height: marginY * 0.125,
          ),
          SizedBox(
            width: double.infinity,
            height: marginY * 1.5,
            child: ElevatedButton(
              onPressed: () => {},
              style: ElevatedButton.styleFrom(
                foregroundColor: AppColors.contrast,
                backgroundColor: AppColors.secoundry.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: AppColors.contrast, width: 1.0),
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    'http://pngimg.com/uploads/google/google_PNG19635.png',
                    fit: BoxFit.cover,
                    color: Colors.white60,
                  ),
                  const SizedBox(width: 5.0),
                  const Text("SIGN UP WITH GOOGLE", textAlign: TextAlign.center)
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: marginY * 1.5,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: AppColors.contrast,
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onPressed: () => navigateToNewScreen(context, Login()),
              child: const Text("Already have an account? Sign in"),
            ),
          ),
        ],
      ),
    );
  }
}
