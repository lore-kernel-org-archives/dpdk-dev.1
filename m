Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3D5CCD199
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 16:40:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DDD6E4281D;
	Fri, 17 Oct 2025 18:40:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 28951400D7
 for <dev@dpdk.org>; Fri, 17 Oct 2025 18:40:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760719251; x=1792255251;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=R9RuTIi7l0WhsN6I0TMWnUeua2VxsI1SstTO0cSPYN8=;
 b=mU97KQwQYqTfmRYVbhfW2BdQjG/EP3I0GY+DIEyxr2olT8JMfLghwl6G
 kbxIqVX3DDDFEi2bXUCySzT6Wgr+436Noc7+OeZYF6F/5uxc2yopuE/Yp
 J9OAzccDLoUHr/x5Nvm6TSQLN48iMzmPIMEBk/9vkDkZD8pQ4URtsPoCE
 IPr6nugj1uU91PL+M9q1ZN08Vpc6Sh+MjYgpGzYgqJHOD0t+l3u1XCG04
 duC2tqmZVfGjX+QTGh5smy+rIB72vvlQnGNWsEOu7CWuZDASoe0x48FC9
 rnosFq6RaRP8zPl0eEwZEFgYuuhUPSnQlMUuT7a0jJ39kzeP2CCuOyfdo Q==;
X-CSE-ConnectionGUID: wiTiOniAQNuZlZLbAsPh3Q==
X-CSE-MsgGUID: MaKJ7QPkRJSoCwqWpnIKFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="73536883"
X-IronPort-AV: E=Sophos;i="6.19,237,1754982000"; d="scan'208";a="73536883"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2025 09:40:50 -0700
X-CSE-ConnectionGUID: K5dqaiK7QtOKjGJLQNYojw==
X-CSE-MsgGUID: G+AH+7sERlq1s5Fz/3NDXg==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2025 09:40:50 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 17 Oct 2025 09:40:50 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 17 Oct 2025 09:40:49 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.8) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 17 Oct 2025 09:40:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtAtJC1nxs4XYwNj9u5fn6RLs6TIFt2a5r/qT1QH5DdmIKTuRfrrPDmgoTHYDmrM3HrmeG9FNpz9E4/0f7M/j+9dwCPMsRlU79rT4LOAbO9qUTpwXjfsNRqs4ICLO+lu733mSvFE/qOr8rsVSnb4EneJ9mG9jB52KOnwlqP2ewTiKkuS+GjENEhFj44n8oX7IhHhbEhVhWmXXGrmvrjVlZ5IDAKLPYxVqGV5+TYkbL2Bk7Tg1Qgm5GqyGpHWGAUNt89y8kXKkxyEMXTiQjW382XGDDbPu1wBawOwMHb3rx57WTaQbduqI0ICtd4wlcZ+84C2K/W+iNkRbNHvKgYHwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLurUyXIrnR/tiw1YbeXjRNBkZ5wUJuWZQr2B5ewVAk=;
 b=IlpkCGQxl0NYqZLA0K0SDplkufMGZ2b8SBRDBzOcCUpvlWpRyZ4WlGehH7hyAOMYDRSEAcNM1T7PIjjT4j6gD2uwjG9iuWvTFurND2TdQRilMbqNpuXfFz/Ixkwpua0Wy9TyE255Mmb8rAurwlyTlw343khJnWR3LfS4xVOPZDcFtZlR/cvxIGCCSqmCLJl8YPooFzL7+D5pdJF9CMk9BpiddMDU708ekPfYwDy7J5jGM3n8yPjK9NDFsF9asdrTUtZF1fJLePW6M0B9QHbnb/8BCQKmkBP40R4vNJq/rXw3YpizoixzSegpjgKAnMA0iAKqEULHONIVvJCIyA+t5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB4933.namprd11.prod.outlook.com (2603:10b6:510:33::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 16:40:42 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 16:40:41 +0000
Date: Fri, 17 Oct 2025 17:40:35 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
CC: <david.hunt@intel.com>, <honnappa.nagarahalli@arm.com>,
 <anatoly.burakov@intel.com>, <jerinj@marvell.com>, <radu.nicolau@intel.com>,
 <gakhil@marvell.com>, <cristian.dumitrescu@intel.com>,
 <ferruh.yigit@amd.com>, <konstantin.ananyev@huawei.com>, <dev@dpdk.org>
Subject: Re: [PATCH] test/ring_perf: add optional cross L3 core selection
Message-ID: <aPJxg1EpxkkcV83f@bricha3-mobl1.ger.corp.intel.com>
References: <20251017163407.845502-1-sivaprasad.tummala@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251017163407.845502-1-sivaprasad.tummala@amd.com>
X-ClientProxiedBy: DUZPR01CA0026.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB4933:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ef5c00b-4c92-4144-c96f-08de0d9be8bf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q25ZQWFIYURwRmNqcDIyVzhSS3pBVDc2N3YrNmlmeDdDM0hyc09FdHQvQXgw?=
 =?utf-8?B?elBnNGpidzA3Mmk0UUJqd3ZBUkpZdS9zZ21PTy8zOFM4WHpaWTB6ZHYvM3Bj?=
 =?utf-8?B?KzE0Q1VoZ043a3NyRHN6Ly9hdnlsdjNPUTAycWZ4L1dDS0ppZlJrTS8wbm1B?=
 =?utf-8?B?NVRkNW4zT3I4ZHV5WmF4cE1HRm82YkE4eGpFN0JaM0RFQW0wWklBOUFtUmFi?=
 =?utf-8?B?VDRkUVplSDBORFl4ZU83MWEzbFJDSUtXaGVDakdxRm5uNitxSFJhSW1SbDUw?=
 =?utf-8?B?Q2NFYlNnbk92ZDNZVlBmbjBWTDNROXlnTWVnL2pFbzE4SjdKSnRQZDNzRHp0?=
 =?utf-8?B?WWJZa3NLOHorM0tvQjQ3dE1LVmMyempyUUFhMDQvRklPSWxQVTZZUkNyTCtM?=
 =?utf-8?B?b0pwUXhiWDBNY3VNcyttTWh4elBEVWJRWms1Y09oZVQrRjB5Q2dOODR2Rnlq?=
 =?utf-8?B?WEdKV09xeVYyM1FqMm9PbDNodFFrU1RWZ2IwczloVWJOSGVjV3hVYzk1VjY5?=
 =?utf-8?B?MmhnV0h4eWJnUjJKWTdScUhuVVhTM1JBM1VXcm4zMkFlZ0xIM2VlWFpmSFJo?=
 =?utf-8?B?dC8xeFZlemtKVWsxYklmaGduOEJrOGdZL2F5UFN3bG5EY3U2aHRSLzJIVnFR?=
 =?utf-8?B?TW1maGl0aHR3cU9ZRVRuWk9HbDl2K3F1akYrZ3BhTXhaYWtWaS9HT2tkbzBT?=
 =?utf-8?B?MXBZNmJ4LzMyQmRxUTNyMiticVJkN2NMMldYR3gvLzdPMUMwMXdkei9CeHZV?=
 =?utf-8?B?UGM0MFdweFA1bXUvT3VGRFpMNEJUdFZVWTI3MU9jMWx2L1VnRXJIRzU5UXBO?=
 =?utf-8?B?MjBGTW9McVdtVkZzMTNDMUplSFZhUXpUdCtYNVpTRjZSaVd6eWVpR241NCtT?=
 =?utf-8?B?MnVtVllDNXVkV1V0WnUwUy9FMXp4Qy9JSDhLZmt3UVIvdzFvcUVUb2RNckI4?=
 =?utf-8?B?dkJ1ZzE3Wm1Jb29va2hMcFVieXIwK1VrZUZHRXNESlRGRFAzZk9GYlNjSDZ1?=
 =?utf-8?B?VktCUFNlZ3NmT1RvY1FubFduSDVnNnNTRUppbDFJNDJ6dnRSTmtUT1pRVmxz?=
 =?utf-8?B?TktSQTJock8rcmtScXFyOG9QRU1jQW04ZmxoNS9wSmwrYUQ4c2NTTXpJRjJs?=
 =?utf-8?B?bndSNEs0bEwvR2tXNDRxaEhPcUxaTjFBZllBMm8vUTJJSE5janFVcE4xblpu?=
 =?utf-8?B?NkFIdGtjVnYzTEpuMHUxVjNyN09jK1hUbWxuWlJHMS8wTkFKakJ2UHpVZk5T?=
 =?utf-8?B?WVhiRThiVm55UWw3UHM3akd4Wk5ITTk4c0hYbDBzOXBMcjQ4VUpuMksvVzg5?=
 =?utf-8?B?bS9JS2RialBCTTRCc0dvblJnR3N2N21CMlR5NkxOanZ0ZWloMnpxQitJcDIy?=
 =?utf-8?B?UUhpUGRZVWlCbmt2OGVmMTBzd3lZRkp3SUZpZ1ZxSGJBaFE3TkFya3plYzlS?=
 =?utf-8?B?MmcwMWxkbUJlaTl2SXpmMWZXYzAyMld0RU1sZVRNTHYxSWZOeEFPZUNKL281?=
 =?utf-8?B?Z28zSHFvNmYwcForcm0xanYvbmJvSkVFMkdsMVZxTDcxN1p0QTllUFpTZ3FF?=
 =?utf-8?B?bEhPZlFkcElUZXNDb2tLbGtmeEZXcWJBYmZsSDZPaDBSUmRzR0ZKdWpaZzli?=
 =?utf-8?B?emc0bmszZ05rL0hhMkRXUEt2aGpEakZFd2J6TFpsL24vWDJrSUhNMkJLaHFX?=
 =?utf-8?B?b2theWFOOFNEazdxSEtNcDhnRXZYUXBqTXI3VXB2MWgrRHVtZUJ5STlGbU9z?=
 =?utf-8?B?dDJ5R0ZxMk85ZHQ0OXJYdEVnM1duckVjM0c3My9CNGFUY0haS1A4b2RRd2dN?=
 =?utf-8?B?am43OGsxYmpZSFFMakdqTnhTNnJ5SVpjcnU4TEh6TGpMczNwQXlWNjJxQUd1?=
 =?utf-8?B?dkJMbzdkT1lHSzNEbGlWZU96MllVdnlEQ1k2bElJYXlpUE9wRnhZamxqclF3?=
 =?utf-8?Q?kM4mueX0WFlsPz9BvfFlKw03vuUml7YT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW1sQU9FUUk5d1VlbHBJOEsyOHY4WXJ2SHBrVSs1bVZjM0REWGljL3pMbnhu?=
 =?utf-8?B?bWlOM2VReHpFZFEyb3ZGSzJibTJwQWpDQXlxMDBJbE9sUnV4UnY2ekNuM3E0?=
 =?utf-8?B?UUltK3BSVnhDdmpZc01tZVNPUjJCN01xTVJyaWhVNFNKcTh0dG4zR2dMSm1Z?=
 =?utf-8?B?cGRqV0J3R2dVa0JKMXhiejJUb3VYaGR4OFI5RmJPZ1NtTE9NVHBSbjR0c29s?=
 =?utf-8?B?Q1BRMnQyR3NFMUUxdWVScWpGTG1mSXpYa0RqRVZNcDArRWFUMWExaVd3R3dx?=
 =?utf-8?B?Ynp0a09wQW1RQWd3WGxsZWFuZ2RqcXBxVE1jWkhJZlRpOGRyYTJpcjFkMXB0?=
 =?utf-8?B?Tk42eExEUGRvZGs2SUxNZUZ1RFowKzdUR0t6RThRTUZaa2RxamlGKyt4VWZu?=
 =?utf-8?B?aDREVUxLN1h5MHdFcmxIUTlQR2ZyU0owYlJZNVk3czIwNWxWUmllV2Q0Qkhp?=
 =?utf-8?B?WWU1MzQzSDJYUTEwbWNOL2d0SS9kU2NrSkMzRWVPeWJzN0x1eXhNb2NvcTJv?=
 =?utf-8?B?NlNWREE4TGtyYkVwVmpremo3eFI5Sm9mMHpIQVBQckxHVk14UzNHQUNFa1lI?=
 =?utf-8?B?b1pkUXFQU2NGWkEvOWJhUmx6QnBLWS85N1RJcG90cllIbk11dmFoS3R5RWJV?=
 =?utf-8?B?R1BzSzN6dDRRQ2JWZUFvQkRQL1FxTjRhWUVidVVFUDF5NUJORGpRbzdLeW1v?=
 =?utf-8?B?eDFyRGw2M0hISTN1eDB1eXhlanBsOTBmMC94dEtJeG1OR1MxVnhsK25FUUp1?=
 =?utf-8?B?ci9teURkdGg2R1k5Y0ZMR2hNYU9mV1RpTElITkZaRnJKR1NoZURZYnlBVnhu?=
 =?utf-8?B?NVRnZEtMSFdnMHMwcnVvME5DMU80UUp3d0NmQW05Q3laWkdYZWJ5akZIRkln?=
 =?utf-8?B?dnVSSm5RYURVV2ZybzREdlRCMnNsNWZEdy9BaFBjSjRmb1pERTQ5RG5jNTVw?=
 =?utf-8?B?TUk1Y292MWhqZGdGMyt1TDY5Vjh4Mkp2QksrbXNHSHFlQzJRV2NISk5VQzVs?=
 =?utf-8?B?T0srcXhMdkpPMlBSNmRUZXFCZ2FzeE5ITjJSdWpIWkk2NHBuOTl1d09vbnow?=
 =?utf-8?B?c0U5SUR0LzBLRFpvSTdvN3M5aFhxNXNFLzEzU2MxMk9OUnMxeFpyNWVWVElV?=
 =?utf-8?B?K0c0bllCVFdWdml1ZWNiVXRCU1JoNU45NDZLNkhyRlFRdkJRc2lUMU5EdkQv?=
 =?utf-8?B?UEN5aGRvZTIyYXRSYXFTOGlMRmt5L2RJQlFacHZUallTL2M1Zjg3RDBxODZw?=
 =?utf-8?B?a0dZanpjWCswamN0QS84US84UnJuT3JBcTBFd1ExY01RRFJpYkNyamdZQmFO?=
 =?utf-8?B?b0NqMjhKbmdLR3M4Wm9CdWlDM3JRK3Urc2NWbEI3em9nbnp0ZTZ6cDIyd1FU?=
 =?utf-8?B?dkxUSy9SSktuTUZXUnkwMnBjMVFGNkdyVTJlL1MrMWR5aWtLMzhybVIrWHpv?=
 =?utf-8?B?eDAxdkhjdWQ0VStCZVpKdGs4YjlpQmltTm02VU9nVVhBQzZUTTF4a3J3eGNR?=
 =?utf-8?B?R1FHOGh4Titwa3l2c09wNk1ydWRxN2NqdXFrT0lwTU93ekdaL3VlNUE5ZFYy?=
 =?utf-8?B?b09ONXY1eXpQUWwyMnVJcmd3ODRnUjBqU3BrL1YzZVl1T2NnUW9Fbk9wT0tE?=
 =?utf-8?B?N1RwQW0zTGo5Q1lzeWdka2NOeWZMQmx0RWQzdDByWWtmdmoyUzl2YWlMaGww?=
 =?utf-8?B?SUVYMXdzZmd4Uk43SE5hcE9zSHFtTjlOOVQyUTRsWTBETEcwRWt0NE5XcUg3?=
 =?utf-8?B?WEd3aWRPakhFNHdLVEpMZmVYRXo2TFc1WEFHRklPNlZBOXRESndxTFFFa01N?=
 =?utf-8?B?b0h3RTRxQkVnbHNtcnZPMzNtblY5bE5Rem1rb3pKUVEzaVUvZ1FIbDRwSGYz?=
 =?utf-8?B?NWlOcUZjTkdEcG9oa2xuMHhLaGNsdVpEc0o5aEZpRkNRWUVIYld0d2toZXd0?=
 =?utf-8?B?Q3YwaGhGa3RBNmJ5VngwR2hpMzBMVnhFdFhXUCswYTZNd0xvNFNST0VzcHRL?=
 =?utf-8?B?T21RNVpKVnhrd1FHRTVmZDlNNzAxYlBhRUkxNEtGWlhESXE4a2p6TUY1RGoz?=
 =?utf-8?B?MmNoclM2M2RWKys3ZHlwRE5SUXZHOVNhSU4xa2xoK3V5SnFyaWkyUk0zdjVK?=
 =?utf-8?B?Q3JPc09oVXYwcUF0VXBxTjZlUCtyUlFwUU5wdDJ6Sm9QeExjcHBWWmxLd1Jz?=
 =?utf-8?B?cmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef5c00b-4c92-4144-c96f-08de0d9be8bf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 16:40:41.3145 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cH9/Pm0GGoL0aJ64iK0jmzTKJ2EMl1a/ApEi/B59VVvKin2klgxZL+x6FdwfOJoYv3hOuYfn0yBA4CkC94y69yb0VI97K7Ddran7PDlWshQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4933
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

On Fri, Oct 17, 2025 at 04:34:04PM +0000, Sivaprasad Tummala wrote:
> Enhances test_ring_perf to optionally select two cores on
> the same socket but on different L3 caches using hwloc.
> 
> This allows performance characterization of ring library
> on processors with split L3 cache architectures, providing
> more realistic measurements of inter-core communication
> and cache effects.
> 
> The feature is conditional on hwloc being present, ensuring
> builds succeed on systems without hwloc.
> 
> Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
> ---
>  app/test/test_ring_perf.c | 75 +++++++++++++++++++++++++++++++++++++++
>  config/meson.build        |  8 +++++
>  2 files changed, 83 insertions(+)
> 
> diff --git a/app/test/test_ring_perf.c b/app/test/test_ring_perf.c

<snip>

> diff --git a/config/meson.build b/config/meson.build
> index b8c1f127a2..75630254f2 100644
> --- a/config/meson.build
> +++ b/config/meson.build
> @@ -313,6 +313,14 @@ else
>      add_project_arguments('-include', 'rte_config.h', language: 'c')
>  endif
>  
> +hwloc_dep = dependency('hwloc', required : false)
> +if hwloc_dep.found()
> +  add_project_arguments('-DHAVE_HWLOC=1', language : 'c')
> +  add_project_link_arguments('-lhwloc', language: 'c')
> +  dpdk_extra_ldflags += '-lhwloc'
> +  message('hwloc found — enabling L3 cache–aware topology support')
> +endif
> +

Hi,

I think this is the wrong place to put this. This will make the whole DPDK
build depend on hwloc and add it to the pkg-config file.

Instead, it's only the unit test binary that actually has the dependency,
based on this patch, so just add the dep there, and add it to the cflags
for that component only.

/Bruce
