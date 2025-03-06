Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585C4C282D1
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 16:23:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FF7840A71;
	Thu,  6 Mar 2025 17:23:10 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id B8A974069F
 for <dev@dpdk.org>; Thu,  6 Mar 2025 17:23:08 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526B49CX010799;
 Thu, 6 Mar 2025 08:23:07 -0800
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 457agq8mwp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Mar 2025 08:23:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jRu3iaNjkrU0zXMJ1CMYVWBgpBA20FnNys+0ZXdwMKy7+ou2AvqeDp/OsQLM0jwkcqtA0xJBkWMJViZ8POMwJt7XRoMMAOE0TuzJUwlHF/NrAVOMuOtFktopd+M//ocuCK1Xb//Zf4Dr/xNswRb2OBoHIfskWqMwFkGwBU6F+mCgO7UM8CK0zOa+i1+r3yhZfxk5o4r0yTOFUUxOHvx9YWjDN8P5z8BIKg/fmcuRUbjlHNBAOu5EI0cI05oBT/+tURv8nZTzlocTqaAuyqfbwNltlttH4M8esGIk+gwUNFea8RihAFduychOGaPjPnHo4Id8hXb8DuoOZUAsNVQB5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0Ietha4eOt+esRC6a2PXVgnx7C4iTNbDYM5LRnrISQ=;
 b=uKXW25cEjBZG+vL+Gs6A7HMXB/zU809EY/b+iYYZ0JtWHskg5eRhWtDLCDJv5eefCoilPuyiiyh8c47ZA0Rs6tcIojNeTAc5LoJ78KWPC4vIniY7/NwkhEWMqryZAoxUU9HMLXAlCdWL9eb/ciuJV34CAycKZvVGkwSlov/kPwTr4hYkABgT1HfyrrNR0sg/d5PH9k3sML6OHrbmVTG1ynjJaLvm/9ZkpOvx7c6tmrxRmAcgJGw25T51Xcl/EyNissPfLrNQNzOzeVhLLWAs8AE39ubmlAV50gDip3vO++sfQ7sYUBNLNatQmbwdmxKo8NtgRY86ZMCEaHPJNLnH+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0Ietha4eOt+esRC6a2PXVgnx7C4iTNbDYM5LRnrISQ=;
 b=lDs6WIku574duvG93Fk3S4waVXRZ3hblnIsJy9H4skeOPJYfFT4PLnAvVj8UM050gAZRxLBYbJb1b/2bi8OORaGabwdvN7KFULAIKOsU4lx0ThCaSK0lHWn1Qqas+oIwVXkQZ9PThKBQh58xoK9XRft+6CHGDJrN/SUXAcBllvc=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 MN2PR18MB3685.namprd18.prod.outlook.com (2603:10b6:208:26b::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.17; Thu, 6 Mar 2025 16:23:04 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717%3]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 16:23:04 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: Jerin Jacob <jerinj@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] Re: [PATCH] devtools: fix regex of cnxk skip files
Thread-Topic: [EXTERNAL] Re: [PATCH] devtools: fix regex of cnxk skip files
Thread-Index: AQHbjqv71lKh2WP4fUeX5/gtjd5gkbNmSJyAgAACDOA=
Date: Thu, 6 Mar 2025 16:23:04 +0000
Message-ID: <PH0PR18MB4086CF34DA550AFAB8C1DE8FDECA2@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20250306152516.2594-1-pbhagavatula@marvell.com>
 <5438880.RUnXabflUD@thomas>
In-Reply-To: <5438880.RUnXabflUD@thomas>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|MN2PR18MB3685:EE_
x-ms-office365-filtering-correlation-id: 9760d5fc-b81c-412c-d9f5-08dd5ccb2c4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NFk4VXRBNjF6OWxCT1k1UXFIWkVmazBzeEpJbDNlSDFMWlRFM1ZhZ0NtK1Z6?=
 =?utf-8?B?Qm9zR2RlTFlqMHllcm0rRFoyYVdUK3Y1clcwdlUwNUJrMWkxRk1aTGZZRklI?=
 =?utf-8?B?Ri9hbEhRWUcycGZNaXNsV0RrMHhQVktiM0tqYTN3RjhWbVZvajQ2YnBCbEs2?=
 =?utf-8?B?bjNGSkRwenRwZyt3WXNVVTMxdUJEOGlVNkc2bGlpa3h4MnFGbTUrSWNiTkxt?=
 =?utf-8?B?N1AyWkJpd1psYmdES3BGbUJVUk51Z21NMlMrdG1DU3VHdy9VR0xna2dpSG1p?=
 =?utf-8?B?WkwyMGpPeUtzaExhR1ZsdFo2QVNyMDlCOXArbVNwQ1BTUkExOGM1eFFuSUNV?=
 =?utf-8?B?YVRjRlZDYk95NGVnenp1NERqMTZ0bEphbXZyeUZUeGlRd1JhZ2dSdFdpbVJY?=
 =?utf-8?B?dHlla29hOXBPR0RjRk5WVFl3SGlqSXVjekRiRUh0L29rM2lhL20yZ05FS0NJ?=
 =?utf-8?B?N25mem1aLzhuSDZ5eG4zT2RMN0tOZytqWlB4THdRSXdoVitkVVpuK2dSYnkw?=
 =?utf-8?B?ZHBGQmlEMGE2U3ZCN3hUU09WUUNldmErK1ZSZlZXb3Q5ZU1LcmtIeFZPWDN6?=
 =?utf-8?B?RmxJRGQyYTF5WjZFRmxmdDRadHVIMDVQb1pOcXBKelNodWVkTW9yQW5wZE54?=
 =?utf-8?B?ZE1GRHpGVkpxbmNJcGlGQnpxRUQxN1hSRXN2andkdDJscEZQSjZZb244QU4z?=
 =?utf-8?B?dkJxcmwwalZrWkpXU214WHJuVXJMWDdBTm1PS2FaMC9sbHI5RVN5WElWZ01C?=
 =?utf-8?B?OGxCcHFkWldBNWd5eWZ3Q1lvVFM2aUR3OFA3ZHJZWHVNSG9TQ0hrOS9ROFpB?=
 =?utf-8?B?ZXdiRllBb2tGVXdpaWJtd2lmbUsyU0ZyQWJMRjBQdWNBV0ZJS3Evd0htRWlZ?=
 =?utf-8?B?bVlCMHZOanVIajE2S0lGVU54MnB0RjQ1d3hDWHhkak95b200R1krVTJpbEJP?=
 =?utf-8?B?ZlR4TktnUGltbnNkaEttNStpcldCRlJPZ3lwQjlhcmswMVZFeEtTTzdQNEtF?=
 =?utf-8?B?NlBkN3ZZQWd1NWg1aFZZTkR3QkRQTkovNHJGMVNCSmsvMllkZ2o1OVNCWHlP?=
 =?utf-8?B?N2wyY2o0Z2JFMTJFenhNaFpCUGlBaFg0UGUvSFdZR3FxeXhzSnl5Nms3OU14?=
 =?utf-8?B?aWJ5MDIxWlNpbGNyNXhLRGUyY1Jyc1VIczhwKzNuZXZZR2JHOTNsVWdQL0tT?=
 =?utf-8?B?UnJMVkJ0ZDJEZHFBVmRKeGtiTFYyckVma2xVRGcyb0FpbTJhTVp6c05PSFpk?=
 =?utf-8?B?SU9kMFRPRVptYWVhT3hEZ2J2d2laemJSZ29OaXQ0anRVdFlic29jdlhpbzVt?=
 =?utf-8?B?aUFRWjBEYnRZOFZKRGhCaTRGdEN0OFZqV296YU9oeUVqbHFuUXNBb2NyZXl1?=
 =?utf-8?B?aTA4Q2tzYkpHQmpKOGptaE13MUtsdFRGcjIrZmFFb29hazR4REI4V2dTdXJj?=
 =?utf-8?B?UlFZVlFxOUdOaURPLzZBQkNwdTJlbFA5SWoxcjFCQjNkeWNRY0pSbkYzTUZa?=
 =?utf-8?B?d0k0M1FYc1BqbHZYRVpNYjQ5QmtQT040RDhjRjlRUjJkNUhBSjRFL2JaclMr?=
 =?utf-8?B?bzRTSkg2c2VEeFd6eXpaNHE0R3VFanZwSWZNVDlkb1dwNjlrQ1Y1RU1zMG5Y?=
 =?utf-8?B?WnZIVnZTNmo0QkxGeE5ybHJwWHZmVWNuTjNGK1h3TDUxYmRLYW45U3ZKcGtq?=
 =?utf-8?B?TitiWGx6QldDQzRIYk81VFdUZlkwUW1Ed3hyKzlwWDNDYlZQZU5GNHcxb05p?=
 =?utf-8?B?TW9ISTJhdWFob2NOUnZvc1U0RkJ2SUNXV3Z2OFJZK0FVSnRYc05QSUhvKzBP?=
 =?utf-8?B?M0VnTnJQVllCY0VuUFBEb2xLZG42SWplcytMZ1dCNlJqWkwxNURjYVl3L1Fj?=
 =?utf-8?B?Y3VDYzlaNmV3dTVaamZhdWFvQkxLaENFWFQrNE9xTk1IUlUrVGtjWW1tQ2la?=
 =?utf-8?Q?xMzuVSwEpCLyDuvEtjgnCfb8t69fy7nQ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFBmNnBXbXcxYWRHWnVrZUVoTHlvVjVPREYrQnJoT1RXUGtrbGxSWElOWndB?=
 =?utf-8?B?YXIrVzJXLzYzVHI5NTE0M0djcEY0cjBmNXdTRlVMMzdieUJmQXlMMkhQbEE2?=
 =?utf-8?B?bVhkdkV1eHZrQzZELzgxeFJxTGJzYWtrb0g0b1ROZlBwZHlHTEVObnYzREtK?=
 =?utf-8?B?UFJsVFdkb2ZxQWRKWWVwUUU2ZUNYTGJLWWdOQ1dEbkJIcVd4QVQyOXFkNzhw?=
 =?utf-8?B?akJXQzIzMXFVaHl3TXhFNkJKNThWK1RaYUVqSTFkNWVsc2d4bDVGZ1pqaFdO?=
 =?utf-8?B?T1NsdmZqd05Lcyt6VHBELzVEbGU2MWZWQXRsdyt2c05aT3BLT1hGMVcxbW0r?=
 =?utf-8?B?Y1JuaU1qWlF1R1RiR2FiSWRocE50WUJITDNLKzNSTC9Ka054RVdoUUh0VEUx?=
 =?utf-8?B?SDRibk95c3VDa0tjdGNLWU5XZk9IMmRYdmZYTkJTK0xBTkF4cVVlUTc4dmQ4?=
 =?utf-8?B?aktQbXpETzNaT25XOWRIVVR6RGpuZDIyTC80ZmZUeEhEZ25PeU1uMk9FUHNh?=
 =?utf-8?B?ZlVnRWVUdytRN29ENkoyZUhMMSt4N1g5bXNPL1c0YVB5U1h5OTNKajlsUm1N?=
 =?utf-8?B?aU5ZVzRnM05yN09SUEduV3ZyaEk0VldpaElVVWdhbmR2anFuTml2ekhFd2E1?=
 =?utf-8?B?dURnRmdkNk85clpqbjUxQVpkaEVMWWEvQjA3L0RJMTVOWkRxSlc0VTR3QmdR?=
 =?utf-8?B?dVBGcCtPbmN6N0hjbGoxNjJhdVhWaVRid2VPVThMTUk0ay9BL3QybUZ2TVN6?=
 =?utf-8?B?N1U3ckRVRHdHcVdIVXN0cjZqcWJGUTd5c1E3T2ZERVp3V3JwK2tuNEFaeFVo?=
 =?utf-8?B?alVOdmo4RGM4aFlET1JleWRsbDZQcWh5a0VabXUxVVI3VDZldFpNTWhOZUN3?=
 =?utf-8?B?NUZKUlFRdE13VlZ0MHkzTzdkZ0pScHEzK1FuVDJLN3lMWHp5azd3K3BMRVph?=
 =?utf-8?B?blJCc3FUTWlSTTNTTWJ1VmFUbXBQS0VubTVKVTNKRjZ0NFdKbXZpbGpLeDgy?=
 =?utf-8?B?d1RVSmdodGd2aWU5MzVoM2ZhdXA5VlBOQW0wZ3BOTVNXQ21lakJFckpnN0xh?=
 =?utf-8?B?MjFoMnNlSEoyUjV2K0FPMFlVRDlKSThoTEhTdnJaaW51MUhKR3p1VkcyUTl5?=
 =?utf-8?B?TkFZbXdXUTZSL2V6NDQ3dUNUTHovck1PTml3TzZQem5Fdy9nUVA4NGdsTGgx?=
 =?utf-8?B?NlM0T1RVYkMvWEwvbWZqeHVHSFhUbDQxQ05DYWtTbW82QUM4K0t6V0NBeEJv?=
 =?utf-8?B?dU1uenJUaFJHdVpscHFlcStYaXZybVp0UEZjcUY1bURMS2IxcHMxK0NKa0tx?=
 =?utf-8?B?UGc4bzU5a09WaGhPSXVqOVJVVzFYdG0vd2ZKejRtNjlhTEhRVkNPeElZUm9Q?=
 =?utf-8?B?eUNDQ0FmcWlRMEFiTFh3NmRQdzFwY1crWVF3WWRDbnpvaVhmRVJEUVBZOTBQ?=
 =?utf-8?B?Ym5lVzRuQ2pkc3ExcCtYc3lLaCtudlQvK1NZUzRjUUNNblFMKzROSE41c3Y3?=
 =?utf-8?B?U2ZER0xQVHArR211OFhYdjhCTlR0ZUdhUU5xVThYK21GVGFmeXRZdndRbk85?=
 =?utf-8?B?ZU1PUGM3c3YrdHRlV09oUWQ0RWV0ODZNWjhRdVNDcVNZSkxsZjRTNm9aSlNZ?=
 =?utf-8?B?Z3NKRlcrWUdhRC9nK0RRcThhWWxZQW1YdkE1VTBsNzRNZllLYnJXMGtHUENU?=
 =?utf-8?B?bkNodzhRbGZBWHViS09sUlljS09vZEZPSVpnencxaXVaRUJnb3p3emdIWUVG?=
 =?utf-8?B?NCtNUjVGY2FPL29iYWs1SjlReEoxYUg4akRNYkV3eitnbVZYeWlwK1BtVkNq?=
 =?utf-8?B?WGpPYXJuYXI0Skc4dHRvQUlCNDdWQ1lMYll5YitoZWMwUDhLdFlnZS9NbXBB?=
 =?utf-8?B?QlZxQlBFOGdGYVNLVXg2aDBXcS90cElmd1B1OERXU2xnNVREYWlKOFhhQUdr?=
 =?utf-8?B?T0FYa1JDMmY2RE1UZE9FK2FLODlVR0JKdnhaaFYwa1dSOVRCVFpmYXc0UWdI?=
 =?utf-8?B?ZzZLMDhaQ25aaTVOZkxqTk5udW5JODVZYnpIK0dndWVuQSs2WGVuM1Zqd0h6?=
 =?utf-8?B?bnBFUHhCLzBMMXRwckduOWpBNERvZDRZZFkxNHVGWjJTcFVDQkQ3bGE5WCt0?=
 =?utf-8?Q?qRiOiaDcydwSO6EcuLAbQlSVj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9760d5fc-b81c-412c-d9f5-08dd5ccb2c4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 16:23:04.7597 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NpiaHwJDns09aNFJP7HoSHDk/GtSOyWR6voZdEgqDojNL/ZP9kUEtNsPxA2HTg9iHVHjxax1Q2Jr3aWwRDDsq03hQyuUksZCiBfXuRGGa1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3685
X-Authority-Analysis: v=2.4 cv=coRhk04i c=1 sm=1 tr=0 ts=67c9cbeb cx=c_pps
 a=l9lnEPKonMfu/vbXsUzXcw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=63TXHbPgE7stUKv7vHoA:9
 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: ioR15pR6rrgP8Zp6ml1TyeG5oW_dvc91
X-Proofpoint-GUID: ioR15pR6rrgP8Zp6ml1TyeG5oW_dvc91
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
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

DQo+IDA2LzAzLzIwMjUgMTY6MjUsIHBiaGFnYXZhdHVsYUBtYXJ2ZWxsLmNvbToNCj4gPiBGcm9t
OiBQYXZhbiBOaWtoaWxlc2ggPHBiaGFnYXZhdHVsYUBtYXJ2ZWxsLmNvbT4NCj4gPg0KPiA+IFNL
SVBfRklMRVMgc2hvdWxkIGluY2x1ZGUgdGhlIHBhdGggb2YgdGhlIGZpbGUuDQo+ID4gVXBkYXRl
IHRoZSByZWdleCB0byBtYXRjaCB0aGUgcGF0aC4NCj4gDQo+IENhbiB5b3UgcGxlYXNlIGFsc28g
Y2hlY2sgdGhpcyBvbmU6DQo+IAktdiBTS0lQX0ZJTEVTPSdvc2RlcC5oJCcNCj4gSXMgaXQgcmVh
bGx5IHdvcmtpbmcgd2l0aG91dCB0aGUgZnVsbCBwYXRoPw0KPiANCg0KU3VyZSwgbGV0IG1lIGNo
ZWNrLg0K
