import 'package:clean_arc/core/routes/navigator_push.dart';
import 'package:clean_arc/core/theme/app_colors.dart';
import 'package:clean_arc/features---or-----modules/client/category_services/views/service_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ════════════════════════════════════════════════
//  CATEGORY SERVICES VIEW — صنايعي
//  Displays all services under a selected category.
//  Usage:
//    Navigator.push(context, MaterialPageRoute(
//      builder: (_) => CategoryServicesView(category: myCategory),
//    ));
// ════════════════════════════════════════════════

class CategoryServicesView extends StatelessWidget {
  final ServiceCategory category;

  const CategoryServicesView({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // ── Gradient header with back button ──
          _CategoryHeader(category: category),

          // ── Services grid ──
          Expanded(
            child: _ServicesGrid(services: category.services),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Header
// ─────────────────────────────────────────────
class _CategoryHeader extends StatelessWidget {
  final ServiceCategory category;
  const _CategoryHeader({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        20,
        MediaQuery.of(context).padding.top + 16,
        20,
        28,
      ),
      decoration: const BoxDecoration(
        gradient: AppColors.headerGradient,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back button
          _BackButton(),
          const SizedBox(height: 16),
          // Title
          Text(
            category.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          // Subtitle
          Text(
            '${category.services.length} خدمات متاحة',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Back button
// ─────────────────────────────────────────────
class _BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
          Icons.arrow_back_rounded,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Services grid (2 columns)
// ─────────────────────────────────────────────
class _ServicesGrid extends StatelessWidget {
  final List<ServiceItem> services;
  const _ServicesGrid({required this.services});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemCount: services.length,
      itemBuilder: (_, i) => _ServiceCard(
        service: services[i],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Service card
// ─────────────────────────────────────────────
class _ServiceCard extends StatelessWidget {
  final ServiceItem service;
  const _ServiceCard({required this.service});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: service.onTap ??
          () {
            RouteManager.navigateTo(
              ServiceDetailView(
                service: ServiceDetail(
                  name: service.name,
                  rating: service.rating,
                  reviewCount: 150, // Mock value
                  duration: service.duration,
                  basePrice: service.price,
                  icon: service.icon,
                  hasWarranty: true,
                  description:
                      'هذه تفاصيل خدمة ${service.name}. يقوم فنيونا المعتمدون بتقديم أفضل خدمة لك مع ضمان الجودة.',
                  included: [
                    'فحص شامل للخدمة',
                    'تنظيف مكان العمل',
                    'ضمان على الخدمة المقدمة',
                  ],
                ),
              ),
            );
          },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.cardWhite,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Icon container ──
            _ServiceIcon(
              icon: service.icon,
              iconColor: service.iconColor,
            ),

            const Spacer(),

            // ── Service name ──
            Text(
              service.name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 6),

            // ── Rating + Duration row ──
            _RatingDurationRow(
              rating: service.rating,
              duration: service.duration,
            ),

            const SizedBox(height: 6),

            // ── Price ──
            Text(
              '\$${service.price.toInt()}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppColors.teal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Service icon box
// ─────────────────────────────────────────────
class _ServiceIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor;

  const _ServiceIcon({required this.icon, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(icon, color: iconColor, size: 32),
    );
  }
}

// ─────────────────────────────────────────────
// Rating + Duration row
// ─────────────────────────────────────────────
class _RatingDurationRow extends StatelessWidget {
  final double rating;
  final String duration;

  const _RatingDurationRow({
    required this.rating,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Rating
        const Icon(Icons.star_rounded, color: AppColors.orange, size: 14),
        const SizedBox(width: 3),
        Text(
          '$rating',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        const Spacer(),
        // Duration
        const Icon(Icons.access_time_rounded,
            color: AppColors.textLight, size: 13),
        const SizedBox(width: 3),
        Text(
          duration,
          style: const TextStyle(
            fontSize: 11,
            color: AppColors.textLight,
          ),
        ),
      ],
    );
  }
}

// ════════════════════════════════════════════════
//  DATA MODELS
// ════════════════════════════════════════════════

class ServiceItem {
  final String name;
  final double rating;
  final String duration;
  final double price;
  final IconData icon;
  final Color iconColor;
  final VoidCallback? onTap;

  const ServiceItem({
    required this.name,
    required this.rating,
    required this.duration,
    required this.price,
    required this.icon,
    required this.iconColor,
    this.onTap,
  });
}

class ServiceCategory {
  final String name;
  final List<ServiceItem> services;

  const ServiceCategory({
    required this.name,
    required this.services,
  });
}

// ════════════════════════════════════════════════
//  MOCK DATA — Replace with your API data
//  Add / edit categories here freely
// ════════════════════════════════════════════════

abstract class CategoriesData {
  // ── Plumbing ──
  static const plumbing = ServiceCategory(
    name: 'خدمات السباكة',
    services: [
      ServiceItem(
        name: 'إصلاح الحنفية',
        rating: 4.8,
        duration: '30 دقيقة',
        price: 45,
        icon: Icons.water_drop_outlined,
        iconColor: AppColors.catBlue,
      ),
      ServiceItem(
        name: 'تركيب دش',
        rating: 4.9,
        duration: 'ساعتان',
        price: 120,
        icon: Icons.shower_outlined,
        iconColor: AppColors.teal,
      ),
      ServiceItem(
        name: 'إصلاح المرحاض',
        rating: 4.7,
        duration: 'ساعة',
        price: 80,
        icon: Icons.plumbing_outlined,
        iconColor: AppColors.violet,
      ),
      ServiceItem(
        name: 'تركيب مواسير',
        rating: 4.8,
        duration: '3 ساعات',
        price: 150,
        icon: Icons.build_outlined,
        iconColor: AppColors.catGreen,
      ),
      ServiceItem(
        name: 'تنظيف البالوعات',
        rating: 4.6,
        duration: '45 دقيقة',
        price: 60,
        icon: Icons.cleaning_services_outlined,
        iconColor: AppColors.orange,
      ),
      ServiceItem(
        name: 'سخان المياه',
        rating: 4.9,
        duration: 'ساعتان',
        price: 200,
        icon: Icons.local_fire_department_outlined,
        iconColor: AppColors.catRed,
      ),
    ],
  );

  // ── Electrical ──
  static const electrical = ServiceCategory(
    name: 'خدمات الكهرباء',
    services: [
      ServiceItem(
        name: 'تركيب أسلاك',
        rating: 4.8,
        duration: 'ساعتان',
        price: 150,
        icon: Icons.cable_outlined,
        iconColor: AppColors.orange,
      ),
      ServiceItem(
        name: 'إصلاح القاطع الكهربائي',
        rating: 4.7,
        duration: '30 دقيقة',
        price: 60,
        icon: Icons.electric_bolt_outlined,
        iconColor: AppColors.catYellow,
      ),
      ServiceItem(
        name: 'تركيب مروحة سقف',
        rating: 4.6,
        duration: 'ساعة',
        price: 90,
        icon: Icons.air_outlined,
        iconColor: AppColors.teal,
      ),
      ServiceItem(
        name: 'تركيب إضاءة',
        rating: 4.9,
        duration: '45 دقيقة',
        price: 75,
        icon: Icons.lightbulb_outline_rounded,
        iconColor: AppColors.violet,
      ),
    ],
  );

  // ── AC ──
  static const ac = ServiceCategory(
    name: 'خدمات التكييف',
    services: [
      ServiceItem(
        name: 'صيانة تكييف',
        rating: 4.8,
        duration: 'ساعة',
        price: 89,
        icon: Icons.ac_unit_rounded,
        iconColor: AppColors.teal,
      ),
      ServiceItem(
        name: 'تركيب تكييف',
        rating: 4.7,
        duration: '3 ساعات',
        price: 250,
        icon: Icons.wb_sunny_outlined,
        iconColor: AppColors.orange,
      ),
      ServiceItem(
        name: 'تنظيف فلاتر',
        rating: 4.6,
        duration: '30 دقيقة',
        price: 40,
        icon: Icons.filter_alt_outlined,
        iconColor: AppColors.catBlue,
      ),
    ],
  );

  // ── Car Service ──
  static const carService = ServiceCategory(
    name: 'خدمات السيارات',
    services: [
      ServiceItem(
        name: 'تغيير زيت',
        rating: 4.9,
        duration: '30 دقيقة',
        price: 50,
        icon: Icons.local_gas_station_outlined,
        iconColor: AppColors.catRed,
      ),
      ServiceItem(
        name: 'فحص كامل',
        rating: 4.8,
        duration: 'ساعة',
        price: 100,
        icon: Icons.directions_car_outlined,
        iconColor: AppColors.violet,
      ),
      ServiceItem(
        name: 'تبديل إطارات',
        rating: 4.7,
        duration: '45 دقيقة',
        price: 80,
        icon: Icons.tire_repair_outlined,
        iconColor: AppColors.orange,
      ),
    ],
  );
}
