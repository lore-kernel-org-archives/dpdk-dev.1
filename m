Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6EECAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 15:11:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92DE04065E;
	Wed, 24 Sep 2025 17:11:07 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013001.outbound.protection.outlook.com
 [52.101.83.1]) by mails.dpdk.org (Postfix) with ESMTP id CEF8D4027C
 for <dev@dpdk.org>; Wed, 24 Sep 2025 15:29:30 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=R8eeI1QflqzH3i1w3hsNPf3KTJmCVPbzEe1cVpASC4rhHvK8yNQmAR1gnteSs7E7ys3TdwIj6ThWFFrQDbYueraF5PyYTD/IQXHOaO4c/j4I1ocK0jdNRcW51giMZdESwS67ieJGx5iZcZhe09S06HB9rZAXvC3YMnnRuP9kxT/6loLA1wGNnha4WfcoSAD1XCkm6Y0wRxttzuiBckvyz+RYHwy/poao2O4xZevxVRc3YJXsBViApuyhY94fZhDTjAFrCZ7PITRxwcVSQyU24UpDEplpMPHOqVOHbo4yP3mo7C+uNeCPWkJiwUXhqti//lEIGlpOLDepm61CsauApw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8J54aMyGaoaNXrOgbTJ18wPfw5oPYTKe9M/fcDFcArE=;
 b=EqGtSp15/cIby28/opl87iou1eSRsYNeEfkdgIG6jn/GI8tLaEaReM9vXqi/gBkxkYB+jIPPslKxqQR2VAeL4WwOzGVZ8o18wrGXexV59IlINcO7HGMRDWbMiC9yc9gy0qNatiNaCTMqgFfRmdvVOzOnPQ3GcHAFAO0qx974B9nB5RBJA7bd5ZznswXniqNaW78m38do4mvyajc23GnmcbT3aMRetfhY2RROvoeSm4uUBNPrRc3AbuUzERc2imqFg2sfHgQHl4MT7V18Uwuj73RGxwXqsQwMhdwgNppn9b7GiY44E7okNsGKec8B7rZlxq7DmpR7ed1abv+eqND8RQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=huawei.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8J54aMyGaoaNXrOgbTJ18wPfw5oPYTKe9M/fcDFcArE=;
 b=afTmoDZZJ9YlOfP7KbZrQ5wF4z+xpsWVb2UITNSOAwh3Sjwn6qSHXbbmw1oPnl+mW3REFURwcFNbZ2VdAAgt0ulgAaW+9AyUz7EpelbceVlFmWI9neAq2ldsXWUAkJTACRvHV1/4APmt33G0vZhzkTmqllAdsvQ5jU0LwaSFhdI=
Received: from AS4P251CA0022.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:5d3::14)
 by GVXPR08MB10833.eurprd08.prod.outlook.com (2603:10a6:150:158::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 13:29:24 +0000
Received: from AM3PEPF00009B9E.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d3:cafe::89) by AS4P251CA0022.outlook.office365.com
 (2603:10a6:20b:5d3::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Wed,
 24 Sep 2025 13:29:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF00009B9E.mail.protection.outlook.com (10.167.16.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.9
 via Frontend Transport; Wed, 24 Sep 2025 13:29:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LlZqPfbcb4S1LeukIlW5QlrO2T+5h6DnifSHFmdJfcloiiWP8ritQ8XMl/u7LFAzAP27yOac1Yu0SloyQhflOSGfeuCIh0qR1K4z+3YPDg28FGx1Ghdo25DP+JKEcQbpzq3+o0Ak5hbVgsjIGxEsynKtj8iI0ZYqxWRBK5NyCStjruO3CSG+KENK0rTOiA+HjtGKPbQfImblqElJDzdUW9WK/KYkJLNYpFEp6NCkEUvwBB2wsScC8FNxXYXlNmz7hf5+dZAS0Y7OCCBV5o8beC9ayq934m9IXPiCOiCVbVUlka6CAcDxTuJuTbTARi6U8J0rRsfTNfHQmEolaoz/9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8J54aMyGaoaNXrOgbTJ18wPfw5oPYTKe9M/fcDFcArE=;
 b=BVa+UTV+a12Ckl8ga+0Uy5ktqjh8ZUMNrmQcHqSJPKT7cFJwXzFXhrnRMCYND5Hd5UFxqRHom2AO9hzJBv6WTCo/35uNzqvkxLhz0Xz8BxeiqBi5Rkofh9W4p1nU8rhkbTcuSXqR90pQXffNoQd+oNsWiB0e9QoPzyTzM7rp7S0ZKadeVZmTjp+l9UCYcWoiKMvEDEep1GcQTaTXQ/lXpR6ChFCETAgfGz1lKgzBJwwm2OE2vJFPvZ3JAfLp8UCOUvfuotu5+/JCzzd1S/K9fRICK+S8e2JlTMQ1CdBfaF/pLmwx86hUsIYw4BV1Dii8udNt2kA1EKCS1NsHPGhUhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8J54aMyGaoaNXrOgbTJ18wPfw5oPYTKe9M/fcDFcArE=;
 b=afTmoDZZJ9YlOfP7KbZrQ5wF4z+xpsWVb2UITNSOAwh3Sjwn6qSHXbbmw1oPnl+mW3REFURwcFNbZ2VdAAgt0ulgAaW+9AyUz7EpelbceVlFmWI9neAq2ldsXWUAkJTACRvHV1/4APmt33G0vZhzkTmqllAdsvQ5jU0LwaSFhdI=
Received: from DU0PR08MB9557.eurprd08.prod.outlook.com (2603:10a6:10:44e::14)
 by AM7PR08MB5480.eurprd08.prod.outlook.com (2603:10a6:20b:de::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 13:28:51 +0000
Received: from DU0PR08MB9557.eurprd08.prod.outlook.com
 ([fe80::fdd1:fe93:89d8:1c07]) by DU0PR08MB9557.eurprd08.prod.outlook.com
 ([fe80::fdd1:fe93:89d8:1c07%3]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 13:28:51 +0000
From: Ola Liljedahl <Ola.Liljedahl@arm.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>, Honnappa Nagarahalli
 <Honnappa.Nagarahalli@arm.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Dhruv Tripathi <Dhruv.Tripathi@arm.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH 1/1] ring: safe partial ordering for head/tail update
Thread-Topic: [PATCH 1/1] ring: safe partial ordering for head/tail update
Thread-Index: AQHcJnJiBml2HHEBUEWClQ4fxxecK7SWYP5wgABfdICAADf1oIAAQKiAgATGqYCABX8KAIAAdQaAgAAPLICAADKHAP//8/gAgAA3n4D//+UCAIAAPOEA
Date: Wed, 24 Sep 2025 13:28:50 +0000
Message-ID: <BD3A1BB1-B778-46DE-94BA-6E27DA4B0B08@arm.com>
References: <20250915185451.533039-1-wathsala.vithanage@arm.com>
 <20250915185451.533039-2-wathsala.vithanage@arm.com>
 <a5fae8a9edc947fdbaf4e2519c39f93e@huawei.com>
 <2a611c3cf926d752a54b7655c27d6df874a2d0de.camel@arm.com>
 <61a9d5b157be4816aa296194f9c0eabe@huawei.com>
 <4173E44D-BB31-45B9-AF6A-553B1E755604@arm.com>
 <64a7def62ee642139c3af31ce4fd94e9@huawei.com>
 <EF1C5BFC-B9C7-4D38-8FDC-FF412DD45C21@arm.com>
 <8eab3da6eb2944a4a4a197aeb38ee2f1@huawei.com>
 <d485010b97654d09a1921b97879faf90@huawei.com>
 <71C73931-11EA-4B4C-8FFF-F82A2B2F7520@arm.com>
 <2421eba5de7c4586a7b80dda29078eb2@huawei.com>
 <9B712773-4A39-4D09-9313-1623EE30F209@arm.com>
 <73287d6c09d049aa994a1d17962130b9@huawei.com>
In-Reply-To: <73287d6c09d049aa994a1d17962130b9@huawei.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.100.25090553
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: DU0PR08MB9557:EE_|AM7PR08MB5480:EE_|AM3PEPF00009B9E:EE_|GVXPR08MB10833:EE_
X-MS-Office365-Filtering-Correlation-Id: cc77f82a-0ada-4e4d-e9b4-08ddfb6e60e8
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?aG9TNEE2akxoM0pVUmxYa0x4MHBqd2xTQnVQendvN1c4MGl3cEZBZ2xramZN?=
 =?utf-8?B?SGNPTmtpWkZJaE80QmpZcDRIRmRHcEc4MURJSjJ2aUt2N3ZCQ3pxQXUyNjNL?=
 =?utf-8?B?S2JvUFJqNU1qOGVkQTUzNklmTmE5T0RXM0hFMEFYY1FsS3U3SkQ4UmM0WXRj?=
 =?utf-8?B?U1RkNzdSYnRNZEdCNlcydHhocFRLM0laRUJIV29VamlXUUptYVNiL3ZGcEho?=
 =?utf-8?B?Zk1nMURZMHVCM3YyMk9SZjZNeis0MUxBTEhMOERZdU9FN2gvVWhMSVNaZ0sw?=
 =?utf-8?B?WHJLaUYzSmdzRFFuRVEzS0NVcVpHNWJWQmRvOTdhQnhkaGVuekpSYmx4SzFq?=
 =?utf-8?B?UzhCOFpzU2dmeDNYZnZ2b1JicitZL3RDaXJMRjg1ZzlHZWs2cllwRDVJT0po?=
 =?utf-8?B?Ny9OTll2MjIvSk1ZbytVdWZHMkJPRFdYR05WT1FPQ0MwTk5Sb2N1dkhJb2or?=
 =?utf-8?B?ZnJFWndCbDdKdWRtbkF6QmcyTXJSdmQ5UDVibjhMNXRkZk5tWVpScTRNSENS?=
 =?utf-8?B?cW91dDBzRXdIMjVSdnYyQlFEcWlKQWE1czZ2TDY4VGNNMEhmcGxUN1BVVXVD?=
 =?utf-8?B?VmJmM281NHNuaU1rSi83T3R6RS9jdEJlSUtRU0I2Q1gzK0t5SHNSYU0wN3pR?=
 =?utf-8?B?anlXbS85K3hUcVpUUXJjc3ZPbHhLOUNvOUpIZktjZXlNeHM4UEZMb3NYYlVR?=
 =?utf-8?B?cmRFcE1uWnE2c2VRdmJJc2Jja1VxL24vRWZzeGhDNGV6a05ZRnpXWVFjeTMv?=
 =?utf-8?B?UTIrUjR6UDd5M2djTStwSUZTZjZTNkpTaFBVTXB4SXlXTjREMjJmTUdveDJt?=
 =?utf-8?B?TzBUR1dEM0RETXVBTDJvTVc4ZEpTV0hkNmhweEhaclI0SlJpbjJiOUZJTjF3?=
 =?utf-8?B?M3VTZ3hTRVNWbFVPWjlCVXNveDVXdjBiZjdWc3YzQ3RpQnRUeXNLdjZNU2F1?=
 =?utf-8?B?b2lHeDdhZ2cvZmdVazdBSG9jYmtPY1gwVDIvSjdpT25sT3lORkgwNjM5Y2tn?=
 =?utf-8?B?SzVOa1haVGt6VzFtUzIxckdYdEpqeFo5YlpSUVVLcjN4VWZJUy80NDJrdnBV?=
 =?utf-8?B?amFFTVNnOFRRclkyaHpUSllrVW1iZGlOZ3pNc3Z0UUc1ZWFFdEJYVUVhM1VH?=
 =?utf-8?B?LzNncGtOaTdhL2VGRHdJWGU4OExHQ1BjcXFQVWNmR3RQdkpQU2FMVWZWYW9t?=
 =?utf-8?B?SkM3c0dYcTVnK1lKQ0xhMDJLeDA5UjdMbDNLOWsxQ1hOZTFLei9RVEMvSTUz?=
 =?utf-8?B?YkY3N3hMNVNuV3o5MHdNRmRwRlNueFRtQVBlQWxJeXN0Mmk2NGluZytaWE5k?=
 =?utf-8?B?dno5cUVmaG56QzdtMW9WeXZjQlBNQUZid0NWSVFYL0xZeHlCK1o0KzlMRUZa?=
 =?utf-8?B?WGRZYWgxTm1PWlZDMktZZThhbG4weFU5dGlNMGNQMXE4M3ZicXlibXQ0ZG5V?=
 =?utf-8?B?UnNmVWp1Zzg3VFpXUXg4OFQxcktyU0NINTMrQldaQi9nWDFDaHhSRGpqWnZL?=
 =?utf-8?B?Y3RIY3hoTi9vS2c1bTdoTWhVNVRGTXEwTllySm4rUVVxSUlBazFEcWsxQmxL?=
 =?utf-8?B?Sld4dEh1YVdjdHExc1NkWFlGMXlJRVdlcDdXbDRwY1dGVDRmMloxTFo5N3d4?=
 =?utf-8?B?RVdONEZabUljVFRkd2JOQnN6NVdvTDd6aWdtS2hvSEcvbW5QOW9RRmZ0M0Rk?=
 =?utf-8?B?YzNUbExzUzhsRVZ0ZFl6SmFVdDVYTmVJR3NKQzRaN3RhSG4xa0pHZWNaYVJ4?=
 =?utf-8?B?U2lmNitIb1JuU3dIZElIN0xjaDNQcWwwU2lMbkVZSVVZUXpWbWx1WWJvdmc1?=
 =?utf-8?B?YStOOUxmLy9OSUZpTlZMR3E0aVhaajJBOW1idGE2YmZXTnc5TU9DQ0tSTkFL?=
 =?utf-8?B?Qjd0MEtTRG5za29sNzdoSFFQZlkrV1hzSmVvLzFLU3ozSUo5UFh2UUNNaEFR?=
 =?utf-8?B?TGxmUW5ybFQrOGpObXVrbXN1YSt6VnpQT1NQMTQ3SzJpREZKSVdHQVk2VWh0?=
 =?utf-8?Q?fwE6rhFp/AKfxIFFQDdKyArJH0Ublo=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DU0PR08MB9557.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700021);
 DIR:OUT; SFP:1101; 
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC3678253DBC8344888761D1E50C82A2@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5480
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF00009B9E.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b3f7bbb2-0516-42ad-ec54-08ddfb6e4cdc
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|14060799003|82310400026|1800799024|35042699022|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QTBZRzVmWnhkbzhuNTh2c01XUHlRVkMwU2oxRWdTSG8zU21nc09VaG5RWlRG?=
 =?utf-8?B?dkNKZHphYjZZVUFMVE1LSkZ0UDEvOFFQb0UySENnN05rcU5oSUFMNnBMc0FL?=
 =?utf-8?B?QUNSeitIenNqdkM5RzFsL2x1aFpMNmozQjhPeCtieURuMi9vSExodVBRRW9H?=
 =?utf-8?B?L2Vwc3g1aTRwamw0bXZVc3ZKSXRPK1VnY001WjE2c1NkSHFvZm1wTUwva25T?=
 =?utf-8?B?QnVLZ3QxZGlybUMvT1VVaFJ6UTBpbCtqai9tNWxCVkIzMjBnQjBCSmxSRXdE?=
 =?utf-8?B?NFpuTExWbTREZXErRFh3S3htQWxCSTRVd2NUd0ZCZDRYLzMrbWtQemxQd3ZI?=
 =?utf-8?B?MWNEb0loN09YYXBvOXpNWk5ZY29ad3YzaEtrbDlBM1RJTXJYaC9jUDNPT0tU?=
 =?utf-8?B?M0hPQlNycWJ0akNlNUdMVW9Ham5ZdHV4QzZNK0dSdWZVQlFvUFFobGJ4UVRF?=
 =?utf-8?B?aUhwcEJtalJGUmJDL2luUFFqbXpIMmpFOTZrSndUMFMzRGtwMWFqMlc4dmt3?=
 =?utf-8?B?S2dvN2V6Z0p4QW0zdXdVclZyTTdCVVkzRGZ6cXgvTE5LM3JzMEhLdE5WeFhl?=
 =?utf-8?B?UEljd2xxQ1E1UFlFM1BVM2g1cmlnNXZkK2JjeG0wT1gxY0NBRXk5V2Nxdk11?=
 =?utf-8?B?U0s5d2Z0SklpZkdHZTF3akdSUVE3N1h5R1NxVlYrVlFwRi9jL0tSMklUMnJR?=
 =?utf-8?B?cURaT05WZWRjVFF5TDBlQ3p6TWUrTjhVRjBJZWNER2tQNG5NNHVIcm5KZTgr?=
 =?utf-8?B?bEZzcGI2WmI2bitURDdYa0UvZFZuNWNtRXRJYmpSay80KzRja2FSRzR4RXVC?=
 =?utf-8?B?M2tLNVhJN2hsVElTNEZCNEQ0VVFxa1IzRlNEWXBSeUZFQUxwc1dOSm0zVjJa?=
 =?utf-8?B?Szl5MGY4RiszbmNsb3B4Zmc0TkpLLzc0Nm42VkhXeGxxek1pR2FFUHNGTWgx?=
 =?utf-8?B?Nk1BS1o2RlZWWTVna1VlelgxaW1FOGhieVJOcEU5b2dzZEV5K3BpOGJ4R09B?=
 =?utf-8?B?SWQ4cG5mVjZpMXRpem5NbWZmOTNrTkt3ODQ4ZGllaXgwRm01UERsRWNhaVhV?=
 =?utf-8?B?U3dUL2xpWkg0cmZuRHh4cHIyV3BwcDV3TEQ2bjJFMFlsVEhPK1cxLzVKSm44?=
 =?utf-8?B?ZHJ1bGdNd1dXUGRFSHB0bzJNd01oQ0p1eFZZekxPQ2JiSkZMSWJ4TVJRUmEr?=
 =?utf-8?B?ZWs0V3hpdXFxM2J3WkdKc2J5aitwdWUwdjdrWnZBVXpFRTdxbTZnVUhRN041?=
 =?utf-8?B?YXZxa0dyeWdWWFUzc0RrRWxMd05nY1RDUzUzcXpKNGk3bm9SYnRkMnhSZjZZ?=
 =?utf-8?B?a0lhV3l0Y1gvcGZsaFZyaHJmOXVESHN0NVk5a1A4bmJKNmRPV1ZYVDJyTUVx?=
 =?utf-8?B?ZVZTTG5xdmNRWFYveUVtL1dKbE5wZHdtdGVyNFFJS3FjSVlMZWkvTXFQNUxM?=
 =?utf-8?B?SmJ4SzJ4ZEVLYnNDYWVzRHRJaW9LRWJDaVVPZGFrUHpzL2NIVW1iRmZrQWJz?=
 =?utf-8?B?QWZIdzZvNUk2RDBsSS9NR0QxQVA1TndrZlJVYjBCRVltMkRzNndZN2VnaVJh?=
 =?utf-8?B?MlFneFUrSHZsWk5rQnYvc0c2cWJjVk9laFlzWHhTQjZLS1NSVjJWVXZzMUZy?=
 =?utf-8?B?VlEyMlh5UksrSktGSHJ3NkM2aTQ4OWx5dHR0VVVRbm4rbnQwbW5iQWtEcWpi?=
 =?utf-8?B?QTR4SWtOSWRvcVFHQ25TQlAxdDVGVjJRRFNicnhjci9ETnB6a1p4Q2xmUTlN?=
 =?utf-8?B?eUQ2Z2U0K3F0TzlLdUxCTmNteTcycmwzUVB3RjF4RnpMSG1JMW4vaS9DWnpH?=
 =?utf-8?B?YnF3NlVESm5abUY4SnVOOUZrVlNLODk0cjRuWEttUnMvWXQ0ZUl6NitSS0JF?=
 =?utf-8?B?Ui9ROTUxTlFQSkNKRSthVHhvcGtXZVdyN3JhZ3dLZEt4M0hiZTd3UUxEbHNW?=
 =?utf-8?B?b3ZOVExndVZVeHFiZUJYbFZ2SDF5a2NueURYc1JPNFY1SFlNS21zOGsxYkZR?=
 =?utf-8?B?d3lGRkUxbFNIb2dsa3FrbDUrSVFXYVE5aW9ZQVcvOUsrTUw3dTdxQVhMUTRv?=
 =?utf-8?Q?IwjQag?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(14060799003)(82310400026)(1800799024)(35042699022)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 13:29:24.6184 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc77f82a-0ada-4e4d-e9b4-08ddfb6e60e8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10833
X-Mailman-Approved-At: Wed, 24 Sep 2025 17:11:06 +0200
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

PiBPbiAyMDI1LTA5LTI0LCAxMzo1MSwgIktvbnN0YW50aW4gQW5hbnlldiIgPGtvbnN0YW50aW4u
YW5hbnlldkBodWF3ZWkuY29tIDxtYWlsdG86a29uc3RhbnRpbi5hbmFueWV2QGh1YXdlaS5jb20+
PiB3cm90ZToNCj4NCj4gPiA+ID4gPiA+IFN1cmUsIEkgYW0gdGFsa2luZyBhYm91dCBNVCBzY2Vu
YXJpby4NCj4gPiA+ID4gPiA+IEkgdGhpbmsgSSBhbHJlYWR5IHByb3ZpZGVkIGFuIGV4YW1wbGU6
IERQREsgbWVtcG9vbCBsaWJyYXJ5IChzZWUgYmVsb3cpLg0KPiA+ID4gPiA+ID4gSW4gYnJpZWYs
IEl0IHdvcmtzIGxpa2UgdGhhdDoNCj4gPiA+ID4gPiA+IEF0IGluaXQgaXQgYWxsb2NhdGVzIHJp
bmcgb2YgTiBtZW1vcnkgYnVmZmVycyBhbmQgcmluZyBiaWcgZW5vdWdoIHRvIGhvbGQgYWxsIG9m
DQo+ID4gPiA+IHRoZW0uDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBTb3JyeSwgSSBtZWFudCB0byBz
YXk6ICJpdCBhbGxvY2F0ZXMgTiBtZW1vcnkgYnVmZmVycyBhbmQgcmluZyBiaWcgZW5vdWdoIHRv
DQo+ID4gaG9sZA0KPiA+ID4gPiBhbGwgb2YgdGhlbSIuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+
IFRoZW4gaXQgZW5xdWV1ZXMgYWxsIGFsbG9jYXRlZCBtZW1vcnkgYnVmZmVycyBpbnRvIHRoZSBy
aW5nLg0KPiA+ID4gPiA+ID4gbWVtcG9vbF9nZXQgLSByZXRyaWV2ZXMgKGRlcXVldWVzKSBidWZm
ZXJzIGZyb20gdGhlIHJpbmcuDQo+ID4gPiA+ID4gPiBtZW1wb29sX3B1dCAtIHB1dHMgdGhlbSBi
YWNrIChlbnF1ZXVlcykgdG8gdGhlIHJpbmcNCj4gPiA+ID4gPiA+IGdldCgpIG1pZ2h0IGZhaWwg
KEVOT01FTSksIHdoaWxlIHB1dCBpcyBleHBlY3RlZCB0byBhbHdheXMgc3VjY2VlZC4NCj4gPiA+
ID4gQnV0IGhvdyBkb2VzIHRoZSB0aHJlYWQgd2hpY2ggY2FsbHMgbWVtcG9vbF9wdXQoKSBnZXQg
aG9sZCBvZiB0aGUgbWVtb3J5DQo+ID4gYnVmZmVycw0KPiA+ID4gPiB0aGF0DQo+ID4gPiA+IHdl
cmUgb2J0YWluZWQgdXNpbmcgbWVtcG9vbF9nZXQoKSBieSBzb21lIG90aGVyIHRocmVhZD8gT3Ig
dGhpcyBpcyBub3QgdGhlDQo+ID4gPiA+IHNjZW5hcmlvIHlvdQ0KPiA+ID4gPiBhcmUgd29ycnlp
bmcgYWJvdXQ/DQo+ID4gPiA+IElzIGl0IHJhdGhlciB0aGF0IG11bHRpcGxlIHRocmVhZHMgaW5k
ZXBlbmRlbnRseSBjYWxsIG1lbXBvb2xfZ2V0KCkgYW5kIHRoZW4NCj4gPiA+ID4gbWVtcG9vbF9w
dXQoKQ0KPiA+ID4gPiBvbiB0aGVpciBvd24gYnVmZmVycz8gQW5kIHlvdSBhcmUgd29ycmllZCB0
aGF0IGEgdGhyZWFkIHdpbGwgZmFpbCB0byByZXR1cm4NCj4gPiA+ID4gKG1lbXBvb2xfcHV0KSBh
DQo+ID4gPiA+IGJ1ZmZlciB0aGF0IGl0IGVhcmxpZXIgYWxsb2NhdGVkIChtZW1wb29sX2dldCk/
IFdlIGNvdWxkIGNyZWF0ZSBhIGxpdG11cyB0ZXN0IGZvcg0KPiA+ID4gPiB0aGF0Lg0KPiA+ID4N
Cj4gPiA+DQo+ID4gPiBCb3RoIHNjZW5hcmlvcyBhcmUgcG9zc2libGUuDQo+ID4gPiBGb3IgUnVu
LVRvLUNvbXBsZXRpb24gbW9kZWwgZWFjaCB0aHJlYWQgdXN1YWxseSBkb2VzOiBhbGxvY2F0ZS91
c2UvZnJlZSBncm91cA0KPiA+IG9mIG1idWZzLg0KPiA+ID4gRm9yIHBpcGxlbGluZSBtb2RlbCBv
bmUgdGhyZWFkIGNhbiBhbGxvY2F0ZSBidW5jaCBvZiBtYnVmcywgdGhlbiBwYXNzIHRoZW0gdG8N
Cj4gPiBvdGhlcg0KPiA+IHRocmVhZCAodmlhIGFub3RoZXIgcmluZyBmb3IgZXhhbXBsZSkgZm9y
IGZ1cnRoZXIgcHJvY2Vzc2luZyBhbmQgdGhlbiByZWxlYXNpbmcuDQo+ID4gSW4gdGhlIHBpcGVs
aW5lIG1vZGVsLCBpZiB0aGUgbGFzdCBzdGFnZSAodGhyZWFkKSBmcmVlcyAoZW5xdWV1ZXMpIGJ1
ZmZlcnMgb250byBzb21lDQo+ID4gcmluZyBidWZmZXINCj4gPiBhbmQgdGhlIGZpcnN0IHN0YWdl
ICh0aHJlYWQpIGFsbG9jYXRlcyAoZGVxdWV1ZXMpIGJ1ZmZlcnMgZnJvbSB0aGUgc2FtZSByaW5n
IGJ1ZmZlcg0KPiA+IGJ1dCB0aGVyZQ0KPiA+IGlzbid0IGFueSBvdGhlciB0eXBlIG9mIHN5bmNo
cm9uaXphdGlvbiBiZXR3ZWVuIHRoZSB0aHJlYWRzLCB3ZSBjYW4gbmV2ZXIgZ3VhcmFudGVlDQo+
ID4gdGhhdA0KPiA+IHRoZSBmaXJzdCB0aHJlYWQgd2lsbCBiZSBhYmxlIHRvIGRlcXVldWUgYnVm
ZmVycyBiZWNhdXNlIGl0IGRvZXNuJ3Qga25vdyB3aGV0aGVyIHRoZQ0KPiA+IGxhc3QNCj4gPiB0
aHJlYWQgaGFzIGVucXVldWVkIGFueSBidWZmZXJzLg0KPg0KPg0KPiBZZXMsIGFzIEkgc2FpZCBh
Ym92ZSAtIGZvciBtZW1wb29sIHVzZS1jYXNlOiBkZXF1ZXVlIGNhbiBmYWlsLCBlbnF1ZXVlIHNo
b3VsZCBhbHdheXMgc3VjY2VlZC4NCj4gVGhlIGNsb3Nlc3QgYW5hbG9neTogbWFsbG9jKCkgY2Fu
IGZhaWwsIGZyZWUoKSBzaG91bGQgbmV2ZXIgZmFpbC4NCj4NCj4NCj4gPg0KPiA+IEhvd2V2ZXIs
IGVucXVldWUgb3VnaHQgdG8gYWx3YXlzIHN1Y2NlZWQuIFdlIHNob3VsZCBiZSBhYmxlIHRvIGNy
ZWF0ZSBhIGxpdG11cw0KPiA+IHRlc3QgZm9yIHRoYXQuDQo+ID4gUmluZyAxIGlzIHVzZWQgYXMg
bWVtcG9vbCwgaXQgaW5pdGlhbGx5IGNvbnRhaW5zIGNhcGFjaXR5IGVsZW1lbnRzIChmdWxsKS4N
Cj4gPiBSaW5nIDIgaXMgdXNlZCBhcyBwaXBlIGJldHdlZW4gc3RhZ2VzIDEgYW5kIDIsIGl0IGlu
aXRpYWxseSBjb250YWlucyAwIGVsZW1lbnRzIChlbXB0eSkuDQo+ID4gVGhyZWFkIDEgYWxsb2Nh
dGVzL2RlcXVldWVzIGEgYnVmZmVyIGZyb20gcmluZyAxLg0KPiA+IFRocmVhZCAxIGVucXVldWVz
IHRoYXQgYnVmZmVyIG9udG8gcmluZyAyLg0KPiA+IFRocmVhZCAyIGRlcXVldWVzIGEgYnVmZmVy
IGZyb20gcmluZyAyLg0KPiA+IFRocmVhZCAyIGZyZWVzL2VucXVldWVzIHRoYXQgYnVmZmVyIG9u
dG8gcmluZyAxLiA8PDwgdGhpcyBtdXN0IHN1Y2NlZWQhDQo+ID4gRG9lcyB0aGlzIHJlZmxlY3Qg
dGhlIHNpdHVhdGlvbiB5b3Ugd29ycnkgYWJvdXQ/DQo+DQo+DQo+IFRoaXMgaXMgb25lIG9mIHRo
ZSBwb3NzaWJsZSBzY2VuYXJpb3MuDQo+IEFzIEkgc2FpZCBhYm92ZSAtIG1lbXBvb2xfcHV0KCkg
aXMgZXhwZWN0ZWQgdG8gYWx3YXlzIGJlIGFibGUgdG8gZW5xdWV1ZSBlbGVtZW50IHRvIHRoZSBy
aW5nLg0KPiBUQkgsIEkgYW0gbm90IHN1cmUgd2hhdCB5b3UgYXJlIHRyeWluZyB0byBwcm92ZSB3
aXRoIHRoZSBsaXRtdXMgdGVzdC4NCldpdGggYSBsaXRtdXMgdGVzdCwgd2UgY2FuIHByb3ZlIHRo
YXQgYSBzcGVjaWZpYyBzaXR1YXRpb24gY2FuIG9yIGNhbm5vdCBvY2N1ciB3aGVuDQpleGVjdXRp
bmcgdGhlIHNwZWNpZmllZCBtZW1vcnkgYWNjZXNzZXMgaW4gbXVsdGlwbGUgdGhyZWFkcy4gQnkg
ZXhwZXJpbWVudGluZyB3aXRoDQpkaWZmZXJlbnQgbWVtb3J5IGFjY2VzcyBzZXF1ZW5jZXMgYW5k
IG9yZGVyaW5ncywgd2UgY2FuIGZpbmQgdGhlIG1vc3QgcmVsYXhlZA0Kc2VxdWVuY2UgdGhhdCBz
dGlsbCBwcm9oaWJpdHMgdW5kZXNpcmVkIHJlc3VsdHMuDQoNClNvIHdpdGggYSBsaXRtdXMgdGVz
dCwgSSBjb3VsZCBwcm92ZSB0aGF0IGVucXVldWUgaW4gdGhyZWFkIDIgYWJvdmUgd2lsbCBzdWNj
ZWVkIG9yDQphbHRlcm5hdGl2ZWx5LCBtYXkgbm90IHN1Y2NlZWQgKHdoaWNoIGlzIHVuZGVzaXJl
ZCkuIEFuZCBJIGNvdWxkIGZpbmQgb3V0IHdoYXQgb3JkZXJpbmdzDQphcmUgcmVxdWlyZWQgdG8g
Z3VhcmFudGVlIHN1Y2Nlc3MuDQoNCj4gTG9va2luZyBhdCB0aGUgY2hhbmdlcyB5b3UgcHJvcG9z
ZWQ6DQo+DQo+DQo+ICsgLyoNCj4gKyAqIEVuc3VyZSB0aGUgZW50cmllcyBjYWxjdWxhdGlvbiB3
YXMgbm90IGJhc2VkIG9uIGEgc3RhbGUNCj4gKyAqIGFuZCB1bnNhZmUgc3RhaWwgb2JzZXJ2YXRp
b24gdGhhdCBjYXVzZXMgdW5kZXJmbG93Lg0KPiArICovDQo+ICsgaWYgKChpbnQpKmVudHJpZXMg
PCAwKQ0KPiArICplbnRyaWVzID0gMDsNCj4gKw0KPg0KPg0KPiAvKiBjaGVjayB0aGF0IHdlIGhh
dmUgZW5vdWdoIHJvb20gaW4gcmluZyAqLw0KPiBpZiAodW5saWtlbHkobiA+ICplbnRyaWVzKSkN
Cj4gbiA9IChiZWhhdmlvciA9PSBSVEVfUklOR19RVUVVRV9GSVhFRCkgPw0KPiAwIDogKmVudHJp
ZXM7DQo+DQo+DQo+ICpuZXdfaGVhZCA9ICpvbGRfaGVhZCArIG47DQo+IGlmIChuID09IDApDQo+
IHJldHVybiAwOw0KPg0KPg0KPiBJdCBpcyBjbGVhciB0aGF0IHdpdGggdGhlc2UgY2hhbmdlcyBl
bnF1ZXVlL2RlcXVldWUgbWlnaHQgZmFpbCBldmVuDQo+IHdoZW4gdGhlcmUgYXJlIGF2YWlsYWJs
ZSBlbnRyaWVzIGluIHRoZSByaW5nLg0KV2l0aG91dCBleHBsaWNpdCBzeW5jaHJvbml6YXRpb24g
YmV0d2VlbiB0aGUgdGhyZWFkcywgdGhleSB3aWxsIHN0aWxsIHJhY2UgYW5kDQphIGNvbnN1bWVy
IGNhbm5vdCBiZSBndWFyYW50ZWVkIHRvIHN1Y2NlZWQgd2l0aCBpdHMgZGVxdWV1ZSBvcGVyYXRp
b24sIGUuZy4NCnRoZSBkZXF1ZXVlIG9wZXJhdGlvbiBjb3VsZCBvY2N1ciBiZWZvcmUgdGhlIChz
dXBwb3NlZGx5KSBtYXRjaGluZyBlbnF1ZXVlDQpvcGVyYXRpb24gaW4gYW5vdGhlciB0aHJlYWQu
DQoNClVzaW5nIGFjcXVpcmUvcmVsZWFzZSBmb3IgYWxsIHJpbmcgYnVmZmVyIG1ldGFkYXRhIGFj
Y2Vzc2VzIGRvZXNuJ3QgaW5mb3JtIHRoZQ0KdGhyZWFkIHRoYXQgaXRzIG9wZXJhdGlvbiBpcyBn
dWFyYW50ZWVkIHRvIHN1Y2NlZWQsIGl0IGp1c3QgZW5zdXJlcyBhbnkgZGF0YSBpcw0KdHJhbnNm
ZXJyZWQgKG9yIHBhc3NlZCBvd25lcnNoaXApIGluIGEgc2FmZSB3YXkgKGVzdGFibGlzaGVzIGEg
aGFwcGVucy1iZWZvcmUNCnJlbGF0aW9uKS4gQnV0IHRoZSByaW5nIGJ1ZmZlciBpbXBsZW1lbnRh
dGlvbiBpdHNlbGYgY2Fubm90IGVuc3VyZSB0aGF0IHRoZQ0KZW5xdWV1ZSBpbiB0aHJlYWQgUCBo
YXBwZW5zIGJlZm9yZSB0aGUgZGVxdWV1ZSBpbiB0aHJlYWQgQy4gVGhlIGRlcXVldWUNCmNhbiBz
dGlsbCBmYWlsIGFuZCByZXR1cm4gMCBlbGVtZW50cy4NCg0KSG93IGRvIHlvdSBkZWZpbmUgInRo
ZXJlIGFyZSBhdmFpbGFibGUgZW50cmllcyBpbiB0aGUgcmluZyI/IEp1c3QgcmVhZGluZyBvbmUN
Cm1ldGFkYXRhIHZhcmlhYmxlIGRvZXNuJ3QgdGVsbCB5b3UgdGhpcy4gQW5kIEkgYXNzdW1lIHVz
ZXJzIHVzdWFsbHkgZG9uJ3QgYWNjZXNzDQppbnRlcm5hbCByaW5nIGJ1ZmZlciBtZXRhZGF0YS4g
U28gaG93IGRvZXMgYSB0aHJlYWQga25vdyB0aGVyZSBhcmUgYXZhaWxhYmxlDQplbnRyaWVzIGlu
IHRoZSByaW5nIHRoYXQgY2FuIGJlIGRlcXVldWVkPw0KDQpJdCBzZWVtcyB0byBtZSB0aGF0IHlv
dXIgcGVyc3BlY3RpdmUgaXMgc3RpbGwgdmVyeSBtdWNoIHRoYXQgb2Ygc2VxdWVudGlhbA0KY29u
c2lzdGVuY3kgYW5kIHRvdGFsIG9yZGVyLiBCdXQgZXZlbiBzbywgeW91IG5lZWQgc3luY2hyb25p
emF0aW9uICh1c3VhbGx5DQpiYXNlZCBvbiBtZW1vcnkgYWNjZXNzZXMgYnV0IHRoZXJlIGFyZSBv
dGhlciB3YXlzLCBlLmcuIHVzaW5nIHN5c3RlbSBjYWxscykNCnRvIGVuc3VyZSB0aGF0IG9wZXJh
dGlvbiBEIGluIHRocmVhZCAyIGlzIG9ubHkgaW5pdGlhdGVkIGFmdGVyIG9wZXJhdGlvbiBFIGlu
DQp0aHJlYWQgMSBoYXMgY29tcGxldGVkLiBPdGhlcndpc2UsIHRoZSBvcGVyYXRpb25zIHdpbGwg
cmFjZSBhbmQgdGhlIG91dGNvbWUNCmlzIG5vdCBndWFyYW50ZWVkLg0KDQotIE9sYQ0KDQo+IE9u
ZSBzaW1wbGUgd2F5IHRoYXQgcHJvYmFibHkgd2lsbCBpbnRyb2R1Y2UgYSBsb29wIGluc3RlYWQg
b2YgJ2lmJzoNCj4gKGtlZXAgcmVhZGluZyBoZWFkIGFuZCB0YWlsIHZhbHVlcyB0aWxsIHdlIGdl
dCBhIHZhbGlkIHJlc3VsdHMpDQo+IGJ1dCBhZ2FpbiBJIGFtIG5vdCBzdXJlIGl0IGlzIGEgZ29v
ZCB3YXkuDQo+IEtvbnN0YW50aW4NCg0KDQoNCklNUE9SVEFOVCBOT1RJQ0U6IFRoZSBjb250ZW50
cyBvZiB0aGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgYXJlIGNvbmZpZGVudGlhbCBhbmQg
bWF5IGFsc28gYmUgcHJpdmlsZWdlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lw
aWVudCwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFuZCBkbyBub3QgZGlz
Y2xvc2UgdGhlIGNvbnRlbnRzIHRvIGFueSBvdGhlciBwZXJzb24sIHVzZSBpdCBmb3IgYW55IHB1
cnBvc2UsIG9yIHN0b3JlIG9yIGNvcHkgdGhlIGluZm9ybWF0aW9uIGluIGFueSBtZWRpdW0uIFRo
YW5rIHlvdS4NCg==
