import 'package:flutter/material.dart';
import 'package:nic/components/CardWrapper.dart';
import 'package:nic/components/ClickableContent.dart';
import 'package:nic/components/InlineList.dart';
import 'package:nic/components/MiniButton.dart';
import 'package:nic/components/PageSection.dart';
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
  List<Map<String, dynamic>> products = [
    {
      "background": Colors.orange.shade300,
      "icon": "save-heart",
      "image":
          "https://images.unsplash.com/photo-1560346740-a8678c61a524?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxNjE2NXwwfDF8c2VhcmNofDM2fHxibGFjayUyMGZhbWlseXxlbnwwfHx8fDE2ODQzNTYwNDB8MA&ixlib=rb-4.0.3&q=80&w=900",
      "name": "Life & Saving",
    },
    {
      "background": Colors.green.shade300,
      "icon": "car",
      "image":
          "https://bsmedia.business-standard.com/_media/bs/img/article/2019-05/25/full/1558730112-9901.jpg",
      "name": "Magari",
    },
    {
      "background": Colors.purple.shade300,
      "icon": "house",
      "image":
          "https://www.nicinsurance.co.tz/img/uploads/pier_files/Linda-Mjengo_1690709063.png",
      "name": "Linda Mjengo",
    },
    {
      "icon": "motorcycle",
      "image":
          "https://images.unsplash.com/photo-1625043484550-df60256f6ea5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxNjE2NXwwfDF8c2VhcmNofDZ8fG1vdG9yJTIwYmlrZXxlbnwwfHx8fDE2OTQ0MzMzNzR8MA&ixlib=rb-4.0.3&q=80&w=1080",
      "name": "Pikipiki / Bajaji",
    },
    {
      "icon": "airplane",
      "id": "UHJvZHVjdE5vZGU6MTc0",
      "image":
          "https://images.unsplash.com/photo-1544016768-982d1554f0b9?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxNjE2NXwwfDF8c2VhcmNofDI3fHxhaXJwbGFuZXxlbnwwfHx8fDE2OTk0NDk5MDl8MA&ixlib=rb-4.0.3&q=80&w=1080",
      "name": "Travel Insurance",
    },
    {
      "icon": "car",
      "id": "UHJvZHVjdE5vZGU6MjY=",
      "image":
          "https://www.nicinsurance.co.tz/img/uploads/pier_files/Motor-Insurance__1690709184.jpg",
      "name": "Bima Kubwa ya Binafsi"
    },
  ];

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
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            action.label,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            action.description!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 2,
                ),
          ),
          const SizedBox(height: 28),
          Text(
            "Product Benefits",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  // fontWeight: FontWeight.bold,
                  color: Constants.primaryColor,
                ),
          ),
          const SizedBox(height: 12),
          InlineListBuilder(
            future: () async {
              return action.extraData!["benefits"];
            },
            itemBuilder: (item) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 7, right: 12),
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
                          fontSize: 16,
                          color: colorScheme(context).onBackground,
                        ),
                        // style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        //       fontWeight: FontWeight.w600,
                        //     ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.description!,
                        style: TextStyle(
                          fontSize: 13,
                          color: colorScheme(context).onBackground,
                          height: 1.8,
                        ),
                        // style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        //       height: 1.8,
                        //     ),
                      ),
                      const Divider(thickness: 0.1, height: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
