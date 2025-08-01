class Product {
  final int id;
  final String name;
  final double price;
  final String image;
  final String description;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
    required this.category,
  });

  static List<Product> dummyProducts = [
    Product(
      id: 1,
      name: "Smart LED Bulb",
      price: 499.0,
      image: "https://placehold.co/400x300/E0E7FF/3B82F6?text=LED+Bulb",
      description: "Energy-efficient smart LED bulb with adjustable brightness and color. Control via app.",
      category: "Lighting",
    ),
    Product(
      id: 2,
      name: "Universal Power Adapter",
      price: 299.0,
      image: "https://placehold.co/400x300/E0E7FF/3B82F6?text=Power+Adapter",
      description: "Multi-port universal power adapter for various devices. Fast charging support.",
      category: "Adapters",
    ),
    Product(
      id: 3,
      name: "Wireless Charging Pad",
      price: 799.0,
      image: "https://placehold.co/400x300/E0E7FF/3B82F6?text=Wireless+Charger",
      description: "Sleek wireless charging pad compatible with all Qi-enabled devices.",
      category: "Chargers",
    ),
    Product(
      id: 4,
      name: "Smart Plug (Wi-Fi)",
      price: 349.0,
      image: "https://placehold.co/400x300/E0E7FF/3B82F6?text=Smart+Plug",
      description: "Control your appliances remotely with this Wi-Fi enabled smart plug.",
      category: "Smart Home",
    ),
    Product(
      id: 5,
      name: "Extension Cord with USB",
      price: 399.0,
      image: "https://placehold.co/400x300/E0E7FF/3B82F6?text=Extension+Cord",
      description: "6-outlet extension cord with 2 USB charging ports. Overload protection.",
      category: "Cables & Cords",
    ),
    Product(
      id: 6,
      name: "Digital Multimeter",
      price: 1299.0,
      image: "https://placehold.co/400x300/E0E7FF/3B82F6?text=Multimeter",
      description: "High-precision digital multimeter for electrical testing and troubleshooting.",
      category: "Tools",
    ),
    Product(
      id: 7,
      name: "Surge Protector",
      price: 549.0,
      image: "https://placehold.co/400x300/E0E7FF/3B82F6?text=Surge+Protector",
      description: "Protect your electronics from power surges with this reliable surge protector.",
      category: "Safety",
    ),
    Product(
      id: 8,
      name: "HDMI Cable (10ft)",
      price: 199.0,
      image: "https://placehold.co/400x300/E0E7FF/3B82F6?text=HDMI+Cable",
      description: "High-speed HDMI cable for crystal clear audio and video transmission.",
      category: "Cables & Cords",
    ),
  ];
}