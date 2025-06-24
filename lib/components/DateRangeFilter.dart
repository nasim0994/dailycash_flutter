import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRangeFilter extends StatefulWidget {
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final Function(DateTime? startDate, DateTime? endDate, String selectedLabel) onChange;

  // NEW optional styling props
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BoxDecoration? decoration;

  const DateRangeFilter({
    super.key,
    this.initialStartDate,
    this.initialEndDate,
    required this.onChange,
    this.margin,
    this.padding,
    this.decoration,
  });

  @override
  State<DateRangeFilter> createState() => _DateRangeFilterState();
}

class _DateRangeFilterState extends State<DateRangeFilter> {
  late DateTime? startDate;
  late DateTime? endDate;
  String selectedLabel = 'This Week';

  final List<Map<String, dynamic>> dateRanges = [
    {
      'label': 'Today',
      'range': () {
        final now = DateTime.now();
        return {
          'startDate': DateTime(now.year, now.month, now.day),
          'endDate': DateTime(now.year, now.month, now.day),
        };
      },
    },
    {
      'label': 'Yesterday',
      'range': () {
        final yesterday = DateTime.now().subtract(const Duration(days: 1));
        return {
          'startDate': DateTime(yesterday.year, yesterday.month, yesterday.day),
          'endDate': DateTime(yesterday.year, yesterday.month, yesterday.day),
        };
      },
    },
    {
      'label': 'This Week',
      'range': () {
        final now = DateTime.now();
        final start = now.subtract(Duration(days: now.weekday - 1));
        return {
          'startDate': DateTime(start.year, start.month, start.day),
          'endDate': DateTime(now.year, now.month, now.day),
        };
      },
    },
    {
      'label': 'Last Week',
      'range': () {
        final now = DateTime.now();
        final lastWeekEnd = now.subtract(Duration(days: now.weekday));
        final lastWeekStart = lastWeekEnd.subtract(const Duration(days: 6));
        return {
          'startDate': DateTime(lastWeekStart.year, lastWeekStart.month, lastWeekStart.day),
          'endDate': DateTime(lastWeekEnd.year, lastWeekEnd.month, lastWeekEnd.day),
        };
      },
    },
    {
      'label': 'This Month',
      'range': () {
        final now = DateTime.now();
        return {
          'startDate': DateTime(now.year, now.month, 1),
          'endDate': DateTime(now.year, now.month, now.day),
        };
      },
    },
    {
      'label': 'Last Month',
      'range': () {
        final now = DateTime.now();
        final lastMonth = DateTime(now.year, now.month - 1, 1);
        final lastDay = DateTime(now.year, now.month, 0);
        return {
          'startDate': DateTime(lastMonth.year, lastMonth.month, 1),
          'endDate': DateTime(lastDay.year, lastDay.month, lastDay.day),
        };
      },
    },
    {
      'label': 'This Year',
      'range': () {
        final now = DateTime.now();
        return {
          'startDate': DateTime(now.year, 1, 1),
          'endDate': DateTime(now.year, now.month, now.day),
        };
      },
    },
    {
      'label': 'Last Year',
      'range': () {
        final now = DateTime.now();
        return {
          'startDate': DateTime(now.year - 1, 1, 1),
          'endDate': DateTime(now.year - 1, 12, 31),
        };
      },
    },
    {
      'label': 'Maximum',
      'range': () {
        return {
          'startDate': DateTime(2017, 1, 1),
          'endDate': DateTime.now(),
        };
      },
    },
  ];

  @override
  void initState() {
    super.initState();
    final thisWeek = dateRanges.firstWhere((e) => e['label'] == 'This Week')['range']();
    startDate = widget.initialStartDate ?? thisWeek['startDate'];
    endDate = widget.initialEndDate ?? thisWeek['endDate'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin ?? const EdgeInsets.fromLTRB(10, 10, 10, 0),
      padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: widget.decoration ??
          BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(8),
          ),
      child: DropdownButton<String>(
        value: selectedLabel,
        isExpanded: true,
        underline: const SizedBox(),
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
        items: [
          ...dateRanges.map((item) => DropdownMenuItem<String>(
            value: item['label'],
            child: Text(item['label']),
          )),
          const DropdownMenuItem<String>(
            value: 'Custom',
            child: Text('Custom'),
          ),
        ],
        selectedItemBuilder: (BuildContext context) {
          return [
            ...dateRanges.map((item) {
              final label = item['label'];
              final range = item['range']();
              final start = range['startDate'] as DateTime;
              final end = range['endDate'] as DateTime;

              final formattedStart = DateFormat('MMM dd, yyyy').format(start);
              final formattedEnd = DateFormat('MMM dd, yyyy').format(end);

              final displayText = (label == 'Today' || label == 'Yesterday')
                  ? '$label: $formattedStart'
                  : '$label: $formattedStart - $formattedEnd';

              return Row(
                children: [
                  const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                  const SizedBox(width: 6),
                  Flexible(child: Text(displayText, style: const TextStyle(fontSize: 14))),
                ],
              );
            }),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    (startDate != null && endDate != null)
                        ? (DateFormat('MMM dd, yyyy').format(startDate!) ==
                        DateFormat('MMM dd, yyyy').format(endDate!)
                        ? 'Custom: ${DateFormat('MMM dd, yyyy').format(startDate!)}'
                        : 'Custom: ${DateFormat('MMM dd, yyyy').format(startDate!)} - ${DateFormat('MMM dd, yyyy').format(endDate!)}')
                        : 'Custom',
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ];
        },
        onChanged: (value) async {
          setState(() => selectedLabel = value!);

          if (value == 'Custom') {
            final picked = await showDateRangePicker(
              context: context,
              firstDate: DateTime(2017),
              lastDate: DateTime.now(),
              initialDateRange: DateTimeRange(
                start: startDate ?? DateTime.now().subtract(const Duration(days: 7)),
                end: endDate ?? DateTime.now(),
              ),
            );

            if (picked != null) {
              setState(() {
                startDate = picked.start;
                endDate = picked.end;
              });
              widget.onChange(startDate, endDate, 'Custom');
            }
          } else {
            final selected = dateRanges.firstWhere((item) => item['label'] == value)['range']();
            setState(() {
              startDate = selected['startDate'];
              endDate = selected['endDate'];
            });
            widget.onChange(startDate, endDate, value!);
          }
        },
      ),
    );
  }
}
