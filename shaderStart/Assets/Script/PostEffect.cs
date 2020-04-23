using System.Collections;
using System.Collections.Generic;
using UnityEngine;





public class PostEffect : MonoBehaviour {


	Material material
	{
		get
		{
			if (curMaterial == null)
			{
				curMaterial = new Material(curShader);
			}
		}
	}
	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		
	}
}
