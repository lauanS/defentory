using UnityEngine;

public class CameraController : MonoBehaviour
{
    public float panSpeed = 10f;
    public float panBorderThickness = 20f;
    public Vector2 panLimit;
    
    public float scrollSpeed = 100f;
    public float smoothSpeed = 20f;
    
    public float minZoom = 4;
    public float maxZoom = 8;

    private bool borderMovement = false;
    void Update()
    {
        Vector3 pos = transform.position;

        
        float verticalCommand = getVerticalCommand();
        float horizontalCommand = getHorizontalCommand();

        if(verticalCommand != 0)
        {
            pos.y += panSpeed * Time.deltaTime * verticalCommand;
        }
        
        if(horizontalCommand != 0)
        {
            pos.x += panSpeed * Time.deltaTime * horizontalCommand;
        } 

        pos.x = Mathf.Clamp(pos.x, -panLimit.x, panLimit.x);
        pos.y = Mathf.Clamp(pos.y, -panLimit.y, panLimit.y);
        transform.position = pos;

        float orthographicSize = GetComponent<Camera>().orthographicSize;
        float scroll = Input.GetAxis("Mouse ScrollWheel");
        float zoomTarget = Mathf.Clamp(orthographicSize - scroll * scrollSpeed, minZoom, maxZoom);

        if(scroll != 0){
            GetComponent<Camera>().orthographicSize = Mathf.MoveTowards(orthographicSize, 
                zoomTarget, smoothSpeed * Time.deltaTime);
        }
        
    }

    private float getVerticalCommand(){
        float verticalCommand = Input.GetAxis("Vertical");

        if(verticalCommand == 0 && borderMovement)
        {
            if(Input.mousePosition.y >= Screen.height - panBorderThickness)
            {
                verticalCommand = 1;
            }
            if(Input.mousePosition.y <= panBorderThickness)
            {
                verticalCommand = -1;
            }
        }

        return verticalCommand;
    }

    private float getHorizontalCommand(){
        float horizontalCommand = Input.GetAxis("Horizontal");

        if(horizontalCommand == 0  && borderMovement)
        {
            if(Input.mousePosition.x >= Screen.width - panBorderThickness)
            {
                horizontalCommand = 1;
            }
            if(Input.mousePosition.x <= panBorderThickness)
            {
                horizontalCommand = -1;
            }
        }


        return horizontalCommand;
    }
}
