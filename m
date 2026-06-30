Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022EEC43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 15:44:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E94CA4067B;
	Tue, 30 Jun 2026 17:44:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 4664B40611
 for <dev@dpdk.org>; Tue, 30 Jun 2026 17:44:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782834281; x=1814370281;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=T7ECnF9DLMo8S40SfsDPluf3cBGML98sLjJFEG9IpBw=;
 b=akjO1YfKB7wRc1BZ859n6xaKMfSoxDdi1mIWzGJ0HXP5BqWAeUactTc7
 OSe7OSVc6ZpJ/CK8A3B3GD44f/mopZS5lIAX2HQGmD/hKJD7CvmiKFO33
 RvvZ5s6IURS07BDO5zDq/PpH0qQAR9myAeiTEym28QE3hqEW7jM55Mg5B
 tTt68FH5NzWJtDVVaF8AJXYlb+InapgXkvIOOf7wOax9TuqOct5VfKuVq
 sqJWl0J4AnPEzV2Un6dSDrXJw45UE6UOT1I/H2NPZBOCP442Pcc1ub4bF
 Cdv9vHbkd2T9BMbG5J+IaqasorvBtR+nJWyFb4G94k1b2udBu5GXGmevp g==;
X-CSE-ConnectionGUID: /kWPuG9ZRVaAXIJOeieD4A==
X-CSE-MsgGUID: mD5+2bDXR4GZfIZeqgbmpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="83579734"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; d="scan'208";a="83579734"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 08:44:09 -0700
X-CSE-ConnectionGUID: BPQXbL6hTi2yBB8KyH0GoQ==
X-CSE-MsgGUID: Uai5C1+tTbK4z4KVzTp6bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; d="scan'208";a="245953359"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 08:44:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 08:44:08 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 30 Jun 2026 08:44:08 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.16) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 08:44:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJenWk7c1FpXbRbD9PBlSwIMzcqlgBKf0RByLbIHQihHecpqxS7VJZ8o9Zhs7KfWcqiMfu1omVCXDPkMTko0zH8k92IoGdydNM6AzLRRRxzPJD65ZB/X1CtmBMlpOBhNT9o8NrPMorE+n8CtnNAsuaTiJGcXgIldqjyxX1hJuqEdaN2kR7tXVEKdF+rCMMCHSCoj+5iMMZ14BMLQnlVnfE+RmeNyrLa9Jix6Zrl9Vc63vs0C3FgcNx1H15qp/vnluKyVPF0l0rFs9PJzCuLl4AOxtf0HWLvnSEbQDEz400QuVpyy+5zYsAlGlSlrUETEjHSm1N42UF4rDcQMUYs7kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFmaJj8xc2VQ3sBX2PboQnytgoHjKx21gxK/Ip1OBaw=;
 b=dySWSCsOk9OlQdADvl6sqJdJbC33oHjcf9TU/xcfkKROI0T5/b4txA9d8smEHSc0FDsNuQaO7d+zJWePnGK4coAvLjpgSBE8ht3T0BP2/4JXW4RqcFak7sMJtVPqHuQ4NkQHhKUbFv8lN+pAf0jXcpkKpWuhA4MwwCXjKi2N4CYMvVOMYvCZTEaEIAhOqMs9JbrI9A+CLxDvAb2YjMgz3u5kUj5I/Vg12tGVljZxfiUJVC8tVWIZNQ39bkoF8X/bjpJHTLWdLDBN7DOdpzjZnn8LcVEb42ArmKBTfZ1zlt9m4hCuUJS4g8osRdvu/oVz8FU+R85lxjnNFGs8cj157A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by MW3PR11MB4698.namprd11.prod.outlook.com (2603:10b6:303:5a::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 15:44:04 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 15:44:04 +0000
Date: Tue, 30 Jun 2026 16:44:00 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Dawid Wesierski <dawid.wesierski@intel.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <marek.kasiewicz@intel.com>
Subject: Re: [PATCH v3 5/6] net/iavf: disable runtime queue setup capability
Message-ID: <akPkQDPTkRgU5-le@bricha3-mobl1.ger.corp.intel.com>
References: <20260618144442.312844-8-dawid.wesierski@intel.com>
 <20260630120657.1046588-1-dawid.wesierski@intel.com>
 <20260630120657.1046588-6-dawid.wesierski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260630120657.1046588-6-dawid.wesierski@intel.com>
X-ClientProxiedBy: DUZPR01CA0194.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::19) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|MW3PR11MB4698:EE_
X-MS-Office365-Filtering-Correlation-Id: 847411ef-2e91-43d4-e18b-08ded6be6a18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|3023799007|22082099003|18002099003|11063799006|56012099006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: 33qH362WbgNyYN8ln4RQ5wts6KgcD5Q07FiRGUl6EBpAlcGjXUetuqSzr8gDmf6Sl5uqluXEiD91L5In1bbZfXv99aklQbSGoKl7RubMq/lCDykIjibN7FJ5TeD+4Nrjze04YplHOJZo6z9KK+DKdbq40Q9rvTUp2yII5EVFKMAZWLmH1LW+4rFxTyrRR9cV94tuS+rOidtEAr8LIvVq03zNPUc/H28skMf9d6vH9JBG6uz7juysOYNC7MUmpB6vmbdFFmHy3wYVGy8fxEMRCMjt4bFQ+eFQ3VHAD0mTTYX85pVKM//LFu+CRz9NbIeHkwUKwL3YKOCH3F2ZKW5C7Y1tXSLSkZrHO4gIuty7hO/ZPcTIMG3c62fR8EJ4OPMg2pqQ+gxIMHeki4cTKrPHufM52+bE9RXK4Rx9h9jX8NqOTaL23KEbH0Srx75FfJuiO3LFdm8EaVnjp2K2CxY0BD0/ddQclgdrHRQJ+O/hx6PEW8b3DFSmFCFONPFytKfn5o24iJxHzNCEAjJoZn8/W2iJ0WX7xygFZ9XUoMpBfwequAuBgbhg/NUB+KE6U2XEzNniZql4ACXN3Dz7uV7qSzley+hzb9o6MCHvEJ7bOUF+xmV+M992VvfodKlAF06AoJHAMF8i3fTDmpJkoHjVSjUADzw5bT4e1fsS62gqybE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(3023799007)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Me0FWdxuEDEifze4D2t4JV9mFpm5KOlx+ZR8PHnqY+CtcojnXXSxJSa4Nspz?=
 =?us-ascii?Q?SDFhPXfFEbkpS2RYSAVkC+4tcDmZnELCUn/Ba54JHPpH1kpJjF4WoLmuX+Cn?=
 =?us-ascii?Q?k66wnrWpwzJUNsqWsi1M8MXk/9l8rNdRNqaiYFCjcmc+GxZ7ulfKKSMT35Us?=
 =?us-ascii?Q?/YQSGPe//L/5WK52WSYcVXr7KI9gPvg1Wxrof5l00tHcKH5/FNjlv8znpjGN?=
 =?us-ascii?Q?sd/LrpbScQZpeAoXlaeV9YIcVVOwMQ1l/GA6w34tosZI4efJp1YMXbgvzcz9?=
 =?us-ascii?Q?9aT5dH2Rr7DjHr2ehaa3OYaPj3d2r8l18ZIQVZLx5MSDELZ9v/NRaqkqbt69?=
 =?us-ascii?Q?m8Q5f82CJbcHdLcLyJn2IS8HzB8Yw9QbBfqcSh/x4UCT/y3e4/V3mmXYgAHM?=
 =?us-ascii?Q?40Bpw1UfKNlNRATNY3jK5viwFidjKr8VLNTp82L+C62XLLfXq0eSvaVpDNWQ?=
 =?us-ascii?Q?csdTrWDQ+Q9MgbZiz84CnM4GAKU8dxFi+Q5KnTe4aOMCdQZwwocn/RGnKmei?=
 =?us-ascii?Q?Pb+ljIpCh7CPSF5eHWpXBX7Fnz/QHKsTk1KYwsp+DjBwqzjnqPJT7IFZ3HLl?=
 =?us-ascii?Q?13ijA41jO3HpfESWVt+9UCzQh/Zzm7YFDvBYxOBbj91Z7L9ISZuQRwEzMhGR?=
 =?us-ascii?Q?4Fqqk9YE7LPW5QERzVZkFG9sGtxptfxaMavKEi01wciGiWBw4NW7OYMN7ysK?=
 =?us-ascii?Q?lpDTryyuBokr5ya9E8Vov3toAIPR/pNYQVBAwsFm9oieb4R1oJa0R/eXcMvV?=
 =?us-ascii?Q?m05P61sr0FdncsBMbwwmgviQwH7nAKdmOHkR5quYmYtpD7HN4WW9oyhoc5+v?=
 =?us-ascii?Q?hWUpcBDMeyxKTS6tNsdugivhyix5lMRPfqGdD6d0M6e4GjRuJRJzWI1Owjoa?=
 =?us-ascii?Q?rvLrwN8kBJIr/Wk+qszxMxIDu6InbBTHKiuO9NC2WB5JTlJ2Z1aNZ2jLfiLt?=
 =?us-ascii?Q?1lfVHumVZ5h7pXIl5enCwiJ54u6MdNa78l1kX0ZnO38/faKxmsh4CQkk8YkN?=
 =?us-ascii?Q?O5EJX8Eev8o3h1/H8pC/30BcJM/qaZUsXAbQ975zVZ6U5r9zBYE3gx9SeU8N?=
 =?us-ascii?Q?Ms7TBQUEqVgWNfxiPOGSaHHaT4c8mODS0428uqxPUpTPAr2XFoNiHYND9Mgt?=
 =?us-ascii?Q?lB1qEcF2GJARa1DCKwNadQfnSS2WgRugqqDIag8QwwEBSenSQRBU2wZZHKWl?=
 =?us-ascii?Q?jc39Sc2cx7dS6nyTK8EwbttMTE4udabGXLQx62tbEqlSV9M6d+yqFy2omYTv?=
 =?us-ascii?Q?uWQB1AghPR0EaR8ebh9S613CbN4ju+i15IGn8PYfVAj5KRr+eI0C/l/GSB8t?=
 =?us-ascii?Q?vu4l18+9HTB4ImMfs0sDH3SjmbbIH0iMRkCGiGY/6XY2Dj2ZbaSLdGI1EgCs?=
 =?us-ascii?Q?6EG3l5X457jELqlEsaQwlZ54+OxqbCgp3xGz8StMPLiMLaY0G5O/phTBiEpM?=
 =?us-ascii?Q?XBqUeHm+klItx3WlYoki2HpZjZLDdUCZNioVNccwngbg/ZgQzVVCRBYnhPOz?=
 =?us-ascii?Q?vVZEjvHz00gBcS+ZFEIASscPPv7JeG3aVlqCtTx8yx4RqEaKZplmElABUgxX?=
 =?us-ascii?Q?DrcrimuPjXHtNb4nwIqcbIntwqxRS+umTzEMpwtJcJIA2mwD5B+P7MBaHJyi?=
 =?us-ascii?Q?DcrsJfJALJVgrpmq2uW+hGbnvj9qrkPhXAdZjNyc0uFYqGX/w2rS7p7+0TX0?=
 =?us-ascii?Q?p8AonzSIV/XiVsQnVoi9IzDHZ6LYHt7WygCVgh8GlQhWgcepP9mKRV5tARUX?=
 =?us-ascii?Q?4VNe3hH7b+t3SghMrK0aJI/G5ZRLIn8=3D?=
X-Exchange-RoutingPolicyChecked: e8lBVqLp7mCFWLUjfvgJV9TENvaQq+tJUZw16I3b5IF7SLhqNj1kjyhXNUVIalTL4sN5PfhduG4RslHgcgG0X4HYuxHnEk9vdBNPW74YcrfQnEHNHTWfiCk3w0sIjeW/hQkJmjnLckE1IGsaymq9xOU1oru5a19xsMOC8sOzcrvfJmNJUSnBN7jeIWPxLixnA3z+fc0dMkzkx4GlXYBsc1GDTxqfMxtAfZltD6yW//Rjhro9oQSsLo5SCtbHsE7RJQqFus2Ewn/4vmAZN8fVWp7n7TOZooQ1tM+UFzgCzlGKHHi4C2kM9vlYBqT3x9iTIY1AUPiRPbg50wUjmw1K1A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 847411ef-2e91-43d4-e18b-08ded6be6a18
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 15:44:04.6902 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x8Eiqy0eo0CvOlFQlojqgGiCbE4BXcenCbGOFjTxZPgd1e/MSIfOSLqIhermcvfANhyLA5d/NPojduZtD/35uyTFoTERhOuKV2bSeQtMI+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4698
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

On Tue, Jun 30, 2026 at 08:06:55AM -0400, Dawid Wesierski wrote:
> From: Marek Kasiewicz <marek.kasiewicz@intel.com>
> 
> Remove the advertisement of RTE_ETH_DEV_CAPA_RUNTIME_RX_QUEUE_SETUP
> and RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP capabilities from the
> iavf VF driver.
> 
> Runtime queue setup on E810 VFs causes queue state corruption when
> queues are dynamically reconfigured while the hardware rate limiter
> is actively pacing TX queues. Queue configuration messages to the PF
> via virtchnl can race with ongoing TX operations, leading to undefined
> behavior.
> 
> By not advertising these capabilities, all queues are configured at
> port start and remain stable throughout the port lifecycle.
> 
> Signed-off-by: Marek Kasiewicz <marek.kasiewicz@intel.com>
> Signed-off-by: Dawid Wesierski <dawid.wesierski@intel.com>
> ---
>  doc/guides/nics/intel_vf.rst           |  9 +++++++++
>  doc/guides/rel_notes/release_26_07.rst |  2 ++
>  drivers/net/intel/iavf/iavf.h          |  1 +
>  drivers/net/intel/iavf/iavf_ethdev.c   | 22 ++++++++++++++++++----
>  4 files changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/doc/guides/nics/intel_vf.rst b/doc/guides/nics/intel_vf.rst
> index e010f852cf..86878330f2 100644
> --- a/doc/guides/nics/intel_vf.rst
> +++ b/doc/guides/nics/intel_vf.rst
> @@ -131,6 +131,15 @@ IAVF PMD parameters
>      * ``segment``: Check number of mbuf segments does not exceed HW limits.
>      * ``offload``: Check for use of an unsupported offload flag.
>  
> +``no_runtime_queue_setup``
> +    Runtime (post-start) Rx/Tx queue setup can race with the hardware Tx rate
> +    limiter on E810 VFs and corrupt queue state.
> +    It is advertised by default.
> +    Applications that pace queues through the traffic manager can opt out
> +    of advertising the runtime queue setup capability
> +    by setting ``no_runtime_queue_setup`` to 1,
> +    for example, ``-a 18:01.0,no_runtime_queue_setup=1``.
> +

Do we really need a commandline arg for this? If it's known enough to have
the extra arg passed at device init, is it not also known enough to have
the app not do dynamic reconfiguration in the first place?

Alternatively, if the user configures packet pacing through rte_tm, can we
not at that point adjust the driver to disallow runtime config by returning
-ENOTSUP when reconfig is attempted, and no longer advertising the capabilities?
Runtime configuration, whether with or without user interaction, should be
preferred over devargs whenever possible.

/Bruce

