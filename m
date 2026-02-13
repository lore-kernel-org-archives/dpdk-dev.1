Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCEBEDF148
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 10:45:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70A164042E;
	Fri, 13 Feb 2026 11:45:11 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 4189D40287
 for <dev@dpdk.org>; Fri, 13 Feb 2026 11:45:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770979510; x=1802515510;
 h=message-id:date:subject:from:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=NFgpV3ruqoQ2HtMT4rCULHUWL+V+UJ2p7I+wApO9WoM=;
 b=J8Ia6NEDKxAfT994R6aPEO0ct97/2znnloCNytKVmqD0ec79AbJc/9jV
 Jv2t4etOl70HpmmcETIzsvd0dIwlJJsJYIQVj8GjHsWtXhXGVz1XE8yv6
 5RlsdZKTBunApLCH3jzQlJiC7jDxyJITxaprHuBpqosj/erOE4Nhv58dp
 gd55CDbfro80Lxr/qx6vAxRCe415G95DMop2v/4/BSte5M19/tldtt9nW
 pf2kvpv8i67lNAdlo/h73FGR3x9ewzIMa2tLpKVAXj/YEBYKc/e3/U9PC
 SpyBf7i//DEBavjAiT+lkwOjvrD+0F6DxtG9L6cqSWE4GGeqOcLRxwxyv Q==;
X-CSE-ConnectionGUID: IV2sJdQdSkab5V5GpjkD4A==
X-CSE-MsgGUID: LtnY5/u0ToW8SEMVzJxTvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="71875969"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="71875969"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 02:45:09 -0800
X-CSE-ConnectionGUID: DNRAZF1kR/OLyvc84A0hiw==
X-CSE-MsgGUID: WZDuXYntTyOl4js0piQqDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="250554987"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 02:45:09 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 02:45:08 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 13 Feb 2026 02:45:08 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.0) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 02:45:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJgamaA0euk3v5OuyEaLOV5pM2xyBQ2l82YpUBo28mHkHXp+5y7QxgVre9FWqj4F0NNVFsImOy3vJQ/OcM80+KSVKnAG95sOq8rFHvqt8qUjD0oDnL79GD6le38859qCg1loDAQMHekn9uZRvbSIs+7ZMQXk7ZB38gvLKXfwlEslZKcBEC7LfUBmBlW+GoFZidHx5TZAAEjtUOvBjXt15LnKHsBfoNMpyFUaQTxw2PrhE/aDfwLS41BBMG2pB4fHDbfh/PQyJc6TpJDaoEMlhuSOXF1Sas/Zf4WlPD/ivZ7+sv2Ywn+eQ6OOzyI9bOoD3N2CZswMFGNa2X8cIutu5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjiBUHm8LzP1SViwGDnSR47idzQfNCyctOYBoBe1ODY=;
 b=Y+8X5pXXIEDJsd9E+K/HvVMa1L0Wmwem2uSageV4gnccYN6b/pLn0QLWIvRcMIHpE/BJ8OSOx65AuukYYXCqT3MmLieQLOvMFXOjhYbkTQGE2XZq4mq6P2NKwKOtm4529tGho4/cVusYX6K7jrqFIThKfIS+tCPrBwTxxngI7jc8PTbNML5kkEHISS7vu5kXLTrz9LGE502zXJHFF3S6AAFqfthnd//2OXez9x6WgvAD9HtbhQRseF2uYo7ZzEXykI1hPWsIE8nx/0PZvpJ3nl9x4ejG4+nirTU7IuqvpkZlqOVErRiVxGBjA0L/nCWIpHS9Pght98FNm2uBIKF/zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH7PR11MB6353.namprd11.prod.outlook.com (2603:10b6:510:1ff::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.10; Fri, 13 Feb 2026 10:45:01 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 10:45:01 +0000
Message-ID: <d938c294-2519-4f9f-949a-d1e047a33510@intel.com>
Date: Fri, 13 Feb 2026 11:44:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/27] net/ixgbe: remove security-related ifdefery
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
To: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
References: <23349a5e45da22b07965d11b28b8bed12688ca81.1770978324.git.anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <23349a5e45da22b07965d11b28b8bed12688ca81.1770978324.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB3PR08CA0001.eurprd08.prod.outlook.com (2603:10a6:8::14)
 To DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH7PR11MB6353:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fd2dcb1-ab51-47a1-a022-08de6aecf072
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RDJITUFzYkdIYmlmVjNPek16T0VWU2xGS3FmT0xzQUszOWVCbjFOSU82OGFG?=
 =?utf-8?B?bjlDcXJtYXFUR1JGYSt3SHR6VGk4ZVVieFJ1Z0Jxc2VHUi91NEx6a09EM1hU?=
 =?utf-8?B?N2dzRkd4azlGS1gwcGNrNGJ1R2IxY21Lbzh5UUVKdlpPcFMwS0pHY0p6Rkkr?=
 =?utf-8?B?N1FyanRwMHBsQ2g0ZllMQ25qQ3hKMDFYZmd4eldOVXFPd2NwT1hyQ2FLbUpG?=
 =?utf-8?B?MFNIeUtHcnBDMWJEdUhqOXFUUDBRclM1bkN1Sm52UnduUVNEeGFKQ1MzSDB6?=
 =?utf-8?B?b3VVMVpnSEdvSmI1VzkzcDVuczRocTFNYW0rK2dyM3JleFNvRDRSUHNCRWNi?=
 =?utf-8?B?cUVVUFNOSGcyeDBUaXFSZ3B0Y1BPZ0xqSkQ0b09YSTlZZlljeDFFRUkwMWpz?=
 =?utf-8?B?REl1dXM4NjlHUFZNeDg2QWsrbWl6NUsxdUMvWXdWQVQ1NWdoOWtucWpBQUhE?=
 =?utf-8?B?cTRNQk9CWkhPd3F2endndUZiTnljS0ZBWWVROEx2REtUd3NBV002RDlmTjlV?=
 =?utf-8?B?TjE3N2VhOFh3MGo5UzFLM2ZLWjJGRUNETUJ3TnFGdWRaQmFqdG9qVDhoQkpX?=
 =?utf-8?B?RnlPTlhxRU5heWpMTUYrMUZSKzlEZFRCMFFpWW1oR1R5eVZGZ3E3TDBmd2Uz?=
 =?utf-8?B?eE43R2ZaRitlcld3TlNPTXEzcEpWRUZEUkVGbllNaU51VFo1Y2JneS84cnFP?=
 =?utf-8?B?dVNORWtlV0VpZWRoUHpwVENkRVVUN3lWSVJHamVuSkczMnczM0pjaUw1d1oy?=
 =?utf-8?B?Z1V4NEIvZE5BeklxL3BWWGpsNnNReTVaU1pZZENFOEErZ3hlYUViaE41dmhs?=
 =?utf-8?B?RTJmUkNiRTZPSDVvSkFzTmgxUjF3WnZrOVNrOC9Ybm9wUnE3eE1pQWNpUmgv?=
 =?utf-8?B?ZHhkbFhhTkNKVEFOazVKc2R2d0wrUWQxWGVRTVduTHhsRDZHQm1WOEJtL2RS?=
 =?utf-8?B?MHdyR2VTRzdpUnFjTlVTdWZKVy9rRnFuQVZGMEZHaTN1dXJaYnJuQkV0ODRY?=
 =?utf-8?B?ckNaNDJEQ01sTEhhRm1raSt5TWZrY2d0b1dPNjMxSEs5YzdHTk1LcW81OWFV?=
 =?utf-8?B?c1VzVVA2OUlTbGtBcjVXQnJGZGhneng4TWJ0UHErMG9sSGUvR3VQQ3JKV2lK?=
 =?utf-8?B?R3hSWXk0OGdlVkhQZUlvSHp3NGFxajErMVU0TWVlbkh2UkZPMlQ1cnlsZDJC?=
 =?utf-8?B?aWlVN1NTV1hnQ2pncXRmY1pUVnZtZmlWR1grUksxcE5kTHZFRTBmWGpNaXAy?=
 =?utf-8?B?c01zU2dMNWhMaWFucE1SdFN1Sjgxa1BjKzZLT3JlMmZka25QMmx3eWY1dUlx?=
 =?utf-8?B?Ry9odFJxamxKT2IxRE9BRGhXanJ3QUxMZm9jV2cxTm1zd25FT2Z4NmdFT3Jt?=
 =?utf-8?B?QTBBdllDc3AxRm9NejJjNEF5WDNSdjBHVXBlTVZQVnE1QzlYejZiUWtESVNo?=
 =?utf-8?B?Lzd6UnZCMG12NzNCSjI3S2RQNFE3a0RkdXFrWW9nSnhCTTVxS1I2NE1LZHJX?=
 =?utf-8?B?d2xXK2RyNnVVWXV3ak1kMWxNYzczV3daV09QQVZuc0F5aFZ0TytHQ2J3WGF4?=
 =?utf-8?B?R3pIMnlsQlpkb0svYlhuWFN3VVN2RzJVNWVlYUxOdVBMNG5XRHRwTllwdXQ1?=
 =?utf-8?B?TXlvT3B5b2lwTmJsbWRMZkF1OHFMWDljeEFVSDlLOU01bWJtSVNrWXBBdzFz?=
 =?utf-8?B?M1QrcGJnUjVNNGNGeGtWaVFDOExLUCtjWHYrOUdSdzladThlYSsvTDN6Mlhl?=
 =?utf-8?B?ZEJMbStVcW5JRVNTMDhrUTVBaTViSmdiTThIdkpGcGlVY3U0aTFncWlYdFNh?=
 =?utf-8?B?UURvM0V0NE93SWtFRTFodnFEc3NJNlRvenF3Y1k5RUFnRVd1eHQvbkdTVWlF?=
 =?utf-8?B?bGtBZlJzT3FrV2FIWUIrcTFQWkRwaWZFNHdlNi9ZeXNXaHV6TWoyNExjRFBs?=
 =?utf-8?B?MVFVNnVGL000Z2NCM0dmeUkzK0p0WXo3Qkt1aEVjRVh1YlczclJVQ3ZDUVBi?=
 =?utf-8?B?d3VGYzVGb0JDQi9uRzNOYXJHdE5ITGgvNmpZWm43V1Y0SksxdWVwTGkvUUNE?=
 =?utf-8?B?dnBWMjFMTEFibVBDUzhGMHdZNko3YkdFa2R4cDRsNm1jL3VXeTE4amNhV0Vm?=
 =?utf-8?Q?urV8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWZPL0Q2UERUTE5OMVBCcWdrck1ZYkhJSHpRWEpKRVAza1VCU09pZ0VxM0NE?=
 =?utf-8?B?aWRONjlrZ2piekU4WWJJUnlpYVlwYTl2Syt6RmlabUJBT1NxY2szQk9Ybkxz?=
 =?utf-8?B?UlRKaEFVd3JJNVViK01Objl4SHptL2pPWXhUb2dUS2xJai9SR0Q2eWx5SVB1?=
 =?utf-8?B?TlM3NHVSbDJKV016QmRzeE5mTWM2bjJ6Mkl2Uk0wNU1rUWhsUkFMalVDUlRk?=
 =?utf-8?B?SkovbEpvd0tKR05vbkRyMHZ2WlFIR3BRM1k5OFdJSDQyZUNIOUxlN0hjVEE2?=
 =?utf-8?B?QXlNaHhRRHlydTVhS0pRd2dGajI2Rm9MQTU5R3FvZDlFSG0yOW91d3E0Szd5?=
 =?utf-8?B?R3VVdjlIWHNhVHdIOUxteklzaFM2TjRtNjdVdWpNcWMxckV1ekkxdk8yOGE4?=
 =?utf-8?B?VnFTVHd6ZUt6QUpQelhXK3RpYTlFWTRCamVPVW9Qd1ovZW5ZU29GUDFHaUc4?=
 =?utf-8?B?MXpLZWZ2eGlQc3ZRSnFGSVZtWDEvRENaOXE0TGFYWXZ6S3IveUZkd1Jzc3l4?=
 =?utf-8?B?UWRwc0Rqai9IMUpTWUl0STF3OXphaFZIMHRpVDRoZVQrU2V2SU9VNkVDamxn?=
 =?utf-8?B?Vnd4ZGp5eWVBajRGRzdNWmNjV0Q4c0twWFVrUGo1NjJaZnA2S3R6VWFiVzlq?=
 =?utf-8?B?aXl1dmVQcERJaGxGUCt1bDIyT2pyamZMQStpR2lhRUNqS1dpNk1vMk51VGZx?=
 =?utf-8?B?YUZDeGsrcE81SUtMM0xxU1JscGl5cmZZakVYcUJpT0k3Yll5ZVFtT0ZiODRv?=
 =?utf-8?B?V2pHMnhOb1VPemp1NUpubG9CeEsvNFUvMlFkNGFsMzJVbEM2ZElQSGl6M05v?=
 =?utf-8?B?MDlmTjJsM2pHYlpnYmdDUHBHVHNhZjRsamladFRMNlczUFQ4VUl0d0xtT3c2?=
 =?utf-8?B?d1RJS2xvdkhPZXNXcmJ0dGtZK1hJa3VrZ1AxbTczcXR1cVgvRTBYSkdTRUc2?=
 =?utf-8?B?R3FnVVJQbUxCbUpBaDZ2TnVIK3dJUUhWRXc3UmxycXB3L0JaR3ZvbkZzbGl0?=
 =?utf-8?B?Sll0UUFTenV1czdWOUUrNk9TR2h5NDJ1OVdTK0R3a3ZSVitmdmpxL3hINmZS?=
 =?utf-8?B?QWJjWFRWMWZOVXVtVnJjNUVldXR5RUZPcXpNZVR0VTBtQzFsRk1zSXVtS0Vh?=
 =?utf-8?B?L0dRcllWVG1BUDAwZ2Nhak1xcDZQenpnQVBCeE5sdHFSNjJDM1E5SXZINGZQ?=
 =?utf-8?B?Ujl5WlBXZVVLZTE5SXpKQW9adDhWbnlKWHB1em45UWdWWEZqSlVPYTIxZDY4?=
 =?utf-8?B?aGZXZlZnWUZocnZOU0FORHdrRWFCOVYrRTlSSHpjOEhMT0FWeGlHVE51MHZ3?=
 =?utf-8?B?Z09iWWVibzNEVVRaTGRKRWVtY1RXRTJQM2s3cEIwWTdoUnZUd01ZVXhiUGEw?=
 =?utf-8?B?c2lXWFMxNVBpYlpQM3NVMlk5SHVUK3o1UU95SWpYb281VXRUUDFYNlk1ZDdV?=
 =?utf-8?B?S2hKcEt6YWszR25nOXBPRXNiV3lHc28yRDRSblBZN2Irci9SMnR0RTNKbm9O?=
 =?utf-8?B?dEFDQWRIU3FEd3E1d0p2L2NDRFg5cDNKNk5xQnkrcXpqNnkzSWZBa1M2cWJ6?=
 =?utf-8?B?c1l3REp2Yy93TWdlY0ZLWXRYVWkweXY3aEpaODBNbHpBeVltN2FZTHN5ZlFa?=
 =?utf-8?B?T2dob1RYeUw5TlRpMjVBNVBLZC9aRUg3YitMeVFQN2ZyUHlvV0FXMXEzQ1pL?=
 =?utf-8?B?cTdIL0VCc0FUd3diUjYxRmtiM0VTMDNwb0lVM1pFaEdzZnlGdWd0Ni9ubTdy?=
 =?utf-8?B?MUM5VTlUcEZkVkJRUUZ1Skdrb2lsVmFMejVVY3VqMmovcXowN3pzU3l2TkZR?=
 =?utf-8?B?WG91V2FBNHFLdGtRNzNTdnNUd2laNHhJWUtCbW1YU2V2VmtuOC9zYjkyQWRU?=
 =?utf-8?B?MVV4N3NPUUh4L2x3N3k1MUZYZmQwMlVkcG1VREREOVIzZjBUb1JIdnJqZmp6?=
 =?utf-8?B?UFpUUmpyeUVraXFHeHgyeWJYSGJIZkJwaDJ6eG9yc0Z6MU1EMjV2dUVvWjd1?=
 =?utf-8?B?RGRhTEhmNTZncExXKzUxcHRuRUdOUGJhMi81L2czbE04VUZlVE5hRmpMN2Yv?=
 =?utf-8?B?S25mT2V5VE1UamVEQXI0NGtoSlNHeWQ0a0pJeTNyQmZlKzhpZmh3QUt5ZHkz?=
 =?utf-8?B?SnpScERrUmRjbGQxZmFOdCtJa0hBOUJZWjZnemJ1WTVDZ2c1T3Z4NWFOVEpr?=
 =?utf-8?B?T21McjJlbE83WnNOSzBMT2hOcmRpanR1cE00VWRwbGFCRTR0NXh1V1o0QjFx?=
 =?utf-8?B?bkZXVTVJblgwVHltUmtnRGVKeThlRUZDWFRxOWtSV0VwdndweEJDdWNMVzQ4?=
 =?utf-8?B?QWFPTkcrRTVkRmZIMUk4aHIzMlhpN2F0K1liQVVXSXVCZWdudlhNSDV1UWV6?=
 =?utf-8?Q?gRxAGFFnPu+V4j+A=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd2dcb1-ab51-47a1-a022-08de6aecf072
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 10:45:01.4920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +QhyHjHDZ9XhGShdgmfd3mo904E38XJEPUOMFscDqumcKoaneO1Yj2OW2UOKnrZh6ohghpAPJuYhr5ECsI4SskhlE7m3uuUOl7/qC0Ino5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6353
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

On 2/13/2026 11:26 AM, Anatoly Burakov wrote:
> The security library is specified as explicit dependency for ixgbe, so
> there is no more need to gate features behind #ifdef blocks that depend
> on presence of this library.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---

Missed from v3

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

-- 
Thanks,
Anatoly
