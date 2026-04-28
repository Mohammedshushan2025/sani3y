import 'package:clean_arc/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

// ════════════════════════════════════════════════
//  HOME VIEW — صنايعي
// ════════════════════════════════════════════════

class ClientHomeView extends StatelessWidget {
  const ClientHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // ── Gradient header ──
          SliverToBoxAdapter(child: _HomeHeader()),

          // ── Search bar ──
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(child: _SearchBar()),
          ),

          // ── Special Offers ──
          const SliverPadding(
            padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
            sliver:
                SliverToBoxAdapter(child: _SectionTitle(title: 'عروض خاصة')),
          ),
          const SliverToBoxAdapter(child: _OffersCarousel()),

          // ── Categories ──
          const SliverPadding(
            padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
            sliver: SliverToBoxAdapter(child: _SectionTitle(title: 'الفئات')),
          ),
          const SliverToBoxAdapter(child: _CategoriesRow()),

          // ── Most Requested ──
          const SliverPadding(
            padding: EdgeInsets.fromLTRB(16, 24, 0, 0),
            sliver: SliverToBoxAdapter(
              child: _SectionTitle(title: 'الأكثر طلباً', showSeeAll: true),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                _HomeData.services
                    .map((s) => _ServiceCard(service: s))
                    .toList(),
              ),
            ),
          ),

          // ── Top Rated Technicians ──
          const SliverPadding(
            padding: EdgeInsets.fromLTRB(16, 24, 0, 0),
            sliver: SliverToBoxAdapter(
              child: _SectionTitle(
                  title: 'أعلى الصنايعية تقييماً', showSeeAll: true),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                _HomeData.technicians
                    .map((t) => _TechnicianCard(technician: t))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Header with gradient + greeting + location
// ─────────────────────────────────────────────
class _HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          20, MediaQuery.of(context).padding.top + 20, 20, 24),
      decoration: const BoxDecoration(
        gradient: AppColors.headerGradient,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('أهلاً بعودتك،',
                    style: TextStyle(color: Colors.white70, fontSize: 14)),
                SizedBox(height: 4),
                Text('John Doe',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w800)),
                SizedBox(height: 10),
                _LocationChip(),
              ],
            ),
          ),
          _NotificationBell(),
        ],
      ),
    );
  }
}

class _LocationChip extends StatelessWidget {
  const _LocationChip();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(Icons.location_on_outlined, color: Colors.white70, size: 14),
        SizedBox(width: 4),
        Text(
          '123 شارع المعز، القاهرة',
          style: TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }
}

class _NotificationBell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.notifications_outlined,
              color: Colors.white, size: 22),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.orange,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// Search bar
// ─────────────────────────────────────────────
class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4))
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: const [
          Icon(Icons.search, color: AppColors.textLight, size: 20),
          SizedBox(width: 10),
          Text('ابحث عن خدمة...',
              style: TextStyle(color: AppColors.textLight, fontSize: 14)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Section title row
// ─────────────────────────────────────────────
class _SectionTitle extends StatelessWidget {
  final String title;
  final bool showSeeAll;

  const _SectionTitle({required this.title, this.showSeeAll = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark)),
          if (showSeeAll)
            Text('عرض الكل',
                style: TextStyle(
                    fontSize: 12,
                    color: AppColors.violet,
                    fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Offers carousel
// ─────────────────────────────────────────────
class _OffersCarousel extends StatelessWidget {
  const _OffersCarousel();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 145,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: const [
          _OfferCard(
            gradient:
                LinearGradient(colors: [Color(0xFF6C63FF), Color(0xFF48CAE4)]),
            badge: '50% خصم',
            title: 'أول خدمة بنص السعر',
            subtitle: 'للعملاء الجدد فقط',
          ),
          SizedBox(width: 12),
          _OfferCard(
            gradient:
                LinearGradient(colors: [Color(0xFFFF9F43), Color(0xFFFF6B6B)]),
            badge: 'مجاني',
            title: 'كشف مجاني',
            subtitle: 'على أول طلب',
          ),
        ],
      ),
    );
  }
}

class _OfferCard extends StatelessWidget {
  final LinearGradient gradient;
  final String badge;
  final String title;
  final String subtitle;

  const _OfferCard({
    required this.gradient,
    required this.badge,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(badge,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700)),
          ),
          const SizedBox(height: 8),
          Text(title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: const TextStyle(color: Colors.white70, fontSize: 12)),
          const Spacer(),
          Row(
            children: const [
              Text('عرض التفاصيل',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600)),
              SizedBox(width: 4),
              Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 14),
            ],
          )
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Categories row
// ─────────────────────────────────────────────
class _CategoriesRow extends StatelessWidget {
  const _CategoriesRow();

  static const _cats = [
    _Category('سباكة', Icons.water_drop_outlined, AppColors.catBlue),
    _Category('كهرباء', Icons.bolt_rounded, AppColors.catYellow),
    _Category('سيارات', Icons.directions_car_outlined, AppColors.catRed),
    _Category('نجارة', Icons.handyman_outlined, AppColors.catGreen),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: _cats
            .map((c) => Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: _CategoryChip(category: c),
                ))
            .toList(),
      ),
    );
  }
}

class _Category {
  final String label;
  final IconData icon;
  final Color color;
  const _Category(this.label, this.icon, this.color);
}

class _CategoryChip extends StatelessWidget {
  final _Category category;
  const _CategoryChip({required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: category.color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(category.icon, color: category.color, size: 28),
        ),
        const SizedBox(height: 6),
        Text(category.label,
            style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark)),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// Service card
// ─────────────────────────────────────────────
class _ServiceModel {
  final String name;
  final double rating;
  final String reviews;
  final double price;
  final IconData icon;
  final Color iconColor;

  const _ServiceModel({
    required this.name,
    required this.rating,
    required this.reviews,
    required this.price,
    required this.icon,
    required this.iconColor,
  });
}

class _ServiceCard extends StatelessWidget {
  final _ServiceModel service;
  const _ServiceCard({required this.service});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4))
        ],
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: service.iconColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(service.icon, color: service.iconColor, size: 24),
          ),
          const SizedBox(width: 12),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(service.name,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star_rounded,
                        color: AppColors.orange, size: 14),
                    const SizedBox(width: 3),
                    Text('${service.rating}',
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDark)),
                    const SizedBox(width: 4),
                    Text('(${service.reviews})',
                        style: const TextStyle(
                            fontSize: 11, color: AppColors.textLight)),
                  ],
                ),
              ],
            ),
          ),
          // Price
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('\$${service.price.toInt()}',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.violet)),
              const Text('لكل خدمة',
                  style: TextStyle(fontSize: 10, color: AppColors.textLight)),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Technician card
// ─────────────────────────────────────────────
class _TechnicianModel {
  final String name;
  final String specialty;
  final double rating;
  final String reviews;
  final Color avatarColor;

  const _TechnicianModel({
    required this.name,
    required this.specialty,
    required this.rating,
    required this.reviews,
    required this.avatarColor,
  });
}

class _TechnicianCard extends StatelessWidget {
  final _TechnicianModel technician;
  const _TechnicianCard({required this.technician});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4))
        ],
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 24,
            backgroundColor: technician.avatarColor.withOpacity(0.2),
            child: Icon(Icons.person_rounded,
                color: technician.avatarColor, size: 26),
          ),
          const SizedBox(width: 12),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(technician.name,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark)),
                const SizedBox(height: 2),
                Text(technician.specialty,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textMedium)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star_rounded,
                        color: AppColors.orange, size: 14),
                    const SizedBox(width: 3),
                    Text('${technician.rating}',
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDark)),
                    const SizedBox(width: 4),
                    Text('(${technician.reviews})',
                        style: const TextStyle(
                            fontSize: 11, color: AppColors.textLight)),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded,
              color: AppColors.textLight, size: 22),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Static mock data for HomeView
// ─────────────────────────────────────────────
abstract class _HomeData {
  static const services = [
    _ServiceModel(
        name: 'إصلاح وصيانة تكييف',
        rating: 4.8,
        reviews: '234',
        price: 89,
        icon: Icons.ac_unit_rounded,
        iconColor: AppColors.teal),
    _ServiceModel(
        name: 'تركيب سباكة',
        rating: 4.3,
        reviews: '189',
        price: 120,
        icon: Icons.water_drop_outlined,
        iconColor: AppColors.catBlue),
    _ServiceModel(
        name: 'أعمال كهرباء',
        rating: 4.7,
        reviews: '516',
        price: 150,
        icon: Icons.bolt_rounded,
        iconColor: AppColors.orange),
    _ServiceModel(
        name: 'دهان المنزل',
        rating: 4.9,
        reviews: '228',
        price: 200,
        icon: Icons.format_paint_rounded,
        iconColor: AppColors.catRed),
  ];

  static const technicians = [
    _TechnicianModel(
        name: 'John Smith',
        specialty: 'خبير سباكة',
        rating: 4.9,
        reviews: '342',
        avatarColor: AppColors.violet),
    _TechnicianModel(
        name: 'Sarah Johnson',
        specialty: 'متخصصة كهرباء',
        rating: 4.8,
        reviews: '287',
        avatarColor: AppColors.teal),
    _TechnicianModel(
        name: 'Mike Williams',
        specialty: 'متخصص تكييف',
        rating: 4.7,
        reviews: '411',
        avatarColor: AppColors.orange),
  ];
}
