Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB070EA8113
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 13:22:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB161400D7;
	Tue, 10 Feb 2026 14:22:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 168D7400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 14:22:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770729722; x=1802265722;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=nK5Jj9VjiXS1rM6YdtvKMcWWYMD7XBrEwI5Q/FghTIA=;
 b=m2IDugyEouIb332HC22MrJM3RsC+aeeaEWiPCYN7VRxXcZzqyThovUZW
 zOomeCWwWzDFJMNPUSLFmRjE1hPkC8MZkq6xI11TMXgMhM8XNgHpDikZc
 PlL3hKLKC2lucaAgtoi835A6uXCDxiUL8wkhgD+xm6gP7v4dtnqTJPxI7
 pJ+IYSbs5k7niXxtfpgps1ioWgqC1AEpIgPAomEtmak3EZjchuVPQ9APa
 kVp7I1AdTrPwGE2PSYCe1lslBDahVLkL5Sf2HHVX2MWR6yafR46XrjBj5
 uc1HBT8GyO7LtFuAdodLO8SEbhnPaQbGjcNYJd6yd1j8sRsdK9KhR6EK2 A==;
X-CSE-ConnectionGUID: z7iVx3W4RSWxgsH/AKEjWQ==
X-CSE-MsgGUID: gCMI7pj+RDmxU3aU9BMEZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="82587031"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="82587031"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 05:22:01 -0800
X-CSE-ConnectionGUID: 4x2wQuxMSr+yQ+/zZ3EAvA==
X-CSE-MsgGUID: DlHzVwbVTg6RODhaeL4+/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211567952"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 05:22:01 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 05:22:01 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 05:22:01 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.54) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 05:22:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zMzFR5qAF2sannIxN5tjO0iyttrACKe1ML/OfMtazX52RCy9VafK2jcIl+zUpdEKWUND5ti2ALjV49LZn/cgFiySHPQaaNcSQ4jXuVHmD4eY9UFJLfN+LEleI3MGhIMGQUp5zmhlqHXb2YRKAoP2KHNVGf7svnYUOOb4Sj3MU++BM0m1q8WEJ+8nRBF033WzuAZ8+MPvxC8CuesZzz7sxTYX12S6CnirnFwaW7cQCRFdL3RAaKqY+YRT1Uh6w9P7rJIa24hejObjVAdLxOAV695UJJDTlZpeU6CQi/8m6fDrDy/RIaHWd4SQYDv8ftEFxYY4POJsRnQDCJKRRcdsRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2rds6/7URBKcm4ZvjRhudA+ILtT8XQO/d4N5ZPslr0=;
 b=h2Ctd6j0DMldfYaeU/4AvatwXlLvco2bAy8x9m6seNmgkVUlxYR58LudpYbVIBqCte3wKNeYNfvvSM21iFUZC/UavCOZJGIC+vSAaebgkUtIsYI9Uv4BlPUnUuveXfcktkEDCrrHFIkdWaVWdRrBviP0Wt3CZW32VM6H/ZkN15E9+VGBkqnlsizJhUDP9QBCNCNWzGKps2KrxhQvN4RRmSVage1VggFmMci/zLaY/bP54mIzPgsKjmT83iL7xZ0ZjYWBuQTKUgktrtcrxn7pAT2sqIyknYSKfzp9enulMB7/fLM9Tzan68zgQFssmojzc5c9TbiwvddyudVIwgGpIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DS4PPF9E4E1C227.namprd11.prod.outlook.com (2603:10b6:f:fc02::3e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 13:21:54 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 13:21:53 +0000
Message-ID: <6d8f5c9d-c014-4763-bff0-215b43656b9d@intel.com>
Date: Tue, 10 Feb 2026 14:21:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/35] net/intel: support configurable VLAN tag
 insertion on Tx
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-15-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260209164538.1428499-15-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0073.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::11) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DS4PPF9E4E1C227:EE_
X-MS-Office365-Filtering-Correlation-Id: 051bdfe2-2c2c-4b93-d673-08de68a75b4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R1BmSHhRMFF2TUJhRGhzUzEvRzVlMjlVOXZoaDBXZGVkblVTK3hIazNjWjdz?=
 =?utf-8?B?TnNJNHMxazlUQXpQMkZaZkEzU3VUNzFsbVhndnNpODFVend2NEVYWVVEMis4?=
 =?utf-8?B?WEtIcEFFV212UFVvOHJsUDc0ZHY4c0owV1FLek1PMEIzWi9VdzVDSWpJQTIy?=
 =?utf-8?B?dmlTb2hhK3lBL3gvTTYzZ2VaZDArS29hbmdqRHpIQlFWaTNvYWZPNlVZbHkr?=
 =?utf-8?B?WVJrWkdFNDN4eVdxaE1aYW54UVB1ZWxMK3B0TEtYNGpJTXZlUkl3dDJzSjh3?=
 =?utf-8?B?Z1FwMG85c0VDSUpTSEE3OEE3NVFoL09iMmpMT1pDS1JjSGg2cDlremdlVWdw?=
 =?utf-8?B?bnJCSWpuU2RjbklCNGo4MmZTY2t4UTVNRTlVdlNmOHF1aDROZHBqbmxROEUz?=
 =?utf-8?B?VGJKelNuTUNNYWU2UzBaWVhiRytkeWEyVTdiZGhNT2FpT3BXQkRtUi9DeXZi?=
 =?utf-8?B?YVFsR1YwWSsrWWhOdWllV1E5bEY3MFl1QUwxeG1qL0NNR2wwR1M3Y20zVFd1?=
 =?utf-8?B?ZG11NkE0UmxkYkxMNVUyckdXU0crODJ5NWlSWEltUjhTTjBlUGkxaFliemZq?=
 =?utf-8?B?UEo4TzZ1Ryt1NGNHYlNEWWlBb2RQMmVudnNreC8rSlpnZFlDalRnQktTWStz?=
 =?utf-8?B?T2JSY0xLSVNNdi9rRHlxZXFteWtQNlFHUzM0NlBLQVcxQnZLNlZDMVRxcWp3?=
 =?utf-8?B?NVhQc2Z2Ni9HYkhEODJZVGcvQ3BIOHVIYVdVOUZlWVpEd0ZFNjQyVWZ3cm8y?=
 =?utf-8?B?WFNSTkNQd2E4d1NpZUVaY3hMaVRIQldvWm4veDU3dk4vQ2JGWFpuMEloVFpa?=
 =?utf-8?B?R0pHbytqOHVXZTRJUjc0VzFQSHhiQzFpS0htZkJ0TUg4aTBFV2JzeXFySTBC?=
 =?utf-8?B?N2RmRWhLM0JYbXhHSEF1T3k1UU1kdzVQVWRrbjFJSHJ5bUJzU0hEZzYvUk5M?=
 =?utf-8?B?OVF1aVAzRUtDUHhoSVNEOTNIQjVjVEMxWDhrTnFHeGw0UkpXN1NZZDZ5R3lE?=
 =?utf-8?B?dlE5elhNb0IxdExwbWYxNmdOK3hyYStZb3oycWVsaVBJWUIvcGtGeHhWMDM0?=
 =?utf-8?B?SEN0ZGx5YmRxeks4bHE0UVFURTVrU000ZnRrLytnK3dqQTJ1cG1Gckt4ZGhM?=
 =?utf-8?B?Z05lSmx5SzBPN0xHTVR4bi9KcFdmNTk1K3V2WkJTdXcxamhzZTVFOGtOWXpm?=
 =?utf-8?B?MGRQelFJN1llVHZRUTNTUVp4UHM3Q2tsTG5qODB5Wk8vRXJVYUhrRmQ1Y3kx?=
 =?utf-8?B?Y1VOODV2Y0hqM3I0ZXUwNm16K3ZTbEdVcjc2UWV1UzI4QXFnRExLTU4wOUJT?=
 =?utf-8?B?SnMyTldiVVNESGdoVjZuN2liTzB3bzJZUXFrYm5abzZ1ZEJCc2JwNmQzTGkx?=
 =?utf-8?B?aWRPRldKbW9JTFVpU2kvNFUwdUgwK3JzL0x3bzRUZk9NNmRrVTNDeWpKSVBS?=
 =?utf-8?B?OWs1eVRyamU1aVB5WWl0Z2NYWnMwYjU4QjlHWUdiRk5qSVdndjFLU1YrTmxX?=
 =?utf-8?B?OU9HeE5yNVVTSFVpZ29XcWVsVGxGOHFRSVpEcitDMUhpQStVOUZwQ0lSS1lB?=
 =?utf-8?B?SElZc3RNM21BWjVSSFNnRVJmMTRXMzlnbnlUOUNNSGczNWlWb3Z0cGszTlQy?=
 =?utf-8?B?R0dhOUp0SkUwNlZNOEE3TXA5ZWRPOU0rS2tiMm5COTUxWXJYMXNpT0Z6OHBR?=
 =?utf-8?B?c3FHa0tyZ0EzeEtBaVNOeUd2dzdUdk14SUNZQ1RmMnMralk5YVZtTUxkM20z?=
 =?utf-8?B?dUV5WEpodXhRems4NHdqaldWR24zQUZLdnFBSnR6N1NtZjE4K1ordjJKU0Y2?=
 =?utf-8?B?VkErbzI2RHFVZUQ1djFldzcxQzZsOTVQU2VoWjVtVWFFRncwRUkwM1BPYUxj?=
 =?utf-8?B?NUwxaTU4dDN5Q2FsSW9tcm1WTVNWaHFmWWZEcGZOalJqbXJQcTdHRFZEdGg5?=
 =?utf-8?B?T05BQkJobkpNalN0Sk1leDREVDdHYzRzcTB0MEZKb2NnS2drOEZhcWJWclZi?=
 =?utf-8?B?SXB2RUxFZTIvYXFTWDBZRzFrMXYrL1pzd2E3elg2akZNcW9Rb1BKS01mVGE0?=
 =?utf-8?B?amhrTnhSbFVpSSt2UWF4Ujl2a1pwOE8zdU51ZkFmN1FPRCttV2VFWUw3NUI3?=
 =?utf-8?Q?U41M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0NiVnJ6dzJ1OG4rZjNybW4yNnRSLzlrdjZUSkt1WFpaWCsxNFpsTHh3SmRS?=
 =?utf-8?B?cXF2RVE3WmsrZDJQZXJqU2xwWGxKeXdpWjBneHAvT29lU2N0Tm04WElEekRG?=
 =?utf-8?B?dFp5Q3pCR3R6Z0RYanhpR2tON0Vxb2pxeFVCblJpS0xZek9LamlIODl6OWlX?=
 =?utf-8?B?Nnl5Y1NramszQ0dWejRLanl2a3NQN0I3RTg5cGhQd1piLzNmK3QvaUhwaG9C?=
 =?utf-8?B?b3Q4MWhINHdOdzBITzB5UXR4VHVWcEhzWGoyNDQ1d2VYclBBWnR4RlZvdm1t?=
 =?utf-8?B?VURNMGc1cGZXWXBRVWVlLzNMaUFvcTFLUENEQTNjZVJ3cXpGZTM2RnFTTXUx?=
 =?utf-8?B?a0NTdXluNHpmQ0ZzVGVNT3ZxRXdiaW8xMTNFQnlOcXdGRDByU2dFV1BCWU9o?=
 =?utf-8?B?dnNiN3ZMZnpRd2U5cGVra200VUdPelVmd2xldVJvSklLMjlkbFdRTTJpZ2s3?=
 =?utf-8?B?QmxMaGVXN1JMc2VjdVNHZDZ0ZVlncmVyU3JLOXNFdUFsMGZlTGdqaE9rRFls?=
 =?utf-8?B?elREbU4yWU9rNVJGSmxHNS9xT2hLdWZVcGNIRE5UUzg1K1RMUEYwOFIzZCtS?=
 =?utf-8?B?VGU4MkpBcjhDZ3o5WGhLMy85REgra21WK1lTUVM3cXlraGRYb3RQcTBXOS9p?=
 =?utf-8?B?TjN3bkUyQXBoVmZRNUE4QXQ1QkxpZG4yVCtrOUFSRlI3Smc3M0xrRnorTkFY?=
 =?utf-8?B?bmpTOS84L2hsVFZ0Y3lGWElIU3JLQmVvNC85YUhKK0pieTBQTUJ2OHJBSjFC?=
 =?utf-8?B?Zmo2VEttZTVQWURLWEIwTE5YU1R5T3U2bXBJSTkzSzUwbUhDcjhNRmdMTkE0?=
 =?utf-8?B?SDhmYTZteHpUSVE5bmg1SVI2amtCWWMwdEdqWjZoOEtOeWRHdXR1OVJJVEFJ?=
 =?utf-8?B?OG1aQklVYmE4aXhxUDRnK3FxSXR6ZldKaFpvZExoVWp3akdNZk56ckpMalpB?=
 =?utf-8?B?QlZuMTJnT2MwZ1JJQWF2RlhmWDFoNm1NY0paTlk5aVFwSHM3ZzhpQm5MYkY3?=
 =?utf-8?B?eXJZZWZNVGw4YWNiNVRyZlFPRkNZWmlFWENtaE05bTFXUk1sNzA1T1VrSWk0?=
 =?utf-8?B?M3lNV3J4RWQxWEhxdERtcENoYWNFSXhUU2o2cXQ1NndBSlVxVW5nTDN1MCtH?=
 =?utf-8?B?UUdjMkc2WkdxTWlacDZMRkZ0Y3g3cWJxYTZsRlJIOCtWZ2liNHk5T1pQOVRY?=
 =?utf-8?B?djE2TGVVN00xN1VNaS9ydUdyWVYwWk5DUXcxZEJEbXIxcitTaURSY25YQmdo?=
 =?utf-8?B?Q1c5TU1pNG5GQmlrUVJ0SlJpalg2UGtUSG00QllEd3dPRWV5WXFneDJRbTht?=
 =?utf-8?B?MURkb2FUQ3RzS2Y0RmRLeWdUR3FFVGxKb1hmWGh2ODZMVFpESTNvV3liZFpt?=
 =?utf-8?B?Tm01Z3U1eGQrSUd0aklxTFlBNDlKSDR1eThVTnJtckd4VFl2Y2l5SjRLNHRk?=
 =?utf-8?B?OElzaXVZUGV1clVZZnNseFViTHRxbXZmMU1IRVppa2hZU3lPT3haMC9qSVNV?=
 =?utf-8?B?UjZqTGlOVC9uUDY5M2xBVEJlVk5IcUkxUEdSb29DQ2h1bTBMQ1FrVTB1azlW?=
 =?utf-8?B?bEROOUVKNHVpUmVtVURGbmxTRXNOT2s0UzZ4UFhZcWtZTW1kZGpHekQ1dll3?=
 =?utf-8?B?STBOeWNkd3crU3JYM3pOQytxSzUzSG9LRzRMWUFLUnVxVVlxdUdmR0FjQ3hV?=
 =?utf-8?B?Z1lwM2lpMXVBZkZROXlhZ0Z5KzJqT2paN2YxWEd0SFc2bURVbm5RTmhmaGNt?=
 =?utf-8?B?Mjg3MW5Uc1poVjFuSDVaaEV4cER5YVZxR2xmUGxNZ2V5SjZ1NjRPa3l3cFlH?=
 =?utf-8?B?aHVublFGcjJpdXdyQUxoWDVsVHZPT1J0amh6SDl4RUhjdEpzTWx5ejB3NTFq?=
 =?utf-8?B?SjJ3RGFpeWN1ZDROcERDRFVGQTVLYzJZdjZGdTE2NFNUTVY4V3o2Qk5hdVgr?=
 =?utf-8?B?QS9Ld2RrM3lySEt4NXRlTDlDZjN4VEg5VUxnWm1nK0NaTGhuVEQzdC9PeGVZ?=
 =?utf-8?B?UlVEbVJEOVNaVmU5d2xLUU5PbFFtZG1zbWo3SExFSzJBWlhYM0E2SG1adXg5?=
 =?utf-8?B?eUVweWRRRGVndVBGUk5Vd25HNEQxSGZiNTZRbi9ZNmt5em40bE8xbXBWaE9r?=
 =?utf-8?B?UEVjaGNLK0RxUWpFMEltNkxDRndncHE1a2sxaFFIRUI2UENldktXSHVaNWhr?=
 =?utf-8?B?UEJvdmt3QW5Lc2VyMm1LUHpnRStiZTV0c1ZHZ0NHSm9wU2VxL0c5YTdxRnUy?=
 =?utf-8?B?Q3VralNuaDlLVFRNWWE1azUwcTdPc3VrL2phUS9DdzdwYzh3N3Z3bHl4UnFH?=
 =?utf-8?B?RDROK2g4WnNtYmlldGhOSlJTTlAxMkJFWmMwcC9pYVl6WndEREdzVlNOL2JS?=
 =?utf-8?Q?hvdirKwoZWm+edeU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 051bdfe2-2c2c-4b93-d673-08de68a75b4b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 13:21:53.7175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4v9PxrENO/SeMVcpWPOoPzgBSaCkcNtkYHGKT+jFmBhYIB5dvgcDmFCc6/1JkQI4NAdQO3v7Oz0prePdsGT/z+FEaATeC88y2SFyto6N+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF9E4E1C227
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
> Make the VLAN tag insertion logic configurable in the common code, as to
> where inner/outer tags get placed.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Hi Bruce,
I might be missing something obvious, but...

>   
> -		/* Descriptor based VLAN insertion */
> -		if (ol_flags & (RTE_MBUF_F_TX_VLAN | RTE_MBUF_F_TX_QINQ)) {
> +		/* Descriptor based VLAN/QinQ insertion */
> +		/* for single vlan offload, only insert in data desc with VLAN_IN_L2TAG1 is set
> +		 * for qinq offload, we always put inner tag in L2Tag1
> +		 */
> +		if (((ol_flags & RTE_MBUF_F_TX_VLAN) && l2tag1_field == CI_VLAN_IN_L2TAG1) ||
> +				(ol_flags & RTE_MBUF_F_TX_QINQ)) {
>   			td_cmd |= CI_TX_DESC_CMD_IL2TAG1;
>   			td_tag = tx_pkt->vlan_tci;
>   		}

I can see that we insert VLAN tag on TX_VLAN and VLAN_IN_TAG1. But then...


> @@ -1004,8 +1004,7 @@ get_context_desc(uint64_t ol_flags, const struct rte_mbuf *tx_pkt,
>   	/* TX context descriptor based double VLAN insert */
>   	if (ol_flags & RTE_MBUF_F_TX_QINQ) {
>   		cd_l2tag2 = tx_pkt->vlan_tci_outer;
> -		cd_type_cmd_tso_mss |=
> -				((uint64_t)I40E_TX_CTX_DESC_IL2TAG2 << I40E_TXD_CTX_QW1_CMD_SHIFT);
> +		cd_type_cmd_tso_mss |= (I40E_TX_CTX_DESC_IL2TAG2 << I40E_TXD_CTX_QW1_CMD_SHIFT);

this logic is only triggered for QinQ. Meaning, there's nowhere we 
insert VLAN tag on TX_VLAN and VLAN_IN_TAG2?

-- 
Thanks,
Anatoly
