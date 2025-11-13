part of '../home_view.dart';

final List<String> _categories = [
  'Engraving',
  'Outcut',
  'Linocut',
  'Sticker',
  'Chibi',
  'Icon',
];

class _CategoriesSection extends StatelessWidget {
  const _CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = category == _categories.first;
          return Padding(
            padding: EdgeInsets.only(right: DDimens.sm),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(DDimens.radiusXl),
                child: AnimatedContainer(
                  duration: DConstants.fastAnimation,
                  padding: EdgeInsets.symmetric(
                    horizontal: DDimens.md,
                    vertical: DDimens.sm,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? DColors.primary : DColors.glassBgDark,
                    borderRadius: BorderRadius.circular(DDimens.radiusXl),
                    border: isSelected
                        ? null
                        : Border.all(color: DColors.glassBorder),
                  ),
                  child: Text(
                    category,
                    style: DTextStyles.buttonMedium.copyWith(
                      color: isSelected
                          ? DColors.backgroundDark
                          : DColors.textMuted,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
