import 'package:flutter/material.dart';
import 'package:shop_app/global_variables.dart';
import 'package:shop_app/widgets/product_card.dart';
import 'package:shop_app/pages/product_details_page.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {

  final List<String> filters = const ["All","Adidas","Nike","Bata"];
  late String selectedFilter;

  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 1)),
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(50),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Shoes\nCollection",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search_sharp),
                      border: border,
                      enabledBorder: border,
                      focusedBorder: border,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 120,
              child: ListView.builder(
                itemCount: filters.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final filter = filters[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFilter = filter;
                        });
                      },
                      child: Chip(
                        backgroundColor: selectedFilter == filter ? Theme.of(context).primaryColor : Color.fromRGBO(246, 247, 249, 1),
                        label: Text(filter),
                        labelStyle: TextStyle(fontSize: 16),
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.transparent
                            ), 
                            borderRadius: BorderRadius.circular(30), 
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                if (constraints.maxWidth > 1080) {
                  return GridView.builder(
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.75,
                    ),
                  itemBuilder: (context, index){
                    final product = products[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          return ProductDetails(product: product);
                        }));
                      },
                      child: ProductCard(
                        title: product['title'] as String,
                        price: product['price'] as double,
                        image: product['imageUrl'] as String,
                        backgroundColor: index.isEven ?  Color.fromRGBO(216, 240, 253, 1) : Color.fromRGBO(246, 247, 249, 1),
                      ),
                    );
                  },
                  );
                }
                else{
                  return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          return ProductDetails(product: product);
                        }));
                      },
                      child: ProductCard(
                        title: product['title'] as String,
                        price: product['price'] as double,
                        image: product['imageUrl'] as String,
                        backgroundColor: index.isEven ?  Color.fromRGBO(216, 240, 253, 1) : Color.fromRGBO(246, 247, 249, 1),
                      ),
                    );
                  },
                );
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}