Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039A1C5B543
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 22:25:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 133D5402A7;
	Thu,  5 Jun 2025 00:25:23 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013035.outbound.protection.outlook.com [52.101.72.35])
 by mails.dpdk.org (Postfix) with ESMTP id D9D324028E
 for <dev@dpdk.org>; Thu,  5 Jun 2025 00:25:20 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=qCRNehGIBxo8OpG3chuJXgNZztGNjkgOi9K1146raa6ke4yu/JctYURgv3tk2eZGWFSp0JJTCPOxIT2878hfgm2gQFCdKsJylscBITISyaTxtE3bgEX8BVwMum7gHcsAWXUIMUNB6jCtiS7ImPH0y+/bvdFa8I1n8jgaolOvOxEf0446OBqdvBxVYbvNo3qh4JBMP9PdYD48+RDEE35z9aRA6Q3SLPvfY0OdHRxRe8XrIcGypQs++kpjvSDuwOuEgDmAU5h88VqtBIbnwlm0n5jQ0El3tDotsuVSzlFJRNAIn62oun/WE8KLRvSffjR25YupwAqdb05V0jS16W2hLg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIcgl14bRb0su+HapIWDoCdh+7EfIT9bt37BrdeObcs=;
 b=BoXDr8kW9em+mxcb3iZK7aw8IPqY7gZZnDLRalOkZpOlIMHK7bPnST2uMtoMg0ijBJ3n/B98eE0uHEaQffaZugLkezIw4acKn1SI1lVKKChnzA5aXjjpYt+DvD3UnSjn+YiOkYNySEuLqMCpf/z7HNAaHmy/DcEztl9HAleZ/LA6e5A8ek36QlFbmRZbTbMNJuQJxFeorCcBCRfXi3TahieAJbRJXyjw4IyM9VXR7cY+T3yUBBob+E35hHN0v6sozURGmUYZIyqiFFHSuU8cZgxy84Qna10ap3NVRxrgvIrmaMcodBotZAjkydVrrSa3jRGZ/STZBGGAUYy2GKXptw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=networkplumber.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIcgl14bRb0su+HapIWDoCdh+7EfIT9bt37BrdeObcs=;
 b=UJQDCXGu7IP6mtTkWJl00zOkt/HMMP+y+TmtT3JnNs3dAV+SAo0AigEIpN0TniTYNkIy6kLz6JVB07Dky82ZXStHVqLPIn2a6Ss5dXjH23b3XRuIqcP1QpogurKH2qZ+BrqapBM/kfACFukmV8KCGAusffJz0DaSPPnmjJntjYA=
Received: from AM0PR06CA0141.eurprd06.prod.outlook.com (2603:10a6:208:ab::46)
 by DB9PR08MB7796.eurprd08.prod.outlook.com (2603:10a6:10:39b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Wed, 4 Jun
 2025 22:25:17 +0000
Received: from AMS1EPF00000040.eurprd04.prod.outlook.com
 (2603:10a6:208:ab:cafe::e) by AM0PR06CA0141.outlook.office365.com
 (2603:10a6:208:ab::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.24 via Frontend Transport; Wed,
 4 Jun 2025 22:25:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000040.mail.protection.outlook.com (10.167.16.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.29
 via Frontend Transport; Wed, 4 Jun 2025 22:25:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OVYTi780zvDu239TR6vGjMbAvVIWhLts9V5xQf/UlALCsiYrKDUXGhBbNABHkcUijbOiX/LSR/Js5Hkf2YvUKvYP/sQ3S10IXpw6RKNAvpC4WSNjn5o8Xr30PnJPuMxd9pkFKYyA2LArrMUJl39yrTO2yemiqAAYK2Nl3IqIb9ltyYSZSRZvpos/q7MSd31YS/TzsJkNcZmXb6aWM7qoJSHMl9ftv64+b7eMhJX2ti6CROpz0Rc37hn0GeBy3SazfPDOUv/g7JCYdeHL+gdYKv5nZwweSDTkY428opVY41n0e7TJofSPP9zrlvZYl+8QxxuqBYq9sjER38fsGyWxvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIcgl14bRb0su+HapIWDoCdh+7EfIT9bt37BrdeObcs=;
 b=GhKT1THGftUEMXOcf5YcZMoQNzGjSAvf25uekvyew4S33i69b9AIJ6NFpSQkEM0k1nqrPgcEDSkRiRGdT2Sq6vAH6Il2Xo+W7GagRgiffHyTeLmHTDjKj1f1w6NhayWnSXVMEgP1AW0Pufeu0DSFNPwGA6P6ZwMDFYDRG+W68rKGE59DnoBBNd+S2cr/4tK81JaNoHCRnT2BM0AGJmumKjl0wcOpSk5OpyZbt+MWjz73Gy+K4dsQOjP+C7+RgwT/R4ggz7NcQE5yIsh704mRdEHWD4wte5h71tgRJ/1WoUsS+dxIDcb8SKCB8Drhq+nm9gZXNWxJBZmUO007k1jmMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIcgl14bRb0su+HapIWDoCdh+7EfIT9bt37BrdeObcs=;
 b=UJQDCXGu7IP6mtTkWJl00zOkt/HMMP+y+TmtT3JnNs3dAV+SAo0AigEIpN0TniTYNkIy6kLz6JVB07Dky82ZXStHVqLPIn2a6Ss5dXjH23b3XRuIqcP1QpogurKH2qZ+BrqapBM/kfACFukmV8KCGAusffJz0DaSPPnmjJntjYA=
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com (2603:10a6:102:33a::19)
 by VI0PR08MB10744.eurprd08.prod.outlook.com (2603:10a6:800:20b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Wed, 4 Jun
 2025 22:24:41 +0000
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294]) by PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294%7]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 22:24:41 +0000
From: Wathsala Wathawana Vithanage <wathsala.vithanage@arm.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, nd <nd@arm.com>, nd <nd@arm.com>
Subject: RE: [PATCH v5 0/4] An API for Cache Stashing with TPH
Thread-Topic: [PATCH v5 0/4] An API for Cache Stashing with TPH
Thread-Index: AQHb1A8ISIMiXdU/RkWkyAsKdq/xXrPzOaUAgABce6A=
Date: Wed, 4 Jun 2025 22:24:41 +0000
Message-ID: <PAWPR08MB890902A37C742458A49436A79F6CA@PAWPR08MB8909.eurprd08.prod.outlook.com>
References: <20241021015246.304431-1-wathsala.vithanage@arm.com>
 <20250602223805.816816-1-wathsala.vithanage@arm.com>
 <20250604095114.2e540905@hermes.local>
In-Reply-To: <20250604095114.2e540905@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: PAWPR08MB8909:EE_|VI0PR08MB10744:EE_|AMS1EPF00000040:EE_|DB9PR08MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: 0673d821-166d-4d0f-f941-08dda3b6aeea
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?aWsyeUlkWkpRbDZOYnNLV0RzU1VGai9YZ1J0WlduL0xTak5pMmpNRURFeEtr?=
 =?utf-8?B?QWpzbm1va0t3WHo3aU1mdzRkSVczTnhrOWNNUkpHVVVQeGdmcnpCK3p2YldU?=
 =?utf-8?B?MjBVbEZYelVuTFpIdmpsWCtnRWdDbUR2RTJpRkJsaXg4U0d6akU3RXhvWGU3?=
 =?utf-8?B?NVhuUmU4QnlPVkpyWS9iZHd2cHhhUWszZm1RVUtNZmNCb2dkeG0vdGpIS29F?=
 =?utf-8?B?THhrdWhNZEZ4cU5zQTlIWWFmZUNtb0JOV3EwOThuL2k1cE9IWlBsK0JwbUFK?=
 =?utf-8?B?QmE1alRMUzByUTJvNzVXZUsxMXJJT2FDb0RhWW9rVzBoUXhLSFFyL1JjbytI?=
 =?utf-8?B?T2t3R0c3S1R5bTUzcTczaFlkckhqVERIUmM2Wmd2cFJLdVl3WitvNW9laUt1?=
 =?utf-8?B?NVhEOHMvS2dKd3hzcjQ0MXlsTk4yTllPZjlNL3B3RWpNbHdkTW9Ec0RyUTdT?=
 =?utf-8?B?Y1RPdlgrTU0xT0lnK3JCTXlKVDlPMGl2bjBiamEza0dlU3pSMFJPQ3MzT1dq?=
 =?utf-8?B?TlVRcVh4clRqSHA0bFVZdk9sVng1NmE2ZDBUWVRneUh3R2dETEsrR3dUeFRT?=
 =?utf-8?B?aExsd3R1OEJ4YWlSYklkWGc4R0NRaWcvVEhPdVUwdVVqZ09SZGQwbWlpelA4?=
 =?utf-8?B?MGdkeFNBOXo1a1lySmdoeUpBRlFmYVFhQXlMUVRXOStPditvYUgzTzVNT1BS?=
 =?utf-8?B?cGFRTTJteDlJeVEycU9NQ0JwdGRNMFQ4NUhtejV5Q21lSWtUR3Q5MGx1c0or?=
 =?utf-8?B?SC9iNEdsYlZDejdrMHpnWG9Cdm9UZzFBSkFST0xLeU9IL0VpU01MVTZzRzFF?=
 =?utf-8?B?MlFjdnBhN2lCdmUzRWZLTVRaT3Vha2FsckJYcjFtYlpwT1FJSXdsNzRZVHR3?=
 =?utf-8?B?R1ExckdLTXZwU2x0bTl3ODFjelMrV2hWZm5Fa0Q1L1Y3V1BMblBrNG1aK2xY?=
 =?utf-8?B?dTJvMlg2Z0RnOXBNSlRScFRLTXFsbk1jN3RFSG1ybWc1b0ZvMXhyVCtuZHBw?=
 =?utf-8?B?QWRZQlBoMCswbXdET2RLcUhSaGo2bUJiVWxTY2FtcVVjaklnZVdjV01ZUlU2?=
 =?utf-8?B?RlJhZzREV0FiM1liRVFkUkFPeFR5SFFzakQ0NU4ycnN4NHJVWkVTdUJ4Z1Fr?=
 =?utf-8?B?N0xsQU02cGRHZEhMdWVDd2RJcnhqVXhRUDNyNmxXcW5jckZEMkdJbERJbnJG?=
 =?utf-8?B?RFVvYytXV3R4eEU2S0xTSkFuQ3ZqWUc0UEQxMm14b3M3andMaStJNHp4RjdE?=
 =?utf-8?B?RGNnUDFKbVJYbnkvVEFSU0Z2bEcrMDJNaEN1MHZtWXphcXVzQ28zZWE1NGhZ?=
 =?utf-8?B?UnMycXVHMlFmWEVHbVVsaHdIL2pIZEYyYStsYmRzWlpDNnNJUlRxcWNaNEJC?=
 =?utf-8?B?Nkc1VU1lUm9Ud1kvMzZsb0s5aDV2ZlJrK3krS04xcjdaY2lOR3J6NlgrZmpr?=
 =?utf-8?B?dFlEYUozOTROdm5XU1ROb0JsU1M4V0VaSTRkMkp5bWkyQ0VDMm9YREc4Vkpw?=
 =?utf-8?B?ZE5TaUtxb1VabWlrNnhDSFZEaWpYaTROUEl3UFErTEZxSmN4bGQxdzNOOC9o?=
 =?utf-8?B?bE9DSnhXdzBVQ1p4QXN5M2hyU2NDYldaQVdrZnRURm91N2trQThXaVRrWlJO?=
 =?utf-8?B?TG55Z0RBNi9TcWpYU1kyRU9QelIzS1VSMHBtdW9hZjc4aVV4dlZtd2dmNVRS?=
 =?utf-8?B?T0xaMm8zNlUra3J4Sk1zUmZNZ1p5NUtRclRrMUFjWm9pSTlGT2lJaXRqdEJn?=
 =?utf-8?B?MFR1MlpKTHZldGhvZTcxSVBwajh4bEtrOVVNczNRTG9xejhkSmhPd0dRRGRk?=
 =?utf-8?B?czBRZVUwUUNJQVY2OUx4SVdTZndvM2FqK0x1M0lNVXk3Tis4VUJuMVRHK3B1?=
 =?utf-8?B?eHZ3OXdhOU16THQ1a3Fqd3BnSm5CN2c4U2YzY0RlcW9mVVRiYTYrVFJKQk1P?=
 =?utf-8?B?ald6RTVCZmpoU0Z5ek5xWXRFNFlZZENtSUVpSklHRGZqWEd2TzBKSjdTZHBV?=
 =?utf-8?Q?tFOivWjpz6keCd8DbImKzhfP8zbzt0=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAWPR08MB8909.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700018);
 DIR:OUT; SFP:1101; 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10744
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS1EPF00000040.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1f3680a5-c5be-4580-194d-08dda3b699c4
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|14060799003|1800799024|35042699022|376014|36860700013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFRjUFg1Q0VITU1mblJwSUdYS25CUmwwbHFlUHFMSHRMQm9GOUJkZ2NseGQz?=
 =?utf-8?B?Wk9HNTJSaUVTSiswbmJIVit1V0FyT1RwdHdkWEdCV2duTE01M1ZEMWZxNGRs?=
 =?utf-8?B?NHBqTGo2SXg2bFR5QTVxcjYzOUtML3NETGZjNzVnM1VDVWhNVUV5WVEzMU41?=
 =?utf-8?B?dTI2Q01rRitSOGIzWGcxZ1VsSGFOTU9qV01zZElPUlNxTU5JREVFT3g0Qnln?=
 =?utf-8?B?bEhrNEwzT0lZRlkzUmk4WXlhYy8vSlh2REh4TzZGbVc4RkdIaVA4OVBCeHJX?=
 =?utf-8?B?VzNsaVJFSzZOeE9iWEFvak5vZlVha1RpOEhLeUZidzd6MDZJbVY2NWwxWW1r?=
 =?utf-8?B?WHlvVDN6ek02UVdqQWtuMHlTTFo4N1RKdFp6aGtzaVE2QkUzNlVhK1JmS3ZC?=
 =?utf-8?B?UDBRUC9TcEFPU04rMkJPUlZJTmtlRTdNT09BYkJmdTJFU1FseE5QMTFhNFFB?=
 =?utf-8?B?TmNjNjFHejM4RWE0ZkRDNUxJaVFXN2huN3hjNG0wUXBZMlZyNHdBNkRpUW9v?=
 =?utf-8?B?VGFWUTRkcWFqRTVjL0RWVm5ZTTZORUduVVBuekhsQzg5a3M1QWJSZEVXS2J4?=
 =?utf-8?B?VFZ6UkdTcDZNSG13QU1WOElFWXlZM0NEcVYyUURUWk1kenFTSUFUa3JsbkxI?=
 =?utf-8?B?NmMzckkzZm9lRVpjUm0xM1Z4eHdLV3BBRTdiT2FMNWQxWnllaG00Q0lieUoy?=
 =?utf-8?B?Tm1uVk5OR3hOc1cvcjM5aFdFUkR3dEpyK2Nmdmt6LzJ4YzhLbXFNRkpndmll?=
 =?utf-8?B?dkVhbndtZmlnSVJUQ3pudDRoQlQySFRueVFPeERxMlVVWmlSckJjQi9CNE1U?=
 =?utf-8?B?L1dDbHB4eEhxQWduWm95TVg1Ymg0dVRWL2dlb3hpU1kwQ2VOUC96QzBBVWxi?=
 =?utf-8?B?RkV3UjhHenFYWlc2QnRoeE5POGVvaG5LOFBTbFFLd1ZWd291Z1RWVWljTHNT?=
 =?utf-8?B?OS96NTdvVVo2NWNyd3k0WEFkWjVyWVRNeUZPd3hnbzdTWTU2aWc2cGFXNEhZ?=
 =?utf-8?B?eXZQd1FZanExd2dlZVJsYmlLQzcvQ0I3OHo4Z2F5c3phZmhjU3J1dFFVckM3?=
 =?utf-8?B?dDRlSVg3dFBqNFhhS1RyWGtUUkM3N1d6bUhpdGpjb1QwYWNMQm1tdW9SZnhv?=
 =?utf-8?B?VUk1VENZZFQrZHBRc3l5cHFXZFNudTNJMHliZ3k3SE9HRjZjbVV2NjBmQURM?=
 =?utf-8?B?QlF6aHI3dGFBTW5HQm9vZVdHd29mb0VtUjdjNzNDYWh5b0VmQVU5bG4vb1Ez?=
 =?utf-8?B?YUFoeHF4b0lpVUxvM2pTdjVUaE1zNjlCY05GVjB3MHllVHdMYnpKTWEycXRC?=
 =?utf-8?B?a2hwWXprQTl1UkNYYkNMTlRJR09KUW02ZUsyOFE0RW82UXdVNGpqaVNCNlla?=
 =?utf-8?B?WmgvZzV5VkNTcHlRK0FEYjJ6VUFzQUNOT3AvZzYvNXd0Zk5IdDN0TXBHUlBU?=
 =?utf-8?B?UFhCSy9BcmU5bWJpdDNHNElFbVJFY215Qm5KbStzMlVUc0J6b3AwUEFRbzBT?=
 =?utf-8?B?V0JYZUY5TlRDNkxOYWt1RGxXdVNQUW9DUTN2Wk1CNWpQekJxS1dwUlR0VmtH?=
 =?utf-8?B?U1B3b3VMdDR6M3ZCYkRBMXBMZVRrMjFjMmVyelFoSkpRQURVQnIvM0dlYnFK?=
 =?utf-8?B?cm1TN2tweFNhRjlwK1FnNUtlRDVRc041U3IwWmYxdGJEdFhLOHBUKzRFaXhh?=
 =?utf-8?B?Y0cwTStMRXlXdVBPVmlPSmE0Mm43WGVwZmllVTI0Tm1QTlZocGlWQnVXNEN4?=
 =?utf-8?B?eUxLRXgzME9FS0VXTmxFWnNEQzM5ajd4dmk2TEI5TGZ6S1dCRnNmQVZrTE5w?=
 =?utf-8?B?aHluMmlvK0hSSk5XdUl5OWwxUDFBQndWL0xlQzlXeWs5VUx1SXdoMW9OMnMx?=
 =?utf-8?B?Nk5CdlNBUFdZSndJbjBxQ1hrV0dBcXBSb0UrS1EwaStiaEY2UFkwK2JXS2Rn?=
 =?utf-8?B?L3l5NmV3TWR2T0pQQkgrL1h1K3h0VjhySHVIY0oxYmMvc05CK3JMOWxwZCtI?=
 =?utf-8?B?UmZoTXhpeTV6T3hhOTdWTnRkdmdlODFPZUpwenBoMzl1UHY1RE9kUk5RZ0FY?=
 =?utf-8?Q?TU4O+L?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(14060799003)(1800799024)(35042699022)(376014)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 22:25:16.9882 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0673d821-166d-4d0f-f941-08dda3b6aeea
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000040.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7796
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

PiA+IFRvZGF5LCBEUERLIGFwcGxpY2F0aW9ucyBiZW5lZml0IGZyb20gRGlyZWN0IENhY2hlIEFj
Y2VzcyAoRENBKQ0KPiA+IGZlYXR1cmVzIGxpa2UgSW50ZWwgRERJTyBhbmQgQXJtJ3Mgd3JpdGUt
YWxsb2NhdGUtdG8tU0xDLiBIb3dldmVyLA0KPiA+IHRob3NlIGZlYXR1cmVzIGRvIG5vdCBhbGxv
dyBmaW5lLWdyYWluZWQgY29udHJvbCBvZiBkaXJlY3QgY2FjaGUNCj4gPiBhY2Nlc3MsIHN1Y2gg
YXMgc3Rhc2hpbmcgcGFja2V0cyBpbnRvIHVwcGVyLWxldmVsIGNhY2hlcyAoTDIgY2FjaGVzKQ0K
PiA+IG9mIGEgcHJvY2Vzc29yIG9yIHRoZSBzaGFyZWQgY2FjaGUgb2YgYSBjaGlwbGV0LiBQQ0ll
IFRMUCBQcm9jZXNzaW5nDQo+ID4gSGludHMgKFRQSCkgYWRkcmVzc2VzIHRoaXMgbmVlZCBpbiBh
IHZlbmRvci1hZ25vc3RpYyBtYW5uZXIuIFRQSA0KPiA+IGNhcGFiaWxpdHkgaGFzIGV4aXN0ZWQg
c2luY2UgUENJIEV4cHJlc3MgQmFzZSBTcGVjaWZpY2F0aW9uIHJldmlzaW9uDQo+ID4gMy4wOyB0
b2RheSwgbnVtZXJvdXMgTmV0d29yayBJbnRlcmZhY2UgQ2FyZHMgYW5kIGludGVyY29ubmVjdHMg
ZnJvbQ0KPiA+IGRpZmZlcmVudCB2ZW5kb3JzIHN1cHBvcnQgVFBIIGNhcGFiaWxpdHkuIFRQSCBj
b21wcmlzZXMgYSBzdGVlcmluZyB0YWcNCj4gPiAoU1QpIGFuZCBhIHByb2Nlc3NpbmcgaGludCAo
UEgpLiBTVCBzcGVjaWZpZXMgdGhlIGNhY2hlIGxldmVsIG9mIGEgQ1BVDQo+ID4gYXQgd2hpY2gg
dGhlIGRhdGEgc2hvdWxkIGJlIHdyaXR0ZW4gdG8gKG9yIERDQWVkIGludG8pLCB3aGlsZSBQSCBp
cyBhDQo+ID4gaGludCBwcm92aWRlZCBieSB0aGUgUENJZSByZXF1ZXN0ZXIgdG8gdGhlIGNvbXBs
ZXRlciBvbiBhbiB1cGNvbWluZw0KPiA+IHRyYWZmaWMgcGF0dGVybi4gU29tZSBOSUMgdmVuZG9y
cyBidW5kbGUgVFBIIGNhcGFiaWxpdHkgd2l0aA0KPiA+IGZpbmUtZ3JhaW5lZCBjb250cm9sIG92
ZXIgdGhlIHR5cGUgb2Ygb2JqZWN0cyB0aGF0IGNhbiBiZSBzdGFzaGVkIGludG8NCj4gPiBDUFUg
Y2FjaGVzLCBzdWNoIGFzDQo+ID4NCj4gPiAtIFJ4L1R4IHF1ZXVlIGRlc2NyaXB0b3JzDQo+ID4g
LSBQYWNrZXQtaGVhZGVycw0KPiA+IC0gUGFja2V0LXBheWxvYWRzDQo+ID4gLSBEYXRhIGZyb20g
YSBnaXZlbiBvZmZzZXQgZnJvbSB0aGUgc3RhcnQgb2YgYSBwYWNrZXQNCj4gPg0KPiA+IE5vdGUg
dGhhdCBzdGFzaGFibGUgb2JqZWN0IHR5cGVzIGFyZSBvdXRzaWRlIHRoZSBzY29wZSBvZiB0aGUg
UENJZQ0KPiA+IHN0YW5kYXJkOyB0aGVyZWZvcmUsIHZlbmRvcnMgY291bGQgc3VwcG9ydCBhbnkg
Y29tYmluYXRpb24gb2YgdGhlDQo+ID4gYWJvdmUgaXRlbXMgYXMgdGhleSBzZWUgZml0Lg0KPiA+
DQo+ID4gVG8gZW5hYmxlIFRQSCBhbmQgZmluZS1ncmFpbmVkIHBhY2tldCBzdGFzaGluZywgdGhp
cyBBUEkgZXh0ZW5kcyB0aGUNCj4gPiBldGhkZXYgbGlicmFyeSBhbmQgdGhlIFBDSSBidXMgZHJp
dmVyLiBJbiB0aGlzIGRlc2lnbiwgdGhlIGFwcGxpY2F0aW9uDQo+ID4gcHJvdmlkZXMgaGludHMg
dG8gdGhlIFBNRCB2aWEgdGhlIGV0aGRldiBzdGFzaGluZyBBUEkgdG8gaW5kaWNhdGUgdGhlDQo+
ID4gdW5kZXJseWluZyBoYXJkd2FyZSBhdCB3aGljaCBDUFUgYW5kIGNhY2hlIGxldmVsIGl0IHBy
ZWZlcnMgYSBwYWNrZXQNCj4gPiB0byBlbmQgdXAuIE9uY2UgdGhlIFBNRCByZWNlaXZlcyBhIENQ
VSBhbmQgYSBjYWNoZS1sZXZlbCBjb21iaW5hdGlvbg0KPiA+IChvciBhIGxpc3Qgb2Ygc3VjaCBj
b21iaW5hdGlvbnMpLCBpdCBtdXN0IGV4dHJhY3QgdGhlIG1hdGNoaW5nIFNUIGZyb20NCj4gPiB0
aGUgUENJIGJ1cyBkcml2ZXIgZm9yIHN1Y2ggY29tYmluYXRpb25zLiBUaGUgUENJIGJ1cyBkcml2
ZXINCj4gPiBpbXBsZW1lbnRzIHRoZSBUUEggZnVuY3Rpb25zIGluIGFuIE9TIHNwZWNpZmljIHdh
eTsgZm9yIExpbnV4LCBpdA0KPiA+IGRlcGVuZHMgb24gdGhlIFRQSCBjYXBhYmlsaXRpZXMgb2Yg
dGhlIFZGSU8ga2VybmVsIGRyaXZlci4NCj4gPg0KPiA+IEFuIGFwcGxpY2F0aW9uIHVzZXMgdGhl
IGNhY2hlIHN0YXNoaW5nIGV0aGRldiBBUEkgYnkgZmlyc3QgY2FsbGluZyB0aGUNCj4gPiBydGVf
ZXRoX2Rldl9zdGFzaGluZ19jYXBhYmlsaXRpZXNfZ2V0KCkgZnVuY3Rpb24gdG8gZmluZCBvdXQg
d2hhdA0KPiA+IG9iamVjdCB0eXBlcyBjYW4gYmUgc3Rhc2hlZCBpbnRvIGEgQ1BVIGNhY2hlIGJ5
IHRoZSBOSUMgb3V0IG9mIHRoZQ0KPiA+IG9iamVjdCB0eXBlcyBpbiB0aGUgYnVsbGV0ZWQgbGlz
dCBhYm92ZS4gVGhpcyBmdW5jdGlvbiB0YWtlcyBhIHBvcnRfaWQNCj4gPiBhbmQgYSBwb2ludGVy
IHRvIGEgdWludDE2X3QgdG8gcmVwb3J0IGJhY2sgdGhlIG9iamVjdCB0eXBlIGZsYWdzLiBQTUQN
Cj4gPiBpbXBsZW1lbnRzIHRoZSBzdGFzaGluZ19jYXBhYmlsaXRpZXNfZ2V0IGZ1bmN0aW9uIHBv
aW50ZXIgaW4NCj4gPiBldGhfZGV2X29wcy4gSWYgdGhlIHVuZGVybHlpbmcgcGxhdGZvcm0gb3Ig
dGhlIE5JQyBkb2VzIG5vdCBzdXBwb3J0DQo+ID4gVFBILCB0aGlzIGZ1bmN0aW9uIHJldHVybnMg
LUVOT1RTVVAsIGFuZCB0aGUgYXBwbGljYXRpb24gc2hvdWxkDQo+ID4gY29uc2lkZXIgYW55IHZh
bHVlcyBzdG9yZWQgaW4gdGhlIG9iamVjdCBpbnZhbGlkLg0KPiA+DQo+ID4gT25jZSB0aGUgYXBw
bGljYXRpb24ga25vd3MgdGhlIHN1cHBvcnRlZCBvYmplY3QgdHlwZXMgdGhhdCBjYW4gYmUNCj4g
PiBzdGFzaGVkLCB0aGUgbmV4dCBzdGVwIGlzIHRvIHNldCB0aGUgc3RlZXJpbmcgdGFncyBmb3Ig
dGhlIHBhY2tldHMNCj4gPiBhc3NvY2lhdGVkIHdpdGggUnggYW5kIFR4IHF1ZXVlcyB2aWENCj4g
PiBydGVfZXRoX2Rldl9zdGFzaGluZ197cngsdHh9X2NvbmZpZ19zZXQoKSBldGhkZXYgbGlicmFy
eSBmdW5jdGlvbnMuDQo+ID4gQm90aCBmdW5jdGlvbnMgaGF2ZSBhbiBpZGVudGljYWwgc2lnbmF0
dXJlLCBhIHBvcnRfaWQsIGEgcXVldWVfaWQsIGFuZA0KPiA+IGEgY29uZmlnIG9iamVjdC4gVGhl
IHBvcnRfaWQgYW5kIHRoZSBxdWV1ZV9pZCBhcmUgdXNlZCB0byBsb2NhdGUgdGhlDQo+ID4gZGV2
aWNlIGFuZCB0aGUgcXVldWUuIFRoZSBjb25maWcgb2JqZWN0IGlzIG9mIHR5cGUgc3RydWN0DQo+
ID4gcnRlX2V0aF9zdGFzaGluZ19jb25maWcsIHdoaWNoIHNwZWNpZmllcyB0aGUgbGNvcmVfaWQg
YW5kIHRoZQ0KPiA+IGNhY2hlX2xldmVsLCBpbmRpY2F0aW5nIHdoZXJlIG9iamVjdHMgZnJvbSB0
aGlzIHF1ZXVlIHNob3VsZCBiZSBzdGFzaGVkLg0KPiA+IFRoZSAnb2JqZWN0cycgZmllbGQgaW4g
dGhlIGNvbmZpZyBzZXRzIHRoZSB0eXBlcyBvZiBvYmplY3RzIHRoZQ0KPiA+IGFwcGxpY2F0aW9u
IHdpc2hlcyB0byBzdGFzaCBiYXNlZCBvbiB0aGUgY2FwYWJpbGl0aWVzIGZvdW5kIGVhcmxpZXIu
DQo+ID4gTm90ZSB0aGF0IGlmIHRoZSAnb2JqZWN0cycgZmllbGQgaW5jbHVkZXMgdGhlIGZsYWcN
Cj4gPiBSVEVfRVRIX0RFVl9TVEFTSF9PQkpFQ1RfT0ZGU0VULCB0aGUgJ29mZnNldCcgZmllbGQg
bXVzdCBiZSB1c2VkIHRvDQo+ID4gc2V0IHRoZSBkZXNpcmVkIG9mZnNldC4gVGhlc2UgZnVuY3Rp
b25zIGludm9rZSBQTUQgaW1wbGVtZW50YXRpb25zIG9mDQo+ID4gdGhlIHN0YXNoaW5nIGZ1bmN0
aW9uYWxpdHkgdmlhIHRoZSBzdGFzaGluZ197cngsdHh9X2hpbnRzX3NldCBmdW5jdGlvbg0KPiA+
IGNhbGxiYWNrcyBpbiB0aGUgZXRoX2Rldl9vcHMsIHJlc3BlY3RpdmVseS4NCj4gPg0KPiA+IFRo
ZSBQTUQncyBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgc3Rhc2hpbmdfcnhfaGludHNfc2V0KCkgYW5k
DQo+ID4gc3Rhc2hpbmdfdHhfaGludHNfc2V0KCkgZnVuY3Rpb25zIGlzIHVsdGltYXRlbHkgcmVz
cG9uc2libGUgZm9yDQo+ID4gZXh0cmFjdGluZyB0aGUgU1QgdmlhIHRoZSBBUEkgcHJvdmlkZWQg
YnkgdGhlIFBDSSBidXMgZHJpdmVyLiBCZWZvcmUNCj4gPiBleHRyYWN0aW5nIFNUcywgdGhlIFBN
RCBzaG91bGQgZW5hYmxlIHRoZSBUUEggY2FwYWJpbGl0eSBpbiB0aGUNCj4gPiBlbmRwb2ludCBk
ZXZpY2UgYnkgY2FsbGluZyB0aGUgcnRlX3BjaV90cGhfZW5hYmxlKCkgZnVuY3Rpb24uwqAgVGhl
DQo+ID4gYXBwbGljYXRpb24gYmVnaW5zIHRoZSBTVCBleHRyYWN0aW9uIHByb2Nlc3MgYnkgY2Fs
bGluZyB0aGUNCj4gPiBydGVfcGNpX3RwaF9zdF9nZXQoKSBmdW5jdGlvbiBpbiBkcml2ZXJzL2J1
cy9wY2kvcnRlX2J1c19wY2kuaCwgd2hpY2gNCj4gPiByZXR1cm5zIFNUcyB2aWEgdGhlIHNhbWUg
cnRlX3RwaF9pbmZvIG9iamVjdHMgYXJyYXkgcGFzc2VkIGludG8gaXQgYXMNCj4gPiBhbiBhcmd1
bWVudC7CoCBPbmNlIFBNRCBhY3F1aXJlcyBTVCwgdGhlIHN0YXNoaW5nX3tyeCx0eH1faGludHNf
c2V0DQo+ID4gY2FsbGJhY2tzIGltcGxlbWVudGVkIGluIHRoZSBQTUQgYXJlIHJlYWR5IHRvIHNl
dCB0aGUgU1QgYXMgcGVyIHRoZQ0KPiA+IHJ0ZV9ldGhfc3Rhc2hpbmdfY29uZmlnIG9iamVjdCBw
YXNzZWQgdG8gdGhlbSBieSB0aGUgaGlnaGVyLWxldmVsDQo+ID4gZXRoZGV2IGZ1bmN0aW9ucyBy
ZXRfZXRoX2Rldl9zdGFzaGluZ197cngsdHh9X2hpbnRzKCkuIEFzIHBlciB0aGUgUENJZQ0KPiA+
IHNwZWNpZmljYXRpb24sIFNUcyBjYW4gYmUgcGxhY2VkIG9uIHRoZSBNU0ktWCB0YWJsZXMgb3Ig
aW4gYQ0KPiA+IGRldmljZS1zcGVjaWZpYyBsb2NhdGlvbi4gRm9yIFBNRHMsIHNldHRpbmcgdGhl
IFNUcyBvbiBxdWV1ZSBjb250ZXh0cw0KPiA+IGlzIHRoZSBvbmx5IHZpYWJsZSB3YXkgb2YgdXNp
bmcgVFBILiBUaGVyZWZvcmUsIHRoZSBQTURzIHNob3VsZCBvbmx5IGVuYWJsZSBUUEgNCj4gaW4g
ZGV2aWNlLXNwZWNpZmljIG1vZGUuDQo+ID4NCj4gPiBWNC0+VjU6DQo+ID4gICogRW5hYmxlIHN0
YXNoaW5nLWhpbnRzIChUUEgpIGluIEludGVsIGk0MGUgZHJpdmVyLg0KPiA+ICAqIFVwZGF0ZSBl
eHBvcnRlZCBzeW1ib2wgdmVyc2lvbiBmcm9tIDI1LjAzIHRvIDI1LjA3Lg0KPiA+ICAqIEFkZCBU
UEggbW9kZSBtYWNyb3MuDQo+ID4NCj4gPiBWMy0+VjQ6DQo+ID4gICogQWRkIFZGSU8gSU9DVEwg
YmFzZWQgU1QgZXh0cmFjdGlvbiBtZWNoYW5pc20gdG8gTGludXggUENJIGJ1cw0KPiA+IGRyaXZl
cg0KPiA+ICAqIFJlbW92ZSBTVCBleHRyYWN0aW9uIHZpYSBkaXJlY3QgYWNjZXNzIHRvIEFDUEkg
X0RTTQ0KPiA+ICAqIFJlcGxhY2UgcnRlX3BjaV9leHRyYWN0X3RwaF9zdCgpIHdpdGggcnRlX3Bj
aV90cGhfc3RfZ2V0KCkgaW4gUENJDQo+ID4gICAgYnVzIGRyaXZlci4NCj4gPg0KPiA+IFdhdGhz
YWxhIFZpdGhhbmFnZSAoNCk6DQo+ID4gICBwY2k6IGFkZCBub24tbWVyZ2VkIExpbnV4IHVBUEkg
Y2hhbmdlcw0KPiA+ICAgYnVzL3BjaTogaW50cm9kdWNlIHRoZSBQQ0llIFRMUCBQcm9jZXNzaW5n
IEhpbnRzIEFQSQ0KPiA+ICAgZXRoZGV2OiBpbnRyb2R1Y2UgdGhlIGNhY2hlIHN0YXNoaW5nIGhp
bnRzIEFQSQ0KPiA+ICAgbmV0L2k0MGU6IGVuYWJsZSBUUEggaW4gaTQwZQ0KPiA+DQo+ID4gIGRy
aXZlcnMvYnVzL3BjaS9ic2QvcGNpLmMgICAgICAgICAgICB8ICA0MyArKysrKysrDQo+ID4gIGRy
aXZlcnMvYnVzL3BjaS9idXNfcGNpX2RyaXZlci5oICAgICB8ICA1MiArKysrKysrKw0KPiA+ICBk
cml2ZXJzL2J1cy9wY2kvbGludXgvcGNpLmMgICAgICAgICAgfCAxMDAgKysrKysrKysrKysrKysr
Kw0KPiA+ICBkcml2ZXJzL2J1cy9wY2kvbGludXgvcGNpX2luaXQuaCAgICAgfCAgMTQgKysrDQo+
ID4gIGRyaXZlcnMvYnVzL3BjaS9saW51eC9wY2lfdmZpby5jICAgICB8IDE3MCArKysrKysrKysr
KysrKysrKysrKysrKysrKysNCj4gPiAgZHJpdmVycy9idXMvcGNpL3ByaXZhdGUuaCAgICAgICAg
ICAgIHwgICA4ICsrDQo+ID4gIGRyaXZlcnMvYnVzL3BjaS9ydGVfYnVzX3BjaS5oICAgICAgICB8
ICA2NyArKysrKysrKysrKw0KPiA+ICBkcml2ZXJzL2J1cy9wY2kvd2luZG93cy9wY2kuYyAgICAg
ICAgfCAgNDMgKysrKysrKw0KPiA+ICBkcml2ZXJzL25ldC9pbnRlbC9pNDBlL2k0MGVfZXRoZGV2
LmMgfCAxMjcgKysrKysrKysrKysrKysrKysrKysNCj4gPiAga2VybmVsL2xpbnV4L3VhcGkvbGlu
dXgvdmZpb190cGguaCAgIHwgMTAyICsrKysrKysrKysrKysrKysNCj4gPiAgbGliL2V0aGRldi9l
dGhkZXZfZHJpdmVyLmggICAgICAgICAgIHwgIDY2ICsrKysrKysrKysrDQo+ID4gIGxpYi9ldGhk
ZXYvcnRlX2V0aGRldi5jICAgICAgICAgICAgICB8IDE0OSArKysrKysrKysrKysrKysrKysrKysr
Kw0KPiA+ICBsaWIvZXRoZGV2L3J0ZV9ldGhkZXYuaCAgICAgICAgICAgICAgfCAxNTggKysrKysr
KysrKysrKysrKysrKysrKysrKw0KPiA+ICBsaWIvcGNpL3J0ZV9wY2kuaCAgICAgICAgICAgICAg
ICAgICAgfCAgMTUgKysrDQo+ID4gIDE0IGZpbGVzIGNoYW5nZWQsIDExMTQgaW5zZXJ0aW9ucygr
KQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQga2VybmVsL2xpbnV4L3VhcGkvbGludXgvdmZpb190
cGguaA0KPiA+DQo+IA0KPiBIb3cgd2lsbCB0aGlzIGltcGFjdCBleGlzdGluZyBhcHBsaWNhdGlv
bnMgdGhhdCBuZXZlciB1c2UgdGhlIEFQST8NCj4gSXQgaXMgY3J1Y2lhbCB0aGF0IGV4aXN0aW5n
IDNyZCBwYXJ0eSBhcHBsaWNhdGlvbnMsIGp1c3Qgd29yayB3aXRob3V0IG1vZGlmaWNhdGlvbnMu
DQo+IFdlIGRvbid0IHdhbnQgdG8gaGVhciBmcm9tIE5ldHdvcmsgVmlydHVhbCBBcHBsaWFuY2Ug
dmVuZG9ycyB0aGF0IHRoZXJlIGlzIGENCj4gcGVyZm9ybWFuY2UgcmVncmVzc2lvbiBpbiBEUERL
LiBUaGV5IGFyZSBhbHJlYWR5IHJlbHVjdGFudCB0byBrZWVwIHVwIHdpdGgNCj4gRFBESyB2ZXJz
aW9ucy4NCj4gDQo+IEkuZSBpZiB0aGUgYXBwbGljYXRpb24gZG9lcyBub3RoaW5nIGNhY2hpbmcg
bXVzdCBiZSBlbmFibGVkLg0KDQpJdCB3b24ndCBhZmZlY3Qgc3VjaCBhcHBsaWNhdGlvbnMuDQoN
Ci0td2F0aHNhbGENCg0K
