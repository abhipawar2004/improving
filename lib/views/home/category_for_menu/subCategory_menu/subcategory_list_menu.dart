import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gehnamall/constants/constants.dart';
import 'package:gehnamall/models/sub_categories_models.dart';
import 'package:gehnamall/views/home/category_for_menu/product_card_menu/product_list_menu.dart';
import 'package:http/http.dart' as http;

class SubcategoryListMenu extends StatefulWidget {
  final int categoryCode;
  final int? selectedGenderCode; // Changed to genderCode as int
  final void Function()? onTap;

  const SubcategoryListMenu({
    Key? key,
    required this.categoryCode,
    this.selectedGenderCode,
    this.onTap,
  }) : super(key: key);

  @override
  _SubcategoryListState createState() => _SubcategoryListState();
}

class _SubcategoryListState extends State<SubcategoryListMenu> {
  List<SubCategoryModels>? subcategories;
  bool isLoading = false;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchSubcategories();
  }

  Future<void> fetchSubcategories() async {
    setState(() => isLoading = true);
    try {
      String url =
          'https://api.gehnamall.com/api/subCategories/${widget.categoryCode}?wholeseller=BANSAL';
      if (widget.selectedGenderCode != null) {
        url +=
            '&genderCode=${widget.selectedGenderCode}'; // Adjusted query param
      }
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final fetchedSubcategories = subCategoryModelsFromJson(response.body);
        if (widget.selectedGenderCode != null) {
          subcategories = fetchedSubcategories
              .where((subcategory) =>
                  subcategory.genderCode == widget.selectedGenderCode)
              .toList();
        } else {
          subcategories = fetchedSubcategories;
        }
      } else {
        error = 'Failed to fetch subcategories: ${response.statusCode}';
      }
    } catch (e) {
      error = e.toString();
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(
        child: Text(
          error!,
          style: const TextStyle(fontSize: 18.0, color: Colors.red),
          textAlign: TextAlign.center,
        ),
      );
    }

    if (subcategories == null || subcategories!.isEmpty) {
      return const Center(
        child: Text(
          'No Subcategories Found',
          style: TextStyle(fontSize: 20.0),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kDark,
        automaticallyImplyLeading: false,
        title: Column(
          children: [
            Center(
              child: Text(
                'Subcategory', // Replace with your main title
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ), // Main title styling
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: subcategories!.length,
          itemBuilder: (context, index) {
            final subcategory = subcategories![index];

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductListMenu(
                      categoryCode:
                          widget.categoryCode, // Pass the category code
                      subCategoryCode: subcategory.subcategoryCode,
                      subCategoryName: subcategory.subcategoryName,
                      // Passing the name
                    ),
                  ),
                );
              },
              child: Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double availableWidth = constraints.maxWidth;
                      double imageWidth =
                          availableWidth * 0.25; // 25% of available width
                      double imageHeight = imageWidth;

                      return Row(
                        children: [
                          subcategory.exfield1 != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    subcategory.exfield1!,
                                    width: imageWidth,
                                    height: imageHeight,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const Icon(Icons.image, size: 80.0),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  subcategory.subcategoryName,
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
