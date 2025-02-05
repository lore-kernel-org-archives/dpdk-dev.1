Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDC3C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 10:49:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7051440608;
	Wed,  5 Feb 2025 11:49:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id BFA3740611
 for <dev@dpdk.org>; Wed,  5 Feb 2025 11:49:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738752594; x=1770288594;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ezSZn57AlJMQleuA+R7J6NIU87xVJMff+sPr2Y4P6g4=;
 b=HL27gKxo5+vpAwZvAqs/wp0JIqUVODSDZ197fXhUKD2T6OBGcraoEiP7
 keFTmzIQMXv6izxKAL769Ahk9rqIpx6Yi1w6tdAGkMuJfWMCHHr90gB1J
 ZuSa1epnXbb8V9EIBKccLHKIDnaaF91lu7cmcaufV8UyP7r6VK5mNCxB2
 k2JSDTCx7BTGv9YErfJNAeWn7ymXMFHM87aHd+PUeZ6WPGvuYpeXb4P/7
 9xmHCca7Bks8nnTzGBe0dsfoMuM92UGjEU10jax1a/Tt7swQ4YOWaZ5kM
 e3dzyTjl/zu9hBX5q/5CYsSQuj4WUJygyTTsyA8KziFvE3Ov3vIw90d9F w==;
X-CSE-ConnectionGUID: GAUkbOsxR9mVGGR/j4Z3aQ==
X-CSE-MsgGUID: Cy7EyJdZT8GfoelBiDxo5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="39423235"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="39423235"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2025 02:49:53 -0800
X-CSE-ConnectionGUID: g2FpFn6dTsuaSEDzW6yaVQ==
X-CSE-MsgGUID: fAAosWWjRcWBfTAZmPu67g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="115486346"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 05 Feb 2025 02:49:52 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Feb 2025 02:49:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Feb 2025 02:49:51 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Feb 2025 02:49:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XjVdcFNQVHB/Y1aNwiq+BeAoYeqtu1Jkw1YLuw/nMJ9aBDg9F9XZwSlNlG6+GqYgMHOJe6OUq6SCiuPHL5MYL8zAJQu8ZMFLrl64IJXvhtzbBh8n4lYbcNX+IOkaiYf93Ty5mTIc66D4mYM3DmkCOOvPpIV9tOYKzTvBcK/+aQOffs2FVsj+AEMm/aiJI6UhWADgAacRYYUZAKzV3JI8fsYPvgFu0NGtqBmOY/MzCV0NFj7ClRLMrqajpbSqzPYybfXFexYDYZpLlYG9lxmuS264K/mRP8XqNcN86R3+RFhzjlho8+EnS2yuhm58VRSk2mprutqElOQCNAW4uhtNEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXAVa6aaWi16E6iT7PF7DWcBtBVpaBTed2aBLH5SH2s=;
 b=JuUhXlOFT/AR7Mm6w2/R6oXeF/7WReCInfc87fBDrWLjemuLCP927qohifxgX1nmI6JOh+df1IYbDINJdIyENDWB8kkapif/SUELb1UQlr1uh16d0OTxQCEIoKQPGi04mBDldJQJyImGBx/Jfw/8xDePLL4PwIevAWOYzDWLk6ijSyuswvdJALRw3361X4mcj+WguPNRSB5oXjAvWiI5ljKyIlzsuvIvnTsgLZ2Umc4HIcYOX0q9cmvwKV6/10QSa54at8GvukFJhagPmJ5j5QrxgoKfIxHvAHwj0w5U+A+ISJ1QOgjo8+dJp3oWyuY8d8UuCAzbn8aNmtypB34cXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM6PR11MB4674.namprd11.prod.outlook.com (2603:10b6:5:2a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Wed, 5 Feb
 2025 10:49:49 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 10:49:48 +0000
Date: Wed, 5 Feb 2025 10:49:41 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 02/54] net/e1000: merge igc with e1000
Message-ID: <Z6NCRWeEpeDxU6wv@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738681725.git.anatoly.burakov@intel.com>
 <321a79ef4fff4812dc4c42b81f2a26766148d7ef.1738681726.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <321a79ef4fff4812dc4c42b81f2a26766148d7ef.1738681726.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0251.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::23) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM6PR11MB4674:EE_
X-MS-Office365-Filtering-Correlation-Id: 33d0b03e-63f2-4b0a-7795-08dd45d2cfb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TThN5Uymk26ZVSN2ciAMSXfF88wp8jVrLlybnHnTxiE69v0ef3Xzhm7K4rsF?=
 =?us-ascii?Q?XzP+Fh5V48wthS1AZXApNtX1K20H9wRSg6ImQJejba2MJj1i6cHaVOpRfL3P?=
 =?us-ascii?Q?agjWwaYJZQBdKVCXVqleVUmfBm+L6ZEmOSu2rjtswCCM+s7+RFP+VilqRfDi?=
 =?us-ascii?Q?geB8aYkz4Q88dMcC7ifLP0dO15pNCFws2upp1EpX023JOwsusUNX5vo9LhGi?=
 =?us-ascii?Q?eTvlGCJtI+XTnKKaJf3c7D2Borab7WBrEWpdtmP5ZFBCCqj7BWlbnTh2pcUJ?=
 =?us-ascii?Q?YTVanIKcUMp4rCmgtu5qJ5OOcqW9r51T729ngSD/nc+kr0lpq+BMav0qXuaG?=
 =?us-ascii?Q?E2F9yl8VT++2Tp1R9te5E3Syo4peJj4bgiJ1cboxyM4zMjxLrJBnCME3Ig6m?=
 =?us-ascii?Q?Hn2T7BIiJlsTAEcwcDmrU33KaHQVK/xqxjZ8t/vOsZw4/144QspYwD1ggEeL?=
 =?us-ascii?Q?X9Ei56wg5kfS0wqLCjGodBkFK1i4Jg4rO3c7lX5UiPbCCJZZUTVMEKCCsvUY?=
 =?us-ascii?Q?xjlXbhFVSIAN7LGUBSCeuPx84vCX03S22puVVg/xCGzOBPyqr0hAPRsZ4UAV?=
 =?us-ascii?Q?E6snojJG4Ae1+ekAXirKMszRc0ADfuIOB5l+PFzdNvnaFBQb3tq3beoe2nXk?=
 =?us-ascii?Q?3eJ8W6ZWCGCxnucAc5UuBXZv8Ia53UHclhzavCVlT9O7VIMRGpxs5fZdhGWc?=
 =?us-ascii?Q?/u9gzSHS6LL0DtYa6MaNT09ulfKdfhjLytdn1eHVRwtv0cU43ltDdVZ2dlar?=
 =?us-ascii?Q?ZGOlW/jLehp5ZDTzTYOCZafDKd1Qc6XnTccJkhFjESv8KWBZcITvonB/2oEX?=
 =?us-ascii?Q?5BHJyzT0uGpPJkfeplmA+539nP8LMxU6iqlYPHD+9aePlzyv2lR/u09m27Oo?=
 =?us-ascii?Q?Ocgv87+iZparhzpOrnltJJ9hHoIaXRdlee6isaO3FIALh/GyYJzMmazpcEAu?=
 =?us-ascii?Q?TSF64xbWTJhTROvdd0LdlWB+JMrlGEoMVSDh7WNqxwxZc7G1bwOw2c/ws9lS?=
 =?us-ascii?Q?G80/PSclPhbFT2cH+kUdviVFZPnvOltQRPIz3zigg2z822XVx2PqF+gT8WsO?=
 =?us-ascii?Q?cBzhjW39Z+hNDhf05IQMl2Us4NFlHa9+6HAOrwPyQcPAYT67IoKr2b/jUIKn?=
 =?us-ascii?Q?4R6GYAMTPRxMfk2//xCAs22s++AjHehGDT8kzL/KJqig8nJCVsenEH0r4b3A?=
 =?us-ascii?Q?UtJZybv1sxqa83OQ5MVICa8BFEwjSoBSPNIU6pj+CawWhKcgubiEBpaGs6Ur?=
 =?us-ascii?Q?i+2eNiVXwJ3QKI3HRGy8lYKX9y06xoDbQf4fsw53WQMIrHI6899THEYrwAhT?=
 =?us-ascii?Q?zhmUOA2uoFtpCFwjgAWe9D+YIhfc97WUtD7devO06Y8a1g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TXXOHWkGI4U6WY8iW1fzqRybgBKaDWnptkFP+XK4DRBgxRkurUeNcRNFPxzZ?=
 =?us-ascii?Q?5sZKAvFqPKdbSih0p9Z/4xBf4It4xh7mpY/MCR9B1E4XKQeqGl2Nsc7zsA3G?=
 =?us-ascii?Q?2YJArx8TBqci+aT737VxPAIu/O5nYP/K3W46YQaAM4TRPnHyCcLbUkoL4MKv?=
 =?us-ascii?Q?RCl7cw9OWu2XYH6fbxCrYixc/+TKs3bdzXleCBwJFivhzCVytuMhGuC5yo1o?=
 =?us-ascii?Q?4aQ/0JnxNRomk0qih90gONHjC1+/NvWVz2eADMnM0cSYJHuvnVz800QpTA7U?=
 =?us-ascii?Q?I4TzT/Cx3iDxLzmU/oskA+RMP1hUQiUnJzfs1JOWpkAqKP/HHHFsS8pFnROg?=
 =?us-ascii?Q?8ghthLUcLpKtTtVX3F7XZeXrQlgOwmzL+ghmGr6whUCCGA7RQrBBXFaMzmMm?=
 =?us-ascii?Q?+lEati+ZHSI0t5c0PVUif94VBm26WaEmBXboc7c8hPSyAcGLMyEtcfwi7vqy?=
 =?us-ascii?Q?s6QhKFTPglW6KD8yE6xj8kfVGpASn4SiWJ+JDLHSEpFhuloimTjn8fM1tGyk?=
 =?us-ascii?Q?2r6IWmdN6zcumNlDgrG8JGCMN4LlHgGzpnyzkztmuO5TBmnXsFzFpeIMzbCj?=
 =?us-ascii?Q?O86+FNkWvPW7yBbm6vWFjYErTJZgThDYHorf5FXPIx+czncTC/vdaq+V4ygM?=
 =?us-ascii?Q?/zLIAMEFkVt66IAEQZlJT7MrTfm3odaXAV52mRQOeHtuDsgwPDOZJ41QQapH?=
 =?us-ascii?Q?Sb61JIZo/GdZxqkiDy/bjd9tZZIXXL2eIJJAcvCkQE9kNskd4mQfRx6hlxMH?=
 =?us-ascii?Q?fopLyxihO6YirMRRQpWdDNBfVR65IKBWMygwU1OB35RXnO99MWlhl1voR+Cv?=
 =?us-ascii?Q?fYJN34yk7OZeAhd8T9PCe/g1Q0knF7bUCzKAbHRcwpAO7mlLDGHbFscbznaF?=
 =?us-ascii?Q?/TDlbYiKKixGB4WZ9NOo8w3D/Gp80RW2VPmxirUvKmkrC+C6Wld8NrALQWQ/?=
 =?us-ascii?Q?ltmobZecMIqNcTHGyxpowlwqKk+H9v3Joz0aEkAsYYR6sLRGk+bzWah6l7UD?=
 =?us-ascii?Q?5Yu2q/BfFrghq9i5ZD1WuIznGu3K/zHr+zGokMxyDZlGNh5/mpuMT+zucvzp?=
 =?us-ascii?Q?7XV05Cv1R1VNzmIwzTn/543L1z9nfcy7Ux14RpL40TIMbZLNVZSxOkjxYUC8?=
 =?us-ascii?Q?Ot6Z1YjY6p0ykO8PZ4ukVUGDfDySr5bWpELCIVZerPEfBolxDgRbAUUTrUm5?=
 =?us-ascii?Q?Y4pPAV2NXzduISftQOerXVnlsKLbGkDmXNFMdonOYdJyNoiQn7awWneMEe+d?=
 =?us-ascii?Q?PPBu6Gz0VG8+J5NPf7lGnr9QwsY5fWc2yBmEmx1KQ9Zz47r7j+r5GB5MN7BW?=
 =?us-ascii?Q?xn9OZxpc0hj/fz0KdTorS2WN1zX2pnwQTw86oJyzvur+u5H+e3jG5ddhVOBH?=
 =?us-ascii?Q?c73z88mLE0y/kuAand7G4fm8h6TcowLJYaCAVIMV22obTkCxr1IG6MM9U5GY?=
 =?us-ascii?Q?0gP8CWeKhmVCknMU5wFR7hzwOHBQGKGB0Wmd32OrYFMJdiAGYROoITNWPhjY?=
 =?us-ascii?Q?ceawAZ37NoInth8WOuxUi8LhoiCablHeXDwRjI7WrsOSBBC0oP1PrmZkexmv?=
 =?us-ascii?Q?xg+JGuKVd8j8AaHq4GRbsT75suFE/SZAm0iyG/8HpKFhQRBasUaB+llX6+wr?=
 =?us-ascii?Q?EQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d0b03e-63f2-4b0a-7795-08dd45d2cfb7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:49:48.8616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OL5T3iwnAnO5HBWjnSek91RXLGKuQTlESKMYGv+YLQoTPQ253zxsWEcbjYIamNWizS3atZOYPzFJTDFAXcf5riaqXgpePc4e/Yx5HeoslIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4674
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

On Tue, Feb 04, 2025 at 03:10:08PM +0000, Anatoly Burakov wrote:
> IGC and E1000 drivers are derived from the same base code. Now that e1000
> code has enabled support for i225 devices, move IGC ethdev code to e1000
> directory (renaming references to base code from igc_* to e1000_*).
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/{igc => e1000}/igc_ethdev.c | 910 +++++++++---------
>  drivers/net/intel/{igc => e1000}/igc_ethdev.h |  32 +-
>  drivers/net/intel/{igc => e1000}/igc_filter.c |  84 +-
>  drivers/net/intel/{igc => e1000}/igc_filter.h |   0
>  drivers/net/intel/{igc => e1000}/igc_flow.c   |   2 +-
>  drivers/net/intel/{igc => e1000}/igc_flow.h   |   0
>  drivers/net/intel/{igc => e1000}/igc_logs.c   |   2 +-
>  drivers/net/intel/{igc => e1000}/igc_txrx.c   | 376 ++++----
>  drivers/net/intel/{igc => e1000}/igc_txrx.h   |   6 +-
>  drivers/net/intel/e1000/meson.build           |  11 +
>  drivers/net/meson.build                       |   1 -
>  11 files changed, 717 insertions(+), 707 deletions(-)
>  rename drivers/net/intel/{igc => e1000}/igc_ethdev.c (73%)
>  rename drivers/net/intel/{igc => e1000}/igc_ethdev.h (91%)
>  rename drivers/net/intel/{igc => e1000}/igc_filter.c (81%)
>  rename drivers/net/intel/{igc => e1000}/igc_filter.h (100%)
>  rename drivers/net/intel/{igc => e1000}/igc_flow.c (99%)
>  rename drivers/net/intel/{igc => e1000}/igc_flow.h (100%)
>  rename drivers/net/intel/{igc => e1000}/igc_logs.c (90%)
>  rename drivers/net/intel/{igc => e1000}/igc_txrx.c (87%)
>  rename drivers/net/intel/{igc => e1000}/igc_txrx.h (97%)
>
Either in this patch or in the next one, the igc documentation needs an
update to inform users it is merged into e1000. Interestingly, looking at
[1] there is no chapter for e1000 - just for igb, which is strange. Maybe
as part of this merge, you could rename that chapter to Intel 1G/2.5G driver?

/Bruce

[1] https://doc.dpdk.org/guides/nics/index.html 
