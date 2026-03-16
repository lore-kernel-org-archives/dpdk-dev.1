Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82555F506D5
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 14:32:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5B634025E;
	Mon, 16 Mar 2026 15:32:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id E0D4B400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 15:32:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773671553; x=1805207553;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=5zqzmW1oT8yu6fkTUZ/+dy9KQkRhNYp7bRJstxf2gG4=;
 b=BDBJXc95Z1dJuMcD3ZkvqNQOOxvXah7BaxkzxFaA8dPH4f0QR0x1jKBc
 hbt5ln/5vdBrt8vs1i90KfJ2pFazzplbBRKLG5iY3CIXHE5MDWXBrz96P
 uFsuLzXxdZEhFCnYMx2e++83nJH1ayWFIJg8pgBnSBabBD6oRQKaXacPr
 I9XUnKEppbyoNc9kjnOEWpmBmu3cSevl2xbNfik+G38aYRagy2Ki/+VAk
 0uAH0LBpQun3uVc2kj9DqRU81aW99IWyAoEReXk4dfQ92+E8fyUTv5S+1
 roi0oVwFwSN2wAe4+tXjFSWAiSz/UeHB/GSH9P1KJTqto6YYKYOU8k45V g==;
X-CSE-ConnectionGUID: hzI487wcSDGzOMpCom9I1Q==
X-CSE-MsgGUID: EQu6wrMcQm6cPYdkgB2UPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="78538361"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="78538361"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 07:32:32 -0700
X-CSE-ConnectionGUID: 3+RVYJh3ShiBchL6/KHaVw==
X-CSE-MsgGUID: x7+1GVR6T7mxzouaZszYEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="219510469"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 07:32:32 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 07:32:31 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 07:32:31 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.58) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 07:32:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MdRaCL7p3CCTs7FsY7ekgh38hDXMkZ7caE33I6iB+OOnJvvnbnZLeWvdn1z5JndzavYuE64gmVPPOaHmn8/ZvdMfW5yBDMqyTHZz+5ehFQ2v7rMcdclgb8FxUkb+xW3CgODe9DavwCeS0J3hMmPrKoIPkNUOTjTsYiU+knFqjgIGfi3E2UdDnC6fyAEk3nyvWbAC7x4ZK2NOzwvq+4f6iX9opd1Cn64XwdcmaVx2wQyRZ411vrWgcIw/0jvp1AaJHeVx7nw2PKebo2XqjEOBl9N2yxZrU9mTg1raFG9Czuh9lQRo1aavEvTBGbq2Y7btVgF80DR7NO5DhX5B6U5/RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QoUTvPk1d2dKigYktb2sSNfOq3t2Kie3FXEqCaqFyUk=;
 b=TkirtIs5WxBUq/EzfEhpfCJEN7KVSwF5Eqxzi0DDOlS92SZOfvRHqpyau2wm4fNK8PhK0uz7swGcXVUkE0v4rIzmdkDda43vBYFnRN8vxpwiolWBotmHDzdZLcZMa31AqkHoba5qFeTafSdK+d1H5IBlbzo2pJDUMFFzwbc9/cwqrmKEZJziQ+DRQon9qwToK6uo1NrDuxcO7hugaG7svTw4hIk+J1XtRHjtuJtBz9TR05nAP+4D2HXn46oSsGWbMa4MwSi9WRo2LORFnn7WGaZOcr6D84+zLhalnLOPE4sd1tntFc7pPPDw9T5JWinOe1LZzFmh04R8DQ0Px/89+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by IA0PR11MB7696.namprd11.prod.outlook.com (2603:10b6:208:403::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 14:32:27 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1%5]) with mapi id 15.20.9723.016; Mon, 16 Mar 2026
 14:32:27 +0000
Date: Mon, 16 Mar 2026 14:32:21 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v20 18/25] net/pcap: clarify maximum received packet
Message-ID: <abgUdd6s9uCI-GSr@bricha3-mobl1.ger.corp.intel.com>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
 <20260310161356.194553-19-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260310161356.194553-19-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0300.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::24) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|IA0PR11MB7696:EE_
X-MS-Office365-Filtering-Correlation-Id: cfb11140-0226-4e42-1d49-08de8368d7d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: vtvhSH9kMMCJcDC1fKuvWdKu9X2IuFQ1peHAyiXY15FX0+xEvDcOspiOowdCOJpX1TDZ1LwVY8j3G9w9bTNN6FztNSPnM0CQV6mTqesfQJiEmaZwRdiHvGwiG5tf6nzDSAmGi4Ec7yzac9dN3TtcGGomLl0ftpitFs6grACCFy+xKhl4ODH+LCyMzf4LXv1ZTIpNZUXZr2rrfGuGBmSoi+4c5TayglGfs3DlhGgdvL9zb1CYsFxiRwRm9DswrdIxjVfkz5w3NeVHVrxSFvHs+rMz+q3ySR5VvZBZFc7TMf9BvzEneOLyTW9RNRND48riRmsQdRRC2fBPiQCDgFV5XkSjQVzn6NI5aoOeJYLaxCRC3HtAOja9KFTv69G2LoAEDNZWA8O94OszN+ZkXiDY0N0ysLU8hkf6jbO1RiWYY3+6/VQoyq1/pz2FVfwqXIXV5NvZhbVZVSJaB+RwvvGQlwovKR6M40GpRuEJCKONcdrW4OZZ7GJ+q6MI2f/xiEXZY00MnyrjEY3ExaZ3WB0Nk4uaTAU3iZFHsLt+u09ehe3CKFEfc/UcfK1RxkwBWeEeROIS8yyI01iTuHEppT42EO2EtAOkBKqECjdtz34+jARmw/fqDTUk839V5oFrD+mk4VIPclBk/T2SO5vFV3FXFqfXNGkAWdPiILoBGxrUtkxWExd//DjJiJ0WTdSJQFy/nFjtPI8uv96u4bHjby07B25AllCa+7ZQhKr14GU4szQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XJx4HH2JTZaYMo9YfLdAjgaj+M7Nyy2LIP7rZyHjnCZEcsTsIsErh0SksotW?=
 =?us-ascii?Q?4Jn23gwS3tjAwAEiHnYdIGfdOgKhYQN9AQdAWa2Q6mdMZW3W7cfYkBoyGIlM?=
 =?us-ascii?Q?m9j2GGa+9a2gC0VEmFUASoia3PJFt6BK9ixlZO4bb+PbjEcjcXZ4/NecTtMU?=
 =?us-ascii?Q?DYNstfxLbbuFsIyVbHVxT4k7IXe0hIj0X5iDONZWDD3MbZESmDgPxiybTAMS?=
 =?us-ascii?Q?vFSkNpW37XtraB20WPfZJ/k0rZOywUb3KTZa/74PY5CDnBnU0LcBXIAFEyVo?=
 =?us-ascii?Q?If8kw/6rIpfj8YYGE+eYswn6P5rWrSeBy7f2YISrwSHbynidr9C3FJKHm9uo?=
 =?us-ascii?Q?2ZUCTTM18tMrbrMOyGsjssotfGo9ea82IoonjGZRmqVAOhiscYp5Tob6GEqV?=
 =?us-ascii?Q?X1Jkjp1SapQJxDsW0OaJdkmHidDb2hadZtaqS8VP881WX70FPk10rgRNJ3Iy?=
 =?us-ascii?Q?Vn2EP5yaEWDQ6kgN81/JfEHvEfuPSYJXJgwjDw3sy44BK8QU7dS/I0xjh2oH?=
 =?us-ascii?Q?cnjdLziTA4sW/MCIgK3F34vs3ynLBJ2QABXCPchxmbqZFyjf/ikhh8cX04qq?=
 =?us-ascii?Q?k7hkDGcNJQDw+xMN6AX+UAIcjR9tE1l899N10saKzeztVeg93yS9MdPk0VAO?=
 =?us-ascii?Q?cs5Iy9QnTkX7fytM8yKUtiXbn5cGdjx80quW8me1bes1ZzFuYh/mBMLeU4Rv?=
 =?us-ascii?Q?6dmf6Ir9WNfLuxLYoijw5l3Rl7KuHIGyBZ6U0lWOKHkghG2VIZJ3XU4h/yrN?=
 =?us-ascii?Q?EUpknD+CUB0EH0G0jroRdzeNLsub3kkbRqy+MoaSHrlnOkC2PYdnUFmHSy+Z?=
 =?us-ascii?Q?0kEA2rX+fNnJYuD0hP8qWBVcy/EcG91eAy8YZprj5qMK2/cfDluZC++AGat1?=
 =?us-ascii?Q?RiCtnpP4qQxw6SKM1bzdwCkzIFEzEjv7v8YW3QTTEFg5jZ6j8zXgc88JbXIL?=
 =?us-ascii?Q?77P2k5avJEjtJrpHu/AQtkFBOUk5RQrtXO37FNRPADfdsaNpHt9pyuVg/hbM?=
 =?us-ascii?Q?LOvO0O+6j9hAHXERU7ASQDUVaaH5t3uWBNwBu5AfxGtGn/vmot+lm/Ky71D8?=
 =?us-ascii?Q?7gH3WnBwJwGilYaxWIKowkCG/In9t4JTE4RRnLAS7Drt/talKeppbaUbOKQ2?=
 =?us-ascii?Q?j5xCGohM3IHRzWY/wpvXvI39uTwoaEGCjBWtU5ulTbURZCrINkLwblgAIaYX?=
 =?us-ascii?Q?h7bJI9fLiU4sbRFVW8RDB/rFb5RPfq5qO7uzW/iKUCUdRkLRLtJnQARPi/Us?=
 =?us-ascii?Q?np/dMJVyg9SBJ1wS02oUbOKWnc2q7s8PNj/YUUQaWaBG0VtmtIyTLFuqJ1qj?=
 =?us-ascii?Q?4rPFY++/uAhn1v5c2IYtql9dRFxDRg+fm9cZo3vlDOqXOS+ZSgvcD2ygd5T4?=
 =?us-ascii?Q?FvfYVosHA78lvr7ftvlrvNCnWvyICBFHecNsbkOIcxq9mlMXfuP8PKZD6gEM?=
 =?us-ascii?Q?+37xYiBDjcAHsW9FpECPK6ZZnX+UhM5OR7agr8hqOWSTn1/BsIHHKypIDVbx?=
 =?us-ascii?Q?i58MuQwCm/tzukrCsXMIFPriBPxdCaJda1XPpHOLBwtssDV58JCa1kFIxoCO?=
 =?us-ascii?Q?AeAqcqNobeWfVVAfQtGYYmLr32ztBhQTdPIQPRCayChumv8JV4JRxXls0s3j?=
 =?us-ascii?Q?PtwP3OgRQQCYokeWHcpiwJkMCjI5sjFzpIYC70HzKROdEjjnQM3Hg9loWOpf?=
 =?us-ascii?Q?DijEdYFu1bQH5fYYXfAbHlOtISHjsP8qAJCm8LuQjCqwSIfbbfvIvn1VGYII?=
 =?us-ascii?Q?7IyUSrehNZS3HySvMj1I2hSr98h5cO0=3D?=
X-Exchange-RoutingPolicyChecked: Y3P5fJ9lnQuecjSBxvRLWVK1uppTZheN0q2dA+/q/i/mx1P8yYTZ8f7PKmQKir3s5Zipc84C4UCxyw9ZowSiuAG4qDH39qE4/C4nGgM/W4YJqMNtMGRLfwvYesxPQaery0PnFilxtIVR3qu4PWdnPOt73k+VwYPGA/bABEkaXC9z+GlFoAM/NnOuk6Ph0r9l07GGwEtQhtrkqsxn+KmlQd9LR6ONXLBaxh+tiBvPXiLga5wuSJALrVRAZwdCdamY3vOFF1jQU/WRg5wWZAQ+eeXGsYwaYBntxxykEBeYOewfA2mm0HKll8VPi8iik9TO93ql5+pGzFgefQW4D2P0Cw==
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb11140-0226-4e42-1d49-08de8368d7d0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 14:32:26.9983 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lc0D8xsPQsQENXW95Jmxc8Wfm/7ssfkUESY6ghwWJV575HirU90Ow+rnNZq8F7l2WPX5CJrgnOlme0na4qHnBqPOlTno/mwgBzyP3o80vrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7696
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

On Tue, Mar 10, 2026 at 09:09:56AM -0700, Stephen Hemminger wrote:
> The driver has constant RTE_ETH_PCAP_SNAPSHOT_LEN with is set
> to the largest value the pcap library will return, so that should
> also be the largest receive buffer.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

>  drivers/net/pcap/pcap_ethdev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
> index 20e4b8e6aa..2ffbce2448 100644
> --- a/drivers/net/pcap/pcap_ethdev.c
> +++ b/drivers/net/pcap/pcap_ethdev.c
> @@ -884,10 +884,11 @@ eth_dev_info(struct rte_eth_dev *dev,
>  
>  	dev_info->if_index = internals->if_index;
>  	dev_info->max_mac_addrs = 1;
> -	dev_info->max_rx_pktlen = (uint32_t) -1;
> +	dev_info->max_rx_pktlen = RTE_ETH_PCAP_SNAPSHOT_LEN;
>  	dev_info->max_rx_queues = dev->data->nb_rx_queues;
>  	dev_info->max_tx_queues = dev->data->nb_tx_queues;
>  	dev_info->min_rx_bufsize = 0;
> +	dev_info->max_mtu = RTE_ETH_PCAP_SNAPSHOT_LEN - RTE_ETHER_HDR_LEN;
>  	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
>  		RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
>  	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP |
> -- 
> 2.51.0
> 
