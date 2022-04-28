import 'package:flutter/material.dart';

import '../../domain/entity/user.dart';

class UserItemCard extends StatelessWidget {
  final User user;
  const UserItemCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(user.avatarUrl),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            user.username,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
