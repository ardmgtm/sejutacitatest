import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/entity/repository.dart';

class RepositoryItemCard extends StatelessWidget {
  final Repository repository;
  const RepositoryItemCard({Key? key, required this.repository})
      : super(key: key);

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
              color: Theme.of(context).colorScheme.primary,
            ),
            child: const Icon(
              Icons.library_books,
              size: 32,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  repository.fullname,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  DateFormat('dd MMMM yyyy').format(repository.createdDate),
                ),
                SizedBox(height: 4),
                Theme(
                  data: ThemeData(
                    iconTheme: IconThemeData(size: 12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.visibility),
                      Text(
                        repository.watchers.toString(),
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.star),
                      Text(
                        repository.stars.toString(),
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.fork_right),
                      Text(
                        repository.forks.toString(),
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
