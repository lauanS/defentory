using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Unit : MonoBehaviour {
    private GameObject selectedGO;

    private void Awake() {
        selectedGO = transform.Find("Selected").gameObject;
        selectedGO.SetActive(false);
    }

    public void SetSelectedVisible(bool visible){
        selectedGO.SetActive(visible);
    }

}
