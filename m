Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E309CAC59A
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 17:41:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C143B4066A;
	Thu, 18 Sep 2025 19:41:26 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013055.outbound.protection.outlook.com
 [52.101.83.55]) by mails.dpdk.org (Postfix) with ESMTP id E9CC4402D6
 for <dev@dpdk.org>; Thu, 18 Sep 2025 19:41:24 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=jROEP52xjG2cjySMYzaAWxql/9cqJDAsbasKvvxBlwRZfMgtqq8ST6567P4RcRfcLoQoBuc8GotColiMjA0bFftJ5vQH0kqz68kjKwzfqZS6bDXM55aQGsXvVOJz/s4UlRja0WQw0+hAcGkBC7JqeC/ybxkILZf/g+IglTm7N9XAgX6fyVyUmRNzrxBJerIx3MxVU/WOOS7jVD1kkie0FgbV1db7tnSFy1uBUMALo79WFk31ogpdgZylkCXa3xgvTYL1bLNCdJsRhMGjy3ImZTuMK3svJQAeJj4B0/KGG+ZpDwv2A6u+42yLpydSQt2YMjdZ1tQwu8WxOch/epLuYg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwSVdr7DquErheWzv+KQU23Rcw1ehPMCmdSJcbYCMHs=;
 b=gGXDgQF2abcpRW6eziPC5VN32blc270aIKXfyX6EotBtwhCe2RgjXWDV3U3KGCXfbapotawIbL2C5ZLMHRc+tWJIM8FNML1OuTBbFxn3dk7772/cClaV0Ma1sOzkJ9u5Qn9USC7nCgUPkJwWjkoJ1YVSDdAROm0RG3hRQHOdnCP8JJrz8rw+sJrHJUF2cfEAWGjeYUAPLtycKAHhh3qrW8zXADoddNaU6Wm7ZuhlOlZ6W5JtXPJPFxfSKuL7/1k00V5RTLRmvZnGePRK8CODLBRnGIZcdhafGLhhbiWdVMyYX9lsLfDD7zsN7MT6dIq4PEVE/rTaxY3uln9UgtM8xA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=intel.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwSVdr7DquErheWzv+KQU23Rcw1ehPMCmdSJcbYCMHs=;
 b=A9NiHPbyGXsUMGmYKQlx1i0c3mvOfz4jXMpmpFze/pgLNypOhp8/yKlqLMMtWofJ8hH7etmzAM7txQYVVFkwMVxx3kAS+R03i0XESqtQSetJQ8+nPojh5Gc6ZSCe5ScVdZQed6BnvX8VJBQLgQ8dAFRW3MTGU9Pp3BIULA7UeGc=
Received: from AS4P192CA0005.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5da::11)
 by DB5PR08MB10310.eurprd08.prod.outlook.com (2603:10a6:10:4a1::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 17:41:19 +0000
Received: from AM4PEPF00027A6B.eurprd04.prod.outlook.com
 (2603:10a6:20b:5da:cafe::c) by AS4P192CA0005.outlook.office365.com
 (2603:10a6:20b:5da::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 17:41:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A6B.mail.protection.outlook.com (10.167.16.89) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12
 via Frontend Transport; Thu, 18 Sep 2025 17:41:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+8+/Y/RX+m9QEpAiEX/gzdHyKqBFhBTQFkaHjVGw6EG8YPYNvRhmkCaRQEb3pZdrqqAPstTBzNiNyAUTKl1pfdTHwF3PZ76bdq5eEsmvHOVy5FqEY71MXbA3489zrWTVBIWUyL7VUOwg/hej1bievOjdB/Yo6Xbngj8XueFUSwH95YKmS+6GTTBBhJ4MJh6gCPQ2MdW5n1arxOqJHctCcbHPPyE2LuweAlhsViE/q6U8pctdbG2SE+jhjAYIyC3IuoszVgiZVv0+v0btE0SR1VIl8RGuA35eKVRnY1M/fGw5VSlY0UiGf2WZXXcSWoY1Q+TcWju56U4LlutigtfPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwSVdr7DquErheWzv+KQU23Rcw1ehPMCmdSJcbYCMHs=;
 b=ETH9FZ3jAzfoDuMDCYbQtUc1q1dqa9JnyXOUUdmpJ8twFpDEwQvlZd/kJsCnD7D3GM/vAtI5WiyvItRJX4C0O69EWCitKYteFFnr/0juQRiZsypkluFrb5zn9dVqE4c7+9zchrc92syh6EI2IS+ANgQgNMJ58cHFVM6IMSk2CTivMPBJvVRLyOzIkQWefiNt/DesJUEqhLNdOl8Mnm+7FhFDBxcVIRNRag27r7JAnCvBqGrKNvuAgxVrMHyN1gjjZJdueRCLwKlxcmXMtgmPc54A7B53BtW+LTA5ey1+ffWxMzCPc/2MdYh4fp8psdcOfdQQE04bVV0+nxZhT6ZITw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwSVdr7DquErheWzv+KQU23Rcw1ehPMCmdSJcbYCMHs=;
 b=A9NiHPbyGXsUMGmYKQlx1i0c3mvOfz4jXMpmpFze/pgLNypOhp8/yKlqLMMtWofJ8hH7etmzAM7txQYVVFkwMVxx3kAS+R03i0XESqtQSetJQ8+nPojh5Gc6ZSCe5ScVdZQed6BnvX8VJBQLgQ8dAFRW3MTGU9Pp3BIULA7UeGc=
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com (2603:10a6:102:33a::19)
 by AS8PR08MB9196.eurprd08.prod.outlook.com (2603:10a6:20b:5a0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Thu, 18 Sep
 2025 17:40:46 +0000
Received: from PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294]) by PAWPR08MB8909.eurprd08.prod.outlook.com
 ([fe80::613d:8d51:60e5:d294%6]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 17:40:45 +0000
From: Wathsala Vithanage <wathsala.vithanage@arm.com>
To: Ola Liljedahl <Ola.Liljedahl@arm.com>, "bruce.richardson@intel.com"
 <bruce.richardson@intel.com>
CC: Honnappa Nagarahalli <Honnappa.Nagarahalli@arm.com>,
 "konstantin.ananyev@huawei.com" <konstantin.ananyev@huawei.com>,
 "dev@dpdk.org" <dev@dpdk.org>, Dhruv Tripathi <Dhruv.Tripathi@arm.com>
Subject: Re: [PATCH 1/1] ring: safe partial ordering for head/tail update
Thread-Topic: [PATCH 1/1] ring: safe partial ordering for head/tail update
Thread-Index: AQHcJnJid/srWO08nEqlMPhaWlMNTbSV9DeAgAAr1ICAAOHPgIACN/qA
Date: Thu, 18 Sep 2025 17:40:45 +0000
Message-ID: <def294d88e810e99d9b538e6d82e12904e073a96.camel@arm.com>
References: <20250915185451.533039-1-wathsala.vithanage@arm.com>
 <20250915185451.533039-2-wathsala.vithanage@arm.com>
 <aMmFeXsHI9VRn3GY@bricha3-mobl1.ger.corp.intel.com>
 <590A2369-28AC-494F-9E27-7CA9C670426C@arm.com>
 <aMpnqVPUDIsCj0zI@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aMpnqVPUDIsCj0zI@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: PAWPR08MB8909:EE_|AS8PR08MB9196:EE_|AM4PEPF00027A6B:EE_|DB5PR08MB10310:EE_
X-MS-Office365-Filtering-Correlation-Id: d949a009-02fd-46c1-177c-08ddf6da9330
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?ZXM0Ymo4RmU5S0xqRVFwM1ptd2p6TlJWUi9uRWJtRURIalVvQ3lBcG1CbHNY?=
 =?utf-8?B?dmRVeE02TmM5OHhQQVYyc0c4SWI1M2FSWDdVcHJ1bjlRQm0xV1hybWxCVjJD?=
 =?utf-8?B?eVR0c3l4bW9GU1BBN3hCd2xWWnpzS0J2UTdxSTZrVTZBMm0yNEVHK0NQUWF2?=
 =?utf-8?B?bEhhR0l1TXB1ekhpNno4MVU2dXVSQlhwNW5JNm45ZVRCR05XT1lKZW54M25p?=
 =?utf-8?B?RHZwblZCZXVGWE9KSGEzaWlza0t1SkpFbkRCQ2RPTEdQUHI5eG5MRDVHSmpS?=
 =?utf-8?B?VDRZOHZ4VWMvc1ZsSS9kWktvR2NGREVKNmNDUTZmTDR4OGxkenJTVFFZTm1U?=
 =?utf-8?B?VnBndFZtOHp1bDhOeGhnR2NsQ1R2UTJDZW9QSWNyYlpjN3F1QzgrWXkwT29r?=
 =?utf-8?B?c2QyYXhOanR4N3hTNmZnSitld0lvanYyWXpUdUY3ZHZZV3lBTnQ0cDdsZzdC?=
 =?utf-8?B?T2E3bTl4UnUrV05OY3FQZ1Z2eVI0aXUwNHA2dzRwYnJlc2tYN0xHQWJiQjVY?=
 =?utf-8?B?TGRlQ3JMOFBScmZLR2NZV254d0ZZNDh6c2E5QThRREF0M05MRGNoMkxwYzFJ?=
 =?utf-8?B?YmtLQnFlems0ODZ0MTRNNXNiVDBTdjZpb1I5VnJwcS85Z1NCRlRZQ1U2dHl2?=
 =?utf-8?B?S0VxZzFXNDBkbkdidkpQWVRqNVVHMXZQbHRlVDR1Z2p6b2l2WEhkZEFmODBC?=
 =?utf-8?B?blZreTI5RTVtUTk4VVBKNnVJL04yWTEvcWFxSHl6cHowM1dPRFNUcUZ1MndL?=
 =?utf-8?B?VEF0dGVhdHpyaVBiUUZlNmpnaVd3MVptenp0SE9FLyswQUt4S0hzSnFkTUJh?=
 =?utf-8?B?aHRhdFRETUoxNjRFRE83RTNMRmx2dWJmbXVPaDZCZlk5bXZFL3JsdWd1UmN5?=
 =?utf-8?B?T0plQmxMOWM0RDJ0bmoxa1RURERoOVk0eXhaZ2JXaXJSMTBqQXZMK2I3aUNG?=
 =?utf-8?B?cnFOTFhxdklIclVXVlNMRm9JZUNxQ253c0lxR1pwcHNSc0RLTlJzZDNxNXQ5?=
 =?utf-8?B?WkNqTEd6TW92VWl1YklhNmNNOTliZHdTT1o2QWExMm1BSEJ6aWcyc3kwc1VS?=
 =?utf-8?B?OFZTY1QzaGJOMmJRaXVScEpXZGpWMjJvby9oUWgwNDA5Q1dvYkljUG9taVNI?=
 =?utf-8?B?dFpvNVRSUXJqZGl3bTdzQkJwUElzQXpMUVYzaWJRR3Y0Y1dUTnNsL01tRkZM?=
 =?utf-8?B?SCs5Mm1EcjRnb0xFN3hiMmRhOUxSTWUvZE90dDhMMUczcGowb1ZZYndhVmVB?=
 =?utf-8?B?QXdYdW1GRW5zUHFWcHlqbTJlRWUwZFJGWG1hU0FzMHk3dHk2elFKSzFKZG1Z?=
 =?utf-8?B?SHdjck5OUmhUSElxMENaWVJHdHVMcnR5N1hESzhWMGYxampxRHZ2UjVDdGtX?=
 =?utf-8?B?QUFnamZHZGNpWFFEWWNIT3R6SE85TGZLSWxZcFIweEpvNEQvbis5c1hJWjlj?=
 =?utf-8?B?ZjlMa2crNEh4WFB1V0lMblg2NlZodmVkSEVGaFdPY0M0dEJiN2FJeFEraiti?=
 =?utf-8?B?TyswOHljZDg3ZWI3Vmt3dHdEcDRxOXY5bEt0MmdNR0h2OHY1elV0eFFTSzRO?=
 =?utf-8?B?RVlJV3lLUk9PbFNWb0pHNEMvOGJsQm1lL3pNN3ErYTVtbWtmSGIzOW51aDhB?=
 =?utf-8?B?eHdTZm9qVEo0ZXo1U2gwTjhTcWdVT2lDdk4rT0p3SGRVSHRnaWtZcVJ3VDkx?=
 =?utf-8?B?TzRZZGF4alFCUlo1YjlISXFOZTVEWGJwQWRHNXBiVjNLRjNwZzhrOWNtaE16?=
 =?utf-8?B?UUd0dHkzK3cwT1pWT04xdkZReXYxdWdORC9YQTRhUzZNeXJoY2xsdE42djBB?=
 =?utf-8?B?bkp2WGF2NW8zc3RUazc4aDA5ZXVtbWc5MHZTek50WVdtSXA2YUxnTVpNdFVq?=
 =?utf-8?B?ajZ1UUtKcVpLajBlM3VuejNjeS9YSEdFV05nVjZXb0VqMjBydS9RUFFZby9X?=
 =?utf-8?B?ZWxtb0hGRXVRVUhFbWJBY1pwMCtjNExOY0lxVHE5Mm1Pd1I5cVMrR2xwSXk4?=
 =?utf-8?Q?U66BFVCcxxIKh5fAfvzVhsbgu8IgiM=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAWPR08MB8909.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700021);
 DIR:OUT; SFP:1101; 
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF2C613625183C4A8A74BF14C25D51B1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9196
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM4PEPF00027A6B.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5a23f59e-2e4f-4477-bb4a-08ddf6da7f7f
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|35042699022|36860700013|14060799003|376014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTJhdXJHdGRibmIvN2IvcnRORUNUY0tReFZnUkd6b0x6TldDcVNNSFhoNktF?=
 =?utf-8?B?UUZ1ZGw3bXJzaGEwQzdzVFE1eTVyb3RvT2NmNUNVeUs2aXZmKzd0b25zUnRZ?=
 =?utf-8?B?MDJhTWNWazFRMFJsVGhySTY0Y1BCQ1RXUVB5c3JvVjQ2WlQ2Y1RqejRlVmE1?=
 =?utf-8?B?WDc4QzFycXdDVGpuQXBlTzFLTXJUaG1qdXcyYVpjSlFleU5oMUI3SmNaM1dJ?=
 =?utf-8?B?T0ZmL2xQcm05bEF5RTZFTUVsVGI5UG9GZjNWMlpHTFc5TG5jOThTMENIejVG?=
 =?utf-8?B?TGw1azFBaHEzWThoa0FFb05KdSt5V3BqdmUxUXNTMWdKdUQ2d3o4bSt1NzZE?=
 =?utf-8?B?NWxqb2J5ampteHB6VE9TajE1b2ZNVGRJendPVWFMSWQxMVM5ZHk0NU1TSmNG?=
 =?utf-8?B?RFBmRTRTNFdLUUZLeWdtVFhzV1BlVHN3Q3R5eFlyWThjcFZwS1ZaSzc4NCt5?=
 =?utf-8?B?a0w5RFB3ZE11RVhIanZlWjRFZEpwOHRBRVFqRVo4ZWl1NGJaNHBDc1EvNFV6?=
 =?utf-8?B?QzNVNFl6cTR5SVc1VC8xa21USzVxdDVwVXhjbVBaeUdGWklOUzBrdzBVYzQ3?=
 =?utf-8?B?UkpKb0JyMUlIZ2lLeWxBbVZhSkhMUjFYYlUxUG91ZENQTEY0a3pMZEFhU0FY?=
 =?utf-8?B?aDgyeThIRmlPTmkrMS9sdUxxWnIzTU9tbWpwcWZ5VmtvNjd1RThGUytnMFNF?=
 =?utf-8?B?Y3B5VzRRc05SdnpzNkVtcnZ0MkhMYWpSTHE5WFREOUNuOW15YkVaQlZLUlFP?=
 =?utf-8?B?THovc21XZXZxUXdMTGZyeUEvTUpBNGxJcjBrbGphRU9IZWc1eTJEeXpxQzh1?=
 =?utf-8?B?bHdUaGdxRFBoMnpFcmc4czFiT3c1ajhKTGZhTG5wdWdsUVVHUStteUIxWWRl?=
 =?utf-8?B?UmduU3ZBYm9VK3dtZWcxK0NBMTdqUWwySW5JWldqV0cvaHpleDFFSGZmQzZS?=
 =?utf-8?B?Vzg1V1pqT2ViZE0xaWRsVzU4NlpjdUZRS1p0ZXY5NGFxa1RBeTJQYWJwTEJi?=
 =?utf-8?B?NWl4OElpTDMvV2tDREl6MDhZTWRGamxlSUpzeXROdTZXNmtndUxiS2tvSXdO?=
 =?utf-8?B?R1d1VXowV202REpjVjZQOEgrb2QzN3BjRzViNmVIWG5hczVneEhQekhsMVl3?=
 =?utf-8?B?TjNBb2M2eEVGaklzZ2JDWmtVMFUycSt2UTY0NUVaWHJuSUJCekZqSGxYREQ0?=
 =?utf-8?B?NWVqbWg1dFJseFBBTjlHcFVnTnZMVW9XQ2VjU2RqdElsUjY1azFHR1RRV2Q5?=
 =?utf-8?B?dWU4U0hHQXI1dlhCMjBpSzErNisvdEpOUWJRZzZmWWxUR0o5SFJoTnB6L3Ur?=
 =?utf-8?B?THNLTlpuS2Q4TjZQQXdIOXF1K3FXdURPdTRGc3V4cnZYbG9kMk9VeWhkdzBX?=
 =?utf-8?B?NVZ0T3NTQ2pSTXZQWDA0TzVWWWs1WGV0RlBPbW9RaFZTQUhBdE9OZHBUTStl?=
 =?utf-8?B?R05DNUsvOGpHQW5xL2w2bTd2dVRpVmNleTlERXFnRkxIYzBiUm5aNGgvZnVI?=
 =?utf-8?B?Z2Q0ZjIwai95dy96UVRBNkNJN3RZQVovaHU5QUppWGRiSjAxekY3cklBUFZ2?=
 =?utf-8?B?bGZMWFdqenNyVFA0RXlLRFRienVnSXo3TFA0bFVqblBNZEJjS3NFblJSb3dm?=
 =?utf-8?B?V01UZytNZU0zRHNJWC8yL2dDUnJ2QkxBL1hVeVEwampTZ0l4UkluanNtRWJh?=
 =?utf-8?B?QmlQZXZxbGRzUG9oR3ZwdDZTdzBFMnNjSkNReFBaOWNCQjZ0RU9HZTdJR1NF?=
 =?utf-8?B?QVI1V2VKQ3liTWMvVGNIQ2g0UmFmY2VqWUZsOWZHK1diakNJQk9ub21qNGtK?=
 =?utf-8?B?MFpKc3lteGR6WWFZVjZ4VUdTUk44N1ZKRkNzUG1BL2RUaFdTVmNCSFU3MW1q?=
 =?utf-8?B?YWU1MkZESmlSdWE0eGpvc2tNSVZRcHB1RjFRcVZYdngzMGw5M0xobmZnT1VK?=
 =?utf-8?B?ZlNscFI5TmQ1bERqRjZHNEluODNpYTNab01FNWdFdzhBQWsrN0JkSUFjRjlX?=
 =?utf-8?B?UHVoZzlhREZXSzc2dHdmd0Z1MWxBUGp1OCtwZWRPMXpVQVJpR3phY0trQVZo?=
 =?utf-8?Q?3eV/qH?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(35042699022)(36860700013)(14060799003)(376014)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 17:41:18.8234 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d949a009-02fd-46c1-177c-08ddf6da9330
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A6B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR08MB10310
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

T24gV2VkLCAyMDI1LTA5LTE3IGF0IDA4OjQ3ICswMTAwLCBCcnVjZSBSaWNoYXJkc29uIHdyb3Rl
Og0KPiBPbiBUdWUsIFNlcCAxNiwgMjAyNSBhdCAwNjoxOTo0MVBNICswMDAwLCBPbGEgTGlsamVk
YWhsIHdyb3RlOg0KPiA+IChJIGFtIHNlbmRpbmcgdGhpcyBmcm9tIE91dGxvb2ssIEkgaG9wZSBJ
IGhhdmUgYmVlbiBhYmxlIHRvIGZha2UgYQ0KPiA+IHByb3Blcg0KPiA+IGVtYWlsIGNsaWVudCkN
Cj4gPg0KPiA+ID4gT24gMjAyNS0wOS0xNiwgMTc6NDMsICJCcnVjZSBSaWNoYXJkc29uIg0KPiA+
ID4gPGJydWNlLnJpY2hhcmRzb25AaW50ZWwuY29tID4NCj4gPiA+IDxtYWlsdG86YnJ1Y2Uucmlj
aGFyZHNvbkBpbnRlbC5jb20+PiB3cm90ZToNCj4gPiA+DQo+ID4gPg0KPiA+ID4gT24gTW9uLCBT
ZXAgMTUsIDIwMjUgYXQgMDY6NTQ6NTBQTSArMDAwMCwgV2F0aHNhbGEgVml0aGFuYWdlDQo+ID4g
PiB3cm90ZToNCj4gPiA+ID4gVGhlIGZ1bmN0aW9uIF9fcnRlX3JpbmdfaGVhZHRhaWxfbW92ZV9o
ZWFkKCkgYXNzdW1lcyB0aGF0IHRoZQ0KPiA+ID4gPiBiYXJyaWVyDQo+ID4gPiA+IChmZW5jZSkg
YmV0d2VlbiB0aGUgbG9hZCBvZiB0aGUgaGVhZCBhbmQgdGhlIGxvYWQtYWNxdWlyZSBvZg0KPiA+
ID4gPiB0aGUNCj4gPiA+ID4gb3Bwb3NpbmcgdGFpbCBndWFyYW50ZWVzIHRoZSBmb2xsb3dpbmc6
IGlmIGEgZmlyc3QgdGhyZWFkIHJlYWRzDQo+ID4gPiA+IHRhaWwNCj4gPiA+ID4gYW5kIHRoZW4g
d3JpdGVzIGhlYWQgYW5kIGEgc2Vjb25kIHRocmVhZCByZWFkcyB0aGUgbmV3IHZhbHVlIG9mDQo+
ID4gPiA+IGhlYWQNCj4gPiA+ID4gYW5kIHRoZW4gcmVhZHMgdGFpbCwgdGhlbiBpdCBzaG91bGQg
b2JzZXJ2ZSB0aGUgc2FtZSAob3IgYQ0KPiA+ID4gPiBsYXRlcikNCj4gPiA+ID4gdmFsdWUgb2Yg
dGFpbC4NCj4gPiA+ID4NCj4gPiA+ID4gVGhpcyBhc3N1bXB0aW9uIGlzIGluY29ycmVjdCB1bmRl
ciB0aGUgQzExIG1lbW9yeSBtb2RlbC4gSWYgdGhlDQo+ID4gPiA+IGJhcnJpZXINCj4gPiA+ID4g
KGZlbmNlKSBpcyBpbnRlbmRlZCB0byBlc3RhYmxpc2ggYSB0b3RhbCBvcmRlcmluZyBvZiByaW5n
DQo+ID4gPiA+IG9wZXJhdGlvbnMsDQo+ID4gPiA+IGl0IGZhaWxzIHRvIGRvIHNvLiBJbnN0ZWFk
LCB0aGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiBvbmx5DQo+ID4gPiA+IGVuZm9yY2VzIGENCj4g
PiA+ID4gcGFydGlhbCBvcmRlcmluZywgd2hpY2ggY2FuIGxlYWQgdG8gdW5zYWZlIGludGVybGVh
dmluZ3MuIEluDQo+ID4gPiA+IHBhcnRpY3VsYXIsDQo+ID4gPiA+IHNvbWUgcGFydGlhbCBvcmRl
cnMgY2FuIGNhdXNlIHVuZGVyZmxvd3MgaW4gZnJlZSBzbG90IG9yDQo+ID4gPiA+IGF2YWlsYWJs
ZQ0KPiA+ID4gPiBlbGVtZW50IGNvbXB1dGF0aW9ucywgcG90ZW50aWFsbHkgcmVzdWx0aW5nIGlu
IGRhdGEgY29ycnVwdGlvbi4NCj4gPiA+ID4NCj4gPiA+ID4gVGhlIGlzc3VlIG1hbmlmZXN0cyB3
aGVuIGEgQ1BVIGZpcnN0IGFjdHMgYXMgYSBwcm9kdWNlciBhbmQNCj4gPiA+ID4gbGF0ZXIgYXMg
YQ0KPiA+ID4gPiBjb25zdW1lci4gSW4gdGhpcyBzY2VuYXJpbywgdGhlIGJhcnJpZXIgYXNzdW1w
dGlvbiBtYXkgZmFpbA0KPiA+ID4gPiB3aGVuIGFub3RoZXINCj4gPiA+ID4gY29yZSB0YWtlcyB0
aGUgY29uc3VtZXIgcm9sZS4gQSBIZXJkNyBsaXRtdXMgdGVzdCBpbiBDMTEgY2FuDQo+ID4gPiA+
IGRlbW9uc3RyYXRlDQo+ID4gPiA+IHRoaXMgdmlvbGF0aW9uLiBUaGUgcHJvYmxlbSBoYXMgbm90
IGJlZW4gd2lkZWx5IG9ic2VydmVkIHNvIGZhcg0KPiA+ID4gPiBiZWNhdXNlOg0KPiA+ID4gPiAo
YSkgb24gc3Ryb25nIG1lbW9yeSBtb2RlbHMgKGUuZy4sIHg4Ni02NCkgdGhlIGFzc3VtcHRpb24N
Cj4gPiA+ID4gaG9sZHMsIGFuZA0KPiA+ID4gPiAoYikgb24gcmVsYXhlZCBtb2RlbHMgd2l0aCBS
Q3NjIHNlbWFudGljcyB0aGUgb3JkZXJpbmcgaXMgc3RpbGwNCj4gPiA+ID4gc3Ryb25nDQo+ID4g
PiA+IGVub3VnaCB0byBwcmV2ZW50IGhhemFyZHMuDQo+ID4gPiA+IFRoZSBwcm9ibGVtIGJlY29t
ZXMgdmlzaWJsZSBvbmx5IG9uIHdlYWtlciBtb2RlbHMsIHdoZW4gbG9hZC0NCj4gPiA+ID4gYWNx
dWlyZSBpcw0KPiA+ID4gPiBpbXBsZW1lbnRlZCB3aXRoIFJDcGMgc2VtYW50aWNzIChlLmcuIHNv
bWUgQUFyY2g2NCBDUFVzIHdoaWNoDQo+ID4gPiA+IHN1cHBvcnQNCj4gPiA+ID4gdGhlIExEQVBS
IGFuZCBMREFQVVIgaW5zdHJ1Y3Rpb25zKS4NCj4gPiA+ID4NCj4gPiA+ID4gVGhyZWUgcG9zc2li
bGUgc29sdXRpb25zIGV4aXN0Og0KPiA+ID4gPiAxLiBTdHJlbmd0aGVuIG9yZGVyaW5nIGJ5IHVw
Z3JhZGluZyByZWxlYXNlL2FjcXVpcmUgc2VtYW50aWNzDQo+ID4gPiA+IHRvDQo+ID4gPiA+IHNl
cXVlbnRpYWwgY29uc2lzdGVuY3kuIFRoaXMgcmVxdWlyZXMgdXNpbmcgc2VxLWNzdCBmb3Igc3Rv
cmVzLA0KPiA+ID4gPiBsb2FkcywgYW5kIENBUyBvcGVyYXRpb25zLiBIb3dldmVyLCB0aGlzIGFw
cHJvYWNoIGludHJvZHVjZXMgYQ0KPiA+ID4gPiBzaWduaWZpY2FudCBwZXJmb3JtYW5jZSBwZW5h
bHR5IG9uIHJlbGF4ZWQtbWVtb3J5DQo+ID4gPiA+IGFyY2hpdGVjdHVyZXMuDQo+ID4gPiA+DQo+
ID4gPiA+IDIuIEVzdGFibGlzaCBhIHNhZmUgcGFydGlhbCBvcmRlciBieSBlbmZvcmNpbmcgYSBw
YWlyLXdpc2UNCj4gPiA+ID4gaGFwcGVucy1iZWZvcmUgcmVsYXRpb25zaGlwIGJldHdlZW4gdGhy
ZWFkIG9mIHNhbWUgcm9sZSBieQ0KPiA+ID4gPiBjaGFuZ2luZw0KPiA+ID4gPiB0aGUgQ0FTIGFu
ZCB0aGUgcHJlY2VkaW5nIGxvYWQgb2YgdGhlIGhlYWQgYnkgY29udmVydGluZyB0aGVtDQo+ID4g
PiA+IHRvDQo+ID4gPiA+IHJlbGVhc2UgYW5kIGFjcXVpcmUgcmVzcGVjdGl2ZWx5LiBUaGlzIGFw
cHJvYWNoIG1ha2VzIHRoZQ0KPiA+ID4gPiBvcmlnaW5hbA0KPiA+ID4gPiBiYXJyaWVyIGFzc3Vt
cHRpb24gdW5uZWNlc3NhcnkgYW5kIGFsbG93cyBpdHMgcmVtb3ZhbC4NCj4gPiA+ID4NCj4gPiA+
ID4gMy4gUmV0YWluIHBhcnRpYWwgb3JkZXJpbmcgYnV0IGVuc3VyZSBvbmx5IHNhZmUgcGFydGlh
bCBvcmRlcnMNCj4gPiA+ID4gYXJlDQo+ID4gPiA+IGNvbW1pdHRlZC4gVGhpcyBjYW4gYmUgZG9u
ZSBieSBkZXRlY3RpbmcgdW5kZXJmbG93IGNvbmRpdGlvbnMNCj4gPiA+ID4gKHByb2R1Y2VyIDwg
Y29uc3VtZXIpIGFuZCBxdWFzaGluZyB0aGUgdXBkYXRlIGluIHN1Y2ggY2FzZXMuDQo+ID4gPiA+
IFRoaXMgYXBwcm9hY2ggbWFrZXMgdGhlIG9yaWdpbmFsIGJhcnJpZXIgYXNzdW1wdGlvbiB1bm5l
Y2Vzc2FyeQ0KPiA+ID4gPiBhbmQgYWxsb3dzIGl0cyByZW1vdmFsLg0KPiA+ID4gPg0KPiA+ID4g
PiBUaGlzIHBhdGNoIGltcGxlbWVudHMgc29sdXRpb24gKDMpIGZvciBwZXJmb3JtYW5jZSByZWFz
b25zLg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBXYXRoc2FsYSBWaXRoYW5hZ2UN
Cj4gPiA+ID4gPHdhdGhzYWxhLnZpdGhhbmFnZUBhcm0uY29tIDxtYWlsdG86DQo+ID4gPiA+IHdh
dGhzYWxhLnZpdGhhbmFnZUBhcm0uY29tPj4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogT2xhIExp
bGplZGFobA0KPiA+ID4gPiA8b2xhLmxpbGplZGFobEBhcm0uY29tIDxtYWlsdG86b2xhLmxpbGpl
ZGFobEBhcm0uY29tPj4NCj4gPiA+ID4gUmV2aWV3ZWQtYnk6IEhvbm5hcHBhIE5hZ2FyYWhhbGxp
DQo+ID4gPiA+IDxob25uYXBwYS5uYWdhcmFoYWxsaUBhcm0uY29tIDxtYWlsdG86DQo+ID4gPiA+
IGhvbm5hcHBhLm5hZ2FyYWhhbGxpQGFybS5jb20+Pg0KPiA+ID4gPiBSZXZpZXdlZC1ieTogRGhy
dXYgVHJpcGF0aGkNCj4gPiA+ID4gPGRocnV2LnRyaXBhdGhpQGFybS5jb20gPG1haWx0bzpkaHJ1
di50cmlwYXRoaUBhcm0uY29tPj4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+IGxpYi9yaW5nL3J0ZV9y
aW5nX2MxMV9wdnQuaCB8IDEwICsrKysrKystLS0NCj4gPiA+ID4gMSBmaWxlIGNoYW5nZWQsIDcg
aW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPiA+ID4NCj4gPiA+IFRoYW5rIHlvdSBm
b3IgdGhlIHZlcnkgY29tcHJlaGVuc2l2ZSB3cml0ZS11cCBpbiB0aGUgYXJ0aWNsZQ0KPiA+ID4g
YWJvdXQgdGhpcy4NCj4gPiA+IEl0IHdhcyB2ZXJ5IGVkdWNhdGlvbmFsLg0KPiA+ID4NCj4gPiA+
DQo+ID4gPiBPbiB0aGUgcGF0Y2gsIGFyZSB3ZSBzdXJlIHRoYXQgb3B0aW9uICMzIGlzIHNhZmUg
dG8gdGFrZSBhcyBhbg0KPiA+ID4gYXBwcm9hY2g/IEl0DQo+ID4gPiBzZWVtcyB3cm9uZyB0byBt
ZSB0byBkZWxpYmVyYXRlbHkgbGVhdmUgb3JkZXJpbmcgaXNzdWVzIGluIHRoZQ0KPiA+ID4gY29k
ZSBhbmQNCj4gPiA+IGp1c3QgdHJ5IGFuZCBmaXggdGhlbSB1cCBsYXRlci4gV291bGQgdGhlcmUg
YmUgYSBub3RpY2FibGUNCj4gPiA+IHBlcmZvcm1hbmNlDQo+ID4gPiBkaWZmZXJlbmNlIGZvciBy
ZWFsLXdvcmxkIGFwcHMgaWYgd2UgdG9vayBvcHRpb24gIzIsIGFuZCBhY3R1YWxseQ0KPiA+ID4g
dXNlZA0KPiA+ID4gY29ycmVjdCBvcmRlcmluZyBzZW1hbnRpY3M/DQo+ID4gSSBhbSBwcmV0dHkg
c3VyZSB0aGF0IGFsbCBuZWNlc3Nhcnkgb3JkZXJpbmdzIGZvciBzYWZlbHkNCj4gPiB0cmFuc2Zl
cnJpbmcgZWxlbWVudHMNCj4gPiBmcm9tIHByb2R1Y2VycyB0byBjb25zdW1lcnMgKGFuZCBlbXB0
eSBzbG90cyBmcm9tIGNvbnN1bWVycyB0bw0KPiA+IHByb2R1Y2VycykNCj4gPiBhcmUgcHJlc2Vu
dCBpbiB0aGUgY29kZSAoSSBzdGlsbCBoYXZlIHNvbWUgcXVlc3Rpb25zIG9uIHRoZSB1c2Ugb2YN
Cj4gPiBtZW1vcnkNCj4gPiBvcmRlciByZWxheGVkIGluIF9fcnRlX3JpbmdfdXBkYXRlX3RhaWws
IHdlIHNob3VsZCBjcmVhdGUgYSBsaXRtdXMNCj4gPiB0ZXN0IGZvcg0KPiA+IHRoaXMsIHRvIHNl
ZSB3aGF0IGlzIHJlcXVpcmVkIGJ5IHRoZSBDIG1lbW9yeSBtb2RlbCkuIFdoYXQgb3RoZXINCj4g
PiBtZXRyaWNzDQo+ID4gZm9yIGNvcnJlY3RuZXNzIGRvIHlvdSBzdWdnZXN0Pw0KPiA+DQo+DQo+
IE5vdCBzdWdnZXN0aW5nIGFueSBvdGhlciBtZXRyaWNzIGZvciBjb3JyZWN0bmVzcy4gSSdtIGlu
c3RlYWQganVzdA0KPiB3YW50aW5nDQo+IHRvIGRvdWJsZS1jaGVjayB0aGUgY29zdC1iZW5lZml0
IG9mIHRha2luZyB0aGUgYXBwcm9hY2ggb2YgcHV0dGluZyBpbg0KPiBhDQo+IGZpeC11cCwgb3Ig
d29ya2Fyb3VuZCwgaW4gdGhlIGNvZGUgaGVyZSwgcmF0aGVyIHRoYW4gYWN0dWFsbHkNCj4gY29y
cmVjdGluZw0KPiB0aGUgbWVtb3J5IG9yZGVyaW5nIHVzZS4gIEFsc28sIGdpdmVuIHRoYXQgdGhl
IHdvcmthcm91bmQgdXNlcw0KPiBzdWJ0cmFjdGlvbg0KPiB0byBkZXRlY3QgdW5kZXJmbG93LCBh
cmUgd2UgMTAwJSBzdXJlIHRoYXQgd2UgaGF2ZSBndWFyYW50ZWVkIGNvcnJlY3QNCj4gYmVoYXZp
b3VyIG9uIGNvdW50ZXIgd3JhcGFyb3VuZCBhdCB1aW50MzJfdCBtYXg/DQo+DQoNCkkgYWdyZWXi
gJR0aGF0J3MgYSB2YWxpZCBjb25jZXJuLiBJZiB0aGUgY29uc3VtZXIgcmVhZHMgYSBzdGFsZQ0K
cHJvZHVjZXJfdGFpbCBvZiAweGZmZmZmZmZmIGFuZCB0aGUgaW5kZXggaGFzIHNpbmNlIHdyYXBw
ZWQgdG8gTiwgdGhlDQpuZWdhdGl2ZSBjaGVjayBkZXRlY3RzIHRoZSBwYXJ0aWFsLW9yZGVyIGVm
ZmVjdCBmb3IgTiA8IDB4ODAwMDAwMDAgYW5kLA0Kbm90IGZvciBOIOKJpSAweDgwMDAwMDAwLiBJ
biBwcmFjdGljZSB0aGUgbGlrZWxpaG9vZCBvZiB0aGUgbGF0dGVyIGlzDQp1bmxpa2VseS4NCkhv
d2V2ZXIsIGNvbXBhcmluZyBhZ2FpbnN0IHRoZSByaW5nIGNhcGFjaXR5IHdvdWxkIGJlIGV2ZW4g
c2FmZXIsIHNpbmNlDQppdCBjb3ZlcnMgYSBsYXJnZXIgcmFuZ2UgZm9yIE4uDQoNCi0td2F0aHNh
bGENCg0KDQpJTVBPUlRBTlQgTk9USUNFOiBUaGUgY29udGVudHMgb2YgdGhpcyBlbWFpbCBhbmQg
YW55IGF0dGFjaG1lbnRzIGFyZSBjb25maWRlbnRpYWwgYW5kIG1heSBhbHNvIGJlIHByaXZpbGVn
ZWQuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHBsZWFzZSBub3RpZnkg
dGhlIHNlbmRlciBpbW1lZGlhdGVseSBhbmQgZG8gbm90IGRpc2Nsb3NlIHRoZSBjb250ZW50cyB0
byBhbnkgb3RoZXIgcGVyc29uLCB1c2UgaXQgZm9yIGFueSBwdXJwb3NlLCBvciBzdG9yZSBvciBj
b3B5IHRoZSBpbmZvcm1hdGlvbiBpbiBhbnkgbWVkaXVtLiBUaGFuayB5b3UuDQo=
