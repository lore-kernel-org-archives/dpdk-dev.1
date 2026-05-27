Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC51CD5BD0
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 16:28:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEB9E4026C;
	Wed, 27 May 2026 18:28:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 71ECD4014F
 for <dev@dpdk.org>; Wed, 27 May 2026 18:28:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779899297; x=1811435297;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=oAt1UJU8ANKDnwul5vBcvzr1mlUKtjFf75nleiQcyEM=;
 b=KSnNULV7auOHGgvZsWAY0NrdQ++OgPIth+b+RINDr+D0Rs3fLwN6/UOJ
 L2wC5A17yIr23Fd1VjF1/Je3rsbbs+N4n9POuMv/nRq5S70p1XpA9GE8d
 6xlBuWmlFM+x8prg1/suU4YQV8jgkAX6rX++tW9YTcRnx09FswapKNR2C
 AIPNsczb/sUeRb5v08Gg4LQdKWB9ho/uuvUE3cFP/WYxndcQxPU+u5oz/
 X+EJttxlQueOlwjwbod5XeICVd2InITzH7MC291RBpoYo0+V0JCaAlV7S
 XIMkAl7pFn4iU8/TTFVIC8VESoXmrbtQsFK/ki2e2WNMEq7e3bNtjvA7i Q==;
X-CSE-ConnectionGUID: 891Vn0uLQW2ODRS+gvZ2Zw==
X-CSE-MsgGUID: 1ySXMJx8TBKXrgasbI+mvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="91040675"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="91040675"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 09:28:16 -0700
X-CSE-ConnectionGUID: eubm2BTkT7qoKKcCoq5tsw==
X-CSE-MsgGUID: tM7FdcsiSZafhYTU3MRM7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="242353172"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 09:28:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 09:28:16 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 27 May 2026 09:28:16 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.14) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 09:28:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6wRBEXGy4+qas96Mh5YwqbrNCYN2/FjZPeltgfjNIztuufAb7niSPb3kZY4paZNVQU8LWacGOxL1dA67To5maMq2t+IrqqfE4mig+uw5DCya5+A8SQGfzmbvSTu0pLM5fo5WPSwZyTwe3qP2XWa2B63timcsFFysDQGOGl03+/eULA/ofblp8qD36S0JdC7figH+VyOkWwcdn9CUNwWG8biEK9hWryXW9vKoAPWC+6ZRqi4ABD/9kq8+iJcRFlQkFWffiH1l04ik9kJbPBDQGGcZXamu5VzmOxOuBn8NAa1H018sR5161F87tqUUSlgX1leJXc0RPKL274QhuAJJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KP6+st9j3wIEbD9NeM3HVEWAvUeheaYxu/26dFkdnTk=;
 b=sYgJFH3z16b0ioSa6SHZl4lqY1CnhdKQVBEGPrJtOwBbDvy9NYO5l1XPNEEd/L2aNo/e6+QlJ/+zZXDFDi38oBEUa8QS9PCRDFs2z4ihxK+4NwDVtQyGfzcuIOWY6xSz84b5IiVYbCLqU9Xmy8C37Y+u/cpXizrgtMU2HkbsxmdIjBgUTVtD5iqgR28D1C+sn6cP1Lu5EBa19GupBNvqgDQY6ZuSYj4aUgX75+7cKl9eg4Vb45ZNL++eT10eZx6OJCQUFatVgIgeWuen4MWlGoYy/vJ6+g9eXNxuUrzbiV8EubKUZfbtSICfiYtM7KfqUzpXGSx1i6GxBUIW/RZ4jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BY1PR11MB8078.namprd11.prod.outlook.com (2603:10b6:a03:52a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 16:28:11 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 16:28:11 +0000
Date: Wed, 27 May 2026 17:28:06 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)"
 <humin29@huawei.com>
Subject: Re: [PATCH 3/3] net/bonding: remove redundant function names from log
Message-ID: <ahcblnK2whRjSkC9@bricha3-mobl1.ger.corp.intel.com>
References: <20260417165530.653328-1-stephen@networkplumber.org>
 <20260417165530.653328-4-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260417165530.653328-4-stephen@networkplumber.org>
X-ClientProxiedBy: DU7P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::14) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BY1PR11MB8078:EE_
X-MS-Office365-Filtering-Correlation-Id: d78601f1-b6be-44b2-8dbd-08debc0cf12b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|6133799003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: MY3EplZxffKG5E3ioXZGyJmelQR+vqB/T4W23M4X5sFxV/mCUy4y+XhZ0kBBZIo+vGUbtlragbI8vXRQmQWJ87a6me/dmMax44+LwIap+ag/OmZk1dRFiW5V+eAgCETb2Se4FkOOoviE/hFK8ECdGWsQ5qN8rL6b+qags8FpwwSem51k//fPvAHxt4+s8NyHYP/6ffef2mij0u4BP7yyXEQj1qDWIMh7wuvhGiqGPGk7n06NmdmXfJFauMMYy+CTQ2DmcFL5BytvXCrb/92iDyu7ilparTbUZdXSQdI7R4LQQvFp3xv77LN11eh1AxIqmzJoJF0Ku1Fj40SU02giiA5ucEpKRG4s7dEoLF7fGMLZpvjwkkdVxgHt6MWMP66oisahaTtqQzbwRUXDpv3S2NKMf+I1HTh5IwNCZVC+vVDkwkfQvSufouAky3gft8TioHNWtjZpdUXCBUFRH8s/KnPDkzaA4TwM4T0jhjuyJlh6/p+UMhWrJO7aQ3pTUiaBFbWH0/amUEOovvpJSNMHK6+9oblGO8EOgsrqfZSyJi+ncn7/WhuSfC/QFO/XBBKX9TDB9zGuT6THZA1P3HuZwgwgiP+EJXfzMUoi65mFsqSL03ilrjjQWgKwSXhMqNgdlTRXaGF4ZUrek7EDVRVQur/e2BeRsb9UaBYTlDX8hX3d8PSJeZBLWmQ8fpoSpEkw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KKOxm73xx58yFmIf8MD9RRfrMWy7hf3FlaCXLb8gc5+VuWcexZxGT224Jelt?=
 =?us-ascii?Q?Cz3iK9CVPFlZ3yjqWKi3LWSfLhMr8PpVDJ2u0IFqaNr2OtagTiMlEvsjbEyF?=
 =?us-ascii?Q?NJNwalq1cB8Y29ieyLNaPqNJ9+vTnfrtMT8FvsoWo2tBnFMDlHQTv+G2oYnn?=
 =?us-ascii?Q?0PjMzsM2cnoCZ/PD4zATFXx9BqVLouyVy5JUfai2v4eeuDIVQLZhhwoDVR3b?=
 =?us-ascii?Q?wAAWGPThFA5s24LPmGLWkMoxukSVHkZDJ2w/gTfNfFrCUjNp6hHYxUKjVMGm?=
 =?us-ascii?Q?6WY3xV+APugOwWb2Fm6rAHPBS7O5ZrK0xOC+P2HvEE2QjWYq6VXwmTpF9Sbv?=
 =?us-ascii?Q?j14jLtO1kvmuq8dQu3n8tUegOHxd1pAqprG4ERkyeBiVOczBzCKxZlTTLuyC?=
 =?us-ascii?Q?Vy6vxueQ/rpMt0ZrS4Ly2saihwUlfM+WwKCzGW4pbRn1OUOp2uOz81AgA3YB?=
 =?us-ascii?Q?2Yo265Kw9/2eluVNVSTv01OZN0pKPOhnutTo0rwek8qt6jViS2oxMD7NFG5e?=
 =?us-ascii?Q?1bdPByys4mfVxNuWmjkYA8IEfsqIl9FjFcZYJaZRLZd4tMDMnP7HYgvzv+OD?=
 =?us-ascii?Q?g5vcGvAALQF1ZEkADdOEx906bXF+V6ss1XQUinKhBdBup6x/I0FBbw/4tHhn?=
 =?us-ascii?Q?M3iXvSwm/j/04xN687dkyDs3Eo5QafM0aCBekBqp/g2pA66J5+lCMul0Pvgy?=
 =?us-ascii?Q?XH6bGky7asuG9l6Zo9uc+2yzKkBY6EZmt4q+cbDUNKae7pTqKEiEJYSazWzV?=
 =?us-ascii?Q?LfvgsP/8OTR4wo+8qXELqxNHp79J6pPwc469xJkLUDMs0Xag0JBw7b4EtAFF?=
 =?us-ascii?Q?Cm7H94AN5CpCekzrfHHiXGtku8pRxlD6CEcNM59uNv3r8AhcFP1jBc5KxARm?=
 =?us-ascii?Q?XqYTQovLPr9asjyDNrxd/thg7jdiMYoK4nJAK1gUJlEO1EdvRCfcumDwzZOp?=
 =?us-ascii?Q?URtlzGl0eU3H4/7DOHD7RgSiQG0ukjqiSZxIriZa3eIjZX+CPm4d1fgOyIw3?=
 =?us-ascii?Q?F00iWjEYTr/uVAUaj65tEKj7nt8uD1/h464HrOZjIFHE8Nyjd3ZgqmhZ8B9F?=
 =?us-ascii?Q?+lgsyA+H/pa6P/ckXvVyJHzH9+GNP752e5Z652qdxslqr6t4YBss3bJzCryn?=
 =?us-ascii?Q?jqpT4Knaj8UymuLNeb/ZRa9dOKlYP3S21gR5lu+d24O+euwecbGhmwZI/Vai?=
 =?us-ascii?Q?PDuhWpOHt7+w1P42FqV5jIdL0HNRJvvsPN6MIWF0oKbvY92+QIYamG08kLWN?=
 =?us-ascii?Q?qBF+MnQ/fHoVirGNKXDsc+uQzNdLJFEl6lE3T8d4UzHUWfVyRdvJepzeNEma?=
 =?us-ascii?Q?5AYheDF83l00oR49KcLWw+Dqm4g84qbIh5J+EW/zv+nsC3R9Un/8WQDp3/RG?=
 =?us-ascii?Q?/XFTaPwO8ex16CzQKdyLNNHua5qksvUTXss4t1d6M9u8n0sAwu3B76tvUouT?=
 =?us-ascii?Q?h6WWhsx+cJ3UiC8MymbFCmLNPnqZWYx160pFHtQdqdWqVI1gRms4pSY90u7r?=
 =?us-ascii?Q?7613JvffFvFHuHkV5Txm9ExuhwHFsp5WD1Ag4ZOYgtc+gFGfvq27Fx+1yeKp?=
 =?us-ascii?Q?N2hyT6NaTd++EuTeB3gc+q/AS1evHETNMHlWnw+9KSQ4rclhRQWQ3vbs1ooA?=
 =?us-ascii?Q?heyiPZ6lWasLlx9qWDEjVi/Oy3joNN2gyC9eS95HB0re67SPp6YKDjs4yjs4?=
 =?us-ascii?Q?ifC96+bs3LTnvWKK20mlc7B0729/XyZmRmlPhqq77MDgJdku1BWpTK9YTEJM?=
 =?us-ascii?Q?f/OzgfitZVj0gobt4WM0s2/REx0uj00=3D?=
X-Exchange-RoutingPolicyChecked: ZXoEbaL9GzR8mTUzZBRrec4QmTpDHA+mI40/kcit4KLzwp28bw7TD/NCy6rzqLEkHomZGlUvhdMarYHN7rEvaYJQu5SP/pgrhUjkTSMLFEsACdTxkHEVDLoFeMjdx4gVoq5QkIdjNRmDHr26kD0wq/6tJarcTRahqjAq3Juhub8RuUlvYTNFtAs08yr1QqFHD1tvNUDFJHDXGoLP1yVGMcUZTCirgPyd6XHAQqy43U+JplL9JB91xNWpqga/t32DgCNZxANrMGQCmrbd1kpYGevwBcAIOmAp59q6vDJn5ch4D3rZHRtO6vig2aYKMSJVWrojVWG3mtxQdvIwPANI2Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: d78601f1-b6be-44b2-8dbd-08debc0cf12b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 16:28:10.9242 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aS8J/2xkl1BPgUD3sjFnRHNeSH7p3eUYLD3wbVoPqjQw04XWnmnAgLBcEAWGu1lYEj7LquP7lbljUvOtvclGg3uczdElirWnDu6sOF656ZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8078
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

On Fri, Apr 17, 2026 at 09:51:37AM -0700, Stephen Hemminger wrote:
> The function name is already printed as part of RTE_BOND_LOG().
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

>  drivers/net/bonding/rte_eth_bond_api.c |  4 ++--
>  drivers/net/bonding/rte_eth_bond_pmd.c | 23 ++++++++++-------------
>  2 files changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/bonding/rte_eth_bond_api.c b/drivers/net/bonding/rte_eth_bond_api.c
> index 9e5df67c18..78361e73d4 100644
> --- a/drivers/net/bonding/rte_eth_bond_api.c
> +++ b/drivers/net/bonding/rte_eth_bond_api.c
> @@ -485,8 +485,8 @@ __eth_bond_member_add_lock_free(uint16_t bonding_port_id, uint16_t member_port_i
>  	ret = rte_eth_dev_info_get(member_port_id, &dev_info);
>  	if (ret != 0) {
>  		RTE_BOND_LOG(ERR,
> -			"%s: Error during getting device (port %u) info: %s",
> -			__func__, member_port_id, strerror(-ret));
> +			"Error during getting device (port %u) info: %s",

While updating, I think it would be good to update the log messages to be
more natural-sounding English. s/during getting/getting/

> +			member_port_id, strerror(-ret));
>  
>  		return ret;
>  	}
> diff --git a/drivers/net/bonding/rte_eth_bond_pmd.c b/drivers/net/bonding/rte_eth_bond_pmd.c
> index 6a42257d2b..e2819c931b 100644
> --- a/drivers/net/bonding/rte_eth_bond_pmd.c
> +++ b/drivers/net/bonding/rte_eth_bond_pmd.c
> @@ -210,8 +210,8 @@ bond_ethdev_8023ad_flow_verify(struct rte_eth_dev *bond_dev,
>  	int ret = rte_flow_validate(member_port, &flow_attr_8023ad,
>  			flow_item_8023ad, actions, &error);
>  	if (ret < 0) {
> -		RTE_BOND_LOG(ERR, "%s: %s (member_port=%d queue_id=%d)",
> -				__func__, error.message, member_port,
> +		RTE_BOND_LOG(ERR, "%s (member_port=%u queue_id=%u)",
> +				error.message, member_port,
>  				internals->mode4.dedicated_queues.rx_qid);
>  		return -1;
>  	}
> @@ -219,8 +219,8 @@ bond_ethdev_8023ad_flow_verify(struct rte_eth_dev *bond_dev,
>  	ret = rte_eth_dev_info_get(member_port, &member_info);
>  	if (ret != 0) {
>  		RTE_BOND_LOG(ERR,
> -			"%s: Error during getting device (port %u) info: %s",
> -			__func__, member_port, strerror(-ret));
> +			"Error during getting device (port %u) info: %s",
> +			member_port, strerror(-ret));
>  
>  		return ret;
>  	}
> @@ -228,8 +228,8 @@ bond_ethdev_8023ad_flow_verify(struct rte_eth_dev *bond_dev,
>  	if (member_info.max_rx_queues < bond_dev->data->nb_rx_queues ||
>  			member_info.max_tx_queues < bond_dev->data->nb_tx_queues) {
>  		RTE_BOND_LOG(ERR,
> -			"%s: Member %d capabilities doesn't allow allocating additional queues",
> -			__func__, member_port);
> +			"Member %u capabilities doesn't allow allocating additional queues",
> +			member_port);
>  		return -1;
>  	}
>  
> @@ -249,9 +249,8 @@ bond_8023ad_slow_pkt_hw_filter_supported(uint16_t port_id) {
>  		ret = rte_eth_dev_info_get(bond_dev->data->port_id, &bond_info);
>  		if (ret != 0) {
>  			RTE_BOND_LOG(ERR,
> -				"%s: Error during getting device (port %u) info: %s",
> -				__func__, bond_dev->data->port_id,
> -				strerror(-ret));
> +				"Error during getting device (port %u) info: %s",
> +				bond_dev->data->port_id, strerror(-ret));
>  
>  			return ret;
>  		}
> @@ -2347,10 +2346,8 @@ bond_ethdev_info(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
>  			ret = rte_eth_dev_info_get(member.port_id, &member_info);
>  			if (ret != 0) {
>  				RTE_BOND_LOG(ERR,
> -					"%s: Error during getting device (port %u) info: %s",
> -					__func__,
> -					member.port_id,
> -					strerror(-ret));
> +					"Error during getting device (port %u) info: %s",
> +					member.port_id, strerror(-ret));
>  
>  				return ret;
>  			}
