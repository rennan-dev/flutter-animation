import 'package:faerun/screens/components/category_transition.dart';
import 'package:flutter/material.dart';
import 'package:faerun/controllers/api_controller.dart';
import 'package:faerun/screens/results.dart';
import 'package:faerun/utils/consts/categories.dart';

import '../../domain/models/entry.dart';

class Category extends StatefulWidget {
  Category({Key? key, required this.category, this.isHighlight=false  }) : super(key: key);
  final String category;
  final bool isHighlight;

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  final ApiController apiController = ApiController();

  Future<List<Entry>> getEntries() async {
    return await apiController.getEntriesByCategory(category: widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          child: InkWell(
            onTap: () async {
              await getEntries().then(
                (value) => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Results(entries: value, category: widget.category),
                  ),
                ),
              );
            },
            borderRadius: BorderRadius.circular(16.0),
            child: Ink(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(25, 167, 86, 0),
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    width: 4.0,
                    color: const Color.fromARGB(255, 167, 86, 0),
                  ),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 6.0,
                        color: const Color.fromARGB(255, 167, 86, 0)
                            .withOpacity(0.2),
                        blurStyle: BlurStyle.outer),
                  ]),
              child: CategoryTransitionWidget(isHighlight: widget.isHighlight, duration: const Duration(seconds: 1), imagePath: "$iconPath${widget.category}.png")
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            categories[widget.category]!,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.white.withAlpha(200),
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
    );
  }
}
