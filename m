Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF02C87FD2
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 12:31:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5D124042E;
	Mon, 11 Aug 2025 14:31:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 90E814013F;
 Mon, 11 Aug 2025 14:31:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754915505; x=1786451505;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=B5YIFJuD+w9fZ331DJ0yQQxipvuchKpONCejQuFPJZ4=;
 b=GK7Iehz+Lca3zrYTtUDyoLE2cLYKPnGKJ6FHU27/NvVcOAdW0yfwPtKS
 hDBYmCABDousnvW5r/+HO0J8IcrHgasE5etZpq0F5LQznOzLk0/csGPXW
 GbA5l2j+TBQ3595RjGhaoUzMDA1Kj+YnyinLKrLOPq+vwPzFmhyBe46SP
 G3VrhSnIgB5OHE+r2/ncQlwT427G3meoAqd2yqQVH7iYdPoYjayvKWvnp
 VedMWNQRCX5MNrjrQGVUKHLMB4xi/gt2kA8gwagLPqr93o5B4PMREdF/6
 FlXCkAlQFwXF9+FmNfqESY1OeMDZKzxdVXPKFtQRxmIal7m9+H7MGgrdH A==;
X-CSE-ConnectionGUID: wrzEtDIrSEW8VKYj7RFubg==
X-CSE-MsgGUID: E3uYrbOAR7Cn6etjSxC1/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="82605387"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; d="scan'208";a="82605387"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2025 05:31:33 -0700
X-CSE-ConnectionGUID: cArKPuVsR/W/CY0tZZvIxg==
X-CSE-MsgGUID: 4J18wm4OSKOK9iAEStQmoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; d="scan'208";a="171255276"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2025 05:31:33 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 05:31:32 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 11 Aug 2025 05:31:32 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.67)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 05:30:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RaqMyqC4cDSPZ5zr0iKH41xyPPJFrw6oqXDhBlGr50CPzcqaYkkpKoi++vo3Ntz4zxPwgcRFKImzz/Emfnu+XJSTQDwWcjfFPnxt9NFbd1UqMPp2emVwfpLJ8lnRf98NOp7Z5EYKnSPIdUJVDgj6dFyB6/JWOU3CgcZszfHmSkW8EUAz8JT9cVHMbm1PY3eFFmarQtY45GK7I98DAEnnprJ+HaB8v/0Gykzmvc9BOb99k3TrzfZ+VYUsdAxgoJFBY4mDYEjAUj7Qfgu3EqY+1KdXLCSF2PVjsdDJ8xXPpoG6fV4g1+27QNVupGpwoSS4kpc7z5XFRS+w0sMgZmKv9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkfZ35/WyM918P4LkIEdDsUAXYy4yyznlSNcYnV+iAs=;
 b=wGGd+vgw97kja/kzLFmUoooLSxDp6qZWwvPS9z66vuSF2xzu2b4QkrIHqiKg0jOTYIeqSyvsu5buTOGgr3pErga5VIzhiQ2bhEnne59qV8r5tECnzuz1UlZdaFVNPx2uGPK7t2y4MOm6uXsvRa6QJIY/L7/Yc0FzrLXecBFo6X8GmocnpcbbnfaRm7g156cUwve0qXf3LyCeaj1FbXKzmTWVFPElweesqb5SiFeAMryARmS/SLaZth+udpR2tMyw6bVRF5wYXkd/k7F3ky3+oEGLTt0zGJUAteFThbsYh2VZfcl/c4Y/cIVT4GiMtaQCQ1rSep/8NS/Bbjs9tboUPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB7865.namprd11.prod.outlook.com (2603:10b6:610:128::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Mon, 11 Aug
 2025 12:30:55 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 12:30:55 +0000
Date: Mon, 11 Aug 2025 13:30:50 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Yuan Wang <yuanx.wang@intel.com>
CC: <anatoly.burakov@intel.com>, <vladimir.medvedkin@intel.com>,
 <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] net/ixgbe: fix port mask default value on E610
Message-ID: <aJniegZL1dok1nk0@bricha3-mobl1.ger.corp.intel.com>
References: <20250718090907.649202-1-yuanx.wang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250718090907.649202-1-yuanx.wang@intel.com>
X-ClientProxiedBy: DUZPR01CA0156.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB7865:EE_
X-MS-Office365-Filtering-Correlation-Id: 679cbc3e-e3de-4afc-160b-08ddd8d2eace
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R65SJ7Xs00lcbICh/KfzxrsIF35FCu2p4Tfpqoe4ZOE8GIE7ZmObUNRFq0Lh?=
 =?us-ascii?Q?qWEbtowcfNdkHywbFavEvDxTJ6OM1j5V4nIPEvJDtLT5L2GpZoJ+2TMiOKwJ?=
 =?us-ascii?Q?lls4UTbuE8S4U+uzJeF5ST+1xUYREk/NkSccNrNfj8yPhsSLEwfpvsTIFeLc?=
 =?us-ascii?Q?gxZn+CYIvSoZqk9u7Ie3g2xIaAZYXBsWQZDpcTjL5c3SnTROSCg3gfAJcsej?=
 =?us-ascii?Q?NVmhDymVXnjQdzpNqXhjdCDAcjhjgwoGLPDmKv9sHh+9Ef7U9PYBgUoha3Y/?=
 =?us-ascii?Q?hCkpn53lx4+ChEeZYbY67PqlQisEDoMjqh7eZU7sqgn49+2dhdfg+ajCo4+V?=
 =?us-ascii?Q?wmimpzWCw3jFXEV3LsvT0zBafsFkCX9MPMMk5uIMRTg9ZqlTkXhVFgFhxLYZ?=
 =?us-ascii?Q?z3oEuQpf17ZdFZbv5R+AMUJlxfKLqV0J+MLGBtWJCiVeHhBEm1IeEEo655cU?=
 =?us-ascii?Q?8X6H/wDka3XvNBpB/U9bbyU5ZxpttfmOCV6grEe89FEByDmFk02I5TmN8E6X?=
 =?us-ascii?Q?xIGoqzpat5JotjaOd7JxwTSJ7NOgZELbHnbEF5k+W+W++Uyp3ucIlRiCwt5n?=
 =?us-ascii?Q?EQvk6KsblUc9aAuK3Hr2KZsKHnPAx/6PJnNOXn+59Jz/ebwEUPqgUpVxZMlc?=
 =?us-ascii?Q?QfrPuOYwYxo0E0qGHYc8kx9++tQiEqvKHH9sF01FSbqDRz67UVQGrNNVTnnU?=
 =?us-ascii?Q?ob4qt/2YEVEmVhC8h61Tj//cGFEQ1slqzUhBeOKxZ6+g4Nioz0FoQqZgY56k?=
 =?us-ascii?Q?jnJqV4WQlIQlRleBmDrcoycKNCfmyS7cY5fyLDBAT25YNR2q+tOQUByZH2Ye?=
 =?us-ascii?Q?XXoqlgL/INDTTENiij/SkUPs6ibxEjb8nK7tDWrRosDGOy/yRUjPkm2L6uU/?=
 =?us-ascii?Q?jeOPLKEcTNsaW02Mgldn6aHXqbVXgU1aBzEkMfzf+hvn3XgBi9KNVej8R4vn?=
 =?us-ascii?Q?b8SIPXbP1fjMq63E5GwSPKbZ6tGlcR21GDCN5dfRizh1W3UmvO3+elbdTke3?=
 =?us-ascii?Q?YlhZRfdjJjEKW55Q1yRtFxiqwhXLOXZu1mM080FfMsi/j1mHVD9H96kibBLz?=
 =?us-ascii?Q?6WR2t8JxB3GuG8b1ZbuUHiPgas6ZbRalW57BVsdWReFtfos2rQMl1THRWGAP?=
 =?us-ascii?Q?J2tYe6xRYLIlpoy1AMaEJvRCm3f1qj3kzbYBZ3JumsINNNTUfDlvPKKwgCaD?=
 =?us-ascii?Q?pkXiLRk88MSIZj23ShiBjClF2RBJLKVFik6NyRJ4cTRqKbwXMuGAhliIUInX?=
 =?us-ascii?Q?J+IQwR+ZMCOaeA0GJh7MNONRmIg8Pfp2Ax5Hwep4hyscmO7CUNXGgKEj7Xys?=
 =?us-ascii?Q?wIlMnqly6p9FYLmr969/kCyhzOQndU0kJvlEIRWQCCgnlNMtNUWn4sZZnyVE?=
 =?us-ascii?Q?J8nvhXa134pljDpSJCiwYAiZoQf0SsvGRBGd7KZjqVANCq9eJO3EjFg043zA?=
 =?us-ascii?Q?cnZ/BQ4weaQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BBRRAXVGfLjf+wihsnqV2nx5ogPbRfc6kB5pWe7JW3ygefdG9OgkqQBPVVpi?=
 =?us-ascii?Q?JH9sLLyMaCJE5Wb7IMzgm+DSF1VI9J3opwpdJGSWLqjFZ+G6BTzHu18fIPxI?=
 =?us-ascii?Q?JkGwl5jsw0r1UYYrerM6soN85/X3oVBLxLCCEO7fv4yZ8Exk3XQoQqBuyLot?=
 =?us-ascii?Q?4f9r7ySlSJGExFoAolzLI0lDPgaknZORTLJuOtGmk/gFtaiOcAWHXnB7OeKr?=
 =?us-ascii?Q?XV9Qk52Si8EwR6R7xCssdUxZo0/KSCfNVNYf3mLfvXQoROUUpkr1IxDPFrfe?=
 =?us-ascii?Q?JCT5oi+s3zTsU2DhlDIj/0WCOf39s2f9ZFUZgSFHtBFd4bohVXv4t20p/vdU?=
 =?us-ascii?Q?Q4mX4+AYXuarQoiU5XMM5IFBy4zxg6kokblQoEeJ8Hg8xchHvkut3yxZ0d7i?=
 =?us-ascii?Q?Ni9pCdJENf6ygbob++ZZUfUM9KUdRMc9hHiXVAi9anPc1FiHzXkJ4r2DMOhR?=
 =?us-ascii?Q?7bIOJOxN1cty3toG3IkIh5jDGS2m23BE7uaGt7QGbLvRYyrj6TtAyX5VHyI/?=
 =?us-ascii?Q?ub49OooP0677v2XazzRObzsOLDC8t8zn53rzOzfKQ8FFuWrL3stdjSyIjZ4d?=
 =?us-ascii?Q?FKP5ovNBPDjaLdBuEwlVOohEsTatGDP/o/1m3sSPVLvtSzLOa7n7r1mfFbdL?=
 =?us-ascii?Q?BZThtYbG1+47WCiic1KMkIYp5seLc6zEsGPhXwMRFv3QKokn3IoRBoEeACE2?=
 =?us-ascii?Q?wfbunVBk8k5yj/VviVXLe9rHUy3VFkM1BftP7lRFzTnVgIGZqktRQtgnfSHS?=
 =?us-ascii?Q?9DRmjV5Cl5qFp4dJiuaocQ7L6dlV9gSEov7xfy1eInXOWiEixMH931yVzyD2?=
 =?us-ascii?Q?381SvF0PxPXgDBtclIC2zMzUq2qWcLm2LfxoeeSDaCsZw8VGs1sXKMo8lAlQ?=
 =?us-ascii?Q?TQ1av9+hpM0wXrfg3SWGNOC1NwPPnlqM7ym0k68B9p3SytIZYH4zJIQNUY5/?=
 =?us-ascii?Q?GxdgUsyhcp3IgZhxTQiqLIL0yNVHffYSjNX8UvmnCBKsSrg07qJI9c7+c9tO?=
 =?us-ascii?Q?ojXpm8bNlmTdTi5tybunu5TQTi860xMvvkLz4rPA5anXOHzOIsxPQEwrcstf?=
 =?us-ascii?Q?4ZL1Amfq4ltlPr9zDD6AOO+0mbZJCm7r59bbmAJG4GXD+4B8/slG1BFNN83S?=
 =?us-ascii?Q?DjQu+oeu41QD2+3YiFQwSu/Inpl51T2fQBS77I8hav46YI3j0r++v3K5QVFQ?=
 =?us-ascii?Q?40+1zaBvodMnk89N5e8fFqr5+BSNWXwUrjEBSBKgAE0JaPsLs35qSrEDAt1D?=
 =?us-ascii?Q?SjD6EXI40APyNy9UsGAwVp34UKlMmS31ADCfNOxtePSL8vxYnpYucCmNDXcB?=
 =?us-ascii?Q?kVHc+hOSCZtqg/MXrVWRJHWLGg94+CKS1/WZyqAPlEB6LQ/GTJVs9fwgThms?=
 =?us-ascii?Q?u9WBBp+tx+6euBxvkNibYOP2Tj2QcJCaGa/HBsZXaFdYLjmcHbji/IZo9e8D?=
 =?us-ascii?Q?l6DuqBDy4XljEHw5vrEy8iI1aSLR5l2y/HoxP1odhFchaH/01gzBv9LpqNgz?=
 =?us-ascii?Q?mumcK/uQnFDZoF+w3y1eDIdVLavVUkPymcxF2sZZz12b3/uorqdqPMrNDgAw?=
 =?us-ascii?Q?55k8zuoRJyrp2EKGhuiKSvVWYQ4+MuLT+jylNM73nwkU4Wgd4TxTtlNR9Fe2?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 679cbc3e-e3de-4afc-160b-08ddd8d2eace
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 12:30:55.2785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ougXoG2sxPK3S6VJ6Q54vrwUhdruv3Kn0e5g3Cuw3J2vwGL1cUxo2NU82/YN7hkfTxb8tY7Dif9Qa5xDIIFdVhR6Wf4+k9oH0cyLnjSbE94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7865
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

On Fri, Jul 18, 2025 at 05:09:07PM +0800, Yuan Wang wrote:
> Modification of default values should be limited to E610,
> as 82599 handles raw IP well.
> 

Hi,

I think you could do with clarifying the issue here. The patch title seems to
imply that there is an issue with the E610, but in fact the code change is
for all NICs except E610. What is the observed behaviour on an X550 or an
82599 NIC vs what is desired? Is setting the default masks to zero not ok?

Thanks,
/Bruce

> Fixes: c81daae2383a (net/ixgbe: fix port mask default value in filter)
> Cc: stable@dpdk.org
> 
> Signed-off-by: Yuan Wang <yuanx.wang@intel.com>
> ---
>  drivers/net/intel/ixgbe/ixgbe_flow.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
> index 1bf0af330f..71b11f9e70 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_flow.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
> @@ -1644,8 +1644,10 @@ ixgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev,
>  	memset(&rule->mask, 0xFF, sizeof(struct ixgbe_hw_fdir_mask));
>  	rule->mask.vlan_tci_mask = 0;
>  	rule->mask.flex_bytes_mask = 0;
> -	rule->mask.dst_port_mask = 0;
> -	rule->mask.src_port_mask = 0;
> +	if (hw->mac.type == ixgbe_mac_E610) {
> +		rule->mask.dst_port_mask = 0;
> +		rule->mask.src_port_mask = 0;
> +	}
>  
>  	/**
>  	 * The first not void item should be
> -- 
> 2.47.1
> 
