class TimeSlotModel {
  final String id;
  final String startTime; // Format: HH:mm
  final String endTime; // Format: HH:mm
  final bool isAvailable;
  final bool isBooked;

  TimeSlotModel({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.isAvailable,
    required this.isBooked,
  });

  String get label => '$startTime - $endTime';

  // Copy with for immutable state updates
  TimeSlotModel copyWith({
    String? id,
    String? startTime,
    String? endTime,
    bool? isAvailable,
    bool? isBooked,
  }) {
    return TimeSlotModel(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isAvailable: isAvailable ?? this.isAvailable,
      isBooked: isBooked ?? this.isBooked,
    );
  }
}

class DayAvailabilityModel {
  final DateTime date;
  final List<TimeSlotModel> slots;

  DayAvailabilityModel({
    required this.date,
    required this.slots,
  });

  DayAvailabilityModel copyWith({
    DateTime? date,
    List<TimeSlotModel>? slots,
  }) {
    return DayAvailabilityModel(
      date: date ?? this.date,
      slots: slots ?? this.slots,
    );
  }

  // Mock data for development
  static List<DayAvailabilityModel> mockAvailability() {
    final today = DateTime.now();
    return [
      // Today
      DayAvailabilityModel(
        date: today,
        slots: [
          TimeSlotModel(
            id: '1',
            startTime: '14:00',
            endTime: '15:00',
            isAvailable: true,
            isBooked: false,
          ),
          TimeSlotModel(
            id: '2',
            startTime: '15:00',
            endTime: '16:00',
            isAvailable: true,
            isBooked: false,
          ),
          TimeSlotModel(
            id: '3',
            startTime: '16:00',
            endTime: '17:00',
            isAvailable: false,
            isBooked: true,
          ),
          TimeSlotModel(
            id: '4',
            startTime: '17:00',
            endTime: '18:00',
            isAvailable: true,
            isBooked: false,
          ),
          TimeSlotModel(
            id: '5',
            startTime: '18:00',
            endTime: '19:00',
            isAvailable: true,
            isBooked: false,
          ),
          TimeSlotModel(
            id: '6',
            startTime: '19:00',
            endTime: '20:00',
            isAvailable: false,
            isBooked: false,
          ),
        ],
      ),
      // Tomorrow
      DayAvailabilityModel(
        date: today.add(const Duration(days: 1)),
        slots: [
          TimeSlotModel(
            id: '7',
            startTime: '09:00',
            endTime: '10:00',
            isAvailable: true,
            isBooked: false,
          ),
          TimeSlotModel(
            id: '8',
            startTime: '10:00',
            endTime: '11:00',
            isAvailable: true,
            isBooked: false,
          ),
          TimeSlotModel(
            id: '9',
            startTime: '11:00',
            endTime: '12:00',
            isAvailable: false,
            isBooked: true,
          ),
          TimeSlotModel(
            id: '10',
            startTime: '14:00',
            endTime: '15:00',
            isAvailable: true,
            isBooked: false,
          ),
          TimeSlotModel(
            id: '11',
            startTime: '15:00',
            endTime: '16:00',
            isAvailable: true,
            isBooked: false,
          ),
          TimeSlotModel(
            id: '12',
            startTime: '16:00',
            endTime: '17:00',
            isAvailable: true,
            isBooked: false,
          ),
        ],
      ),
      // Day 3
      DayAvailabilityModel(
        date: today.add(const Duration(days: 2)),
        slots: [
          TimeSlotModel(
            id: '13',
            startTime: '13:00',
            endTime: '14:00',
            isAvailable: true,
            isBooked: false,
          ),
          TimeSlotModel(
            id: '14',
            startTime: '14:00',
            endTime: '15:00',
            isAvailable: false,
            isBooked: true,
          ),
          TimeSlotModel(
            id: '15',
            startTime: '15:00',
            endTime: '16:00',
            isAvailable: true,
            isBooked: false,
          ),
          TimeSlotModel(
            id: '16',
            startTime: '16:00',
            endTime: '17:00',
            isAvailable: true,
            isBooked: false,
          ),
          TimeSlotModel(
            id: '17',
            startTime: '17:00',
            endTime: '18:00',
            isAvailable: false,
            isBooked: true,
          ),
          TimeSlotModel(
            id: '18',
            startTime: '18:00',
            endTime: '19:00',
            isAvailable: true,
            isBooked: false,
          ),
        ],
      ),
      // Day 4
      DayAvailabilityModel(
        date: today.add(const Duration(days: 3)),
        slots: [
          TimeSlotModel(
            id: '19',
            startTime: '08:00',
            endTime: '09:00',
            isAvailable: true,
            isBooked: false,
          ),
          TimeSlotModel(
            id: '20',
            startTime: '09:00',
            endTime: '10:00',
            isAvailable: true,
            isBooked: false,
          ),
          TimeSlotModel(
            id: '21',
            startTime: '10:00',
            endTime: '11:00',
            isAvailable: true,
            isBooked: false,
          ),
          TimeSlotModel(
            id: '22',
            startTime: '14:00',
            endTime: '15:00',
            isAvailable: true,
            isBooked: false,
          ),
          TimeSlotModel(
            id: '23',
            startTime: '15:00',
            endTime: '16:00',
            isAvailable: false,
            isBooked: true,
          ),
          TimeSlotModel(
            id: '24',
            startTime: '16:00',
            endTime: '17:00',
            isAvailable: true,
            isBooked: false,
          ),
        ],
      ),
      // Day 5
      DayAvailabilityModel(
        date: today.add(const Duration(days: 4)),
        slots: [
          TimeSlotModel(
            id: '25',
            startTime: '14:00',
            endTime: '15:00',
            isAvailable: true,
            isBooked: false,
          ),
          TimeSlotModel(
            id: '26',
            startTime: '15:00',
            endTime: '16:00',
            isAvailable: true,
            isBooked: false,
          ),
          TimeSlotModel(
            id: '27',
            startTime: '16:00',
            endTime: '17:00',
            isAvailable: false,
            isBooked: true,
          ),
          TimeSlotModel(
            id: '28',
            startTime: '17:00',
            endTime: '18:00',
            isAvailable: true,
            isBooked: false,
          ),
          TimeSlotModel(
            id: '29',
            startTime: '18:00',
            endTime: '19:00',
            isAvailable: true,
            isBooked: false,
          ),
          TimeSlotModel(
            id: '30',
            startTime: '19:00',
            endTime: '20:00',
            isAvailable: true,
            isBooked: false,
          ),
        ],
      ),
    ];
  }
}
