import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:plant_diary/API/Auth.dart';
import 'package:plant_diary/Config/Colors.dart';
import 'package:plant_diary/Utils/Navigation.dart';
import 'package:plant_diary/Views/Register/Register.dart';
import 'package:plant_diary/Widgets/FormFields/StyledFormTextField.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                height: screenHeight * 0.45,
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
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: marginX,
                    vertical: marginY,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      StyledFormTextField(
                        controller: emailController,
                        isHidden: false,
                        icon: Icons.email,
                        hintText: 'Enter your email',
                      ),
                      StyledFormTextField(
                        controller: passwordController,
                        isHidden: true,
                        icon: Icons.password,
                        hintText: 'Enter your password',
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: marginY * 1.4,
                        child: ElevatedButton(
                          onPressed: () async {
                            int statusCode = await signIn(
                              context,
                              emailController.text.trim(),
                              passwordController.text.trim(),
                            );
                            if (statusCode != 200) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Center(
                                      child: Text(
                                          "Email or Password are incorrect")),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white60,
                            backgroundColor: AppColors.main,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  25), // Adjust the radius as needed
                            ),
                          ),
                          child: const Text("SIGN IN"),
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
                            backgroundColor:
                                AppColors.secoundry.withOpacity(0.1),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: AppColors.contrast, width: 1.0),
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
                              const Text("SIGN IN WITH GOOGLE",
                                  textAlign: TextAlign.center)
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
                            onPressed: () =>
                                navigateToNewScreen(context, Register()),
                            child: const Text("Don't have an account? Sign up"),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
