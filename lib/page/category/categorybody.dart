import 'package:bai5/conf/const.dart';
import 'package:bai5/data/model/categorymodel.dart';
import 'package:bai5/page/product/productwidget.dart';
import 'package:flutter/material.dart';

Widget itemCateView(Category itemcate, BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProdcutWidget(
            objCat: itemcate,
          ),
        ),
      );
    },
    child: Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration:
          const BoxDecoration(color: Color.fromARGB(255, 139, 171, 231)),
      child: Container(
        width: 150,
        height: 120,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: Image.asset(urlimg + itemcate.img!, fit: BoxFit.cover),
      ),
    ),
  );
}
