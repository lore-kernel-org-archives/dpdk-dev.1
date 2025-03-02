Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50292C19F32
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Mar 2025 20:25:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43BAF40041;
	Sun,  2 Mar 2025 21:25:01 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id C4E154003C
 for <dev@dpdk.org>; Sun,  2 Mar 2025 21:24:59 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 522KHBIg018639;
 Sun, 2 Mar 2025 12:24:58 -0800
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4540fua4st-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 02 Mar 2025 12:24:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/LdVRr6RKDKcXw/WbzzmcsoWayN3/FMJ4oaoA3WML2NwsjWSrQy2aVc9fDv4PB+RfxmaX7HkdTJXMEhyWp2k/zGxe7oQrRR6yuEFwWakZcdEMaMtQxqaMB4SheoKemk6Me0W/OnCwDICmk9s5TIcjyyNYnAOyya1RnrP66EPUWd2/7+ubb3xA34xDUv8kqJdPXGovFYhwpQol4gHEUpM+69U7HXsEGfn5cSq7ev1OlJsi8DzQiLO+aZCqjZN9ZdnUFrSejujcgL72529zeKHwb3VK7izm8Q0Ea0qyVNQdQu3kmf4snWiHyT3xtMN8E9Tsyuw+cH/HwpVQjk/IPpbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UudmR2TlmhXiF+ELMt+X96hPQb9i9XhiMDRBFv5Y+WE=;
 b=v40Ttmwwd5NxveMEGBFUhmLIwMTpyhOyz59uQTJCbzevzMz8uOvignE82h6wrhLXFY50GgLdDtGC068exl/GcUylKUt9/0kY1FaSOHuqfnfCgascRLk3tcTr7mMq5m2cg9E1CsSP15rsExmWG/shRni3bRkZTsQpNRtFM2ipZT4P46alTivrFsmTqL2OlsytF5xhRcnId3cFJbktmddH5tUvGHCIEvuhzJtszvEK/xcV/Sgp08bvQ1M2VU/MiZY5khLC+TVQsr32AjUXgKdIm4IlUB4f1o+LS4q2cxIDMUJgh2nVjdYWbfULo2zRxQK6bNEDzvuEvIqpv+c2YQZ39Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UudmR2TlmhXiF+ELMt+X96hPQb9i9XhiMDRBFv5Y+WE=;
 b=O234pICp0FAMecvfUKkBH0ffcXTO4pQypwj0EAfGEhBUwEGxULmMLzu+xVXoE6XMoXxzSuYOgQTiaqcIdYSevnauYU2IrUvb9rOCLypZTiaFXA5BgfYWVKhVzgvWEErc5+zpk0VmeV6gF/ONG551msXQeuy8vWAquChZgb4tkEk=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DM4PR18MB5525.namprd18.prod.outlook.com (2603:10b6:8:17d::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.25; Sun, 2 Mar 2025 20:24:52 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%3]) with mapi id 15.20.8489.025; Sun, 2 Mar 2025
 20:24:51 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Yang Ming <ming.1.yang@nokia-sbell.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Anoob Joseph <anoobj@marvell.com>, "kai.ji@intel.com" <kai.ji@intel.com>, 
 Gagandeep Singh <g.singh@nxp.com>, "jack.bond-preston@foss.arm.com"
 <jack.bond-preston@foss.arm.com>, "pablo.de.lara.guarch@intel.com"
 <pablo.de.lara.guarch@intel.com>, "matan@nvidia.com" <matan@nvidia.com>
Subject: RE: [External] [PATCH v2] cryptodev: not close device when secondary
 exit
Thread-Topic: [External] [PATCH v2] cryptodev: not close device when secondary
 exit
Thread-Index: AQHbXY0K+NtcwPjXIUWyOW8EylNkurMMvLDQgEN3jwCAEHJ/EA==
Date: Sun, 2 Mar 2025 20:24:51 +0000
Message-ID: <CO6PR18MB4484C8347E8488A693953A66D8CE2@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20241128054829.1453-1-ming.1.yang@nokia-sbell.com>
 <20250103030957.1117-1-ming.1.yang@nokia-sbell.com>
 <CO6PR18MB44844F645EFA1FA6C852B11AD8122@CO6PR18MB4484.namprd18.prod.outlook.com>
 <2a825be0-cebf-4218-9e4f-d64b02bf2d6b@nokia-sbell.com>
In-Reply-To: <2a825be0-cebf-4218-9e4f-d64b02bf2d6b@nokia-sbell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DM4PR18MB5525:EE_
x-ms-office365-filtering-correlation-id: 7ec83d0e-fd3b-44ef-33be-08dd59c84994
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RzFuSmthT1NyZGY5TjZiNGYzTXVDelpLRVVXOE0vQllRNUV5cEpsdll5allv?=
 =?utf-8?B?cm1malR0YzIyTVhiS3lyQTk3TGFEd2dxQitmc0xLR3pxWW0yRjBOMEdrVGZY?=
 =?utf-8?B?Ly8wMEpFOHBqdkpaUnVSODBqUVcvRUpoNWJsQ0xrVWR2SXdyTnZxWlpBWVNZ?=
 =?utf-8?B?SVhNZ0lUeGRCQ25IRkZIcnl3bDdMNndaTUtXelJjMWFDRnRHT3hxSEgrLzNT?=
 =?utf-8?B?U2NUMjFIbk5oUXJlU0FGZEZCZE4wQnprdlEwRFl0MmoyUStGQi8wUDR1R2xF?=
 =?utf-8?B?SzdQRUxpN2NaRjNNSksySmswdk5pV2ZTWVVXcitTaUttejNKRjBRUWNBZHhW?=
 =?utf-8?B?NnVIL1RNTHdscDV2OTZtMDlUR1dVcVFOZEF0RTNGZm5PQnhBMU1yREZlMzRO?=
 =?utf-8?B?VXRKRlpKdDJSMXd4MUtMZFNHcmYydEVsU2JDVndKYjFzVmN4RW1LT1BVMUhn?=
 =?utf-8?B?ODlzbkxuOEdLQ2srQnJGZEpGY0dOZHZ3WFZCQWFmNlFZUDUvWW9YU0tjNUJu?=
 =?utf-8?B?bUFjS2FGdGt3MTl3cGNJWnVWVTNjQmtPVnMwMEJhZTJpR2RFYXF6by9PMWVm?=
 =?utf-8?B?Z0dESGp1c0hlV1U2Zy9FT1o0OE9Ub0JYN3dDTC95ZzFIZ2J0UjFNMkhwU09Z?=
 =?utf-8?B?NmxUaW5NSE9RbWt5ODZqcGlicm5MbkJ6ZVNjQXc4bG9XRTErbVF6ZGFzYnhO?=
 =?utf-8?B?UHpod09JZGNJZnRBZ3VTOThBZ0dYaXFiNjNzZ0oyeUZUTXdhMDVSdVlJV0hh?=
 =?utf-8?B?RkJzMkFvZHR6Y1hjNnNkYXRIUld0ak84dStPRGFrSnhzSm1NZ3Q3MzZLZGhw?=
 =?utf-8?B?STh4bENuZUdoZXMzZE50aUNzaFVodHo3ZmFFS1o3VENuREVHd1c5TXk2U29u?=
 =?utf-8?B?ZTU4Q2twME1jUU96amNIVzl2dnk5Qy82dlV6Yk9sdjlna2xKL1lSaHptQ2Ni?=
 =?utf-8?B?Um1KSmY2WFM5azR4Y0RnandReXZZdm15TjlVY1k4cWFIenoydUhKdE03aW96?=
 =?utf-8?B?SGdYeUliYkgwMnY2QVBEMjFIVW1zM1FLUEtOUmROV2ZwSzBWMVV5SEFkdGtx?=
 =?utf-8?B?RWxQREVDaHJpc25uK296Z2VqeGlWaGlNeHFZem5wbnpCYU1XTzZjbnlwdmZx?=
 =?utf-8?B?b3RtdEpMSVQ0OHFEQUxaRFFuNjVkUlZwdGE3SVhmQWVGSnVVdzZZQUtJRUpN?=
 =?utf-8?B?KzF3bnZFREJYN3Q2MzZTemdMQ1N4b0RqMngxWU9rbGlkaFNEWUpaU2x1WTcz?=
 =?utf-8?B?TjVRa25ENTdCRzMzN2Q1OXJWeHNWRlZKSTUrZmM3NTRFWEdrNmJqSFdHV1Fz?=
 =?utf-8?B?U3Q3c3F5azdwajFzQnlWRWxEcUNIY3hueGdMSE5zSXRiRERPMU4vUWlRT0Q4?=
 =?utf-8?B?cWsxanZuYkhXWXc5SjkzaWhMSGd5eDU1M2J6TFE4T1MrdWdsMDRIcmtBWmk0?=
 =?utf-8?B?ZXVSZFZvekt3U29SYU5YWXF6MmVWbmtzRDIzdFVUZWxDcDhBcWQyaHJHWmhP?=
 =?utf-8?B?d2tFY25ZL1JqYjgrSENjQk1na00zdkw5Yk9Xei84WHNCd0RubURCbEhOY0Vx?=
 =?utf-8?B?NXBQa1dvcmJjTnlhcG0wYkdDM0ppSjJ2NzZTNVkySHNYeG04dk5zcWZidkNY?=
 =?utf-8?B?aFFjZkYwdXFubzEyU1JVTnR5cFVxdUhaQnhkdHZpTUU1LzZiVHhWOEt3WjlN?=
 =?utf-8?B?RVRxWnZ4L1NIK2VRdEo4SGN2akRwWUkwVGZZR29ZZWp6MERUTExlZTBJSUVJ?=
 =?utf-8?B?T1liOEY5cG5La3hZZnd4TEZUc2hnN2wyN0JObDBnQUtGR1JnN01ZN0RiS1Ir?=
 =?utf-8?B?ekZmTjUwN3FqL2tuWm92YWhKM0VVM0xINlRiZzlXLzBtazVZQU1VNmlOWnpB?=
 =?utf-8?B?MTl0NG9VMVBwOW9GSzVJVWtTb05FVTcxbGRYNm9GcFBiakdDbkpqRTMrc0Vv?=
 =?utf-8?Q?ZjP94iVQ5Mi1DnjZ//S/fBMMsulizF4v?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDFVRWJpVVduRHlBU20vUC9pWGZzUVVKRU5KMzlBbWV0Tmw5SnBGeGFwVFJD?=
 =?utf-8?B?b0sxZENpcDRFVWo5ZWtMTWs1aWdEUHV1Uk0zR3VHaC9ETlBTVVJmTmxOWG1M?=
 =?utf-8?B?VituNFFEZy9VRnJHTUxiVmpWOUtDSks2akFsWnpwMzB1NFNyUkhGa0hUVlF6?=
 =?utf-8?B?N2MzS2E4eUZZZ00vMVVNRER0b3BNN3dmQlZ3eHozVGV5UUdWK2Y3OEg3U3U3?=
 =?utf-8?B?NTF0R1NURDAvUk1DOWQ2aUlBQU9xM1NZR1B6V1p1NjJHSmgzQ0drOTlHOHRm?=
 =?utf-8?B?OVp5SGpGL01tckhFOHozWHE2VE54d00rYWJGOFZteTFrd1Ywb3NiR1cvV08v?=
 =?utf-8?B?Unl5RlpyQU5DT2I5WFAvZFkzb0Fia2VmNmZoQTNRcExQQ1lNdk5XY2VwYjFP?=
 =?utf-8?B?NVJXUnJGWVp6RytGZldKS3ZFYnZZYjdid2FPWnd5RWtWZ1l2bjFqVk9rWG1P?=
 =?utf-8?B?VWxzTWsrbnR3SVRxNHFSWU9VWjdkVTFZRUhsVG53ck9DOGxkNEh2V2hXUXIw?=
 =?utf-8?B?R3NZLzlNUTU3RzBaV21oK2RwRXNVa04yRFBnOWlNdTZYYndzMFZzdnpDY0lX?=
 =?utf-8?B?MTRVeDZ4Q3VZenFtQ0RsdFNYR2ZRd21RN1NDeTJCL3pudGR1SElVbUw3akV1?=
 =?utf-8?B?SytWQzlzclQxNmlEL2J2MjRwbTIrd3J5OG5oZ25wSGg1U0tIdnE0MnNxZXl3?=
 =?utf-8?B?d1dURVU1SzJ0NEJqYXJBRzgzZktHaWVBVFlzWDdUWGp3dzBkemZLTlltN1NH?=
 =?utf-8?B?c3JDRDNQSG1ya1ViKzlCUWhOeDVyNG5pSXNTRE1Od0Vyc0RhNHhIdHlveDVy?=
 =?utf-8?B?S1Vha2tWWTFiL0lEVC9UWERjQUhwSUxESDRIOURwYUZvUUhQUG10K0tYRWJD?=
 =?utf-8?B?R1ZTNExubHd1UzN1LzV4ZUlVNTZIRnQzam1WckNmS2xMRWRqK0ZYazVHWmhP?=
 =?utf-8?B?WmJOUUJLMVFTaDBibGVuVzh1U21UVlorT3dwUE9VYU1PM1FleDIrczN1bkhN?=
 =?utf-8?B?TWQrUEVKdkQwSHVOVTI3WXIwZ0RycDFBTElIUkFXdmhYbDJieE5NeU1mbmVr?=
 =?utf-8?B?Y1UvS3lqUU9aSEovVzFnZnhFV2lBZmJVZWxuT2UrRnFzVStnZ2d2ajdqZ2RW?=
 =?utf-8?B?OGluNVNzeUkxWlZKTE1SendobXJVYm9NY1RYd05JNlNZNUFMNjd2czlUS2tw?=
 =?utf-8?B?WFlBUWNJUmJoVGc1b1RMcDZrUFQyQi9kajBNcFYxZzlmYTB3YTNpZlJPVVdy?=
 =?utf-8?B?WGJSUm5UcjlYTWJUNVJaNW9RcXZCcks4OEdIYWVqc01CSU9PVllvYzF6SXll?=
 =?utf-8?B?QVk3VDRmQStxZVllTlhob0syakJoQ0lPeXBxcFRna1lMQytTckxTOW9aN2Vk?=
 =?utf-8?B?NTJDbmEwdmt4NXdJcWFpYWZpMjFvREFGUTZ5NTdPNXRvM3FsVG1NZmdqVmI0?=
 =?utf-8?B?VFJxZHdhZGRXYldmenNaaStiMjJsY1dFaE54d0ZwNkQrZ2lnNHNZUXZqRUVr?=
 =?utf-8?B?VkJYQUdsTWliaXFEVGtTOGEvQ21TMktPRTUzbjBBREtKaFh3WjBLVW91dm9Y?=
 =?utf-8?B?R2V0TE84bTc2YUh4RHA1V2ZuankzTm9TS0N1MTY0VTNMYU1CSlpaUEZVUS9C?=
 =?utf-8?B?TzVzTy9jT3JSUG5nc2g4Mk9XZUwzd0N6NS9YaW1jaHl0dFNQRU9veGRUWWdL?=
 =?utf-8?B?Vnp2K0tMMmxTQUYveDBoMkVqSzNRN3dLMDdmNGsyYW9XMmNhcDBLMTMwK1NV?=
 =?utf-8?B?VE4wWTNvUGd2NE9FZzJqZi9lUXNMNXNEaWxmeDJFbGRGd21YUXVUekJyUnVY?=
 =?utf-8?B?eGxrYlZZWWg4elZTODhTRlpZTzYyRjB6SFVLS3hiVUV4cjZEaWVvMDdrUEx5?=
 =?utf-8?B?STlya0ppZUU1Qmx1Wm9MUWg2Wko3V1k4ZTU2TE1XUGN3OUppRW0rRDJkeXpC?=
 =?utf-8?B?NEhFdkJvQVpIOFB2UlJuMDk3OUhweUlab2ZMMEErQXpqd2txa29nak9oMDVy?=
 =?utf-8?B?WE5adTJPV1FaWHl5blhNUnpiUGZtN0R1Nk5NRGtBRUszVS8ySnVVcGxyVkJr?=
 =?utf-8?B?bTFuS1JPK1dxZ2lJeGlrMUJnSCtKZ21pa3poTUdURnpKV29DYlpqeExSOWhX?=
 =?utf-8?Q?x9tXFwezu8Ehnu7+75y86fccB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec83d0e-fd3b-44ef-33be-08dd59c84994
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2025 20:24:51.8828 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Agqvs7oE0NRqVufCJ8nTtY47kZefnAIszDBy2izYFcSs1hX3rqsWxYenZH+27sWdbLwcBZYi1tpEgGUARmEtkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB5525
X-Proofpoint-GUID: 8o3_OGiEFgOSQNKDz_ccIWld3rjDzQbR
X-Authority-Analysis: v=2.4 cv=e5P8Sbp/ c=1 sm=1 tr=0 ts=67c4be9a cx=c_pps
 a=H8RDR50mQ1szzU+C1Tr1+Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=-AAbraWEqlQA:10 a=26pQ9PmYAAAA:8 a=M5GUcnROAAAA:8
 a=XtR4tV-tLZOKT3eLXcgA:9 a=QEXdDO2ut3YA:10 a=wW9LCmZR2vbY8VTk3qYP:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 8o3_OGiEFgOSQNKDz_ccIWld3rjDzQbR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-02_06,2025-02-28_01,2024-11-22_01
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

PiA+PiBUaGUgc2Vjb3JkYXJ5IHByb2Nlc3Mgc2hvdWxkIG5vdCBjbG9zZSB0aGUgY3J5cHRvIGRl
dmljZSB3aGVuDQo+ID4+IGl0IGV4aXRzIGJlY2F1c2UgdGhlIHByaW1hcnkgcHJvY2VzcyBzdGls
bCBtYW5hZ2UgdGhlIGRldmljZS4NCj4gPj4gVGhlcmUgaXMgbm8gcmVhc29uIHdpdGggb2NjdXJy
aW5nIGVycm9yIGxvZyBiZWxvdyB3aGVuDQo+ID4+IHNlY29yZGFyeSBwcm9jZXNzIGV4aXRzIHdp
dGhvdXQgYW55IG9wZXJhdGlvbiBvbiB0aGUgY3J5cHRvDQo+ID4+IGRldmljZSB3aGlsZSBwcmlt
YXJ5IHByb2Nlc3Mgc3RhcnRzIHRoZSBkZXZpY2UuDQo+ID4+DQo+ID4+IENhc2Ugc2l0dWF0aW9u
Og0KPiA+PiBlYWxfYnVzX2NsZWFudXAgaGFzIGJlZW4gYWRkZWQgaW4gcnRlX2VhbF9jbGVhbnVw
LiBCdXQgZm9yDQo+ID4+IHNlY29uZGFyeSBwcm9jZXNzLCBlYWxfYnVzX2NsZWFudXAgd2lsbCB0
cmlnZ2VyIHZkZXZfY2xlYW51cA0KPiA+PiB3aGljaCB0cmlnZ2VyIHJ0ZV92ZGV2X2RyaXZlciB0
byByZW1vdmUuIFRoZW4gY3J5cHRvIGRldmljZXMNCj4gPj4gd2lsbCBleGVjdXRlIGlwc2VjX21i
X3JlbW92ZSB0byBydGVfY3J5cHRvZGV2X3BtZF9kZXN0cm95Lg0KPiA+PiBGaW5pYWxseSwgcnRl
X2NyeXB0b2Rldl9jbG9zZSB3aWxsIGJlIGNhbGxlZCBieSBzZWNvcmRhcnkNCj4gPj4gcHJvY2Vz
cyBleGl0Lg0KPiA+Pg0KPiA+PiBFcnJvciBsb2dzIG9jY3VyIGFzIGJlbG93IHdoZW4gdGhlIHNl
Y29yZGFyeSBwcm9jZXNzIGV4aXQ6DQo+ID4+IENSWVBUT0RFVjogcnRlX2NyeXB0b2Rldl9jbG9z
ZSgpIGxpbmUgMTQ1MzogRGV2aWNlIDAgbXVzdCBiZQ0KPiA+PiBzdG9wcGVkIGJlZm9yZSBjbG9z
aW5nDQo+ID4+DQo+ID4+IEZ1bmN0aW9uIGNhbGwgdHJhY2U6IHJ0ZV9lYWxfY2xlYW51cC0+ZWFs
X2J1c19jbGVhbnVwLT4NCj4gPj4gdmRldl9jbGVhbnVwLT5ydGVfdmRldl9kcml2ZXJfcmVtb3Zl
LT5pcHNlY19tYl9yZW1vdmUtPg0KPiA+PiBydGVfY3J5cHRvZGV2X3BtZF9kZXN0cm95LT5ydGVf
Y3J5cHRvZGV2X3BtZF9yZWxlYXNlX2RldmljZS0+DQo+ID4+IHJ0ZV9jcnlwdG9kZXZfY2xvc2UN
Cj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogWWFuZyBNaW5nIDxtaW5nLjEueWFuZ0Bub2tpYS1z
YmVsbC5jb20+DQo+ID4+IC0tLQ0KPiA+PiAgIGxpYi9jcnlwdG9kZXYvcnRlX2NyeXB0b2Rldi5j
IHwgMiArLQ0KPiA+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvbGliL2NyeXB0b2Rldi9ydGVfY3J5cHRvZGV2
LmMgYi9saWIvY3J5cHRvZGV2L3J0ZV9jcnlwdG9kZXYuYw0KPiA+PiBpbmRleCA4NWE0YjQ2YWM5
Li5lZDEwMjFmNjM1IDEwMDY0NA0KPiA+PiAtLS0gYS9saWIvY3J5cHRvZGV2L3J0ZV9jcnlwdG9k
ZXYuYw0KPiA+PiArKysgYi9saWIvY3J5cHRvZGV2L3J0ZV9jcnlwdG9kZXYuYw0KPiA+PiBAQCAt
MTE0Miw3ICsxMTQyLDcgQEAgcnRlX2NyeXB0b2Rldl9wbWRfcmVsZWFzZV9kZXZpY2Uoc3RydWN0
DQo+ID4+IHJ0ZV9jcnlwdG9kZXYgKmNyeXB0b2RldikNCj4gPj4gICAJY3J5cHRvZGV2X2ZwX29w
c19yZXNldChydGVfY3J5cHRvX2ZwX29wcyArIGRldl9pZCk7DQo+ID4+DQo+ID4+ICAgCS8qIENs
b3NlIGRldmljZSBvbmx5IGlmIGRldmljZSBvcGVyYXRpb25zIGhhdmUgYmVlbiBzZXQgKi8NCj4g
Pj4gLQlpZiAoY3J5cHRvZGV2LT5kZXZfb3BzKSB7DQo+ID4+ICsJaWYgKGNyeXB0b2Rldi0+ZGV2
X29wcyAmJiAocnRlX2VhbF9wcm9jZXNzX3R5cGUoKSA9PQ0KPiA+PiBSVEVfUFJPQ19QUklNQVJZ
KSkgew0KPiA+PiAgIAkJcmV0ID0gcnRlX2NyeXB0b2Rldl9jbG9zZShkZXZfaWQpOw0KPiA+PiAg
IAkJaWYgKHJldCA8IDApDQo+ID4+ICAgCQkJcmV0dXJuIHJldDsNCj4gPiBJIGJlbGlldmUgZGV2
X2Nsb3NlIGlzIGFjdHVhbGx5IG5vdCByZXF1aXJlZCBpbiBwbWRfcmVsZWFzZV9kZXZpY2UuDQo+
ID4gRGV2X2Nsb3NlIG5lZWQgdG8gYmUgY2FsbGVkIGZyb20gdGhlIGFwcGxpY2F0aW9uIHNlcGFy
YXRlbHkgYmVmb3JlIGl0IGlzIHJlbGVhc2VkDQo+ID4gd2hpY2ggSSB0aGluayBpcyBhbHJlYWR5
IGhhcHBlbmluZy4NCj4gPg0KPiA+IEFkZGluZyBtb3JlIHBlb3BsZSBmb3IgcmV2aWV3Lg0KPiA+
DQo+ID4NCj4gSGkgQWtoaWwsIEkgc3VwcG9zZSB0aGUgY2hhbmdlIG9mIHJlbW92aW5nIGBkZXZf
Y2xvc2VgIGluDQo+IGBwbWRfcmVsZWFzZV9kZXZpY2VgIHJlcXVpcmVzIG11Y2ggbW9yZSBlZmZv
cnQgYW5kIGNvbW1pdCBzaXplIGJlY2F1c2UNCj4gdGhpcyBjaGFuZ2Ugd2lsbCBpbXBhY3QgYSBs
b3Qgb2YgZXhhbXBsZXMgYW5kIGNhc2VzLiBBcyB0aGVyZSBpcyBubyBtb3JlDQo+IGNvbW1lbnRz
IGZyb20gb3RoZXIgcGVvcGxlLCBjYW4gd2UgYWNjZXB0IHRoaXMgcGF0Y2ggYXMgYSBsaXR0bGUN
Cj4gaW1wcm92ZW1lbnQgZm9yIHRoZSBzZWNvbmQgcHJvY2VzcydzIHNjZW5hcmlvIGFuZCB3YWl0
IGZvciB0aGUgZW50aXJlDQo+IGltcHJvdmVtZW50IGZyb20gYW55b25lIHdobyBpcyBpbnRlcmVz
dGVkIGluIHRoaXMgZW50aXJlIHdvcms/DQoNCkFja2VkLWJ5OiBBa2hpbCBHb3lhbCA8Z2FraGls
QG1hcnZlbGwuY29tPg0KDQpBcHBsaWVkIHRvIGRwZGstbmV4dC1jcnlwdG8NCg0K
