Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE6CC8303C
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 12:48:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FF5540677;
	Tue,  8 Jul 2025 14:48:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id BF558402A0
 for <dev@dpdk.org>; Tue,  8 Jul 2025 14:48:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751978885; x=1783514885;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=58GjfCeRNAtNTuDn0nwhkRsv/m68i28G1jVLLuiSCFE=;
 b=IK4eX0SiwxOsUS2z2AaEICjrTa68mCwCXbrJFMGJzArX0arFjilSKvoU
 l38Uyls1GFcC7NkOEp779BGXvavWn060+UuV391/Y8qUixahuG6RRxmn3
 ORBQFPu0ewqFJmqooBEzhmXg1uB088TpK8Ft3miPwlWem5IE6fAm76pIr
 6rAlvAMqcnGTX3iojUBWGGgRpgQ1/A3ayceqfHOLGsH4B6e46DOr4TNFI
 SxS7D13FP39bhAGInyGZYLdfV+GWKnXddWvCp9CHePJla2Yyki5MEFglm
 fVQR3IcGdmFQdggdtFKBrOTvqS+vEfBrzZWcgFWHRw84B9SLoEwXCtodF g==;
X-CSE-ConnectionGUID: 3iuxru2mQEebfRQB2lZbmg==
X-CSE-MsgGUID: drj/EW7LSnGQWP7UQQGf6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54310993"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; d="scan'208";a="54310993"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 05:48:03 -0700
X-CSE-ConnectionGUID: 66CN51QoTACTqARXuEsGvA==
X-CSE-MsgGUID: yJbb/Mr+QYmVWvQ/98fxEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; d="scan'208";a="154900712"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 05:48:03 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 05:48:02 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 05:48:02 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.40)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 05:48:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AzjdTh8ifp1ud73Bq/nXPhO3jXJV2OULdv0cOhXwpA+N4Wfjo+fesS8bA7L3A+o+xb0WcsEfRGQ8MEKVYsaUaFjcp6M6DhskK4oyfF3TmxbRTdHBogSieI2fn49edzyjIbKMxWMiUSB6C1ItjXgjyUco06Kw3PNVwIYa1Yv138TuBAVB4OlBHoM1zl+6gXoK+NsiJ8Uo/Y8GB1VYdh6xvD0JV+Al+7PprZyS5MPm4x3YsW0/32xIqpYA9Ot8mKsO8cmmDYPldRRl6ODhZcvM9joeRXBpdMgUHBFeUUPlLuDFSy86K24+XBKEHAWCCY7qp5bJT1fp4Nm+CZ73etRaXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwLiEG73skHHyJ9f7ln2eJJm9wI5y9xM03UHe5n38Aw=;
 b=Li1K3Nv6lJwvHMdl0vpl7KSkV9AVWjxYeWjc74hjJIrTJOHen9Xq3R+C+iCDxNXXaVEprGjOmURGOq4LXhw8DU14PB7N9l4BsLAhC0gL6l0B5SzCI5lQnkVSSAd56KPu7Rz5t4wI2/oMdYboxRdqjZoqB4bvYZmpkMQ5XWINTLCFJReZyHgmdiNBW+XSTj8b1v75sPXQYCb/SnxsrkU5fLFmofhoHjsnrautcmpGo6kTIXul762jmeupEhEMbSItmsoz4e34g3fID5YiXPfwqvAtx6hudnZ40eGIAqcxefZAk8E3LvTNLdw3LtcHQcezBtkj3EQx7JGXX8AQxVu+yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH8PR11MB6682.namprd11.prod.outlook.com (2603:10b6:510:1c5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 12:47:46 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 12:47:45 +0000
Date: Tue, 8 Jul 2025 13:47:41 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 16/18] test/power: fix tests without power drivers
Message-ID: <aG0TbXztzouaF0MO@bricha3-mobl1.ger.corp.intel.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250708122823.3406288-1-david.marchand@redhat.com>
 <20250708122823.3406288-17-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250708122823.3406288-17-david.marchand@redhat.com>
X-ClientProxiedBy: DU2PR04CA0334.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::24) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH8PR11MB6682:EE_
X-MS-Office365-Filtering-Correlation-Id: 78ec8e46-2c90-45ac-5a9f-08ddbe1da32b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZZeeJ8XSAP63CTXtEJ/LDrXIg8UaOAiMlfNFir3OjSki8dmSPySiN0j2G2uE?=
 =?us-ascii?Q?qEMMvKl1qv3Qrj3y3vq0UNuw9woYnyRYrNznTF3NxsXSO3555kXgpZW0wEa8?=
 =?us-ascii?Q?+mTV4A7SWrLpOkF1am3bV4BXP5ys0E2BzFyJodsiOcsK+M9BrvUH4B26oWhM?=
 =?us-ascii?Q?k4l0LQ44jmpiF5CcHt4IQ/rp3sty6Ebo0GzGMS0aWA0cldVXwKS+NBmP9Rhj?=
 =?us-ascii?Q?qQntTSlj+xlR16kBSp2w2L/CXADusj6eUq+UdI+58NC8YD/bVI8BnSeXrY8T?=
 =?us-ascii?Q?52kBFLi/W0N9Al5SJzDSqyvzhBQ9eCJfiTafOVHNoRuxn+hGMnZI95UCIPh/?=
 =?us-ascii?Q?0ftOnjcrH73yUP1tUZx9iyNhtlugDxjUU2cDny/ydnXNGx5QwlxPFF7A2ZDw?=
 =?us-ascii?Q?WJHD1wpPxMXdw+FQRnMLSyfZnyLpAVC8jH0pRcyPCGts3we1BedyO9Et1jVd?=
 =?us-ascii?Q?HwHUOkDHRPjl+e7vNkfNlZOeYKXcJqCbf7fOiAhUlwv/xJX/dEI4L6v3uny5?=
 =?us-ascii?Q?BbYuFgtPOywpCKvj2m8YWCbVJeXN35Y2OQr2332b6vOcZsGrY88KqRTSefLd?=
 =?us-ascii?Q?qG70yb+iulgHb3L8poGNYuqvlnEzZ1qSagLOIV0krn/37QGXOpwJ84etT8eF?=
 =?us-ascii?Q?MiCVWwUYkaSN8ITmB0NycuUuqyJWP63fZOe/zaMQqemujyMZSlCN8JSXFpUv?=
 =?us-ascii?Q?Ha26/GQJ35DVhH+UYeqQD20CY6AsCIXwQwVmcbsBBs/wXy0wMmp2rY0gY+Ey?=
 =?us-ascii?Q?XiU8grayLIWggaarA8LRvyZGJmRTRdOIsPHGbASRclX38cuPYf5k3106IeSo?=
 =?us-ascii?Q?C1/+7yRiY0YdQMynoQjBi6g1X2Ap755F4fLETaB8RRAX/L8Rb7I3D1Bj1koe?=
 =?us-ascii?Q?sdW4mAWTiiQ+7+5fZE8BC7emAOTfvJJ4S8XYl5j69SEiKLys69vDLcaBVw4l?=
 =?us-ascii?Q?sM18yMbDHuLaB2G+t2+wQvoqBtmW2/eVKHBckBsqS9jlIY/KMy8tE7S+Cz9F?=
 =?us-ascii?Q?4//GBhIg2YzqZQNMW8tItrO1x2fxDCxM6QfVma3IHPKnt+qFhsGGfHF/M6BH?=
 =?us-ascii?Q?8rMAnlujPk5SBi2iqN8/8X6aXrjmzjuqdnmFWoK1n9vgCV3Nlpunv+Xv146Y?=
 =?us-ascii?Q?WXZoppRmrB1uIprshacI6N8qxzOmDmBAKIX6+pbOLT3fcwNPdjW0zaOY+rCf?=
 =?us-ascii?Q?mSz1qAdoULolkeGZwMzvN4BaHXKh+o+E5rmx5pUB+smVOjcJIjpcM94uAPSQ?=
 =?us-ascii?Q?Koy35ELzB3VhaiTlHdvnqR65XeXNSqqOHuSiRtYIxh6qIOvK23oRB8yLFT8z?=
 =?us-ascii?Q?8sAwj1rKtt1LrYoShKatLUWCGAx9Go11t5xAd4yczkTR6LycEi9x/OVMWFIH?=
 =?us-ascii?Q?WcSketGKX+7/AibZhRskzLDYuLHubvCjwL1tsq4jV2PUGVjY6cxCb6+avG5f?=
 =?us-ascii?Q?KWkpmCfkP1E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FrkfCDGQ2mQYwOilWEk6pvLxA2iV8TyILJQ44/gOvYDx64bkN+kv4DYzTW1R?=
 =?us-ascii?Q?QNYnF5hbD3+CC131XSiRt6/Q2wtQuX4iwNjnpZYceA4CnHKXa55zZI7S0ETq?=
 =?us-ascii?Q?aBVvn4uHKzKxuwc1YXuIy4/8hHqGhgrZHIFvboj38NCJbv8n5EX5jGxI4DLy?=
 =?us-ascii?Q?Lhbuzl3vLer3AWQs64vKL9SbmceMr1/sZdaJnHqXjxhkZMDzzVD1gEDiapsb?=
 =?us-ascii?Q?peH7ngqPUD0OoBCOSVTHmuV6ievpZx7RyL1EnJAfuZbX0oWTISQn64tljRkD?=
 =?us-ascii?Q?i/uGighwu3NxdkA9n2R65l6+tOZArDx5ljsjz8O6AJAg03ZRErk4pVF4IVze?=
 =?us-ascii?Q?TTmxB/4ebZBRAbJAeW9MLs3OSsJ2sJbCUcShQEHN4j370hH1Q+1MO3pxj2af?=
 =?us-ascii?Q?K026Yk1CPDwA8RjiRGbvjmJp7AvIad4JXi4WTZQ6CN28YB7sRVw+DaX4LbBK?=
 =?us-ascii?Q?8JpUzAQMunCwTa26wpZzFtejPc/IQT8dCuEyTpglSGkeysCjYnlvK8feBrDV?=
 =?us-ascii?Q?VWvwtJylF7Ha/KaBXjFFHY9cDmqCMOCMvlAgqZZWPKuwb5JOtTx3N4+B1b6B?=
 =?us-ascii?Q?RI+Xko1DOqLjYEP1ivYjUS5ILa9Pi2DaPVcLBs8DFfDGmURrR4kMRg3RPqCR?=
 =?us-ascii?Q?NfEa9o5g+D8Kao1v+eYlLwbsCVBnhSZOCFxrl4GqIUnV0HLZUe9l7Na/U695?=
 =?us-ascii?Q?lyXfYoBXBQY7MOCZ0ZoliZdDUdLuh2FteKZ4CwNB0zlcqCJoyQkLVwjOUIJj?=
 =?us-ascii?Q?AQjjl7ajPShmb84/PKrEMmioXkP0DWKyst33IHsR5kIgfpVyMpylnVqHrqod?=
 =?us-ascii?Q?4R7zeIZCxaQroP/xqfb2zRWldnC5cwOcdYccRwsXXWF3eL88+KcOvXIsrDVC?=
 =?us-ascii?Q?wYgOlCegrzYTTn043kpXSNDUYkcr7lD0J6l2cQFag8hFXaaZH+o45LahQod/?=
 =?us-ascii?Q?ba4/GwOubhktmD8D52mo51SmFVnejXiyhKVuHdJ6ITLLepebwr1uQd0eYYW3?=
 =?us-ascii?Q?Ewx+ussX4xSvX3GWMaZ/DlzW9AzN5R0TkCZGcCwLxsu2LNJdhj3Uc9tma2aR?=
 =?us-ascii?Q?DizvB4ozwBw709+LaP9ty9MJ/T0ivmmfNSf51VNNaKLlH1A59z2GP3szjNT8?=
 =?us-ascii?Q?u5GbzotCnOvMSPaPKVIlBlUChq5ZfWoOJlY7XtfsXpk9nzT+GJfOc19XsfzM?=
 =?us-ascii?Q?EfvU9hKwcpiUuDdGzY4NhHbwJY3PUmUIXzrLzFyP0BKvCf/QzG394cli/a+M?=
 =?us-ascii?Q?C3+gCIAbk7wmmNjtkgbXnJuppglyl1Bm9zua8vz61yaUOhB3Xjozayl1xj+U?=
 =?us-ascii?Q?5EVbqXnfaWM95Pca8oRZDcwEQiNS16jqFnWBpwPmV7w1WnG4BnRpH/FHdOs+?=
 =?us-ascii?Q?H8/0T09sqbZTFmiRfbIZROmvFwiWI02/+xv6Vj0/f/zgXJNuZz/DPHDzKRab?=
 =?us-ascii?Q?Ck7qvPiyyW4n2SetnlhwdaBwLgLRXBM/kwS0jmSBcNvbWGKYExpyzVv/S9i3?=
 =?us-ascii?Q?ajrb/ZjOiTX0sWQYG7u9qVQZEbC7aQ6FDKzjBFcApeoxTwPLQZMfn9zNfnP7?=
 =?us-ascii?Q?lzovTgm/GM29EmTas/DeK2eaZ7w9baNN3DHFzj0Bio/OCH4h/sRtH+G2EfQT?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ec8e46-2c90-45ac-5a9f-08ddbe1da32b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 12:47:45.9512 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: etPEz1EZ/AwzYjNGYQaf+wC0DPuyHOSQpQcTzGjNXRiTplYGqnmGYnwSyt4cK0QAhXwvfAoWyCXTj4mPOtlkYxDX6Poi8W5UR/+txhniS2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6682
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

On Tue, Jul 08, 2025 at 02:28:20PM +0200, David Marchand wrote:
> In the absence of drivers, skip tests instead of failing.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  app/test/meson.build | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/app/test/meson.build b/app/test/meson.build
> index 7d38f51918..79d635b42b 100644
> --- a/app/test/meson.build
> +++ b/app/test/meson.build
> @@ -145,10 +145,12 @@ source_file_deps = {
>      'test_pmd_ring.c': ['net_ring', 'ethdev', 'bus_vdev'],
>      'test_pmd_ring_perf.c': ['ethdev', 'net_ring', 'bus_vdev'],
>      'test_pmu.c': ['pmu'],
> -    'test_power.c': ['power'],
> -    'test_power_cpufreq.c': ['power'],
> -    'test_power_intel_uncore.c': ['power'],
> -    'test_power_kvm_vm.c': ['power'],
> +    'test_power.c': ['power', 'power_acpi', 'power_kvm_vm', 'power_intel_pstate',
> +        'power_amd_pstate', 'power_cppc'],

Is this better done at build time or at runtime? Unfortunately we don't
have support for "or" operations on dependencies, so if even one driver is
missing the whole test file will not be built. I would think it better to
look for the drivers at runtime and return TEST_SKIPPED if not present.
WDYT?

> +    'test_power_cpufreq.c': ['power', 'power_acpi', 'power_intel_pstate', 'power_amd_pstate',
> +        'power_cppc'],
> +    'test_power_intel_uncore.c': ['power', 'power_intel_uncore'],
> +    'test_power_kvm_vm.c': ['power', 'power_kvm_vm'],
>      'test_prefetch.c': [],
>      'test_ptr_compress.c': ['ptr_compress'],
>      'test_rand_perf.c': [],
> -- 
> 2.50.0
> 
