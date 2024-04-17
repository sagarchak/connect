enum DateFilter { Day, Week, Month }

extension ParseToString on DateFilter {
  String toUIString() {
    return 'This ${this.toString().split('.').last.replaceAll("_", " ").toLowerCase().trim()}';
  }
}
