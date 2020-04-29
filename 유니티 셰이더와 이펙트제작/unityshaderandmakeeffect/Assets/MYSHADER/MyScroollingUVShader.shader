Shader "MyStudy/Chapter3/MyScroollingUVShader" {
	Properties
	{
		_Color("Color", Color) = (1,1,1,1)
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_ScroolXSpeed("X Scrool Speed",Range(0,10)) = 2
		_ScroolYSpeed("Y Scrool Speed",Range(0,10)) = 2
	}
		SubShader{
			Tags { "RenderType" = "Opaque" }
			LOD 200

			CGPROGRAM
			// Physically based Standard lighting model, and enable shadows on all light types
			#pragma surface surf Standard fullforwardshadows

			// Use shader model 3.0 target, to get nicer looking lighting
			#pragma target 3.0

		float _ScroolXSpeed;
		float _ScroolYSpeed;
		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;

		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_BUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_BUFFER_END(Props)

		void surf(Input IN, inout SurfaceOutputStandard o) 
		{
			//tex2D함수로 전달하기 전
			//UV 저장을 위한 별도의 변수 생셩
			fixed2 scroolUV = IN.uv_MainTex;
			//시간에 따른 UV조절을 위한 x.와 y컴포넌트를 저장하는 변수
			fixed xScroolValue = _ScroolXSpeed * _Time;
			fixed yScroolValue = _ScroolYSpeed * _Time;
			//최종 UV 오프셋 적용
			scroolUV += fixed2(xScroolValue, yScroolValue);
			//텍스쳐 및 색조 적용
			half4 c = tex2D(_MainTex, scroolUV);
			o.Albedo = c.rgb * _Color;
			o.Alpha = c.a;
		}
		ENDCG
		}
			FallBack "Diffuse"
}
