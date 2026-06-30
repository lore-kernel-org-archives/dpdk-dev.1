Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B37C43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 14:46:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D3E540691;
	Tue, 30 Jun 2026 16:46:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id E55914067B
 for <dev@dpdk.org>; Tue, 30 Jun 2026 16:46:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782830794; x=1814366794;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=IDOKeLUtMRSOt0qIR0cE8hIZqOh6nvkwglzVMkBnEJ0=;
 b=T7J9bk4eoFtgymqhFjXwzb0SVTkMsjbYz8RooNwzOOUYz0SaehdVDxQk
 nH8xlb+sKTQ6Es6GHmcV0hO05bwUozn70FuryC86bxzKUKk+pYf8ea72+
 cui/ZdFicawVMCZjBI1P1wDY64EqGfbswC7fOgftsUx1Z+TOKYQRgwshp
 fM4EUpfajDWaJAw0VwHbKphHolK7TnLLFlEW7dOA1IabQughokAX0Sz2u
 6G5JL+GUyV06hJfEvBIkFcyyu9m/0E+5erSN5kzUqn9gqPWTuuRpEoOmH
 y8CVdNxDsSldrRlzmRXZfjLcsiPVz6fEWslNYAT0TW5zXL9UmibCcscWU w==;
X-CSE-ConnectionGUID: JFcLEy14RrKpxif75IchKQ==
X-CSE-MsgGUID: tW90rQqCQ7+8v0fMzfvF0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="100972567"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; d="scan'208";a="100972567"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 07:46:33 -0700
X-CSE-ConnectionGUID: jHQAo/oNTquGwYZeyuit8A==
X-CSE-MsgGUID: obo6Nw2bSqSmHVeEVE4vCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; d="scan'208";a="251225817"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 07:46:33 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 07:46:32 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 30 Jun 2026 07:46:32 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.71) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 07:46:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1vZ7+lcxcL9yDdCr6l+0jP8KK4Yi00oReHjC1cn2bHfy6FCxdBkf5ikw9ZZI99++NMmdkV3lhbLVzolo/08ZetoIHZNOG1i+HPxZ3FbSQjMpvsiah9gj539VEv4AWyPQPfNfkfczujjxZZM2uSeOWWN4IL90K1+h8rPw/OOkd5kBGpOE+wv1d8LDPE8oLdSobuUjc2gQ4BaEw8dP4zv3Yy02y1jXLNlGCqU16orkDVu9i0OSFGhZpCFQh1B9MsCN8YomSX+vQU1J8RoPIXrruzoelatoAM2BGsW3ORDVKzYrQuFU/4HUtJwKcVvm09+cEFXk6fOa3Cyp+8StwV/mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUkIVX0jKJZR6oFEsckBGzIsTam1oS7mCJ2jzMFVdBw=;
 b=o6Z4+GX57iQ4p4yf05gQWXFX52d1AmNRoau9BnVuNJeFZbuEg74TLqKxZpb3E09Hq+/eINkKP0rWrvV+ISImse1qODVR22cArRxPnU5rCabU4UE97he14lUfFng73eLfIh31I7aixoPiK/y1FVlPuN5vZY5Z0uBsflHuZM4H4cAgsgCNVKj0lsGaUMWt38DQ80kuusfNp8V2E1Vmp+BINUyirbKvmJ2T7XmFtdJHgVNOsD76XG4sevO86wtWRQiA5Puijdyt33hiHPailj+PNOkw8Gy0jhRxbq1Wk0j773Ke1QSHARX/qxZ1M4WLnixCmPdFP0vSIC6s/kEGQ612Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by PH7PR11MB6499.namprd11.prod.outlook.com (2603:10b6:510:1f0::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 14:46:29 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 14:46:28 +0000
Date: Tue, 30 Jun 2026 15:46:24 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Dawid Wesierski <dawid.wesierski@intel.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <marek.kasiewicz@intel.com>
Subject: Re: [PATCH v3 2/6] net/iavf: allow runtime queue rate limit
 configuration
Message-ID: <akPWwOAE4Dbuvb0Y@bricha3-mobl1.ger.corp.intel.com>
References: <20260618144442.312844-8-dawid.wesierski@intel.com>
 <20260630120657.1046588-1-dawid.wesierski@intel.com>
 <20260630120657.1046588-3-dawid.wesierski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260630120657.1046588-3-dawid.wesierski@intel.com>
X-ClientProxiedBy: DU2P251CA0012.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::8) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|PH7PR11MB6499:EE_
X-MS-Office365-Filtering-Correlation-Id: 670a55aa-23ca-4352-f8dc-08ded6b65e42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|11063799006|56012099006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: S+MiT6lcp8TQRR2h3tNwGUlm+qc1/uIZc8F9D7FldXnb0gvwW1yqcrxmS39E1dtK4PbAO4ufxaKeMAEPkBSx9epy7SDh2dqscj6yYEnASyoRlXlq79vGZ+waZTIv0WnOCOzmcAUW3jG9kHtbul9foGVfLNv+qg8NzW7znWHVmHHLWvq+Ndi57sm5zZmahXUolFCtAkvk/X66EjFyKP7i39yORxcbvKQaCel7K8dGhgdeW6hsL6hf0NPo6/2qw04uUxFQgT9P2rfucTs5agVPZO77DFMf/QeO/hEmQ+1w4L+4TjkVhCAlEQshr7qo3hDTMDDNBvDvFX/gzaqA++FdEa3QK4J249PGyS6HSWcWaWWATY9Z4WfHavLessEa7myFt8+2njjB/jtx9svGXJEdviIEZQMljdvAB5YRbINtxuo9v/Qbcoj7MNNEGVDMppRzy26jngVHY20ZZA4LNJ/pgCgZz4vQK+3xpP3N20pH2GM8h8+3DdBNgS1CUrq7werLuBce85h0bOW8bfGWKJl51AP35lvdt2UyhR6asO16bkgcAC5r1ToKfxVC/do6afjGBYI4+/PHomih5P9wrfQbKGdvor8bG84is/JQU6Q0RG7Xim1P8lBnQ6ud/0Se7Wx/Nc1WLqnyNKQpbldZs9e5wuaVGKYV/WwyV46OBjnAZIs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sGAVDlu1H6K6XoSlJz4oo31vgNA/s3X2hRWJlYg11Nna2uZFnYUbr2AEsOuQ?=
 =?us-ascii?Q?AfYHa8f2DmYWk6kFxPHUZ0RWqvLCGsM3DImPr1cINk0hOBepsA01CWo2fiIy?=
 =?us-ascii?Q?V4YmlNcVwKu1sew8f8Nazsf7JR51X07gchE3rRmcrVqFveaXZRW8mh8fsjuF?=
 =?us-ascii?Q?dYqExDb7LnR+hnSlJkVtuwm8McNmtG43FVK3O6Vx5GXSkRE3hphM27eRShQ2?=
 =?us-ascii?Q?RFtT5ppK1CtzMRnZWFOF06sB8812HIAPbVAdw6Bx817UEa6jcDH7om9QVNwO?=
 =?us-ascii?Q?dn1LzKg/1J0BAAoOLOqp47xDqn7SQ0Lu3fhE/9x5TeS6Jt0dDizT8dGnhTP2?=
 =?us-ascii?Q?Mnwyx6WGGA1ghZ3RZUxcxG/sLwgLoQGmzic+CguONfqFp+rScT7OP14MjQRE?=
 =?us-ascii?Q?t7uuZCraK4MVmV8Guv8vEUPRiEhcs+YT6lNggp/dUTlpLXnrhYSRgGbofgIg?=
 =?us-ascii?Q?nlUN9YQwEz+ebS6r2//M6FnEdoCtPwSOD5k6jN77hAAKjoMxgUeX99WBkTZS?=
 =?us-ascii?Q?rD1nG4stL8qVmPPgobwa5S8yKwjzaSpSyfCdhZvVADHymiK46iVwepu4sGAj?=
 =?us-ascii?Q?IuqzJW535cbW7Et5A7M/+eWNJWHlkKDm4q+2YLHGOGhCjnQyhTNQ8/hvUu61?=
 =?us-ascii?Q?04jtU4wgAh2ZxcESdf+VNdC1AJQBurlrJz9HUkOeL7mKDYqENUmslbjCc64w?=
 =?us-ascii?Q?2iwSMiGqTNxYsorGd0FVFAOPu9lDFxJvRXrOOuZQsRd2TMvmbq4j0Mzs1RZG?=
 =?us-ascii?Q?aKhItrQ+y+oiaXgPw0GiMrIYxNny1/WE/p+c0Qbd6CQ4QYt4KRqoUIdAZ/KV?=
 =?us-ascii?Q?yCjubQIdtNHAytNADaQDNWYH6siw6xU/c0W3TDFqFYEtZodTUxXBKn7i2NYA?=
 =?us-ascii?Q?OhzFjkyN/fd0b6ukMcfA68CORyfgbN9mXHgAL/AJjopYDf61PLD9/E5EXHqQ?=
 =?us-ascii?Q?U6OmdmYtEbBqKol1WNR5AYoBLiwxhWLa/ZrZEZzFvSBoGc/qXZzo1Bj/AcF3?=
 =?us-ascii?Q?lZXGg2759Hztm3qRR8Xim8iU5euriGVqY+L+JhceSmar6aAdgRdEaL5D19qj?=
 =?us-ascii?Q?BdTmOLrB/TCC5X4NFTEsAF5YsKl0ifNV+i8qnDJ4QIzgIMfWT8dWN23zS8jy?=
 =?us-ascii?Q?2Pft7JetNALXgfcuZFu+LlmGu1L7R2B0VSJ41CJ3OQYjg/SBiKjU+YJFcMl6?=
 =?us-ascii?Q?yfA8GPl+v3gGfs5GvLIvjQ82VP7XA95ntCxFKtTH21iFacsRq13AODgEuGvK?=
 =?us-ascii?Q?iApw4nv757ZXWfOmR3PC3UT2AwSCJZa70t3YTmOstCski1Vb8o+54GCJFXbc?=
 =?us-ascii?Q?oQwzosiyHMjFji1t24RKR9VY3uYQ3z7y9idZml4IH/xYItjkmNIoEO01SQZC?=
 =?us-ascii?Q?jxP/bl+vmCNa+UUADCwRlWQxagM/dvSEDkMoEDPlpM0FUpgjigtjcKMjrZpl?=
 =?us-ascii?Q?fLWObLzHql7bdP+bYE3scPG5YprhVPzNFKGRjqKFxLvkmqYYzU0rn6IzmF+O?=
 =?us-ascii?Q?usJnyCTE7YbdBRxyzV1rFNivn/jlqiqIIgdoxVoFPrwuT9kq7/K8UtigbrTq?=
 =?us-ascii?Q?5lwXm/okGdyGxCXwkkdQ88r8MRaTjqjnLJT1OYm+7A/77OvrRBdDrexb7Tb2?=
 =?us-ascii?Q?Ca5QO+Iamm4eMGQbNXW0i4pC+jL7yn59s0xQxYMsuobKouUH/J8irnRrS8fk?=
 =?us-ascii?Q?7rKVWmswYPd9PdIo1mxdrbb+PYoqlVrNUtfh7H8ATfZ4FwLYRC/d99JPFxm0?=
 =?us-ascii?Q?6di6dxYNkQMivbXvW9zo1VKvcdvuu14=3D?=
X-Exchange-RoutingPolicyChecked: gJKapKKdCfSHW6SrQnPRigyjDKCdXrSy7ALuj5qODusiqdYUAouMs2qZe1j4bAgSjqqTKlG2eM9YksfsJcv3cnJ36EFQaLil7sjmIwK3WoGAtBRN5uqM175M0pIU9+Q/DsTJxrrCSnpo4Rugs4TCNKZh8qDnuujMPwiqzj2YGt6WJOEbUO5VfAOgo6PIpUPdVQ+6t5FTw3ADzhX545M/tifviP3YqN4/lqMcD0Z2/CAEqOb0pebRDKQVO+a1YV5YpplndLqzJS0P5CKqdwdYJ6mJylzP0KV9dpbYq7EaNZkiFW8CN1RpE49xbGQlAEG9OFK3vLkMXwNvsFTAdZzdhw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 670a55aa-23ca-4352-f8dc-08ded6b65e42
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 14:46:28.8654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSR8kzDYvTFUdsSVMOzQ5EFxwF9e1yM+4IIvVnGMzTggkVd/cd0cJ3g+/4/RfUPx7NJssP1ey+f+lywEzM1sbfACIUnhxyFitxRgFZ8iFLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6499
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

On Tue, Jun 30, 2026 at 08:06:52AM -0400, Dawid Wesierski wrote:
> From: Marek Kasiewicz <marek.kasiewicz@intel.com>
> 
> Allow per-queue bandwidth rate limiting to be configured without
> stopping the port when only a single TC node and single QoS element
> are involved. This enables dynamic session management where individual
> queue pacing rates can be changed while other queues continue
> transmitting.
> 
> Also fix the queue ID assignment in the bandwidth configuration to
> use the actual TM node ID rather than a sequential counter index, and
> only mark the TM hierarchy as committed when the port is stopped to
> permit subsequent reconfiguration.
> 
> Signed-off-by: Marek Kasiewicz <marek.kasiewicz@intel.com>
> Signed-off-by: Dawid Wesierski <dawid.wesierski@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_tm.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 

AI review that I ran indicates that this function has some memory leaks
around the tc_mapping, q_bw and qtc_map variables, which are allocated
using rte_zmalloc. However, those are not introduced by this patch, so ok
to take this as-is for now. We should look to ensure leaks are fixed in
future patches. (Also, we should ideally change from using rte_zmalloc to
regular malloc/calloc, unless there is a strong reason why the need these
nodes in hugepage memory).

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


> diff --git a/drivers/net/intel/iavf/iavf_tm.c b/drivers/net/intel/iavf/iavf_tm.c
> index 1cf7bfb106..e3492ec491 100644
> --- a/drivers/net/intel/iavf/iavf_tm.c
> +++ b/drivers/net/intel/iavf/iavf_tm.c
> @@ -804,19 +804,25 @@ static int iavf_hierarchy_commit(struct rte_eth_dev *dev,
>  	int index = 0, node_committed = 0;
>  	int i, ret_val = IAVF_SUCCESS;
>  
> -	/* check if port is stopped */
> -	if (adapter->stopped != 1) {
> -		PMD_DRV_LOG(ERR, "Please stop port first");
> -		ret_val = IAVF_ERR_NOT_READY;
> -		goto err;
> -	}
> -
>  	if (!(vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_QOS)) {
>  		PMD_DRV_LOG(ERR, "VF queue tc mapping is not supported");
>  		ret_val = IAVF_NOT_SUPPORTED;
>  		goto fail_clear;
>  	}
>  
> +	/*
> +	 * Allow reconfiguration on a running port only when a single queue is
> +	 * involved (single TC node and single QoS element); otherwise the port
> +	 * must be stopped first. qos_cap is valid here because the
> +	 * VIRTCHNL_VF_OFFLOAD_QOS capability was checked above.
> +	 */
> +	if ((vf->tm_conf.nb_tc_node != 1 || vf->qos_cap->num_elem != 1) &&
> +	    adapter->stopped != 1) {
> +		PMD_DRV_LOG(ERR, "Please stop port first");
> +		ret_val = IAVF_ERR_NOT_READY;
> +		goto err;
> +	}
> +
>  	/* check if all TC nodes are set with VF vsi */
>  	if (vf->tm_conf.nb_tc_node != vf->qos_cap->num_elem) {
>  		PMD_DRV_LOG(ERR, "Does not set VF vsi nodes to all TCs");
> @@ -856,7 +862,7 @@ static int iavf_hierarchy_commit(struct rte_eth_dev *dev,
>  		q_tc_mapping->tc[tm_node->tc].req.queue_count++;
>  
>  		if (tm_node->shaper_profile) {
> -			q_bw->cfg[node_committed].queue_id = node_committed;
> +			q_bw->cfg[node_committed].queue_id = tm_node->id;
>  			q_bw->cfg[node_committed].shaper.peak =
>  			tm_node->shaper_profile->profile.peak.rate /
>  			1000 * IAVF_BITS_PER_BYTE;
> @@ -900,7 +906,8 @@ static int iavf_hierarchy_commit(struct rte_eth_dev *dev,
>  		goto fail_clear;
>  
>  	vf->qtc_map = qtc_map;
> -	vf->tm_conf.committed = true;
> +	if (adapter->stopped == 1)
> +		vf->tm_conf.committed = true;
>  	return ret_val;
>  
>  fail_clear:
> -- 
> 2.47.3
> 
> ---------------------------------------------------------------------
> Intel Technology Poland sp. z o.o.
> ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
> Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.
> 
> Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
> This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.
> 
