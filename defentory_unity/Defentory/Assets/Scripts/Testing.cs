using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Testing : MonoBehaviour
{
    // Start is called before the first frame update
    private Grid grid;
    void Start()
    {
        grid = new Grid(48, 27, 1f, new Vector3(-17, -16));
    }

    void Update(){
        if(Input.GetMouseButtonDown(0)){
            Debug.Log("Mouse: " + Camera.main.ScreenToWorldPoint(Input.mousePosition));
            Vector2Int vet = grid.getXY(Camera.main.ScreenToWorldPoint(Input.mousePosition));
            Debug.Log("X" + vet.x);
            Debug.Log("Y" + vet.y);
        }        
    }



}
