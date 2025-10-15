import 'package:flutter_dotenv/flutter_dotenv.dart';

final baseUrl = dotenv.env['BASE_URL'];
final housesUrl = dotenv.env['HOUSES_ENDPOINT'];
final usersUrl = dotenv.env['USERS_ENDPOINT'];