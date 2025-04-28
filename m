Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F575C369D5
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Apr 2025 15:21:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A9FB0402A9;
	Mon, 28 Apr 2025 17:21:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id BDDD14021F;
 Mon, 28 Apr 2025 17:21:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745853694; x=1777389694;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Zrnhv8EijPTlvZ8ovfbCteBFhs5KmixUV/WNqLq8l7M=;
 b=LsdL8YcprR7nTvma3UF28zinDijeCOHyAQwylBYJTcTPQwYvMViCQndu
 QXQFeYYqMLVtS12KqtYO8baS4s2FvOFqEi9xHNtX2iT75om7dk0JmTZmH
 28OWMWB5HiezPW/ZsqhKc4wjE9b4Vuk5/6Qm9rUW4ixkbz8u5D0HGiocK
 ON2Xo4ar5hpi/lEdoUgXAfmRh8GRnmMu4XOsZK6r+yWI6LobYX5v74opo
 IovcUEyEXVmKdeG3EG2xeDrZ8e64g+yIP7frns3l1v9m6fHd8U164htFm
 i05RU4viMrr8/qu0JoEynFHiuWjclrUKWJUe8RzF9dO0CywHscJMCvrqp Q==;
X-CSE-ConnectionGUID: 43vwH/dLTzqx5KYNQLarog==
X-CSE-MsgGUID: RcPXKTIKRuCVxG+NqPD6Bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="47610221"
X-IronPort-AV: E=Sophos;i="6.15,246,1739865600"; d="scan'208";a="47610221"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2025 08:21:33 -0700
X-CSE-ConnectionGUID: mSlXrWhKQE6CJ7y1iZkZZQ==
X-CSE-MsgGUID: 0SmcO8QyTHaq0XiWOC3JWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,246,1739865600"; d="scan'208";a="133440463"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2025 08:21:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 28 Apr 2025 08:21:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 28 Apr 2025 08:21:32 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 28 Apr 2025 08:21:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xphylC8mPrQJ8cpHCA7zr5CYsZxqTRYrHCXuln4sNoWCMSsmp1iHCvFSLwBcxcRpzBGoKO10/isStoltquMhzvK5huaBNzDuzpxyLdKiaj3uxdWDaS0Y3KdQ0mMZ1b00k0D3m/kZXTER079AS3cgtjIOo8MpWdx3kqPXDW1CWsBoaQyK855PYNBsvhWmi0TE1ULlMgXcMHBHoCyqoLMQHE1DQP5jLHBLQgyNnSsNQIoKfLBhR/VhcVhccDMsXz5HHLGiYdji1f1NL7pGfCYNFyXP+q+wpzBQCV7+xsoHaEXPb7hjl6uXCqAFd8wyJSb7qPo1bLmS8U4HQnWw+Ft7og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9jFfkVZqhJMZ4hTfD+C2waRYfO/N3wIv3EFcRgk/sw=;
 b=yNkrznhkYtd2/+xHySs8ipvdHzapgJ5Wp5G02MAa4nq+pkTbjVFPh/+Qs2tDRbrNCeTF2TTBP5sTn/OsoW5NTqCzh8tS/fIb23rJLnKOOZXZRyOTz5OIKZR6+fqXGzzYURkznDxOFFrwS0dgaKSGjIbD26Z3F/RiLBrKtkm8/I71oyF7iLT5nB3CkUeCfD86KCeapDibChx6hX6poceqMgffB2gCkMA+tCwjnFIXg9b9s9ECArsDMn0uJ4+vK7eUmonvOy7VDidmGunyLcmVaoQ2z8m/Gm/pXA/xARjSDfLVycKAScKND43HUlxAuMAW/HihBQHHtAnxJybofR6VAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB7326.namprd11.prod.outlook.com (2603:10b6:8:106::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Mon, 28 Apr
 2025 15:21:03 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 15:21:02 +0000
Date: Mon, 28 Apr 2025 16:20:57 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Kaiwen Deng <kaiwenx.deng@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Qi Zhang <qi.z.zhang@intel.com>,
 Yaroslav Brustinov <ybrustin@cisco.com>
Subject: Re: [PATCH] net/intel: fix igb tx queue offloads capability
Message-ID: <aA-c2XuK7SFVKqqZ@bricha3-mobl1.ger.corp.intel.com>
References: <20250414085353.848901-1-kaiwenx.deng@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250414085353.848901-1-kaiwenx.deng@intel.com>
X-ClientProxiedBy: DU2PR04CA0062.eurprd04.prod.outlook.com
 (2603:10a6:10:232::7) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: e307eca1-bb7f-43fb-9eb7-08dd8668499b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5bZoXUuHqHiRGf6fq7o297pX3R8kOxWzHz/ddrWhmlQow2++wurSNC+UihHB?=
 =?us-ascii?Q?dwccMoFRNi4jJ2awwFXw/3hJsPZOb9QMTCxOJlUW5j59wk9BBrrQUnLXP1+g?=
 =?us-ascii?Q?kkLNpJEakTEHNj8OvUxHnOrkAlbSVjcuKyGMOtRZRnbkGZJUkaNq/UdHNPRL?=
 =?us-ascii?Q?Nsd7+v7vCPRgx2+w37Q74mX3HtKNlHPjwvGIrn7bGviPeyTixHNWnWZj0hA+?=
 =?us-ascii?Q?Jt3T+o6FyAvMVOdK8rPuGQOE6IEfzkNutNdTDtsiGdCEncib+makR166Zqp6?=
 =?us-ascii?Q?W50UnpT1zp53AZjouey/kAan+MB0Sd3nbRxa8ANwJvMnURPz1cXYf+gt6RAn?=
 =?us-ascii?Q?n+z2o0EqPpxM+rICNqTYHj0qkXyFvCWi7i2c68bW2BfmcJ0ILmxC3dcuRPd/?=
 =?us-ascii?Q?y9j1aDw3dJBJE/PNllMR3yqwr9CJ33IpAo+EFvgBfTLiWoAVkgMvY80nrm/1?=
 =?us-ascii?Q?3hQG6dwDOyxoz2ykLZNvw931XgiP0e0d1w3ZuICBq9w+MchDqd/CYY73L1+r?=
 =?us-ascii?Q?O+E5w0AY1HizR7sdF8mln+VIndmQIKLCZK0YZn9OXHJ9kksPH8T72uL33XN7?=
 =?us-ascii?Q?QH0faLcYuwsSle9i9zA6WNsdvAbl4cKMEb95i+UxusBXIfkgsC973KfdLIs7?=
 =?us-ascii?Q?bgNam7v6lfC6hMpeWKWdAvThg26BURxo9EGojZUgQazMjZWSZMntH/rNf4k4?=
 =?us-ascii?Q?Y2HB3WWvt/aEQDicpdjim+IEJcEzHSkMH023UYBMOsvmlhjS0AgP0xgdS/Zy?=
 =?us-ascii?Q?iufgysoD3+S4PUsmR+9oJeo5kcVT44zU+6uHahkSeKfdpc7LH7J8KQfUGMhl?=
 =?us-ascii?Q?qaQpbMODG4FU9Zw++8G1QMMLrPIFOShkLi4ZJVkXG07pm+8LH+nRm+IjF9yr?=
 =?us-ascii?Q?ba8WA2oAeaP8/deQoGE0NoJaaRq2Iri6HUIi4TPtptVfy8COolFbm4/LSVne?=
 =?us-ascii?Q?mjlFT+3sXVpmdF1vadbXXWAVZvk6/DP/3OylSEJgfQTyfpSfPQyvaAHyDR8e?=
 =?us-ascii?Q?Ek4Wn6EcwqRDFQvGzUoP+ZOgsRhCHOATQ2GGSNoVpvp8yHAim9fi1+kvNEaQ?=
 =?us-ascii?Q?OafuP3EQN2uuxv7USY0kuPEYbx9cZ6xMTpQW0ROg8O1Fo7FeuiUfPvnRzXFp?=
 =?us-ascii?Q?Tyj4pdsB7aX2J76tpoOCmWrjrMFQaSqG1Cdtxt2IYbBrfWHmWClips1oejFd?=
 =?us-ascii?Q?elLNatSGeUwRMuMRDIK54WwEtD1EfIBIVjpni/LbufnILlApnb5fIDWxT9Wc?=
 =?us-ascii?Q?FJC6mHaMKV1qPtlJxgBfkq0Y5BaVfzVbPHYeI8TvTTeiZJj7DR/1CkgAyohG?=
 =?us-ascii?Q?aJUVWBVIc2YZfCWG4oLhnBEBkeQBitL1r94bWZ/joholUyAuA7zVuJZGfbf8?=
 =?us-ascii?Q?+mLszP6RXqeorDRez3LymuuBKg24xLSL8XdupijI/rnhzyFStzTYs64fNe8i?=
 =?us-ascii?Q?ppWocxIxkfM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?40IDEzHyPUTIDG5PNvWppQ8TFiacphRm9yip7/F8Rfm8RxfM77TSuUckTpQm?=
 =?us-ascii?Q?kKsx/UTJgJQnIASUZ9oKKXIlVkF58ICtR5Gzkg5v40g4o5do5wXq1zTpY4i5?=
 =?us-ascii?Q?PpQMCNq8+9ozO8iuA71/zV+kJnBWNgfS9RoaY9HFdzsIemTFbrXilvdDa3nx?=
 =?us-ascii?Q?BcvJZTgw881tZb1LcLWiTgYG+3GMuIfciFxsBD3Vi0qczOwBFmLjbfRzP69h?=
 =?us-ascii?Q?XAujAqP2UHkD4fPvDGEGLKKBLJV8WmEnBA9/eFKnVQ1INu4VD8ynfQykpZRX?=
 =?us-ascii?Q?TNkAW3l8lcTE09CXXq8sQsBS/1oxf+1NW1QVpWwwmdXJGEQvQi/6WyluDc+D?=
 =?us-ascii?Q?MeJLKX31ofYDXiVW9aEDXUMnStdT85qhhOS3aLniqUszKrw9n4JtWql8Fs3J?=
 =?us-ascii?Q?vMC2/ZIii8wtZbZrolFymCNFiWz7oa5lpQ9QJxKNnLVpEcOg+XoH5TISQ/rQ?=
 =?us-ascii?Q?SQvedRzO/or014bNwedZL9HoeAsOTfTGjxXBs6pc2q3jkkhq1URNjApgmDTU?=
 =?us-ascii?Q?GNpGLv6t/4/GrznwW2bgZHhJopBXB4bMTnP/zXRbSMAEj1VfNSuzcx4Qw6pW?=
 =?us-ascii?Q?d1peEAKtP+OiNYW/SAb2V94jqSlStguDBvQ7ssxiNNYJ9r92B5aLErQ9EN6B?=
 =?us-ascii?Q?oWW9PobPF2i1AL1nxuMKEa6ylKpo3VgAonaKICLVUoVHz+aB1ormdvn/jg2u?=
 =?us-ascii?Q?o/Nr+lfpgsH3XGBozR3MnahbFaE/r+0ltzWzCDkd3akiSWQV8dzGONCKZZVe?=
 =?us-ascii?Q?/LBPp7gbZismzx40NE4jhDYRfwvXhjJKSNCp57bBP5BKC5q3JAYupcamsES4?=
 =?us-ascii?Q?4Jm/iB3Cs8zFbFpXbQ/vxBg0l5Fi8aK3/JB1hEBRasj+59S2ZMRwWc5LwvKV?=
 =?us-ascii?Q?IVz2xt1WFITfqrqXGnNmVe1gDk7Y75KsDBS4xZvZxk2dCxAid3SuSZvgdI85?=
 =?us-ascii?Q?/sChBXwsVQG564n69Mn23W01W0adWLFS0v2ZbZEb9tJ4UkuPsiwmhqt+7U95?=
 =?us-ascii?Q?RDn4YbgGzcDnpKtN6L62yarqbs4TwQNzvoljUu+eCcFmDqujabo2C/0XjYzi?=
 =?us-ascii?Q?GDpkL7crOc6JkEwsI84SPIR0HYLkoks6UeT+fBaSBiTUN25JoN+9sO/cy57j?=
 =?us-ascii?Q?DG4YzdSSfBVSmSMnkUj7YWImIo0k4ILRspEIokrWyA9JP4DDCbUPim7EO4s3?=
 =?us-ascii?Q?n+jhEnsywCg4uKM1D1YEr1Dr2+03KNlhj/jhG4X1031kQbIez7N5SkgDhKo4?=
 =?us-ascii?Q?+2u7Uivhf0NCFW/hr/GH8bYg8kYFoJKssCx0iGOHHLJGLUV0sCsuIuALsFvb?=
 =?us-ascii?Q?ounRdpNt/sMKVIFzB2TR0T5WdMhF94zVrqSmBGxhnmk+rGZtbmhFTtQ066aB?=
 =?us-ascii?Q?gYlpt9DMYaA2fViBVzV4UXeZa7/jKURxs5pIvleS0V8f1ZyvOD5c7GTmkmMq?=
 =?us-ascii?Q?PJDNw5TJAPMqoNecbY7K8+IbHbhjw9bxm6gkay73VlQ1PcTYgwNKVCybGRLB?=
 =?us-ascii?Q?haqAFrC7KmfFAnACt7nIpVUZCZJIU7W/v33rEpDEHxK5KdMX1T+sXGFbdhbj?=
 =?us-ascii?Q?vy7ITi2m1h5vL8HRf28kWXUqMpoxmRcBNtkixZSShtwmaAvGfJcfNh191AYn?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e307eca1-bb7f-43fb-9eb7-08dd8668499b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 15:21:02.8774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LMsjeKOsih5OUsY0TA0oTxGjgdl2vmQ5oTwuDKhrdHjjLz+0eUSqxMZLokwk9byvKifUkGQLMLUSmfz3KmTIs0xnso7ibVf6PN4dyy7TZNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7326
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

On Mon, Apr 14, 2025 at 04:53:52PM +0800, Kaiwen Deng wrote:
> The igb driver assigns the tx port offload capability to the
> tx queue offload capability.
> 
> This commit will fix this issue.
> 
> Fixes: daa3b0833f08 ("net/e1000: fix Tx offload capability typos")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Kaiwen Deng <kaiwenx.deng@intel.com>
> ---
>  drivers/net/intel/e1000/igb_rxtx.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/intel/e1000/igb_rxtx.c b/drivers/net/intel/e1000/igb_rxtx.c
> index 4276bb6d31..b63de2354f 100644
> --- a/drivers/net/intel/e1000/igb_rxtx.c
> +++ b/drivers/net/intel/e1000/igb_rxtx.c
> @@ -1490,11 +1490,9 @@ igb_get_tx_port_offloads_capa(struct rte_eth_dev *dev)
>  uint64_t
>  igb_get_tx_queue_offloads_capa(struct rte_eth_dev *dev)
>  {
> -	uint64_t tx_queue_offload_capa;
> -
> -	tx_queue_offload_capa = igb_get_tx_port_offloads_capa(dev);
> +	RTE_SET_USED(dev);
>  
> -	return tx_queue_offload_capa;
> +	return 0;
>  }
>  

I suspect there may be more instances in the code where we do this. For
example, I see the same pattern used in em_rxtx.c in e1000. Can you quickly
check our other drivers to see if the same mistake is repeated elsewhere
other than "igb" and "em"?

/Bruce
