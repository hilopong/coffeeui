import 'package:flutter/material.dart';

class CoffeeTile2 extends StatelessWidget {
  final String imgurl;
  final String prdname;
  final String catename;
  final int price;

  const CoffeeTile2({
    Key? key,
    required this.imgurl,
    required this.prdname,
    required this.catename,
    required this.price
  }) : super(key: key);

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
              //child: Image.asset('lib/images/latte.jpg'),
              child: Image.network(
                  'https://webapi.superdesk.co.kr/Content/Prd/PrdOrigin/' +
                      imgurl +
                      '.jpg'),
              borderRadius: BorderRadius.circular(12),
            ),
            Text(
              catename,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 4,
            ),
            Text(prdname),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(price.toString()),
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(6)),
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
