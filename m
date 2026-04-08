Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8BD10F995A
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Apr 2026 15:55:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E57F4060C;
	Wed,  8 Apr 2026 17:55:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 25FA14013F
 for <dev@dpdk.org>; Wed,  8 Apr 2026 17:55:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775663735; x=1807199735;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=d5KFzCqCKwqQPBWTkaWfHz7+jAIGzDYNrikSY4FB0Mw=;
 b=hKSP0Prt5rYPclVv17qBVGpGr01o0XicrX+smX+jr7SbPhL1j8LxAsJ6
 IvTUp2Z65guSehTkCR0rePvjLI3oJTQz+OSobQYTpcKeO63QtN/0mXTPb
 fW57m98hDa/K+uvq1WvpCEz/bdBWyyGVVXDzK9NRaLMKZRJRCTrwinCxM
 5uKTjsfNRVbGVOXC9w+EPGDnk0W2ItdMYSZQYiXDEtn0GlCxVDf7lM/lp
 wxDfsEwgXiqNM6COscG1EzKharJHGjAlfDETbZ7Hkl5YjOH7hOmzowC0O
 crhBtJcw9l+LwpJZ9qmt2aSI6+izhn5qiOD4vrrmj6K0USFLJJ8bHg+6h w==;
X-CSE-ConnectionGUID: nhwNd00yQ7ulsXawpt1TrA==
X-CSE-MsgGUID: uBr/UaeOQ6yh/wMMPwL1QA==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="75825772"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="75825772"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 08:55:34 -0700
X-CSE-ConnectionGUID: MiZbaupHTOmcNk6R7UiGeQ==
X-CSE-MsgGUID: 65SgCjDPRUKYKHFYpJre9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="227505205"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 08:55:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 08:55:33 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 8 Apr 2026 08:55:33 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.65) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 08:55:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X11A2pZM6Va+iIEY7JqfuARm3Jffu6FDTwuWWL8C4h2P8m1kXaOzWtF2y1HxgeYjBejDy34FwaJSL8n7HfHd2EPPToeN/8dqbpo4tzsOXsZZYMPwk9Hz57/7QhgZkEuXoUcKEzCKSVdgs8oIDvHwwkZNHfECBUy6M6S+zNC2nqvXokpV82KM3yNzwxjsKFMVnc1JmSS+hJKDTs/2gd6SWUjD2ojocGf2JlSz3i0izW9rd1KzQls15t2oLHR545F/AMwPgXQ60ux+nPZFfqwifoBYZFX9oRkD/Q4ZV72+D4Y36tICmhsUk/IM7Xis6U8qX85eVJkQDkX65EJZPmk90Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxE6cqrvjbRid4xBN1mejFRw3kmlupXks+ft42cGyBw=;
 b=Se1s9Gwluf61W9blevrq8v0Rq8ppAC5HJCApuIWu0HZ7binuDCtz67JOCFRL1ywCY/xCIH26na/07ZiaVnp4U6e/E9iSGYk/yueu4hlTePcTUDb4oigWwRgeMffma3KLQrFETxsXj6iibQs4xOnZtwH4CdkWtQlLeNKupvlU/ED4alAzK7dVmRx1OyvdnLI4zVg5qfVk+l/DOHq/T7iYB+Qsiumkkc5FJ1kVMCxVAFrrte89XvZ87WM65bwmgIO0U8J1YHxFfEh8X703RGaVn0N8F2TzLZiVmAL1J7j+NTiouTEbx/l5OruXJiOjNYup5iyjonDak6efeCE6dqPj4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB6991.namprd11.prod.outlook.com (2603:10b6:806:2b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 8 Apr
 2026 15:55:31 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.018; Wed, 8 Apr 2026
 15:55:30 +0000
Date: Wed, 8 Apr 2026 16:55:26 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH] net/ice: fix L2TPv2 outer MAC address in training packet
Message-ID: <adZ6bldGrcY3ucv9@bricha3-mobl1.ger.corp.intel.com>
References: <20260406081355.3241393-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260406081355.3241393-1-shaiq.wani@intel.com>
X-ClientProxiedBy: DU2PR04CA0057.eurprd04.prod.outlook.com
 (2603:10a6:10:234::32) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB6991:EE_
X-MS-Office365-Filtering-Correlation-Id: c2d93b9e-4d7f-4bf1-cd7f-08de958742cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: dtq+D4N48PCrbYEHJJoYHFjzTdFeR7ssyY5E4wc73dnsf5e0+gRfLLX3auQixVm1cpIeF0fKxIgVENh88Oj3LNR7MmeVqwh53MfYfbZMhiOoDSMIF4i8R0f2/7wN678Ta0JgnIwnv198de5zJBdAHJbfeKfARFJ7hbdgeUT5nodEsLHIMuOlFpv22nIylacn2FD2Uhg2RvjhtjCpJJ4An9R0N5L0QKU0vvsWlPvVCbdScHi1sJFQXwbtRnyXvQAJzwb4KSjq6yTsnDDdAdWk/PAki6/qh+k9rHyUpI7o4DAVsXO7BXz57Vp/IbDt2M2L42k7P0oTVeYEL5FanD9DgxXRAfiQBYDFa8ORQ12ZZqW3KIjlJikCkYCPXGSID9XvXBpBTuRjtlYnsaT2FH7NrM/uB4oyR8ud8F0pfPXXsyjrjt6dTavaNUJovfafldoJgVFSOKNI072epcWsr4m/vCWBzMaIf+qL5/Hofru+vi8B3BobxTuW/6qEJx1adS33BA1apeZ/3i5H3U7o5dNWAXc/q0DDSESOk5LV8tHofBUpSbHym6+92E53/n+L0n3dYeukjGOaLa4wTm15VkTz0LBAd5HzUxvCmR8F7EVm6zK9YKvQxykcUeODt5+TMNEF2JoegvsLIr/1sixEVpqWW3OPqi4Ok099TvkC5tN3SQqM4uV4trj0xvWQ5UJPIivVFTaaOj2CbOYezaxlnquA9wa+N2Ks9/byrjRmlhGMA94=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rM1x+TdFZ5fbKwFJM4jaG4Kn5Iux4SiOwoZSHHDe7V9mexAEnQy0laS0Z67c?=
 =?us-ascii?Q?C+Pv3v4tJiK5/rdx8qxY1T+lug/K/G/JPEZfVVkZdY8F3pq+qv5qgfROr81e?=
 =?us-ascii?Q?j9j8LdWuYujcTYBg7dKHHexXY4FH2Angtd0zYqWFXTjTO1weyf+ALm14y50g?=
 =?us-ascii?Q?8ZWzL3PAi7CVhTnKLHFhLJdJUU1DZ9eytemohzfOH2be4oDbY90EVR9KClpO?=
 =?us-ascii?Q?mvm3aYnpbgjoAH2NVQIyL3KlcQ5ffcKWV7rIwQ0zsDrVikIbkazOGLON/syP?=
 =?us-ascii?Q?ZW7cHpuceu0ctZfFU8NVKcf8tMxaX+b0lDrFwjkhUqjPPM0F8i/LlqCyHsog?=
 =?us-ascii?Q?Uy3uRiJ2bf+MLUL/PQPDYIp9/vIIPL/LZqfh0bITolqO7nrUKTM2ZKscfae+?=
 =?us-ascii?Q?RaZLMvHX6XWbdW6qfqHM6hp90EU118JF8SxU+qED2DP25ZSugsXj6MWGXnzc?=
 =?us-ascii?Q?IhWGLnex5qCbmdJnVudUIjY1Ema0LPlnrXC9/jb0NUbZ9qdY/fGgKtqk6egb?=
 =?us-ascii?Q?3dvCWbyfTuJSXX6GZz//5U+o199mbTGs5USU47ldiOLX0jIVUQQDmbV5fMAN?=
 =?us-ascii?Q?cSXwMjyx6zro8tC4dyb4kXCWDm7ZK9Wb4EqQMYgMkkMQPZxMn5g0RtutgrM+?=
 =?us-ascii?Q?qzclRb3JBTwsOcX1+ckOAK/DUj7GaowZpQgMMmFzUHL6cDOvrNDXjjcrZAlH?=
 =?us-ascii?Q?yqjSDRRYZr3fZkbZB2UVdbICymZP0QT/YSuuQHxH3OU1ZhUN4o/hvwWka1Nw?=
 =?us-ascii?Q?m03Hbzci2lTzXAytahpXRHGknCMPv0hWNKDPUlvBNTbfhGzqs1odIGLqWBCW?=
 =?us-ascii?Q?dgtLcw1d/bZKAz/1MnEQlOuLlA3r7OkKUhcbovkR60ChJH8BAToY8nra96Xh?=
 =?us-ascii?Q?Fs1xC5q2DXk4naYeyKrkyjldtEBVb38ZVtc7v+t574NhTGvgFwD9bwjPVYpl?=
 =?us-ascii?Q?YnCoah6/G5woOT/GRHs2jSFx7qSImAAPW0HyNRVovLmshr8BTfj77WiXB0Ar?=
 =?us-ascii?Q?zsmpqq222/B5uBxAKvkZBN5dq4g+nFMYLyzkKaz3Rq7ePGLlONq4eyVhWgD5?=
 =?us-ascii?Q?csc9LDx/PaIL1OuuNwoH2nWOAcDDB7ROM30KdohbMcpHVmmfzuqLxdVP0/0k?=
 =?us-ascii?Q?1KOkuvZWj/QzUwppkyBqcg7xGkrnD+HdAYI+CLZnx2XKfBmJG/oU8O3zQHIs?=
 =?us-ascii?Q?e4BZYaNvVpCCTnZPyMcQHncF0ifgbdwPjC+yR2xyv/BGFm1EPXV7T/IIbOa2?=
 =?us-ascii?Q?dU2fTbhs6c3beAJ8L34YSYY4jOLkUMg9KzhWl/QmZ3h5dm4ThcMQU/7IKZPM?=
 =?us-ascii?Q?dfJ9wxqiXNBB9aGTyxavHe7sSbbXVheTs7PDYYXhnJx8qCnXXgP2qPWi0JTV?=
 =?us-ascii?Q?/Fw0Yld48OWKSWMRehNeXkRdhUqpkFj5SyWg6eva9XHWglr/w4q2WE/qMe8I?=
 =?us-ascii?Q?YEfN7BwWBzsrfKBnO/Ga3an0COun6FMNJZLrmFJA9p5fYioLLU2+9yQx3tVj?=
 =?us-ascii?Q?qZ08t9ygCNgof2A+SvZwH5Qivd2NvbvOnmAunalvJRpZTn60cmoakh+h2P+q?=
 =?us-ascii?Q?xEbgn5VQIqkWeLhw8LC3oEQ5kQHx6yEutoNJfiW1DjuuyaGUW/wCayqyQ/tY?=
 =?us-ascii?Q?N58j7x0/EX6K0DxzSv/hp6f5+tGouhpM8yrRe+IIDuUTEON/qmngbb1Khas3?=
 =?us-ascii?Q?LKHFmueYHDuhci/ljFZt8Y5whMSSECohhJYLz93NqSq7yEUksDq04jZZp//a?=
 =?us-ascii?Q?PSPLBTPEbWAR1E1AE27sRls5Qzg9fg4=3D?=
X-Exchange-RoutingPolicyChecked: CbmtQ9BNeBQ85V/CiTTDNjMqMztuFMPytPokp3s0kJNfCOpqz7/Fhlf4KEqDnFNuamNtKVOQpF0oF05GgE+oWQFufP2PwUr7q3vXDXiWuABLPnMgRyZevAz4nW6fWZCvxRPDaiC1twyJgtAmE2loFpmRM6dL/zE1+iDD9Y0h/a5sk+C79ANN6hLsfnKw5pfH2Cm+Rm5fJIBaYWw2bPAPpy6xWL0jKzAHSI5FSefueZG9/5dZf8m+o5bl7bVUwkrmau8o35SB6O1ZNlX4NazRNLOHdA+ftr7AHODsWEsrQL//nTq95GDEycfeAnbziiosnkjUvgjYo6k71k9sMLQvBg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d93b9e-4d7f-4bf1-cd7f-08de958742cd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 15:55:30.8627 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQC8qt1/35YSNLABiCN1rvdyiLeeWeOKP8lf/RYgbQX8rvXuo20rtMpNvybEN7vH42csA6zzciHTII5Q7Mzrl2OG78AMn7rp1gvQa9m+lf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6991
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

On Mon, Apr 06, 2026 at 01:43:55PM +0530, Shaiq Wani wrote:
> flow rules with eth + l2tpv2 patterns fail to match because outer MACs
> are written to the wrong location in the training packet.
> 
> The pre-scan loop does not detect L2TPV2, so tunnel_type is still 0
> when the ETH item is parsed and MACs land in ext_data (inner) instead
> of ext_data_outer. Also, ice_fdir_get_gen_prgm_pkt() uses the 'loc'
> pointer (past the L2TPv2 header) instead of 'pkt' (Ethernet offset 0).
> 
> Detect L2TPV2 in pre-scan, and use 'pkt' for MAC insertion in all
> four L2TPv2 training-packet cases.
> 
> Fixes: 733640dae75e ("net/ice: support L2TPv2 flow pattern matching")
> Fixes: bf662653976e ("net/ice/base: support L2TPv2 flow rule")
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---
>  drivers/net/intel/ice/base/ice_fdir.c   | 16 ++++++++--------
>  drivers/net/intel/ice/ice_fdir_filter.c |  2 ++
>  2 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/intel/ice/base/ice_fdir.c b/drivers/net/intel/ice/base/ice_fdir.c
> index 2c0cb99854..e1d8b65972 100644
> --- a/drivers/net/intel/ice/base/ice_fdir.c
> +++ b/drivers/net/intel/ice/base/ice_fdir.c
> @@ -4599,16 +4599,16 @@ ice_fdir_get_gen_prgm_pkt(struct ice_hw *hw, struct ice_fdir_fltr *input,
>  				     input->ip.v6.tc);
>  		break;
>  	case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_CONTROL:
> -		ice_pkt_insert_mac_addr(loc, input->ext_data_outer.dst_mac);
> -		ice_pkt_insert_mac_addr(loc + ETH_ALEN,
> +		ice_pkt_insert_mac_addr(pkt, input->ext_data_outer.dst_mac);
> +		ice_pkt_insert_mac_addr(pkt + ETH_ALEN,
>  					input->ext_data_outer.src_mac);
>  		ice_pkt_insert_u16(loc, ICE_IPV4_L2TPV2_LEN_SESS_ID_OFFSET,
>  				   input->l2tpv2_data.session_id);
>  		break;
>  	case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2:
>  	case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP:
> -		ice_pkt_insert_mac_addr(loc, input->ext_data_outer.dst_mac);
> -		ice_pkt_insert_mac_addr(loc + ETH_ALEN,
> +		ice_pkt_insert_mac_addr(pkt, input->ext_data_outer.dst_mac);
> +		ice_pkt_insert_mac_addr(pkt + ETH_ALEN,
>  					input->ext_data_outer.src_mac);
>  		flags_version = BE16_TO_CPU(input->l2tpv2_data.flags_version);
>  		if (flags_version & ICE_L2TPV2_FLAGS_LEN) {
> @@ -4622,16 +4622,16 @@ ice_fdir_get_gen_prgm_pkt(struct ice_hw *hw, struct ice_fdir_fltr *input,
>  		}
>  		break;
>  	case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_CONTROL:
> -		ice_pkt_insert_mac_addr(loc, input->ext_data_outer.dst_mac);
> -		ice_pkt_insert_mac_addr(loc + ETH_ALEN,
> +		ice_pkt_insert_mac_addr(pkt, input->ext_data_outer.dst_mac);
> +		ice_pkt_insert_mac_addr(pkt + ETH_ALEN,
>  					input->ext_data_outer.src_mac);
>  		ice_pkt_insert_u16(loc, ICE_IPV6_L2TPV2_LEN_SESS_ID_OFFSET,
>  				   input->l2tpv2_data.session_id);
>  		break;
>  	case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2:
>  	case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP:
> -		ice_pkt_insert_mac_addr(loc, input->ext_data_outer.dst_mac);
> -		ice_pkt_insert_mac_addr(loc + ETH_ALEN,
> +		ice_pkt_insert_mac_addr(pkt, input->ext_data_outer.dst_mac);
> +		ice_pkt_insert_mac_addr(pkt + ETH_ALEN,
>  					input->ext_data_outer.src_mac);
>  		flags_version = BE16_TO_CPU(input->l2tpv2_data.flags_version);
>  		if (flags_version & ICE_L2TPV2_FLAGS_LEN) {

My concern with this change is that it makes the code different from all
the code surrouding it - all of which use "loc" rather than "pkt". While
there are some entries at the top of the function using pkt, almost all use
"loc". When do you need to use pkt vs loc? Should that be doucmented in a
comment in the function?

> diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
> index 3522d77123..1cbc613020 100644
> --- a/drivers/net/intel/ice/ice_fdir_filter.c
> +++ b/drivers/net/intel/ice/ice_fdir_filter.c
> @@ -1911,6 +1911,8 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
>  	for (item = pattern; item->type != RTE_FLOW_ITEM_TYPE_END; item++) {
>  		if (item->type == RTE_FLOW_ITEM_TYPE_VXLAN)
>  			tunnel_type = ICE_FDIR_TUNNEL_TYPE_VXLAN;
> +		if (item->type == RTE_FLOW_ITEM_TYPE_L2TPV2)
> +			tunnel_type = ICE_FDIR_TUNNEL_TYPE_L2TPV2;
>  		/* To align with shared code behavior, save gtpu outer
>  		 * fields in inner struct.
>  		 */

While I understand that both changes in this patch are to do with L2TP,
they actually appear as independent fixes. Consider splitting these into
two separate fix patches. [Note too how you have to describe them
separately in the commit log, and you have two fixlines for the patch]

/Bruce
