Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3013CAC599
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Sep 2025 14:08:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A4DC402C3;
	Wed, 17 Sep 2025 16:08:00 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11023110.outbound.protection.outlook.com
 [52.101.83.110]) by mails.dpdk.org (Postfix) with ESMTP id 13AC740285
 for <dev@dpdk.org>; Wed, 17 Sep 2025 16:07:59 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=utGlxLXGAwcsqmCICXRzRyHh4v+F1gm+gfDfGqQsgz9nLWkQ/6tQfPrzDUEpEBGLWouq4ZGPxaly4PIuY6RXeklzs4ujKllHpwxP8PfZ9+D2eQLIk5JMC2k4Eqx2thwF8CxqH/s+KT0ItEThPXSv/XR6JLiS/65VR6fOWW2eDxJp5btMyk+q8qZfe0Ofs5UMo6aFJgpqRXXC9Seuoynctn3HngyBmGFwA0AvSShJ2lOvTTKvAFS6ChEicV4C5RhZ0eSnfSqGl5J0Cu4ESPChX//QpK2KDMlStbQFCBbeRnd+GLDj2C1y31JvpQy74LN5ciMabyz+JV1juQIyoHxuXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hzRomIgm1As8jlqjfvtWi7AWHAUUWX7UhPZ5Q9CIdw=;
 b=xJ5zO4NCalODSgw79e77mJb2XOPctFTAgRSaP/IsGmsBzvO4Ac8B/roZHWkpOLxkUILLG6xns96BKVHoO/tT4FIGbCNUx+czAou4PhDMaUWVJQSmZY1nVXs9NXK+36Ksh8GHYn1M72Uyy5JPP20plGF0ahkbNsJb4t+zvm4Rwqsti5V393+zD8xYWnvegO6bem0ZllGJTPeXEtI3MheJXxr+4XFsxrGP0d4qEV3hGOJ9j8jRwBFZ0qKc+WuPYm8lJ3cUBGK0WQyXjQFJxls3IOehHMKrJTLKBoI7aONoZ0BgbMegKCl3u/bYoam7l/olUJGoCf/qarN/9wvHKMrhtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=catonetworks.com; dmarc=pass action=none
 header.from=catonetworks.com; dkim=pass header.d=catonetworks.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=catonetworks.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hzRomIgm1As8jlqjfvtWi7AWHAUUWX7UhPZ5Q9CIdw=;
 b=0mgdWEC8sfMx/3cnGePrs+RjxrI9OwDg/1iGMy9GI52+qVBsejdTgBkryA+5R49z18iuK7F9r0Ull3J9OpToDTOmWf0zMEn/C4JyVD4zKS3pyu4/vQlKadXI+09qWSdqLZ/Hko7gW2BPKw7nE3UQzAfkOcYI9rFSpyV+sXorF7Y=
Received: from DB7PR03MB4890.eurprd03.prod.outlook.com (2603:10a6:10:75::16)
 by AM9PR03MB7866.eurprd03.prod.outlook.com (2603:10a6:20b:431::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 14:07:56 +0000
Received: from DB7PR03MB4890.eurprd03.prod.outlook.com
 ([fe80::7d9:95de:63e6:701c]) by DB7PR03MB4890.eurprd03.prod.outlook.com
 ([fe80::7d9:95de:63e6:701c%5]) with mapi id 15.20.9115.018; Wed, 17 Sep 2025
 14:07:56 +0000
From: Arik Alexander <arik.alexander@catonetworks.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: Dima Babich <dima@catonetworks.com>
Subject: DPDK LACP implemantation
Thread-Topic: DPDK LACP implemantation
Thread-Index: AQHcJ9p2HDXM2SQhRESVke3PVqaxxg==
Date: Wed, 17 Sep 2025 14:07:56 +0000
Message-ID: <DB7PR03MB48906F6B09425E675420A8A6F217A@DB7PR03MB4890.eurprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=catonetworks.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR03MB4890:EE_|AM9PR03MB7866:EE_
x-ms-office365-filtering-correlation-id: 1da0fb15-17bc-4a3b-ff7e-08ddf5f39a27
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|39142699007|31052699007|38070700021|8096899003;
x-microsoft-antispam-message-info: =?Windows-1252?Q?+V2KhCxou9LPfxhvQSaj7ZgNMbIGG0R7kTjr775BAltoHQM57TobmdD5?=
 =?Windows-1252?Q?x+PTuJWe7FDHU0Si4rnfKt8H5ukZ+UO9rRQVxVezOjMeeTQV4UEq/Y/K?=
 =?Windows-1252?Q?ZRa8ZSCM+1H4a19tbwRzc2apO8v9lCB/olqMSJajnzetXgO/cLDgg+KP?=
 =?Windows-1252?Q?IkdbNb3wDm1XdVSsErmeQ1y9Klbea7jW79DDhJ/OVoS+GUm273lBf+Qh?=
 =?Windows-1252?Q?b+mC2kNdnjTXNq+k1zGtrDtHainjyoVSGhXRigkr1uo1yzyRJ8pejcKW?=
 =?Windows-1252?Q?VFAv0l1pNCA8L96lw5cd1s0eGvatXjbbEuc+1x6iCBIh56Y/4S1kA9x8?=
 =?Windows-1252?Q?3tKJtyVb1oBJVG/YJv1FsE34FeZ/ywqkRhQHu2w5UZVUNJvXx2bBNXCr?=
 =?Windows-1252?Q?XLhxZH4Q69uEsVxjBVbaQ7L4HLRsHJZCNRJSQgq91rTjeF/Em5S00pzs?=
 =?Windows-1252?Q?27l/Y3BI54J3Od+tiRzKc/UNIASeImzQW/STaTlhVBZRqp9bheecfXYX?=
 =?Windows-1252?Q?9GcJL9m02S+xuViJc66WpxB6ktLVrkTldvQJoXZGsLSlsDF52Dwit94E?=
 =?Windows-1252?Q?4fxKUAzMoq1gQQ/ZSH8f3CXdHvlIkaU1I4MQhQdjDu6JoySETxu2AOOr?=
 =?Windows-1252?Q?y3g9hVP796cLdl7ZZIc7oXEoMESynvi2msWrpkc0PNbKmwfc8jTB4Vo6?=
 =?Windows-1252?Q?+Av1drY0/bvTsEdRFhYENPlymrDoSeTuv3LCtOAvcSpUlKWZXj62hOn0?=
 =?Windows-1252?Q?DBpU2UX+B1iW07/blfsMc+D+BqdmJgZpcPgT/4ZaG0twLywUGQ6dVelL?=
 =?Windows-1252?Q?rFH/W2r2ulhAVmGHpwwK94gKFDXV7qQmUB1/V+6xT5cMPGmj+ljIm6s5?=
 =?Windows-1252?Q?JeKpPJWitLijJdt2VhyKlbQHI2ecu73yuxSxNAl+rbEC1pkxN36v2UtB?=
 =?Windows-1252?Q?nMW0ZhAugBPAgFqjfLgGn24oBQuN4Fap89IgC94m9DPaAzKDzKyLQ8pm?=
 =?Windows-1252?Q?Q/H0cLVSjA0hM3BwM1iEO6q4UoFUbKTZerXeg1ODjLAh9+H0JWVRp79o?=
 =?Windows-1252?Q?j6hYZpe3Noc2vp68+WBOKHX59Sr5iT7PQBkCSiZfJHI1TPXK7CXZAX3E?=
 =?Windows-1252?Q?INZpwpz9EAyQBlaOG8OB/sV0+GXHv/i+sgVRQFdGjj88/0su63btV7LY?=
 =?Windows-1252?Q?j4VlRpuMwazs0YhTBXOGcX2wkR8930mLHdVolp8eijjj2p6BE5GBL2an?=
 =?Windows-1252?Q?egrGJMZBAwCkREq2fiwFumLV9xEMiuSLMEdNxiJdLTA5CY8Hyv/7ZTla?=
 =?Windows-1252?Q?GHkffL8Fn/xtnUZw+ZwfrV/F5BDvhlT2CCA8kmoPCZWVlWiQ86kg/eOK?=
 =?Windows-1252?Q?STPTBGt3BLAcHL/v7mqLc5ynTlStq0WRRybL2nkSQcL5oeKqEiuW/egq?=
 =?Windows-1252?Q?dA5wVrlvSKoYgKkz3+dWoCSUcoEOKYX13l0M9o/Y5UygUAP95cwam39r?=
 =?Windows-1252?Q?IJSaerdQOLK40aoJQ/y6HCs+vEXpgvz+VTXibiPZG9kDzXV1zLz4Kg0R?=
 =?Windows-1252?Q?SuHng2dsnmdktEC24NyL8JmYBn18ZEQjdU/pnA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR03MB4890.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(39142699007)(31052699007)(38070700021)(8096899003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?rJDZxA9kWk15Oeh8S3RN/l9lY+I63vN+FpI5+qvlqk1EF6GUXNOqByWV?=
 =?Windows-1252?Q?OKASNbfv+8jxaA0oDdIgQDD4QeMQLJ9snDnZ+btxEarfqQv2Vyzk62Lk?=
 =?Windows-1252?Q?XCgQ85Wx3S2UeQBGNvzV0hO/rE1lAd9XYcG3tyfpdT9kEc0dL0uqh6qN?=
 =?Windows-1252?Q?/k1cgaEnZXPtlXxf38nOD+FtJG2nVFXb2uHstPPxIxfIMLb7aanBrAWm?=
 =?Windows-1252?Q?nnWl504R5kqANrmcQrwk8pmuwJjFCyFI7g0LGMWsNhx4mz4aK14u87U9?=
 =?Windows-1252?Q?bfpuvETGtu68O1snn8BSAFZNGdCh1D/TcdzgiIcGd4EVc9IKiZdqbcC6?=
 =?Windows-1252?Q?MRk0HsHCHGUjAlFFxz0XnYPRspDM0hqIw8WqYPcwnL3wZczW9gbLt0vH?=
 =?Windows-1252?Q?FHFl/OQ3NdVtI55FASWfjbze8zsEcmR+Ht955pImgJreOyvgWxYHSUSF?=
 =?Windows-1252?Q?s5IDKSZZPo9UyAlFZoIxVb8radaiMAZ8pvUeBeeQNSptjK2nUa2aiIuN?=
 =?Windows-1252?Q?7e4JWWLIFNwceVcIX5gpx96+c0/NG++T8Gv/m96/JY9BexMluKK4X8qS?=
 =?Windows-1252?Q?NavbxVCUarwfm7xS17L9UimHERb3QjrWKb6DwlpkWmVHZrtSwkRw637q?=
 =?Windows-1252?Q?UxWet80VMO64WKcG6S46HOfnHUnmsHQEBahZlrUsaSjvgsQj1krI6Jre?=
 =?Windows-1252?Q?TfN/8LymYO1HN+XdDGZxGnLQe8QAdRLk+taOuVb0UmKhZr37Rj12Zdlf?=
 =?Windows-1252?Q?7GV3GE5SwqTTT1YndXy1jOOaH0xA33c7e2fY74XqHm1o13CtdIhcO0yW?=
 =?Windows-1252?Q?QBR6HbZUPp+xNmJ8VxuSN42r7T4HEbIk1I6YOky4dGKPuWDhJoDuVU8n?=
 =?Windows-1252?Q?+rHWpcdYrYcuE0onkyb2zpcypFTsy+b+PU00PMiNOL1YKy0SBxGhCTkR?=
 =?Windows-1252?Q?UpPC6muVQYCNa1k4JezzAM6gwg8Z7lRVEliii1TKRv0WFy0nekAvwJVJ?=
 =?Windows-1252?Q?lU9oYKvSNr5MBiMFiAo+toE8QdPFbUEg2tD3OYWuxvf4aAQQzrWd16cg?=
 =?Windows-1252?Q?UtUxVojMaqgdWCI4tcocrLKV5tAIiC1eddgpEHXYIriwYQxE66wYlnWi?=
 =?Windows-1252?Q?++oqMab3DoIyTJtZjtzdjjLOu8tLPyvGMPXnaSLhAOXt/VgTixfC33Vz?=
 =?Windows-1252?Q?Qgz9i+nZardQkcjA4B8LPJzY06wzw6lVcXAyILSdZeEMwQkVtGWL2kmF?=
 =?Windows-1252?Q?9UZU6b5W2/hcYHgtSiL56nRjECQvelufv0JPQ4UKHSYN5EoGN6JNa/Ub?=
 =?Windows-1252?Q?GayOR5zT7He/AGlyaFZDL7VNsqxqNYlAOx4aI3vAFXQoIyjj49S3cn+y?=
 =?Windows-1252?Q?JAlUjb58eIEVAOmY7QxsAqRDqbL1ax0YVz6YMJaP8yS55f9ueHsFCPhJ?=
 =?Windows-1252?Q?nneHk6GookCoDCn1hWyBwPrcEAMJ7BK+55qM4bcWIHDoWcbMGv3keJdi?=
 =?Windows-1252?Q?HHCyy4ljb9yrmriFYdfHgkWJNyVIm2mF7pBLDnU9SavxkrZlfGdKaoeS?=
 =?Windows-1252?Q?/rOmryWh8+uaP40efIqMDosLERWRVfyNauJRYutC3AdSoRtvx5kmTyXv?=
 =?Windows-1252?Q?aM1htGI1kfAqtpP1R36jQ8/pHrad8SmXYs9jMY2C/uksLPPgDSqOPleR?=
 =?Windows-1252?Q?S4XtKHiwfPRkxKiKdAjHq/4NdFfH3ZCEMQDCvjkWIRg58PnQSEcuLw?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DB7PR03MB48906F6B09425E675420A8A6F217ADB7PR03MB4890eurp_"
MIME-Version: 1.0
X-OriginatorOrg: catonetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4890.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da0fb15-17bc-4a3b-ff7e-08ddf5f39a27
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 14:07:56.8304 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d03fe63f-ee56-4020-a121-dd5b65bc7ea3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j+Ztd3Q5jpE8wD8m+YgpiW6syEVdGJXC2F/RtPX/J7cUYToe9rLZqNkgF5paXDwc8zTXnxmPiE1X+s4SnX7OGSJvU1qxrgQoHeXsJQR8q1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7866
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

--_000_DB7PR03MB48906F6B09425E675420A8A6F217ADB7PR03MB4890eurp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,
At Cato Networks we are currently working on implementing LACP LAG (bonding=
 device, mode 4) using the DPDK library.
During our evaluation, we identified some shortcomings in the implementatio=
n =97 for example, the lack of support for short timeout and the absence of=
 proper handling for partner key mismatches.
These gaps, combined with the lack of complaints or upstream patches addres=
sing them, raise concerns about the maturity and stability of the library.
We would be grateful if you could clarify the following:

  *
To what extent is the DPDK bonding/LACP code deployed in production enterpr=
ise environments?
  *
Is it possible to share the names of companies or organizations that use it=
 in production?

Your guidance would be greatly appreciated.



--_000_DB7PR03MB48906F6B09425E675420A8A6F217ADB7PR03MB4890eurp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<pre class=3D"elementToProof" id=3D"x_b"><div class=3D"elementToProof" styl=
e=3D"white-space: normal; margin-top: 1em; margin-bottom: 1em; font-family:=
 Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;, Ca=
libri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">Hi,</d=
iv><div class=3D"elementToProof" style=3D"white-space: normal; margin-top: =
1em; margin-bottom: 1em; font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;=
, &quot;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0);">At Cato Networks we are currently working on=
 implementing LACP LAG (bonding device, mode 4) using the DPDK library.&nbs=
p;<br>During our evaluation, we identified some shortcomings in the impleme=
ntation =97 for example, the lack of support for short timeout and the abse=
nce of proper handling for partner key mismatches.</div><div class=3D"eleme=
ntToProof" style=3D"white-space: normal; margin-top: 1em; margin-bottom: 1e=
m; font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontSe=
rvice&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">These gaps, combined with the lack of complaints or upstream patch=
es addressing them, raise concerns about the maturity and stability of the =
library.</div><div class=3D"elementToProof" style=3D"white-space: normal; m=
argin-top: 1em; margin-bottom: 1em; font-family: Aptos, &quot;Aptos_Embedde=
dFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-seri=
f; font-size: 12pt; color: rgb(0, 0, 0);">We would be grateful if you could=
 clarify the following:</div><ul data-end=3D"795" data-start=3D"604"><li st=
yle=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFo=
ntService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rg=
b(0, 0, 0); white-space: normal;"><div role=3D"presentation" class=3D"eleme=
ntToProof" style=3D"white-space: normal; margin-top: 1em; margin-bottom: 1e=
m;">To what extent is the DPDK bonding/LACP code deployed in production ent=
erprise environments?</div></li><li style=3D"font-family: Aptos, &quot;Apto=
s_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helvetica, =
sans-serif; font-size: 12pt; color: rgb(0, 0, 0); white-space: normal;"><di=
v role=3D"presentation" class=3D"elementToProof" style=3D"white-space: norm=
al; margin-top: 1em; margin-bottom: 1em;">Is it possible to share the names=
 of companies or organizations that use it in production?</div></li></ul><d=
iv class=3D"elementToProof" style=3D"white-space: normal; margin-top: 1em; =
margin-bottom: 1em; font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &qu=
ot;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12=
pt; color: rgb(0, 0, 0);">Your guidance would be greatly appreciated.</div>=
<div class=3D"elementToProof" style=3D"white-space: normal; margin-top: 1em=
; margin-bottom: 1em; font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &=
quot;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);"><br></div></pre>
<div style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Apt=
os_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 11pt; co=
lor: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
</body>
</html>

--_000_DB7PR03MB48906F6B09425E675420A8A6F217ADB7PR03MB4890eurp_--
