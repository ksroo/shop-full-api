import 'package:flutter/material.dart';
import 'package:shop_udemy/shared/network/local/cache_helper.dart';
import '/screens/login/loginScreen.dart';
import '/shared/style/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({this.image, this.title, this.body});
}

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: "assets/images/onboardin_1.png",
      title: "Screen 1 Title",
      body: "Screen 1 Body",
    ),
    BoardingModel(
      image: "assets/images/onboardin_3.png",
      title: "Screen 2 Title",
      body: "Screen 2 Body",
    ),
    BoardingModel(
      image: "assets/images/onboarding_2.png",
      title: "Screen 3 Title",
      body: "Screen 4 Body",
    ),
  ];

  bool isLast = false;

  void submit() {
    CacheHlper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: submit,
              child: Text(
                "Skip",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: boardController,
                  onPageChanged: (int index) {
                    if (index == boarding.length - 1) {
                      setState(
                        () {
                          isLast = true; 
                        },
                      );
                      print("last Done");
                    } else {
                      isLast = false;
                    }
                  },
                  itemBuilder: (context, index) {
                    return buildOnBoardingItem(boarding[index]);
                  },
                  itemCount: boarding.length,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5,
                      activeDotColor: defaultColor,
                    ),
                    controller: boardController,
                    count: boarding.length,
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {
                        boardController.nextPage(
                          duration: Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    },
                    child: Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Widget buildOnBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(
                "${model.image}",
              ),
            ),
          ),
          Text(
            "${model.title}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "${model.body}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      );
}
