import 'package:flutter/material.dart';  

const brickLevels = [
  [
    [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
    [ 0, 0, 1, 1, 1, 1, 1, 0, 0 ],
    [ 0, 0, 1, 1, 1, 1, 1, 0, 0 ],
    [ 0, 0, 1, 1, 1, 1, 1, 0, 0 ],
    [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
    [ 0, 0, 0, 0, 1, 0, 0, 0, 0 ],
  ],
  [
    [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
    [ 0, 0, 1, 2, 2, 2, 1, 0, 0 ],
    [ 1, 0, 1, 2, 2, 2, 1, 0, 1 ],
    [ 0, 0, 1, 1, 2, 1, 1, 0, 0 ],
    [ 0, 0, 0, 1, 1, 1, 0, 0, 0 ],
    [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
  ],
  [
    [ 1, 1, 0, 3, 3, 3, 0, 1, 1 ],
    [ 1, 2, 1, 2, 2, 2, 1, 2, 1 ],
    [ 1, 1, 1, 2, 3, 2, 1, 1, 1 ],
    [ 0, 0, 1, 1, 0, 1, 1, 0, 0 ],
    [ 0, 0, 0, 1, 1, 1, 0, 0, 0 ],
    [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
  ],
  [
    [ 3, 1, 1, 1, 4, 1, 2, 1, 1 ],
    [ 1, 3, 3, 2, 4, 2, 3, 2, 1 ],
    [ 1, 3, 2, 2, 4, 2, 3, 1, 1 ],
    [ 1, 1, 1, 1, 4, 1, 1, 1, 1 ],
    [ 1, 1, 2, 1, 1, 1, 2, 1, 1 ],
    [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
  ],
];

const brickColors = [
  Color(0xff2ecc71),
  Color(0xfff1c40f),
  Color(0xff1e6091),
  Color(0xffe74c3c),
];


const gameWidth = 128.0 * 35;
const gameHeight = 128.0 * 35;
const ballRadius = gameWidth * 0.02;
const batWidth = gameWidth * 0.2;
const batHeight = ballRadius * 2;
const batStep = gameWidth * 0.05;  
const brickGutter = gameWidth * 0.015;
const brickWidth = 512.0;
const brickHeight = 128.0;
const difficultyModifier = 1.03;  