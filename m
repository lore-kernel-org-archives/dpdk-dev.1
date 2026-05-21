Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C27CD5BAC
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 16:48:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55620402A2;
	Thu, 21 May 2026 18:48:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 77938400D5
 for <dev@dpdk.org>; Thu, 21 May 2026 18:48:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779382086; x=1810918086;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=L/JpkbnUuEkrsq+WqoFL19fAHXzPCQdw/EbNh7qGaRw=;
 b=lmMbvf6qwY9GFiBthXcXtugi3/XEt0Enrwi6Tv94ZsRaus4fNhKQPxm0
 IIU9mKM+s3R2gy4EAPIl8ViOp2i6dHCI3btB0HttZ9+Zjo6N7DlahSjo5
 5SKDGtFzz2TD7ILe1N9k1sjEH31gMHbzkdNoudTFq3+95/DZt+y3ODKPa
 8Z/s3ceYDgKgjTnFgoQ4L3I2BL/DeS44GtsvYsMlB63T5cx1TLjJzp8W7
 9zIDAwYFI7tXs/8SzkU7MVV/5fRq61rozZgXuDNJsMpQZuM6tn9pJH2TA
 jNpUHz+r+stiWjs8hNaWXQ52znOBxoXgQGmPG7pd+31E7WM2dst+7IzrQ w==;
X-CSE-ConnectionGUID: eYP3UbguRzO9HCRv/4DLAw==
X-CSE-MsgGUID: qyjarTspRbSX5GU34Rcj/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="67830033"
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; d="scan'208";a="67830033"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 09:48:05 -0700
X-CSE-ConnectionGUID: i6JXf1XlSaiIyMQAf7AQcQ==
X-CSE-MsgGUID: YmFBnu0gR9qq614utoxgTw==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 09:48:05 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 09:48:03 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 09:48:03 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.1) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 09:48:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yo7tZ2JtcJqn+WmsqHBom5DoFox4suM5r6p70TSFwOREywN1uSZmbhFHo4raEkhXepO8s1sejQqwHJanK49viUc6dLTKLGYYkdarIKXqiFviPfegc4zlgx/rwm27GHltPKwnxIaRPQyz2msnjtWrHu3jtY+V/WV29MO+oXVHhsUpWVtSWAy9lLeA5DzK4C7xcwz5jrki4utmUdpWR4Xp3rhh78s2g77GZjKk07JL5+MaILAF4JzydSC2z3Tf7FVfTUZBhc2/FcN6cIBPb1+pbu7bQGZZFcGIJXVxmEWJ/e+Hihn8M/amt+4gUh7aFJhuFn/BDaOemMVym0xVUafrZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0syRB8AnnFCXeEyukV28ypBezx7qokM257L4Q9fFdE=;
 b=XM02b0YM/mF3KW8pzsp2tQWb//Oz8jVOVjpGR96rRp0QzGdcFn2R97REN8ksQLqF7xam+rDNANd3qYeFXoWqbKF6ryvGpdjyxPWqqdiO2Az5PhbQmIYq43Bc2TOvRm4IiaKtVnXD25CYCsgKFT1rl6vXEwKOds8qYeOOQaqG2wvMJjeWGufxA95U+lawy/pSoZt9PeEThqckBImRoWC3s4dSnfmz5/nD8sU47q2aUz6hlXO9jVH0DJQjGLHojNsrOGVJTTn2CWcoqKqyCOPmfSTJTK3ERsHjzA2kzD3gJz0IWOPaLTxGqM7xHtsYST9EmVUSwnKz2bFNc6NRY3LXSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MN2PR11MB4597.namprd11.prod.outlook.com (2603:10b6:208:268::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 16:48:01 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 16:48:00 +0000
Date: Thu, 21 May 2026 17:47:56 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 00/10] e1000 base code update
Message-ID: <ag83PEjq6YnjQAmz@bricha3-mobl1.ger.corp.intel.com>
References: <20260520125256.354336-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260520125256.354336-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DB9PR06CA0027.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::32) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MN2PR11MB4597:EE_
X-MS-Office365-Filtering-Correlation-Id: cb921f1f-ac60-4b0b-14c9-08deb758b81c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|6133799003|22082099003|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: gFW81HtPfmytc/SpbxqL1mOLqfJ2ovbnwRpEbxAwxsxIL2h+lvOlOSUC/SfVXHHYwuCfuO2eo36wHqbP5o8d0S+no8YSEnwyOKwfZ/7jvsNg4gRo0UiE390a3A9X904RKb3YZhUtvXg1oANTqDbXDt+qsoLClIHO6lOSn2GWxbg61e+2Xdem+XQl2bwf2WvWrX8Mjm6hlHA5GTcCLet6+7tDeEDPQoNeel/nE51TwCtWZ5wbR1rRXTlYrEqJTWQj7+dBOM+s5fhmw4heecCm/m277zs8cIQj7HT8ikEfP2c2SQNcYRbdWiTSlqrArb+BN+sRN4t8vT0GnRY7tYX5Ef9nbnZXKF7xpqPD9rg5bzHJ8gv+XNRWNpDP+d/HE+aoa3GLp7y3FBDY+8bweb2Eh9pnYRgwkev5c6kJbDQK9fx8Rv44Y86+emQqk3MIFdBkinFyzTCgyGyiaQ6cMfLETKxgFyrmuZHU1Au7LsC/hpi9U5Hv54UVy4Icqb9jJJhFE+2JGlYuGZL3eaMuNkBRoWK3DFbvCzoe1cWoFxUY3CBy6o9tFYQZ/di59RYkPKs9qlGXJV5ECh7F9Yq/XH7GyDEbjVs7x/4uFfuzxdguVNPIVXBE1UoBwidnZpavOUHRhQnJU4lzPCdrqrpKZMHb183wS/uKGHVLpX5HxNtSxWW3VUfRgLr1pa/OQrpvMgwp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(6133799003)(22082099003)(18002099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PzDhMISZfo2hi4h2vf3yHgB0cwYkj1f8hFJ4w8UN5UxPNUYdOZ/RG8m7jqTX?=
 =?us-ascii?Q?kKm3/zLFYUiC9erjgs0fEb1dln06zc3AkkqchCJjMKFRIXzfZulXNAYMZM/n?=
 =?us-ascii?Q?smN/BsylTgxzz/O6tyuvlQScc8bMqIq3GqFxJu86Fxmz5CBVGLXNimzzdVVg?=
 =?us-ascii?Q?D5gqjEJEmnd/FqSAhe6tVz1AK1GsHK0rkHDK5GKF+xeTqluiLR8sFbdJp52y?=
 =?us-ascii?Q?9LFve8thF0/9DSEw2OI1cQ1nOsPvVa8mzFKBFezFn716mPPvUpaaKePJdGl+?=
 =?us-ascii?Q?CGhy1kABRqcLdohrG5WJKrRMv3Km4egU3yCuFHATmdUPAGmZ+4ebjVubcQmv?=
 =?us-ascii?Q?DVMWf7cdbizPAic3ni4lR4ds40YEXl7+4zevvcDX9MS6e4m84sQSYjzub13D?=
 =?us-ascii?Q?bH9/Mog1aMSxYptETdh+T6ImnvvJLlUwm5sdJWxsPRXs1zc1CKsa4Atk4Up1?=
 =?us-ascii?Q?jyjh8cWTBbQF8Sw603q/rD1CbUUUiv7qxR3FgffRax1o1HIlCl1a7W7pqRTp?=
 =?us-ascii?Q?QY7sjPJO2Scq1crX7J00E6sstzExAH0slXrEQCrZi30laLR8mC/nfpJWZduH?=
 =?us-ascii?Q?rJrgyaCUR2eu6NihyL54EyN2cF+IEzyznuvS48aouJPWAmTpYXiarHLCbb8f?=
 =?us-ascii?Q?JeGzGoeiPbfpAaKahKhPtzT9MOjFhE6fCJglaja6RkI6itVhueX1irZjpZBI?=
 =?us-ascii?Q?qjJs72aAroPpADs1rB+Ec/To/Cj0WITe3dBJyQf76csojhNhWAw5i6HS/7CJ?=
 =?us-ascii?Q?s8D4ZVXw1/3aTJIDmaVnbCNEkLKyZ46vYiWYKpjRi3ZOMwEnagpuAfHgGmux?=
 =?us-ascii?Q?pUEE1v19vMBquZcLOBy0jehpQUdeCIK/phW1mPgU4JhT2MtXADMnnMwMsYTt?=
 =?us-ascii?Q?O5KHlzH2MPtAcyitmt4Z6WAXNYjLAJUk5SAH+Jg5rFKy5Vdn6VR5/nH+kg+n?=
 =?us-ascii?Q?2RcqFArc52r17fB7/Wd+Rz0E0WaCxEw29MDgqwSjDEsOCkKt/GDNAd8ptaQO?=
 =?us-ascii?Q?onXfmWluf3JFxDI3pZmAypysj38dBoOhPfsuPI+zK57R4P5JDQqrryiVQFHf?=
 =?us-ascii?Q?SPsW95CsiWomKRFW17tcIrx/NRYRsn1RaiB4nfMl7xp0vdn4439FdsEpFre/?=
 =?us-ascii?Q?lNLivKQflFGbpaE/CcXnoQoHX0VmpHmISmcY1/kb96Gf3hw9Ez8/ThWNw2W6?=
 =?us-ascii?Q?pZIc+KmRMPrisIwSNZF7Nm0KkK+rp3hQHirxOjaIR9ROCKd6YpSKBmvDB2we?=
 =?us-ascii?Q?hCO3H4eCP4b6bt4pXbDnEA4xLZ46IlA+avvQ7tRvMAbodi+rZLM5WoU5o7OU?=
 =?us-ascii?Q?uEbTxqY5B1pVqKoX2r6K9UnFgBDsHxONoj2eNIofuePgDtjNcAalcsw42d/p?=
 =?us-ascii?Q?5LI/qDAJ1BcK5/bL6DBojAAPqXnL67X6im/uIO94I78xcGzdynugAn6i03/e?=
 =?us-ascii?Q?pJY6wPjdNw8hOCtkYUVfnefPX3ydBSlkMkL1jaj4bVt5YZZIhUTNw2YNfps6?=
 =?us-ascii?Q?hkTZPp/5GKgFq3Dbx0/C0L3L/3i7ZCGAGU1aloVoleq36ecQMfFQ0x4oNRsn?=
 =?us-ascii?Q?UEfxVCePLTFnO17mfU77kdOCKZ2ma4Z8bgtIyDhhu8YbEUIhUnFSpGmX0G7Q?=
 =?us-ascii?Q?UXbcB4D3Zj6EBnNWpM1hja6cxsX1wQHEFVKjvDCfu1DZ3yT4RvMr3MIxZW++?=
 =?us-ascii?Q?RVLPBtS1enWsu1NA/njvGwR+ZdK+kkz0wnhDVV9bk9qRvsYZQjHNC5JH/gJ+?=
 =?us-ascii?Q?IaHQkmU0hFwlYl6BB6ynd9EP1ozslE0=3D?=
X-Exchange-RoutingPolicyChecked: Hb9Ujpk+3lT41uGPjnEgm2mAnoqkVfr35cOkuYU426CYDJ/AFbUZHhm10mj2sr9qAyxxZ3NmddDqoQurjTsi9HAZBSHnzP0L7aeUXSSxJZL36cvvkmEspYUT2OAxzQ5tjKqDvIO8AUEcgnfJGlIJlVpl4KT/G74gCU2YBX8OcazdsNi9lAgLrHJP2jjpFpoIG0SzoiBfpPijG6YcuUL4B92Akn2on5yUP8lZ1V0tDtJCypKNdSSrRxOOE/ADu7BaoB11A9sdSzTbM/YpvyAJnnpUlVrHXRsaN8Ggwmnl2IIxynqNcKmfX8d3S0AsVnYHV0uVC/JmwosiA8nR/32rDw==
X-MS-Exchange-CrossTenant-Network-Message-Id: cb921f1f-ac60-4b0b-14c9-08deb758b81c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 16:48:00.8646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x6Aqo4IxOscnrwfa3lFOWFyqWSk0IGXGNxV6bnPlLHm8qZdgicXhQMYuYKOWv14NQPljfzKfUp77nWi+isGM5nGhDeAMDkQ/Bn4vFoY6pek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4597
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

On Wed, May 20, 2026 at 12:52:37PM +0000, Ciara Loftus wrote:
> Update the e1000 base code. The changes are mostly fixes, refactoring,
> and code cleanup.
> 
> Ciara Loftus (1):
>   net/e1000/base: update version info
> 
> Dima Ruinskiy (2):
>   net/e1000/base: fix coding style issues
>   net/e1000/base: propagate PHY control register write error
> 
> Lukasz Czapnik (1):
>   net/e1000/base: fix possible variable overflow
> 
> Mateusz Fryze (1):
>   net/e1000/base: auto-negotiation status for 1000BASE-T
> 
> Menachem Fogel (1):
>   net/e1000/base: fix NVM loop bounds and pointer access
> 
> Vitaly Lifshits (4):
>   net/e1000/base: refactor K1 exit timeout configuration
>   net/e1000/base: fix typo in e1000 base code
>   net/e1000/base: reclassify MAC type
>   net/e1000/base: clear DPG enable bit post MAC reset
> 
Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to next-net-intel.
Thanks,
/Bruce
