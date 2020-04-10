Shader "Custom/SpecularShaderForwardAdd"
{
	Properties
	{
		_Color("Color",Color) = (1,0,0,1)
		_DiffuseTex("Texture",2D) = "white" {}
		_Ambient("Ambient",Range(0,1)) = 0.25
		_SpecColor("Specular Matrial Color",Color) = (1,1,1,1)
		_Shininess("Shininess",Float) = 10
	}
	SubShader
	{
		Tags { "LightMode" = "ForwardBase" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_complie_fwdbase
			// make fog work
			#pragma multi_compile_fog
			#include "UnityCG.cginc"
			#include "UnityLightingCommon.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCORD0;
				float4 vertex : SV_POSITION;
				float3 worldNormal: TEXCOORD1;
				float4 vertexWorld : TEXCOORD2;
			};

			sampler2D _DiffuseTex;
			float4 _Color;
			float4 _DiffuseTex_ST;
			float _Ambient;
			float _Shininess;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.vertexWorld = mul(unity_ObjectToWorld, v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _DiffuseTex);
				float3 worldNormal = UnityObjectToWorldNormal(v.normal); // 월드 노멀 벡터 계산
				o.worldNormal = worldNormal; // 출력 데이터 구조체에 할당
				
				return o;
			}
			
			fixed4 frag(v2f i) : SV_Target
			{
				float3 normalDirection = normalize(i.worldNormal);
				float3 viewDirection = normalize(UnityWorldSpaceViewDir(i.vertexWorld));
				float3 lightDirection = normalize(UnityWorldSpaceLightDir(i.vertexWorld));

				//텍스처 샘플링
				float4 tex = tex2D(_DiffuseTex, i.uv);

				//디퓨즈(람버트) 구현
				float nl = max(_Ambient, dot(normalDirection, _WorldSpaceLightPos0.xyz));
				float4 diffuseTerm = nl * _Color * tex * _LightColor0;

				//스펙큘러(퐁)구현
				float3 reflectionDirection = reflect(-lightDirection, normalDirection);
				float3 specularDot = max(0.0, dot(viewDirection, reflectionDirection));
				float3 specular = pow(specularDot, _Shininess);
				float4 specularTerm = float4(specular, 1) * _SpecColor * _LightColor0;

				float4 finalColor = diffuseTerm + specularTerm;


				return finalColor;
			}
			ENDCG
		}

		Pass
			{
				Tags {"LightMode" = "ForwardAdd"}
				Blend One One

				CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_complie_fwdbase
				// make fog work
				#pragma multi_compile_fog
				#include "UnityCG.cginc"
				#include "UnityLightingCommon.cginc"

				struct appdata
				{
					float4 vertex : POSITION;
					float3 normal : NORMAL;
					float2 uv : TEXCOORD0;
				};

				struct v2f
				{
					float2 uv : TEXCORD0;
					float4 vertex : SV_POSITION;
					float3 worldNormal: TEXCOORD1;
					float4 vertexWorld : TEXCOORD2;
				};

				sampler2D _DiffuseTex;
				float4 _Color;
				float4 _DiffuseTex_ST;
				float _Ambient;
				float _Shininess;

				v2f vert(appdata v)
				{
					v2f o;
					o.vertex = UnityObjectToClipPos(v.vertex);
					o.vertexWorld = mul(unity_ObjectToWorld, v.vertex);
					o.uv = TRANSFORM_TEX(v.uv, _DiffuseTex);
					float3 worldNormal = UnityObjectToWorldNormal(v.normal); // 월드 노멀 벡터 계산
					o.worldNormal = worldNormal; // 출력 데이터 구조체에 할당

					return o;
				}

				fixed4 frag(v2f i) : SV_Target
				{
					float3 normalDirection = normalize(i.worldNormal);
					float3 viewDirection = normalize(UnityWorldSpaceViewDir(i.vertexWorld));
					float3 lightDirection = normalize(UnityWorldSpaceLightDir(i.vertexWorld));

					//텍스처 샘플링
					float4 tex = tex2D(_DiffuseTex, i.uv);

					//디퓨즈(람버트) 구현
					float nl = max(_Ambient, dot(normalDirection, _WorldSpaceLightPos0.xyz));
					float4 diffuseTerm = nl * _Color * tex * _LightColor0;

					//스펙큘러(퐁)구현
					float3 reflectionDirection = reflect(-lightDirection, normalDirection);
					float3 specularDot = max(0.0, dot(viewDirection, reflectionDirection));
					float3 specular = pow(specularDot, _Shininess);
					float4 specularTerm = float4(specular, 1) * _SpecColor * _LightColor0;

					float4 finalColor = diffuseTerm + specularTerm;


					return finalColor;
				}
				ENDCG
			}

	}
}

