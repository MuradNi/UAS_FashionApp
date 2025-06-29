import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/fashion_provider.dart';
import '../widgets/fashion_item_card.dart';

class MainFashionScreen extends StatefulWidget {
  @override
  _MainFashionScreenState createState() => _MainFashionScreenState();
}

class _MainFashionScreenState extends State<MainFashionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              _buildHeader(),
              SizedBox(height: 30),
              _buildCategoryFilter(),
              SizedBox(height: 30),
              Expanded(
                child: _buildFashionGrid(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dashboard\nFashion App',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              'UAS Pemograman Mobile (Fashion APP)',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.person_outline,
            color: Colors.grey[700],
            size: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryFilter() {
    return Consumer<FashionProvider>(
      builder: (context, provider, child) {
        return Container(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: provider.categories.length,
            itemBuilder: (context, index) {
              final category = provider.categories[index];
              final isSelected = category == provider.selectedCategory;

              return GestureDetector(
                onTap: () => provider.setCategory(category),
                child: Container(
                  margin: EdgeInsets.only(right: 16),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.black : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? Colors.black : Colors.grey[300]!,
                    ),
                  ),
                  child: Text(
                    category,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[600],
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildFashionGrid() {
    return Consumer<FashionProvider>(
      builder: (context, provider, child) {
        final items = provider.filteredItems;

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 16,
            mainAxisSpacing: 20,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return FashionItemCard(item: items[index]);
          },
        );
      },
    );
  }
}