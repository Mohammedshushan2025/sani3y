import 'package:clean_arc/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

// ════════════════════════════════════════════════
//  ORDERS VIEW — صنايعي
// ════════════════════════════════════════════════

enum OrderStatus { pending, approved, completed }

class ClientOrdersView extends StatefulWidget {
  const ClientOrdersView({super.key});

  @override
  State<ClientOrdersView> createState() => _ClientOrdersViewState();
}

class _ClientOrdersViewState extends State<ClientOrdersView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
          _OrdersHeader(tabController: _tabController),

          // ── Tab views ──
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _OrdersList(
                  orders: _OrdersData.all
                      .where((o) => o.status == OrderStatus.pending)
                      .toList(),
                ),
                _OrdersList(
                  orders: _OrdersData.all
                      .where((o) => o.status == OrderStatus.approved)
                      .toList(),
                ),
                _OrdersList(
                  orders: _OrdersData.all
                      .where((o) => o.status == OrderStatus.completed)
                      .toList(),
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
// Header with gradient + tab bar
// ─────────────────────────────────────────────
class _OrdersHeader extends StatelessWidget {
  final TabController tabController;
  const _OrdersHeader({required this.tabController});

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
          const Text('طلباتي',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          const Text('تابع حجوزات الخدمات',
              style: TextStyle(color: Colors.white70, fontSize: 13)),
          const SizedBox(height: 20),
          _OrdersTabBar(controller: tabController),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Custom tab bar
// ─────────────────────────────────────────────
class _OrdersTabBar extends StatelessWidget {
  final TabController controller;
  const _OrdersTabBar({required this.controller});

  static const _tabs = ['قيد الانتظار', 'مقبول', 'مكتمل'];

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
        labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
        unselectedLabelStyle:
            const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        dividerColor: Colors.transparent,
        tabs: _tabs.map((t) => Tab(text: t)).toList(),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Scrollable list of orders
// ─────────────────────────────────────────────
class _OrdersList extends StatelessWidget {
  final List<_OrderModel> orders;
  const _OrdersList({required this.orders});

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return const _EmptyOrders();
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, i) => _OrderCard(order: orders[i]),
    );
  }
}

// ─────────────────────────────────────────────
// Empty state
// ─────────────────────────────────────────────
class _EmptyOrders extends StatelessWidget {
  const _EmptyOrders();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long_outlined,
              size: 64, color: AppColors.textLight.withValues(alpha: 0.5)),
          const SizedBox(height: 16),
          const Text('لا توجد طلبات هنا',
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
// Order card
// ─────────────────────────────────────────────
class _OrderModel {
  final String serviceName;
  final String technicianName;
  final String date;
  final String time;
  final double price;
  final OrderStatus status;
  final IconData icon;
  final Color iconColor;

  const _OrderModel({
    required this.serviceName,
    required this.technicianName,
    required this.date,
    required this.time,
    required this.price,
    required this.status,
    required this.icon,
    required this.iconColor,
  });
}

class _OrderCard extends StatelessWidget {
  final _OrderModel order;
  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Top row: icon + name + price ──
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: order.iconColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(order.icon, color: order.iconColor, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(order.serviceName,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textDark)),
                    const SizedBox(height: 3),
                    _InfoRow(
                        icon: Icons.person_outline_rounded,
                        text: order.technicianName),
                  ],
                ),
              ),
              Text('\$${order.price.toInt()}',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColors.violet)),
            ],
          ),

          const SizedBox(height: 12),

          // ── Date + Time ──
          Row(
            children: [
              _InfoRow(icon: Icons.calendar_today_outlined, text: order.date),
              const SizedBox(width: 16),
              _InfoRow(icon: Icons.access_time_rounded, text: order.time),
            ],
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: AppColors.divider, height: 1),
          ),

          // ── Status badge ──
          _StatusBadge(status: order.status),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Reusable info row (icon + text)
// ─────────────────────────────────────────────
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.textLight),
        const SizedBox(width: 4),
        Text(text,
            style: const TextStyle(fontSize: 12, color: AppColors.textMedium)),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// Status badge
// ─────────────────────────────────────────────
class _StatusBadge extends StatelessWidget {
  final OrderStatus status;
  const _StatusBadge({required this.status});

  Color get _color {
    switch (status) {
      case OrderStatus.pending:
        return AppColors.pending;
      case OrderStatus.approved:
        return AppColors.approved;
      case OrderStatus.completed:
        return AppColors.completed;
    }
  }

  String get _label {
    switch (status) {
      case OrderStatus.pending:
        return 'قيد الانتظار';
      case OrderStatus.approved:
        return 'مقبول';
      case OrderStatus.completed:
        return 'مكتمل';
    }
  }

  IconData get _icon {
    switch (status) {
      case OrderStatus.pending:
        return Icons.hourglass_empty_rounded;
      case OrderStatus.approved:
        return Icons.check_circle_outline_rounded;
      case OrderStatus.completed:
        return Icons.task_alt_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(_icon, size: 16, color: _color),
        const SizedBox(width: 6),
        Text(_label,
            style: TextStyle(
                fontSize: 13, fontWeight: FontWeight.w600, color: _color)),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// Static mock data
// ─────────────────────────────────────────────
abstract class _OrdersData {
  static const all = [
    _OrderModel(
      serviceName: 'أعمال كهرباء',
      technicianName: 'Mike Williams',
      date: 'أبريل 18، 2025',
      time: '11:00 ص',
      price: 150,
      status: OrderStatus.pending,
      icon: Icons.bolt_rounded,
      iconColor: AppColors.orange,
    ),
    _OrderModel(
      serviceName: 'دهان المنزل',
      technicianName: 'John Smith',
      date: 'أبريل 18، 2025',
      time: '9:00 ص',
      price: 200,
      status: OrderStatus.pending,
      icon: Icons.format_paint_rounded,
      iconColor: AppColors.catRed,
    ),
    _OrderModel(
      serviceName: 'إصلاح تكييف',
      technicianName: 'Sarah Johnson',
      date: 'أبريل 10، 2025',
      time: '2:00 م',
      price: 89,
      status: OrderStatus.approved,
      icon: Icons.ac_unit_rounded,
      iconColor: AppColors.teal,
    ),
    _OrderModel(
      serviceName: 'تركيب سباكة',
      technicianName: 'John Smith',
      date: 'مارس 25، 2025',
      time: '10:00 ص',
      price: 120,
      status: OrderStatus.completed,
      icon: Icons.water_drop_outlined,
      iconColor: AppColors.catBlue,
    ),
  ];
}
