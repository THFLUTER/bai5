import 'package:bai5/data/model/categorymodel.dart';
import 'package:bai5/data/model/productmodel.dart';
import 'package:bai5/data/provider/productprovider.dart';
import 'package:bai5/page/product/productbody.dart';
import 'package:flutter/material.dart';

class ProdcutWidget extends StatefulWidget {
  final Category objCat;
  const ProdcutWidget({Key? key, required this.objCat}) : super(key: key);

  @override
  State<ProdcutWidget> createState() => _ProdcutWidgetState();
}

class _ProdcutWidgetState extends State<ProdcutWidget> {
  List<Product> lstProduct = [];

  Future<String> loadProdList(int catId) async {
    lstProduct = await ReadData().loadDataByCat(catId) as List<Product>;
    return '';
  }

  @override
  void initState() {
    super.initState();
    loadProdList(widget.objCat.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('product list ${widget.objCat.name.toString().toUpperCase()}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
            future: loadProdList(widget.objCat.id!),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              return GridView.builder(
                  itemCount: lstProduct.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 8),
                  itemBuilder: (context, index) {
                    return itemGridview(lstProduct[index]);
                  });
            }),
      ),
    );
  }
}
