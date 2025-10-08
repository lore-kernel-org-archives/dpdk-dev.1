Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6392CCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Oct 2025 08:28:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A8CE402A0;
	Wed,  8 Oct 2025 10:28:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id CABBC40297
 for <dev@dpdk.org>; Wed,  8 Oct 2025 10:28:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759912120; x=1791448120;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=nbnHDE7zlWrsctZs8o/LxY3+XwbOXvhEpIbkHBU+raM=;
 b=KQ8Ijl3RJmPydWQOkbFGhZIgPirGD3i+aNWHsQobZYBAnvVGI9m7rZQ6
 JkRgunRBaMEwA9kRbLiEKh9gzFhnBxpb59ZBZHi+xvqSs5ZG/gWjS0pM5
 CBHVi8/5/y7svb4y6XNKcE8qFQyGtsSopzFjxjizZjJTNRLd2HL/6HR7t
 tOS8PC/6S8PgBXAtwy1ECy74IlqjfKXQufrqEb7+VIvVsV9AwRi3vEeV3
 xnXAizmjHOorVLFpB0OjER23UvH3k36hL8iANqYJGcbicNPin/+01TYeN
 hdMQ8HLUMLWh3GyAi0T8etnx+6kOdF+cA1BaO/UiU+V21CpoG4MXlca0D g==;
X-CSE-ConnectionGUID: ht7mmT8vTTuCNaOrrlYMSw==
X-CSE-MsgGUID: EQ7D/B1fSWWzkpwHOjK/Ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="72359674"
X-IronPort-AV: E=Sophos;i="6.18,323,1751266800"; d="scan'208";a="72359674"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 01:28:39 -0700
X-CSE-ConnectionGUID: LJcxr42aRH+Vnd53tnbarg==
X-CSE-MsgGUID: KydrSycNSFqz0gG5tvSRoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,323,1751266800"; d="scan'208";a="179973413"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 01:28:39 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 01:28:38 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 8 Oct 2025 01:28:38 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.6) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 01:28:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kcHM2LmsuYM4zZdWXFAl00dV1WwXOptoUf+aEPWj4xTUiMkD0rNfcp08SHMIxrMxdV/3Uwdsccf4FFHo/X8U3gfFsRw2ZqPi0ahvdKTM1NqNiAB1b6MMBqXe23vu1xEwspKNK4FPEefeU4dSovgO0h7j32wufyuyiZLRnnHrmeAZREQcAIZUgjmPvBuDZHS0hutYnLAQtMUK9nGQ4tx3hT6QEEKu/KJUUn1R6dA9hfHoqRlXUfb5fzcv1kvDHM5uLNW+Gi8sEim4ytBD1pO06fxAWvJuwZuf9hgs+Z37irUEBjbVktCrWMVtD9XQE2naEOoFotmXoQSZ0cKjWsEjPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6IZD1NFRsWH9WaYKUvj2ihsgJ6pR3dWZZRFU1Yl93U=;
 b=DibN7xXyJM5prBvnB4nDWuhgRNUYuolBBpT7haIQ208PR7Ib4Gs8iIpxbyhU6Zei79DM/2VoMmjonxX2k2bzevhaD7p8r9XA/A9wLtyZfghI2WYhYDM1toInaAf3j9pL6M93rbtcw9Xf+D/3UZtj5ToqWTwTE2H6OrkPiqivmCBUXBOmKReNR2Q7HKa++YuUg65fnYFdgesuDfajXKrWPSHvEvhMqbfYZhZgetZYIG159LoVxS8UEgfDzMdlESTTc9/YxCbCUIIbhYO7qJqRnWoeCEDVJgUgFgW7tVTvEC3qWFbHbsiGTaBLTMIbnXUbFJXofhoeiBIAwuMF9vhU0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB8081.namprd11.prod.outlook.com (2603:10b6:8:15c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 08:28:31 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 08:28:31 +0000
Date: Wed, 8 Oct 2025 09:28:27 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <anatoly.burakov@intel.com>
Subject: Re: [PATCH] net/idpf: correct the enum constant name typo
Message-ID: <aOYgq56i7mnEohXn@bricha3-mobl1.ger.corp.intel.com>
References: <20251007040436.2924355-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251007040436.2924355-1-shaiq.wani@intel.com>
X-ClientProxiedBy: DU2PR04CA0009.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::14) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB8081:EE_
X-MS-Office365-Filtering-Correlation-Id: bd9bcf1b-6011-4e3e-3bdb-08de0644aa1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TEgda8TS8j3mkjBVxPc2voSaWOP2SuO6OcgmR8e08S5okKNsHE0zSHeS27MP?=
 =?us-ascii?Q?MpZ6+3B17rnHC9mqAVMoJuS8bPxF6Ud0DY//+JVbV1cbIv0fQiumD1TnT/k+?=
 =?us-ascii?Q?qpmZk276To03N61XtO4wxsZBoscu9OS0VQA3BbIxqhtV3+6NuNMdDbTwpGMS?=
 =?us-ascii?Q?7f6vsgVY4BGeeRzxbdWmWd7wNVwbCsvLWE7CPf60gnOQ5jVB4Wue2pQAAyL7?=
 =?us-ascii?Q?i+aKq4RBicJ2kLa6ECX5tlG0mvC/R1ssmNzqaLQKJ9Wlo0OslRJ0KUHHrz32?=
 =?us-ascii?Q?VyPq42ZcA0fMbEA5zoJ06U7cflbCGeg2ki6eUim//MqzeMM2TMi5qNzXnCNN?=
 =?us-ascii?Q?3c5+JosPdoV0f+Y25z0BAjxIALKIWi7OH0SwdEJ2r7fyw3c+W/Oy45bjND2P?=
 =?us-ascii?Q?Ugy2orgEdDAVlUnJJnv316zoiF5n9N1BgjI3ojmyhH+tq4N7iubphZxxjQgu?=
 =?us-ascii?Q?r9Mxw5K3qhLpMNf5N9hO0OeuE6xQumt0QXsAxvsQB+uXsjJoNlIzPKfGO1vf?=
 =?us-ascii?Q?P0OqBl5MugmAnwfUvnJsTxyN14D6Tv6icU36alSJLuTWrJfDcov7nJHPldT8?=
 =?us-ascii?Q?3rItbFr/+03VhXMtSbz5pBv1GSqChq7eg1pMrm8mQG/B/eWTMgKykbuCIH//?=
 =?us-ascii?Q?XCHuWbH1FM4P0uVI/svM/PqV0ODCaYJMr+DnrUlmd41AMoQrKbjKHu33Gj/R?=
 =?us-ascii?Q?hjTMEXU2OYaY/B42hhZ+/N64n73FlZ2qx1mIQZ3uG2aKCm1apNINMZ6Oc+qE?=
 =?us-ascii?Q?/YabqzMJKUO4oWqp+k9BBqWU6vkZYeJkil0nRw84zctwBe6cG/oTEaOek3uY?=
 =?us-ascii?Q?T/9LKQppBvHd2k9uiRFJB5ZrzfEvnG7Si2Fiyn+sml8Xq8Dq+YdFFDScWFbY?=
 =?us-ascii?Q?Uh9a0ATLX8SBaIPFv6giwyQW5vSMxsNSHADkutHx7LDWmEiVjyFOgNDOxcKa?=
 =?us-ascii?Q?z7lHSmc/wuYSoWoFKbANUSV+9l4PFjW64wHthox9LPhdC8zizsBKaI54WE1X?=
 =?us-ascii?Q?7jB5maieKutDQ46sONuwnGSVDI0gHSen1t3NoK2OAC4OpuQpF2xpZLZJy6I4?=
 =?us-ascii?Q?yBmOg8Ho1BGvU7gnK3MFDAgYUo51lOp29wavda37qbhWCiIAc1CnfavwfaCZ?=
 =?us-ascii?Q?4/T9U0v2BUoSsyKSWVbnZ2GlxeK5c2KmVTAGAugJjIypLKHGny2lJm507FGJ?=
 =?us-ascii?Q?F2nCemry7mrcP7dxOnzcaE17x7wjXgo8CLMH4U+bHSUg08mRU7EGfpPHKiZK?=
 =?us-ascii?Q?rxmO9/QVKux8YRng9lli6rYZtWG5VeT9Sm5fvdpT4+MWJJ15xxGOKKh1/c5S?=
 =?us-ascii?Q?Kw4ZRD8HSW8t/FK92ln0br9/HUw0UA6baTe4ToK6+vDHc7GoViCGGbmVHKuQ?=
 =?us-ascii?Q?apJXBxZz+cqfuHqMS4TnWtywpjejusl/yKRd2DLfN+0FqBOZauNZRPRlxs8y?=
 =?us-ascii?Q?XAtBTVSnTblJPHgyaFxD1AICxP0V5M/x?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E0MSM/md42fn0TDoUUQ556ZDnfHMW74BiHC3u1saM8JVNNfddq31i04WvZ2X?=
 =?us-ascii?Q?gbQbRkHjggoBDtqjodwNDEv1tM1ZX112NIHTxEF5uzCF3nrNPbdFnYAFsS0H?=
 =?us-ascii?Q?DpRmXKqH0DllAdFgOi4JioKRR8IYoz+i6Cettd6zIqu6xQKfda+SLVS3N6V8?=
 =?us-ascii?Q?bCSvSoP/cV6Gs8qxt7w+l5lyLlIZUC1xLV/pe4gWkgsBm69EL2jOUifbljGO?=
 =?us-ascii?Q?mwz+slE69goYWjWkKIZ8NFYuL5DrGkUzu4H+k/j1e7xmdbQTgAE8U9qUl9NT?=
 =?us-ascii?Q?Ozj6TRnpmWYkH6DxER49ogDKtmTYs7K4L9z26nbY7AcQPInZ0+pVfg8EwXai?=
 =?us-ascii?Q?bXiOcA2Vy2Pu4WVz9qz0IgnP45TkreIuIxgXqjnwZNkf4XTaFIMhpF2j4vYK?=
 =?us-ascii?Q?plw2BBKQ0Ykx3JoAFKnMUK/4zCUEdZQSq7herHAsNiAk+aWe+JnYktDx9g2t?=
 =?us-ascii?Q?jNQbxq8MtOuVF63/YzOin/xPRGF6JlL/ERFyMCQiMGcSqYkWKaFeowGn4b3f?=
 =?us-ascii?Q?TiJPoddwen1LLvUu7AYSxb5w7gminYBojUQjAB7WlZl4CJ2yCzAeAppzzq4H?=
 =?us-ascii?Q?HZuEm25fvzaFIN0XLWG3S9uvDj8XpSs0MXCUK1s7kZcSpbSrRJEdxb21TXtT?=
 =?us-ascii?Q?bt5fzmtImiuiBNPbxy4dqV6tKRpGnVG7lQO1rZllUz4dPX1HE7koF7Ri8asd?=
 =?us-ascii?Q?9obV64/y/SCWwKBIEylnUYSD5ioSiXrWo+kjFAM1StYSAd8BPiTDPpvYAHNn?=
 =?us-ascii?Q?trNljORBJpzYos5C9kDemDIiZS1jduCnD+QS5MD1f0zz4HXx2P5GoV8+84E2?=
 =?us-ascii?Q?CT/wpVV+vkKYoWD3SkO9Q3ZsaFFtI3VYNy1k14Xn/Ot/LaBnWO4BvKAhnSn9?=
 =?us-ascii?Q?YCUw4GjNeH8qqBIKRthunZYhWw8Jkb5I46VLR+TsCa5LQ5WIclv4QlM5DMcU?=
 =?us-ascii?Q?8zzaLUr3fkiP5jGzTsEETYVRCXECTPxAY4pvNSWRwUappf4by93UBwgrx8Ec?=
 =?us-ascii?Q?sp5FIZ+s0WVR4f15+jdzU/0BIzx8NYU5PvK2B2vnVm/x/YYexF4jVjSDjIdn?=
 =?us-ascii?Q?3T0uRfo5y0/5JENKUGthdp912AYhoY6R0AGf9W8zEJmpc5/NmyFTsMZsRO0F?=
 =?us-ascii?Q?Od6oQSrYsban2PEtxd2bIr1ULYVKCicLsywJa/bt2heyAlXM6TQREov8qEOZ?=
 =?us-ascii?Q?Urr0UMv6qskX944BMUPCcQAdiVeGnbH6LsxNDQFeVIgJ+F2VmE1ekd+31yUY?=
 =?us-ascii?Q?A32Ovve7qgjDwOZdIfTEE44EjOJIy/Qmq+HPjLG5EMdQaL3S9BVkghzWrwCG?=
 =?us-ascii?Q?Rwqy3ppgAvE+ygHYxTabcPyS3PK1+2wbO6PN/Q9kcsMNxKaeWlNVZvpc3VAA?=
 =?us-ascii?Q?2XW0wXxM9qA9wLKHqthmwsXrt7W74LDYIvUQV8FOxxePn95dEzJmzoefJcZO?=
 =?us-ascii?Q?3/SP1JcKvXGthAO2Fy3NHjDiC9Vr3iTFvZ54KG9wiKSU9wtt+Xql/mTyfgFz?=
 =?us-ascii?Q?OmT0bL10/W+BNom9oV82v20ZTis9TBzQXFI7QZnp9TCZjT5m8YY5VLO3an+e?=
 =?us-ascii?Q?UuLYLy/YEGM6Goy51Be+4UtwhwCL9dlnJ8gdc5BHW8D/kXfqsORMtYxKXpp1?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9bcf1b-6011-4e3e-3bdb-08de0644aa1b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 08:28:31.7065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XOWRgr2/DntpfUYw8TrkJmq1UsaT0UuCD4P6W9hKY7z74ei4S51bVI+Xxvo8tAZARZsj6HA999TYsRIm3evwhz/8rviyOgob8bwm30Ln15U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8081
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

On Tue, Oct 07, 2025 at 09:34:36AM +0530, Shaiq Wani wrote:
> Correct the typo in the idpf_rx_func_type enum by renaming
> IDPF_RX_SINGLQ_AVX512 to IDPF_RX_SINGLEQ_AVX512 for consistency
> and improved readability.
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>

Fixes, even minor ones like this, should always start the patch title with
the word "fix" rather than "correct", for a number of reasons.
a) for consistency with other patches
b) to mark the patch as a bug fix for possible backporting
c) so that tooling such as check-git-log recognise it as a fix and run
additional checks for things like a "fixes" line with correct commit
reference.

Point "c" is especially relevant here. :-)

Fixes: 12b1c2901761 ("net/idpf: use common Rx path selection infrastructure")

Patch applied to next-net-intel with title rewording and fixline applied.

/Bruce

> ---
>  drivers/net/intel/idpf/idpf_common_device.h | 2 +-
>  drivers/net/intel/idpf/idpf_common_rxtx.c   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/intel/idpf/idpf_common_device.h b/drivers/net/intel/idpf/idpf_common_device.h
> index 3b95d519c6..09d59dd0c1 100644
> --- a/drivers/net/intel/idpf/idpf_common_device.h
> +++ b/drivers/net/intel/idpf/idpf_common_device.h
> @@ -50,7 +50,7 @@ enum idpf_rx_func_type {
>  	IDPF_RX_SINGLEQ_SCATTERED,
>  	IDPF_RX_SINGLEQ_AVX2,
>  	IDPF_RX_AVX512,
> -	IDPF_RX_SINGLQ_AVX512,
> +	IDPF_RX_SINGLEQ_AVX512,
>  	IDPF_RX_MAX
>  };
>  
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
> index a2b8c372d6..5a1c1561e5 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
> @@ -1663,7 +1663,7 @@ const struct ci_rx_path_info idpf_rx_path_infos[] = {
>  		.features = {
>  			.rx_offloads = IDPF_RX_VECTOR_OFFLOADS,
>  			.simd_width = RTE_VECT_SIMD_512}},
> -	[IDPF_RX_SINGLQ_AVX512] = {
> +	[IDPF_RX_SINGLEQ_AVX512] = {
>  		.pkt_burst = idpf_dp_singleq_recv_pkts_avx512,
>  		.info = "Single AVX512 Vector",
>  		.features = {
> -- 
> 2.34.1
> 
