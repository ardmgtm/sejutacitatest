import 'package:flutter/material.dart';

class PageWidget extends StatelessWidget {
  final int page;
  final int maxPage;
  final Function(int)? previous;
  final Function(int)? next;

  const PageWidget({
    Key? key,
    required this.page,
    required this.maxPage,
    this.previous,
    this.next,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isFirstPage = page == 1;
    bool isLastPage = page == maxPage;

    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Text(
              "Page $page of $maxPage",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            Expanded(child: Container()),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: isFirstPage
                  ? null
                  : () {
                      if (previous != null) {
                        previous!(page - 1);
                      }
                    },
              icon: Icon(
                Icons.arrow_left,
                color: isFirstPage
                    ? Colors.black.withOpacity(0.2)
                    : Theme.of(context).colorScheme.secondary,
                size: 48,
              ),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: isLastPage
                  ? null
                  : () {
                      if (next != null) {
                        next!(page + 1);
                      }
                    },
              icon: Icon(
                Icons.arrow_right,
                color: isLastPage
                    ? Colors.black.withOpacity(0.2)
                    : Theme.of(context).colorScheme.secondary,
                size: 48,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
