import 'package:flutter/material.dart';

class FailureWidget extends StatelessWidget {
  const FailureWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.shortestSide,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(
            Icons.warning,
            size: 48,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            "Something Wrong !",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
