Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B88FCCF9FC
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 09:42:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22DED4027A;
	Thu, 30 Oct 2025 10:41:59 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id A048B4026F
 for <dev@dpdk.org>; Thu, 30 Oct 2025 10:41:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761817318; x=1793353318;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=cnMwFfvpO+Weu7LTwCSUwm4PBokcOuH5kzFyVf6Te6Q=;
 b=KgNjfXqkMmksTgriX9uAr0fJi+lAy+FZqWYvg62I5uytENK5DvK0rVlm
 MFq1Euz5ohtFLXKzAFlKWD1EjLmM39sUk9jfnJZg/H2lcjFDbg558j2rb
 siiw1DhGb5NNxThJ8ACGqXaC4J4ubLqdbrF3qp0+zvozoCfFv3UY3FsD4
 39UUsqM6ESsGRK6QiPN/TWy9w5IRGJagH1Ys8N0RTcE9+IuzUgwuWywFX
 EbcsHJiso9MIfUN/amtGm6EeTjgpKko+cm0ksz3nYK1+yP9sJ4vovxWqy
 uBIla8cGwd67Wzk/QCI4Mi6FN/8IdODnG+5W46gVk4Zc+eH074wPF3eNy w==;
X-CSE-ConnectionGUID: xVekqfMJSkmNmuXN6FZ4+Q==
X-CSE-MsgGUID: VCjOxv8LRk6evWlRhokXYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="64049888"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; d="scan'208";a="64049888"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2025 02:41:57 -0700
X-CSE-ConnectionGUID: q+yp0idwT7qjrWhz8LEizA==
X-CSE-MsgGUID: 5Da/VqCET+eTfSPaGVCnYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; d="scan'208";a="185103763"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2025 02:41:57 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 02:41:56 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 30 Oct 2025 02:41:56 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.39) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 02:41:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O71F2EBPbzOq4hAgnGmnmNqRa2/LdufNBqPbKCAq3JXLmcpfbQH6CUK/3GnYIm7c2x42vjXqpaP6kmHZ6h7R7nVTiVf0bPpOO5fpkwuo9WjOnOVkbScr/Hac80eqDUl2n/y6o9CkIkADWBLIJjVeW18R2rpMDZEn+1qaASLDxXWSFJ8E2Q+zgzg/wCqYTbiXUwp9pCKHUWuRZFfCkyvFbkybkv1SJ44ZxTErYJ9EF3Pun8Qln/pjDTsUxXZUSP/WvCJTHvF3q6eKIsP1n1piUMT3oHzrpjutOdVjDzOjPEEz5X9jOoa7D1jV61nzm3v/ekU21GNQwi3BD7ZwhZFEqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0uNcLswemD8lTWh9d/h3wIkFbBftmMsVN9jLWqx3vc=;
 b=k6NCr1STQ9T/8EP9PPgXCj449nTqr4WMa3Pbfo3eLKihtoL90zGi6vBaQQCPFYTx7CE2i+xs44+s3palVyfenq9luoe8p8FLm5Ss+nuh9fzbN0vCCII8D0rGdLB3gj5AugAWDVL7bqTA5afkkmKduiwkd8JJ7spxsvg3P7g6158iS09QiqQlgUrcIbBpQFZc74htMbXhUYYB++aS09P/IXr4w83IuP+VVsnECPZuVPQ7hZMxdGcFfMsQcAMGmg+4WZD3BDTR4n+9vjVvJeDh6D1eqqCSfJzU1Z+rqq0Do5K0wbo2EqO2b+nsGt7DpYcwJrbPyAe4Gr/oIVsOvt19iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LV3PR11MB8531.namprd11.prod.outlook.com (2603:10b6:408:1b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 09:41:54 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 09:41:54 +0000
Date: Thu, 30 Oct 2025 09:41:49 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
CC: <dev@dpdk.org>, <rajesh3.kumar@intel.com>, <aman.deep.singh@intel.com>,
 <manoj.kumar.subbarao@intel.com>
Subject: Re: [PATCH v2 4/4] doc: add PTP IDPF documentation
Message-ID: <aQMy3RaFEOzhsb0U@bricha3-mobl1.ger.corp.intel.com>
References: <20251024120840.420016-5-soumyadeep.hore@intel.com>
 <20251028060758.233929-1-soumyadeep.hore@intel.com>
 <20251028060758.233929-5-soumyadeep.hore@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251028060758.233929-5-soumyadeep.hore@intel.com>
X-ClientProxiedBy: DU2PR04CA0273.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LV3PR11MB8531:EE_
X-MS-Office365-Filtering-Correlation-Id: f3b71f49-0923-45f0-91d8-08de17988f49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XN9sdBq0YFEAe2BM2xXPgv+Uc2V2e0UkO/tmhe2hCO0IV3cQaI/ZdBJl1C/5?=
 =?us-ascii?Q?nOlQKa2m/o8Fttp+0dcZN8XaJxW+qg5So3/DHKVCmKVJiOL60Ji1KnHBUxlQ?=
 =?us-ascii?Q?4siWhxUly+loQuh/JZS402jEUdiBDwwcX5I7MKAC8qgdhY5/dkCdjbaovr/o?=
 =?us-ascii?Q?bnKeAcLGXR0D5Xxk6bU7QtHXiVbLlVivxUiD53JOBFxvwh7+a6WUgInWcbfT?=
 =?us-ascii?Q?9wfVoQxaqqqEhocX3TFRXWi3x2D0ofEH8jaWe196J7zzqVEdVPZ+RNjSyk1V?=
 =?us-ascii?Q?5N35SDQwtHrr17i0G3hpd6ct9w+1iO8dp8N2nWQjeDQZyMNYU0ir/f76Jpax?=
 =?us-ascii?Q?HMWsch3nhaHaS4fIgigzwA9cHWsWDaLw1GTee6+UFa26t3wi6vItQMqfcLDF?=
 =?us-ascii?Q?vRV9roBdfRVwvxXF2IxyNxNugGCUoaxAU4j60yo3l3UezWE8Iq1958W4Ihbz?=
 =?us-ascii?Q?0IW5fabor5vKPZqlNfTPSHttlcED35NLOLs9gvLCxVLIaBvLTRKLHf1TKX7m?=
 =?us-ascii?Q?2E6gjsCTZdqrB2M4P3u9U48Gply329AeZVZvEz0tSa93IcUwEr7fqfDCExWS?=
 =?us-ascii?Q?adCQonn4uqx6On4XI6Cok2akEDJUHw0EfFaJz+PVN4X2jZLQhyaLfSKkx2WR?=
 =?us-ascii?Q?wNY9W2Dl8dAoqclpmVbRsN02IogMtna6Yv3XpK00IkQJQ5mTuI6roaGqU6gB?=
 =?us-ascii?Q?66qkpCToqLPp4cRoeXyOnUiXaOXRRGci20OInBIOpSys2BmwimTg2ZfhHZsB?=
 =?us-ascii?Q?2Vye31JjHIsNUCRTEjF4l/EIXeeMfgJg+dU8jazGWEkXM2MPEut4Q/u70BsS?=
 =?us-ascii?Q?Qsnn8v462Tqy/Av4bnpTpeLSazXYcix/etroqnp1UUs0savMHIUnMCAT25GV?=
 =?us-ascii?Q?ZMNw7swIoC5dQXjQvonnk2i0oEOUi+AtSsJFHrFcKkVJLG5rmHx3a2n3hOsR?=
 =?us-ascii?Q?t+pxtEqDCXGo11f/G8Oe43d34FXZ1w77Pe1gdn0gZNG9Zy/CDZi5PgZ6ROjW?=
 =?us-ascii?Q?DSlHoSEsa+0rLXeXAw8zoNIfOUvgWRUTie2FanCEuJHvEbccrGtYPOdyl/zO?=
 =?us-ascii?Q?DRR7qXuTHNN/k5jAQv80qZ9AMt2tYb42opQV+UTkKtqm5rtEztzWUhiOX6Ae?=
 =?us-ascii?Q?cf7vG5faxuxHX3ULrmeq64vaDJZy0aKsYX9Rw+W7jAKq6S+6A4pmAr2o1hed?=
 =?us-ascii?Q?u7S4V4qQwilvqjcDMEO5UsiZoINztp4WAGE1equFIPqfTR+nYAYYKu0BGQ5S?=
 =?us-ascii?Q?yhr5p/+2uH8tlYrdeH5t3xRiCXAz/B5MfKFFlA7VqR+5+HMvvB25k2J4UmKr?=
 =?us-ascii?Q?hNFgWBRapPuOET5yU1QzWxFyflkdmUqoXTtA8XwtQv3YlEWOYEGPY2NawPA6?=
 =?us-ascii?Q?aXN8OyI9B1Q/kjOyrHGwe2PiD1Im7JLlveMAL4a/S3zwV/fWzlD+Huy7nBT3?=
 =?us-ascii?Q?Hkn1oGgQno4UUX4B8Yg1Q9COvRC22/P2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Em6hg2CiCwW9/4swGPMJfZY3GIwcWAZhqKt4necQD+nev+G4En+jlz5IMrti?=
 =?us-ascii?Q?DokRmjb1YAZ5TRcbh5Evqn5PLgOQ+pzxUQJn0gvAf1yecf5dLPHoSvnPNtFJ?=
 =?us-ascii?Q?J1CbW5GLaMQ2PmTu5wyTB4urCGEf7pJSRXDHsY4W+/sq8yupOay4ldvRIPWF?=
 =?us-ascii?Q?uSbeXgLoHh/T1wKQP71TN4Q1E02isJOQch05LztIZB+Z8pAw1HbsZ9Ei1wWd?=
 =?us-ascii?Q?jLpysZKo7UsWfIB6ok17TMJrwzd2Luo6kS95gwbFZ4lV4WaVdNxa6ZCMgWFb?=
 =?us-ascii?Q?oGq1rxgUCZhFdU6YePNYNvnAyVXwzGmBqSmJDNG4xB+qqMFeWpL8Eyq9Y6j5?=
 =?us-ascii?Q?CXHNl6zGjBuqfZQO3/bjmPUdTwImQFW7uGMsWdCY7RYuzRDfmzRYaVVxJVaB?=
 =?us-ascii?Q?NjMVL8M3D/vIGVjiFauX6jbscg57gu8JRY2LXEmhygpm8+kTHdzrFvjGyp+7?=
 =?us-ascii?Q?AL4WznSbj+GCnhg70dHCU20fj5ueusrJISok5E0EEynqjXCdOFkX+GclvgUV?=
 =?us-ascii?Q?YUzLEhhs0lXxdjgrIG5BBB1nobzlYXHk0GwIfyV5zNFbpb/tqDDh/oZDPX8+?=
 =?us-ascii?Q?5UoBP8GqAwC6jYImc0E1QmVc6J28ZPdRS4zl/r0cYpnxdklXjP0vVYn41GoP?=
 =?us-ascii?Q?UiGd/gtm5u3J1WlFeP0ldJJYTA6nlpgworcrizd0DO4FmJtPp/J6YY76ZstS?=
 =?us-ascii?Q?IPNbEZf1LGo7a9L4q+uguWXENNBFF0CNGxRtJwI4zFCfEjvX1jOJsaWhwWDt?=
 =?us-ascii?Q?6pBL4k9IsqVDx1g1DrmW+66W9UWc4ssQHsTKfZtx5g7aGRPsDipndNRdumHf?=
 =?us-ascii?Q?OjH+opQx4OikWutFTwPSuXjFthXrlL1YKMbrHsUzUjFDMHh+Xz3H3kWPXFl3?=
 =?us-ascii?Q?17RQVo/KWVJBwGZujpIAhthmn40ylGyNH5IayOi7j4urw0iBVKYu6szzsKKW?=
 =?us-ascii?Q?N7xKIJmy9siPpASTGsRCSbqIjtsJ4lnMJsTRu0MA6HNf6bv0HOeqWB4BA9ci?=
 =?us-ascii?Q?9DHPuXgj15eK26qYsNlDRTiZ4ZpaiTvDAX/qciO2VPrpc9ar+Txaa3df6eUg?=
 =?us-ascii?Q?ZzsjWsNaXwYivra5FOsSqDnJixLrXIHKUTLYvgqw+GLa6dIJULwsRdi3tHyB?=
 =?us-ascii?Q?nmTK6wlyBM3PtNDj9ks35nWdSPuQdcylJjZ0X7/VjTE333RVDP349gKwFQKS?=
 =?us-ascii?Q?aNXST6NB+1EvjyJD3EK6y0CIr+qVMOCgkSxY4+VOXqe+eJwCBOk4WuzMi1qq?=
 =?us-ascii?Q?bgKMEuWYQV7UHgtvL2Zr5/AxrHPPuCNa9YDRMXjquOnDAqL+XqaKVY8QRmcK?=
 =?us-ascii?Q?/PSfDBOnoyvkMkRzPxKaLEfNZJH3aq/VYsOGeLx2uEkHe1YTHfLfQRvvwFX8?=
 =?us-ascii?Q?Kvf1wrktmgDcciDj7BxZhCkQqkrIpPoEn0cnnOcL68Beek3UOw+bvjc1slxE?=
 =?us-ascii?Q?n9Wx8aWKovgU6/gmKnTNSKn93y2pyksNHToifd5X4k9HydK8Yjj4w6Ww06Uw?=
 =?us-ascii?Q?VSjArY46X+zdMt/3h/38McDsMP5+KMS13cE3kpXYV49R3gTasI/g8HB8eMX9?=
 =?us-ascii?Q?iaqpwh0UxYBjOExr38udBntFO63ibRlli4JAHZPmdg2KC3Z00sqPOsmw0RtV?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b71f49-0923-45f0-91d8-08de17988f49
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 09:41:54.3174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pax0xUh9Qm1CvXlyoHOeEgvdpAlJkP0dV5hxkIzA/AIwvqJ/Exu6iq2fccgXkCmbXlFbBcDOk3gFL7dWg88A34tGG/+4rwSDanTz+bICg0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8531
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

On Tue, Oct 28, 2025 at 02:07:58AM -0400, Soumyadeep Hore wrote:
> Updated the IDPF Documentation with PTP feature.
> 
> Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
> ---
>  doc/guides/nics/idpf.rst | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/doc/guides/nics/idpf.rst b/doc/guides/nics/idpf.rst
> index b99cc18188..e76632904b 100644
> --- a/doc/guides/nics/idpf.rst
> +++ b/doc/guides/nics/idpf.rst
> @@ -109,3 +109,19 @@ The paths are chosen based on 2 conditions:
>    A value "P" means the offload feature is not supported by vector path.
>    If any not supported features are used, idpf vector PMD is disabled
>    and the scalar paths are chosen.
> +
> +Time Synchronisation
> +~~~~~~~~~~~~~~~~~~~~
> +
> +The system operator can run a PTP (Precision Time Protocol) client application
> +to synchronise the time on the network card in ACC
> +(and optionally the time on the system) to the PTP master.
> +
> +IDPF PMD supports PTP client applications that use the DPDK IEEE 1588 API
> +to communicate with the PTP master clock.
> +Note that PTP client application needs to run on PF in ACC
> +and add the ``--force-max-simd-bitwidth=64`` startup parameter to disable vector mode.
> +
> +.. code-block:: console
> +
> +   examples/dpdk-ptpclient -l 0-3 -n 3 -a 0000:ec:00.1 --force-max-simd-bitwidth=64 -- -T 1 -p 0x1 -c 1

Why is force-max-simd-bitwidth necessary? When using a feature not
supported by the vector driver path, the driver itself must be the one
which selects a scalar path. That task cannot fall to the user, or require
the user to know that he needs to select a scalar path.

/Bruce

> -- 
> 2.47.1
> 
