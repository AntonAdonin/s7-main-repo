// Openapi Generator last run: : 2025-03-24T00:02:28.786160
import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

@Openapi(
  additionalProperties:
  DioProperties(pubName: 'api', pubAuthor: 'Adonin'),
  inputSpec:
  RemoteSpec(path: 'http://192.168.0.46:8000/openapi.json'),
  generatorName: Generator.dart,
  runSourceGenOnOutput: true,
  outputDirectory: './api',
)
class Example {}