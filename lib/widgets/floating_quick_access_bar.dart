import 'package:fitfoot_web/widgets/responsive.dart';
import 'package:flutter/material.dart';

class FloatingQuickAccessBar extends StatefulWidget {
  const FloatingQuickAccessBar({
    super.key,
    required this.screenSize,
  });

  final Size screenSize;

  @override
  _FloatingQuickAccessBarState createState() => _FloatingQuickAccessBarState();
}

class _FloatingQuickAccessBarState extends State<FloatingQuickAccessBar> {
  final List _isHovering = [false, false, false, false];
  List<Widget> rowElements = [];
  List<String> items = ['History', 'Science', 'Philosophy', 'Novels'];

  List<IconData> icons = [
    Icons.location_on,
    Icons.date_range,
    Icons.people,
    Icons.wb_sunny
  ];

  List<Widget> generateRowElements() {
    rowElements.clear();
    for (int i = 0; i < items.length; i++) {
      Widget elementTile = InkWell(
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onHover: (value) {
          setState(() {
            value ? _isHovering[i] = true : _isHovering[i] = false;
          });
        },
        onTap: () {},
        child: Text(
          items[i],
          style: TextStyle(
            color: _isHovering[i] ? Colors.blueGrey[900] : Colors.blueGrey,
          ),
        ),
      );
      Widget spacer = SizedBox(
        height: widget.screenSize.height / 20,
        child: VerticalDivider(
          width: 1,
          color: Colors.blueGrey[100],
          thickness: 1,
        ),
      );
      rowElements.add(elementTile);
      if (i < items.length - 1) {
        rowElements.add(spacer);
      }
    }

    return rowElements;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 1,
      child: Padding(
        padding: EdgeInsets.only(
          top: widget.screenSize.height * 0.60,
          left: ResponsiveWidget.isSmallScreen(context)
              ? widget.screenSize.width / 12
              : widget.screenSize.width / 5,
          right: ResponsiveWidget.isSmallScreen(context)
              ? widget.screenSize.width / 12
              : widget.screenSize.width / 5,
        ),
        child: ResponsiveWidget.isSmallScreen(context)
            ? Column(
                // mainAxisSize: MainAxisSize.max,
                children: [
                  for (int i = 0; i < items.length; i++)
                    Container(
                       width: widget.screenSize.width / 3,
                     height: widget.screenSize.height / 10,
                      decoration: const BoxDecoration(
                          // borderRadius: BorderRadius.circular(8),
                          ),
                      child: Card(
                        elevation: 4,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left:widget.screenSize.width/40 ,
                            top:widget.screenSize.height/45 ,
                            bottom:widget.screenSize.height/45
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(icons[i]),
                              SizedBox(width:widget.screenSize.width/50 ,),
                              InkWell(
                                  splashColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  onHover: (value) {
                                    setState(() {
                                      value ? _isHovering[i] = true
                                          : _isHovering[i] =false;
                                    });
                                  },
                                  onTap: (){},

                                  child: Text(items[i],style: TextStyle(
                                      color:
                                      _isHovering[i]?Colors.red:Colors.black),)),
                              SizedBox(width:widget.screenSize.width/50 ,),

                            ],
                          ),
                        ),
                      ),
                    )
                ],
              )
            : Card(
                elevation: 5,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: widget.screenSize.height / 50,
                      bottom: widget.screenSize.height / 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: generateRowElements(),
                  ),
                ),
              ),
      ),
    );
  }
}
