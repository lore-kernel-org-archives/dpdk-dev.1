Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C904EC110E
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Feb 2026 16:56:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C6BF4025E;
	Mon, 23 Feb 2026 17:56:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id D1A12400EF
 for <dev@dpdk.org>; Mon, 23 Feb 2026 17:56:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771865770; x=1803401770;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=JeEqkyueI9qmuxEkl+UJ6AqK1aM0jk9BLFy6P3ZZegM=;
 b=PhtAAl2NO0fUluGzJivll/3DrZ9fsMVIarkaP5MoKkKM3yIRTIbYBFCi
 JR3BQQmGkiG68ZE9PpnxG7rsl49OPyNbELsNL6hA17+gD7fdLzs9PFUHI
 i/SF18YRPYZcgh08dDMoLlKDVMByNi5FQKDwq2HZjuSdAJKVLmHQKlCtd
 g8c0ViC0hmUYF9obAVjgeJ5PRBoFMOcPUegbqKrRvPKBt2yZOauIKhGVr
 81yvUeJbHd9FGoq3kMcHxhf6Z5Yan3qi/kPmDXBOr9yYVu57dPtDs6ulV
 RUucvf6478T/whocPCAhm+jKCIujU6dZIL/faLagGDd7ZLF2YN+zMG0hw g==;
X-CSE-ConnectionGUID: obTd36LBTV6z/cr0gmjwVA==
X-CSE-MsgGUID: kwWZYgZfRX+FW908z+bC0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="72842582"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; d="scan'208";a="72842582"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2026 08:56:08 -0800
X-CSE-ConnectionGUID: /qCD/xwoQvGeFaviuP2Vpw==
X-CSE-MsgGUID: IvpJMoz2SP6ja5NFfUviNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; d="scan'208";a="219159520"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2026 08:56:08 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 08:56:07 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 23 Feb 2026 08:56:07 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.25) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 08:56:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bk5GfLD6Puxo/jddj2iea+4cAi+j16z2p5f6MbdmPWwOizY0w5FuHMqziffmZpr8aX6OGKdc1MZ99mh9JxwA5HbWYfxMjvtfyOjsCv6FXvaU5T9iT63jv0Bzn1OvhGI6lrqYOIgz9qo6jXQmwqxO9KzxayfhaySRK1YgNsp6wvR0M2jG4CTh8232Lb8+rvEMtVA66Wz9SBK/66FDqiqDQBBj7bcEzxKx6cSMGLubZGHQ4RD4cGSN5uPT7Kr2/Yec4ALLDvqRpWuXvOG6LhUbl4BSa6KtTcdvvIMCW8vtVWKBtlWj0P6ocCGyktZl3n/nSUxCxRiYfVCVKsF51Jz+6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HV/RLN0lbSiSyOSvwiuYlFXcoCf0F3mKXcA387aqaE=;
 b=uwvVeaGK8nvZjj2o7AhTBbj8dIL1yVQH6idI5oRh/aoc5qettK/wBObOikOvqL+w83CcqCWEumXl2Q+ydRin6x18JvV9Voefn6nta+rz3goJBzrtdQm0QJAAcfrVkNtUndW8+uG2qiGyGoD5qhyMFZQy4m80W7ud/t3wYK3N4Cevnh0oNPgxKaiEfJ7Qicb4f0ZyUmNZ9i1wFNYofOBV00V3LfWWk7K5G4X1aDJ60ow5lnvb9gmDil/Z4ZgNtxhtvCxcdbn3eyN3B1Z8od2WNzXiXGcFhXadoOrkQHELSf5o33P1BHuDf+mNdRkFR3fSikrWRA76xazutfo12s5WMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BL3PR11MB6410.namprd11.prod.outlook.com (2603:10b6:208:3b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Mon, 23 Feb
 2026 16:56:05 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 16:56:05 +0000
Date: Mon, 23 Feb 2026 16:56:00 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Marat Khalili <marat.khalili@huawei.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>
Subject: Re: [PATCH] app/test: simplify getting the current file prefix
Message-ID: <aZyGoLDWXJn-pPu3@bricha3-mobl1.ger.corp.intel.com>
References: <20260220174952.2647744-1-bruce.richardson@intel.com>
 <3ea36267a2594b27b017284d0eba2a30@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3ea36267a2594b27b017284d0eba2a30@huawei.com>
X-ClientProxiedBy: DUZPR01CA0128.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BL3PR11MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f503f12-d8fb-48fd-4032-08de72fc6ed7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j8TqBSiIenljxFa2+5QYTEOyTuGE7r7MSWLGtFZPcrUxf4MRziPYs7We86Zh?=
 =?us-ascii?Q?6UG052KghFEUAeeU8FFW3i/MJYQTF6eD6ubX3VLf14efLcyShhqlOckwkZU5?=
 =?us-ascii?Q?F+nmIgBC9tk7Mruud5F73mznstK1nWVWkBIKCCZRJggr9JRQgJa8W1MSrVZB?=
 =?us-ascii?Q?ruyfxy91i7R0k/usCeSE6hZViMBSkAFzSajfbonNxc7NvPUsb76/NHbUUawD?=
 =?us-ascii?Q?aw+CTTKxHai9BDqZToSZ2FtTAwhIiBDCTCtWJnW71Tx8R4z+kvlPAn92g/u1?=
 =?us-ascii?Q?PJDapQD39lhDR1JfNbYvHhmsOGgRoHIZhtRssmvEFphDyr6VTRP4iNBAVZIm?=
 =?us-ascii?Q?iGayL5QJ+anmOdksPT3mHbgGVwFtvDvrgOHeDZMa9n056xQqysQwVNeeWvVR?=
 =?us-ascii?Q?lZVneHWbIyolvl/5MYbKM84/Ki4YTp9ha5HWXwvglslSPG3qGiNDiel1hqje?=
 =?us-ascii?Q?i4LtP9MGsVgbQvDmflo+OzbzN1p/BK3gXQo29xtIKGjZaKEkeycaaI5slo47?=
 =?us-ascii?Q?KubaaGRow/CAhF+CSCjiOvsUN4+HtF8HOOxs2NhibC8qC3ZSomTjVOInII5t?=
 =?us-ascii?Q?H50Z+Q3tkXi2XOFMBJIwm9Ol3kuRnKxlO4dFt8LFSwD49LMfwIqEh+F43Sgn?=
 =?us-ascii?Q?wVXu+MQKMkNpR1qvr/GnyaZ79MTKY5Mav5SVxIo1taJ1O983eBOqfZIH40Hg?=
 =?us-ascii?Q?XRnnJzmz/y9aAnBW7ciIdYXgZR2yjq4ZEusmAD7icdHmy9eBP3gjEbcUa1ZC?=
 =?us-ascii?Q?1ywqbEkwW1TPNn/xhlzxw5PQxAp/JihaM0HK7m768R8Iw4rkAYsI8wd137mF?=
 =?us-ascii?Q?fv45O0J3BH/xFXRSRMzA57tU6Sm1XS3F0nRrHO420K5gZeIXHS2bUCMAGdDQ?=
 =?us-ascii?Q?m0Qj+fgYxD/OTQElXw/MmoaZkoxK6vsfRvGIQtTkIsjr9Gxh/vP5ZKNx0a4T?=
 =?us-ascii?Q?Cldq6QtAb8qzoB72aXKnNvQBgIJdn+Yl+eh1u1Oc3u6etf7OEaqtk0DXACDQ?=
 =?us-ascii?Q?LEf4QU3QfpjSSbxA1jqL4/w7UZyjSFfGYSJNx4MAE0/UOaxnSFlekp+5HvZd?=
 =?us-ascii?Q?YFz9PiEpMQ4wuFJBh6F6OP1Z9nALO7cGAqAj99vqx9Xzbwu8oHqTwvwISkow?=
 =?us-ascii?Q?XUehl8NVgmCoYk+VK/Fb/quw8VRkaBbIihS8myZtNyn2XqcV1FIfUdCV1GRT?=
 =?us-ascii?Q?iSC45DOCUjmwDi4h3PewncwtYocnlqBWDsYqpaIdz5ej3M22yrxuYg7h4FQ2?=
 =?us-ascii?Q?qCdYP/lMWEETdLzoCWj+bPUKztm1b+d5FaOtJcPnDNM5rx6EHsYuFGCXLitc?=
 =?us-ascii?Q?99yMCh/lZHhx5VDU0A7KhThzYq0LWxsuiyN1mLxhQGQLx8lQ8iGVKLXbujVu?=
 =?us-ascii?Q?zwRKxr+tOVmuWYgw4Iozh4OF16KszMlvGyEyMLO7Di21MJF1q6pw71/FzvHL?=
 =?us-ascii?Q?5sIJW97ziyFDKrENZQfmja5O9+nhnmD7CIBitt5bVlYpaVWfgIeyUDB3i7Ki?=
 =?us-ascii?Q?ef24V/GzUmCRwSfIs4ADe0VA93qvi2dlFAj0aEBh3VFj5/XIib0ayZUi6J3C?=
 =?us-ascii?Q?O3nnhKjfF4n8W/UQwII=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EqAmo1x6x9KCotfYH2NiHkMNPJM0fV9VGO+VhMTMW7aY+mrQ6V0zYgNVo0Wu?=
 =?us-ascii?Q?B5VAyPeEV+m5pBc1vIhZAW3tVdd6W3NUtKaMEXPySIYOHUYPU/qg4qrjMyBD?=
 =?us-ascii?Q?xCefp3FrjndzQYGRpFv5rpS7o3CLYYBzBaEuad5XFmVHaXQ9cK6SG5cG4GWa?=
 =?us-ascii?Q?gt807QCR4imaD0R2WCabI8NezCt/1z5GNxxEKJxEAa9f23u9NhN0Dac+gR11?=
 =?us-ascii?Q?Oxtn2lvGyxFcG5ItiqrMBjl4oTF1x045HOd9cBMd6fVJMMz3jhqje9ANB4D+?=
 =?us-ascii?Q?CvIOhKX0yGpG8pPsNnm0QbcXi0w82ijGHylMo/Xhb9owtyEg7aDe4V7Jd4wR?=
 =?us-ascii?Q?WEFvIEP8qrXbkLgiendMRa514RMJ4IjdQCWYuzvvY9mY0aiczmWLjI05rK5e?=
 =?us-ascii?Q?/XJgwd/87626uJTRjhh3HpNik0y76cSW8RZ2h7zdyK8ZieQaghT33VF/Zl/g?=
 =?us-ascii?Q?JMU0wgN1g1TO8JikbeiUsDwOaz2KezbCFFOocXsqr21vtUi2l1JUDjgwyijd?=
 =?us-ascii?Q?KCsrBprsSFImAEX0MPLkd0Pe9mDL45JBF40uLB3FEsTso39i72IY1zcS/YUy?=
 =?us-ascii?Q?gE75PXtmV6tV4FuFwgnaZZGBYP3Ou5qKXpnH5v6C4tTanj16TmES26tnx5LI?=
 =?us-ascii?Q?bl3kTlYFgsvI0Jq06+aYu90oVPIFfMatf9NyOoRJtTK5AQI2GI2N8RuhPB68?=
 =?us-ascii?Q?MLi6JOIfK1DPRHJogj+lEqm0UDpFLuzbLsZndOtKAYM9SywZMdGfHati57EM?=
 =?us-ascii?Q?7pkwD4whi5py+itqlMhVQUpSO7mX5xcvpa9bfnuxXF6KDRrSIH+dHqxINNBG?=
 =?us-ascii?Q?6R3l1xcatMXauvNIfjhocQqRzJq1sHjdr9ywfMj2Y5UkwlNxBZ31+zVUHG1Y?=
 =?us-ascii?Q?PBcbE9Q5C7bKA/ivI1JujpeJHMD7YwsCm/OxjEpbD7B/xXUjfm4Wxv5dYZda?=
 =?us-ascii?Q?iSfiloQjFJL7N6bUdSLqfhSKF7thDRd4EoU+tYZ+jEuE/I93Dac1FjyzLqVQ?=
 =?us-ascii?Q?FwezUIMRsBGPi/CGvPmiqFN1ARwyfa9VGYERA/a8r7quzZTvL+bA0kDGMtWk?=
 =?us-ascii?Q?RpvIEfl8npq1oGv57y06FvdGXRHFIxDYEHhcZFswCXOdJ5zlsJ7RN8d/Swvr?=
 =?us-ascii?Q?Wwmm8a/n67nqSPe9wQvSIGEHrX2KkEOtRxDxnIvagLgR8quJmHflRa/mV4cP?=
 =?us-ascii?Q?h8HJe0cWwoR8uwa+0qOKtUM+yn02f/jEx1vfNiK9FdRUd+nDqItoxdot4+RW?=
 =?us-ascii?Q?wIJC2dndl16Y7eEeHsrD7ornhhHZ3oIrgMGUpymLNImq9Z6EbNXky/g4a7ri?=
 =?us-ascii?Q?lOx3nRV6TaOC2OEAxI5o7ZpH+U2vDI0iLH7DMgBWaGna1l5gn1uf0+QcGDtu?=
 =?us-ascii?Q?cuKW4pVjWIuKClWewb9Lk5SoZFaC964nZgG8BVhKVDkSQW5WatopC2rGk7N+?=
 =?us-ascii?Q?dKQSeM1aGbI/kItkU11HR6MsC3SNTxZ7R9ccQIsKMESk+eqt9rm3UbpqyUdS?=
 =?us-ascii?Q?GEkRQUSugfUc8xZM2uoBmJn2DGzuynKVmBMmCQJPAqH+euvNL9/woGDIzwm5?=
 =?us-ascii?Q?gb77wTSWWuBVNMD/lMSSivWym/8VX8EILwmbyCFZcjfdh9K1a9eCTzjH/zm9?=
 =?us-ascii?Q?ue/UJjFraFDE6OzKggFW4llhIvqz+TKjbNPhkbpxTiTIAA0FPH6eb9Rr3EnD?=
 =?us-ascii?Q?EAOPXCHQjzkv1pPJpAIwIfsEfuyJ6UE6EM3Zy87Pf5YMH1todTCGq6xJ0xVb?=
 =?us-ascii?Q?dumVUlIGqz9MdtCZBIaxV2a42KQcA0U=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f503f12-d8fb-48fd-4032-08de72fc6ed7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 16:56:05.2563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BWA1EA39hWvD1qdY9+umpRb/kB9/YlomS9E5lBk0Ano92kF6XJ4QAezbjE+jl00hVmgyFXjJ18yCFZ8tO5dELZvPMPXS/3MA7GdsF7v4Vw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6410
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

On Mon, Feb 23, 2026 at 11:21:30AM +0000, Marat Khalili wrote:
> > diff --git a/app/test/process.h b/app/test/process.h
> > index 402dc4f96f..1ab5671943 100644
> > --- a/app/test/process.h
> > +++ b/app/test/process.h
> > @@ -8,12 +8,11 @@
> >  #include <errno.h>  /* errno */
> >  #include <limits.h> /* PATH_MAX */
> >  #ifndef RTE_EXEC_ENV_WINDOWS
> > -#include <libgen.h> /* basename et al */
> >  #include <sys/wait.h>
> >  #endif
> >  #include <stdlib.h> /* NULL */
> >  #include <string.h> /* strerror */
> > -#include <unistd.h> /* readlink */
> > +#include <unistd.h>
> 
> Can we delete it entirely? Compiles for me at least.
> 

I believe there are still functions used from it, so I would keep it for
safety.

> >  #include <dirent.h>
> > 
> >  #include <rte_string_fns.h> /* strlcpy */
> > @@ -239,17 +238,7 @@ file_prefix_arg(void)
> >  static inline char *
> >  get_current_prefix(char *prefix, int size)
> >  {
> > -	char buf[PATH_MAX];
> > -
> > -	/* get file for config (fd is always 3) return NULL on error */
> > -	if (readlink("/proc/self/fd/3", buf, sizeof(buf)) == -1)
> > -		return NULL;
> > -
> > -	/*
> > -	 * path should be something like "/var/run/dpdk/config"
> > -	 * which results in prefix of "dpdk"
> > -	 */
> > -	rte_basename(dirname(buf), prefix, size);
> > +	rte_basename(rte_eal_get_runtime_dir(), prefix, size);
> >  	return prefix;
> 
> Do we even need it as a separate function anymore?
> 

This function is used in test_eal_flags.c, which is why it's left here as
separate function.

> >  }
> > 
> > @@ -260,12 +249,8 @@ file_prefix_arg(void)
> >  	static char prefix[NAME_MAX + sizeof("--file-prefix=")];
> >  	char tmp[NAME_MAX];
> > 
> > -	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
> > -		fprintf(stderr, "Error - unable to get current prefix!\n");
> > -		return NULL;
> > -	}
> > -
> > -	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
> > +	snprintf(prefix, sizeof(prefix), "--file-prefix=%s",
> > +			get_current_prefix(tmp, sizeof(tmp)));
> >  	return prefix;
> >  #endif
> >  }
> > --
> > 2.51.0
> 
> With or without comments above addressed,
> Acked-by: Marat Khalili <marat.khalili@huawei.com>
> 
> Tested-by: Marat Khalili <marat.khalili@huawei.com>
