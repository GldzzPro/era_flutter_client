import 'package:flutter/material.dart';

import '../../configs/config.dart';
import '../models/home/ItemCard.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key? key,
    required this.bankCard,
  }) : super(key: key);

  final ItemCardModel bankCard;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: Constants.padding,
      ),
      padding: const EdgeInsets.all(Constants.padding * 2),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(bankCard.image),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(
          Constants.radius,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipOval(
                child: Image.asset(
                  bankCard.icon,
                  height: Constants.padding * 3,
                  width: Constants.padding * 3,
                ),
              ),
              Text(
                bankCard.number,
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Colors.white),
              )
            ],
          ),
          Text(
            bankCard.balance,
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Colors.white),
          )
        ],
      ),
    );
  }
}
