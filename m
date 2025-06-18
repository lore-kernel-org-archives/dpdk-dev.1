Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3E7C7115A
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 16:04:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15D8E427C7;
	Wed, 18 Jun 2025 18:04:55 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id BFA00427B1
 for <dev@dpdk.org>; Wed, 18 Jun 2025 18:04:53 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55IFAcUi015258;
 Wed, 18 Jun 2025 09:04:53 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2090.outbound.protection.outlook.com [40.107.223.90])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47byv504ug-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Jun 2025 09:04:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q1CXHKKnxVm+F/tCYu4M0VqSCvfxzQpVXLyvLViQ05VyaHOyhoEf+Bfkn9poJez996yNeIdOdih0WvsM4M/RzSzLMcQLXSJTshdxaRW+qSNwk5FAHiLOqU0BZpfBCyqeK4eiYu8O7G1F1hpfhJ6/uGfCUk80HQmBP96vWXdNM1fx+1MVtOTRx7G2BoFUK2lpwLWXjKZ5XFzwTNdI59iqPKe42orMnOk6pxfsAwBl8ok17C5Pa5sqostUeBuubxT6/Cw/oZvKqRI/JMaSmwjNXCXeOfpSURMhKa5/odU1paNs8yUGWSA6pYOZUYYYF9DyUDeQ7U2/AhzDNoE68VDr6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXKsANSFS7gzYVqyo1C0xzAjBFkQHb1g3lDGALvBnP0=;
 b=oJK9PA0PoeZZnjTqGxABYB/zKvhC75B7n9S4nGrl1zWbi9e5fn35jIWtc3l81T2A/h7XkZAT0yVRp3FATAAZF31tDX05yebsxC9/iPtDdB1g67LC9RMumRMPBKXFE/L3VGh2FowEm3wqwq9RnjqALbZiIBDcsowHoQdW61zMGm2irHyROdI67D34vrLnyv4Y7KLojRmfFVVGH6DEws2YRAnFgwf+4p3b9Fgio9Yazs/CU2Bt/xlNBU1iofRxLdzNN8zkyVP8NJZoQZkDeKT6YyFQp2SaLVtXo52KDA+TSCjp/0p4MxNnjOUaGDrPfL7G6udF5fzQ3kimw8tAU9vgBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXKsANSFS7gzYVqyo1C0xzAjBFkQHb1g3lDGALvBnP0=;
 b=D282B772BqyMwx2CLYlKLeBlbp3HQ46mkwd7ttPLzOaD4WKWuGrRMzicBAPsONjrxv4AnaQ58KnVF22ueYM8Ix1Ya+gb3ZzT3eQnvUcxzo/ERxI1doWicI7ZKPhCyM3qGvRK8CIC2aMi15153YQeZ3IR2GLwlSUKQq04X2RI26A=
Received: from CO1PR18MB4714.namprd18.prod.outlook.com (2603:10b6:303:e9::18)
 by SN7PR18MB5315.namprd18.prod.outlook.com (2603:10b6:806:2dc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 18 Jun
 2025 16:04:49 +0000
Received: from CO1PR18MB4714.namprd18.prod.outlook.com
 ([fe80::26fb:729e:a947:3e06]) by CO1PR18MB4714.namprd18.prod.outlook.com
 ([fe80::26fb:729e:a947:3e06%4]) with mapi id 15.20.8857.019; Wed, 18 Jun 2025
 16:04:49 +0000
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: "Ji, Kai" <kai.ji@intel.com>
CC: Anoob Joseph <anoobj@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>, Akhil
 Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Shally Verma <shallyv@marvell.com>,
 Kanaka Durga Kotamarthy <kkotamarthy@marvell.com>,
 Ayuj Verma <ayverma@marvell.com>, "Kusztal, ArkadiuszX"
 <arkadiuszx.kusztal@intel.com>
Subject: RE: [PATCH] test/crypto: fix RSA decrypt op validation
Thread-Topic: [PATCH] test/crypto: fix RSA decrypt op validation
Thread-Index: AQHbwZiacBxVlAhw+Ua/Z0S4WXpd/bP/gQsAgAaOmICAAzVMsA==
Date: Wed, 18 Jun 2025 16:04:49 +0000
Message-ID: <CO1PR18MB47144653AC9A8DF6E8B1C697CB72A@CO1PR18MB4714.namprd18.prod.outlook.com>
References: <20250510104452.2186-1-gmuthukrishn@marvell.com>
 <CO1PR18MB471468B21DE770926E149839CB74A@CO1PR18MB4714.namprd18.prod.outlook.com>
 <DS0PR11MB7458F54FAE4573EEA5D30AEF8170A@DS0PR11MB7458.namprd11.prod.outlook.com>
In-Reply-To: <DS0PR11MB7458F54FAE4573EEA5D30AEF8170A@DS0PR11MB7458.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4714:EE_|SN7PR18MB5315:EE_
x-ms-office365-filtering-correlation-id: 67ae25a9-2de2-460f-bee0-08ddae81da34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dE1rNGdzNVhzREFkVEF6bFRSaEtBRnVCTWEvUDJMOFBQZjR4d2Q1bUhRbE00?=
 =?utf-8?B?eFNxQmNWL3l4cll2RlRmUzFhckhNQ0x2c1NMSjU4QkY4bGdRTXNOVnJNZkN5?=
 =?utf-8?B?cVA2R3FkZDlNRXNDZ25naVdLTmk2dlBlR3dMeXVpNkJiNlJtU2lTZDBWVzB6?=
 =?utf-8?B?N0ZGOHJYb25TUktrUTA4cE0yWnpEdTdBVWRjSytHbE9GY1MveEU0M2NyWllN?=
 =?utf-8?B?ZWNmQTJPZnlEUExJZHY3Q25pcnltbGRCSmhFdHNXdTRGcjdvR096N0tvNC9n?=
 =?utf-8?B?LzZzeUJ1NVBndk1oMnlob2tVaVNPSzFHVFZmYVZHQktVWldJNXJZQXB2cEhj?=
 =?utf-8?B?TFc4eUM5KzQ5c0tVeHo3eTlvVVRRM0N6bDg1Q1hUMnYrMC94SlVHdHhmY21C?=
 =?utf-8?B?Y1JrVEp2K0REejBUR3ZxVG1pRnZDNWg2RmFxcEhpQnJ0Wk8ycFg4emdjcXpP?=
 =?utf-8?B?YjN0WVp1a2N4blAxamkyNSs5VnNoZ1pQakJ0VEpvTS9oa0V2cWd2MCtMQk9K?=
 =?utf-8?B?Y1FLeTBEekh6UTlibzAxOXFKUkpyTEpCYUhjMnl5WWpLV1U0WW1RS3VKaVBa?=
 =?utf-8?B?bDcvVGQyd29Rb09RVUNQTHcxMXA1L2NKdkdjdjYwamEyQ0Jrb25aYmMwYjNT?=
 =?utf-8?B?ZWxZMGw0Y1NqY2c3NnNOZE1pQ0pFRG9iRHJZREFUVzF0Tm1OVXE4dDhmVjVI?=
 =?utf-8?B?N2FoUjg5Qk9xcHJ3R0dCN0JBVDk5VlUxd01hMDAxTzNXcjl3Q21JQmthNkVo?=
 =?utf-8?B?MUdQNGU2L0hML1U4SHJnM2VjZmc5Zmk3cGtHNElBNUxMU2FQS1owMVQvNnFS?=
 =?utf-8?B?dSt6amVyS3ZhT3d3cFAxdG1zdU4yMDdPb3hwd2RjdjlrZS9DaTdrZlZHeDUv?=
 =?utf-8?B?SUFCS3BMS210WDZwRkt3dm1WMVVhS0JFUEZFQjZkY2dXcG8xcUtWeVphdFk1?=
 =?utf-8?B?Wm9HZ0N0c0FIay9VbFV0K3Z6eGUwUmVHc1BzSno0TGpaRm5DdFFVVmpYcm44?=
 =?utf-8?B?dlprR25QbkRpZGsvSnJFejVFWnNvUm5sNk9TU3JFT0dxRzhHazh1ZVBZM2F0?=
 =?utf-8?B?Wnh3cHdDYlZMZ0F3bVlUMDhMMW9rbDRYRmpaaHM4REQreW5kOUkxZnYwOThI?=
 =?utf-8?B?YXkxcEZ2QVdReWx1akhCQWlIaVJGTExoeFc0QlZpcXA5TWpVNVdGQVB4MTNi?=
 =?utf-8?B?TDlsc3Z0Q1JLM2U0ZW5VckZBRU5mNlR6QWo2aXBCS1dSNW1iMlFtQkZoVmlh?=
 =?utf-8?B?MVg0NFVKTmNQV3pMYTIwMmJJdjNsWGFIdVVMd1FZZUdxSk03V0tEcCtvYUZJ?=
 =?utf-8?B?VllUc09YenBWK29FUElUNDlQUE1sUEljT0NQZnNjbXNIWFI3OTAzVDlKT09F?=
 =?utf-8?B?bm9FMUM2VTM4ckNEWVV2U0dydUFjRTFkTFJxMjZoMlJjc2RQUmg1b3ZyQ08r?=
 =?utf-8?B?QzRCNUxTMTloUys1ejBBZnoyRzhRU2d6TWc1Z1VaVk9ucXdzbkhOV09lZXpr?=
 =?utf-8?B?M2hkdVRYektQczdOYzBONnVxUjVwQW1TZ0ZhOFYwK3pzdlJaUjkrZzJSZDZa?=
 =?utf-8?B?OVpxZE1QRDZQaWpPZDVQajFFQjBieDB5M1ZTVGxBS0plZ1ZTSERIV0pvT3FL?=
 =?utf-8?B?WUZWWmpmYm5VQmRPdVB4cVR1T2dLOFVsNVk3U1Q3cjhIcGVhYjllaktZMVNC?=
 =?utf-8?B?ejFEQlFMbUdCWCthM0FXdEd0SXJ4VzYybS9HUXBIbS9obWJmS3FGMWlFVHI1?=
 =?utf-8?B?bzlWV0drM3dEclJnazNzMzBmV2xyb2JCZ3o1eVR4ODRKdnROR3lXcG5FcGFO?=
 =?utf-8?B?SmJQNVB4L3gzcUFqOXgxMkRkQ2lZaUxab1lwTUUvUGQ3V205ck44Qjl1MXIz?=
 =?utf-8?B?aVVJbTFSb1N6QjBtRHlYQjgyZUw2T1JjUzN2MmwzdE1aR3FabDVrU3VRaUFr?=
 =?utf-8?B?UzN2WmZST01LOUNJQTRtQURSRXA1NjM0NHhVZkVES29XM0JhVGIyZFVxMjl5?=
 =?utf-8?B?U01CckxZWTZBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR18MB4714.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnloelNOamt3RDRtTjkxL0g5ZnUwcVlQSkdVY3daU0NENEp6Z0RXYUcyWEpx?=
 =?utf-8?B?V2R0NHJabThrZmJqUU9KbkdYOXdrNjkrangxNzRDM1N2a0NGVlpURFpSRzJU?=
 =?utf-8?B?Ymh0d2tpby9TVXo2WWNCUklVaGVKSzN4Z1RDcWVPNitPcTlYTmFVTHVpKzBp?=
 =?utf-8?B?OWcrWkU1dEEyM2JDSnVXcGdBbjNCb05vaGM0a1RSQzVMZXI0ZFMvUGdDTUh6?=
 =?utf-8?B?VGtuU3MxU1pmM1Zmc1ltRW5YMGN2L0lzWkRRbnBqdW9UVXNQNWxzMGx0RUhV?=
 =?utf-8?B?OEdmUGdwamExR20xN2N2Z2duZjB1QTJQNnJreFpXcHR1QkVocHprbmF2QkNn?=
 =?utf-8?B?VGxvR1VJWFNPODJjaWRkQkNPcUl3V3dNYlZaRHB3dm1ZY0EwaERaOE9GaCs3?=
 =?utf-8?B?bjRWTmlJTy9EQWZiOXkyWmoyM0hUK2JIUlBiaDVMOERIUGY0VERUVDdxeGxm?=
 =?utf-8?B?ZENwTjJjN3VSYUFPR3pscUgrWjlaWEpWcFE5ZWtoVnNibHhWdko0Y21hT3R4?=
 =?utf-8?B?bWZ2K1lMdDBONGRqL0dvSEJiSlV6TmpNc2ZyVG9pZFlLd0E0USt0bHVjQVhh?=
 =?utf-8?B?Y3lwRHk1ODJoMkNjYWtoNnlzWG04aCtPT29paEVqN01OZEJlRmRCTGJyb1ND?=
 =?utf-8?B?Q0UwcHN1eXNzRDVqMnZqMjc2N0pVUVZaRXZBVUQ3Mnl2dGJ3SjFpSDRGcWEz?=
 =?utf-8?B?NktyclhoSzFuOGlXK2hNYStXV0hoVGgwalZEYlZxKzQxZkxQREhkVUF0S0VS?=
 =?utf-8?B?NmxQdW4vSVZsYmJQZWY3YlVoMm42Q2pCQTVNS0dqWU4yN1pkc1g0VVRxd0J1?=
 =?utf-8?B?YXRidGx3L2x2Unh0dnJKRUlJVmRQU1pNMlhLSzIzSnNZVkgzdU0vWFY3UXRs?=
 =?utf-8?B?N09IYUFFUDArNzVmS0pVWFNLajgxemxpZzFmU3ZFTGd3KzhsaVpqVlVFbzFO?=
 =?utf-8?B?Ukd4WVNQU0wxMEV1RStvQ2NvUWhtNzdPU3hJSU1UUjR5ZHJpMTRMM0tLSitt?=
 =?utf-8?B?NW81S2JLWjJZNWsrUE5sdnhTY0xoa2U4Y0w3ZTBHRWxhSDBtQ2hpTmtjMlpi?=
 =?utf-8?B?VlZOYmJGQlRjY0ljSXJiVEN0QnUrVndnSFVOd3J5YTYwTjNTNXF3QTFmWUNT?=
 =?utf-8?B?QzZpZzJvUndqYytEbk1QU0QzUU9rUDg3TklGbFVxeHAwS3E5dXQ2aFUxcVJE?=
 =?utf-8?B?M1YvaWQxa3MrSk5mSWtTSWNpclVBNmFMMFJJL2ZPL3pEdDNaVFdwUldjQ1l0?=
 =?utf-8?B?UHFCNmJHT1FOL2VMbUljUVFJZE9MTC96SG52VTFWZURiUjdOSlE1d0w0M2JE?=
 =?utf-8?B?UEg0QnpxQjhyQ0xiYU0zUVZNaS83bERHL0pxclF1UHc4NlJwN3hHZkd3SGJO?=
 =?utf-8?B?SjQ2ckE3RmlhU204V1RrN25Za0FNM1UrUFBPNkZ3R1hpQnVIa0VYNlJqVktU?=
 =?utf-8?B?d1J5SUkwYUxDT3lHa1dZUUFuc3JraS96VklNNDhhblBDYmRVTHVtNXZZN1Vq?=
 =?utf-8?B?aHRhMGh4Q2dCb01HNUxiektKcGJJT2lyc00xSkRjcUNCS3NpMTdRSWdQOHhx?=
 =?utf-8?B?ak91VEc1eXVOdHkveW1FNXFmYytHUkRKN3VRMDFuaTk3aEZqZEFSZTVvR0hs?=
 =?utf-8?B?YksxcXF6YzFzVzNQbzRqc2RvWHlpUTNwK1gyTVJQa1FwOVdQK0RweE1Mc1hm?=
 =?utf-8?B?TE8rQWsvbVFQeXVsNTNhcjhlUm9mUit0WnhCNHMxMW52WC9XZnhDUngzVGdW?=
 =?utf-8?B?c05xK0hyendjRk5XNVM0L050WjI1bFVJYlBaazlPa21WRE9LWHFZS2NjU01B?=
 =?utf-8?B?d2YwU25pSytjZENRb1IxNTZEV0RwWDFJbnlobjdqNnNhOVpPcEtOU0U5SjBQ?=
 =?utf-8?B?QjF4UithR3MwWGpTR2wxTERMYUV1YVhabmQ0TUd3ZlZhYXdCWi9HSzErYTcr?=
 =?utf-8?B?SEx0ZDBjUXduK3F3Yy9rRjVGcG5CTFg5Tkw3UC9kSHU4cDJzK3I1ajVBYUZH?=
 =?utf-8?B?eldWVDh4WVloc3R0RUxWbTh4SkIreXZwY0RobUYxaGs1ckpuckdNTlgxVHNo?=
 =?utf-8?B?WlFubTJJOUJEWTBHbGt0SXZ1ZUlTV1NCVExFaGc2NFBSOG4yYVFHVkVnZGUw?=
 =?utf-8?Q?+f22SPvgfTxmqJpMZLHxoVAih?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4714.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ae25a9-2de2-460f-bee0-08ddae81da34
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 16:04:49.1352 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2okMppAMAH9br5uASKoQmBr6X2GV/WDM6juLmNFQCC489uoWXnlQI44Z/QDi20NXr8HYnI/Y2bXeqyliqTT8Pe12Yrjohe1UJYTuRmOK8PQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB5315
X-Authority-Analysis: v=2.4 cv=HJ3DFptv c=1 sm=1 tr=0 ts=6852e3a4 cx=c_pps
 a=bhNPPQ3SK+T6udONALcAfg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=QyXUC8HyAAAA:8
 a=8rWy6zfcAAAA:8 a=pGLkceISAAAA:8 a=TxBTbgnzu7oP7u9pAl0A:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: Nyu5W_TNjImj8Mjz3njGWtkGIcfmN6tw
X-Proofpoint-GUID: Nyu5W_TNjImj8Mjz3njGWtkGIcfmN6tw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDEzNiBTYWx0ZWRfX4xR8BFcwCESk
 A2OLTTXr2dSFiJ+H4cPxthbcFxmxdooQ0lKWOIY+VuH01Pl8TmYHqKNX1bU0FzsNPE57XpojW+V
 Tvm8sF01pbRVmNFQ5CNyJ2bhN/y7yidqv1MlFS6FtT4QCKh4OxB5YWex21QhLjbzSJmjz8sbsL0
 s05hadIO9eyngkcwZF+nEwLGa88LEaw/XgpeyNJfnDSJMHAQZz1YEJfgxsmQ+zeUBDQ2L6I8kxG
 IL5q5klkutXeJ1qfA5O1TnpEv4ZrGoilFWy4YmGxGpX6MuPKiKGHJhIEF33avOJ1yhimJ81D6Ur
 /H3YNkIQrfTo7SRVDRy6kbVXA4HVT9Y8fATz2ceoMyBEW/4WpEQ4p775xw1bL8TimRmkMG8/Ipu
 XUL2hJYsvy0iqf2QaYQ0F9Av/4S5ymn9tRQEiaGDMVHdD89wq8wYq5HMO5gw04dg+syfIp+f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_05,2025-06-18_03,2025-03-28_01
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

SGkgS2FpIEppLA0KPiANCj4gSGkgR293cmlzaGFua2FyLA0KPiANCj4gVGhhbmtzIGZvciByZWFj
aCBvdXQsIEkgZG9uJ3QgaGF2ZSB0aG9zZSBlbnZpcm9ubWVudHMgc2V0dXAgb24gbXkgZW5kLCBi
dXQNCj4gVWJ1bnR1IDIwLjA0IGFuZCBSSEVMOCAgYXJlIG9sZCBidXQgc3RpbGwgY29tbW9uIExU
UyBwYWNrYWdlcy4NCj4gQXJlIHlvdSBhYmxlIHRvIGR1bXAgdGhlIGFjdHVhbCBtc2cgYnVmZmVy
ID8NCj4gDQoNClJTQV9wcml2YXRlX2RlY3J5cHQgZmFpbHMgYW5kIHJldHVybiBjb2RlIGlzIC0x
LiBPdXRwdXQgYnVmZmVyIGlzIHVudG91Y2hlZC4NCg0KSSBkdW1wZWQgZXJyb3IgY29kZSBvZiBp
dDoNCmVycm9yOjA0MDY3MDg0OnJzYSByb3V0aW5lczpyc2Ffb3NzbF9wdWJsaWNfZGVjcnlwdDpk
YXRhIHRvbyBsYXJnZSBmb3IgbW9kdWx1cw0KDQpXaGVuIEkgdXNlZCBzYW1lIG9wZW5zc2wgbGli
cmFyeSB0aGF0IEkgY29tcGlsZWQsIG5vIGVycm9yIGlzIHNlZW4uIEFsc28sIHB1YmxpYw0KZGVj
cnlwdCBmdW5jdGlvbiBpcyBjYWxsZWQsIGJ1dCBpdCBzaG91bGQgYmUgcHJpdmF0ZSBkZWNyeXB0
IHRvIGJlIGNhbGxlZC4NCg0KSkZZSSBlbmQgb2YgbGlmZSBmb3IgZnVsbCBzdXBwb3J0IGFscmVh
ZHkgb3ZlciBmb3IgdGhlIGFib3ZlIGRpc3Ryb3MuIE5vdCBzdXJlIGlmIHRoZQ0KT3BlbnNzbCAx
LjEuMSBpbiB0aGVtIG5lZWQgc29tZSBmaXggZm9yIGFib3ZlLg0KDQpUaGFua3MsDQpHb3dyaXNo
YW5rYXINCg0KPiBJdCBpcyBoaWdobHkgcG9zc2libGUgcmVsYXRlcyB0byBkc2l0cm8tc3BlY2lm
aWMgcGF0Y2hlcyA/IFBhZGRpbmdzID8gT3IgY3J5cHRvDQo+IHBvbGljZXMgaW4gUkhFTCA/DQo+
IA0KPiBSZWdhcmRzDQo+IA0KPiBLYWkNCj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fDQo+IA0KPiBGcm9tOiBHb3dyaXNoYW5rYXIgTXV0aHVrcmlzaG5hbiA8Z211dGh1a3Jp
c2huQG1hcnZlbGwuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgSnVuZSAxMiwgMjAyNSAxMTozMw0K
PiBUbzogSmksIEthaSA8a2FpLmppQGludGVsLmNvbT4NCj4gQ2M6IEFub29iIEpvc2VwaCA8YW5v
b2JqQG1hcnZlbGwuY29tPjsgZGV2QGRwZGsub3JnIDxkZXZAZHBkay5vcmc+OyBBa2hpbA0KPiBH
b3lhbCA8Z2FraGlsQG1hcnZlbGwuY29tPjsgRmFuIFpoYW5nIDxmYW56aGFuZy5vc3NAZ21haWwu
Y29tPjsgU2hhbGx5DQo+IFZlcm1hIDxzaGFsbHl2QG1hcnZlbGwuY29tPjsgS2FuYWthIER1cmdh
IEtvdGFtYXJ0aHkNCj4gPGtrb3RhbWFydGh5QG1hcnZlbGwuY29tPjsgQXl1aiBWZXJtYSA8YXl2
ZXJtYUBtYXJ2ZWxsLmNvbT47IEt1c3p0YWwsDQo+IEFya2FkaXVzelggPGFya2FkaXVzengua3Vz
enRhbEBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0hdIHRlc3QvY3J5cHRvOiBmaXgg
UlNBIGRlY3J5cHQgb3AgdmFsaWRhdGlvbg0KPiANCj4gSGkgS2FpIEppLA0KPiBUaGlzIHBhdGNo
IGFkZHMgYSBjaGVjayBvbiBjb3Agc3RhdHVzIGFmdGVyIERFQ1JZUFQgaW4gZXhpc3RpbmcgUlNB
IHRlc3QuVGhlcmUNCj4gYXJlIGZldyBDSSBmYWlsdXJlcyBmb3IgdGhpcyBwYXRjaCBhbmQgdGhl
IGZhaWx1cmVzIGFyZSB2ZXJ5IHNwZWNpZmljIHRvIE9wZW5zc2wgMS4xLjENCj4gdmFyaWFudHMg
dXNlZCBpbiBiZWxvdyBwbGF0Zm9ybXM6DQo+ICogVWJ1bnR1IDIwLjA0IC0gT3BlbnNzbCAxLjEu
MWYNCj4gKiBSSEVMIDggLSBPcGVuc3NsIDEuMS4xaw0KPiANCj4gV2hlbiBJIG1hbnVhbGx5IGJ1
aWxkIHRoZXNlIE9wZW5zc2wgdmFyaWFudHMgaW4gdGhlIGFib3ZlIHBsYXRmb3JtcyAodXNpbmcN
Cj4gRG9ja2VyIGltYWdlcykgYW5kIGV4ZWN1dGUgdGVzdHMgdXNpbmcgcmVzcGVjdGl2ZSBvcGVu
c3NsIHNoYXJlZCBsaWJyYXJpZXMsIGFsbA0KPiB0ZXN0cyBQQVNTLiBJZiBJIHVzZSBPcGVuc3Ns
IGxpYnJhcnkgdGhhdCBpcyBzaGlwcGVkIHdpdGhpbiB0aGUgYWJvdmUgZGlzdHJpYnV0aW9ucywN
Cj4gdGhlIHRlc3QgaW4gcGF0Y2ggRkFJTC4NCj4gDQo+IEkgd291bGQgbGlrZSB0byBnZXQgeW91
ciBvcGluaW9uIGZpcnN0IHRvIHByb2NlZWQgb24gZ2V0dGluZyB0aGVzZSBwYXRjaGVzIENJIGFj
a2VkLg0KPiBJbiBteSBkZWJ1ZywgSSBkb24ndCBzZWUgYW55IGlzc3VlIHdpdGggdGhlIHBhdGNo
IGFuZCB0aGUgcGF0Y2ggYWRkcyBiZXR0ZXINCj4gVmFsaWRhdGlvbiBpbmRlZWQuIE1heSBiZSB0
aGF0LCBpdCBoYXMgdW5jb3ZlcmVkIGEgcG90ZW50aWFsIGZhaWx1cmUgaW4gYWJvdmUNCj4gRGlz
dHJvcy4gQ2FuIHlvdSBjaGVjayBvbiB5b3VyIGVuZCBpZiB0aGVzZSBmYWlsdXJlcyBkaXNhcHBl
YXIgaW4gbWFudWFsIHRyeS4NCj4gV2hhdCB3b3VsZCB5b3Ugc3VnZ2VzdCB0byBnbyBmb3J3YXJk
LCBmb3Igb3BlbnNzbCBQTUQgPw0KPiANCj4gSWYgcmVxdWlyZWQsIEkgY2FuIHN0YXJ0IGZpbGlu
ZyBhIEJ1Z3ppbGxhIGFzIHdlbGwuDQo+IA0KPiBUaGFua3MsDQo+IEdvd3Jpc2hhbmthcg0KPiAN
Cj4gPg0KPiA+IEZvbGxvd2luZyBSU0EgZW5jcnlwdCBvcCwgc2FtZSBwbGFpbnRleHQgYnVmZmVy
IGlzIHVzZWQgYXMgb3V0cHV0DQo+ID4gYnVmZmVyIGZvciBkZWNyeXB0IG9wLCBoZW5jZSBjb21w
YXJpbmcgcGxhaW50ZXh0IGJ1ZmZlciBhZ2FpbnN0IHNhbWUNCj4gPiBidWZmZXIgcG9pbnRlciBp
biBjcnlwdG8gb3AgYWx3YXlzIHN1Y2NlZWQgaXJyZXNwZWN0aXZlIG9mIHdoZXRoZXIgZGVjcnlw
dCBvcA0KPiBzdWNjZWVkcyBvciBub3QuDQo+ID4gVGhpcyBwYXRjaCBmaXhlcyB0aGlzIGlzc3Vl
IHdpdGggYSBsb2NhbCBidWZmZXIgZm9yIGNyeXB0byBvcC4NCj4gPg0KPiA+IEZpeGVzOiA1YWUz
Njk5NWYxMCAoInRlc3QvY3J5cHRvOiBtb3ZlIFJTQSBlbnF1ZXVlL2RlcXVldWUgaW50bw0KPiA+
IGZ1bmN0aW9ucyIpDQo+ID4gQ2M6IHN0YWJsZUBkcGRrLm9yZw0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogR293cmlzaGFua2FyIE11dGh1a3Jpc2huYW4gPGdtdXRodWtyaXNobkBtYXJ2ZWxsLmNv
bT4NCj4gDQoNCg==
