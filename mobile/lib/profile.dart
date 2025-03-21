import 'package:flutter/material.dart';

void main() {
  runApp(const ProfileOfUser(children: []));
}

class ProfileOfUser extends StatelessWidget {
  const ProfileOfUser({Key? key, required List<Text> children})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EcoWaste Manager',
      theme: ThemeData(
        primaryColor: const Color(0xFF1B5E20), // Dark Green
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1B5E20),
          primary: const Color(0xFF1B5E20),
          secondary: const Color(0xFF43A047),
          background: Colors.white,
        ),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1B5E20),
          foregroundColor: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFF1B5E20), width: 2),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1B5E20),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        useMaterial3: true,
      ),
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Bin types
  final List<Map<String, dynamic>> binTypes = [
    {
      'name': 'General Waste',
      'icon': Icons.delete,
      'color': const Color.fromARGB(255, 23, 23, 23),
      'selected': true,
    },
    {
      'name': 'Recyclables',
      'icon': Icons.recycling,
      'color': Colors.blue,
      'selected': true,
    },
    {
      'name': 'Organic Waste',
      'icon': Icons.eco,
      'color': Colors.green,
      'selected': false,
    },
    {
      'name': 'Glass',
      'icon': Icons.liquor,
      'color': Colors.amber,
      'selected': false,
    },
    {
      'name': 'Hazardous',
      'icon': Icons.warning,
      'color': Colors.red,
      'selected': false,
    },
  ];

  // Form controllers
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController(text: 'John');
  final _lastNameController = TextEditingController(text: 'Smith');
  final _emailController = TextEditingController(
    text: 'john.smith@example.com',
  );
  bool _isEditing = false;
  String _profileImagePath = '';

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isEditing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully'),
          backgroundColor: Color(0xFF1B5E20),
        ),
      );
    }
  }

  void _updateBinSelection(int index) {
    setState(() {
      binTypes[index]['selected'] = !binTypes[index]['selected'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Profile' : 'My Profile'),
        elevation: 0,
        actions: [
          if (!_isEditing)
            IconButton(icon: const Icon(Icons.edit), onPressed: _toggleEditMode)
          else
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: _toggleEditMode,
            ),
          if (_isEditing)
            IconButton(icon: const Icon(Icons.check), onPressed: _saveProfile),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Picture
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey[200],
                      backgroundImage:
                          _profileImagePath.isNotEmpty
                              ? AssetImage(_profileImagePath) as ImageProvider
                              : null,
                      child:
                          _profileImagePath.isEmpty
                              ? const Icon(
                                Icons.person,
                                size: 80,
                                color: Colors.grey,
                              )
                              : null,
                    ),
                    if (_isEditing)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          radius: 20,
                          child: IconButton(
                            icon: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20,
                            ),
                            onPressed: () {
                              // Implement image selection
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Personal Information Section
              Text(
                'Personal Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // First Name
                    Text(
                      'First Name',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _isEditing
                        ? TextFormField(
                          controller: _firstNameController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your first name',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your first name';
                            }
                            return null;
                          },
                        )
                        : Text(
                          _firstNameController.text,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    const SizedBox(height: 16),

                    // Last Name
                    Text(
                      'Last Name',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _isEditing
                        ? TextFormField(
                          controller: _lastNameController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your last name',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your last name';
                            }
                            return null;
                          },
                        )
                        : Text(
                          _lastNameController.text,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    const SizedBox(height: 16),

                    // Email
                    Text(
                      'Email Address',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _isEditing
                        ? TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your email address',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!value.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        )
                        : Text(
                          _emailController.text,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Bin Selection Section
              Text(
                'Requested Bins',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  children: List.generate(binTypes.length, (index) {
                    final bin = binTypes[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: InkWell(
                        onTap:
                            _isEditing
                                ? () => _updateBinSelection(index)
                                : null,
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color:
                                bin['selected']
                                    ? bin['color'].withOpacity(0.1)
                                    : Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color:
                                  bin['selected']
                                      ? bin['color']
                                      : Colors.grey[300]!,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(bin['icon'], color: bin['color'], size: 24),
                              const SizedBox(width: 16),
                              Text(
                                bin['name'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      bin['selected']
                                          ? bin['color']
                                          : Colors.grey[700],
                                ),
                              ),
                              const Spacer(),
                              if (_isEditing)
                                Checkbox(
                                  value: bin['selected'],
                                  onChanged: (bool? value) {
                                    _updateBinSelection(index);
                                  },
                                  activeColor: bin['color'],
                                )
                              else if (bin['selected'])
                                Icon(Icons.check_circle, color: bin['color']),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 30),

              if (_isEditing)
                Center(
                  child: ElevatedButton(
                    onPressed: _saveProfile,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Save Profile',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
