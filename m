Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71AC606A31B
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 16:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oDEnV5cY
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D10F40299;
	Wed,  4 Nov 2026 17:44:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTPS id 567E440281;
 Wed,  4 Nov 2026 17:44:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793810686; x=1825346686;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=jrZ+EYkfDE0uvLTPHsWHCDGIbC2tOwzRtr+JqmDefSk=;
 b=oDEnV5cY1gG+ICzcYBaYiSHD8lZhqDFtxyP8sQEk/+NWihhcGkfNKq3a
 tpK1+RiMxVl8/B7jrzUCdkO2O44RLrDUzkFuZLcDFPKSoY0NK56cx0gU6
 eK62hhF/hmhKJin86uUqvnoFqrLKc+Iz/XpjNue0nuaN0eQ6TdOIYkylJ
 WYWmfCsnXW7/U/H5STNB+8Q77YVZNe2rdz1tujhDu3Wc7R2nt3r2Ni4+B
 tQqRq09a/6EDxCedKcCpfrAWDx3BlwTZFdESykCV7B0XIpMpNb2Bg2SJ6
 YHZNDYlFt2EMy8Xp9GQ6Zdme3cmg90KptNiHBJoYObRa9pZeMI1SOVqO/ g==;
X-CSE-ConnectionGUID: 4oxxgIYLQa2Iy+ARLB2OBQ==
X-CSE-MsgGUID: MLQXSU3qT3ymdjhy56adSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2577093"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2577093"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 08:44:44 -0800
X-CSE-ConnectionGUID: u1Kj3U0yTlK4LZsllfx7jA==
X-CSE-MsgGUID: /Xq+U9+3Q+WTKTI6obUR1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="7085239"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 08:44:45 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 08:44:44 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 08:44:44 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.60) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 08:44:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y7wOivv7SZBS+h9xdtsplHAINZ+syPfXGD8G9l4W+YXGKaws6Iw2TWhF+mHcgrpFIk4YkeuEdwKiTZvSdqiTZabBvvSY7/8X6C707Tuq6SCNvBy+xtX31nq+DUZM7taqaStKL/2winLIkLTO5gdIBiwuHyaWIwuOJ3N64usg29lZzLE/rG+Xv1ZhoDi+eDzHqNVdL2f2saKIGRAXvaU8gko0b7MWH58c6WV0fqlFZbpRwONERRnRZWq5yibc3fDKHEDmrPrWVvQMmBXlI/dz17wLT4KZErrHtxn+tXRuv8z+anXU3S/OPAh0WEgO/aeYlEPCVB3ihtMDfgWssFbImg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWwqU7bMPnbFM50glNoogbboGbI0kAngAymKCAEWOa8=;
 b=zWlkbve6EsCqnAJn41z3OhxxD9sj/QxMTsJur4xaGctJhJILSaUkf6Ee1tEV/nu5bAoe0oMRRv5p/pWPCS6eil8cfxIEIPfrPRcISCZhoYzu805zfLAOnDqeCJkE5DE8f9H4igEBV+oqPl8n2Of8llub3I6kU1uu4GCqWY6zY6sg8OCn4MDK9/N+2+zg415kddXhFCxrPAHGHBRleAAR3betxQECgTNipeeCpRLeZzw7lHSx+lFjo9C571qejezw4D3y/vYEJgkc3+fgEBas+XLdwiPvXWs5OYowU1VNc/5OdzBdMdnWFhIW4lrO/KKAwm0Ul8D0PtfAWzfhaYwRlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH8PR11MB9534.namprd11.prod.outlook.com (2603:10b6:510:39f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 16:44:38 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 16:44:38 +0000
Date: Wed, 4 Nov 2026 16:44:33 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH v2 3/7] net/ice: fix DDP filename leak
Message-ID: <autg8XH2Xw4VCaRc@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1793605751.git.anurag.mandal@intel.com>
 <5f11c6fcf4e32450d9b020120018ced1bcec6164.1793605752.git.anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5f11c6fcf4e32450d9b020120018ced1bcec6164.1793605752.git.anurag.mandal@intel.com>
X-ClientProxiedBy: DUZPR01CA0092.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::27) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH8PR11MB9534:EE_
X-MS-Office365-Filtering-Correlation-Id: 9af58007-401d-4644-8d9d-08df3a92ea39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|11063799006|4143699003|56012099006|261021123027099003|261021121427099003|261009223027099003|261022105027099003|261102123227099003|261022113327099003|261026140227099003|261028144727099003|261022075727099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 0XAbf27TAKTtefgntFndjsKkWqPZy9T9iLi3jFp6oYZ2DTik1pjfacobhq73MbJ0vwA6YNkIlha/mRdKZM+1VmJnHzv4pq7DSPvl7fiA3MXJxD5ZeHBzq1qGhtnqWcc5iIT1C8tBWcahGEvw68NK7YpUyeLYPfxiwpVirMW8S2lBMU0FybeEd0vnyPAeEgsvjz1CJQHwm0QoZigXYgG+u/G3v5MWBhzyvZsez1RUFV/oBCxTysykmZqKmEtO2ZotafPEeVpedHqXWGJvx48wXICIN6jO9h2kL9YV4KDZZgN0hGbLCsW0s1TU1ZYszwCC36zzq7va6EBw8QcX4YUyBxmt4vWmW6JF7oAUzc3NUVmmds46lErM0KJJHeTn17NmtdZEZMJLsHLPF+Kj7a+3razudCSnP8bHPHQE+Yp87CYp/UNuEHSx2Ahmtz+loZcxQGm13OvIjW+W9LECGMdf5BD/tTd7Xq73F3KUHqv3BT1d+dYUT26zP/eMTbYvXgjPQWj6YHAOBEl2P+7xaVUZUX3i9Xo1dOOJK4cMPZ5SkebbK1M+DjhLfnznPAvD6cMlMWfCF2iR1A3g8ur4hBKBw3OFKczCcnG8qo7nkVYWcc7V/dEHQ1sVplf7f55MC408RzWIYQUmkh4NwGrG6Tb9okfnQsTS08hrbnyCcz/CcFE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261022105027099003)(261102123227099003)(261022113327099003)(261026140227099003)(261028144727099003)(261022075727099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6sLMaSHvc+VtoI4371eNxoU4ZZxr0/nGeB9UIX+OVE0YGeaAO4JPAgDPxMve?=
 =?us-ascii?Q?op+jbCzubPYIes3R1k8miWZg64UziCBK1nHPoKE1iieqb4FqsWGseLVEuPjH?=
 =?us-ascii?Q?CSZCHFyYTosL+WWh+Tm71Y8NDOSOKkOlQAiNnTj7jV57wq2i0iqeZOtmd2zH?=
 =?us-ascii?Q?275klGJOVmcbVzK2Q3oc9xch2ArKiaZNZO5RBfHdP/8oE+2LgFLSdOsBd2Bj?=
 =?us-ascii?Q?T4Vi4Limesb2F9Aj+vELZsPLUnSDZsQ1MaQO5OTs/GmysO/cCo7GNbh2lM0e?=
 =?us-ascii?Q?hECmWw84RvQrZysEU1yXovcJaaDvnhlUcj+bvz5HUABr7vlnUMQmgql0+g1I?=
 =?us-ascii?Q?tCF+zXLpYwczHn/tPlhz19ykc+BPMKyp62SM5x6ZngLWnQQ/1bV8iZUSt3Jz?=
 =?us-ascii?Q?MLnEGyeoBoR3s7mK5CQMTiPrYkI+NAvlzGUp4NCrVyODrNUH7BYQBZB9rMwP?=
 =?us-ascii?Q?XvquO0owMULgVJ/wd1XGcypTi9Z/Ep2ErDpn3FRX6xFq5zdjpkFNIdNN0Nip?=
 =?us-ascii?Q?dXZVdeVvw7eFXYaCmla8Gx38aUxJJK3Gl+N7xUHOm41RWlGrHy1jKielEo26?=
 =?us-ascii?Q?VGbLts9aqKfMCy1t/lA0pwq2IP+qE4LRUZcrBdGeUVZUf94pGAX2+/Nlk6U0?=
 =?us-ascii?Q?cEYNASDlTMP/OYKjFp9OApreWB9YCuYeWdIV0yxo03MN6wjTL3b1NrNeEizQ?=
 =?us-ascii?Q?Agei7iye6/ESplWEi5HXhZDNw0laGFyKxKqCcCQxELqcSq+zgtfs6pygTO/m?=
 =?us-ascii?Q?QqxIoRurWOzG93F65hrzmJ5gdp6cbj+n/5JMr8j6ensiXUXLYh/J7pAc5Vxo?=
 =?us-ascii?Q?CE/DFbBi8Yi738y1yZ29/dlGl/uOwngxO7XOi/q3Z9Yknb/JwDaU89vYI9rN?=
 =?us-ascii?Q?+bMSC1GEa6sXgNgvI055dFdvJfRQTaAQ4lrKdGIzoLCYezo+YRSHfYMsnbdN?=
 =?us-ascii?Q?KeLakaItQyCRCAljZPKhWhP/pugNE8c2iSx93GWABy3RHIfI7FN4TUulRVpa?=
 =?us-ascii?Q?C2X1b9hTXb1jqhZpOyLWxrreULdT58vjiQ6kzSDTxN8zWpdEgHx9eMnHybVt?=
 =?us-ascii?Q?0TdIqzfwt9x7Bc1dePLBpz4/aaGzvad2289PiZwZtDg15ndH+rGia/lKR8Na?=
 =?us-ascii?Q?FrqGjob6EIZzQCSKB9WLfFoM3NvOCZnIBrOsWhCMjoY5PU2h0+eTz7khuI1B?=
 =?us-ascii?Q?a+GKU+FjBHVqarx5KuBa7SSy9+mNVmXLr4ZUfHwWy3jqMcfjcXibgyPuijKP?=
 =?us-ascii?Q?87icQoJiIDHBqarmvWFQ/kjCYBYysPebNcezKvNFFh142BggBVoyy+IyMv48?=
 =?us-ascii?Q?XEe/tYqrKXEyHf/FkIkCSEiqNhlkhEzVrgNfZb7Ht3Ww+F2NlPy5e+K164ew?=
 =?us-ascii?Q?jPVFfbOBmCJQiVn4UfMA1YSMFiDpi+HAaDOlyuzP5jBpEQC3iW7gNYT0pgeW?=
 =?us-ascii?Q?5UCJF0k6Pg3L86RsZo2PmEewiPSLtWr/BXsqiM4N3xBfPc+BRqqnyiqibORz?=
 =?us-ascii?Q?P6DrmfBMypjUIvLcat7+NjPg2BDjYiFESt0irN5ysDVJZi0rlvEo8bWwU268?=
 =?us-ascii?Q?xMYrLSxoRXvHJnoKFU5KHeE2HXVXGMpV/WHRNG83Aep6AEZbp8j9dhj3Rthn?=
 =?us-ascii?Q?lPvkC5lbhruAi9qbulpKYQk2wOecr1RliQWP+tia1tngriMab8KWfzHjXZSo?=
 =?us-ascii?Q?/3kuOGFOZP3gxvZzanCWvOIT3DEvp+Qmym4WAsPiaSDNzX7J3q/miyYr17wS?=
 =?us-ascii?Q?KtEQIqNtFnm/q5UxMFAsQNdIPUaQdA0=3D?=
X-Exchange-RoutingPolicyChecked: loDCp65ceBtA6NKQvfpMv+5aqbMwfks4NJowK6f3VpeZZ//eNSh30WWuvrSWycqtXnuNMSES6kcgBtutsk+seR5AKnkRWixP2FyeMl2TpRYYm5fd4WE+cpxHH6uUlHogMO3UlE28leD3W6SbqfquV3f8Ojx0RnLDnL5AFvIIxSbUsnQdCVC3AmbHgqj725O7nU/IazZNK+rwlzX44R1KisuE3CNMGINPTJR9/R17sgHeSxxWlEe+QrpX27SC6PFG5DYMEJxsC+/Br7GNXNPUxDoKAU6bd+UCvAfb9hwfo19fCeDCIvvwdp6+kqgNjALa6IpWziZttlqsEj+GIs9XdQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af58007-401d-4644-8d9d-08df3a92ea39
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:44:38.0398 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RB+cRiUq9bXpSg7C+79fWe7fBeWkEnX2P+F9LcRC8fC0pVvx9wpABxS7XUPJsFBR7WsiLA9WKba29lKzAqItMEqcG+rvlYZwbAgPQ6XTWDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9534
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 02, 2026 at 08:10:33AM +0000, Anurag Mandal wrote:
> The DDP package filename given with the ddp_pkg_file devarg is
> duplicated with strdup() during devargs parsing, but only freed on
> close. It leaks when ice_dev_init() fails at or after devargs
> parsing, and when the devarg is given more than once.
> 
> Free the previous string before storing a new one, and free it on all
> init error paths.
> 
> Fixes: 9dd6dd1db834 ("net/ice: add option to choose DDP package file")
> Fixes: 603beeb970b5 ("net/ice: add safe mode devarg")
> Fixes: f9cf4f864150 ("net/ice: support device initialization")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>  drivers/net/intel/ice/ice_ethdev.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
