using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UtilsD;

public class GameController : MonoBehaviour
{
    [SerializeField] private Transform selectionAreaTransform;
    private Vector3 startPosition; 
    private List<Unit> selectedUnits;

    private void Awake() {
        selectedUnits = new List<Unit>();
        selectionAreaTransform.gameObject.SetActive(false);
    }

    void Update(){
        if(Input.GetMouseButtonDown(0)){
            // On left mouse button pressed
            selectionAreaTransform.gameObject.SetActive(true);
            startPosition = Utils.GetMouseWorldPosition();
        }

        if(Input.GetMouseButton(0)){
            // For each frame with the button pressed
            Vector3 currentMousePosition = Utils.GetMouseWorldPosition();
            Vector3 lowerLeft = new Vector3(
                Mathf.Min(startPosition.x, currentMousePosition.x),
                Mathf.Min(startPosition.y, currentMousePosition.y)
            );

            Vector3 upperRight = new Vector3(
                Mathf.Max(startPosition.x, currentMousePosition.x),
                Mathf.Max(startPosition.y, currentMousePosition.y)
            );

            selectionAreaTransform.position = lowerLeft;
            selectionAreaTransform.localScale = upperRight - lowerLeft;
        }

        if(Input.GetMouseButtonUp(0)){
            // On left mouse button released
            // Debug.Log(Utils.GetMouseWorldPosition() + " " + startPosition);
            selectionAreaTransform.gameObject.SetActive(false);

            Collider2D[] collider2DArray;
            collider2DArray = Physics2D.OverlapAreaAll(startPosition, Utils.GetMouseWorldPosition());


            // Deselect all Units
            foreach(Unit unit in selectedUnits){
                unit.SetSelectedVisible(false);
            }
            selectedUnits.Clear();

            // Select Units within selection area
            foreach(Collider2D collider in collider2DArray) {
                Unit unit = collider.GetComponent<Unit>();
                if(unit != null){
                    unit.SetSelectedVisible(true);
                    selectedUnits.Add(unit);
                }
            }

            Debug.Log(selectedUnits.Count);
        }        
    }
}
