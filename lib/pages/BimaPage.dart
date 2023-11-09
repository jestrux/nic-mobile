import 'package:flutter/material.dart';
import 'package:nic/components/ActionCard.dart';
import 'package:nic/components/ListItem.dart';
import 'package:nic/components/PageSection.dart';
import 'package:nic/utils.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      // backgroundColor: Constants.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Bima Products".toUpperCase(),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        height: double.infinity,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: colorScheme(context).background,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 4),
              const PageSection(
                // title: "Quick Actions",
                actions: [
                  {
                    "icon": "calculator",
                    "name": "Get a Quick Quote",
                  },
                  {
                    "icon": "status",
                    "name": "Bima Status",
                  },
                  {
                    "icon": "renewable",
                    "name": "Bima Renewal",
                  },
                ],
                shape: ActionCardShape.rounded,
              ),
              const SizedBox(height: 16),
              const SectionTitle(title: "All products"),
              ...products.map((product) {
                return ListItem(
                  margin: const EdgeInsets.only(top: 4, bottom: 6),
                  image: product["image"],
                  leading: product["icon"],
                  title: product["name"],
                  action: const {"label": "Purchase"},
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
