Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DE2CCFA04
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 14:10:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C0244028C;
	Tue,  4 Nov 2025 15:10:22 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 1F42040269
 for <dev@dpdk.org>; Tue,  4 Nov 2025 15:10:20 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A3NXDR51519495; Tue, 4 Nov 2025 06:10:20 -0800
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020092.outbound.protection.outlook.com [52.101.61.92])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4a765rt684-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 04 Nov 2025 06:10:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sibx2eHa236v/13kD4REh/DD5eZ2rGgGpSlwafNBPEWcElQykS7mh1WgBeyOYEvp11SjkrGRa8eqQyVRXEIfpmdF9++3Jy/f2ujRvkHMjn158VKoKBb13Vu53CPPKDAtI8iTN/q1D1gJdLYOMxY+ToQ0KXculp3SR0mhUohcM4yP3pSQu3xMN1Ln+boicnr+yFjHBGIGg+VNvHGJNB5wF7Aj2fOZsQasJMICBhuHmhz0CGuo+la0Bz28dvzOWuwp84gdU3sTVCpVdGG/vIKeLR8eZu0b8hHc2Yk5lUzB6tUkZpgM44ZwK/XEmdVWyiiChBd1A3tGUYgWLheIh8KSvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrNhuypiaC1nKdb8croNX5+XLU+Gy/WEL9xaya20h+o=;
 b=ghJ/fKaAGvWFD1DFFwWnsI9c70M2Ho4LDiK0dnI9JwNAMCfBijDs9mk8vOMbpmIgh/MbCdMEUFgK9mPOyvg+9XvFrMoxblC3RWJOcBNbtXCy067nEwZOhvEw1rrfzFdQdBi+k45hgheX3rU0gA/aUbQyVlhj2hdLbn04wBlTOUBapXf+9CmoFxqbcsF3rXf7WUu13MdXkW34FPBnecEPtnzvr2LX+IeXCGaJhvMxxo6j98HTnE+wqjf1L9M+psh7hxTxVD2eu6plgiLmlcA8Em3Bw/WZMzhHm24SlLEe1Ov9ooc82LTEqaRVJ54X31yrK6PO72NOR1OaYOT4pubRcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrNhuypiaC1nKdb8croNX5+XLU+Gy/WEL9xaya20h+o=;
 b=FI15d2OODb8/3SlQL3CocpHu2UCZsOxcYHae+TMus1ZavgCGCK6VIK84/bLZGdewge6+4n+15smoemFAiQSjtYYmVtYIM2Ca1R341GvX5+MK+Q4+yhiFZQeec/YqgLutx3HpY/4VFJjku8U6ntkwo/lHlX7qo86fNBXbUkpVbsg=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 LV8PR18MB6003.namprd18.prod.outlook.com (2603:10b6:408:230::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.7; Tue, 4 Nov 2025 14:10:18 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%2]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 14:10:18 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Thomas Monjalon <thomas@monjalon.net>, "dev@dpdk.org" <dev@dpdk.org>
CC: Matan Azrad <matan@nvidia.com>, Ori Kam <orika@nvidia.com>
Subject: RE: [EXTERNAL] [PATCH] doc: add NVIDIA SuperNIC devices
Thread-Topic: [EXTERNAL] [PATCH] doc: add NVIDIA SuperNIC devices
Thread-Index: AQHcSbPzO4uIHZsGJ0OiQsWZVH4UR7TilgsQ
Date: Tue, 4 Nov 2025 14:10:18 +0000
Message-ID: <CO6PR18MB44845F13DD68D951B13405E4D8C4A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20251030154250.3918985-1-thomas@monjalon.net>
In-Reply-To: <20251030154250.3918985-1-thomas@monjalon.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|LV8PR18MB6003:EE_
x-ms-office365-filtering-correlation-id: be98c664-26ba-4725-0af6-08de1babe237
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?RlBocmhMRXgxb2ZOV1FINlhBenhsYUpNOHRndHZvbVk1b05YcmxPb0ZWVmZO?=
 =?utf-8?B?TldGR2hMVmRpOGYrS3ZEbGg2M1UvNDBqZWJpRjRvN25TbXpUYTVHaTBwVHJn?=
 =?utf-8?B?N0M2N1lJa2tOSTlyU1hOVnkyUzNncEM5cUpPUnVqNnVRcE56SDZuc3Y4OG9D?=
 =?utf-8?B?MHNRTU8ycGFlREowa1FkMElNTXpacVVDbG1JUUZTN1VCWHNtajdHTzRJNmZl?=
 =?utf-8?B?ZFBFQyt5RGh1UVB6LytuL29UY1VsY292OWVTcXl5azVabTNlNzEybEp5VTUr?=
 =?utf-8?B?VlZzajlLaVIvR2NvV0NvUHJpZUMzbnZ0cnF1Z0E0bm1LbzVZYktzQ0FhY0xm?=
 =?utf-8?B?eFdxSTFTREdHNHhGRk5LSU8rVkppUlVqUDFqTWovbHR3Y2Z3ZFdDYmR2S1ky?=
 =?utf-8?B?Q1cxL0Z6RWswSHFFcWFMd2QxaWg0c0ZHRzNucGtKdG9uK0dQbysvNDU4c1dz?=
 =?utf-8?B?dnVOd2Y5bG1ERExMT3U5M0ovMmVnck80RWs1Rm9GTXFHZW9reWp2WEtJUHk3?=
 =?utf-8?B?NFQ1RnBUbGE1cmRzOGdOVFVqMjExenVkcDRVbzYrNWRWeGFjVW1KZlc0Y21j?=
 =?utf-8?B?b3loZ3hIcXBGUkhTSWtCR0Z1c014RWdraFV3N0piSHFuNWQ2ZWh0ekpGT3ZV?=
 =?utf-8?B?SkV3Z2M3ZGU1M0dTL3Z4UkE5aUszbEpXRkx3RE5CL1pnRzJzZmxxM0xtQjFE?=
 =?utf-8?B?ZGhmZHNLekJLVVVHUXQxL0g3RitMRTJ6TDVQRUdxYjBoeHdpOU8zSkU4UmdL?=
 =?utf-8?B?WjNEdFl3UUFWZkpWM3VoQ2d6ZXRRUEkrK0l3UXM1bTRTZ1hkN0x6MlB4U1Zy?=
 =?utf-8?B?ZlJsUFZQNXlaSGczWFBRM2FHQWlodW9WUWVmUGRpWFEydm5jNUttaUhTOUdN?=
 =?utf-8?B?NWJyc3Q1Z2g1OUY5VlpnNmQ3elZKRlg4UWFwOXNqSWpnTDQxSk9wdFE2UlI2?=
 =?utf-8?B?YktLbFpBRlR4dkdnaW83cTVtRXNUMFRaRVVxcDF3VEtiY21rV1J0NlFTdDZh?=
 =?utf-8?B?UWxmS0ZRcVpKdnFmcmFBVHJ5T0NmMzJKZFV0bnFaWVllbE5IYldZenVnUDIw?=
 =?utf-8?B?dTAzUDEveEVRMTBzUEtuRFlFWWc2U09jMjRSaERkN1h4a2FLejdhN29vYUE5?=
 =?utf-8?B?YWhJY25oeVd1ZytjSEJkUVBCZ2c4aWdaaHJUN3ZXdnlpZlo5dkdJdElMR0tL?=
 =?utf-8?B?UU5aaXRMWHRaVmY0MTh6eExEWkovN2VnaGVTSmN0Z0J4WWNRK1RlNExxUXpM?=
 =?utf-8?B?KzgrY3JIODhWMytkSTB0Uy9XR0Q4Wktaa2oyUnU3VVZJMHE4Z2Z5dXBhRlpL?=
 =?utf-8?B?NXFmMVVBZXdqNHp4VWp5Y3ZKRkwxKzAxbm1NeHRPOEdZUDBwMW1QSkx3MmhG?=
 =?utf-8?B?Q2duMjI2cVREVXcraS9YNEsyVlVOeTdUSWhkZCtiQURwcHBFVjBHUXRUU2tl?=
 =?utf-8?B?UU9kUUxxeVhXMzNwQXdpT0tJWnJKbVZSdEViN1pvWkJTSjZwOU9ZVkdnSUlY?=
 =?utf-8?B?U3Y4bTNraFZTTlVOVHc3eElHa25ucU1XODMvcXJuUlpTQnpDZ0JrdHdlRGxn?=
 =?utf-8?B?NUpTa0F2bGdWQktHaEJlU0pzUXB3V2hUOGtOQXdlYkszNUhVZW5HRFYveUVT?=
 =?utf-8?B?MXNUTWpHT1F1Y2pHUnNjWm9QZnh1S1pFS2w1TWhhRU5zN0JQSzh1aTdvWEY2?=
 =?utf-8?B?RHdpUExsN1N2eHNsb3BhbTdwanJlT1ltTFZOMzlKVXNZWG8xcitNSzBrdVBE?=
 =?utf-8?B?dXQ4bVJocUltSEtiZFAzNFhzSDU3ckRESU96YmdIcm5JWDhnSUdIZnlMVnZj?=
 =?utf-8?B?R2tmSTVyeXVUdlg5dURrdDYrU2tla1RQYUF2UGllOHpNNjg3d0h0cDFhTmNw?=
 =?utf-8?B?VnVFU1RtbC9EejZVYjZwUnNrUm1RbldRY1Y5TE52R2xZbXhNOHFyMW1xUCt6?=
 =?utf-8?B?RW5VRmZZdjh2empVUG9lWkhoKzBIUGRSazJrTVoxbVFESTRxYnhkWmN6eWd5?=
 =?utf-8?B?K3VtRDBNaC95QnZSMWRNUWRFdmJOKzU2RkI5OUtPZ2lTTDgvOVRVMGhrYkdY?=
 =?utf-8?Q?WZlh+Q?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1o0S0tzZnYwWFovSEhHOUZOd09MYVB0QXdLazQzZVZ2SHFjeUtqdU9hODc2?=
 =?utf-8?B?eWlJS2l1bEVWek9haXZIaGZGVE8zc1RzcmhrcVlIbkp6Slpzc1IxNU1vWWRG?=
 =?utf-8?B?SFZjRlNQUEZTUkY3blZHdmMzVldOVTIyRTZjNEcycUZ5VWllenFjN2Jab1Ew?=
 =?utf-8?B?aWFkdk9la2RTQjFMTm5pYktERG9WSCtjZDVCMlQzMG82emtCcGF6ZlZyRm0y?=
 =?utf-8?B?Q1MwM3VSQU4xOEhzbUw0T1RrR0NhTUdxRE1JOFRjdjNoNUJrcXRqZ0JaWjc5?=
 =?utf-8?B?WDlOWVNZVWpyZ05vWkplVXhQZHd6UHFQUFpVR20zZDFrS0lFcE00eGpac1oy?=
 =?utf-8?B?MTNjS0ZUaW5uY01uVkxUTlJGNXZhcVJSL2VtMjJISFcwUDJveGlWTUVXWU4v?=
 =?utf-8?B?TjduQXpjT2xWb0NhZVRWazNEMTlPalFDNkhHRHBBdVN4MjVpR2RQeXY5Zlly?=
 =?utf-8?B?eUlvSE1ZSnNpeFJJT0QvWlV5V2xuOUw4VndGTGZ0dlZuTXBmNHp0eTUzRUxQ?=
 =?utf-8?B?KzdnS3ZGckZ2OGkzRWJoaG1BbmlpRkdLaWtjQlc4am04cUNlMUtwUVB6Z1h0?=
 =?utf-8?B?cXFDRlAxTDVJdjBlY2VaSDU1Y21meWwraDJwMzJUSElueG0xWVRBMWpJWGVL?=
 =?utf-8?B?N2lwZ3RCNjdQdE5OZ0UyZ3JOQlJPQm52a2tqcVhxUTRDdnVTa3IrRVZXbTNj?=
 =?utf-8?B?OWpOaE9BOVNZRldxUnZiYlJEcG41Vk03TC9LTXl4QzJ2OUl4NnJraDJTOE13?=
 =?utf-8?B?N2xxMkNwbUVlaVJJeXQ0d2Q3OE9LSWZjTTJ0NVpheTBsZlF0MkdXdFFlaE1h?=
 =?utf-8?B?aUV6SVA3ZkN3VUdoQ3hXb1lyUU1FQ2d2Q2tWOU8xYXlxbHYwUjh6QTZYNVpl?=
 =?utf-8?B?dkR2N3JXTEF0SlRVbnZUVWZSWkowWU1jbkNYYlpZWm9pcHkyZkkyY0N3OGtt?=
 =?utf-8?B?dmFyUDJpbldhNTMvWGlTbGFZSUlpQys2c3AvSVJTMFpaT1hEUGIybGZmSGI2?=
 =?utf-8?B?K1NlRDExeUt6czBMcjVrY015YSt4WFg5QnEyb2JuWDFRc1BlUUIxOGhVbFV0?=
 =?utf-8?B?bW1jU1UwaUk0Y0E0R0NaamJKVUorZ1ZvWG1kc1ZnNnJmRzVPeVdoM2NQNUc2?=
 =?utf-8?B?N1RoVFlBLytFN2Mxemo0ZTZqSDNNQi9hd1VnSUlZeENzVXFvOE9CQk9lQ1ow?=
 =?utf-8?B?Mk5LL0lKd3ViaGhyOC9KOXh3VCtkZ3ExVjVwTXJmZDRiZkI4MG1zS3MzdHVh?=
 =?utf-8?B?bTJ3aEhKcmN6RzJQdVF2NkEvWG9EUlhwRnlDU1Z2eXdYQW9UMGxYZWN5MUtD?=
 =?utf-8?B?VXlBcXRQOFNVVHZaRERmOEQzc2RqeHlRSXBuQmZHcWFLWDRsdU1pUjZCMHYy?=
 =?utf-8?B?ZlJ6RHVMVFkxNitkRTBrNktQTFY0RlU3UGtuSlIxNytGOGVOK2VZL1RMVmx4?=
 =?utf-8?B?M0RrWlpMY3FFVXhMdE1FUzNsbk1rODMvRlVZMDNwRnpHK1RQRS9JUS82QTNa?=
 =?utf-8?B?czdXZHkvR2JsajYxbFVxTWxnUFhuTzFsbThHNnBodzRtSjB4ZGJReDJ1MWM1?=
 =?utf-8?B?cFdSNlE4WnBBZ1FvMDdlWCtha3lha2RtVVdLNktwOWlpTnIrR3RJZmpPaTFQ?=
 =?utf-8?B?MDIzTmNvZlMybHpCczEra3ArQ2RFOTdZSFJEQmpnQ2k1K21GN2o1TTNSS3h1?=
 =?utf-8?B?azVuMjEwTVlReFQrY3RpREc0UTcrRU5JZlU3clBQV2VxM21xWXIwNTk1S1Uv?=
 =?utf-8?B?aGFpd0VWT2tFajZWc0EwRXFuUGZvS0YzM1lsdWpUaVZQNkYxR3lycVYxbytT?=
 =?utf-8?B?ME1MZUlMdXV1bGhvV09zTEtFSEphZWh5c1pmaDMzdkRGWHFLaDFTeEpuSmFZ?=
 =?utf-8?B?cG1PRENYa1BlbXg2d0ZyVWJtRGovQk9yMXhkV3BWRkdleEVhL2I4RTNITlAr?=
 =?utf-8?B?UnVyeVhIZElGTmN5YktTR3l5U0tVMnhBNWlRMk1Ka1FRbG1xY1Y3bTVnSTZi?=
 =?utf-8?B?blFPbVJ0LzdaME1pQXB2bFRMbHZ5elcyYUE2dElCeVlFZGFHdFo1NnI5eU5q?=
 =?utf-8?B?Vi9aU0ptQVNudmRjMEtHdEt4ZXdsOWMwc1VqblpyL3lpaTBCME53NmtQNVg5?=
 =?utf-8?Q?UX8M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be98c664-26ba-4725-0af6-08de1babe237
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 14:10:18.1201 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vhUdqJAIurxnLdNB9ucVF5JpusZkPIBcRIBJ3AXlzsIGyzWCP/LvrpW/LtBrJ+M+Zohb00vwisnB25NbhL+cFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB6003
X-Proofpoint-ORIG-GUID: dt5--b_g1uJ7SLOi3sITv1a_KSRGite5
X-Proofpoint-GUID: dt5--b_g1uJ7SLOi3sITv1a_KSRGite5
X-Authority-Analysis: v=2.4 cv=P4Q3RyAu c=1 sm=1 tr=0 ts=690a094c cx=c_pps
 a=wB9IvHZoU+EKUwdn4J6Xfw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RpNjiQI2AAAA:8 a=bt5KbKNvAAAA:8 a=dclAjEfm_hoA6EKLl4UA:9 a=QEXdDO2ut3YA:10
 a=a-zEBD5cKgE7DNtTSb7C:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDExOCBTYWx0ZWRfX6/RV2tW2ac0s
 9Ny2ahVslBUbm8RfNJQaakT3g0xwTyaND9jHwVuELz5kupa6rqgpceKqi9Gv82f4hdIhpxXuAuM
 G+8G5kR9y0x3RMzcaiK2Hl+HDhX3jmQ7EO3NlQqZp2T2tsZ01o3CTzklBQNoHAm5YT07m6XsdYe
 0osVp/meBaMvOd43neXg5oaEn87jAwnRwOkshqXpErRa8amQnxV9KLWoWSSvG+Zy6oezlCHsvaq
 XWWt1UNGoe2J80n7Uxc7cMmtw9N73KkYr/JNVRYunpwis7HaNiHGlhp6fpWy39N3zXs/+L4FIKv
 zfYQFIR86nE+bhfLSnFa7NnfJIPBWUilMxE45N/olIeX9+XeMKmAR1U+6JMpgut1NJ9+3Y/RBIh
 fKnl4oo9jxIukYGcJGr+LUpm15Fn5A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_01,2025-11-03_03,2025-10-01_01
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

PiBTdXBlck5JQyBkZXZpY2VzIGFyZSBkZXNpZ25lZCBmb3IgQUkgd29ya2xvYWRzOg0KPiBodHRw
czovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0cHMtM0FfX3d3dy5udmlk
aWEuY29tX2VuLQ0KPiAyRHVzX25ldHdvcmtpbmdfcHJvZHVjdHNfZXRoZXJuZXRfc3VwZXJuaWNf
JmQ9RHdJREFnJmM9bktqV2VjMmI2UjBtDQo+IE95UGF6N3h0ZlEmcj1Ebkw3U2kyd2xfUFJ3cFo5
VFdleTNldTY4Z0J6bjdEa1B3dXFoZDZXTnlvJm09c29Mdw0KPiB5NDdZMzhzM0F0a2xUUnNwZHo0
dC1OTzgtLXk0WUZoOVMtDQo+IDE5OWZGbnZQSW15OWM5YXdWWjVxTVhmWXI2JnM9ampFRXFGc1Vy
QVpkcUp5WTdYM2dTcVc2dERsYVBIREF4LQ0KPiAwTThMMllUWUkmZT0NCj4gDQo+IFRoZSBsaXN0
cyBvZiB3ZWxsIHN1cHBvcnRlZCBOVklESUEgZGV2aWNlcyBhcmUgdXBkYXRlZCBhY2NvcmRpbmds
eS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFRob21hcyBNb25qYWxvbiA8dGhvbWFzQG1vbmphbG9u
Lm5ldD4NCkFwcGxpZWQgdG8gZHBkay1uZXh0LWNyeXB0bw0KDQo=
