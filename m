Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8702ECCFA04
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 07:45:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AEA8C402ED;
	Wed,  5 Nov 2025 08:45:12 +0100 (CET)
Received: from PNZPR01CU001.outbound.protection.outlook.com
 (mail-centralindiaazon11021085.outbound.protection.outlook.com
 [40.107.51.85]) by mails.dpdk.org (Postfix) with ESMTP id 0FA7C40608
 for <dev@dpdk.org>; Wed,  5 Nov 2025 08:18:57 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mq5OUkT947aCdU4EQXmw5XeO1PUMe9ynNZpA0EifIUsEt3LxGCcq+AXnk40lQExYaog9tlTZ5UyJgV1nqUr2PVbhIrTvchBPTr+22lLnCHNeCxp8NWV7MFkjERyGoRZcMIswDKsFqxOLAYd7nlzkrX7i0nQeU4wMnbWFawg4ziZRR25LzJpbXugfYmxbUqAUCXa+RPTYLLImW0kKrYXINmfnOM7PhJQudLZuKOK3CNhUAezd3ia7M4/orQFv2AL6f1Cm1vUgVKl/BFfZpVuXKflPMwbR2n3n2g2tFClshArfgls5+jLzn/EgcAuMXkb+g2tbZafNGHBiuJM4YASP8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/3y+iyK58JMA12DkfevaYuCb6KNtkitAjj+WXL0m2s=;
 b=w3m4kvvsW4WuYb/mpbQT+zJ85xRJ3kHJZXbJvqTiqF0NSKa+qDLyUuk630MiUqm0o+EvpajYib5wOUtchumc7H9Xge5SZIdhbWAJzQ7qtwAvwSg3Bk2iaJxhFkJIMWz9u69w++891fNo45NDRVV/sYTWjhaUnptgxC0mumvV+cAMd7pNlQ0M+Y9jzy/17ZsjgO6GtFpT2s1WxR8yReLXp0zdQDEHzq8DKlqjExO4cAskBvlnqO18wXfrIOMaGTPkumz7A5HSuiXQ3WlkdXspO3JRxeh4lN6vL6hiquc2VauQPPMn6B4y3ULes2VRnfityjCN90UT+iI6jXKg6t5l7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iwave-global.com; dmarc=pass action=none
 header.from=iwave-global.com; dkim=pass header.d=iwave-global.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iwave-global.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/3y+iyK58JMA12DkfevaYuCb6KNtkitAjj+WXL0m2s=;
 b=OBa2ST6HhjEDetpYENmS+gCwM8Rf5/YaVsVoaijZ3df2ckyQ0ykt+WduPgYm5/QSXiww6akcJWspwoMpzZfnUH249lc4wIXKxzDs/cWNy/BVBuDNEw80y7c6VB7vHM6aLiMoyGy6botd85nGfy+KKq9LaoCNbodqwioXGzMQDePzvnhmR+TQa5vToDt/OHjVg4w17iw5NSfmvAuttEVSh34JBGPR2sKd9PKCqgX7S1wu+FAZ5hrtdaO82tJjsvXozefHcGrHga/6yE/8RiY5FxvbQSNGrpBmDFJ8oBandVVKi2qeis+prf3mXR78SVjT/htToyFiC90yzoKYOg86Og==
Received: from PN3P287MB0273.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:d2::13)
 by PN3P287MB1457.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:191::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 07:18:51 +0000
Received: from PN3P287MB0273.INDP287.PROD.OUTLOOK.COM
 ([fe80::38c6:bda2:131d:d3bd]) by PN3P287MB0273.INDP287.PROD.OUTLOOK.COM
 ([fe80::38c6:bda2:131d:d3bd%5]) with mapi id 15.20.9298.007; Wed, 5 Nov 2025
 07:18:51 +0000
From: Thenveer Poolakkanni <thenveer.poolakkanni@iwave-global.com>
To: "andremue@linux.microsoft.com" <andremue@linux.microsoft.com>
CC: dev <dev@dpdk.org>, "dmitry.kozliuk@gmail.com" <dmitry.kozliuk@gmail.com>, 
 Chaturbhuja Nath Prabhu <c.prabhu@iwave-global.com>, Ayshathul Thuhara
 <ayshathul.thuhara@iwave-global.com>
Subject: Assistance with DPDK on Windows 
Thread-Topic: Assistance with DPDK on Windows 
Thread-Index: AQHcTX35keRHNFi4HUamT/VsYmxpNw==
Date: Wed, 5 Nov 2025 07:18:51 +0000
Message-ID: <PN3P287MB0273982789E89005206DA9B0B7C4A@PN3P287MB0273.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iwave-global.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3P287MB0273:EE_|PN3P287MB1457:EE_
x-ms-office365-filtering-correlation-id: ba82d63a-314b-4690-4255-08de1c3b9238
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|13003099007|8096899003|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?aCd/xhIL5NMXJri3wqzjzR0tYG/Njc8c+Si47iN6VwvSrH35WKepT6OcUO?=
 =?iso-8859-1?Q?y+pMYCW6NvidCeJJsLDU7ja7WJ4921ojM4BZKr+v+NfcG+c8ta/8xDS+/Q?=
 =?iso-8859-1?Q?5oFcFpAEZyAtKsE8i8ri0M+wpc/i64c8GDRrKyy8iIu7w5yFxq8SlceQ4F?=
 =?iso-8859-1?Q?XNNHo18J9EA6LHLTBmR4n+fWzKFATdBINCOJZBfnfCqJELGarI7295fws6?=
 =?iso-8859-1?Q?adrJTC25bAlz8I/RHoOWcgt5pi/LZqZR9gaBmxmU2LVLb4FTZV9Jkk4H2V?=
 =?iso-8859-1?Q?KbTQoDGSQpQqIEWt/Q6IUqRIyivMW7GRz201j9fNqXhvHxMEkbyH57clwS?=
 =?iso-8859-1?Q?TkjCHq2XpxSFuWxliJ/Cv1Nh1w/eMZYR2Xm1IFAmx4X0kY6DsuRqQ0tadW?=
 =?iso-8859-1?Q?SnegQOm1fHTxMcLxJqto0fTrJb54BQgQN8b8XbGqOZ2uqy0zWBy5RDLugG?=
 =?iso-8859-1?Q?nifjsdOoenz9bdxrBIKPu5Ug0nr1aQl5818SKjhF7cvdLKefHD5TvC5L03?=
 =?iso-8859-1?Q?zXRS+u+8CljlI0kQPtSXKh34sJgBVHEE6wFr7VZDkTqN5g+u2F2FmuLpkE?=
 =?iso-8859-1?Q?sUZCCgodqZfWv2JLedC0XAw3YpfGgRzZ9+JTJTceMZKrimiR5dCmfyPI0O?=
 =?iso-8859-1?Q?6AMWcF5Bew3KW7ocn6Wz4ADo9CMUTQpScMsDTeXyDwUVMHShNVM7dXR3Za?=
 =?iso-8859-1?Q?Q5xmH9aG98bhZXWnkkfKga4RCs8EhhLJc24bTKNqklWtnRwXY4wMUGrTDR?=
 =?iso-8859-1?Q?NLDbVaybISIHISB3zdCJoL10rW6p55PVQ4BhmugPbpOvz01r9L09qKBPaY?=
 =?iso-8859-1?Q?MlWPuIt35b39U9oNa4IBEItZJkbeAaiNG5Vq+3q+p4Qrqv5XfG++4mLLej?=
 =?iso-8859-1?Q?MNkHPFHkmFaus8OJiNOyQJbPtWn+9WsYJdk0QuOp2lZB9o2N5GeHwAgg6n?=
 =?iso-8859-1?Q?kdTf0SK39OPvzDt0YT3IZVDvQriNA3SwbooH+WiudOK4fsuB6DYWCJNtdM?=
 =?iso-8859-1?Q?0LXYwYdK1q+/g8F5LNKUBwwVXzVEY1dyuozWI5uR3ueFE/Fbu6RlzXCMlC?=
 =?iso-8859-1?Q?MLFVdf+7OkIRM4Ua+n8RZHnu34pCWjgor9LZGIcz37UtOkY5qMIUI+TLLs?=
 =?iso-8859-1?Q?51rA4wSrKJk1fI/q93iWxju6owXm9qDgpJMPh/1UZ9296ZzQpuZvcxg+9C?=
 =?iso-8859-1?Q?u0rPDhRx1rks3mtCH4dHRJ7YkTCUwNmK+KA8m7zdQvK+31txBljLd9vmll?=
 =?iso-8859-1?Q?kmCUd+3LUL6ZUjq83Vp5s5ObHKTzVO+PyWJDjh8vJPLKASQKrcsWLRBA2q?=
 =?iso-8859-1?Q?i1CZMlEvJygC1GxGgFlkbt2FCmL1fP0WxIcpcOfAeZlQI+SUxY6LUUbF2o?=
 =?iso-8859-1?Q?gYPvLBEF3H9wQCHSvzS0+Gj8jw3x1w7RvgJfhhOz2GqH3g1pmRTd7Z25ey?=
 =?iso-8859-1?Q?TiLl4RRX/yRQv+FPkc51E0Tp1JqlxRtaynfzySWMnMWhZKTZArqappoAgg?=
 =?iso-8859-1?Q?3K1j79mctiu0pjNBRU54hC1N0JCigApoFkffXUrzqeuA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PN3P287MB0273.INDP287.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(13003099007)(8096899003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5IfF2Dsz+8cDs6MVinGKdTjvLk5ZwVNXoUbODteaqJsS03h9p0Vw17dUbP?=
 =?iso-8859-1?Q?edRgOiHaRhFBnMjS5OQADnusrG4iywt4VsK7tc9u4JexjUQN35x0sghadv?=
 =?iso-8859-1?Q?SYEejh6RH6ustgUd513pEvSlke0xfS4d9wTwrd1kiI6UPVviT4dtm314CY?=
 =?iso-8859-1?Q?WlAeAo84Zzzu5wAIg3GUm9oNjkdKPVbm2r2g1dTlDXaTZBJJhqspWTGPfW?=
 =?iso-8859-1?Q?cUyZw/sAO+1ZnoQP4Br5Jnl2dIFUF3Rp3HwzlCZdh5S2nsprUTyHZ5mYjK?=
 =?iso-8859-1?Q?Um79JaV27wgXfwBLAna5RaEHNlQEwkvm3S/rE+kTptYeOZ/2Cd3NQIrJHk?=
 =?iso-8859-1?Q?lh6LiCq3ZjHMrHw4aypDCQxJmk3fGblOaoMTUYIyKN5WBQi5tXqmh+jbKI?=
 =?iso-8859-1?Q?MM179JJtDwN+rwrK6Syi9qHZBjXTO7/Wx7PS6Flqn/6bM8FUsQ8D5rWdQg?=
 =?iso-8859-1?Q?gh1ar0ZhuOF4hyVb5MIncZ5ejHwHbc+xp8XoBNGFxMB1Ec1+oes2yMbOK8?=
 =?iso-8859-1?Q?0b5q+U4xb3vmPi4ylEbfdIb8NcJe25XeZq0iGFiR+43whJ/yigJzN2xhl4?=
 =?iso-8859-1?Q?/EKcJHjyCq8OVfw6qe0SPDOGGcAVj/D7sgogxQCIMAIYy8OkdRBWY6PDsY?=
 =?iso-8859-1?Q?0q4EMUqwBnhvj0ViYzS/YNIvCrKNz6HR6YI36ovwCoHopt/kSfwDQmagZK?=
 =?iso-8859-1?Q?6aJnOnfoEJjwLoeo6mcyyHTNAn9bFGTlM2GSMQMEAu0P2q2aQ2oOImQYNW?=
 =?iso-8859-1?Q?FgTs/tIV9Rl3Dj/LNx9D4wp5Aj++0Pm2JRrq4e0M50JiMv3TVsB8mQBvHI?=
 =?iso-8859-1?Q?BzEPqed9Ic6rjpBS0f0F4CE+204pcYPilxcasDwu0+bcMgwj+k104/j72D?=
 =?iso-8859-1?Q?AOQmy0btNJzGTAp2aaLOwYxQ4M3SIjhX2Wz9Go43OwqO3wztJcoD1KCprL?=
 =?iso-8859-1?Q?XDvnkNcrQXIfmD/jt6mDSgrK8GQ32bQhned7VnjrsY8TJ4IYulcHrFTNSo?=
 =?iso-8859-1?Q?+CNXnAizAV14UDIV+60cYofYO3mqigNs1xtfMOomv6qkNv7itH7euP1Ji8?=
 =?iso-8859-1?Q?5Ue5Z+aiPv3DRfjNYiGReoHTjBUz82w4L9zzGaKKj0v7xu6J+dlKPilZlW?=
 =?iso-8859-1?Q?dP936Gpx+Rfsn9iDViljdyxv9GGxXFF1H7xJiZnnB6n4b8PQMMjTriAwGD?=
 =?iso-8859-1?Q?F+bJmOZAsKiDha4FvexYkH9lL391apWjJRJoc6bEgL6uzMRPXyYbIIoS43?=
 =?iso-8859-1?Q?5EN4nB6Eia2d7Shlbx5thIjFVBoSEnZVYAZqRauytXKTC3TjSpvibk6F/C?=
 =?iso-8859-1?Q?9r+AIrKIJJXr30S8NSjHMNJq8OZCimNa73e0sQVecZStJVdB7lAcQFm9Kt?=
 =?iso-8859-1?Q?kH5Uzss+ju3sZGIVlaj5nHDNuPETfXWnWdVEBXyfbW0j4S8JM9EXeqhF1u?=
 =?iso-8859-1?Q?RvspiJAs/LrxYG72gzSomxNzwTzByom7AIenkn2N6uD4qKo/kTLw9p51Ez?=
 =?iso-8859-1?Q?ZnFPoA/WvGl4kJaoVx7wBIP1OtPbMzqHJeNXKKAiuLjz3FQgK2a7CFkfoa?=
 =?iso-8859-1?Q?VEKSgy7PTrwBXZ+jxpgealkEw34FVIVgvbaaDisxARntcDZxnpZ0WlfBDE?=
 =?iso-8859-1?Q?0v4LFhDOuXAI6DNjC/BqY81KN+RV3uPIwy+GfFhp/nu3elCXMn+YW6wOlc?=
 =?iso-8859-1?Q?6NpYf+tOZVdT93JNn50=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PN3P287MB0273982789E89005206DA9B0B7C4APN3P287MB0273INDP_"
MIME-Version: 1.0
X-OriginatorOrg: iwave-global.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB0273.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ba82d63a-314b-4690-4255-08de1c3b9238
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 07:18:51.4890 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 507ae903-cc48-4d6e-bdb6-35278120a345
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8CvAKlqs+Fs1z4spReYbOM7tuYTrglauFHIFGy9heEHminY1g37T15FXG06IlLXoIcAAeaDOERpfMLstmDb/NCvtrza3P030nTBsGkvg58oBGtiXXJnCg0nRC35oI46d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB1457
X-Mailman-Approved-At: Wed, 05 Nov 2025 08:45:11 +0100
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

--_000_PN3P287MB0273982789E89005206DA9B0B7C4APN3P287MB0273INDP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Team ,
I am currently working with DPDK on Windows and have followed the setup ins=
tructions provided in the official guide: https://doc.dpdk.org/guides-25.07=
/windows_gsg/index.html.
I have a couple of queries:

  1.
Is it possible to execute or use dpdk-devbind.py on Windows to verify the d=
evice binding status?
  2.
On Windows, the build generates .dll files (e.g., rte_net_driver.dll) inste=
ad of .so files (e.g., librte_net_driver.so in Linux). How can we use or ex=
ecute these .dll files in the same way we use .so files when running DPDK a=
pplications?

Kindly provide your guidance on these points.
Thank you for your time and support.
Best regards,
Thenveer Poolakkanni

--_000_PN3P287MB0273982789E89005206DA9B0B7C4APN3P287MB0273INDP_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Hi Team ,</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
I am currently working with DPDK on Windows and have followed the setup ins=
tructions provided in the official guide:
<a data-end=3D"423" data-start=3D"307" data-auth=3D"NotApplicable" class=3D=
"decorated-link OWAAutoLink" id=3D"OWAdaedb478-669d-2615-7745-cb43557fd068"=
 href=3D"https://doc.dpdk.org/guides-25.07/windows_gsg/index.html">
https://doc.dpdk.org/guides-25.07/windows_gsg/index.html</a>.&nbsp;</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
I have a couple of queries:</div>
<ol data-start=3D"329" data-end=3D"702" start=3D"1">
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=
=3D"elementToProof">
<div style=3D"margin-top: 1em; margin-bottom: 1em;" role=3D"presentation">I=
s it possible to execute or use
<b>dpdk-devbind.py</b>&nbsp;on Windows to verify the device binding status?=
</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" =
class=3D"elementToProof">
<div style=3D"margin-top: 1em; margin-bottom: 1em;" role=3D"presentation">O=
n Windows, the build generates
<b>.dll</b>&nbsp;files (e.g., <i>rte_net_driver.dll</i>) instead of <b>.so<=
/b>&nbsp;files (e.g.,
<i>librte_net_driver.so</i>&nbsp;in Linux). How can we use or execute these=
 <b>.dll</b>&nbsp;files in the same way we use
<b>.so</b>&nbsp;files when running DPDK applications?</div>
</li></ol>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Kindly provide your guidance on these points.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Thank you for your time and support.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Best regards,<br>
Thenveer Poolakkanni</div>
</body>
</html>

--_000_PN3P287MB0273982789E89005206DA9B0B7C4APN3P287MB0273INDP_--
