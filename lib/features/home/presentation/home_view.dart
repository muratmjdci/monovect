import 'package:flutter/material.dart';
import 'package:monovect/common/theme/d_colors.dart';
import 'package:monovect/common/theme/d_constants.dart';
import 'package:monovect/common/theme/d_decorations.dart';
import 'package:monovect/common/theme/d_dimens.dart';
import 'package:monovect/common/theme/d_text_styles.dart';
import 'package:monovect/common/widget/credit_chip.dart';
import 'package:monovect/features/home/create_art/presentation/create_art_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String _selectedCategory = 'Engraving';

  final List<String> _categories = [
    'Engraving',
    'Outcut',
    'Linocut',
    'Sticker',
    'Chibi',
    'Icon',
  ];

  final List<Map<String, dynamic>> _creations = [
    {
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAoD539qDNJmKFyrnla2Upoxrej4TRrkOwzFq5Amz0rvIfXn7fbN_VyUsNKKe370f9bMiC1MmaWs9yw5CDd9tFfCOy20-nfhA32we5VVg9cX2uHfQQgbFMnneMl3q9Y7-OIJwNyfbeWPhCcq7XcOsAuzGLYHp3J5AhEHioLM5Q9BhjtP25a6Z12Ho23IcRj0pPmvypUbDe_sEPPVGpBXfjp_QUpaqvXnXcPGnNtJw8Zf-sQM6tGf6NuKuBiuC_VLHnXKQdpKFF8ck8D',
      'author': '@artisan_wolf',
      'likes': '1.2k',
      'isLiked': true,
    },
    {
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAKGaz6oJ14nI9_iqosAwMC6W17Tzl6TU7_0qsBj0wIu7d3LLTVGaKK41g1e55JOuuVZm4V-o5W8Jg-7i-skxa6wZuqZN_WYesm-XPkQHdhghRupNqM64jJfeD8beE_1bk7wHk3UHZII2LmsPO7Oshn2pDzXw7ygRPQOrDS-XWiCBaN8cxpuh9y3hd3XW8KPhQANtdWgw8YnK8n0_6TCAw1eYq1sxMdMmAmZKf9yBJOk9CVSwj_pzfPR2Zt3YN4-oUZBl60xyLcaR-M',
      'author': '@city_dreamer',
      'likes': '876',
      'isLiked': false,
    },
    {
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuD1m9UF996OjzOyHN0YXLSWKxLfVQPgGIU5s8OOgLQmasyr9cBVJ2A5oqJBkuB7wfZOfYt-KwsmK9yyZsLAjGrS1MGgIMien2KRWeSuz604H0zAM5byFlp15OeMTDW6nTCrWgfA-8ft7x6nAjzIcZ1UOQihPiZEVm-BbbAK_cr6TQoL3jvV2LobqqG_qSSFu6mzyJy3FVC41TCUZBGMrKqxemJtHYqPDb1N1LR0GNnlQg7ertemFcc8MNHIaoUWnHJWoAwKdt6AZcXk',
      'author': '@vector_vixen',
      'likes': '2.5k',
      'isLiked': true,
    },
    {
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAieh-G0ong4SEtoY8bFbJdT26UQcMGBwbYIu94XXFmGPn5leGfVmlaFErPH8xdyBLr4sEekhGvcvHPSI8A65LRxKyg-rgJpuOATdYjMpzCwQ-1uuF6y-noVnVUciGzhVYtaB13c95x8oUZRPrPi7bh32N8EOiErc4VQEtP-GTUkLneqkUQGOr-SRaDhnMYTob4KxjXVmSoZ7XaDBPWfVULQekRAIEPEoq7v-9Sw_H46P5QOlKIBAv1zaFq4-HSUeT8VcSWNEBFn7Fk',
      'author': '@geometrix',
      'likes': '942',
      'isLiked': false,
    },
    {
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuDH-qmWoRPrBx-MlZbYZeL8fS7lteumEPqp_1EW0uy_g2MF64wR9FSDBnpGxdmhATMslL-JYEBNC3SAvaPLm0VNYX3nG4MpT7auFilP3xRXibXxHl1PFBbK_d1hAU2seHQF9OzOwLrU3y-eJWTuq-6FbESVKcMaWrXWiQ58c9dy4qu9vwJr576H8JkYHHWt29jC8i3wFmyDgkdzjtmBsqRhOMy7uo8QWhTOpX0KIamAkBlnBmWvwTSXWTmQLaXznEdhCwzzVqLK9J7',
      'author': '@mythic_lines',
      'likes': '781',
      'isLiked': false,
    },
    {
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuCSA8u085UEX9FQ5CMBoqJoHJT7oQ6QVTo5kmvIzZVfgJ9X4bb6BsOYYuahhoWVy_vus9C_OsqPj7kiUAbDVeR7MuQo2ylL8JaHrk_4KYVjxYt4NkotehDwPp73U0_iBAPUqb-wUf0uDhW7X3Y0v9q0xC-B_b2KuYCSorBMPhHuLbHdWE_hm7T4ln34vroqH1NXA28Bgby5jFe4yTDdtH-lt8c14J3dzhFiP7zL9MwCDmcTWSM8vIRhAhXwMBN1ACc0K7jgOJfHZSJP',
      'author': '@astro_cat',
      'likes': '3.1k',
      'isLiked': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: DColors.primary.withOpacity(0.45),
              blurRadius: 18,
              spreadRadius: 4,
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CreateVectorView()),
            );
          },
          backgroundColor: DColors.primary,
          shape: const CircleBorder(),
          child: const Icon(Icons.draw_outlined, size: 30, color: Colors.black),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 6,
        shape: const CircularNotchedRectangle(),
        color: DColors.glassBgDark,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home, color: DColors.primary, size: 28),
              onPressed: () {},
            ),
            const SizedBox(width: 40),
            IconButton(
              icon: Icon(Icons.person_outline, color: DColors.textMuted, size: 28),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Background
          Container(decoration: DDecorations.gradientBackground()),

          // Particle background
          Positioned.fill(
            child: CustomPaint(painter: _ParticleBackgroundPainter()),
          ),

          // Main content
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
                    color: DColors.glassBgDark,
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
                padding: EdgeInsets.fromLTRB(0, DDimens.lg, 0, DDimens.xl),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Category chips
                    _buildCategorySection(),
                    SizedBox(height: DDimens.lg),

                    // Create your vision card
                    _buildCreateCard(),
                    SizedBox(height: DDimens.xl),

                    // Last Creations header
                    _buildSectionHeader(),
                    SizedBox(height: DDimens.md),

                    // Masonry grid
                    _buildMasonryGrid(),
                  ]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: DDimens.md),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = category == _selectedCategory;
          return Padding(
            padding: EdgeInsets.only(right: DDimens.sm),
            child: ChoiceChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedCategory = category;
                });
              },
              backgroundColor: DColors.glassBgDark,
              selectedColor: DColors.primary,
              labelStyle: TextStyle(
                color: isSelected ? Colors.black : DColors.textMuted,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              side: BorderSide(color: DColors.glassBorder),
              shape: const StadiumBorder(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCreateCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: DDimens.md),
      padding: EdgeInsets.all(DDimens.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            DColors.primary.withOpacity(0.1),
            DColors.secondary.withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(DDimens.radiusXl),
        border: Border.all(color: DColors.primary),
        boxShadow: [
          BoxShadow(
            color: DColors.primary.withOpacity(0.35),
            blurRadius: 18,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create your vision',
            style: DTextStyles.h2.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: DDimens.sm),
          Text(
            'Turn your ideas into stunning vector art with the power of AI.',
            style: DTextStyles.bodySmall.copyWith(color: DColors.textMuted),
          ),
          SizedBox(height: DDimens.md),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CreateVectorView()),
              );
            },
            icon: const Icon(Icons.auto_awesome, color: Colors.black),
            label: const Text('Start Creating'),
            style: ElevatedButton.styleFrom(
              backgroundColor: DColors.primary,
              foregroundColor: Colors.black,
              padding: EdgeInsets.symmetric(horizontal: DDimens.lg, vertical: DDimens.sm),
              shape: const StadiumBorder(),
              textStyle: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: DDimens.md),
      child: Row(
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
      ),
    );
  }

  Widget _buildMasonryGrid() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: DDimens.md),
      child: _MasonryGrid(creations: _creations),
    );
  }
}

// Masonry Grid Widget
class _MasonryGrid extends StatelessWidget {
  final List<Map<String, dynamic>> creations;

  const _MasonryGrid({required this.creations});

  @override
  Widget build(BuildContext context) {
    final leftItems = <Map<String, dynamic>>[];
    final rightItems = <Map<String, dynamic>>[];

    for (var i = 0; i < creations.length; i++) {
      if (i % 2 == 0) {
        leftItems.add(creations[i]);
      } else {
        rightItems.add(creations[i]);
      }
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: leftItems.map((item) => _CreationCard(item: item)).toList(),
          ),
        ),
        SizedBox(width: DDimens.md),
        Expanded(
          child: Column(
            children: rightItems.map((item) => _CreationCard(item: item)).toList(),
          ),
        ),
      ],
    );
  }
}

// Creation Card Widget
class _CreationCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const _CreationCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: DDimens.md),
      decoration: DDecorations.glassmorphic(
        borderRadius: BorderRadius.circular(DDimens.radiusMd),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            item['image'],
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Padding(
            padding: EdgeInsets.all(DDimens.sm),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item['author'],
                  style: DTextStyles.caption.copyWith(color: DColors.textMuted),
                ),
                Row(
                  children: [
                    Icon(
                      item['isLiked'] ? Icons.favorite : Icons.favorite_border,
                      size: 16,
                      color: item['isLiked'] ? Colors.pinkAccent : DColors.textMuted,
                    ),
                    SizedBox(width: DDimens.xs),
                    Text(
                      item['likes'],
                      style: DTextStyles.caption.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Particle Background Painter
class _ParticleBackgroundPainter extends CustomPainter {
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
