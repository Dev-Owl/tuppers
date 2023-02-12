import 'package:flutter/material.dart';
import 'package:tuppers/tuppers_grid.dart';

final kSelf = BigInt.parse(
    '960939379918958884971672962127852754715004339660129306651505519271702802395266424689642842174350718121267153782770623355993237280874144307891325963941337723487857735749823926629715517173716995165232890538221612403238855866184013235585136048828693337902491454229288667081096184496091705183454067827731551705405381627380967602565625016981482083418783163849115590225610003652351370343874461848378737238198224849863465033159410054974700593138339226497249461751545728366702369745461014655997933798537483143786841806593422227898388722980000748404719');

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const title = "Tupper's self-referential formula Demo";
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: title),
      debugShowCheckedModeBanner: false,
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
  late final TextEditingController controller;
  BigInt currentK = kSelf;

  @override
  void initState() {
    controller = TextEditingController(text: kSelf.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final grid = Size(size.width - 15, (size.width - 15) / 106 * 17);
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                helperText: 'Input k',
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(5),
                  child: IconButton(
                    onPressed: () => controller.text = "0",
                    icon: const Icon(
                      Icons.clear,
                    ),
                  ),
                ),
              ),
              controller: controller,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                final newK = BigInt.tryParse(value ?? "0", radix: 10);
                if (newK == null) {
                  return "Not a valid number";
                }
                return null;
              },
            ),
            const Padding(padding: EdgeInsets.only(top: 15)),
            TuppersGrid(
              controller: controller,
              currentK: currentK,
              girdSize: grid,
            )
          ],
        ),
      ),
    );
  }
}
