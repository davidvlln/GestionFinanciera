import 'package:flutter/material.dart';

enum AlineacionBarra { arriba, centro, abajo }

class BarraSuperiorPersonalizada extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? nombreCliente;
  final String subtitulo;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback? onLogoutPressed;
  final double height;
  final AlineacionBarra alineacion;

  const BarraSuperiorPersonalizada({
    super.key,
    this.title,
    this.nombreCliente,
    this.subtitulo = 'Bienvenido de vuelta',
    this.backgroundColor,
    this.foregroundColor,
    this.onLogoutPressed,
    this.height = kToolbarHeight,
    this.alineacion = AlineacionBarra.centro,
  });

  @override
  Widget build(BuildContext context) {
    final colorPrincipal = foregroundColor ?? Colors.white;

    Widget titleWidget;
    if (nombreCliente != null) {
      titleWidget = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Hola $nombreCliente',
            style: TextStyle(
              color: colorPrincipal,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subtitulo,
            style: TextStyle(
              color: colorPrincipal.withOpacity(0.8),
              fontSize: 12,
            ),
          ),
        ],
      );
    } else {
      titleWidget = Text(title ?? '', style: TextStyle(color: colorPrincipal, fontSize: 18, fontWeight: FontWeight.bold));
    }

    CrossAxisAlignment crossAxisAlignment;
    switch (alineacion) {
      case AlineacionBarra.arriba:
        crossAxisAlignment = CrossAxisAlignment.start;
        break;
      case AlineacionBarra.centro:
        crossAxisAlignment = CrossAxisAlignment.center;
        break;
      case AlineacionBarra.abajo:
        crossAxisAlignment = CrossAxisAlignment.end;
        break;
    }

    return Container(
      color: backgroundColor ?? const Color(0xFF169C88),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              crossAxisAlignment: crossAxisAlignment,
              children: [
                if (Scaffold.of(context).hasDrawer)
                  IconButton(
                    icon: Icon(Icons.menu, color: colorPrincipal),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                    tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                  ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 12, bottom: alineacion == AlineacionBarra.abajo ? 12 : 0, top: alineacion == AlineacionBarra.arriba ? 12 : 0),
                    child: titleWidget,
                  ),
                ),
                if (onLogoutPressed != null)
                  Padding(
                    padding: EdgeInsets.only(right: 10.0, bottom: alineacion == AlineacionBarra.abajo ? 6 : 0, top: alineacion == AlineacionBarra.arriba ? 6 : 0),
                    child: GestureDetector(
                      onTap: onLogoutPressed,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: colorPrincipal.withOpacity(0.15),
                        child: Icon(
                          Icons.logout,
                          color: colorPrincipal,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
