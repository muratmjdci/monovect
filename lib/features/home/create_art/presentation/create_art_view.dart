import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:monovect/common/theme/d_colors.dart';
import 'package:monovect/common/theme/d_decorations.dart';
import 'package:monovect/common/theme/d_dimens.dart';
import 'package:monovect/common/theme/d_text_styles.dart';
import 'package:monovect/common/widget/credit_chip.dart';

class CreateVectorView extends StatefulWidget {
  const CreateVectorView({super.key});

  @override
  State<CreateVectorView> createState() => _CreateVectorViewState();
}

class _CreateVectorViewState extends State<CreateVectorView> {
  final TextEditingController _descriptionController = TextEditingController();
  String _selectedStyle = 'Engraving';
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  final List<Map<String, String>> _styles = [
    {
      'name': 'Engraving',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAhWoFS6DyF3TWU7o7crvBHLlfEhOzIshduWUDhXPr1Dd5RcoTjTHcM1lbvg1KOB2LLvwwQbYbbMl3RktdIkgyO5nChS-ZRYNAAJp0L33vORHdC-KjwvqCvY0zPmxQ5w5jUaI0aqn8Tp9nl5Q8EzOYlUYG2OrmZP6TLP4343EdrtvfiQdHzh3XYr4hOt7BNv5iDQNXGCwY29iLRBMhvhmxgJcOTNQvYqsf5Huyra1rmG3bh3G9_MwFeZC6Yvk1jpr6sdebvOfkSq-kc',
    },
    {
      'name': 'Outcut',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuD4pxwxspb4y2YHcFLtbH0cueUr3R4yMZWB8v3FZa1TMDblM3vtwerdSFxJzQN9Q8Zmekk28jFO7I4S5PoTCaAyvLv9NpjWl2j8IRnRNpxz7WAunFR4BHpctmf2pcFZztj53amkPo-j2VdeufwfoBJO9WzWM3TP4A4myEv5pqIEpBTzKTrdCA0VqHueoLZ80qG5gcIpIMCBsn4PTSTF55hWpgNhEuC6-aeKWkvnu3XHpMQFUyMZeogVH4p3d4wJmdETdzhD2Z_Ke4ou',
    },
    {
      'name': 'Linocut',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBrTPe4t6cbmnPG7Z3tvEr_MLsBuU3hbcEYdort4OLd7oy6Kad2TrR7Du2tXEc5s90-sUyNWbSsbS2ek8dH0ZYJtB59Thy2RkKDgG7E0gLZBDYXzDZSmwSMXZYrkjv6HeK2Ru4vM9FY9z8bTXMeQzNfJVi25ejFPjtcDfPcWzBQz1zJVDHRF5ylrZoZt12GPEyAt4ICtLlrHzd-oxHqI0qpqblzslHJ8WSO4rn3-Ze1eUf_IbTRz1uJer7je52ZYb33NsQIvGvqm5Io',
    },
    {
      'name': 'Drawing',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDh9KUwvZggflr7IO4RT1emFfwIqHFcX_Ejp-nP3mFViCa1ak_6ZN4OHqtmOgICc0EaKQOxuUgk_5J3-BH5AKzKdlHeYdgfG4XOpHd1e2zWqKvqYRxupots-74kzDHYwPbKW3O_UEKXE44GaYoj6RZNtfrqrmO2CenDVtVJqFW_BRiR2Co1N9QkgZ5IOg_5Z8iNZNhMsGxjvbpeHJv1JfHAWyEj7r8QZ0EVErou1P4xNPZsztgilMBq__DXxnU9ZjzQan5DFYEGetYB',
    },
    {
      'name': 'Cartoon',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBsgwBGHHhqKITT5ebq6jdgo_dwWGjrcydr4UVEDU1f11BEcuh3z0kSVmgbREh6CYlqi1c-7e7jinAJJQ34S7aeD7MbwIH5hMlDn89rPBF9GrX5rrR_p5Qd05FXsj4inTvNFrOLs1EFVNWQYLjKAohBHt9Irxg4JIeUY9oSdamjDzbidrxeSAPCvjmFuzIh305oAt9ava5j4EVlJ6cJg4dzGXkqFEk-3ljuI9kNRnVs_rw-M-mM72SEEw9KofHHst8F6tKMvqnPH9AI',
    },
    {
      'name': 'Sticker',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDPcvaPmdQT1mZOLqrKMewFTJ95fzxhnUmmea4zcoeR2W91mE0k4W8Mq_ZQb9BZj-wx56N956Yg9TlE10pKyg9WaNbThNYuEIDyd78UYTZ5Vz8GXYPSn-5fEy3HmlgmNbHbS0zM3mwkpbC8cjPqm_iau0Bx7jUrczxbp-fBzqZBAGc1ichnq2P4rlaJCx72et6ATrO0GrqxlGyZ1_iVYdg0iaIzLMYeu2Thjli7Wnq2yvP9eH5Ai0Rwc5DovxMtn_2RG5u_M-YnUPbB',
    },
  ];

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking image: $e')),
        );
      }
    }
  }

  void _generateVector() {
    if (_descriptionController.text.isEmpty && _selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide a description or upload an image'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Generating vector with style: $_selectedStyle'),
        backgroundColor: DColors.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomAppBar(
        color: DColors.glassBgDark,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home_outlined, color: DColors.textMuted, size: 28),
              onPressed: () => Navigator.pop(context),
            ),
            IconButton(
              icon: const Icon(Icons.draw, color: DColors.primary, size: 28),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.person_outline, color: DColors.textMuted, size: 28),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Background gradient
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
                leading: const SizedBox(),
                elevation: 0,
                backgroundColor: Colors.transparent,
                expandedHeight: 0,
                toolbarHeight: 80,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    color: DColors.glassBgDark,
                    border: Border(
                      bottom: BorderSide(color: DColors.glassBorder),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 32,
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: DDimens.md,
                        vertical: DDimens.sm,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Create Vector',
                            style: DTextStyles.h2.copyWith(
                              color: DColors.primary,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -1.0,
                            ),
                          ),
                          const Spacer(),
                          const CreditChip(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Content
              SliverPadding(
                padding: EdgeInsets.only(
                  top: DDimens.xl,
                  bottom: 120,
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Image Upload Section
                    _buildImageUploadSection(),
                    SizedBox(height: DDimens.xl),

                    // Style Selection Section
                    _buildStyleSection(),
                    SizedBox(height: DDimens.xl),

                    // Description Section
                    _buildDescriptionSection(),
                  ]),
                ),
              ),
            ],
          ),

          // Fixed Generate Button
          Positioned(
            bottom: 100,
            left: DDimens.md,
            right: DDimens.md,
            child: _buildGenerateButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildImageUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: DDimens.lg),
          child: Text(
            'Upload Image (Optional)',
            style: DTextStyles.labelSmall.copyWith(color: DColors.textMuted),
          ),
        ),
        SizedBox(height: DDimens.sm),
        InkWell(
          onTap: _pickImage,
          borderRadius: BorderRadius.circular(DDimens.radiusXl),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: DDimens.md),
            width: double.infinity,
            padding: EdgeInsets.all(DDimens.xl),
            decoration: DDecorations.glassmorphic(
              borderRadius: BorderRadius.circular(DDimens.radiusXl),
            ).copyWith(
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 2,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
            ),
            child: _selectedImage == null
                ? Column(
                    children: [
                      const Icon(
                        Icons.add_photo_alternate_outlined,
                        size: 48,
                        color: DColors.textMuted,
                      ),
                      SizedBox(height: DDimens.sm),
                      Text(
                        'Tap to upload or select an image',
                        style: DTextStyles.bodySmall.copyWith(
                          fontWeight: FontWeight.w600,
                          color: DColors.textDark,
                        ),
                      ),
                      SizedBox(height: DDimens.xs),
                      Text(
                        'PNG, JPG, SVG up to 10MB',
                        style: DTextStyles.caption.copyWith(
                          color: DColors.textMuted,
                        ),
                      ),
                    ],
                  )
                : Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(DDimens.radiusMd),
                        child: Image.file(
                          _selectedImage!,
                          fit: BoxFit.cover,
                          height: 200,
                          width: double.infinity,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.black54,
                          ),
                          onPressed: () {
                            setState(() {
                              _selectedImage = null;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildStyleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: DDimens.lg),
          child: Text(
            'Choose a Style',
            style: DTextStyles.labelSmall.copyWith(color: DColors.textMuted),
          ),
        ),
        SizedBox(height: DDimens.sm),
        SizedBox(
          height: 176,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: DDimens.md),
            itemCount: _styles.length,
            itemBuilder: (context, index) {
              final style = _styles[index];
              final isSelected = style['name'] == _selectedStyle;
              return Padding(
                padding: EdgeInsets.only(right: DDimens.md),
                child: _StyleCard(
                  name: style['name']!,
                  imageUrl: style['image']!,
                  isSelected: isSelected,
                  onTap: () {
                    setState(() {
                      _selectedStyle = style['name']!;
                    });
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: DDimens.lg),
          child: Text(
            'Describe your vision',
            style: DTextStyles.labelSmall.copyWith(color: DColors.textMuted),
          ),
        ),
        SizedBox(height: DDimens.sm),
        Container(
          margin: EdgeInsets.symmetric(horizontal: DDimens.md),
          decoration: DDecorations.glassmorphic(
            borderRadius: BorderRadius.circular(DDimens.radiusXl),
          ),
          child: TextField(
            controller: _descriptionController,
            maxLines: 6,
            style: DTextStyles.bodyMedium.copyWith(color: DColors.textDark),
            decoration: InputDecoration(
              hintText:
                  'e.g., A majestic lion wearing a crown, detailed vector illustration, vibrant colors...',
              hintStyle: DTextStyles.bodyMedium.copyWith(
                color: DColors.textMuted,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(DDimens.radiusXl),
                borderSide: BorderSide(color: DColors.glassBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(DDimens.radiusXl),
                borderSide: BorderSide(color: DColors.glassBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(DDimens.radiusXl),
                borderSide: const BorderSide(color: DColors.primary, width: 2),
              ),
              contentPadding: EdgeInsets.all(DDimens.md),
              filled: false,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenerateButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: DColors.primary.withOpacity(0.45),
            blurRadius: 24,
            spreadRadius: 4,
          ),
          BoxShadow(
            color: DColors.primary.withOpacity(0.35),
            blurRadius: 14,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: _generateVector,
        icon: const Icon(Icons.add, size: 24, color: Colors.black),
        label: const Text(
          'Generate Vector',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: DColors.primary,
          padding: EdgeInsets.symmetric(vertical: DDimens.md),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: BorderSide(color: DColors.primary),
          ),
          minimumSize: const Size(double.infinity, 56),
        ),
      ),
    );
  }
}

// Style Card Widget
class _StyleCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final bool isSelected;
  final VoidCallback onTap;

  const _StyleCard({
    required this.name,
    required this.imageUrl,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 128,
        decoration: BoxDecoration(
          color: DColors.glassBgDark,
          borderRadius: BorderRadius.circular(DDimens.radiusLg),
          border: Border.all(
            color: isSelected ? DColors.primary : DColors.glassBorder,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: DColors.primary.withOpacity(0.3),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    color: DColors.primary.withOpacity(0.2),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ]
              : [],
        ),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(DDimens.radiusLg - 2),
                ),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade800,
                      child: const Icon(Icons.error, color: Colors.white54),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  name,
                  style: DTextStyles.labelSmall.copyWith(
                    color: isSelected ? DColors.primary : DColors.textMuted,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
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
