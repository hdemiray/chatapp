import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const UserTile({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.all(25),
          margin: const EdgeInsets.only(bottom: 15, left: 25, right: 25),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.person, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 8),
              Text(text,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary)),
            ],
          )),
    );
  }
}
