Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CDF1075270
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 17:16:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 594C340431;
	Thu, 19 Mar 2026 18:16:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id F2AD24013F;
 Thu, 19 Mar 2026 18:16:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773940604; x=1805476604;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ZHNtN5W4n7jttrTPrgOPh3uWjhFwm5tL3WJNCDijA9E=;
 b=krmwCnpVkLW3EDL9Lypu8IQfIu4IocaYAeCfhwxi/jz88aeUm6KDduyk
 HkFilI4+20NaBx7c6DIEhPN2qcZwll7cisg6Sx+VRdzJRLa9rs8wDHX86
 T8MVdLf/UQUUknC2RvwoIIzw0dV9oq84FBvzMGddMnuh+jWVN28iIIwN1
 pbfF2wxZOfzlgM4DKxtehie+lwikw3rsCaH3bzCOgAc+YY04O12awIPg6
 45bi+Ikv634Re2iYgAV5JoJ1K+W5dTblB2GVYGDLs14iFD6+BJyoAQ3CZ
 9FYZrttycF2PsLMARROgsAwxKkpQb6UdCbQAR6INx27i4HbxvafxUCr/T Q==;
X-CSE-ConnectionGUID: hAS4dz52Qbex5pXn+sWcww==
X-CSE-MsgGUID: 8tOEcRBCRMaOolJXjkWEnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="92403814"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="92403814"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 10:16:40 -0700
X-CSE-ConnectionGUID: qntV3aWBSAyF9Tg8Y+LLaw==
X-CSE-MsgGUID: bqgAFODRQBiCiRDpeYYbXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="227515829"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 10:16:40 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 10:16:39 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 19 Mar 2026 10:16:39 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.40) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 10:16:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/2UlAJXjHcoZD4sCB0eHU5b9TEMdlGfltW8qcVqXeMBYhxY7VUhgz7tfKA0hJUa9TTYn+90PitVCUVZWZoAofeHDrtn2pC3QtY0lSpqu7X2tTh0f5FYmN81kYOYPBnDDrQ2H+SQCbg64VPz78B4X8ccqkmCZPs/9a+BJ2FIh6ydOvHN0fO/06jcbierEd+v1zR5FZIUm1znchrvWptfTB+K8eqNwpMer3fjDEZ+FfGMa8sDMzi7DeGMn6j6j74X5KF4cfWuQnPyob42KLw6RTfxbjmB2v07gPexXpB2m9Pj7emEKRkaAlAVZclqceO2qCH5DTUmoFbhuIzMpLVF1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XEk6/qFlD6o73npVKFvIbDv0ejdslB6g1mH3dENPgw=;
 b=YaakTBgaTTITOaNMn8m1ryoDNBpXQLtxiMcrP8qQAeUiwFKEOyqIz9UTVC5GpWCrORxsfyhizVJDLCWH/Lvm1JR0eFAK4ynZWZisOgBgsC7aGI/hltNIezkXBUkjoa0XzqQoIJFwoUFzDVyV1uGflQHP3PpzIJzbriZt7XrFEUR9EV78R0TCIbCpAWOjev8YS0xOj4BMXG0kW9kRCeuBMcBO/N5mpDEsj1oZFZMlfdTbuNX+zhMtherdfjA3tMgjAcKqUA8naf3h7bmqQuOT/SZlN1TBoIrCl3J9+8TWLom0JOTi7s8bOFg3g7viJdTzlVRwbrPVJS0/oIXiJ9aD9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB7090.namprd11.prod.outlook.com (2603:10b6:806:299::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 17:16:33 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 17:16:33 +0000
Date: Thu, 19 Mar 2026 17:16:27 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
CC: <probb@iol.unh.edu>, <david.marchand@redhat.com>, <stable@dpdk.org>
Subject: Re: [PATCH 3/7] test/pdump: skip test on FreeBSD
Message-ID: <abwva7QN2pBRD4Jz@bricha3-mobl1.ger.corp.intel.com>
References: <20260319171334.1151425-1-bruce.richardson@intel.com>
 <20260319171334.1151425-4-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260319171334.1151425-4-bruce.richardson@intel.com>
X-ClientProxiedBy: DUZPR01CA0035.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: bdd02946-e674-4775-aa7d-08de85db4491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: Oa/Zc3dybC/7SzWp83X+5C8snJmeDqPZNJod2xMdFEWLxol+meXGe6QB73bx9IzYasgz04R+nsRMg7fGqEA2RgOfx4FmS4L0mLbQRyOU1IwUPMXRZWSz9dFOtX5+jlFNq0mEj495KG8N7MyAdTjIwyh7LKZICnARnAYV1SFko/xh7Ch9tl0RGNXLTsSIBcmbZDk5wbkHN2tGQH56tqaPqgRISTckvso5pqKqrv9RFgttHVUb0jEZlP36lc17Ve3acubhhEKLDeVKHabpKKVAKDa4tfEnh+wGMXKedKARgWj5HRl7kdQ7pD0T96/sJSVOSYY7wJkYLu/c5CyDe78zyQ3QWQdMpoMhb0LH6q3G5tWdyn45x0crrlcNIowj/DH6kQTYvrELdtOzvw2yL9s5r4jzkkctRgGPWnj4FCliqG7qESqFxCZsCPT9r1otxeEhuazV6JFKftJ6dC/9VGmC5o9l29kuuLyHct9A0ytPUcKqbDgh6o2cfeR1shJ59k0twtWCBYWGC0LKGbklc1HH+drmmdEueesd21WPNeQ2ZkljLxAFFbYiFibg7bkVIv0g9BcWso/UP7ru4gYYjj4MWf+W/fA/btDts8RinNE8wvLv6oowrGqMzR1Uq8BvDmXqbWNTHhc7IXy3CJc0hwO98d7N0NuBS28+hEzI7H+iS21aOAfxbkEnqyID3jkJvHc+J3jzNFYQPp8Zuk/pj3AsvQy7ChH6AkcgUGZ0IzLcfjs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?osG778fPfWs3v584g4ILRZlpBZkbRsRiSlCiHcfjNaaxNEqYEgnW5sIVZO7n?=
 =?us-ascii?Q?PY2Ajt03EAUKnCenUTsVDk7qYJkg5DcvRCBpkzFQxzGI2HMhnAKwUYTgg+cG?=
 =?us-ascii?Q?0tkPziR+QZOYbHWk5QFdNYsx6wtfp1Xscqtkmqlg95zA+QuW3BFDEBxfmH9t?=
 =?us-ascii?Q?ievEcUS6ScryGiEm1ujeTaKs971MLWp/GA/mxfcOTKMeKId8yeSQ1NsU1JSO?=
 =?us-ascii?Q?nW0+Tbp/i8kN6YdpUqUt83Gsmz/FxwNJ4nCzEYSW7q2b7McRuvxx8tq6t8Ma?=
 =?us-ascii?Q?YQUmmxg32F6gbs9yv1MK34WJZS6wzX/MiyyktLSZmPmj7cmHOFeA7Z3HcWkm?=
 =?us-ascii?Q?DIuuuRcFA8wsdcA5nRNQpOFAyMkBqjpINJABafjdHVfY7ejekhPSg7i9ThjE?=
 =?us-ascii?Q?qxy9sgat7RByDX1Z3u0LmNoSW57PEcodL8hiogHpEpKQwu7EMgIGARHIYHAH?=
 =?us-ascii?Q?4FJO09Oz7N1TZR2x3EXDN2f3qI7hIzHhugvsu4c5BjBv/jk05Ewf74e+2BgO?=
 =?us-ascii?Q?a0jyh01W9YaCzjETQZl/63d2QN74ouevtwwcU+hnsqjw+F8HCSrajiPqWE8n?=
 =?us-ascii?Q?3OrfLxyKiJPctlzqJ34i3n1j/b2V+drn2Chb7dxxB9RlnOrwy1TUoRcizvkV?=
 =?us-ascii?Q?kzBMvHZCaLwJoQ/ztOTP0uthWEnhVaEuFiXhCuezBCTVv1qleOY3nfALbfB0?=
 =?us-ascii?Q?wRnJeGTz1hWM5/UxDtZJwsTjwIW0UaBt8OlMnOUTcZf6SJ9cNHaarZ0AiMPY?=
 =?us-ascii?Q?5u2SVgMZ3bNv/DOyvFvuNTveTi5tBWIj19uHZXFAuMo2X8Tx7YJvPHcXNFiE?=
 =?us-ascii?Q?BCM2eNXK4zbTNCU4pO5RGeagHLWMepe+9zfrGztbLPq8dkzNNM3YWbuFZKRZ?=
 =?us-ascii?Q?Zfuxi2yWeqCwEAzXbSHkl45hoAuxWXodlXBxYDuvDSO8g+zMfs5huVCH0HNS?=
 =?us-ascii?Q?YHi+Wi5Hud0itBYHRag+XvLDAsOiGUh3C+ZLzd526J7t94/Omj7PUIpshDPZ?=
 =?us-ascii?Q?n7FaUVpSbmqESAR80kQkdEhkpkkn2RkCXisc+WdaP3GFDf/pSztmXDjxq5KX?=
 =?us-ascii?Q?pxNmBHfrKq2abcCyTYmUdGomL8mVbF+YtP0MDfa/EjM8M3MDjH0sH6iDPWWU?=
 =?us-ascii?Q?nsucbjUfZXyjROhf6C9rMbxcwpvP9moiHEyZxmYwVTw3AsYnGi1QW9uHxvBi?=
 =?us-ascii?Q?XalKhmnIAOqeuKU1NqMmk95M9C4D3pxrudGi3Fr9/EM2KcUOBLjGSWw/kg6G?=
 =?us-ascii?Q?pPuvqD5K1LNxdBy8XyLpYW+n6lRVdOEZ3FiCpJ2w3RrdUSMY+UpQeaDny30D?=
 =?us-ascii?Q?nnPp0cakZW9W1VOYNiqRfnU+z7E1mG5qVB2erPLQxC6U8KJSs11H1XVrd4DF?=
 =?us-ascii?Q?fc9N5/08lvmvQM5TXZ9Gsk/gJZZfDg+FfLnYW3mssjSnPXf5krJ2iYt7UITf?=
 =?us-ascii?Q?OFT/YZi3I9L9WFU0KMBiaQA52Um+6ay5iLPaaXavQsBcvpypdMejeIu4faJs?=
 =?us-ascii?Q?fM9qFjQHY1038s62Xn+DQIcm+wWxdpMUusGoSEMEB2J9Z701MXr/7pxkpCQO?=
 =?us-ascii?Q?h5vlUCdVnZmX5cg+Z3wFOpPS6vRRaUdhTws10HYrjqwaTXJweiXCvM3JXVqq?=
 =?us-ascii?Q?NT9ZQHItTOq7VeQ398GRdWKPWsqNzc3pfSFidKAnbg+SHoR9IV0chdifHyVW?=
 =?us-ascii?Q?oyHmMhd8lrJS2flqxWIcYZp9Q9XdM0yAaYmUI5fx4Jf3hWRIewnXDnvZpzXG?=
 =?us-ascii?Q?BcPRNa172drAcKP6BU64A9qbRMgLQeU=3D?=
X-Exchange-RoutingPolicyChecked: YzQOuJGT2sg732geMLpnvArm8BDGqhAP6Nml+gsHZND8AgN5yxd7lrH/K8rM0lnhqoYrODLknJuBUlpMtOQnj9xGOxoT/cv7Brb8iD9BS0AbezWCZIAvasO2IVmYeUKesvRXULAp/aln2R7/IeUWzH4kqzRsSVAF09EA3bxQDYxLs1iEYmsU9fbE9CcIN/Y0wACB5F0LTpVhaFo5NUadTQA3l9YHsjvvNbjxj7+AsZURYav1Sr2uRMCgb5pTy4oIC4ign/p0b9g0Fa06cRdpCbpz9/Y70Zg6jSzbQ3wkFlep4EIJt6vfq5N1qr0vtYBbYde7IactEluVIR4FtWU0jg==
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd02946-e674-4775-aa7d-08de85db4491
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 17:16:33.0339 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xtg3anXRaJjMRw9rfS8+VvlBfhjMwL4HIzuk2vhKX/AZPhW5lWJAwW082dYT96TktGMvE3tjPPvK3FGcRuInCW7Ty/pGH7rLi/SA0vvtQdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7090
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

On Thu, Mar 19, 2026 at 05:11:37PM +0000, Bruce Richardson wrote:
> FreeBSD doesn't support multiprocess so skip the pdump unit test which
> requires multi-process support.
> 
> Bugzilla ID: 761 (partial fix)
> Fixes: 086eb64db39e ("test/pdump: add unit test for pdump library")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  app/test/test_pdump.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/app/test/test_pdump.c b/app/test/test_pdump.c
> index 824caef2d4..9d1175b4b0 100644
> --- a/app/test/test_pdump.c
> +++ b/app/test/test_pdump.c
> @@ -5,6 +5,7 @@
>  #include <unistd.h>
>  #include <stdint.h>
>  #include <limits.h>
> +#include <sys/utsname.h>
>  
>  #include <ethdev_driver.h>
>  #include <rte_pdump.h>
> @@ -197,7 +198,12 @@ run_pdump_server_tests(void)
>  int
>  test_pdump(void)
>  {
> +	struct utsname name;
>  	int ret = 0;
> +
> +	if (uname(&name) < 0 || strcmp(name.sysname, "FreeBSD") == 0)
> +		return TEST_SKIPPED;
> +

Self-NAK, I forgot to update this patch to just use
"RTE_EXEC_ENV_IS_FREEBSD" instead of calling "uname". Will fix in V2.

>  	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
>  		printf("IN PRIMARY PROCESS\n");
>  		ret = run_pdump_server_tests();
> -- 
> 2.51.0
> 
