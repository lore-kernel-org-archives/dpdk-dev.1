Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0169CCCA470
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Oct 2025 06:56:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00A09402A3;
	Tue,  7 Oct 2025 08:56:22 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 703BC4027F
 for <dev@dpdk.org>; Tue,  7 Oct 2025 08:56:21 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5975fuqb009981
 for <dev@dpdk.org>; Mon, 6 Oct 2025 23:56:20 -0700
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023131.outbound.protection.outlook.com
 [40.107.201.131])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49mvxar3qg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 06 Oct 2025 23:56:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QMI7tSbVaiFiKtkDUFkbrRqRSm2+V7MuFZj7zTI3AjnHf7JyYUQ0xaQnvI4qGohT+zaanbIXQ+eeRdzKi2iRgEC+RXDL8b5jiAYGbWIPsfIwUVHZa/IP7BRacQU/8sD95Hon2Co78zNd3QFdM1VrYAKIWYBnUrvGag6AjLus/FaeocIxkfj6DRvZLNVkLO7DRpWF2iQYBUx+2YRMkT5/XU8eIflCaZNB/6Z+QuW8otmYeIznNEQ6aCLJkqJTz0xx69NEjUVpoKuM8GOl8+t9LNZ9vnUOu+D5sld5B3MBzGBwGTyWJhqDuBj/PMQ5w/ILjVKzD3khkxnBPJ3VqEl9bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLwzsFCyQ66FIK+AzBBmabMhq4inkAHP7cx0XngvPGc=;
 b=pyd3nKaXSr0DNUR4DM7VhYhi+PJSt3cFbC+S0df6ijAVWjL9kztHHGgU889lA6gmWxuCFFxtK3BqvNhXZZwdMdvQ0OixWKmMu1xqZ5MRxLiDreKzbs9VpEGS9szuk/TqCEty1JGSTZiFgUa9rgQfla6EZ4gjRSkR0h4wKXvnUILCsLtfvpW8hB8tQFhHbBEXDkssVEzHRAYdiMNgxijsbXIirT9WDzWWEPFLPP7tgmjpVVfvSoTVfbbWy6u3dGHIfdHV6FG0nK+OqKHo4rQbuVGYxmpicSIQKQh/n8XmnXNVrRpWZMHmEtdoNCbUFnimkHsKMsNNx+Nskljr8wQeCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLwzsFCyQ66FIK+AzBBmabMhq4inkAHP7cx0XngvPGc=;
 b=seEjDkY1PaWf9KYQwroQhGkgw5xlfrDRVRpPP7fD/p5RizhQj/+/tBUWVRzn8/yXqVlZpGNdkG5Wmum/TlW5omyfGFXPl564wMoIVPKpxtVImgP2F4pxZRCNXHA8LLdZs7mWR7gRIQRy7EmxTN/fGACK+ou0Rdn8jrEu6UGvJo8=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by IA0PPF820E5265F.namprd18.prod.outlook.com
 (2603:10b6:20f:fc04::c2b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 06:56:13 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::f458:534:2d1:7afc]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::f458:534:2d1:7afc%4]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 06:56:13 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: Rakesh Kudurumalla <rkudurumalla@marvell.com>, Nithin Kumar Dabilpuram
 <ndabilpuram@marvell.com>, Kiran Kumar Kokkilagadda
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha
 Koteswara Rao Kottidi <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Rakesh Kudurumalla
 <rkudurumalla@marvell.com>
Subject: RE: [PATCH 4/5] net/cnxk: handle soft expiry support
Thread-Topic: [PATCH 4/5] net/cnxk: handle soft expiry support
Thread-Index: AQHcNoAXVzuHlBSZHkGs+h8pF0+TTbS2QblA
Date: Tue, 7 Oct 2025 06:56:13 +0000
Message-ID: <BY3PR18MB4785DB1893566B6FACDF7D83C8E0A@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20251006051402.1387576-1-rkudurumalla@marvell.com>
 <20251006051402.1387576-4-rkudurumalla@marvell.com>
In-Reply-To: <20251006051402.1387576-4-rkudurumalla@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|IA0PPF820E5265F:EE_
x-ms-office365-filtering-correlation-id: d43641f7-4aa5-4129-51c9-08de056e9ac1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?4vf09rbWs6IEtiS/3xRg5lgxbX2zjmhY+fCbEm6Ba9egZgEUQ1qcE47NX5Og?=
 =?us-ascii?Q?dOCm1spwWOLneuBoiL9UYQ51nOi16e6bjMjsZ6VlMVuwLekik5BK8RdIjpcj?=
 =?us-ascii?Q?oQgIMUjeCvgzlxxdZKT19ytKSwdl180mqqzh/JYQvmp7iyCQ4V8gpkx/Kywe?=
 =?us-ascii?Q?QSQ7N4CQz2T0gyuv8lL0tEwfZak8XlWlaJ80ZzLcas7j0URzICq3m/2B12Kp?=
 =?us-ascii?Q?VP6AKedA2OxYr4dw6fP99H02hjPWfOTYqaLxlyDCXeEGpyUJPp92AowDztHj?=
 =?us-ascii?Q?hF2TOndBIgIsjddmEcDgAPc9U09vHVlwcArTQAGUMco+CHCOZ3xQ8wqVzHni?=
 =?us-ascii?Q?qSVwpU6mCLhb+uYTiyLQR6CXHQiXvZ6S2yVwa0F1MDRPo1n4LwKKO15mFIj/?=
 =?us-ascii?Q?mS3Ujj5fQtinD5lG29E51h+VUuh+5rIFkuP725ZnRa1Ypp/7MSfMDUxgwh1P?=
 =?us-ascii?Q?hjywdRito0P8dyGAr3wNZzjCM50IC1i98OXNbjvI1UVAXvp2grHyda1Gsate?=
 =?us-ascii?Q?Q7rl3SusRKNsUJGa9RXUsQD7J64V1Ml0vjfH1OX3ptwWoJBE161stsWbU/BB?=
 =?us-ascii?Q?2K9ScD9CBhjfkM+zO2VUrFtguxKpUVVovmB34rVFEfDzWh3w7n5sCl70ccYh?=
 =?us-ascii?Q?GQ+dwYo/Sa7gR90inZPCqbhnN+TbWW3IzPKlmBnffA4g5XM3Q1Jg03QlyrsU?=
 =?us-ascii?Q?KadNK1uDY6y0DIgi+Y0ASazCJDM/n54lESDvo4iPc/kwTz/h9qSIets9LW95?=
 =?us-ascii?Q?CRJ9O9zxSDmKqoQWxNWg88PO2qJFZs7T4pviBvU0MvFkiot/SUoZcyNuM9O2?=
 =?us-ascii?Q?Bk0mYJj9XbEIU3BVFHw9JlEDQ4odme2Yie65uZMoeibpuCWkBXVELk98+wnE?=
 =?us-ascii?Q?q+P5LKh7f6/tdJFOLaJP5JucFdvpTuE32KlA1lIXpKkf3CG27Cmi2soOuh4X?=
 =?us-ascii?Q?S0oTHZD3T07IePkRzoLFJy76EDIolINh/XVHkuwJoxnb+zKxz7tqpIiSn6bn?=
 =?us-ascii?Q?BXSgo3gk3nN1vffXMYoKTPpiOXK+/mQFMPjPNUxqV6B1zKGZS0SKfw3AJp0N?=
 =?us-ascii?Q?0zgvFLz+9j7mxy+kLeJuk7JRjoYqH7ZFkQ8OYb7kysmKuglurNzK2JsL8bTq?=
 =?us-ascii?Q?bjvg+CDsDQCiudmKxw+QFTJP+WNVPGyW1RMPqEkHaMXbhggXLyoVULLnVWwO?=
 =?us-ascii?Q?sgz4nex+/DUstLawyrf8CbbWxBXTo0A8esXwXkE1X4feQeC3kuSvE5JEY/KK?=
 =?us-ascii?Q?2nefId+rMeYhoR69XjEaZuLjbOP6ftyQfwrPLGngPcQuhr0o0e4/Ogjk/YyH?=
 =?us-ascii?Q?sXcTm/pX+dG9/Zj/JyECfHa1H+siYdbVHU2nSuL1ejYZRIMSIEBX45VIGQ3E?=
 =?us-ascii?Q?vhWj0h6EvRRaZsHfxN0pSxU9ghlqsIq7OlO12BbX9dNOzhH482z3JfAVGyFt?=
 =?us-ascii?Q?N2XGuUida1ke/cMwz0UOwut3AfxqV9bXhaIiKA5yDRadaF8a8aKvYfNhC8lP?=
 =?us-ascii?Q?oZM9jJLVqao3XY1VQdQuZZ1ec5LP1XSMFtYz?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3y4XPhmkhQvC5jJOuAMws0X+fCazDnlLw2qr3s7n7BoVVdHd0s1c5aaY0jcz?=
 =?us-ascii?Q?aeB8gmmJWB0OyIqPiIGpjHwzfTz9ZVbX5di8MGCYRnybGJBPl+QhPkHBm6VS?=
 =?us-ascii?Q?ymidF+pwmguADscqgaem1x1IyTLiJSl2AtbrlIN8XeIqydfqDpLcapCnMfEl?=
 =?us-ascii?Q?71f1k06/609YfQs/z9Ik7cjMHX7Bmxr5zusoKhtyxtyTvsK/2WAoyRHapX7b?=
 =?us-ascii?Q?IgkI2GkbV/rGtJkc+mRROPXcl1nRR36z24J5LD+CobDWNwzVMoC5rujqmVWK?=
 =?us-ascii?Q?qyPkqgcYYFcS6MR/XSFkc3ih1t33mYCMlQA7aUuY1HjtEEHTvYS3ewvskLKq?=
 =?us-ascii?Q?wac96lDdTekEKYcuiy4iMxPyc6PskRzH+JAfoRAYT9PdnlyMpDiWg++ommye?=
 =?us-ascii?Q?BOBEHFQ7jA/IRWbo1ENQJZx590ydJPWwyXZk2TN87ujXEY/qMJR0/EFFtLUZ?=
 =?us-ascii?Q?oQjsnAftrkaQCIR7q+PMjhi2H7VRiczw3JnZ/p1Q55AXX5Dl6DAs63zEQ+Az?=
 =?us-ascii?Q?A+JiJMrVHpRmBRSBdU/0JnBIBxK3x3luQn21ome5E8kQNzTtLi0VpADlJudc?=
 =?us-ascii?Q?X8W0zWuK6vZNvyanzWrHgqIA3j/vNpLSGf10Z44HMF9PcxEuwFqcgvaqau42?=
 =?us-ascii?Q?rGg4+e7TmQcnE9w7GxBB47si/sQhl/lOYdfZ8gIgwMoeOCGjoHGdJermUSAw?=
 =?us-ascii?Q?SSBZ0Euw+ZiyoiWS6gtZFEp18NnnvxLBeZ8Y3kIYtkN9tgOw9wLlibkV/5Df?=
 =?us-ascii?Q?/WsiAp3C/ucvot+V0+dfWvq7g0vKIsrHn01UNiNYHDYIdJw+WF5isYqUcOWm?=
 =?us-ascii?Q?0U0yVDwpR9R73z+CbtsumNA2vzkWaYpXMS+kqtp0fXjvZCKIFxz51jJ9w1AB?=
 =?us-ascii?Q?nKexK3C1lGUHZ3flMll1Z5tZSFZuKXbRpH9axaIbX9ingEmBQBST6TjxXAGy?=
 =?us-ascii?Q?++S+YK5OinkYuSO4ESRwyAtskAcTGMRyfAwTfRV27PR5X+xvmq4iXFEG0zHA?=
 =?us-ascii?Q?BTJ4rFSTQ7XmYgOo+H5pBIKI4WwT/CcrKjwLTICFDgUESi2MGyHPbILKrdtc?=
 =?us-ascii?Q?3f0aKqHaUKtstblV7TDvWRK/sBn9J40v4jHU/o4K7PdPduPaYzIRy0qcRl73?=
 =?us-ascii?Q?8Tnypcyi6tGR07ii/j1uCsyQqYYM0YOsIw1Chv/vjfd25gFcfTTf8pOKf6iy?=
 =?us-ascii?Q?QsyVVW4GOLgXj1EkPY/hiUglH4CIbwXqX2ra0oO7khGcFfx7CF/bV4bMxInd?=
 =?us-ascii?Q?6UoDkFsdudFgyXFgt4Tupa2Hl6VZT7W0RfDVszw0BrqezOang0Xwygr4Rqra?=
 =?us-ascii?Q?1Dmgb9gXY8THRvzl9LkxLP0mCRHUXiyQkzLEDzOYhPIXBwXZ4Z07s7VUyCdk?=
 =?us-ascii?Q?pebwnDPSA8owuT4R0C6SGD2gB9+SLQol5u2hmb56OX2lIMr/9+N8cOGsaMSQ?=
 =?us-ascii?Q?HUxi6fkrPf2zjH3i+xdb5u/yLyMQ9nxpViix3x3UxWovRjsJUgTPSC+hJfiA?=
 =?us-ascii?Q?0l1fzcYTs2FhIOlRt7BwyEAagPLqg6V6DNmXCDuUAZ3Xjbpxb5e4I8mhPQc1?=
 =?us-ascii?Q?Tm9cUCT0AAGqpecuY2PWSeapqY+RxQoBKmI8olU8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d43641f7-4aa5-4129-51c9-08de056e9ac1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 06:56:13.3990 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FAj8QShFUsz0nKQjD/m12xcQNzW2AohdTJnwRBIWBSR+KKYG90HHWtJTTKVQ8nKvaXoAtgRbQiAujdf7aayisg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF820E5265F
X-Authority-Analysis: v=2.4 cv=HesZjyE8 c=1 sm=1 tr=0 ts=68e4b994 cx=c_pps
 a=YiOwH4ClqGLeqjbxKXDYtA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=Y4oN7HLr7teIfmY9izwA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: q-0yAj5U0yDLsdZDlX0HLkBaNzCrNEZO
X-Proofpoint-ORIG-GUID: q-0yAj5U0yDLsdZDlX0HLkBaNzCrNEZO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDA0MyBTYWx0ZWRfX1nafvfFPy2Gz
 QMAWe5WfhApkShFFQEO8wglZdSXdZKZVdgp1LdeNrz6jupRhktysCIBLudFqQC4PAsJ+7txPqSa
 yjpBuN4j/tp/J+j7ewc/wWlrWVkoTB05ClENL5QcayXPdmz7ecqaGY9lmDtRrAzfJSnp4A3xHfK
 eG2CFKYu3Z+tXG/c2HOnNW1UmV6/AfU6W7SXl9EiwEA5mqbzs6B/0xlDzBVCB2b1xRCRBheHGR9
 1Vo1BN8JBMS20K01foNIBOxfWVM/Bk0osg64teIhJCBYVYrBVKG9FPBjSVTzChHAZf+AyB/lhWg
 NK4jluVgwpyotBuhayL5fdvkWlebYIrFNkIX2S7QhR0AF/fr0Kiukc+ikaUs/tErNl7bgDotX2e
 V78Rf+RcpzPvIz+FGji0OKSbLMhgVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
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



> -----Original Message-----
> From: Rakesh Kudurumalla <rkudurumalla@marvell.com>
> Sent: Monday, October 6, 2025 10:44 AM
> To: Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>; Kiran Kumar
> Kokkilagadda <kirankumark@marvell.com>; Sunil Kumar Kori
> <skori@marvell.com>; Satha Koteswara Rao Kottidi
> <skoteshwar@marvell.com>; Harman Kalra <hkalra@marvell.com>
> Cc: dev@dpdk.org; Jerin Jacob <jerinj@marvell.com>; Rakesh Kudurumalla
> <rkudurumalla@marvell.com>
> Subject: [PATCH 4/5] net/cnxk: handle soft expiry support
>=20
> Add routines to handle soft expiry for outbound packets using CPT CQ
> mechanism. Added devargs support to inline device to use CPT CQ.
>=20
> Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
> ---
>  drivers/common/cnxk/roc_features.h        |   5 +
>  drivers/common/cnxk/roc_nix_inl.h         |  18 ++-
>  drivers/common/cnxk/roc_nix_inl_dev.c     |  29 +++--
>  drivers/common/cnxk/roc_nix_inl_dev_irq.c |  75 +++++++++++-
>  drivers/common/cnxk/roc_nix_inl_priv.h    |   2 +
>  drivers/net/cnxk/cn10k_ethdev.h           |   4 +-
>  drivers/net/cnxk/cn10k_ethdev_sec.c       |   8 +-
>  drivers/net/cnxk/cn20k_ethdev.h           |   3 +-
>  drivers/net/cnxk/cn20k_ethdev_sec.c       | 132 +++++++++++++++-------
>  drivers/net/cnxk/cnxk_ethdev_sec.c        |   4 +

Update  doc/guides/nics/cnxk.rst for this new devags
