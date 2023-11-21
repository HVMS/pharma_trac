import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../Utils/string_utils.dart';
import '../Utils/styleUtils.dart';

class AddAdverseDrugReactions extends StatefulWidget {
  const AddAdverseDrugReactions({super.key});

  @override
  State<AddAdverseDrugReactions> createState() =>
      _AddAdverseDrugReactionsState();
}

class _AddAdverseDrugReactionsState extends State<AddAdverseDrugReactions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          StringUtils.addAdverseDrugReactionOptions,
          style: StyleUtils.appBarTextStyle(),
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  elevation: 5.0,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Text(
                            "ADR By Drug Name",
                            style: StyleUtils.robotoTextStyle(),
                          ),
                          const SizedBox(height: 10.0),
                          SvgPicture.asset('Icons/add_drug_icon.svg'),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 5.0,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Text(
                            "ADR By Barcode",
                            style: StyleUtils.robotoTextStyle(),
                          ),
                          const SizedBox(height: 10.0),
                          SvgPicture.asset('Icons/barcode_icon.svg'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
