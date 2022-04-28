import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.shortestSide,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(
            Icons.description,
            size: 48,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            "No Data Found !",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
