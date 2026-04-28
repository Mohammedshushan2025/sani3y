import 'package:clean_arc/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

// ════════════════════════════════════════════════
//  FAVORITES VIEW — صنايعي
// ════════════════════════════════════════════════

class ClientFavoritesView extends StatefulWidget {
  const ClientFavoritesView({super.key});

  @override
  State<ClientFavoritesView> createState() => _ClientFavoritesViewState();
}

class _ClientFavoritesViewState extends State<ClientFavoritesView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // ── Header ──
          _FavoritesHeader(tabController: _tabController),

          // ── Tab views ──
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Services tab
                _FavoriteServicesList(
                  services: _FavoritesData.services,
                  onRemove: (i) =>
                      setState(() => _FavoritesData.services.removeAt(i)),
                ),
                // Technicians tab
                _FavoriteTechniciansList(
                  technicians: _FavoritesData.technicians,
                  onRemove: (i) =>
                      setState(() => _FavoritesData.technicians.removeAt(i)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Header
// ─────────────────────────────────────────────
class _FavoritesHeader extends StatelessWidget {
  final TabController tabController;
  const _FavoritesHeader({required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          20, MediaQuery.of(context).padding.top + 20, 20, 0),
      decoration: const BoxDecoration(
        gradient: AppColors.headerGradient,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('مفضلتي',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          const Text('خدماتك وصنايعيتك المحفوظة',
              style: TextStyle(color: Colors.white70, fontSize: 13)),
          const SizedBox(height: 20),
          _FavoritesTabBar(controller: tabController),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Tab bar (Services / Technicians)
// ─────────────────────────────────────────────
class _FavoritesTabBar extends StatelessWidget {
  final TabController controller;
  const _FavoritesTabBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: controller,
        indicator: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: AppColors.violet,
        unselectedLabelColor: Colors.white,
        labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
        unselectedLabelStyle:
            const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
        dividerColor: Colors.transparent,
        tabs: const [
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.home_repair_service_outlined, size: 16),
                SizedBox(width: 6),
                Text('الخدمات'),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star_outline_rounded, size: 16),
                SizedBox(width: 6),
                Text('الصنايعية'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Favorite service model
// ─────────────────────────────────────────────
class _FavoriteService {
  final String name;
  final double rating;
  final String reviews;
  final double price;
  final IconData icon;
  final Color iconColor;

  _FavoriteService({
    required this.name,
    required this.rating,
    required this.reviews,
    required this.price,
    required this.icon,
    required this.iconColor,
  });
}

// ─────────────────────────────────────────────
// Favorite technician model
// ─────────────────────────────────────────────
class _FavoriteTechnician {
  final String name;
  final String specialty;
  final double rating;
  final String reviews;
  final Color avatarColor;

  _FavoriteTechnician({
    required this.name,
    required this.specialty,
    required this.rating,
    required this.reviews,
    required this.avatarColor,
  });
}

// ─────────────────────────────────────────────
// Services list
// ─────────────────────────────────────────────
class _FavoriteServicesList extends StatelessWidget {
  final List<_FavoriteService> services;
  final ValueChanged<int> onRemove;

  const _FavoriteServicesList({
    required this.services,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    if (services.isEmpty) return const _EmptyFavorites();
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: services.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, i) => _FavoriteServiceCard(
        service: services[i],
        onRemove: () => onRemove(i),
      ),
    );
  }
}

class _FavoriteServiceCard extends StatelessWidget {
  final _FavoriteService service;
  final VoidCallback onRemove;

  const _FavoriteServiceCard({
    required this.service,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        color: AppColors.orange, size: 13),
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
          // Price + remove
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: onRemove,
                child: const Icon(Icons.delete_outline_rounded,
                    color: Color(0xFFFF6B6B), size: 20),
              ),
              const SizedBox(height: 6),
              Text('\$${service.price.toInt()}',
                  style: const TextStyle(
                      fontSize: 15,
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
// Technicians list
// ─────────────────────────────────────────────
class _FavoriteTechniciansList extends StatelessWidget {
  final List<_FavoriteTechnician> technicians;
  final ValueChanged<int> onRemove;

  const _FavoriteTechniciansList({
    required this.technicians,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    if (technicians.isEmpty) return const _EmptyFavorites();
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: technicians.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, i) => _FavoriteTechnicianCard(
        technician: technicians[i],
        onRemove: () => onRemove(i),
      ),
    );
  }
}

class _FavoriteTechnicianCard extends StatelessWidget {
  final _FavoriteTechnician technician;
  final VoidCallback onRemove;

  const _FavoriteTechnicianCard({
    required this.technician,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          CircleAvatar(
            radius: 24,
            backgroundColor: technician.avatarColor.withOpacity(0.2),
            child: Icon(Icons.person_rounded,
                color: technician.avatarColor, size: 26),
          ),
          const SizedBox(width: 12),
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
                        color: AppColors.orange, size: 13),
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
          GestureDetector(
            onTap: onRemove,
            child: const Icon(Icons.delete_outline_rounded,
                color: Color(0xFFFF6B6B), size: 20),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Empty state
// ─────────────────────────────────────────────
class _EmptyFavorites extends StatelessWidget {
  const _EmptyFavorites();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border_rounded,
              size: 64, color: AppColors.textLight.withOpacity(0.5)),
          const SizedBox(height: 16),
          const Text('لا يوجد عناصر في المفضلة',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textMedium)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Static mock data (mutable for demo remove)
// ─────────────────────────────────────────────
abstract class _FavoritesData {
  static final services = [
    _FavoriteService(
        name: 'إصلاح وصيانة تكييف',
        rating: 4.8,
        reviews: '234',
        price: 89,
        icon: Icons.ac_unit_rounded,
        iconColor: AppColors.teal),
    _FavoriteService(
        name: 'تركيب سباكة',
        rating: 4.3,
        reviews: '189',
        price: 120,
        icon: Icons.water_drop_outlined,
        iconColor: AppColors.catBlue),
    _FavoriteService(
        name: 'أعمال كهرباء',
        rating: 4.7,
        reviews: '516',
        price: 150,
        icon: Icons.bolt_rounded,
        iconColor: AppColors.orange),
  ];

  static final technicians = [
    _FavoriteTechnician(
        name: 'John Smith',
        specialty: 'خبير سباكة',
        rating: 4.9,
        reviews: '342',
        avatarColor: AppColors.violet),
    _FavoriteTechnician(
        name: 'Sarah Johnson',
        specialty: 'متخصصة كهرباء',
        rating: 4.8,
        reviews: '287',
        avatarColor: AppColors.teal),
  ];
}
