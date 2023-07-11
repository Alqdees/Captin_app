import 'package:flutter/material.dart';
import 'package:notification_of_support/generated/l10n.dart';
import 'package:sizer/sizer.dart';

class CardView extends StatelessWidget {
  String name, msgContent;

  CardView({
    super.key,
    required this.name,
    required this.msgContent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(S.of(context).name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    SizedBox(
                      width: 1.w,
                    ),
                    Text(msgContent,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.black)),
                  ],
                ),
                Row(
                  children: [
                    Text(S.of(context).date,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    SizedBox(
                      width: 1.w,
                    ),
                    Text(name,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.black)),
                  ],
                )
              ],
            ),
          ),
          // IconButton(
          //   icon: const Icon(Icons.notification_add),
          //   onPressed: () {
          //     showDialog(
          //       context: context,
          //       builder: (BuildContext context) {
          //         return AlertDialog(
          //           title: const Text("Title"),
          //           content: const Text("Message"),
          //           actions: [
          //             TextButton(
          //               child: const Text("OK"),
          //               onPressed: () {
          //                 // do something when the "OK" button is clicked

          //                 Navigator.of(context).pop();
          //               },
          //             ),
          //             TextButton(
          //               child: const Text("Cancel"),
          //               onPressed: () {
          //                 Navigator.of(context).pop();
          //               },
          //             ),
          //           ],
          //         );
          //       },
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
