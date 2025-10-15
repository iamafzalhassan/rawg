import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rawg/core/constants/asset_constants.dart';
import 'package:rawg/core/enums/sort_chip_type.dart';
import 'package:rawg/core/theme/app_font.dart';
import 'package:rawg/core/theme/app_pallete.dart';
import 'package:rawg/features/common/presentation/widgets/doshed_divider.dart';
import 'package:rawg/features/dashboard/domain/entities/sort_item.dart';
import 'package:rawg/features/dashboard/presentation/cubits/sort_chip_cubit.dart';

class SortBottomSheet extends StatelessWidget {
  const SortBottomSheet(this.type, {super.key});

  final SortChipType type;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SortChipCubit, SortChipState>(
      builder: (context, state) {
        final List<SortItem>? sortList = type == SortChipType.general ? state.generalSortList : state.platformSortList;

        return Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 16.0),
              child: Text(
                'Order by,',
                style: AppFont.style(color: AppPalette.white, fontSize: 25),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 16.0),
            ...List.generate(sortList!.length, (i) => buildSortItem(context, sortList[i], i, sortList.length)),
            const SizedBox(height: 16.0),
          ],
        );
      },
    );
  }

  Widget buildSortItem(BuildContext context, SortItem item, int index, int length) {
    return GestureDetector(
      onTap: () => onTap(context, item),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  item.name!,
                  style: AppFont.style(color: AppPalette.white, fontSize: 18),
                  textAlign: TextAlign.left,
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: item.isSelected! ? AppPalette.green1 : null,
                    shape: BoxShape.circle,
                    border: item.isSelected! ? null : Border.all(color: AppPalette.gray2),
                  ),
                  height: 20,
                  width: 20,
                  padding: const EdgeInsets.all(2.0),
                  child: item.isSelected! ? Image.asset(AssetConstants.tickIcon) : null,
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            if (index != length - 1) ...[
              const DashedDivider(color: AppPalette.gray2),
              const SizedBox(height: 8.0),
            ],
          ],
        ),
      ),
    );
  }

  void onTap(BuildContext context, SortItem item) {
    context.read<SortChipCubit>().onItemSelected(type, item);
    Navigator.pop(context);
  }
}