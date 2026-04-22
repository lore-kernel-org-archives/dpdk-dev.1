Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE068F9EDF9
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Apr 2026 15:37:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23B64402B5;
	Wed, 22 Apr 2026 17:37:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 9511D402A3
 for <dev@dpdk.org>; Wed, 22 Apr 2026 17:37:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776872258; x=1808408258;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=JQqgbXX3UkBDHr7jiq/x+ide6pnLAbWTBf9bPjx+icU=;
 b=SFaqFVsHs9fO2WIhdR4Mwu0bJk3rvtDhQK0At1Z1yhA8hB4dkQ43hyPV
 9/d2PZxZwXuUiCLWWLR6yAIyI6eTMMW+REmoL2KQbdYNQRbLIqJLc7d0p
 B7yCebfEanxvDMlqV+VWAA1h9dCZwfFL1hTLAgHIMkxMyli/ARnF1H4yi
 t+crnei2ffMY9lyNQSG8mX8olqq16RBGPLN5Hu+7m1smnX41VcLfvblNx
 0JQv5/BWsCe6lHSvUpVBmofFmizFYwz+grBLG/yKlZr5NkCj3Vov6kMcc
 S1Ax9yrMhpc8Lyhpu+j6mWyswWLJSs4pQfT29MXZx/qEZO9VYojPTR/4A g==;
X-CSE-ConnectionGUID: /X4jlVOFRfuxajk05nA0Xg==
X-CSE-MsgGUID: EaMx4lvcS6CWTt0H0HcuYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="76992189"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; d="scan'208";a="76992189"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 08:37:36 -0700
X-CSE-ConnectionGUID: kOgjtSAUTG6MW2Dzx7YxQw==
X-CSE-MsgGUID: 0bJc2AxCSv+KZRQsz/2E8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; d="scan'208";a="232293725"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 08:37:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 08:37:36 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 22 Apr 2026 08:37:36 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.50) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 08:37:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=keRSbtSVuNxPxrBOKusKw59Zfhu5MybFfw+LTdZi9N6jWdl5LPiP8UbfBOIk1LBNX3T3RbbRwsN84uKfkHujmY+klPJLMr4NNeA5Al8YcuEQS4ntGfCsRFLmvuo7z+TKiCUlWh1EBTtqgMfHyihRMWsX5P68jbLpEW7rhZZ+487vWQC+ANyP5Kj68CoWzgmar6gOiZOnITnmAWT48jMF+K9rKiiVgYgVFJx9Zyr1HWDYruu7FohQ3gt96qSe3vLj8x/xUod+3b7M6/x/92+CEjIQyqSr6Bg/l5Y6P+JwSp1Fty52ZQHbNjfZj2YkFDNF36aT6bK7+wWTpfEnA/oTkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4TrDfx4DXBpzTmwCXtLSuYyxgxKbef61DyxZ/fAM+Y=;
 b=UftNGVpWWhXmELsAyOLBIcgjYlbwdpi02ZKWnDk5zoXW0L+J5w+yQGTMAxAYGv5+rVEloazLM0UR12VscDPyMZjhM3CURZsE2vldogNo382A9v2m8u61jcLxGyKoZEIunonJlRepd4N5srSeE3YflSFE80thlC1LvEbB9AmPebspltdYq4z8sxtHJiezMvM2Ztlx964UchQrv9k+uLH7PR8S1BbWJg+ZeWOdm9UV5hQxBt0aH8TMXyX/u7MjQtsy2CWZpTh2YGoz7NB/58kPNuujI7pLCLSeaIyCYGYwmZ3HoMQbYE+ntSLaExNErse4aRf3st9M41NQsi/KMDxPpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BL3PR11MB6532.namprd11.prod.outlook.com (2603:10b6:208:38f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Wed, 22 Apr
 2026 15:37:32 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9846.019; Wed, 22 Apr 2026
 15:37:32 +0000
Date: Wed, 22 Apr 2026 16:37:27 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <luca.boccassi@gmail.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] tree-wide: fix 'allow[s] to' grammar
Message-ID: <aejrN1XS0LEH7hdu@bricha3-mobl1.ger.corp.intel.com>
References: <20260422151901.3523790-1-luca.boccassi@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260422151901.3523790-1-luca.boccassi@gmail.com>
X-ClientProxiedBy: DU2PR04CA0215.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::10) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BL3PR11MB6532:EE_
X-MS-Office365-Filtering-Correlation-Id: e4b94b7a-3233-427b-2f81-08dea085119c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: /0PpE+BaBvMhfr4HwajpVhm0EkQAmR9sSiakGbxxBBbQiOmdTIwk1fDNv/Hrr2YBXpGO4sAHf9heRpCaCV0VuBovCgHzz0AfcYaqt+H153j7z/IoC95gdlZSFP1rqBdRodu2kSRHiPguRwpYH0SICDqGaAjNI3rbUsexN8B27xnnOxaNsOi665z5/w5dhl9FGMc2vM/K0U3vYgAnt4Vcxo2PnMm/rYMW75YCnCgoE4EVMGYCrxo6+hXUAdVlTIkJGMD/SiL8MdWj9KjEhzqWosJG/pCZdI53dKz4VjcO7d+WSxkjRvWArXFTVqlXD3WexGpkKjXeejaB70z9qgj14O1VfvLDZYiBTWRJvnxvYYpHQXeoOSYYcZpYbg843cUEYUIY1R2p8hS0N6YDgu7o2EPINc38XoCF92fAgfN5/Po1jdRi+9sPjOlHtfN/jcVLhA8RA+NDwNbcBADIFUCHVTxawQfABDbDnvdiaFpqw2owfK9nRLBHW+1UqqQeZO9QIHg1UgTyW/93OMElRpaT2vaHPw0e8ylk4R3Jq37AykCXyQ6xxiISSg5T5do9kBtVsRF5RLkW3BwRO2q0D4A4XoToQwyRtpo6+Ch917k/9y0E6ZOd3JTfHn1rAEejJRSjfrKrSooMALRdBh9Fk6ZmbCyJtn+ALRT0PHiZ6D9cumrrhR6XHEAmQmF8NNW5dKLDSK2Ku8czEkLjqKHI8FblTQMC/+PcVG0M31dtXZ5Nuz0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sv8k/qZrtYdH6mUpqmKuMqnOFQHLcCQn/Q4o9YsEVs+hednGpdH3ZapihRet?=
 =?us-ascii?Q?H+7YXFCtqm9NdSJSFfzoo0llnTlhPFBnbPzlSCeSI7EHO44/HAhCeVnbi0HY?=
 =?us-ascii?Q?rS0/Bzs7ijyzxTk2IHopi7Q3KQJw4odBVgXVdqGPb3JlrOMqc0aQLvp4tJvg?=
 =?us-ascii?Q?+xBEvGSvA8OIUvizUU9v0L0Ajz57czHoK7jGj8X+Tn2PRt7A2jgflpvneUdQ?=
 =?us-ascii?Q?jGxg0djNUI6kTux2VQ/Y6aw4Vpj/GsIPh+m8UH7UPcawfVwaXle1leY3Pent?=
 =?us-ascii?Q?1RjcIuO1Adapd31BKKPzZUA3rhm1S8ZKXowvxdyzXRrjn1Ab/qAuYhnIkDza?=
 =?us-ascii?Q?oFOjCxPhsA9xKacSpPUdBJ50dOzu7GGaJJY4Xijhn3lhNp4nQd7UU9ue1b91?=
 =?us-ascii?Q?myKPI09xZeZ2lhk0hSCcPSjDkgXglwI+0W+Z1I8NBSRAYHNDVFBa6B8PrVQ3?=
 =?us-ascii?Q?l293xmS4niBbOPTvqW9HK2dNPpDNyR4L8bGW5d9WCExNTR5hUAmrOTmIAGqt?=
 =?us-ascii?Q?vt+8ehHVsgsezkZ+w5FHEWb93FPbMgHjKfx12SsNTTgTy/FapdlDNLyaFE0g?=
 =?us-ascii?Q?zpC8NZ6hfdceVmvCW3/qBsorw+LOUr+ta9/bXXIE/28tnTbSpZGafIf6CujM?=
 =?us-ascii?Q?KcxYA0CtziU9pUJbjzEvUa0mvIzt0V3cpnb1urI13/z9yHqQ0hbuB+DbPEp6?=
 =?us-ascii?Q?1KtrlkQqbV1PbnQpkNNPKqSYGBsb4JfIZVUjYImQNBAplpLVnFR8ypADoQxA?=
 =?us-ascii?Q?+gseqy0ExIKLYat8vg9+y9y17zy5k4xbpUC79H4kVD9/AJM4WTgPWdkQKGsc?=
 =?us-ascii?Q?QoViihP7nLd1KvIZnc9mbIX7zHNwpazYBAIj7X7oAZcjSQU+otZvxMl1ETTR?=
 =?us-ascii?Q?Ph8r8P6/vTud/3pMXFoe+fihWXUILyPuRbUpBNYz4FoBx1gWCy6A1nBAHhXE?=
 =?us-ascii?Q?quzBLF1ueX3pL7pexucWo2VdcG/ZK8jueAr3yB+TAteHyJFEqi/sA4HP/yqy?=
 =?us-ascii?Q?a1vzygMqtQ9IBatd7GcKgfq5JT18YrLQJLbCg6/BJbTHKsZqkZvo/HipVtuA?=
 =?us-ascii?Q?qAQ+Fg6Y2heQZu0vMEkAeLqSf7N7MtXckdShjsNUjfIQzuNK4Q3iAMMjxHKN?=
 =?us-ascii?Q?rdro/nLMO7Uth6J93ERH9W0sxcYxLWoJFWJejPhq+slwbtQo4ToWhAKfHbV3?=
 =?us-ascii?Q?2e1dvOb2qid0/xQ8KQ+sc1UdGND7fBF2usrVBk1J9yLexTx1BrZDYdOJTdgu?=
 =?us-ascii?Q?9dibLoHbkzOP9d17JUhoVFEyA8l1HW4tKGbauHapmaaHLSSkhHe/GB4r9mO2?=
 =?us-ascii?Q?+Omqg9x81xwPG5CDVFG+MH3dzZ2i5xjmsf5Df09kCbCtIHv9Q2QWHF6j7mXf?=
 =?us-ascii?Q?puyx3V1pb1gsfYS/KXSmoTx5F3nBHIWOe4nT5Q+aPgpiJ7ibP9HDSB8cFNob?=
 =?us-ascii?Q?JePCXZfGEoMBtXuqnzCLiPqnhJO0r3QP+PnXFA3AVUCIyviSnP6PglZKDKbi?=
 =?us-ascii?Q?s3FDfrwZpQCyI87k7RHjK0Wwk6hAH4pWpK1PQGK90AgcHwbcI3ocgmxCYlkA?=
 =?us-ascii?Q?KK9QR/fODl/sV3aQ0pVtSnQyErZbVsjpV215W3VG5Cst4KxwE6/90eWe070i?=
 =?us-ascii?Q?H5kebQjNJSylFDlcqkDXaD2NkC6eT/RNidmIvxzlMABBkoCoGzE3isCb/MiF?=
 =?us-ascii?Q?BXIGg3byikmek37EoMgNNExWeZESaMvtv9+981rULqPiD7TejeEJNOPN7ejk?=
 =?us-ascii?Q?xfdQQdiugUtXCS/1CZELDNdWY8pUsoc=3D?=
X-Exchange-RoutingPolicyChecked: bpK8gCJmz+b/CsZ+hG0hQRvNWYiFqCj7t10sX3tpxfvKfkUA7bZ14OALbE/4yLDGrSVgpu3GzvgG3nNmX8rzwPedVz3GaIpGLCQtwNJVe7YnOklY+hp1Fimx9d91Of0noCfNg6W5TOS2AyPvoRBGp4zz7ZfSuDy/HXPlBVGaCHo5Rv6OCFYk0MsfiX3AtXPUSH5zlK6OWAGr7ZzoOW/tds1EvBBxtNXIX2KvYi70jzhnjYJpCWhHHiXGKtdE8NW+UYueEuXwii48rtE/xeUEHxTsD3AoGe6ahDQaVpp06G45nbCK5pG+hZzSBDwrBYMABsNwjU6C9QWZbQiXXjX8Ww==
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b94b7a-3233-427b-2f81-08dea085119c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 15:37:32.2721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XeiB4IKjAvT77y8+rLXhNnsxSys7F/vCD9laZBU53FMkO/ZEY8mWNMlxjlRkN/4bSdSl9dPLYWhoTc0QeztCZaksPZqVrASr4NWWLHC35Ek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6532
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

On Wed, Apr 22, 2026 at 04:18:53PM +0100, luca.boccassi@gmail.com wrote:
> From: Luca Boccassi <luca.boccassi@gmail.com>
> 
> Lintian flags 'allow[s] to' as grammatically incorrect, as it
> requires an object before the next verb.
> 
> Fix docs, comments and son on by either switching to gerundinve or
> adding 'one' as the object.
> 
> I: dpdk-doc: typo-in-manual-page "allow to" "allow one to" [usr/share/man/man3/rte_graph_model_mcore_dispatch.h.3.gz:32]
> I: dpdk-doc: typo-in-manual-page "allow to" "allow one to" [usr/share/man/man3/rte_mbuf_dyn.h.3.gz:167]
> I: dpdk-doc: typo-in-manual-page "allow to" "allow one to" [usr/share/man/man3/rte_mbuf_history.h.3.gz:71]
> I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_bpf_ethdev.h.3.gz:41]
> I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_ethdev.h.3.gz:3423]
> I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_ethdev.h.3.gz:5197]
> I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_ethdev.h.3.gz:5224]
> I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_event_crypto_adapter_runtime_params.3.gz:32]
> I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_event_dma_adapter_runtime_params.3.gz:32]
> I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_event_eth_rx_adapter_runtime_params.3.gz:32]
> I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_event_eth_tx_adapter_runtime_params.3.gz:35]
> I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_flow.h.3.gz:2669]
> I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_graph.h.3.gz:222]
> I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_mempool_objhdr.3.gz:33]
> I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_mldev.h.3.gz:807]
> I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_node_eth_api.h.3.gz:44]
> I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_node_ip4_api.h.3.gz:73]
> I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_node_ip6_api.h.3.gz:50]
> I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_node_pkt_cls_api.h.3.gz:18]
> I: dpdk-doc: typo-in-manual-page "allows to" "allows one to" [usr/share/man/man3/rte_node_udp4_input_api.h.3.gz:42]
> 
> Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
