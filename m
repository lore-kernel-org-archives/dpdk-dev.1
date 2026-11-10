Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0782F606A333
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 10:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ck40yJta
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CF1B40DD3;
	Tue, 10 Nov 2026 11:48:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTPS id D9B6940281;
 Tue, 10 Nov 2026 11:48:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794307684; x=1825843684;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Q/P3PMigitJLD/7nKvNai6MyfCQTGJ6SDIhP6NiiGNw=;
 b=ck40yJtazO2Rghhh89i1dNL4CoGOz+SrO9Lg5pxyRhlWy6YiKA8Y/lAd
 B4DluHaplYQ6wXQSVO7UUgFRuCQxAiOOu8pROVjOhJ7cNiCWni+l2QJAE
 jtKX7gnr0r+X9UAV/lLpychMiXaXFl2mafYuPjPJWNBTnHi+s1TnxQgVL
 s3OF10QGGU9uaJ050D0YhGNeCoQxhhFBYvYVB9pA6J0ZxUQFnR23z7dps
 myxlWvy7UmIdLYOY9kgSHYqam2RgJ6vK4UdSJKgo2vrjEQxEqAjBYKym9
 63VVvA/G6pzsq2XkjpX1QKS1AiyOgCeX7jwPG0XPf07mKCH2C+opLPMv9 A==;
X-CSE-ConnectionGUID: 3FgSmvGORnaeTHXDHlMv3g==
X-CSE-MsgGUID: MkiaYURxRwOSuEigcFlJEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2937222"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="2937222"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 02:48:02 -0800
X-CSE-ConnectionGUID: nw9Q4K/QQ96Q5RGYD9IHZA==
X-CSE-MsgGUID: 5q05UmkFRn2oZYqqrml2yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="9857971"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 02:48:02 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 02:48:01 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 10 Nov 2026 02:48:01 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.34) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 02:48:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhyI874Zsrzskaq3LCdNPFgLpr5xGEch8AnraYRkz3uWAssJGtCSyujWz5iMqZ3R/8aMbMzG8+Ljbdl/OHabTU16xdc44kMcZEjc2JVeMyROX+CR9J3h8a/1zn4jbZ2ih+dD2CUGFsWqRjmFdV0Ui/cbRVhSMPc4ehZRsX29UbPMuqfLgoFnPm9uFkhT+TX/mGd/0UVxXl/UnoHTRSGwqHMBjXKc0ahH3Ccw+LsCnn3spB8NU0ocvS9X68x7QOrbVJhNdL7AHE/FPTToM7IZVuh22pgGs6v1AjtDMzFlNyqaNJbeVjskLuPmIH6dCjqcuS2zmhtFv02RHKhajk/quw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjwWAWAeZehyJInTsTSHpVu1dR6c8SNX0EUhX5wxCi4=;
 b=E2/6ztfAlusHHqlKaqf1JXyprbsk3v+6i9cWTt9/fyBQq2ApLjjCghvbzIW/CA1rnZHM2mIRQKLO09aRxN+H4dWj6rnp6kloAWO7vNDtdPDkc1JQBeYCSONCqDwUW9pIGAi4FnefQp0WD8OZkF9GbWPQmElu/m9UKPoEyRWfkC+X1tUWMbKx9ZsQ/to4jnIgtZYP6wNBfpBFnDy2GdFOeuqOiNObPsJDL+u3z3jhgSYdAzlUopvh0CZkXUmesNt1eIQEyvEd02G4D7GIkMIJz+PQjGYDIB+31SIKU6mUvtyNgxboe1Fvf+vNnxoa3Fcl6W/I5gF7ezjYJkOs1YHD3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DS4PPFE396822D5.namprd11.prod.outlook.com (2603:10b6:f:fc02::59)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Tue, 10 Nov
 2026 10:47:53 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 10:47:52 +0000
Date: Tue, 10 Nov 2026 10:47:47 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Declan Doherty
 <declan.doherty@intel.com>
Subject: Re: [PATCH v4 3/4] net/iavf: fix watchdog clearing reset state
 during recovery
Message-ID: <avL2U5FwW1bHDiyo@bricha3-mobl1.ger.corp.intel.com>
References: <20261105123237.12279-1-ciara.loftus@intel.com>
 <20261106094014.28784-1-ciara.loftus@intel.com>
 <20261106094014.28784-4-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261106094014.28784-4-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0135.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::6) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DS4PPFE396822D5:EE_
X-MS-Office365-Filtering-Correlation-Id: 30f49e86-c9d9-4838-50f5-08df3f181220
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|4143699003|261009223027099003|261026121527099003|11063799006|261021123027099003|56012099006|261026140227099003|261022105027099003|261022075727099003|261021121427099003|261028144727099003|261102123227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: NP11KrohNX5tFh7j+yXUGAyKw8Jhhs45l3f0YKUsYLYifdfo7u5ejsbXnrH3r1B/4ucMMmhD/9FTQVgCLh0PShTar2g4HlGgg423xx/Iy6a67l1UtJ6twoEUGuwkQ0592pjtd6/p2UxYi/VGVU59hJG8pZ6y98VEK8Bhqfl+B972pAHmKqmZdu4vLSNModSt3BJdiMxL8djKbzloYJ4+UP4yjh0MH7M9nW9cn7FvVo9pJB65rDLiyUIBqlE/YAWnDgfrzLcuHmd4ZQMy9AXiF1FNUqRqBibIRD+myhT6AmBUW6ra9CHBmM92g6NNtbks8ExR3tz8BdFm/lPT3UONvZ7iMHpqU27E64nO97HP51+GY8fBzkl1By/VkD2TMpULNCfOawHnQIWxlj4eLKaNyBnkZht0sj3Q1qJtQ8DdLooKGUNteVgPbExHsi57zm/3/xZrON4SHGseFcZriFBig858dOU0Y1fnvfUQvIhDhHBsizElyEYWr0lZ9qDYIXe3R3gkXgKw1Kn/tR0zGy6Y5t/mEJwB5BPRzvmsS97HDhhFRZm3nFxcrNjO1wUhDl3swWhio7gApKoaAw/E+spyaCUde5T4L79/MIXsbWxLjC+CJjTyKtUvBvMMnQDp2+mlBIjl0UpHB+qh9YYQq7av7GERnzxNX6OCAhC3/QMGTxk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(4143699003)(261009223027099003)(261026121527099003)(11063799006)(261021123027099003)(56012099006)(261026140227099003)(261022105027099003)(261022075727099003)(261021121427099003)(261028144727099003)(261102123227099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1ZcJLaSM7jNO8QIg39jXcwsrnlyR7ibaaurhbMQOkS1OnNH5iWDbEr1qHmPm?=
 =?us-ascii?Q?STkUcZoAvbrJuHAorXE5s4FOTia5tHtjb6L5nU/Fz+FwR79o64Md87DoFJ/s?=
 =?us-ascii?Q?1UlvFVuLTdIjOTLPzKHOQMkDy6Kg5Bi0Ipl+vF2T3ktSO1+FOKU0XJdxWorY?=
 =?us-ascii?Q?RkanX5S+OhKJHuahDoEbimB0rula7eMTHyhThZualhFhvLxiFUWQMzkZhUGv?=
 =?us-ascii?Q?S61sXnAhjAXyCdOCIKPYlZ3gLxOOLxXn+WzWYzC/0wBc+QiiLvgNCqym3AZv?=
 =?us-ascii?Q?aUvQjZ7lbyJ7gLZsZ9j2QJnWvBRPhK4+ngz/eMdbbR0Ck4IguNEAVhP6MKL+?=
 =?us-ascii?Q?pby/Ivh/htzXvU7Q4LuIx/KHiGErVbyRlsjCA3C6BfNibKkF9SNUxM2xz8Es?=
 =?us-ascii?Q?RCVYi6+NCEddypW6jMNeggqcSLU8rQp775wgfuRoCwK6OyEYtt8PXjUEat7a?=
 =?us-ascii?Q?9l1efThBrNdc8dh/oUldCfDqt4WP2U9RhFXVhj6NZvEuuri4I6EkLuNhpQwQ?=
 =?us-ascii?Q?Ri+4kVXlMgllKvZr/9OoRXfoauZamPTRtDu9hFof0S72M+q0a+p6F3PO6Dee?=
 =?us-ascii?Q?k4O8jgjRIGeGR2EB/yz2ZtfD6eW0kEh70NgcXr214ufcCPa7Kxmm2pLn/B/i?=
 =?us-ascii?Q?BseyFByZShlN0BxHvjHfhQRM0/fmKyjoSE1DbMpyHaUJcIeKwhecO16GdxhJ?=
 =?us-ascii?Q?TKKGcf/hJDIcRMHevqFcfHl49WU7n2WDuDDxvJTAQIEoZzsQzCmxr5CPwsSa?=
 =?us-ascii?Q?ZSH6LgaAZhsg3qhTUFQqK7BPoz+jDAzLDrsjkAWVk3XcPJW58XlFUFI32t2L?=
 =?us-ascii?Q?cKKU1TAHf5VO7UA7biaU/wARDzyOh3xV29gKFPMSH2qZz5ggB47BaZj5wv9D?=
 =?us-ascii?Q?TJhdTo8uox+Qey0fO7u/dBZY8fiiMSQPMNY3C0OMb03YuYUoiW9ddoCYuwnj?=
 =?us-ascii?Q?ZqCSSOQrg5FSmitEUZ+Ua64gWdHS6Fx3+jveBYz0hfUBrltUuy8OI5uusxzm?=
 =?us-ascii?Q?uPsR5irEpnOPRnS6nck2cOKHzpaqv1095pNDhLt9R1zrVa80kKVNIMPnYh2t?=
 =?us-ascii?Q?YOJtQjCVSb3kRh0S+/GUzyUWvevH9QRwXfpWs65SLRU0+kyMvYoJSPxbDI0T?=
 =?us-ascii?Q?LDy7oSzA6qIF9PqmZ9uYBk4kpYpxU6RXbqXx4P6ukfiifWS46TBALsSN99EP?=
 =?us-ascii?Q?WjPVI2PQ7Ua3mkUwsVAix5xHfwltC2c35el8i8pLuAiAujfy3tnvcbkmL3eC?=
 =?us-ascii?Q?YTiNOIWqAeWKJFNXYBZ3zNEM5xZjuAUU+UpDZaKTV5iutxYiHo1wghnugzvY?=
 =?us-ascii?Q?E6NigrmdD8raGl+6tdAHV+W4SB5BZEpJZBVnK2fUfkUbwfm13x+E4NvRKqZC?=
 =?us-ascii?Q?RxguDrU0f6fLEAe7J0JvOzlUsiwhf7zWsZ7zX06syvqEIQFNlBPjNyMHYpx+?=
 =?us-ascii?Q?6MDRx15km/o1+jiXUvz+Nc9mBRO61lAT0l/BUII+QnhpmFwnbe+oMfcy/i+Q?=
 =?us-ascii?Q?cX+Rj+BEdscX7+Z2iqIQXkI6WnaPW63kCi9UEiJu4SX7Z5c7oKoi42lWrmBY?=
 =?us-ascii?Q?+osMdZVlsaltTO2xV5bo3a7V9wmugQBEhRugW7fdmQNGncStC/l6RWfLG7EU?=
 =?us-ascii?Q?hBsMXZhEoeeJeFBP8iuJlCrHGUw9BNWqeFoFDb4sSb5bg3HEXK4fpyLdQZno?=
 =?us-ascii?Q?vo6uDsby61d/Si371EHH1JiweNZzNWrp3p229CVPuVY3PAaE6xW846gh6UfL?=
 =?us-ascii?Q?W+tATJBi/A23CjeuTMdIOv91rO1Bh7U=3D?=
X-Exchange-RoutingPolicyChecked: wAcisk3ICIbd5pj7NatusyE2dBAoSnQ2fA3ydae4Ua5RYnYN0rwRLzDFJIzEWrM+G3JoXW/Rt5kzJ3WmRSE0GasVQonCtQbzBtF8srdEbWBA7CwC+BbK3zcHCEnpgzGEy4AAPeoU3WsVhDgVx4qSUijz6rpr8PMlfrNDAkngRvC+BbGflaRBqlMIcJiBXPJ8uSHbtF0q1CebrBfGnUEl0ZcVqd4s8h028dgn5E5Jeg6mj9fWgVqMMfzo86O9IN00wjw2DSVV/cJjvnyG/f8cueuey0h/2F3DcqA41pSb9TF/n2Mbf5Xj8NCqiTxXG6A55nimfXwNtTVR34futiHpYA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f49e86-c9d9-4838-50f5-08df3f181220
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 10:47:52.8787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mdMaX4uYDZwRcbi/BYoy/jdt79RPNwB+6JmCPpVmHgvGbfojjilYmL4tTlLlJ0s94LDLeOcTyisnDJfwjXKBp8er9hF0nt5/sloHzVfI2o8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFE396822D5
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

On Fri, Nov 06, 2026 at 09:40:11AM +0000, Ciara Loftus wrote:
> Since the watchdog is kept armed across a PF reset, it can clear the
> `vf_reset` flag while the reset event is still queued or being handled,
> as VFGEN_RSTAT toggles while the PF resets the VF. iavf_dev_close() then
> skips re-enabling PCI bus mastering, which the VF reset cleared, so
> VIRTCHNL_OP_VERSION never reaches the PF, iavf_dev_init() fails and the
> port is left returning -EIO. Each toggle also posts a further reset
> event, causing redundant recovery cycles.
> 
> Count reset events from before `vf_reset` is set until they have been
> handled, and do not let the watchdog clear the flag while any are
> outstanding. Also make the `vf_reset` flag atomic, as it is accessed from
> multiple places: the watchdog alarm, the interrupt thread and the virtchnl
> polling path.
> 
> Fixes: a0e296420a70 ("net/iavf: keep watchdog armed for the whole reset window")
> Cc: stable@dpdk.org
> 
> Suggested-by: Declan Doherty <declan.doherty@intel.com>
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
> v4:
> * Remove overly defensive check after reset callback
> * Added a log on event post failure
> ---
>  drivers/net/intel/iavf/iavf.h        |   6 +-
>  drivers/net/intel/iavf/iavf_ethdev.c |  32 ++++----
>  drivers/net/intel/iavf/iavf_vchnl.c  | 117 +++++++++++++++++----------
>  3 files changed, 94 insertions(+), 61 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
