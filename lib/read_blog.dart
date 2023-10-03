import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:subspace/blog_modal.dart';

class ReadBlog extends StatefulWidget {
  final Blog blog;
  ReadBlog({required this.blog});

  @override
  State<ReadBlog> createState() => _ReadBlogState();
}

class _ReadBlogState extends State<ReadBlog> {
  bool isBookmarked = false;
  SharedPreferences? _prefs;
  late String _bookmarkKey;

  FaIcon bookmarkedIcon = FaIcon(
    FontAwesomeIcons.check,
    color: Colors.teal,
    size: 20,
  );

  FaIcon unbookmarkedIcon = FaIcon(
    FontAwesomeIcons.bookmark,
    color: Colors.white,
    size: 20,
  );

  @override
  void initState() {
    super.initState();
    // Initialize SharedPreferences
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _prefs = prefs;
        // Create a unique key for the blog's bookmarked state
        _bookmarkKey = 'isBookmarked_${widget.blog.id}';
        // Load the bookmarked state from SharedPreferences
        isBookmarked = _prefs?.getBool(_bookmarkKey) ?? false;
      });
    });
  }

  void showBookmarkSnackbar() {
    final message = isBookmarked ? 'Bookmarked' : 'Bookmark removed';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 1), // Adjust the duration as needed
      ),
    );
  }

  Future<void> _triggerHapticFeedback() async {
    if (await Vibrate.canVibrate) {
      if (isBookmarked) {
        // Trigger haptic feedback for bookmarking
        Vibrate.feedback(FeedbackType.success);
      } else {
        // Trigger haptic feedback for removing bookmark
        Vibrate.feedback(FeedbackType.warning);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("0F1E23"),
      appBar: AppBar(
        surfaceTintColor: HexColor("0F1E23"),
        centerTitle: true,
        leading: const BackButton(
          color: Colors.white, // <-- SEE HERE
        ),
        backgroundColor: HexColor("0F1E23"),
        title: RichText(
            text: TextSpan(children: [
          TextSpan(
              text: "B L O G ",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat")),
          TextSpan(
              text: "S P A C E",
              style: TextStyle(
                  color: Colors.teal,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat"))
        ])),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(100)),
              child: Center(
                child: IconButton(
                  icon: isBookmarked ? bookmarkedIcon : unbookmarkedIcon,
                  onPressed: () async {
                    // Trigger haptic feedback
                    await _triggerHapticFeedback();

                    setState(() {
                      isBookmarked = !isBookmarked;
                    });

                    // Save the bookmarked state to SharedPreferences with the unique key
                    _prefs?.setBool(_bookmarkKey, isBookmarked);

                    // Show the bookmark Snackbar
                    showBookmarkSnackbar();
                  },
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Stack(children: [
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.teal.shade100,
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white, // Placeholder color
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.blog.image_url),
                        fit: BoxFit.cover)),
              ),
            ]),
            SizedBox(height: 10),
            Text(widget.blog.title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat")),
            SizedBox(height: 100),
            Text("Blog Content Goes Here",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat"))
          ],
        ),
      ),
    );
  }
}
