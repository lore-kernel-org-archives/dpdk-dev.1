Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01463CD4F5B
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 07:07:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72C6E40608;
	Tue, 19 May 2026 09:06:55 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11020108.outbound.protection.outlook.com
 [52.101.193.108])
 by mails.dpdk.org (Postfix) with ESMTP id 8F839402B8
 for <dev@dpdk.org>; Mon, 18 May 2026 14:12:53 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsegrWqFHaVJrLgQhYUkwYjpwZ63ns9cAKPOBHnibSiZR/2uC/EQ5tNhuT6sisRbUkVmwiv5odOcWrZjOqMxym+J+xO1CCkdvTOrGuXsk2Jy2NVgaRfgFeCzSJeJiZ0nPJL0nhBndb4zXw9pjtDVbjiRXWnuBsHLeSU/RjF+7XcftTyGc6oG83+94cNAmLn+JazYJWhTAVSefSG7YRkaC5MXJm+J4mavfYpFLDCyUUr6ECKG7ypIEKnubBAM4LCB+h2z+Mpz4903OxyjgDfOpylSy64tNGzNFfooTIc5e+iQhFF8YOofTXFfGkmWu1JLy1vqYCMcFmmx/p5ldT9Obg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmimoZyMJSPNDfmygCUNiXIKJ+KUb/CSVSjOAiKdsJQ=;
 b=MYsgY0WQFAAC6FhGr2fWUTWIU4FbuDACdmI+VdAEW7rmAdCmhe3Dg2pJVWEYReSSf/YIRp7miR9Uet6xdkpRT+h+ZyhnlgShTw7YYLf8Yml4acK5xqQlUUj7/pZwaWxObudvStHNBdduCbjq1f54UTw01Rs609XFamnea+pXG+NjUgRKeBc+9iwllAg38NpJW70xDWxNgux0FpfnzJEzvs7kWPTHb27w+NKggz0Bxu8v5ZPY6U8Bn8QZZlm8jDtK/U5PlMrUzBdiF2dwZbNg0ecbcPcrGR9QpJLjKOTO0olb4cv8hDfIiLnTNCqYzyfCIkPa7gzJZdCBLJTFrQHIIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nrao.edu; dmarc=pass action=none header.from=nrao.edu;
 dkim=pass header.d=nrao.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nrao.onmicrosoft.com; 
 s=selector1-nrao-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmimoZyMJSPNDfmygCUNiXIKJ+KUb/CSVSjOAiKdsJQ=;
 b=XcQtHJVEPinJWKAUNpL1djI5aRhHfi371tOAucA7S2EXAopP2F3xGpRnPaeE6B8U4ZEAh+zQFzkjWDcchJGjTy/ocVa8WBOo4AecR8oYN6jpHDucdl322HwFxBC47xtB0ecqr2WUtZgs4OfApu5Kk7kerXTg28Fr8FeZZpSLfoY=
Received: from CH3PR14MB6346.namprd14.prod.outlook.com (2603:10b6:610:14e::19)
 by PH8PR14MB958671.namprd14.prod.outlook.com (2603:10b6:510:3d0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 12:12:51 +0000
Received: from CH3PR14MB6346.namprd14.prod.outlook.com
 ([fe80::e8a1:5457:a3a4:281e]) by CH3PR14MB6346.namprd14.prod.outlook.com
 ([fe80::e8a1:5457:a3a4:281e%4]) with mapi id 15.21.0025.016; Mon, 18 May 2026
 12:12:50 +0000
From: Noah Bloom <nbloom@nrao.edu>
To: "dev@dpdk.org" <dev@dpdk.org>
Subject: Bad gateawy on DPDK kernel mods git URL
Thread-Topic: Bad gateawy on DPDK kernel mods git URL
Thread-Index: AQHc5r3D+YttNsdNa0GA1TRa5au60w==
Date: Mon, 18 May 2026 12:12:50 +0000
Message-ID: <CH3PR14MB63465CDF386C7768B0B65621BF032@CH3PR14MB6346.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nrao.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR14MB6346:EE_|PH8PR14MB958671:EE_
x-ms-office365-filtering-correlation-id: 252399c6-4959-4ee2-a2f3-08deb4d6c828
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|41320700013|376014|1800799024|786006|38070700021|13003099007|8096899003|18002099003|56012099003;
x-microsoft-antispam-message-info: 0JDaFdmOJXAC/9uKcwLjq1Oua4+bVjbyFjXEWB9Y+gNn1L8RCyUbtJEheNLx3jR+pGoGHFnJODZsjyLYdofmhm3Zqbx95v8XWYPwjqqRzrYcbCS4CRffR6BrKvF+V4pvxkhrm2qSGJMcfHPRWN6T9u0Yvq8j/4UWyGxa+4ogFyVU2imR0B1fukAzE6DM/GpGXaEs/OUBiIxbGHjihLDzKyTEDrkxvwHMLKD3Vz54g8VluNS76tvB6lmxREdpDVtjPRAJF3kVC4FokOFjwOb6QDknZ98XgTj/yLb+MJdQI1h5KvNBQ3UojIILGlxzwCA1iH6sdVrIPLVYJ2uV8D+DxH+OrZbQGQcEYijFoSS3tV+6NnOKOWbXDGVYiGchbGTSVHz7nypzslBB96oIRxxBBmQoL9eWwjmNrpkVvp0erbZZNb1NBbQYbiErskFyU1fN+AafLkHQS18R1Ig/FFVjeYNdDgv8k2Z5liIGVAEG3Kxiwh1H0MJp44uEXuS17t4MZ5zkjw+1M34lSi+xN2IiiVqwtfutN+tyO1I1FqIcD5+iVD2U+cCYjJrfIueuYAI1DuPSYvphO92GwoXb4nnLcEv8jOI0jkxVWKQlZQZOVHtV/B3+DYiQggEd+m8GCbHRhWqcT2fg9Ld8SX4qMUIkkUJYJ25AcagdzpV51ccMeiMA7p41vLO3HuY3e3tX/SMUu7RzfmqaJW/iZfULxzi/5KyKChe9ygWd2I1oheVt6PZvxEfjlDm5kNPm7BqyoTwa
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR14MB6346.namprd14.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(41320700013)(376014)(1800799024)(786006)(38070700021)(13003099007)(8096899003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?X6Pk97m0w4BOooG07M1ZbKNYSwJYUo0E3i7bVChOfvFitkCrwcjZML3yWp?=
 =?iso-8859-1?Q?med228jtkhAdBU0VZyF2PfALeg7oNNmVjjXo67i31AMDVtGByMY4EVhGnz?=
 =?iso-8859-1?Q?LK2dUQxpu/EquKz4A02wWlOkgrtxjZsL8Uh1YfzWYkuoT+3XtVQ4rOyvWQ?=
 =?iso-8859-1?Q?08HntSBGPqd71U70j+geHV3ko6oGiUR8YsiOmaQThG6qWSSLPmXw9HLoyo?=
 =?iso-8859-1?Q?mw/3NbV2U6wgVTT5cWQn1yYHg6kjvlO1kbJlOkZbIKvgH8xkwbZ/9XpNog?=
 =?iso-8859-1?Q?WeR7khVZZAIRfIbjyC0PymDQi/0X9e3boiL3oZdS4YURhA4RTsboZr26X1?=
 =?iso-8859-1?Q?5DNDSx6lb4eMEyZXVIpccY/zGIBlHj9YbNu2RLt8pPDLF4i4SQ+BkNaicj?=
 =?iso-8859-1?Q?JqVv8YTyOwjsAPNQMrBv5uVOTeADdezyYRG/KUXQPAhjXYtGYTf0S7RBfx?=
 =?iso-8859-1?Q?Ci8NQCQJO62UdZJOCY0DmAgjzWQM/uNK45au09IUSbfro3CgSZM9qNDvSZ?=
 =?iso-8859-1?Q?LBHhckT0ifH1BWQT/DxRe4qa6nc1tFofjrXQkyKNpFoIwozqN6y2aCRQ7T?=
 =?iso-8859-1?Q?R5yihupqguK3I01n4FOgKh9cGBFcJt9JwA46zbLQUT/noRM5/8zzqTJF9h?=
 =?iso-8859-1?Q?S0HdQUg+4Prm2xrAIsiFlBpzZPiLReO/j3M4gi7scOBoqivF+3ljC4qRlQ?=
 =?iso-8859-1?Q?oOBtq01Gl5JucS7monfqYQ3r4PfPzr1WwckTdfRHn2Du5Hwg3Ji0LCQwaf?=
 =?iso-8859-1?Q?7yw5uXbjnhFLAdmFd9I7MgibdbYEQ3o+0hwE8UUZeE4CCN1oEc568GC4PT?=
 =?iso-8859-1?Q?hYmf9ffYo12GbgApbKTXPB8FxnPoKotjd0/V1o4PhAK4F4rIE5XYs3anA2?=
 =?iso-8859-1?Q?Tn5zEOhERVVgy5m0+fz+N5sXjBRsULKHqY0rknwl6jm+z266osqC/agIFo?=
 =?iso-8859-1?Q?9rfol85YP0Z7sLZAdLyWshnODMO6XMh60H6DBRTAdSYkfa1qC3f4rS3Wlo?=
 =?iso-8859-1?Q?lPEIvGJMSfUru5C/uf+pQ11L8cSjW0XyRoV++XqU2Re4USU/jd+DJGJrqI?=
 =?iso-8859-1?Q?WB6QCoMlpro4mo8tOYPVYvobtMfXCWqhiTiCS0uXJ/T8sAV7hiEw3icgjv?=
 =?iso-8859-1?Q?26mKl+iH0Q+Is16vOVXMIXqoHK+0SGH18OIqm9b9JFUs2o4uuLijfxPei4?=
 =?iso-8859-1?Q?Z4AhXY5XMzTTR853D22OmwCpKxGd1C2Ne8vuOqYkgV4Q5CaQIdq/upqRRX?=
 =?iso-8859-1?Q?sxBvNtkF9uziJ/Lzmhf6SE2t6nX/iyXwrNiZiRUajJtjS/KxTtFwoXByG/?=
 =?iso-8859-1?Q?ReKI2RPAnoh6IdfkkkTLH6/xc6Qwvf1esc6ScvzlQdFUVmBpu5PN5HjSpl?=
 =?iso-8859-1?Q?Rigj4Yep0Zy9Jzr3fpEgye+XXVCkEnUEvBbcKaAJ0Cder/PAVf3UY12EfK?=
 =?iso-8859-1?Q?q1Lpd/KVPHyjcsaBl3mRsSeKE/twAP/1GxEqgh/UCsUICLm/+FLfRHkWFb?=
 =?iso-8859-1?Q?GrT3lUt1VWJYgqfHZdMOiS0DlZnPGSLETNSs9aY+a+2FOrbq8otECNTfL6?=
 =?iso-8859-1?Q?uuesn+oezCn1bmwwnVIwEYfDFMV8VcYBgSOkUeR/02LtXE0dm7Z3xqWQr7?=
 =?iso-8859-1?Q?sUF8xxFXcgyPFsmndOYND6+OebxLRE4XMKSXZLMJloBpY2ziewnkbhtEqC?=
 =?iso-8859-1?Q?M6ZA+XvbYOsiu87vaju30ot3Y+vJdho6D+yQJn8X9GAdLw2pJfJr9QnB87?=
 =?iso-8859-1?Q?OHa+s4qB7RxaeXFXh9jLL2dIUJf5XeVcp/nM77A3BvklQ2?=
Content-Type: multipart/alternative;
 boundary="_000_CH3PR14MB63465CDF386C7768B0B65621BF032CH3PR14MB6346namp_"
MIME-Version: 1.0
X-OriginatorOrg: nrao.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR14MB6346.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 252399c6-4959-4ee2-a2f3-08deb4d6c828
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 12:12:50.7123 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 76999309-9e36-444d-bc21-0500ec3cfa17
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IeRtAE7kAA5lOreDy5bUTDYgt7Hil4SRzwSj1XS041hnDhKwGAzOsiRPt7Yu7Yiy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR14MB958671
X-Mailman-Approved-At: Tue, 19 May 2026 09:06:54 +0200
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

--_000_CH3PR14MB63465CDF386C7768B0B65621BF032CH3PR14MB6346namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I've been running a third-party script that installs DPDK kernel modules fr=
om the DPDK.org git repository and it has recently started failing with a 5=
02/Bad Gateway error.  This was previously working as recently as May 14 (4=
 days ago) but has been happening since at least May 16 (2 days ago).  Is t=
his expected?

Here is the specific error:

$ git clone http://dpdk.org/git/dpdk-kmods
Cloning into 'dpdk-kmods'...
fatal: unable to access 'http://dpdk.org/git/dpdk-kmods/': The requested UR=
L returned error: 502

Please advise.  Thanks,

Noah Bloom
Software Engineer
National Radio Astronomy Observatory

--_000_CH3PR14MB63465CDF386C7768B0B65621BF032CH3PR14MB6346namp_
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
<div style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Apt=
os_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; co=
lor: rgb(0, 0, 0);">
Hi,</div>
<div style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Apt=
os_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; co=
lor: rgb(0, 0, 0);">
&nbsp;</div>
<div style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Apt=
os_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; co=
lor: rgb(0, 0, 0);">
I've been running a third-party script that installs DPDK kernel modules fr=
om the DPDK.org git repository and it has recently started failing with a 5=
02/Bad Gateway error.&nbsp; This was previously working as recently as May =
14 (4 days ago) but has been happening
 since at least May 16 (2 days ago).&nbsp; Is this expected?&nbsp;&nbsp;</d=
iv>
<div style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Apt=
os_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; co=
lor: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Apt=
os_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; co=
lor: rgb(0, 0, 0);">
Here is the specific error:</div>
<div style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Apt=
os_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; co=
lor: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Apt=
os_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; co=
lor: rgb(0, 0, 0);">
$ git clone http://dpdk.org/git/dpdk-kmods</div>
<div style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Apt=
os_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; co=
lor: rgb(0, 0, 0);">
Cloning into 'dpdk-kmods'...</div>
<div style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Apt=
os_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; co=
lor: rgb(0, 0, 0);">
fatal: unable to access 'http://dpdk.org/git/dpdk-kmods/': The requested UR=
L returned error: 502</div>
<div style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Apt=
os_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; co=
lor: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Apt=
os_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; co=
lor: rgb(0, 0, 0);">
Please advise.&nbsp; Thanks,</div>
<div style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Apt=
os_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; co=
lor: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Apt=
os_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; co=
lor: rgb(0, 0, 0);">
Noah Bloom</div>
<div style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Apt=
os_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; co=
lor: rgb(0, 0, 0);">
Software Engineer</div>
<div style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Apt=
os_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; co=
lor: rgb(0, 0, 0);">
National Radio Astronomy Observatory</div>
</body>
</html>

--_000_CH3PR14MB63465CDF386C7768B0B65621BF032CH3PR14MB6346namp_--
