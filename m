Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4C0CA0EC4
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 17:04:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9AEC440615;
	Mon, 11 Aug 2025 19:04:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 9D7C6400D7
 for <dev@dpdk.org>; Mon, 11 Aug 2025 19:04:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754931845; x=1786467845;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=wgIx665MDizRSy4Dy0NNWMYd4NZE37/mNrqouc/o+8E=;
 b=ASzCghEi2IX9WU3l+xttETCsIxLNbDtO8VmvjoUrFWyoY58aD4pjDdQD
 yaRxamqtODRby6nG0HNFKxcOeomFtQny/T9TA7+e508ZlB3TXYhkND3aH
 4a+NFbn9ji28RD+W7Z2q3b7SzCyF4OSsU3SA0GKHkRTFdTrA/b7sY73bz
 qYWep/P+ISUD4AyfUBS0ysoD1eVFd4gdQBmsEg/LsXMdkdhqbZbU6E3Ej
 rvX3NyR7QnBr8oblaSlJo6RkBYuloF5+7k7uuPn2bzROoQSb/6zMofJv9
 e1AutWPr0oXl7heSjYt4jg9vfWXKTJY0dz6+FulKkzFLLICZzAONDuiGd Q==;
X-CSE-ConnectionGUID: hETrInB/Q/a06n5okGLs9A==
X-CSE-MsgGUID: SepnFSBaRzWPFyd3gMMDHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="68562432"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; d="scan'208";a="68562432"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2025 10:04:04 -0700
X-CSE-ConnectionGUID: uKCo9FaPS9aX3gW8w3dA2Q==
X-CSE-MsgGUID: FN6MSr/KRpSnaega/s3Rrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; d="scan'208";a="196805641"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2025 10:04:03 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 10:04:02 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 11 Aug 2025 10:04:02 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.48)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 10:04:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MoGKVZJIIE9PDS/LkJdwOiRugfmpR1rBDw9Sj6qkWiaqUFnAMk4xGLgEJMBPSWexHwPgyee2NG8k8JnLgZepUup7LGVyNuQA3dSYbmvnFW3MGZ/6GJtN+Wo0wDqr64wcIXRQ5W/kxejiJcCkPg21M6JaoHf696TT0ExhYoM4dhPvnLTDxiFjRzPM1dZUkDSwAB5plRmm6Zo1MZ5e/UiwC+fZs7KxSz0Y0Df0QnPNNZ9f/mR+Utx/Sij2NW3k8bxKqliE5dyWNhqGqPJPqoQBMUFc4KH1NHV6W7G2smWS4Onlilru6QVZ5BUys5z+fhBB92F1xvcLumYJC87M5VEQoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYkbUvY0BBK3D7jcI5z3VfEoAMa0SyrNoJnTPABc/6U=;
 b=WM1/6TiRhhk+xMkA3l7NOj8mz6ABwuiSMz9o/HhoEgF3DgAjuaM3MDSdmyFFbip2lzxBgq+4mYAx9kQrQzhg0/y54JaI9O9rlChHIMNDKJMrKdagPXQopBkIA7yr+BIneb66mWTuFfpUOTRXyvSil0vzvS1pGqa+pnUDBAt2YLBia5+BZMk7nrWd3DuzrCLnbzqjnb8OZXB3OSCyAqpgqsb0j41vrRyQs3x2thkaq9vhlSOE21dInuDqplL+ti7+w5IvXXilO5+04Omew+nu8OCR2l29TdgVdDDZGkr30cM6NEUOf3cW+lK+S6Gb9bNkEmwt2gFig8iYqMYwkvJ7vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB7849.namprd11.prod.outlook.com (2603:10b6:8:fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 17:04:00 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 17:03:59 +0000
Date: Mon, 11 Aug 2025 18:03:54 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 13/15] net/ice: use the common Rx path selection
 infrastructure
Message-ID: <aJoies3-W51XiRx6@bricha3-mobl1.ger.corp.intel.com>
References: <20250725124919.3564890-1-ciara.loftus@intel.com>
 <20250807123949.4063416-1-ciara.loftus@intel.com>
 <20250807123949.4063416-14-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250807123949.4063416-14-ciara.loftus@intel.com>
X-ClientProxiedBy: DU6P191CA0066.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::6) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: ae444fbd-ef97-4808-310d-08ddd8f910b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1hfgwRbZQc4C18hlMn9lzKCNMTQc4xstCwXQMYn1kVT5A99Zx/k3REL8w6Qe?=
 =?us-ascii?Q?YT1nGeWxC0bdGhuomnuMbY7Hdy5NueRvLRecEZaeh6clSGtpAZ8TMT4Ulszq?=
 =?us-ascii?Q?WAR2KCHa0SQ4A/gtCt473spNdHtRZCIdZXXgJCEBDgR4+lvGm5KSXuqnWsnu?=
 =?us-ascii?Q?KC+ZT8b7d3Ke5jK8MdSKwxTZqbRsipbYkigJl6RHmC9UBFzdQyHm7pTFUuo8?=
 =?us-ascii?Q?rlaJnzUImQSxqA0T6FwP5i4miaxusRcasx8B6LKjnHyo6WxJ6XE92/bm1SQH?=
 =?us-ascii?Q?NVJnJcKrJAEsMwQtvfHwk7HxeRwxNXHxoVivnIqOa7fQ0quoT88hXBFks2+L?=
 =?us-ascii?Q?D3y0PimNcryZpTrrx60Tp8syIjMoZaufEtfM6FYHE+yYW0CGefIwan3HxWAY?=
 =?us-ascii?Q?jusFHYJZq2eE1tCRyUCgFyWD3sX4XgocDfo7MoegoEjT/+INRhbD1BwiqpXc?=
 =?us-ascii?Q?vChYjx3E4SASBb28OykPfEDlDYUwEymw9K+sg4c5qG2Td1KSdJ8pvmRe+C8Q?=
 =?us-ascii?Q?j9qRfQY6qXgIMmcp7uQKRAbq85ZCuJbjKCQSRbOX3bXKWMzFTYD8uP1Z59ge?=
 =?us-ascii?Q?mNpWzz2VJIv8ugR/hHI/ma3xIdkBVgD/N5cVfIGNaekhbeNJjpSkGAH1+opT?=
 =?us-ascii?Q?npXzNOes4qJt44gh2aP1SVAVXTfmxdgRSnOeSYN5rVRuyWekq6y3euvGa84/?=
 =?us-ascii?Q?8+r4u1QqV+C8Yn9jboWoRFlvV7i4nPncUS1V3GhOeMxEDAbdVyqajMpn39v/?=
 =?us-ascii?Q?Yjbgs94lYqQbT20qJESCnK2XqIadhjbf2eVxfSyDlcIitD7ae2QKUgmfNRs9?=
 =?us-ascii?Q?h+qXZqWpZdwPxy41hG+zhaVmqXchML8UYY0loUDA3B4hRxy7thlqJnV/5bDE?=
 =?us-ascii?Q?8rar+ov0PGIlS0hyKEcu3FlMfDHkxfjbUb8NsEcFXc0cGF4R7BiUyds5W6t8?=
 =?us-ascii?Q?6TrzcrNRf3xEqoYWxxc1PlcA13/z2KEk/enwnfPVrSQoh71HODRDaUxZV5Xg?=
 =?us-ascii?Q?yMustAyHdRTvVWQ9pOnYFouhc8FhWfjwJRFHA9p98g2P/eWUMPUnvbHBLdFV?=
 =?us-ascii?Q?hHJrU5JBaeay4PfsSs8KAa6u2exeWu7LjtoHBB9JHkmmBUwcX0bNkUANf8Ae?=
 =?us-ascii?Q?1jLWZ41tDyHo+kVTZnRfXpSNeEXn5ZHyrgCJNCdCIEP3lwV3tKh5FfT3GSu2?=
 =?us-ascii?Q?7ggOvFok6X83Chrle/sIv2QewgHMZTcc8xFCghJ323yW+MjPeEjnh/+gp3H/?=
 =?us-ascii?Q?Gk9liNfrqybSH/sMWI0dY/QZh/XL5lQ8zZoa95e9mTUxvZ/NeKu3XqWGVfkU?=
 =?us-ascii?Q?5fHWaUeMgY0ws7KDnQU59jHTSc+K8UcgFm7vM3rTB7nLHIEgzlo1IHE52V3E?=
 =?us-ascii?Q?lYyoYxbHUVG+1IT7au9hGA5YZ514jgNSHAJkenItBrPaWE0/yOwEq7KK//UB?=
 =?us-ascii?Q?6lDEQJCKFsQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G0YRP1Dgg4JjHywUObnI2i+jW7EpI5PRgxlT4MGpD77QrKvFHUh9i1cJt6YR?=
 =?us-ascii?Q?eoiubmLKDVEQdTtlO+lPNGGLOhk7wTAE+HWcX5bwYUoj4qNVbWtfr/nq9pvl?=
 =?us-ascii?Q?BecUSu9UcWyPj/Mgda6HstEpbK8v4iSR5zvrIUQcKlX0XmjbxJHSWe8erZso?=
 =?us-ascii?Q?qoywSzPV1BXnOmBXPYo7/XIyjUtTD26MzXMHfcRuRIDOaw9sEpUGujyWdXdm?=
 =?us-ascii?Q?Hz4OaovwKAyQvIqEwkxkZDiIOFiGqRm/mjWAfRs9f5DV3H/KSC22vY2hMlxS?=
 =?us-ascii?Q?Rh0otnPSDDZ56p2RrICeleyUAVUcGXA9hxel4ZIIRCHIcbZIUa0pmqlr9rDu?=
 =?us-ascii?Q?pFSVHmQcCCliGIw6OaFZChyOJJAdgWCDOwJwV+s76OoZ4RyiXmeKyrhSlQ3t?=
 =?us-ascii?Q?aXlMBOPq48ahwK+5Z0GBjxbz56tTXE/mMtGRqEwXmnCMBGqyPkr24c29M1Ml?=
 =?us-ascii?Q?aCIf/bO6UQnfTu8QFmWQ+ARL035jRYS8PePXq+HZH2mndYoBIech85Edvuyb?=
 =?us-ascii?Q?Ci+Z8LGc3D+045/pWtR6XJF6pyWqnJEWhLLKkvM2xd0PIE7DUvZEBaQgzf5F?=
 =?us-ascii?Q?PjP64sQwWWtU9RuZGn/2Uv11bjXCqtBMy05bs8KWWx8rdllYAG2h6HmWkq8l?=
 =?us-ascii?Q?q0ZgPmqMuNqZZBO+jnJS53fK7M/bJss8MGg1iRFNs3QzlOdZpD5/66uO00pa?=
 =?us-ascii?Q?WJHRsAApNEOrEuzbsd5qzj9meVOgXeau6ExCQvEKlvIhKcYvN+tGYMsSsIq3?=
 =?us-ascii?Q?+19aaVXl+DDCw4gkKUWW29cFDY6qw+HW0Qjq4dNSIiOWtaN7HWO9kB12lUe/?=
 =?us-ascii?Q?kCZrSFfzZCggzEISGQp3V1dF2VPQEAcT33GCoIjpqtouNodLE0Idf2Jf/zOY?=
 =?us-ascii?Q?sQMT/Hpnb85PAlEy1OBmIN20v16n3wJ7hDmVZtq5/PuE4LziOPbNB+gyfBPW?=
 =?us-ascii?Q?bItTkuqQZY3FGj/qUggzTlUaaRRhNFTLZHCgSeNNVA5iPeKwnrB9ldvlJ5eZ?=
 =?us-ascii?Q?Er2VWuXHKk51J9TGtgXyLTyClvNlAMJx75USCjSqPJIgLZ9fdWzbrGXXr2vc?=
 =?us-ascii?Q?oXw53sDEXNeyxP/qm5acb+1UgQlQo6pc8hx3Gvd4imRAR7MoFMhXDXIiGJ8z?=
 =?us-ascii?Q?ueySpNIo46AOHR7Sbd8MRBGHpd4qAR4KhkxHFZGxV1s42N4l7iJRDQF/Rv9U?=
 =?us-ascii?Q?bFMZSI9StLBPBbSgk/0LDWTskvrfL781rRu1toVg3WXj11K7ABi2WWSyugAH?=
 =?us-ascii?Q?CzCKUnQuEgTVvtNVhcVicUpdjtfDNUBGzChal1MWtZ+9SOvpjpZtg9qrO8XW?=
 =?us-ascii?Q?3KVvFIDHPiZYpwpY3Sdx7an015mh6f/fcP60xsgc8i2L/PWB4bURRQUsm5qk?=
 =?us-ascii?Q?oYzsebnGMMBOGvN9fw7R85gyxHBhtKbiRi4zaEUPlYtD7D6wGPxziivYE0xW?=
 =?us-ascii?Q?HSD0Ftar00XLAnOIwRxERBNVWuFCZkghWiLiYTU/FuzvXeykac98jP7NVa6q?=
 =?us-ascii?Q?oWq0tDqCypT4OwLz0Gepmq3a9B0KJhwgMWImkIzGH4FhWTujK0eHZoMVw14p?=
 =?us-ascii?Q?wOg9rILOu9dpnLpBOf2KTiUTbawkW5vsW/HX6clMvObpIP5pdZ6ruwuxICt2?=
 =?us-ascii?Q?Uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae444fbd-ef97-4808-310d-08ddd8f910b5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 17:03:59.7909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kDh1mFhzuho1QVkrI7tAmde17BTzM964iwZwl2Dwzoq9J7SJfqcFuKQcjGHNlBFdTG5WEgXOrRPVr0igLZ1pROiWg+rgoVYVk3gVySKDLVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7849
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

On Thu, Aug 07, 2025 at 12:39:47PM +0000, Ciara Loftus wrote:
> Replace the existing complicated logic with the use of the common
> function.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
> v2:
> * use the new names for the renamed structs and functions
> ---
>  drivers/net/intel/ice/ice_ethdev.h          |   1 -
>  drivers/net/intel/ice/ice_rxtx.c            | 162 +++++++++-----------
>  drivers/net/intel/ice/ice_rxtx.h            |  28 ++++
>  drivers/net/intel/ice/ice_rxtx_vec_common.h |  17 +-
>  4 files changed, 102 insertions(+), 106 deletions(-)
> 
> diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
> index 8d975c23de..c9b0b86836 100644
> --- a/drivers/net/intel/ice/ice_ethdev.h
> +++ b/drivers/net/intel/ice/ice_ethdev.h
> @@ -651,7 +651,6 @@ struct ice_adapter {
>  	struct ice_hw hw;
>  	struct ice_pf pf;
>  	bool rx_bulk_alloc_allowed;
> -	bool rx_vec_allowed;
>  	bool tx_vec_allowed;
>  	bool tx_simple_allowed;
>  	enum ice_rx_func_type rx_func_type;
> diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
> index 8c197eefa9..b54edd7a6a 100644
> --- a/drivers/net/intel/ice/ice_rxtx.c
> +++ b/drivers/net/intel/ice/ice_rxtx.c
> @@ -3662,28 +3662,46 @@ ice_xmit_pkts_simple(void *tx_queue,
>  	return nb_tx;
>  }
>  
> -static const struct {
> -	eth_rx_burst_t pkt_burst;
> -	const char *info;
> -} ice_rx_burst_infos[] = {
> -	[ICE_RX_DEFAULT] = { ice_recv_pkts, "Scalar" },
> -	[ICE_RX_SCATTERED] = { ice_recv_scattered_pkts, "Scalar Scattered" },
> -	[ICE_RX_BULK_ALLOC] = { ice_recv_pkts_bulk_alloc, "Scalar Bulk Alloc" },
> +static const struct ci_rx_path_info ice_rx_path_infos[] = {
> +	[ICE_RX_DEFAULT] = {
> +		ice_recv_pkts, "Scalar",
> +		{ICE_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_DISABLED, 0, 0, 0, 0}},
> +	[ICE_RX_SCATTERED] = {ice_recv_scattered_pkts, "Scalar Scattered",
> +		{ICE_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_DISABLED, CI_RX_PATH_SCATTERED, 0, 0, 0}},
> +	[ICE_RX_BULK_ALLOC] = {ice_recv_pkts_bulk_alloc, "Scalar Bulk Alloc",
> +		{ICE_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_DISABLED, 0, 0, CI_RX_PATH_BULK_ALLOC, 0}},
>  #ifdef RTE_ARCH_X86
> -	[ICE_RX_SSE] = { ice_recv_pkts_vec, "Vector SSE" },
> -	[ICE_RX_SSE_SCATTERED] = { ice_recv_scattered_pkts_vec, "Vector SSE Scattered" },
> -	[ICE_RX_AVX2] = { ice_recv_pkts_vec_avx2, "Vector AVX2" },
> -	[ICE_RX_AVX2_SCATTERED] = { ice_recv_scattered_pkts_vec_avx2, "Vector AVX2 Scattered" },
> -	[ICE_RX_AVX2_OFFLOAD] = { ice_recv_pkts_vec_avx2_offload, "Offload Vector AVX2" },
> +	[ICE_RX_SSE] = {ice_recv_pkts_vec, "Vector SSE",
> +		{ICE_RX_VECTOR_OFFLOAD_OFFLOADS, RTE_VECT_SIMD_128,
> +			0, 0, CI_RX_PATH_BULK_ALLOC, 0}},
> +	[ICE_RX_SSE_SCATTERED] = {ice_recv_scattered_pkts_vec, "Vector SSE Scattered",
> +		{ICE_RX_VECTOR_OFFLOAD_OFFLOADS, RTE_VECT_SIMD_128,
> +			CI_RX_PATH_SCATTERED, 0, CI_RX_PATH_BULK_ALLOC, 0}},
> +	[ICE_RX_AVX2] = {ice_recv_pkts_vec_avx2, "Vector AVX2",
> +		{ICE_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_256, 0, 0, CI_RX_PATH_BULK_ALLOC, 0}},
> +	[ICE_RX_AVX2_SCATTERED] = {ice_recv_scattered_pkts_vec_avx2, "Vector AVX2 Scattered",
> +		{ICE_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_256,
> +			CI_RX_PATH_SCATTERED, 0, CI_RX_PATH_BULK_ALLOC, 0}},
> +	[ICE_RX_AVX2_OFFLOAD] = {ice_recv_pkts_vec_avx2_offload, "Offload Vector AVX2",
> +		{ICE_RX_VECTOR_OFFLOAD_OFFLOADS, RTE_VECT_SIMD_256,
> +			0, 0, CI_RX_PATH_BULK_ALLOC, 0}},
>  	[ICE_RX_AVX2_SCATTERED_OFFLOAD] = {
> -		ice_recv_scattered_pkts_vec_avx2_offload, "Offload Vector AVX2 Scattered" },
> +		ice_recv_scattered_pkts_vec_avx2_offload, "Offload Vector AVX2 Scattered",
> +		{ICE_RX_VECTOR_OFFLOAD_OFFLOADS, RTE_VECT_SIMD_256,
> +			CI_RX_PATH_SCATTERED, 0, CI_RX_PATH_BULK_ALLOC, 0}},
>  #ifdef CC_AVX512_SUPPORT
> -	[ICE_RX_AVX512] = { ice_recv_pkts_vec_avx512, "Vector AVX512" },
> -	[ICE_RX_AVX512_SCATTERED] = {
> -		ice_recv_scattered_pkts_vec_avx512, "Vector AVX512 Scattered" },
> -	[ICE_RX_AVX512_OFFLOAD] = { ice_recv_pkts_vec_avx512_offload, "Offload Vector AVX512" },
> +	[ICE_RX_AVX512] = {ice_recv_pkts_vec_avx512, "Vector AVX512",
> +		{ICE_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_512, 0, 0, CI_RX_PATH_BULK_ALLOC, 0}},
> +	[ICE_RX_AVX512_SCATTERED] = {ice_recv_scattered_pkts_vec_avx512, "Vector AVX512 Scattered",
> +		{ICE_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_512,
> +			CI_RX_PATH_SCATTERED, 0, CI_RX_PATH_BULK_ALLOC, 0}},
> +	[ICE_RX_AVX512_OFFLOAD] = {ice_recv_pkts_vec_avx512_offload, "Offload Vector AVX512",
> +		{ICE_RX_VECTOR_OFFLOAD_OFFLOADS, RTE_VECT_SIMD_512,
> +			0, 0, CI_RX_PATH_BULK_ALLOC, 0}},
>  	[ICE_RX_AVX512_SCATTERED_OFFLOAD] = {
> -		ice_recv_scattered_pkts_vec_avx512_offload, "Offload Vector AVX512 Scattered" },
> +		ice_recv_scattered_pkts_vec_avx512_offload, "Offload Vector AVX512 Scattered",
> +		{ICE_RX_VECTOR_OFFLOAD_OFFLOADS, RTE_VECT_SIMD_512,
> +			CI_RX_PATH_SCATTERED, 0, CI_RX_PATH_BULK_ALLOC, 0}},
>  #endif
>  #endif
>  };
> @@ -3694,89 +3712,51 @@ ice_set_rx_function(struct rte_eth_dev *dev)
>  	PMD_INIT_FUNC_TRACE();
>  	struct ice_adapter *ad =
>  		ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
> +	enum rte_vect_max_simd rx_simd_width = RTE_VECT_SIMD_DISABLED;
> +	struct ci_rx_path_features req_features = {
> +		.rx_offloads = dev->data->dev_conf.rxmode.offloads,
> +		.simd_width = RTE_VECT_SIMD_DISABLED,
> +	};
>  
>  	/* The primary process selects the rx path for all processes. */
>  	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
>  		goto out;
>  
>  #ifdef RTE_ARCH_X86
> -	struct ci_rx_queue *rxq;
> -	int i;
> -	int rx_check_ret = -1;
> -	enum rte_vect_max_simd rx_simd_width = RTE_VECT_SIMD_DISABLED;
> -
> -	rx_check_ret = ice_rx_vec_dev_check(dev);
> -	if (ad->ptp_ena)
> -		rx_check_ret = -1;
> -	ad->rx_vec_offload_support =
> -			(rx_check_ret == ICE_VECTOR_OFFLOAD_PATH);
> -	if (rx_check_ret >= 0 && ad->rx_bulk_alloc_allowed &&
> -			rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
> -		ad->rx_vec_allowed = true;
> -		for (i = 0; i < dev->data->nb_rx_queues; i++) {
> -			rxq = dev->data->rx_queues[i];
> -			if (rxq && ice_rxq_vec_setup(rxq)) {
> -				ad->rx_vec_allowed = false;
> -				break;
> -			}
> -		}
> -		rx_simd_width = ice_get_max_simd_bitwidth();
> -
> +	if (ad->ptp_ena || !ad->rx_bulk_alloc_allowed) {
> +		rx_simd_width = RTE_VECT_SIMD_DISABLED;
>  	} else {
> -		ad->rx_vec_allowed = false;
> -	}
> -
> -	if (ad->rx_vec_allowed) {
> -		if (dev->data->scattered_rx) {
> -			if (rx_simd_width == RTE_VECT_SIMD_512) {
> -#ifdef CC_AVX512_SUPPORT
> -				if (ad->rx_vec_offload_support)
> -					ad->rx_func_type = ICE_RX_AVX512_SCATTERED_OFFLOAD;
> -				else
> -					ad->rx_func_type = ICE_RX_AVX512_SCATTERED;
> -#endif
> -			} else if (rx_simd_width == RTE_VECT_SIMD_256) {
> -				if (ad->rx_vec_offload_support)
> -					ad->rx_func_type = ICE_RX_AVX2_SCATTERED_OFFLOAD;
> -				else
> -					ad->rx_func_type = ICE_RX_AVX2_SCATTERED;
> -			} else {
> -				ad->rx_func_type = ICE_RX_SSE_SCATTERED;
> -			}
> -		} else {
> -			if (rx_simd_width == RTE_VECT_SIMD_512) {
> -#ifdef CC_AVX512_SUPPORT
> -				if (ad->rx_vec_offload_support)
> -					ad->rx_func_type = ICE_RX_AVX512_OFFLOAD;
> -				else
> -					ad->rx_func_type = ICE_RX_AVX512;
> -#endif
> -			} else if (rx_simd_width == RTE_VECT_SIMD_256) {
> -				if (ad->rx_vec_offload_support)
> -					ad->rx_func_type = ICE_RX_AVX2_OFFLOAD;
> -				else
> -					ad->rx_func_type = ICE_RX_AVX2;
> -			} else {
> -				ad->rx_func_type = ICE_RX_SSE;
> -			}
> -		}
> -		goto out;
> +		rx_simd_width = ice_get_max_simd_bitwidth();
> +		if (rx_simd_width >= RTE_VECT_SIMD_128)
> +			if (ice_rx_vec_dev_check(dev) == -1)
> +				rx_simd_width = RTE_VECT_SIMD_DISABLED;
>  	}
> -
>  #endif
>  
> +	req_features.simd_width = rx_simd_width;
>  	if (dev->data->scattered_rx)
> -		/* Set the non-LRO scattered function */
> -		ad->rx_func_type = ICE_RX_SCATTERED;
> -	else if (ad->rx_bulk_alloc_allowed)
> -		ad->rx_func_type = ICE_RX_BULK_ALLOC;
> -	else
> -		ad->rx_func_type = ICE_RX_DEFAULT;
> +		req_features.scattered = CI_RX_PATH_SCATTERED;
> +	if (ad->rx_bulk_alloc_allowed)
> +		req_features.bulk_alloc = CI_RX_PATH_BULK_ALLOC;
> +
> +	ad->rx_func_type = ci_rx_path_select(req_features,
> +						&ice_rx_path_infos[0],
> +						RTE_DIM(ice_rx_path_infos),
> +						ICE_RX_DEFAULT);
> +#ifdef RTE_ARCH_X86
> +	int i;
> +
> +	if (ice_rx_path_infos[ad->rx_func_type].features.simd_width >= RTE_VECT_SIMD_128)
> +		/* Vector function selected. Prepare the rxq accordingly. */
> +		for (i = 0; i < dev->data->nb_rx_queues; i++)
> +			if (dev->data->rx_queues[i])
> +				ice_rxq_vec_setup(dev->data->rx_queues[i]);
> +#endif
>  
>  out:
> -	dev->rx_pkt_burst = ice_rx_burst_infos[ad->rx_func_type].pkt_burst;
> -	PMD_DRV_LOG(NOTICE, "Using %s Rx burst function (port %d).",
> -		ice_rx_burst_infos[ad->rx_func_type].info, dev->data->port_id);
> +	dev->rx_pkt_burst = ice_rx_path_infos[ad->rx_func_type].pkt_burst;
> +	PMD_DRV_LOG(NOTICE, "Using %s (port %d).",
> +			ice_rx_path_infos[ad->rx_func_type].info, dev->data->port_id);
>  }
>  
>  int
> @@ -3787,10 +3767,10 @@ ice_rx_burst_mode_get(struct rte_eth_dev *dev, __rte_unused uint16_t queue_id,
>  	int ret = -EINVAL;
>  	unsigned int i;
>  
> -	for (i = 0; i < RTE_DIM(ice_rx_burst_infos); ++i) {
> -		if (pkt_burst == ice_rx_burst_infos[i].pkt_burst) {
> +	for (i = 0; i < RTE_DIM(ice_rx_path_infos); ++i) {
> +		if (pkt_burst == ice_rx_path_infos[i].pkt_burst) {
>  			snprintf(mode->info, sizeof(mode->info), "%s",
> -				 ice_rx_burst_infos[i].info);
> +				 ice_rx_path_infos[i].info);
>  			ret = 0;
>  			break;
>  		}
> diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice_rxtx.h
> index 8c3d6c413a..e6a18310a0 100644
> --- a/drivers/net/intel/ice/ice_rxtx.h
> +++ b/drivers/net/intel/ice/ice_rxtx.h
> @@ -80,6 +80,34 @@
>  #define ICE_TX_OFFLOAD_NOTSUP_MASK \
>  		(RTE_MBUF_F_TX_OFFLOAD_MASK ^ ICE_TX_OFFLOAD_MASK)
>  
> +#define ICE_RX_NO_OFFLOADS 0
> +/* basic scalar path */
> +#define ICE_RX_SCALAR_OFFLOADS (				\
> +			RTE_ETH_RX_OFFLOAD_VLAN_STRIP |		\
> +			RTE_ETH_RX_OFFLOAD_KEEP_CRC |		\
> +			RTE_ETH_RX_OFFLOAD_SCATTER |		\
> +			RTE_ETH_RX_OFFLOAD_VLAN_FILTER |	\
> +			RTE_ETH_RX_OFFLOAD_IPV4_CKSUM |		\
> +			RTE_ETH_RX_OFFLOAD_UDP_CKSUM |		\
> +			RTE_ETH_RX_OFFLOAD_TCP_CKSUM |		\
> +			RTE_ETH_RX_OFFLOAD_QINQ_STRIP |		\
> +			RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM |	\
> +			RTE_ETH_RX_OFFLOAD_VLAN_EXTEND |	\
> +			RTE_ETH_RX_OFFLOAD_RSS_HASH |		\
> +			RTE_ETH_RX_OFFLOAD_TIMESTAMP |		\
> +			RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT)
> +/* basic vector paths */
> +#define ICE_RX_VECTOR_OFFLOADS (				\
> +			RTE_ETH_RX_OFFLOAD_KEEP_CRC |		\
> +			RTE_ETH_RX_OFFLOAD_SCATTER |		\
> +			RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM)
> +/* vector offload paths */
> +#define ICE_RX_VECTOR_OFFLOAD_OFFLOADS (	\
> +		ICE_RX_VECTOR_OFFLOADS |	\
> +		RTE_ETH_RX_OFFLOAD_CHECKSUM |	\
> +		RTE_ETH_RX_OFFLOAD_VLAN |	\

The OFFLOAD_VLAN flag includes QINQ, which is not supported by the
Rx vector path, so this needs to be replaced with OFFLOAD_VLAN_STRIP and
OFFLOAD_VLAN_FILTER.

