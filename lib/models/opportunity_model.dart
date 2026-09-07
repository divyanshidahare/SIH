enum OpportunityType {
  governmentScheme,
  tradeFair,
  ngoGrant,
  b2bBuyer,
}

class Opportunity {
  final String id;
  final String title;
  final String organization;
  final OpportunityType type;
  final String deadline;
  final String stipendOrGrant;
  final String description;
  final List<String> eligibility;
  final String applicationStatus; // "Open", "Closing Soon", "Applied"

  Opportunity({
    required this.id,
    required this.title,
    required this.organization,
    required this.type,
    required this.deadline,
    required this.stipendOrGrant,
    required this.description,
    required this.eligibility,
    required this.applicationStatus,
  });
}
