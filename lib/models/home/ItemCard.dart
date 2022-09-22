class ItemCardModel {
  String image;
  String icon;
  String number;
  String balance;
  List<ExpenseModel> expenses;

  ItemCardModel({
    required this.image,
    required this.icon,
    required this.number,
    required this.balance,
    this.expenses = const [],
  });
}

class ExpenseModel {
  String image;
  String title;
  String description;
  String amount;

  ExpenseModel({
    required this.image,
    required this.title,
    required this.description,
    required this.amount,
  });
}

final cards = [
  null,
  ItemCardModel(
    image: 'assets/notes.jpg',
    icon: 'assets/icon_2.jpeg',
    number: "0912",
    balance: "SHOW MY NOTES",
    expenses: [
      ExpenseModel(
          image: 'assets/quinielapro.png',
          title: "your last note",
          description: "5 days ago",
          amount: "")
    ],
  ),
  ItemCardModel(
    image: 'assets/alarm.jpg',
    icon: 'assets/icon_1.png',
    number: "0912",
    balance: "SHOW MY ALARMS",
    expenses: [
      ExpenseModel(
        image: 'assets/amazon.png',
        title: "your next alarm in",
        description: "8h:30",
        amount: " ",
      )
    ],
  ),
  ItemCardModel(
    image: 'assets/kommunikation.jpg',
    icon: 'assets/icon_3.png',
    number: "8743",
    balance: "SHOW MY COMMUNIKATION",
    expenses: [
      ExpenseModel(
        image: 'assets/netflix.png',
        title: "you are connected to ",
        description: "5 devices",
        amount: "",
      )
    ],
  ),
];

// bg_1 : https://unsplash.com/photos/5LOhydOtTKU?utm_source=unsplash&utm_medium=referral&utm_content=creditShareLink
// bg_2 : https://unsplash.com/photos/5LOhydOtTKU?utm_source=unsplash&utm_medium=referral&utm_content=creditShareLink