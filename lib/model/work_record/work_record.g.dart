// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_record.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWorkRecordCollection on Isar {
  IsarCollection<WorkRecord> get workRecords => this.collection();
}

const WorkRecordSchema = CollectionSchema(
  name: r'WorkRecord',
  id: -8207273324724481485,
  properties: {
    r'breakEnd': PropertySchema(
      id: 0,
      name: r'breakEnd',
      type: IsarType.dateTime,
    ),
    r'breakStart': PropertySchema(
      id: 1,
      name: r'breakStart',
      type: IsarType.dateTime,
    ),
    r'date': PropertySchema(id: 2, name: r'date', type: IsarType.dateTime),
    r'endTime': PropertySchema(
      id: 3,
      name: r'endTime',
      type: IsarType.dateTime,
    ),
    r'patrolEnd': PropertySchema(
      id: 4,
      name: r'patrolEnd',
      type: IsarType.dateTime,
    ),
    r'patrolStart': PropertySchema(
      id: 5,
      name: r'patrolStart',
      type: IsarType.dateTime,
    ),
    r'startTime': PropertySchema(
      id: 6,
      name: r'startTime',
      type: IsarType.dateTime,
    ),
  },

  estimateSize: _workRecordEstimateSize,
  serialize: _workRecordSerialize,
  deserialize: _workRecordDeserialize,
  deserializeProp: _workRecordDeserializeProp,
  idName: r'id',
  indexes: {
    r'date': IndexSchema(
      id: -7552997827385218417,
      name: r'date',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'date',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _workRecordGetId,
  getLinks: _workRecordGetLinks,
  attach: _workRecordAttach,
  version: '3.3.2',
);

int _workRecordEstimateSize(
  WorkRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _workRecordSerialize(
  WorkRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.breakEnd);
  writer.writeDateTime(offsets[1], object.breakStart);
  writer.writeDateTime(offsets[2], object.date);
  writer.writeDateTime(offsets[3], object.endTime);
  writer.writeDateTime(offsets[4], object.patrolEnd);
  writer.writeDateTime(offsets[5], object.patrolStart);
  writer.writeDateTime(offsets[6], object.startTime);
}

WorkRecord _workRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WorkRecord(
    breakEnd: reader.readDateTimeOrNull(offsets[0]),
    breakStart: reader.readDateTimeOrNull(offsets[1]),
    date: reader.readDateTime(offsets[2]),
    endTime: reader.readDateTimeOrNull(offsets[3]),
    patrolEnd: reader.readDateTimeOrNull(offsets[4]),
    patrolStart: reader.readDateTimeOrNull(offsets[5]),
    startTime: reader.readDateTimeOrNull(offsets[6]),
  );
  object.id = id;
  return object;
}

P _workRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 4:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 5:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 6:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _workRecordGetId(WorkRecord object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _workRecordGetLinks(WorkRecord object) {
  return [];
}

void _workRecordAttach(IsarCollection<dynamic> col, Id id, WorkRecord object) {
  object.id = id;
}

extension WorkRecordQueryWhereSort
    on QueryBuilder<WorkRecord, WorkRecord, QWhere> {
  QueryBuilder<WorkRecord, WorkRecord, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterWhere> anyDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'date'),
      );
    });
  }
}

extension WorkRecordQueryWhere
    on QueryBuilder<WorkRecord, WorkRecord, QWhereClause> {
  QueryBuilder<WorkRecord, WorkRecord, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterWhereClause> dateEqualTo(
    DateTime date,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'date', value: [date]),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterWhereClause> dateNotEqualTo(
    DateTime date,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'date',
                lower: [],
                upper: [date],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'date',
                lower: [date],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'date',
                lower: [date],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'date',
                lower: [],
                upper: [date],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterWhereClause> dateGreaterThan(
    DateTime date, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'date',
          lower: [date],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterWhereClause> dateLessThan(
    DateTime date, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'date',
          lower: [],
          upper: [date],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterWhereClause> dateBetween(
    DateTime lowerDate,
    DateTime upperDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'date',
          lower: [lowerDate],
          includeLower: includeLower,
          upper: [upperDate],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension WorkRecordQueryFilter
    on QueryBuilder<WorkRecord, WorkRecord, QFilterCondition> {
  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition> breakEndIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'breakEnd'),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition>
  breakEndIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'breakEnd'),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition> breakEndEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'breakEnd', value: value),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition>
  breakEndGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'breakEnd',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition> breakEndLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'breakEnd',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition> breakEndBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'breakEnd',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition>
  breakStartIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'breakStart'),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition>
  breakStartIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'breakStart'),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition> breakStartEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'breakStart', value: value),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition>
  breakStartGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'breakStart',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition>
  breakStartLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'breakStart',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition> breakStartBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'breakStart',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition> dateEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'date', value: value),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition> dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'date',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition> dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'date',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition> dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'date',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition> endTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'endTime'),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition>
  endTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'endTime'),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition> endTimeEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'endTime', value: value),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition>
  endTimeGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'endTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition> endTimeLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'endTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition> endTimeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'endTime',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition>
  patrolEndIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'patrolEnd'),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition>
  patrolEndIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'patrolEnd'),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition> patrolEndEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'patrolEnd', value: value),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition>
  patrolEndGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'patrolEnd',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition> patrolEndLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'patrolEnd',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition> patrolEndBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'patrolEnd',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition>
  patrolStartIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'patrolStart'),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition>
  patrolStartIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'patrolStart'),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition>
  patrolStartEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'patrolStart', value: value),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition>
  patrolStartGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'patrolStart',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition>
  patrolStartLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'patrolStart',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition>
  patrolStartBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'patrolStart',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition>
  startTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'startTime'),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition>
  startTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'startTime'),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition> startTimeEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'startTime', value: value),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition>
  startTimeGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'startTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition> startTimeLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'startTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterFilterCondition> startTimeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'startTime',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension WorkRecordQueryObject
    on QueryBuilder<WorkRecord, WorkRecord, QFilterCondition> {}

extension WorkRecordQueryLinks
    on QueryBuilder<WorkRecord, WorkRecord, QFilterCondition> {}

extension WorkRecordQuerySortBy
    on QueryBuilder<WorkRecord, WorkRecord, QSortBy> {
  QueryBuilder<WorkRecord, WorkRecord, QAfterSortBy> sortByBreakEnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breakEnd', Sort.asc);
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterSortBy> sortByBreakEndDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breakEnd', Sort.desc);
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterSortBy> sortByBreakStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breakStart', Sort.asc);
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterSortBy> sortByBreakStartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breakStart', Sort.desc);
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterSortBy> sortByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.asc);
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterSortBy> sortByEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.desc);
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterSortBy> sortByPatrolEnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'patrolEnd', Sort.asc);
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterSortBy> sortByPatrolEndDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'patrolEnd', Sort.desc);
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterSortBy> sortByPatrolStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'patrolStart', Sort.asc);
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterSortBy> sortByPatrolStartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'patrolStart', Sort.desc);
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterSortBy> sortByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.asc);
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterSortBy> sortByStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.desc);
    });
  }
}

extension WorkRecordQuerySortThenBy
    on QueryBuilder<WorkRecord, WorkRecord, QSortThenBy> {
  QueryBuilder<WorkRecord, WorkRecord, QAfterSortBy> thenByBreakEnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breakEnd', Sort.asc);
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterSortBy> thenByBreakEndDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breakEnd', Sort.desc);
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterSortBy> thenByBreakStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breakStart', Sort.asc);
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterSortBy> thenByBreakStartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breakStart', Sort.desc);
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterSortBy> thenByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.asc);
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterSortBy> thenByEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.desc);
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterSortBy> thenByPatrolEnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'patrolEnd', Sort.asc);
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterSortBy> thenByPatrolEndDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'patrolEnd', Sort.desc);
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterSortBy> thenByPatrolStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'patrolStart', Sort.asc);
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterSortBy> thenByPatrolStartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'patrolStart', Sort.desc);
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterSortBy> thenByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.asc);
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QAfterSortBy> thenByStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.desc);
    });
  }
}

extension WorkRecordQueryWhereDistinct
    on QueryBuilder<WorkRecord, WorkRecord, QDistinct> {
  QueryBuilder<WorkRecord, WorkRecord, QDistinct> distinctByBreakEnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'breakEnd');
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QDistinct> distinctByBreakStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'breakStart');
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QDistinct> distinctByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endTime');
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QDistinct> distinctByPatrolEnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'patrolEnd');
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QDistinct> distinctByPatrolStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'patrolStart');
    });
  }

  QueryBuilder<WorkRecord, WorkRecord, QDistinct> distinctByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startTime');
    });
  }
}

extension WorkRecordQueryProperty
    on QueryBuilder<WorkRecord, WorkRecord, QQueryProperty> {
  QueryBuilder<WorkRecord, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<WorkRecord, DateTime?, QQueryOperations> breakEndProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'breakEnd');
    });
  }

  QueryBuilder<WorkRecord, DateTime?, QQueryOperations> breakStartProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'breakStart');
    });
  }

  QueryBuilder<WorkRecord, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<WorkRecord, DateTime?, QQueryOperations> endTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endTime');
    });
  }

  QueryBuilder<WorkRecord, DateTime?, QQueryOperations> patrolEndProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'patrolEnd');
    });
  }

  QueryBuilder<WorkRecord, DateTime?, QQueryOperations> patrolStartProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'patrolStart');
    });
  }

  QueryBuilder<WorkRecord, DateTime?, QQueryOperations> startTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startTime');
    });
  }
}
