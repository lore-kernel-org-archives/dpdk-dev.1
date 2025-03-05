Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F85AC19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 18:08:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1CDA402DF;
	Wed,  5 Mar 2025 19:08:13 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
 by mails.dpdk.org (Postfix) with ESMTP id A857640275;
 Wed,  5 Mar 2025 19:08:12 +0100 (CET)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=g/HcAwL+bSOSRIMSgvxjWOUjFvP0jMcoX4sEJolJMIUyrn88WLyG/kgHB+MLNWL6E1mhnV3q5UUYlSpPNuKDpW9pIjMiJTJYy5UHSC6OGlVnGtVBOH1cfi2o3CVOsCOgj7rQ+zFSaMaNS39tSMusH8ujsqNMySg9B5K6wIYsUPt3bvmdlDkVKItznaA1/p2jUScnX0KD5EfAhiFsnC8X2BfdjEoBVzp8NCUUl/mQerWOw31wLjYkPYJeAB5kJQwfPHz/UniSnKwmXL20bOWHwMB1DMhrVLP3gxgUUj5l+ZIOWVtLkdeylfEe67wguMm3loOUIh4ted4akx7GtvufhA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6uguVgN5uVDiLJlfd1BeoLdrVMls6ya7arDmiepxgk=;
 b=PLJZ4h86xEUK/g50Fe1mZbqz0BEdSZlXZFZKxkGRVAwiVpV/TENU9CZZBBgkLfINbZ7N8NiDGJ3HLUYQqRvq0s4DYxDBBqL3qmqBkgTJ0WVLIinQVThNBvHlc6uNaysrbeWGlkhikP/gwTxLXntxMjiXX0d+8ESRMYWI09OFNxBT9l4NGYLG7KqUbtUP13iNs9SwIBDpYQcXsl3ZeFZvGBiAZKYanT+UjfvzK/j20le4tiEp7bzxLD8LwDzoYwXSLp9umo/CkcQkXP6h0y+5zbZlZwO4C9HYaFHPUVtU98AysLd4n2EBv/9KUn02k6gCOquWMiV4FpnBB34b5ikZgQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=dpdk.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6uguVgN5uVDiLJlfd1BeoLdrVMls6ya7arDmiepxgk=;
 b=G0WwoIefNCfl71I9+1ajtmytW5xDHWYzzJCCt+GJe90aPE2WeEfZ78WfsrMdvnlzjZE5eBLzLKEIumXALiY/DSbcyc3SdqpUM10RG9rwSuUhHw3mcRFS5Nl0NhojXu0M4fxZjRKxDraUhXq3yHpH3iy+DEYynvprG3SisGdhkYo=
Received: from AM4PR07CA0029.eurprd07.prod.outlook.com (2603:10a6:205:1::42)
 by PAXPR08MB6704.eurprd08.prod.outlook.com (2603:10a6:102:130::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 18:08:09 +0000
Received: from AM3PEPF00009B9B.eurprd04.prod.outlook.com
 (2603:10a6:205:1:cafe::27) by AM4PR07CA0029.outlook.office365.com
 (2603:10a6:205:1::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.6 via Frontend Transport; Wed, 5
 Mar 2025 18:08:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM3PEPF00009B9B.mail.protection.outlook.com (10.167.16.20) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15
 via Frontend Transport; Wed, 5 Mar 2025 18:08:09 +0000
Received: ("Tessian outbound bc832f6acacf:v585");
 Wed, 05 Mar 2025 18:08:08 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 5e5da3f780d54252
X-TessianGatewayMetadata: L2l81imgP5GUh76o/u3H9YFPK9jAfAm8TI3TOw4JS8NCrX2HrViCYqgUAieumqiDoLkMuinjRBOQoj4afOKT5nvGAqREXzCGhly0ahNGkAo03fjEky0vIS4LizonqHKtV7ne5xUAwx6ymOb+EFVyvjDUCaDT3WVkqzDlII9p7eftAa/w60fIPgXbVghGhpgK3hfHN5ysi5EcE3NvaSpkdg==
X-CR-MTA-TID: 64aa7808
Received: from Lf92204a976f7.2
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 0062F992-F875-40F8-93D7-2DA73994363D.1; 
 Wed, 05 Mar 2025 18:08:02 +0000
Received: from AS8PR03CU001.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id
 Lf92204a976f7.2 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 05 Mar 2025 18:08:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eFf8tt9y0WX97EFMyVrfxRs0Ed8htjsHemamNzaG5JxRliW7PqeVQzLWmnhI5aMufmppx362GwBEZhgT4Py1MrJXJPG7125RPJtRJVpOI3F4NJNo5sfbivalAD4ufIJl8aWBP2CA6IR1lt+VB6A2DUyCs71884lOs2dty+izDwwLOZ8KgyMRX6oks2o9yNnr3OKKNmLHu+aDoGF/7M3AHUQFm8lbuZPMe+vGRi8IC/6VQPUxhQMls7BKTggCSCrv5T4rK0OfhPHBaxa+jo6UV+Y/U1FQTyikPyRomReAqN0tu3ofwa5Yr6KH85lOIvb4lNxfxFLWtoewwgHEWuyIRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6uguVgN5uVDiLJlfd1BeoLdrVMls6ya7arDmiepxgk=;
 b=NUt5DRPLLE5c8C2iLtA8067uu/HYq/A3SkcddB4dW2msmvJriPS09ZqSfQiDOOxQ8DLeMcr/huEM6KMo1Tald8Vh9S7CjELa53L/oHQewb4PB8UqnV3KMYEFGYtpTzKBtTokHnl1kWQwiRqBhv4cvqaSAYwl+VdfG1Lb6h5RjY4UR50r2CLsZf7XemsS3m7auAZ7cN3P0bVsKWf5eEz3rkkaDg9d/0j8e4/NCURI4I+RPJVhCNDyYELkuSsn6gzJZAluNqKrO8rs018hmKP2t/NBy2g45CmzTAJsEY1Ybch9gcYu/UH769oG+lPggtsmtsBoMjDJsgD7pST7WSa1FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6uguVgN5uVDiLJlfd1BeoLdrVMls6ya7arDmiepxgk=;
 b=G0WwoIefNCfl71I9+1ajtmytW5xDHWYzzJCCt+GJe90aPE2WeEfZ78WfsrMdvnlzjZE5eBLzLKEIumXALiY/DSbcyc3SdqpUM10RG9rwSuUhHw3mcRFS5Nl0NhojXu0M4fxZjRKxDraUhXq3yHpH3iy+DEYynvprG3SisGdhkYo=
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com (2603:10a6:102:33a::19)
 by GV1PR08MB8668.eurprd08.prod.outlook.com (2603:10a6:150:86::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Wed, 5 Mar
 2025 18:07:58 +0000
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294]) by PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294%5]) with mapi id 15.20.8511.015; Wed, 5 Mar 2025
 18:07:57 +0000
From: Wathsala Wathawana Vithanage <wathsala.vithanage@arm.com>
To: "bugzilla@dpdk.org" <bugzilla@dpdk.org>, "dev@dpdk.org" <dev@dpdk.org>
CC: Honnappa Nagarahalli <Honnappa.Nagarahalli@arm.com>, nd <nd@arm.com>
Subject: RE: [DPDK/meson Bug 1670] DPDK fails to compile using gcc version
 8.5.0
Thread-Topic: [DPDK/meson Bug 1670] DPDK fails to compile using gcc version
 8.5.0
Thread-Index: AQHbja4TfsAzHm+clU+3RpFat6xn4rNkzeYA
Date: Wed, 5 Mar 2025 18:07:57 +0000
Message-ID: <PAWPR08MB89099E2B381B858E173967D89FCB2@PAWPR08MB8909.eurprd08.prod.outlook.com>
References: <bug-1670-3@http.bugs.dpdk.org/>
In-Reply-To: <bug-1670-3@http.bugs.dpdk.org/>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: PAWPR08MB8909:EE_|GV1PR08MB8668:EE_|AM3PEPF00009B9B:EE_|PAXPR08MB6704:EE_
X-MS-Office365-Filtering-Correlation-Id: b620a0a5-8330-46a2-fc88-08dd5c10afb0
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?aFdJc2cvVnFEVXFLZWZXS3RUbC8wYzR5K080NWJCcTU4RHBrRndGcnN1RUFq?=
 =?utf-8?B?REhNMytUNnNsYUJOZmw5Q0JhVzlmdXp6ekZ6MzFubkh3SXlFblJJVG1Fd0pW?=
 =?utf-8?B?OHBrbjdpcXpCOHI4dnFBaVRlYkI4eVR0Z1FCdVNqMzRiOUVMYjZoVU0xQnh6?=
 =?utf-8?B?SXIxSXFjT3lpTjNkV3d2Yk51RVdyMTFKTzdpTjFjTHhUMFZhL0c2TUE0RU5J?=
 =?utf-8?B?WHlpRDZOdnpkeFlnQlB0MTUyT0hnMHh4Q1dXQTFKbXdVMjdTdjJpeVVRK0dx?=
 =?utf-8?B?bHBtTHZDbERMTm1PcEFYN0lhNHl1MDBEU1ZhRjBKbXoxODNXMW4yZTBLT3lN?=
 =?utf-8?B?T2tMYUg0bURPTnBFZ0d6SFg5Snk4OUk2eHBEa2pkR1laRUlIak4rWm0wK3V6?=
 =?utf-8?B?V2gvUnBCVkhFSks1NHU4L0hxSWlHUi80SDNRZHhnUGlCOWt5QUhuMkVDYWpL?=
 =?utf-8?B?UklTV0tEalBGblFPVkdtcElaQ2U5bm8zYUkxNmJCQWRjRHFRYzA3NFY3WjN2?=
 =?utf-8?B?bElVR0MwRCtUUFFpdUpiQkd5L3Q3TXBINTlUWDh3Qno1ZzBRakRzUlZKZEtw?=
 =?utf-8?B?ZXJKTmNFM0txbHdiazhHVDcycmRHTnBORjVyeG93UVY1UGNITFBjR0w0aUdG?=
 =?utf-8?B?N2tXUUxuS2IvVGcyV3BaMCtFK09KcVg0U1NRVHExNzlHdnhxWDRsSWtwNlY5?=
 =?utf-8?B?UEkwK1B5VHpHbGkzTURXYUJoR2FINGxxektyeFVxcm9ZbGZLcGRjZDNJWlBH?=
 =?utf-8?B?NkRxME14aEZVMHFYVDBIQTMzeUQ5Vm9aRW5aQ2pQcFprL2JXTGJGYStSbFMv?=
 =?utf-8?B?Q0s1L09UbFdGOTZBVDBlaVp2aGFBZFlNbFlSa1ozRFJ3RVhEZklyL2dOd3dF?=
 =?utf-8?B?QjFMTW90MTRUOWpqd3BqWGVPYjQ1UmtIMTNhUFg4Y2orQ2tHbmplNkMrclU1?=
 =?utf-8?B?T1VFcEE3aUtsOHFpRDREYWE0SzR2ZnhEa243NldraklYSGhJTHhLUzlkVVRl?=
 =?utf-8?B?NFpMRURGWW52bys1WklOWmVJdlZ6OVhzS0RTV3Ewc3A0YmhZNmFjVUpPU0NW?=
 =?utf-8?B?RUFTYTc2YjM4MUhwWVo0MUc1R3l1K05LUGt1a3NveHV0Z2pIc2Q2VnJqYnds?=
 =?utf-8?B?V28xM2NKM0Nja1ZIWE9hUERWMHNrSnlNOW9YN2ozNHdhWndQVnNDWGw3UXU4?=
 =?utf-8?B?TG5jSUFKOG5peGxIUFpiL1VIOThJQWFrUWc0TUpCVzFoM25ibGR5UVVydkwr?=
 =?utf-8?B?WGxwUzNsMVdZTFA5cGV4TmZnYm50dVNqVXl0bFNKZkZlQk5ROXpjMElyZWFI?=
 =?utf-8?B?WHJXbDJ5dDBaUUtGVG9nalNGWlc3Wi9ZNm5DVkQ2ODdhbXUrR2pvdjhuNUx2?=
 =?utf-8?B?aDVaRnZqNDVmUVdXNm9IREdISk40Z0pQYlE1bHpVWVUrN2diSWtmaEJ3Ym9G?=
 =?utf-8?B?L2ttOXIvVmt6SmxWWEdQTm1jTVBoNUpEd2UvUW9WdUpjbHBXVExTNjRnbzFO?=
 =?utf-8?B?bW4rekxYMjMwK3lxMUxMQU9ZdnQ2WDkvYWFHMjBQYkY1NHpDZTdWQStzS2pD?=
 =?utf-8?B?b1h0U05WUVZHOEx6YzRNVDdOOVJhdHpaSGJRMVc1clZBU0d3bUpPWkdhdzU4?=
 =?utf-8?B?ZVNYcFFTZjI5Z3lSdmtZbyttSU1qbElDWWtlWUR4aEIrTDcwcFFsamtGNnkw?=
 =?utf-8?B?Y2FTcUJZT0VIY2RVQkVZNGwrdnRiaC9pRlc2S2F5TlRpODJsVW5rT3dIUmt6?=
 =?utf-8?B?S0U0M2I4dGVVbHlDZTI0c2N4clJEYTJ4WndjdTAxME1RV2REUzE3ZWtpU0FK?=
 =?utf-8?B?WGhzNlVmOTZrb1EzMjFTRlhjOW5jbVo0NkcxVzhOTmdPVTQxMmJFTzkvcTJ4?=
 =?utf-8?B?NnRuOTEycGpOMTk5NHRnR1o3b0pHclRzQkJRNlJtUTYxaWc9PQ==?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAWPR08MB8909.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700018);
 DIR:OUT; SFP:1101; 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8668
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[2603:10a6:102:33a::19];
 domain=PAWPR08MB8909.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF00009B9B.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b035ab6d-519d-413d-4720-08dd5c10a8e5
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|14060799003|35042699022|82310400026|376014|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TXJUWUhQVDRUVEFJWWF0VWNqNVBOQlRkT3U5cmNMVU1nOEl1RzNHUW9najB2?=
 =?utf-8?B?SjlUQ2ExZVI5UXYxK3g4YkdhQThpOGNibFl0VVpIdjN6ZGpTaG5Xek84VjhL?=
 =?utf-8?B?dVZURkdWcnRuM0xockZMM2NlajZ0Mnh4a1NvenVVQ1FnM0Z5azl3eC9TNjRv?=
 =?utf-8?B?cVpIM3JiNEoxcFJzSWM1M0RnZjRiVTM0RHdOSW81R25pZ0w0RnRBc0xEcmJ0?=
 =?utf-8?B?bW5TSnlCRzZlMFUrRnU0WnZIVDVSMzd0blhpbFVBK1lNbUJMa3hHOC9MWUty?=
 =?utf-8?B?QzN6bDEzNFJxT2R1UWE2Z3hlSUI4OEYzVVZTTGgwaTNvRGdyWDRjQXJCcm4v?=
 =?utf-8?B?VHNuNE5RZEd6c3hxWTFvQmhiUy8va2ErNDI2WTRaM0x0ZnM5dmVweUR2TzVY?=
 =?utf-8?B?aFZkMTA0NzVmSVhSQVVQbFJOTzF6NUhyK1EwQm5PdU12UlVyMmJGYk1ORzd2?=
 =?utf-8?B?M0lzaS9ramVPYmVCZTZ3MXBZdUNpTDI4aVNwM2o0OWxLWVlwUmZ2Z29XTzFB?=
 =?utf-8?B?YVl5Ukpqd01MenpMU0dGQVJBRWlGTkxzL0QrclhPa2lXMlJCM3VoaFZSMEZP?=
 =?utf-8?B?TGdBL0JhYzFOQXg3NEk3YThHTGg4MVZseDZ1amE0V1plTTFmeWYybFNjaU5Q?=
 =?utf-8?B?MGhSL0hHY3VIZTNkdUZSVENVc2kvUWtHUllmaVIxdTErWG5pOUVSZ1dmWDd1?=
 =?utf-8?B?NVNQT1F5Y3NSajNlajNXK25YM055UkhqMjBSR25DNEIyVFhhNXdmMzZOOGYv?=
 =?utf-8?B?SDJRSWlMK1BSOE5PeDFxSnZhZGJ6bndOZlF6NWNDS3pUVGlzZ2RDdGZKanFK?=
 =?utf-8?B?bDFHaGVVb1NpVlpXN3FRSFJOb3lpb2Fob2VCa2d1T1VTQ2pFSCtYbFNNWGFP?=
 =?utf-8?B?RzREOXFXUXd3RVhJVkw1Q3JzSnBqSld6TGlsWk5XWk0yeEVlUTVXbEN6c1VZ?=
 =?utf-8?B?WXdUV1pzNCtqVVBMNTZrZTlwUUpkQVJrZEJTd25raW5FUTErdkJETkVOSS96?=
 =?utf-8?B?RGthR29sejJoUjFkeEZVZUtkRE1idmpIL0tBeXFJamx0Z01wL2ZQOXRPTDdi?=
 =?utf-8?B?bDBCM0ZEVVVLQ0ZZZ3VKOTNHVjA5L1pQZ2YzTjVLT0RHV1M2RnNvWG9sVXMr?=
 =?utf-8?B?eXF4TVk5RU9OUFlueURCa0sydmhRUmo5VnQ2Z2wzQ2xWUlo3bUg5TEpaWlEx?=
 =?utf-8?B?RUNVOU1QVnVMNGs4d0RjbVJTRVRGSWM4d1Q1K2ZtS1Nvd2lUMTdwN3hHUjBI?=
 =?utf-8?B?a1hGbktWOHpsb2p2SUN3YWxRU3RJKzV3RVFCQXljRndiRTNOZC9HU0dkdTk4?=
 =?utf-8?B?SDFaa2ZRWFBpSHplbWxxL1BaZ21acFlVM2puR3Y5KzJnUXliUnJ4Tk5GblRE?=
 =?utf-8?B?SWY2TjlUOGF0NlVabzhIZUtNd2NjNFNqcHFYMHBpR21FQlFmM1laandwUW5X?=
 =?utf-8?B?SzNsMW1oR2Y1TGJGNkFOK3VaM1JOaTZUYml5eW1zZCtrcUh4alRUVWZQTWly?=
 =?utf-8?B?RzZwbWdHR2U3NGtIeVVETFk2RDBLZHJ5b2MwZ2xNMXcwbHZ6TmN1UHQybDhD?=
 =?utf-8?B?YlMrTHE3REsxNnhJdjcwemFYclRiclRaRWZMSGsxTzUxT2VWMTlqcHJmRUNU?=
 =?utf-8?B?Y3JYSGU5NFZLVVNiUXpIRjYweHZIS2RDQUx5b25oUDlUQ2ZlYmp2Ym1GeFJO?=
 =?utf-8?B?V3ZVQndmSkdjbVpVdDNKZVczTklhakc2cEJLOTFVdmsxWVUrU0hoTXZsWWtp?=
 =?utf-8?B?dGUzaUVJNDFQYXNPZThuSm85aHlLSkZ4eS9lVTRWMTRjK1RzTER5SzFDR3p6?=
 =?utf-8?B?SGJVcis2L2F2MEx6ZEloVTJHcnNNTWlveEpPSVUxV0FiOEk1YzdlL3lMOWI3?=
 =?utf-8?B?RUJPL3JEVlpLWlBQTHlCRzVTRHRQUHI1WmV2NjB5THc1U0NCZnhVK0FqTUFC?=
 =?utf-8?Q?T9+L+edeBPM=3D?=
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:64aa7808-outbound-1.mta.getcheckrecipient.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(14060799003)(35042699022)(82310400026)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 18:08:09.2541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b620a0a5-8330-46a2-fc88-08dd5c10afb0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6704
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

PiBTdWJqZWN0OiBbRFBESy9tZXNvbiBCdWcgMTY3MF0gRFBESyBmYWlscyB0byBjb21waWxlIHVz
aW5nIGdjYyB2ZXJzaW9uIDguNS4wDQo+IA0KPiBCdWcgSUQJIDE2NzAgPGh0dHBzOi8vYnVncy5k
cGRrLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MTY3MD4NCj4gU3VtbWFyeQkgRFBESyBmYWlscyB0byBj
b21waWxlIHVzaW5nIGdjYyB2ZXJzaW9uIDguNS4wDQo+IFByb2R1Y3QJIERQREsNCj4gVmVyc2lv
bgkgMjUuMDMNCj4gSGFyZHdhcmUJIEFSTQ0KPiBPUwkgTGludXgNCj4gU3RhdHVzCSBVTkNPTkZJ
Uk1FRA0KPiBTZXZlcml0eQkgY3JpdGljYWwNCj4gUHJpb3JpdHkJIE5vcm1hbA0KPiBDb21wb25l
bnQJIG1lc29uDQo+IEFzc2lnbmVlCSBkZXZAZHBkay5vcmcNCj4gUmVwb3J0ZXIJIHN1YmhpbUBu
dmlkaWEuY29tDQo+IFRhcmdldCBNaWxlc3RvbmUJIC0tLQ0KPiANCj4gQ29tcGlsaW5nIERQREsg
MjUuMDMgb24gc3lzdGVtcyB0aGF0IHJ1bnMgZ2NjIHZlcnNpb24gOC41LjAgYW5kIEFSTQ0KPiBh
cmNoaXRlY3R1cmUgKCBhYXJjaDY0KSBpcyBmYWlsaW5nLg0KPiANCj4gUmVwcm9kdWNlciA6DQo+
IA0KPiAxLkNsb25lIERQREsgMjMuMDUgOg0KPiANCj4gZ2l0IGNsb25lIGdpdDpcXGRwZGsub3Jn
XGRwZGsgZHBkay0yNS4wMw0KPiANCj4gMi4gQ29tcGlsZSBEUERLIDoNCj4gDQo+IG1lc29uIGJ1
aWxkLW1lc29uIC0td2Vycm9yDQo+IC1EZXhhbXBsZXM9ZXRodG9vbCxpcF9mcmFnbWVudGF0aW9u
LGwyZndkLWNyeXB0byxsM2Z3ZC0NCj4gcG93ZXIsbGlua19zdGF0dXNfaW50ZXJydXB0LG11bHRp
X3Byb2Nlc3MvY2xpZW50X3NlcnZlcl9tcC9tcF9jbGllbnQsbXVsdGlfcHINCj4gb2Nlc3MvY2xp
ZW50X3NlcnZlcl9tcC9tcF9zZXJ2ZXIsbXVsdGlfcHJvY2Vzcy9zaW1wbGVfbXAsbXVsdGlfcHJv
Y2Vzcy9zeW0NCj4gbWV0cmljX21wLHZkcGENCj4gLURwcmVmaXg9L2Rvd25sb2FkL2RwZGsvaW5z
dGFsbCAtRGxpYmRpcj1saWI2NCAtDQo+IERlbmFibGVfZHJpdmVycz0qL21seDUsbWVtcG9vbC9i
dWNrZXQsbWVtcG9vbC9yaW5nLG1lbXBvb2wvc3RhY2ssbmV0L2ZhaWwNCj4gc2FmZSxuZXQvbmV0
dnNjLGJ1cy92bWJ1cyxuZXQvdGFwLG5ldC92ZGV2X25ldHZzYyxjcnlwdG8vb3BlbnNzbCwqL3Zp
cnRpbyosYnVzDQo+IC9hdXhpbGlhcnkNCj4gJiYgbmluamEgLUMgYnVpbGQtbWVzb24gaW5zdGFs
bA0KPiANCj4gDQo+IFJlc3VsdCA6IGNvbXBpbGF0aW9uIGZhaWxzIHdpdGggdGhlIGZvbGxvd2lu
ZyBlcnJvciAgOg0KPiANCj4gQ29tcGlsZXIgZm9yIEMgc3VwcG9ydHMgYXJndW1lbnRzIC1Xbm8t
bWlzc2luZy1maWVsZC1pbml0aWFsaXplcnM6IFlFUyBDb21waWxlcg0KPiBmb3IgQyBzdXBwb3J0
cyBhcmd1bWVudHMgLWZ6ZXJvLWluaXQtcGFkZGluZy1iaXRzPWFsbDogTk8NCj4gTWVzc2FnZTog
QXJtIGltcGxlbWVudGVyOiBBcm0NCj4gTWVzc2FnZTogQXJtIHBhcnQgbnVtYmVyOiAweGQ0Mg0K
PiBDb21waWxlciBmb3IgQyBzdXBwb3J0cyBhcmd1bWVudHMgLW1jcHU9Y29ydGV4LWE3OGFlOiBO
Tw0KPiANCj4gY29uZmlnL2FybS9tZXNvbi5idWlsZDo5MTU6MTI6IEVSUk9SOiBQcm9ibGVtIGVu
Y291bnRlcmVkOiBDb21waWxlciBkb2VzDQo+IG5vdCBzdXBwb3J0IC1tY3B1PWNvcnRleC1hNzhh
ZS4NCj4gDQoNCkNvcnRleC1hNzhhZSBpcyBuZXdlciB0aGFuIEdDQyA4LCBzbyB5b3UgZ2V0IHRo
aXMgZXJyb3IuDQpPbmUgb2YgdGhlIGZvbGxvd2luZyBvcHRpb25zIHdvdWxkIHNvbHZlIHRoaXMg
SXNzdWUuDQoNCk9wdGlvbiAxOiBVcGdyYWRlIHRoZSBHQ0MgdG8gYXQgbGVhc3QgYW4gMTEueCB2
ZXJzaW9uDQpUaGUgcmVzdWx0aW5nIGJ1aWxkIHdvdWxkIGJlIHRoZSBtb3N0IHBlcmZvcm1hbnQg
Zm9yIENvcnRleC1hNzhhZSBDUFUuDQoNCk9wdGlvbiAyOiBGb3JjZSBtZXNvbiB0byBkbyBhIGdl
bmVyaWMgYnVpbGQgYnkgcGFzc2luZyAtRHBsYXRmb3JtPWdlbmVyaWMNClRoZSByZXN1bHRpbmcg
YnVpbGQgbWF5IG5vdCBiZSBhcyBwZXJmb3JtYW50IGFzIHRoZSBvbmUgcHJvZHVjZWQgYnkgb3B0
aW9ucyAxLg0KSXQgd2lsbCB1c2Ugb25seSBmb2xsb3dpbmcgbWFyY2g9YXJtdjgtYStjcmMgYXMg
ZGVmaW5lZCBoZXJlDQpodHRwczovL2dpdGh1Yi5jb20vRFBESy9kcGRrL2Jsb2IvbWFpbi9jb25m
aWcvYXJtL21lc29uLmJ1aWxkI0w2NzYNCg0KLS13YXRoc2FsYQ0KDQoNCg==
