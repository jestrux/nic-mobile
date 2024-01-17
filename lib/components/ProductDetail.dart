import 'package:flutter/material.dart';
import 'package:nic/components/InlineList.dart';
import 'package:nic/models/ActionItem.dart';
import 'package:nic/utils.dart';

class ProductDetail extends StatelessWidget {
  final ActionItem product;
  const ProductDetail({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   product.label,
        //   style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        //         fontSize: 20,
        //       ),
        // ),
        // const SizedBox(height: 8),
        Text(
          "About Product",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: colorScheme(context).primary,
              ),
        ),
        const SizedBox(height: 5),
        Text(
          product.description!,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                height: 2,
                color: colorScheme(context).onBackground.withOpacity(0.7),
              ),
        ),
        const SizedBox(height: 28),
        Text(
          "Product Benefits",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: colorScheme(context).primary,
              ),
        ),
        const SizedBox(height: 12),
        InlineListBuilder(
          future: () async {
            return product.extraData!["benefits"];
          },
          itemBuilder: (item) => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 5, right: 12),
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme(context).surfaceVariant,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.label,
                      style: TextStyle(
                        fontSize: 15,
                        color: colorScheme(context).onBackground,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.description!,
                      style: TextStyle(
                        fontSize: 13,
                        color:
                            colorScheme(context).onBackground.withOpacity(0.7),
                        height: 1.8,
                      ),
                    ),
                    const Divider(thickness: 0.2, height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
