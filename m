Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21386CD5BB3
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 14:49:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BC744029F;
	Fri, 22 May 2026 16:49:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 09CB04003C
 for <dev@dpdk.org>; Fri, 22 May 2026 16:49:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779461361; x=1810997361;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=xxYF1oxrQ+KQ6cQFgFo1+Rt6SAij+yTb9MUFwGrmJGA=;
 b=dQQ8OU/lAMRvgYPTwve60AZurPVVGmLAEG8wED8ndv6i6sA5guW+KbSn
 PynWYgfmKUwx4C9aCBoE7OX7fml1bitIzdCN5QmEwy08dI65aR7Ts2y1M
 HTFZzFAjmw4PZKSWBEZaeJ3f6aMgo9Xq+xEXE+eBXtYgXJpCgnW8gwSn+
 loXx6vKjBTJ31tbCO7SKtxcT+cE9mCz7yX2a78r1YIgriOmNDW002wyRh
 KQ/PlpIwTC52SeWq7FCosL8GaXXyWerUIW9osV+IOr63F7xGSeVaUTvdT
 Fffw2KB7AuvAGbgDEuPQRVAhCLIF6dkspqH65IMClMd1kpP5CqP/JbN/a g==;
X-CSE-ConnectionGUID: nopbbGL9TeGQRF9C40wHWA==
X-CSE-MsgGUID: WWMc0LQbQ1yXQqt+zcfmGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="80511956"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="80511956"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 07:49:20 -0700
X-CSE-ConnectionGUID: 1BgjSOkFQvOaVkOLlKW6/g==
X-CSE-MsgGUID: I1mhirUFRkSd9g6EP08Xag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="245913998"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 07:49:20 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 07:49:19 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 22 May 2026 07:49:19 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.26) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 07:49:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmhIE201AGjs50eqf9WW5t5lgprdRQk/hrslQ5opHbf+x+sP5Z6M2vQcpQ1pUKl0MMEvQ4mWgC37EwCfkCA2e0uWCq7B8ZLnjCKp4etnARtzLGa54gvVKkr75B+zhhRiRwIafras9xnHtm8Ru+sXSOPDAY/DtE4xqYOFa3J4kuUzcEWhmdyUAIOe4cfGZkD6vA0molA3UOHl7QRy83uj0p2oZ/tj7nM+2wIi7L53jzBZDtxT3yfQT80QnF3F59LdUZ+nRpIC7b3Lelhmzl9gpVYvteOe2pjVSvjVhPMZz9KVNuR+cUjyISsbAo0RcwoXI5YAyswLSgGq0SSH6FOInQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGYWPxI0wCqp2YGc0DG/5TOdYdNhZh2gS38PnpH5DP4=;
 b=gLW8DjKWsOooOgIYpqCDVkjt5wvvPcmMihzvmiUEA/9X9qMHRFuC+5hf3BqaLoi4VuLRajWCiIegsThiRWgb8EOuT+JSsS2XCX7vS2Qj6f6AZINRA6VMz7RkxrD0zEY9zYMHL/QrjmkrkN/mf+RzSXBRkdQDLFa9kB1GAsxGYx1MbBqSXh1+fY93wXkAYGBvsZFGzLDKvgF5azHS39usF8Yp1UmSYQTCTR8ZvTiK03sw4BqP+8z0C7CXfu2Qv9Ptcer0EyRCWLdyaN9AbucsKT7u11SnVQvGptjW1PHvn+sHFp2lfisjdNM/ZQ5I1ClCmYzNQfvhIonB1d5JmuI/Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW6PR11MB8437.namprd11.prod.outlook.com (2603:10b6:303:249::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Fri, 22 May
 2026 14:49:15 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 14:49:15 +0000
Date: Fri, 22 May 2026 15:49:10 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Arin Kharkar <arinkharkar@gmail.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] FIX: excessive logging in I40E driver
Message-ID: <ahBs5sVdRubjqpO5@bricha3-mobl1.ger.corp.intel.com>
References: <20260512234227.218761-1-arinkharkar@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260512234227.218761-1-arinkharkar@gmail.com>
X-ClientProxiedBy: DB3PR08CA0016.eurprd08.prod.outlook.com (2603:10a6:8::29)
 To DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW6PR11MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: c30afe7a-fc22-4e16-9e1f-08deb8114b44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|11063799006|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Ocsuwzgq4sYAtKYviwvAv5jZo4CK2+rJPDjNbHSSvdPX8rciQwAEI3M1We0C1m5gwDLr1Y686+zqz3vqcndj2RGEDvueKUHY2qIYNUxyAhJJBIuuEbCJIW98TfxXFlFCQMYQGgmppEoO8VAzLc7nR89HyJYyzhA2PeGkjpaxEJaGvm2jpcqm6ZXem0ifFBq459vQxee9tTATKcA4W1dBprq7tZHmwWG4H2BqXRonMKhDjrjRY93lxrRMiV+L96vsWLk8VRJ/i1+olwUbnd1dReoK02nEDaVCGF4SpYzaR+bXy4vSFNXZM0I/ANaykj4G46X/CGqKBLwXnuPinRF7jhfre/grqWKwDr35KP9xnqFumPNeKpTV2oA8DvxpOHtYl2uaw8k4zC01HNas8vdowvNUfNb2YeqYkckovOdTeD2k3Bzf8it4plxoxjf2wsOOWHGwyTMgn9Cya7muHN7vT2ehmORLYRLDkRu7iRs9UxZ/U1f07Am9OgWWHJmdZHdR6VkqV8CM4vbfDpKFPE01y0+4K/hUoxadxgXqLTFt4kePwyCCzM2X1a7RBqfK6qozyRNdsSNmUCq5kg7ECWGJsva7UUzR/WUptNtle0y9LX1p8dz2omYgCdprI4v3R1TiXH68hGiZxemP6jrznV65Ix6JKeCBXmBkX2hrN/pETW+rXsMkOZThlp7cm6mZg7er
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(11063799006)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RhfjGA5BGXjo3dcN6q/eylK3ogCSRz2AIROYqzAU4Y/xeas6aZxOHcymeGPE?=
 =?us-ascii?Q?/6+cCWEqItCW5CUDGCOUWm4T+g8irN7jxA04VHRIBE8soQxmH1y5n9QKj35P?=
 =?us-ascii?Q?m3HuJj3Jc/XLGBfeuQouvLJR7AgjSvRLGdBfqiFmNRyMs0yBpbnX31lN4oNU?=
 =?us-ascii?Q?l2xlz0E4uht3sgoVYMxs4wqlJcuqMrGyXNFrclrlaQLm/GyTuT5VPSU+vcNJ?=
 =?us-ascii?Q?0zLu94sTmpn9b/342x/QOcdAxpTx84l3m/jrwWQ34ZRaNh8+OhPij1bjsM6v?=
 =?us-ascii?Q?LqJ6TRe7N0LIK3jL1zA9iVCKTUrAtgT/F9+lTkLpEG8kYSUaSgewXf4nSASr?=
 =?us-ascii?Q?/ZSatdwIgn+Tf13C2Hhyy2bSoayHqAZ8zkvJnfwYoNjR/AJyfcDULceZmsl6?=
 =?us-ascii?Q?zEOadW3qTDDjopDz0+HQbCcNfU2Mq33NJkFXpJ8HKe9j5Lj5PAYap1lhBhAw?=
 =?us-ascii?Q?A2HUonoKZOxfSzOwfzYwOgtCBJDEdvIzpZlp91SULbSyRv4Q3CWUnufS8i+H?=
 =?us-ascii?Q?HuWz58MCbj+LWslW7ObtSoybo+ZcK9s1+WiQvG9aUVQAK9tK07QASNqBwv/c?=
 =?us-ascii?Q?4oH5ovWbOw5JJ1rNGb3cLRj+ohTwLtperpKFye5dMFOdlfOYPk0svG1uxuVZ?=
 =?us-ascii?Q?1Wr6RWD/0C48lkBDMxKwqei7sFPOZlWgvBEtZFYTm+t0z5MIYr8KEnae2aN2?=
 =?us-ascii?Q?CcNpQa2IAaZfbE2CEkBD2Tr/et03lGmWZTkdZL5PnjaDEOSEmJ/QjU87bPBu?=
 =?us-ascii?Q?8+6R+kXUQPlCtRp3s81s3QO5VMY+YBtcAigbLNHwPCDLvYDUfbj/Ga6FDZCv?=
 =?us-ascii?Q?9GgUMZ3XSCROIgGlD51hXIR4Zq5o1yCijaqXUuoUAhZUZegw3LKfQBSz9vlX?=
 =?us-ascii?Q?ahfCXkHFJvp82IVwJgTFtl9emNxsL35ClYho7OXhjn25DlzCJhrN8azujmR5?=
 =?us-ascii?Q?i0RNhG4MKyCrzG7Doj1pZL20wSrtvFMzW5mJaNCR3dBRtPKi1aOQ5jm/Pw2j?=
 =?us-ascii?Q?5vkPg+Hdba3YOX2S6MhKJsxtbj+rBITub9DHJXehnGSii/H3oCjuRu+DjHFO?=
 =?us-ascii?Q?S18iUduqfKUdA32E4ipRcG/LkCNXi0IsoF0NERY/SCGJs0oek4z4940WbWsA?=
 =?us-ascii?Q?7qHWD6vaGZoHQblYalB7z4oBywnM+HCq9ENPEv4P3u1FafD/u747Dw8zrVCs?=
 =?us-ascii?Q?vk4sfrRtH9+wtbq0M0EUNWNsrJHlwq8kwjSmdeduct/zledgmGXSguUxas7P?=
 =?us-ascii?Q?8IofDIKtNl/OkKUxkI1MsAqZFuCnOfaQPwpqnzYyS+Cw9UZzBWNZaXqkS8Al?=
 =?us-ascii?Q?2yXFZmXKICbIyejZBrZqtUAQdC84cAVsxsMq8xuhEbl4gAW+rx6BeaEkF34/?=
 =?us-ascii?Q?PQHo3WPEZywX+UW7fdcdrCkYrVe3AXOYjft6aQDQW9sRjEkc8R4whU9DBUp4?=
 =?us-ascii?Q?oiyS6qqX37uHkO+I+h59bK9nSzyrPcoqs0jH713gT2nEWMCl23wWwupewEP0?=
 =?us-ascii?Q?uCHiB3wjuEC+jf6q0RB+QvZgRip1JiCgYh8MErxzZeaFf5/PD/9JE4Xb3I6b?=
 =?us-ascii?Q?s6sVY5VHoGK7zUQkSr4PkNy2TB6QQ2VFPwivtKVWt65igot8NcQQDMKWdy8i?=
 =?us-ascii?Q?rew+Pxcrl7TfXFgkDMuvlGuf7IkfQKt+bLPzuLTHASWjSWawtXxs0yHL2FkE?=
 =?us-ascii?Q?IzHdWY2d/CJ6zXx7CoQmlySpK2ANXoFaxzIGAJy2JWIjfCIPzoFSOmkBeKPF?=
 =?us-ascii?Q?j5cewTMH05wXKp6iXd6BnMRrFQwT/Ws=3D?=
X-Exchange-RoutingPolicyChecked: atOS/J7raJR6JevAuAIGoekIsLFailS/XYHwlwfkLsLEJTxOJUy5K8tBefKJkPW38vo9siYxo5/ZpFJqXKoJx9lY2njL9eQuTtgfl6hKXUukVU4Gpp/D+EM0UpNq6slS4PcD8bQN/keCWGDuL50/TdwJCUfr/LtrueIOFSVtRQYu0KTSqpBchU7Q+14ketCrxR0EjIdOsVoaONAjVBmnnmxrepUfX2lzLXZk5FLxzIeJC498zSnhzRY3BBsZ3B4FOPFGRyIUxwdPpkF3AmeRsLNbzmwCVIH+YVwERmN6sNKOiBPDZv0orV2kTbcgLg0MEZ6XzogTyB16h79kPnGo7w==
X-MS-Exchange-CrossTenant-Network-Message-Id: c30afe7a-fc22-4e16-9e1f-08deb8114b44
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 14:49:15.3296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H6wlsyl0IIiFSsZw8hRMBkwmA5G1eAeI/Lof4rn5hXYWxmQ30zoMOvVO3BtqjXvcVqCRuzJkXAKKubwRxCtm5uiYvYioGc+OVUneAJ46sDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8437
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

On Tue, May 12, 2026 at 04:42:27PM -0700, Arin Kharkar wrote:
> Resolved bug #1936 by changing the log level in i40e_set_tx_function from NOTICE to DEBUG
> ---
>  drivers/net/intel/i40e/i40e_rxtx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
> index c5ac75e0f0..bc48303a25 100644
> --- a/drivers/net/intel/i40e/i40e_rxtx.c
> +++ b/drivers/net/intel/i40e/i40e_rxtx.c
> @@ -3124,7 +3124,7 @@ i40e_set_tx_function(struct rte_eth_dev *dev)
>  					 i40e_tx_path_infos[ad->tx_func_type].pkt_burst;
>  	dev->tx_pkt_prepare = i40e_tx_path_infos[ad->tx_func_type].pkt_prep;
>  
> -	PMD_DRV_LOG(NOTICE, "Using %s (port %d).",
> +	PMD_DRV_LOG(DEBUG, "Using %s (port %d).",
>  		i40e_tx_path_infos[ad->tx_func_type].info, dev->data->port_id);
>  
>  	if (ad->tx_func_type == I40E_TX_SCALAR_SIMPLE ||

Hi, thanks for the fix. 

Unfortunately, with the recent changes in the drivers to use a different
path selection mechanism, this patch is no longer relevant, I believe. The
log messages for path selection in the driver on "next-net-intel" tree are
now all at DEBUG level.

Marking as not-applicable in patchwork.

Thanks,
/Bruce
