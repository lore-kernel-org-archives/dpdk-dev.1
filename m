Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F03CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 07:33:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FA214028B;
	Fri,  3 Oct 2025 09:33:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 9B3AE40151;
 Fri,  3 Oct 2025 09:33:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759476791; x=1791012791;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=CRaD+3FdqZJ4uu0mOWq825etZkAaMnBWw8I8YZy4/CU=;
 b=R9yQyzHH1yEsXZHnddoP7SZ4KwzOutAW40rLaSnnhxnJxqatEFwr54GF
 hiKaSc5+DplxOK3GhoCKbxtlgRWtCK24l/0y46uYCjZ98FZz9m4yglPut
 X8G+/jYVuTgOA3ihYboHdCaIspYoHNbNtQuoPihWwdBBJSe3fyM8nXkJg
 dib3gnztxlMO7ZWs1/C15X4csZvosFbuHZLhxW5M/y/g8LhI3591G7vdM
 LU2DbBJvp/3ysDemotXn6uA16LyZghfAXWEO+TK/fU1fmcj/RP0Zf6G79
 o5B6rzepV/mTq8h3ghJ6sZlZuab42UtlYUN+5h3541q6QqgIVBLVnTq8m Q==;
X-CSE-ConnectionGUID: RR3VngZaQx+KutXjjEMdUg==
X-CSE-MsgGUID: 9jGB3uiAQpiI31wV27ywGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="49315082"
X-IronPort-AV: E=Sophos;i="6.18,311,1751266800"; d="scan'208";a="49315082"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 00:33:10 -0700
X-CSE-ConnectionGUID: pe0tDu5lTQKv16KMDB9evQ==
X-CSE-MsgGUID: q7Eg45itRQyDSZzvaKZRZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,311,1751266800"; d="scan'208";a="179666579"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 00:33:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 3 Oct 2025 00:33:09 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 3 Oct 2025 00:33:09 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.42) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 3 Oct 2025 00:33:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4ZrniiABxLR2YaWRzO7pYjSgHamAbGtPd2o4UncIXkZ8UXAFPvYDEUXZlStrF5EVldDJwZ4KWWmWpy2K/meMegNI1Go0YeXRlnuc+5MtFKJ43ixOyys1NFqyskwOI90HTLC8vmbQZkwetlon36WOktdbBXvRm5PecPgbewMxg4FFDlx4qDrfdRyFcZPrlH2dpj/iHicQ3K+OAmL7Q4HKnYb5IZ102dO9HhgFEwiazjpKzRyGGX/TtLz5aX8tG4IHWtUCumAbRdRlkwU3ONLKA0BUDuyJvAyUijeX2OrMuK2HmWd3dbWN9ZJKAfXIzTEBQNWker+BttzHaA1jexU/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSoslZjY3a/MzVhKe26mNDz112DkX3Uqf/7x63FW0gQ=;
 b=rfiBct8jZv7Yse84LUxUktTRXP8RteZf76r37+riK/I0yzGNKMC0v/7wipTQKyud4KkeUWzIw0gW2gYbUneE1zIgbGlLwULJg9Qy/o5LDSo5m/sN9oERD0/A7EcNMRISoIOGQO6jZPEa+mKiKSzGlchRW8UsIcg0XwYHAYo/r3+5KOeAXSMDqovn4wntBMl+wQ0ylN/qG7S4TqarkFzZETuLImYuDtA362ziVPjh2vjMFJQn+QUOQx9mM8J/+3pTIrsBkzbrdX1ZkSriCIbwp9Aes2iD52J3zsDNdNiIay5VOKcHpbxyLRnnsR6GrbzZOHVv2qxJJGdNwpqfY04fqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH3PPF55C5E51F2.namprd11.prod.outlook.com (2603:10b6:518:1::d20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Fri, 3 Oct
 2025 07:33:02 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 07:33:02 +0000
Date: Fri, 3 Oct 2025 08:32:57 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <dsosnowski@nvidia.com>, <stable@dpdk.org>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v2] test/debug: fix crash with mlx5 devices
Message-ID: <aN98KbxZZwLVgh2X@bricha3-mobl1.ger.corp.intel.com>
References: <20251002165546.523435-1-david.marchand@redhat.com>
 <20251003065101.617467-1-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251003065101.617467-1-david.marchand@redhat.com>
X-ClientProxiedBy: DU2PR04CA0181.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::6) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH3PPF55C5E51F2:EE_
X-MS-Office365-Filtering-Correlation-Id: 08137200-6a9e-44bb-2862-08de024f158f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D8AtAtl2GcYW2+heC6NSxus8YI5hSenOovnnt1kqNi3wX6GtDGsTMb4XIR8T?=
 =?us-ascii?Q?hBh6uA58xP1M5TU+SVURs3ivx7NGd+6QWJXmZrlLF1KJN0Q7ffHz5tO587pD?=
 =?us-ascii?Q?i3hgY8wNnue02GuVy2Za3oxfxNmCsRy2/oehfozM0uReBgr6td9FemHykFGy?=
 =?us-ascii?Q?2fbAdARJ8Vc7r5HS2fMx4PV2TJ5YaeKedrm3TpJQ8KY9RxGrwajWoUmw53Xb?=
 =?us-ascii?Q?WWC6Mylhno/GymRR1MrDS311Wz2DBC0p4yNO3Tyd4i/ycNdaH5iWnyvKNQaj?=
 =?us-ascii?Q?XN+oO2qglsEmdjjgpqqSMYTrHDYHD3c36kJB8YFGcT44fWuDvlxYsCsSKhAZ?=
 =?us-ascii?Q?GhhsL2ecto2qseI5W9tdURdG7gvCtdAeCPkNs5RgKc5gNeEQ9Feh8gKDiyIG?=
 =?us-ascii?Q?LRud4hjTmWCjOeG7gxUA5EnwTc9zmVmucBr5ALg1guDjT+57Xkpg91mJtpcA?=
 =?us-ascii?Q?WPyEEV3P9qz3tddmi7T+wju2CUKUcGqtN96vaf85ryfxmACkIXwaT4pV2ved?=
 =?us-ascii?Q?mwZ6iFADEWz7iYGnqVyl1okzMJFM43Lwa1FubRcB4+45xJfMDYkKZiFbNEl5?=
 =?us-ascii?Q?RX/pvcMaVHjzaU0Lb+9mkXsWnFaZH0ppYNfWACMK3gmFnlTOVHdAaXndIVk3?=
 =?us-ascii?Q?1zsdyv5nPM2URMFPZz4usGFQvjW7Xd5i1zKUdMd/YNO0DBILxE9aHj8UZfxS?=
 =?us-ascii?Q?yjBx66jrcZntiwx02QEm/itRmmOaEY575/G8b+RuEVZcaL4KaIKk/fGPTw7W?=
 =?us-ascii?Q?pvMDMZDQxKCJXmYSKyOPswlRAFJQ5toA5tJdAZtPIqpCiGcvGpdQogvID9ok?=
 =?us-ascii?Q?t7ZigJkrX5qbTDTRojLo4UMu/StFusSuXIz2UG4Qus75aHcMlqQ7Tbebgi01?=
 =?us-ascii?Q?rNalIBrEy0tudZOi9tG9gyu7GPjTmz33DrWAkNeU5mwcM3PId/AXEGPlscJR?=
 =?us-ascii?Q?pK6VdkSGWSHbPpYIHnlg80uB+aDJrflNI9gBI/FLYJJPpVKFs9vF6SEn1jeW?=
 =?us-ascii?Q?yXAwTUNtYZfZbPvlKXgho1tj16RBzGFLhtU5bjpAqbRHAU9T7I58hBYJeBpm?=
 =?us-ascii?Q?ogJ+wIk8ing+jQcKD75tlyLMDXf4EfHqWfLMe39ViAmS/qh91IF5XXa+bJdD?=
 =?us-ascii?Q?2UMvCqNTgVETVc9L6SLNRlV404h1VMDj20NOgWcp7u0D35DCi1avBzcpgqHk?=
 =?us-ascii?Q?gXF6Oz4Kaunj4X/dHzgeHmBu+d4UyDAEyKilbLF/9ZhlIbAV9dZpGcpdfB1e?=
 =?us-ascii?Q?6fQcmz/5yvu+lOCJ958jqT+JUWsGxzga0J/9xHOkC5WU9IswqXb+2sVs4XR6?=
 =?us-ascii?Q?mVAPvPIKXsQkpuny3FygDPOZ62DfjKlRi0wizP3qez5iZDLymDDBTcOv9Xar?=
 =?us-ascii?Q?JvmYVZbo2rHwqaUnDSzrvRqn6MAD+5NcLbm5frtHF/2Tcap0jfFmf/Mi+9vD?=
 =?us-ascii?Q?A52z7GFIH5L/dR1pfKXKf8C7PN059JDX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IyH2C05awMqNfg490pZOgmj/Krp837Qt+ZIjoc30ylxaALJ/mxBTSGCKorlj?=
 =?us-ascii?Q?8OZEXZ2L5+7O+Or5yGH5p5JJFmU+5a/y+n4Z9c+gi0rKeVwa5+tPJs1nU2aL?=
 =?us-ascii?Q?fkNPcrEq6C1VIG9sn27DKF+Vv7aLL1yMOAEVB1Ykqa3KZkuRM2DbIFF41kQJ?=
 =?us-ascii?Q?9jIO1PLLYHB026QobLv5kk3qO8uI73xcB/MLd98ikdxE3ayY0EyopBcQDh3D?=
 =?us-ascii?Q?Avko0RL7ii0zVnqbkdFc0d7aN0BA9/aiB1LGjz/JEs0zVgeLJi7pLtqhz7zW?=
 =?us-ascii?Q?nErztiz+y+LjNiMo12V0KjtQaLXCb6DZ8lQLD3r6RZbrS6Tt+8rEmXL6Cm09?=
 =?us-ascii?Q?3SAbHQ2GDGobMJI9R5gib0lUeukzqfTOJK49dBsMxPoOMuciHLcSSB7jb8t+?=
 =?us-ascii?Q?eCVy/aoKT6+ZGDTAoTu7zKf3i98ucfZGKthxrVF7SPyYCHf8JAyhQkxyHFTA?=
 =?us-ascii?Q?165ycP9rCMLj7b+lWwn71KkdLAgJwq5Say43ZUNCL0/YTI7T3fq1CgJ4Xj5C?=
 =?us-ascii?Q?CxeZsXT4pmi95wdIb1ONgK5b2BTMuWWjM8IOcs/2ZthJVM/H282IMj5G5Omm?=
 =?us-ascii?Q?C7OgRMU//Gy2HTtzFLB/ti7I32KWIZLyDtDLyberu7K8vm5kkh7h5hQXM7ca?=
 =?us-ascii?Q?VwLJlGCl1X4vkDtPDhxEqyu2WhkfalKxgrJyj5OYnjtm2pvZUJB4cSf6WXWI?=
 =?us-ascii?Q?z3ybVV1YaP+qsF2rTD2Sg5oG4oETfmjheOcjkw/rCEgFNzG6xJ5A8x4cazGt?=
 =?us-ascii?Q?7GqEv/PDLISdrK4DAFrwt1df5PNCSYE1FsNbwWkzpzRGkG0QfgZ1IriqWk1A?=
 =?us-ascii?Q?smV5LzF0GFAvjgscvg6SBEyX+4m7m/eJk4a1EMyAAf6YIkd/pM3RGtmEwkoZ?=
 =?us-ascii?Q?jPRCNJ8rNfWft16mutZkUdbIPO6nfabTtS0/ukFb9cgWOELgxpiNBJ27JGQO?=
 =?us-ascii?Q?uafcmcwS6To4cDfgidLqlQqQ9rX/Rix1HkO/hFUZhARfxnrD176is3wwYml2?=
 =?us-ascii?Q?1JWJzFrAqU80DwVXZggQGQZqtsqSiA+hNxymsRH4rtWNBm//G+NeIVwtJ64n?=
 =?us-ascii?Q?n8qr+3mezIy30PHRG7iwRd4oYP9TXsLWb8otX/VewME4xhrd2urkMhHsQD4r?=
 =?us-ascii?Q?oGRBvsTdS7n2Aem9x/VpyluJdLi7onniTm/zn9LIAHIe7ThMFpWbfqqR5TxM?=
 =?us-ascii?Q?zpkPwRDqtPAXCMlPEE7dnlxoG2O13TGeTtJ0TnRrOuC2H9wGzO2WahcLbSlb?=
 =?us-ascii?Q?jsAVXOK5bFrw0oPVAxEcVX1y3nzx5spoCq3rV+kfvIi52lBzB4Ad1aam4+VK?=
 =?us-ascii?Q?Bl32teaide40cAGmGJ3xSJrDdtWKJsq032yRwmsokBjcSW+Mgs6e8zxNVxq8?=
 =?us-ascii?Q?7UGHjc1LYsz6dTIQvfBSvcYfwQRUmIuIt1REIvTJ+fi+r5RL+hoAiem/1ljh?=
 =?us-ascii?Q?2NPNXGJsuWydp3HdZYazXKHeg1y0cDXanp0uVmJti0Q5s/JOVcTnqvA3gyqW?=
 =?us-ascii?Q?g82Yg0tF1943ZgPyFNmaqgJV1tMG4Bm1VnQIGnccztL1m/xVBvDp5KsDhbwL?=
 =?us-ascii?Q?TwEBcp155E28V11maoSJYLtBr5yoOTeqFe0E+3db7yN7urHTs2bSbeRrit9V?=
 =?us-ascii?Q?xQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 08137200-6a9e-44bb-2862-08de024f158f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 07:33:02.2964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u5r0VpY3CgJstDxacHS1nYIeNDwu3RX9bGlIiVLHJg7CDlutSh14gIc1P1d0acg79TYKzldVr8TOZcVpHN43n41j1I8tNeUiyU7BXI0rKcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF55C5E51F2
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

On Fri, Oct 03, 2025 at 08:51:01AM +0200, David Marchand wrote:
> Running rte_exit() in a forked process means that shared memory will be
> released by the child process before the parent process does the same.
> This issue has been seen recently when some GHA virtual machine (with
> some mlx5 devices) runs the debug_autotest unit test.
> 
> Instead, run rte_panic() and rte_exit() from a new DPDK process spawned
> like for other recursive unit tests.
> 
> Bugzilla ID: 1796
> Fixes: af75078fece3 ("first public release")
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
> Changes since v1:
> - revert last minute cosmetic change that broke the fix... iow pass
>   the name of the function to run, instead of __func__,
> 
> ---
>  app/test/process.h    |  2 +-
>  app/test/test.c       |  2 +
>  app/test/test.h       |  2 +
>  app/test/test_debug.c | 92 ++++++++++++++++++++++++++++++-------------
>  4 files changed, 69 insertions(+), 29 deletions(-)
> 

Fix seems reasonable.
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

