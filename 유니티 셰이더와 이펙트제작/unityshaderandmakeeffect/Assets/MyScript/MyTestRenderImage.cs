using System.Collections;
using System.Collections.Generic;
using UnityEngine;



[ExecuteInEditMode]
public class MyTestRenderImage : MonoBehaviour {
	#region Variables
	public Shader curShader;
	public float grayscaleAmount = 1.0f;
	private Material screenMat;
    #endregion

    #region Properites
	Material ScreenMat
	{
		get
		{
			if (screenMat == null)
			{
				screenMat = new Material(curShader);
				screenMat.hideFlags = HideFlags.HideAndDontSave;
			}
			return screenMat;
		}
	}
    #endregion



    // Use this for initialization
    void Start () {
		if(!SystemInfo.supportsImageEffects)
		{
			enabled = false;
			return;
		}

		if(!curShader && !curShader.isSupported)
		{
			enabled = false;
		}
	}
	
	// Update is called once per frame
	void Update () {
		grayscaleAmount = Mathf.Clamp(grayscaleAmount, 0.0f, 1.0f);
	}

	void OnDisable()
	{
		if (screenMat)
		{
			DestroyImmediate(screenMat);
		}
	}

	void OnRenderImage(RenderTexture sourceTexture, RenderTexture destTexture)
	{
		if(curShader != null)
		{
			//screenMat.SetFloat("_Luminosity", grayscaleAmount);
			Graphics.Blit(sourceTexture, destTexture, screenMat);
		}
		else
		{
			Graphics.Blit(sourceTexture, destTexture);
		}
	}
}
