import 'package:flutter/material.dart';

class CoffeeTile extends StatefulWidget {
  const CoffeeTile({Key? key}) : super(key: key);

  @override
  State<CoffeeTile> createState() => _CoffeeTileState();
}

class _CoffeeTileState extends State<CoffeeTile> {

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
        child: Container(
          padding: EdgeInsets.all(12),
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.black54),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                child: Image.asset('lib/images/latte.jpg'),
                borderRadius: BorderRadius.circular(12),
              ),
              Text('Latte',style: TextStyle(fontSize: 20),),
              SizedBox(height: 4,),
              Text('imageUrl'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('45.0'),
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(6)
                    ),
                    child: Icon(Icons.add),
                  )
                ],
              )
            ],
          ),
        ),

    );
  }
}
