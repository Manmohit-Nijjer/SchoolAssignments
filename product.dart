// This is merely changed files from the shrine template from flutter repositiory on git, this is to showcase the task assigned by my proffessor in our ability to edit and change files to include what we need. 


import 'package:flutter/material.dart';

class SubCategory {
  const SubCategory({
    required this.name,
  });

  final String Function(BuildContext) name;
}

class Category {
  const Category({
    required this.name,
    required this.subCategories,
  });

  // A function taking a BuildContext as input and
  // returns the internationalized name of the category.
  final String Function(BuildContext) name;
  final List<SubCategory> subCategories;
}

SubCategory subCategoryBangles = SubCategory(name: (context) => 'Bangles');

SubCategory subCategoryEarrings = SubCategory(name: (context) => 'Earrings');

SubCategory subCategoryBracelets = SubCategory(name: (context) => 'Bracelets');

SubCategory subCategoryNecklaces = SubCategory(name: (context) => 'Necklaces');

SubCategory subCategoryAnkleBracelets =
    SubCategory(name: (context) => 'Ankle Bracelets');

Category categoryDiamond = Category(
  name: (context) => 'Diamond',
  subCategories: [
    subCategoryBangles,
    subCategoryEarrings,
    subCategoryBracelets,
    subCategoryNecklaces,
    subCategoryAnkleBracelets,
  ],
);

Category categoryRuby = Category(
  name: (context) => 'Ruby',
  subCategories: [
    subCategoryBangles,
    subCategoryEarrings,
    subCategoryBracelets,
    subCategoryNecklaces,
    subCategoryAnkleBracelets,
  ],
);

Category categorySapphire = Category(
  name: (context) => 'Sapphire',
  subCategories: [
    subCategoryBangles,
    subCategoryEarrings,
    subCategoryBracelets,
    subCategoryNecklaces,
    subCategoryAnkleBracelets,
  ],
);

Category categoryEmerald = Category(
  name: (context) => 'Emerald',
  subCategories: [
    subCategoryBangles,
    subCategoryEarrings,
    subCategoryBracelets,
    subCategoryNecklaces,
    subCategoryAnkleBracelets,
  ],
);

Category categoryAmethyst = Category(
  name: (context) => 'Amethyst',
  subCategories: [
    subCategoryBangles,
    subCategoryEarrings,
    subCategoryBracelets,
    subCategoryNecklaces,
    subCategoryAnkleBracelets,
  ],
);

Category categoryAquamarine = Category(
  name: (context) => 'Aquamarine',
  subCategories: [
    subCategoryBangles,
    subCategoryEarrings,
    subCategoryBracelets,
    subCategoryNecklaces,
    subCategoryAnkleBracelets,
  ],
);

Category categoryLapisLazuli = Category(
  name: (context) => 'Lapis Lazuli',
  subCategories: [
    subCategoryBangles,
    subCategoryEarrings,
    subCategoryBracelets,
    subCategoryNecklaces,
    subCategoryAnkleBracelets,
  ],
);

Category categoryGarnet = Category(
  name: (context) => 'Garnet',
  subCategories: [
    subCategoryBangles,
    subCategoryEarrings,
    subCategoryBracelets,
    subCategoryNecklaces,
    subCategoryAnkleBracelets,
  ],
);

Category categoryTopaz = Category(
  name: (context) => 'Topaz',
  subCategories: [
    subCategoryBangles,
    subCategoryEarrings,
    subCategoryBracelets,
    subCategoryNecklaces,
    subCategoryAnkleBracelets,
  ],
);

Category categoryOpal = Category(
  name: (context) => 'Opal',
  subCategories: [
    subCategoryBangles,
    subCategoryEarrings,
    subCategoryBracelets,
    subCategoryNecklaces,
    subCategoryAnkleBracelets,
  ],
);

Category categoryAll = Category(
  name: (context) => 'All',
  subCategories: [],
);

List<Category> categories = [
  categoryAll,
  categoryAmethyst,
  categoryAquamarine,
  categoryDiamond,
  categoryEmerald,
  categoryGarnet,
  categoryLapisLazuli,
  categoryOpal,
  categoryRuby,
  categorySapphire,
  categoryTopaz,
];

class Product {
  const Product({
    required this.category,
    required this.subCategory,
    required this.imageasset,
    required this.id,
    required this.isFeatured,
    required this.name,
    required this.price,
    this.assetAspectRatio = 1,
  });

  final Category category;
  final SubCategory subCategory;
  final int id;
  final bool isFeatured;
  final double assetAspectRatio;
  final String imageasset;

  // A function taking a BuildContext as input and
  // returns the internationalized name of the product.
  final String Function(BuildContext) name;
  final int price;

  String get assetName => '$id-0.jpg';
}
