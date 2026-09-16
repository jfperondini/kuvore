class FamilyMemberModel {
  const FamilyMemberModel({
    required this.id,
    required this.name,
    required this.relationship,
    required this.cpf,
  });

  final String id;
  final String name;
  final String relationship;
  final String cpf;

  factory FamilyMemberModel.fromMap(String id, Map<String, dynamic> map) {
    return FamilyMemberModel(
      id: id,
      name: map['name'] as String? ?? '',
      relationship: map['relationship'] as String? ?? '',
      cpf: map['cpf'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'relationship': relationship,
        'cpf': cpf,
      };
}
