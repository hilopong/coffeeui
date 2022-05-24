import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'util/coffee_tile.dart';
import 'util/coffee_tile2.dart';
import 'util/coffee_type.dart';

import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List coffeeType = [
    ['Cappucino', true],
    ['Latte', false],
    ['Black', false],
    ['Tea', false]
  ];

  List mainprdlist = [];

  void coffeeTypeSeleted(int index) {
    setState(() {
      for (var i = 0; i < coffeeType.length; i++) {
        coffeeType[i][1] = false;
      }
      coffeeType[index][1] = true;
    });
  }

  Future getprdlist() async {
    var result = await http.get(Uri.parse(
        'https://webapi.superdesk.co.kr/AdminProduct/GetPrdList/?companyidx=36'));
    var result2 = jsonDecode(result.body);
    setState(() {
      mainprdlist = result2;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getprdlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Icon(Icons.menu),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Icon(Icons.person),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ''),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'Find teh best coffee for you',
              style: GoogleFonts.bebasNeue(fontSize: 60),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Find your coffee...',
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade600)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade600)))),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
              height: 40,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: coffeeType.length,
                  itemBuilder: (context, index) {
                    return CoffeeType(
                      coffeetype: coffeeType[index][0],
                      isSelected: coffeeType[index][1],
                      onTab: () {
                        coffeeTypeSeleted(index);
                      },
                    );
                  })),
          Expanded(
              child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: mainprdlist.length,
            itemBuilder: (context, index) {
              print(mainprdlist[index]['NVC_prdName']);
              return CoffeeTile2(
                imgurl: mainprdlist[index]['C_prdNo'],
                prdname: mainprdlist[index]['NVC_prdName'],
                catename: coffeeType[0][0],
                price: mainprdlist[index]['I_discountPrice'],
              );
            },
          ))
        ],
      ),
    );
  }
}
