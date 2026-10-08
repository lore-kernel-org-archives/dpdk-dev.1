Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDB8CA600B
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 11:40:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E123240294;
	Thu,  8 Oct 2026 13:40:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 4A4284027B
 for <dev@dpdk.org>; Thu,  8 Oct 2026 13:40:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791459657; x=1822995657;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=DVUgvclwk++HnjibGYdwDC4KTmNQmi5iIKScAYyYmHk=;
 b=goXovOHU1ywQWPSPLoiNuw+R9bunSYea8T4neXB/zOGH+K3+OFPO+QxG
 1mgpIxSpzapxnnVTWS9lB95MN0LqTSqaV8xQunPXP6scBSbvFcvOIgjqe
 RuznDj0afu96LAXEkrqZtR5nkPXm995WVhke6i0B7O6FE0+vlGhFgWQP8
 7HXQC6ASEESUe3Gy1lvJ5r96fxkvvvVnHiG9QEKHy/qFNeWciWwv8Bo39
 8B2hbJgQxi2QMSr0bWnNiTqJIMplw21W3/EbVOrM9kN89Y0dDP44ORWqP
 Ch7ohmEjC0M9aSFkMjrg/1e02/6eqThjl8orJI4h3cJFNRYYYuNcGghiV g==;
X-CSE-ConnectionGUID: bLJnP2rKS3KdxHyAGZzlSg==
X-CSE-MsgGUID: 4L/jLitIQGK40GCBrSOd4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="124119"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="124119"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 04:40:55 -0700
X-CSE-ConnectionGUID: IKAazB5hRyW6/IDGxDb2Aw==
X-CSE-MsgGUID: vx3uBw1fSDSFafDYVELbPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="376100"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 04:40:56 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 04:40:54 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 04:40:54 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.68) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 04:40:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Coy1NgJF+k6hMMh6k3i5MFLun+ts0/9PePfT5EHj1mv7YcFbYniOa9gJcJIX29S5KQ+3tNAVr6brB0vLXUjf+mS+XW9yq0PqGhoQi7W83kUELu1n+WvMVz9UBlU778E9LWVFxwfGTjqeDiNy/R+cwKW96pEmwkxP8VwUtd6ITeXGdKhBU1HLlgvMD/2irVTYDnehHCXIW5DhyiAJT5Ae0gt96S6YkfdEqIlTNjvBdRq7EmecjCSfDJuXCuZxnLww/UBnXb/u+NEmohPm1GddTGCyIt36G1Mdj3utsixY2XLXZ8iwWNB77TqyqWEPF/1D1Smwr/zlkT4KATbaWB9YRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIYNfPR8GV2Yj9h2XuXhxfFUX6COSmzjpeuR5V/Q6zs=;
 b=cPzsgA4psfJm8yxlbSA80K2YOzNpxqw9QH+ovunoeHGtv+RAqk9iD5WFbh4Q7rMtAwXaCZVNCsAu253sxhf7PL7yJ8c/KZIaVVbPDJLTVfihPPBFJZ/MyeE3pR1Rg8EmJdbBY2s2YUbOQXLuQPd9bn/pTKVBB5NzfsA09YVxC3vjtxsHr33ChCIJ6rPXEntlPkqespUAJsiXtAmVpwCgEiCtuB98c1GXs1ojdUvMbuctqjqK8G2rCx4zUWcFauei63IfHiFTmdbP8niP9m3+euI/KIMDUTErmPjvO/5/73dAi1hJ2mVF44n4I6bGAYo2mRgkGF4qzHYJRAyi9JWLYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DS4PR11MB045191.namprd11.prod.outlook.com (2603:10b6:8:50b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 11:40:51 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 11:40:51 +0000
Date: Thu, 8 Oct 2026 12:40:45 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] net/ice: support Rx timestamp offload on vector path
Message-ID: <aseBPS3GmdAkIvn8@bricha3-mobl1.ger.corp.intel.com>
References: <20260918210352.303512-1-sandeep.penigalapati@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260918210352.303512-1-sandeep.penigalapati@intel.com>
X-ClientProxiedBy: DB9PR02CA0002.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::7) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DS4PR11MB045191:EE_
X-MS-Office365-Filtering-Correlation-Id: a52652fc-15b6-4571-db32-08df253100e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: p4Yk0xLoJg0lRl1ZuHnAvcss8qf8Cqnufbhw3Wz17bDM7bCxLS3UDzFo5xxgbigbVipPRVDF/GwbJfS4y46egHFqh/qKQbt6QeOpCWsVAUqOznwVdOsz0nNN0sq0JUMXXcl/FEavfVcu8VLahquHAXgz4yKZQX6Rj8EZHCvBilm5FQBG9fH7T6mrVh3x3grJmNxoXxKwtaw5FzDJsF/PiZd/wdbovRtiG66mWSIv+flt/Qikyi2awnE0W4zxf4byUX/dL87LZyVQgtTFSc0m+ztieXPsWbp+WmBfLRn6MEcM3Se6N8wYbJdcMpdaBISyguUVStbDgxge+bYK6ciIj0RRWA2SyPuH+YCmFbbcCYL/YVX9wou00RlDQA5FVV8eBzDs79VijJK+aW3qgggWwM12iQz+30mvS6MZElNGe4Ad+notHzRkvC9oOqHh0bClbWYN23qrxIrdvuNAMZu3lVHvHl3ec/Fty3ekWCtX0AXXv/n8Svt5glsiThRuL5326BxIRKAbcq01CcjW33UeUAfG6f0hjLXV2Wy47GuhauYAro5HEzzWYksp3+Y9nl+uOxbBVr/7fbQ+MxyycsTK4BE+gBcalstm5dNyacbYvZLCVXvx59/ttL3iVO9f7WDGN9YFxtuCPlC60nrFTHYQ+EOkNgGdlqY92reTDDa281w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PCYAdXVot0GTMx0lZNJoArjm1l4W9pcSjJnTQevw0YERFuL11DNifdKUhzPL?=
 =?us-ascii?Q?2Ec63Fnxa1UiSe3NpaG5d65ARt1W2MhJLGW9VUVof0Bg0qz3pSLfAS7KIsfh?=
 =?us-ascii?Q?grqwq+gxzl4erNxXXhnV3zqbBXzXfFVVIFhPxE9gkXoCxEoKSKQ4mMc2wvXv?=
 =?us-ascii?Q?XQWyCx/qawTNlG17JvOE0BzzHdcNomVHvGKU+JEVhUlX5TwWX5znXyg3gZnS?=
 =?us-ascii?Q?GFMc8Wy2/mAb5PqZWBOINlH1b/8IpP+uqJhcUUN82+1o5TxxR0D4bfM5Xh9F?=
 =?us-ascii?Q?dldrK2fzRx6Ini0xLkMEQtWSh2nGw54jEBqyfFVPrUzOlipplw50oCZgijvu?=
 =?us-ascii?Q?DudV+nfDx8C9VftxV6Z6nxuXnLdPYl5d9D+54aGmvEFFBZbb1/Vr4Eo2SbE3?=
 =?us-ascii?Q?rnmrXNP1ogOIM3zrKaRWMXyTvnltFdmx2tK7lbRXVQSWi1ii7bbozmYXB5Jz?=
 =?us-ascii?Q?pQ6+Um41YU/imU2ySqQQtWuM4FgdliitdXV+W4znKMN4BU/D8aJCldXsz95T?=
 =?us-ascii?Q?PTTVqGPHZ/BsIkUCZ9X21+J0qDep/OVMFtz1jdINkb+zU7HWygMs155BTNKl?=
 =?us-ascii?Q?qqc/QrkXqY0tlz6D0Q2LC4UXq8GrEMx4n/6J0m/YyDdSRFZMdPRDWIymnTlo?=
 =?us-ascii?Q?TzjuovuGy3qt8U8/9HYxIDghrX532nePv5lXgwbgdZqrq6o67RuiL5RMiJ7U?=
 =?us-ascii?Q?CRwY4aBO8VN72tnFyIxUzTkTATVqGCNaX+7sAmoyILESTVmT1R8d+xcFgD7F?=
 =?us-ascii?Q?z9FeqVzvxkf0KMhRaobogjY4nKgTLkHKgoFmBPG9B9eXUD050Upej1WEDcRT?=
 =?us-ascii?Q?dgvn5jrjJgVSoLcKavebcXAyTpdNYeZDhs8Gwv553i2Innfi1QDr/ZWXkHqu?=
 =?us-ascii?Q?jyE6UmW4UFC/wkgXdyiHeVdBC3xMdwMgIR3xyiqU78ijXWtjImPRwkRmt/VP?=
 =?us-ascii?Q?OcVpgfsw+TOjW4TY5yJzrKGcNnqCH6rIbKIlwKRe9WxrpDvYDabOI3dSn05A?=
 =?us-ascii?Q?+5fmxbYhnOkdtwRa5BgYtYx6bgQQjItKPGd7sorwoe6kxxQjVUx+sslkQihB?=
 =?us-ascii?Q?L4T0f0aI5ffaf7R9ci1m5+8HjpR3jodI4DCJ5Udm9kesQFhJoiXUMAD0Hg//?=
 =?us-ascii?Q?J+h90JKUq3HoOBzuG68YdDHCmDUNK7lKrXlkUjaKvSd14XZOl7Sye5YK0mLk?=
 =?us-ascii?Q?kUUYhXULXTAi0b7UPo9YLybKpIBsIsPmUa+RidpNacuoEIK2WVVIZ+tigVgW?=
 =?us-ascii?Q?s4uqAMdPCCho52Wun96YTgRaF9hE5ZjmoPe2EQiJVQ4WvFc8RtWkvKZgy1uy?=
 =?us-ascii?Q?ySFE5U2t8B4kcOOZb3yHYJ+D+Jzm5EJhEPabi8ce8q5JKOIyjyacRkjHjriq?=
 =?us-ascii?Q?ZJtuIvnu/2o8I8UEiYAhmgHH0N+RAxLaCjFvMhqkvnN9b6R8J43GIjJU3AqA?=
 =?us-ascii?Q?f5GRKFrkz8J75ywseEb8vyX7+XONGz1uRabIoi/sDRurTI+G2asDoG/hdKU9?=
 =?us-ascii?Q?yie4hT/2jTyKTrgMZbXfY8ZgHV1cfogAPOVB6plrhlznulU0SETSBhwH21lu?=
 =?us-ascii?Q?Jrw5B6J2Jwf+hBt96usH0NmS2/aGZh3xpErQPlraKsx0549za2BVT7hGqOrZ?=
 =?us-ascii?Q?pNjitVvaIAm/NYmF/F+3+cCHYA+xcy7iwVlM7EXrrcYtXNHBPUgQ/732UIzb?=
 =?us-ascii?Q?O55w9NgWcRG3WmdYIqUX9Uci5MK7fqHdNZa31r8pcireMqd0UAGJ1pjuga9j?=
 =?us-ascii?Q?gSfXuy+ka+ywmPtu5g4StYrDOuzR0wo=3D?=
X-Exchange-RoutingPolicyChecked: MXdl99a86yoq7pd+tFMKMZPTxyxPdGajxuOv1nXwUUteUqc4MzxiHxoTHzXgL3Ng0VVdQG7VwYw8RAfJXmMm3594zuiK0h/xZmQKHRQXpHIE7LS3v+dFQ0vKk28tSrztuQzCy/5g8J7jHIfYTxKIEmoS1wf89KzZx5CTIgzFo2bMC42rw/0e0f7NsA1pA7Nt5bixdFdXJANMMnwx1i9KDN985HsIK4mGnDWx6lIGBi8i+nlducGmKLCw5uyr0YBb2XKTY2a905bz6g6fPDsaGwPTq2xQeoxXJm1sZON3o6xDsk33FB2ULMDza0Wp1qu5uHbeofnaI/JrfkLtxyTRlw==
X-MS-Exchange-CrossTenant-Network-Message-Id: a52652fc-15b6-4571-db32-08df253100e6
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 11:40:51.2407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xAMVRnicXVJbsL7gggtfC1YZsuoJWb3x6Y3qO/iObMwi+TnMohAMqyUBjzj7WwkjmC01PhZmnj9c/vWGuk4eSPjcHVjd3hRWTAXcpruPW/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB045191
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

On Fri, Sep 18, 2026 at 05:03:52PM -0400, Sandeep Penigalapati wrote:
> The ice PMD only supported Rx hardware timestamp offload
> (RTE_ETH_RX_OFFLOAD_TIMESTAMP) on the scalar Rx path. Enabling the
> offload forced a fallback from the AVX2/AVX512 vector Rx paths to the
> scalar path, causing a significant performance drop on 800 series
> adapters.
> 
> Add Rx timestamp support to the AVX2 and AVX512 vector Rx paths,
> mirroring the existing iavf implementation: the 32-bit timestamp is
> read from the flex descriptor in the vectorized loop and converted to
> 64 bits, with register rollover tracking, in a scalar pass over the
> received packets after the loop.
> 
> Advertise the timestamp offload only on the x86 vector paths that
> implement it, via a new ICE_RX_VECTOR_OFFLOAD_TS_OFFLOADS mask, so on
> Arm the request still falls back to the scalar path.
> 
> Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
> ---

Patch looks ok to me, and AI review finds no issues. I've flagged a couple
of minor things below.

Main concern is performance. What's the performance difference - if any -
measured on this Rx path with this change compared to without?

>  doc/guides/nics/features/ice.ini            |   2 +-
>  doc/guides/rel_notes/release_26_11.rst      |   5 +
>  drivers/net/intel/ice/ice_rxtx.c            |   8 +-
>  drivers/net/intel/ice/ice_rxtx.h            |   4 +
>  drivers/net/intel/ice/ice_rxtx_vec_avx2.c   | 158 +++++++++++++++-----
>  drivers/net/intel/ice/ice_rxtx_vec_avx512.c | 158 +++++++++++++++-----
>  6 files changed, 262 insertions(+), 73 deletions(-)
> 
> diff --git a/doc/guides/nics/features/ice.ini b/doc/guides/nics/features/ice.ini
> index 893d09e9ec..0ff4af19e0 100644
> --- a/doc/guides/nics/features/ice.ini
> +++ b/doc/guides/nics/features/ice.ini
> @@ -36,7 +36,7 @@ VLAN offload         = Y
>  QinQ offload         = P
>  L3 checksum offload  = Y
>  L4 checksum offload  = Y
> -Timestamp offload    = P
> +Timestamp offload    = Y
>  Inner L3 checksum    = P
>  Inner L4 checksum    = P
>  Packet type parsing  = Y
> diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
> index 4b3e5d995c..bc5faa5182 100644
> --- a/doc/guides/rel_notes/release_26_11.rst
> +++ b/doc/guides/rel_notes/release_26_11.rst
> @@ -56,6 +56,11 @@ New Features
>       =======================================================
>  
>  
> +* **Updated Intel ice driver.**
> +
> +  Added support for the Rx hardware timestamp offload
> +  (``RTE_ETH_RX_OFFLOAD_TIMESTAMP``) in the AVX2 and AVX512 vector Rx paths.
> +

Patch needs a rebase, there is already a section in release notes for ice
driver updates, and the ice.ini file has conflicting updates too (though
both these are easy fixes)

>  Removed Items
>  -------------
>  
> diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
> index c4b5454c53..2a81b998dc 100644
> --- a/drivers/net/intel/ice/ice_rxtx.c
> +++ b/drivers/net/intel/ice/ice_rxtx.c
> @@ -3303,7 +3303,7 @@ static const struct ci_rx_path_info ice_rx_path_infos[] = {
>  		.pkt_burst = ice_recv_pkts_vec_avx2_offload,
>  		.info = "Offload Vector AVX2",
>  		.features = {
> -			.rx_offloads = ICE_RX_VECTOR_OFFLOAD_OFFLOADS,
> +			.rx_offloads = ICE_RX_VECTOR_OFFLOAD_TS_OFFLOADS,
>  			.simd_width = RTE_VECT_SIMD_256,
>  			.bulk_alloc = true
>  		}
> @@ -3312,7 +3312,7 @@ static const struct ci_rx_path_info ice_rx_path_infos[] = {
>  		.pkt_burst = ice_recv_scattered_pkts_vec_avx2_offload,
>  		.info = "Offload Vector AVX2 Scattered",
>  		.features = {
> -			.rx_offloads = ICE_RX_VECTOR_OFFLOAD_OFFLOADS,
> +			.rx_offloads = ICE_RX_VECTOR_OFFLOAD_TS_OFFLOADS,
>  			.simd_width = RTE_VECT_SIMD_256,
>  			.scattered = true,
>  			.bulk_alloc = true
> @@ -3342,7 +3342,7 @@ static const struct ci_rx_path_info ice_rx_path_infos[] = {
>  		.pkt_burst = ice_recv_pkts_vec_avx512_offload,
>  		.info = "Offload Vector AVX512",
>  		.features = {
> -			.rx_offloads = ICE_RX_VECTOR_OFFLOAD_OFFLOADS,
> +			.rx_offloads = ICE_RX_VECTOR_OFFLOAD_TS_OFFLOADS,
>  			.simd_width = RTE_VECT_SIMD_512,
>  			.bulk_alloc = true
>  		}
> @@ -3351,7 +3351,7 @@ static const struct ci_rx_path_info ice_rx_path_infos[] = {
>  		.pkt_burst = ice_recv_scattered_pkts_vec_avx512_offload,
>  		.info = "Offload Vector AVX512 Scattered",
>  		.features = {
> -			.rx_offloads = ICE_RX_VECTOR_OFFLOAD_OFFLOADS,
> +			.rx_offloads = ICE_RX_VECTOR_OFFLOAD_TS_OFFLOADS,
>  			.simd_width = RTE_VECT_SIMD_512,
>  			.scattered = true,
>  			.bulk_alloc = true
> diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice_rxtx.h
> index 999b6b30d6..1ac57c23a4 100644
> --- a/drivers/net/intel/ice/ice_rxtx.h
> +++ b/drivers/net/intel/ice/ice_rxtx.h
> @@ -105,6 +105,10 @@
>  		RTE_ETH_RX_OFFLOAD_VLAN_STRIP |	\
>  		RTE_ETH_RX_OFFLOAD_VLAN_FILTER |\
>  		RTE_ETH_RX_OFFLOAD_RSS_HASH)
> +/* vector offload paths that also support Rx timestamp (AVX2/AVX512 only) */
> +#define ICE_RX_VECTOR_OFFLOAD_TS_OFFLOADS (	\
> +		ICE_RX_VECTOR_OFFLOAD_OFFLOADS |\
> +		RTE_ETH_RX_OFFLOAD_TIMESTAMP)
>  
>  /* basic scalar path */
>  #define ICE_TX_SCALAR_OFFLOADS (		\
> diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
> index b72f69a47b..a316eae43b 100644
> --- a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
> +++ b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
> @@ -7,6 +7,7 @@
>  #include "../common/rx_vec_x86.h"
>  
>  #include <rte_vect.h>
> +#include <rte_mbuf_dyn.h>
>  
>  static __rte_always_inline void
>  ice_rxq_rearm(struct ci_rx_queue *rxq)
> @@ -440,12 +441,16 @@ _ice_recv_raw_pkts_vec_avx2(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
>  
>  		if (offload) {
>  #ifndef RTE_NET_INTEL_USE_16BYTE_DESC
> +			const uint64_t rxmode_offloads =
> +				rxq->ice_vsi->adapter->pf.dev_data->dev_conf.rxmode.offloads;
>  			/**
> -			 * needs to load 2nd 16B of each desc for RSS hash parsing,
> +			 * needs to load 2nd 16B of each desc for RSS hash parsing
> +			 * or Rx timestamp offload,
>  			 * will cause performance drop to get into this context.
>  			 */
> -			if (rxq->ice_vsi->adapter->pf.dev_data->dev_conf.rxmode.offloads &
> -					RTE_ETH_RX_OFFLOAD_RSS_HASH) {
> +			if (rxmode_offloads &
> +					(RTE_ETH_RX_OFFLOAD_RSS_HASH |
> +					 RTE_ETH_RX_OFFLOAD_TIMESTAMP)) {

Nit: I'd try to keep this on two lines rather than 3.

>  				/* load bottom half of every 32B desc */
>  				const __m128i raw_desc_bh7 = _mm_load_si128
>  					(RTE_CAST_PTR(const __m128i *, &rxdp[7].wb.status_error1));
> @@ -488,37 +493,77 @@ _ice_recv_raw_pkts_vec_avx2(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
>  						(_mm256_castsi128_si256(raw_desc_bh0),
>  						raw_desc_bh1, 1);
>  
> -				/**
> -				 * to shift the 32b RSS hash value to the
> -				 * highest 32b of each 128b before mask
> -				 */
> -				__m256i rss_hash6_7 =
> -					_mm256_slli_epi64(raw_desc_bh6_7, 32);
> -				__m256i rss_hash4_5 =
> -					_mm256_slli_epi64(raw_desc_bh4_5, 32);
> -				__m256i rss_hash2_3 =
> -					_mm256_slli_epi64(raw_desc_bh2_3, 32);
> -				__m256i rss_hash0_1 =
> -					_mm256_slli_epi64(raw_desc_bh0_1, 32);
> -
> -				__m256i rss_hash_msk =
> -					_mm256_set_epi32(0xFFFFFFFF, 0, 0, 0,
> -							 0xFFFFFFFF, 0, 0, 0);
> -
> -				rss_hash6_7 = _mm256_and_si256
> -						(rss_hash6_7, rss_hash_msk);
> -				rss_hash4_5 = _mm256_and_si256
> -						(rss_hash4_5, rss_hash_msk);
> -				rss_hash2_3 = _mm256_and_si256
> -						(rss_hash2_3, rss_hash_msk);
> -				rss_hash0_1 = _mm256_and_si256
> -						(rss_hash0_1, rss_hash_msk);
> -
> -				mb6_7 = _mm256_or_si256(mb6_7, rss_hash6_7);
> -				mb4_5 = _mm256_or_si256(mb4_5, rss_hash4_5);
> -				mb2_3 = _mm256_or_si256(mb2_3, rss_hash2_3);
> -				mb0_1 = _mm256_or_si256(mb0_1, rss_hash0_1);
> -			} /* if() on RSS hash parsing */
> +				if (rxmode_offloads & RTE_ETH_RX_OFFLOAD_RSS_HASH) {
> +					/**
> +					 * to shift the 32b RSS hash value to the
> +					 * highest 32b of each 128b before mask
> +					 */
> +					__m256i rss_hash6_7 =
> +						_mm256_slli_epi64(raw_desc_bh6_7, 32);
> +					__m256i rss_hash4_5 =
> +						_mm256_slli_epi64(raw_desc_bh4_5, 32);
> +					__m256i rss_hash2_3 =
> +						_mm256_slli_epi64(raw_desc_bh2_3, 32);
> +					__m256i rss_hash0_1 =
> +						_mm256_slli_epi64(raw_desc_bh0_1, 32);
> +
> +					__m256i rss_hash_msk =
> +						_mm256_set_epi32(0xFFFFFFFF, 0, 0, 0,
> +								 0xFFFFFFFF, 0, 0, 0);
> +
> +					rss_hash6_7 = _mm256_and_si256
> +							(rss_hash6_7, rss_hash_msk);
> +					rss_hash4_5 = _mm256_and_si256
> +							(rss_hash4_5, rss_hash_msk);
> +					rss_hash2_3 = _mm256_and_si256
> +							(rss_hash2_3, rss_hash_msk);
> +					rss_hash0_1 = _mm256_and_si256
> +							(rss_hash0_1, rss_hash_msk);
> +
> +					mb6_7 = _mm256_or_si256(mb6_7, rss_hash6_7);
> +					mb4_5 = _mm256_or_si256(mb4_5, rss_hash4_5);
> +					mb2_3 = _mm256_or_si256(mb2_3, rss_hash2_3);
> +					mb0_1 = _mm256_or_si256(mb0_1, rss_hash0_1);
> +				} /* if() on RSS hash parsing */
> +
> +				if (rxmode_offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) {
> +					/**
> +					 * Extract the 32b Rx timestamp (flex_ts.ts_high),
> +					 * located in the highest 32b of each 32B desc, and
> +					 * stash it (low 32b) into the mbuf timestamp
> +					 * dynfield. The 32b->64b conversion with rollover
> +					 * tracking is performed in a scalar pass after the
> +					 * main loop (see below), matching the scalar path.
> +					 */
> +					*RTE_MBUF_DYNFIELD(rx_pkts[i + 0],
> +						rxq->ts_offset, uint32_t *) =
> +						_mm256_extract_epi32(raw_desc_bh0_1, 3);
> +					*RTE_MBUF_DYNFIELD(rx_pkts[i + 1],
> +						rxq->ts_offset, uint32_t *) =
> +						_mm256_extract_epi32(raw_desc_bh0_1, 7);
> +					*RTE_MBUF_DYNFIELD(rx_pkts[i + 2],
> +						rxq->ts_offset, uint32_t *) =
> +						_mm256_extract_epi32(raw_desc_bh2_3, 3);
> +					*RTE_MBUF_DYNFIELD(rx_pkts[i + 3],
> +						rxq->ts_offset, uint32_t *) =
> +						_mm256_extract_epi32(raw_desc_bh2_3, 7);
> +					*RTE_MBUF_DYNFIELD(rx_pkts[i + 4],
> +						rxq->ts_offset, uint32_t *) =
> +						_mm256_extract_epi32(raw_desc_bh4_5, 3);
> +					*RTE_MBUF_DYNFIELD(rx_pkts[i + 5],
> +						rxq->ts_offset, uint32_t *) =
> +						_mm256_extract_epi32(raw_desc_bh4_5, 7);
> +					*RTE_MBUF_DYNFIELD(rx_pkts[i + 6],
> +						rxq->ts_offset, uint32_t *) =
> +						_mm256_extract_epi32(raw_desc_bh6_7, 3);
> +					*RTE_MBUF_DYNFIELD(rx_pkts[i + 7],
> +						rxq->ts_offset, uint32_t *) =
> +						_mm256_extract_epi32(raw_desc_bh6_7, 7);
> +
> +					mbuf_flags = _mm256_or_si256(mbuf_flags,
> +						_mm256_set1_epi32((int)rxq->ts_flag));
> +				} /* if() on Rx timestamp parsing */
> +			} /* if() on RSS hash or Rx timestamp parsing */
>  #endif
>  		}
>  
> @@ -653,6 +698,51 @@ _ice_recv_raw_pkts_vec_avx2(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
>  			break;
>  	}
>  
> +#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
> +	/**
> +	 * Convert the stashed 32b Rx timestamps to 64b for the packets that
> +	 * were actually received, tracking the register rollover. This mirrors
> +	 * the scalar Rx path and is only done over valid (received) packets, so
> +	 * timestamps of non-DD descriptors never corrupt the rollover state.
> +	 */
> +	if (offload && received > 0 &&
> +			(rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP)) {
> +		struct ice_vsi *vsi = rxq->ice_vsi;
> +		struct ice_hw *hw = ICE_VSI_TO_HW(vsi);
> +		struct ice_adapter *ad = vsi->adapter;
> +		uint64_t ts_ns;
> +		bool is_tsinit = false;
> +		uint64_t sw_cur_time =
> +			rte_get_timer_cycles() / (rte_get_timer_hz() / 1000);
> +
> +		if (unlikely(sw_cur_time - rxq->hw_time_update > 4))
> +			is_tsinit = true;
> +
> +		for (uint16_t k = 0; k < received; k++) {
> +			uint32_t ts_high = *RTE_MBUF_DYNFIELD(rx_pkts[k],
> +					rxq->ts_offset, uint32_t *);
> +
> +			rxq->time_high = ts_high;
> +			if (unlikely(is_tsinit)) {
> +				ts_ns = ice_tstamp_convert_32b_64b(hw, ad, 1,
> +								   ts_high);
> +				rxq->hw_time_low = (uint32_t)ts_ns;
> +				rxq->hw_time_high = (uint32_t)(ts_ns >> 32);
> +				is_tsinit = false;
> +			} else {
> +				if (ts_high < rxq->hw_time_low)
> +					rxq->hw_time_high += 1;
> +				ts_ns = (uint64_t)rxq->hw_time_high << 32 | ts_high;
> +				rxq->hw_time_low = ts_high;
> +			}
> +			*RTE_MBUF_DYNFIELD(rx_pkts[k], rxq->ts_offset,
> +					   rte_mbuf_timestamp_t *) = ts_ns;
> +		}
> +		rxq->hw_time_update = rte_get_timer_cycles() /
> +				      (rte_get_timer_hz() / 1000);
> +	}
> +#endif
> +
>  	/* update tail pointers */
>  	rxq->rx_tail += received;
>  	rxq->rx_tail &= (rxq->nb_rx_desc - 1);
> diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
> index 309ab9fca7..1ebfc064f4 100644
> --- a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
> +++ b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
> @@ -7,6 +7,7 @@
>  #include "../common/rx_vec_x86.h"
>  
>  #include <rte_vect.h>
> +#include <rte_mbuf_dyn.h>
>  
>  static __rte_always_inline void
>  ice_rxq_rearm(struct ci_rx_queue *rxq)
> @@ -462,12 +463,16 @@ _ice_recv_raw_pkts_vec_avx512(struct ci_rx_queue *rxq,
>  
>  		if (do_offload) {
>  #ifndef RTE_NET_INTEL_USE_16BYTE_DESC
> +			const uint64_t rxmode_offloads =
> +				rxq->ice_vsi->adapter->pf.dev_data->dev_conf.rxmode.offloads;
>  			/**
> -			 * needs to load 2nd 16B of each desc for RSS hash parsing,
> +			 * needs to load 2nd 16B of each desc for RSS hash parsing
> +			 * or Rx timestamp offload,
>  			 * will cause performance drop to get into this context.
>  			 */
> -			if (rxq->ice_vsi->adapter->pf.dev_data->dev_conf.rxmode.offloads &
> -					RTE_ETH_RX_OFFLOAD_RSS_HASH) {
> +			if (rxmode_offloads &
> +					(RTE_ETH_RX_OFFLOAD_RSS_HASH |
> +					 RTE_ETH_RX_OFFLOAD_TIMESTAMP)) {
>  				/* load bottom half of every 32B desc */
>  				const __m128i raw_desc_bh7 = _mm_load_si128
>  					(RTE_CAST_PTR(const __m128i *, &rxdp[7].wb.status_error1));
> @@ -510,37 +515,77 @@ _ice_recv_raw_pkts_vec_avx512(struct ci_rx_queue *rxq,
>  						(_mm256_castsi128_si256(raw_desc_bh0),
>  						raw_desc_bh1, 1);
>  
> -				/**
> -				 * to shift the 32b RSS hash value to the
> -				 * highest 32b of each 128b before mask
> -				 */
> -				__m256i rss_hash6_7 =
> -					_mm256_slli_epi64(raw_desc_bh6_7, 32);
> -				__m256i rss_hash4_5 =
> -					_mm256_slli_epi64(raw_desc_bh4_5, 32);
> -				__m256i rss_hash2_3 =
> -					_mm256_slli_epi64(raw_desc_bh2_3, 32);
> -				__m256i rss_hash0_1 =
> -					_mm256_slli_epi64(raw_desc_bh0_1, 32);
> -
> -				__m256i rss_hash_msk =
> -					_mm256_set_epi32(0xFFFFFFFF, 0, 0, 0,
> -							 0xFFFFFFFF, 0, 0, 0);
> -
> -				rss_hash6_7 = _mm256_and_si256
> -						(rss_hash6_7, rss_hash_msk);
> -				rss_hash4_5 = _mm256_and_si256
> -						(rss_hash4_5, rss_hash_msk);
> -				rss_hash2_3 = _mm256_and_si256
> -						(rss_hash2_3, rss_hash_msk);
> -				rss_hash0_1 = _mm256_and_si256
> -						(rss_hash0_1, rss_hash_msk);
> -
> -				mb6_7 = _mm256_or_si256(mb6_7, rss_hash6_7);
> -				mb4_5 = _mm256_or_si256(mb4_5, rss_hash4_5);
> -				mb2_3 = _mm256_or_si256(mb2_3, rss_hash2_3);
> -				mb0_1 = _mm256_or_si256(mb0_1, rss_hash0_1);
> -			} /* if() on RSS hash parsing */
> +				if (rxmode_offloads & RTE_ETH_RX_OFFLOAD_RSS_HASH) {
> +					/**
> +					 * to shift the 32b RSS hash value to the
> +					 * highest 32b of each 128b before mask
> +					 */
> +					__m256i rss_hash6_7 =
> +						_mm256_slli_epi64(raw_desc_bh6_7, 32);
> +					__m256i rss_hash4_5 =
> +						_mm256_slli_epi64(raw_desc_bh4_5, 32);
> +					__m256i rss_hash2_3 =
> +						_mm256_slli_epi64(raw_desc_bh2_3, 32);
> +					__m256i rss_hash0_1 =
> +						_mm256_slli_epi64(raw_desc_bh0_1, 32);
> +
> +					__m256i rss_hash_msk =
> +						_mm256_set_epi32(0xFFFFFFFF, 0, 0, 0,
> +								 0xFFFFFFFF, 0, 0, 0);
> +
> +					rss_hash6_7 = _mm256_and_si256
> +							(rss_hash6_7, rss_hash_msk);
> +					rss_hash4_5 = _mm256_and_si256
> +							(rss_hash4_5, rss_hash_msk);
> +					rss_hash2_3 = _mm256_and_si256
> +							(rss_hash2_3, rss_hash_msk);
> +					rss_hash0_1 = _mm256_and_si256
> +							(rss_hash0_1, rss_hash_msk);
> +
> +					mb6_7 = _mm256_or_si256(mb6_7, rss_hash6_7);
> +					mb4_5 = _mm256_or_si256(mb4_5, rss_hash4_5);
> +					mb2_3 = _mm256_or_si256(mb2_3, rss_hash2_3);
> +					mb0_1 = _mm256_or_si256(mb0_1, rss_hash0_1);
> +				} /* if() on RSS hash parsing */
> +
> +				if (rxmode_offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) {
> +					/**
> +					 * Extract the 32b Rx timestamp (flex_ts.ts_high),
> +					 * located in the highest 32b of each 32B desc, and
> +					 * stash it (low 32b) into the mbuf timestamp
> +					 * dynfield. The 32b->64b conversion with rollover
> +					 * tracking is performed in a scalar pass after the
> +					 * main loop (see below), matching the scalar path.
> +					 */
> +					*RTE_MBUF_DYNFIELD(rx_pkts[i + 0],
> +						rxq->ts_offset, uint32_t *) =
> +						_mm256_extract_epi32(raw_desc_bh0_1, 3);
> +					*RTE_MBUF_DYNFIELD(rx_pkts[i + 1],
> +						rxq->ts_offset, uint32_t *) =
> +						_mm256_extract_epi32(raw_desc_bh0_1, 7);
> +					*RTE_MBUF_DYNFIELD(rx_pkts[i + 2],
> +						rxq->ts_offset, uint32_t *) =
> +						_mm256_extract_epi32(raw_desc_bh2_3, 3);
> +					*RTE_MBUF_DYNFIELD(rx_pkts[i + 3],
> +						rxq->ts_offset, uint32_t *) =
> +						_mm256_extract_epi32(raw_desc_bh2_3, 7);
> +					*RTE_MBUF_DYNFIELD(rx_pkts[i + 4],
> +						rxq->ts_offset, uint32_t *) =
> +						_mm256_extract_epi32(raw_desc_bh4_5, 3);
> +					*RTE_MBUF_DYNFIELD(rx_pkts[i + 5],
> +						rxq->ts_offset, uint32_t *) =
> +						_mm256_extract_epi32(raw_desc_bh4_5, 7);
> +					*RTE_MBUF_DYNFIELD(rx_pkts[i + 6],
> +						rxq->ts_offset, uint32_t *) =
> +						_mm256_extract_epi32(raw_desc_bh6_7, 3);
> +					*RTE_MBUF_DYNFIELD(rx_pkts[i + 7],
> +						rxq->ts_offset, uint32_t *) =
> +						_mm256_extract_epi32(raw_desc_bh6_7, 7);
> +
> +					mbuf_flags = _mm256_or_si256(mbuf_flags,
> +						_mm256_set1_epi32((int)rxq->ts_flag));
> +				} /* if() on Rx timestamp parsing */
> +			} /* if() on RSS hash or Rx timestamp parsing */
>  #endif
>  		}
>  
> @@ -679,6 +724,51 @@ _ice_recv_raw_pkts_vec_avx512(struct ci_rx_queue *rxq,
>  			break;
>  	}
>  
> +#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
> +	/**
> +	 * Convert the stashed 32b Rx timestamps to 64b for the packets that
> +	 * were actually received, tracking the register rollover. This mirrors
> +	 * the scalar Rx path and is only done over valid (received) packets, so
> +	 * timestamps of non-DD descriptors never corrupt the rollover state.
> +	 */
> +	if (do_offload && received > 0 &&
> +			(rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP)) {
> +		struct ice_vsi *vsi = rxq->ice_vsi;
> +		struct ice_hw *hw = ICE_VSI_TO_HW(vsi);
> +		struct ice_adapter *ad = vsi->adapter;
> +		uint64_t ts_ns;
> +		bool is_tsinit = false;
> +		uint64_t sw_cur_time =
> +			rte_get_timer_cycles() / (rte_get_timer_hz() / 1000);
> +
> +		if (unlikely(sw_cur_time - rxq->hw_time_update > 4))
> +			is_tsinit = true;
> +
> +		for (uint16_t k = 0; k < received; k++) {
> +			uint32_t ts_high = *RTE_MBUF_DYNFIELD(rx_pkts[k],
> +					rxq->ts_offset, uint32_t *);
> +
> +			rxq->time_high = ts_high;
> +			if (unlikely(is_tsinit)) {
> +				ts_ns = ice_tstamp_convert_32b_64b(hw, ad, 1,
> +								   ts_high);
> +				rxq->hw_time_low = (uint32_t)ts_ns;
> +				rxq->hw_time_high = (uint32_t)(ts_ns >> 32);
> +				is_tsinit = false;
> +			} else {
> +				if (ts_high < rxq->hw_time_low)
> +					rxq->hw_time_high += 1;
> +				ts_ns = (uint64_t)rxq->hw_time_high << 32 | ts_high;
> +				rxq->hw_time_low = ts_high;
> +			}
> +			*RTE_MBUF_DYNFIELD(rx_pkts[k], rxq->ts_offset,
> +					   rte_mbuf_timestamp_t *) = ts_ns;
> +		}
> +		rxq->hw_time_update = rte_get_timer_cycles() /
> +				      (rte_get_timer_hz() / 1000);
> +	}
> +#endif
> +
>  	/* update tail pointers */
>  	rxq->rx_tail += received;
>  	rxq->rx_tail &= (rxq->nb_rx_desc - 1);
> -- 
> 2.27.0
> 
