import 'package:companionapp/utilities/gradients/home_page_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
      useMaterial3: true,
    ),
    home: const HomePageView(),
  ));
}

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color.fromARGB(255, 0, 0, 0),
          ),
          title: const Text(
            'Companion',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor:
              Color.fromARGB(255, 46, 49, 88) //Color.fromARGB(94, 79, 78, 93),
          ),
      drawer: Drawer(
          backgroundColor: const Color(0xFF292C55),
          child: ListView(
            children: [
              const SizedBox(
                height: 50,
              ),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Mood Tracker",
                    style: TextStyle(color: Colors.white),
                  )),
              TextButton(
                  onPressed: () {},
                  child: const Text("Journal",
                      style: TextStyle(color: Colors.white))),
              TextButton(
                  onPressed: () {},
                  child: const Text("Meditation",
                      style: TextStyle(color: Colors.white))),
              TextButton(
                  onPressed: () {},
                  child: const Text("Log Out",
                      style: TextStyle(color: Colors.white))),
            ],
          )),
      body: Container(
        decoration: const BoxDecoration(
          gradient: homePageGradient,
        ),
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 30, 0, 15),
            child: Center(
              child: Text("Good Morning, User",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  )),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 200,
            child: Container(
              //width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Color(0xFF292C55),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(2, 2), blurRadius: 6, spreadRadius: 1)
                  ]),
              child: Center(
                  child: const Text("Lorem Ipsum",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "how are you feeling?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.end,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 100,
                  child: Container(
                    //width: MediaQuery.of(context).size.width,
                    //height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      //color: Color(0xFF292C55),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.black.withOpacity(0.25),
                      //     spreadRadius: 0,
                      //     blurRadius: 4,
                      //     offset:
                      //         Offset(0, 0), // changes x,y position of shadow
                      //   )
                      // ],
                    ),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // IconButton(
                        //     onPressed: () {},
                        //     icon: const Icon(
                        //       Icons.face,
                        //       size: 70,
                        //       color: Colors.white,
                        //     )),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.face_2,
                              size: 70,
                              color: Colors.white,
                            )),
                        // IconButton(
                        //     onPressed: () {},
                        //     icon: const Icon(
                        //       Icons.face_3,
                        //       size: 70,
                        //       color: Colors.white,
                        //     )),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.face_4,
                              size: 70,
                              color: Colors.white,
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.face_5,
                              size: 70,
                              color: Colors.white,
                            )),
                      ],
                    )),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text(
                      "Journal",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color(0xFF292C55),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(255, 0, 0, 0),
                                offset: Offset(2, 2),
                                blurRadius: 6,
                                spreadRadius: 1)
                          ],
                        ),
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.book_outlined,
                              size: 100,
                              color: Colors.white,
                            )),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      "Meditate",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color(0xFF292C55),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(255, 0, 0, 0),
                                offset: Offset(2, 2),
                                blurRadius: 6,
                                spreadRadius: 1)
                          ],
                        ),
                        child: Icon(
                          Icons.bed_rounded,
                          size: 100,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
