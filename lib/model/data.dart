
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Data {
  String? apikey = dotenv.env['API_KEY'];
}