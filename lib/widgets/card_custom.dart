import 'package:app_p16/models/product.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductCustom extends StatelessWidget {
  final Product product;
  const ProductCustom({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.only(
          bottom: 8,
        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFF0575E6),
            Color(0xFF021B79),
          ]),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            topRight: Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Column(children: [
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.55,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                          fontSize: 20,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Kanit'),
                    ),
                    Text(
                      'Ajover',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.8),
                        fontFamily: 'Kanit',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.2,
                child: CachedNetworkImage(
                    imageUrl: product.urlImage, width: 80, height: 80),
              ),
            ],
          ),
          Row(
            children: [
              Text(product.quantity.toString(),
                  style: const TextStyle(
                      fontSize: 20, color: Colors.white, fontFamily: 'Kanit')),
              const SizedBox(width: 8),
              Text(product.category,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.8),
                      fontFamily: 'Kanit')),
              const Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.double_arrow_sharp),
                  color: Colors.white),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.monetization_on_rounded),
                  color: Colors.white),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                  color: Colors.white),
            ],
          )
        ]));
  }
}
