import 'package:flutter/material.dart';
import 'package:monovect/common/theme/d_colors.dart';
import 'package:monovect/common/theme/d_dimens.dart';
import 'package:monovect/common/theme/d_text_styles.dart';

class PaywallView extends StatefulWidget {
  const PaywallView({super.key});

  @override
  State<PaywallView> createState() => _PaywallViewState();
}

class _PaywallViewState extends State<PaywallView> {
  String _selectedPlan = 'annual';

  final List<Map<String, dynamic>> _benefits = [
    {'icon': Icons.auto_awesome, 'title': 'Unlimited AI Generations'},
    {'icon': Icons.construction, 'title': 'Access to All Pro Tools'},
    {'icon': Icons.download, 'title': 'High-Resolution Exports'},
    {'icon': Icons.groups, 'title': 'Exclusive Community Access'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      body: Stack(
        children: [
          // Background gradients
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    DColors.primary.withOpacity(0.2),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            right: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    DColors.secondary.withOpacity(0.2),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Particle texture overlay
          Positioned.fill(
            child: Opacity(
              opacity: 0.05,
              child: CustomPaint(painter: _ParticleTexturePainter()),
            ),
          ),

          // Main content
          SafeArea(
            child: Column(
              children: [
                // Top bar with close button
                Padding(
                  padding: EdgeInsets.all(DDimens.md),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close, color: Colors.white70),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.black.withOpacity(0.2),
                        ),
                      ),
                    ],
                  ),
                ),

                // Header section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: DDimens.lg),
                  child: Column(
                    children: [
                      Text(
                        'Go Premium with Vectorify',
                        style: DTextStyles.h1.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: DDimens.sm),
                      Text(
                        'Unlock your full creative potential with unlimited access to our pro tools.',
                        style: DTextStyles.bodyMedium.copyWith(
                          color: Colors.white.withOpacity(0.7),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: DDimens.xxl),

                // Benefits list
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: DDimens.lg),
                  child: Column(
                    children: _benefits.map((benefit) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: DDimens.sm),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: DColors.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(
                                  DDimens.radiusMd,
                                ),
                              ),
                              child: Icon(
                                benefit['icon'] as IconData,
                                color: DColors.primary,
                                size: 24,
                              ),
                            ),
                            SizedBox(width: DDimens.md),
                            Expanded(
                              child: Text(
                                benefit['title'] as String,
                                style: DTextStyles.bodyMedium.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const Spacer(),

                // Subscription tiers
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: DDimens.md),
                  child: Column(
                    children: [
                      // Annual plan
                      _buildPlanCard(
                        id: 'annual',
                        title: 'Annual Premium',
                        subtitle: 'Billed once per year',
                        price: '\$69.99 / year',
                        pricePerMonth: '\$5.83/month',
                        isBestValue: true,
                      ),
                      SizedBox(height: DDimens.sm),

                      // Monthly plan
                      _buildPlanCard(
                        id: 'monthly',
                        title: 'Monthly Pro',
                        subtitle: 'Billed monthly',
                        price: '\$9.99 / month',
                      ),
                    ],
                  ),
                ),

                SizedBox(height: DDimens.lg),

                // CTA buttons
                Column(
                  children: [
                    // Subscribe button
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(DDimens.radiusXl),
                        boxShadow: [
                          BoxShadow(
                            color: DColors.primary.withOpacity(0.5),
                            blurRadius: 20,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle subscription
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Subscribing to $_selectedPlan plan',
                              ),
                              backgroundColor: DColors.primary,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: DDimens.md),
                          backgroundColor: DColors.primary,
                          foregroundColor: Colors.black,
                          minimumSize: const Size(double.infinity, 56),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              DDimens.radiusXl,
                            ),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: const Text('Subscribe Now'),
                      ),
                    ),
                
                    SizedBox(height: DDimens.md),
                
                    // Restore purchases
                    TextButton(
                      onPressed: () {
                        // Handle restore purchases
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Restoring purchases...'),
                          ),
                        );
                      },
                      child: Text(
                        'Restore Purchases',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),

                // Terms and Privacy
                Padding(
                  padding: EdgeInsets.all(DDimens.md),
                  child: Text(
                    'By subscribing, you agree to our Terms of Service and Privacy Policy.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.5),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard({
    required String id,
    required String title,
    required String subtitle,
    required String price,
    String? pricePerMonth,
    bool isBestValue = false,
  }) {
    final isSelected = _selectedPlan == id;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPlan = id;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.all(DDimens.md),
        decoration: BoxDecoration(
          color: const Color(0xFF2B2D25).withOpacity(0.5),
          borderRadius: BorderRadius.circular(DDimens.radiusXl),
          border: Border.all(
            color: isSelected ? DColors.primary : Colors.white.withOpacity(0.1),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: DColors.primary.withOpacity(0.2),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: DTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: DDimens.xs),
                      Text(
                        subtitle,
                        style: DTextStyles.bodySmall.copyWith(
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      price,
                      style: DTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (pricePerMonth != null) ...[
                      SizedBox(height: DDimens.xs),
                      Text(
                        pricePerMonth,
                        style: DTextStyles.bodySmall.copyWith(
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
            if (isBestValue)
              Positioned(
                top: -DDimens.md,
                right: -DDimens.md,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: DDimens.sm,
                    vertical: DDimens.xs,
                  ),
                  decoration: BoxDecoration(
                    color: DColors.primary,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(DDimens.radiusXl),
                      bottomLeft: Radius.circular(DDimens.radiusMd),
                    ),
                  ),
                  child: const Text(
                    'BEST VALUE',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Particle Texture Painter
class _ParticleTexturePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Draw random dots for particle effect
    for (var i = 0; i < 100; i++) {
      final x = (i * 37) % size.width.toInt();
      final y = (i * 73) % size.height.toInt();
      canvas.drawCircle(Offset(x.toDouble(), y.toDouble()), 0.5, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
