Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94162EA8105
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 12:48:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B500B400D7;
	Tue, 10 Feb 2026 13:48:35 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 090AD400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 13:48:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770727714; x=1802263714;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=kScpQJTPTXK1vJjFeb/XQfqnKOw9C2x2vfPuk7CqGSg=;
 b=LCOHU6B3Ec3hnPpX9atCG7Y5U559fICsrrediyzg7zF90x4s9EXHep72
 0Xz8RshEfkkWc4aev24u0cFusbPdH/9ykpPt2oIJtwtVbdP6XNuOVI4Qt
 PlbFhp8gByq5nPkby516ljtBPPoGdYyWbR0zZSqrbmvV9Svo6Po6v58V9
 t2eKUdpbhQP6Tyhuujl6Ur59Jsu5yBXX96YTcbaxMLkh1QBpjTX+/1Cph
 eqftc75ppcEvPx5uvNOVRFBaRw1AbmTI5J3QUohjIOrybhH/ZSJ+Mra+X
 dltsO4J/qmVKkxYdZakS25DQYhG7ZLr77y7MDeQqOppzCMdu1zWn+viBl Q==;
X-CSE-ConnectionGUID: nJ2chvAARDOHvPVtRYQ8rw==
X-CSE-MsgGUID: lM/21iLFR3KxEww+NxtVVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="59421128"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="59421128"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 04:48:33 -0800
X-CSE-ConnectionGUID: xqQ0+HqYSIanF4g0fgfzKQ==
X-CSE-MsgGUID: qKm6tuNoT+uukpDhC9NCvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="210973436"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 04:48:33 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 04:48:32 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 04:48:32 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.56) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 04:48:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DoXXCHPQrPzpzt1bKokohu2CVBDswmA9c0M5VKuxnqDfjsK/fl02ltNIk61Q8QV3ysgZpZCMeC1/gk6t06r071JIWyRaxkdQz4T0AVthT91jNZsOI0qjXQ8RhpEY4iB14jLz5Nznr2A/Hxm7i5YnLszgI6zDIl9VTWyRYJMYt7dZmS4CPPzE/8SHJEuqgl9skuBnAozRVM7dDX4vUzvUA2Xapg/WWRhXgILRZjok7t1ekASCC27VycKVGotybSSOsdbhJF0oAvyYI6r4K57VkMwsLadGBWcSd5XAdlPfHJfYDiICd2DvAZf1VsBZvKEf2xlqmnm5WTyIk1/EDmKHew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcTI+bWF0DLMTjdQeQUPSCKznlgyu1LAbM67P2bDTRQ=;
 b=cFTIFyBPEbkkAMRW9ax/+f7M1cxZhYtb4jeslWLCHyv4/NAyGshgwR/ANmoymt2zsdK2NrhVFT9fA/qX3mqDWHy5G/6JuTUwuAqV/LCoqbQWT+HGGA6PiGJXNr/rQFuQnIIO1uOHEbQwcQHbXhQqHM0xO4gfpH4AsJTUX3SEB/BoXMcZZUnQbMiO95RIf7Q5ncbyk837RL1pS6YAVjUscIogU0YaKtvugoU7fA5HtoHxvMwtqEZHoI2huM/tdJTqI3rDs+Gmfvgf9x6ZfVqK6pbKh8EWuzknPdTzEsbkEXm8ee2N3Z04ImXux7Sfk6Cc+4miCzAaH4/ppKJ9IbbJVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SA1PR11MB7086.namprd11.prod.outlook.com (2603:10b6:806:2b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 12:48:25 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 12:48:24 +0000
Message-ID: <abad013f-0a13-490e-9443-0441233684c0@intel.com>
Date: Tue, 10 Feb 2026 13:48:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/35] net/i40e: refactor context descriptor handling
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-8-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260209164538.1428499-8-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0273.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::14) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SA1PR11MB7086:EE_
X-MS-Office365-Filtering-Correlation-Id: 8546ed0a-afed-49ee-e4da-08de68a2ae00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHFPKy9STHNhR2ZJTjIwSlFQZ2NqV0JYZ3JaSTMvS1d2YlUrOWJMa0FJTGEw?=
 =?utf-8?B?SitGcjNuSTNEeVhzNDlnMjlOSnJ5M3MyV08zaE1iZGFKMzFvSEV6ZjZyZUMw?=
 =?utf-8?B?WDI0VzNUeXJvUVZXK0NHanExeFJEcjRwZkVmUFJERjdJakUrOTkxVjJxS1Zq?=
 =?utf-8?B?cFA5YWR2U1d0MU9VamdXVHNhQmZ0UjBqSWsxOFhGSE81S3MwVlBFNXRtMUFB?=
 =?utf-8?B?TGVlcmJQR2JQM2ZxY1VpN0FvYUY1NFJ3N2c5NEhyb1VPSC9MSEptQlQ3Zkt3?=
 =?utf-8?B?WGlLK3hNbENoYTBwb09MSFdxaUpBVk9EWmw5bjhOb2lvd3VUbVdRa3kwWkNY?=
 =?utf-8?B?MHRKR1BkR0hwQlJubCtZOWFpYURISTlpUkdlS21rNU80SElPWVkyTkVibnRn?=
 =?utf-8?B?T1FJUW05ZGFkVTB0Ri9ORlFRMGgwZHM4Rjh2SUpuTE0yMHVXaEpiUnkyTUVU?=
 =?utf-8?B?eUxqSjdBTENCWitybmgrN01lUWxHMGdhOHhyaUliam1HSitZZjVGaWRQQjAy?=
 =?utf-8?B?Sm93ZkJKWXFWYVVrVUt3eWFKSEdkaWYzSEFFYjJBUGtPSFIySENxMVp0dHJ4?=
 =?utf-8?B?dTBVZmw4NE9Mb3N3Rk5vRi9BQnNWejJLUEFHWW5DTmxKVFM3Z085bjRQd3Y4?=
 =?utf-8?B?c0xWZFVSZUdaY1libzBSRyt6ZFRMaEt2eDF3MzFCNGl3Z1RMbGJMY1YyaENR?=
 =?utf-8?B?R1dCMjJraVlkbGxVK1IwSlFRM2pqdFN1V0dSQ3c1RzRKb3Bqc0NyYWxlSUtL?=
 =?utf-8?B?aHdGUm1GcGF3OExuc1FLTTF5ZUx4WlVhR3dJVzh5T2IxcmhUSzF0aWgrdm1t?=
 =?utf-8?B?TWtjVTVFQ0ZRRWNzTzYvckRjbm1kUW5KM0RVQlg5cGc4clNDZGRrK2RGaytt?=
 =?utf-8?B?cEVZWlJQYXNSLzROWlF5dHd2VVQwSTRKdEpwRWIzWDlqdW5aaSt3U3VFbzNq?=
 =?utf-8?B?YWJyMXJhNDJ2L3p0VjVOUlUwREN2UDhCVXZHd0lQRTFrei9sdU5nSW9XYzU2?=
 =?utf-8?B?dzVUek15dURhdk1IOW5oNXBDYUpvWng0a1NweG93RDBqTG5Cdmt1NnZ2Y2c5?=
 =?utf-8?B?Q0MyRlRxUi95WnFHOHlDdDVicnVYMCtUOWdaWkp2SXJuNC9ISW0zQ3ZEbEF1?=
 =?utf-8?B?WVZYRFRHNmdEVjgwSS9EbGd0Tm9RcnNpVnY3ZURVV2xPUjc5MmI1ZkMzM3Ba?=
 =?utf-8?B?MHdaTHRjb1duYUJhUUxSK3oyNTNhQkJOTnhHbkt5ejc5N2RIQlJZUGdrT2tO?=
 =?utf-8?B?YlQvcDl2ZU5DbWFDamxzVFhBRjVxY1JXRFA5UHNuWFN5cDhiMUxiSnZkRGkz?=
 =?utf-8?B?WFlGbE1HcUN2TGRtNlRSdk1JRDRoOFJXMWRNUmwrUVJNQ0E1RkZiT0JhVzk2?=
 =?utf-8?B?QjhpMGhwNnBTekpJTXIzS2NLbVFuU3prNE85K2N5KyswNUQyNk9zdlMrWndJ?=
 =?utf-8?B?L1BQSnZUbHNkQ2lZVEdWOGxmN2JDZm1ra3JxcEVGVlBEVGZhMkQyMlR5R044?=
 =?utf-8?B?SVk4MUR5NVZ5ekxJRU93K0NBL1RRNFdGK1h6dnFhbjVUZnpXWWRSRGxrMmhW?=
 =?utf-8?B?WGV0clBDM1ZGRTY1V2Qza1ZWTmplR2MxaFd6aHlPMkx4d3lBeitVSFNsajdO?=
 =?utf-8?B?Ym9qczFUeEN1UkZnTnFIalo0WkJaMDhpV1VsTWpMU1J3M0c4ZW92M2c3T2tG?=
 =?utf-8?B?M3o1SnU3a0lZLyszd29SbHJMZEIrTUdOb0dHd3g5OUJ2Zktpelg1dkZhL09K?=
 =?utf-8?B?VkRFc3YrWHBoeEppdlV0T3lkdXRzWUVzdXVnQ2k5ZUg3VDlWVzdjUVE2MTNG?=
 =?utf-8?B?endlWWRqNVZNWmI0ekJleXhBMWRNaVJKOHJ0QVJtUzRQdlNhNjF0V2czTWNI?=
 =?utf-8?B?L1UwT2V2MzJoQldwcUxYTHNqSEJQOHp3a2tFdHFtWnFjdk9PRkFrRFp4THVR?=
 =?utf-8?B?NVQ1QmM2N3dxRFdpUkNDaWdWdzRYcDhZaDkvdzFBamNkUU5aV0FaWEM4R1pj?=
 =?utf-8?B?M29zcm84cldxaXF2empLZ05nbGh5b2VYM1J0ZGlSeXhBMGl1V1AxWGpCV0tw?=
 =?utf-8?B?SXU1anF2eWRPUlYrUnQrWFVrL1k1UU1oangwSzh5c2Qrc2pQSFBXamFUZUhs?=
 =?utf-8?Q?zYEc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3cyalc4R3VKeG9keDRHa2ptRW5aejJYRklDaTd6d05NeldJTzFnMStLWXFk?=
 =?utf-8?B?VjVWV3JoQ3duVHFQb0tKMGdQMHk3ZDNxWXNPTWczbm5GdjdwVUZZNzZ0Y055?=
 =?utf-8?B?VW9FUFp3UFVHTmVMNE9FNUIzcVgvK0k2Y3E3dEJSbjY0d2FvWXcvcEZTWm9K?=
 =?utf-8?B?ZFlnQnZDQ0k4NEQwN1BLRzNManVuVU0weDR5cVREN2VNNDYrUzFDN1E4bXZt?=
 =?utf-8?B?THVWNHhsM3JVR1ErWU5IS0VaY2NnSzN4aDIxNnZFaXJ5TWtUTEtVZ281N2c1?=
 =?utf-8?B?S1d5Mm8ySWcrQkR1bG1mNWNTbDVnUVF5L1BZVmgzY2VQUkFNaVN1ZkFQNHFz?=
 =?utf-8?B?L0lIZjRwd3BPMmQrSWJKOHRUQXU3NjF5YVlKT0x4MVpLWTRhaFdlTWpQbzVW?=
 =?utf-8?B?ZXkyQTczdmFaVjc0aU1TSElrcktLWGNuL1BDQ0NOWUxtdDdQdEpkT0NoOFhj?=
 =?utf-8?B?M3dCUUd3VzBCZVUvRU1qRXhFd3J2OWdyQ0UxbHdCb2FoSXh5NGk0aDVJRFg0?=
 =?utf-8?B?WGZjUEVTZXZFTXRwa3RoSGxza3BpbUtzckxHQjhwNGhkYWk5RWkvanF1dlFs?=
 =?utf-8?B?Vm9JcW5NcGl6SkxRZG9IZjJIL3VLWXNTYXdhNk1xejJYL040dmdZendIaXZ0?=
 =?utf-8?B?YjZoc25xVExlL0pUTWk2ODZPZVhXZ3BsUkR6QXFndml2U3lpdWs1Q1NqWWRO?=
 =?utf-8?B?NWw3WFhpYnBRYlI0MzJHejRhY1d5aVhMdU9EMUVtWCtPckk1d01CMmJsbXdF?=
 =?utf-8?B?NlowQUZWZCs2TDQ1eDhCQlJpYnVIZzVnNHd1ektDNlFkdm53RDlqRjVpODNI?=
 =?utf-8?B?QXNTTjdMUWloT2ZKdkVPaWFiRStRTzc0cEJPVVRYMlcrTHVMMnFGbGNuR29o?=
 =?utf-8?B?NCtUTXNYUFBsY0trbXN4Q21aVHRDU0Fvdk9hZGpseU04bEM4aFVCK0hIMFZE?=
 =?utf-8?B?OXF5TDNZbGJvd29MT2J6MmJMNHFMaFhLNmorSm0wVVhTN3RWY3FBWlBmWlBi?=
 =?utf-8?B?QS9lVGI4eWlualNqQVF1cnJpSnp2MmszcFlEUktUakIxc04vNDhHUTlEVXRY?=
 =?utf-8?B?QW4zU3dyZHVCQ2RZRUVncnpPcjU2WEtieTUycjZVQjhyWElhSWl0K2J1RzNO?=
 =?utf-8?B?Rm12TGg0STNnUDVxUzRKYUxyOUkyTGRRZnh2czJjRm1sM2Y2VXJqS0doMW5K?=
 =?utf-8?B?OWNsV0x4ckRDUXJGbzh1emh5Q0RGT2VocE5VV2F3clFNSWxJaUlVOG1UYkNi?=
 =?utf-8?B?T3dteWZuTkl0aTdESlhlN25HM3ViVEJzd25adi9za0MyNDlhaEs4ZCtDOTF5?=
 =?utf-8?B?bTNZUUVhTWNPSFJmKzNMKzVPem1rdTAzd0FETnBUdG1yd3YrdzdrM1hHNUVv?=
 =?utf-8?B?Q3A3N3hPYnUyQWN0U0srT0tDUzhOdndvcTVsckkyWWtPcnlYWlN0UDVVYlJY?=
 =?utf-8?B?akRoVlRGWDB2blNFbUNINXlWMEJDcTdBMDYrWGtUK29sOHNwVWluZHVIZG16?=
 =?utf-8?B?WElsd281TWlySll3b04vU3YreWdlbmdHc3RnVXVldlBMTkdPY1JRN3gyWTJL?=
 =?utf-8?B?NFhmYTkzeGsvcGk0R1pUZW54Tzh2aUVMR1NTaDFFZUhYU1M1OUJHZ0NkN3JD?=
 =?utf-8?B?TGRxYzJhTDR3OXgzTUFRZDVPNHhvblhsMXFKV0hPNFFyRDRuckpYRFlBSnhK?=
 =?utf-8?B?eFJSSWFXTmFpbjhSWXVaWlhpajlBUVg4ZDBYV0dyTml0VjBlTU8yNE01Vzhn?=
 =?utf-8?B?ajcvbjRXSy9SMEtYd21lS1Z1R2Y2QmUySFF0YjMzZzA2QldUUkZiOFlRTnU3?=
 =?utf-8?B?NmI2ZjBDNmtWM011YU1PUDI3aHN1dVhjbnc1Y3lFbnErSGV4S3p6WDBYamV2?=
 =?utf-8?B?MXM0dTlra3BUSFJ1dUVSQkFNYUVWSkN6aWFsV2dUb2QvQzZDYzZkVmwzcCtR?=
 =?utf-8?B?QzEvZ3I1Ky9XWFBzSEphN0svYjdHZ25yQmc4b1ZRbTJ5TG54VjloZFJJWWFJ?=
 =?utf-8?B?QnJmN0tuVnl6Y1hEV1Zld2JQS2VkVWlvc05mdmJiQU40S0h3V1FCQkZ3bksy?=
 =?utf-8?B?WmZqOXFRVWlyWGV3RmZJbFN0WTliaFphcVhSTUc0UndJRmEyeUVoU1pSVHc1?=
 =?utf-8?B?Vkp0NWcxNXR1U3V0RHpvaWZ0WHM3ckRFZDhzWFUzZHdkWWlvSEdSVXZwcFMx?=
 =?utf-8?B?TlZPaXR4ZHpKSFY4RTcraWNzMnFvZVZ3Vk14UndZMWdjUjVIVktLWmpLS1E5?=
 =?utf-8?B?SEV0SWlzRlRRZjhvRUcyY2pGWnNIWXVhc3ZIQzdZOWo4OEtabVBIazBDZHZD?=
 =?utf-8?B?L2lySjRLZXo4U1U5cW5sL05oeCtDTWVpTUlGQ3A5WlY2czhVN3hrcGdpTTk5?=
 =?utf-8?Q?/UVdqyvSmzh9z2Q4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8546ed0a-afed-49ee-e4da-08de68a2ae00
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 12:48:24.8953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZDzAyt1Tqi8poDwpXcWiNmyUI4lOun0vmZjR0ztIPJDNw8+n+ZHJVFpxUn5FDvV00adsDTfrwr1D+w+pGXTNuOvGLC/tDWnSs9toOOVLtk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7086
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

On 2/9/2026 5:45 PM, Bruce Richardson wrote:
> Move all context descriptor handling to a single function, as with the
> ice driver, and use the same function signature as that driver.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

<snip>

> +static __rte_always_inline uint16_t
> +get_context_desc(uint64_t ol_flags, const struct rte_mbuf *tx_pkt,
> +		 const union ci_tx_offload *tx_offload,
> +		 const struct ci_tx_queue *txq __rte_unused,
> +		 uint64_t *qw0, uint64_t *qw1)
> +{
> +	uint16_t cd_l2tag2 = 0;
> +	uint64_t cd_type_cmd_tso_mss = I40E_TX_DESC_DTYPE_CONTEXT;
> +	uint32_t cd_tunneling_params = 0;
> +
> +	if (i40e_calc_context_desc(ol_flags) == 0)
> +		return 0;
> +
> +	if (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK)
> +		i40e_parse_tunneling_params(ol_flags, *tx_offload, &cd_tunneling_params);
> +
> +	if (ol_flags & RTE_MBUF_F_TX_TCP_SEG) {
> +		cd_type_cmd_tso_mss |= i40e_set_tso_ctx(ol_flags, tx_pkt, *tx_offload);
> +	} else {
> +#ifdef RTE_LIBRTE_IEEE1588
> +		if (ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST)
> +			cd_type_cmd_tso_mss |=
> +				((uint64_t)I40E_TX_CTX_DESC_TSYN << I40E_TXD_CTX_QW1_CMD_SHIFT);
> +#endif

I couldn't find any places where we define this, it appears to be some 
sort of legacy define, making this basically dead code?

-- 
Thanks,
Anatoly
