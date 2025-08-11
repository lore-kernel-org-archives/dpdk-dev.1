Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C666AC87FDB
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 14:02:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B43E0402AC;
	Mon, 11 Aug 2025 16:02:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id A31BD402AC
 for <dev@dpdk.org>; Mon, 11 Aug 2025 16:02:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754920936; x=1786456936;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=dQLFuIgskPtp6a7G0L/ltJOeA/ck3E37TRyo8wBZ7qA=;
 b=AhNvsVVuL9qPGO63i4mKflk/j8choACm5qR8qh2U+IMONXYe16lzxRXq
 tQV+TcsmCcqbrkqCKi0f+HSBmO4DLu/X7EftcQJKhmRlZDvaWLQrWGVlF
 XOjazBPoNgRi5TuH4kU4hAArp8zhGxx7QMxM3FJgqZdNXg9ayHIveJ/pK
 /81DkgCrbGlZHNIHLochIGqD8Ez/H6JvHw7MmFSuTZoZPN8AcUmHXRgGx
 3rbPwOsZ75pJl5QxpbKZym1GeNzkVycJAU/mlBUlZJb/l2nfN6wOAveLn
 T4E7UINIreBPqv4HHP6JTPwPRJz2Byo1v/OTQRZ/Zk6W+UMw9uHbALi4a g==;
X-CSE-ConnectionGUID: YTPiNRPoSZyQvjHrZk9RMQ==
X-CSE-MsgGUID: aFnqToVEQW6gMmwwfAMgJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57078912"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; d="scan'208";a="57078912"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2025 07:02:14 -0700
X-CSE-ConnectionGUID: KP1Np9dXTQ+tRT2rAMDcNg==
X-CSE-MsgGUID: P4c4qdEhS0+QVpEBhCHO/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; d="scan'208";a="165822549"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2025 07:02:14 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 07:02:14 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 11 Aug 2025 07:02:14 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.66)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 07:02:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3rFkZhdRe1gL6nCHvxy4EjYL7b6rAGF8+8wpj2YDJfzfww2m8A+5SB3lFOSB6feld9HmuhKH31qG/teOQ1VFC3FFka13AgKN/6ReOuEA8b6+XBrPZHf2QbC/EyeqEX4pNjheKWoRqLGFKOV3oHtZHG/KVZBs+e90aJMAUK8+mK7ZJEYlj+A+wlQaLdfxb3K01gURM/hS8oGzygxUceU+0PN0Azw0keRmtr0vBj5ZmZchZxQtGMN0Xly3xkC+aOX74vMkIoZhWV/LqvL+Bp2o4HSUZhLMKF78sW5SrdtKPdkJKQv8ek+hnYhB8F+G1mGsM5hm2lbGnMY1GeyyzHGCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRdOHFkebpQXqfwGYSJ9mmHgrgrrLsw/jKKs0a6hLYw=;
 b=Hw6C6257z1jtBznsdsJPoZZC6qQ96MjYKcuWOhcVhLXFUtTgJm+vLKRmgohrBVsLXrtrlMv5Lr8YjcD5odyB9I2GrCRw8AFMcqQDISCd+KBVtD/YSsL7iCA4biLGyOBVsFiyvWDyb96UTNDkONLKBUlrqk8SYSPL+1mrapmYnSAy3bS1LThxSLD76FCKe3Edh7J4b5GVqDWglPmnFQkp9y2fv8CtmyMX4nFpOjEBpTkduQuQXRxpKQOkdBqssYxwe+E/OOuXrVb5TzbQVO8pj9N1lkpBh21u9V0YefkeFMPqOJk2u4ZZ961uB8deQVq/PVzvWsEvFWiAw02/hjSeZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH8PR11MB7069.namprd11.prod.outlook.com (2603:10b6:510:217::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Mon, 11 Aug
 2025 14:02:11 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 14:02:11 +0000
Date: Mon, 11 Aug 2025 15:02:06 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>
Subject: Re: [PATCH v2 1/6] net/ice/base: add utility functions
Message-ID: <aJn33kGcl2dfTMDe@bricha3-mobl1.ger.corp.intel.com>
References: <20250807122238.334177-1-vladimir.medvedkin@intel.com>
 <20250811134301.459523-1-vladimir.medvedkin@intel.com>
 <20250811134301.459523-2-vladimir.medvedkin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250811134301.459523-2-vladimir.medvedkin@intel.com>
X-ClientProxiedBy: DB9PR05CA0004.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::9) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH8PR11MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: 43754ebe-0901-4bd0-b080-08ddd8dfaa92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lEUyEQe6VfneXeFF1+QqmaC8w7YWWa0Oglr36oo5KO7c/WVxI+ERscPHP4sb?=
 =?us-ascii?Q?lCgpgXG/0Qt9zKmjaQT8Rmc9ddlRw+hqGs//CYsGtYgqegfeVRYJPfcYHjxe?=
 =?us-ascii?Q?QXoYMLqNoawhUwp5zIt+idGjgR5VSsbI8uLJ5YIBLJgNWM4bOyP8oX3/JAr5?=
 =?us-ascii?Q?Kq1w8JK7YPX54dmFESb49QGkOtB3+RJw/HYKB+iLukI2wHoSwrwBrn/iLy9k?=
 =?us-ascii?Q?6YA12ufDQQhNN9zSCvQMrnSeYgOXr40EMouSe0Iegt/pPFRv4gBeLSmaKIwN?=
 =?us-ascii?Q?WIb7HXLrGm0vxZg6EMgEMr59qmDrx8j3+MRprqPVfxGhB5uWryfysiSw54K5?=
 =?us-ascii?Q?Wp4NsPhMfn5FKjJERupthmo6kZC+ih01sytTrxO+ZbBBkxJS1W4Fotp20tlL?=
 =?us-ascii?Q?AEBaPzA+96LA2K4HOhTqPpJvvBBQlMKYSVudZrd16bgAipo3ZdD0trnYFfHL?=
 =?us-ascii?Q?+epZjpBN6YpkNCttdyFJrClShXgGF8IAX3oGBnjqu5seex0jDvPK6MHBHcTZ?=
 =?us-ascii?Q?TpyHOtGWCwSdrzllt2BRk/Uh0P22jM6sOoomsBlzAkuvW51fjrzs4CvmgTAo?=
 =?us-ascii?Q?26JDgiIlF96hd8YPOBdO+4SWhihewJbWFamWgUuk5jfIV5qhK0HbPmkQxgy4?=
 =?us-ascii?Q?u/kTgasf71NN/DtNoIu3lt19PV/Y4j2gM8dcmBbh+oriuZ4uhiQ7n4WVuLtd?=
 =?us-ascii?Q?DZsqrgfakOrs+7azUR2ytmgDeItxo3un+uwrFUlWXt4lex1AxJHrLB4RAMRe?=
 =?us-ascii?Q?xL17WQSwS3SaXhdLffXN9ZK+dK+oQLKX/3pGfE95L6579PQU0a1Sot4AvrwU?=
 =?us-ascii?Q?lZc53MK04vMNDROz3RwQO8bsXgxFIlGFzuZmpnB/YEQiaNnsfeUDSMFVnUtP?=
 =?us-ascii?Q?3Ghuc1tWGDGeZOxbLAnH7qSTgckR/B+omCg9hawpPGwTzlit5hDcUfsK9zAf?=
 =?us-ascii?Q?oBkwd8AMGe3XDWrT99IFtB22OssO1sCiYoXmsJOcXULD5+aUEyW5RFcpRE9g?=
 =?us-ascii?Q?G4Wi7s3U/Z75d94JyxKJkLjA3P91laAOsKpRDZT978z/aErVITYlAMWKfd4u?=
 =?us-ascii?Q?OaMixPdNs0tEo0FZ2O/R2Le1h7QL8xaGi7txIlks9/ONq6zonJ5npTmtbofb?=
 =?us-ascii?Q?SZZRUmxpTox3NahDBHdaejHNeFY1QBZHPV2MsKevpFYPBWrsFHdQtvtZcUrJ?=
 =?us-ascii?Q?n7H52tlVQdSaLJCTD5+OQiAzyhEqRVc/BcnSaWgL9lX/uheqJjI5zrQDnlF+?=
 =?us-ascii?Q?XOBmx2W8T3Yos43OVIo+uFoJUaDYSV325BcJFmYCD8Ru3lHejofm7c+82BhQ?=
 =?us-ascii?Q?98WKWfmQW7m9QKjXzuvl85wBkrJcLpFZb7FOboelQN+ZBIUWcyE1LpjTupxJ?=
 =?us-ascii?Q?P5KGpFJi9W6fqZkDA4ROZb04MACRgUpq5Va0jThYg+taduWODWDA2VIgEIdI?=
 =?us-ascii?Q?Ijq5ZDqWhTY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cZ742HoGK19fATho8xE3OZy8RqDlPLSkcrhaWHOrmAaDlXnwMCAsuTzYk+Qe?=
 =?us-ascii?Q?IWpoZfQf2FuULlNUh67ht3i5d35gCs9Xj7OVAoucmPg31mZmVUXl8feGdP20?=
 =?us-ascii?Q?/PZviufBKm4G1ECZm94f2llQoKAh/Og50rBFHn/h8zJmheIIBXAc2qsC+ztE?=
 =?us-ascii?Q?7PfHtyBQoYncU3Jyu+hCAXYK+fVcX64wyVj7fJtk7kcn4VPaZOKRKDQWsvQ8?=
 =?us-ascii?Q?KZlDWzaACqDglrouymLbq7TrVKzWdKPkcgzatZrQnmUWO9arJ/LiaIV9GqsD?=
 =?us-ascii?Q?SHC0HZhuRFONrYJCgdpSWsX+5fhe+3pCXO5NGA48p+KEHAiLd9jgcIWit0NZ?=
 =?us-ascii?Q?U+caUNILZ9lvdMGmGmzq9uBsiQ0HvVsE2rgLgyI7GaPcTQrPXecLxduXAUv1?=
 =?us-ascii?Q?qUDWapBPo9wgXn3UbagEOL/xWBPZYb1FEbmLaCDR/V/nW96QPDLa/Tk0IWpk?=
 =?us-ascii?Q?aUFJKmI7/C5g3TJ1EfsC+DOZ96bgbX4Ht6wBO9AUIMpGmJYKeVI770OaMfss?=
 =?us-ascii?Q?PU456qaKy1LSTzB7+4W4MqRQDBf6W8zU/dCKm8I3e7heEs0x1T4hPBmJcJ8y?=
 =?us-ascii?Q?4MnwI4nuuD7SSY4g3EmR0FGT8JOa0ZY0YqUOfohBhP1h7GwQuMG6UYgOVYLM?=
 =?us-ascii?Q?wPK4qh9YLCYGlIIIxzikRkNiMuxsmGNdlYyFz4lBHgNnNEBRZ28fXpcm0QRD?=
 =?us-ascii?Q?uN4hKsPcpiAlmxEha38GxtQjzeej97ABQPk0rdh3yNLsgJGzex2ZM4c/EDzZ?=
 =?us-ascii?Q?DzOO6JJ8X7AuFkS17CN63F1LBmkYCspx6cIp5jYb5NTQp/ZuQmUQpKkXNljb?=
 =?us-ascii?Q?/5GVHlCkuWokbh9nre3k8tTyeewzbWFXnThRabUo5zZdQ/OkBmuN7R/mYg4O?=
 =?us-ascii?Q?dq+0yVXPFIebrFZReuoiJ5HlhWvfZmnBDfEKj+8B0bFXve9goxJgmE6BIS3j?=
 =?us-ascii?Q?9ML9YdfSkuG5ulLNpeYJGTM/mxKhQ8o5ZlTdx8gdJ2N7gh+m4QhlyXiJURhx?=
 =?us-ascii?Q?2HH9gZADSRLg2P6dS4amixAvTlc9N3R0NynZ9JbZw15Z2Yz66x14lSfZd/rV?=
 =?us-ascii?Q?fKk9kJaq1whEPvLpNx6t0cpor7e4clgxNag1phyN8iq8n7IZGUlEnfV7tYpT?=
 =?us-ascii?Q?mk7wcDQmnKwUuzvookgwKAEU4BKsGSYGIrca23Y5XhTApBu/QRpSbed8Pzxu?=
 =?us-ascii?Q?h00yDtRBgt4tZ8/VZcGtWP6W6fHw4X7dhIcla1iv/jcGAls+6lpVO/9lUizW?=
 =?us-ascii?Q?RQvvjzzBxPs22Xu5X/OlQ9DF+zd0/+EgbjtzYt44qByYMuFIRf43Gck6LKsZ?=
 =?us-ascii?Q?YGQJk9Ir36TeA7CAxg3qJzceKPUfxmjuTpKtWNsq90MUD6EQ6C8krxxq31FA?=
 =?us-ascii?Q?4lz7ttmYU/mR3qyVOESluF5bb6bQbCWNPyuSXgrvVu6LvIOh8o+H4sNr2RAi?=
 =?us-ascii?Q?UecLfB+XYeK6LqqIkDVIbcReWdHaXlgMMDVQ7uKjcesaDqkqdEHPEEWastJA?=
 =?us-ascii?Q?FO7NNOPnwauvMqL0UhA7Tx4p50BbYCninPSft/zUJBgFY9m4z8tqsrr2ad69?=
 =?us-ascii?Q?T784/5wZQ6xm/pSqyq9/Vpfcc0kZEPzQ6mU4Sk0B5MAxywvQ0TaVv+2wNzPl?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 43754ebe-0901-4bd0-b080-08ddd8dfaa92
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 14:02:10.9885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LQM1vXdqTTL2+92Q7jIvs9rzC/5y3jdgNaQ+cAS04n1hvpL7ff9kCD9NlpLCR1ZVjt1rwxpkkegWOQditQOG2AT9PLgJc9YMyfXA1IzFV/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7069
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

On Mon, Aug 11, 2025 at 01:42:56PM +0000, Vladimir Medvedkin wrote:
> Add the following function related to DCB:
> 
> * Get number of Congestion Domains per port
> * Resolve Traffic Class(TC) by 802.1p VLAN User Priority(UP)
> * Get absolute index of the Congestion Domain by the TC
> 
> Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> ---
>  drivers/net/intel/ice/base/ice_common.c | 28 +++++++++++++++++++++++++
>  drivers/net/intel/ice/base/ice_common.h |  8 +++++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/drivers/net/intel/ice/base/ice_common.c b/drivers/net/intel/ice/base/ice_common.c
> index dfc2fd69e7..8bca256b34 100644
> --- a/drivers/net/intel/ice/base/ice_common.c
> +++ b/drivers/net/intel/ice/base/ice_common.c
> @@ -6579,3 +6579,31 @@ bool ice_is_fw_auto_drop_supported(struct ice_hw *hw)
>  		return true;
>  	return false;
>  }
> +
> +enum ice_cgd_per_port
> +ice_get_port_max_cgd(struct ice_hw *hw)
> +{
> +#define ICE_8_PORTS_LINK_TOPO	0x2
> +	u32 link_topo = LE32_TO_CPU(rd32(hw, GLGEN_MAC_LINK_TOPO)) &
> +		GLGEN_MAC_LINK_TOPO_LINK_TOPO_M;
> +
> +	return (link_topo == ICE_8_PORTS_LINK_TOPO) ? ICE_4_CGD_PER_PORT : ICE_8_CGD_PER_PORT;
> +}

The term "cgd" is not very clear (at least to me) on reading this. I think
a comment at the start of the function to say what it does would be
helpful, e.g. "/* get the number of congestion domains (cgds) for a port */

> +
> +u8
> +ice_get_tc_by_up(struct ice_hw *hw, u8 up)
> +{
> +	struct ice_port_info *port_info = hw->port_info;
> +	struct ice_qos_cfg *qos_cfg = &port_info->qos_cfg;
> +	struct ice_dcbx_cfg *local_dcb_conf = &qos_cfg->local_dcbx_cfg;
> +
> +	up &= (ICE_MAX_TRAFFIC_CLASS - 1);
> +
> +	return local_dcb_conf->etscfg.prio_table[up];
> +}

Rather than "up" (which I assume is "user priority"), I think
"tc_by_priority" would be a better title. Again, a one-line comment at top
of the function can clarify that it's the user-priority field being
referred to.

> +
> +int
> +ice_get_cgd_idx(struct ice_hw *hw, u8 tc)
> +{
> +	return hw->port_info->lport * ice_get_port_max_cgd(hw) + tc;
> +}
Add comment here too - e.g. /* get congestion domain for traffic class */

> diff --git a/drivers/net/intel/ice/base/ice_common.h b/drivers/net/intel/ice/base/ice_common.h
> index f7e7ff5aaf..2d4f4871e6 100644
> --- a/drivers/net/intel/ice/base/ice_common.h
> +++ b/drivers/net/intel/ice/base/ice_common.h
> @@ -25,6 +25,11 @@ enum ice_fw_modes {
>  	ICE_FW_MODE_ROLLBACK
>  };
>  
> +enum ice_cgd_per_port {
> +	ICE_4_CGD_PER_PORT = 4,
> +	ICE_8_CGD_PER_PORT = 8
> +};
> +
>  int ice_init_fltr_mgmt_struct(struct ice_hw *hw);
>  void ice_cleanup_fltr_mgmt_struct(struct ice_hw *hw);
>  void ice_set_umac_shared(struct ice_hw *hw);
> @@ -335,4 +340,7 @@ ice_aq_write_i2c(struct ice_hw *hw, struct ice_aqc_link_topo_addr topo_addr,
>  bool ice_fw_supports_report_dflt_cfg(struct ice_hw *hw);
>  /* AQ API version for FW auto drop reports */
>  bool ice_is_fw_auto_drop_supported(struct ice_hw *hw);
> +enum ice_cgd_per_port ice_get_port_max_cgd(struct ice_hw *hw);
> +u8 ice_get_tc_by_up(struct ice_hw *hw, u8 up);
> +int ice_get_cgd_idx(struct ice_hw *hw, u8 tc);
>  #endif /* _ICE_COMMON_H_ */
> -- 
> 2.43.0
> 
