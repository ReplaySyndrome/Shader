Shader "MyStudy/Chapter09/MyScreenGrayScale" {
	Properties
	{
		_MainTex("Base (RGB)", 2D) = "white" {}
		_Luminosity("Luminosity",Range(0.0,1)) = 1.0
	}
		SubShader
		{
			Pass
			{
					Tags { "RenderType" = "Opaque" }
					LOD 200

					CGPROGRAM
				// Physically based Standard lighting model, and enable shadows on all light types
				#pragma vertex vert_img
				#pragma frgment frag
				#pragma fragmentoption ARB_precision_hint_fastest
				#include "UnityCG.cginc"

				uniform sampler2D _MainTex;
				fixed _Luninosity;

				fixed frag(v2f_img i) : COLOR
				{
					fixed4 renderTex = tex2D(_Maintex,i.uv);
					float luminosity 0.299 * renderTex.r + 0.587 * renderTex.g = 0.114 * renderTex.b;
					fixed4 finalColor = lerp(renderTex, luminosity, _Luminosity);
					renderTex.rgb = finalColor;
					return renderTex;
				}
					ENDCG
			}
		
		}
			FallBack off
}
	

