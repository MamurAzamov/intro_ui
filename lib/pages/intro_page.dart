import 'package:flutter/material.dart';
import 'package:intro_ui/pages/home_page.dart';

import '../utils/Strings.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);
  static final String id = 'intro_page';

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final int _numPage = 3;

  late PageController _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
    );
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            onPageChanged: (int page){
              setState(() {
                currentIndex = page;
              });
          },
            controller: _pageController,
            children: [
              makePage(
                title: Strings.stepOneTitle,
                image: "assets/images/image_1.png",
                content: Strings.stepOneContent,
              ),

              makePage(
                image: "assets/images/image_2.png",
                title: Strings.stepTwoTitle,
                content: Strings.stepTwoContent,
              ),

              makePage(
                image: "assets/images/image_3 (1).png",
                title: Strings.stepThreeTitle,
                content: Strings.stepThreeContent,
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(bottom: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildIndicator(),
            ),
          ),
        ],
      ),
      bottomSheet: currentIndex == _numPage -1
        ? Container(
        margin: EdgeInsets.only(bottom: 50),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.end,
           children: [
             GestureDetector(
               onTap: () => Navigator.pushReplacementNamed(context, HomePage.id),
               child: Row(
                   children: const [
                     Padding(
                       padding: EdgeInsets.only(right: 20,),
                        child: Text("Skip", style: TextStyle(color: Colors.red, fontSize: 18),),
                     )
                   ]
               ),
             )
           ],
        ),
      )
          : Text("")
    );
  }
  
  Widget makePage({title, image, content}){
    return Container(
      padding: EdgeInsets.only(left: 50, right: 50, bottom: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(title, style: TextStyle(color: Colors.red, fontSize: 30, fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              Text(content, style: TextStyle(color: Colors.grey, fontSize: 20),textAlign: TextAlign.center,),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(image),
              ),
            ],
          )
        ],
      ),
    );
  }
  Widget _indicator(bool isActive){
    return AnimatedContainer(
        duration: Duration(milliseconds: 300),
      height: 6,
      width: isActive ? 30:6,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: isActive ? Colors.red: Colors.red[200],
        borderRadius: BorderRadius.circular(5)
      ),
    );
  }

  List<Widget> _buildIndicator(){
    List<Widget> indicators = [];

    for(int i=0; i<_numPage; i++){
      if(currentIndex == i){
        indicators.add(_indicator(true));
      }else{
        indicators.add(_indicator(false));
      }
    }
    return indicators;
  }
}
