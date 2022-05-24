import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'util/coffee_tile.dart';
import 'util/coffee_tile2.dart';
import 'util/coffee_type.dart';

import 'package:http/http.dart' as http;
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List coffeeType = [];

  List mainprdlist = [];

  void coffeeTypeSeleted(int index) {
    setState(() {
      for (var i = 0; i < coffeeType.length; i++) {
        coffeeType[i][1] = false;
      }
      coffeeType[index][1] = true;
    });
  }

  Future getprdlist(int catecode) async {
    var result = await http.get(Uri.parse(
        'https://webapi.superdesk.co.kr/AdminProduct/GetPrdList/?companyidx=' +
            catecode.toString()));
    var result2 = jsonDecode(result.body);
    print(result2);
    setState(() {
      mainprdlist = result2;
    });
  }

  Future getcatelist() async {
    var result = await http.get(Uri.parse(
        'https://webapi.superdesk.co.kr/AdminProduct/GetOutChannelCateMap'));
    var result2 = jsonDecode(result.body);
    setState(() {
      coffeeType = [];
      for (int i = 0; i < result2.length; i++) {
        var tempdata = [
          result2[i]['OrginName'],
          false,
          result2[i]['OrginCate']
        ];
        if (i == 0) {
          tempdata = [
            result2[i]['OrginName'],
            true,
            result2[i]['OrginCate'],
          ];
        }
        coffeeType.add(tempdata);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcatelist();
    getprdlist(36);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      bottomNavigationBar: CurvedNavigationBar(
        //height: 50,
        backgroundColor: Colors.transparent,
        color: Colors.orange,
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) {
          print(index);
        },
        items: [
          Icon(
            Icons.home,
            color: Colors.white,
          ),
          Icon(Icons.favorite, color: Colors.white),
          Icon(Icons.settings, color: Colors.white),
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
                onTap: () {
                  print('here');
                  var tempcatecode = mainprdlist[index]['OrginCate'];
                  print(tempcatecode);
                  getprdlist(tempcatecode);
                },
              );
            },
          ))
        ],
      ),
    );
  }
}
