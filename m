Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3CCC83F17
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 10:58:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8242B402CC;
	Wed, 23 Jul 2025 12:58:55 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013022.outbound.protection.outlook.com
 [52.101.83.22]) by mails.dpdk.org (Postfix) with ESMTP id B488040264
 for <dev@dpdk.org>; Wed, 23 Jul 2025 12:58:54 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=s/pzYXtG5SvV6daJwMkY/MunFi8kbcWWtp/KmNtqQ7DW+wg9GH7tYiCRuv3nSh9dRT1Pooamx+GbbfJdkAfRCB0k5/epMlBPFwMdkJrLPc5lFTziLiD+8GrT9b3msZfL/E81huilcx3T2SBfTJIm6XVcPuiW/kwYQvy9FDbs00ET5Ep2qq/BOgSGt4gg1pUWXd71rzQYYF4k+RNEKfTpTFhrFBw6hqfW5b+IAPIZOhN3jzveWHJkQHAXnV5uXSIJ6hzUjIR2umL7kEgq5jGt224UvwBxP4q4x/oRJm0S+Ne5jevPCvee1l0UIwEUZMyWe1WE/NcCAWNU1iwX9rVDbA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqHWMnBHV6pqJbIvJ7d6+rER1wWRdJ2vFMF8cjbBEic=;
 b=Bqc5c9lJ71/KcSDVq5+b+HbL1tX95oDYZpAmhizeryrCS7xcIshsT64V8a0F0aVnMRH0ui7r8MbkOmmQ4Sp2YIphKGKhaMXzmXTUp4eavcTOB2Z2igKfmFiqoVufx/J8jvN6KarPq81pfEPbGTJr3zU2OPZa+jRZqXjbKPygTNy6LeHjAbg606RKB3Ye++ub2Zq5wb405Bddb92dg1iWwDBhohvuhz3GVAf+g/gGLNgOdtqZ29mrrxypfYknHHO1Gobbq16vULJPWykAfgTn5fHqRd96CpcIKoouxzgZiEI0bBkN2naVXKxaWq3MMPq4RKcx0OJZTWdnRFhicfcKYQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=iol.unh.edu smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqHWMnBHV6pqJbIvJ7d6+rER1wWRdJ2vFMF8cjbBEic=;
 b=rN8LvYwE2aGEeLWlyxkCJFjxD0WH1pAF7t3EfmblZXEdTR543mKboaOdo62F3MallR7hJx6zm7ZxQ012bC4sMcA/KYtrwBiYcRdtaO0Csn//24CBZmnHG3SiVCGDMy2BxDQJ8C7RNAkjO5KVDHDPkVBNak6truahGu8ASleNgC0=
Received: from DU7PR01CA0028.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::13) by PAXPR08MB7352.eurprd08.prod.outlook.com
 (2603:10a6:102:22a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 10:58:50 +0000
Received: from DB1PEPF0003922F.eurprd03.prod.outlook.com
 (2603:10a6:10:50e:cafe::8a) by DU7PR01CA0028.outlook.office365.com
 (2603:10a6:10:50e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Wed,
 23 Jul 2025 10:59:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF0003922F.mail.protection.outlook.com (10.167.8.102) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20
 via Frontend Transport; Wed, 23 Jul 2025 10:58:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cpd7yjdFpH0yPtrxbsHirr4KGTk3Afb1+ezi72ptPi2WIdfc85Z+9lKCULNna/xlqb7z5TD5lUL6GZIUSgdY82mHQWhedsjdYcaSkdu0wk0f6z+STgthlV0e6MD2w5sh0uxbHmPZy/YQkOoB0nzd93YlmgFtmkDVD9Gfmv/FoFcIUKrxvVEyPVXcwLMqRzREH9zm6+BKawzshUojRFR/N/hdHwourU7gEgIjUOogW+djI7i+5095B7fqmiM1qb7kVZAoynhBk12f3h671yCZBwkeAXNN2wB8vKBjVFTYFbs5XgMpZ2MOBv3XF1MsgZLJZ9kHVlxtTIw2Jt7PdLIH7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqHWMnBHV6pqJbIvJ7d6+rER1wWRdJ2vFMF8cjbBEic=;
 b=zMltU51DME+TCGjvtDeahdT2hLvqNrTa2Cj2IQufzUIRE9/XCnXC7SKeAG3h0vwTEasMXC20N/TRCPtGAzIektqHwuk1Lbxq5Yl+tY1n83tqrXZPAFqIGD2HOte7ec7XF2U7BOPBsfUURI/T2kifceZ71QWH9IT7/ac2MzC1ZsXXVZ7yvnWDkbqzxpFCvvcBuxECm4T9967CvTufJCXCraFIWJBwMDEcDMPitXEdPSgsCZFVIEAzw4ID4U5++TQ71/aJX5g0pilise1Efr5w11W5wfElCEnd1XVFYp6aZvULC3VfXqN0tSbvseopG+TxyZlTsazHBmuz/a0M7lG2Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqHWMnBHV6pqJbIvJ7d6+rER1wWRdJ2vFMF8cjbBEic=;
 b=rN8LvYwE2aGEeLWlyxkCJFjxD0WH1pAF7t3EfmblZXEdTR543mKboaOdo62F3MallR7hJx6zm7ZxQ012bC4sMcA/KYtrwBiYcRdtaO0Csn//24CBZmnHG3SiVCGDMy2BxDQJ8C7RNAkjO5KVDHDPkVBNak6truahGu8ASleNgC0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB4PR08MB8151.eurprd08.prod.outlook.com (2603:10a6:10:381::16)
 by DB9PR08MB6347.eurprd08.prod.outlook.com (2603:10a6:10:253::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 10:58:16 +0000
Received: from DB4PR08MB8151.eurprd08.prod.outlook.com
 ([fe80::2dd2:fd4d:8ff5:3733]) by DB4PR08MB8151.eurprd08.prod.outlook.com
 ([fe80::2dd2:fd4d:8ff5:3733%2]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 10:58:16 +0000
Message-ID: <71bdc991-62a8-4d13-bfb0-c23f868af2c7@arm.com>
Date: Wed, 23 Jul 2025 11:58:15 +0100
User-Agent: Mozilla Thunderbird
Cc: nd@arm.com, dev@dpdk.org
Subject: Re: [PATCH] maintainers: update for DTS
To: Patrick Robb <probb@iol.unh.edu>, Luca Vizzarro <luca.vizzarro@arm.com>
References: <20250722160529.2659392-1-luca.vizzarro@arm.com>
 <CAJvnSUDetAq7uRJaCwVf9+QrYn=rTAjxra3zPev_ieRVds33Sw@mail.gmail.com>
Content-Language: en-US
From: Paul Szczepanek <paul.szczepanek@arm.com>
In-Reply-To: <CAJvnSUDetAq7uRJaCwVf9+QrYn=rTAjxra3zPev_ieRVds33Sw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0038.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::15) To DB4PR08MB8151.eurprd08.prod.outlook.com
 (2603:10a6:10:381::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB4PR08MB8151:EE_|DB9PR08MB6347:EE_|DB1PEPF0003922F:EE_|PAXPR08MB7352:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c1a5cb3-eb12-455b-38cf-08ddc9d7e760
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?S0FKODYrN0JYaGxiZGxjajlXdXM2cERRSmcxK2pHWGQwQ09FaVE1ZHF5b2x0?=
 =?utf-8?B?S2p3NHlPaHk0bnhTMWNoNlYxd0J4ZE5GeDhzdzlYOEdsSGFZOHloT0xzTmRL?=
 =?utf-8?B?a1lacnM4TTNXNm94YVc4YTNnNEZxM043MVRjWElLNnpyeDcxZzduQSsvZ21s?=
 =?utf-8?B?Y0VMUW5MTGVTMkhmZ2cyditUSXg4RWJsS0piL0g4N3ZGY2pIYWN5MWJIS3hp?=
 =?utf-8?B?bGJ5TS9hY245UW5FUDQ1UlVxT3B0NWdsa1pDNHI1MGttL3BwWXZWNDZCSnVM?=
 =?utf-8?B?V2RNdUZxV2NyVnBHNUZVUFlkcEdCT2E0aVduRE9jbGlZRWd3QWlJcXBqajA0?=
 =?utf-8?B?bjl2bTJpdkhFd1J2cHBwQ1llYlhqZDhXOVVxaVA0RDFQc0s1c2t5UTZHZ1dI?=
 =?utf-8?B?RmY0ZTF0RWgwQWoyWlRldDZLSVRmcm1OdmlZT1Q2bTlzWGpJd0QrSW9pRWx6?=
 =?utf-8?B?dFk2aWRkTWhtaWtrY3h3UjdGcGRZTmhvbkY2N0JGTmNMTGV0bzBSeTNMNVg3?=
 =?utf-8?B?cWdLajVKUG11Y09TaldOMmJtUHdKN2pPV1dOOHV3K2R5S3hRVC8zRWRrOWtS?=
 =?utf-8?B?ZW5zL3o4T1BRdkRtS1B3bFZhclVycENPOFBBOThqQVljbnU2K0l3dXM5TkRu?=
 =?utf-8?B?a2F4OS9WdFdkeWtsalpyd1BieWJQOEFEZk1VZThuRE4rQUhnTXIwR1g1R3Zq?=
 =?utf-8?B?SlNrZzBEUEk1c053dmcwT0M3MVRNR3hpMHovVDRvektOam1URHN5WHk2dUs5?=
 =?utf-8?B?WDc5V2dGZ1lqaUFTV0FCNVg0RjhuaEhkeHVmWnpaYU9rL2VuL2hUMzVZN2RX?=
 =?utf-8?B?S1pMODM0MGk1MFJyT1BaOUtabldSWFFyRUl5cTFUV0hoRUVtcGpKS1VoL055?=
 =?utf-8?B?VDM4NUdreEM1alhmay9KeUMvUUFDTUt5a0IvVFZkMk1nOWtzVDZrUVdWUjQ2?=
 =?utf-8?B?dVBhclROVWt0dnY1ZXBISXVkMFRuV1VUQzJPL0JWWk9VS1R4TXRYU0V3ellR?=
 =?utf-8?B?N2FVZUNiVnlUc2xiQ3JJbG50TTZFelhhLzFVSjFRZHk4VDVhTEc0OGx3OUxi?=
 =?utf-8?B?dWVIbkRwVkRxczRMdXo3QWl0akZWSzJMOVpiS2hDQ0hsaGdlelp5ME1zeS9s?=
 =?utf-8?B?alhIRFI4S3pUSXYxbnZLdTRpTHMveVNpOWJJMmFPMXl3Uld1VXJrRkExRnNy?=
 =?utf-8?B?bGVNZXh5Q1JtOVF0WkptU3lnNmRnZnRNK3o4aVl5Yjk5N1pZcEg2VkR0ckc1?=
 =?utf-8?B?NUR4ZkVRZ1pDaWo2R01ERDNKOXZkVkN0ejBydlJVejF2MUZKSEFPZXhZa1JP?=
 =?utf-8?B?ekxUUCtiKytuaEZQRGo1SllYWWNtWW1US1VtSjVQdFE5alV3azFDRm1NZjNa?=
 =?utf-8?B?ZXpIcUk2ZE5DZHo1WldBdWwrOEsrODNmTFF6a0I0UTRXeGhZanpGSXRNVE1W?=
 =?utf-8?B?a3crRXo1M25TWjIwR3lpNncxelcxbUhJeUNJdnNmZ0c0dmtTWXYyZU1pam1H?=
 =?utf-8?B?aEtTUEFucmUvWEZ1cFJNVkxTNmp0NUZIdDJ2cGd3UGlvYk85UVVLczQxcUVw?=
 =?utf-8?B?SVpLc3FyanJWM1RMRFFQbXVYNWJYZTdmeUdrd2FMcnhmQUlaNjV3dWZNR3l5?=
 =?utf-8?B?dEZwTzdIUXB2cGVNcTZtNnJTeFVyS3pnOEJvYmw2eExlaHV3dy9qRFlUSnJC?=
 =?utf-8?B?WlVPQ1JQQU5ITDBMK1JITTJ5QWt5NGFvaGJEMFpScFNCbE9MWFYxRlF4aGp1?=
 =?utf-8?B?VTRjYWlpSnhPS2hnWXo0dnoxYXZlT2cxcnI4cGxxR1Jvanc2ejRneGtOejhw?=
 =?utf-8?B?cHMwcUxzTHJ5Mnk1QVREbWFURDFSeHJKT0RMQmRDOXdoTnltay9KTjhwZThO?=
 =?utf-8?Q?T+Z2PB/tS+MlV?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB4PR08MB8151.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6347
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF0003922F.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e73e2c4a-6f4a-4839-7dd2-08ddc9d7d38c
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|35042699022|82310400026|1800799024|376014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qy8vVlJYeHZEc0hib1FTZDVGNkN3MXhPR3ZNQlhJSEUxaFluaVEzZnVkbGxu?=
 =?utf-8?B?T2lrUXF5UUlSZHZERnA5aXllRkhRUUNwQjRwcndGRWExM3VtYjFmWFMxdHlt?=
 =?utf-8?B?K2ZsSFhWS25NcVUzZ1A1dWtRcUVaRjN1STRiZStiSlY1SU4xVEUrYjBzUHlY?=
 =?utf-8?B?UFJkSlZNNjlNc2tsakdiRzRWVUFkaHRUMXVCZldYckNmYUhmMXpSNjV1K0Fi?=
 =?utf-8?B?dHkreitrM2g4ci9SQTBsamdpSFBXZTRWaldmS0pRVkRzMk56dFA5SXcrblVz?=
 =?utf-8?B?dGVPclhqalhKVFA5dXhMZ1A1cnlVNXlHRXRaMGVOOWNTSnJpbGZnM1c2Vm4w?=
 =?utf-8?B?WUFaS2hSdm5zamFZRlk2YmlHYi9GeHB2U2F4TXFHZGRsSFcrUWhET2ZDTklS?=
 =?utf-8?B?OWVXMHJKUmZ6MnJNVFdNNUNHeEtySDhDYUFRejFHNDRGUzh0TzBXbWJ0RnBo?=
 =?utf-8?B?SVU4cUZ2dVA3WWpPOHQyem9xSHZwNUVkUnNJMDFoMVhxRG9POVBZZHFPTWxT?=
 =?utf-8?B?QlpadVN6U3pXK3J1YlZaanFUTVB2bXZEZlRaNjhVa09TOG96d0dzV1JOS1pC?=
 =?utf-8?B?d3BKZGZxR1grZjdSdCtBMjd0d0Rzc3dwcGlTSmM5Qm9BR2pXMjExamlnV05N?=
 =?utf-8?B?QkpwM0M5d01ENk1qWWx6Q2VzK0Z2cDlzNkNmYkdaRzBsaGo3WXNQYS95YUZR?=
 =?utf-8?B?SlNQaDNVOHBFV1RDRU8xMWpFaWtXVW5Td0JwRzhLcFFtdVVGS3RmbGRPaUVD?=
 =?utf-8?B?QzE1QWJZcU44ekhjc25FVmZqWGlIaU1ESnUwdWFqby9iN0ZHSHJkSGUwK0hY?=
 =?utf-8?B?RTZtMGZobEx6TkRpNGIyYXFpRmc4bDFlZVgxbFRNN21KSFJTL25SYVdjTEVO?=
 =?utf-8?B?WHQrWExJN0tGN3JtNTdxRGZ4bDJ4TTczUi84Y3E0ZWZLQ3p4a1ZwT2UwMEUv?=
 =?utf-8?B?U1JzVDk2bnl4cFAvdFVMcU1iZXhOZHhEV21nbWlDZlNPY1B1djVaemlDeW5R?=
 =?utf-8?B?cFlBdFQwOHlIdHU5UVI2MEc3L2hla1dZSVVObzBrZ24zcGVORmM4K0pRaW1K?=
 =?utf-8?B?RTRtK3FCYkQrcFJqYnNUT3hTTTU0cmdSdFpZTFJpb3Q3ZXlVM21MWkRpc1VP?=
 =?utf-8?B?OFpEVGZjUGpCOVAxQi9TRzRsWVZ0U25WZEY3ZFd3T2ppK3Fka0ZJeDV1bElD?=
 =?utf-8?B?dk5OeHkxdEUvRlBwWUZaelVieWFsYzhWV2h2S0NQY0JlT1ZjdXU3WFhhYjBG?=
 =?utf-8?B?S05KeWdZRjZPQ0h0TW1jclcxMFZ4NFI2NkdxMXR4NHd3RzFEeW0yUWw4WmUv?=
 =?utf-8?B?OVNIcTByRU02RTg2YktnN0xFcDhhZjVTRWFTRE9VRmdKWHFTbU1GZndJQmF5?=
 =?utf-8?B?SkN2Z3ZmZUN0UDB1MFRqVWpYVmEvcU1vNkNWMGxlQ3pRTHQ2am9LQ0Y0dzA4?=
 =?utf-8?B?WmkzNDdCenFCL3FNUTg1TUs0L2FSVWExZ1UxUDJEZDRkVHpiZVZFeU1oZ3c1?=
 =?utf-8?B?RGZ6ZWcwbnpPcE5MQXM3Y05LMEI0QzVRbkZFUFpBZkl6Y0lxcnBMYzJNK2Zs?=
 =?utf-8?B?Y3gzM3A4NGV6QTc3SDM0cHlhYWlOWXJrbzJUNnRsR0pHQi9XbUk0djZUQXdm?=
 =?utf-8?B?TWQ3dGlpazlqb3d0WmtlQ0hpMlBoVkxiRDF4SGljL0dzWHdKQWdNODlLTlZS?=
 =?utf-8?B?dCt4eWpBOXRUQU90ZzliS1hiWXMzNlhkbFNUR1VLTjcyWTZySXBobDc4M0hB?=
 =?utf-8?B?SWdBc3JqWTFEalNaL0loKy9vTGVLdWJOaXFmbW1aa2hqVHo2Z1BrZXhxTXZM?=
 =?utf-8?B?L2J0MGdwYkpidGlJSlRCVnlITmc4VE0zdnVQZ05vTDdvMUNpM2RiL3FpbjJW?=
 =?utf-8?B?NGZnQUhYdzVKWk85eFJqOHdtc1J1QnJrM25rVGZ0azBqZ0xPMW1FU25nYVVt?=
 =?utf-8?B?MWNpdTdsdkx1S2o2bnp3UWVxZWlqRUJSMUsyanRoRWxZRE1Obmk1Y3pXVk5v?=
 =?utf-8?Q?Hzw5Zv11xLFy8JodppRdCum+Ch3050=3D?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(35042699022)(82310400026)(1800799024)(376014)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 10:58:49.3036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1a5cb3-eb12-455b-38cf-08ddc9d7e760
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF0003922F.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7352
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

Don't think I can "elect" anyone but we did discuss it with other
maintainers during the recent release meeting and motion was seconded by
Bruce (I think) and run unopposed.

Acked-by: Paul Szczepanek <paul.szczepanek@arm.com>

On 22/07/2025 17:04, Patrick Robb wrote:
> Acked-by: Patrick Robb <probb@iol.unh.edu <mailto:probb@iol.unh.edu>>
> 
> I'm not sure whether my approval is needed or not, but for the record
> Luca has been making contributions to DTS for more than a year now and
> is very capable of acting as maintainer.
> 
> On Tue, Jul 22, 2025 at 12:07 PM Luca Vizzarro <luca.vizzarro@arm.com
> <mailto:luca.vizzarro@arm.com>> wrote:
> 
>     Paul is giving up his role of co-maintainer of DTS, electing Luca
>     Vizzarro in his place.
> 
>     Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com
>     <mailto:luca.vizzarro@arm.com>>
>     ---
>      MAINTAINERS | 2 +-
>      1 file changed, 1 insertion(+), 1 deletion(-)
> 
>     diff --git a/MAINTAINERS b/MAINTAINERS
>     index 0e9357f3a3..2098a68b1e 100644
>     --- a/MAINTAINERS
>     +++ b/MAINTAINERS
>     @@ -65,7 +65,7 @@ M: Maxime Coquelin <maxime.coquelin@redhat.com
>     <mailto:maxime.coquelin@redhat.com>>
>      T: git://dpdk.org/next/dpdk-next-baseband <http://dpdk.org/next/
>     dpdk-next-baseband>
> 
>      Next-dts Tree
>     -M: Paul Szczepanek <paul.szczepanek@arm.com
>     <mailto:paul.szczepanek@arm.com>>
>     +M: Luca Vizzarro <luca.vizzarro@arm.com <mailto:luca.vizzarro@arm.com>>
>      M: Patrick Robb <probb@iol.unh.edu <mailto:probb@iol.unh.edu>>
>      T: git://dpdk.org/next/dpdk-next-dts <http://dpdk.org/next/dpdk-
>     next-dts>
> 
>     -- 
>     2.43.0
> 

