import 'package:bita_markets/models/schema.dart';

final data = {
  'Clothing and Apparel': [
    "Men's Clothing",
    "Women's Clothing",
    "Children's Clothing",
    'Shoes',
    'Accessories',
  ],
  'Electronics and Electronics Accessories': [
    'Computers & Laptops',
    'Mobile Phones & Tablets',
    "TV's & Home Entertainment",
    'Cameras & Photography',
    'Audio Equipment',
    'Phone Cases & Covers',
    'Laptop Bags & Sleeves',
    'Charging Cables',
    'Screen Protectors',
    'Headphone Accessories',
  ],
  'Home and Kitchen Appliances': [
    'Kitchen Appliances',
    'Cleaning Appliances',
    'Home Comfort Appliances',
    'Home Security Systems',
    'Small Kitchen Gadgets',
  ],
  'Books and Stationery': [
    'Fiction Books',
    'Non-fiction Books',
    'Notebooks & Journals',
    'Writing Instruments',
    'Art Supplies',
  ],
  'Health and Beauty Products': [
    'Skincare',
    'Haircare',
    'Makeup',
    'Vitamins & Supplements',
    'Personal Care Appliances',
  ],
  'Toys and Games': [
    'Action Figures',
    'Board Games',
    'Puzzles',
    'Dolls & Playsets',
    'Building Blocks',
  ],
  'Sports and Outdoor Equipment': [
    'Camping Gear',
    'Fitness Accessories',
    'Cycling Equipment',
    'Team Sports Equipment',
    'Outdoor Recreation Gear',
  ],
  'Furniture and Home Decore': [
    'Living RoomFurniture',
    'Bedroom Furniture',
    'Home Lighting',
    'Wall Art & Decorations',
    'Rugs & Carpets',
  ],
  'Automotive Parts and Accessories': [
    'Car Care Products',
    'Interior Accessories',
    'Exterior Accessories',
    'Performance Parts',
    'Tools & Equipment',
  ],
  'Pet Supplies': [
    'Dog Supplies',
    'Cat Supplies',
    'Small Animal Supplies',
    'Bird Supplies',
    'Fish Supplies',
  ],
  'Jewelry and Accessories': [
    'Necklaces',
    'Bracelets',
    'Earrings',
    'Rings',
    'Watches',
  ],
  'Food and Groceries': [
    'Fresh Produce',
    'Canned Goods',
    'Snacks',
    'Beverages',
    'Baking Ingredients',
    'Organic Foods',
    'Ethnic Foods',
    'Gourmet-Foods',
    'Specialty Teas & Coffees',
    'Fine Wines & Spirit',
  ],
  'Art and Craft Supplies': [
    'Paints & Brushes',
    'Canvas & Surfaces',
    'Sculpting Supplies',
    'Crafting Tools',
    'Paper & Cardstock',
  ],
  'Musical Instruments': [
    'Guitars',
    'Keyboards & Pianos',
    'Drums & Percussion',
    'Brass & Woodwind',
    'String Instruments',
  ],
  'Gardening Supplies': [
    'Seeds & Bulbs',
    'Gardening Tools',
    'Planters & Pots',
    'Fertilizers & Soil',
    'Watering Equipment',
  ],
  'Office Supplies': [
    'Pens & Pencils',
    'Notebooks & Paper',
    'Desk Organizers',
    'Office Furniture',
    'Presentation Supplies',
  ],
  'Baby and Toddler Products': [
    'Diapers & Wipes',
    'Baby Food',
    'Baby Clothing',
    'Nursery Furniture',
    'Baby Gear',
  ],
  'Fitness and Exercise Equipment': [
    'CardioMachines',
    'Strength Training Equipment',
    'Yoga & Pilates Gear',
    'Exercise Accessories',
    'Gymnastics Equipment',
  ],
  'Travel and Luggage': [
    'Suitcases',
    'Backpacks',
    'Travel Accessories',
    'Travel-sized Toiletries',
    'Luggage Sets',
  ],
  'Party Supplies': [
    'Balloons & Decorations',
    'Party Tableware',
    'Party Favors',
    'Themed Party Supplies',
    'Invitations & Cards',
  ],
  'DIY and Craft Kits': [
    'Model Kits',
    'Sewing Kits',
    'Jewelry Making Kits',
    'Candle Making Kits',
    'Painting Kits',
  ],
  'Home Improvement Tools': [
    'Power Tools',
    'Hand Tools',
    'Safety Equipment',
    'Building Materials',
    'Plumbing Supplies',
  ],
  'Collectibles and Memorabilia': [
    'Trading Cards',
    'Comic Books',
    'Stamps & Coins',
    'Autographs & Signed Memorabilia',
  ],
};

Future<void> addCatagories() async {
  final c = await CatagoryDb.filter(where: (where) => null);
  print(data.length);
  if (c.isEmpty) {
    for (final item in data.entries) {
      await CatagoryDb.create(name: item.key);
    }
  }
}
