import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'like_animation.dart';

class ReportCard extends StatefulWidget {
  final snap;
  const ReportCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<ReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard> {
  bool isLikeAnimating = false;

  @override
  Widget build(BuildContext context) {
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
                    backgroundImage: NetworkImage(widget.snap['profImage']),
                    backgroundColor: Colors.white,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.snap['firstname'] +
                                ' ' +
                                widget.snap['lastname'],
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
                      text: TextSpan(
                          style: TextStyle(color: Colors.teal),
                          children: [
                            TextSpan(
                              text: '${widget.snap['likes'].length} likes',
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
                      widget.snap['description'],
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
                    widget.snap['postUrl'],
                    fit: BoxFit.cover,
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isLikeAnimating ? 1 : 0,
                  child: LikeAnimation(
                    child: const Icon(Icons.thumb_up,
                        color: Colors.teal, size: 120),
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
                        icon: Icon(Icons.star),
                        label: Text('Calificar')),
                  ),
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
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Text(
                DateFormat.yMMMd().format(
                  widget.snap['createdAt'].toDate(),
                ),
                style: TextStyle(
                  color: Colors.grey,
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
