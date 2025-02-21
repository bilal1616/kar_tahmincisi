import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:kartahmincisi/widget/map.dart';

class NavigationProvider extends ChangeNotifier {
  PageController pageController = PageController();
  SideMenuController sideMenuController = SideMenuController();

  bool isMenuOpen = true;

  NavigationProvider() {
    sideMenuController.addListener((index) {
      pageController.jumpToPage(index);
      notifyListeners();
    });
  }

  void toggleMenu() {
    isMenuOpen = !isMenuOpen;
    notifyListeners();
  }

  void navigateToWebView(BuildContext context, String url) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MapPage(url: url)),
    );
  }

  // ✅ Tüm Menüleri Ekliyoruz (Eksiksiz)
  List<Object> buildAllMenuItems(BuildContext context) {
    return [
      _buildExpansionItem(context, "ECMWF", [
        _buildMenuItem(
            context, 'ECMWF Resmi', 'https://charts.ecmwf.int/', Icons.link),
        _buildMenuItem(
            context,
            'Weather.us Türkiye',
            'https://weather.us/model-charts/euro/turkey/acc-total-precipitation.html',
            Icons.map),
        _buildMenuItem(context, 'IMS Model Haritalar',
            'https://ims.gov.il/en/ModelMaps', Icons.public),
      ]),
      _buildExpansionItem(context, "GFS", [
        _buildMenuItem(
            context,
            'WXCharts Europe',
            'https://www.wxcharts.com/?panel=default&model=gfs,gfs,gfs,gfs&region=europe&chart=overview,850temp,wind10mkph,snowdepth&run=12&step=003&plottype=10&lat=51.500&lon=-0.250&skewtstep=0',
            Icons.language),
        _buildMenuItem(
            context,
            'Hava Türkiye',
            'https://www.havaturkiye.com/cgi-bin/expertcharts',
            Icons.wb_cloudy),
        _buildMenuItem(context, 'Wetterzentrale',
            'https://www.wetterzentrale.de/', Icons.cloud_done),
        _buildMenuItem(
            context,
            'Weather Models',
            'https://weathermodels.com/index.php?r=site%2Fpreview&mode=animator',
            Icons.waves),
        _buildMenuItem(context, 'Ogimet',
            'https://www.ogimet.com/tabla_pred.phtml?lang=en', Icons.heat_pump),
      ]),
      _buildExpansionItem(context, "WRF", [
        _buildMenuItem(
            context,
            'Meteoroloji Genel Müdürlüğü',
            'https://mgm.gov.tr/tahmin/wrf-model-harita.aspx?t=rainG&s=06&a=bal&g=p',
            Icons.link),
        _buildMenuItem(context, 'SimeTeo', 'http://www.simeteo.gr/', Icons.map),
        _buildMenuItem(context, 'Meteo.gr',
            'https://www.meteo.gr/meteomaps/gr_wrf_3h_prep.cfm', Icons.public),
        _buildMenuItem(context, 'Meteo3',
            'https://meteo3.geo.auth.gr/WRF/home.html', Icons.public),
      ]),
      _buildExpansionItem(context, "BOLAM", [
        _buildMenuItem(context, 'Meteo Maps',
            'https://www.meteo.gr/meteomaps/gr_bolam_3h_accum.cfm', Icons.link),
        _buildMenuItem(
            context,
            'İSAC',
            'https://www.isac.cnr.it/dinamica/projects/forecasts/bolam/',
            Icons.map),
      ]),
      _buildExpansionItem(context, "SKİRON", [
        _buildMenuItem(context, 'Forecast',
            'https://forecast.uoa.gr/en/forecast-maps/skiron', Icons.link),
      ]),
      _buildExpansionItem(context, "METEOGRAMLAR", [
        _buildMenuItem(
            context,
            'Freemeteo',
            'https://tr.freemeteo.com/mobile/havadurumu/bursa/7-days/meteogram/?gid=750269&language=turkish&country=turkey',
            Icons.language),
        _buildMenuItem(
            context,
            'WRF',
            'https://www.mgm.gov.tr/tahmin/wrf-meteogram.aspx',
            Icons.wb_cloudy),
        _buildMenuItem(
            context,
            'GFS1',
            'https://www.meteociel.fr/cartes_obs/gens_display.php?ext=1&lon=29.084&lat=40.1927&ville=Bursa',
            Icons.cloud_done),
        _buildMenuItem(
            context,
            'GFS2',
            'https://www.wetterzentrale.de/show_diagrams.php?model=gfs&var=92&lid=OP',
            Icons.waves),
        _buildMenuItem(
            context,
            'ECMWF1',
            'https://charts.ecmwf.int/products/opencharts_ptype_meteogram?base_time=202502210000&lat=51.4333&lon=-1.0&station_name=Reading',
            Icons.heat_pump),
        _buildMenuItem(
            context,
            'ECMWF2',
            'https://charts.ecmwf.int/products/opencharts_meteogram?base_time=202502210000&epsgram=classical_10d&lat=51.4333&lon=-1.0&station_name=Reading',
            Icons.heat_pump),
      ]),
      _buildExpansionItem(context, "UZUN VADELİ", [
        _buildMenuItem(
            context,
            'EFFIS',
            'https://effis.jrc.ec.europa.eu/apps/effis.longterm.forecasts/',
            Icons.link),
        _buildMenuItem(
            context, 'Rossby', 'https://www.consonantchaos.com/', Icons.map),
        _buildMenuItem(
            context,
            'IRI',
            'https://iridl.ldeo.columbia.edu/maproom/Health/Regional/Africa/Malaria/IRI_Seasonal_Temp.html?bbox=bb%3A-20%3A35%3A40%3A75%3Abb&L=1.0&region=bb%3A-20%3A35%3A40%3A75%3Abb',
            Icons.public),
      ]),
    ];
  }

  // 🔧 Expansion Item Metodu
  SideMenuExpansionItem _buildExpansionItem(
      BuildContext context, String title, List<SideMenuItem> children) {
    return SideMenuExpansionItem(
      title: title,
      icon: const Icon(Icons.schema),
      children: children,
    );
  }

  // 🔧 Menü Item Metodu
  SideMenuItem _buildMenuItem(
      BuildContext context, String title, String url, IconData icon) {
    return SideMenuItem(
      title: title,
      icon: Icon(icon),
      onTap: (index, _) => navigateToWebView(context, url),
    );
  }
}
