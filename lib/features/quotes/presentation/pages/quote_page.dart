import 'package:flutter/material.dart';

import '../../../../core/widgets/app_page.dart';
import '../widgets/quote_form.dart';

class QuotePage extends StatelessWidget {
  const QuotePage({super.key, required this.title, required this.subtitle, required this.icon});
  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return AppPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary.withValues(alpha: .12), borderRadius: BorderRadius.circular(18)),
                child: Icon(icon, color: Theme.of(context).colorScheme.primary, size: 30),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 4),
                    Text(subtitle, style: const TextStyle(color: Colors.white60)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          QuoteForm(type: title, icon: icon),
        ],
      ),
    );
  }
}
