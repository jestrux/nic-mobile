import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void showGetQuoteModal() {
    // const closeProductPicker = showCustomAlert({
    //     content: (
    //         <ProductPicker
    //             onSelect={(product) => {
    //                 closeProductPicker();
    //                 getQuote(product);
    //             }}
    //         />
    //     ),
    // });
  }

  void navigate() {}

  void route() {}

  Widget _buildActions() {
    List<Map<String, dynamic>> quickActions = [
      {
        "icon": "calculator",
        "name": "Get a Quote",
        "action": showGetQuoteModal,
      },
      {
        "icon": "add-file",
        "name": "Report Claim",
        "action": () {
          navigate(
              // route("claims", {
              //     "subPage": "report",
              // })
              );
        },
      },
      {
        "icon": "contract",
        "name": "Claim Status",
        "action": () {
          navigate(
              // route("claims", {
              //     "subPage": "status",
              // })
              );
        },
      },
      {
        "icon": "status",
        "name": "Bima Status",
        "action": () {
          // navigate(
          //     route("bima", {
          //         subPage: "status",
          //     })
          // );
          // let closeStatusModal;

          // closeStatusModal = showCustomAlert({
          //     content: (
          //         <div className="p-5 md:p-6">
          //             <h2 className="text-xl font-bold mb-3">
          //                 Bima status
          //             </h2>

          //             <BimaStatus onClose={() => closeStatusModal()} />
          //         </div>
          //     ),
          // });
        },
      },
      // {
      //     icon: "time",
      //     name: "Bima History",
      //     action: () {
      //         navigate(
      //             route("profile", {
      //                 subPage: "bima-history",
      //             })
      //         );
      //     },
      // },
      {
        "icon": "renewable",
        "name": "Bima Renewal",
        "action": () {
          // navigate(
          //     route("profile", {
          //         "subPage": "bima-renewal",
          //     })
          // );
        },
      },
      // {
      //     icon: "document",
      //     name: "Pending Bima",
      //     action: () {},
      // },
      // {
      //     icon: "folder",
      //     name: "Your Claims",
      //     action: () {},
      // },
      {
        "icon": "feedback",
        "name": "Feedback",
        "action": () {
          // navigate(route("feedback"));
        },
      },
      {
        "icon": "complaint",
        "name": "Complaints",
        "action": () {
          navigate(
              // route("feedback", {
              //     "subPage": "complaints",
              // })
              );
        },
      },
    ];

    return GridView(
        primary: false,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 3,
        ),
        children: quickActions
            .map(
              (action) => Container(
                color: Colors.red,
                child: Column(
                  children: [
                    Image.asset("assets/img/${action["icon"]}"),
                    Text(action['name'])
                  ],
                ),
              ),
            )
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        title: Row(
          children: [
            Image.asset(
              'assets/img/icon.png',
              width: 40,
            ),
            const SizedBox(width: 12),
            const Text("NIC Kiganjani"),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _buildActions(),
          ],
        ),
      ),
    );
  }
}
