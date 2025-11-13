part of '../home_view.dart';

class _CreateCard extends StatelessWidget {
  const _CreateCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(DDimens.lg),
      decoration: DDecorations.primaryGlow(
        borderRadius: BorderRadius.circular(DDimens.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Create your vision', style: DTextStyles.h3),
          SizedBox(height: DDimens.sm),
          Text(
            'Turn your ideas into stunning vector art with the power of AI.',
            style: DTextStyles.bodyMedium.copyWith(color: DColors.textDark),
          ),
          SizedBox(height: DDimens.md),
          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.auto_awesome, size: DDimens.iconSm),
            label: const Text('Start Creating'),
            style: ElevatedButton.styleFrom(
              backgroundColor: DColors.primary,
              foregroundColor: DColors.backgroundDark,
              padding: EdgeInsets.symmetric(
                horizontal: DDimens.lg,
                vertical: DDimens.sm,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(DDimens.radiusXl),
              ),
              textStyle: DTextStyles.buttonMedium,
            ),
          ),
        ],
      ),
    );
  }
}
