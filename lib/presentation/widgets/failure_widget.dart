import 'package:flutter/material.dart';

class FailureWidget extends StatelessWidget {
  final String? message;
  const FailureWidget({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.shortestSide,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.warning,
            size: 48,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            message ?? "Something Wrong !",
            style: const TextStyle(color: Colors.grey),
          ),
          const Text(
            "Try again later",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
