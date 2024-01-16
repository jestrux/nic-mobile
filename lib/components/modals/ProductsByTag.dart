import 'package:flutter/material.dart';
import 'package:nic/components/Loader.dart';
import 'package:nic/services/product_service.dart';
import 'package:nic/utils.dart';

class ProductsByTag extends StatefulWidget {
  final String tag;
  const ProductsByTag({Key? key, required this.tag}) : super(key: key);

  @override
  State<ProductsByTag> createState() => _ProductsByTagState();
}

class _ProductsByTagState extends State<ProductsByTag> {
  List<Map<String, dynamic>>? choices;

  @override
  void initState() {
    getProducts(tag: widget.tag).then(handleProductResult);
    super.initState();
  }

  void handleProductResult(List<Map<String, dynamic>>? res) async {
    if (res == null || List.from(res).isEmpty) {
      Navigator.of(context).pop();
      return openErrorAlert(message: "Failed to fetch products");
    }

    var products = List.from(res);

    if (products.length == 1) {
      Navigator.of(context).pop(products.first);
      return;
    }

    setState(() {
      choices = List.from(res).map((product) {
        return {
          "label": product["mobileName"],
          "value": product,
        };
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (choices != null) {
      return ChoicePickerContent(
        title: "Select product",
        choices: choices!,
        confirm: true,
        mode: ChoicePickerMode.regular,
        onSelect: Navigator.of(context).pop,
      );
    }

    return const SafeArea(child: Loader());
  }
}
