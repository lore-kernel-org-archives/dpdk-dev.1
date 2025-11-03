Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3D6CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 15:11:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E617402D5;
	Mon,  3 Nov 2025 16:11:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 50F4840281
 for <dev@dpdk.org>; Mon,  3 Nov 2025 16:11:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762182669; x=1793718669;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=eE+s7FXKEoighV+tLJj4IoHdSBhIsoscoXRQZi2jjW8=;
 b=JkzK5h1R6vkit7s8NJBoJ3gbZp+gA+OvAaWGVGBXI3HKUD2Rs5Wx2rzF
 zDqAgrCwmH+MoWDvlNVIN1I6KilNAO6GKaLd8aSe1d2RgolikStLQcNzS
 EuGJdUkSbLmfFt+LCb3sSxSSlH5TriQeNtYiovaZ0Rf8Jd/S1DFhZMYea
 vArb+kBhvReZmVEyZMhvsIMdq9pb8s/zWuj+Tqauyj+6m2N7h4sTx71aZ
 5lGFhuYop7HicXUQ5h1zNHhWcohoyefs296NyfNPra8k/ucpcoM8mbmDv
 I4Cvj/5WDq/nFlvvN3ltATIlEKFVB3wv8jrHrywWypUmH0Yk3DMq64yup w==;
X-CSE-ConnectionGUID: Pb0c/y+7S5GhvYLmnIX4UQ==
X-CSE-MsgGUID: UKYKcJswQjaLSfxvgpPcQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="64355303"
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; d="scan'208";a="64355303"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2025 07:11:08 -0800
X-CSE-ConnectionGUID: MqBN5cYhTyqO0ZuB4HuEwA==
X-CSE-MsgGUID: zWbW7O7iQ/yk5NgEQ6WuTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; d="scan'208";a="186564742"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2025 07:11:07 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 07:11:07 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 3 Nov 2025 07:11:07 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.58) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 07:11:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z1z7y7jH/kjxmNDauJeqn9V8HJ52hvAS1vItPkgDOlqYiFpCQYTRLlv0DQsFCIOQUJPvXCFb9Mve3vTBU5Zp5cZL5k+LSIlPJEYgTV//Ko6GIluETo3TcXq1Ngd7opkD+2eENIqZFiM+OrHO/4TvPqHBPd/A8FJmGOJPg9DP6GytigDdb0v1kPnMJiZXVL0hGJwNKL1Nze0lFBYtemT6SP2gGURSZ0nhUeFv5Lo0uYkzgTjnRyaNDYHI4Y9VWqseEdz4YJVoB4EDW4n98ZjY0dCsB0dkjQFzAy/4SSz7piTgJj1Iq7Wy0XkpKDLmD1qhMK5tL3kJ+9D9RBBWxjj8CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kixw3WKmXWgJMI53lXKbitZfhedgEnGYmtj/CaOl/po=;
 b=Y4QGU46OVftcX+7ok03BIMTJ78n/Rte52s1gfoWQ2MHfk37nGA9bhiEpNUOndrbMxIc+TRpmacB0mrUuglbTrn3/JpRJ1NLQ26oAGTTFwPMdWhx3ZK4Q60GPTIfoWW/MZq1eGRqvdjsrk0m1NoVlE9Y+FrLM8bK3WmLqDxKmVd3zjpA2fqWj3JtjGtdjWSYCvidzM/Xpg6/RGemDJk6xrVfnSj2/uyU65FntY6tlV9U/+nLs0vxbtchduReqJetBHqgU2Ab3O2X+D0sEKV5PNuFgwqUO7JJbYeHU83XIs1Rker7ZFE/j4k+v8KW5rieeJUSIy9v8fYsKMgUhpTKmPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH3PPF6E8D29981.namprd11.prod.outlook.com (2603:10b6:518:1::d2d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 15:11:04 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 15:11:03 +0000
Date: Mon, 3 Nov 2025 15:10:55 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>
Subject: Re: [PATCH] doc: update documentation for ICE DCB and PFC features
Message-ID: <aQjF_6Gne1Wpk1OM@bricha3-mobl1.ger.corp.intel.com>
References: <20251103150237.958606-1-vladimir.medvedkin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251103150237.958606-1-vladimir.medvedkin@intel.com>
X-ClientProxiedBy: DU7P189CA0013.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH3PPF6E8D29981:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cc41284-b47c-43cd-aa61-08de1aeb3480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vyFMuof4N0wJcEG0IAd+U96vUXgOi/ex7JBq6p4DnZtdIyTXgauub/hY2JiM?=
 =?us-ascii?Q?szXDbdbQ0qLHOjkjdD21cNdBCzo/+lkZfrmbVe7T0O8LWOK8V/T692rgru11?=
 =?us-ascii?Q?koX+7tqJ+CImV8h1qBhCkXh7AN63ChNO3QC3PJ81IFlX+fSgSnOHcwu489EC?=
 =?us-ascii?Q?NBHregkAKeB99/BiZQfsiZkgSqDIsxiO8Q0mzngm8lWvCapasYB3zGK/PxQH?=
 =?us-ascii?Q?+unHAa5W0RC/ATevuk7mvmdLwWCq9dg6i/9CulVXUBdzZrUg4iJ6ryrhHK+H?=
 =?us-ascii?Q?jOLELw99m5XnfICqiqlY7Tmh+G4xp+CQdAYaAZgiFDvo4yw5b+81HlMjNTJH?=
 =?us-ascii?Q?YhgWSvlrjfgcp8qaMUBKfDhYNwFgBa/HEeDBBkurCIgDiRvY8wBafAtWKJaP?=
 =?us-ascii?Q?R4wqsRjHYeR7ND2W465ro16sxHtJMUrM2eV/q9tlYClwy5f1ey2MaiBPjR+/?=
 =?us-ascii?Q?CVg27TZWCARNLaONhw4OS4AKd4APYM0sVNC0iTGZkCq7Bz9ecV0SYVUo1ldA?=
 =?us-ascii?Q?iFM2X8E7WYzmebHFeWgGWJor+P4kqb9zpLbMZaiyetcKkPpcw/R68FK8hYew?=
 =?us-ascii?Q?6hCYFeaQTxltQvpdVM4z09QRDo9jFe+Pse+SKWMgIqFMKcLWSiNqU1sQr3/z?=
 =?us-ascii?Q?BPO1Dk8Cz+uZ64RCG5ZpV4O3aE1cycfiEIAvk50+2oLSo71Cbdkxcg9Wgi2v?=
 =?us-ascii?Q?5P3BRDsEp7qL9YjqKbubJKQsoHBEtloWNfbbEOWPNAKTc5Wn8ebVHOs0SWv3?=
 =?us-ascii?Q?2JjxEEd/tsEaepLDxUAZqaRBZJ9T1h/QsEeDw+JqsInCIbs3A1o0RjmG9QUS?=
 =?us-ascii?Q?76ALphr+PWgy4kU9pmHBa0gb0Mmqa6s3wn3ZkjJ9nmTXprSeI3LMHZxif8y8?=
 =?us-ascii?Q?Xah287jAEpK9mtZyy7xfl+RHv7HzVWmVKM7C4ioH6QxiKHvqE3s1WSuSCCWg?=
 =?us-ascii?Q?DuLXbeIhqC4Ddgq/mb19URcRQYZ4xZXJ37vZotUG+6kVn0iwuH6VoIWHku3U?=
 =?us-ascii?Q?Ac6dqy+ya7I4CGfVcBZahbipivqvLPKOaRyzXBmkEk2K9TAgxrixaPnD7W9P?=
 =?us-ascii?Q?rAA4nF5iUSRx2hHHjLJO2vAfSx2eolA8iccfpMFzn7Gu3rNZlmiVqZkqGGkw?=
 =?us-ascii?Q?LN76K+512w5xxSANoAPvUI+No5GksGPpdNnoFDW1PEjAlL0smdh9giKd6WnD?=
 =?us-ascii?Q?9p6Ap3c/bHi+/LX6ZH62dRDOIBvUayPEmBNldarNGGQMKhb/VRE6CcmHvVN3?=
 =?us-ascii?Q?5qXp547wFfriQwXbzo+9fOlBBinC2XsM1Q9GAX0r7tF89CbJFcRjFFppBBLS?=
 =?us-ascii?Q?1ROlt1ggk343xceGtnBZaKD4BBgBzsTwGXSGi0A026A+1Iqnq1/vb7Vllr/j?=
 =?us-ascii?Q?1UKj/DV6T5FQex3xrwssX0cQFLcUPPDWKHhKWzIJmAfIT78gO05twYNnuxsE?=
 =?us-ascii?Q?9ypE/ztHotk4MduUJBkM+tFkadJZ3+dX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AR/OAHfmE5aWfN8i+epl5jhz0np7Wzi4YTLu9h86bB+CKnSOIJ0OEASGpJ1z?=
 =?us-ascii?Q?+clHIVn7MG+cgu78eLZUrsllC2Hx7i987LAwS1EjR+9OfAqtSvCWpKeQxH2q?=
 =?us-ascii?Q?n2JTlRElPmGfqs9gKGZD+Rw73h14yzihiHOcDmKM618OekDfhu2NYUUaHR5m?=
 =?us-ascii?Q?/8OTGuQ/LxzM3LG2sHTxPYI14OskyqybRAO7mXWbLa/slI44ILlCm+Ny/u6Y?=
 =?us-ascii?Q?zOfLdthxDhvfl7tlkZ/iQYyNeJ5WeETW0ICzfD9+8p5L727v+Rj/qpIzM2/P?=
 =?us-ascii?Q?IgUk7hLZhyOgoEIYpAnZctOIXbuuVTk4nXBzxWCM6xGQ4UxQG8/dTGO9/GIo?=
 =?us-ascii?Q?hvsbGlf4xJlpsJgEC8KojJ1s8fTMtzLGilZ/AXj2CHfQvD9HJCbWeiF4oaPM?=
 =?us-ascii?Q?x8YUje1dDOQyY0+/WwlAXIsSV1R8UOr42gS2NVUdEsFQ1AqjET1+dbR1q+98?=
 =?us-ascii?Q?xnkyB7F+pgvV1r/9NjGpYYpfllxrG0bsFqsjo08moDL5kcdgkZw3AIHdnjtR?=
 =?us-ascii?Q?RMz7aCT9SjL7nHqizlwlXURdwrhUFqA8llcPPcFBmS2axIKigcaNpRVOz+5e?=
 =?us-ascii?Q?/7LW5767jmkdUn3Yqx4Ha7Nqjgj4BERSpHbV/hoVIaOZ8RVEm9813dux2PGh?=
 =?us-ascii?Q?rrfBX5b9WGzKGtyShHFkq7LnekLA6jX81kYc1gMioww3HNX33TSppHnSj452?=
 =?us-ascii?Q?Vn0gdVmF1pFr68hTHQ91NrjbdMIzHicQchnXB2SFL/tBTVpQUP9JDaZYCyMx?=
 =?us-ascii?Q?W+yZ0A0gVf74rfMYGlp0tfejlL/uDCkxADf5TCAqwq/4XPqnVHdih4f1kdAv?=
 =?us-ascii?Q?Roa35JX8bpDj7uCn2ffYhQPjf4exTTDtJqFQytKfb+aZpK5cSc9F7E4NrqBk?=
 =?us-ascii?Q?XWHd3la+BQSp4GlAJMya4kkGMjNWC7cJ3Jvl3Cm7TierxTeQ5ICxDLfrMWfX?=
 =?us-ascii?Q?rFlHuSGuyOwrVZ6kXh9Dq28iyP9jZAE0/PiDUXtYt/miUqE0n1ySi7y4Ar6x?=
 =?us-ascii?Q?KEQJzJ3g88SiCx39PzqL4ZUMmxl8qUr8gLNzd0lxaI1ryKWo/l5oK2zOBG7a?=
 =?us-ascii?Q?6ewW+wbSWHSHKKb8CdpuCavkmgBHKZ5KTdePbSkZMnaRVAykbmYARvdcPLaI?=
 =?us-ascii?Q?GRINj8dLZSeKf4mru7FB5+hkO8f5CSWAMic1SM3NKmdgADexA5ZPr0zNSZ6C?=
 =?us-ascii?Q?hfbeHsgiWmNdkOh43BegLet5xlFgZGBsn0b+q2ONEMyoHMTSwUkU7NbHjU/a?=
 =?us-ascii?Q?zWTz5mO3HcGOpSfCUhSu4szYbswiJw5/qReKkJIFNnqOSIA7QG21gfUbXLSF?=
 =?us-ascii?Q?SavG/47ChWwIVLm3sGK/CunMUvu7pImKLmRavoNYgDVldtvJRUVISt3wZLfr?=
 =?us-ascii?Q?C7U8p+Sq5+e9QlLuDw8f8kS4MHVkoFDHwiWtCAUOTS/tvNu5MnlfOOpMcNJQ?=
 =?us-ascii?Q?wNLMAsmVjySsFphBElfRwTtFBPO7T/Psp4yhti9bshuDqt8uV15L8vDErw6j?=
 =?us-ascii?Q?d/cR9jBPogQfZ93nFVuoW0NQYHsK1iNRmz47IDznI+yDmgQKEwUrfRlhCnh7?=
 =?us-ascii?Q?g2NJWQR63APeSSUTQ9etUNfGxOx4MliDDwLwyjPEYR0Lb/jmokU7dD1XuWNA?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc41284-b47c-43cd-aa61-08de1aeb3480
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 15:11:03.6735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W82J/aQ6efKKXgPlBybesJHeRDTUsgvZ94HE6pk7CRYNokNStT6ree5B0RwkYFxmvB+sQu17wLhNuswUlaAxCD0aQGaUVDtVewjuPVMJREE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF6E8D29981
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

On Mon, Nov 03, 2025 at 03:02:37PM +0000, Vladimir Medvedkin wrote:
> Add DCB and PFC documentation. Update feature matrix
> and release notes.
> 
> Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> ---
>  doc/guides/nics/features/ice.ini       |  1 +
>  doc/guides/nics/ice.rst                | 74 ++++++++++++++++++++++++++
>  doc/guides/rel_notes/release_25_11.rst |  4 ++
>  3 files changed, 79 insertions(+)
> 

I should have noticed that this was all missing from the original patchset
and flagged it before merge! Sorry.

Anyway, thanks for doing this now - better late than never, as the saying
goes! Review comments inline below.

Thanks,
/Bruce

> diff --git a/doc/guides/nics/features/ice.ini b/doc/guides/nics/features/ice.ini
> index 2703493514..e9796c1eab 100644
> --- a/doc/guides/nics/features/ice.ini
> +++ b/doc/guides/nics/features/ice.ini
> @@ -24,6 +24,7 @@ Scattered Rx         = Y
>  TSO                  = Y
>  Promiscuous mode     = Y
>  Allmulticast mode    = Y
> +DCB                  = Y
>  Unicast MAC filter   = Y
>  RSS hash             = Y
>  RSS key update       = Y
> diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
> index 7e9ba23102..7fe61daaf3 100644
> --- a/doc/guides/nics/ice.rst
> +++ b/doc/guides/nics/ice.rst
> @@ -447,6 +447,80 @@ and add the ``--force-max-simd-bitwidth=64`` startup parameter to disable vector
>  
>     examples/dpdk-ptpclient -l 0-3 -n 3 -a 0000:ec:00.1 --force-max-simd-bitwidth=64 -- -T 1 -p 0x1 -c 1
>  
> +Data Center Bridging (DCB) and Priority Flow Control (PFC)
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +

Just wondering about the placement of this new section. I would keep the
PTP section and the packet pacing sections together in the doc since
they are both time and timing related. Can you move this new section up to
appear after the DCF one.

> +The ice PMD supports Data Center Bridging (DCB) and Priority Flow Control (PFC).
> +These features enable Quality of Service (QoS) in data center environments by allowing
> +traffic classification and prioritization across multiple traffic classes.
> +
> +DCB Configuration
> +^^^^^^^^^^^^^^^^^
> +
> +DCB can be enabled by configuring the device with ``RTE_ETH_MQ_RX_DCB_FLAG`` in the Rx mode
> +during device configuration.
> +
> +The ice PMD supports:
> +
> +* 4 or 8 traffic classes (TCs)
> +* VLAN Priority to Traffic Class mapping
> +* All TCs configured with Enhanced Transmission Selection (ETS) with even bandwidth allocation
> +* Queues are evenly distributed across configured TCs
> +

The latter two points here are not really config options are they? They
seem more like limitations that should go in a separate list from the
configurable aspects.

> +Requirements:
> +
> +* The number of queues must be evenly divisible by the number of traffic classes
> +* The number of queues per TC must be a power of 2
> +* Traffic classes must be configured contiguously starting from TC 0
> +
> +Example DCB configuration in testpmd:
> +
> +.. code-block:: console
> +
> +   dpdk-testpmd -a 0000:18:00.0 -- -i --nb-cores=8 --rxq=8 --txq=8
> +   port stop 0
> +   port config 0 dcb vt off 4 pfc off
> +   port start 0
> +
> +This configures 4 traffic classes with 2 queues per TC.

Do you want to include a C-code config for app developers as well as just
testpmd instructions?

> +
> +PFC Configuration
> +^^^^^^^^^^^^^^^^^
> +
> +Priority Flow Control (PFC) provides a mechanism to pause and resume traffic
> +on individual traffic classes, enabling lossless Ethernet for specific priorities.
> +
> +PFC can be configured per priority using the ``rte_eth_dev_priority_flow_ctrl_set()`` API.
> +Each traffic class can be independently configured with:
> +
> +* RX pause only
> +* TX pause only
> +* Full duplex pause
> +* No pause (disabled)
> +
> +PFC operates in VLAN-based mode and requires DCB to be configured first.
> +

So this means you need to call APIs in a specific order?

> +Features:
> +
> +* Per-TC pause control (XON/XOFF)
> +* Configurable high/low watermarks for buffer management
> +* Configurable pause quanta
> +* PFC statistics exposed via xstats
> +
> +Example PFC configuration using DPDK API:
> +
> +.. code-block:: c
> +
> +   struct rte_eth_pfc_conf pfc_conf;
> +
> +   pfc_conf.fc.mode = RTE_ETH_FC_FULL;          /* Enable full duplex pause */
> +   pfc_conf.fc.high_water = 100000;              /* High watermark in bytes */
> +   pfc_conf.fc.low_water = 50000;                /* Low watermark in bytes */
> +   pfc_conf.fc.pause_time = 0xFFFF;              /* Pause quanta (in 512 bit-time units) */
> +   pfc_conf.priority = 0;                        /* Configure PFC for priority 0 */
> +
> +   ret = rte_eth_dev_priority_flow_ctrl_set(port_id, &pfc_conf);
> +

Need to align your config examples here. You show a testpmd example for DCB
and a code example for PFC.

>  Tx Packet Pacing
>  ~~~~~~~~~~~~~~~~
>  
> diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
> index c5ba335cfc..6a35f9f15d 100644
> --- a/doc/guides/rel_notes/release_25_11.rst
> +++ b/doc/guides/rel_notes/release_25_11.rst
> @@ -115,6 +115,10 @@ New Features
>  
>    Added network driver for the Huawei SPx series Network Adapters.
>  
> +* **Added DCB and PFC support to Intel ice net driver.**
> +
> +  Added support for Data Center Bridging (DCB) and Priority Flow Control (PFC) to the Intel ice PMD.
> +
>  * **Added Nebulamatrix nbl ethernet driver.**
>  
>    Added the PMD for Nebulamatrix NICs.
> -- 
> 2.43.0
> 
