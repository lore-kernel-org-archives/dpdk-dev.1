Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2684DC35FFA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 16:54:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2FC84402C4;
	Wed, 19 Mar 2025 17:54:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 1E75E4026B;
 Wed, 19 Mar 2025 17:54:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742403296; x=1773939296;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=isAS9wqEkHAuy7V4WGLf01u/F3V9EAq8euVofTFOoUA=;
 b=fwu2wV9T3qINbv6UJGGa2rDtFZYstT/QUq62Y2TkqKZ1FX5AGCObnQ1a
 xs2vQ4JzVdsin8LluNxLAX00FjLBVOlVTecBj0e/uDcdOo7HLPUtCLSKS
 2AP+xxjSwCVIXvJIH6jHS35ImRSYrVaqh/skZP1gA9e0NsdZhmYQX8Nzk
 zYLSFQe9FAIql+PwTvd7QwSExvY9imxn2fu8EwybxmZJ9jXsQYQJY2jd7
 l5x4Rh3IwjI+5es72SkNz0akan+e6GqVZ9T3gn6njznZ8MRJHmhdmUUSO
 qwv+3L+kpkLCgD2miqyMxFF1rxKR2RQGrEo9TGEgOmea5Rifq8lBh4kpA w==;
X-CSE-ConnectionGUID: ZAFqbrjcRLKAAjHPy/qbgQ==
X-CSE-MsgGUID: ArR03mKWRY+r9kfPSsbb0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="47256939"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; d="scan'208";a="47256939"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2025 09:54:55 -0700
X-CSE-ConnectionGUID: KSWN4TdIR96lFbcLBtubpg==
X-CSE-MsgGUID: sTI9T9HPTjCURlviQh/DlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; d="scan'208";a="153560289"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2025 09:54:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Mar 2025 09:54:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Mar 2025 09:54:53 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Mar 2025 09:54:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTWzJL9WB+Q07DuiEOPL6YbGJRI5Kbc0s1LNWiGRnQ2FLYoIu9gd7vsLtr9lzR9HvTYmoInZBH13xnRA/ntqfsJF43gqa+rMdAOZ4WiQd/5F5h21KzBSfHYMV/V3EyZh/8fifuBektYQrPFGFdxXRTY7adMXt5Gi0JD6uD2HLiHBBvByM6OPEVz1Jw3xubE3n9lCMru5WGzpF7kPUVuNnVKqT0Rt9Ljy4QvWnFQfaeTW0aoNo7T54yT8/6FDvcjOeQa/HSZqtQL6P1+NZSpTH8rZb+7EZBUlr5KxxdwBb6hNV+f6ZqAYxzkURNWdpYlvtVhHzIskFt6Lf/2in8MQYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KONwocPr2eU1JrYD8bGt4FYEJwhFrAdNGsy6CIGL5GA=;
 b=kECw6t3d5yhew/lfC/Q97hD+p7hliuaqIULqorhtiJj08oGW8nDaCHyQqAcRC3EnkAbAYWrqfdmXUkEjjiDCIVcsf6rm1mcbHfhLQnMUEwXt1MFbInxVh9SWiHcqYeMI3LIqSAKHREXVVsMEusclEMF3nXdNT4oX2nXVx+DmV8ljxhCzSMfbUwy4sb+R/1Q9k5evdy6kYP9auXWSr/RLvOGmmVvQ5vKPloishZTSMayv9SC0E4gN5eFiT2xH4CNuPVA5RNMkJx+vnZY2ojGsny2sTY8QUtEpFTmmkc/xW/y3BFT2jJCFUsqWMQG7HqSqv+fTvH1fpyqVZZSomoOrsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by SA1PR11MB7697.namprd11.prod.outlook.com (2603:10b6:806:33a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 16:54:37 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%7]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 16:54:37 +0000
Date: Wed, 19 Mar 2025 16:54:31 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>,
 <stable@dpdk.org>
Subject: Re: [PATCH v2] eal: fix undetected NUMA nodes
Message-ID: <Z9r2xwbFB2S2200Q@bricha3-mobl1.ger.corp.intel.com>
References: <20250305134720.907347-1-bruce.richardson@intel.com>
 <20250305162458.1059282-1-bruce.richardson@intel.com>
 <CAJFAV8xA-HK63XxSEYNZBTeghOUgtEEKTe=iBE4syCF_vsoKxQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8xA-HK63XxSEYNZBTeghOUgtEEKTe=iBE4syCF_vsoKxQ@mail.gmail.com>
X-ClientProxiedBy: DB9PR01CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::21) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|SA1PR11MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: 368f9f90-6953-4e6f-53df-08dd6706bb7d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y01IbGZvbVU1WDN1eVBOZmlScVUxQ0RXcWtsSkwvbDU1OEVvNjNxWXljVWZC?=
 =?utf-8?B?UnhkaWJCUzFJN0lva3RMeVFQaTJScDRiSkNFQitpS1NObktsODRzVjFSeHJn?=
 =?utf-8?B?MEV6RW1Sekh1L2UwZUtUL0xCMVJLSXRmT3NSU3dpZmlGMStyRFRIYmdIeW5L?=
 =?utf-8?B?YVhXSTlUOXM4ZHBBbE1KVzlDZVQ3L2xiWFIzVjY3dHJ2eGgyeTBHZ01HTFRG?=
 =?utf-8?B?RkVDRm8zc1owWGFCQThEeWs3eUcxemZVSjhQN1Z2S2NpcHI2dys3RG1ieUVn?=
 =?utf-8?B?a05Ra2d1UWpkb1Z2am94T3JEUGxmVGNWUzhsaVJPbjEzU2JBNFRvQU1HSE1S?=
 =?utf-8?B?KzAxcnRRT3R3NStqaWtQT1dDamhOU3JISzc2OFMrOVJqd2Job2lPQWhZT3c4?=
 =?utf-8?B?MExVbkRoMDNWc21HTlJUSXJhNG1JWkt3NUlOTGx3bHBNaTA3Q0FwcEVhaXR6?=
 =?utf-8?B?VnRQbUhnZGlXckpHa3lWWEoyYm1ZRmYzVjhEallrcFlFL3BIN3REWEhWVXla?=
 =?utf-8?B?Y0d4TmdOQTdzOW9RbVNoNE9rVUh1b1kwVjB6OE1XbGlaMEpFNHhjcjd0M0Yx?=
 =?utf-8?B?R1dCaW1aaDV6MGp4S3p2VUhpeGtDSVpOcUxxZkRvcVdwOUI2dGRXUFhaakUz?=
 =?utf-8?B?UmFPZld5TFVRUVNBUHV6SkwwSmp6MVNTZENvaHhWY1pWSFpjY0l6Umc2Rzdh?=
 =?utf-8?B?NDNmSmlSREJndUVXNlJyY3daL2tsMCtLZnNNeHdYUkQzdlRaL2hRQWZEa3ps?=
 =?utf-8?B?R1VmMlZkU3NzcTB3NWZnWWhJWDBhVEZMd3FCL0ZQOXhuQXBkMEpQbTQvRnlR?=
 =?utf-8?B?eHlSbTJQVnpJK1VIU2hXY1RUbUprcE1mMUNtNmtOR2thMlV6cUQ5YTNaSkJZ?=
 =?utf-8?B?QjRUbSs0eWdqS3RoMStmUWhpanBpQUNMOE84bVVUL3dRV2kvUk9YSE1wZ3J3?=
 =?utf-8?B?ZXNNdVlHN09TcldQSFBRY09kZ1hXNmZiK2hiNm1IS2pwNVBqY0tMb2xpWktE?=
 =?utf-8?B?d0dEMjVReHZQMlAxeXlnT0g5ZHE4R1pSWWRZSXJVd05yK25ZZU1HbytuQjFz?=
 =?utf-8?B?dUd1MUJkRVgrQmllZ1ByemVpcjArZ0x4NDRSbG4vOUVYNzFNWUZLL1F4ZHJQ?=
 =?utf-8?B?UFB0T3ZuMkwzcTRXNDRqdUJrMVFrc0NaQzB3VjBrV3JoMEEyOVpaVk5ZT1d1?=
 =?utf-8?B?d2tGblY0QU1QV0lwMkVqZ1NjcGRuc0ZiMFpmU2FjU0FoaHVlVkF2d3k4V1Jy?=
 =?utf-8?B?WVdLdll6UjVPdGtUYkF0VEU1eUV6UlZYTk1ndytBRGpSUzZESUh1T2lYUVIy?=
 =?utf-8?B?YnFEeFlTVmNQeHZMcWlWdHVwOWEyQUpZOHdHa05QSkZHMTFwMStMRGNLR2gr?=
 =?utf-8?B?Ykk5S3ZaU3Z5dnlxeFJWMVc4Y2NpZUlicys1cGY5anZieHpxQVFhUzAyaVJT?=
 =?utf-8?B?OU9oR2llaXlGM1dWUms4UHphd3NsMlF4dlRQaVZJeFkrUDlOdU51a3l4N3cy?=
 =?utf-8?B?ZjgrYnBneUdQaFpGRk1yY2dLd3pveGZsU1djM21IZlVESURwRXZZMDkyRHZY?=
 =?utf-8?B?dVJDTkdFZEhSU0ZkRVVqS0R4SGNkRUdEODF1VjJBbkVKTlZWMVBYUTZzdkg2?=
 =?utf-8?B?QWdEbWkvQldXTzdZQTViZXZaYUJ3THdXSUJmQ05OQ2NuMHBnWVpDcTQrN0Jt?=
 =?utf-8?B?Q2txVGlEdjN4dmg0L1l3YU0xemhTRGFrTkMzVFovV2ZYWWg1eXJHSHF1QjBK?=
 =?utf-8?B?RkFpbCtNdVBOVUh6cHlwKzNnRnNyNEJLMEZkTG1mMmpRYkgrbU1IODBPSkM4?=
 =?utf-8?B?L3BPK2xwemwvUGxRMnFvNGhIckpnYWhYQkFDWDhwbFlTLzhzMXFObjh1cTdC?=
 =?utf-8?Q?rNzdLOZnUES4j?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVZZS2FKdDhpcmhYQmZrRWRuZnl1Qzg4NVBWQ3c2N3dNcmwyU2RFNW5JdEtk?=
 =?utf-8?B?QVduTjI4bVBvWENwU3lnbnRWRmRYQnhTdm13MnF3L1ZRVzNFTjRRS3pWczNx?=
 =?utf-8?B?ZTlRc21pWnhzMFkxdTVXaVJiSUFnSTEwZWwzLzRrZW9saHd0WU9kbno1YW8v?=
 =?utf-8?B?c1dSUWluSmdHVW9CWUFUQ0NBVHFqV1RHY045dDVJODVmQ0ZDajhzZWJKOTJF?=
 =?utf-8?B?VCt3ZjloU2JuQWZscjQxZVNuNXdoWmc4R2paNXJMcmV1K0NFaW9uemlRUmpX?=
 =?utf-8?B?SVNSdzB6QjJsYTArSzNRWHZhRXczb2JPeWk2OFQyaERvbmoxQVBlSFZlWnh5?=
 =?utf-8?B?bHRFRHlhRW9hSHZnK0NncFh3d3JadGhLUkNWZkwzUHJPTDBHeEsyTEFINFhx?=
 =?utf-8?B?UTZ4MytIRTVNMk95YnhHT2lXc01MZmoxTGNUcENTeXJQWnVJOHZQaXJ0dEt5?=
 =?utf-8?B?N3hXZ0NvWEZiaHZ6bWEwTDUxeUFwcUF3R2M3a3gwaXgvL1FieVhJL3FKbVdj?=
 =?utf-8?B?b0tEejJZejNIazl5YUNYSmZTMytrMG5jaldvV2VwWk5mUTVvME1tanh1QTBS?=
 =?utf-8?B?Q0pYL2tTNXU2R256SDlJTXJ3S3gxcExVbThtdTVxK3BGSG1KNjRYN0JPV0tD?=
 =?utf-8?B?Zm9LY0dYUG16eEZ3WW5kNkxWOEFrdmYvWTEyOU5lOC9ybnU4aitDVDA5Nk5h?=
 =?utf-8?B?eHU4ckxhY2M5QysxSUhHdHVIOFRUY283bmJYUFpSWkhKZngvbWFiSW0rNkhY?=
 =?utf-8?B?ZWhpMGRidmZOdHgzcHJvNWxHZXZDT0xNaTJhWnNsdzV5Q3dmaGJONU9oM0xj?=
 =?utf-8?B?V01UQUYrZzhMOHNaSkYxTUtzVEFqbzZIU3ZBbkJLSXhtbFUyQytUQVd3TVNB?=
 =?utf-8?B?MTVMbUorTHlKV3VBQm9CY25EUnpRbThtanhHMlZrb0MyNk5hM1hSZG9oYjAy?=
 =?utf-8?B?ZDh5dmFMazh5MnJ1U3BVNzZlSGxCU2VFK2pQM3JuRVZaVWliS0YwOE9nMi94?=
 =?utf-8?B?Y2Y0Tmdad1dLKy9KZklHUVlkbVI2cGFlK2xlVHlXWXNudkc2N3V5RUVnd2xV?=
 =?utf-8?B?S3NXd2N6aWhvNTVveHl2K28rUC9LV0V1KzRJZGJQSUVLVFZuYWt5ZklMWXFJ?=
 =?utf-8?B?QmtXODBQZXdSdDNENFNPeXgvVmFCZ0xOdDAvRTkzMGZGeTZUTnIzN3l0ckVP?=
 =?utf-8?B?S2tDNmVTSzZtb3ZJemlyS2w0eUs0UjBDRi8raTloUzJSZ2FKMDB5V3lPNVBj?=
 =?utf-8?B?YnpNUUdjQVBLODdReG9zUUU3ZU9uYXRKUFNJSStxVDExQ2dqYUZyVVFVaFRJ?=
 =?utf-8?B?SmhTOVg0Smh0cG84ZDlWNldjZklybkFGbTBkYzVCd2tyZUk2T215M3lLTnNO?=
 =?utf-8?B?QVVlczNKWVcyUmN4N1p5Zk5jQUJ3Y21yaTBxdU9Wc2lqS2ZRWWFOZzBGY2Na?=
 =?utf-8?B?YTMreWw0Vm8yYVFYNVUwa21tR1l4OWdOeDFmajBFQ0M1R1R6bDI2Z3F6K3ND?=
 =?utf-8?B?bnRoWVRWUGpGc2V1d21NRWpRS201ZVVOWTcwTnR6L1djU1MxckhZQ3VOQ3pz?=
 =?utf-8?B?ZnhnZXpzQ3p4cndwRmlia3NGbUpNV2lSUy9GTWVzN1lpaXV2UDA2ODBRaHVw?=
 =?utf-8?B?ZnVsMUJFR1o2TDF5VkZ2NDY4SXhBamxJTzlNSkpIckhnTmdyVnl3bjRmZFJW?=
 =?utf-8?B?ekYwOVNRYzFDbkZsWE5CVldERDZ0b29XdTN4NWRiTzZ3bnNuWmtnVG1WTGtY?=
 =?utf-8?B?VHVFT1NRVm1rR3ozY3laN29WWHBqNnRxSHJpL1dzYVZLSkJrTUJiY0RWTDQy?=
 =?utf-8?B?QlFxZHYzZDduZUgvTlBtWEMvSXhDbEN0U2VJSGZJeWZLTXphZDZhUWlvTnRD?=
 =?utf-8?B?dnNKUE9tSm54enJrcFRRS1l5ZWpIa2VQZGpnQzdQckFGaHVjNFVWSHI1WFFZ?=
 =?utf-8?B?YXloNkQ4bEp0Ykw4VWl6Yk80Ly94MzJwVXlwSWI3MC8yczh4QmpMT3FPM0hv?=
 =?utf-8?B?Mk41VEhsM09EOWpVdU1HMmVDci9TT21nM2RySHlOd1dqWDk1cUI2emwzWWZ2?=
 =?utf-8?B?UjdlclQxSG5qSThFSzRyRVNFYm5ld3d2b1RTWEFzRUxYWmlZcmVSWERaZjNK?=
 =?utf-8?B?VlRlZm1oV05xODhWeVk4dEJpMEtjTjlXZm5Hd3hPNFEzMCt5elFGRzMrb05H?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 368f9f90-6953-4e6f-53df-08dd6706bb7d
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 16:54:37.1292 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3iesPqdoyNWL0/I9vL5JtqFXtmNu+JJ26ImxKL7yGmB7DZhKflO69t5lBQqYUqiyNtrdC14wxx/YJBWhwF3yEoiKv8CE1lhGtis+lPNLC+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7697
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

On Wed, Mar 19, 2025 at 05:31:45PM +0100, David Marchand wrote:
> On Wed, Mar 5, 2025 at 5:25 PM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > In cases where the number of cores on a given socket is greater than
> > RTE_MAX_LCORES, then EAL will be unaware of all the sockets/numa nodes
> > on a system. Fix this limitation by having the EAL probe the NUMA node
> > for cores it isn't going to use, and recording that for completeness.
> >
> > This is necessary as memory is tracked per node, and with the --lcores
> > parameters our app lcores may be on different sockets than the lcore ids
> > may imply. For example, lcore 0 is on socket zero, but if app is run
> > with --lcores=0@64, then DPDK lcore 0 may be on socket one, so DPDK
> > needs to be aware of that socket.
> >
> > Fixes: 952b20777255 ("eal: provide API for querying valid socket ids")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> On the principle, the fix lgtm.
> 
> I have one comment.
> 
> >
> > ---
> > v2: handle case where RTE_MAX_LCORE > CPU_SETSIZE (i.e. >1024)
> > ---
> >  lib/eal/common/eal_common_lcore.c | 17 ++++++++++++-----
> >  1 file changed, 12 insertions(+), 5 deletions(-)
> >
> > diff --git a/lib/eal/common/eal_common_lcore.c b/lib/eal/common/eal_common_lcore.c
> > index 2ff9252c52..820a6534b1 100644
> > --- a/lib/eal/common/eal_common_lcore.c
> > +++ b/lib/eal/common/eal_common_lcore.c
> > @@ -144,7 +144,11 @@ rte_eal_cpu_init(void)
> >         unsigned lcore_id;
> >         unsigned count = 0;
> >         unsigned int socket_id, prev_socket_id;
> > -       int lcore_to_socket_id[RTE_MAX_LCORE];
> > +#if CPU_SETSIZE > RTE_MAX_LCORE
> > +       int lcore_to_socket_id[CPU_SETSIZE] = {0};
> > +#else
> > +       int lcore_to_socket_id[RTE_MAX_LCORE] = {0};
> > +#endif
> 
> This initialisation was unneeded so far because, in the next loop (on
> each possible lcore), eal_cpu_socket_id() (returning 0 even for
> errors) was called regardless of eal_cpu_detected().
> Moving this call after eal_cpu_detected() would be consistent with the
> rest of this patch.
> 

So keep the zero-init, and move the function call to set the initial values
in the array then?

> 
> It is unrelated to this patch itself, but I also have some doubt about
> the socket_id value stored per lcore, as no check against
> RTE_MAX_NUMA_NODES is done afterwards.
> (it is probably never hit since the default value for RTE_MAX_NUMA_NODES is 32).
> 

Well, it's an open question whether RTE_MAX_NUMA_NODES is the max value for a
node id, or the maximum number of ids which can be handled. I imagine most
of the code assumes both - that we have sequential numa nodes with value <
MAX.

/Bruce
