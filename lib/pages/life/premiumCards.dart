import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nic/components/InlineList.dart';
import 'package:nic/components/ListItem.dart';
import 'package:nic/components/RoundedHeaderPage.dart';
import 'package:nic/models/ActionButton.dart';
import 'package:nic/models/ActionItem.dart';
import 'package:nic/models/life/premiumCardModel.dart';
import 'package:nic/services/life/premium_cards.dart';

class PremiumCard extends StatefulWidget {
  final String policyNumber;
  final String policyId;
  final String checkNumber;
  final String product;
  final String customer;
  final String sumInsured;
  const PremiumCard(
      {super.key,
      required this.policyNumber,
      required this.policyId,
      required this.checkNumber,
      required this.product,
      required this.customer,
      required this.sumInsured});

  @override
  State<PremiumCard> createState() => _PremiumCardState();
}

class _PremiumCardState extends State<PremiumCard> {
  List<PremiumCardModel> premiumCards = [];
  @override
  void initState() {
    // TODO: implement initState
    // getPolicyPremiumCards(policyId: widget.policyId);

    fetchPremiumCards();
    super.initState();
  }

  Future fetchPremiumCards() async {
    try {
      premiumCards = await getPolicyPremiumCards(policyId: widget.policyId);
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RoundedHeaderPage(
      title: "Contributions",
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          children: [
            const InlineList(
              title: "Summary",
              data: [],
            ),
            InlineList(data: [
              ActionItem(label: "Customer", description: widget.customer),
              ActionItem(label: "Product", description: widget.product),
              // ActionItem(label: "Sum Insured", description: widget.sumInsured),
            ]),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  for (int index = 0; index < premiumCards.length; index++)
                    Card(
                      elevation: 1,
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: [
                                Text("${index + 1}."),
                                Container(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text(
                                    DateFormat.yMMMM().format(
                                      DateTime.parse(premiumCards[index]
                                              .allocation
                                              ?.allocationDate ??
                                          DateTime.now().toString()),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                NumberFormat.currency(
                                        locale: 'en_US', symbol: '')
                                    .format(premiumCards[index].amount ?? 0),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
