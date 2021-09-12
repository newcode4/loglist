import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:azlistview/azlistview.dart';
import 'package:github_language_colors/github_language_colors.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:tradelist/model/models.dart';
import 'package:tradelist/common/res.dart';
import 'package:tradelist/common/utils.dart';
import '../common/dialog.dart';

class TradeList extends StatefulWidget {
  const TradeList({
    Key key,
    this.fromType,
  }) : super(key: key);
  final int fromType;

  @override
  _TradeListState createState() => _TradeListState();
}

class _TradeListState extends State<TradeList> {
  /// Controller to scroll or jump to a particular item.
  final ItemScrollController itemScrollController = ItemScrollController();

  List<Languages> originList = [];
  List<Languages> dataList = [];

  TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    loadData();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  void loadData() async {
    originList = LanguageHelper.getGithubLanguages().map((v) {
      Languages model = Languages.fromJson(v.toJson());
      String tag = model.name.substring(0, 1).toUpperCase();
      if (RegExp("[A-Z]").hasMatch(tag)) {
        model.tagIndex = tag;
      } else {
        model.tagIndex = "#";
      }
      return model;
    }).toList();
    _handleList(originList);
  }

  void _handleList(List<Languages> list) {
    dataList.clear();
    if (ObjectUtil.isEmpty(list)) {
      setState(() {});
      return;
    }
    dataList.addAll(list);

    // A-Z sort.
    SuspensionUtil.sortListBySuspensionTag(dataList);

    // show sus tag.
    SuspensionUtil.setShowSuspensionStatus(dataList);

    setState(() {});

    if (itemScrollController.isAttached) {
      itemScrollController.jumpTo(index: 0);
    }
  }

  Widget getSusItem(BuildContext context, String tag, {double susHeight = 40}) {
    return Container(
      height: susHeight,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 16.0),
      color: Color(0xFFF3F4F5),
      alignment: Alignment.centerLeft,
      child: Text(
        '$tag',
        softWrap: false,
        style: TextStyle(
          fontSize: 14.0,
          color: Color(0xFF666666),
        ),
      ),
    );
  }

  Widget getListItem(BuildContext context, Languages model,
      {double susHeight = 40}) {
    return ListTile(
      title: Text(model.name),
      onTap: () {
        showDialogFunc(
          context,
          model.name,
        );
      },
    );
  }

  void _search(String text) {
    if (ObjectUtil.isEmpty(text)) {
      _handleList(originList);
    } else {
      List<Languages> list = originList.where((v) {
        return v.name.toLowerCase().contains(text.toLowerCase());
      }).toList();
      _handleList(list);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '매매일지',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromARGB(255, 225, 226, 230), width: 0.33),
                  color: Color.fromARGB(255, 239, 240, 244),
                  borderRadius: BorderRadius.circular(12)),
              child: TextField(
                autofocus: false,
                onChanged: (value) {
                  _search(value);
                },
                controller: textEditingController,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colours.gray_33,
                    ),
                    suffixIcon: Offstage(
                      offstage: textEditingController.text.isEmpty,
                      child: InkWell(
                        onTap: () {
                          textEditingController.clear();
                          _search('');
                        },
                        child: Icon(
                          Icons.cancel,
                          color: Colours.gray_99,
                        ),
                      ),
                    ),
                    border: InputBorder.none,
                    hintText: '종목명을 검색하세요',
                    hintStyle: TextStyle(color: Colours.gray_99)),
              ),
            ),
            Expanded(
              child: AzListView(
                data: dataList,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: dataList.length,
                itemBuilder: (BuildContext context, int index) {
                  Languages model = dataList[index];
                  return getListItem(context, model);
                },
                itemScrollController: itemScrollController,
                susItemBuilder: (BuildContext context, int index) {
                  Languages model = dataList[index];
                  return getSusItem(context, model.getSuspensionTag());
                },
                indexBarOptions: IndexBarOptions(
                  needRebuild: true,
                  selectTextStyle: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                  selectItemDecoration: BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xFF333333)),
                  indexHintWidth: 96,
                  indexHintHeight: 97,
                  indexHintDecoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          Utils.getImgPath('ic_index_bar_bubble_white')),
                      fit: BoxFit.contain,
                    ),
                  ),
                  indexHintAlignment: Alignment.centerRight,
                  indexHintTextStyle:
                      TextStyle(fontSize: 24.0, color: Colors.black87),
                  indexHintOffset: Offset(-30, 0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

