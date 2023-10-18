import 'package:flutter/material.dart';
import 'widgets/keypad.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TP clavier qui fait des images',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1b3b6f)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'TP clavier qui fait des images'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool isKeyboardOpen = false;
  int? currentImage;

  void updateCurrentImage(int newImage) {
    setState(() {
      currentImage = newImage;
    });
  }

  void toggleKeyboard() {
    setState(() {
      isKeyboardOpen = !isKeyboardOpen;
    });
  }

  List<Image> imgList = <Image>[
    for (int i = 0; i < 10; i++)
      Image.network('https://picsum.photos/id/${i*10}/500/500', width: 500, height: 500,)
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF9eb3c2),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            const Spacer(),

            Text(
              '${currentImage ?? '0'}',
              style: const TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
              )
            ),

            const Spacer(),

            isKeyboardOpen ? KeyPad(
                onPressed: updateCurrentImage,
                selectedKey: currentImage != null ? currentImage! : 0,
            ) :
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Center(
                child: imgList[currentImage != null ? currentImage! : 0]
              ),
            )

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          toggleKeyboard();
        },
        tooltip: 'Increment',
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.panorama_outlined, color: Colors.white,),
      ),
    );
  }
}
