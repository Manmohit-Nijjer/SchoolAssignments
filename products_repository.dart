// This is merely changed files from the shrine template from flutter repositiory on git, this is to showcase the task assigned by my proffessor in our ability to edit and change files to include what we need. 


import 'package:gallery/studies/shrine/model/product.dart';

class ProductsRepository {
  static List<Product> loadProducts(Category category) {
    final List<Product> allProducts = [
      Product(
        category: categoryAmethyst,
        subCategory: subCategoryAnkleBracelets,
        id: 1,
        isFeatured: true,
        name: (context) => 'Amethyst Ankle Brcelet',
        imageasset: 'assets/Amethyst-AnkleBracelet.jpg',
        assetAspectRatio: 1.5,
        price: 2046,
      ),
      Product(
        category: categoryAmethyst,
        subCategory: subCategoryBangles,
        id: 2,
        isFeatured: true,
        name: (context) => 'Amethyst Bangle',
        imageasset: 'assets/AmethystBangles.jpg',
        assetAspectRatio: 1.5,
        price: 2576,
      ),
      Product(
        category: categoryAmethyst,
        subCategory: subCategoryBracelets,
        id: 3,
        isFeatured: true,
        name: (context) => 'Amethyst Bracelet',
        imageasset: 'assets/AmethystBracelet.jpg',
        assetAspectRatio: 1.5,
        price: 1067,
      ),
      Product(
        category: categoryAmethyst,
        subCategory: subCategoryEarrings,
        id: 4,
        isFeatured: true,
        name: (context) => 'Amethyst Earrings',
        imageasset: 'assets/AmethystEarrings.jpg',
        assetAspectRatio: 1.5,
        price: 789,
      ),
      Product(
        category: categoryAmethyst,
        subCategory: subCategoryNecklaces,
        id: 5,
        isFeatured: true,
        name: (context) => 'Amethyst Necklace',
        imageasset: 'assets/AmethystNecklace.jpg',
        assetAspectRatio: 1.5,
        price: 2890,
      ),
      Product(
        category: categoryAquamarine,
        subCategory: subCategoryAnkleBracelets,
        id: 6,
        isFeatured: true,
        name: (context) => 'Aquamarine Ankle Brcelet',
        imageasset: 'assets/AquamarineAnkleBracelet.jpg',
        assetAspectRatio: 1.5,
        price: 1022,
      ),
      Product(
        category: categoryAquamarine,
        subCategory: subCategoryBangles,
        id: 7,
        isFeatured: true,
        name: (context) => 'Aquamarine Bangle',
        imageasset: 'assets/AquamarineBangles.jpg',
        assetAspectRatio: 1.5,
        price: 2045,
      ),
      Product(
        category: categoryAquamarine,
        subCategory: subCategoryBracelets,
        id: 8,
        isFeatured: true,
        name: (context) => 'Aquamarine Bracelet',
        imageasset: 'assets/AquamarineBracelet.jpg',
        assetAspectRatio: 1.5,
        price: 987,
      ),
      Product(
        category: categoryAquamarine,
        subCategory: subCategoryEarrings,
        id: 9,
        isFeatured: true,
        name: (context) => 'Aquamarine Earrings',
        imageasset: 'assets/AquamarineEarrings.jpg',
        assetAspectRatio: 1.5,
        price: 912,
      ),
      Product(
        category: categoryAquamarine,
        subCategory: subCategoryNecklaces,
        id: 10,
        isFeatured: true,
        name: (context) => 'Aquamarine Necklace',
        imageasset: 'assets/AquamarineNecklace.jpg',
        assetAspectRatio: 1.5,
        price: 1342,
      ),
      Product(
        category: categoryDiamond,
        subCategory: subCategoryAnkleBracelets,
        id: 11,
        isFeatured: true,
        name: (context) => 'Diamond Ankle Brcelet',
        imageasset: 'assets/DiamondAnkleBracelet.jpg',
        assetAspectRatio: 1.5,
        price: 1046,
      ),
      Product(
        category: categoryDiamond,
        subCategory: subCategoryBangles,
        id: 12,
        isFeatured: true,
        name: (context) => 'Diamond Bangle',
        imageasset: 'assets/DiamondBangles.jpg',
        assetAspectRatio: 1.5,
        price: 1325,
      ),
      Product(
        category: categoryDiamond,
        subCategory: subCategoryBracelets,
        id: 13,
        isFeatured: true,
        name: (context) => 'Diamond Bracelet',
        imageasset: 'assets/DiamondBracelet.jpg',
        assetAspectRatio: 1.5,
        price: 1554,
      ),
      Product(
        category: categoryDiamond,
        subCategory: subCategoryEarrings,
        id: 14,
        isFeatured: true,
        name: (context) => 'Diamond Earrings',
        imageasset: 'assets/DiamondEarrings.jpg',
        assetAspectRatio: 1.5,
        price: 1839,
      ),
      Product(
        category: categoryDiamond,
        subCategory: subCategoryNecklaces,
        id: 15,
        isFeatured: true,
        name: (context) => 'Diamond Necklace',
        imageasset: 'assets/DiamondNecklace.jpg',
        assetAspectRatio: 1.5,
        price: 1342,
      ),
      Product(
        category: categoryEmerald,
        subCategory: subCategoryAnkleBracelets,
        id: 16,
        isFeatured: true,
        name: (context) => 'Emerald Ankle Brcelet',
        imageasset: 'assets/EmeraldAnkleBracelet.jpg',
        assetAspectRatio: 1.5,
        price: 1387,
      ),
      Product(
        category: categoryEmerald,
        subCategory: subCategoryBangles,
        id: 17,
        isFeatured: true,
        name: (context) => 'Emerald Bangles',
        imageasset: 'assets/EmeraldBangles.jpg',
        assetAspectRatio: 1.5,
        price: 1292,
      ),
      Product(
        category: categoryEmerald,
        subCategory: subCategoryBracelets,
        id: 18,
        isFeatured: true,
        name: (context) => 'Emerald Bracelets',
        imageasset: 'assets/EmeraldBracelet.jpg',
        assetAspectRatio: 1.5,
        price: 1404,
      ),
      Product(
        category: categoryEmerald,
        subCategory: subCategoryEarrings,
        id: 19,
        isFeatured: true,
        name: (context) => 'Emerald Earrings',
        imageasset: 'assets/EmeraldEarrings.jpg',
        assetAspectRatio: 1.5,
        price: 1412,
      ),
      Product(
        category: categoryEmerald,
        subCategory: subCategoryNecklaces,
        id: 20,
        isFeatured: true,
        name: (context) => 'Emerald Necklace',
        imageasset: 'assets/EmeraldNecklace.jpg',
        price: 1595,
      ),
      Product(
        category: categoryGarnet,
        subCategory: subCategoryAnkleBracelets,
        id: 21,
        isFeatured: true,
        name: (context) => 'Garnet Ankle Brcelet',
        imageasset: 'assets/GarnetAnkleBracelet.jpg',
        price: 1287,
      ),
      Product(
        category: categoryGarnet,
        subCategory: subCategoryBangles,
        id: 22,
        isFeatured: true,
        name: (context) => 'Garnet Bangles',
        imageasset: 'assets/GarnetBangles.jpg',
        price: 1192,
      ),
      Product(
        category: categoryGarnet,
        subCategory: subCategoryBracelets,
        id: 23,
        isFeatured: true,
        name: (context) => 'Garnet Bracelets',
        imageasset: 'assets/GarnetBracelet.jpg',
        price: 1304,
      ),
      Product(
        category: categoryGarnet,
        subCategory: subCategoryEarrings,
        id: 24,
        isFeatured: true,
        name: (context) => 'Garnet Earrings',
        imageasset: 'assets/GarnetEarrings.jpg',
        price: 1312,
      ),
      Product(
        category: categoryGarnet,
        subCategory: subCategoryNecklaces,
        id: 25,
        isFeatured: true,
        name: (context) => 'Garnet Necklace',
        imageasset: 'assets/GarnetNecklace.jpg',
        price: 1495,
      ),
      Product(
        category: categoryLapisLazuli,
        subCategory: subCategoryAnkleBracelets,
        id: 26,
        isFeatured: true,
        name: (context) => 'Lapis Lazuli Ankle Brcelet',
        imageasset: 'assets/LapisLazuliAnkleBracelet.jpg',
        price: 1347,
      ),
      Product(
        category: categoryLapisLazuli,
        subCategory: subCategoryBangles,
        id: 27,
        isFeatured: true,
        name: (context) => 'Lapis Lazuli Bangles',
        imageasset: 'assets/LapisLazuliBangles.jpg',
        price: 1292,
      ),
      Product(
        category: categoryLapisLazuli,
        subCategory: subCategoryBracelets,
        id: 28,
        isFeatured: true,
        name: (context) => 'Lapis Lazuli Bracelets',
        imageasset: 'assets/LapisLazuliBracelet.jpg',
        price: 1234,
      ),
      Product(
        category: categoryLapisLazuli,
        subCategory: subCategoryEarrings,
        id: 29,
        isFeatured: true,
        name: (context) => 'Lapis Lazuli Earrings',
        imageasset: 'assets/LapisLazuliEarrings.jpg',
        price: 1412,
      ),
      Product(
        category: categoryLapisLazuli,
        subCategory: subCategoryNecklaces,
        id: 30,
        isFeatured: true,
        name: (context) => 'Lapis Lazuli Necklace',
        imageasset: 'assets/LapisLazuliNecklace.jpg',
        price: 1535,
      ),
      Product(
        category: categoryOpal,
        subCategory: subCategoryAnkleBracelets,
        id: 31,
        isFeatured: true,
        name: (context) => 'Opal Ankle Brcelet',
        imageasset: 'assets/OpalAnkleBracelet.jpg',
        price: 1257,
      ),
      Product(
        category: categoryOpal,
        subCategory: subCategoryBangles,
        id: 32,
        isFeatured: true,
        name: (context) => 'Opal Bangles',
        imageasset: 'assets/OpalBangles.jpg',
        price: 1152,
      ),
      Product(
        category: categoryOpal,
        subCategory: subCategoryBracelets,
        id: 33,
        isFeatured: true,
        name: (context) => 'Opal Bracelets',
        imageasset: 'assets/OpalBracelet.jpg',
        price: 1245,
      ),
      Product(
        category: categoryOpal,
        subCategory: subCategoryEarrings,
        id: 34,
        isFeatured: true,
        name: (context) => 'Opal Earrings',
        imageasset: 'assets/OpalEarrings.jpg',
        price: 1352,
      ),
      Product(
        category: categoryRuby,
        subCategory: subCategoryNecklaces,
        id: 35,
        isFeatured: true,
        name: (context) => 'Ruby Necklace',
        imageasset: 'assets/RubyNecklace.jpg',
        price: 1465,
      ),
      Product(
        category: categoryRuby,
        subCategory: subCategoryAnkleBracelets,
        id: 36,
        isFeatured: true,
        name: (context) => 'Ruby Ankle Bracelet',
        imageasset: 'assets/RubyAnkleBracelet.jpg',
        price: 1347,
      ),
      Product(
        category: categoryRuby,
        subCategory: subCategoryBangles,
        id: 37,
        isFeatured: true,
        name: (context) => 'Ruby Bangles',
        imageasset: 'assets/RubyBangles.jpg',
        price: 1242,
      ),
      Product(
        category: categoryRuby,
        subCategory: subCategoryBracelets,
        id: 38,
        isFeatured: true,
        name: (context) => 'Ruby Bracelets',
        imageasset: 'assets/RubyBracelet.jpg',
        price: 1354,
      ),
      Product(
        category: categoryRuby,
        subCategory: subCategoryEarrings,
        id: 39,
        isFeatured: true,
        name: (context) => 'Ruby Earrings',
        imageasset: 'assets/RubyEarrings.jpg',
        price: 1372,
      ),
      Product(
        category: categoryOpal,
        subCategory: subCategoryNecklaces,
        id: 40,
        isFeatured: true,
        name: (context) => 'Opal Necklace',
        imageasset: 'assets/OpalNecklace.jpg',
        price: 1535,
      ),
      Product(
        category: categorySapphire,
        subCategory: subCategoryAnkleBracelets,
        id: 41,
        isFeatured: true,
        name: (context) => 'Sapphire Ankle Bracelet',
        imageasset: 'assets/SapphireAnkleBracelet.jpg',
        price: 1307,
      ),
      Product(
        category: categorySapphire,
        subCategory: subCategoryBangles,
        id: 42,
        isFeatured: true,
        name: (context) => 'Sapphire Bangles',
        imageasset: 'assets/SapphireBangles.jpg',
        price: 1242,
      ),
      Product(
        category: categorySapphire,
        subCategory: subCategoryBracelets,
        id: 43,
        isFeatured: true,
        name: (context) => 'Sapphire Bracelets',
        imageasset: 'assets/SapphireBracelet.jpg',
        price: 1344,
      ),
      Product(
        category: categorySapphire,
        subCategory: subCategoryEarrings,
        id: 44,
        isFeatured: true,
        name: (context) => 'Sapphire Earrings',
        imageasset: 'assets/SapphireEarrings.jpg',
        price: 1352,
      ),
      Product(
        category: categorySapphire,
        subCategory: subCategoryNecklaces,
        id: 45,
        isFeatured: true,
        name: (context) => 'Sapphire Necklace',
        imageasset: 'assets/SapphireNecklace.jpg',
        price: 1535,
      ),
      Product(
        category: categoryTopaz,
        subCategory: subCategoryAnkleBracelets,
        id: 46,
        isFeatured: true,
        name: (context) => 'Topaz Ankle Bracelet',
        imageasset: 'assets/TopazAnkleBracelet.jpg',
        price: 1337,
      ),
      Product(
        category: categoryTopaz,
        subCategory: subCategoryBangles,
        id: 47,
        isFeatured: true,
        name: (context) => 'Topaz Bangles',
        imageasset: 'assets/TopazBangles.jpg',
        price: 1242,
      ),
      Product(
        category: categoryTopaz,
        subCategory: subCategoryBracelets,
        id: 48,
        isFeatured: true,
        name: (context) => 'Topaz Bracelets',
        imageasset: 'assets/TopazBracelet.jpg',
        price: 1364,
      ),
      Product(
        category: categoryTopaz,
        subCategory: subCategoryEarrings,
        id: 49,
        isFeatured: true,
        name: (context) => 'Topaz Earrings',
        imageasset: 'assets/TopazEarrings.jpg',
        price: 1372,
      ),
      Product(
        category: categoryTopaz,
        subCategory: subCategoryNecklaces,
        id: 50,
        isFeatured: true,
        name: (context) => 'Topaz Necklace',
        imageasset: 'assets/TopazNecklace.jpg',
        price: 1565,
      ),
    ];

    if (category == categoryAll) {
      return allProducts;
    } else {
      return allProducts.where((Product p) => p.category == category).toList();
    }
  }
}
