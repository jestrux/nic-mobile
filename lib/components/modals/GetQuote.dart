import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nic/components/ChoiceItem.dart';
import 'package:nic/components/DynamicForm.dart';
import 'package:nic/components/FormActions.dart';
import 'package:nic/components/KeyValueView.dart';
import 'package:nic/components/Loader.dart';
import 'package:nic/data/products.dart';
import 'package:nic/models/policy_model.dart';
import 'package:nic/services/data_connection.dart';
import 'package:nic/services/policy_service.dart';
import 'package:nic/services/product_service.dart';
import 'package:nic/utils.dart';

// void useQuoteHelpers = () {
//     // const { showAlert, showCustomAlert, showAlertLoader } = useAppContext();

//     const { mutateAsync: initiateQuotationForm } = useAPIMutation({
//         query: r"""mutation ($product: ID!, $underwriteChannel: Int!) {
//             initiateQuotationForm(product: $product, underwriteChannel: $underwriteChannel){
//               success
//               data
//               product
//               quote
//               message
//             }
//           }""",
//     });

//     const { mutateAsync: getQuotationForm } = useAPIMutation({
//         query: r"""query ($product: Int!, $underwriteChannel: Int!) {
//             quotationForm(product: $product, underwriteChannel: $underwriteChannel)
//         }
//         """,
//     });

//     const { mutateAsync: submitQuotationForm } = useAPIMutation({
//         query: r"""mutation($product: ID!, $quote: Int!, $data: JSONString!, $underwriteChannel: Int!){
//             quote(product:$product,quote: $quote,data: $data, underwriteChannel: $underwriteChannel){
//                 success
//                 message
//                 premium
//                 totalPremium
//                 propertyName
//                 sumInsured
//             }
//         }""",
//     });

//     const getQuote = async (Map<String, dynamic> _product) => {
//         const productId = _product["id;"]
//         const hideLoader = showAlertLoader();

//         const submitQuote = async ({ fullName, phoneNumber, ...payload }) => {
//             const res = await submitQuotationForm(payload);

//             if (!res.quote?.success) {
//                 hideLoader();

//                 showAlert({
//                     title: "Error!",
//                     message:
//                         "Failed to fetch quotation. Please try again later.",
//                 });
//             }

//             const { totalPremium, premium, sumInsured = 0 } = res.quote;

//             if (phoneNumber) {
//                 const message = [
//                     """Hey ${
//                         fullName.split(" ")[0]
//                     }. Here's the quote your requested for ${
//                         _product["name"]
//                     }:\n\n""",
//                     """Premium: TZS ${Number(premium)?.toLocaleString()}\n""",
//                     sumInsured > 0
//                         ? """Sum Insured: TZS ${sumInsured?.toLocaleString()}\n"""
//                         : "",
//                     """Total Premium: TZS ${totalPremium?.toLocaleString()}""",
//                     """\n\nTo get more quotes click here:\n$link""",
//                 ].join("");

//                 sendSMS({
//                     endpoint: "/?getQuote",
//                     customer_number: null,
//                     phone_number: phoneNumber,
//                     message,
//                 });
//             }

//             hideLoader();

//             return showCustomAlert({
//                 content: <QuoteModal {...res.quote} />,
//             });
//         };

//         let res = await initiateQuotationForm({
//             product: productId,
//         });

//         if (!res.initiateQuotationForm?.success) {
//             return showAlert({
//                 title: "Error!",
//                 message: "Failed to fetch quotation. Please try again later.",
//             });
//         }

//         const { quote, product } = res.initiateQuotationForm;
//         const quotationFormRes = await getQuotationForm({
//             product,
//         });

//         if (!quotationFormRes.quotationForm) {
//             return showAlert({
//                 title: "Error!",
//                 message: "Failed to fetch quotation. Please try again later.",
//             });
//         }

//         const quotationForm = JSON.parse(
//             JSON.parse(quotationFormRes.quotationForm)
//         );

//         const formFields = [
//             {
//                 name: "fullName",
//                 label: "Full Name",
//                 placeholder: "E.g. Juma Hamisi",
//             },
//             {
//                 name: "phoneNumber",
//                 label: "Phone number",
//             },
//             ...(quotationForm?.[0].fields ?? []),
//         ];

//         if (!formFields?.length) {
//             return submitQuote({
//                 product: productId,
//                 quote,
//                 data: "{}",
//             });
//         }

//         hideLoader();

//         showCustomAlert({
//             size: "lg",
//             content: (
//                 <div className="p-5 md:p-6">
//                     <h2 className="text-xl font-bold mb-3">
//                         Provide some details
//                     </h2>

//                     <DynamicForm
//                         noGroups
//                         fullWidthFields
//                         submitButtonText="Submit"
//                         fields={formFields}
//                         onSubmit={async ([
//                             { answer: fullName },
//                             { answer: phoneNumber },
//                             ...data
//                         ]) => {
//                             await submitQuote({
//                                 product: productId,
//                                 quote,
//                                 fullName,
//                                 phoneNumber,
//                                 data:
//                                     data.length < 1
//                                         ? "{}"
//                                         : JSON.stringify(data),
//                             });
//                         }}
//                     />
//                 </div>
//             ),
//         });
//     };

//     return {
//         getQuote,
//     };
// };

class GetQuote extends StatefulWidget {
  final String productId;
  const GetQuote({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  State<GetQuote> createState() => _GetQuoteState();
}

class _GetQuoteState extends State<GetQuote> {
  Map<String, dynamic>? quotationDetails;
  bool loading = false;

  @override
  void initState() {
    getInitialQuote();
    super.initState();
  }

  void getInitialQuote() async {
    setState(() {
      loading = true;
    });

    try {
      quotationDetails = await getQuotationDetails(productId: widget.productId);
      devLog("Quotation: $quotationDetails");
    } catch (e) {
      Navigator.of(context).pop();
      openErrorAlert(message: e.toString());
    }

    setState(() {
      loading = false;
    });
  }

  Widget _buildContent() {
    if (loading) return const Loader();

    if (quotationDetails != null) {
      var quotation = {...quotationDetails!};
      quotation.removeWhere((key, value) => key == "form");

      devLog("Quotation: $quotationDetails");

      return Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(
              top: 12,
              bottom: 4,
            ),
            child: Text(
              "Quote details",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          KeyValueView(data: quotation)
        ],
      );
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return const Loader();

    if (quotationDetails?["premium"] != null) {
      var premiumVat =
          quotationDetails!["totalPremium"] - quotationDetails!["premium"];

      return Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(
              top: 12,
              bottom: 4,
            ),
            child: Text(
              "Quote details",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          KeyValueView(data: {
            "Base Premium": {
              "type": "money",
              "value": quotationDetails!["premium"]
            },
            "Premium VAT": {"type": "money", "value": premiumVat},
            "Total Premium": {
              "type": "money",
              "value": quotationDetails!["totalPremium"]
            },
          })
        ],
      );
    }

    return Container();
  }
}
