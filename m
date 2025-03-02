Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78061C19F32
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Mar 2025 20:38:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C44974025E;
	Sun,  2 Mar 2025 21:38:04 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id E168840041;
 Sun,  2 Mar 2025 21:38:02 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 522KKgnW031549;
 Sun, 2 Mar 2025 12:38:02 -0800
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 454kvegskn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 02 Mar 2025 12:38:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N6iyAqjwmzhESIcVkxnowGv1GrqWc4BWVAzCeoOQMaKexXMNXrDy1USO4tDb4eWey4b1+t9tWmWnX3TvqPv4btrKSdfhzgjSCRPvvi/BsOJpJ1dN5+qH/xR3z0Hz34sfrh5wfYvCB/H4k+Rl/+QivqxeBFX7s+z6yutZzSlG9ECe+N5i8N2lFwSa/3ne0Tc0zNK17OWWqMKuX2LBfmNMiwS/bG7oj8sG0afWSpoL6iKD8QfxHzrFceioyBhE7enSj563cdZD4rl6qpu+82M8pLKqIlPkGUtHlTKUbolUkgsI3rwDBVzR6alp9777j8idAQ2jyO/qI6KR358xMndtIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DS7BKb8azJP8FiHHtfgClOeYlFcVyBQRZ19tmKU+28A=;
 b=fsY/6gR4sKhTHlnaipPKG2LB60I6l14FInGE0kBbTLWFZxEzBFApZAG3luZ3CmJEMfcQX1a2MLXK0lIYfpMVollLr0eLgx9ykmmJWuzPH/HwnZlBihAMs+xHhG7WBJRBk3HQhPfTmxAJYOQJO8m+L3SFLFLNLP0jT3z5pTsdTKrFsJ3l2iwWiM1R1Yw8cJs1r5XqzEVRbgZT4OWE5RU7oH8wgrarQ9IxYawea55zMLGOTwJ/n0oynYbFQ/vDy7WChvMXQwCKdUtQAxOXMYvDaEeOT8lreZYzfwqeRtqdwINRxHI/3ZjC04MbUZHnElDa5JftFqbsZnFUxAjD1R2pAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DS7BKb8azJP8FiHHtfgClOeYlFcVyBQRZ19tmKU+28A=;
 b=QKE6rivKhn7eyfWv2BRKrTBHqPMNnULw08Q1d3yZ+rmOBlD+FAOmWXmtEsj37K4fzU4JNlLKcT18Iavv4xcmrm+nemtgKTvxehNlTTP+SnWCyaqGsxASNl9E2o/G/oUxqnzcbbNDRGnAZDPeOeqFiquaC8a9vFHpQ86oO28R224=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 CH3PR18MB5511.namprd18.prod.outlook.com (2603:10b6:610:15e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Sun, 2 Mar
 2025 20:38:00 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%3]) with mapi id 15.20.8489.025; Sun, 2 Mar 2025
 20:38:00 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "brian.dooley@intel.com" <brian.dooley@intel.com>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH] crypto/qat: fix incorrect sm3 state size
Thread-Topic: [EXTERNAL] [PATCH] crypto/qat: fix incorrect sm3 state size
Thread-Index: AQHbiDESf3cWAjUCiEa6ISVh56ZVgrNgVXPg
Date: Sun, 2 Mar 2025 20:38:00 +0000
Message-ID: <CO6PR18MB44848F6CEF92BA27B891E883D8CE2@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250226093019.1582450-1-arkadiuszx.kusztal@intel.com>
In-Reply-To: <20250226093019.1582450-1-arkadiuszx.kusztal@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|CH3PR18MB5511:EE_
x-ms-office365-filtering-correlation-id: 119bc674-295d-4b96-ec81-08dd59ca1fa6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SUh6aEVOdDFBeUcwZ2w5Q2lvcWJzSEgxRFoxOSthNytDZzFkam91ZENoWWx6?=
 =?utf-8?B?LzgxMnFpWDBmS3RwTUgyL2tmcjRtZFJzODRTaDRzdVh3MGloWmorKzRGaUta?=
 =?utf-8?B?bUVKd0ZyLzRTLzZsTTE1cEhsTHhLN3hvbWU1cVloL1NuTDM2ZVNSbUd4NUM2?=
 =?utf-8?B?aWdteW9BMkFyb1QvS3NQNXVqM0s5c1loM1NBRU4xQW4wcDBDM1l5VkNRVFdG?=
 =?utf-8?B?T2FQSWlnRHJIYTEyVEVLUVlRTW1KdTVyQ0lxYk84MnNtQzZHTHlYaW1WTW1I?=
 =?utf-8?B?Z0pza3pUYzJ3SHRHbVFHa3FDak1WSFdESGU5aVNYY1MrSU1BOGJ4czB2YmVN?=
 =?utf-8?B?QmJjOWRDcDZpTjdYN2NsbFBFOElHSVZUVnNNRU9VSEk2RzBQUjc0amVhcDFV?=
 =?utf-8?B?QTFZOHVWa295VFduVGV6NllDcFZhRUJOemlNemhNQkVnZXVzTm1ZL2FIeUtY?=
 =?utf-8?B?REFoZGJEOWk4bXJRYXovWDhqK3dqSkZNWHEyOURsSVBIMXpZcWhrR0gyRE5x?=
 =?utf-8?B?Q1dmWldOemE1aFRMS0NMQ0RBTUVVK2x0d09pOXRLdEZIQ29GTEcyckxyeUVq?=
 =?utf-8?B?NVN4VHoxcC9KT3dLMmZibVhLUFluaTFWNStTUjRHWEhyQTloWFdvVXlEOUtR?=
 =?utf-8?B?bTlQcDlDKzVBUXVMaGkwUkNUYjdRcDRkVHRTcXlQNFhQL0U2eEZtZmlYa3R1?=
 =?utf-8?B?ckJRcFNaQjExSWZPZHBMZ1Z4SFg0c2JodWdvSjZkbXpFaXdnN3JDRUh5VkxQ?=
 =?utf-8?B?ZEJZOXN5RnpzVTNPSW1mcjZVYWJkOTU4d01IRzdRcHRjOUp2cXhxMThINW5U?=
 =?utf-8?B?ejJvUjVjUnRSTEg4T1hpSXRPMVdqYUpQU3RQdWtRTlN6QUViUTg5RERjR0hi?=
 =?utf-8?B?bDNaLzZab1VOL21OWkgwQng0WVh5dVk3cEY3VUQ0R1ZUanRFR3JwQ0hpUTNJ?=
 =?utf-8?B?Nkh6T28zalpxeFZLZFBWcnorYTNNSmtHRU9hNkwyTU5OMCtvZkl0QzZRQ0JS?=
 =?utf-8?B?cHdIdlNFWVBNOEQ4Mm04OEsvbHptcjBTc3B4cUZLamRsRkg5ZEpMeUlGVGdO?=
 =?utf-8?B?d3BRNmxpN3ZzN3ZLY2x0VkN0TStROXpjRS9uQWNRWW5FeVZlUWlOemRKVEw2?=
 =?utf-8?B?b0RQUnBtUTBKUlZGeTV5RFp3TVlOclpuem9ZKzFUZHI2UWVYR3dmQk9POTMv?=
 =?utf-8?B?ZFdrVkhhaEtNS1l5bU5FaTc2T2hlV1F0RHJyTXU4RVVRd1FyL2ZVMjlMWlBD?=
 =?utf-8?B?c3ZHYVpwMGFYZWN2VU5ZUzlQczBBZW1vMmdVTW1OU0hCaHhCTnZPdEpoM3Rh?=
 =?utf-8?B?Wkp5TzRqaDN2OFVkTS9Kbk56RUQvSVI2WTRqTlhxNVdld2RkV25QQkVneTAw?=
 =?utf-8?B?dTJSQ3lxRk5icFJXYlVqcTRLSUV6L1R4NGNYek9HV2tmQ25uRG5YR1B5THhK?=
 =?utf-8?B?TTJMNnVSZ3ZucFJ2U00rdUV2YlhXUDlhaUx3Z3FWY1BZL3d1dGM5WktGRmFH?=
 =?utf-8?B?dTI2Vk15WC93WHVVOGNCWE01SGp2dXlUVWY3TGRaUHFmTSt3R0RPTWF3TkxI?=
 =?utf-8?B?ZE1ZSU93YzI5NXhma3BWRjZKZVhaN0dNVlNLRnM4TTNkb0kzYXJQVW5zbEQ5?=
 =?utf-8?B?Q0ZZN0pnTlJ2WnJuNVNwZ2hZNzJMOGVObkNzM0cvKzdJeC93VHRaQm1OekFZ?=
 =?utf-8?B?dFNOdnI4Umpvb3hNRTR6MUFzcnFPSlJDQ2pob1NOOHZGNEVLNUx1OUwzcUVB?=
 =?utf-8?B?TEQxWFN2WjdNbkIrY0c2akoxSkxwVkJHMThyVEJnaGRuZmFra0xEMlUrcU5N?=
 =?utf-8?B?eHJVTVJ6RXp6bGs3b0NNUzVPQ0wrOFFTRjZEVzZUZEtCK3NuOWJOUXhPSzJL?=
 =?utf-8?B?T0Y5bUpqeEhWS0VjODhxZWI5N0JRWUxzQm85ek1SczBSMnVsNktPelNQWlVY?=
 =?utf-8?Q?nlxy+mciziI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTg3alRFWUs1S0hBUGUweXRoN1hibzZTb0pQV0FzWWo0Q1ZqTmJkWUVVWXdF?=
 =?utf-8?B?dG9MeVRaaHMwdmthK1ZLZElOWG1FVDdnTGlaNnd6eWtBbWxETzNWTVArOEVz?=
 =?utf-8?B?OXNMNzM4NVJiMjI4TDRvcGltUXBBV2FzT1dYNDdpMlEzbWFKMEFiTmU5MGhm?=
 =?utf-8?B?cEZjeVNFWFhhbnp3eVA1M1NUREI0SklBeTRHMnVvMGgrWlBvRUNxcENtSXVP?=
 =?utf-8?B?MDdjQlYvbWlCanYyUlpqZGNxY0UycGNGUW1Xdnk2d0JLR2JvekFFMEZhMGhy?=
 =?utf-8?B?dlZtbUZ4dlVLUGxXRkc0NldkamhIYytmVU1iU2hwYTlYY3pNSE1KUk5ZTlpi?=
 =?utf-8?B?U1Rsd01aU1pJSTZGTWFKMk9HNm55YWFpUnhIL3BlS2grdENIQWZUWmlIQ0U0?=
 =?utf-8?B?bWlCOVFIeGdwVFdJdllrN2tQelY4V0FwT1JpTExiL3hIcGlBVzJxZmZteDQy?=
 =?utf-8?B?WXpiSmZLOHZYcjdlQjM3UVFNbEFIei8xVWZSM3NONlN5SHlDN3Z4RFNnRThC?=
 =?utf-8?B?ZFY2R3NPY2VQN0IxUkJnVk9BcFlQaGlHcHp5RzJQV0FVSXhoUy9CeU9jeTRn?=
 =?utf-8?B?MWJjQ1A0VzFudC95U1dwV24wYXM1ZWNqdFM2aXpiNXF1a1hMcC85VGJ6UjRP?=
 =?utf-8?B?RUJJOXFXOGlYelArNFV6b1BHM1dFeThiWjIvRkNNU0tkRmwvSTBnUzJ2SEJV?=
 =?utf-8?B?TWpTMWNmZlZzRm9CeVBKaHV1cWljb3JraElCQzU4RkllZ1VaOVY1d3BTN2hw?=
 =?utf-8?B?N1pxL0V3cS9rRGZjMkh3bkVkQVVPTzFvcWhSdExtTFpCbllCUWhmdG44SE9E?=
 =?utf-8?B?ZUtydnBaSHpUWlhSL2NVaWFnRGhERUtaQ2d3UHNBamVyNGVsNHNwcHBhaHds?=
 =?utf-8?B?RkFxVWhVcWpDUWliaUhSbG82bXVBMjdsVTJ2ekE2dHI4OGRReWZHL29SSkFV?=
 =?utf-8?B?ZStrVXJiNE5vbXhXNGdXdkZnamF0SERCVGZuVFlLZGRHWnAyVHlXRGEwTkdL?=
 =?utf-8?B?MnVTdUtLMjVvVTJCUkRjRjhqMjczM3k1SStmbG05M2FCa3hFcEhHWit1TDJS?=
 =?utf-8?B?eDFrTndPVjVxSEl3S1RuNDBUbVlvbDU3UnRMN3EwV3lPVTZoUlNCanZUSm9u?=
 =?utf-8?B?bExqSTBVVzBpazl2ZXB5U1VKcDdSZ3F3aWRsdndFTHNYZzUwNFdHV3Vhb0hr?=
 =?utf-8?B?b2w3ZG5hS0g0Mkd4MVpBWVliZ0tIcmpiWHI3bndWR1luSStIdGVPcmQ3OVVN?=
 =?utf-8?B?VEVPeVFFWGt1NmlyaUxTRXNNVFY4blBjaldmUHBzVGJOQnZKL01IM1NvYnZ2?=
 =?utf-8?B?dmtPNHJxZEJ4STh1cnZWaSszY1hKOFFPS2pFdU1RVE5VNXV0dkpRazAzQlpY?=
 =?utf-8?B?bTZEQ2NmRndoUTh6YkZmRmg1REhFSmNVVm1QYjc3YnY5eVRUYUY0NHZCRW1E?=
 =?utf-8?B?VGFvZEtJdTZlOHdod0lxV0V2Uk1EZVFRdjZYWlpkNVlDMkRvb0xYdnBBMFF3?=
 =?utf-8?B?T3d1ZW5kNEFhS1ZGRXZCZFdDaXFiSytBSWxMVjJzNlQ1SEdmK0E4RmRNa25o?=
 =?utf-8?B?YTRXeFlGWWFNck1jcWx5WXNhcTBJRjZzbUY1YVF0cU1qSlJRN29YMnFRd2NM?=
 =?utf-8?B?SE1jU1dpd25vMWxvek5KMS93RmhqN2Zud0R0Qk1ybExCMGlETjFtMlRkNlVG?=
 =?utf-8?B?OUJzRTdyYUxiRk9qZU1WdWdVT2dzOW9sRzQ1c0x4Z1BvSEMzc3FoUUNlMlJR?=
 =?utf-8?B?Mk1tQ0pMRDJlUkxsSGdIWnVua2V4N3FyMHM1a29oR0JsT3VWcXRrUlppZmNn?=
 =?utf-8?B?dm05Nm5KR0FhSmhzYXBrYVdyZC9sRWlONTVyQjFYRlZjbjhaVWdualBhalF6?=
 =?utf-8?B?UDZzcWpGSTI2RnJzdkxQSUF0ZVMxQU5KRDZKVkhKUzRmNDR1dnpnalkycWZ4?=
 =?utf-8?B?L2JvaTg1cmZsNmJQUm53VnlJbUhQM2RSWHk0SGxzRDFEZTNYSjFzYlJUQzEx?=
 =?utf-8?B?L0NoMUx1TVF6TlRSZ3MrWkw0MVJTKzRFUk90eXVuMU1ka3pOZDgrek41dEE2?=
 =?utf-8?B?SG9BRG02eUsyWkd6aUlRQ1RSSURRVkhDOXRDcENIbUpSdFhKeGR3WUlKLzJr?=
 =?utf-8?Q?GfkEA/dtnpL5creZkRWB+ILJr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 119bc674-295d-4b96-ec81-08dd59ca1fa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2025 20:38:00.5488 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yWQhf7KGkL9jASQ4KV42LGq81U1uSex2JR8sFAX0/4lagyXbFZmW1m4SZg7BokNAbmrrkGWZvVcdUx3qsfs8NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5511
X-Proofpoint-GUID: yRLTuDiJK03vyEYPMd5PNN6_AFrUTZIh
X-Authority-Analysis: v=2.4 cv=O73DvA9W c=1 sm=1 tr=0 ts=67c4c1aa cx=c_pps
 a=PdgAl9AEy1hEU2ikvxmBtw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=-AAbraWEqlQA:10 a=8rWy6zfcAAAA:8 a=QyXUC8HyAAAA:8
 a=mcVHISYiNg4QUIt1LasA:9 a=QEXdDO2ut3YA:10 a=vsLuWa4wIxMA:10
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: yRLTuDiJK03vyEYPMd5PNN6_AFrUTZIh
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

PiBUaGlzIGNvbW1pdCBmaXhlcyBpbmNvcnJlY3RseSBzZXQgc3RhdGUgc2l6ZSB3aXRoaW4NCj4g
dGhlIFFBVCBQTUQuDQo+IA0KPiBGaXhlczogNzVmZDRiYmM5NGFiICgiY3J5cHRvL3FhdDogc3Vw
cG9ydCBTTTMgaGFzaCBhbGdvcml0aG0iKQ0KPiBDYzogc3RhYmxlQGRwZGsub3JnDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBBcmthZGl1c3ogS3VzenRhbCA8YXJrYWRpdXN6eC5rdXN6dGFsQGludGVs
LmNvbT4NCkFwcGxpZWQgdG8gZHBkay1uZXh0LWNyeXB0bw0KDQo=
