Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16D3E81BD3
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 16:10:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E798C402B0;
	Mon,  9 Feb 2026 17:10:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 767944028F
 for <dev@dpdk.org>; Mon,  9 Feb 2026 17:10:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770653451; x=1802189451;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=3w4bZunAYywOuR8KzWtrexW7WpjIccJX8a4T3Dx7nHo=;
 b=kLG7611hRHO1AcnApzrKqi8ND/L8QnmNedN8/zZsvS7AK0WhQP+/4/tD
 kSgCh1lpBwhx8M18Og5c2JduUjGe8XiCyaa/YzoTTP/388VZffuaswfgh
 fkiIGizEgZtFTEEd3obSuFc32RAuiVN+o3nwfXgkfvFaIaiciG9R2Z48G
 PKkVJVDOldkKFuMiB358rAJXjIiIyoNTqFQ9wU31Fpc8y+ookalQBN8KU
 o0o5qNAHwsKuThh+YDiW8tJOmRth7sJIIMMGc8H/V628yz+RtD28hKHKz
 +oqusUy7mx/PekDh4B5IA5vOndTOMgbVWuETfLhnRYnA6MjeB5aPrXGsJ A==;
X-CSE-ConnectionGUID: RAu9nmqzQgG/auFwXO25wg==
X-CSE-MsgGUID: nbowJbfQQmeBRp+AahYDag==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="75615238"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="75615238"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 08:10:49 -0800
X-CSE-ConnectionGUID: i7jjiSllQ32c0b3q2xiXCg==
X-CSE-MsgGUID: Z3bsIghbS8qfumhtopCqKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="242244016"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 08:10:49 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 08:10:49 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 9 Feb 2026 08:10:49 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.24)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 08:10:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D0Nm2ZjwklvMNkhtYdj/Zcxe8V/+fcImGnZTEcw0dZF9g8sAIAvIxIOI+MX3pusptnyZUaEtJezo0iFOrQBUZEbmHitAfuPnqo8ZA7PeoqlGDA2YTj9nhH4bZWyI707t9Ezp4B/5Ekt8ALgWTUKmWG3R7BOAnIXQA8VkxW2ronep5tUqXHgMAX9RKL62am51dByO1GvKhqDzSe2yD87HIgQ3Of+M6qnZSvr7lmHSsLs2/nZCQ3/Pzs7HMQYFmaWnhZB2hLpc1rK/uPMlOxMGRv9UE4es6xVHpoLDW1UN77dmc/HZ+a2PbeSr3WgEPPE89Y0yeh9U7C8KAVsXLzhQMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2GQyF99Xd8KyFoeo/q7Qgj1cEpQlOCzTz/bnOZ9Ywg=;
 b=VfZveRotQi6beZQkZriE6ztGQOs2ymlg109DQYxerxL9+iCnX4sFQzGjGGwkTQQMPYx+sNQLZk5+yDQ0f6PA2npFMqdAg/fSx9egI7Hwv3oZBHBD6Dq/IeNCzGCpeZV+yuI+mzbYHYf7b3pwvP7JyEJCNrXfHrVJRESNYC4RkELeZQ6mzGOYeJlRacoBqoKvty1/ADT1pCB7nAc9W8rgWoshn08hOi3sqjo6WDK35Eh4NiMpUaSTrw1EdrNFN22Hm5BYtelPA1CD7Yi0GxlBSQoRZHeJfRhJdcoWmdQilbqV40+QqJapFibKlduXZPpougGXfwXuJI2YW/kMZPTrWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB7709.namprd11.prod.outlook.com (2603:10b6:510:296::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Mon, 9 Feb
 2026 16:10:46 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 16:10:45 +0000
Date: Mon, 9 Feb 2026 16:10:40 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 1/2] net/iavf: use mbuf packet type instead of dynfield
 for LLDP
Message-ID: <aYoHAPSKLXs3m67F@bricha3-mobl1.ger.corp.intel.com>
References: <20260209152049.1640121-1-ciara.loftus@intel.com>
 <20260209152049.1640121-2-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260209152049.1640121-2-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0296.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::25) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB7709:EE_
X-MS-Office365-Filtering-Correlation-Id: a52081ce-c7b0-43b4-d253-08de67f5c823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zdmrb8S1VheAt3v3uhcRjFePXu2J6Z51FhoT2Z7ILcXgsietNXLtq2T6WOxi?=
 =?us-ascii?Q?pebdSZzu8mxpeQSjqf0eMDHj+g/bQvxYvY29to2r4ADTQiMvP+g8tjOoCGef?=
 =?us-ascii?Q?3OzE+d9ToSaoq7I6Zc2ruwEHQYj9jLwM/omwGbz2LLyK4U4hBfqEuNwge2wk?=
 =?us-ascii?Q?VW0B5oeZek85twH9uk/VJGzx7FaHW4gIarDvbDn/dsiaX+M645c0ypJ43irg?=
 =?us-ascii?Q?6HlBTgax12xNQDuc6GhIU98CPZEUkwlBQ8KllxJyKEkFmeqNdGsZD10ckGzY?=
 =?us-ascii?Q?sO3BRIlMNF41+2m1z8VQjiHLksmdt1pFD90B3rK7JT7FjQuyLW2Up8ABEM7C?=
 =?us-ascii?Q?7HUB0FILOu6c+GMo7j9vOw9KWJYACtfTXXCPCEZvcHGiq2Qa2FRQYK/XnIgV?=
 =?us-ascii?Q?Ul50Qi5M2N0K5ti2KlF8Lq8tythR60RwSbWs10HUP+Rbw40NReNRFBypH7Se?=
 =?us-ascii?Q?dGz9QsNoVc4KJ6lanX0bcQfet3/83+v3Zny4yPot6nTudY9bxSm0KOvHvq3F?=
 =?us-ascii?Q?d53tZxGQLurwAQyPYBsW80rumNsUmChT5S7di6OIdqjR661Ql5262Hc7N00h?=
 =?us-ascii?Q?z3CRaPIsa/mCm2JoCJxAeJ9eBLwVKqUtSxfLDPW6niJPi6e/5xMgKLoZ+LPk?=
 =?us-ascii?Q?5ZYMD7EPNKnUwJCi52dlLg5iKSl7DAdLx93Idpy9iem4A3C399nqw4azlaxR?=
 =?us-ascii?Q?6Km4r0HxazsRxapETVYSTq9yGhhUMrRzoQJ+/bAyvHrcgAU20zvx8rSRnvKP?=
 =?us-ascii?Q?AGHNVxFg6G/xiKqG4pAz4bLnnYj1H9tzkA7sNN8aBqoXsbEE7gdRupFJfsUf?=
 =?us-ascii?Q?EEk89tfbl3wkU3AJmzm1AlpATzr0bEBFqyvyNdf4guD+kueyzYl51sglwL17?=
 =?us-ascii?Q?C1yjlHwVn+ZgaZADDog8BgRdpGeMN5i2B+DRtN7y63wIE/j56+KaIJjp6gW1?=
 =?us-ascii?Q?AJyIVF1pQ+ddfpDrWEkZov+uEXRSNhpf0GOKpIhG+ju9xsQvL2ri2IrRa/nm?=
 =?us-ascii?Q?bOumpkMPcNLnVOmWF+4NhgX9PZ1REU2KT34Rh2iIVrjKBjcjWudzDmsNlrS5?=
 =?us-ascii?Q?Q4NAygb52bRlbd/X5Xuh9aGca9xKbrc5MpudlJ+ehM17UBRldQDvn9bZI6/L?=
 =?us-ascii?Q?fGnGnXO8T9BSSdQ8vOawWka3uBnP5HF5GFjCPpZKw9OUZ65h/KJUoQEhXV1B?=
 =?us-ascii?Q?DSJSesxZDrAghkfIR4C5VRWfCMaaVU4+t6+dVCctQd/dSnBZ2JGNY7EwwN0J?=
 =?us-ascii?Q?h9dkh19vKVOmOVXI96TPL0w4hmbmvu6nZdGFLEyg2UrGB48Px9t0mXei+pCt?=
 =?us-ascii?Q?t+mvO7U92IhFRIkLUO+0l7k75LoSz+WsIdnJjezE7Sk0qVQsjVTv6erIDObO?=
 =?us-ascii?Q?PiK+4kTh+U1J3GXFfJMqQVOfaCHAOHYr1ZEkyBqWRKXIy1jMI33KiBhh95jK?=
 =?us-ascii?Q?CnJipNO8I4HEeQsy87sjjyzS4895/uxMYCOWH9oNmpomUpsQgcus+XU3PG7F?=
 =?us-ascii?Q?4tISEC+rzWJ8LOQ3+AxViQ+GiB1YWj+FNtQBGboCR5gOsU9twIY9ub5PjleP?=
 =?us-ascii?Q?a6DHu2rD5TyOSpmDGVA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?grfsslUyp2NDvR0hM1DaCvmWVx66mxoDs6ITs5yB2KgW2alRcUgLDjB8E91i?=
 =?us-ascii?Q?Wrhiyo8uAR7gdzV8AmvxzIL5Ob29yEtU3ySB9ZjyeY23+NTXU4QPhztNfT1y?=
 =?us-ascii?Q?HVgQi5cHGjqEd+1sn8E5mN2Qa6D2ZX+hP1ZPYvMD/mDyRYTL0bJREuj11QUK?=
 =?us-ascii?Q?1XtpY+nnaYWuEDHUzgekRA0s0gCus/K+S5Bu3YMJ6j7gL+tPk+/Aq1lOtPBg?=
 =?us-ascii?Q?fBREzdQ+U1ijG3iQvjT4aI4sI0FXFjLv1zKU9SHLbZTF+ZBu/g8wbAYbq6jm?=
 =?us-ascii?Q?iE8S2mcNSdCzxeQbV45IMD9BVSEkIk5PySjxHcxE2Lo+xpU9mGgtxlahLl3p?=
 =?us-ascii?Q?WJ6fUB+aBz/w0hKqhb3/gnP39PRIfKdW6Gz/g55Z1T3SOlAz3pTEAiQJkUZG?=
 =?us-ascii?Q?t9yV7x8rSxZZ31lqpCyO1XhdlCyyLx9ZOPaX4/1IrEI6ic6b0tVCZslrTTeb?=
 =?us-ascii?Q?50k0zU+NxXfpJUHmCY4qNAHXTwxwLD3dwBTdlO00MuOVnRuf0c3qKlADlA8M?=
 =?us-ascii?Q?GVPgoB3Qj1JuQkXDYblp2p3y68xMMVf/Es+9PmiBj6LlIg4giZ9na1WIpjP/?=
 =?us-ascii?Q?R6bqflvhq2g324fp3aLsx8eqXtYCjdVfJE4oR3yYXRwTlO1UpoC0BKogAOtZ?=
 =?us-ascii?Q?zOG6tJfqrY/zJs4ubufPaGrZawr36e1BVYsPAIIOdAaph28VRq3VjFpKetM6?=
 =?us-ascii?Q?1bqU564SZeSJXg4UnpwVQKreYXx70nD4DuW9TsVWR0gyTCwtMNNlegSCKYdb?=
 =?us-ascii?Q?z0LnggouEUdaZ6OKN+WaNQ0XbnCmZei2lyg/QG1L8N1wAp7v1gryUDPJsU67?=
 =?us-ascii?Q?EPS8/jWwDu9mM5HRolNQc5qvHv5vRi47WxcDlXNiwbTyVIGZAkLcbq0Sm+xH?=
 =?us-ascii?Q?Ud6Zio0tLTkDUIyCk9qFNLl7cnAicJBiD5W3FkbCs4UnVSHjHpXyDzKuchzH?=
 =?us-ascii?Q?lttFPDs6nGOmRWouJcYXHlxCG4ZOvnE+5/KRD7Iu7YPAgRHsdsBwzpS3uWJN?=
 =?us-ascii?Q?wH90e1++urCJu7VQJrFA1Phr4DP3EXTtP3JhMx+BqUkP2/Bz7oVsIhhoeqyo?=
 =?us-ascii?Q?biRynJnAP0xKLdOm6atQid3EzOTvsdB4R3jRUhEOPeHwh2+xQJzLS7WSHWTR?=
 =?us-ascii?Q?Ry/QVnHvYQ6/7R6fYkaasTzh/xiljVk9Wg6hWq2UMc0zfpV47B1zlECnBcV0?=
 =?us-ascii?Q?du/O4ZUDxKWHsWBB70rtPNSQr58r58qDrxzww6ow3hQ6n2l6uHZyGeUdHjbQ?=
 =?us-ascii?Q?0SWMV98JalYAdwFKwuOTUXA07eitbGGginjY2exwlV+sNR9MBaZC5pcvDbHL?=
 =?us-ascii?Q?XI6/Y2gnC9TAxgMVghrByVltLoOdOE0PYd54EKafkfExTeRYHNoNxsrmFoHL?=
 =?us-ascii?Q?bwHSxEcFhcEFB59t1/96FDbN7lwpBnPc2L7w9lGQ0PCIsAMxcYXxiPlZcFgA?=
 =?us-ascii?Q?RYT9dsLl15bDAF9mvcLWTjgNlYVDwPtUMoac+8wxUM6CnkCm89gEZ9h02/p/?=
 =?us-ascii?Q?VvRCfaAqexPv8qDHtQwCiqIl/P4jqEefUaBXB6oXsQw2PYvl7/nHTHGi4Dgv?=
 =?us-ascii?Q?zuE6u87jlMBzMdOxX5GCCvoi8jttehYg42TtY4I0B1t95ExcjlGx3WlaIEFZ?=
 =?us-ascii?Q?MSfjDF6rgfDSfI1VM6TFVkZqYeTzfWwWTqWZw1m/uOq6exrsej5uUWTOLElv?=
 =?us-ascii?Q?346IHMVe1oS/ndlb3rW3Kdr+anV/ectH3zjzF+QySa0KEkVa5vKKlG6YrGyX?=
 =?us-ascii?Q?WJnyFDVticeHm+ClkPR+N78E0OJ8DsE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a52081ce-c7b0-43b4-d253-08de67f5c823
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 16:10:45.7439 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K6I+w9LT8aIcFyIhGUd6+mVZDV9r2JFloij3Mr9ewVTO6ytaccP03aS5xPQm0DLQs7HJwoAcpGwq4SVxy305J9KjWUzbO3QGSoD6R75vJ7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7709
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

On Mon, Feb 09, 2026 at 03:20:48PM +0000, Ciara Loftus wrote:
> Instead of using a dynamic mbuf field to flag a packet as LLDP, instead
> utilise the mbuf packet type field as the identifier instead. If the
> type is RTE_PTYPE_L2_ETHER_LLDP the packet is identified as LLDP. This
> approach is preferable because the use of dynamic mbuf fields should be
> reserved for features that are not easily implemented using the existing
> mbuf infrastructure. No negative performance impacts were observed with
> the new approach.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>

For ABI compatibility, though, I think we need to keep the old method of
identifying LLDP packets there too. While I completely agree that using
packet types is the better approach, we need to go through a deprecation
process for the old dynamic field method, though.

> ---
>  doc/guides/nics/intel_vf.rst           | 16 +++++++++-------
>  doc/guides/rel_notes/release_26_03.rst |  1 +
>  drivers/net/intel/iavf/iavf_ethdev.c   | 13 ++++++++-----
>  drivers/net/intel/iavf/iavf_rxtx.c     |  3 +--
>  drivers/net/intel/iavf/iavf_rxtx.h     |  8 +++-----
>  drivers/net/intel/iavf/iavf_testpmd.c  | 20 +++++---------------
>  drivers/net/intel/iavf/rte_pmd_iavf.h  | 10 ++++++++++
>  7 files changed, 37 insertions(+), 34 deletions(-)
> 
> diff --git a/doc/guides/nics/intel_vf.rst b/doc/guides/nics/intel_vf.rst
> index bc600e4b58..197918b2e8 100644
> --- a/doc/guides/nics/intel_vf.rst
> +++ b/doc/guides/nics/intel_vf.rst
> @@ -668,19 +668,21 @@ Inline IPsec Support
>  Diagnostic Utilities
>  --------------------
>  

<snip>
>  

> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_iavf_enable_tx_lldp, 26.03)
> +void
> +rte_pmd_iavf_enable_tx_lldp(bool enable)
> +{
> +	iavf_tx_lldp_enabled = enable;
> +}
> +
Rather than a private function, this looks something that should be a
feature flag or capability somewhere, e.g. like TSO.
