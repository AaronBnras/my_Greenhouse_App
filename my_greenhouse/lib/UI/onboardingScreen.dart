// ignore_for_file: file_names

import 'package:flutter/material.dart';

// import 'package:my_greenhouse/UI/root-page.dart';
import 'package:my_greenhouse/UI/screens/Sign_in.dart';
import 'package:my_greenhouse/constants.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int currentindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 20),
            child: InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => const SignIn()));
              },
              child: const Text(
                'skip',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            onPageChanged: (int page) {
              setState(() {
                currentindex = page;
              });
            },
            controller: _pageController,
            children: [
              createPage(
                image: 'assets/images/black-farmer-picking-up-vegitables.png',
                title: Constants.titleOne,
                description: Constants.descriptionOne,
              ),
              createPage(
                image: 'assets/images/Intro-2.png',
                title: Constants.titleTwo,
                description: Constants.descriptionTwo,
              ),
              createPage(
                image:
                    'assets/images/black-farmer-picking-up-vegetables-and-welcoming-with-thumbs-up.png',
                title: Constants.titleThree,
                description: Constants.descriptionThree,
              ),
              createPage(
                image:
                    'assets/images/black-farmer-welcoming-with-thumbs-up.png',
                title: Constants.titleFour,
                description: Constants.descriptionFour,
              )
            ],
          ),
          Positioned(
            bottom: 80,
            left: 30,
            child: Row(
              children: _buildIndicator(),
            ),
          ),
          Positioned(
              bottom: 60,
              right: 30,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Constants.primaryColor),
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        if (currentindex < 3) {
                          currentindex++;
                          if (currentindex < 4) {
                            _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                          }
                        } else {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const SignIn()));
                        }
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      size: 34,
                      color: Colors.white,
                    )),
              ))
        ],
      ),
    );
  }

//creating the indicator description Widget
  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 10.0,
      width: isActive ? 20 : 0,
      margin: const EdgeInsets.only(right: 5.0),
      decoration: BoxDecoration(
          color: Constants.primaryColor,
          borderRadius: BorderRadius.circular(5)),
    );
  }

//create the indicator list
  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];

    for (int i = 0; i < 3; i++) {
      if (currentindex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }

    return indicators;
  }
}

// ignore: camel_case_types
class createPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const createPage({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 50, right: 50, bottom: 80),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          height: 350,
          child: Image.asset(image),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Constants.primaryColor,
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 20),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w400, color: Colors.grey),
        ),
        const SizedBox(
          height: 20,
        ),
      ]),
    );
  }
}
