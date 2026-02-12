Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FF3EB4914
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 12:20:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 73AF14060C;
	Thu, 12 Feb 2026 13:20:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id F195A4042F
 for <dev@dpdk.org>; Thu, 12 Feb 2026 13:20:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770898856; x=1802434856;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=uCEqCFjVjkyZFQhhBgxXpCddZZ3aw9msI83GUy3QI0Y=;
 b=dJCzQXbict8tm8WHVUWEsN19pePd+5YtYASjAHu6ff0A6UhCF5zYqR4x
 0Gdqwf7DvK4oFNLhSsn3ynfQ9bq2iQiTQWq7LFJorzBlIBCXmlfgbUt9O
 nRpGFJyJB/BeqqNUHYV7qJqqjU+bXT2NbAEx0aOuW/9aVjh3+etEm/HUC
 hxyl3F/L5kddmna67zhjRJWX3XqRW8QCPy2IIfhl6ybmoVrTOSwLJg84z
 6RNxkNRx2ltusgJqOc4Tf1rh5mdogTMCCjLfTsGxQeqkcKAp13IoR+DXh
 B+Q6dT98W2P1KRydAaAy//b/bJvdxMfVxk1G60ze7cPPG9Ik8mePpG0I+ A==;
X-CSE-ConnectionGUID: Nww80kgFS+q5j7a+ZWRgxA==
X-CSE-MsgGUID: eLmXQxx+THuKyne1HmpOqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="83165568"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="83165568"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 04:20:55 -0800
X-CSE-ConnectionGUID: ESvJXIrFTpWm+INJCxymQw==
X-CSE-MsgGUID: gPE9e33rQ7CRYs7XOofQgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="250250923"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 04:20:55 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 04:20:54 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 04:20:54 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.45) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 04:20:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dtBuUVXJl4Aze8f1MkWVryn3FfZvFUIkxeoje5acnvhzb8RvUgFGptQcRKD3cZ0atpsdR/Z0RmLREofk4fpDEbxmDF1EmCMCaC7XAY5uzmTUbgZgHVcu4FKemogwjOuyi5t3hde49yejVwsQRUf9X45tU5HQlXg4Znbv8Bd2i47YQnCQzw+t0k0pd1oVSREH08SNIrvBIQZVFlxGFvAVM9OV2jtWYD17iD71jKCr68zbIXuaKqADzkmnzaq+3vcuB1raVZCY1BRei/h5PDa0/3HVgFzt1/6Z3Oz4jpsWaWLZ+iDADbc0gd1RskHAsjnilpJy147c/bdfqVV9Crud9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUzLWVAi1eJBmU+kVfVLo7n/VmLC1dX2v+i0Ysx0xt0=;
 b=Ec02Fx7448SgthA3m9GCCDu2qPIRcR1+To5pHGkZJ6AXkQK0kMJO8x5kRmwqhwUmFzVl59KOT5vpvI3XGlpstCvVRMsf+4AfVFvq9jl5xUEO7py7mKLMJ/+yjUGpTFWeSldMFrDnY9vMDI3aTI0/vE2OQyyYQgZ9JTqTBdv+J+1Zxi9Era9QfZGN0WDWxI34De5HryEV+hC19f7OlYYj5p6pTcPzQr35c0Ye9DuDHk3rz9T/9AQcH7nNLpxAN8TilFJfkGu51DCJb/UpohaSzjlDTwqYSvuZ9DmJ/scw414HWZ11MyB84z8IVmXdQOfn366mwjHKBpWFKXfxwEOgvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 IA1PR11MB7270.namprd11.prod.outlook.com (2603:10b6:208:42a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 12:20:47 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 12:20:47 +0000
Message-ID: <6869874d-85cd-48d8-9fc1-1d754b271726@intel.com>
Date: Thu, 12 Feb 2026 13:20:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/35] net/intel: support configurable VLAN tag
 insertion on Tx
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260211181309.2838042-1-bruce.richardson@intel.com>
 <20260211181309.2838042-16-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260211181309.2838042-16-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8P191CA0019.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::29) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|IA1PR11MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f075ccc-f85a-4b65-4348-08de6a3126d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NE9Ec0ZFZTArNDQwT3FQbDUwcHNGeVJVeEd3ckNxQ1FBeGRnbW0wMHhJd3ow?=
 =?utf-8?B?OWdSdTNrdEF3OEg2dlBid3RpaWZMODdvY3VuVUUrY0FyUmpHcE0yeE0yQlVX?=
 =?utf-8?B?QythbGU5ck9ka001QVhtbXJ0QVovYmMxMld6SVZxTnVOL1VjTHAyTnA2QTJp?=
 =?utf-8?B?MGFjRmlYVXhUR2R1KzRNNm1TQ1Z2YXFmM2d5SkNsVGt5YnJ6NlQyQ0N3VTQ4?=
 =?utf-8?B?THk1SlUrdG52WXhMQmtUbHVUWVFrV1hTTnYrTTFRMjFvZ1czSWJBcnB6VnNm?=
 =?utf-8?B?NGFxR3RBWUVNcVBiNXE5ejRYbUJZb20xMFkvb3lQcGs2bWFmcTd1U2EzQ0ZF?=
 =?utf-8?B?ZDJTUWNXZFBseFNrbnhOY2gvM0w2dWRtRDhzNXVNVWxQRWJrNWthTDhVUlY1?=
 =?utf-8?B?dW91Y2t2cjBSUDhDejJuczd2VCt6MHpLUTFOUlhESTJUY2poY05KRnBFUTJj?=
 =?utf-8?B?aVl1dWR2eTJYdmt1bGFaKytlcElvNUlmSDQvOHVHbllpbnp3TGpoQ011a0Vn?=
 =?utf-8?B?MFNYYkV5Tyt4WVppUEJXSmRsLzFDOUtWSXhuTWo3aEJrTHFEKzRWcVJ5S0k1?=
 =?utf-8?B?SzJHdkVvYTZsc1pEUkZkZWM0cHUyay9Vc3lWRUFqQzZTbzAxYWR1R2RHTTZz?=
 =?utf-8?B?L2hPMVRJZmJZZCtTY3FuMVp2eXgzdzdrakhLYzlwdkJPbVhDdzRSSEM2b2hY?=
 =?utf-8?B?UU1rNHBqUXRUazdpMFFuTXdKZ2tTL3BINDdsYXZsdXhVSThzU1pFRDJ3ajJp?=
 =?utf-8?B?OHkzejNzTXJCZ2JqNVJ6SlhBK20yeEN4TElVWnJLem9YYmdpd0hOTEptaW1y?=
 =?utf-8?B?OFlBWDAvYlBJd2xJVFZ5b3ZmSU5uKzZaTm1hV01Nc2I4RTFQdlg0WVFQSWlP?=
 =?utf-8?B?clhoYWhPNTNXTDJadkJWbVpIOEt4N0Z0WXNiTWFTT2V0K2poNXFtR2dmY3hJ?=
 =?utf-8?B?ZHAwZDhCYXBOclluK0ZPUGpiUWdyZmVsQXJ0b255TEJXcGhYTGpIZHNyL011?=
 =?utf-8?B?cmcwWExNSjdrL1FxVE4zTGZodWZyd3lVdjRwb2NnK0M4VzR2Q2R0Wmw2NDBq?=
 =?utf-8?B?V1h3aGRpRGN4RE9pV2szKzJVNk9nR3R0aFU2TjhGeDM2OHJsbFVYdWJxMUcw?=
 =?utf-8?B?VFRYTUF2OUQ2aU9hWmV6V29ZTmZhNTZ1d2o1SFFYZGtnUE5vc2JMbUo0Y0xB?=
 =?utf-8?B?cWxsc1JXMEF2VlMzTWd5S2wvWmNtci8vVGRkd2FLY3RCR1htT0QxRTRXenIy?=
 =?utf-8?B?SFRYVUx4RTFOR0NWb0p3WndlMHZGb0Z3cGs2TWRpSmdGSTJadDZ3ZGJRNGNs?=
 =?utf-8?B?ckFNMEdFUk9IckpDWEJzTDJ4dTRWL2VmRERsTlhMTDNxT1NEOElsSUlzYlJT?=
 =?utf-8?B?QVVnYnlJK0R2cGdVZkoreWxBUzdVNTRZUjZPQWxtU05aNXQ0Si80WnA4a2Z3?=
 =?utf-8?B?NkZOa3p3L01oc1c1REdLSW1JdUg2K29qRGhkUzFWM25oWXRxSVo2cjU3Qkh0?=
 =?utf-8?B?NXZQUWNOL3MvSHJqU1YvRldFbVl3NVB5QmU1RnNsRXBzaXBKMTZ5RFlOaTBU?=
 =?utf-8?B?VVM2b0hhQUZjWWMvNEdGZEhtOHd0WTd2LzlPOU1CdWxHWVhnZVZmRjVKajZa?=
 =?utf-8?B?dk9KOE1CeFJtZnNGSGhVb1FZYmw0ZXlGS1dZRXhCWUorazZhUDN2cVEvTXRl?=
 =?utf-8?B?YlFBNU4vWXIzV3dZS0hheEh1bWxYcDFwdXdTVnI1RVVwdmREbzVBUUtIT1cx?=
 =?utf-8?B?S3NBNytJR3Ivay9rZjgxWkVlN1g0NWxpUHgzWGdwbEpyS0VtSk5USjllTWtV?=
 =?utf-8?B?djVGUStXN3RlclJkUHNBVnpuQjY5b2laV1luRDlVT3RxbHhJMHgvc3dmRWVY?=
 =?utf-8?B?ZWlWSnNoN2JuT3F3ZW5vNGxwSUd6WklwZnJKcEpVRWRtSUx5VEJLS1pnS09v?=
 =?utf-8?B?MFpPTlQ2cUdiV3NXaGF5T0FEUWpmaWswVkFINm04MlFHWU41UXhydFNEUldP?=
 =?utf-8?B?OFhNdko4ZmowcktNZ244dENWREpac3IzRlBLbnJ2NlhuNHBJR3JMcHJ6WDV4?=
 =?utf-8?B?NTdEb2RCU2FHRVBkbm9wU1hCRTRrdE4wanoyYWkwNmVGcStmeEdKY3hSV2Ez?=
 =?utf-8?Q?yKTE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWlKaG9Fek91ME9XWjVMMUtFN0o0WDlaRFc4Q3VRajlnNlhuK3NIcmRyWmhx?=
 =?utf-8?B?R3hpTnFwUlpFdkZKS2ZMMEt2OWRGY2RHenZPWTBvTVF4d25odXo0V2RIYVIw?=
 =?utf-8?B?ME92Z0MrY2padll0aEN1UW40Um85TUlFWEF4WWpzZU14V09raXdVS3RJTHUy?=
 =?utf-8?B?cThhL3Y3UlJnaXRJZWN0YS82T1k1dThxUGxIU3VRKyt4MmJhQm5MUDJOb1h3?=
 =?utf-8?B?L3B5UVVRbDFZaFZaSjl6bHFLYk1WM0xXVHhJbk1HNGMvV3JaNmw2aGRBRTAz?=
 =?utf-8?B?cDV4b0RnNFRWdi9XbGtwMG9OckFtQlFkNEx1Nm8xZmlrejN5ellvS3BSTng5?=
 =?utf-8?B?RDBNOUlsN21zOXBYRDBPOExVV2w2bDVYTGRxNHJGQzZpazhOcGpFN0JYWWw0?=
 =?utf-8?B?NUo1WHhXS25KSnZyN1VHMGUwMGRqL01GakZoWmtEL3hBVUtkeXlxaGtFb2FT?=
 =?utf-8?B?cUM5eUExdnI3SVlGS2lJZ2krczYrVXIzV1Bva3lTeEhZUExJQkE4cGVYWUpj?=
 =?utf-8?B?cG5Pd0xJYWFQWGZDeHEzM0F5U0d3VDZvNlUrUTFjMjZTck1Velhra0FsbTlh?=
 =?utf-8?B?RFlLcTJrUjI5STc3cmxQc2kvY2N2ZDdFcnpscXFWK2cxai9mbGs5ekZUcXF4?=
 =?utf-8?B?L0t0Y0p1YmxaUmEvb3REb1BOS1RwSGttZ0gydWdsQ2NpQ0ZRQ1RyaGdCVzUz?=
 =?utf-8?B?TzU2MEhtbE96REdmSWpueFJSQmttTkM4blNTZTJVbzBNbm13Mmt4dWtxd2Iy?=
 =?utf-8?B?TU1LR0J2TFZrL0pZcVRwRjhEbkpzRXdBcjJIQ1lpT2FWME9uMW1NVWttdzVn?=
 =?utf-8?B?Y3ltWURxcEFya1ZmeXI0bGpYRURRcUZqL0NTbTZRd3lDR2hOS21zT1crb1Z1?=
 =?utf-8?B?eVEyS1NCbU42Q0FnQnFEV1VabG41d3JFTG9sU3YyN3FmRDhOVnZtT3c2aFBx?=
 =?utf-8?B?eUJtbU1JUS9tVUVQNnlsb2VGSVFPSk51WEJUendOVkFYMVF1NDQ2cDBuZSth?=
 =?utf-8?B?WExqR0ZIdXRIUDlOKzZXZkRaMzBJWjdWY3ltcWc4ZFhoN24rTll3TlNsb2tZ?=
 =?utf-8?B?L2NPcUFhc2p2S0UxeUVjQXpPdTRuUGgvZzljMkRCc2pqSG9wU0tBNEVxWVRO?=
 =?utf-8?B?bXFjTm5nclAwYWJnbDNKbXhSWWp4WXlHVGl1V0RkZVRPRU52U09EU0t1YXVO?=
 =?utf-8?B?dXBqR1dSMU0yVldObUJSMzl0TnFsbm5aeVgrM1R0bUZXb0dCSjhGd3c1bFZw?=
 =?utf-8?B?cVRidnNwamdadmZCVmtFYmlObFd1RzhZaEc2dWdUSVowdW5yWmR6K1EzS2lO?=
 =?utf-8?B?djJKa3loa3I2U0o1WDZ6djBmaWRlWFhIWWJJMWVDdUhJMWFCNzdPeC9UQWtK?=
 =?utf-8?B?UVZQeXRvZk92eE5Fc0xkb3hkMlZoUjV2bVBCdTNxOG9XdWNPZmlzK2RHNzRX?=
 =?utf-8?B?TXFQaHpRL005Y0VJenphbnBPM3FUOFdnT2lraTZHelQzMkN2UG9uQkFCZ2J1?=
 =?utf-8?B?Z0p3UGVCWUx5V3pCTWhJMDJkZmZDeWkydk9RRjhKSG8vUDZyN1cyRExnaHBo?=
 =?utf-8?B?WVJEU2JJOTJMdkhkS3R5cGpzRjA5UUZyNkFwQ0ZzdHl5MWQ2ZlZBSWdlT296?=
 =?utf-8?B?d04yeEtTRWhTVXRYY2ZiLzlSNlJJWk1nNDVJaWJRc20vU2FFWHlkaFNFcFZZ?=
 =?utf-8?B?dE5VSXdzaXlxUHhBd3Q1T0VGRnp1cFZPWWZJL2dnYXV1bHhvLysrSzNnYUsv?=
 =?utf-8?B?d01TbXUzOWNSNnFHY1F3L3VsTTdwRXlncHlqTVJJY0U5eTRDanJMOWVJWmw0?=
 =?utf-8?B?eWQwckdRMy9hZlg1S05nUnVGVUtCbmtvNENUV0h4MTkxOGNXMXBkalpuRGlV?=
 =?utf-8?B?dndmV3Zpczc3OUJkOGhWTSsrcFVReUlOVFFpVngrb0orTklDY0ZtMDg1WEJY?=
 =?utf-8?B?akZBUzVtcys4aE10Z3AvOEF6bWgvRHczUEFoWGRyMHl1TWx6bDhpQkQ3QlRS?=
 =?utf-8?B?ckpzcjZEZElPb0Y2dzJrWmR4a1hyeDhCUVZkVTZJbVh1T1hBc2V1NlRZV3JC?=
 =?utf-8?B?Qi96UDg5TEhrb1o3KzlCVDY5S2pHcEZjY2pTVWxacUpSbFZYcUlGcDhkZGox?=
 =?utf-8?B?d0JSaDlCYTlDVGtLY0xTZDlhZmhmUnh4QW13Z1RwdW1Hb3M3Q01NSjNad0xH?=
 =?utf-8?B?aVg0eVFyaFo5SXkrZzMxZXpuQ1RpNGQ3cmN4N29GNXdtSmYrZStNSzF5ZUFu?=
 =?utf-8?B?Y3pucjA3NnJxaXZreEVUZEZFRkxPS2hoZkk3LzZHUkhJMlNkem8rU1d3WFZ1?=
 =?utf-8?B?Vm5BK2l3eitnVmFJbUJHQ2FOSWhsZEI1TmRySTBhdDROOTZaV2toaDdUL3FH?=
 =?utf-8?Q?U7eayvrcS0LEWSXc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f075ccc-f85a-4b65-4348-08de6a3126d8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 12:20:47.3282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uRjXggbznTDRqpyjR5fyO37coIiSoIoZ+d+o70AKXKRqRU/SuzRN/2gZuokqa0XbPmPSjU+qsPf7qrM+ReLRE2sMla1fKFRuoZgVIeGNe8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7270
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

On 2/11/2026 7:12 PM, Bruce Richardson wrote:
> Make the VLAN tag insertion logic configurable in the common code, as to
> where inner/outer tags get placed.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
