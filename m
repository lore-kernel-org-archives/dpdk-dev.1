Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E15CD5BC9
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 May 2026 19:57:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59DB040280;
	Mon, 25 May 2026 21:57:19 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011003.outbound.protection.outlook.com [52.101.52.3])
 by mails.dpdk.org (Postfix) with ESMTP id 309F540144
 for <dev@dpdk.org>; Mon, 25 May 2026 21:57:18 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ha1tq+xCOO2WZd5kM2NQKIL+vELMs9A5ysNEutLSn5A4TgqzZ6jruMqq/748W32Kcy42ojm2ZACEUnXJbtKEZbDiahyBLG6eidYfzJkpsAhGkMfIn/n/cd7+t5jKI9VzzEs+67y54RT9Co+5JoiXJMBQIob4Ue1HWF8zLukb4+hqTHEIqz3xNxil8RKG04Fq+PY9ujjGsVwoRAY2EkL/mAHKwXWnE6fzrhRcKlDV18FY0SNfTeo8QA0UU4CpCGlFySwjEJT7c5dJLQPa6xvy8d69dV3cXp5EPxeFxzULJfZKjqbbWC7OVRKOqZCoRLThmP+K2nZgLyaMGgoypCCqMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQIpbTxFph+/AKRC/FJE9xIyuz7SBPDVxUmJHXUXo0M=;
 b=fMnHoc5BAPza4bXH9N5EJel2ON7AYyOzVmRyebGy7qLlB6Y7GvlOWONRaHjZwz+SO8HRZcMqW3TmN2NTVUsGo/E7whKmLCSlwPStS59oFVLuJD34pSPsNcbLUOyc2d1r9b1MFJsm4d+Dd5lHBEPYasyyxsB4FR1HbsDPJJYPjOry+Zefmp1gWNew8ZP12uG7fpZzH4XE2L0NLIU2rPt8gvM9h7NRIiCiJ/tRkQDOdWsQuZ0YirCLYL0olQeDqBj34lPCcc34qsaZrlvgit1mZeJ2jOjTsQcmviVr6y9ur0GNx64oYrcddekYqKeRVz7rYEqrgGLK8S0/hYzWBOIPMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQIpbTxFph+/AKRC/FJE9xIyuz7SBPDVxUmJHXUXo0M=;
 b=b0qGR/+ZkJRb6dWy1DaWoyHpKx0vwfxlVf8JNI2rGR9gbu2Tasm7T8r/aKTYfMDjIPP3C+3u+ERmFQJgNZxaZe/n4tVt1ynquuw+YXhjN3KblWte+afU5KlXnsHrHIwXOYEcqPnKJyiyPQwX8zbHOJFvXotccKoMwj/GOxmo+60=
Received: from DM6PR12MB4385.namprd12.prod.outlook.com (2603:10b6:5:2a6::14)
 by SJ0PR12MB7460.namprd12.prod.outlook.com (2603:10b6:a03:48d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 19:57:14 +0000
Received: from DM6PR12MB4385.namprd12.prod.outlook.com
 ([fe80::2c74:efbe:aa4b:195e]) by DM6PR12MB4385.namprd12.prod.outlook.com
 ([fe80::2c74:efbe:aa4b:195e%7]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 19:57:14 +0000
From: "Ningoji, Raghavendra" <Raghavendra.Ningoji@amd.com>
To: "david.marchand@redhat.com" <david.marchand@redhat.com>
CC: "Modali, Bhagyada" <Bhagyada.Modali@amd.com>, "Sebastian, Selwin"
 <Selwin.Sebastian@amd.com>, "dev@dpdk.org" <dev@dpdk.org>,
 "fengchengwen@huawei.com" <fengchengwen@huawei.com>, "Ningoji, Raghavendra"
 <Raghavendra.Ningoji@amd.com>, "rjarry@redhat.com" <rjarry@redhat.com>,
 "thomas@monjalon.net" <thomas@monjalon.net>
Subject: Re: [PATCH] dma/ae4dma: add AMD AE4DMA DMA PMD
Thread-Topic: Re: [PATCH] dma/ae4dma: add AMD AE4DMA DMA PMD
Thread-Index: AdzsfY9wg4QV943gRxSYPi5gpYF44Q==
Date: Mon, 25 May 2026 19:57:13 +0000
Message-ID: <DM6PR12MB438529A4D7C43F6AE7587437E60A2@DM6PR12MB4385.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f39aa4b3-b62d-42bf-8097-75e2c573ddfa_ActionId=11a468e3-2f54-4093-9734-6a0d697d5ce0;
 MSIP_Label_f39aa4b3-b62d-42bf-8097-75e2c573ddfa_ContentBits=0;
 MSIP_Label_f39aa4b3-b62d-42bf-8097-75e2c573ddfa_Enabled=true;
 MSIP_Label_f39aa4b3-b62d-42bf-8097-75e2c573ddfa_Method=Privileged;
 MSIP_Label_f39aa4b3-b62d-42bf-8097-75e2c573ddfa_Name=Non-Business
 v26;
 MSIP_Label_f39aa4b3-b62d-42bf-8097-75e2c573ddfa_SetDate=2026-05-25T19:35:28Z;
 MSIP_Label_f39aa4b3-b62d-42bf-8097-75e2c573ddfa_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f39aa4b3-b62d-42bf-8097-75e2c573ddfa_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4385:EE_|SJ0PR12MB7460:EE_
x-ms-office365-filtering-correlation-id: 041b98fe-98e6-4bc1-a444-08deba97d0e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|8096899003|56012099003|18002099003|11063799006;
x-microsoft-antispam-message-info: /1PnsAQpKsAvylDNuxK+seU9OCj7flMneaxHzTpL/WenIxJPuwcClqnxLT0fYbvHeUZMFSUJsRJUkoUbxfrLSgoYUmfDB/WYXQGYgGGe4UmjXw92B0OLZyJNkRagePWXJJMtHKnyKrzjf4dCLN1raPLI7faC8zAu0XZUkNiVUInSkRGG7TFPu8eRi41vx01NAIBXp1Ay6193Vdd0uNIAOcwtAudiOLtGwtsN9By8LMqvbEhtWSn2GFFpLdD0d0fRXsmxScOoD+ynFrPSRndzCJguQKCKspz+MwV3nuak+QVsS955IwFc9LTJ6LfC25MfOxujrCMckQSZbyAWNorYoYggGs+XHxcY6eJo/727wesRAbAYVSUrzy1P/lqbCdfoBFSVgamyLBPrM/zUAm0ZsvCCMnOfQOAvgiLmv29gYA0gK/9iEKbm1XxT1R0vkJiySb87x6KBt2HxgeZpulN/OKYhIwHSzA449Y6zgopOZqyZJqenm2lWXFJPgo4YaAjoLvxPFP5iMPiWHMJtptgHsAmJMUsgS/OKjdnPJ27D2JgE5VVCxmWZvtrxttUwjITCljXJurvFd+X8MAMoz6l1TTjmj9vbfz3Pra40H6wV77KdfMi5ChuJH4VLK4auWbkB//ccNA9WZchVpz00bC+SiJXGVrjrUhzN6ySkt6R79M6uMtwZlC0cn8KdE2J53v1O1yfsjA28tqQ7ohti9NKEv8KxxHzwxI9OVnx6EGF6l+MmkxJhX8D1ZxdRsBfKaaCD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4385.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(8096899003)(56012099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aS2rRimNxYmKJKUUY2CwEQw8ybMJ5y9lfmpiD046bP1PTNZ6Hd6ob8iA6fbZ?=
 =?us-ascii?Q?L931ThIT00ugP5ARJfdKBCiBHBXj8dn+470AJ/09hJq8PwbZEpTJK1MepFow?=
 =?us-ascii?Q?8pB+i4Wf808IcQf+NM3XVYLuysTN3D0FFPWbhuRLF8gzd4TgLW98wygFPbL4?=
 =?us-ascii?Q?xoAvS2vLZXclw9nXNUQmAf6+ZzGLHTyoPqAPFvjdoPyAfzWM23rNIL53aQ1/?=
 =?us-ascii?Q?A1r1yNyN0s+1hWJa1D6qoCZpQ6tTBQ+HOxc9eZbV+SzGHu3KMJNlZqEupYM6?=
 =?us-ascii?Q?VkbvuH4DtqXiabSz+6psIfswMoDA+i50e9CMnfx74yQQOC2necm8Zkf3SbCZ?=
 =?us-ascii?Q?GRkvZIbqNl7vfiKhhLkzv/cGGVntDjOtexsvN9yAAnA9vNJDc+FW/7eL19++?=
 =?us-ascii?Q?JBS/Uw9f7WgYeTo7kzEvLmB03Uqi+Mv0aKaOzNXGJwe8WQTz4dHZ70YXV7cb?=
 =?us-ascii?Q?vig6LqZyq7TWDN8U//N+olEm+o+IQICMCei2oHa9rCeQagbJsesJMaaCCRYT?=
 =?us-ascii?Q?jvHq/4tqCnrMcWHthIbZI7JMoruCBXQcnbF5rVdwk0yw9pPWH7eGhKyssure?=
 =?us-ascii?Q?1YvyYWgCmS47gW2tweEfatqUWpUxjx9rXl4juw/s5gRTLpHT6B6wWKnt5aJn?=
 =?us-ascii?Q?OTXjNGit+nHqHBSu7UPD3G7wGVw4lEgy9VJR/D/LxxKfZ+n4tGw32px+2mFy?=
 =?us-ascii?Q?N977I6ywvNFoLWQzh5VVGh8InfTvNfrjRgkizvjCsLldVt0Ei6GNT7cPELBU?=
 =?us-ascii?Q?Tjf3Kkh9dwJMmqWIs/xv6SvOvlUSeAzEfx2yYxO6lRjWBgLUeAVzaimIc9FM?=
 =?us-ascii?Q?JwwUtABBK7lZIYVF6dpHIAz7XYKd9MvDbZZAodYjLJ3vEr6EgyFkuC43wWE5?=
 =?us-ascii?Q?pASpzfz7Tw8yrqA5Sv0OI4c9jEPKfZyM8BlKbFepTVnqSZIh1/R2POdPbTUn?=
 =?us-ascii?Q?86EaGw371+n/OzAbmbZ9lOLt0u9f0Sg3OLRosAivJn5JN0miv2qghAJicuyC?=
 =?us-ascii?Q?ozTjwLj/+KYwA9bAdolK6Ue+8XWBAadteSndAe/MmOetuCDRA/1xqXYuL7Do?=
 =?us-ascii?Q?YJTefgWV6aL+NvMpK3Iao0sZ13m3KsENX/atRx80wjwljtvBZqhMGIEHXbc0?=
 =?us-ascii?Q?ibc2MfY5fbLN5T1aQ+dfnecfV0NQDVei51p2vBO0b+QmsPyxK4aDLhK5huIa?=
 =?us-ascii?Q?1xBHX2UXhToKHAoiEfhaEZ+E/fhoRBk3cC6r5IQxrhtJeDPce2vcG0LfLmH+?=
 =?us-ascii?Q?GL87QnfKuw0KHPt8zG1rF68kyD6Eo8X/l8TwCl16jYQ6sV5qAnChJaTn6hWe?=
 =?us-ascii?Q?L8p8Uowe/p9I5ZtR7iCEFaAbzO7mnDnbNgbyNXCaO0+MBGftcmJ9fcOBeU1I?=
 =?us-ascii?Q?z2n2LVSqe4VpdTKp1dWO3Zd+j789pOrSooDCB5Ck2nPENDII4kn6qKX+QO4H?=
 =?us-ascii?Q?I/PiFN0WjD2TjOY7nwlSrEuaBEVvRA97cr3iamMIujCBxqWe280syWWXN3hR?=
 =?us-ascii?Q?Qwq1Xk7q+EYjYc0KLQRhy1SSK8bfty/2ZPgBFCvJR+c76lsXsJmRtjhjTMOu?=
 =?us-ascii?Q?D+USUW1I1d8gmf0n/3M7gysKT5WzrbZFdSq2mGD7lAAMi8EasvIzqpCV8Rjy?=
 =?us-ascii?Q?EmHt3QfgZdVaf3aTFC3R2vcx4FT1+NFh/ECpVknaG3IM8hy7lLkQkB8vFzqM?=
 =?us-ascii?Q?P2mXskv7bMrZxiGMx2vPVATUOB/3XurDbPUQ0svWQvUTZjf8?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB438529A4D7C43F6AE7587437E60A2DM6PR12MB4385namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4385.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 041b98fe-98e6-4bc1-a444-08deba97d0e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 19:57:14.0658 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qhW6rddb7ge0rUJPUFRF8mbnKJRwcS0Wwka1nTFh8NqJJel5F3KsuwS4xspLo95V7AhoGUgnbmyRZM/AESaZ5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7460
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

--_000_DM6PR12MB438529A4D7C43F6AE7587437E60A2DM6PR12MB4385namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi David,

Thanks for the review.


- Please fix the below warnings raised by checkpatches.sh, and run this scr=
ipt before submitting a new revision

- Please also checks the copyright years.

- Globally in those changes, rte_iova_t should probably be used instead of =
phys_addr_t.
>>All the review comments have been addressed in v2 series . Now all the pa=
tches are clean and clears patch checks.


- The patch is big, splitting it into logical patches introducing one featu=
re at a time would help.
>>As you suggested to refactor the v1 patch into logical multiple patches, =
the v2 patch has been split into 3 patches.

Thanks,
Raghavendra

--_000_DM6PR12MB438529A4D7C43F6AE7587437E60A2DM6PR12MB4385namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi David,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks for the review.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">- Please fix the below warnings raised by checkpa=
tches.sh, and run this script before submitting a new revision<o:p></o:p></=
p>
<p class=3D"MsoPlainText">- Please also checks the copyright years.<o:p></o=
:p></p>
<p class=3D"MsoPlainText">- Globally in those changes, rte_iova_t should pr=
obably be used instead of phys_addr_t.<br>
<span style=3D"font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif">&=
gt;&gt;All the review comments have been addressed in v2 series . Now all t=
he patches are clean and clears patch checks.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">- The patch is big, splitting it into logical pat=
ches introducing one feature at a time would help.<br>
<span style=3D"font-size:12.0pt;font-family:&quot;Aptos&quot;,sans-serif">&=
gt;&gt;As you suggested to refactor the v1 patch into logical multiple patc=
hes, the v2 patch has been split into 3 patches.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Raghavendra<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB438529A4D7C43F6AE7587437E60A2DM6PR12MB4385namp_--
