using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Grid{
    private int width;
    private int height;
    private float cellSize;
    private Vector3 originPosition;
    private int [,] gridArray;

    public Grid(int width, int height, float cellSize, Vector3 originPosition){
        this.width = width;
        this.height = height;
        this.cellSize = cellSize;
        this.originPosition = originPosition;

        gridArray = new int [width, height];

        for (int x = 0; x < width; x++){
            for (int y = 0; y < height; y++){
                Debug.DrawLine(getWorldPosition(x, y), getWorldPosition(x, y + 1), Color.white, 100f);
                Debug.DrawLine(getWorldPosition(x, y), getWorldPosition(x + 1, y), Color.white, 100f);
            }
        }
        Debug.DrawLine(getWorldPosition(0, height), getWorldPosition(width, height), Color.white, 100f);
        Debug.DrawLine(getWorldPosition(width, 0), getWorldPosition(width, height), Color.white, 100f);
    }

    public Vector2Int getXY(Vector3 worldPosition){
        int x = Mathf.FloorToInt((worldPosition - originPosition).x / cellSize);
        int y = Mathf.FloorToInt((worldPosition - originPosition).y / cellSize);
        return new Vector2Int(x, y);
    }

    private Vector3 getWorldPosition(int x, int y){
        return new Vector3(x, y) * cellSize + originPosition;
    }
}
