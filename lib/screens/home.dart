import 'package:flutter/material.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final PageController _pageController = PageController();
  int _currentIndex = 0;
  int _selectedCardIndex = 0;


  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onSwipeLeft() {
    if (_currentIndex < 4 - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void _onSwipeRight() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void _onCardTapped(int index) {
    setState(() {
      _selectedCardIndex = index;
    });
  }



  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);

    final List<String> images = [
      'images/20-0.jpg',
      'images/21-0.jpg',
      'images/30-0.jpg',
      'images/42-0.jpg',
    ];

    final List<Widget> cards = images.map((image) {
      return Card(
        child: GestureDetector(
          onTap: () => _onCardTapped(images.indexOf(image)),
          child: Container(
            width: mediaquery.size.width * 0.4,
            height: mediaquery.size.height * 0.5,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage(image),
              )
            ),
          ),
        ),
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('MenuBar'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.green.shade100,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  width: mediaquery.size.width * 0.3,
                  height: mediaquery.size.height * 0.3,
                  child: GestureDetector(
                    onHorizontalDragEnd: (DragEndDetails details) {
                      if (details.primaryVelocity! > 0) {
                        _onSwipeRight();
                      } else if (details.primaryVelocity! < 0) {
                        _onSwipeLeft();
                      }
                    },
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: _onPageChanged,
                      scrollDirection: Axis.horizontal,
                      children: cards.map((card) {
                        return Container(
                          padding: const EdgeInsets.all(20.0),
                          child: card,
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Container(
                  color: Colors.green.shade100,
                  width: mediaquery.size.width,
                  alignment: Alignment.center,
                  child: _selectedCardIndex < images.length
                      ? Image.asset(
                        images[_selectedCardIndex],
                        width: mediaquery.size.width * 0.51,
                        height: mediaquery.size.height * 0.5,
                      )
                      : const Text('No Item is selected')
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}