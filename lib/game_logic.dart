import 'dart:convert';
import 'dart:io';
import 'dart:math';

// ignore: deprecated_member_use
import 'package:collection/equality.dart';
// import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import 'package:quiver/iterables.dart';

//import 'package:collection/equality.dart';

class GameLogic {

}

List<int> secondVector = List.generate(100, (int index) => 1);
bool initialized = false;
bool turn = true;
String id = '';
var myMap = {};
bool gameOver = false;
//List<int> nums = [];
var nums = [];
var rowVector = convertTileToRowSimple(secondVector);
var bakVector = to2dList();
//var bakVector = partition(secondVector, 10);
//var bakVector = to2dList(secondVector);
//List<int> initList = listFromRow(row);

popChompItem(index) {
  int rowSize = 10;
  int colSize = 10;
  int column = index % colSize;
  int row = index ~/ rowSize;
  int loopColumn;
  int loopRow;
  for (int i = 0; i < secondVector.length; i++) {
    loopColumn = i % colSize;
    loopRow = i ~/ rowSize;
    if (loopColumn >= column && loopRow >= row) {
      secondVector[i] = 0;
    }
  }
//  rowVector = convertTileToRowSimple(secondVector);

  if (secondVector[0] == 0)
    gameOver = true;
  else
    turn = !turn;
//  return secondVector[0];
}

List<int> chooseChompItemSingle(List<int> inputList, index) {
  int rowSize = 10;
  int colSize = 10;

  int column = index % colSize;
  int row = index ~/ rowSize;
  int loopColumn;
  int loopRow;
  List<int> outputList = List.from(inputList);

  for (int i = 0; i < inputList.length; i++) {
    loopColumn = i % colSize;
    loopRow = i ~/ rowSize;
    if (loopColumn >= column && loopRow >= row) {
      outputList[i] = 0;
    }
  }
  return outputList;
}

chooseChompItems(List<int> inputList) {
  var superList = [];
  for (int i = 0; i < inputList.length; i++) {
    if (inputList[i] == 1) {
      superList.add([i, chooseChompItemSingle(inputList, i)]);
    }
  }
  return superList;
}

List findAllChompItem(List<int> inputList) {
  return chooseChompItems(inputList);
}

List<int> convertRowToTileSimple(List<int> rowList) {
  int rowSize = 10;
  List<int> tileList = [];
  for (var number in rowList) {
    for (int i = 0; i < rowSize; i++) {
      tileList.add(number > 0 ? 1 : 0);
      number--;
    }
  }
  return tileList;
}

List<List<int>> convertRowToTile(List<List<int>> superRowList) {
  List<List<int>> superTileList = [];
  for (var row in superRowList) {
    superTileList.add(convertRowToTileSimple(row));
  }
  return superTileList;
}

//[1,1,0,0...0] -> [2,0,0,0,0,0]
List<int> convertTileToRowSimple(List<int> tileList) {
  List<int> rowList = [];
  int rowSize = 10;
  var number = 0;
  for (var i = 0; i < tileList.length; i++) {
    number += tileList[i];
    if ((i + 1) % rowSize == 0) {
      rowList.add(number);
      number = 0;
    }
  }
  return rowList;
}

List<List<int>> convertTileToRow(List<List<int>> superTileList) {
  List<List<int>> superRowList = [];
  for (var row in superTileList) {
    superRowList.add(convertTileToRowSimple(row));
  }
  return superRowList;
}

List<int> listFromRow(rowList) {
  return convertRowToTileSimple(rowList);
}

init() {
  var arr = [];
  var current = [];
  var moves = [];

  File file = File('output.txt');

  var lines = file.readAsLinesSync();
  lines.forEach((l) {
    arr = l.split(': ');
    current = jsonDecode(arr[0]);
    moves = jsonDecode(arr[1]);
    myMap[current] = moves;
  });
}

AI() {
  var random = Random();
  int index;
//  print(rowVector);
  rowVector = convertTileToRowSimple(secondVector);
  bakVector = to2dList();
//  bakVector = to2dList(secondVector);
//  bakVector = partition(secondVector, 10);
  myMap.forEach((k, v) {
    if (IterableEquality().equals(k, rowVector)) {
      if (v.length != 0) {
        var temp = random.nextInt(v.length);
        index = v[temp];
        print('N index: $index');
//      print('N');
//      for (var item in v) {
//        print(item);
//      }
      }
    }
  });
  if (index == null) {
//    print('P');
//    var tempVector = List.from(secondVector);
//    tempVector.shuffle();
//    index = tempVector.firstWhere((i) => i == 1);
//    index = secondVector.lastWhere((i) => i == 1);
    var availableIndices = [];
    for (int i = 0; i < secondVector.length; i++) {
      if (secondVector[i] == 1) {
        availableIndices.add(i);
//        index = i;
      }
    }
    if (availableIndices.isNotEmpty)
      index = availableIndices[random.nextInt(availableIndices.length)];

    print('P index: $index');
  }
  return index;
}

bool getTurn() {
  return turn;
}

resetGame() {
  secondVector = List.generate(100, (int index) => 1);
//  rowVector = convertTileToRowSimple(secondVector);
  nums = [];
  gameOver = false;
  turn = true;
}

randomMove() {
  var random = Random();
  int index;
  index = random.nextInt(secondVector.length);
  while (secondVector[index] == null) {
    index = random.nextInt(secondVector.length);
  }
  popChompItem(index);
}

shuffle() {
  bool temp = turn;
  resetGame();
  var random = Random();
  int cycles = random.nextInt(4) + 1;
  for (int i = 0; i < cycles; i++) {
    randomMove();
  }
  if (secondVector[0] == 0) {
    resetGame();
  }
  turn = temp;
}

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/output.txt');
}

initBoardWithOppMoves() {
  if (nums.isNotEmpty) {
    for (int i in nums) {
      popChompItem(i);
    }
  }
}

realInit() {
  if (initialized) return;
  var stringList;
  loadAsset().then((content) {
    var arr = [];
    var current = [];
    var moves = [];
    stringList = content.split('\n');
    stringList.forEach((l) {
//        print(l);
      arr = l.split(': ');
      current = jsonDecode(arr[0]);
      moves = jsonDecode(arr[1]);
      myMap[current] = moves;
    });
  });
  initialized = true;
}

//to2dList(list) =>
//    list.isEmpty ? list : ([list.take(10)]..addAll(to2dList(list.skip(10))));

to2dList() {
  var chunks = [];
  for (var i = 0; i < secondVector.length; i += 10) {
    chunks.add(secondVector.sublist(i, i + 10));
  }
  return chunks;
}
