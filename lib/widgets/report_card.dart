import 'package:flutter/material.dart';
import 'like_animation.dart';

class ReportCard extends StatefulWidget {
  const ReportCard({super.key});

  @override
  State<ReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard> {
  bool isLikeAnimating = false;

  @override
  Widget build(BuildContext context) {
    // final User user = Provider.of<UserProvider>(context).getUser;
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                  .copyWith(right: 0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(
                      'https://icones.pro/wp-content/uploads/2021/02/icone-utilisateur-gris.png',
                    ),
                    backgroundColor: Colors.white,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'John' + ' Doe',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => Dialog(
                                child: ListView(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shrinkWrap: true,
                                  children: [
                                    'Reportar Publicacion',
                                  ]
                                      .map(
                                        (e) => InkWell(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 16),
                                            child: Text(e),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ));
                    },
                    icon: const Icon(Icons.more_vert),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    child: RichText(
                      text: const TextSpan(
                          style: TextStyle(color: Colors.green),
                          children: [
                            TextSpan(
                              text: '10 likes',
                            ),
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    child: RichText(
                      text: const TextSpan(
                          style: TextStyle(color: Colors.grey),
                          children: [
                            TextSpan(
                              text: 'Place reference',
                            ),
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DefaultTextStyle(
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontWeight: FontWeight.w800),
                    child: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas id volutpat dolor. Cras arcu quam, facilisis ut odio eu, ullamcorper sodales elit.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onDoubleTap: () async {
                // FirestoreMethods().likeReport(
                //   widget.snap['reportId'],
                //   user.uid,
                //   widget.snap['likes'],
                // );
                setState(() {
                  isLikeAnimating = true;
                });
              },
              child: Stack(alignment: Alignment.center, children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  child: Image.network(
                    "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png",
                    fit: BoxFit.cover,
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isLikeAnimating ? 1 : 0,
                  child: LikeAnimation(
                    child: const Icon(Icons.thumb_up,
                        color: Colors.green, size: 120),
                    isAnimating: isLikeAnimating,
                    duration: const Duration(
                      milliseconds: 400,
                    ),
                    onEnd: () {
                      setState(() {
                        isLikeAnimating = false;
                      });
                    },
                  ),
                )
              ]),
            ),
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      // color: widget.snap['likes'].contains(user.uid) ? Color.fromARGB(255, 255, 153, 146) : Colors.white,
                      color: Colors.white,
                      child: LikeAnimation(
                        // isAnimating: widget.snap['likes'].contains(user.uid),
                        isAnimating: false,
                        smallLike: true,
                        child: TextButton.icon(
                            onPressed: () async {
                              // await FirestoreMethods().likeReport(
                              //   widget.snap['reportId'],
                              //   user.uid,
                              //   widget.snap['likes'],
                              // );

                              setState(() {
                                isLikeAnimating = true;
                              });
                            },
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ))),
                            icon: Icon(Icons.thumb_up),
                            label: Text('Me gusta')),
                      ),
                    ),
                  ),
                  VerticalDivider(
                    width: 1,
                    thickness: 1,
                  ),
                  Expanded(
                    child: TextButton.icon(
                        onPressed: () {},
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ))),
                        icon: Icon(Icons.chat_bubble),
                        label: Text('Comentar')),
                  ),
                  VerticalDivider(
                    width: 1,
                    thickness: 1,
                  ),
                  Expanded(
                    child: TextButton.icon(
                        onPressed: () {},
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ))),
                        icon: Icon(Icons.send),
                        label: Text('Compartir')),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: Text(
                  'Ver todos los 20 comentarios',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Text(
                '30/08/2022',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
