Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7654FCA5FF1
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 08:03:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA6FC40290;
	Wed,  7 Oct 2026 10:03:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id BD44640264
 for <dev@dpdk.org>; Wed,  7 Oct 2026 10:03:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791360225; x=1822896225;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=bpvC9XeTybKW/5ahwonv/Uf/Y+HqoQCFt3gaT26nCiQ=;
 b=XNUK410Vbac6d3WFc2aG7CZH76EOT48cXjYgHVtp0BJMdh2tfsAyp8kA
 qEqzPm6RNYaDEJa/rchk96Tqq+KzbSTnoZ+ib7fC4SL6112ecgO3ZxaRo
 wqNqdXGiYJXbkxXSVtitvCrwMUvkput8yxy5DEx9R9h+NNxrfTRqJp4tf
 1eyrKUeT2jj3gE5K/PQeXtuYaMgjM4OZ4ar+MC6mYumdjSuUDd+O6nBbr
 yECV2VuDVy/vcYJLtSDaTUc1h587SbX3IIiMSmwMVPi6/MBCE6Pb/GWDn
 wxQrAT7wmRW1qrdCZoTjwl9YS5BDgqZtrAZcCyw3CfLitE1UgvS/tVNXJ Q==;
X-CSE-ConnectionGUID: R4/gGIKtQ+GNoJoWqvjarg==
X-CSE-MsgGUID: mfZL3eW2R8ef/zXwvYbUxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="10418"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="10418"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 01:03:36 -0700
X-CSE-ConnectionGUID: Kq6o+3awRuSlLLnDJZ6QTw==
X-CSE-MsgGUID: /dKENo9JQZCbrQ9s3vrQCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="126253"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 01:03:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 01:03:35 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 7 Oct 2026 01:03:35 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.17) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 01:03:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h89NraY66D9IM/fELZE6c7aHRvZV2U56mJim2bngShbteXuusUf6LG26YmZ0EoAU7m/pkZH5kK3jAfJry47T+a/TGoaUr9+2ZcMQ5GOSw7otWFKB/JgkSvx0hZHi/V7OELM2uChdqSz5ZL4PMtBWkeQ/2MN6i+qbaGP9l0gPdDdpB2SmLZndIOVVGkWSOdJ9wadlwzrrB4cdO8VZY833myyFxe9k5jMm8IfTmY6XI6PJNRnZBWtXhQ5ZMB1XuU7vLC2jaIW2lP6qpmR6ydCodWWuE8XMaq+uHk3LJwU97dcTdtxq4YKtnDgwy4zAKbh7/vB5J5RTUlA1ZnTiK7N5ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNzxOv0185np5Y/rGRWrfhNKjA0va7V0G0gJyNnAbiA=;
 b=GNpCSp7wa1TJOePSmvRMlBEmE3C/8fi/zwkfyGGd/1wfniJOfv0dWaqQ2vJw9FkJeHntbEh4YZ0TFEp2rBlojvlxFZKxaEEZ6zcsOmXwL0YcpudbMqJNkfL6BFltsAAZryLV/oG/ddtXknoCcth1hjol60Z1eikcdNuzxxQWS7+rjVytsQeo+cjZ4F7dPLH8m7v4AqvE11E7im8JkHTUFQiq+290MItwC5PIrvfof8S73ZJX+9uKhkXfwQuiwsy5pxDrbPqGyuNKVXEnDEhg3dh8HYglERLsHpDZDIdA1pXTMRcyPzsujlXb7LSWAi5fCbECc9eqzJcLo3ClSkkseA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DS6PR11MB798475.namprd11.prod.outlook.com (2603:10b6:8:528::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 08:03:28 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0451.014; Wed, 7 Oct 2026
 08:03:27 +0000
Date: Wed, 7 Oct 2026 09:03:23 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] metrics: remove experimental telemetry helper API
Message-ID: <asX8y0Nv8APsp8ct@bricha3-mobl1.ger.corp.intel.com>
References: <20261006233144.644562-2-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261006233144.644562-2-stephen@networkplumber.org>
X-ClientProxiedBy: DU7P191CA0007.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::32) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DS6PR11MB798475:EE_
X-MS-Office365-Filtering-Correlation-Id: 649ccc9c-d43a-4538-ab66-08df2449782c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|5023799004|11063799006|3023799007|260925021911599003|10067099003|56012099006|260925021311599003|260925022911599003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: XJO5IFvJXxMNK1FCfvAawfZzi+PxngIxMaP19kzrBOfxNTZlS+br1REhlC+JwsuJGoKcY/yV9dzjrLdhS9M7gCGQRGAM9RzK1vFjURlN8tVutaBw04dAsPgcCUZ3Uisp5+RT2PGz1pqxA2T9loJVWUw7CL5MmqbE3yOFYmN9h2MDzJNLYy9FA1kkrKgRqIXboSSqsGZoG9ulDo83jS88MTb+95vWU3FQyCgZ01KJOuzqtufJ0oWzvTxYQV+IOmBNqebIg3rnGVqxmRj9JVxNfnGZOI8V5UTxMwtqzelJ0u2Vfk6zunqgbjvUrd8fGHZO8pVB5RntCC5pj6HsQ+QDyKoj5eevig6ocSsr+wLIqHbjq65DjJcx3ULLQSkp83qPZQsqOecNuulVWX3NRBhvGclOqNlOuEh7mg/dywVwwTKNO/iNM0YM8W760OJuOtqy+RiNjR0ta6GYJZ0S1dnBihuIshGi/YpUu+K/gHxQJ3k/j/PxYVHiNse5968lT0cDs9TnFn370ZsyZawwWiTYbPnycdnInp4CGE/fYIRRTRGyRSvPcjW5aTuDN8vtuYj+sgxyY86BdSv3mvdL0xm1D6gJwzmBL/u7S73FbCC+6aN+MfG03DmlxY7qzXOBOwmNeZFZQ7BxEWob2TX+X4SGsLbMbLIiErJbCo6LTq284B8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(5023799004)(11063799006)(3023799007)(260925021911599003)(10067099003)(56012099006)(260925021311599003)(260925022911599003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bFfr5R9dMrx3L6ejkxXxqIxlR+iv8IAgxOPoN+xs3j3FfMQ1I7oyEW4ZVYtd?=
 =?us-ascii?Q?Juny3c5Ru7g3nZ1LeaZf15p9WWsrk20UIiBAX69l/xYQoBRlJPHaeP0LXiZc?=
 =?us-ascii?Q?VwAcR2krs+2HeIpd+7ZEKfxoaYi0hhFCR08ZSpHXfn9iuKtTXLrdDSdQFP4l?=
 =?us-ascii?Q?BRUB75dmn0F0grjQxJLHjSFHA5PxsjyFRTfXJykLXJSXSJdab3iBrBPPHS/6?=
 =?us-ascii?Q?onFzHyz/k7AdebNP4aNb9eCJlp68HcoU5QI6ZAux7LX4kHy/2N8s3Qji5kal?=
 =?us-ascii?Q?4f62ZiDQ7U82xzDTlCu1yXr9vtQQbd7j3Ikx/6x0RLAn/vCYEeszEiwJrg1R?=
 =?us-ascii?Q?94w1HxD8uR65qPQs00TfQYaesMCDUc0bjpFTxIfTJtrUe4ftwki3RjCGnE02?=
 =?us-ascii?Q?6ANHdVIGeD3e1z8PtjNTrJ8D5ojumiGW+Q/eav/JLqEpvaPSvOJ+qN5GwsuM?=
 =?us-ascii?Q?dtdj1HA7o8QetfnY0fRKpW63MHmLya55oihJdHVushdhy8zSGsCLgu8Svktw?=
 =?us-ascii?Q?x+pcxrkLQuwkXuW6yi7JVXJSLbuVxj7QoZItGImCOhMUMIEVBlWMSxWhpWfC?=
 =?us-ascii?Q?lSzTfgszZwlzzEtpcN8yljKKC9foiEkvZ9Tj8ztfwLb3HgPvw8LT3c3+EBwf?=
 =?us-ascii?Q?pSFACgpC2Ha0BcsGDg2IZchcIwgyIjXIm38iI4VGjsGcIjP4EzCf39HPCP+L?=
 =?us-ascii?Q?9WSweJOZLzlGl1WlMFzFlsbJFwTYDEZ64mmKNezv9Buf/3TCCBn+J54toBxm?=
 =?us-ascii?Q?fNnCUds+WgypfEdvC/cT6s4uF1NS3VVGEMgvp87ToZEfZW97R7n4PBwlOQzg?=
 =?us-ascii?Q?Lj7rH8yHZsaotrFU/IweMQQrBwoGjhFY/jA2IrL0yT26OJ0Gxx3A29FRANzy?=
 =?us-ascii?Q?OTeAnPaIWMw2j/JRi8wRDgNb4NB3Pr/YD8Jn5bhleCs7buemyGLQxAfBwPaE?=
 =?us-ascii?Q?iEtcMSZlyWT2PzOAQ25d75wKNulB7uDlFO5AfM+scYYJJO2iPrz7Q0YdF3sh?=
 =?us-ascii?Q?sih/ssVV11PJ52Ocl/OlmGbZDHAoJhsCdSIlCnTI0hKNtTyKwt9tOCvjbYUd?=
 =?us-ascii?Q?oEYVmdBx2fr2YD/qEqZ4nov3XBAuy7HDa4BBDCHAKJmUPu1r8fB77X45Oo3G?=
 =?us-ascii?Q?odlmcfmo8FuOqBlAe2Vf2ZLKOm5F0oVV0q8WbksMstnIna+vvjN5Xe32nmv2?=
 =?us-ascii?Q?K3M9YgCW0XrZxQ6jAQJlBas3+eudVKOe6l6mvkyEkRKI+8S7cT3PNIlilY8C?=
 =?us-ascii?Q?P8h0NAJXgRjkr5H42uBZiFQepVLTbBN3KmEj3L15Gg7XeXNsmvvbpfd94b5l?=
 =?us-ascii?Q?FZXEUSGZvaF/WHk64w8rxzwejUIhFUjT4TrEhORAqiOlIBqdId2WIFUk7yeP?=
 =?us-ascii?Q?YuRkmsFSJlC6hEjaJ49946ozXHPcaxDBg3L0nRLtO/gQg+DQBFOOCKzHLgiF?=
 =?us-ascii?Q?qAXnyc66lJEz1ng79VDwS+Dg91pvhyFBS2SiXNIAqDn075BD2g5Bq7169ICo?=
 =?us-ascii?Q?Janqp19kF+4QYnZh88IF78Xa5BEOn/p0WdD97CP4yZ6E7ttfMfo2CqKwGX/2?=
 =?us-ascii?Q?cMVgHerbkCHzyFFRtkIc4FuxOyIpSXJoVKlBVXoFbC5+o4BW+N3TRMHqlaIS?=
 =?us-ascii?Q?nTc8KZuk0J3DXzg4zRGw8IO+Mw1FOAYP5fVW1uVzyctTqsr0mwD4M1S26q6K?=
 =?us-ascii?Q?sMxrmv33R59q0vKmGNJJE+9cobVoDBxcx6kuK1V3q5WQnbdzPfcOdrdytW+0?=
 =?us-ascii?Q?frZKFlKh0mwjmOYXIqIfw1bCFi0cBTE=3D?=
X-Exchange-RoutingPolicyChecked: LzB2W7VC+AWL41/71h5/XFvfa20FYrVki5ywOfpLjGhg2BgpvU0wHMEt3q+1kwdHIpL1nsMxbTbwIfkM7XYQT6FF2uKY5AANzASoa9Tt0D7NUGiOOjm/zc8Wv5nDEi7GPjD4NiXhtPVz/TNzIu/XTfuvDy5vSh/G2SyX4R8lr7BHvQn6lb7CbkKOvsA+0HOdmxHLauHgYO/zCpb2AFP/VEuirrt1KMYX2t/ELnEpdtYG2bHMrawC5qTdqDg0DW8lr1o5E+qxwfddxoTj9RHUq8DvkI3dSmpi+5S/ixLT588aMrTU9LmFhwwzp+jllnWx0oY4b3U3GtnKhCIvpGThAQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 649ccc9c-d43a-4538-ab66-08df2449782c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 08:03:27.9268 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 75RsbfDOR2OBBRl57wCzTMVvexizwK8vUSulfCXXT8qswubxRj2YG1ypV3yIzJACp1Qi4e+h1G8OXg8hm5awxaQzrUmN9FbCCMeeM+bXzC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB798475
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

On Tue, Oct 06, 2026 at 04:31:44PM -0700, Stephen Hemminger wrote:
> While investigating experimental functions leftover in DPDK.
> 
> The rte_metrics_tel_* functions are dead code. Nothing in the tree
> calls them from outside the metrics library itself; they were left
> exported by the telemetry library rewrite in 20.05.
> 
> Stop exporting them. Delete the header, move the types into the C file
> and make the helpers static. The file now only builds when jansson is
> present, so the stub branch goes away too.
> 
> The legacy commands ports_all_stat_values, global_stat_values and
> ports_stats_values_by_name are unchanged.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  doc/guides/rel_notes/release_26_11.rst |   9 +++
>  lib/metrics/meson.build                |   6 +-
>  lib/metrics/rte_metrics_telemetry.c    | 106 ++++++-------------------
>  lib/metrics/rte_metrics_telemetry.h    |  71 -----------------
>  4 files changed, 39 insertions(+), 153 deletions(-)
>  delete mode 100644 lib/metrics/rte_metrics_telemetry.h
> 

In the process, should we post a deprecation notice for the whole
metrics-based legacy telemetry system? It's been superceded for many years
now and it has a lot of limitations: supporting ethdev only, having
globally registered stats (so if you have two different NIC types, you get
a list of all stats names for both whatever port you query), and probably
more beside. That would allow us to remove a large enough chunk of code in
a future release.

/Bruce

> diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
> index 934efaaf93..254e9ada64 100644
> --- a/doc/guides/rel_notes/release_26_11.rst
> +++ b/doc/guides/rel_notes/release_26_11.rst
> @@ -195,6 +195,15 @@ Removed Items
>    which were based on the legacy pipeline library API.
>    The ``pipeline`` example application covers the SWX pipeline API.
>  
> +* metrics: Removed the experimental telemetry helper API
> +  and the ``rte_metrics_telemetry.h`` header:
> +  ``rte_metrics_tel_reg_all_ethdev``, ``rte_metrics_tel_encode_json_format``,
> +  ``rte_metrics_tel_get_global_stats``, ``rte_metrics_tel_get_port_stats_ids``,
> +  ``rte_metrics_tel_get_ports_stats_json`` and ``rte_metrics_tel_extract_data``.
> +  These had no users and exposed jansson types in the public header.
> +  The legacy telemetry commands ``ports_all_stat_values``,
> +  ``global_stat_values`` and ``ports_stats_values_by_name`` are unchanged.
> +
>  * net/iavf: Removed the ``auto_reconfig`` devarg.
>  
>    The restoration of the promiscuous and all-multicast settings after a VF reset
> diff --git a/lib/metrics/meson.build b/lib/metrics/meson.build
> index 6722f666d2..0e32a08dc3 100644
> --- a/lib/metrics/meson.build
> +++ b/lib/metrics/meson.build
> @@ -1,10 +1,12 @@
>  # SPDX-License-Identifier: BSD-3-Clause
>  # Copyright(c) 2017 Intel Corporation
>  
> -sources = files('rte_metrics.c', 'rte_metrics_telemetry.c')
> -headers = files('rte_metrics.h', 'rte_metrics_telemetry.h')
> +sources = files('rte_metrics.c')
> +headers = files('rte_metrics.h')
>  
> +# Legacy JSON telemetry commands are only available with jansson.
>  if dpdk_conf.has('RTE_HAS_JANSSON')
> +    sources += files('rte_metrics_telemetry.c')
>      ext_deps += jansson_dep
>  endif
>  
> diff --git a/lib/metrics/rte_metrics_telemetry.c b/lib/metrics/rte_metrics_telemetry.c
> index f9ec556595..2350ef5041 100644
> --- a/lib/metrics/rte_metrics_telemetry.c
> +++ b/lib/metrics/rte_metrics_telemetry.c
> @@ -2,19 +2,35 @@
>   * Copyright(c) 2020 Intel Corporation
>   */
>  
> +#include <jansson.h>
> +
>  #include <ethdev_driver.h>
> -#include <eal_export.h>
>  #include <rte_string_fns.h>
>  #ifdef RTE_LIB_TELEMETRY
>  #include <telemetry_internal.h>
>  #endif
>  
>  #include "rte_metrics.h"
> -#include "rte_metrics_telemetry.h"
> -
> -#ifdef RTE_HAS_JANSSON
>  
> -struct telemetry_metrics_data tel_met_data;
> +enum rte_telemetry_stats_type {
> +	PORT_STATS = 0,
> +	GLOBAL_STATS = 1
> +};
> +
> +struct telemetry_encode_param {
> +	enum rte_telemetry_stats_type type;
> +	struct port_param {
> +		int num_metric_ids;
> +		uint32_t metric_ids[RTE_METRICS_MAX_METRICS];
> +		int num_port_ids;
> +		uint32_t port_ids[RTE_MAX_ETHPORTS];
> +	} pp;
> +};
> +
> +static struct telemetry_metrics_data {
> +	int reg_index[RTE_MAX_ETHPORTS];
> +	int metrics_register_done;
> +} tel_met_data;
>  
>  int metrics_log_level;
>  #define RTE_LOGTYPE_METRICS metrics_log_level
> @@ -72,8 +88,7 @@ rte_metrics_tel_reg_port_ethdev_to_metrics(uint16_t port_id)
>  	return ret;
>  }
>  
> -RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_reg_all_ethdev, 20.05)
> -int32_t
> +static int32_t
>  rte_metrics_tel_reg_all_ethdev(int *metrics_register_done, int *reg_index_list)
>  {
>  	struct driver_index {
> @@ -227,8 +242,7 @@ rte_metrics_tel_format_port(uint32_t pid, json_t *ports,
>  	return ret;
>  }
>  
> -RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_encode_json_format, 20.05)
> -int32_t
> +static int32_t
>  rte_metrics_tel_encode_json_format(struct telemetry_encode_param *ep,
>  		char **json_buffer)
>  {
> @@ -281,8 +295,7 @@ rte_metrics_tel_encode_json_format(struct telemetry_encode_param *ep,
>  	return 0;
>  }
>  
> -RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_get_ports_stats_json, 20.05)
> -int32_t
> +static int32_t
>  rte_metrics_tel_get_ports_stats_json(struct telemetry_encode_param *ep,
>  		int *reg_index, char **json_buffer)
>  {
> @@ -312,8 +325,7 @@ rte_metrics_tel_get_ports_stats_json(struct telemetry_encode_param *ep,
>  	return 0;
>  }
>  
> -RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_get_port_stats_ids, 20.05)
> -int32_t
> +static int32_t
>  rte_metrics_tel_get_port_stats_ids(struct telemetry_encode_param *ep)
>  {
>  	int p, num_port_ids = 0;
> @@ -379,8 +391,7 @@ rte_metrics_tel_stat_names_to_ids(const char * const *stat_names,
>  	return 0;
>  }
>  
> -RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_extract_data, 20.05)
> -int32_t
> +static int32_t
>  rte_metrics_tel_extract_data(struct telemetry_encode_param *ep, json_t *data)
>  {
>  	int ret;
> @@ -547,68 +558,3 @@ RTE_INIT(metrics_ctor)
>  			handle_ports_stats_values_by_name);
>  #endif
>  }
> -
> -#else /* !RTE_HAS_JANSSON */
> -
> -RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_reg_all_ethdev, 20.05)
> -int32_t
> -rte_metrics_tel_reg_all_ethdev(int *metrics_register_done, int *reg_index_list)
> -{
> -	RTE_SET_USED(metrics_register_done);
> -	RTE_SET_USED(reg_index_list);
> -
> -	return -ENOTSUP;
> -}
> -
> -RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_encode_json_format, 20.05)
> -int32_t
> -rte_metrics_tel_encode_json_format(struct telemetry_encode_param *ep,
> -	char **json_buffer)
> -{
> -	RTE_SET_USED(ep);
> -	RTE_SET_USED(json_buffer);
> -
> -	return -ENOTSUP;
> -}
> -
> -RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_get_ports_stats_json, 20.05)
> -int32_t
> -rte_metrics_tel_get_ports_stats_json(struct telemetry_encode_param *ep,
> -	int *reg_index, char **json_buffer)
> -{
> -	RTE_SET_USED(ep);
> -	RTE_SET_USED(reg_index);
> -	RTE_SET_USED(json_buffer);
> -
> -	return -ENOTSUP;
> -}
> -
> -RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_get_port_stats_ids, 20.05)
> -int32_t
> -rte_metrics_tel_get_port_stats_ids(struct telemetry_encode_param *ep)
> -{
> -	RTE_SET_USED(ep);
> -
> -	return -ENOTSUP;
> -}
> -
> -RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_extract_data, 20.05)
> -int32_t
> -rte_metrics_tel_extract_data(struct telemetry_encode_param *ep, json_t *data)
> -{
> -	RTE_SET_USED(ep);
> -	RTE_SET_USED(data);
> -
> -	return -ENOTSUP;
> -}
> -
> -RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_metrics_tel_get_global_stats, 20.05)
> -int32_t
> -rte_metrics_tel_get_global_stats(struct telemetry_encode_param *ep)
> -{
> -	RTE_SET_USED(ep);
> -
> -	return -ENOTSUP;
> -}
> -
> -#endif /* !RTE_HAS_JANSSON */
> diff --git a/lib/metrics/rte_metrics_telemetry.h b/lib/metrics/rte_metrics_telemetry.h
> deleted file mode 100644
> index dd84f5431e..0000000000
> --- a/lib/metrics/rte_metrics_telemetry.h
> +++ /dev/null
> @@ -1,71 +0,0 @@
> -/* SPDX-License-Identifier: BSD-3-Clause
> - * Copyright(c) 2020 Intel Corporation
> - */
> -
> -#ifdef RTE_HAS_JANSSON
> -#include <jansson.h>
> -#else
> -#define json_t void *
> -#endif
> -
> -#include <rte_compat.h>
> -#include "rte_metrics.h"
> -
> -#ifndef _RTE_METRICS_TELEMETRY_H_
> -#define _RTE_METRICS_TELEMETRY_H_
> -
> -#ifdef __cplusplus
> -extern "C" {
> -#endif
> -
> -enum rte_telemetry_stats_type {
> -	PORT_STATS = 0,
> -	GLOBAL_STATS = 1
> -};
> -
> -struct telemetry_encode_param {
> -	enum rte_telemetry_stats_type type;
> -	struct port_param {
> -		int num_metric_ids;
> -		uint32_t metric_ids[RTE_METRICS_MAX_METRICS];
> -		int num_port_ids;
> -		uint32_t port_ids[RTE_MAX_ETHPORTS];
> -	} pp;
> -};
> -
> -struct telemetry_metrics_data {
> -	int reg_index[RTE_MAX_ETHPORTS];
> -	int metrics_register_done;
> -};
> -
> -__rte_experimental
> -int32_t rte_metrics_tel_reg_all_ethdev(int *metrics_register_done,
> -		int *reg_index_list);
> -
> -__rte_experimental
> -int32_t
> -rte_metrics_tel_encode_json_format(struct telemetry_encode_param *ep,
> -		char **json_buffer);
> -
> -__rte_experimental
> -int32_t
> -rte_metrics_tel_get_global_stats(struct telemetry_encode_param *ep);
> -
> -__rte_experimental
> -int32_t
> -rte_metrics_tel_get_port_stats_ids(struct telemetry_encode_param *ep);
> -
> -__rte_experimental
> -int32_t
> -rte_metrics_tel_get_ports_stats_json(struct telemetry_encode_param *ep,
> -		int *reg_index, char **json_buffer);
> -
> -__rte_experimental
> -int32_t
> -rte_metrics_tel_extract_data(struct telemetry_encode_param *ep, json_t *data);
> -
> -#ifdef __cplusplus
> -}
> -#endif
> -
> -#endif
> -- 
> 2.53.0
> 
