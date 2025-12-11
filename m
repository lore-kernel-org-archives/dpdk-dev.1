Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C886D3E792
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Dec 2025 11:56:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C660740A7A;
	Thu, 11 Dec 2025 12:56:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 72A8A40285
 for <dev@dpdk.org>; Thu, 11 Dec 2025 12:56:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765454187; x=1796990187;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=SgFqTAylyykorz5Ben+dEtuQv0eQFnaeDEsuu4n5/XI=;
 b=Obly97j8NsjEDPKJQu2kcOWgI3xImDRo9VRJyJaHqXHrqqbvwVqYAwBi
 dC2ZAnc1YbupD1eFvtT0yOggH74g0CJD3/bLLpnRBRLVy9+4TE/Q3Y+mo
 0kvFI8xeyrRm7AF7uUHtjio2xDVZf35CdTWc3MlYZncNvI0cokYs5kpLF
 DJtrEhFtzUN+uON+TVA+x8YETyAG4ooE6nuEFTt0Lpb7IgZ85oeLFojdk
 ItD+hvtuvSsvG9G7xXgmgO82763rPrFJOoc/2m1j2+qs60kgSJEmd+msv
 HFNmmzei2UACEPMiMfa/s96J+GoHOCDLtK9Ts3ZNQUYjUPNDzqqnQhRT2 Q==;
X-CSE-ConnectionGUID: ohDBCD0xRQKurMQExdt2HQ==
X-CSE-MsgGUID: mT/tsI37S/2Do3QSz8i/Lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="90080839"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="90080839"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 03:56:25 -0800
X-CSE-ConnectionGUID: FFVh4lcuQZG4+sI9yHYZvA==
X-CSE-MsgGUID: vX9yc27pQ1mZcW4odA2C0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="201694746"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 03:56:25 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 03:56:24 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 11 Dec 2025 03:56:24 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.28) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 03:56:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQf9hh9ECL4TisoOfaigmDCIi+nQRKnivpkCph5FqY5auxKhI2xssykwrTigzrkHd+t/31A7ymxOMmjXlNNPnIScMyAPKWoY1REgYA+dsJacDuV/vmwZpt25R4e5ivrsOcGyEeDRGHRfRHCF4zovH8uGjrNhzaOCGQj0JHhcRWcUqJQMGn/Z2/8sJReZm1787uF8Ra1VqQbPkK756/dNqW4EEFmazmjgtHKe8YU1/2RngNAUBJd4q5k7iVcuRwp5gHrGXC+wA569L7TN7iIRJRZxeZS+lmnsHUUifEMzuMmL4NCF7ZSYW8hNhm9TNP5QlHRT83+hzwJeU4vTlxbNZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQcUeqXFTpqN5Hy/ns3DYEqDRQp5MxPRCT9B0OoP4As=;
 b=ceedpKDBkavTBDmcGsSlTpB3sr0ZFxryNzK2Y5HR/NUVAbCctdHTkGRCJttdR5BDLlX4RP+SkUQSAzMZBroh1UDWONlnYCx1ihNJ9Fv18JXPgKNMTxEIx/FCbWxG6EJ8LbLsYqvC4Z94O/oBpDglA58QopH4rC1ucTwOTuMTm1ezdug8ji45nCgExfml33a8n8yuOb9ZtbwyLNiQz2KdLXfI1Yqm96fF7wrYFU1b0u+43eDyy13Wnc4/SJuKx7B8uQlF+jrc/yyAKQqcHBfzSeBnhEqoZA1SeDPt5bgxTNsnPZLvSwAfMa3nYk0B6zghoyGUReXZETKB2xOnpin+pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB8428.namprd11.prod.outlook.com (2603:10b6:806:38b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 11:56:17 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 11:56:17 +0000
Date: Thu, 11 Dec 2025 11:56:12 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 03/13] net/ice: use common Tx path selection infrastructure
Message-ID: <aTqxXFZzcrM3ccpk@bricha3-mobl1.ger.corp.intel.com>
References: <20251209112652.963981-1-ciara.loftus@intel.com>
 <20251209112652.963981-4-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251209112652.963981-4-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0157.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: 20df3f41-d567-4c19-568f-08de38ac4a4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WKyHfxJ5TxUEfxRTQCIlwq9c5Vp3MZxAelCVXC95GLOl614vMRYnqJP4POd1?=
 =?us-ascii?Q?LSInrQo94lu/IGaVjJE2GzvaunUY5cLBNhyDHWPwmEq8ufuwx9q5EdfTTE+8?=
 =?us-ascii?Q?dP1unbKPWmjCl1DUPbaGXwjXRqe0yLS3WDhsDCai5I9Nz+DVohAQOuXmXLxF?=
 =?us-ascii?Q?ET/7H+/h+bfjN0ygw/jPuRd/GJA2Q4bu8FwP8IF0CHXnZm746GfzeVjZQCZm?=
 =?us-ascii?Q?PFMtPJZ3MYAXEuyApNL4471evmb9iaIg0wxKfeYIwiwdEBl82dDH2pg4wUap?=
 =?us-ascii?Q?57kdNKhzLmZMFiaAHUXRiYFBLDg/gD3ICYa0jAhGEDafJ6PbD6lBVqt6xTRX?=
 =?us-ascii?Q?2EZHs48P7v2jDriEGDJ05iTLQI6qW4WwFVYrBNlE9VngCyfQOx1UyAXQqtxY?=
 =?us-ascii?Q?Kcjb885DjY1YPcFI9gkfhPLiPCAWHry5o2fv8GV/QnjwL13/mdRH8k2xcmZy?=
 =?us-ascii?Q?L7va02h+x+IaTs3GftnUqbqsTJiLL10bXwYqjtq94m10x1eUCDaL/PZJZK+g?=
 =?us-ascii?Q?CaofuBCacnaqDM8Ho5pnADwZq9zogP+yXjjO/ORNaEvVHkLLsDmPSb0/+gvi?=
 =?us-ascii?Q?KZaSPjM+Mdwjs5ogpEe6fw19h8fXS+aFegdgVelPSkZG3rs3OH3QoCsaIRFY?=
 =?us-ascii?Q?SBVsf1CyZDUNK9ZPt7gz0DQv6zgOxX8ousaxwN9fpA4bpi4zmHXI7XQMbX81?=
 =?us-ascii?Q?tuaEix8dYautt6BgXMVcnhLOqi2seUhYmb6Xod9wD5k4se2Ee3xUJIvfzTgz?=
 =?us-ascii?Q?QhCYYXaGeU42NEfNZz/FVAGj+UspyoyYk8UTNGC3566FtA5mFi8nkWJqwWzh?=
 =?us-ascii?Q?e1tYQYSr5NwNK+veJnBnE4G7NQn8ZoUP+xqls5p0/TIAHgeR/mac+ViKmSaN?=
 =?us-ascii?Q?ZI7fjd4kAaLtcfZIuiz80EBnDAHLYoCFvFbpv3tM9HIF3eG0DIaA+Y1MKEq3?=
 =?us-ascii?Q?bZyqujmU6J1SnkZEj/mF4xycX8DgO9/2yJqoWRKRCv2pIZRR47ysE4uCwfqm?=
 =?us-ascii?Q?2VW17TmmxMtYI5UQtbkpj1TU207wcDBkPNJH085Ju3pe0vds881o5KqMbM4X?=
 =?us-ascii?Q?oiC6fCvhL/hj2CQXMtiRPyyxept2vX5u1Us63/04gfAA+jGH7vHiMGnxBkas?=
 =?us-ascii?Q?jZstyvyux9Zwph9vh/sOo2p8CK87RxCshwKPC9dxmNJq7g+rRIHwrlk1X1MC?=
 =?us-ascii?Q?jpO6CLW70hVcUBktUlakF6opPMBKdsE+K4OoJYBMpv4NCaS3xXw5iV5SwmVr?=
 =?us-ascii?Q?eFFP6UZ2GFkqpEd/tonhvoMLeJX/gVFaL6aTvUX365RIQzjw7fr4FP2QPIJE?=
 =?us-ascii?Q?taSFZy/HbViNewZeDjiKstdr8aTnQLl5FZX7PHrJvvVC6N0Tqg5SDLLyZTQ6?=
 =?us-ascii?Q?Gj5c0WzqIulFBuP8AaKhsOLzjhxRCqa920N/SJjHfFM8WMCMS8WPFPFBptVy?=
 =?us-ascii?Q?dxejfZl17xqvCGs8r2gDOaPxiBBlTWpX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YV1VDUkH4yNjTNLtJ5NiQC5Lu6/Fawc7lOwJgI2UkrfUYYts9mUH8HY2H59I?=
 =?us-ascii?Q?h8S44wUxpmcV3mG8VGfKFUpzyhKSZXM+HW9DQdLqa3qcqPpMYEt7jB/OvjCx?=
 =?us-ascii?Q?egiHNsekqPogFZyqbGZd3554pX1H9QXevgYdX+K4O+grN50BFChIrpLMAoUX?=
 =?us-ascii?Q?gb7kD330VJo91douTExcaO137OZBtqQlMzo3Xs/PDfCzs2GPOfF0iItQ4uCO?=
 =?us-ascii?Q?HaatKk+V1Hka3yy3Dn7hy+Z5/UKRZdNdU4Ao+ENEhlJuIyBxkJVuURaVSvCp?=
 =?us-ascii?Q?eAyhu+Vl4U5uV3n5Yf8wpcklyp2G7mGgruGRN0tRrll59VYR2JUNxOf+hIgq?=
 =?us-ascii?Q?7hHVX4pHGAcEIEWW/C3BsxR/HD3vGpEFGltGUFj+eadFUYDbaM8uvgC4sl2y?=
 =?us-ascii?Q?WPZCwYbb+9r+PnKq9yascUIW1WfUR4SA6bacmO77zoqBx78iqg04mBDcYyGY?=
 =?us-ascii?Q?TmM5oQnWcEQ3DKA36O4eW3BmGvToHC5LHsPYOHNgoOhED8f0UZBeCR6kqBN8?=
 =?us-ascii?Q?yTgKqMZu26ZaQLnki6nKErAf3/f4P8G+Hf1sStBWWdztesXTLm3CwbAMvBxk?=
 =?us-ascii?Q?/jvc+GrfpST45EVegNbd/bpn1umvrqSy3sps//308NRjE4aWEmpqo4zjxH7D?=
 =?us-ascii?Q?JWAQfL5Kdspl3uqG6NJKc5/MO+UqH8Z4BOdSVfsxmTUDDBWfRE+XDSs7zBMc?=
 =?us-ascii?Q?ai5npwMZvqwYn0tLFFxUTCUD0YtoCTh2bumSn6SlmPBKe2CpF9OEzF3QbgII?=
 =?us-ascii?Q?LYtF4wZOmg12May2oAzv36ehqmbbx/o/XGa1khCRJUhkbncmjOWGGkDovk9N?=
 =?us-ascii?Q?8fHvneAwyt2NWqDV+gjPcsGEXIZ1ctD0JCQpLvCXmxnplCXTWvzogsKB3sfT?=
 =?us-ascii?Q?spRsutBs+r+l6zVlhu/eovMMHcF5d4Z7/qEvF0InmIkRvReYt7TJ6PdXDoh3?=
 =?us-ascii?Q?sN06IF3Rh6dJpFgI7ndRgE1pMIqY5GosRRxWsVwFyUYXYI+BS56h0dXyle7Z?=
 =?us-ascii?Q?c97A4nCgpORunfoKCFMXgmvnAyYWi6fWqDB6EjP2cQq/FKGn9mPgIEtSAFKB?=
 =?us-ascii?Q?XiqfwKuuPKMq8aaI3WL43hCnlbQZ7JhuitHWdbgLZHjE14kIPDuwOZcnNZJA?=
 =?us-ascii?Q?n+Fn5xJr2nAZFGeal1mtIFLtW0lglQOwF5zZKtx3orpyxp5QZdsMDXW7Pzty?=
 =?us-ascii?Q?GhSo49NFhVzWwY2bNkHNzpTeEdDLQwwVKkQjBuRe2vzbh0hJ9LZ6Es9xoSxe?=
 =?us-ascii?Q?Nis/MrNsxWnIwz6cq1xXrzOHmJYgx/raEo2X4eCQCWUgvRSalGnoEJhtTpOL?=
 =?us-ascii?Q?5Kn+QNCciJjQfD/N/E4bpRR18FwhMIGN5AGvLamKDwzxQ6YsXrntXE0qg3j7?=
 =?us-ascii?Q?h7IEFRqeyJhihoRxe3QA1LXsGF7Ycg4Jnwz1EeeriQ1OA7t4pVpc/M4RXU8Q?=
 =?us-ascii?Q?prqqlpNE+Vgd9JU1bv/7RgmYRvcxAehuZAqymeMJ/X2Uo33sEvwBZtkFZ+/i?=
 =?us-ascii?Q?CSvfimYYSXWvxA8WI8nlctoFhS/x2ia9Lh+ckqcA3GibTYV6tjoAKZ/6XgCV?=
 =?us-ascii?Q?IWZZbgZs01WPqUyErGn+D7v5f7/khhE7bOTFNzbSvGi/xfDnEQsIZnZL9K2H?=
 =?us-ascii?Q?KQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20df3f41-d567-4c19-568f-08de38ac4a4d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 11:56:17.6251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 21yB2nqZYnr9DDDAvryci1xjdDwu1vaiwX2PQCyVeeNZj1sIUOTmSdXFjU8DdDWUn9rDJKB3olsY5tusNXFBvS+++EN8wPY2EYbV3SsUOCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8428
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

On Tue, Dec 09, 2025 at 11:26:42AM +0000, Ciara Loftus wrote:
> Replace the existing complicated logic with the use of the common
> function. Introduce a new feature "simple tx" to the common
> infrastructure which represents whether or not a simplified transmit
> path may be selected for the device.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/common/tx.h               |  10 ++
>  drivers/net/intel/ice/ice_rxtx.c            | 142 +++++++++-----------
>  drivers/net/intel/ice/ice_rxtx.h            |  30 ++++-
>  drivers/net/intel/ice/ice_rxtx_vec_common.h |  35 +----
>  drivers/net/intel/ice/ice_rxtx_vec_sse.c    |   6 -
>  5 files changed, 103 insertions(+), 120 deletions(-)
> 
> diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
> index c6c1904ba3..3480c5e07c 100644
> --- a/drivers/net/intel/common/tx.h
> +++ b/drivers/net/intel/common/tx.h
> @@ -118,15 +118,21 @@ struct ci_tx_queue {
>  	};
>  };
>  
> +struct ci_tx_path_features_extra {
> +	bool simple_tx;
> +};
> +
>  struct ci_tx_path_features {
>  	uint32_t tx_offloads;
>  	enum rte_vect_max_simd simd_width;
> +	struct ci_tx_path_features_extra extra;

Two thoughts on this - do we really need a substructure here rather than
just adding the flags directly to the path_features structure? Secondly,
should this addition not be included in patch 1, which adds the rest of the
support for the tx path selection logic? I don't see a reason to put half
the infrastructure there and the rest here.

>  };
>  
>  struct ci_tx_path_info {
>  	eth_tx_burst_t pkt_burst;
>  	const char *info;
>  	struct ci_tx_path_features features;
> +	eth_tx_prep_t pkt_prep;
>  };

Similar comment here - should the pkt_prep function not be in place from
the first patch?

>  
>  static __rte_always_inline void
> @@ -302,6 +308,10 @@ ci_tx_path_select(struct ci_tx_path_features req_features,
>  	for (i = 0; i < num_paths; i++) {
>  		const struct ci_tx_path_features *path_features = &infos[i].features;
>  
> +		/* Do not use a simple tx path if not requested. */
> +		if (path_features->extra.simple_tx && !req_features.extra.simple_tx)
> +			continue;
> +
>  		/* Ensure the path supports the requested TX offloads. */
>  		if ((path_features->tx_offloads & req_features.tx_offloads) !=
>  				req_features.tx_offloads)
> diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
> index f05ca83e5b..ca9cdc9618 100644
> --- a/drivers/net/intel/ice/ice_rxtx.c
> +++ b/drivers/net/intel/ice/ice_rxtx.c
> @@ -4091,39 +4091,70 @@ ice_prep_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
>  	return i;
>  }
>  
> -static const struct {
> -	eth_tx_burst_t pkt_burst;
> -	const char *info;
> -} ice_tx_burst_infos[] = {
> +static const struct ci_tx_path_info ice_tx_path_infos[] = {
>  	[ICE_TX_DEFAULT] = {
>  		.pkt_burst = ice_xmit_pkts,
> -		.info = "Scalar"
> +		.info = "Scalar",
> +		.features = {
> +			.tx_offloads = ICE_TX_SCALAR_OFFLOADS
> +		},
> +		.pkt_prep = ice_prep_pkts
>  	},
>  	[ICE_TX_SIMPLE] = {
>  		.pkt_burst = ice_xmit_pkts_simple,
> -		.info = "Scalar Simple"
> +		.info = "Scalar Simple",
> +		.features = {
> +			.tx_offloads = ICE_TX_SCALAR_OFFLOADS,
> +			.extra.simple_tx = true
> +		},
> +		.pkt_prep = rte_eth_tx_pkt_prepare_dummy
>  	},
>  #ifdef RTE_ARCH_X86
>  	[ICE_TX_SSE] = {
>  		.pkt_burst = ice_xmit_pkts_vec,
> -		.info = "Vector SSE"
> +		.info = "Vector SSE",
> +		.features = {
> +			.tx_offloads = ICE_TX_VECTOR_OFFLOADS,
> +			.simd_width = RTE_VECT_SIMD_128
> +		},
> +		.pkt_prep = rte_eth_tx_pkt_prepare_dummy
>  	},
>  	[ICE_TX_AVX2] = {
>  		.pkt_burst = ice_xmit_pkts_vec_avx2,
> -		.info = "Vector AVX2"
> +		.info = "Vector AVX2",
> +		.features = {
> +			.tx_offloads = ICE_TX_VECTOR_OFFLOADS,
> +			.simd_width = RTE_VECT_SIMD_256
> +		},
> +		.pkt_prep = rte_eth_tx_pkt_prepare_dummy
>  	},
>  	[ICE_TX_AVX2_OFFLOAD] = {
>  		.pkt_burst = ice_xmit_pkts_vec_avx2_offload,
> -		.info = "Offload Vector AVX2"
> +		.info = "Offload Vector AVX2",
> +		.features = {
> +			.tx_offloads = ICE_TX_VECTOR_OFFLOAD_OFFLOADS,
> +			.simd_width = RTE_VECT_SIMD_256
> +		},
> +		.pkt_prep = ice_prep_pkts
>  	},
>  #ifdef CC_AVX512_SUPPORT
>  	[ICE_TX_AVX512] = {
>  		.pkt_burst = ice_xmit_pkts_vec_avx512,
> -		.info = "Vector AVX512"
> +		.info = "Vector AVX512",
> +		.features = {
> +			.tx_offloads = ICE_TX_VECTOR_OFFLOADS,
> +			.simd_width = RTE_VECT_SIMD_512
> +		},
> +		.pkt_prep = rte_eth_tx_pkt_prepare_dummy
>  	},
>  	[ICE_TX_AVX512_OFFLOAD] = {
>  		.pkt_burst = ice_xmit_pkts_vec_avx512_offload,
> -		.info = "Offload Vector AVX512"
> +		.info = "Offload Vector AVX512",
> +		.features = {
> +			.tx_offloads = ICE_TX_VECTOR_OFFLOAD_OFFLOADS,
> +			.simd_width = RTE_VECT_SIMD_512
> +		},
> +		.pkt_prep = ice_prep_pkts
>  	},
>  #endif
>  #endif
> @@ -4135,85 +4166,36 @@ ice_set_tx_function(struct rte_eth_dev *dev)
>  	struct ice_adapter *ad =
>  		ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
>  	int mbuf_check = ad->devargs.mbuf_check;
> -#ifdef RTE_ARCH_X86
> -	struct ci_tx_queue *txq;
> -	int i;
> -	int tx_check_ret = -1;
> -	enum rte_vect_max_simd tx_simd_width = RTE_VECT_SIMD_DISABLED;
> +	struct ci_tx_path_features req_features = {
> +		.tx_offloads = dev->data->dev_conf.txmode.offloads,
> +		.simd_width = RTE_VECT_SIMD_DISABLED,
> +	};
>  
>  	/* The primary process selects the tx path for all processes. */
>  	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
>  		goto out;
>  
> -	tx_check_ret = ice_tx_vec_dev_check(dev);
> -	tx_simd_width = ice_get_max_simd_bitwidth();
> -	if (tx_check_ret >= 0 &&
> -		rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
> -		ad->tx_vec_allowed = true;
> -
> -		if (tx_simd_width < RTE_VECT_SIMD_256 &&
> -			tx_check_ret == ICE_VECTOR_OFFLOAD_PATH)
> -			ad->tx_vec_allowed = false;
> +	req_features.extra.simple_tx = ad->tx_simple_allowed;
>  
> -		if (ad->tx_vec_allowed) {
> -			for (i = 0; i < dev->data->nb_tx_queues; i++) {
> -				txq = dev->data->tx_queues[i];
> -				if (txq && ice_txq_vec_setup(txq)) {
> -					ad->tx_vec_allowed = false;
> -					break;
> -				}
> -			}
> -		}
> -	} else {
> -		ad->tx_vec_allowed = false;
> -	}
> -

This code being removed was reworked in the previous patch. Do you think it
would be as simple to merge this patch with the previous one, rather than
adjusting the code twice?
