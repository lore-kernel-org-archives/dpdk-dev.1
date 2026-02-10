Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4149DEA811E
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 14:15:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 828E3400D7;
	Tue, 10 Feb 2026 15:15:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id BD6C4400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 15:15:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770732948; x=1802268948;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=bkdPVakBs5TvDJUWinua2COrT7+bWrvz3ni2LwD+kTM=;
 b=ZQGmKH7/ejaL7qhaU/tFNaitZC2dcMQBy9I2UhUum/HL5duApc9tn9w9
 ZeO/Wm1p/DP9v5ifr/DkdUPskbgXTySqQTQYB/gK4Qr6rWGBxcO2NlpPM
 Zx8eqd3UY1JvNUrcPjsjtcaNJPAYBZ2iaDzUOrc2CF9v1mbJXdkzcCJlY
 Z4W7GvI2hzVsbUxRi2NKNIyvMZuft3HPEHlNKAyXDRmKO3Tr0AXtm0Y6x
 IVYaGQ5n8AWO3TfYDzZlTJk7x5qShWfrpv7jr5/H2QDPTZnWowEIWb0hR
 mqtBtVDZ/TUCJkWQvWJSa0E5uzMqS9AxemnHa1u9SYj2CbZf4763E23J2 g==;
X-CSE-ConnectionGUID: /nLF7UdVTcuCYAc2E6eQKg==
X-CSE-MsgGUID: hggv7DYGQCmMVl2CNDaJYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="83230982"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="83230982"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 06:15:47 -0800
X-CSE-ConnectionGUID: 2FOuM4e2S4iN1UsMdASEtg==
X-CSE-MsgGUID: yDK1INIBTMaWW+FbeaHpDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="212010804"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 06:15:47 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 06:15:46 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 06:15:46 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.40) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 06:15:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=roVsRc7+wKPHyCg5ZiUrAGBz1jctgXs/ZvkH3gk9AdXnuMelU14LtOiW7n82o5juRY0MJwQ5ckJpM5CJLBN6Md0s4ksloFUapCs1QTD4RdXQcBgbDUC01O2deh3+zbP5u6JCzP2E7cMCZ8QpqZswKXJ1Jfw/2bzPTDrAQwMhSMj1fDtdBK+Pfm2A8SIstGvSVWlv4gPSC6NRHbmkSfra9O1IbSJy0r+W+ehUAjbVUb9hhBvUk2pEfmMEw0hr55ZStZegqGm1+7wZpoYgO+9hJUIhx8jArRrO3bUjLRMeNiFnT9DoalwVQ5XF0VC//9NiWdSkjnPpCrZAgKDjNSA1EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkcwRhHESXb2csqecC63CU7YiB2XazfyMDANIRfmFBI=;
 b=GrDnggZ/AGMs+3BE8h2Uw3LnHwr+jEAU3HEJkXM6Hyu1e0MohFx4UYCt1zYKtZcselCkmyw5o+3aZluEtg3RynujXdGPCpnYp3Uw43Z5zCRllBCrBkBrcpKJuWOwyuphoHkyqFGcy1JIDiAN4/kz7SjV4+7RLUrOOH9XjO+VMBFyCCWIZLMdaA7rbvVi/qZZSvuGg29R0BVYH/XULy3K23KLe5cjcbCp0XIc9/iyuaMrhjfuGsnRVjkJD/6NGQEtaEyKmjuI9pNOeI4P6THIxqLgLTy0iaJPVDrGtVZSqMLA3D73R784azG8ABZTnrTFkxlEorMbsaDPxcJPMre5lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DS0PR11MB6472.namprd11.prod.outlook.com (2603:10b6:8:c0::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8; Tue, 10 Feb 2026 14:15:43 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 14:15:43 +0000
Message-ID: <82f0ce5c-dd7c-4143-9408-47bae58b2473@intel.com>
Date: Tue, 10 Feb 2026 15:15:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 27/35] net/intel: remove index for tracking end of
 packet
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: Vladimir Medvedkin <vladimir.medvedkin@intel.com>, Jingjing Wu
 <jingjing.wu@intel.com>, Praveen Shetty <praveen.shetty@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-28-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260209164538.1428499-28-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0219.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::16) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DS0PR11MB6472:EE_
X-MS-Office365-Filtering-Correlation-Id: 85712910-ffbf-439c-5d0e-08de68aee07c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a04wS3Fwam1qMnVZeTU0RWxTMXRKRG92Lzh5UFBCUW9TSUN1dEVjRTUxMUtK?=
 =?utf-8?B?TG5sV3NGNUxVVjN2dlBQaWdXbm9tMWIrUGVLOU8wRDIzc0FHcTAwVTFncDg1?=
 =?utf-8?B?SXovNTJCZ2l2bEwxWnJqRGQzdE04aTJxdGZYdVRsSzVNM29CdzRERXdHd3g0?=
 =?utf-8?B?N3ZlWXRIbFNRaWdWWjZSdUVEOFdWU2R3WHJYTWNtcG93eWVjYjkxRzhLaGNF?=
 =?utf-8?B?Q05HbkNsaTdneWZRTVNrTyt6UkZ5VitxaFVqalZKeU9qV3o4MSt2dlNEeG8v?=
 =?utf-8?B?VHhmeHpqRCthdjIzT01uWmF4WUVyN29UaXFSdWJBYXRzcFpqamhmcEtuOWJH?=
 =?utf-8?B?bkVpUDcyTE5qSG96VEVIRDVWeVlGVjFNeFZHTTNtcUhRY2t1ZzYxV1BqRzdm?=
 =?utf-8?B?c09MRkxvNzZmOGQ0aWxNb2RnWldyZkxoUGlJVmNKMHZzeXVNdEtHSE9KdzhS?=
 =?utf-8?B?dGQxbVhuWHk0cCt6ZnYvSVFPdkRSTEx4MklpODNwb0ZmS1k3TTZKZHZqTnlM?=
 =?utf-8?B?REhLS1V4ckVIZnB2SnNEeU85SlZ4akZBSFVjSllmb1cwbm5zNG1vRm0wT3Nt?=
 =?utf-8?B?SmRKRnh4UEJHUmNUWkxady85SHVEOWtTYTBHOVhLb0VmUmtaN1huOXNSUzBs?=
 =?utf-8?B?WkcraEg4c3hwSU4rRU9Uci8xdU1MdkFoQTNnNTB2c0M2QnlSNTgwTlZ3SlpH?=
 =?utf-8?B?cDBSVU0xT09kOWU1N1pPcG1YZndlaWZEQWxsQ0YyNitsRmFMZWoxb0Fuc1gy?=
 =?utf-8?B?TXJqZUw4SEw4dnpEakNiU0tuY0xuN3dwZW9hemdkYnczMHZZV2VDNFUyaHMw?=
 =?utf-8?B?eWNobTVFZmkyK2czc3lXWWxSdzZMbjkxQ0NlUm93cmN5dVB3WFg0YWF3TDBl?=
 =?utf-8?B?WDNqZHV5N1BDOFNoV05GRWR6VzY2aHZGbFZBdGJKOXk3RkFvYTl4U1kvaGRB?=
 =?utf-8?B?NThqN2k5SGR0T2w4QWh1L0MrNVdXYUtPanRkYnpab0dOd2UzMVRDcUJ0Qk1s?=
 =?utf-8?B?Yk96Q0lPalN5YWlvWG90SXljOWFZL0czaWhQaGs3akNMcUxWN3RLUmY5TktS?=
 =?utf-8?B?U01xMnkyMk5QUzRqZnZmUUVmQjlGaXlIRTMxajRMRWQ1T1REVlY4RTRNVndT?=
 =?utf-8?B?dVNwSXNjT1ZnMWFkZE9ZdmZXTXN1T3IzY0N5OGhXNG5qVzRYQ2ZObkVhVS93?=
 =?utf-8?B?UXM3WFdTNUloazI5RnI4TWoxRCtFeXZ0TGFjOWZvVnRDOFBzL0FnM0kwQWt1?=
 =?utf-8?B?N3NEenlmU1ZaZktQaytyVmpPOUxkcHJXb3c5S2h2a0NYeHRDS083ZU55RGZN?=
 =?utf-8?B?OGYyN09PLzZZNEJnUFZKNzI1b0dmKzF5L0xRZmRtVklMdU1zM3JQL2xLSm5u?=
 =?utf-8?B?NUIyUVA0bmNrQlQ5enY2blRGMnVWVTNFSzEwYmNzUTVWSDFHVW9IbjlnZFJx?=
 =?utf-8?B?b0prVkJJQmxSc1RMRnJXczRuOHVEZ2dsSDJJVm5wOTlnSmg1V1ZqbTNocTl2?=
 =?utf-8?B?TzMvRTBPWFFGYlFMMXBGcEhhbElkV3o3WlozY3ZlZ0YrM0hFZ1ZBWUl4aDA3?=
 =?utf-8?B?aVdScVFveng5UVkxaXBiVmgvdWZWc0w5bzNKQlJiVE90K2RYbW52T3FCUE9N?=
 =?utf-8?B?Z2xJU2d0UXRZR2NTKzNXRVJON290RnN3UnhWMkpnK0p6ZUd3cHFoM2J3elVq?=
 =?utf-8?B?a2JKbE9RQThqR0VsM2RWRXJlSXRlckJQb0V3QVFIUFEzblVlYnlieXYyOWRo?=
 =?utf-8?B?Yk1aeFZsQkNxNVAzbC9lTTNCKzRFaGlzMnBvQk92UzRnMjBlNm90RnhsSUZj?=
 =?utf-8?B?NTVUbm9xcXJNK05GOWlvV1BEREJlRHlLZytPUHZCemZFemI2TjVqeWJ6Wit4?=
 =?utf-8?B?anhrSFNjMjZYOEpaOTRUK2JzOGJFR0tOTWZka0F6N0Q4U0tOQjYvWnEraEFz?=
 =?utf-8?B?cmFEWngwaTRncG0reXRPQXNzVW1ZQ2V4T0VNYjUvaGdPa3FrSUphaWJJRmVp?=
 =?utf-8?B?OEVzYml1NTVYcXJnV3piQVdMVTBzTGJYRG5RRllVMXdkWkgvbFZaelREU2xa?=
 =?utf-8?B?SThqbzVRbEZxMHRMcm0wd3lBY1k5Z0RhUitTOXVpMkFKenZvSUc4cFRtZytj?=
 =?utf-8?Q?293w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUpSYzZicG0wM2xiZ1YrVy9LMHRYSFhzKzh3eDBSZFVQcGFvRWtDcG01Q2pv?=
 =?utf-8?B?R2lKdENCRTNZVkhCdEJFcDBQNFV3bWhLVGRHRExSMEVIME40RERPU2FsRHRw?=
 =?utf-8?B?WWJCSGtpdDAwb1VSNEhaTllLdXlYbFNoVDhwLzRETkFVTXJjR0tvbStlanRl?=
 =?utf-8?B?Y2I1WUhOVDAwQXJ4VWpuTllsRU5rS1YzYUhOQXIwUEJySnNsdDgwSlltaHZh?=
 =?utf-8?B?NGhzSTM5QVZnZ2laa1NBMWxDVC9vVVBMS1U0V01UYndhNVdmT3UvMzdBYitx?=
 =?utf-8?B?TWVpcWNjVndjY1JuRU9CejZOTUQ2NDVoYlpmSm1UeU5ac1YrVXhSOFRhcTZL?=
 =?utf-8?B?ZGdHdjdmc00xQk1zMlNPOHoyeGlWUFF1cVBZVzhZVnFiaHQ2R1NIa1p3RUVH?=
 =?utf-8?B?UG9XUXJnZFdpLytMS3pYQXVVUFo5cjA5Q1l0Yk9rWmM4Q082T2l1Y1dpN3F4?=
 =?utf-8?B?YnBBcHgrUVMrSE5EWFNZekZQZGhNRG5IRnVxaTNHWkhjT1M4bE1iV010NW5J?=
 =?utf-8?B?K0d2R1hnb2o2aFl0VEJVQVhodFJDeWErVnMrSFUwVU9nTEluOUxuNDZDR0ho?=
 =?utf-8?B?cStKeW50Y2JTeXJadlVJNGMrYXdBa2RVUWt3elB4Nks0dlJqODhvWGpDZ05R?=
 =?utf-8?B?aWRhMGVsYUpncnZCSnVaZlRmdGw2bmlCbEhFSkNWbWxIcnYxWVJMTHkyc3V0?=
 =?utf-8?B?cURyZm40NGJoRC9tNjBmbTAxWWpEU2NRemhoUDFldlhmbDM2QmxsWFZsYVpt?=
 =?utf-8?B?c3NQNUNFUzZKczZlNGthZ3JiQjd5WTJJbWp3YXdFTko3NjRqcWZXR09QcTND?=
 =?utf-8?B?dzBObDROb1htNkpDaHRQbVlWczQrNXRBay9CQkNqUjNPKzdtdk92MUNKV1lU?=
 =?utf-8?B?dVJnWWlOblFiK0tjMTJDV05zblp5L2xKZDBXNFNncDJNWE0raEFqSURScnk5?=
 =?utf-8?B?RHBOQXMya3FxeGh1S0V1eFFkWWZNaXVyc0hGMmY2L0djM09rVHNKOU8ydi9M?=
 =?utf-8?B?LzZjRWx5Z29mN2toUFNIYjg3U2JGSE5qVmQ0dzBVRUw1Q0JYVFJRdDVJSVlr?=
 =?utf-8?B?UUR3QUNzeVNlaFY4TllqS0NlNnVMWS9SVUtuQkNjN1I1SUdlbEZpVEtRajgr?=
 =?utf-8?B?eGptUm9LR2x6aERvVjFqdXVGRExWUmQvT0QwbjNyTnlyamx1aFIzTFFYLzVG?=
 =?utf-8?B?ZlZzMWxqZldlZ0p1anJ5T09kUlZLUGJxc2Z0b2hmeDkvcEk1NjVaMzVBRHln?=
 =?utf-8?B?TEU2NlA5bEM2OXc2VkpTYlNyYU9EMDQ3c3JuUlp1ZWNNQ21TZkpRQlJ1UTRB?=
 =?utf-8?B?aDdMcVNUd3FhRzVnblMrMjBaK2dRK3ZxS2xoRTlnK3kvcG5oVE9zaDBqNUY4?=
 =?utf-8?B?dXB4aGt3RFlLcG9lNXJEUGpqTmoxVEpFejdKMnlRR0ZNcEJqRkp0RDBwUjB2?=
 =?utf-8?B?bWdoVCtDbnkvSnByOEltZ3V3eXhnSHlaaHJjWVV2bVFieEFzSER0SEJRTUVH?=
 =?utf-8?B?TG9DRW5lcGJDWHFLZ0lwMURpQ0NzTytNRjVYZ252T3h2YkhvREpFMjdYV2Y1?=
 =?utf-8?B?QysxcU1vcWNTVytsR0tpQWg3ZEFHT3pTbXlqMFZLSTBORDhQY011WWNrSHFm?=
 =?utf-8?B?NkdheDVkT3ZyREREMXBmdittYTZBL2FGYW5wTEpmN2gxemFKaFFjTjgrbkha?=
 =?utf-8?B?YVBYN1hHeWdsUVRhME90bm9zRUFSQndyeGVEcEF3RHdPcEtBT1BMSDNEb28w?=
 =?utf-8?B?WjIwQ1QxcjY1RTE4NGFrOWU2SkxNWEtHQlFPU0tGVFQ1UXgwSkVsNkthRGV0?=
 =?utf-8?B?RHJZZGVkWVcyOEwwTWM2WFNvMWQyVXV3L0NjNEMyNm1XdWVIWWVJR2pMU2Ri?=
 =?utf-8?B?UXVFOUplYThWL2QvbWljVWtid2E0MURaS1dlaHRXZjRUQkgvZXA3ZXgwZUtI?=
 =?utf-8?B?UGFUcDVzcVBLSlBIVDd4bWorUWI5QmxyUEJkRFVXc04xYktFUk9BSUVCbXpT?=
 =?utf-8?B?NHBET2ZhTEREK3VNVmVwMHdncUZwaG82ZkFhd01sVzZYd21uVVpBdnNtQity?=
 =?utf-8?B?WFdyeWV3T1U1Y2JVRUhiWFVOMDdNWkJ2TXozMHNKN3czcStBV0c0bEtVb3pF?=
 =?utf-8?B?YXdMdzhJK2x2NCtSWVQrQzJWVWdJOUJQU0l6WDFjQ2xUOWNtWDY5bGZLV0N5?=
 =?utf-8?B?MDR5dzRlY2sybzhuNlNUWTdlcDd2MnNoOWh0aE0xMGdkVWQwT20vYWovTWtp?=
 =?utf-8?B?bXVmeUFZMXNNTllFV3pIWHlOT0dublU2WnZUb0IwbW1zcG0wcEc5ajdXb2s5?=
 =?utf-8?B?YnNOSU40SEpRZmp1OVJkWWtMa1c1dG43NWl0Q2lDY0UzZUdHYjFWTi83c3Vs?=
 =?utf-8?Q?9sQXjczpXUhBL7UE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85712910-ffbf-439c-5d0e-08de68aee07c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 14:15:43.5451 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tMcS3tVfPfoQLQmAEnE9XwwfBysp9QPRzDUhwUPKoWrpRmccYaKfMAMN4EZkwlai8tOJ/OzRpArQqvL4W0rCeOBndB4lts3mRCHvWCu898A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6472
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
> The last_id value in each tx_sw_queue entry was no longer used in the
> datapath, remove it and its initialization. For the function releasing
> packets back, rather than relying on "last_id" to identify end of
> packet, instead check for the next pointer being NULL.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
