import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Info App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NamePage(),
    );
  }
}

class NamePage extends StatefulWidget {
  @override
  _NamePageState createState() => _NamePageState();
}

class _NamePageState extends State<NamePage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  AnimationController? _animationController;
  Animation<double>? _nameOpacityAnimation;
  Animation<Offset>? _nameSlideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _nameOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _nameSlideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: Interval(0.5, 1.0, curve: Curves.easeInOut),
      ),
    );

    _animationController!.forward();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _navigateToNextPage() {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your name')),
      );
    } else {
      Navigator.of(context)
          .push(_createRoute(StudentIdPage(_nameController.text)));
    }
  }

  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Name'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
              position: _nameSlideAnimation!,
              child: FadeTransition(
                opacity: _nameOpacityAnimation!,
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _navigateToNextPage,
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

class StudentIdPage extends StatefulWidget {
  final String name;

  StudentIdPage(this.name);

  @override
  _StudentIdPageState createState() => _StudentIdPageState();
}

class _StudentIdPageState extends State<StudentIdPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _idController = TextEditingController();
  AnimationController? _animationController;
  Animation<double>? _idOpacityAnimation;
  Animation<Offset>? _idSlideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _idOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _idSlideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: Interval(0.5, 1.0, curve: Curves.easeInOut),
      ),
    );

    _animationController!.forward();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    _idController.dispose();
    super.dispose();
  }

  void _navigateToThankYouPage() {
    if (_idController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your student ID')),
      );
    } else {
      Navigator.of(context)
          .push(_createRoute(ThankYouPage(widget.name, _idController.text)));
    }
  }

  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Student ID'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Hello, ${widget.name}!'),
            SizedBox(height: 20),
            SlideTransition(
              position: _idSlideAnimation!,
              child: FadeTransition(
                opacity: _idOpacityAnimation!,
                child: TextField(
                  controller: _idController,
                  decoration: InputDecoration(
                    labelText: 'Student ID',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _navigateToThankYouPage,
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

class ThankYouPage extends StatelessWidget {
  final String name;
  final String studentId;

  ThankYouPage(this.name, this.studentId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thank You'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Thank You, $name!',
                  textStyle: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                  speed: const Duration(milliseconds: 200),
                ),
              ],
              totalRepeatCount: 1,
              pause: const Duration(milliseconds: 1000),
              displayFullTextOnTap: true,
              stopPauseOnTap: true,
            ),
            SizedBox(height: 20),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Your Student ID is $studentId',
                  textStyle: TextStyle(
                    fontSize: 24.0,
                  ),
                  speed: const Duration(milliseconds: 200),
                ),
              ],
              totalRepeatCount: 1,
              pause: const Duration(milliseconds: 1000),
              displayFullTextOnTap: true,
              stopPauseOnTap: true,
            ),
          ],
        ),
      ),
    );
  }
}
