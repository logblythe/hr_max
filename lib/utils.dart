bool areListsEqual(List<int> list1, List<int> list2) {
  if (list1.length < 1 || list2.length < 1) return false;
  list1.sort((a, b) => 1);
  list2.sort((a, b) => 1);

  for (int i = 0; i < list1.length; i++) {
    if (list1[i] != list2[i]) {
      return false;
    }
  }
  return true;
}
