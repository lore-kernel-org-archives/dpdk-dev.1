Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7B9C624D3
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 13:34:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 070EC40A77;
	Fri,  4 Sep 2026 15:34:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id BE32A4021F;
 Fri,  4 Sep 2026 15:34:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788528891; x=1820064891;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=IWbwAvN7gE0Go+5WwG3Qm141QIhqRzHp6pTjYANUbhk=;
 b=D5vISlBxMO3S0MutJq7Tipb0K9Yl/5YD1YkDZ7DSLcbajpyRhCQ3sk4q
 3KO19WQVgPWWdUDFTeQZmAXgo8cqFUyGRglDYb/C8Yxu1NFL/BPd9en8m
 rr7eXgUhqvTvV3cQkXuH8s85md3j06yTnYv4M6frD3ibdqF/Udog8sOnF
 9NUzqH9ELi3HPswcGwlMKzjrBn6j0uNsihzN/0L9bLTkweO9gw9+P/wOg
 1FBSTYffeoed1sE2ErIIHKKhRUeixqhL9/jLHG4jeZt4D+6F5uFQ/9241
 pgg9pTzEGYsDA1x28Hk/9XmiYoJD1b27MsN1N7+5ldXaf5Tsda2PivCXf Q==;
X-CSE-ConnectionGUID: Gwzzu+oVR8WJCsQEr0si0Q==
X-CSE-MsgGUID: IMFn2JaXSqOTYHBzlt8g7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="88172517"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; d="scan'208";a="88172517"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 06:34:11 -0700
X-CSE-ConnectionGUID: pahwBWYlSsmezaunb7oJeg==
X-CSE-MsgGUID: ttYn4f9gS6Gz3eWeLtVsxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; d="scan'208";a="294922286"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 06:34:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 06:34:11 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 4 Sep 2026 06:34:11 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.60)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 06:34:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNh/Bv9YgSZIcdLCc/l9WGAc/twMqEIltFEtouGpuqFL4RgfBWDwsABxEDw0hK8yxU6DXRuVKcN3WWhIeWyra0efne7UUy+WjNiIlMFbe8qlHJ0eZY//X80JVgbxG1JfdIlHv862B1nSn2PNj2zEA64NUW/B1/SpxGmDSx7iKeJQdbaMb1FQPFuZKG81Y4m/smIrF0z2kK6jyxIBegs0fyU4UBTz1OjmT5cAcLpvI18SQJd7kzsH+1mBQ/0P2st/fo1ixHQWVPu8lde/AgDsgVeAiwKWvEK2O34a0EerQ6TMfLBcI6EYm55cPn1iE6fJdvgxdSf8PfoXu1NiWM7Xvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UsexvrFdQ5r1QKfi+Mja9poFdwj/3srjnfdkMEhKNw=;
 b=WCo7I7odObRi0DtN36kORcg4Db4+7L6HVpinNshI7iZaLnthMhQaLuYf/4JZveiLphQo23sAGdL4+oljPJIwGcSfo3wIl511B/SUGiy47JBtidMYkR4dgosgqp9Yfy3BUhIeBMK/15bzIwjewBlQt9f2X14y0o6aJEx83DBRrv4iCxAc4XcH88KkRGvh1mXrkDrhcAthPAOotSt5ED8/4z5TSPqLCzqvoGFgJUPrjQwvXHd30nulsigNGphqanN2OMWudVq76j5bsk7dvEryKKXhvM+f1gUzZPtpDEIA/V9yFIOBojnncRgi47brwzd/31rkr8BxDu0lIIvkbYRwQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by DM4PR11MB5295.namprd11.prod.outlook.com (2603:10b6:5:392::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 13:34:01 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 13:34:01 +0000
Date: Fri, 4 Sep 2026 14:33:57 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH 3/3] net/ice: fix Rx queue count reporting after TM commit
Message-ID: <aprIxQgs8bEhcO7R@bricha3-mobl1.ger.corp.intel.com>
References: <20260904105139.3117640-1-ciara.loftus@intel.com>
 <20260904105139.3117640-4-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260904105139.3117640-4-ciara.loftus@intel.com>
X-ClientProxiedBy: DU2PR04CA0005.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::10) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|DM4PR11MB5295:EE_
X-MS-Office365-Filtering-Correlation-Id: 0318579c-ac08-4b76-4e54-08df0a892e0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: UgDBEunDtVPOyW5iC9pVXy4XIxs1KxLfsFgGIVyn88jJF3DvwymB0k0lc1IZrF3s+OZTkhW9QxXgA1yBy7VapUItb/gebkP56cVXZkz5MUJCIUEoG01+mjbM1MiSzT5bQL71l8uz++1QsejGNYu2lmJtM9m4fSUIaI13nhwL8Q7OZmQCQpG9fzstta3Q0mtH2aeHHGrV7SZHwOJFNQKHrc87t6YHTBk3RD91lzDMr6pXGDIOoATPyKboiS/uvRjajM/zDhCQhCi8sPjvS9BB8hKEH8U+TSMQGdfeWSTq3br/hi6IGC1DcrGSVtQr3FqsffNrToN+V5Sx6BQXaJvdS94DnBnuPbakNGxD9E59ykYemZDgDBdV3xW5CCWP6ss9+k4YNs+IWYAhQTAkfxRODmGQRQrTmhaVHdmVEzrFBHP3UZ+0VNZ0W6jdBN1BxrkS0hIidqx0m/4DQQPnuMx4x59ezORIewAQ6AqNNtMu1vHzBlU4KYkKVeDYcMUlcaphotqICOCVseHI4YWHb37UKVKdHZlJE3vIG4hNgrrpCNvUeGPgIrc9XGPS3QjbV4qNtdxHfvN4lQ5AlZxMRE1cm7Q99ZyQljt4gNVeVXMyuwECBLTorBIpcCZwvGinxL6ywkIlP5tON1d45fXVXoet4X+enbgTrQ4IY5qjNJmTdQM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DUi7DGuHIMLSM/mo8LywZNn06EPiqg61Wd7CdGKZ8cZnJJWSba8zApFUm2/G?=
 =?us-ascii?Q?SxLj8kuHollA0gG6b+jERc0f6mWatzq7AhXUyk4rUGl7UeHP4IA+9+brXJtc?=
 =?us-ascii?Q?vgsmbrJe9Tf1MyPIfvrMGD5v5eqf5FMjQ94KhA4dqRtb9qvG4gNBi5lSzMUl?=
 =?us-ascii?Q?iZCN5aVbPuZhznA1gtJ1O7M3gqMLtDUbmFFq4hYsJTh0+4q1H2Z08WSbXgGi?=
 =?us-ascii?Q?tbp2mlwnd4WbfFRCOKpZ6JD86FUF0WB4gZ1C7QT/e9AR+g1yGELEVUUOAZLo?=
 =?us-ascii?Q?xjTPUDvLe+lXwdRu2gTBh7BLzCdQh4MXiHs46K++bRe78vrei1LksdIfrBde?=
 =?us-ascii?Q?hfRh3KZJT7mGqbZVWgOJ3IC/ZkTtU7u3eFfBtlAFlwDNB+OiA+GKZc47GAwy?=
 =?us-ascii?Q?J1E9RM3KhGvJw5V7i3JklrLYfkqJhTYqrZ2mLXtSqaqxQwfLto/3Bxziqej0?=
 =?us-ascii?Q?Ir6LwdXDh668WtCB2FFLtIbAAEpXV2ur1zGF4bX9W6apPbEobuLfvkiJU2y3?=
 =?us-ascii?Q?dPlGt7xzTJpKtF8KK2nemgJF+eWrpUD4w16nolcZSPLjnXvfRgTY5fnBGiVb?=
 =?us-ascii?Q?TZQNKR/qjQlFpR4Hube7xC0qoUzHgVwUcfoapG724oSJhCBySW/7cAO597lm?=
 =?us-ascii?Q?Ga4H4wNKmbVehUbs9a19XWhqhp8a4j4GmQGXe94Kc9ezaSLuImmxK8pn1di2?=
 =?us-ascii?Q?U4q0xOCkZrVCUDtNPFXR3j/fn7O2pfMXPvK5+Sfsz00th8OLL3e/VO9IPQ8z?=
 =?us-ascii?Q?HfpEt+YiRL5llcDH/+AyeD6D69c+7hTMvh/Yamtuz65DpafxcCImIZ98Iwyb?=
 =?us-ascii?Q?fQECMMVELQoJbZgJ26pb1nVfQ+r1syvMOZclnskEYCWoR68nDX2YnKC0rtlc?=
 =?us-ascii?Q?ySJ7nQTZSYEUQ+H5+cYB9MzUumswuEXY0+FQk+WadIXHaQs/VVj+w3lOfFvM?=
 =?us-ascii?Q?cp52Uxcprn43mgcFC1gBQYKpHHjYOgK4LZlfv7TR1mpBW7RCCHBNRsAQ6HFw?=
 =?us-ascii?Q?62vaNPfz1B7c0VrVr3OXX5EzP864BRgxUSi3cNUGUaSx/WbIOPeYKmTY5oZx?=
 =?us-ascii?Q?XfcEcOBS/6qJWBffHCvtaIgFv/fxllWkFogEvwIK9Uj5cwsLeWXUn8HZDcXZ?=
 =?us-ascii?Q?zDY4lEbBtZoB1B8hoyq4bW8gp7c78oPeYPmWiTnSynwb9aNEZzVBZWgX4JNm?=
 =?us-ascii?Q?9v6O+JGAeVFL6yKnyKfSmohyMNgzIkXcEZ0FdZoH64MrzoFF6uB4TeQKgxsY?=
 =?us-ascii?Q?Eq4NxeIu9H7++YsC55HPEu4sztPrCS87K21fJzNeU7ul8dJeh5hpNhCRL+37?=
 =?us-ascii?Q?uj4KLOYuIjxego0bgHYtbCILGWHfQm73j7wBBfZh3rRYyzPSJKVm1wYd8KcU?=
 =?us-ascii?Q?huvsFfV6ks8246GOMaZ9kw2mx85kQ7TSGEy0yP5YUdenEEfWDTxo8XARMZeI?=
 =?us-ascii?Q?4T00p7WnayO4d6rQHkUbhJu2f8gcG35iDwjJwweiYdWtbIE39oPWH+ncPpFI?=
 =?us-ascii?Q?w86hsBggabMviwsCpqBnpbIDNis5ge0CdntvO3s554DC+J8wvtIpOGXR84He?=
 =?us-ascii?Q?O0OjB7Fl+amQPBDyGaEoiWiMn96IZWULEWWxjfmTIFM8UMc+5mcHHMRH+VrN?=
 =?us-ascii?Q?7HnTpDjTqV5Fb7dg+D65POxUkr9YUC+5x20MPSQDi79/wHDw0dNFw2iQYMYM?=
 =?us-ascii?Q?Uc0pxJXIWA7av+mQZV/pCX0mYJd5bGZ2nTFKaxQbLSOmkeGnz4eT9ShjeURH?=
 =?us-ascii?Q?oshhmfp7Yxh8pS9N95UUeTaSXYDEdUE=3D?=
X-Exchange-RoutingPolicyChecked: RmRmV3clkT45yO59Qc/boIrbSIDjwwjfdokKIIpyO5zOF+PMD5frOQMtam5XcO56QwDLgBOgO5UCsj45u7a4JHeug7RpbSlYsHmcqgpdb102nubenZyQfVWkx/fqVInMr7M6w1VAW9MlkVlmKIYVhiPhYKTNnjtuyYMTgp2VsJFbKOMe2IxOH/vlZrZIlvSoWH6UbmjVaWBL1OIcbriPTS4ue6A8qlr3kjkmVJ7eJtdVEQNNVW942wAaCwJV0FYZmQ4UqgO6rV9cwSSbezD0ew9z6wupgwdznfuY8gdW4oW1EGiXeYw1g16HFrJbJ6n7hTeVArhLzJxZ39q0mbB0Xg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0318579c-ac08-4b76-4e54-08df0a892e0f
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 13:34:01.1087 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TWtg8JYiq7QjSZa42VECZu6s+C9Xlz8BY2iZLXrT8LasjLZo4gvBE+rfrLWeNp9H42T+qGHV2ioTS/YU94XMIahXnPzO1Qch5DXChnyjrHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5295
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

On Fri, Sep 04, 2026 at 10:51:39AM +0000, Ciara Loftus wrote:
> Currently, ice_dev_info_get() assigns the value of `vsi->nb_qps` to both
> `max_rx_queues` and `max_tx_queues`.
> 
> After a Tx scheduler hierarchy is committed, the value of nb_qps may grow
> to reflect the VSI's larger Tx scheduler capacity. However the Tx scheduler
> hierarchy change has no effect on the VSI's Rx queue allocation,
> which stays fixed at its original size for the life of the port. An
> application can then request more Rx queues than the VSI's actual Rx
> resources support when the inflated nb_qps is assigned to `max_rx_queues`.
> 
> `vsi->nb_qps` also feeds `ice_vsi_disable_queues_intr()`, which clears
> both Rx and Tx queue interrupt registers by absolute queue index on
> every port stop. Once `nb_qps` grows past the VSI's fixed queue window,
> this can clear interrupt registers belonging to a different VSI.
> 
> Fix this by introducing `vsi->nb_tm_qps` to track the Tx scheduler

Just a nit on naming here. For the tm block it doesn't deal with
queue-pairs so much as Tx queues, so the variable should probably be named
nb_tm_txqs instead.

However, that opens a wider renaming question - rather than tracking a
generic nb_qps and nb_tm_qps(nb_tm_txqs), might it be better to have vsi
variables separately called "nb_rxqs" and "nb_txqs" and ignore the whole
"tm" part of it?

> capacity as it grows, leaving `vsi->nb_qps` as the VSI's fixed
> queue allocation for the life of the port. `ice_vsi_disable_queues_intr()`
> is switched to `nb_used_qps`, which already tracks the actually configured
> queue count.
> 
> Fixes: 715d449a965b ("net/ice: enhance Tx scheduler hierarchy support")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/ice/ice_ethdev.c | 5 +++--
>  drivers/net/intel/ice/ice_ethdev.h | 1 +
>  drivers/net/intel/ice/ice_tm.c     | 8 ++++----
>  3 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
> index fd148848d3c..149872816d8 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -1816,6 +1816,7 @@ ice_setup_vsi(struct ice_pf *pf, enum ice_vsi_type type)
>  				     ret);
>  			goto fail_mem;
>  		}
> +		vsi->nb_tm_qps = vsi->nb_qps;
>  
>  		break;
>  	case ICE_VSI_CTRL:
> @@ -2924,7 +2925,7 @@ ice_vsi_disable_queues_intr(struct ice_vsi *vsi)
>  	uint16_t msix_intr, i;
>  
>  	/* disable interrupt and also clear all the exist config */
> -	for (i = 0; i < vsi->nb_qps; i++) {
> +	for (i = 0; i < vsi->nb_used_qps; i++) {
>  		ICE_WRITE_REG(hw, QINT_TQCTL(vsi->base_queue + i), 0);
>  		ICE_WRITE_REG(hw, QINT_RQCTL(vsi->base_queue + i), 0);
>  		rte_wmb();
> @@ -4628,7 +4629,7 @@ ice_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
>  	dev_info->min_rx_bufsize = ICE_BUF_SIZE_MIN;
>  	dev_info->max_rx_pktlen = ICE_FRAME_SIZE_MAX;
>  	dev_info->max_rx_queues = vsi->nb_qps;
> -	dev_info->max_tx_queues = vsi->nb_qps;
> +	dev_info->max_tx_queues = vsi->nb_tm_qps;
>  	dev_info->max_mac_addrs = vsi->max_macaddrs;
>  	dev_info->max_vfs = pci_dev->max_vfs;
>  	dev_info->max_mtu = dev_info->max_rx_pktlen - ICE_ETH_OVERHEAD;
> diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
> index 5914454c7c2..3160c82c5e3 100644
> --- a/drivers/net/intel/ice/ice_ethdev.h
> +++ b/drivers/net/intel/ice/ice_ethdev.h
> @@ -330,6 +330,7 @@ struct ice_vsi {
>  	struct ice_mac_filter_list mac_list; /* macvlan filter list */
>  	struct ice_vlan_filter_list vlan_list; /* vlan filter list */
>  	uint16_t nb_qps;         /* Number of queue pairs VSI can occupy */
> +	uint16_t nb_tm_qps;      /* Number of Tx queues usable by the committed TM hierarchy */
>  	uint16_t nb_used_qps;    /* Number of queue pairs VSI uses */
>  	uint16_t max_macaddrs;   /* Maximum number of MAC addresses */
>  	uint16_t base_queue;     /* The first queue index of this VSI */
> diff --git a/drivers/net/intel/ice/ice_tm.c b/drivers/net/intel/ice/ice_tm.c
> index 651d6aa932d..7afe31738ba 100644
> --- a/drivers/net/intel/ice/ice_tm.c
> +++ b/drivers/net/intel/ice/ice_tm.c
> @@ -859,9 +859,9 @@ commit_new_hierarchy(struct rte_eth_dev *dev)
>  		}
>  		/* TM hierarchy deleted. Restore default scheduler state. */
>  		reset_hw_node_recursive(hw, hw->vsi_ctx[pf->main_vsi->idx]->sched.vsi_node[0]);
> -		pf->main_vsi->nb_qps = pf->lan_nb_qps;
> +		pf->main_vsi->nb_tm_qps = pf->lan_nb_qps;
>  		pf->tm_conf.committed = false;
> -		return ice_alloc_lan_q_ctx(hw, 0, 0, pf->main_vsi->nb_qps);
> +		return ice_alloc_lan_q_ctx(hw, 0, 0, pf->main_vsi->nb_tm_qps);
>  	}
>  
>  	/* handle case where VSI node needs to move DOWN the hierarchy */
> @@ -889,13 +889,13 @@ commit_new_hierarchy(struct rte_eth_dev *dev)
>  				nodes_created_per_level[i], i);
>  	hw->vsi_ctx[pf->main_vsi->idx]->sched.vsi_node[0] = new_vsi_root;
>  
> -	pf->main_vsi->nb_qps =
> +	pf->main_vsi->nb_tm_qps =
>  			RTE_MIN(nodes_created_per_level[qg_lvl] * hw->max_children[qg_lvl],
>  				hw->layer_info[q_lvl].max_device_nodes);
>  
>  	pf->tm_conf.committed = true; /* set flag to be checks on queue start */
>  
> -	return ice_alloc_lan_q_ctx(hw, 0, 0, pf->main_vsi->nb_qps);
> +	return ice_alloc_lan_q_ctx(hw, 0, 0, pf->main_vsi->nb_tm_qps);
>  }
>  
>  static int
