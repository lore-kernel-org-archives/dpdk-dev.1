Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B79BC44507
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 09:56:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F02F040DFB;
	Fri, 17 Jul 2026 11:56:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 7A40A4014F
 for <dev@dpdk.org>; Fri, 17 Jul 2026 11:56:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784282168; x=1815818168;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=RKnMSFFxUn+frgV3QGKgTYtXDqF9depLEIi/QI9EIpU=;
 b=PxalQ3QADm9WyKGOQtWe2+uuvs3don9wgDVsi0MVnaQie4V8Tm0eAe/e
 I00djkfgMnUKNfRu26y3+sz5doC5bLLvhmgGOLpDTK7IR/Xh4Dn2rg/2g
 6XtDcjasC/p1Bor/0uGC54lP44FlzuN4O3DhfZScAJlNnEbrEaVpKneo6
 0tfWPKIWmcVGnuCyynG5rMQPN3FGPuPrYPddvxfPZa2C/LvxMTIUrWbtO
 ZorgJmHHSmofeW/eBbevQvw1fVYkgVzd1I9mMonIdiervEXTCyeGh3uqs
 /7PYn/OpXq5ohxHpmKDBk3d7qe+YkIUIeb715UPPcEetWaCeAouiL6q5/ g==;
X-CSE-ConnectionGUID: DvX0zI9CRdaJRY+lDh8ZmA==
X-CSE-MsgGUID: W5HcpdQCRVKUrfxuxpCKRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="84072995"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; d="scan'208";a="84072995"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2026 02:56:06 -0700
X-CSE-ConnectionGUID: SYsg8VuLTL6q8XSo14R9nA==
X-CSE-MsgGUID: o10MfKFdTZG2TCCXBxlHew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; d="scan'208";a="260566822"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2026 02:56:06 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 02:56:05 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 17 Jul 2026 02:56:05 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.26)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 02:56:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qgVqPXckrz/dpg/NYOjs6dEJDW6xnxG4ua6KjuTKsttz0/Ri9g/Tv1RLC6faj0HSPyDuQm4XgakM1h3aAGyL8Wjikn2xIKGmNQaCy/b7v+rozWkJscokm1e5j0nrt4RzTneNgRTzIX7QT8id2aqMHY+LJVawVMJUD//rLhpQBL0z8fjVaMTOwA3w5yRLJXAoApIbB+Op1GIZvJXx89Iqf1KYUU5yL/xba7WSele8yn0pYTPNzWf4+Jzwbz7zGfvypaKktu0/4dbPi1nrK8dvsxQTupJqZjeDSyXkyAk8v1hhjFCq29rchXt3yTvTs8JB/tCY8baD7YOF9lDOzjWBIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lanvlfKP8sB/HYvWHVIjHLQL9XyJ2VZZJ11obmF1Pgo=;
 b=h4Oww2Eodp5Hv/rFJ8L5G1AIUZcRyHp+9DjqwxqMuIE8JGs4BlvNRnTj1Ebr47q1weGP+4cK8fw0dIZUlnps/PiTex85U0C6BxntwOHw7Y597yv7XvZh3Z2SHJYqYmKZvayvZWv2o7+DwxMSjk6C5kh+E3CotKfy0DZTsQJwmSnB58xqb402X3HMxm8jfHB9qFrwJuhFuadyHPHS83VhVqUIcPhBSOURL19vJlYF7l7iUNcQB5xwzjixiiLkx++Zl3csddwBVBGBt4ElFRdj1yDCpKq8dl0u2wslR7zXIoOT5ruzQCRmq2FuDJJpNMAflwt8KnFnWwFQvBhWu4eFag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by MW5PR11MB5762.namprd11.prod.outlook.com (2603:10b6:303:196::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Fri, 17 Jul
 2026 09:56:03 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0223.012; Fri, 17 Jul 2026
 09:56:03 +0000
Date: Fri, 17 Jul 2026 10:55:58 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 06/10] test/devargs: check driver presence with public API
Message-ID: <aln8LkIk5q74OlpT@bricha3-mobl1.ger.corp.intel.com>
References: <20260717093006.229370-1-david.marchand@redhat.com>
 <20260717093006.229370-7-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260717093006.229370-7-david.marchand@redhat.com>
X-ClientProxiedBy: DUZPR01CA0267.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::10) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|MW5PR11MB5762:EE_
X-MS-Office365-Filtering-Correlation-Id: 944a4fea-7628-46d3-e529-08dee3e99cb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|4143699003|56012099006|5023799004|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5r8SHmVl7LC+Xh/VX90Pgk3wUlA2N9MbvV9jhEXgErtV6AOxD03V7dljY0dJFI16vw44spPTrBjv0MAF+CAofUdZmvc1So20DexxEGMnQ4OB4FXEQiodQn3ZRw/szHS2w3/Rfq/mqcD/dtV4agsw4tl6H9jffq/xJescCvbwomHoPsWTty/BF6V30/dlj9NyjR16Q371tBrZ/uLNP4t1CXhizCYOUCk8yO+iOzNK9d+rA8ynwk7heCC790I0FeeVRpNBn3VEmJQLqP6vwiIIPmZn+JDFLWHys9UTlr8lf+kJZD4dbbVod8FLynkUDYsAcW0RepPgvoBzpj6fMKcElNjoXTwUXde/OHXjmw1fh15P4kMyIEd0i+s+CWa1Ob0l+M3jYiuezG93VlfWrisSBLkMvphmjnT5OtR+ZwN9+Dgwu4M+YEPVsz36U9AOULXTXA1YTksxxZUhbfd9oSWGcm9EZb1n9xgw/Q/Csghp7lf9RrIIdi2PMuY3kSDtWUiCa9aBCx+Zbp4nhKCMlr9g8P4sKXbnobVcz3LO4J40TtrUTAifml78laFHElPvS9dqj7XMS1SGOhN6Rk6LTlyAEbFYjycrGtiOLJtRSrb7KZgS7iE+hmkpKNxV0mAbQKxOBqGj/m6ZV8v0OgkBLn+fV0xdSEs09TZ2uIHLHj7DOqc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(4143699003)(56012099006)(5023799004)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eFQcnV/psD8eoCExm/MkQkk3hcEwvd6REUR14I3VxpyYA5OU/4DlCgAavCOG?=
 =?us-ascii?Q?/fKghb8PYb9jQB59k24NcbfuTsp1I1SDNoEzUCk3gKnhB8W9P7j/lSH+CDCB?=
 =?us-ascii?Q?WL8mY/FHfU3CJYzgolO7ZigJ9ETqoYAqE4BxdiWHdf1WLL5/PvMnYLhOuXSg?=
 =?us-ascii?Q?iFaJeKDBVez65NyUW0IneyWi5MHinAFYnLSbmmKl6Fe3oRkcpGrylAAQAnAO?=
 =?us-ascii?Q?lHIEYFJ8Xcsx4vnXZg0xfpFRa9CqXAY4OYsSoJsXAGBRFnVWYOFtAV0SHxIR?=
 =?us-ascii?Q?Z6e7al/RLw///rkRZg2BM9LNZilTR+aVEwuNm6Y9FGKYuc57cgYsLf1irCLg?=
 =?us-ascii?Q?rN+8QgOsnGe+Tk26KylqapZYB/vsu82S2oHOQ05e5brL2TZS82PN/ETWouPh?=
 =?us-ascii?Q?B+Mh7KpOb8trh3rVNutTQEM57WCXaFz4h6jHsAVLF/tGpbVyKIrl1lNSGmYA?=
 =?us-ascii?Q?FpR8sC95jb0mwbf1DEE1nfbw5k+KVbUxQN00sHxrYQBAkJzFzUuk53BOFijF?=
 =?us-ascii?Q?fD+nLn7b6QbO0ZIPp8DksavLAazTITvNpkrieVI3l8Wu71Mb3T5wC27vWKSY?=
 =?us-ascii?Q?X5KsP5LkQtDQ11p0m9YA+qPW57s5xkhxhE+nr7QWrinAxhfm6Is56t9IoqCY?=
 =?us-ascii?Q?iEzZNLRq9/VFFcnd9jzYLUlF7i1Z1fTxDQ/QRxUik+6a6Umdg8Dmr0rm0iie?=
 =?us-ascii?Q?3zYIjx4Va5SNyIfYm79+L5ct9CvCm0n1mQao6DmpMrL8OzChv/uYlrEMlRSm?=
 =?us-ascii?Q?eGsCjAmGfxCufgmYKt9P58YXb9wvCtAGiV5gXVBmjbJipfU5KnsZgHScqHjp?=
 =?us-ascii?Q?NZT+fQWRGqZO80UZr1OWPC0zAkl7E6XIO8o0tmaXVe8x3zHe0+LkpIFpCIGT?=
 =?us-ascii?Q?bd4IKwdIFW/YrfeQ8xVqDhWJ7LdQava+dlizcaYFfNrmnoWCuAUfB4rA/5f0?=
 =?us-ascii?Q?VpUmeaptK8vHxQaDoDyoVFaOallxzx+GK3emYL5sUP5fi7KFJVkHB36+uHug?=
 =?us-ascii?Q?RCuAUTLX/ceNlkBCdR6d5LMzIPt2yIBF9m3KXgfZW2sd4zYhKylpeNkJWpFc?=
 =?us-ascii?Q?f9Z47f3eqXZqyIfuzPrrUAk/h8Am/KLzVF9E9Rgr17ut8iU/680cYj6Psthj?=
 =?us-ascii?Q?tc1yqlNz+gAJcqage4j80daimoQ8JDroYea+UDMhGLxR5M0R3VMl5cMwJ8T5?=
 =?us-ascii?Q?/b5LtRhNuwXpvtrPxudXzEybIKYlxyPaq2rCfymVqpHaMOMQu8yiByqjDPGu?=
 =?us-ascii?Q?Y2h22Q++vKXplMH+zeO9OmEnHnpBuMpxYKya1fKTpNw6G0d5YD48h6Ybk9PJ?=
 =?us-ascii?Q?s2xDlBvS3E5JYJQGN3Qz/Od3wl2WYGyB7Dv7VfMBUdE4s1BGMgJVfqSqzpps?=
 =?us-ascii?Q?cftUx49mlEAIBMtOGU/CDfCXFFta9zVk3YGsgEFqrxrlLH3CFOE6qy8XdmYF?=
 =?us-ascii?Q?5AVNL8VYj3sIOlLyw0n4UDZDTAPITVIbl5Iw1t0M5MBCQ6eRLwQQEXMDLEBD?=
 =?us-ascii?Q?tMDUEt/DYd0uxz9QemCp24N0S+mCRAt00JPu5hq3zF0r8BRYkf2a4O5pAnwu?=
 =?us-ascii?Q?Beaz9rfTq/GTdhu4F+uIfGmIFwMUy8mgheKacmbu5LArXbUQA6rZuc3oU51A?=
 =?us-ascii?Q?uGHOnerZuSdwIMrDB/OXTi3f8pA3BSbmVcOoLYEp1dDlDg72ZO4ZfaDIu0Gk?=
 =?us-ascii?Q?KYFt/ukDE/vItREMMog+W/cp720qrCNEOKF3L8Kf81J3vQC7Ic2u+CPtkjog?=
 =?us-ascii?Q?I4/QlcCOX3yZjNuCwTih98H9UyijLDo=3D?=
X-Exchange-RoutingPolicyChecked: ojgdNoR+cOsjmb3/SdUL0ofS5zTcFTO/PYSq1oiHzEfp/UKHNgyOQ3Ndr7DnDw55QyJUFOVxqbgRzhUSNPoEBsMebx2TAoNdeyQX2AKIS3/QHNQZ13LwExALi/56/RmW4+ku4UbYHTdp7UunoOgAdAviHF1YyYhos/Vxcw+7pxf6Vr1Ny5BuokJbjtJFpfT2xrzLJAzWuSfuJGOxFXUTpiEIyhUeREfcU23Kr5vTL8HJE864MWzzQGInp3nnCRlnHRPMD15ZNY/VVBy0AlrqOyK138p10lMa7sADaY/qq1eqfI+7yNFjGknJM+UZ4euJe94iQl9F2PX2Nge/swv0fQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 944a4fea-7628-46d3-e529-08dee3e99cb0
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 09:56:03.0258 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQ2hBP4UEbEPvmienk7E5PuVXAyhNJaIy+/lZvRG8v31LBs3fa/UcHkmSflZcUSB2tEhSiIFlZ9DbUrryb6uHuZtjx7xXWpTExfLdAnETY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5762
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

On Fri, Jul 17, 2026 at 11:30:01AM +0200, David Marchand wrote:
> Let's avoid calling internal drivers API.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

One suggestion inline below.

>  app/test/test_devargs.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/app/test/test_devargs.c b/app/test/test_devargs.c
> index 0bd14c24ec..6c194ecfc6 100644
> --- a/app/test/test_devargs.c
> +++ b/app/test/test_devargs.c
> @@ -10,7 +10,7 @@
>  #include <rte_common.h>
>  #include <rte_devargs.h>
>  #include <rte_kvargs.h>
> -#include <bus_driver.h>
> +#include <rte_bus.h>
>  #include <rte_class.h>
>  
>  #include "test.h"
> @@ -167,14 +167,18 @@ test_valid_devargs(void)
>  		{ "net_ring0,iface=test,path=/class/bus/,queues=1",
>  		  0, 0, 3, "vdev", "net_ring0", NULL },
>  	};
> -	struct rte_bus *vdev_bus = rte_bus_find_by_name("vdev");
> +	struct rte_devargs da;
>  	int ret;
>  
>  	ret = test_valid_devargs_cases(list, RTE_DIM(list));
> -	if (vdev_bus != NULL && vdev_bus->parse("net_ring0", NULL) == 0)
> +
> +	memset(&da, 0, sizeof(da));
> +	if (rte_devargs_parse(&da, "net_ring0") == 0)

From what I/AI can see, there is nothing in this test case that requires
the ring PMD specifically. I think it would be good if it were updated to
use net/null, so that we standardize on our basic unit tests only relying
upon that PMD, rather than requiring a variety of drivers. WDYT?

>  		/* Ring vdev driver enabled. */
>  		ret |= test_valid_devargs_cases(legacy_ring_list,
>  						RTE_DIM(legacy_ring_list));
> +	rte_devargs_reset(&da);
> +
>  	return ret;
>  }
>  
> -- 
> 2.54.0
> 
