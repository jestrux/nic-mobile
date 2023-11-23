import 'package:flutter/material.dart';
import 'package:nic/components/Loader.dart';
import 'package:nic/components/modals/InitialProductForm.dart';
import 'package:nic/services/product_service.dart';
import 'package:nic/utils.dart';

class ProductsByTag extends StatefulWidget {
  final String tag;
  const ProductsByTag({Key? key, required this.tag}) : super(key: key);

  @override
  State<ProductsByTag> createState() => _ProductsByTagState();
}

class _ProductsByTagState extends State<ProductsByTag> {
  @override
  void initState() {
    fetchProducts();
    super.initState();
  }

  void purchaseProduct(product) {
    openAlert(
      title: "Purchase ${product['mobileName']}",
      child: InitialProductForm(
        productId: product['id'],
        productName: product['mobileName'],
      ),
    );
  }

  void fetchProducts() async {
    var res = await getProducts(tag: widget.tag);

    Navigator.of(context).pop();

    if (res == null || List.from(res).isEmpty) {
      return openErrorAlert(message: "Failed to fetch products");
    }

    var products = List.from(res);

    if (products.length == 1) {
      return purchaseProduct(products.first);
    }

    var choices = List.from(res).map((product) {
      return {
        "label": product["mobileName"],
        "value": product,
      };
    }).toList();

    var product = await showChoicePicker(
      title: "Select product",
      choices: choices,
      mode: ChoicePickerMode.alert,
      confirm: true,
    );

    if (product != null) purchaseProduct(product);
  }

  @override
  Widget build(BuildContext context) {
    return const Loader();
  }
}
