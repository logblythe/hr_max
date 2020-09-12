class DialogResponse {
  final String fieldOne;
  final String fieldTwo;
  final bool confirmed;
  final bool rejected;

  DialogResponse({
    this.fieldOne,
    this.fieldTwo,
    this.confirmed = false,
    this.rejected = false,
  });
}
