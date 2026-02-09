Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F438E94623
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 23:19:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96AC040679;
	Tue, 10 Feb 2026 00:19:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 6970740676
 for <dev@dpdk.org>; Tue, 10 Feb 2026 00:19:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770679177; x=1802215177;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=C/XPhjDqpf1QIj+8raIvh/ciDDa8HuY/FpDprD1Wdg4=;
 b=jkY59WHMcH8FT4pjcPHq0etlpIUqx1AJg5dZVBsPcvCc4lX8wsZAy5J6
 eMVQsClmRo9PRzKVKMf+LDfhLcRMGl63pPeQrilHLPQY0r7I+4NAz0pug
 1OxKk77NzbCylrOKUDTTtH9LG1JYWI92D4o8reR4mJzu1X+XCIlkWWSAd
 0Utb0Jx1bR4lehqab8sE6gKcy+TLVyOPpOzNI21QQ+ubby/shkhB1JZ2c
 jIHkmgHhM6qJh3FEi/m0FXV5AQExv6RpUTVz1qCc/XWWe+NUjgaBWsGxi
 SVTjyo2PrZ7F260lEoDHGvqcoybePTxbA+CYTA6Ov+wKgksH9KBj0FCDX Q==;
X-CSE-ConnectionGUID: J9aZspTcTjqwoHTqt8u4tA==
X-CSE-MsgGUID: hlplY8tNSl+5pC5fq/PuaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="89382884"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="89382884"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 15:19:37 -0800
X-CSE-ConnectionGUID: MnHEKPZmRumZ2WpS+ODDVw==
X-CSE-MsgGUID: vtvVjbRxQDuRHXZnvyP+ug==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 15:19:37 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 15:19:36 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 9 Feb 2026 15:19:36 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.52) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 15:19:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIYzh2KZeFxwyxQiAoCTjcLF0O+EeZ7lIl8btAjp2By59D6o6RMJovG1KwUVKWIhFz+rKfX7yG+hdtetHmeaP6OPrxO79aRI/6kr3kSAOISBzWJP7DNazI9Vr6jEzStd5vHGlBZEPBmNotSpmLimLc2x6P6e9caEvgoXJZCa8LJRMY7hPnAhMDkg60bDo2Aopfg8JdCz2rMIZ0GeuOXR/5C/auVCErYio7ar4T4OEzIl5hZOmtZ6rX8T35fKwwOKrcEZZ5GYht1Ta304FV65nP6tioBLAWEMBA4BpbAUSS6kTmn2tCr7fM4bbTVKuhcCPDewLuaC/7rRthKM03+BuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rg34QB4eJDM+L1NHrU3E4SBVPzliQfV8zx4dvCYZKm8=;
 b=wQKR/uXjXGLkJHyuF+CK/6fr+R/LKKZ/aZUI5+A8LjskRsOFWCIAYY3k8eJ8fecXuPFoFAyhv08aQLobHF7aD2UTqAdXhL6TCOH4jW30fcujvQcckQQ+mI4DTWRmVZ3xhk5s/EXsmOTDsNIAfgpf26orSji9cX6GctxT1RuwwEZqMdty8M5gfJm5kp7TLtt5+rColGDUADS0m1enDZNjYEIKRZFG9Bq0c787HUs8+/sTtK3ULlXvkhPS/9ap1waDwSkIXHrPK/kcyxpbP9ER5thRQthx1B4CUPhAnK50REqWRu9eZew5sdeRKJNkxCBkICgMZ5Kv7UhCvDLnHviJUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by CO1PR11MB4898.namprd11.prod.outlook.com (2603:10b6:303:92::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 23:19:34 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9564.010; Mon, 9 Feb 2026
 23:19:34 +0000
Message-ID: <dad0b35a-1b85-4c7c-b53d-78b7f2e6530b@intel.com>
Date: Mon, 9 Feb 2026 23:19:33 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 33/35] net/intel: use vector SW ring entry for simple
 path
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: Praveen Shetty <praveen.shetty@intel.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Jingjing Wu <jingjing.wu@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-34-bruce.richardson@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20260209164538.1428499-34-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0442.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::15) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|CO1PR11MB4898:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b0ca8da-09c4-4d24-30db-08de6831afb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGFNOGFZVDZDcU9xd3V2dkxiLzdCMUhIRmZDQjdsS1JXU0xtM2NaT29iTWNi?=
 =?utf-8?B?Q3E0R1F2ZmJpaFVmQmVPRVpLOFcrcXZxeEZFZjBDOFl6aW83bnBEeDkzRjZx?=
 =?utf-8?B?RGFjQURFc1MrUDluVEN6dzZXMCs2Mml0dE1qR0hVT1A0UTIzVU81Sm9Va1dY?=
 =?utf-8?B?M1A5S1ZDRmo0TGdXYUhXRFVtbFNINElmdXlQTGVqVHJlUm5RZldSSEpsYzlH?=
 =?utf-8?B?bW1ZR2F5eSt5TUswQ1l1NHhreCtTK25sWlhOSUZJazl0UHhNcDFmd3ZVR2F0?=
 =?utf-8?B?N2pramxJM3ZkWnBXbGh0NzF2SXVhZExOTlc2azFObmFJZWdnRjd6Tm1kSUJF?=
 =?utf-8?B?MzdvdGJaQzA3Rm4vSGVhZC9lL0huVzNUaWMzNGY1M1NEb1E4c2t0dFJhbU1X?=
 =?utf-8?B?alZIaVVBd1lrVDFYQituLys2dVVEeDFKNEtQcitxQVRYZENqdWViTlUydkRu?=
 =?utf-8?B?bktVcTlhQW5IeXFhdjJWOGlkMXBad1hDQmJxRDM4QXNoWE01MWdHS3c5dFVw?=
 =?utf-8?B?M0llVlh4MnkvRFh5TFpXdmIzcXNrdFpPU203WUZWWEhCdWFSbGM3eVBaa1Bz?=
 =?utf-8?B?QmFUdFBDdkVyR0Y3SmxaM0Y4T2xoeUJkTmRZSHk4TDN4UWtVcjVSY0FJb0dN?=
 =?utf-8?B?N0ljcWNaTlFCLzVZaU14YW9Ud3c4eVd1NStkZ1NtdVE1MHlDMGdiYVBlVnFN?=
 =?utf-8?B?MHA1cFgza3ZiR3V6NlBUWGlZbkMvTzNLZEVoSmcrY0R6Z3pWcUI3cVNqV2Rr?=
 =?utf-8?B?SHFFVE9QbVZzanZqR1NOZnVtamRCc3VrQnNjYXVaZ29tMlhGYjZteUVWeWNC?=
 =?utf-8?B?TDAvc0FScWhHSVM2dlhuZkJIbFZFMzdrVnd0Wng2VFVYbXBNeE5CaFJkOEhs?=
 =?utf-8?B?UThnUTMzR00vK1JGOTJ5ZjlPeHovZXpIMkM4R0ZnMEtGSnFndHVWY0MrY010?=
 =?utf-8?B?YW0xV1ZKWWNzamtJMUc5WlFERVRGai8zS1c1elR1RWVpV3JwajNJVFNMMERL?=
 =?utf-8?B?RElYWkczcXNEZXpTbWJOUjJCVjl2ODlSQjRDeDRuWlFvbXN3Mlg4UDlVWmYr?=
 =?utf-8?B?TTVmQlQwdXNPYU8zWk01dGxMN0djRjNTOVVHNlBSenZSSkkvTktrS1NaTEdm?=
 =?utf-8?B?eHl6N3NJWnpNeE5rOHFvOXNvU0tHZFJUZXhSbFBUT0ZMbkJtbU9rbW4ydUJH?=
 =?utf-8?B?UVdhbkpHNVB4K01YN24zUERkdTZ6WUtpZlZScXh1amx4T1NwT1pUbCtTUXYx?=
 =?utf-8?B?anFmOHNGVnlSb3c0VGw1MSs3UzhBc3lNa1VQdTQxYTdPRWYwME1Qb05SQnRE?=
 =?utf-8?B?c0t1OStESWcxZUV4N2NQZitpbnVRa1BWREpOb3lrWGNoUUZmaS9VNTdLbEts?=
 =?utf-8?B?RDh1V1VCc0xzUWUxMjV6bStGZ1VmWkxJM2JiUVBWMFlZdnRPalpTZWRDR01W?=
 =?utf-8?B?UlQ0T05JTmZqajIrbFVGam1wb2g4Z1NhSWxSQzArTkwzeWNXWitlSFBUemwy?=
 =?utf-8?B?R3VEREZmY1pxcjA4MHpJcnE1dGZOR0xDWXNVY2xpdkZpZ0VhdUNrTDlQcWw0?=
 =?utf-8?B?c3VhME9tUlcwWVhPdUtJVlhPOERXNXBkUGNwR2dJMGhyTjZtaThkNm1NMGpx?=
 =?utf-8?B?OXFHK0R5OVdNTkZEZ0hteDZyWWczM0xwZkdMN3lRRVVqUElNY0xoODVWNVJV?=
 =?utf-8?B?ZFJ4eVBteFlaYTJuQWFzTklvczdwQUNKd2tTSkVEUVN3SmY5aWs2Mnc1ME9L?=
 =?utf-8?B?ckxrN1ZNMFh5cTdhWHQrTHZpNnU4SFFGc3hIZDNiRGIxQzJCTzF6aXhvZW8x?=
 =?utf-8?B?UFJQeUhvTFR4dFFXR1hJSllLRS91Q00zNFVTdmJzeTNMODM1UEI4YWFTQ1Fv?=
 =?utf-8?B?aGFHaVZuSDVOazl3NXMvT0FZTHpteEgvWTV2UXJ3T1ZRazlJWWRJNU01dWQ2?=
 =?utf-8?B?d3grbVU5SkNzUGhRSGo3MFMyR085MnEwMGFsZURialBEc1RwRS9pMWRBS054?=
 =?utf-8?B?c21td2hERktqTW9mMHNYblJybHlTNlcxblBGSWhLZlhHVlFRNHYrdUd0YTgz?=
 =?utf-8?B?SlNRcHVJRjJVSzJPdjlER21tWGdTZDdQMW1iWGo1a3JGSVdnUjlCN0RuMjJR?=
 =?utf-8?Q?XQc8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1ZHRklrcUY3UWNwSVYxMkR2YUJmQ2pSTGJ4MDJkajByY0N5cjc1MGVQejVr?=
 =?utf-8?B?elZmT2UvTkFGZnNDeWFXdldHSy9uQW1aeTZwOEo5eVJqNGRic3BOL2FqWXJ4?=
 =?utf-8?B?SmJWREV5ZXg4eGJ6Tlp6SlZXK3JaVmp4SjB4c2QvWVdMRHpBZXBid1g0YlhE?=
 =?utf-8?B?V0s5UldycWVNRTZzbFhJL00rY1lvbXFzSXYyUGZ2dzcxVGc2ZFNVOTlST0hh?=
 =?utf-8?B?Qk9ETUF5QjhUZnBzU1N3ZExweWFhdGdDVmhMdGFOYUtWWHhNZDJEOFVuUmY5?=
 =?utf-8?B?SVZkQUxML0M0ZVVHMGlCTERSN01pTEhJR2FpVURuVEZkYlBIcWRpVjZZU04r?=
 =?utf-8?B?Q1ZpUGgzOEExakZaYUZiNk45OSsvcUJHdDdCVy84MnN2aXBYZUluYlpiSjQ0?=
 =?utf-8?B?ZHV3TTN2TGRHZVY0dEw0eE1jVDFQUXI3VE5RZmtBcEJzV2dpWmtmanVMQzNa?=
 =?utf-8?B?WDAveWFEam9VOVVabnlSZ2d4eVdYN1FRWFlJaitXWXFsN1JPb0t2eC9sKzlQ?=
 =?utf-8?B?ZlRDMDluL1JMSVkxWE9pTkdlRnM3Sk5UbFNBbDAvaU1CTnM1aDNzYy81Q1l2?=
 =?utf-8?B?bUlVdWZWOStFMTVvbFhMYXNLV0h0SjgyRnhaMDdERDNkQTl0dVFXeXgwd3Zp?=
 =?utf-8?B?TFNKOGVXNXlxMEpDdHpUWnJ2VWtvcTFnTUp3SDJXdFRLN3JCZHRwZlMyVnNP?=
 =?utf-8?B?MmErS2NyYnhPaE9NSFVGUElLL1RlSG15cEFWTDRrUXF0RHhsalZNTmdDbi9L?=
 =?utf-8?B?akszelNPYXk2cnU0R0R6M3dQVGZPUjVmQzZMTkw5QWFvQ0RlL0hvYzBCazZn?=
 =?utf-8?B?YUxnYS96aFBFU2ZFSmF0N240SnlQaElWaUd3M3V5Z1c5dUZZYmFMejh5eTBJ?=
 =?utf-8?B?WVVJVHYzY3dIQUdoY1ptR3BHRU5Lc1greUZ4QkozeXNtQjhaQVZMRFdpRnQv?=
 =?utf-8?B?dDVmMjhtZ3U4Q2dDTXY2SWdsdG1FbzM5YVNHM2Y2TGo1d0pUcFF1ZWRrbUhC?=
 =?utf-8?B?ZFljSEJYWWlZM0RjNyszZTdGMkh1VXlwR3BBMVNCcFJORDJDVHlxcTdaQVpv?=
 =?utf-8?B?Yzg5Z1Q2L2xqL3JmaWFkdk5tZHZza29HcFpNRWJ6OCtCY1JJRTg2NFlpZnBZ?=
 =?utf-8?B?T3Jib2NyNWFmRmZnN3FsdFE1MEh2MnhBYW9xWC9pRUtxS1R2Q3FNVTlWL2Ir?=
 =?utf-8?B?THBPWWEyRysrWUtXaVRFazBWMDhRZEJuWjJDTEF2bU1OamlvK2E1Uzg2bTNH?=
 =?utf-8?B?QXNET0xhczR5NGhIVzdVMHM1bFlmVlNIWXBsTFFxZ01sS0c3VVpOb2FDbWtw?=
 =?utf-8?B?TS91SEw5TzAxMVRrUHhXc0xPcDVJZS84SE1SL25YN2NoZG5nWTBEM3JzbXdw?=
 =?utf-8?B?OUFJMHpuTjdWZXIvRmxveis0d283eWdUNzBMUlRwMTg0RFo5dDFIN2djejJW?=
 =?utf-8?B?Y2lXVk45U0dORnNhSGp4emhxeFM5WHdmZUZnS1pUZjdQNVUyaTBzQUpjcFp1?=
 =?utf-8?B?VVhFNWVaS2lkeHhFN1V1c3oxcWlSeitOclBOSGZGVGE0eVdmSk9mTGMyNW5J?=
 =?utf-8?B?OHZtSzloTlplS0ZRYlgvUFdkV3pWdjh2WnM3cGVWZnIwSk9JMzhwTDJ3ZVN4?=
 =?utf-8?B?NWlTZmVEQlE4TG9Db0xSQjBxVDlmbVhueHZKbUI1NGxhd0srWDBlQnRERW1i?=
 =?utf-8?B?VEtFeDJRNGJzTGtoTFBMRG5lLzRQbllBcm9SbHExOVplaDFzdzhoZVBCR0dP?=
 =?utf-8?B?ZWpDNGNQT2xMa3p1bGRCb2ljejJDRW5DQkhDQXdKMUtIS3Z0L0NYY1JWNmJM?=
 =?utf-8?B?eUZ0ODdOZ2RZMTBlbXhJR0szNGNnNjRzdllLUCs3SUIxTlZRUUFUNmtkRXQr?=
 =?utf-8?B?VkloZ0pJZ3hHWUtpVm1BYnJQcWlqdnZQVnh0MzJHQ1ZDam51MXQvR2NrMkFk?=
 =?utf-8?B?bUJKV0NsRUVsalRDWTZvWjFSSVBOL1poR3pRWG9xYkl5WHMrZENpaTZxZlBw?=
 =?utf-8?B?Vy9BT0ZZVldkL1Q0b09KNG9Ba0dKdE12Z2ZXaE1JSGl4eXR4Z0xzSG1PTEhK?=
 =?utf-8?B?NzdSOUVjSjAyY29ralU3VmprdzhQdTRTWThETndDU3ErVGVSWjBSU2RiQWhk?=
 =?utf-8?B?RVhzOEZXVG1JQ1ZHMnhSREdUVlA1bVovMWcwcTFUQW92YzNjWU43MGtkZWN6?=
 =?utf-8?B?TG5BbFpmSHV1TExFZlVCUGhiKzVkanBWV254N3pKc3JvQnZ0bzR6TjI0VkJh?=
 =?utf-8?B?MHdRZTFWYm50UnNIeXB6N1JkZm9TZlRoRmF1eG5EYWR3MngxOUNmNU5CNmh2?=
 =?utf-8?B?eHl0cC82V3FPc1V6UUlyRFpPUUU4dlBucWNqdXJ6MEVRSjZQZy8wbm16T25l?=
 =?utf-8?Q?ZNyZ908b2RvBGhXU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0ca8da-09c4-4d24-30db-08de6831afb7
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 23:19:34.4997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U9uVDbblYLXeX75dqxdCNiJVfCnxQ3oaisqkxDuLidnqw4m0vGbvWjUAwVe9KIoz8bypctPQ7W0VoPR5g5Dqs6TAfWHZSFzPdS+iR+nEEKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4898
X-OriginatorOrg: intel.com
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

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 2/9/2026 4:45 PM, Bruce Richardson wrote:
> The simple scalar Tx path does not need to use the full sw_entry
> structure that the full Tx path uses, so rename the flag for "vector_tx"
> to instead be "use_vec_entry" since its sole purpose is to flag the use
> of the smaller tx_entry_vec structure. Then set this flag for the simple
> Tx path, giving us a perf boost.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>   drivers/net/intel/common/tx.h                    |  6 ++++--
>   drivers/net/intel/common/tx_scalar.h             | 14 +++++++-------
>   drivers/net/intel/cpfl/cpfl_rxtx.c               |  4 ++--
>   drivers/net/intel/i40e/i40e_rxtx.c               |  2 +-
>   drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c      |  2 +-
>   drivers/net/intel/ice/ice_rxtx.c                 |  2 +-
>   drivers/net/intel/idpf/idpf_common_rxtx_avx512.c |  2 +-
>   drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c  |  2 +-
>   8 files changed, 18 insertions(+), 16 deletions(-)
>
<snip>

-- 
Regards,
Vladimir

