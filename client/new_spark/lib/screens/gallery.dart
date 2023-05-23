import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:new_spark/config/palette.dart';
import 'package:new_spark/data/data.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Gallery extends StatelessWidget {
  const Gallery({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Palette.scaffold,
        backgroundColor: Colors.grey[900],
        body: Container(
          color: Colors.amber,
        ));
  }
}


//       body: Container(
//         margin: const EdgeInsets.all(10.0),
//         child: masonryLayout(context),
//       ),
//     );
//   }
// }

// Widget masonryLayout(BuildContext context) {
//   return MasonryGridView.count(
//       itemCount: stories.length,
//       crossAxisSpacing: 5,
//       mainAxisSpacing: 5,
//       crossAxisCount: 2,
//       itemBuilder: (context, index) {
//         return ClipRRect(
//           borderRadius: BorderRadius.circular(20.0),
//           child: CachedNetworkImage(
//             imageUrl: stories[index].imageUrl,
//           ),
//         );
//       });
// }
