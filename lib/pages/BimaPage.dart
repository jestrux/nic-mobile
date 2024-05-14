import 'package:flutter/material.dart';
import 'package:nic/components/CardWrapper.dart';
import 'package:nic/components/ClickableContent.dart';
import 'package:nic/components/InlineList.dart';
import 'package:nic/components/MiniButton.dart';
import 'package:nic/components/PageSection.dart';
import 'package:nic/components/ProductDetail.dart';
import 'package:nic/components/RoundedHeaderPage.dart';
import 'package:nic/components/modals/GetQuote.dart';
import 'package:nic/constants.dart';
import 'package:nic/data/actions.dart';
import 'package:nic/data/providers/AppProvider.dart';
import 'package:nic/models/ActionItem.dart';
import 'package:nic/services/product_service.dart';
import 'package:nic/utils.dart';
import 'package:provider/provider.dart';

class BimaPage extends StatefulWidget {
  const BimaPage({Key? key}) : super(key: key);


  @override
  State<BimaPage> createState() => _BimaPageState();
}

class _BimaPageState extends State<BimaPage> {

  var iconMap = {
    "fire": Icons.house,
    "life": Icons.volunteer_activism,
    "vehicle": Icons.directions_car,
    "motorcycle": Icons.two_wheeler,
    "travel": Icons.flight,
  };

  Future<List<Map<String, dynamic>>?> fetchProducts() async {
    AppProvider provider = Provider.of<AppProvider>(context, listen: false);

    if (provider.products != null) return provider.products;

    var products = await getProducts();

    if (products == null) return null;

    provider.setProducts(products);

    return products;
  }

  void purchaseProduct(action) {
    handlePurchaseProduct(
      action,
      authUser: Provider.of<AppProvider>(
        context,
        listen: false,
      ).authUser,
    );
  }

  void viewProductDetail(ActionItem action) {
    openGenericPage(
      title: "Product Detail",
      subtitle: action.label,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: ProductDetail(product: action),
      okayText: " Purchase ",
      onOkay: () => purchaseProduct(action),
      cancelText: "Get a quote",
      onCancel: action.id == null
          ? null
          : () {
              openAlert(
                child: GetQuote(
                  productId: action.id!,
                ),
              );
            },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RoundedHeaderPage(
      title: "Bima Products",
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 4),
            PageSection(
              // title: "Quick Actions",
              content: [
                getQuickQuoteAction.cloneWith(background: Colors.transparent),
                bimaStatusAction,
                bimaRenewalAction,
              ],
              shape: ActionItemShape.rounded,
            ),
            const SizedBox(height: 16),
            const SectionTitle(title: "All products"),
            InlineListBuilder(
              future: fetchProducts,
              itemBuilder: (action) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: CardWrapper(
                    padding: EdgeInsets.zero,
                    child: ClickableContent(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 16,
                      ),
                      onClick: () => viewProductDetail(action),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            action.label,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const MiniButton(
                                label: "See details",
                                flat: true,
                              ),
                              const Spacer(),
                              if (action.id != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: 8,
                                  ),
                                  child: MiniButton(
                                    label: "Get a quote",
                                    onClick: () {
                                      openAlert(
                                        child: GetQuote(
                                          productId: action.id!,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              MiniButton(
                                label: " Purchase ",
                                filled: true,
                                onClick: () => purchaseProduct(action),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
