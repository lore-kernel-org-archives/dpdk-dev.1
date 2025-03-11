Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601B1C282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 11:49:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 29DBF4027F;
	Tue, 11 Mar 2025 12:49:58 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id F024240263
 for <dev@dpdk.org>; Tue, 11 Mar 2025 12:49:55 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B8xxnB010804;
 Tue, 11 Mar 2025 04:49:54 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45aj57r94k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Mar 2025 04:49:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDWKEwnlBP8EtoKvMKXqXejAfc1BNnh6YbBZ3hqvusU2WjWApTNzsf7WDaPky3Q/A5y5IvQGDdu6tGXndZAOfq2IP08BO1KJAqVSJY2SLiQ1rtb3CB3ziyESKZYyi9ZLvboeDaDEN5XIKjgXqp0kkQwfIU3pdOFc+0zBaaLYXn9vXiILESfx9Y4LUN/L+EOymr8x5+76znyyHZQlbrFH8gbe0mrxdw+ZuRQox351+O5GwK/ZjFwgORmTW71umPRRRiN7G59A4OyehgJJvEih42vnbrcL99vjqzYyM89rh2RABox9kYVTjvwxwVQTZleoRpPMrJZv6RU8xH7CgerbyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huNO29shy8IaBLfFRR6ZENQWYx5nznBKji+N672KPbo=;
 b=mlKS6CBhhOAWIzFnVco/NQBpa9pHDi6yB25yuUSEUMPMnECm2X5Xlo5uVLW+PmPwmm+ZxAt15O/16b/jh+4Phr8L4J0vrL6ytlgU/njtEoIsaOtLua7yqIyRWVW0l5hI8hoqOGO/GO4QRBuPmPdxJAbNwIMjimbWa4FUqxr9IeezIVyHOh+gEXz9GsplLVLpNQrcJ7d/b+8W9rZxQPc6gLPY/aZ1MtV5BtrflwA4oQZsXxuL0DCEq8/T9WqYJLDrZI+Wylf5iUKjkH70cvcHz/TTeyeP43lxiLE92qO4pdxY6hSNcn/1OOz0SgcsQRFb1CuM6RgOdEDVuRWBoyWGIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huNO29shy8IaBLfFRR6ZENQWYx5nznBKji+N672KPbo=;
 b=AiQY/ocK+7MgptvRRdRFLUAK5ILMrFhQ+eX5objHlho/GaTrRk4s85iQaDH2bxjLzYgbtnWehDqGo34981+UrGTOBy2KBJCQSONWr2uDQIrguLaETPwae1bBXRDvlV6/TzQJpYnGnnh4nbB1X9327NZfCmyiiPmZaCLmLpB6xek=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by IA1PR18MB5448.namprd18.prod.outlook.com (2603:10b6:208:454::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 11:49:51 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576%3]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 11:49:51 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: Luka Jankovic <luka.jankovic@ericsson.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "mattias.ronnblom@ericsson.com"
 <mattias.ronnblom@ericsson.com>, Pavan Nikhilesh Bhagavatula
 <pbhagavatula@marvell.com>
Subject: RE: [EXTERNAL] [PATCH v10 3/3] eventdev: add atomic atq to
 test-eventdev app
Thread-Topic: [EXTERNAL] [PATCH v10 3/3] eventdev: add atomic atq to
 test-eventdev app
Thread-Index: AQHbjnS/Pi/WAZweYkuSe3b3irlm97Nt2jLA
Date: Tue, 11 Mar 2025 11:49:51 +0000
Message-ID: <BY3PR18MB4785CC3A77CF153553B89338C8D12@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20250305141255.3031686-1-luka.jankovic@ericsson.com>
 <20250306084946.3699972-1-luka.jankovic@ericsson.com>
 <20250306084946.3699972-4-luka.jankovic@ericsson.com>
In-Reply-To: <20250306084946.3699972-4-luka.jankovic@ericsson.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|IA1PR18MB5448:EE_
x-ms-office365-filtering-correlation-id: 1c36f85a-33aa-4a23-c09b-08dd6092d535
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?eDJMTTN4OWN3MC80SFRBclZDTTRSNjRlL2s5T2xMRHVJNm5rR3k4cDlYODVo?=
 =?utf-8?B?Wjh0WGxFQkRYNEwwUFZLVTA1NVNra3RueXQxNE9VMWJIclE0TkJmZjZUNGoz?=
 =?utf-8?B?cUlzd0lZMXhZOHEyWnFvb3B1cDhVNjFVOXVvSDVvd2FZcTdFQUo1YjMrM1Bh?=
 =?utf-8?B?RDRtZTVQTTg4NGU1dU1RaEZqS1REWTZLVzI0VUFhNEJIcC9pa1VFQ1N3dWxt?=
 =?utf-8?B?SWUzeUdPc2k4YXJCRU5LSFhqZitGWHhhTnRsZi9FUFp6NFZxUE1WVXNzamgy?=
 =?utf-8?B?UlZTV3ZxdzZoY1dWM2JPRkRNYXRCWUJZVWlWRjU0WnRVelErQ3orSDJHdE11?=
 =?utf-8?B?WnV6dWplYW5MRzB1bUpycFQwZHBtVzV0bXhrU1lZSDdGUXF1SlpQNTN3ckVP?=
 =?utf-8?B?eFd1c3Vab3k5ci8rb3NtbjZHVkNqQkdrM0ZxV2FVTTJyNXA1QlRURnpSMm01?=
 =?utf-8?B?ZmVnR2JYUzd5T2xTWnd0akRDNFUzRjJrbWc1dXQ4MlUzOHAxYTJEUDdnbzJG?=
 =?utf-8?B?UFFEYXhtTTVNWG5xOG1hanhtV3d6L3RRSU9uR0JkbkVvU1NQT2VlRzBZRkMx?=
 =?utf-8?B?UTBtNDJjK2tUNnUyN0ZiaU5VMjJUWlFOaDV4VmpEaENGZ0hua0xtNUs1Z0ZL?=
 =?utf-8?B?bEg1ZVU0blZLYnZuMGZMZWlLQUhBTUM3Uk5iMHJhWFoxdTlwcE1iV2cxbERQ?=
 =?utf-8?B?eTlUamZ0T25LQUtLMmRZamRNVExCSFFUcGljZ3JjWXN2SjhIYXp6bFhtUkxl?=
 =?utf-8?B?SStVRVlJTVFRazBVTXdpbkJVY0Rad3RJOGRLTkdsN3c1SDJMM2xlTS9BaGNZ?=
 =?utf-8?B?NkZwdHZvdnRVWkxsbDV6VFVES2s1M1pJZGNYRXoyUjNPZTEyVzR1R3BvMjNH?=
 =?utf-8?B?SmJXL0Mzc2xwL3N6UDEyQzdYTDZNWlMzdzJlNWdwcjdLZTRIUmFhbXF6azJk?=
 =?utf-8?B?ZjR3TFV2UEphZmRlaHhQaWhuMm8wODY0dVFqRTVnU1VrRU0vek4yRkZDd2V4?=
 =?utf-8?B?SXl2RjV3SnlnYkdXZUMwSXl5TlRIR01jZ1YyWFJ2bFNrSDVWakcvV2tEZ1Qw?=
 =?utf-8?B?Z0toUGYra3lILy9UZlRNb29kN04rSU5vNU1GcGtBMDJHc3JkYVdZb1RCR3Ju?=
 =?utf-8?B?dzVDMWNoQnEyNllkRWw3YkZVclExenlIaVNpVEhEalZudys3Y2NVKzBkeGR4?=
 =?utf-8?B?MThCOTJmbWNDWWxyUEE2QVZtUlZVZ0IreDZKeWZWRVhHa3BJK2x6ZmNIdHZ0?=
 =?utf-8?B?RTFNQ245VGJ1MU5TV1BRcUc1S2Vvd24yMmxZbXc1NlhmcnhSMUQvLzJ3cFl4?=
 =?utf-8?B?SG9VNjZsS2ltTE80MUsyTkFqM3dBVHI0TmRoTjVzaEJ0RU9peHdhamtiNGM2?=
 =?utf-8?B?UjVYbXBSY3ZQTWZaaFBvbjdqR0hpZklDWndKM1lxT1BRRHZrRWdaNEpxSGM3?=
 =?utf-8?B?Vmc5WjJ4QVZ5K2lZVm5YY1h1Qk5rczR2ZzJCWGptNEowQ2p2aTgxU2VDTVpI?=
 =?utf-8?B?YUtmemFnNmsxT25nVFNjbzYzTG5ZTFpOSkIvYWpRTXNtdjBVUWtXVjY0ZGxk?=
 =?utf-8?B?YjFSMXpHOERjWWx1QnNISHo2cC9La0oxTXhGVmZwTkJTN3lKNVNLUUdVV2V4?=
 =?utf-8?B?WmVFbFRPNWlzYkE2SWhlSk9yNjVqMG9wcXZYWm1EVWpEZGpZNDdwQ0RPUkt0?=
 =?utf-8?B?K1B6VExXYkxmN25HNXZsLzgrVFViV3piNDh3Nkl2N1R3YlJDMzF5djNOYW1B?=
 =?utf-8?B?TVlLTHFxR2VsRWtJOGk1b3I4NFkyVTJMdnV5elIxVXR3UEJKVi9PbHJsUmx5?=
 =?utf-8?B?am8wa0pqZ29OVDgxTlViTy9SeTN3M0xOOVJDTXhKWDRZSStBeXZTdVR1bEVD?=
 =?utf-8?B?SlEwSWF6MGtReU5Wc29oaHo0YnJyTlN4bUhlMHBNTFRaVWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1RLS3BEZVRhYWNFMU9FYTUwSGhwd0U0dkhWUDA0bGhlbEQ0L2haUnJlb29s?=
 =?utf-8?B?aHdLSlNUQWlOMDRmMTlOcG1BMEIzL3ppaklCSk50MHRFSVoyWGhlcjFBb29Z?=
 =?utf-8?B?RDVIWW5wQW1PZlk3OG51bmRTKzR5UkZqcnRqdGt4WXNabjR2OVNaV2lPUjVS?=
 =?utf-8?B?ZkhHR3VMOWNnOG5ZU1o0MHV2UzI5UGVHZUxuV1gvaUJ6OHYrOGxlQmQyMDFH?=
 =?utf-8?B?VVF3VXE5YW02MnZZVkl4ZWNidG90T0ZBNlpTdFVXZVJhUVZUYWZrK2EvMFRt?=
 =?utf-8?B?UTNjTDJZMS96M20vZHBlcGRkNGNna1lxdlAremV4Y3YveU8vcGhyR3U4bVVJ?=
 =?utf-8?B?dkRKNnN5TlNET1VwcWtiQzJWMmROVkVCVHprUlJEdWVhcGtpaWx5Y1doODJY?=
 =?utf-8?B?dG0rNUFmdmd0aXJ2cjF4R25adGhYZ3FmamJtdERjSHI4WmFwY2k4ODJDWGp5?=
 =?utf-8?B?RnhES28rZmx5ckpZcGh1V3FxVStFUXI1ei9ZajBZWFJFM0Y2SXFxbm95MWx5?=
 =?utf-8?B?Sm0vMU90Nk9GMGx0Mjg0SWJ3MDNaY2FLYmNVKy9OdU94Kzhhem9XTXpFMGpv?=
 =?utf-8?B?R3dZUU9tcnQ2cUl1cFh5M1V2dDhaRXZDUWJtMUJhd2ZGdXc0aTZ6aHgwTS9Z?=
 =?utf-8?B?QlhBOE5QSHF2Tk1pMUQxeGJST2dRZFVIYithV3RXWFFXbWp5VEc5SE5WQXZM?=
 =?utf-8?B?em9QMk1KcHhZR0NETUozZEVaK1c4ZWZHWVFxK3VsdkR1NTRDWngxN0UrSUcv?=
 =?utf-8?B?Zi8yenBJbklLVmt5SmhZUjl2ZDlUL0hobUZ6YnM3dkNFSTdkZ21admdLZytM?=
 =?utf-8?B?VXJHd0JZeXBiWi9IUWlUL25qZGVaSlZNT1F4SG9nS0U3a3JJQ2VPMlBldWJG?=
 =?utf-8?B?dmFXUlBGblo0NHdpTGNMYnJhaW14Y2ZXUnlNL29hSTV6MnFMS0xTeFhBRnRp?=
 =?utf-8?B?Zk1Hak1Bb0RQbVdxL29oNEpvdlZEZmltb2ZpSGhkT1pQSUZzYW5PeVJSenE1?=
 =?utf-8?B?em1ObWRDcW9VUS9lbDFEZUJXRlBOMnI4R2MxZnJUV2E2WEVGMEkvbzFMdzZI?=
 =?utf-8?B?bzgyMktxRGhnMVVlNGlBWDNsR2ZGTkFNM3ozMHF5TFRZQzRQaGI1Y2o1UHBU?=
 =?utf-8?B?RlRiazBBK0h0cFgxUmhIK2pWN2wzVDgraXlBY0hra2RLdkQ2TVZpbzFNbWto?=
 =?utf-8?B?c0ErL01TR01hTDZISStuV0dyK0lTaXZzZU9jTXJlVS82M2Rvblo1RDBGYUVZ?=
 =?utf-8?B?ZHo2eGxyRGRFRFlHcFZHdTBRbGFRajU0d0JZUTZRVktEazZYT0haUGNpS3di?=
 =?utf-8?B?YjBkSjFObzlvY2Iwd0I0WGtWT2t6SUF2OWpCVzZDczcyUFh6VFd0RS9peDg2?=
 =?utf-8?B?UEU2TmROQlRSeXdLb3E1TWwwTHFuM1lUaXYyMG96YkxFbThVSkFXcEMzb3VP?=
 =?utf-8?B?dmwrNHlpbkNWTmdoVW1sb0UyWTRjbnpTUWYwWmVLb2tNZ0xFM3NUbGptcmNR?=
 =?utf-8?B?a3hWK1ZjV2VtR0NuckpiQWM5UGFLQ3NtNHltV1REMzRKd281bENBS3NMSmlu?=
 =?utf-8?B?NXlHNzJlRzBzdGFUdWZRTHYwa1U3YktqZnZCcSs1MkltQnFwUnd1ZVFZZG9v?=
 =?utf-8?B?TXRDYXdMT1NRU1dINGk2a2ZZa0tQYUFiZWpqYi9iRCthRzBNZVlIbHBnNnlE?=
 =?utf-8?B?bmwzckhHZTlwMTVCdGpDU2xiV3FKeGUxSGZwZTNndnpNTHVzNlpFckNBODJ6?=
 =?utf-8?B?MGpRaVVFSWhXWlNJd3dBVDAzb3dtMERRSXZKVWJ6dC9HNGxnbkVHWHNxK0xI?=
 =?utf-8?B?TEo5bDk3cjlMalhzZjluN0tLMWxQZlZwazRNSk9MOW82UERYb2hTT0ZRUXc5?=
 =?utf-8?B?MHY1QzlnUklMcmU4NVJsZmJ1UTRENnNxZFZpZVZlOUZWcVNEeE5zVEt1QXVi?=
 =?utf-8?B?aFlmYmxrNS9QU0pZOHJGZS9tdkFWZUF6Qms1b0FYd2ZPQ2dSK1M2TFFpbk5D?=
 =?utf-8?B?R3Q5Nk1rOVBmNFI0enl6MnpnMXY1Um1UV3N2b0dKNDZMVTZybTcwWFdKaklq?=
 =?utf-8?B?NmQwcnBJL08ydDBhNzhxL2VadmtJREFUTC8vUDlnN012aGFsTzJPQ2QrMkY4?=
 =?utf-8?Q?TVrJa0YG8R0UF8tQyizG126Gq?=
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c36f85a-33aa-4a23-c09b-08dd6092d535
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 11:49:51.4412 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KbuOAZiD2I13e6RKMaqX/f/vXjunvOuPU7/P6HJeKqJ072vQm0V82FHQm8rKg82pS5HhmHT77FCAzdk0YrasWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR18MB5448
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: _WJ2CfwvojYyfBeoFPaqYH_8Cud032rt
X-Proofpoint-ORIG-GUID: _WJ2CfwvojYyfBeoFPaqYH_8Cud032rt
X-Authority-Analysis: v=2.4 cv=FdvNxI+6 c=1 sm=1 tr=0 ts=67d02362 cx=c_pps
 a=pa2+2WWV+ihErLhOOf7pAQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=-AAbraWEqlQA:10 a=0FD05c-RAAAA:8 a=8rWy6zfcAAAA:8
 a=M5GUcnROAAAA:8 a=RpNjiQI2AAAA:8 a=Z7GHiSNUfUHmViNBfOcA:9 a=QEXdDO2ut3YA:10
 a=l1rpMCqCXRGZwUSuRcM3:22 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_01,2025-03-11_02,2024-11-22_01
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
> From: Luka Jankovic <luka.jankovic@ericsson.com>
> Sent: Thursday, March 6, 2025 2:20 PM
> To: luka.jankovic@ericsson.com
> Cc: dev@dpdk.org; Jerin Jacob <jerinj@marvell.com>;
> mattias.ronnblom@ericsson.com; Pavan Nikhilesh Bhagavatula
> <pbhagavatula@marvell.com>
> Subject: [EXTERNAL] [PATCH v10 3/3] eventdev: add atomic atq to test-
> eventdev app
>=20
> Add an atomic atq test to the test-eventdev app. The test works in the sa=
me
> way as atomic queue, the difference being that only one queue capable of =
all
> types for both stages. Signed-off-by: Luka Jankovic
> <luka.=E2=80=8Ajankovic@=E2=80=8Aericsson.=E2=80=8Acom> Tested-by:=E2=80=
=8A
>=20
> Add an atomic atq test to the test-eventdev app. The test works
> in the same way as atomic queue, the difference being that only one
> queue capable of all types for both stages.
>=20
> Signed-off-by: Luka Jankovic <luka.jankovic@ericsson.com>
> Tested-by: Pavan Nikhilesh <pbhagavatula@marvell.com>


Series applied to dpdk-next-net-eventdev/for-main. Thanks
