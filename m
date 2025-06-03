Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DACDC5AD49
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 16:46:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13FAA40E64;
	Tue,  3 Jun 2025 18:46:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 35C0B40E3B
 for <dev@dpdk.org>; Tue,  3 Jun 2025 18:46:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748969160; x=1780505160;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=RfbrOZ7YqK1jcVodCPNKNFYHpBXft5dXjF14LPcnquM=;
 b=G1ug1ioIguvq3Ls+OqFE0L85YW5X4kcEkfJx0VPgIk9ru4aIXzlc+43j
 Xl1Y9wtIkNjHlQdTfq03FyRNl3PDKYFqqiufFK7EMkH7wfPJk6RKRPefF
 C78mN1VEtVmPWOCIQrhRpLSge6A+X167IyvCo76yDJCucSINv2AnAP0Ue
 /dh5sMEGPbGxTikOgjJl9zkxwWcipLiXlrHIP5kReZmDqb6eAGWreSf/O
 MzBtfeNvmZNlrrIl45m9tE4VnI1WZU0ujGc/wqY2UNQU8YPVdHCi87FoW
 84e6T4FpsanDOnKrdos+B2dcQkRx9oCs4lVcUnJT/mOiuGwlkhScfqrdc g==;
X-CSE-ConnectionGUID: oSzhAq3STO6zRiDb5yb6wA==
X-CSE-MsgGUID: d9NBxBPeSC6BAlNIYwpJNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="61682715"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="61682715"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 09:45:59 -0700
X-CSE-ConnectionGUID: dMreIIv9Rs2AQYPzFjEI6g==
X-CSE-MsgGUID: ZGjK9a49Sv6UyMGHTts6Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="149960576"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 09:46:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 09:45:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 09:45:58 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.57) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 09:45:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJZaBpxBrchVZ+EZndOZpH/IYQBekuT5PNrn5ber83elSMHflCKqngCCRtWnR3StKYaIx+ubK6hvvp4A8jMoNGLZrCk9IA5UagNjEMus9SczRuFOYZcitW0+7Vp5GahgkOZ7ka+YpdV135pFg8sujNMqAnbhRffxhkGao1rKM/ZUqnVCEQAi4y2pVm71zUnXn1isJg88y1KKId3DvAw/IrC7gCTUfdp9Y79PAgjTQTzGnG2KnmUksucIswnkMWGhsj3dxrzfVbMWIAERmhR0Qc2LwupcvSswXa223X1eDcDSplylpmhVPP4JvZ+HO8lioIAYx7QuJ0Wgvou0f3Z+YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3HHLT3Qz7/vfEwcMtQrHz/xzwm+MnM+O0dd/+51eH0=;
 b=YNqSxeMYaUAnyih5OMhW9cJI9GYt59x+JcP3k3Hpwi8Cy4KsCm0+O1BAgNAd15QEb2pZBGFflNiZVUwikmWwHHnQZ54QI7uI6YjfPsW9x3sM00gbLDppWBDwSUX+fXq5aukMlWzksC98UNCMqKJMJLALAGcoE1ZQwjVDcRLfAXWLwNvxJB/4T52RVgkpoDdOEduhW12m5Uwqx7jzOo+jjE3XQHaQ9wWOprDie1KESV3lFZDnNxUvrBBMwd/xKL36DjLyGQPGacHhygLO4psm0OjdBF1HvjW/5WlRFpNBy2SjY+uSKBrmgcHrmJ9XOzx99hvmgtXou6JYuBkslfoWxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA2PR11MB5051.namprd11.prod.outlook.com (2603:10b6:806:11f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 16:45:42 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8792.033; Tue, 3 Jun 2025
 16:45:42 +0000
Date: Tue, 3 Jun 2025 17:45:36 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v4 15/25] net/ixgbe: create common Rx queue structure
Message-ID: <aD8msCzHfruQYhC4@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1748612803.git.anatoly.burakov@intel.com>
 <cover.1748612803.git.anatoly.burakov@intel.com>
 <dcde3665a06b052fef2c722e8c940bf41ab73e4f.1748612803.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dcde3665a06b052fef2c722e8c940bf41ab73e4f.1748612803.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2PR04CA0306.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::11) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA2PR11MB5051:EE_
X-MS-Office365-Filtering-Correlation-Id: c82ce1e8-257a-4b69-97c6-08dda2be143f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5/WtEHBIKh6pqHZgPO5v2HMXoKrLsvxXRySsCxY9okTHX211FwKS2cA4r5tG?=
 =?us-ascii?Q?LDFoaeO999cd1sDKMyDMroZEyCAI1TkiLljbwlhnyYqVbnso0bfERptNUZPN?=
 =?us-ascii?Q?JRvTXmaCojrLhz2wLCByEMrySB2+uj5zOUXfacwagWMvszd8vwAtPJLse68C?=
 =?us-ascii?Q?/lLrZaJf8HedCsKQOq8UuM4z6TxcRrtot+i45S2d78PdBbeQoF24S0uKDaX6?=
 =?us-ascii?Q?ln/d64vJdRr4Tag6Q/r6M/LzW25nExUS7IMztsT/kXFdLi/nXtjcB+IEp1lr?=
 =?us-ascii?Q?lxbBQC9G2WM6YDoqECbn+vM2klLF2h7UD14xnmHh4Bwq82kDoLypkEzSTRbh?=
 =?us-ascii?Q?rpiGXc3d9x9M1yjYMPxcYZ2h0wCoSyGG0le6OXgAGjnPDudfXP2a4ndUcz/9?=
 =?us-ascii?Q?Opg9IoRg1Wat4wu5Hj4DSI+VJQgPlU0tSNcLJXCuRmSRttnffO1zKmrgB/zd?=
 =?us-ascii?Q?N2wMPUBArNRWMPJBxYAxFpa2g6CEZ2IhECOk8EB9XTESVAEsmED7eMo8RNkR?=
 =?us-ascii?Q?hOiH61UUXDQnJ6KFVc35m5Z5HLBVQsTcVa2Vdj4nefL045L7Mon5YBitj5i8?=
 =?us-ascii?Q?ULNO0w87b1ClWEiwhJAEPDunlkJkL2bCUMBsBgjApXIuZiesf9nQ3qinixcO?=
 =?us-ascii?Q?lCqNR8q9kkpOdJzX7L/M67KpbDvFhJT5LmEMTVYUovlK2fN/vdZsPwuXDnN9?=
 =?us-ascii?Q?gtMqyJJatWwGAh9TbaHjWJbDJQpRfpkH/PbkECDEE4Zgn6Y17/h/nvThe6fA?=
 =?us-ascii?Q?nOLEtsbs5/AIpuRHrsU3A3hLcb2Pr6MlDzCzyLTGfAs2sBN5R6MwbTkheu6g?=
 =?us-ascii?Q?P+R1zHNfXaCVd0gvIjTAHscuB6R3Q0k7yht15fJhIbN15i9sXfuWpOMYIYxk?=
 =?us-ascii?Q?JYTeDeXJfpf51sdPPvTFn3Kr8mOGcIeNrzVoy9x7Hqw/kCQzd05zue3ywBCT?=
 =?us-ascii?Q?S2ekhmsMwp9LfEubpi3McdtkSrXD49tYjmFgcjjgXQ1GP+stfFHT6ywN0NKy?=
 =?us-ascii?Q?eNrdQUVuFwIzp3YJbSwkDSlv0FvXPl+yGSdx2IXR/05uWw45Zb1uFkEWnS56?=
 =?us-ascii?Q?Pdg+LitnW6eQWhNAS25w2xZtfRHjtNBgbA9vsq1OlG88JOeUQvlQmB13RARM?=
 =?us-ascii?Q?KlC4NUEW322QT/C20T3vD0lNQASsYcXiu+HGqyj4U4R1WPYgxWMbQ7qe7HIB?=
 =?us-ascii?Q?cwJYoWE8gbI2ShSY5LRnlSMBg8sPeJz6LBsaGVl1avmP8/6NhvCpxReuRSe8?=
 =?us-ascii?Q?tqWLbvMWfHztVoNnzh+/SNDzMvxJqsKbAjOPaT1H7CX+LFVGPVj9y+F/szkX?=
 =?us-ascii?Q?7XIgHoOCNyyScfyE4oty7+qPH3swiKc3OahSqH7fu8HOKQF8O6GAS2IFpvJg?=
 =?us-ascii?Q?vEKTKuYPfoE3dVDWUVPUTpxSGcykhC+QpLORLZD/B7CNI7wETC477KOjOe2M?=
 =?us-ascii?Q?NFwe3HJZOEs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?16GVOsJGuqZu6BheSnZlG3jCez7HqEgBlObo6K5MGn9dzqLQJ2v82VsgNKn8?=
 =?us-ascii?Q?19JodEtryuNq2qSYzmHruTGlVfxQynZYf8wvRO/aBavRA3XPFdXwx9MFZocN?=
 =?us-ascii?Q?RUhE32OQBwNdouvunkNfX3X2nVU5Nf75KgTUrGw7xA7CqD1+tcKsGMD8JkDR?=
 =?us-ascii?Q?lk2I/vBryv8pHkaggUfyIfRT8szJGpSUk+Deqb1G7/y6Eugfb9IxoJhDxtqa?=
 =?us-ascii?Q?9kgMDeSHesJjJ7mzB/JDhe4c7Tm1Di9fleVyLl13QWzeBa2wr9+tgQ2RDidY?=
 =?us-ascii?Q?8fhOB3D228tYA9d6/xRPTEMjjhx8Zb88Kh3DFS4l8XvBysaxACWftAG0Oxlu?=
 =?us-ascii?Q?Oewyo5dCJulpgj8nQZ5CO6ECzsGpX69PPNR5lu9P/J0myIwEH+OMaylSiQKt?=
 =?us-ascii?Q?M6FrYFQyqZkLbGUpE51mQg4/518Nf5v6twT+wSNoWoJB7h3Si4+Sf61nKf59?=
 =?us-ascii?Q?s8uDaWkr/0aPKOjsSdFhPCwgCw9358xGa2jRLt0F3VJw9BUfcyaZRooWUIUC?=
 =?us-ascii?Q?3D381jNUgmuM2e1ydOaFPZCqsyNVYA6tvmx0FvqAuCUSwfG7t7DlYdtot6Pb?=
 =?us-ascii?Q?ArQKm8ucUDdYPf+f7KkdCjmP3UE2AxX9VfoBVgke86ZkXPULn6cstHF3WV2g?=
 =?us-ascii?Q?tHc6kVcwRq2f+3dX3kCL7FpZ0TgoXIjFS0f3hMB7dIwfQX60IiN1/LP0riwE?=
 =?us-ascii?Q?A/QSSvLpAma8RA/la9fqvsF3WkDtTP47kzh5uh7dOZGd2grzc2LepcpCS0TJ?=
 =?us-ascii?Q?UhR3ILfsv6oJLXi5aRgJd6JYY83pkMd+XVYRXesoq6H37INZDpIe361zhgRz?=
 =?us-ascii?Q?IsWgeoOlrmx0b4HcbpXZK3g2ChqV44fuDBuD73zbJfB6LL9ao3G15ZQnG1S3?=
 =?us-ascii?Q?UPVPrKUQtS9y8FsHdyTNGnSGt3qhutzPembbihho3ethISDWppjnsoxlIlOp?=
 =?us-ascii?Q?RDv9vCHLtY0dNoYeMwZHfbTGdB4i/b0uqJwZpempwF/+PZGiTMXFkXgvie50?=
 =?us-ascii?Q?lPeEg9aPkvpkzlDxhuZVxb/+ZjSRJvVlSWAeKKR1i1bg+A/qgJ3d9O7R7CXJ?=
 =?us-ascii?Q?KAEUMlWj2WRIadem9WPFOrJ6bXdsu/Z+9uMYI+PLH7RFmtLO1NuyfDBZ2fXT?=
 =?us-ascii?Q?do7r4mDH0iALulSzQnD+GiujwCIk7gBdXFDoMFVd2l/kIkYQzrr/zq29hU6n?=
 =?us-ascii?Q?LbgcGkKgsfr0yMvgSjdC/S/kAOXK9/ZMQb+hqlfabSaTGt2o7w9qHUpqtkNt?=
 =?us-ascii?Q?D2+pr1jpwsxH8gFb7ZlQsuW23g+mumgtib5CYId7LANytMFi02Xl48ls0x8y?=
 =?us-ascii?Q?a4qnqJOQ3qvU7CP/HDnKU04v2n4/ZMEeIuHpDEFRho/+3IQB7zpW/lbARPht?=
 =?us-ascii?Q?2lDHgEMDpP498WqdipHoobpK9pZg8nnT+8vdFtHvbSXkQY+Fb7roaqJEilrr?=
 =?us-ascii?Q?o6JCEGiFDSgJ9MmWnag/Tyxn0hVVUnLjm8EOBsL3icVhd4D/bWx+me9VQO1R?=
 =?us-ascii?Q?fTgX1tN1+CcbEx51O4skBemiHEYMPkz+JZuAA5kv5cex1HCvHh9wFeEW8KTC?=
 =?us-ascii?Q?BXoicoSVICh8CbOlNbdza2fPN8I7arZMM1qlmOnLDi7Uv+5MpYCjiaCaARCr?=
 =?us-ascii?Q?6w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c82ce1e8-257a-4b69-97c6-08dda2be143f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 16:45:42.6470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 75mkMle+jFyZljxdz1hZKM8r9jQeMt35Pyml2tVPKIHN3nLcFyiZ6LcFVroJxPnZ05azNYvsiiKnm6UG3NZIWRT3lNh9ywxeNak0ZHIoVt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5051
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

On Fri, May 30, 2025 at 02:57:11PM +0100, Anatoly Burakov wrote:
> In preparation for deduplication effort, generalize the Rx queue structure.
> 
> The entire Rx queue structure is moved to common/rx.h, clarifying the
> comments where necessary, and separating common parts from ixgbe-specific
> parts.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

One minor nit inline below.
> 
> Notes:
>     v3 -> v4:
>     - Separate out some of the changes from this commit into previous commits
>     - Rename CI_RX_BURST to CI_RX_MAX_BURST to match the driver naming convention
> 
>  drivers/net/intel/common/rx.h                 |  67 ++++++++++-
>  drivers/net/intel/ixgbe/ixgbe_ethdev.c        |   8 +-
>  .../ixgbe/ixgbe_recycle_mbufs_vec_common.c    |   6 +-
>  drivers/net/intel/ixgbe/ixgbe_rxtx.c          | 110 +++++++++---------
>  drivers/net/intel/ixgbe/ixgbe_rxtx.h          |  65 +----------
>  .../net/intel/ixgbe/ixgbe_rxtx_vec_common.h   |   4 +-
>  drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c |  18 +--
>  drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c  |  18 +--
>  8 files changed, 150 insertions(+), 146 deletions(-)
> 
> diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
> index abb01ba5e7..80a9f21303 100644
> --- a/drivers/net/intel/common/rx.h
> +++ b/drivers/net/intel/common/rx.h
> @@ -10,14 +10,75 @@
>  #include <rte_mbuf.h>
>  #include <rte_ethdev.h>
>  
> -#define CI_RX_BURST 32
> +#define CI_RX_MAX_BURST 32
> +
> +struct ci_rx_queue;
> +
> +struct ci_rx_entry {
> +	struct rte_mbuf *mbuf; /* mbuf associated with RX descriptor. */
> +};
> +
> +struct ci_rx_entry_sc {
> +	struct rte_mbuf *fbuf; /* First segment of the fragmented packet.*/
> +};
> +
> +/**
> + * Structure associated with each RX queue.
> + */
> +struct ci_rx_queue {
> +	struct rte_mempool  *mp; /**< mbuf pool to populate RX ring. */
> +	union { /* RX ring virtual address */
> +		volatile union ixgbe_adv_rx_desc *ixgbe_rx_ring;
> +	};
> +	volatile uint8_t *qrx_tail;   /**< register address of tail */
> +	struct ci_rx_entry *sw_ring; /**< address of RX software ring. */
> +	struct ci_rx_entry_sc *sw_sc_ring; /**< address of scattered Rx software ring. */
> +	rte_iova_t rx_ring_phys_addr; /**< RX ring DMA address. */
> +	struct rte_mbuf *pkt_first_seg; /**< First segment of current packet. */
> +	struct rte_mbuf *pkt_last_seg; /**< Last segment of current packet. */
> +	/** hold packets to return to application */
> +	struct rte_mbuf *rx_stage[CI_RX_MAX_BURST * 2];
> +	uint16_t nb_rx_desc; /**< number of RX descriptors. */
> +	uint16_t rx_tail;  /**< current value of tail register. */
> +	uint16_t rx_nb_avail; /**< nr of staged pkts ready to ret to app */
> +	uint16_t nb_rx_hold; /**< number of held free RX desc. */
> +	uint16_t rx_next_avail; /**< idx of next staged pkt to ret to app */
> +	uint16_t rx_free_thresh; /**< max free RX desc to hold. */
> +	uint16_t rx_free_trigger; /**< triggers rx buffer allocation */
> +	uint16_t rxrearm_nb;     /**< number of remaining to be re-armed */
> +	uint16_t rxrearm_start;  /**< the idx we start the re-arming from */
> +	uint16_t queue_id; /**< RX queue index. */
> +	uint16_t port_id;  /**< Device port identifier. */
> +	uint16_t reg_idx;  /**< RX queue register index. */
> +	uint8_t crc_len;  /**< 0 if CRC stripped, 4 otherwise. */
> +	bool rx_deferred_start; /**< queue is not started on dev start. */
> +	bool vector_rx; /**< indicates that vector RX is in use */
> +	bool drop_en;  /**< if 1, drop packets if no descriptors are available. */
> +	uint64_t mbuf_initializer; /**< value to init mbufs */
> +	uint64_t offloads; /**< Rx offloads with RTE_ETH_RX_OFFLOAD_* */
> +	/** need to alloc dummy mbuf, for wraparound when scanning hw ring */
> +	struct rte_mbuf fake_mbuf;
> +	const struct rte_memzone *mz;
> +	union {
> +		struct { /* ixgbe specific values */
> +			/** indicates that IPsec RX feature is in use */
> +			uint8_t using_ipsec;
> +			/** Packet type mask for different NICs. */
> +			uint16_t pkt_type_mask;
> +			/** UDP frames with a 0 checksum can be marked as checksum errors. */
> +			uint8_t rx_udp_csum_zero_err;
> +			/** flags to set in mbuf when a vlan is detected. */
> +			uint64_t vlan_flags;

These ixgbe fields should probably be sorted by size.

> +		};
> +	};
> +};
<snip>
