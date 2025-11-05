Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5996CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 10:44:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19ED2406B7;
	Wed,  5 Nov 2025 11:44:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 42F58400D7;
 Wed,  5 Nov 2025 11:44:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762339447; x=1793875447;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=UESd92yATEEP7ugzHblrv2z2m3DZc8wwQY32SncESiM=;
 b=XEOlVLmQPZMgzOQop24W0tNXqU1N/D5pqnVaMJ/H6uQzYNFb1qgHVQgn
 NeS0ZvcP9PMjLfhY24KTWSSjKVH37icfjPZF1G1V5++zgUnJhYAKJ3VX7
 2RyHdMsz1piIEphGr9ZYDkCVk8ZoUML2DzwlbUvDISJ4487IdVKyVia4k
 QGwv/63jHAJlDHjBkTucOTu0SOg5D5pEXOrpecKRyJOR8HlrDo1aMdCtI
 E5VBwrwheaGUU1UV3m2LBfvjy3DdV7Qi7uOUO3ZM/R54VJPfr2nCibNGt
 qvlnJgTNT+/3XRq0zwblPc6LfZdG7KMLPZfU4id2iIABHoIQ0wBM4xcqt w==;
X-CSE-ConnectionGUID: dYE3vEhDSt6EVWI83tH00Q==
X-CSE-MsgGUID: yVmZ5TbvTCmT32ws0oCAUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="64550636"
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; d="scan'208";a="64550636"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2025 02:44:06 -0800
X-CSE-ConnectionGUID: rMYKtGiFQAGAxWwNSM16RA==
X-CSE-MsgGUID: Jysihqj6QJ+XHE7KaXFiug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; d="scan'208";a="218203205"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2025 02:44:06 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 02:44:05 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 5 Nov 2025 02:44:05 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.45) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 02:44:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UxbvQRVMjfh98UQXPMxV/hS2X56mTbR9fg6HBZ5JhTzTXDPWW/9XmQ5Bk8YbIDT/Ky6V2vhEY7p4+dSZJEv6rqMOxVW8D45c44kNVd5TLyYzfRtyznankMltW1LwBA83JXuRs08+/zqQcOJXhs/KPGFL4D2w0W0gfhjSrTiTN7gwoyQw1gnNG/tnOQESrZ3whX9Bo8qpbDDymgGdSAvlCKNDaZg75XyzpEPP0lV+hfC60tHRA3mSY4DwCjaUo9YUxHe8m6gj8284hpq38pnNhl9SOhMvglDQpmTYpEJtFpusMNlfgGq9ngSlg00J6zln/OKLAAFnbT0Lcp4SfggFjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJE+vPmzquny0Yod5FHynu/wNHfdXILNpSH0rJwtavY=;
 b=n1jD7NkWVo3ewCsZJAwRMGlwlPQIonE5qTxMSXtxiRcxdmObPOP2fbI07VEjFQLOCEmSI7VWTeoGW86KDsm/QuByEgXlMoLqtm441RfBnoNgJcBiaW3kU8KfzKZib9gCNfzT4YvKatrVl3+o3eyp4JureT3GW+Ecr9seROMRqGw7n8kHaLcpNJHGVHvAZUBwHDHTNpRZzqMysGAPSpR0qszYZucEPv7AkMBBJr18xfwXVJsgYNEE7+Y0qFtHL7BU1ySOMke3Yq51zX3+Wq+TuHy6MYwgczULKwcAQDGXqzWujv6AaTKLnStjlVQ3CppMS9Pxod5IKx5L0qQJSm8QiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ1PR11MB6177.namprd11.prod.outlook.com (2603:10b6:a03:45c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 10:43:55 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 10:43:55 +0000
Date: Wed, 5 Nov 2025 10:43:49 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, <stephen@networkplumber.org>
Subject: Re: [PATCH] net/fm10k: fix build with GCC 16
Message-ID: <aQsqZep3DWUkBq5q@bricha3-mobl1.ger.corp.intel.com>
References: <bug-1822-3@http.bugs.dpdk.org/>
 <20251104111515.1728873-1-bruce.richardson@intel.com>
 <26e240e0-9d0f-47dd-a94e-c13599f0368c@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <26e240e0-9d0f-47dd-a94e-c13599f0368c@intel.com>
X-ClientProxiedBy: DUZPR01CA0333.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::27) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ1PR11MB6177:EE_
X-MS-Office365-Filtering-Correlation-Id: b89885b0-6c98-4501-7104-08de1c5837c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L0k0UROdCJpAJtOc0qSN6Yx7NVxLlwuF4ZeMmg6pCA1VSNKauaijCfgWNQE6?=
 =?us-ascii?Q?zx+zeLxNvVg3eiBb5ox7DuIMU7NqWBrNB3ik+k4nvZf9UJCIWyJ5tJMkwX4W?=
 =?us-ascii?Q?5ERCM/QnyYXr2wnRYGZuiZhZIAFIiQM1MVdRXTYE8UJOaAciYv3AZZxjloQf?=
 =?us-ascii?Q?bZlT1nvjdCI6nTDW3dIPGqkkZP2QlzmGDqRYUlGmiPOaG4p/ZUAvAIqb51Bm?=
 =?us-ascii?Q?xZMQDVfDDqkOCpsmaLF32xjpElnAnPV5Bkf2KSz0+AR8lWaWdApXY1EURYxL?=
 =?us-ascii?Q?Eh0zkYJBBXnDWEQvwxaZICZDx0XTh44Az8TSI24WLXEpAezvvCj3tBdVnIGx?=
 =?us-ascii?Q?AMiP2Sy/V5gPsMN0G7eYpy99Rs8snoRq5/T5njb8ikN3FeeL0lErKxgG8W0E?=
 =?us-ascii?Q?6NEpTcCcMzq7UcGCnr/vsKYKGDfvpmZduTwNi5SNtRZ53jTsmDPFug5eYgnB?=
 =?us-ascii?Q?Z5CgjMih6pxEqT0t29HOjb9KkHDWdJuzkMWjH+n1hq0/ykE899myNVU3SqRV?=
 =?us-ascii?Q?Ltd3YxhbSQI0CXSTFoDg08WEqb4Cz4Q5mKRMI3St5XRIOGy718zL6YKrspXk?=
 =?us-ascii?Q?KDbs2XWf4276uOjgha61jDX1IgXiXE8hohM8lFyg1+sI+miGvJn8Mdqdjris?=
 =?us-ascii?Q?ljDmh35PEq48ghN6dxhX73A7SvwPTS6+oAXw/YFhMldd0sVqmBkWSJS97E6x?=
 =?us-ascii?Q?3THqXl4YuvGHKaI4XolozSPPq78H+QbPhygqjc2JRIYaOdDJaiZUOgGc2P6Z?=
 =?us-ascii?Q?xIMW9ix0Z5Wf6xS+5sudGLi6w6GCeqs07ItwSXaYZhg0miWix34Xx1YvD06w?=
 =?us-ascii?Q?iXFq5Ux+Dba4A2T6SMPBdN5CQDdcICfpwNenHvmdERIXblerF5ubxxHeI6Cn?=
 =?us-ascii?Q?R4BHWVcJ9DxRHCBVBFZoHe+1Dl0BY+Mr8DQ6+YwHxRa+kykwgiNHOykVauye?=
 =?us-ascii?Q?meOZZ9RYVBw4+eGbEcNxuA9enlUFq8kaKBVrrmSiqJBSbBXyvC/v+KW2jycC?=
 =?us-ascii?Q?k4+UVu3SFStKtzx+YpZJhOKxgynnqtcEMRiUgrAaEhvYKfcnOSDpeTPUnb4N?=
 =?us-ascii?Q?N9NpMCD1VLb4PGg/b3vQny9kEqZtsq4hKCegHPIzVszgX/bCK9pzO//wTsJL?=
 =?us-ascii?Q?+Zra5rzXlNHuM0yQtmD93hydrV6s9/pJzqD13KPuVNaU2A9qGk/arL+6ZHa4?=
 =?us-ascii?Q?oBaFwhO83E4VLpYq1+PIUR2MY9wkatdASxjxdBpP+oLYzImO3w1KwfDiCqtR?=
 =?us-ascii?Q?go0cx11+jOSveHnoyPa4eeFUKokqJQwJJs6l0fmrcQ05r3eEqO4gjVgO2BEs?=
 =?us-ascii?Q?dsIsIgpGJTk4XJmddBLBG1TevkRRNf1dLr5haoQ4AEy9qGQVhvdZ4iyy9luJ?=
 =?us-ascii?Q?LjmWvwcEWucCp630vcEAXexQ6KUND2MzgXg49t24dKF8MgC2n4ydLSyrSIr4?=
 =?us-ascii?Q?90UEj+2rXsKAHpGfJd6X734MRt5Lhk0y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SM/tut+tFuitF+idKZHkueH2KRiWk/PKUcskZDy4eMzbcHwk13flpmYJ49qH?=
 =?us-ascii?Q?PAKVw9zTH/Zm7A1ag9I37qBmHupvbtSoYp7UhsW4O3g6fCvT0gfcIC1iyEXb?=
 =?us-ascii?Q?6PW3KW7/hlDlSX47uW4vWf6nW5i06l4KADn9plw+37B2c0hNRqq38GKA5AGt?=
 =?us-ascii?Q?ARS8Ff7cbJew8DsDWRUM1E4JjKwGZp6oaDx7M3EhgD3LPalh+qCKaZfCOtXa?=
 =?us-ascii?Q?PSBrE2arTU39GmAQwCVAshxw/dQD4BGdkvtXlC2mFQoLpDjPONqqNkbPQ58m?=
 =?us-ascii?Q?iFLPCilnDs0wWbMbEiFCjvYsiFvQw2U7geogn84mwXUdFO8Mo3aaXfCwaV37?=
 =?us-ascii?Q?wl9Nzv//d3nd37wpslGFaiRPyITSvQBHJR7I5l2vDRku1gVTaMAAigencQvs?=
 =?us-ascii?Q?xP1w8LIWBg0huUBREuPPTsfz6B05GQsRwfGCkDUA3D8dFTBLu4le41lNzrGX?=
 =?us-ascii?Q?zxujmQ1/X6gWCjEL6B2b7xqnUN2wH4FG+gy9Hcw0uKbua4VFHPw3UCFN3Npf?=
 =?us-ascii?Q?Bm0vRMJmIcGapj9gXoIjTBHYmHtfIbwdTeScBtAh8lZ2r8oAYrz7F2RCYJfj?=
 =?us-ascii?Q?5MCL8+BndJ6HJrncXSWKC/dTUS4n4bA/X+2Frpq5D24LUU+iv5hE1stIzDpJ?=
 =?us-ascii?Q?/zu+2VEotYWXKpY7U4g2cf+0bjrEvE+uJL9OB1p0OCWW1DpQvptjF309tkRp?=
 =?us-ascii?Q?0GslLecRjEl7lj8SHn/Js2ktn9gyT5hPs/P5WFwZVsczeU3ZcKGabJ9WRw/R?=
 =?us-ascii?Q?ZqWvj5hlkqVau1FJAbHYAd0fVPVFi2I0ZJUEzkpMTM7f+3kvDhZTffLgGIEb?=
 =?us-ascii?Q?06/6S25jEMi3f4YlY6ostby4LvZu/h63hI0rTNpz9crzrwpXDbv5/2YhVmcU?=
 =?us-ascii?Q?MUO81m6E0VNeMBhjcU9MjmLM2lqVHcpvh5PIvJsZPjxwBHrwSNZUyxZjing4?=
 =?us-ascii?Q?DAwZ9RvrzKrka8w/plmCUwT2HpUfD5jCkVH2K/e4t4ZuZnR3hq7O9FnHb25F?=
 =?us-ascii?Q?8ZTE8bihw1R626yq55zk93Vh4fZAt8/7+Krbyr5WdyWqBX5hsjt5DainUPyN?=
 =?us-ascii?Q?YFSwP54EuZQNEg/wO2xcINSn6upQQBxKwRqUkee5M85GGrZmZhYGQdxvIRj9?=
 =?us-ascii?Q?yhSTM5/v6NUKGYe7DUwEeZmGimioOPHKNqMaR6HoIIIOSSqGbOOPYbyIM9yW?=
 =?us-ascii?Q?Ue/ApPyz0r6B1jPvj1hkTJ/VtaegBDcmYqM8ruXxp5SsdbkFT55MOv2RQ91m?=
 =?us-ascii?Q?AkxqnFaPqq3CRUXyIA+hVsmHe5tYps3uuYF4XGSI3U9j6ZXuZWKIDhWB2w3T?=
 =?us-ascii?Q?KRwfYTXbcrSnaYpNwTmamjy//RlHKutRkwch9g2f8OlZY4qTOR1jpOWrvoJ2?=
 =?us-ascii?Q?FK+7nb62Bh/0WhN99wh6+0vW+1f30Ka4i9GJYpQY+TdR0vvS2FqTB6I6Z0Lq?=
 =?us-ascii?Q?tP3wW00XkJbM9vo027s84fU7VEhMUVNC+NQWNTHDSuwTvq1PhspPWjPIAQNY?=
 =?us-ascii?Q?YGpxfUPDLOrbmYIsXdgFn2XeqSeCkDOqz4ULVSrTGEszijt4eDbFRgpxHzyY?=
 =?us-ascii?Q?P+I0dgmoto0lLLQkGu3PGf5jRpKRqbN9nkb9Epv3W2Rq8Ag5eTI3+DXh8ksK?=
 =?us-ascii?Q?1Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b89885b0-6c98-4501-7104-08de1c5837c4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 10:43:55.3947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5aeR+dQAvwolAfoWkMrHb5gvddDRXERI2hlRxfK8M0tQajgt20jmrbhnE+8MVO4FttCszUqt9eeoIAtrrbsDbJ3GHP+5d91gk6ObUToUTBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6177
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

On Tue, Nov 04, 2025 at 02:52:37PM +0000, Medvedkin, Vladimir wrote:
> 
> On 11/4/2025 11:15 AM, Bruce Richardson wrote:
> > Build error reported with GCC 16, due to a set but unused variable. Fix
> > the issue by removing the setting of the var and marking it as unused.
> > 
> > ../drivers/net/intel/fm10k/base/fm10k_common.c: In function 'fm10k_unbind_hw_stats_q':
> > ../drivers/net/intel/fm10k/base/fm10k_common.c:480:62: warning:
> > parameter 'idx' set but not used [-Wunused-but-set-parameter=]
> >    480 | void fm10k_unbind_hw_stats_q(struct fm10k_hw_stats_q *q, u32 idx, u32 count)
> > 
> > Bugzilla ID: 1822
> > Fixes: 7223d200c227 ("fm10k: add base driver")
> > Cc: stable@dpdk.org
> > Cc: stephen@networkplumber.org
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> > ---
Applied to dpdk-next-net-intel.

/Bruce
