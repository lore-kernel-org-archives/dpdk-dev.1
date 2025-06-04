Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEF3C5B552
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 09:32:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67F9B4042E;
	Wed,  4 Jun 2025 11:32:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 96D594029D
 for <dev@dpdk.org>; Wed,  4 Jun 2025 11:32:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749029562; x=1780565562;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=DC4c5bturN0nsd3K/uyT0+h7RLJkoWovP4M9QqdnWZ4=;
 b=lZMHuZdlm3WT+R8Ua23kepDsa5SVW0IsuQfhXRwlB+HGZOIFlh+B/iyI
 c7MZ/sgcMF/MF/QbUUs82rk810CGmyouXiDmmlaHE4zf5d9iYB6erORPH
 HZriCNZN8rgI57tcUyJGZu2Obm2gGvB41P7HggQGJbT1o1oU2wxoRjxGp
 c7/zHx45B/VFg8c47ixS9RYMN6CEI70IqOSC1m9VbJ224CnfJaHpjq3tK
 tlnq6LGGO6Phs9EPhRpPO15bsZP6v36eQY52xWgezcac2Zgxuz08jfO+I
 sISzIDKCXVtYSYrE8mwx9LQ+oEuW7xtitVBpic8T3ucD5Ds2SaF48IM6Q A==;
X-CSE-ConnectionGUID: FzS5qPiYQlyQQ8fNtCFNPw==
X-CSE-MsgGUID: /4gOafteSGSeVRUHLaYt3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="68537384"
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; d="scan'208";a="68537384"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 02:32:40 -0700
X-CSE-ConnectionGUID: c28f9EA8R+eA3nfQsGIy/g==
X-CSE-MsgGUID: Xy84bi/dTharMd8Tgwx/Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; d="scan'208";a="146105601"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 02:32:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 02:32:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 4 Jun 2025 02:32:39 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.53) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 4 Jun 2025 02:32:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HoyREdSIBrJubVJAPgpFO7uAl+LgjRpcefIrHbNo+p/y9iYso883M0boUVrp6pCcAUpknIc2hTgG+1Kdz+rrhJZcldjY8qne0xROQ/7SdHBoxR8maHCYzCKZhQeEGqTI10On6mHVkcmoIKGge1wC40Bl9Gmc0F7kR39kx80gRCYK8HXkGO6EYQp4pRg/EW+yjWO8qKFbTLr55Q0OvY5WBhTLckHFqINTlnhb5ox391otnrJunepNl0rdJieEiQUV1E0Zwg12lLDGHPMZQ1y9X0ZDkmX6MUFEWKx+GggO9jztM18pJz5MlDq4xp7ENXAnrINg1xFAIuOCv59gA3kMww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWIOzycHxmNV8bKu6u4wc9szsTbFVIjxNd1aXtZZ2AM=;
 b=VEMUCwg7bOlmu08AxobA/oKgzfQnX39OJtKEgpkv4KAmHf967KptyjjOSCo52mQo+cDXS3ehdM957T8sDwJZWuafBgn2jI2lCoYUb7Axx8MXaff6eosy4uTZH4egDxiG4cseZHEXqbvcyngcmq2QiIvmad/+giv0V76i9hRlCEA0lc5lkQj1e3YCffaa3AzRrY8XPqMAOXFTKi05pyuY17bJqrO4OUxp6Q5wZbXZRrhQYU8Tm29FpDnaEHeh9cNBfMMPxrUrHEUb9quEWmDa8Y5/qknbzTy1WxPiOAyStgKstsDR/A0No2NNO41Yo88PpTDcSK11jyUfQzKnEjRqJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH3PPF632600ADB.namprd11.prod.outlook.com (2603:10b6:518:1::d27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Wed, 4 Jun
 2025 09:32:10 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8792.033; Wed, 4 Jun 2025
 09:32:10 +0000
Date: Wed, 4 Jun 2025 10:32:05 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 19/25] net/intel: generalize vectorized Rx rearm
Message-ID: <aEASlf7t4G8s5coz@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1748612803.git.anatoly.burakov@intel.com>
 <cover.1748612803.git.anatoly.burakov@intel.com>
 <53edc2bd68e42152358d731d51860c8606ef13a6.1748612803.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <53edc2bd68e42152358d731d51860c8606ef13a6.1748612803.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0183.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH3PPF632600ADB:EE_
X-MS-Office365-Filtering-Correlation-Id: 846f1c70-b576-4988-76db-08dda34aae01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MlqMRliagrVqnb3lpHbHxMPpC60033q91ajBiDTEOi5mjnU6PEdtO5J3L0eR?=
 =?us-ascii?Q?3EVfXghf+fSyCDXM0tUsqtjJsgW8X0fWHRWjLzsx7dnc0Ty3fv6Fp7n7Bes7?=
 =?us-ascii?Q?USCQwn06FWvtwDDqD3NyLaroaD3l+emlPv3+rOAr5zkrVjAtslbNU875lUvS?=
 =?us-ascii?Q?RjKjqbRyoyDzqfhKz1lsmFCgDiLgAmPS7Wb5/rtr/eJostxDPu5HfP/YOb6L?=
 =?us-ascii?Q?itgcQLzAYmM9k0Q9qzlfr5bZ84B9JroxEc5mKblD2tL6l2+rj4htJF5Ni8i7?=
 =?us-ascii?Q?OCOiidspKS+ZkCK6f1NE4ZEEbsvCQQv2TGIjlWyWNHJGK4CFs8fX9z8b8Nl3?=
 =?us-ascii?Q?7j7SfNZ4Jqzb0eeN8xg9p21fjX7AYFaaVNmOf1vMAJgb/xcsDijegR48VjBU?=
 =?us-ascii?Q?gey+hhOOel9K7+VTAndZURQAuaOpOq70J8d0LKAUgqHnvU+zRnG2awJv+GEw?=
 =?us-ascii?Q?EOvQM1fRqyIYH7wTrpC3ggA2/erdjjLqFTtND9Fb9rad6NqZdOFU15qOSwwR?=
 =?us-ascii?Q?exCTIidU1/6LymEOD6K91s3fakV88OdMkAwXlAMwRi07gKAZOtsD1xJ2Rl6K?=
 =?us-ascii?Q?aCS25HcOu+cIuGCie6BpuH6HVCjQgi1PU1WiHcNPl89laMNx+7dm7Pys+ZM4?=
 =?us-ascii?Q?8RgPcI7bAtXNPHEnpA/X1mS1ZgewXoxTBv+E6GMO76L5OQ3by6kqqMN1Wkr1?=
 =?us-ascii?Q?RNlxxIzqbEkhvTkLwTGA6QkduFDem+ZBtIlErQMV3VZGeq4t9uDJ+vgwBkCX?=
 =?us-ascii?Q?G3/7IvcynFHoaVfFST2ZVQhU6f8z8NCXiAFc7GFRZs8kG4oDUy8CEUTuyMlI?=
 =?us-ascii?Q?iEqTD5ia7zUA3d6uRkShoypDlmVeIVTv0IH8tJEzM/avQqkfD2TeNC+8Mjvm?=
 =?us-ascii?Q?tk/lC8dtZ5oZcb2JvwKqEuJpX00wo9KDhwVsav8BkWixlfvwLLKGbxM4XV0p?=
 =?us-ascii?Q?SQodrfyDM0P/AJL+ZPUlvJrqwFNXBYmU9dt6e/sOlg22loyxuiZ9nglWM52x?=
 =?us-ascii?Q?fwFPvI8zNXE6voh8ra0Mw4OC/rCposMl3Ud7qosFzxVD3M/tjHc19F96wuza?=
 =?us-ascii?Q?6iwFVpcNkqku2t6YtFG60uDYRiysrasOuKHO0R612pjAgAojXWxft1BSE8Xt?=
 =?us-ascii?Q?Mm3XtGuDUPZ8TBo2RX0nVTFec7hzqX/k8e7Idn383kOBs5K1T2stTf0tq8/R?=
 =?us-ascii?Q?uIUqvq9rG9UT5/mWsuHP8XG+64yF9bkA9awL7XZh/uvkhV4kjPO5+nXb/UDN?=
 =?us-ascii?Q?0qdVj+BswJT85HTGHo9sdqdveSVKaDMpmo16sWC03iUMqNQr1oE2zcEfuSoJ?=
 =?us-ascii?Q?aciTG01lpYQmIEPLIQDoe46+tIHoD/6XdN7VCuAN8UAtXpsBMOxPYBoaR3kT?=
 =?us-ascii?Q?OOiG4RXi76sCAAEy2YqR8Q+R2r05Krj03O2qG1jf8/dkgZtablfipcf8yfpW?=
 =?us-ascii?Q?zwLaBGhg/3M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6qbi2oF4pYXl7XvksHwd0G2W3SaXh7qY3fJvTSAUDMIfglOZDy4VnK1GKBQN?=
 =?us-ascii?Q?s952oqAQ96+oz0Iwm/+I9xxLWTHcaQfwCdeOynxK/ucUW/83Vc3d/eywuNT9?=
 =?us-ascii?Q?7uccX+kLQqLmm8ZR0NNL+k8dn7yAXMLZQ13Omd6P847XCOaoRdmJd+2PgOwn?=
 =?us-ascii?Q?sx/6X+EBoVvXUwqnORsJcgXd6hLqGe1ZpBXIKlfV922Ty2kB/m/gwt+ORw3n?=
 =?us-ascii?Q?JaX638DHx/KbAycgyjQD24FmbGDBh8J0UWyfckXH9bv+vPnRo3jB8GPMA8Gk?=
 =?us-ascii?Q?7RvaTczSbfbk1oSrXvys/hPAmWhHyTFfdYzDQu3ZB8GBNvGOx1wpp0hOSX31?=
 =?us-ascii?Q?PsPNnXaxjFUQYm5oh4BD9WmPR64l05O0K2/K8w5VcBmYpDfs77wBfx9VuOAe?=
 =?us-ascii?Q?A+LhdZRc1kRqLMu6XOTYB7gE61+dXabxoLdYzekpRrUsGHPEJ/4RbGCsbGXX?=
 =?us-ascii?Q?77SJ0NCN/3W9rA/Xy+pR8zxo6lFqBGos/Z9esWNxW7mO6tiuxZ5BlsseQSOd?=
 =?us-ascii?Q?pNE6Mm0Fu09fx1maybb7EXQN79MlfZwmmk3BzuASxHfIwtGZZ4nD88c4aHbn?=
 =?us-ascii?Q?Rg3lLsmieRdOi2TMdMKLBMpqE99zWaA/sPiB9VDBeBoU21Ve2scfhHcG2nfR?=
 =?us-ascii?Q?RRRsbATpkQ3pDOaC13UMGvFnQAqk5O4R+CvrA1vN4P8dRL2B+Ww0qlZFbqnz?=
 =?us-ascii?Q?9R6KZIXpoyb4GTBGI3yJv8ubx0psrqehJViwnlA+etBc/A3kP/qNmAfhurei?=
 =?us-ascii?Q?O/5Bl7jW1PreQJrn9jalxcTiAqw2UKGCaBYInXds+dSbQohbfPbh+WSuu1P4?=
 =?us-ascii?Q?bTsuBYnl22YfGp5M4A3ksGY2jmkKln5t4/JYmS1YApLf13wfWLNV1aN2DCQh?=
 =?us-ascii?Q?vrGwzuA5sm3qR9psHvzIaqBM60zTtubSzLBTJa56mRp0x4qfj1pH/ipkmt2v?=
 =?us-ascii?Q?M6R6hX8GtlkSAw1XNhmq3cLVRQ+YFRZBE0WFuA/VWRxhPiwbeO35LC449iBR?=
 =?us-ascii?Q?RyPXmRaPZ1AP+U26D+T1eaBTxlxVd3LWc6MC9FN7Q3WELNnu3r2UR/fRRgR4?=
 =?us-ascii?Q?RQ3Lu7c5wxr2VXtvuhRWMFIchfqHpGXhNRHnaEL+OiJsVjuZJRqeOtxPak55?=
 =?us-ascii?Q?W9vUMNzBs4SMGUhFDnGPwnkLuZ+UoMTPnOLmp+3wdf+Xs0BdQN09RddgKH3Q?=
 =?us-ascii?Q?2uv9tjNR+d8XPBwVh+gooyb/C+rgeZg/rZMF8BmQix8rnpqb2a2AVNSszim5?=
 =?us-ascii?Q?Mp7l05cD+IWyhk8ruEGpWymK1ooFnyunevB4VyxoTiBALlcpGozdp7ckNfgl?=
 =?us-ascii?Q?O3Yq7mBZyTdJQnLPyLlH+h1v/rsmJ4Dy1+J+3i794t/D8SnLvyJYZtOnkLhE?=
 =?us-ascii?Q?Yf8stqeufaMD1dgovxqCbWJQHOxcDh8EFmkMwJFeuR30BojuAtZ7MeS1EeeG?=
 =?us-ascii?Q?uAOi9yZhqKmcb0WCTTqOg9/wDLCTFACt6vws0ld5H6BdTR+iKWRE0Bs/N06Z?=
 =?us-ascii?Q?esLbJvV52OA+3N3LeyvFp3+4jeDfeL+FvamcHXgXHFhELVW+vej/IWnaPyqB?=
 =?us-ascii?Q?86UpyHLtrQTee/uEPsrtnaURTOGwBYhLfRSF+tpbczjhAlIor+BAYk9lsTI7?=
 =?us-ascii?Q?Aw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 846f1c70-b576-4988-76db-08dda34aae01
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 09:32:10.0834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /WGoN+hbpCfWYqbru9y+fqA3dTetfeH+gQvjKwmgTwI19tMfnU1ed0EKXezv7TOrPHq7BiPX65YW7gVrtQyhcyJ50bEp8LDwLegSolmlVzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF632600ADB
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

On Fri, May 30, 2025 at 02:57:15PM +0100, Anatoly Burakov wrote:
> There is certain amount of duplication between various drivers when it
> comes to Rx ring rearm. This patch takes implementation from ice driver
> as a base because it has support for no IOVA in mbuf as well as all
> vector implementations, and moves them to a common file.
> 
> While we're at it, also make sure to use common definitions for things like
> burst size, rearm threshold, and descriptors per loop, which is currently
> defined separately in each driver.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
> 

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

One minor comment inline below.

> Notes:
>     v3 -> v4:
>     - Rename rx_vec_sse.h to rx_vec_x86.h
>     - Use the common descriptor format instead of constant propagation
>     - Use the new unified definitions for burst size, rearm threshold, and descriptors per loop
>     - Whitespace and variable name cleanups for vector code
> 
>  drivers/net/intel/common/rx.h               |   4 +
>  drivers/net/intel/common/rx_vec_x86.h       | 303 ++++++++++++++++++++
>  drivers/net/intel/ice/ice_rxtx.h            |  12 +-
>  drivers/net/intel/ice/ice_rxtx_common_avx.h | 233 ---------------
>  drivers/net/intel/ice/ice_rxtx_vec_avx2.c   |   5 +-
>  drivers/net/intel/ice/ice_rxtx_vec_avx512.c |   5 +-
>  drivers/net/intel/ice/ice_rxtx_vec_sse.c    |  77 +----
>  7 files changed, 322 insertions(+), 317 deletions(-)
>  create mode 100644 drivers/net/intel/common/rx_vec_x86.h
>  delete mode 100644 drivers/net/intel/ice/ice_rxtx_common_avx.h
> 
> diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
> index 8d5466eb44..cf83994c47 100644
> --- a/drivers/net/intel/common/rx.h
> +++ b/drivers/net/intel/common/rx.h
> @@ -15,6 +15,10 @@
>  
>  #define CI_RX_MAX_BURST 32
>  #define CI_RX_MAX_NSEG 2
> +#define CI_VPMD_RX_BURST            32
> +#define CI_VPMD_DESCS_PER_LOOP      4
> +#define CI_VPMD_DESCS_PER_LOOP_WIDE 8
> +#define CI_VPMD_RX_REARM_THRESH     CI_VPMD_RX_BURST
>  
>  struct ci_rx_queue;
>  
> diff --git a/drivers/net/intel/common/rx_vec_x86.h b/drivers/net/intel/common/rx_vec_x86.h
> new file mode 100644
> index 0000000000..7c57016df7

<snip>

> +
> +static __rte_always_inline void
> +ci_rxq_rearm(struct ci_rx_queue *rxq, const enum ci_rx_vec_level vec_level)

I think a comment on this function would be good to point out that since
it's inlined from the header and the final parameter is a compile-time
constant, the compiler eliminates all the branches in the switch statement
below.

> +{
> +	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
> +	uint16_t rx_id;
> +
> +	/* Pull 'n' more MBUFs into the software ring */
> +	if (_ci_rxq_rearm_get_bufs(rxq) < 0)
> +		return;
> +
> +#ifdef RTE_NET_INTEL_USE_16BYTE_DESC
> +	switch (vec_level) {
> +	case CI_RX_VEC_LEVEL_AVX512:
> +#ifdef __AVX512VL__
> +		_ci_rxq_rearm_avx512(rxq);
> +		break;
> +#else
> +		/* fall back to AVX2 */
> +		/* fall through */
> +#endif
> +	case CI_RX_VEC_LEVEL_AVX2:
> +#ifdef __AVX2__
> +		_ci_rxq_rearm_avx2(rxq);
> +		break;
> +#else
> +		/* fall back to SSE */
> +		/* fall through */
> +#endif
> +	case CI_RX_VEC_LEVEL_SSE:
> +		_ci_rxq_rearm_sse(rxq, desc_len);
> +		break;
> +	}
> +#else
> +	/* for 32-byte descriptors only support SSE */
> +	switch (vec_level) {
> +	case CI_RX_VEC_LEVEL_AVX512:
> +	case CI_RX_VEC_LEVEL_AVX2:
> +	case CI_RX_VEC_LEVEL_SSE:
> +		_ci_rxq_rearm_sse(rxq);
> +		break;
> +	}
> +#endif /* RTE_NET_INTEL_USE_16BYTE_DESC */
<snip>
