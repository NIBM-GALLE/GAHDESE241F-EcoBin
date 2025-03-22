import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class BinReviewPage extends StatefulWidget {
  const BinReviewPage({super.key});

  @override
  _BinReviewPageState createState() => _BinReviewPageState();
}

class _BinReviewPageState extends State<BinReviewPage> {
  double _rating = 0;
  final TextEditingController _reviewController = TextEditingController();
  File? _image;
  final ImagePicker _picker = ImagePicker();

  // Minimalist color scheme
  final Color primaryColor = const Color(0xFF4CAF50);
  final Color surfaceColor = Colors.white;
  final Color backgroundColor = const Color(0xFFF5F5F5);
  final Color textColor = const Color(0xFF212121);
  final Color secondaryTextColor = const Color(0xFF757575);

  // Sample customer reviews data
  final List<Map<String, dynamic>> _customerReviews = [
    {
      'name': 'Emily Johnson',
      'rating': 4.5,
      'date': '28 Feb 2025',
      'comment':
          'This bin is perfect for sorting recyclables. It has clear labels and enough compartments for different materials.',
      'hasImage': true,
    },
    {
      'name': 'Michael Chen',
      'rating': 5.0,
      'date': '25 Feb 2025',
      'comment':
          'Excellent design and durability. It fits perfectly in my kitchen and helps me stay organized with waste separation.',
      'hasImage': false,
    },
    {
      'name': 'Sarah Williams',
      'rating': 3.5,
      'date': '20 Feb 2025',
      'comment':
          'Good bin but could use more compartments. The lid sometimes sticks which can be annoying.',
      'hasImage': false,
    },
    {
      'name': 'David Rodriguez',
      'rating': 4.0,
      'date': '15 Feb 2025',
      'comment':
          'Sturdy construction and easy to clean. I like the eco-friendly materials used in making this bin.',
      'hasImage': true,
    },
  ];

  // Calculate average rating from all reviews
  double get _averageRating {
    if (_customerReviews.isEmpty) return 0;
    double total = _customerReviews.fold(
      0,
      (sum, review) => sum + (review['rating'] as double),
    );
    return total / _customerReviews.length;
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green.shade600,
        title: const Text(
          'Rate & Reviews',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: textColor),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Rating overview card
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    '${_averageRating.toStringAsFixed(1)}',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      // Show full, half or empty stars based on average rating
                      IconData starIcon;
                      if (index < _averageRating.floor()) {
                        starIcon = Icons.star_rounded;
                      } else if (index < _averageRating) {
                        starIcon = Icons.star_half_rounded;
                      } else {
                        starIcon = Icons.star_outline_rounded;
                      }

                      return Icon(starIcon, color: Colors.amber, size: 24);
                    }),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Based on ${_customerReviews.length} reviews',
                    style: TextStyle(color: secondaryTextColor, fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  // Simple rating bars
                  ...List.generate(5, (index) {
                    int starCount = 5 - index;
                    int reviewsWithThisRating =
                        _customerReviews
                            .where(
                              (review) =>
                                  (review['rating'] as double).round() ==
                                  starCount,
                            )
                            .length;
                    double percentage =
                        _customerReviews.isNotEmpty
                            ? reviewsWithThisRating / _customerReviews.length
                            : 0;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        children: [
                          Text(
                            '$starCount',
                            style: TextStyle(
                              color: secondaryTextColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(2),
                              child: LinearProgressIndicator(
                                value: percentage,
                                backgroundColor: Colors.grey.shade100,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  primaryColor,
                                ),
                                minHeight: 4,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            reviewsWithThisRating.toString(),
                            style: TextStyle(
                              color: secondaryTextColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Write a review section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Write a Review',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Rating stars
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(5, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _rating = index + 1;
                          });
                        },
                        child: Icon(
                          index < _rating
                              ? Icons.star_rounded
                              : Icons.star_outline_rounded,
                          color:
                              index < _rating
                                  ? Colors.amber
                                  : Colors.grey.shade400,
                          size: 32,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                  // Review text field
                  TextField(
                    controller: _reviewController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Share your experience with this bin...',
                      hintStyle: TextStyle(
                        color: secondaryTextColor.withOpacity(0.6),
                      ),
                      filled: true,
                      fillColor: backgroundColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.all(16),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Image upload button
                  InkWell(
                    onTap: _pickImage,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child:
                          _image == null
                              ? Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_photo_alternate_outlined,
                                      color: secondaryTextColor,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Add photo',
                                      style: TextStyle(
                                        color: secondaryTextColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              : ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  _image!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Submit button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle submit logic
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                              'Review submitted successfully',
                            ),
                            backgroundColor: primaryColor,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );

                        // Clear form after submission
                        setState(() {
                          _rating = 0;
                          _reviewController.clear();
                          _image = null;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Submit Review',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Customer reviews section
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Text(
                'Customer Reviews',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
            ),

            // Review list
            ..._customerReviews.map((review) => _buildReviewCard(review)),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // Method to build individual review cards
  Widget _buildReviewCard(Map<String, dynamic> review) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User avatar
              CircleAvatar(
                backgroundColor: backgroundColor,
                radius: 18,
                child: Text(
                  review['name'].substring(0, 1),
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // Review content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name and date
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          review['name'],
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: textColor,
                          ),
                        ),
                        Text(
                          review['date'],
                          style: TextStyle(
                            fontSize: 12,
                            color: secondaryTextColor,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    // Rating stars
                    Row(
                      children: List.generate(5, (index) {
                        // Show full, half or empty stars based on rating
                        IconData starIcon;
                        if (index < review['rating'].floor()) {
                          starIcon = Icons.star_rounded;
                        } else if (index < review['rating']) {
                          starIcon = Icons.star_half_rounded;
                        } else {
                          starIcon = Icons.star_outline_rounded;
                        }

                        return Icon(starIcon, color: Colors.amber, size: 16);
                      }),
                    ),

                    const SizedBox(height: 8),

                    // Review text
                    Text(
                      review['comment'],
                      style: TextStyle(
                        fontSize: 14,
                        color: textColor,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Review image if available
          if (review['hasImage'])
            Container(
              margin: const EdgeInsets.only(top: 12),
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Icon(
                  Icons.image,
                  size: 28,
                  color: secondaryTextColor.withOpacity(0.5),
                ),
              ),
            ),

          // Helpfulness buttons
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              children: [
                _buildActionButton(Icons.thumb_up_outlined, 'Helpful'),
                const SizedBox(width: 12),
                _buildActionButton(Icons.thumb_down_outlined, 'Not helpful'),
                const Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Report',
                    style: TextStyle(fontSize: 12, color: secondaryTextColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, size: 14, color: secondaryTextColor),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(fontSize: 12, color: secondaryTextColor),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }
}
