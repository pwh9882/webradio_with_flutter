import 'package:flutter/material.dart';

ListView createRadioLinesList() {
  return ListView.separated(
    padding: EdgeInsets.zero,
    itemCount: 20,
    itemBuilder: (context, index) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.green,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('$index'),
            const Text('00.00hz'),
          ],
        ),
      );
    },
    separatorBuilder: (context, index) {
      return const SizedBox(height: 1);
    },
  );
}
