import 'package:flutter/material.dart';
import 'package:monovect/common/theme/d_constants.dart';
import 'package:monovect/common/theme/d_decorations.dart';

import '../../../common/theme/d_colors.dart';
import '../../../common/theme/d_dimens.dart';
import '../../../common/theme/d_text_styles.dart';
import '../../../common/widget/credit_chip.dart';
import '../create_art/presentation/create_art_view.dart';
import 'widgets/last_creations_widget.dart';

part './widgets/_create_card.dart';

part './widgets/_categories_section.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CreateVectorView()),
          );
        },
        shape: CircleBorder(),
        child: Icon(Icons.draw_outlined, size: DDimens.iconLg),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 6,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(icon: Icon(Icons.home_outlined), onPressed: () {}),
            SizedBox(width: 40),
            IconButton(icon: Icon(Icons.person_outline), onPressed: () {}),
          ],
        ),
      ),

      body: Stack(
        children: [
          Container(decoration: DDecorations.gradientBackground()),
          Positioned.fill(
            child: CustomPaint(painter: ParticleBackgroundPainter()),
          ),
          CustomScrollView(
            slivers: [
              // App Bar
              SliverAppBar(
                floating: true,
                snap: true,
                elevation: DConstants.appBarElevation,
                backgroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                expandedHeight: 0,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    color: DColors.backgroundDark,
                    border: Border(
                      bottom: BorderSide(color: DColors.glassBorder),
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: DDimens.md,
                        vertical: DDimens.sm,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.layers_outlined,
                                color: DColors.primary,
                                size: DDimens.iconMd,
                              ),
                              SizedBox(width: DDimens.sm),
                              Text('Vectorify', style: DTextStyles.brandTitle),
                            ],
                          ),
                          const CreditChip(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Content
              SliverPadding(
                padding: EdgeInsets.fromLTRB(
                  DDimens.md,
                  DDimens.lg,
                  DDimens.md,
                  0,
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _CreateCard(),
                    SizedBox(height: DDimens.xl),
                    _CategoriesSection(),
                    SizedBox(height: DDimens.lg),
                    _buildSectionHeader(),
                  ]),
                ),
              ),
              const LastCreationsWidget(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Last Creations', style: DTextStyles.h2),
        TextButton(
          onPressed: () {},
          child: Text(
            'View All',
            style: DTextStyles.buttonMedium.copyWith(color: DColors.primary),
          ),
        ),
      ],
    );
  }
}

class ParticleBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Radial gradient 1
    paint.shader = RadialGradient(
      center: const Alignment(-0.7, 0),
      radius: 0.6,
      colors: [DColors.secondary.withOpacity(0.06), Colors.transparent],
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Radial gradient 2
    paint.shader = RadialGradient(
      center: const Alignment(0.7, -0.4),
      radius: 0.6,
      colors: [DColors.primary.withOpacity(0.05), Colors.transparent],
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
