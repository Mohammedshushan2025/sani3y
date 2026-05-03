import 'package:clean_arc/core/routes/navigator_push.dart';
import 'package:clean_arc/core/theme/app_colors.dart';
import 'package:clean_arc/features---or-----modules/client/booking/views/booking_view.dart';
import 'package:flutter/material.dart';

// ════════════════════════════════════════════════
//  SERVICE DETAIL VIEW — صنايعي
//  Usage:
//    Navigator.push(context, MaterialPageRoute(
//      builder: (_) => ServiceDetailView(service: myServiceDetail),
//    ));
// ════════════════════════════════════════════════

class ServiceDetailView extends StatefulWidget {
  final ServiceDetail service;
  const ServiceDetailView({super.key, required this.service});

  @override
  State<ServiceDetailView> createState() => _ServiceDetailViewState();
}

class _ServiceDetailViewState extends State<ServiceDetailView> {
  int _quantity = 1;
  bool _isFavorite = false;

  double get _totalPrice => widget.service.basePrice * _quantity;

  void _increment() => setState(() => _quantity++);
  void _decrement() {
    if (_quantity > 1) setState(() => _quantity--);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // ── Scrollable content ──
          CustomScrollView(
            slivers: [
              // ── Hero image header ──
              SliverToBoxAdapter(
                child: _ServiceHeroHeader(
                  service: widget.service,
                  isFavorite: _isFavorite,
                  onFavoriteToggle: () =>
                      setState(() => _isFavorite = !_isFavorite),
                ),
              ),

              // ── Info section ──
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                sliver: SliverToBoxAdapter(
                  child: _ServiceInfoSection(service: widget.service),
                ),
              ),

              // ── Description card ──
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                sliver: SliverToBoxAdapter(
                  child: _DetailCard(
                    title: 'الوصف',
                    child: Text(
                      widget.service.description,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textMedium,
                        height: 1.6,
                      ),
                    ),
                  ),
                ),
              ),

              // ── What's included card ──
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                sliver: SliverToBoxAdapter(
                  child: _DetailCard(
                    title: 'ما يشمله الخدمة',
                    child: _IncludedList(items: widget.service.included),
                  ),
                ),
              ),

              // ── Quantity section ──
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                sliver: SliverToBoxAdapter(
                  child: _QuantitySelector(
                    quantity: _quantity,
                    onIncrement: _increment,
                    onDecrement: _decrement,
                  ),
                ),
              ),

              // Bottom padding so content isn't hidden behind the booking bar
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),

          // ── Fixed bottom booking bar ──
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _BookingBar(
              totalPrice: _totalPrice,
              onBook: () {
                RouteManager.navigateTo(BookingCheckoutView(
                  booking: BookingCheckoutData(
                    serviceItem: BookingServiceItem(
                      name: widget.service.name,
                      icon: widget.service.icon,
                      iconColor: AppColors.teal,
                      quantity: _quantity,
                      totalPrice: _totalPrice,
                    ),
                    technicians: const [
                      TechnicianOption(
                        name: 'محمد أحمد',
                        specialty: 'فني ممتاز',
                        rating: 4.9,
                        reviewCount: 120,
                        avatarColor: AppColors.violet,
                        isAvailable: true,
                      ),
                      TechnicianOption(
                        name: 'أحمد محمود',
                        specialty: 'خبير صيانة',
                        rating: 4.8,
                        reviewCount: 85,
                        avatarColor: AppColors.orange,
                        isAvailable: true,
                      ),
                    ],
                  ),
                ));
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Hero header (gradient bg + icon + back + fav)
// ─────────────────────────────────────────────
class _ServiceHeroHeader extends StatelessWidget {
  final ServiceDetail service;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const _ServiceHeroHeader({
    required this.service,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      decoration: const BoxDecoration(
        gradient: AppColors.headerGradient,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(28),
        ),
      ),
      child: Stack(
        children: [
          // ── Service icon centered ──
          Center(
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Icon(
                service.icon,
                size: 64,
                color: Colors.white,
              ),
            ),
          ),

          // ── Top bar (back + favorite) ──
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _CircleNavButton(
                    icon: Icons.arrow_back_rounded,
                    onTap: () => Navigator.pop(context),
                  ),
                  _CircleNavButton(
                    icon: isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    iconColor: isFavorite
                        ? const Color(0xFFFF6B6B)
                        : AppColors.textDark,
                    background: Colors.white,
                    onTap: onFavoriteToggle,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Circle nav button (back / favorite)
// ─────────────────────────────────────────────
class _CircleNavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color background;
  final Color iconColor;

  const _CircleNavButton({
    required this.icon,
    required this.onTap,
    this.background = Colors.white24,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: background,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Service name, rating, duration, warranty
// ─────────────────────────────────────────────
class _ServiceInfoSection extends StatelessWidget {
  final ServiceDetail service;
  const _ServiceInfoSection({required this.service});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Name
        Text(
          service.name,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 10),

        // Rating + Duration row
        Row(
          children: [
            const Icon(Icons.star_rounded, color: AppColors.orange, size: 16),
            const SizedBox(width: 4),
            Text(
              '${service.rating}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '(${service.reviewCount} تقييم)',
              style: const TextStyle(fontSize: 12, color: AppColors.textLight),
            ),
            const SizedBox(width: 16),
            const Icon(Icons.access_time_rounded,
                color: AppColors.textLight, size: 15),
            const SizedBox(width: 4),
            Text(
              service.duration,
              style: const TextStyle(fontSize: 13, color: AppColors.textMedium),
            ),
          ],
        ),

        // Warranty badge (optional)
        if (service.hasWarranty) ...[
          const SizedBox(height: 10),
          _WarrantyBadge(),
        ],
      ],
    );
  }
}

class _WarrantyBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(Icons.verified_outlined, color: AppColors.teal, size: 16),
        SizedBox(width: 6),
        Text(
          'يشمل ضمان',
          style: TextStyle(
            fontSize: 13,
            color: AppColors.teal,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// Reusable detail card with title + content
// ─────────────────────────────────────────────
class _DetailCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _DetailCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// What's included list
// ─────────────────────────────────────────────
class _IncludedList extends StatelessWidget {
  final List<String> items;
  const _IncludedList({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.teal,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textMedium,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}

// ─────────────────────────────────────────────
// Quantity selector
// ─────────────────────────────────────────────
class _QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const _QuantitySelector({
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'الكمية',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            // Decrement
            _QuantityButton(
              icon: Icons.remove_rounded,
              onTap: onDecrement,
              isActive: quantity > 1,
            ),
            // Count
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                '$quantity',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                ),
              ),
            ),
            // Increment
            _QuantityButton(
              icon: Icons.add_rounded,
              onTap: onIncrement,
              isActive: true,
            ),
          ],
        ),
      ],
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isActive;

  const _QuantityButton({
    required this.icon,
    required this.onTap,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.teal.withOpacity(0.12)
              : AppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive
                ? AppColors.teal
                : AppColors.textLight.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Icon(
          icon,
          size: 20,
          color: isActive ? AppColors.teal : AppColors.textLight,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Fixed bottom booking bar
// ─────────────────────────────────────────────
class _BookingBar extends StatelessWidget {
  final double totalPrice;
  final VoidCallback onBook;

  const _BookingBar({
    required this.totalPrice,
    required this.onBook,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        14,
        20,
        MediaQuery.of(context).padding.bottom + 14,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Total price label
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'السعر الإجمالي',
                style: TextStyle(fontSize: 11, color: AppColors.textLight),
              ),
              const SizedBox(height: 2),
              Text(
                '\$${totalPrice.toInt()}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          const Spacer(),
          // Book button
          GestureDetector(
            onTap: onBook,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.teal, AppColors.violet],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.teal.withOpacity(0.4),
                    blurRadius: 14,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Text(
                'احجز الخدمة',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════
//  DATA MODEL
// ════════════════════════════════════════════════

class ServiceDetail {
  final String name;
  final double rating;
  final int reviewCount;
  final String duration;
  final double basePrice;
  final IconData icon;
  final bool hasWarranty;
  final String description;
  final List<String> included;

  const ServiceDetail({
    required this.name,
    required this.rating,
    required this.reviewCount,
    required this.duration,
    required this.basePrice,
    required this.icon,
    this.hasWarranty = false,
    required this.description,
    required this.included,
  });
}

// ════════════════════════════════════════════════
//  MOCK DATA — Replace with your API response
// ════════════════════════════════════════════════

abstract class ServiceDetailData {
  static const acRepair = ServiceDetail(
    name: 'إصلاح وصيانة تكييف',
    rating: 4.8,
    reviewCount: 234,
    duration: 'ساعتان',
    basePrice: 89,
    icon: Icons.ac_unit_rounded,
    hasWarranty: true,
    description:
        'خدمة إصلاح وصيانة تكييف احترافية. يقوم فنيونا المعتمدون بتشخيص وإصلاح أي أعطال، وإجراء الصيانة الدورية، وتنظيف الفلاتر، والتحقق من مستويات الفريون، وضمان أفضل أداء تبريدي.',
    included: [
      'فحص شامل للتكييف',
      'تنظيف أو استبدال الفلاتر',
      'فحص مستوى الفريون',
      'معايرة الثيرموستات',
      'اختبار الأداء',
      'ضمان خدمة 30 يوم',
    ],
  );

  static const plumbingInstall = ServiceDetail(
    name: 'تركيب سباكة',
    rating: 4.3,
    reviewCount: 189,
    duration: '3 ساعات',
    basePrice: 120,
    icon: Icons.water_drop_outlined,
    hasWarranty: true,
    description:
        'خدمة تركيب سباكة متكاملة بأيدي فنيين متخصصين. نضمن جودة التركيب وسلامة التوصيلات.',
    included: [
      'فحص نظام السباكة الحالي',
      'تركيب المواسير الجديدة',
      'اختبار التسريبات',
      'تنظيف موقع العمل',
      'ضمان خدمة 60 يوم',
    ],
  );
}
