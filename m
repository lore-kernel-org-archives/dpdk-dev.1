Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D847FC3ABD8
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 05:17:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0352400EF;
	Fri, 16 May 2025 07:17:20 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013003.outbound.protection.outlook.com [52.101.72.3])
 by mails.dpdk.org (Postfix) with ESMTP id 087CF40041;
 Fri, 16 May 2025 07:17:19 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=UZERZfI+jthtuLC1XBtv5n6qRm+cpx5FkF/cil02d1mP35VKLJsvC7ImdHYOGsQuX5JBlPxUOth4RYkfI3OW1SEmlYzjwtfN8AO1VbiQjN5XsaXOmXKQb9m8Fi4aXEn6H6HJ7f78zykhYE+zhrzStN3zWSR0YeeI3ZaBra2aNbigysmrDHijFYkj4eLjaJygB7JZl7UQn0KWNzYkkBN8rU0vwANLbLnp2Pg8VdPZrKlmMvUZ7kiQN4WxD9L+SfwzGtPvq5dGQJdpApKQVJwpPL9pDyOzqe8yPzSaDPPAknUCYPDF9xPWkvSnnuOxGF82KILSDNEmgH5cM2nLE2aaWQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmgIT4uHWgU4txiHi2DQVCSuZSHJbl3daBdn6VCVC3g=;
 b=CBmXZiZGsM3rtKXDOCV6aVkfIFmy1CWsjeBE4aiSAQaZQAVlyJr1H5SAo5m3RzP3+CxPaTCw4RNFhPfI2HpPHVBq0Agm6a6mQ3Sw680Mt0TkW0WXGg7hBp28vljyVHRzv+fUWih38sFKylUg36M0zP0va7zR5DT1yhidVYMC7I7pAATx8tAcdCbywS8YCNSpyx+dXtVdm9WN37v4hjA1E2waJOyTP14TuDcG89BL9shJ096vzdN6yflsOd7cy+1C1u/a+h/ddiGWFy5d5mlt1vzjp8tM1b79OIYYfdq8kdzBQ6pxQpR2k0llxa75I8fhAzVgZf0ylBxAM8B5VIxIRg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=iol.unh.edu smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmgIT4uHWgU4txiHi2DQVCSuZSHJbl3daBdn6VCVC3g=;
 b=oLohGf8JUvhSCkhInmecwpzRNgAGrTSUJlxofEUMVAQxl+w9mV4A/k6TnBdmwMLYdehGjWoZ2zSyVo7GGqKgS9D0r3yO8IE9unOVwdmtDd5bB8q6rg8NwjaIx0x1blKofY0uWDBsfVhT8HrpFZ85Yp5KrrWe9FmWr/vdTC6ci5Q=
Received: from DU7P190CA0001.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:550::27)
 by AM7PR08MB5448.eurprd08.prod.outlook.com (2603:10a6:20b:106::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Fri, 16 May
 2025 05:16:45 +0000
Received: from DB5PEPF00014B88.eurprd02.prod.outlook.com
 (2603:10a6:10:550:cafe::32) by DU7P190CA0001.outlook.office365.com
 (2603:10a6:10:550::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.20 via Frontend Transport; Fri,
 16 May 2025 05:16:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B88.mail.protection.outlook.com (10.167.8.196) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18
 via Frontend Transport; Fri, 16 May 2025 05:16:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HrDz4FyMLEMXhnEzIoUpxqwwd9ZOnEwB2ymoykdeoMNhKFEGO3fHFqU2yhuzK9BcT9o8r9zj57BbA3RWqfLS2bzO/NVpceQq6ig7xkT5lMdFzvauZaJwvnK75YAli1RXo45Y3can5ovS9uMxwBAufx7QRL3tt54CfxxeNWcHlm4vbeySfFR6abhhT3vnjRk/LScPUa2pP90SvNp1Kpb+bypr+NXi7pG+JY6EJU79Tt3drVmaSx2W7txE7U3Zyu2ES+7TbjzOU/f8z/1c9bEaM9sJcVkmeXXr0ooVpqScSxh0lwvZFTKY5yTgrzs6ExKON9qoZBw/P430KoyfvmJcQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmgIT4uHWgU4txiHi2DQVCSuZSHJbl3daBdn6VCVC3g=;
 b=VNV08U3a8aGMqyB3yogojrwe5XRNk0M3mECv4h7JUxWCyutq1yabyhElc0qfJ2b48QPJOokvCYeRukcpHd4g8RtW2fsjPU/x59BYgfH/DDl9x7wnrmacWJiWwbFEtyEbFS7PMIZT+GKO+kHUXQERmjmLdc3xYHvvhvmqduCzrvhxO4GHa/zZLOXpgSyC1uiZLHdaMyct5aaw4y9X5rl9rLU9q6URXUYPkpS+CcxuuEYU4hXXI/I2STyOIWvqnHeiTkgC6qfOIvPX1lr6AAQj4cGY8H59SZ2/Ujhj1bqwVtD0WnmmoGbU1Ae/YCdyvLpjdt42uTuoTEVTxsVAua0ysg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmgIT4uHWgU4txiHi2DQVCSuZSHJbl3daBdn6VCVC3g=;
 b=oLohGf8JUvhSCkhInmecwpzRNgAGrTSUJlxofEUMVAQxl+w9mV4A/k6TnBdmwMLYdehGjWoZ2zSyVo7GGqKgS9D0r3yO8IE9unOVwdmtDd5bB8q6rg8NwjaIx0x1blKofY0uWDBsfVhT8HrpFZ85Yp5KrrWe9FmWr/vdTC6ci5Q=
Received: from AS8PR08MB7339.eurprd08.prod.outlook.com (2603:10a6:20b:446::11)
 by GV2PR08MB10353.eurprd08.prod.outlook.com (2603:10a6:150:db::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Fri, 16 May
 2025 05:16:10 +0000
Received: from AS8PR08MB7339.eurprd08.prod.outlook.com
 ([fe80::98e5:ae7d:ccb9:beb8]) by AS8PR08MB7339.eurprd08.prod.outlook.com
 ([fe80::98e5:ae7d:ccb9:beb8%4]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 05:16:10 +0000
From: Doug Foster <Doug.Foster@arm.com>
To: Patrick Robb <probb@iol.unh.edu>, Wathsala Wathawana Vithanage
 <wathsala.vithanage@arm.com>
CC: "ci@dpdk.org" <ci@dpdk.org>, dev <dev@dpdk.org>, Honnappa Nagarahalli
 <Honnappa.Nagarahalli@arm.com>, "stable@dpdk.org" <stable@dpdk.org>, nd
 <nd@arm.com>
Subject: RE: meson error on ARM Grace server 23.11/22.11
Thread-Topic: meson error on ARM Grace server 23.11/22.11
Thread-Index: AQHbuLEeKJ6SB5N3OEySh9o8oTsIIrO6zhaAgBl4/ACAAIdRYA==
Date: Fri, 16 May 2025 05:16:10 +0000
Message-ID: <AS8PR08MB73396AB179C12ACDCBA214B5E593A@AS8PR08MB7339.eurprd08.prod.outlook.com>
References: <CAJvnSUBzSvUbrTMmMDhX0+QUY7nCsW0rVBnv+q6aEB3LZQ3SSw@mail.gmail.com>
 <PAWPR08MB89094F996EAC0988995DE9899F802@PAWPR08MB8909.eurprd08.prod.outlook.com>
 <CAJvnSUD6tKB8xjiSMD7Ompy4TMGL__X682z_pNDbKAK54Vv+Lw@mail.gmail.com>
In-Reply-To: <CAJvnSUD6tKB8xjiSMD7Ompy4TMGL__X682z_pNDbKAK54Vv+Lw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: AS8PR08MB7339:EE_|GV2PR08MB10353:EE_|DB5PEPF00014B88:EE_|AM7PR08MB5448:EE_
X-MS-Office365-Filtering-Correlation-Id: ab642685-a6ae-4be5-a197-08dd9438d91d
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|376014|38070700018|13003099007|8096899003|7053199007;
X-Microsoft-Antispam-Message-Info-Original: =?us-ascii?Q?nm23Gz1Tm0EoShFFc/R/oyckMvBLod/P3aA8nUw1bF9/LjBAylcJVqt8QXwM?=
 =?us-ascii?Q?XBjbCJsMLsdsjY0Y4OLc9ZmmRHWi4Sc7A/bIWRm/h/xZLl8ISJV5Pz73gUgq?=
 =?us-ascii?Q?mNWVa485aSvSaeCDTtDrO5oapZ1Ay8i9tEqLcLIMu2rhy3WzWQfnokrIF5pG?=
 =?us-ascii?Q?xDpQ2VEX2IKRV20GprQ8p5TiLRddgomNgTXTvupMifQCvVpp9z1467jWs207?=
 =?us-ascii?Q?WZHt1K0c/YeV+3KDaliMtYlGN06T6QN9lJoBSaoJIyJh9Suvh14MzXu9RlVt?=
 =?us-ascii?Q?8VAeQ9fe5D6HYWel97ijSJ34k0gtsJ3uxN1KwHIv/xs6WdYc0ZgtNNp6NdVr?=
 =?us-ascii?Q?WUgO8plpGC1N3tpM3uTxkJrv5UTVjPsmbuiuO0LN9x+zEPLOeUArAC+lH9OV?=
 =?us-ascii?Q?WFeqLvGlE7yIRV5/kQLTOKGyGiMvEsO3K5WulD72F0/B2euemG8lPewBC1Pd?=
 =?us-ascii?Q?vuk2y9H/0VQjPA/CdtPXWuvbucEAvBXWJ6bLDV+gWX+CwEosTqMFjDVzdrv7?=
 =?us-ascii?Q?cI1gATgMGXrxftqCV+YExYQHLOQvvLFAYGZAo1oPC9e6j/rVOd+chmYIrt6o?=
 =?us-ascii?Q?Cnjcf/1K441+hCgP4bVQwKEC8ZA51fjRbGUnqTn35ZFUeq+3ONQGEdWXdqoy?=
 =?us-ascii?Q?p+50WLWPBrqVcu548DdymHZ/gbJOcsSy1lT+7WTI2hsoYVDiMoJjRwl6zWC0?=
 =?us-ascii?Q?/LtVjIWh1Axn2sOkbtQP2X7QHRZD+1Blg/vtOzMEeRt+LLnW8iNiH1jrAtTi?=
 =?us-ascii?Q?olEIw8Y4NrAEQ7VMHS/ye1tQC48h4UGvr2r8eKomabVmHiMZvdp9pTdz36Ql?=
 =?us-ascii?Q?oX8B43QiGlMEuqNYjOKEhoUOT8T9jTAVT7WUqNcUFpMycKToz1oJf6DuB4kq?=
 =?us-ascii?Q?jIIJMZQAqlMdMC0lPc59Rp1xciXwOrzIzlsVSzv8eYvJzaRohZDabAIe52Xk?=
 =?us-ascii?Q?KmJpBOQgl6WeAjlZG7JQJWZUgL00t0JKvBpyc66uNmBJjdOQI2vr22UtVOgu?=
 =?us-ascii?Q?HtHXGvlzq8AV03lQyX4vn4vh9fczu3UBy9UMfpBNBj0seCftDI0BjgskNh6O?=
 =?us-ascii?Q?QR7xAB/KP8HbHi5WvkBUWZE0I2Oc9LFWop+IN7XpJ1qiER/tipoIlATimb3h?=
 =?us-ascii?Q?7IDcpGKXjR7C+rDikdWF7nTEZV1+NUdTKjb21FRKRgHUt7vOrgqaNO4PiIs+?=
 =?us-ascii?Q?G3+BYx4ZkW22Hnkn5IyMXktiN1uWdgCBGz6yvOhD2/vTwMAHiow6wVEur/Q1?=
 =?us-ascii?Q?2MmDT95XDJ3/wzc9d6OpZ36W+hJKkYob6lutsTRQ+m5yrQvMTIzR+ojYD9Lq?=
 =?us-ascii?Q?q8yCPca6MZL+fWjJsJv3SwYTpG1eHJszjskbXGxGCN6cPaU936eYkBHgsko3?=
 =?us-ascii?Q?fM7hmximhSQ3iIF1hUPoklf8RuPOuLfxR+Xw+esBOTLChG47pgos1kVyauAe?=
 =?us-ascii?Q?7Q+3l+doTDQzXoLoqC6JESlBCkYVghh1?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AS8PR08MB7339.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018)(13003099007)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
Content-Type: multipart/alternative;
 boundary="_000_AS8PR08MB73396AB179C12ACDCBA214B5E593AAS8PR08MB7339eurp_"
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB10353
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5PEPF00014B88.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8400c373-e2f7-4a7d-aebc-08dd9438c512
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|35042699022|82310400026|14060799003|1800799024|36860700013|13003099007|8096899003|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZlFTREZWaVZXb3g2VGxTVGxQam5ySlI4Y1dYZGxkc0VkZE4yV1VOYVRHczNa?=
 =?utf-8?B?TXdRV3MxS244WlBKUmFEYm9jUFgxS2hFaWFhaVcyWVZzSDZYbTNRbVJrNHhl?=
 =?utf-8?B?VUV2UTRsQ2c4M1VHMHVuOXJ6S2JqVkM1d21GdklpK3c4VU96d0gvRE1Ybnhj?=
 =?utf-8?B?TUY4UldGUlo2VnF1WklmMVlOYkpiT0hOMjNFdTI4SC8wU0ozOXdqSUhDOUlC?=
 =?utf-8?B?dmRHeHRqZ1FuUUlxSVc2S2k2cnVRSjk1ZEJhOWg0VUVrT1MzQ21ZbTNUVEg5?=
 =?utf-8?B?cnk0c2pmYUMzeS9DYXJFemFJVHpWRlNXVjV5QW9hWXdNUlVCMmhoazB1ZGFU?=
 =?utf-8?B?TWNteGhlUGNCbzBQZ0t3T1A4dFJmZjV4U1VDb09GeklSVlBwSG5EVXVrcXkx?=
 =?utf-8?B?ZWllOEwvM3U3dDVVRFBseS9YbzZlbFpTNDhKR09Fc1Zvc0FUampNM25IS1Yv?=
 =?utf-8?B?NzRJSWljdW9vR3ZBNE16UmRpeDZkNzFBWHJHU1cxbWlHeVJTSjIybzExN1FF?=
 =?utf-8?B?MUVrMUU2UG5vTlNndUhWQlB2bDZUM0JnNTlocG9qTFZmZldGTFdkcmlEa0FG?=
 =?utf-8?B?SFNmMWhSQUxkTDArU29yZitXMmtHMnloQkVMWkxrS2RjWHIvS3gwREtmcENO?=
 =?utf-8?B?Y2Q5bDFIVHhWcmJPZ0NUbFlKRGlnUW16QWhabDduYkFXL1VJU2IzSGlUdWhx?=
 =?utf-8?B?N0hhUXlZamdlWEhkSlVXd2RHTjhBZUtSQ3JkeXZGRlJzY0JmZ1ZjQ21vSlJX?=
 =?utf-8?B?NVBQdGZzakc5bmxiMWtNN0dzTWFkNGJvUnNUMnlOcXUrQmRlZjNnMEw5OW1Z?=
 =?utf-8?B?eVNoNi9IaWNMTXV5TTc1NXRHNUQzeTJZdDltdkJ5amFIOVpmOStHd1BxaXhO?=
 =?utf-8?B?dElxSjRCRjhuTjZDNEZSV05sNlpYeFEzcEdvaG54T25iNGhOR2c3Y3ZRWGYr?=
 =?utf-8?B?cXZuWXdNNFlSdmFoS2FmQzg3TklyaG1HcG16a2dFWjZqeUhvVTFRUVFieWxv?=
 =?utf-8?B?NjYrVXJZV0xYZ2VadU9vaWNVNGNyL1ZQa0VIamgxV21XbUF3R3I2ZHRRV3Vt?=
 =?utf-8?B?YXFjMWdmZnF1QWE4MnRwUHVZOWdXdmMyZStmd2w2NjQvU1A3N2RsTGw1Z3J1?=
 =?utf-8?B?NVA1azY2V0xYd3h5MlFobUtCNmZJTXlsV3U1VTdWSTBiYm5VekswcDkvR1dh?=
 =?utf-8?B?aVJ5cEgvMDVjajdpSlc3c1N5aDh2cjZDWnlOZGYrc1pWeW9qbE9VaTRmOHlL?=
 =?utf-8?B?czU1cFI3MWpIdW8xUHJnRmdiamx6eU4yKzFXbVhqV2lZZmtFTGFqaVc4MUJv?=
 =?utf-8?B?d1F6eFpmUERpRnZFMDBRZEdOQWMwR3dUaU9RekNXK2xYbmtNOFU3M0Rra01n?=
 =?utf-8?B?RDdEMXIvUmNRR1Fldi84YjZZYUlQRzJycHltZ3FqbWlsdHVUWmc3bmxpNys4?=
 =?utf-8?B?emJ0bFhZREFpb1FTYk1nRk13SkdqN1NoZzlSVU96OHB3cnE0dWNVSmhFZTlM?=
 =?utf-8?B?S2Z3VFdrbHYxUWxmSk9Pd1B4SWNUTTJsSU9ac014d0EwMWVjL3BaTG0rZUpP?=
 =?utf-8?B?UnRUWWZHVGkrYUUzUFZCZllvTVp4TEI5bDJQY29PcUxnWHpHZGZySXN6NXcw?=
 =?utf-8?B?THMzNStSRWRvYXhETGtaRDRSTUNpcHRzNldIOWxsTGpiU0FWWHdlTFg4RFl6?=
 =?utf-8?B?VFZjd3FVRGpSOU1iWGtaQnk3ZzFFUFJtMW5BbVBnZVgxY3dUZHJ2Uk1IVHUw?=
 =?utf-8?B?cjF4SEhHU0c2UDg0QXZiRjlVYU9vZUdFOUx4Z1NFcTVmK2dxY0hyNTBtN2JR?=
 =?utf-8?B?NmNWeUxZVmhId0RaMG9uWklManJ0SFptR1NUd0ZnSnR3enVNVVRaMVEwczg1?=
 =?utf-8?B?NjBFcW96dTNRM0liK0s2TWpkQlFIOHJ1VGE0czhacFlzVnZnL1JkcDJmbkZl?=
 =?utf-8?B?S2l2SmZ1ZVZUd3NGdmJhNmYwYmRSanlFZFhkRHMrdnRpajB6Wlhad2dPbFZu?=
 =?utf-8?Q?+Ga8zWw3MBdfjX6sW7gsXDdDDlb0kI=3D?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(35042699022)(82310400026)(14060799003)(1800799024)(36860700013)(13003099007)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 05:16:43.7090 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab642685-a6ae-4be5-a197-08dd9438d91d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B88.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5448
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

--_000_AS8PR08MB73396AB179C12ACDCBA214B5E593AAS8PR08MB7339eurp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgUGF0cmljaywNCg0KSSB3aWxsIHByb2R1Y2UgdGhlIHBhdGNoZXMgd2l0aCBuZWNlc3Nhcnkg
Y2hhbmdlcyB0byBidWlsZCBvbiBHcmFjZSBmb3IgMjIuMTEgYW5kIDIzLjExLg0KDQpGcm9tOiBQ
YXRyaWNrIFJvYmIgPHByb2JiQGlvbC51bmguZWR1Pg0KU2VudDogVGh1cnNkYXksIE1heSAxNSwg
MjAyNSAzOjU5IFBNDQpUbzogV2F0aHNhbGEgV2F0aGF3YW5hIFZpdGhhbmFnZSA8d2F0aHNhbGEu
dml0aGFuYWdlQGFybS5jb20+DQpDYzogY2lAZHBkay5vcmc7IGRldiA8ZGV2QGRwZGsub3JnPjsg
SG9ubmFwcGEgTmFnYXJhaGFsbGkgPEhvbm5hcHBhLk5hZ2FyYWhhbGxpQGFybS5jb20+OyBzdGFi
bGVAZHBkay5vcmc7IERvdWcgRm9zdGVyIDxEb3VnLkZvc3RlckBhcm0uY29tPjsgbmQgPG5kQGFy
bS5jb20+DQpTdWJqZWN0OiBSZTogbWVzb24gZXJyb3Igb24gQVJNIEdyYWNlIHNlcnZlciAyMy4x
MS8yMi4xMQ0KDQpUaGFua3MgV2F0aHNhbGEsDQoNCkhvdyBjYW4gd2UgaGVscCBvbiB0aGUgVU5I
IHNpZGU/IERvIHlvdSB3YW50IHVzIHRvIHByb2R1Y2UgdGhlIDIyLjExIGFuZCAyMy4xMSBkaWZm
cy9wYXRjaGVzLCB3aGljaCB3b3VsZCBiZSBiYXNlZCBvbiBkMDA3MDM4LCB3aXRoIHNvbWUgbW9k
aWZpY2F0aW9ucyBiYXNlZCBvbiB3aGF0IHlvdSBoYWQgc2FpZCB0byBEb3VnPw0KDQpJJ20gbm90
IHN1cmUgd2hhdCB0aGUgcHJvY2VzcyBsb29rcyBsaWtlIGV4YWN0bHkgZm9yIHByb3ZpZGluZyBi
YWNrcG9ydHMgdG8gTFRTIG1haW50YWluZXJzLg0KDQpPbiBUdWUsIEFwciAyOSwgMjAyNSBhdCAx
MjowMOKAr1BNIFdhdGhzYWxhIFdhdGhhd2FuYSBWaXRoYW5hZ2UgPHdhdGhzYWxhLnZpdGhhbmFn
ZUBhcm0uY29tPG1haWx0bzp3YXRoc2FsYS52aXRoYW5hZ2VAYXJtLmNvbT4+IHdyb3RlOg0KPiBI
aSwNCj4NCj4gQXQgdGhlIERQREsgQ29tbXVuaXR5IExhYiB3ZSBoYXZlIGJlZW4gcnVubmluZyBD
SSB0ZXN0cyB3aXRoIGEgbmV3IEFSTQ0KPiBHcmFjZSBzZXJ2ZXIgZm9yIHRoZSBwYXN0IGNvdXBs
ZSBvZiBtb250aHMgb24gbWFpbiBhbmQgbmV4dC0qIGJyYW5jaGVzLiBJIGFtDQo+IHRyeWluZyB0
byBhZGQgTFRTIHJ1bnMgbm93LCBhbmQgcmFuIGludG8gYSBzbmFnIHdpdGggMjMuMTEgYW5kIDIy
LjExIGZvciB0aGlzDQo+IHN5c3RlbS4gU3RhYmxlIG1haW50YWluZXJzIEknbSBub3Qgc3VyZSB3
aGV0aGVyIHRoaXMgc2hvdWxkIGJlIGFkZHJlc3NlZCBvciBub3QNCj4gZm9yIGhhcmR3YXJlIHdo
aWNoIGlzIG5ldyBhbmQgZGlkbid0IGV4aXN0IHdoZW4gMjIuMTEgYW5kIDIzLjExIHdlcmUNCj4g
cmVsZWFzZWQuLi4gYnV0IEkgZmlndXJlZCBJJ2QgbWFrZSB0aGUgdGlja2V0cyBhbmQgZmluZCBv
dXQuIEkgYXR0YWNoZWQgdGhlIG1lc29uDQo+IGxvZ3MgdG8gdGhlIHRpY2tldHMgYW5kIGlmIGZv
ciB3aGF0ZXZlciByZWFzb24geW91IGd1eXMgd2FudCB0byByZW1vdGUgaW50byB0aGlzDQo+IG1h
Y2hpbmUsIEknbSBoYXBweSB0byBzZXR1cCB0aGUgVlBOIGFuZCBTU0ggYWNjZXNzLg0KPg0KPiAy
Mi4xMTogaHR0cHM6Ly9idWdzLmRwZGsub3JnL3Nob3dfYnVnLmNnaT9pZD0xNzAzDQo+IDIzLjEx
OiBodHRwczovL2J1Z3MuZHBkay5vcmcvc2hvd19idWcuY2dpP2lkPTE3MDINCg0KK2RvdWcNCg0K
bmVvdmVyc2UtdjIgaXMgc3VwcG9ydGVkIGluIHRoZSBHQ0MgMTMuMyB1c2VkIGZvciB0aGlzIGJ1
aWxkIGFsdGhvdWdoIC1tdHVuZS8tbWNwdQ0KZm9yIGdyYWNlIGlzIG5vdCBhdmFpbGFibGUgaW4g
dGhhdCB2ZXJzaW9uLg0KQWRkaW5nIG5lb3ZlcnNlLXYyIGFuZCBzb2NfZ3JhY2Ugd2l0aCBjcnlw
dG8gZXh0ZW5zaW9uIHNob3VsZCBicmluZyB0aGVzZSByZWxlYXNlcw0Kb24gcGFyIHdpdGggbGF0
ZXN0Lg0KDQpJTVBPUlRBTlQgTk9USUNFOiBUaGUgY29udGVudHMgb2YgdGhpcyBlbWFpbCBhbmQg
YW55IGF0dGFjaG1lbnRzIGFyZSBjb25maWRlbnRpYWwgYW5kIG1heSBhbHNvIGJlIHByaXZpbGVn
ZWQuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHBsZWFzZSBub3RpZnkg
dGhlIHNlbmRlciBpbW1lZGlhdGVseSBhbmQgZG8gbm90IGRpc2Nsb3NlIHRoZSBjb250ZW50cyB0
byBhbnkgb3RoZXIgcGVyc29uLCB1c2UgaXQgZm9yIGFueSBwdXJwb3NlLCBvciBzdG9yZSBvciBj
b3B5IHRoZSBpbmZvcm1hdGlvbiBpbiBhbnkgbWVkaXVtLiBUaGFuayB5b3UuDQo=

--_000_AS8PR08MB73396AB179C12ACDCBA214B5E593AAS8PR08MB7339eurp_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWwgeG1sbnM6dj0idXJuOnNjaGVtYXMtbWljcm9zb2Z0LWNvbTp2bWwiIHhtbG5zOm89InVy
bjpzY2hlbWFzLW1pY3Jvc29mdC1jb206b2ZmaWNlOm9mZmljZSIgeG1sbnM6dz0idXJuOnNjaGVt
YXMtbWljcm9zb2Z0LWNvbTpvZmZpY2U6d29yZCIgeG1sbnM6bT0iaHR0cDovL3NjaGVtYXMubWlj
cm9zb2Z0LmNvbS9vZmZpY2UvMjAwNC8xMi9vbW1sIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcv
VFIvUkVDLWh0bWw0MCI+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIg
Y29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxtZXRhIG5hbWU9IkdlbmVyYXRv
ciIgY29udGVudD0iTWljcm9zb2Z0IFdvcmQgMTUgKGZpbHRlcmVkIG1lZGl1bSkiPg0KPHN0eWxl
PjwhLS0NCi8qIEZvbnQgRGVmaW5pdGlvbnMgKi8NCkBmb250LWZhY2UNCgl7Zm9udC1mYW1pbHk6
IkNhbWJyaWEgTWF0aCI7DQoJcGFub3NlLTE6MiA0IDUgMyA1IDQgNiAzIDIgNDt9DQpAZm9udC1m
YWNlDQoJe2ZvbnQtZmFtaWx5OkNhbGlicmk7DQoJcGFub3NlLTE6MiAxNSA1IDIgMiAyIDQgMyAy
IDQ7fQ0KQGZvbnQtZmFjZQ0KCXtmb250LWZhbWlseTpBcHRvczt9DQovKiBTdHlsZSBEZWZpbml0
aW9ucyAqLw0KcC5Nc29Ob3JtYWwsIGxpLk1zb05vcm1hbCwgZGl2Lk1zb05vcm1hbA0KCXttYXJn
aW46MGluOw0KCWZvbnQtc2l6ZToxMi4wcHQ7DQoJZm9udC1mYW1pbHk6IkFwdG9zIixzYW5zLXNl
cmlmO30NCmE6bGluaywgc3Bhbi5Nc29IeXBlcmxpbmsNCgl7bXNvLXN0eWxlLXByaW9yaXR5Ojk5
Ow0KCWNvbG9yOmJsdWU7DQoJdGV4dC1kZWNvcmF0aW9uOnVuZGVybGluZTt9DQpzcGFuLkVtYWls
U3R5bGUxOA0KCXttc28tc3R5bGUtdHlwZTpwZXJzb25hbC1yZXBseTsNCglmb250LWZhbWlseToi
Q2FsaWJyaSIsc2Fucy1zZXJpZjsNCgljb2xvcjp3aW5kb3d0ZXh0O30NCi5Nc29DaHBEZWZhdWx0
DQoJe21zby1zdHlsZS10eXBlOmV4cG9ydC1vbmx5O30NCkBwYWdlIFdvcmRTZWN0aW9uMQ0KCXtz
aXplOjguNWluIDExLjBpbjsNCgltYXJnaW46MS4waW4gMS4waW4gMS4waW4gMS4waW47fQ0KZGl2
LldvcmRTZWN0aW9uMQ0KCXtwYWdlOldvcmRTZWN0aW9uMTt9DQotLT48L3N0eWxlPjwhLS1baWYg
Z3RlIG1zbyA5XT48eG1sPg0KPG86c2hhcGVkZWZhdWx0cyB2OmV4dD0iZWRpdCIgc3BpZG1heD0i
MTAyNiIgLz4NCjwveG1sPjwhW2VuZGlmXS0tPjwhLS1baWYgZ3RlIG1zbyA5XT48eG1sPg0KPG86
c2hhcGVsYXlvdXQgdjpleHQ9ImVkaXQiPg0KPG86aWRtYXAgdjpleHQ9ImVkaXQiIGRhdGE9IjEi
IC8+DQo8L286c2hhcGVsYXlvdXQ+PC94bWw+PCFbZW5kaWZdLS0+DQo8L2hlYWQ+DQo8Ym9keSBs
YW5nPSJFTi1VUyIgbGluaz0iYmx1ZSIgdmxpbms9InB1cnBsZSIgc3R5bGU9IndvcmQtd3JhcDpi
cmVhay13b3JkIj4NCjxkaXYgY2xhc3M9IldvcmRTZWN0aW9uMSI+DQo8cCBjbGFzcz0iTXNvTm9y
bWFsIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjExLjBwdDtmb250LWZhbWlseTomcXVvdDtDYWxp
YnJpJnF1b3Q7LHNhbnMtc2VyaWYiPkhpIFBhdHJpY2ssPG86cD48L286cD48L3NwYW4+PC9wPg0K
PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMS4wcHQ7Zm9udC1m
YW1pbHk6JnF1b3Q7Q2FsaWJyaSZxdW90OyxzYW5zLXNlcmlmIj48bzpwPiZuYnNwOzwvbzpwPjwv
c3Bhbj48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEx
LjBwdDtmb250LWZhbWlseTomcXVvdDtDYWxpYnJpJnF1b3Q7LHNhbnMtc2VyaWYiPkkgd2lsbCBw
cm9kdWNlIHRoZSBwYXRjaGVzIHdpdGggbmVjZXNzYXJ5IGNoYW5nZXMgdG8gYnVpbGQgb24gR3Jh
Y2UgZm9yIDIyLjExIGFuZCAyMy4xMS48bzpwPjwvbzpwPjwvc3Bhbj48L3A+DQo8cCBjbGFzcz0i
TXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjExLjBwdDtmb250LWZhbWlseTomcXVv
dDtDYWxpYnJpJnF1b3Q7LHNhbnMtc2VyaWYiPjxvOnA+Jm5ic3A7PC9vOnA+PC9zcGFuPjwvcD4N
CjxkaXYgc3R5bGU9ImJvcmRlcjpub25lO2JvcmRlci1sZWZ0OnNvbGlkIGJsdWUgMS41cHQ7cGFk
ZGluZzowaW4gMGluIDBpbiA0LjBwdCI+DQo8ZGl2Pg0KPGRpdiBzdHlsZT0iYm9yZGVyOm5vbmU7
Ym9yZGVyLXRvcDpzb2xpZCAjRTFFMUUxIDEuMHB0O3BhZGRpbmc6My4wcHQgMGluIDBpbiAwaW4i
Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PGI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMS4wcHQ7
Zm9udC1mYW1pbHk6JnF1b3Q7Q2FsaWJyaSZxdW90OyxzYW5zLXNlcmlmIj5Gcm9tOjwvc3Bhbj48
L2I+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMS4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7Q2FsaWJy
aSZxdW90OyxzYW5zLXNlcmlmIj4gUGF0cmljayBSb2JiICZsdDtwcm9iYkBpb2wudW5oLmVkdSZn
dDsNCjxicj4NCjxiPlNlbnQ6PC9iPiBUaHVyc2RheSwgTWF5IDE1LCAyMDI1IDM6NTkgUE08YnI+
DQo8Yj5Ubzo8L2I+IFdhdGhzYWxhIFdhdGhhd2FuYSBWaXRoYW5hZ2UgJmx0O3dhdGhzYWxhLnZp
dGhhbmFnZUBhcm0uY29tJmd0Ozxicj4NCjxiPkNjOjwvYj4gY2lAZHBkay5vcmc7IGRldiAmbHQ7
ZGV2QGRwZGsub3JnJmd0OzsgSG9ubmFwcGEgTmFnYXJhaGFsbGkgJmx0O0hvbm5hcHBhLk5hZ2Fy
YWhhbGxpQGFybS5jb20mZ3Q7OyBzdGFibGVAZHBkay5vcmc7IERvdWcgRm9zdGVyICZsdDtEb3Vn
LkZvc3RlckBhcm0uY29tJmd0OzsgbmQgJmx0O25kQGFybS5jb20mZ3Q7PGJyPg0KPGI+U3ViamVj
dDo8L2I+IFJlOiBtZXNvbiBlcnJvciBvbiBBUk0gR3JhY2Ugc2VydmVyIDIzLjExLzIyLjExPG86
cD48L286cD48L3NwYW4+PC9wPg0KPC9kaXY+DQo8L2Rpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwi
PjxvOnA+Jm5ic3A7PC9vOnA+PC9wPg0KPGRpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFs
Ij5UaGFua3MgV2F0aHNhbGEsIDxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xh
c3M9Ik1zb05vcm1hbCI+PG86cD4mbmJzcDs8L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBj
bGFzcz0iTXNvTm9ybWFsIj5Ib3cgY2FuIHdlIGhlbHAgb24gdGhlIFVOSCBzaWRlPyBEbyB5b3Ug
d2FudCB1cyB0byBwcm9kdWNlIHRoZSAyMi4xMSBhbmQgMjMuMTEgZGlmZnMvcGF0Y2hlcywgd2hp
Y2ggd291bGQgYmUgYmFzZWQgb24gZDAwNzAzOCwgd2l0aCBzb21lIG1vZGlmaWNhdGlvbnMgYmFz
ZWQgb24gd2hhdCB5b3UgaGFkIHNhaWQgdG8gRG91Zz88bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0K
PGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxvOnA+Jm5ic3A7PC9vOnA+PC9wPg0KPC9kaXY+
DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+SSdtIG5vdCBzdXJlIHdoYXQgdGhlIHByb2Nl
c3MgbG9va3MgbGlrZSBleGFjdGx5IGZvciBwcm92aWRpbmcgYmFja3BvcnRzIHRvIExUUyBtYWlu
dGFpbmVycy48bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPC9kaXY+DQo8cCBjbGFzcz0iTXNvTm9y
bWFsIj48bzpwPiZuYnNwOzwvbzpwPjwvcD4NCjxkaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05v
cm1hbCI+T24gVHVlLCBBcHIgMjksIDIwMjUgYXQgMTI6MDA8c3BhbiBzdHlsZT0iZm9udC1mYW1p
bHk6JnF1b3Q7QXJpYWwmcXVvdDssc2Fucy1zZXJpZiI+4oCvPC9zcGFuPlBNIFdhdGhzYWxhIFdh
dGhhd2FuYSBWaXRoYW5hZ2UgJmx0OzxhIGhyZWY9Im1haWx0bzp3YXRoc2FsYS52aXRoYW5hZ2VA
YXJtLmNvbSI+d2F0aHNhbGEudml0aGFuYWdlQGFybS5jb208L2E+Jmd0OyB3cm90ZTo8bzpwPjwv
bzpwPjwvcD4NCjwvZGl2Pg0KPGJsb2NrcXVvdGUgc3R5bGU9ImJvcmRlcjpub25lO2JvcmRlci1s
ZWZ0OnNvbGlkICNDQ0NDQ0MgMS4wcHQ7cGFkZGluZzowaW4gMGluIDBpbiA2LjBwdDttYXJnaW4t
bGVmdDo0LjhwdDttYXJnaW4tcmlnaHQ6MGluIj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxl
PSJtYXJnaW4tYm90dG9tOjEyLjBwdCI+Jmd0OyBIaSw8YnI+DQomZ3Q7IDxicj4NCiZndDsgQXQg
dGhlIERQREsgQ29tbXVuaXR5IExhYiB3ZSBoYXZlIGJlZW4gcnVubmluZyBDSSB0ZXN0cyB3aXRo
IGEgbmV3IEFSTTxicj4NCiZndDsgR3JhY2Ugc2VydmVyIGZvciB0aGUgcGFzdCBjb3VwbGUgb2Yg
bW9udGhzIG9uIG1haW4gYW5kIG5leHQtKiBicmFuY2hlcy4gSSBhbTxicj4NCiZndDsgdHJ5aW5n
IHRvIGFkZCBMVFMgcnVucyBub3csIGFuZCByYW4gaW50byBhIHNuYWcgd2l0aCAyMy4xMSBhbmQg
MjIuMTEgZm9yIHRoaXM8YnI+DQomZ3Q7IHN5c3RlbS4gU3RhYmxlIG1haW50YWluZXJzIEknbSBu
b3Qgc3VyZSB3aGV0aGVyIHRoaXMgc2hvdWxkIGJlIGFkZHJlc3NlZCBvciBub3Q8YnI+DQomZ3Q7
IGZvciBoYXJkd2FyZSB3aGljaCBpcyBuZXcgYW5kIGRpZG4ndCBleGlzdCB3aGVuIDIyLjExIGFu
ZCAyMy4xMSB3ZXJlPGJyPg0KJmd0OyByZWxlYXNlZC4uLiBidXQgSSBmaWd1cmVkIEknZCBtYWtl
IHRoZSB0aWNrZXRzIGFuZCBmaW5kIG91dC4gSSBhdHRhY2hlZCB0aGUgbWVzb248YnI+DQomZ3Q7
IGxvZ3MgdG8gdGhlIHRpY2tldHMgYW5kIGlmIGZvciB3aGF0ZXZlciByZWFzb24geW91IGd1eXMg
d2FudCB0byByZW1vdGUgaW50byB0aGlzPGJyPg0KJmd0OyBtYWNoaW5lLCBJJ20gaGFwcHkgdG8g
c2V0dXAgdGhlIFZQTiBhbmQgU1NIIGFjY2Vzcy48YnI+DQomZ3Q7IDxicj4NCiZndDsgMjIuMTE6
IDxhIGhyZWY9Imh0dHBzOi8vYnVncy5kcGRrLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MTcwMyIgdGFy
Z2V0PSJfYmxhbmsiPmh0dHBzOi8vYnVncy5kcGRrLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MTcwMzwv
YT48YnI+DQomZ3Q7IDIzLjExOiA8YSBocmVmPSJodHRwczovL2J1Z3MuZHBkay5vcmcvc2hvd19i
dWcuY2dpP2lkPTE3MDIiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL2J1Z3MuZHBkay5vcmcvc2hv
d19idWcuY2dpP2lkPTE3MDI8L2E+PGJyPg0KPGJyPg0KK2RvdWc8YnI+DQo8YnI+DQpuZW92ZXJz
ZS12MiBpcyBzdXBwb3J0ZWQgaW4gdGhlIEdDQyAxMy4zIHVzZWQgZm9yIHRoaXMgYnVpbGQgYWx0
aG91Z2ggLW10dW5lLy1tY3B1PGJyPg0KZm9yIGdyYWNlIGlzIG5vdCBhdmFpbGFibGUgaW4gdGhh
dCB2ZXJzaW9uLjxicj4NCkFkZGluZyBuZW92ZXJzZS12MiBhbmQgc29jX2dyYWNlIHdpdGggY3J5
cHRvIGV4dGVuc2lvbiBzaG91bGQgYnJpbmcgdGhlc2UgcmVsZWFzZXM8YnI+DQpvbiBwYXIgd2l0
aCBsYXRlc3QuIDxicj4NCjxicj4NCjxvOnA+PC9vOnA+PC9wPg0KPC9ibG9ja3F1b3RlPg0KPC9k
aXY+DQo8L2Rpdj4NCjwvZGl2Pg0KSU1QT1JUQU5UIE5PVElDRTogVGhlIGNvbnRlbnRzIG9mIHRo
aXMgZW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBhcmUgY29uZmlkZW50aWFsIGFuZCBtYXkgYWxz
byBiZSBwcml2aWxlZ2VkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBw
bGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYW5kIGRvIG5vdCBkaXNjbG9zZSB0
aGUgY29udGVudHMgdG8gYW55IG90aGVyIHBlcnNvbiwgdXNlIGl0IGZvciBhbnkgcHVycG9zZSwN
CiBvciBzdG9yZSBvciBjb3B5IHRoZSBpbmZvcm1hdGlvbiBpbiBhbnkgbWVkaXVtLiBUaGFuayB5
b3UuDQo8L2JvZHk+DQo8L2h0bWw+DQo=

--_000_AS8PR08MB73396AB179C12ACDCBA214B5E593AAS8PR08MB7339eurp_--
