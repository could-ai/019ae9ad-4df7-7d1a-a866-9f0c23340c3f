import 'package:flutter/material.dart';
import 'package:couldai_user_app/theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Datos mockeados para la demo
  final List<Map<String, dynamic>> _students = [
    {'id': '1', 'name': 'Juan Pérez', 'course': '1° Básico A', 'avatar': 'JP'},
    {'id': '2', 'name': 'María Pérez', 'course': '3° Básico B', 'avatar': 'MP'},
  ];

  final List<Map<String, dynamic>> _recentRequests = [
    {
      'type': 'Inasistencia',
      'student': 'Juan Pérez',
      'date': '15/05/2024',
      'status': 'Aprobado',
      'color': AppTheme.successColor
    },
    {
      'type': 'Atraso',
      'student': 'María Pérez',
      'date': '10/05/2024',
      'status': 'Pendiente',
      'color': AppTheme.pendingColor
    },
  ];

  String? _selectedStudentId;

  @override
  void initState() {
    super.initState();
    if (_students.isNotEmpty) {
      _selectedStudentId = _students[0]['id'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel de Apoderado'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sección de Selección de Alumno
            const Text(
              'Mis Estudiantes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 110,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _students.length,
                itemBuilder: (context, index) {
                  final student = _students[index];
                  final isSelected = student['id'] == _selectedStudentId;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedStudentId = student['id'];
                      });
                    },
                    child: Container(
                      width: 100,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? AppTheme.primaryColor.withOpacity(0.1) : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? AppTheme.primaryColor : Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: isSelected ? AppTheme.primaryColor : Colors.grey.shade400,
                            child: Text(
                              student['avatar'],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            student['name'].split(' ')[0],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isSelected ? AppTheme.primaryColor : Colors.black87,
                            ),
                          ),
                          Text(
                            student['course'],
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Botones de Acción Rápida
            const Text(
              'Solicitudes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _ActionButton(
                    icon: Icons.calendar_today,
                    label: 'Inasistencia',
                    color: AppTheme.primaryColor,
                    onTap: () {
                      // TODO: Navegar a formulario inasistencia
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Abrir formulario Inasistencia')),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _ActionButton(
                    icon: Icons.access_time,
                    label: 'Atraso',
                    color: AppTheme.secondaryColor,
                    onTap: () {
                      // TODO: Navegar a formulario atraso
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Abrir formulario Atraso')),
                      );
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Historial Reciente
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Historial Reciente',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Ver todo'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _recentRequests.length,
              itemBuilder: (context, index) {
                final request = _recentRequests[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: (request['color'] as Color).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        request['type'] == 'Inasistencia' ? Icons.calendar_today : Icons.access_time,
                        color: request['color'],
                      ),
                    ),
                    title: Text(request['type']),
                    subtitle: Text('${request['student']} - ${request['date']}'),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: (request['color'] as Color).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        request['status'],
                        style: TextStyle(
                          color: request['color'],
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 12),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
