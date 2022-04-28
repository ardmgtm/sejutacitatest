import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/entity/issue.dart';

class IssueItemCard extends StatelessWidget {
  final Issue issue;
  const IssueItemCard({Key? key, required this.issue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isOpen = issue.state == 'open';
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
              Icons.bug_report_outlined,
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
                  issue.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Update : ' +
                      DateFormat('dd MMMM yyyy').format(issue.updatedTime),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: _isOpen ? Colors.green[800]! : Colors.red[800]!,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              child: Text(
                issue.state,
                style: TextStyle(
                  fontSize: 12,
                  color: _isOpen ? Colors.green[800] : Colors.red[800],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
