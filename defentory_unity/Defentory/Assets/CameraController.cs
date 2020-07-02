using UnityEngine;

public class CameraController : MonoBehaviour
{
    public float panSpeed = 10f;
    public float panBorderThickness = 20f;

    // Update is called once per frame
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

        transform.position = pos;
    }

    private float getVerticalCommand(){
        float verticalCommand = Input.GetAxis("Vertical");

        if(verticalCommand == 0)
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

        if(horizontalCommand == 0)
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
