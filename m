Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A24C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 08:45:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09140402E0;
	Wed,  1 Jul 2026 10:45:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id DDBBA40278
 for <dev@dpdk.org>; Wed,  1 Jul 2026 10:45:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782895558; x=1814431558;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=yZuzXJ4Dg2ke7VOFsBvpFS6sOmUu1KT5Kom98FJp+4c=;
 b=N0YpGDsX5/ZgnV/1gTAPHUG+qiwVetiggShK9c6+K9zJiAzkZRCj/fxc
 dCRd59QFp2Z70dKk2v/yivMhMa7/XarjqPyGQVtXMusKlEa+ClDGLUmAE
 fm02KtM7TGxND9ig6+fIFMP5vGPriYV2i40FjjIylSiTfhG9JimJyR8us
 LuF6KZhY3K+JAqdxXNT7ZOXDYpz7BFWY32pMTMx2NiKf6YacKMMjbz3JY
 8k9bYSqSkzXHex39/T6hndmr5RcWKVTWGO+pUNjolTIU3gdN/Lu9lzjZu
 bujzzBwx+M4HvwtgnvL+UZdt4VFIaJ9x9E/a8KhAqYwOurTMq+CFPjXxe g==;
X-CSE-ConnectionGUID: AguMx4DVT+qNAKsuxZQb1w==
X-CSE-MsgGUID: 1byEOO3WQ3aciLQLbmfEFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="71144699"
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; d="scan'208";a="71144699"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 01:45:57 -0700
X-CSE-ConnectionGUID: 8jtb4kOOSLyOpWYw1eB5UA==
X-CSE-MsgGUID: wOqfVQtVRI+hgjGmEdMHYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; d="scan'208";a="253149952"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 01:45:57 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 01:45:56 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 1 Jul 2026 01:45:56 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.51) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 01:45:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGoILLqRK8sgkd9b2Vr/89rP4sDuNSFJ7RzQB6cNw5UFq9fPaOf+5Jygn1JDUUvmey0iBySqGvDzb77WyHpwro6qUW1Rn89JeBDdwTjg0Y3GHBcYrVqcJtrnLvAyxr4fdzo+vQ70snif+BWdhaZ2hm15XvK8/OBKC3SGJNSyOKVLPMQjmvJNAToO5J4VO+E0vTuAEy1E+3zWngl6wOAou/ooDmj9cOOrEZacx6p8l1LWZyGm8FjBea3Tdg2J9c7x+1kyxu9aA6AqJmTIrXIstg6Ko4qSBEMLMrES67ArQ3u0iLN3xXK3Zl7HLHvaVF0zACzD8FikK4eSyGgjiwdbKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dvEQ6VdpUSny7y9kUi+1FiK6iaSBv1//N6/Orb24eY=;
 b=Rgicp+h9ZxAisIZOdGVXUWt790CHsJVYN44RA3GBS+SqyOJTTn6nVJbLiG0HaG2ujtwChB+SJp2llo68INuQfitSa0YAIwTAIrlGbA6WaZo92yhMEkR0zE4cbeWbeIMAQwdBgA1h4QqffkBfgoDoyZrG0H9TYpXD1uCTC/qOOGct7/nHq8mSzxpWyTZL79YRBb5QDYWEU8cVZtEcWaqKI0uKNHCvGr86W6+lruFzVwQB0s1fO/210eNr47EGXvuEuyN19eAu7tOD0V00hIH0hZWbXqKkMeHSvTyT8M1rE6EjlfG9ZbJPmqI9kVYPgv7oXpy7iPxw69YxCfQs3EOn2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by BY1PR11MB8005.namprd11.prod.outlook.com (2603:10b6:a03:523::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 08:45:48 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 08:45:48 +0000
Message-ID: <845b63eb-a2d3-4605-98c0-76c8173ee522@intel.com>
Date: Wed, 1 Jul 2026 09:45:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/e1000: align device IDs with base code
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20260630161623.3131518-1-bruce.richardson@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20260630161623.3131518-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0082.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::10) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|BY1PR11MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: 50b226d9-7c68-4cb0-fdd4-08ded74d25ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 0YD7eZb8lDFhork/Bk1QOtpGGMn7sOwFAV8U6qQg+uFerzbF7eqdmUBU8gLXvhlRnDgxkuEUbCFEnTWI9i6KxQT9xGCvnsiCTSBOiZwZ9vt6jh48+72kTwphK8v1nPkhhzn3AS67ZhpKHM9cYLf6vHen1AXhO0NUbdrC5QIodLGwSevKK30ks2o2hZU1COe7YlWLZys3Iu/oAfvz+40FwI28YWQKBw8SIKqrEyTVEQUMtrbfREPwD/Dsiau20GI+lKaIAnQfqVp4T7oiZrg6AO+2gA/aPJdWmeUI/q1E7gvqQwF09WXF8NnoiFn/2KxSS7mAyYsLrjD+Fbh/DOybKYAY7F8REoFCbY+HmhmqocZNJSI4lploozv6upQ8g++1el3X1Azj7gKthVOtIU8kBMWy1Q0VcKlmUaGdDOgb66NmfLM4i/qyhcUMoRLGbKqjjW+Ny+w0+1Ama085HYspfSGeIMUhfjFqMIVUoOx7XKpc0/1EdQ/aIxjwh2+jB135L+kpzf3CAo7w3cS9n8MWdPE+MdsFZ5f9+yYf++v63xOOq4AReGkV82J47GgmjsViYljcQZGs8p6lWXOT6qzPYfJRwlwK5kKE/w8VmkkimK5AYvMXmAJbuB4x/plqWEA3aGg/RhHOhViqvUEYAmptrqbyFviqQiTOC9e8CneB21c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejgxYTZha003NitYTjBETWw5TmFyVHFzc0lEL0pRdTlGZ294RGJSb28xV3py?=
 =?utf-8?B?OGNtK0V0MFhiMHRBd1FleHhJUTI5TFNLbThHenJ6V1c3aGpqZDBMb0g2UUk5?=
 =?utf-8?B?U3BTYUJKYU1rd0lyZ2d3cGJ1MzRHSWtXZUpJc3lETHhNYmg2VGRVR0ZZTWRl?=
 =?utf-8?B?clhTb0JnMVh0M1FpN3Jacnhwb1ByWEc0N3pvWGxEclljSC9jNFc0MXFVZDFY?=
 =?utf-8?B?b05CcWlhTXNoRVRTOHhSTkpvOU9HbTRLdVo2KzVBYTdRb2RiZVNBekZ0Znkz?=
 =?utf-8?B?VnlCZW1BWGtWSms0bDlNdy9QMlFZdUNhaDZEZlY1SlBuOCs1Zlo2SXpHSUNX?=
 =?utf-8?B?Rm9MMmR6WVRTTjdOVzRzSzl6eDJFRlJWeDVMc1lIUUgwSVlZUXZhWFo4K1Yx?=
 =?utf-8?B?SHhZenpsU0QyNmt0MGNreU05elpENjkxYld5Ri8yQ1JETjl2bHpqUUliOFZz?=
 =?utf-8?B?R1luaWRSdHRNakNHWW9BS1k3dHVhbmtBRG1pMS9KL3UzTHJoQm1INzVZSGY3?=
 =?utf-8?B?WmszbVdYRVFrbnExUUFmeDlkZ2l0NHNobFA0bW0raFFPbGMzbjRWajZ2S3F4?=
 =?utf-8?B?ZC9abExncWI2NkRpWnFBVFd4Wno0RFpBZjkzWWFueStsV3FkdllCRzE4MWZI?=
 =?utf-8?B?dzBRa2xxRzZCYTVFSFRKOWlBYnJmMGlnaDJ5TEtLblhmMk1NY2VJZnc3WEQz?=
 =?utf-8?B?RmFPcE5lcnNwSVF3U25oOXlqWTlOS05uSHNVVTliRk0rWk1zaVpKVk42SzNR?=
 =?utf-8?B?OGo3YVNCMWNTSXE5ak9ET2kzSVMvM0MzcWw4RnBCQlN5WUpKZGlBVm1rMHlY?=
 =?utf-8?B?Nm1UdTJrRlgzNWJkU1ZaRVdKcW9xUEpXVkNvM0hEL0NXSWo4SFhJK2xENXgv?=
 =?utf-8?B?dk1MNUxCWXh6RmtQQ3Q2aTIzbG1QekNXVGVDaHNKOHhlbU1UV1N3L1R6cW1U?=
 =?utf-8?B?OE4zTDJHdm5RWDZMeTcrandZeHpsNWZJM1h1elFhWkJGRXpTTldteWt4Z0Z0?=
 =?utf-8?B?bklkbUI4MDFRNzk0ZlRjS1MyWGFYYlhpSzNYTGszVG9BUTR3VUltbU1KbVF0?=
 =?utf-8?B?V3JTeGJhMGJOWFVnWnphemYvc0JiK1IwM0hIZVJJcGs3SHVIeVJ4NTU1TE9r?=
 =?utf-8?B?bFArRTdpNjhFQUc4N1pSbElHYzhZcUZYajJOWldGU2x1TnZxZTlpK3kySHdK?=
 =?utf-8?B?cWpuSGtBSDF6Q2VaU21XWlJPOEtna1dabmRydGFBRW4waksrd1M0dmdrVm40?=
 =?utf-8?B?bTQvS2R1aWpNcFJrclNQM2o1UERiWGpHV0IvM0NNRWdtQnVZR1lmUWcyQ2hY?=
 =?utf-8?B?djltd05Ja2FxejN2SFBuUEMxZGcxZXZXdUNVUDRvQVFTL1NKVnlCRUE2eTdz?=
 =?utf-8?B?aTV6amVkdW43UC9TLzhIS2tCeXVHanVYaVRDc2RtajhKaVdOQ3RuZVo2VkxU?=
 =?utf-8?B?Nit1QVF0Q3pyWkhpemNxNy9Sa0h3WGcvOVdjQkc0RHZYY1Boa2IwamVEeVQr?=
 =?utf-8?B?aExlZlNOZ3oycU5rWVhlVjNzZEJEdHRCTmd0ZHl6TFRoRjhsVHFOM1ZiSCty?=
 =?utf-8?B?TGFJd1dsb3oxRVJHT0FyTHRaM3Y1cEdUeEdoM1dRNnc0ejZmVGdWcXJHNG80?=
 =?utf-8?B?cUZ1cmRvUkoxdmFrUWFQenFaVUk3T2tXWEs4eU4wd2RSSTN6cGFQc0s4Mnlp?=
 =?utf-8?B?NlIyMjZxRUpucWFmK2xRalR4RzNPUWE0eXJlaVpnandrL0xOQzNpTjJvN0Zz?=
 =?utf-8?B?Mi9TcWx1b1dIZDBzQWk4U3RlSEZXT0xEYWxCMFo4SWFuQ080eVJab0lLWTZu?=
 =?utf-8?B?TmRrUUZLVHFHaDJTRXdLM1Vqc0xtRng0cGR6RnZFQWdCMk5KMFNTQURwYzg1?=
 =?utf-8?B?VVcyaUtzNnpuMVI0ZEU1MjM0SkhaWUttenZCa01sVHA5T2ozZGtHelJWM3cy?=
 =?utf-8?B?cGdTeUxqbTdaby84WnZxSE1zTE50UVN4alFjVjlHVE9VUjlXMEFDSCtWbWw3?=
 =?utf-8?B?YkRZZ2xQOVdQcU1pWTcvdXZwOCtFWHZJNEg4NVFlTnAvbTlKWTRtUDU3TG1h?=
 =?utf-8?B?N2NEUzF4TjlYUlE3UlhtVFJSOXJ6Q2RIb2dDWU41c25XdDhHVXNDdGxuTVlH?=
 =?utf-8?B?LzUxY3pKSjVCQWJyU0V4ZzVTa25nSGN3RVF1WkpHbzJZUVVMb0ZRUGp6R0cv?=
 =?utf-8?B?eXJuMUZSVlI0aVVYMGxBK1R1T2xZMERwc0JqaFF6amRuNmk0anlmc0p4dlY3?=
 =?utf-8?B?OEdzZFNaMHNnNUVxaFYyMVUwSW9ueld6ZmwwN3A0Z0dWZTltTmdOeXkyR0Ir?=
 =?utf-8?B?NFBMalZQUkl3TTBpbmE0cjFtOEt1VzNXZmpyQnN0WUlwbGpmTmlwbE84NTZu?=
 =?utf-8?Q?gEj3aBU29Lw36Jj8=3D?=
X-Exchange-RoutingPolicyChecked: X6W+IuFYBM2+FpSmNFRM1nDa1gY1v0uF9gNWw3JLcdZsHLMsLuLFYjBryP0l1idNKhHvYpLys1Kgh9VFDPBviLE6TRZ9/2Ps5bI5L+zxKqbdhPvlBh++i+t+0MFGqngjjwIiJZRXLPdntGHyUOcHoSESu/djofBOMwa6RIDr5lAcAzJB5RgIc9G9/QDLUxVIsQlxLAfy497Hs/mTtcsBoWMDMz0aBLMF8JEqRg/55dfLVqcsHaOr+4g4mSSO63v4TgXe56votyUZcX5BfX89GIjC7ZwLkKn/DQ8N37jeuKlYKhZWEuM5mdkSGVYFl6rcwayK2FUKS6qMecIS6VENLw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b226d9-7c68-4cb0-fdd4-08ded74d25ef
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 08:45:48.4978 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0a5fx07B1a6lQeR5nByhfWyOuAtt/0ZotdyG20CIvO2+wAUvOalWvlY4wU5YFjvcfa5MCd61Mj2rp2G8NdPoaf2kwsVyFt8SKLmD+9UIqb0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8005
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

On 6/30/2026 5:16 PM, Bruce Richardson wrote:
> The e1000 base header lists multiple PCI device IDs in e1000_hw.h that
> are not present in the em PCI ID table. Add the missing IDs so DPDK can
> probe all e1000 devices defined by the shared base code.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>   drivers/net/intel/e1000/em_ethdev.c | 70 +++++++++++++++++++++++++++++
>   1 file changed, 70 insertions(+)
>
> diff --git a/drivers/net/intel/e1000/em_ethdev.c b/drivers/net/intel/e1000/em_ethdev.c
> index 62ab57268f..c02d09e500 100644
> --- a/drivers/net/intel/e1000/em_ethdev.c
> +++ b/drivers/net/intel/e1000/em_ethdev.c
> @@ -187,6 +187,76 @@ static const struct rte_pci_id pci_id_em_map[] = {
>   	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_RPL_I219_V23) },
>   	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_ARL_I219_LM24) },
>   	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_ARL_I219_V24) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_PTP_I219_LM25) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_PTP_I219_V25) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_WCL_I219_LM27) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_WCL_I219_V27) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_NVL_I219_LM29) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_NVL_I219_V29) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_80003ES2LAN_COPPER_DPT) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_80003ES2LAN_COPPER_SPT) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_80003ES2LAN_SERDES_DPT) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_80003ES2LAN_SERDES_SPT) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_82540EM_LOM) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_82540EP) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_82540EP_LOM) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_82540EP_LP) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_82541EI) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_82541EI_MOBILE) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_82541ER) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_82541ER_LOM) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_82541GI) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_82541GI_LF) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_82541GI_MOBILE) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_82542) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_82543GC_COPPER) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_82543GC_FIBER) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_82544EI_COPPER) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_82544EI_FIBER) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_82544GC_COPPER) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_82544GC_LOM) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_82545GM_COPPER) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_82545GM_FIBER) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_82545GM_SERDES) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_82546GB_COPPER) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_82546GB_FIBER) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_82546GB_PCIE) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_82546GB_QUAD_COPPER) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_82546GB_QUAD_COPPER_KSP3) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_82546GB_SERDES) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_82547EI) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_82547EI_MOBILE) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_82547GI) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_82573E) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_82573E_IAMT) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_ICH10_D_BM_LF) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_ICH10_D_BM_LM) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_ICH10_D_BM_V) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_ICH10_R_BM_LF) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_ICH10_R_BM_LM) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_ICH10_R_BM_V) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_ICH8_82567V_3) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_ICH8_IFE) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_ICH8_IFE_G) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_ICH8_IFE_GT) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_ICH8_IGP_AMT) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_ICH8_IGP_C) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_ICH8_IGP_M) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_ICH8_IGP_M_AMT) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_ICH9_BM) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_ICH9_IFE) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_ICH9_IFE_G) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_ICH9_IFE_GT) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_ICH9_IGP_AMT) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_ICH9_IGP_C) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_ICH9_IGP_M) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_ICH9_IGP_M_AMT) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_ICH9_IGP_M_V) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH2_LV_V) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_D_HV_DC) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_D_HV_DM) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_M_HV_LC) },
> +	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_M_HV_LM) },
>   	{ .vendor_id = 0, /* sentinel */ },
>   };
>   

-- 
Regards,
Vladimir

