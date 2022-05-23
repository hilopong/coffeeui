import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'util/coffee_tile.dart';
import 'util/coffee_type.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            child: Text('Find teh best coffee for you',style: GoogleFonts.bebasNeue(
              fontSize: 60
            ),),
          ),
          SizedBox(height: 25,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Find your coffee...',
                focusedBorder:OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade600)
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade600)
                )
              )
            ),
          ),
          SizedBox(height: 25,),
          Container(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                CoffeeType(coffeetype: 'latte',),
                CoffeeType(coffeetype: 'cappucino',),
                CoffeeType(coffeetype: 'black',),
              ],
            ),
          ),
          Expanded(child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              CoffeeTile(),
              CoffeeTile(),
              CoffeeTile(),
            ],
          ))
        ],

      ),
    );
  }
}