Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA619C3ABBE
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 May 2025 11:05:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 846DF4026C;
	Thu,  8 May 2025 13:05:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 5E2554026B
 for <dev@dpdk.org>; Thu,  8 May 2025 13:05:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746702327; x=1778238327;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mAu6PN7uxTCRsF9VhsgnQsDPFj/gzGXOCJ0OrCjHJQ4=;
 b=BNntgGJFavO6i0fflxV9K9liRhoP4MkA1nI3GDKnRUX03XDVPBQdfQk2
 68Vw7TKqmscCh+Ps2s0AbckreDUzLW/ARvR3UaYbWBZ6w7ol6ji43srjX
 YJ13Z6sEL7I+AfmA+tUnZ4KibRFVu69kz2Pp41bsezAhskCJp+yKk3f3D
 YkRgCV0Zib6kk7WdkwajHFecfkqC58zxhbG/CCSfuVySQGSqe0v4JdjO9
 XVNL99L7iLVnIDfP56alff4HGbPqqOj4iPS3jbYrvcdClFgabdQ+f7YhI
 f5CyfPTRgr8H6fp27o3aO/tNuLSkFBJssyPrQrJ4KqLlm87uPUkiLLhTZ g==;
X-CSE-ConnectionGUID: EIadkEjOTdmO+8Ip/Zj+Gg==
X-CSE-MsgGUID: pQjN5mBdSzuY9ZDsqzSRpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="48627098"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="48627098"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 04:05:25 -0700
X-CSE-ConnectionGUID: pCuBXqroTLaRGgy9IWkWOw==
X-CSE-MsgGUID: wwrk8aD8TSiytxjJHqzZzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="137250349"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 04:05:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 04:05:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 8 May 2025 04:05:24 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 8 May 2025 04:05:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jzXB87NFoWFrlro8fpwjwpphiUDIiFZWX6cu0kKJ3Ssww3C+M0JVx5g6t0Rd4PNu9v7K5zFWRnH5fq0dv8uxA+4mL27HL6toAEkiuY4OrzWYuIURC3SA2HpzAL/ZLKS6xgkiWgawxZY6MNjAi0Qtm1I2BCkGetaZbIW2r01aPm7CxgT3HtuMUf1o3DSSukxMxLoTNCbmUdmWpCMULEIHHLlIe9wZju6xA6CPq8u3RbtUGC6xNMBEu48kw8VXrfu/u2SNOZGKFV+lKxQH6ozjZYCCcUyJYwbEwSeS26zeG+DPVKZ6nijVqJcA0Q9DbSOkQ9bn1x5RyaWnnKy2UAj3Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5g+WcysXTF5J8FsxEthtAwhhaMJa2sgwW3JqSFq9BA=;
 b=PsGBzFBlPd0l2P5IsznIHrMiNYC0LifWfNUQFi+sRB8z7fyXlDdrtvKyjs7uUKEy5zUcPjsgN67bLMTE72DxW612ANZsSwUx9gn9HoMZmTLoNrKBShTyVEslr+p+KyfA0YG5FNe4bbwmVXM/kjPpOX8JSJOur+4I0ixd//ea4OVcXXr0GbllmY43xneikUjOPvPsUfyj7Jp9LBqZCaAXMInTDg+RdsNPF+oGbhb7Utb9ETLS5AIqKf2aZLpn3g7SlpYcEpfhkSlU1KYbjyTDDexu+xleWuCbUu/HHeeSYOKGkpCg+eLXr/Pgh3VpfGweHA3QuwpnLhQW4rr9Mjl1sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 CH3PR11MB8563.namprd11.prod.outlook.com (2603:10b6:610:1af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Thu, 8 May
 2025 11:05:17 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.8678.033; Thu, 8 May 2025
 11:05:17 +0000
Message-ID: <0147cab8-bc5e-4211-9266-544a3a2dc649@intel.com>
Date: Thu, 8 May 2025 13:05:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] eal/freebsd: Do not use prev_ms_idx for hole detection
To: Jake Freeland <jfree@FreeBSD.org>, Bruce Richardson
 <bruce.richardson@intel.com>
CC: <dev@dpdk.org>
References: <20250506175010.1141585-1-jfree@FreeBSD.org>
 <20250506175010.1141585-2-jfree@FreeBSD.org>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20250506175010.1141585-2-jfree@FreeBSD.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB7PR02CA0026.eurprd02.prod.outlook.com
 (2603:10a6:10:52::39) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|CH3PR11MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: c0548ace-d5bf-4d81-af3d-08dd8e203729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YS9vTUhvSnc4Y3NUYkRjOXBMT3pMdWxQcHFZVTFob1YxbUNoTHpFS0dVMWE1?=
 =?utf-8?B?cnV0L3diT0s5Uzhub2RUUmNEV200MWRCdVBPQ0tpTnlQTmpaOVlBdS9vZXBH?=
 =?utf-8?B?NmljRDQ0QVdoRWZVQnp0ZzZCZmJreGg0blZSa1hQM1g0M3RaSUJ0NDFEZTJP?=
 =?utf-8?B?aXpKSCt4Q2pnN3ZSR1pBKzcxa3AvbjdldVlIUmppaUc5NHY0ZVA0S2xPdWts?=
 =?utf-8?B?bldYZHNoTmhHT1hSandiSmpjSnRXNUxsbHRraUpOS0lpS1pvWm5qVzg5VWhu?=
 =?utf-8?B?dk9IZ1NsZG5IbS9DempUMVlPc1RBVE0rQVVSZTIvSldhTkorMm55Z1JlWWhj?=
 =?utf-8?B?a0hJNURHc1FUNTlCSURVYVR4aWVWVkV4Y05pblhldklBdzhwMkhtK3RSSHhL?=
 =?utf-8?B?SlkyQTBwcnh5THlrVXRBblAzb0xtL3F0bHZKWVhvWnFrbjFNT0dySmhjQ3dF?=
 =?utf-8?B?YXB0eHUrZHBIa1RvZXJPVENzekZPYjRCVTRHUmt1a3h1TnpQbFdVZUFNL2FY?=
 =?utf-8?B?UVNISHEzQU04UkkvSUZyV09JaUkzYkYyWldGY2tqdjhOL1JOeVF0WDBHYkFM?=
 =?utf-8?B?OHQ5aHMzVUloQ0I5UlhjelExcUhuRTlaUk16Y3FIVHZXcmFHREVMdTdOdmto?=
 =?utf-8?B?V0hWSW80MmdmNllsQ2hucFFXeElUelQvR04yRnZYL1RsN0pUWVFaeXRwSExy?=
 =?utf-8?B?d0ZVSUthK0ZmcXhmSzhmUkhxcDJzR0JGN0R6OElNd1M5NnpwZXFzQ1A1cW5n?=
 =?utf-8?B?MDZENVE4c0RaS0NmZ1EyUE1DYThmYVpIMlhTOGkwbkZDY3NTWEVhdmJHdkNO?=
 =?utf-8?B?RlFVZ2gzaENnZitPTlpHUjNKVXNKNjVxZkU2clVvWGFJMXNJZkxkTFd1V1dv?=
 =?utf-8?B?bDBhdE1vaHF3Z3o2anhIYTk2T1BWSmZjY01GbnluYnRUdUYrZ3MwYnp0bnIr?=
 =?utf-8?B?TVErcW9Qb3NLYTR4WWpnK3BXMGs1YTVQNkxma2ZMYzVOeW1RV2lBNTRzZllF?=
 =?utf-8?B?ejBJckFOZDdjVXk2bE1ISjY0alltVEVyeS91OTd1Z0ZKYUNEcmhybDdLK2Q4?=
 =?utf-8?B?UE9UM21vVzV4ek5FSWp2dk9sTEJRaVhhb2NESXdDRFdUZGF4R0crM2syVFpw?=
 =?utf-8?B?UTZZdVlsMnNqamdxWDhWelZOZkNnRUUxZ1o1dVJyTnFzTEVFemxkcXhnWHlQ?=
 =?utf-8?B?WUhyeWszbHQ1NGtRVnBSdTVlNE5YdEJpWjNBL29hSEttL2dKMFFvb1dKR2w3?=
 =?utf-8?B?VlBPQW9pTXVMMkRkQlJmTFl5eEIwOFB5T1FUME1DZ3pRSUlVenZYeFoxeWpz?=
 =?utf-8?B?K2Z1STNyaWdHbkk1c0Y5M1ZwQ1Z1ZWpqZ1lUaG9PVU9xeWFjN01sZ2RFWDgx?=
 =?utf-8?B?OTVzenJGbVFoYS9ma28xQkdaRytnNmdWbVU4cUFYOFpWTlB6T21aSTNhMThs?=
 =?utf-8?B?UEVvT3NJUEVWbjhqZHNubnBmckYvYm5zNFJWSFNWQlNoNzdJeGppUXhMOGh6?=
 =?utf-8?B?TTNmWm1QY2wxOUhQV0lYVlc0bkF3KzRMM1YzNWhxTmlrYmtmbFZQbmk4Qytp?=
 =?utf-8?B?eGRwbkY5M0hCR2dWUVFTb2N6OTBWT3psWXI0WmxNdHBrRGlSNmEzc0ZYNGdD?=
 =?utf-8?B?c2I2TVQvb1V1WWtIM3pDa2JZK3NCa091R29VbjFxRUJLQ1I4bytiemxmY3RZ?=
 =?utf-8?B?RHBTdGl1Mi9xdG5BWm5Mc2NEV3BzVVJ6ZnBkMFJtMEtLbU05YThHYkFLUGVk?=
 =?utf-8?B?Q2I2UGlFZitxOEJlblg5SWZFQXNiaEpuTkxnVEJLL2xkWWhNdGFFVlFuS25i?=
 =?utf-8?B?UDIwWUpqUEk4NjdDb2dvc2tmcUlSZGFJNUdWa0V0MFR6TkIrcDlERkJvNURT?=
 =?utf-8?B?UitBRVRjVFVTS0RGUzdOcXU0aCsxdDJmRjQ3ZllLbnlFRUVTcHRRTHBjZGxU?=
 =?utf-8?Q?ikRi/By0xGo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHA4bUowVm4zK0w1SGxJcTNRRk9lYVk1Kys2VUI5NklHOXhxM0ZpMzRob3pt?=
 =?utf-8?B?c2ZDVnphMHJncmFhb3JwWittSWFXRm85cTVVR24zSWVrN2FBNTBBQU83NlU4?=
 =?utf-8?B?dWVNd2pTSWhEYkFqbUwzR1ZHZUY1NEltcllwVk91MVVUTzRqdGl5TURkREZY?=
 =?utf-8?B?VnNFNmljUHpmUXE5aGJxQmp6d0NNNVFoQVlWS2JkNVFzVlNTcUFqWnBZT2hH?=
 =?utf-8?B?K1YrZU1hRXVad3NiajF0REFXYTcydFlxUkJHc3ArTGRpTXdzZ2c2dDZNQVZE?=
 =?utf-8?B?WG9nRW56dGJLajVXRVFWVTN2aWkwbFlQcStvTER6c2FrRy83dWNlVVB4MnBp?=
 =?utf-8?B?MEp5SkRKMEFYR0Y1WFFYQ0RrU29zT2luTUwrREZFWGEvWXhqT3VrdXlpMnZW?=
 =?utf-8?B?Uk5ITzdlVTl2UFFuVnl1Q0g5VGQ0THFEVFhmSUI5YUc0OTlnTEpKNG5yWHB2?=
 =?utf-8?B?NHNib25KOHUvd3lveEt5ZnJGSXM2b085eElCUU9IcHRuSVoyS2tSdUlTd0xE?=
 =?utf-8?B?eXMvbHNDNHg3Z3R2aUg1RHRPb0p0S01aL3R5dGlNb2htMFpCdXNqWkNCRjQ0?=
 =?utf-8?B?VzdleEFkN0ljbFlneXRNeHpibUQyeHJ3VlM4YWNHUmhkMlBYMmxlK05pbTRP?=
 =?utf-8?B?RnkvVjBOYkphRUh1TkVIdlBua1grOW5FWE5wUDM0OVNYT1pWc01Kc01ZRHNo?=
 =?utf-8?B?Z0hZNmhqUjdkVHhpbGc1cWsxL3V1RTlIb1pLYi9HYkZzOXNxZXJQeDJaeVd3?=
 =?utf-8?B?eWx2eDFLWmRwNER0V2NmQ0xFK3RpSUdWQ3NUTW1uWGE3TWZ1QWxsbjYwOEZo?=
 =?utf-8?B?UjFYdkFyS2Y3MGx0V0MxQzNsanplTkJtWlZ5RFJXWVdjQXZ2a0p3cmx0MzBa?=
 =?utf-8?B?YUl2TWZGUFBtcm1ZbEpUMDBValNBUWFrWXkxay9wNnhGTlZpVGwxRWsrem4r?=
 =?utf-8?B?NnRmdTRWckR3N1lkWC9qQzVZYU5FdkVuY3p2bFZGaEI0VmRqMnp3NjZpRm5E?=
 =?utf-8?B?ZzJCZEVQdkFSaTlZdVBqT2Jyc05INzZxNjFCaWx2c1p4LzFPRlRGU3pjeDNk?=
 =?utf-8?B?RTNBOFdhMDQwYzJoZTU0TkkwVTNnd0VOV3ZZQnh1R3p4YmIwT3hJeHpJWDN6?=
 =?utf-8?B?UURTUTBHNXJ2cllQZWNFNllpUlM2NUlLaENST0xhUkdzTGVtSytjMzFnOGNo?=
 =?utf-8?B?a2xQU1gzM01BZHpicGc3VlFGRGNMME1zTXBwNWFTYkZJQmZVMHVsQkNOYVNy?=
 =?utf-8?B?cFg2bGhoU2VwM2owNmt1WjlTNVR5akNwRSthbUo4U21YR2dMQnFVY1VyYzN3?=
 =?utf-8?B?MVUrVThmU1FndnRYN3dYenA3TU40UkxES0l1MHBIVlNqVFpja2t2UExPd002?=
 =?utf-8?B?VGxsRjA0NDlZZ0ZoalZseERFUkU5bjRQSERwQWtKMEcwbldvV0c0enhLRTJk?=
 =?utf-8?B?RHJRNmJTWW9rSXJpV0hkN1NXOVdYYVF5WUx6cHVPaHRuZkZ1alhBNHlrOVlB?=
 =?utf-8?B?VlRSZFdUcTBYTUF5bVM2ZVNNWDBnSDN4eHZTZFk5c29sZ2F1MFdrNVQzRlcw?=
 =?utf-8?B?QTRIb291TW9GMmg3YmcvRWpkN29QdHZVTmg0QXZHSlpXMXpVVVFKZDFDRGtV?=
 =?utf-8?B?WFl6Rm5VdTZ5YWMyTVFtN1RMQnhEREI2S1N2OUplVnE1UFl4KzFpcFJiWDVw?=
 =?utf-8?B?K2V0cTViYXhhT3p6dDkvVURHZXY0cVU1ajlFWVJrOWh6QzNSdGxYOXVzeWNR?=
 =?utf-8?B?QWlQQ21ZdnVhV1ZpaFJLcXhSZWVVYkhmMWVhSXcvZmtkaG11NzhGbW9RSmxa?=
 =?utf-8?B?UVY2cGEvdXh6SmN5RlhSWGF5NEo1ZW1MeHIyclFIb00vNFo0enFEeTFxblhz?=
 =?utf-8?B?ZUs3ZTNQNnNyZllzQ0hyY21CdENYeUhFaEhIVkl2eFJkT1A0L0RyUDMvWHJq?=
 =?utf-8?B?Wmh0cHVYdGxvMUcyQ2drZHFKWDljOVhOY2h4VnJLbEx6S0JHMC92cDRoZDJp?=
 =?utf-8?B?MnVTY21odS81TUNaQVEvdFNQSVFJUnlVY3UxWDM5SU9QMHN3Q3ZMMlpVdFpR?=
 =?utf-8?B?Nk95MXAxRmVRTGJYdU02M2xqSjJUUGxWWHUxYkJVTE15N3hLT0l0S2Z5ZERw?=
 =?utf-8?B?ejFxdGVRTXFzWnFURkhpZDEvWkxxcnJmcTRTNFRrelZhaEkzaStOM3BBNjBZ?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c0548ace-d5bf-4d81-af3d-08dd8e203729
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 11:05:17.3952 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x3yYD90NxV02xDmfVwNQKyR4e81MuW6ntKGuTUDVAm8zZfOHqgXT9zwri+wn11eMtboqKgx+xKShE23p0adr6KBXWu3BpfkDXbCXKd4ZUCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8563
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

On 5/6/2025 7:50 PM, Jake Freeland wrote:
> Use rte_fbarray_is_used() to check if the previous fbarray entry is
> already empty.
> 
> Using prev_ms_idx to do this is flawed in cases where we loop through
> multiple memseg lists. Each memseg list has its own count and length,
> so using a prev_ms_idx from one memseg list to check for used entries
> in another non-empty memseg list can lead to incorrect hole placement.
> 
> Signed-off-by: Jake Freeland <jfree@FreeBSD.org>
> ---
>   lib/eal/freebsd/eal_memory.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/eal/freebsd/eal_memory.c b/lib/eal/freebsd/eal_memory.c
> index 3b72e13506..bcf5a6f986 100644
> --- a/lib/eal/freebsd/eal_memory.c
> +++ b/lib/eal/freebsd/eal_memory.c
> @@ -104,7 +104,6 @@ rte_eal_hugepage_init(void)
>   	for (i = 0; i < internal_conf->num_hugepage_sizes; i++) {
>   		struct hugepage_info *hpi;
>   		rte_iova_t prev_end = 0;
> -		int prev_ms_idx = -1;
>   		uint64_t page_sz, mem_needed;
>   		unsigned int n_pages, max_pages;
>   
> @@ -168,9 +167,9 @@ rte_eal_hugepage_init(void)
>   				if (ms_idx < 0)
>   					continue;

I guess an alternative fix would be to reset prev_ms_idx after (ms_idx < 
0) check above?

>   
> -				if (need_hole && prev_ms_idx == ms_idx - 1)
> +				if (need_hole &&
> +				    rte_fbarray_is_used(arr, ms_idx - 1))
>   					ms_idx++;
> -				prev_ms_idx = ms_idx;
>   
>   				break;
>   			}


-- 
Thanks,
Anatoly
