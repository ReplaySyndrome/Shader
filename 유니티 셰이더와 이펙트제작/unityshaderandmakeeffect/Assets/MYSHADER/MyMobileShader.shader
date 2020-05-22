Shader "MyStudy/Chapter08/MyMobileShader" {
	Properties {
		_Diffuse ("Base (RGB) Specular Amount (A)", 2D) = "white" {}
		_SpecIntensity("Specular Width",Range(0.01,1)) = 0.05
		_NormalMap("Normal Map",2D) = "bump" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf MobileBlinnPhong exclude_path:prepass nolightmap noforwardadd halfasview



		sampler2D _Diffuse;
		sampler2D _NormalMap;
		fixed _SpecIntensity;
		struct Input {
			float2 uv_Diffuse;
		};


		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_BUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_BUFFER_END(Props)

		void surf (Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
