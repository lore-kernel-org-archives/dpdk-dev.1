Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94570CA1010
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Sep 2025 15:35:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC32A402E7;
	Fri,  5 Sep 2025 17:35:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id D3BCB402E5
 for <dev@dpdk.org>; Fri,  5 Sep 2025 17:35:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757086502; x=1788622502;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=X8ppYS4ddq9i+xabl+LeJxxtAmnBeS90O928s12BKEo=;
 b=J+3+dx/zCt9q3nJWqFpy10Fzdkgf8xiPsnbSD69gPyWU4ZHd5vAb0Aww
 kDgkhRINskGD2e1elJj1ufJ1BnpaO9sbe5bSoOkotFuuVM/1q6IkNDxhj
 QWole/vNixMUGKVDYudw4VXeRWfYJtMmOdCAePLiHxJToAA/p1NKZEk5L
 V53VTRWQmzvIoAlHrBTNZmoauC2NUnzzb+wVNmprdEogmaO7nIPta85eK
 tBIpxAv95EXx1WSeL8APO1+3vqZ7HO24FHWt3ajaBowcXxIWHjSSNzN3J
 bPEH+xBDK7qcRfOYcAJWtMPcWm3fjBm4i7RaGDi2wzCADTvcz3JJyMmAl w==;
X-CSE-ConnectionGUID: fZg6dZo0Ru6BgzJuch0ktQ==
X-CSE-MsgGUID: kGwpZFbWQCGcHQyJ1YsWbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="70143874"
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; d="scan'208";a="70143874"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2025 08:35:01 -0700
X-CSE-ConnectionGUID: CsPmUVY+SSiYKUx/0Embzg==
X-CSE-MsgGUID: uvUydiCOTSybkByoh38rAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; d="scan'208";a="172069392"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2025 08:35:00 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 08:35:00 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Sep 2025 08:35:00 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.58)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 08:34:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZGOF7xtuw4ov6O9XBIn4gSTsFqudUfEE7hqt3NmULZZFYsjXt25UE0wpRJ2DjA4CDW1EHgtCjnLUprTEgIn01q5nb6V0/PxmDNgVBqZrwUuk/ZPwWLm5BqLV3MfPND5DxDCydPfoXEBi0VLmkR4CUpNvytXEPWNkTM60v6zHeasv6KemxEw0wXU/mGkoF5WyJwruAhfvVaGwPqhfDUkcRmoRKtkxkzVn4b1pPHpDQV6j0izQttRJxy1XOzbs/jQpmzSFy5YzKj/KfTGKvdhzF9CTW2Gh4gO6sJLKsDITehQFMY5ljqL0qOcJpEEyvHs0lz1sfIiu2MbdkS4NqFqoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmBq8+aFJ99TNMAdkon20jeY8XeOpVWNcrs+B5siHPA=;
 b=XP+Wd555R5yiFWiDw0G0BROgQsmlTh+7DwcCMU7D0ux5La5U4D9hefD3H1ZtaajL0gcufIvfc0ZtGDQqK2qUExtPBhmmR7yASbpASrXTDJ37Ojq/RFVhFXvMmACFbjegZbKkF/XBKW4SABDKbKNv7lxh2TqfJx0Lrtr06EB24iIRp6C5SJedNEAYDB4WrSMd6yr6S2fqsVqmllEcRg3nMM2Ha1TiciX7CbP0wvfJkQgjyvy8UIS6d+0d5n2JwQxSZ+voHgNOk0B6+CDuZAYPzyDXpWzRwiqlPRqE1N+zFunKbtZPmElZuVvhepEcP41sHau+MWZFDzLW+to7WR/cdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA4PR11MB9395.namprd11.prod.outlook.com (2603:10b6:208:55f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Fri, 5 Sep
 2025 15:34:57 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 15:34:57 +0000
Date: Fri, 5 Sep 2025 16:34:52 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, <shaiq.wani@intel.com>, <jeffrey.b.shaw@intel.com>
Subject: Re: [PATCH v1 10/12] net/ice: count drop-all filter stats in Rx stats
Message-ID: <aLsDHFBtuya_1BBn@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1756833701.git.anatoly.burakov@intel.com>
 <8b65313e9b85aa1a27e429c5dfbc2875d0ab724d.1756833701.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8b65313e9b85aa1a27e429c5dfbc2875d0ab724d.1756833701.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2PR04CA0254.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA4PR11MB9395:EE_
X-MS-Office365-Filtering-Correlation-Id: 65463970-fad8-42d7-71e7-08ddec91c4e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l8OmynwjUSvbZ5G0TMsd5PLDT6qo6KoSC1KkBN0RycI4F/Jug3gF09szqGCf?=
 =?us-ascii?Q?Zc5y86u33W55VT/ObDlQfvge1ulPJgrY29ehKrAKL4GRxcVFnpezsaG3rZkO?=
 =?us-ascii?Q?6Z3iGHxATayGVpId4+KZDJ7WlMuxsDn1aDvkJE0NPBpGDqDp/S8z516CJAYy?=
 =?us-ascii?Q?PkJNmHADxAuYk4crH++PnpxbzUyo/gYGZ9FHG/ePb0/nyHIDdSDxlGs7gQoU?=
 =?us-ascii?Q?MP94ARRAkeHBLv7V1qJ6YbjRN5u82vhqJ+ZTglAxoE37NeK4FZ85iZTdEYuO?=
 =?us-ascii?Q?N5vYoUcgN45WfZWBWk6Blfyu6pzlryxIU1+dJU6yxFcsXWh7yHeu+nZOydzH?=
 =?us-ascii?Q?fU3mKs9F6eguLk4hapNz6c4vNZPljUPZAIgfSIhj6KvCkvBt4+Oq0ioaIkmN?=
 =?us-ascii?Q?bnx7jlG0mVstdCgYKXP87HafStoxl6kdGOgSMV9R9hyYb+yTElYpEKKtA2KO?=
 =?us-ascii?Q?/umOoTVVwtHCIw2pC/V8+m+8NgUBrVzORkC0J9on/bkXGcI4pjRJ02ltG2Ma?=
 =?us-ascii?Q?+U+NEWaB3tVYV4mUoMW89XIm2+dSgE6tCxfv9MikNSK5JSfvO/od8EIAcKqL?=
 =?us-ascii?Q?7QuTVlZSczBjP6/gwZoAX9IUt3cO7zyk7fXFzMxbnBU60shyXLp+4f10aZVa?=
 =?us-ascii?Q?hJYBAhmLD0cykcECn7q5chgdJNx3Oj0y3V6ZpsKdLkavm2MHqu05Moe27u0X?=
 =?us-ascii?Q?UFyivUwCUjm3M1zbhuj5/RK6uuFMXzg0i95Ttvt3cmzydD6w94h7Tnitiriv?=
 =?us-ascii?Q?wa8P4D9JxeLlesWL8dkVG4AF3tm87RtzaNQIZ5gzSjNZsog4vW/E3SzeGu2I?=
 =?us-ascii?Q?KwqNzdq1pj0t3y70XSbOLaAf6Y/y8qUPS8mHic/kHA1TkjdtPbg785qEgECe?=
 =?us-ascii?Q?I41OaNhTQZDw7fvVEDyKzg2JithPO7fE5NtDtI7fbrB2Upa3RCDY8gd5TmdV?=
 =?us-ascii?Q?FuY7PEAAHPeaOa3fyD3Hy1kLQYkHzSRVXwvNiwsxW0TBuxuJ/5pHTHtsplxc?=
 =?us-ascii?Q?BeOlVLimn/LRp52RY9/dllsjG2cTaSgMIA4sm0BWHUtKsgIfXyLh9WZpMbFF?=
 =?us-ascii?Q?/Q9P9+9ARf56drqg5poRsH5eQCsnQtRfnF+1s1bjFGA24TXSKLMsIqu84aaH?=
 =?us-ascii?Q?sbqIk9XSNp/UQ25080QjXaKy9/DBx3pE0cMIq5scC0ZZ6qpp5UkpdfK8qOmX?=
 =?us-ascii?Q?29qr/2ygwQ8AxzytXRyQK+n17ti7FYa0TR3oetPLxWOuf1CoBQjIGzPmTCth?=
 =?us-ascii?Q?vKCL3ANDfCSz0JXkfFO6D2CQg0jdpSOUgd9CrzBfZAr8V92euSDVSOnrW7J8?=
 =?us-ascii?Q?5Qsm441vqWRb7f2YsltubP2RlA6QbY4L5bQbW3wB0vC4Q405ZlG++JXG3899?=
 =?us-ascii?Q?S+IKgZNy+CwT5j8vnx5uQUolAScb+zX+Kr3gyMXuhNZ14C6n5rDJlUcKZIqz?=
 =?us-ascii?Q?03rA22mDJOs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hnP04tdmlXUJu0tLasVPIN/vOrcUFGYnT8nRbXV4/TfjYIDuC6VdQgYz7fya?=
 =?us-ascii?Q?t3MpyvjIcHy+12Nazet/3CwUVEiCe1OiU9DV5ZAmkCWJz3OtKRUkyoPWZ2p5?=
 =?us-ascii?Q?ZLuhTjROrhWb6pnZqIHkYiD2pcoj0KqC4L2ifYpaMaA+Z52yggyPi6qKc4/4?=
 =?us-ascii?Q?qik0/y/XRmhKqA2+mdZdzDT4EiPqykmtY57hcKAWR2MN1AZGNSfXObgki6HF?=
 =?us-ascii?Q?DSzSVFKzthouP2yaqd1SnKf7DBwFBojrNYVJjfYwZuglL+ySZtxiYe9gckiB?=
 =?us-ascii?Q?K7pIv3xgsxpz8Kg3tf2ATrfWwU65Khllh99x+tZNJdINxVp5GaeInMyuFpe/?=
 =?us-ascii?Q?PPtgwqbVcqa8M88jMzeWB/d0cXzT4cWYExQWyge3fZEAqTkOHlEYPW9XxCdH?=
 =?us-ascii?Q?UmjvHlbHTkf8aa5b+tnDALwQFXwIU9NZPWHcRO8cXJc1Vv+11SI1aGh+/DbJ?=
 =?us-ascii?Q?Qgy81yA28qsAPR0SMWUVijyre8bHsB8Oy0RER9EqnW05DrE7qZElE6JjPc9B?=
 =?us-ascii?Q?hQjfxmDbBON4fc6AmWpHAW2d3zCi3WNliCLU2JciTxhph3OO0v1nqMf+/1jh?=
 =?us-ascii?Q?QPoIWODJMvRQ0/AA4zS7dgwHj5+6VkZtRlQIlZ611pVlbtgfKNMdqP3xOai+?=
 =?us-ascii?Q?9CWB/72lkYYUR6ZkzvsH0pGPKGcnbI7odLJB9UIWKMWGQ7pI1Khm+sDGiKJr?=
 =?us-ascii?Q?w54452fTYKYu1Zj74cYW8IukZB9qn+90U0MCU9m/2ieymuBZbpiRIVV3Vttq?=
 =?us-ascii?Q?REQ22NGNWrvZQ8aJmJrompjnUpHHo0nY20SAbPg5Z8YTDmxrm93Lca4nCi4j?=
 =?us-ascii?Q?SxAGulzXxOwNiDcxk8JRuELqDonkmiPdYvLQZm7Aa3kJqp9eQ/Z4JSzgAMzA?=
 =?us-ascii?Q?KaKVSgWEmQ/RYoTGCj4yLaaqWzHxng+b0/pATrsCjvhLpbbuVwyVMdt2dE31?=
 =?us-ascii?Q?mUm8yK58fuencQ16fgYdim1YHoPagH6vr2spB8RvqXZUG9pKilcD4N8KDHeR?=
 =?us-ascii?Q?OyvO/KoDkMUzk+loPdrB3hcr7FIiz9SsSGSB897WwTPhQiQNR6/i+9cmQ2LZ?=
 =?us-ascii?Q?eOoVHbOUPUkBotXN0Wb6kSCkUYyRDaBuQXzjIme0Qn3sGvQ9TbvEKv79JKO0?=
 =?us-ascii?Q?fBIh77Gij3NSGHQvvk8g0elQUMldtquNMgJlEElfpL/lmJjK+Bf07CR+tKYY?=
 =?us-ascii?Q?h8CRXFgH5DbWBd75c35BG+L1VPp32UGYpQCekJkv3vOVxZF625eUefNLFv0B?=
 =?us-ascii?Q?CQk2oUpREZ3ZsxK/Ze92wsrFPE8RHCP6cKmHd0KRFEo7naTBlmwYkXwqCAtO?=
 =?us-ascii?Q?WkoAmFRedILCGLeW5ChOefmVcaCzZlO5P9ge5c3cvFbRFDfYZ5kAJaXS5R3o?=
 =?us-ascii?Q?/dTuJkGOIRTd4Y/UzjVVcDkDL0yJJG0JZQNSizzzUUAZkUOP34Q5Mo9hpOQr?=
 =?us-ascii?Q?+sSCH2Imc16xbTDg2y3pq//3h8iaEliNj381CXYQJLV41AQCuzEbM1dmD4vF?=
 =?us-ascii?Q?07fI22ZDKW64FOmoR7bXJRPBqGwmZxFogMF7qbVjT3pl69JO/rJLWVRUdSMU?=
 =?us-ascii?Q?zm0A/ALTJW/Fow01fmZ38ZtbhwAzL0kbdmoNhQCBreakKEEOfQJAuq14umHO?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 65463970-fad8-42d7-71e7-08ddec91c4e8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 15:34:57.7985 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+h2YeJhA0hoMtLZQrvCjiq3JNMWBt+i9irBrg7TewL1FMuwQBCIowJgztd8IDWCGIaVO4QiH5anHpg9TEic9OKyRZRjTzA6PrWgLyj2Bkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9395
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

On Tue, Sep 02, 2025 at 06:27:00PM +0100, Anatoly Burakov wrote:
> From: Shaiq Wani <shaiq.wani@intel.com>
> 
> Packets dropped in the receive direction are counted as
> "rx_unknown_protocol" (GLSWID_RUPP),these packets need to be added to the
> "ipackets" and the GLV_GORCH/GLV_GORCL counters need to be added to
> rx_bytes.
> 

I assume from the code below that for the latter change, we don't actually
need to add them, but instead can just get them already included by reading
a different stats source?

> Signed-off-by: Jeff Shaw <jeffrey.b.shaw@intel.com>
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/ice/ice_ethdev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
> index 513777e372..0ebe58f858 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -6383,12 +6383,13 @@ ice_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
>  
>  	stats->ipackets = pf->main_vsi->eth_stats.rx_unicast +
>  			  pf->main_vsi->eth_stats.rx_multicast +
> +			  ns->eth.rx_unknown_protocol +
>  			  pf->main_vsi->eth_stats.rx_broadcast -
>  			  pf->main_vsi->eth_stats.rx_discards;
>  	stats->opackets = ns->eth.tx_unicast +
>  			  ns->eth.tx_multicast +
>  			  ns->eth.tx_broadcast;
> -	stats->ibytes   = pf->main_vsi->eth_stats.rx_bytes;
> +	stats->ibytes   = ns->eth.rx_bytes;
>  	stats->obytes   = ns->eth.tx_bytes;
>  	stats->oerrors  = ns->eth.tx_errors +
>  			  pf->main_vsi->eth_stats.tx_errors;
> -- 
> 2.47.3
> 
