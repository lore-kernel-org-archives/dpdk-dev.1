Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F90F4644A
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 10:59:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F188C4025E;
	Mon, 16 Mar 2026 11:59:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 4727C400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 11:59:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773658766; x=1805194766;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=sHh3fJEeusJwH5UA4/xU9fbpNA9iREwocZ9knAkt1sU=;
 b=IaizspSxITWsplSDhLj3LFrYmilTEHE42vu5+ckoJlb9dUYwhbbHOCC8
 7lyfOdGNRcV7EYvUw0cirBDOk7rbKVyjsem7ipStbEZzd/bCdqUkUqAzO
 l8Nv6N+pyej0cNYqvXJ1fg4jGxHa7yFLWgCnvFT+/KamzufpdYk8PNhY+
 ht0SClFBf8+Icr1CXC8sRycC+NCfL46moqdG43lCqgb7VsYKD3UywUHti
 tqJnGkzZR0KEcAuTCmxHafy1o/NvHnxGSrCYcqVYNVfRi09OuF8i3Jnmk
 S/SCCbiNBomXBSExDw+4XqWzShMrOnfg1m/X9OGifo06LH8mOiXiEVvRk w==;
X-CSE-ConnectionGUID: LDp17SvtQqWb5E50TEr7vA==
X-CSE-MsgGUID: B9OTehjMTgq4Na3GeM2OBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="73686356"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="73686356"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 03:59:25 -0700
X-CSE-ConnectionGUID: jGHnV8iDQkya6Cj87vYpig==
X-CSE-MsgGUID: yRjrj+mzSqeSgXUvDz/9ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="226340065"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 03:59:25 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 03:59:24 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 03:59:24 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.57) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 03:59:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMKXgFF4t902TK9K62CTqY2qGfbITBu/Q8udC0zzDayqKJHYwdC3W7jdvgv9VwvWH1ejWrLB54OibI23EDyPXL7GVDUPWimQj/WhC4DAygCKCZdLIBiI37Hex9gfjVI2jFmd2Di99fQym8Gw/79Q6NYUjA4qwHaZob+8vOI6YFX6qwjiEZuiCAbbsPeY4yHWW3/J9Jtcwi51Pt1XYiBF9heHrmXlSHB3OIjK199KMEry801NzeU2gOqCtS9ZytNbmwjk6BCx1NShbl7+NeYdNJ+lrVPv+Slz6NK2aiSV9EPSb3e7DIezQOrnmO9HeqsCzBDHI0we9LzCWShZ3fqlLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSY4xNTWEJvN8sQXymNtHbT+ROLSbYY0dXWaM0SNXgs=;
 b=VDIBA1Qf815FM28q25vOo5IQifwKV8q9I3yFDJ2W2ssUqUpGKJ6ZZUzhjxrOq2CIJseOmXXXmtX+9qqXjp+TqSdA8OOMpzyuW6JoHEZYnLp1me3zThiRQDK6cwJOO3gGaj3jFLkbzN0ZAooFhc3JaNhIdUBKF3KObDm4MlxV0FccTW5CnpQJDKcfaq1N9FMfOY+XOTa5Hr1cMg04Q1SWGDwwlOJCBv2kYLfjzjPFDUjcEp3UJsTKcT1bIJC2hnpXdFe9u4gNbkHLUhPSozPYetCZDOWWyfCxQmekYEILOum2OxsG9C6ih8Q5uVpJJfdPNLh/6AagTXPsZtL3VPJtlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB8375.namprd11.prod.outlook.com (2603:10b6:806:38b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.14; Mon, 16 Mar
 2026 10:59:21 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9723.013; Mon, 16 Mar 2026
 10:59:21 +0000
Date: Mon, 16 Mar 2026 10:59:14 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 00/25] Add common flow attr/action parsing
 infrastructure to Intel PMD's
Message-ID: <abfiggyU6lvhekgX@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1770819433.git.anatoly.burakov@intel.com>
 <cover.1773658289.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1773658289.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2PR04CA0327.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::32) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB8375:EE_
X-MS-Office365-Filtering-Correlation-Id: 49449af3-ad92-4b3d-fa49-08de834b13b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: yjYld2SwOfeB8JPuGbs+dCSlFhjwcz1IXMWrQYVnfXmnZBbmblOnzDL3zkOgWUfCGqcXagoPYXHdpiBeRpUWNywP+s/Pa9hrlqMowNymFZSTCu1lBQXf5ZAwMffEWyVvbpzHcg2RJ0c70JlsP4FzPD2ggECmAbX35S7lQdOHvmi7QdRTRb4hRXzD6K+Xu+nCWfzVdmHGQPIpgELKVUFOeyBTpAr9bh4s/yqJ0zLBUsjDBvFD2TrsXKjfnj3G+XOGJBxrUpEaBRqozI4YSNnPtTn1vXOWT+1fjYv03YcwecsTvtdByOgma/Go+DYjXNzlRfPTyQB8oHUnlov02eFOXtbvrcoY8ITYIptLbYCrWLOrnS1MKzLA+Y5brQezuwd67YH/mgE3k57PkzWnLWJOSFedoivROF563ho/EPFovXqCySHoB4Pd/LYntFHVYg9BOfLoSuwPB/GN4Dhs1EgiMVecadmRdGuBwPHnxXgcV2CschRBSmWeodKeH99EXWUb4PzBkt2AKg8vWPuZiPq5w29SeAFE32CbmWt0bcRpeTdaRgbKlidzDnNmqYFGGROwHjxn9jJYlAMW+OKTgOJGiCJVhvQ+zGIL34/jobFOnKMnVYbtZUUP5zJkSaK8/wsHOuBV5fcRev2yX/xudmaRwCvOLYky2nWpjOKFHJmLtPfUtmMueLkyqCqqMpxQQBuhKZX/LQPs61lUnGlGW0STXC7iKiwLO6ufCOH6lTILTtox7fc8yaqXjf0jfOrtfX9f
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lDOUD8oUdJ9dVnoRHdQgrvfTHA4WG4PkMmft9YwBiNyPeQKIowv9+5rN/C8Y?=
 =?us-ascii?Q?p6Ucjjq4M+KfNPoLQ0kxpg/RTxheKJEVJ7yNDOvYBmMwxQjiBFz1II/Koi3N?=
 =?us-ascii?Q?jzBXecgdM42Wm1FIBTycCzVrA7DdoCDNX+HeLvS09QacC3A/6+Yh1QZmJY0S?=
 =?us-ascii?Q?bIcBsIIc07xZLXGNh+N/duesJkDn+7C1s/LUNhrlDZMXaseJHr+Rl3q1e2qk?=
 =?us-ascii?Q?pugjOuNMd5RbvzxPOH7zk7ykz48o1jqI1KoxbTS9kRe9urZRQytFKUO4UBeT?=
 =?us-ascii?Q?nDBoPqc/6+LismGKtvCgF4ALaPWnZ3AUWzGvqilmYxxWmZ1jrEIhUusHCCt2?=
 =?us-ascii?Q?a4qhHpn3HsJhHoAEttBzAsNmawfEVexNSYvzIOKdck1sLFRmBHUB4b2Fs3eW?=
 =?us-ascii?Q?QVYoINnfxmiaLTCG8/c3VD6dRu/37ge+dhkO1W9kOh2xBYLOfHAg8SQDvOZ7?=
 =?us-ascii?Q?1JAdiW06cgSJzsfeSneaOpQiBd/RGAWOoL70VJTWDDS7sOWjlQL+LpTzBBfV?=
 =?us-ascii?Q?YfUIoGIfT1ZA6FWoiKRCMIcz29wPbXvBo1eLuK2FDqIBIublgnRYjGVyUTzr?=
 =?us-ascii?Q?tAiben++gsihAq3oBpoN15F/RnkSpcdqykcKwKcK6SOH1sDIk8Gal4NCnM5+?=
 =?us-ascii?Q?KOStQc7EUV8EcnCg+rHOges2T4R+JgfTvq3dpufCN0rJVizkZR8Yw2MrZUoU?=
 =?us-ascii?Q?uWu8A7BL8ssSJsoOxRJ7EAWctgoWPquxTMiadEyJt1ZXdsRU2t5gvucg1Mbj?=
 =?us-ascii?Q?gI88XjcAx2MTVTUHtXeTG/qZLEEVJ/Leg5TYvhX6cougID9aCDe7jTEaZBMl?=
 =?us-ascii?Q?zr3htFkd5JjXwP9ydegX0oN68QF4idIc3pQDqPg8FWDTk8n4JMPpYFMMV6Sv?=
 =?us-ascii?Q?Urlyn12/Hv6okqUqDTXOKA6IShRh4SYNaJ6ojdNZlJSz9xCESFV2LuIyQ96O?=
 =?us-ascii?Q?mnGVW/flxSdutgHYrFLxy2XeMp/0+q4w4N41iHfa+QN1VlrqhVxAYmuLN29A?=
 =?us-ascii?Q?iAQGmCG80F7LvFWY7At4Gt0eaVLyF4ZOI1P1ZMz5+LlzfCpPWJFgiBeAIBSM?=
 =?us-ascii?Q?GYpJNCG2rcXoupzM1enKBRHmi0eu1tiVH1NiOIG8/dg01D8NLq/N0SM/w7IQ?=
 =?us-ascii?Q?BpoNRPqRwXrJRj1Becm/MFmMjaYQ1ddx6AGm1IYidlOz+B0+u6BvtSiXIgb7?=
 =?us-ascii?Q?XkTPM7XP1a6AoE3SqEkfmqU3BLvxSwT+K20y4RBVv1vQx9i/zoFAFHZ0DRTG?=
 =?us-ascii?Q?meSmQqPuQhOeGd7gEVxE/hEBVWojORNOvmwYE/5VmUaK9zhPK4lhMGMzL+Dx?=
 =?us-ascii?Q?kRCPdch1v7IyBl50rjMogO6uq7SwoUpHxmvo2E4oY1qOxxiND2q5ivA+30Xp?=
 =?us-ascii?Q?Q8ZYrGQ1hm/HoJRKrvsZzf1vHlzYlS/9s4CtzOuZEVKoey4m8dh01v58ipyK?=
 =?us-ascii?Q?Hlow8up/DliHTYlzAyYQtc884Jb5ge8jv9Uaja568m//uAZ0fGDKsKrvP2HZ?=
 =?us-ascii?Q?a/VwYGXHeDEJ0pLSw12TEkrfOvOSliV1NNhBWw7Hh/+onodEKU101buZCVbt?=
 =?us-ascii?Q?Exxh13Ai94OIfGv+7dmj7mb4/E5vR09CskX8LAQgUYH9TzekJVmU44V78f7x?=
 =?us-ascii?Q?av/pARwZOJJW0zk+aLdiXVK+LneTitYztynBRhqm+/ExmHGlFcqqER2XhdMY?=
 =?us-ascii?Q?SWJ4waEHL/Jw76usf2StKkjH2eQXmU1t70+e0njJAT3HRUVf+JeMGQRl+FUA?=
 =?us-ascii?Q?KfJrDhEBJUQ3UCpew6X3MFWoUv6Ni18=3D?=
X-Exchange-RoutingPolicyChecked: O62IP83A99LUyTu4v6gN+PY2BF7qJI51OsBdsSIVf0okv75PPScUnjwAaXXpleg+nxyQZJPiptnXuxdwxKEj3zI2UU487wWk9AFSa/BmPRGa7/PMQ0ArZHvUoYDdhwPT72efHfJtelryE3C7f+FkV+mdSmZW4IdpqxJ9rM3ZATs30OqgnV1xF85jcmKhwu90dQ0NTlasXFO5iYMgF1Pk2WbjqWgDVSf1Y6JnvYBlmZ6lqTlazIajG4bzArSly8NgUp1fHyICZKxk3mcjl3wMMRVND44xTHxqECja2eufP5RNiafnxWShc0DgT5L8Cx+enIZ19jwSEpqtb/5TNF1vdw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 49449af3-ad92-4b3d-fa49-08de834b13b3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 10:59:21.1029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EH/SiuTLcaxItczu0uSrv2ksuKWaeJQ66VHHiI+rhV54kIEKD/2TSBxkOzWO9WFDY0z2KuNl83NlajK2xFL3r2XJtZ9k/hYxIE84MGl2jMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8375
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

On Mon, Mar 16, 2026 at 10:52:25AM +0000, Anatoly Burakov wrote:
> This patchset introduces common flow attr/action checking infrastructure to
> some Intel PMD's (IXGBE, I40E, IAVF, and ICE). The aim is to reduce code
> duplication, simplify implementation of new parsers/verification of existing
> ones, and make action/attr handling more consistent across drivers.
> 
> v2:
> - Rebase on latest main
> - Now depends on series 37585 [1]
> 
> [1] https://patches.dpdk.org/project/dpdk/list/?series=37585
> 
Since patchset is deferred, the link shows nothing unless we override
the state value. This link below should work better:

https://patches.dpdk.org/project/dpdk/list/?series=37585&state=*
