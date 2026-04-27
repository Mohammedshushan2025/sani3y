class CategoryEntity {
  final int id;
  final String nameAr;
  final String nameEn;
  final String? image;
  final String? color;

  const CategoryEntity({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    this.image,
    this.color,
  });
}
