import 'package:clean_arc/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ════════════════════════════════════════════════
//  BOOKING CHECKOUT VIEW — صنايعي
//  Usage:
//    Navigator.push(context, MaterialPageRoute(
//      builder: (_) => BookingCheckoutView(booking: myBooking),
//    ));
// ════════════════════════════════════════════════

class BookingCheckoutView extends StatefulWidget {
  final BookingCheckoutData booking;
  const BookingCheckoutView({super.key, required this.booking});

  @override
  State<BookingCheckoutView> createState() => _BookingCheckoutViewState();
}

class _BookingCheckoutViewState extends State<BookingCheckoutView> {
  // ── Form controllers ──
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipController = TextEditingController();
  final _notesController = TextEditingController();

  // ── State ──
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  int? _selectedTechnicianIndex;

  @override
  void dispose() {
    _streetController.dispose();
    _cityController.dispose();
    _zipController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  // ── Date picker ──
  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  // ── Time picker ──
  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 10, minute: 0),
    );
    if (picked != null) setState(() => _selectedTime = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // ── Scrollable form ──
          CustomScrollView(
            slivers: [
              // Header
              SliverToBoxAdapter(child: _CheckoutHeader()),

              // Service summary
              _sectionPadding(
                child: _ServiceSummaryCard(item: widget.booking.serviceItem),
              ),

              // Address
              _sectionPadding(
                child: _SectionCard(
                  icon: Icons.location_on_outlined,
                  title: 'عنوان الخدمة',
                  iconColor: AppColors.teal,
                  child: _AddressForm(
                    streetController: _streetController,
                    cityController: _cityController,
                    zipController: _zipController,
                  ),
                ),
              ),

              // Schedule
              _sectionPadding(
                child: _SectionCard(
                  icon: Icons.calendar_month_outlined,
                  title: 'الموعد',
                  iconColor: AppColors.violet,
                  child: _SchedulePicker(
                    selectedDate: _selectedDate,
                    selectedTime: _selectedTime,
                    onPickDate: _pickDate,
                    onPickTime: _pickTime,
                  ),
                ),
              ),

              // Technician
              _sectionPadding(
                child: _SectionCard(
                  icon: Icons.person_outline_rounded,
                  title: 'اختر الصنايعي',
                  iconColor: AppColors.orange,
                  child: _TechnicianList(
                    technicians: widget.booking.technicians,
                    selectedIndex: _selectedTechnicianIndex,
                    onSelect: (i) =>
                        setState(() => _selectedTechnicianIndex = i),
                  ),
                ),
              ),

              // Additional notes
              _sectionPadding(
                child: _SectionCard(
                  icon: Icons.notes_rounded,
                  title: 'ملاحظات إضافية (اختياري)',
                  iconColor: AppColors.textLight,
                  child: _NotesField(controller: _notesController),
                ),
              ),

              // Bottom spacing for confirm bar
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),

          // ── Fixed confirm bar ──
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _ConfirmBar(
              totalPrice: widget.booking.serviceItem.totalPrice,
              onConfirm: () {},
            ),
          ),
        ],
      ),
    );
  }

  /// Helper — uniform section padding
  Widget _sectionPadding({required Widget child}) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      sliver: SliverToBoxAdapter(child: child),
    );
  }
}

// ─────────────────────────────────────────────
// Header
// ─────────────────────────────────────────────
class _CheckoutHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.arrow_back_rounded,
                  color: Colors.white, size: 20),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'تأكيد الحجز',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'أكمل بيانات حجز الخدمة',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Service summary card
// ─────────────────────────────────────────────
class _ServiceSummaryCard extends StatelessWidget {
  final BookingServiceItem item;
  const _ServiceSummaryCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return _WhiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ملخص الخدمة',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              // Icon
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: item.iconColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(item.icon, color: item.iconColor, size: 26),
              ),
              const SizedBox(width: 14),
              // Name + quantity
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'الكمية: ${item.quantity}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textLight,
                      ),
                    ),
                  ],
                ),
              ),
              // Price
              Text(
                '\$${item.totalPrice.toInt()}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.violet,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Reusable section card (icon + title + child)
// ─────────────────────────────────────────────
class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color iconColor;
  final Widget child;

  const _SectionCard({
    required this.icon,
    required this.title,
    required this.iconColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return _WhiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title row
          Row(
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// White card wrapper
// ─────────────────────────────────────────────
class _WhiteCard extends StatelessWidget {
  final Widget child;
  const _WhiteCard({required this.child});

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
      child: child,
    );
  }
}

// ─────────────────────────────────────────────
// Address form
// ─────────────────────────────────────────────
class _AddressForm extends StatelessWidget {
  final TextEditingController streetController;
  final TextEditingController cityController;
  final TextEditingController zipController;

  const _AddressForm({
    required this.streetController,
    required this.cityController,
    required this.zipController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Street
        _FieldLabel(label: 'الشارع'),
        _InputField(
          controller: streetController,
          hint: '123 شارع المعز',
        ),
        const SizedBox(height: 12),
        // City + ZIP row
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _FieldLabel(label: 'المدينة'),
                  _InputField(
                    controller: cityController,
                    hint: 'القاهرة',
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _FieldLabel(label: 'الرمز البريدي'),
                  _InputField(
                    controller: zipController,
                    hint: '11511',
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// Schedule date + time pickers
// ─────────────────────────────────────────────
class _SchedulePicker extends StatelessWidget {
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;
  final VoidCallback onPickDate;
  final VoidCallback onPickTime;

  const _SchedulePicker({
    required this.selectedDate,
    required this.selectedTime,
    required this.onPickDate,
    required this.onPickTime,
  });

  String get _dateLabel {
    if (selectedDate == null) return 'يوم / شهر / سنة';
    return '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}';
  }

  String get _timeLabel {
    if (selectedTime == null) return '-- : --';
    final h = selectedTime!.hour.toString().padLeft(2, '0');
    final m = selectedTime!.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Date picker
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _FieldLabel(label: 'التاريخ'),
              _PickerButton(
                label: _dateLabel,
                icon: Icons.calendar_today_outlined,
                onTap: onPickDate,
                hasValue: selectedDate != null,
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        // Time picker
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _FieldLabel(label: 'الوقت'),
              _PickerButton(
                label: _timeLabel,
                icon: Icons.access_time_rounded,
                onTap: onPickTime,
                hasValue: selectedTime != null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// Picker button (date / time trigger)
// ─────────────────────────────────────────────
class _PickerButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool hasValue;

  const _PickerButton({
    required this.label,
    required this.icon,
    required this.onTap,
    required this.hasValue,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: hasValue ? AppColors.violet : AppColors.divider,
            width: hasValue ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  color: hasValue ? AppColors.textDark : AppColors.textLight,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(icon, size: 16, color: AppColors.textLight),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Technician list
// ─────────────────────────────────────────────
class _TechnicianList extends StatelessWidget {
  final List<TechnicianOption> technicians;
  final int? selectedIndex;
  final ValueChanged<int> onSelect;

  const _TechnicianList({
    required this.technicians,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        technicians.length,
        (i) => Padding(
          padding: EdgeInsets.only(bottom: i < technicians.length - 1 ? 10 : 0),
          child: _TechnicianTile(
            technician: technicians[i],
            isSelected: selectedIndex == i,
            onTap: technicians[i].isAvailable ? () => onSelect(i) : null,
          ),
        ),
      ),
    );
  }
}

class _TechnicianTile extends StatelessWidget {
  final TechnicianOption technician;
  final bool isSelected;
  final VoidCallback? onTap;

  const _TechnicianTile({
    required this.technician,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isAvailable = technician.isAvailable;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.violet.withOpacity(0.06)
              : AppColors.background,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? AppColors.violet : AppColors.divider,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 22,
              backgroundColor: technician.avatarColor.withOpacity(0.2),
              child: Icon(Icons.person_rounded,
                  color: isAvailable
                      ? technician.avatarColor
                      : AppColors.textLight,
                  size: 24),
            ),
            const SizedBox(width: 12),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    technician.name,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isAvailable
                          ? AppColors.textDark
                          : AppColors.textLight,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    technician.specialty,
                    style: const TextStyle(
                        fontSize: 11, color: AppColors.textLight),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded,
                          color: AppColors.orange, size: 12),
                      const SizedBox(width: 3),
                      Text(
                        '${technician.rating} (${technician.reviewCount})',
                        style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textMedium,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Availability badge
            _AvailabilityBadge(isAvailable: isAvailable),
          ],
        ),
      ),
    );
  }
}

class _AvailabilityBadge extends StatelessWidget {
  final bool isAvailable;
  const _AvailabilityBadge({required this.isAvailable});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isAvailable
            ? AppColors.completed.withOpacity(0.12)
            : AppColors.catRed.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isAvailable ? 'متاح' : 'مشغول',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: isAvailable ? AppColors.completed : AppColors.catRed,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Notes field
// ─────────────────────────────────────────────
class _NotesField extends StatelessWidget {
  final TextEditingController controller;
  const _NotesField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 3,
      style: const TextStyle(fontSize: 13, color: AppColors.textDark),
      decoration: InputDecoration(
        hintText: 'أي تعليمات خاصة أو متطلبات...',
        hintStyle: const TextStyle(color: AppColors.textLight, fontSize: 13),
        filled: true,
        fillColor: AppColors.background,
        contentPadding: const EdgeInsets.all(14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.violet, width: 1.5),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Reusable field label
// ─────────────────────────────────────────────
class _FieldLabel extends StatelessWidget {
  final String label;
  const _FieldLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.textMedium,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Reusable input field
// ─────────────────────────────────────────────
class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const _InputField({
    required this.controller,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      style: const TextStyle(fontSize: 13, color: AppColors.textDark),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.textLight, fontSize: 13),
        filled: true,
        fillColor: AppColors.background,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.violet, width: 1.5),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Confirm booking bottom bar
// ─────────────────────────────────────────────
class _ConfirmBar extends StatelessWidget {
  final double totalPrice;
  final VoidCallback onConfirm;

  const _ConfirmBar({
    required this.totalPrice,
    required this.onConfirm,
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
      child: GestureDetector(
        onTap: onConfirm,
        child: Container(
          height: 54,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.teal, AppColors.violet],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.violet.withOpacity(0.35),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            'تأكيد الحجز — \$${totalPrice.toInt()}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════
//  DATA MODELS
// ════════════════════════════════════════════════

class BookingServiceItem {
  final String name;
  final IconData icon;
  final Color iconColor;
  final int quantity;
  final double totalPrice;

  const BookingServiceItem({
    required this.name,
    required this.icon,
    required this.iconColor,
    required this.quantity,
    required this.totalPrice,
  });
}

class TechnicianOption {
  final String name;
  final String specialty;
  final double rating;
  final int reviewCount;
  final Color avatarColor;
  final bool isAvailable;

  const TechnicianOption({
    required this.name,
    required this.specialty,
    required this.rating,
    required this.reviewCount,
    required this.avatarColor,
    required this.isAvailable,
  });
}

class BookingCheckoutData {
  final BookingServiceItem serviceItem;
  final List<TechnicianOption> technicians;

  const BookingCheckoutData({
    required this.serviceItem,
    required this.technicians,
  });
}

// ════════════════════════════════════════════════
//  MOCK DATA — Replace with your API / state
// ════════════════════════════════════════════════

abstract class BookingCheckoutMock {
  static const acRepairBooking = BookingCheckoutData(
    serviceItem: BookingServiceItem(
      name: 'إصلاح وصيانة تكييف',
      icon: Icons.ac_unit_rounded,
      iconColor: AppColors.teal,
      quantity: 1,
      totalPrice: 89,
    ),
    technicians: [
      TechnicianOption(
        name: 'John Smith',
        specialty: 'خبير تكييف',
        rating: 4.9,
        reviewCount: 342,
        avatarColor: AppColors.violet,
        isAvailable: true,
      ),
      TechnicianOption(
        name: 'Sarah Johnson',
        specialty: 'متخصصة HVAC',
        rating: 4.8,
        reviewCount: 287,
        avatarColor: AppColors.teal,
        isAvailable: true,
      ),
      TechnicianOption(
        name: 'Mike Williams',
        specialty: 'فني عام',
        rating: 4.0,
        reviewCount: 412,
        avatarColor: AppColors.orange,
        isAvailable: false,
      ),
    ],
  );
}
