Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8012EC5B549
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 May 2025 13:13:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9AF4D4025E;
	Fri, 30 May 2025 15:13:18 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 5FD1E4021E
 for <dev@dpdk.org>; Fri, 30 May 2025 15:13:16 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54U4PT5j009109;
 Fri, 30 May 2025 06:13:12 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2125.outbound.protection.outlook.com [40.107.243.125])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46y5mu8xsq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 May 2025 06:13:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ttOrKcNZfRRfGqTiCSTNCIipDOsAZmDQn1aNBOqcdZ9nfTeWcBqiEKWDlcqW4c8XWiCMLpa5W8pdVHot25/K0tHy18lI/vW8bmaFZH4ZjaciN1lzXz0degGELBsI1X2BMtshyxRh+BVKvSe4IPP58QtiODYcP+ngg1vkU20rTTkCKk1VrzsLDnyl6eSklESERIIbqSvvKrMDyQpwiQdyT/pJYFBlOFeZIEeE9TdbH0H53IZwamSURXmujOJHED8aSUPlidsvRTNtJhOlThqRXuWoNOGBQIrOk2ZI2dEyrnfWgygWi4xeIJ1S3TlR6BblVHAaw1AMEz5HuLKlxZs5Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqRhMOh1oGfOacpgeLC06D6I3d29BUxgYcELxZjyC58=;
 b=VCjlcK2kmbRCQjcwhdkLJVN3qKHOKqOCioNprB+rjFqvS/18sfXIYID6dj+xsBNGI+gqvWy+YlHyiyU5t+eu3kXRFWxILFx00K/Tay1Bap2PzJZKLtNlCsPUxjGXwlsApuR4KYPFotqMM61DfS7x53mjaQr/5y89gt+1izyI1d7n1aZCO0/T0k6h2ygsiekggf4nphlpO3BX5W/UYtmPpQKtFkIx2/puaDyUmic7vZv+IboFXpehFtcXXUAvCsDApk21mQilLwEjHxQUv/t47VLsz/aWxbYf98YH6htazGqMvjwMrbCcsBMPUHVFOqTR7TWnr+Xl/yjPiq+EEachjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqRhMOh1oGfOacpgeLC06D6I3d29BUxgYcELxZjyC58=;
 b=Iz00k+WdXwy1i+m9eECKydtgimiFln2o8H6lUnJRq47ChaivPlidebEd1z31GQX/piL//h7Oxq4YK3VZ0dGIkbKgA1w8GAkCg0kjqb06RFYx3GeYcG+3Uii+dZZmJBQRgYF8VWsd6umj1+WfEhSN9DL5aoxQXHtQDxcr0cHJbMM=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by MN2PR18MB3623.namprd18.prod.outlook.com (2603:10b6:208:266::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Fri, 30 May
 2025 13:13:09 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576%6]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 13:13:08 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: Nitin Saxena <nsaxena@marvell.com>, Kiran Kumar Kokkilagadda
 <kirankumark@marvell.com>,
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>, Robin Jarry <rjarry@redhat.com>,
 Christophe Fontaine <cfontain@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Nitin Saxena <nsaxena16@gmail.com>
Subject: RE: [PATCH v9 2/5] graph: add feature arc abstraction
Thread-Topic: [PATCH v9 2/5] graph: add feature arc abstraction
Thread-Index: AQHbstCDDgx+vLRpnUGCCEJl0MvjgbPrYzNA
Date: Fri, 30 May 2025 13:13:08 +0000
Message-ID: <BY3PR18MB4785E9B4003F2CA386071F16C861A@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20250103060612.2671836-1-nsaxena@marvell.com>
 <20250421151718.2172470-1-nsaxena@marvell.com>
 <20250421151718.2172470-3-nsaxena@marvell.com>
In-Reply-To: <20250421151718.2172470-3-nsaxena@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|MN2PR18MB3623:EE_
x-ms-office365-filtering-correlation-id: 1279e825-9cd4-4d47-94cf-08dd9f7bb8a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Qu9kPugSVtTrlx9ZPJSyfF2Rq443+sxxK+vmy59EfXG8LuTkmwDFbkM8n4mb?=
 =?us-ascii?Q?szEZxYtmA9PkVvZpYWkwAoPuDwbDNgqFvdGC9PrDARA+HxanOiuI35APSE62?=
 =?us-ascii?Q?9HtPIrskEgcIXH3Jv4IoHslCSXaGR9lNH7h87kGnogtQKNgPCevtOVTivWGu?=
 =?us-ascii?Q?nPQpyaDCNqXlCA4nS6NKKQbh6kIFJGA6pyouMaF7lbM0ME0ZxQRL6Sm6pErb?=
 =?us-ascii?Q?CMkoKELRlX27Un8U/9zxg1navsyHN5GNssHCq8dr5/x01kuKS6d4h4Zb0RZX?=
 =?us-ascii?Q?p/TJ//JrZzk4ouiRJQaBkKki7Ndhf3e5XLv7iipzBaJKjTj/6EFipkp25J04?=
 =?us-ascii?Q?kyo8gbXl1Q5V7S4W4s9+d3DXrvMct9uhhsEvCHAeecOtdrHyq/7D2fSlBn0w?=
 =?us-ascii?Q?opYd/p6Fr2L/DMliZZNwtYskTprtx6MplnwZGtsm/EpVHZNSgSweZwrLk2BA?=
 =?us-ascii?Q?vRlGFB3a+rwp1nNJAbJMuKYRLzVOYcmCp5M37+MxUZ4uE5LYsQz0C9y6f8Iv?=
 =?us-ascii?Q?vM28KuEeUsoZVoumqVphGFC65SLWtRpsckXA6zHf0eqEdyV/ACZOjkvz32wM?=
 =?us-ascii?Q?lTEqm0iLi6AHdeYCTsAubguEO9WiZcjb50NHyOa+eG+xLOLpR6/zHq04lf4O?=
 =?us-ascii?Q?Zu30rxmB3AwbVCQOpcoWAkQ97rbHLfIZXBrh2QcDyPGmmadCSkKrja3RHgfw?=
 =?us-ascii?Q?aJHWQJz5kBD1td5fQSflxFe9bOdy8+jjI9xVSiwDtZMkq6XQti8yUhvGuON/?=
 =?us-ascii?Q?c3aK/dXDfpmrV/kskZZ71/cMKSH6m4VW5il1A7VctXl2fX+PqUMUjV7Cl8Rq?=
 =?us-ascii?Q?XLm7tn7PlQbsm39mw4v8fE/r49drMfxDAmTawUxxQj5JnB5BSi20L4GLGe4t?=
 =?us-ascii?Q?WHx+okFVbawWh8oCVRdNOMfecorqLiWpyavC3BNiX5qKrElojKDOqdVlG9pz?=
 =?us-ascii?Q?3eT8H5cwmKkR+UVjnuRG+p2e8ei17+lJLFAzQDS71aDMV++fSln3rPgNyESV?=
 =?us-ascii?Q?Tb2NLIdswiG6SdKxiFypVQTz5Ajs2YQq1d0A/2k1pfRC+BtQRnTLOOattKGT?=
 =?us-ascii?Q?qwDf1JdophuzW26klPcnp6GZYeed5aLSBUOClBokloAFKcBARq0f+HsXPbV3?=
 =?us-ascii?Q?r6tr2oXsj3brJQO/hGYkQFJiAwIGoXjZA2OfX5vPfNzG48FMyfNX5T7SkkKk?=
 =?us-ascii?Q?MhQ4qGfDu8SQLcnODeHYeAXwHqF2kFNLhY4E6BSQwMEhh8nyOT5fghokdcIK?=
 =?us-ascii?Q?rPq5IusjkWJ9tHqPLgWETkGX+dr/DcUiid2wg0rCrNQEGYitPJS50CJP/S2B?=
 =?us-ascii?Q?0tlCy1me+qlBk+ivbTN9ZB0OEztdwt2oOPL7ddOz4XtLvynSpJPYb7snipsM?=
 =?us-ascii?Q?e/nB3PCSJTCZU6IYBZG0DKCDHNwP/bsElbOumw9QNoClyAGwmepg+qEo1ZjE?=
 =?us-ascii?Q?omkF0K3Ft27p6H28cthRCbeem/WoEQm88qD+MV8JudpWA+MCl1/60usLUOaQ?=
 =?us-ascii?Q?t6rpaX+4mx/JhRc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rQJx5D4FaIKbnw3i7juOiZjj7t/FIykYQKKTMM79skO8i82IdyIZ8wd4bSEp?=
 =?us-ascii?Q?pVGYZA9feclT9ytGA92hQv+phzyENl82bt4iIapTnAIL9eevHCeB82Iw8tST?=
 =?us-ascii?Q?u6+LKQXcZwB/0w7VDwXyiDKnOBxvkcSUZro9uXV5yaUorREFuPkqzqyUHLvb?=
 =?us-ascii?Q?yDElHec4uwm7A0/PHe+W+U4Brzv6OQ342r/eWAQpNiMyz91mgaSvSu7xXQG4?=
 =?us-ascii?Q?Ofhou9hyDvPfwic2oDZUUTn2SkO5KQ+oj4gV1kVrRYRWbJkkUsGWnW4DZGRH?=
 =?us-ascii?Q?OiiUaSG9Axs6aaC2jtWq3R2gCud88QWcydbDW83kDxBOywx/uHeKaEe+u017?=
 =?us-ascii?Q?vIkRMhIFHES3spPIB774i7isbkeDC5PL0SuDcDijsLuHua1tyanswCGBLxV/?=
 =?us-ascii?Q?lSciJ/hCNo7skBP3XK/cWo5AQulE0IC/ij0tSwdzmNBfK3NsJ2dfCO3qZYs4?=
 =?us-ascii?Q?lGTzsZYmfLbIfy2yhh67O6HBPr2EzizEowqJs/qUe25NUMHGxCaWsrAwTByL?=
 =?us-ascii?Q?DrhfShJirvVi6nrAXxh4ZSBIvWyJ67JleHuntmA1E8FQCuUy2v/fNA7XU+G2?=
 =?us-ascii?Q?q1kaZQ9oX6h5CbUp40gL+5PpHjcaC0IITJGDcaMbEPXKpaYXPOgj1PXXc0Kx?=
 =?us-ascii?Q?Ig/aJ15vVIJxm90PaR4UC19mp30i63UhfWiOmusDIzhwDqBFVKgihAm8dZmi?=
 =?us-ascii?Q?r2gMl+vmxVB7c+Z9qYhXBimMiqXclQglKMC69w+eRK++eKvWTgFBdAFQ7fF9?=
 =?us-ascii?Q?u4KyC/sibDCvhE3d9TPSLf/G+76Z+ukHupdoVA9N9B9ZvHHizXnWf3vknj6N?=
 =?us-ascii?Q?52GVg1U7MHGMcFeuEQtwN6s+9olsxw8QXEkG7FCFyT4K0uIXZAbPSYsE5Txz?=
 =?us-ascii?Q?R819qSR9+Zda7iYRBDH53LkajbUYNt3t+GDNQjEx4lF+cVJef/hz4oIy0Nxb?=
 =?us-ascii?Q?vYTQ65jkYXz1yFM2QdWzBQlIhH+gcs9bjB9bY8+3ofjVXlrwSzYbi58QixRO?=
 =?us-ascii?Q?8wWB5VUyPcy0r4lbDljKBn4X8vibNj4ce8MPxMkBW4+gYl6CpJNetXq+Ekz/?=
 =?us-ascii?Q?hIdTDg22J+asFo9fljJinp3CmlBmFgHKCxjF3WUau9On9M0MmcJrExcENP4T?=
 =?us-ascii?Q?hUvRD9vNmfbanfqugWrt8X3q1hpXraMt4SjetxaRnl/q+Oyq91imAM1NXMQ0?=
 =?us-ascii?Q?xyVIYJ+YUfTn15Ipo/kXMZlq1KHfQR/2acQA8Lx0M6jzHYa7AXtyrv8PGyEI?=
 =?us-ascii?Q?VBi4SqJ1lpMIlV9ID+A9NG81Cxp17n5yCTtkhuXKtTxhkP0Ir2Z/mhvqOcRJ?=
 =?us-ascii?Q?/gSYgfP4mUXoGzv+QdX7mPBvm4sH+yRsL3jdzsC99x9I6iRZ5AxPPMWowBIi?=
 =?us-ascii?Q?7i+7nJgtMqmEZxjH3fufktP77tsnXMKgrM4QRfVTB0K/X9L+XD0VOnGRlutQ?=
 =?us-ascii?Q?dOdmJ9mNE1+XTr9mQzRw1UoaRo91hQNB4oU2AiN5UbcYN1d+JDvvOL+8z3QT?=
 =?us-ascii?Q?H99jtBHPeEIuNinguMV4uXPMd1d4aLo5iRk+VwppUiqneQtaonAddaz/Y5TJ?=
 =?us-ascii?Q?77g4dlTaf72PobMorpzNAlLam0CmZwoQGlK7ElfJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1279e825-9cd4-4d47-94cf-08dd9f7bb8a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2025 13:13:08.3658 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bVRVBce5Rx4WAircZtgoB7nLwl7cBMSVkS/ccY7YtOI+FXRBlw0atyM5LIVuZBhS5cCrKhY0S9BGBFGvAE62GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3623
X-Proofpoint-GUID: CGOvOUEzau5LVonXWlOm8sK4kFeqG9dW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDExNSBTYWx0ZWRfX1Ac9Dw43SL5m
 po7gXwPDGaFbzTXjUNJ17hnjD6Jl8jn69wH/HlhHGfcD082NeZo4t/OdYWGOXzkhW0IQR9OMt78
 7k5HCO2d20EWMvDZ0vYgeNUmbNj5wbljTNdd5aaZktvPhAtEzP0izCzJF4BSTp/TLDJWZzV0Ngx
 zd9bh6Cl7lclqOG7+h/bEqIvXpEitSc7RqE49/YLryIfFAcXoAMdppfBDT8OW8mRbBRmUYQ4944
 Lu1WQGa22X79ldmVjYOpZRVu3EFWLa64Y5G80S9Z0ckLPk39kuzWWnlBJ40czzmddPqMeuOfWIT
 CgWYrel6etIvZK4LEk78Fh25lnK68JC0suSK94FhLz85vEZJTd5sCHnEnoLHxwjYVCg4tFiTFGL
 WT6zaGE7YvYbo1+9dJkOh6Ly6Ngvn0139psiHimWgDMa9B3VQwf6VZsClrmkL8t2/6xpAsjH
X-Proofpoint-ORIG-GUID: CGOvOUEzau5LVonXWlOm8sK4kFeqG9dW
X-Authority-Analysis: v=2.4 cv=OvFPyz/t c=1 sm=1 tr=0 ts=6839aee8 cx=c_pps
 a=6mxpIC5auN2WNi9UCfUMZg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=Byx-y9mGAAAA:8
 a=20KFwNOVAAAA:8 a=8rWy6zfcAAAA:8 a=pGLkceISAAAA:8 a=bK-vPeuM_voH4AzVaZAA:9
 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_05,2025-05-30_01,2025-03-28_01
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
> From: Nitin Saxena <nsaxena@marvell.com>
> Sent: Monday, April 21, 2025 8:47 PM
> To: Jerin Jacob <jerinj@marvell.com>; Kiran Kumar Kokkilagadda
> <kirankumark@marvell.com>; Nithin Kumar Dabilpuram
> <ndabilpuram@marvell.com>; Zhirun Yan <yanzhirun_163@163.com>; Robin
> Jarry <rjarry@redhat.com>; Christophe Fontaine <cfontain@redhat.com>
> Cc: dev@dpdk.org; Nitin Saxena <nsaxena16@gmail.com>
> Subject: [PATCH v9 2/5] graph: add feature arc abstraction
>=20
> Feature arc abstraction allows rte_graph based applications to
> - Allow control plane to runtime enable/disable feature nodes.
>   Fast path APIs helps to steer packets across enabled feature nodes
> - Feature enable/disable based on indexes. Index can be interface index,
>   route index, etc
> - More than one feature nodes can be added to an arc and also provide
>   mechanism to control features sequencing order in fast path.
> - Does not require stopping of workers for control plane updates. RCU
>   mechanism also provided
> - Once DPDK inbuilt nodes adopts feature arc abstraction, out-of-tree
>   nodes can also be hooked (with no custom changes in DPDK in-built
>   nodes)
>=20
> Signed-off-by: Nitin Saxena <nsaxena@marvell.com>

Also split this patch as N patches. Update programming guide in  each patch=
es.
i.e No separate patch for programing guide.


