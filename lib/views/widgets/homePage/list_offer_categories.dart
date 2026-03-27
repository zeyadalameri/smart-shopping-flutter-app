import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListOfferCategories extends StatelessWidget {
  const ListOfferCategories(
      {super.key,
      required this.data,
      required this.onTap,
      required this.selectedIndex});

  final List data;
  final Function(int index) onTap;
  final int selectedIndex;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;
          return InkWell(
            onTap: () {
              onTap(index);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: isSelected
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.onSecondary,
              ),
              child: Center(
                child: Text(
                  "${data[index]['name']}".tr,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected
                            ? Theme.of(context).colorScheme.onSecondary
                            : Theme.of(context).colorScheme.secondary,
                      ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
