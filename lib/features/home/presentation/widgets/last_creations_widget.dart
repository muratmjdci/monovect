import 'package:flutter/material.dart';

class LastCreationsWidget extends StatelessWidget {
  const LastCreationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 120),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          return _ArtworkCard(artwork: _artworks[index]);
        }, childCount: _artworks.length),
      ),
    );
  }
}

class _ArtworkCard extends StatelessWidget {
  final Map<String, dynamic> artwork;

  const _ArtworkCard({super.key, required this.artwork});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E).withOpacity(0.45),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.network(
                artwork['image'],
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    artwork['username'],
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF8A8A8E),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      artwork['isLiked']
                          ? Icons.favorite
                          : Icons.favorite_border,
                      size: 16,
                      color: artwork['isLiked']
                          ? Colors.pinkAccent
                          : const Color(0xFF8A8A8E),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      artwork['likes'],
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
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

final List<Map<String, dynamic>> _artworks = [
  {
    'image':
        'https://lh3.googleusercontent.com/aida-public/AB6AXuAoD539qDNJmKFyrnla2Upoxrej4TRrkOwzFq5Amz0rvIfXn7fbN_VyUsNKKe370f9bMiC1MmaWs9yw5CDd9tFfCOy20-nfhA32we5VVg9cX2uHfQQgbFMnneMl3q9Y7-OIJwNyfbeWPhCcq7XcOsAuzGLYHp3J5AhEHioLM5Q9BhjtP25a6Z12Ho23IcRj0pPmvypUbDe_sEPPVGpBXfjp_QUpaqvXnXcPGnNtJw8Zf-sQM6tGf6NuKuBiuC_VLHnXKQdpKFF8ck8D',
    'username': '@artisan_wolf',
    'likes': '1.2k',
    'isLiked': true,
  },
  {
    'image':
        'https://lh3.googleusercontent.com/aida-public/AB6AXuAKGaz6oJ14nI9_iqosAwMC6W17Tzl6TU7_0qsBj0wIu7d3LLTVGaKK41g1e55JOuuVZm4V-o5W8Jg-7i-skxa6wZuqZN_WYesm-XPkQHdhghRupNqM64jJfeD8beE_1bk7wHk3UHZII2LmsPO7Oshn2pDzXw7ygRPQOrDS-XWiCBaN8cxpuh9y3hd3XW8KPhQANtdWgw8YnK8n0_6TCAw1eYq1sxMdMmAmZKf9yBJOk9CVSwj_pzfPR2Zt3YN4-oUZBl60xyLcaR-M',
    'username': '@city_dreamer',
    'likes': '876',
    'isLiked': false,
  },
  {
    'image':
        'https://lh3.googleusercontent.com/aida-public/AB6AXuD1m9UF996OjzOyHN0YXLSWKxLfVQPgGIU5s8OOgLQmasyr9cBVJ2A5oqJBkuB7wfZOfYt-KwsmK9yyZsLAjGrS1MGgIMien2KRWeSuz604H0zAM5byFlp15OeMTDW6nTCrWgfA-8ft7x6nAjzIcZ1UOQihPiZEVm-BbbAK_cr6TQoL3jvV2LobqqG_qSSFu6mzyJy3FVC41TCUZBGMrKqxemJtHYqPDb1N1LR0GNnlQg7ertemFcc8MNHIaoUWnHJWoAwKdt6AZcXk',
    'username': '@vector_vixen',
    'likes': '2.5k',
    'isLiked': true,
  },
  {
    'image':
        'https://lh3.googleusercontent.com/aida-public/AB6AXuAieh-G0ong4SEtoY8bFbJdT26UQcMGBwbYIu94XXFmGPn5leGfVmlaFErPH8xdyBLr4sEekhGvcvHPSI8A65LRxKyg-rgJpuOATdYjMpzCwQ-1uuF6y-noVnVUciGzhVYtaB13c95x8oUZRPrPi7bh32N8EOiErc4VQEtP-GTUkLneqkUQGOr-SRaDhnMYTob4KxjXVmSoZ7XaDBPWfVULQekRAIEPEoq7v-9Sw_H46P5QOlKIBAv1zaFq4-HSUeT8VcSWNEBFn7Fk',
    'username': '@geometrix',
    'likes': '942',
    'isLiked': false,
  },
  {
    'image':
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDH-qmWoRPrBx-MlZbYZeL8fS7lteumEPqp_1EW0uy_g2MF64wR9FSDBnpGxdmhATMslL-JYEBNC3SAvaPLm0VNYX3nG4MpT7auFilP3xRXibXxHl1PFBbK_d1hAU2seHQF9OzOwLrU3y-eJWTuq-6FbESVKcMaWrXWiQ58c9dy4qu9vwJr576H8JkYHHWt29jC8i3wFmyDgkdzjtmBsqRhOMy7uo8QWhTOpX0KIamAkBlnBmWvvwTSXWTmQLaXznEdhCwzzVqLK9J7',
    'username': '@mythic_lines',
    'likes': '781',
    'isLiked': false,
  },
  {
    'image':
        'https://lh3.googleusercontent.com/aida-public/AB6AXuCSA8u085UEX9FQ5CMBoqJoHJT7oQ6QVTo5kmvIzZVfgJ9X4bb6BsOYYuahhoWVy_vus9C_OsqPj7kiUAbDVeR7MuQo2ylL8JaHrk_4KYVjxYt4NkotehDwPp73U0_iBAPUqb-wUf0uDhW7X3Y0v9q0xC-B_b2KuYCSorBMPhHuLbHdWE_hm7T4ln34vroqH1NXA28Bgby5jFe4yTDdtH-lt8c14J3dzhFiP7zL9MwCDmcTWSM8vIRhAhXwMBN1ACc0K7jgOJfHZSJP',
    'username': '@astro_cat',
    'likes': '3.1k',
    'isLiked': true,
  },
];
