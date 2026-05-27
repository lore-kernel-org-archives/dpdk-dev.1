Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB95CD5BD0
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 14:40:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85F354027D;
	Wed, 27 May 2026 16:40:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 038BF4026C
 for <dev@dpdk.org>; Wed, 27 May 2026 16:40:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779892819; x=1811428819;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=C4zd/RvV+CHlwjbXl/QgrY1Gc7+rMn5CNukRckYxikk=;
 b=huvIabVZECK0xP3HcRL7iyLJ2JOlgn7ADecLmn3xWEPkszDSOwp+c2J9
 0MKy1imeA2EJAseeLt5TDyKNvkqBKXUPSr4+8X5gZeKKxqPC8CXs02qUv
 MHTtnq6cqIQhTzzW577y3rQq9sGLTTHhjYHtFYVjuzAPPDKMDmJY9lBlG
 ojUugNMafVX7GC9CzfatTyAHjIfobd1mKkiG4PvOm+BooVNGGsxBfnKjo
 6kVGeR1nMkcOxXc1kXdjq0pmnw/3w8C6VLTqS06SN4q0nznA4yRuTmBRA
 nnfNcAxeX3OWJZB6iH5aHdfdrcq+rM9H1aeH16ec/y9DZj89yP9HPHYS0 A==;
X-CSE-ConnectionGUID: istSmopaRkePJaUoeW/Yfg==
X-CSE-MsgGUID: IlpJ06e3RZKoTfZ6Go+umA==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="92111587"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="92111587"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 07:40:18 -0700
X-CSE-ConnectionGUID: ore16bV0Ry6L/ZKG95P+8Q==
X-CSE-MsgGUID: cS4ttszDReuqurH5xPsijg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="244083979"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 07:40:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 07:40:17 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 27 May 2026 07:40:17 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.56) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 07:40:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9b7svFhm4ydSvo7IFx7gOLwXPZ7NQ7/dnvSBx0BgXKbkUbo7xhG4qTCsZy6jFu3bH/OYwcJryviobrH1ykbaEwqRJZEQqKJWCc8pkQS0ks+I7UbCz0Eje1a1USWUO7BAFTSRUHMY0GSIQuol+A2Y+0U7c71xIFeaz2qjuKanT3kI32LJK3TndGWntRmEuXoxcrw77TopJzzG3dL6exfDtapmlbK1X0/dJh3DqKTAmUAJqeHUwHEIM0nJ/0F2LOxOLp8Ca3nhthQO49NcnUOGHYiV3T/UkaNFyxigMZPrqN/Rnh9yNL348EV8toatgoyuMWC0W2iTjr4bGXh6hgubw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJdHd1WH7uiA29T/eknChvRXq/cJcqbgGEpvx8WUfEw=;
 b=FaKqQ2tvjInaxdADcn0wTt9sLEZMTFsvp/g8HLANpDYBlVBsKtPRS+MQtj4UF6+W+uoSKMKDjnkb6IVpVrGDR4f7vjiUX9z5GlB9R1syVP7szu8koKQcG6u/V+OFc3eEIngriZj5dU/0HzsNj6zJvowp8jHc8a+K5tnUj7qpf+iMFtHBdp94Px2xp9Ti6EcNl10X74SGOyttGVK6i8d1ymvAv1ACNRoLngva9jAfXbDD7h6MNHzGvVp+HyhxsXU3WbeHwGNXMs6wU2sE4ANlXxeF4hGDfxhzH+lmzKLl2niT/UdGysowKBYOq9mX+jgRJR9C3TpxAnU7+0Icoztwkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BL3PR11MB6363.namprd11.prod.outlook.com (2603:10b6:208:3b6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 14:40:10 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 14:40:10 +0000
Date: Wed, 27 May 2026 15:40:05 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v5 00/27] Add common flow attr/action parsing
 infrastructure to Intel PMD's
Message-ID: <ahcCRRHFYOF_Q0h9@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1770819433.git.anatoly.burakov@intel.com>
 <cover.1779717943.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1779717943.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0044.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::7) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BL3PR11MB6363:EE_
X-MS-Office365-Filtering-Correlation-Id: 34cef322-e6e6-48cc-3828-08debbfddaa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /p+gCWyQvggU8QbX7etMU0xiIBe5fJoXSJLeZe92VDR4M3S4BoFBZFRMIuq4jJ5IryceE37XHaJqkMsMiiQTzQxnc/4RZyiyjvaykUYrAu2sbxtGQ/0jlu0xRRnzA4mxhWAE7bwfM+XW7PBJfrNgnN0dv5i6Zcbvcl9vvVJ42ldkPIevwv+nNGlQUh8KQc/nwWaHwZoppzCytwl1w7mSFwlA7NF9O8uS74OUG4X0kl7279XglrY2HVdVF1YIRR/vEjayM8JTvCS77CMuNpNqL8EmSXYlgZfY7CqArvmXXAi7GiPJKkTIIxgd29nkLcVtmwBwUyisMdOUTDkSSdr92wjYpXbFyATagw4QkOibG1fFimFI0z6sfJufmEfE/XUfdIjnKixu5zOP/Oe9pbnuh4nmZQqEfiYSZmnZf3qDHyR8qU8hwnzTmKiRIja7gVYjjQ3lgxKMz4ANyMFx5DbM802JCzu1vkeIUHdco9GPq+CRd2f4+87GCTO5wFIK1GXMlYXGGgm37U21tkRmFYFS0k0MeytXOmnV1wxW/fvFxh0yZuUBDr8z4kEvesYjdhp57WQPf9gOMdMsqBKF6a0hNRt63dRALyRHDCcKdBY3hJrdL7iZKCF1nJs01Aa1wKEHQa08Eyph4a1aUOMD701pGY5Ibf496auxxW3idDPSmE4OCE/xg4mow7LWvnNwk81A6jqyKkYGzJ234AWLuBOOaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?itLYf6G82AB6Vn01OI3ZXKZVMi2j+K3C77ezaEwY5wrLv24wRCM26GeY+iaD?=
 =?us-ascii?Q?xP2lr3dQ3pWlk1HwP8yDqXNck0JG84zW8AGRg36IQ6xcdJHSdd1ExBzEeYSz?=
 =?us-ascii?Q?eOol7h5HCV3CJxvOUXmy2s0P45J1Ic29Y24eQnxpPp3lMJtA06T3z8lqgBeG?=
 =?us-ascii?Q?0F25Qs2R3vuoBM15EeqaeGpWHyBVCXyIG8jqwWNiAHk5cbip96wYi9x/TMlM?=
 =?us-ascii?Q?wEoXnIe2WGARXorU+n4E38YtnzPGSboRR8rXv7cy2nlz5sjRBbfzFwA+jWjJ?=
 =?us-ascii?Q?0nEODUR0fWP9oxCVaSXghLbG3BBVGmHdt2vc0Vxl42+pPqQcbFeaBKPmikG2?=
 =?us-ascii?Q?wOBDyj82MnHMAVyHwLR3oR/yHhIn0AiyV4UlyFZrFA/wWwrKisIPxoyRfp0p?=
 =?us-ascii?Q?yQWtziFxS1xnNUJz/PZixP9Ycqld2LMc2NzWmgqpntkcIWY4fRLvK/YjFQPw?=
 =?us-ascii?Q?sVOvbvmIX4Q9vzCrSAUOdYXh1kZc4EyCgTZCVzpqJcbkl+LLLjRxFgVvinYw?=
 =?us-ascii?Q?n/C9mqkRjQWLq4iIAE/8DCtQZdtn2rQFfMjBydkekJyuSQLbgQ/Vzy0s3RZN?=
 =?us-ascii?Q?uOTPgIJDL34jQDPRtjFamcH7JnGvDyOJt9tNGS71i+Ocnh5i0sdv4jXj+Xse?=
 =?us-ascii?Q?22FzLlbNwOgq4I4zVSUnJbnOpsDJWtGguqyCakC4b9H3yklMWrzvDldZRMm3?=
 =?us-ascii?Q?CxmjpjxmaSZYCYM9zchOimUuDpG+fLrwbwmF8CQpipT8sQqxlA7ns+q0pKfm?=
 =?us-ascii?Q?uchwHRaae5vdatoh7AgNCdJo3QWKI9Q4XLKQSk5CMyjoHEgiLWPJVN4Qrw6V?=
 =?us-ascii?Q?W6l9UySk+VIbItP7uKfDZ9Q9zhaffgwiXv86QQdcDTEhsHcL9bUY2Z7xmM89?=
 =?us-ascii?Q?5UiBluhXdaKU4PoT/GoevC0kiku5VvR3/8s9e1kGMwTA1L4PhZ7nAIUZVH4f?=
 =?us-ascii?Q?hhDE6NkzAWsLfKfkdNxgj/UP9eOxtzvWLNHAqcYCZxF5qxwmRgo2+6Zr1TMw?=
 =?us-ascii?Q?bYhRsdvljB0+I8T8l1enJh7A7ZyLx3HqRVkcNRoz2K2LR1tQh+orBkZrL63V?=
 =?us-ascii?Q?Vx6fb1a3/dRLiMtGyz5svL8IA/oCDetmM7yRIsP5JNBP3mpnToq0Q4gBO18o?=
 =?us-ascii?Q?kGq4uJtmRFpWA05lQnjfm8akaCjpRy4Tq1OPpPv4ANvyLUY3FhFj0RpWS3hf?=
 =?us-ascii?Q?b9/u5F+qotFHt4ZN47Q4+TUAG325czLjQWa0VEDYsHlBfQf1b9/JxeDQwnKu?=
 =?us-ascii?Q?wuXbUPm10jSDtcUmnh8/ioR8SYesDqLQL6vwwNA+JGJkgZz5MXt1XFRzAtUs?=
 =?us-ascii?Q?b2XwGRHmkdtSYN4Nh+ZJ+vA9ffk42MEcY8Z+UAnSUnm9BNytAu4t9XUJAd5A?=
 =?us-ascii?Q?O+UMjEb1aSRPeTSZovbD9HD351CU5zrOemtqvWZMsfRorjeXht/RXXxkDIWC?=
 =?us-ascii?Q?tlgRe9TupO37TXizaC3MakBHMJ5bp11r1dJgWyLTgABP7+w8Y88YhHjKHHqo?=
 =?us-ascii?Q?0xkO0TeoffZqwoIWT3YmSmn7MGHlRsZXrIkwsJpmRTSkHP1K3j7hRCquUyy5?=
 =?us-ascii?Q?KP6Go7TGNNHM2VtlrwN2dsb3Xo1BHO0QGPox9G1eYlFO7aRXK0KEJz7T3TIQ?=
 =?us-ascii?Q?UY0MIVNXKmL4fETbGBgP+GokXJsMksYA2ERn6p5RGXcKl3hRII8N7TbxKnPi?=
 =?us-ascii?Q?peL5UhZbBqCO529sYCWOoqBo4pXSaTLcMrb312loEE/p7PQH3eHKnuB/2cmW?=
 =?us-ascii?Q?VwS5E13HWz9HCXSmSuZdMzP9Vv1jRm4=3D?=
X-Exchange-RoutingPolicyChecked: PD3y7O8ulA0BrBXKuUw5ix81PdVFBhTZTGF1NlHSYXBXaxvmJMu7FmeAoGEh6r7MZehHo4bKPh+gJkPoXh51ohO0dbFzF3cYzqtuxvus2hnExPn/YkxTFZXj+6+bz7MpaFF3a9GpApksIt1NlQP8kORs3rERVP6fIon2KjmFOHkuwsXIxkCLPIZiaK895rw1FuRZxerD8Lv5nfux6R2QZW1Rosvo/O+mC55Sao4R0nkqyikxL3YnUnsmLCegOmEfsQJ51cjWXHn+EetT3bmt8/9ikxPsJ97LH6QSp2izpHoC/PSOGS5cgz5N6xaJHCHNEQljtM192IPn0TPBH37lgQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 34cef322-e6e6-48cc-3828-08debbfddaa4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 14:40:10.4625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cFNb/IvOBU3LMFIsvlFFKvps548vnapQJftTM8Buz5PPFjwgcrMbRD7pTju3V/iHOFc0lsQl1HQiAFzBT6A+L4DE7kHIvTp/D86yAv4LCQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6363
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

On Mon, May 25, 2026 at 03:06:19PM +0100, Anatoly Burakov wrote:
> This patchset introduces common flow attr/action checking infrastructure to
> some Intel PMD's (IXGBE, I40E, IAVF, and ICE). The aim is to reduce code
> duplication, simplify implementation of new parsers/verification of existing
> ones, and make action/attr handling more consistent across drivers.
> 
> v5:
> - Add missing patch for component/class name compile time constant
> - Fixed missing RSS queue contiguousness checks
> 
> v4:
> - First few commits were integrated as part of a different patchset
> - Added more logging to common infrastructure
> - RSS validation now allows discontiguous queue lists by default
> - Fixed some checks being too stringent and failing common validation
> 
> v3:
> - Rebase on latest next-net-intel
> - Added 4 new commits that have to do with not using `rte_eth_dev` in rte_flow
> - Converted the remaining commits to use adapter structures everywhere
> - Minor fixes in how return values are handled
> - Fixed incorrect check in i40e RSS validation
> 
> v2:
> - Rebase on latest main
> - Now depends on series 37585 [1]
> 
> [1] https://patches.dpdk.org/project/dpdk/list/?series=37585
> 
While I haven't worked through the details patch-by-patch, the whole
concept seems good, and the implementation parts I have looked at seem
fine. Any new versions should be applicable ok to main, since the net and
net-intel trees have now been pulled, which means we'll get a good AI
review too. For now, LGTM

Series-Acked-by: Bruce Richardson <bruce.richardson@intel.com>


> Anatoly Burakov (21):
>   eal/common: add token concatenation macro
>   net/intel/common: add common flow action parsing
>   net/intel/common: add common flow attr validation
>   net/ixgbe: use common checks in ethertype filter
>   net/ixgbe: use common checks in syn filter
>   net/ixgbe: use common checks in L2 tunnel filter
>   net/ixgbe: use common checks in ntuple filter
>   net/ixgbe: use common checks in security filter
>   net/ixgbe: use common checks in FDIR filters
>   net/ixgbe: use common checks in RSS filter
>   net/i40e: use common flow attribute checks
>   net/i40e: refactor RSS flow parameter checks
>   net/i40e: use common action checks for ethertype
>   net/i40e: use common action checks for FDIR
>   net/i40e: use common action checks for tunnel
>   net/iavf: use common flow attribute checks
>   net/iavf: use common action checks for IPsec
>   net/iavf: use common action checks for hash
>   net/iavf: use common action checks for FDIR
>   net/iavf: use common action checks for fsub
>   net/iavf: use common action checks for flow query
> 
> Bruce Richardson (1):
>   build: add build defines for component name and class
> 
> Vladimir Medvedkin (5):
>   net/ice: use common flow attribute checks
>   net/ice: use common action checks for hash
>   net/ice: use common action checks for FDIR
>   net/ice: use common action checks for switch
>   net/ice: use common action checks for ACL
> 
>  drivers/meson.build                        |    2 +
>  drivers/net/intel/common/flow_check.h      |  347 ++++++
>  drivers/net/intel/common/log.h             |   40 +
>  drivers/net/intel/i40e/i40e_ethdev.h       |    1 -
>  drivers/net/intel/i40e/i40e_flow.c         |  433 +++-----
>  drivers/net/intel/i40e/i40e_hash.c         |  438 +++++---
>  drivers/net/intel/i40e/i40e_hash.h         |    2 +-
>  drivers/net/intel/iavf/iavf_fdir.c         |  368 +++---
>  drivers/net/intel/iavf/iavf_fsub.c         |  262 ++---
>  drivers/net/intel/iavf/iavf_generic_flow.c |  107 +-
>  drivers/net/intel/iavf/iavf_generic_flow.h |    2 +-
>  drivers/net/intel/iavf/iavf_hash.c         |  153 +--
>  drivers/net/intel/iavf/iavf_ipsec_crypto.c |   43 +-
>  drivers/net/intel/ice/ice_acl_filter.c     |  146 ++-
>  drivers/net/intel/ice/ice_fdir_filter.c    |  384 ++++---
>  drivers/net/intel/ice/ice_generic_flow.c   |   59 +-
>  drivers/net/intel/ice/ice_generic_flow.h   |    2 +-
>  drivers/net/intel/ice/ice_hash.c           |  189 ++--
>  drivers/net/intel/ice/ice_switch_filter.c  |  389 +++----
>  drivers/net/intel/ixgbe/ixgbe_flow.c       | 1166 +++++++-------------
>  lib/eal/include/rte_common.h               |    4 +
>  lib/meson.build                            |    2 +
>  22 files changed, 2271 insertions(+), 2268 deletions(-)
>  create mode 100644 drivers/net/intel/common/flow_check.h
>  create mode 100644 drivers/net/intel/common/log.h
> 
> -- 
> 2.47.3
> 
