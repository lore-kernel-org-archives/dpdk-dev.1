Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7D1CAC5A5
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 13:07:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A12CE40289;
	Wed, 24 Sep 2025 15:07:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 8F5584027C
 for <dev@dpdk.org>; Wed, 24 Sep 2025 15:07:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758719228; x=1790255228;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=WPHAGW8+xM+aC1OWuFUs49qASiKQ9e/8VFoKvF4f714=;
 b=BTghVKDDLpa1DeqmxC2TI4ldns5FdEvWTHhyRY/Mg2vxd/jSKZWKqsOc
 sWDU49XxijF3r7RA07nZiWwFzqbOHplYiggtK6VfuXvq6EnYa+vxq5IrF
 X6dFRnW7bX7hz2y264elbmwtchmlshq35vDAdvCuNleUQGEr85W57JcuB
 CSS+yMi1sSLE90sXupqH628Olwc0cn8Eo2QPU56jU30j9mLPszcY46oc2
 MSRRCBEFUHGAcDcB0szrFhEWPZeId0SRv7X8RTDlx8zGqK/W0kM4bGAPP
 CYLdHLKQk7gnL+prsElrhn/b6LYJm/w7LbNi5ZJHay/eHzinasghW35qJ A==;
X-CSE-ConnectionGUID: a5JiY1D4T8iv4B0cVgkAzg==
X-CSE-MsgGUID: /NAa81+mSdqQK2Zl0xTBNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="64651663"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="64651663"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 06:07:07 -0700
X-CSE-ConnectionGUID: 3A1mnkxVQ5GqV0zCE7u9XA==
X-CSE-MsgGUID: E0Q4nDolQc2s9DjUcJWx8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="181319116"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 06:07:06 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 24 Sep 2025 06:07:05 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 24 Sep 2025 06:07:05 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.44) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Sep 2025 06:07:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B4E/bAAcVSxqltn4O6h1d/hrGOvEm9cPptgZhLQTSOm/pifiSSt8Sxd4LmWzshJ991OHK38k3sH9kV83Q+3tti2/wtgEXD6xIMMb+hrfcXHiNHrARmzU0IPu+HY6gijEYBt+LS6qLdleiC2Uu1Q27VJ1vbaYoNiukjYJ/GbRFI+hlwy/WdVv1QLEvmlXKvfYOQQJosVovt16qUQspo6usAE/IbQgyfnsf22OkbPWjFKt8e776f0t2a9P8UnSMHcsLWH+8BjDMM6JsiwNOM0jFrLHUxfX60n6eazYeesgxc9/+l9CbusYCScy2qv4SroESHUsdH7B6MDKqfH5Vfq8Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vu8wXh9WvkJXuapwnO6AGyT4WbwxOQcidPVfr6fVLuM=;
 b=BgBQ4bDQqUQN3TOyTxU9oLAdwRcEi1kpuoC0ikAxtO34uIpbWOLFLzX6o6Guybhyi04uh5oUVcr7fc9pzbqIqLGqWjyAze6o8Nsb1Ws8nsLsfhpG5VPPjvD79AiHiNX+0l4x1vYDW1/hjoyD/BRH3pp41M5mmzIUIBFx7FtgXAbW3LtjAH8ZtG7PTnziMUvNj1DiwOUBnhtfLxASVnty5I6l7hZtzMhhdygEwlTFhMnWN6rBsI2isYxfqVmpgUnLPq9tjzOt6fEWqgU4GDK05AfuzlekstSCH7U9G0IUZC3pvdAYEVMjF434MHPCbb4K2z4RfQGSfPdkQH06MUKGEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA3PR11MB9351.namprd11.prod.outlook.com (2603:10b6:208:57c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 13:06:56 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 13:06:56 +0000
Date: Wed, 24 Sep 2025 14:06:51 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Kevin Traynor <ktraynor@redhat.com>
CC: <dev@dpdk.org>, <david.marchand@redhat.com>, <thomas@monjalon.net>
Subject: Re: [PATCH v2 0/2] build: add backward compatibility for nested
 drivers
Message-ID: <aNPs65nln4W2jOQ6@bricha3-mobl1.ger.corp.intel.com>
References: <20250922110708.47879-1-ktraynor@redhat.com>
 <20250924123422.224988-1-ktraynor@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250924123422.224988-1-ktraynor@redhat.com>
X-ClientProxiedBy: DU2PR04CA0029.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::34) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA3PR11MB9351:EE_
X-MS-Office365-Filtering-Correlation-Id: 018994be-3a79-4d51-75a8-08ddfb6b3d30
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PeGjjQixTdcGXpim69WDVR/QGav1htWu4mhjZ8V29jfnBR12ESX1PI2oThcu?=
 =?us-ascii?Q?CKOoxy9ZMNlsZ+5YC2+xm6rFPz4674uFCRAZAogPa5+TdD4bMqFXOV2VuKkS?=
 =?us-ascii?Q?v6Qs8itMlB9/+CWqCfpdjOvNjL3/MKoUsE1JjgJBmCWJbYsst0D172kCqCXm?=
 =?us-ascii?Q?dmNjN9f8vIUh4CLz42zPO48O7yY6zAcp5sgQ1fZg4ZEWr5R5AS2VgS27WuV3?=
 =?us-ascii?Q?rr+vnzUahvpAijEYyE/hlI7NxZr6o8mNXmfmV80QQhyvV5vBi3d08N/SVMxs?=
 =?us-ascii?Q?asDhYj9QBOnHwJ5euC+WIWuZuTea9RBvJLeCOAg8mvbliCt7+6FTxTa+TGIB?=
 =?us-ascii?Q?ZaeVxva6mVJgkCCjPpH3z0l+hi/Jd79DrhjAafnBsmTkS9a3Xs3z3AgB53DD?=
 =?us-ascii?Q?fJCmtBZojQ8GNQ9iTRujtzFO+3q/7GiGST9qxuEsdob61WaYri+LxyS+6EVE?=
 =?us-ascii?Q?0MYq3+1klcgNzfS/jNQ3g83sl4pDqkUNQjxgFR8rQrvGz+Sr3NmNhM7jQllJ?=
 =?us-ascii?Q?hmhW9M4lTRn8XVA1NLFrLEn03Mg8SRm0RTmizz1s/LDTLmGPQbkRzdvn57RL?=
 =?us-ascii?Q?uCHfqDGrOsifU2YWeUOFEUn17EohWmJw70E/ZERuF6dRpTfWUU4BRZ7Bl5Ry?=
 =?us-ascii?Q?28zTVmkb46IFhclFmq0yiS3ULD9fsIMav8UYGKptjLT8vMtd0bEBM+3fDw6V?=
 =?us-ascii?Q?PjQu76SwZ8c6SplOcps4PG+75Oa5vh6RRtmzZD+BfOa/NPG1+oge6fGd/csV?=
 =?us-ascii?Q?Jzrm1nlYqUP3aOKKyRWPKMpvxAPcg1MNCXgF/HuK9GykEUfI85sP6cVczc8c?=
 =?us-ascii?Q?qgarNffsNuCMcphZWs66Kb3RP0l9FDFpfwhimzuy1GgBkuO0HQwNHJAAOIW3?=
 =?us-ascii?Q?VkuzDedkv0OIIPpb94AYAu2fapbbXXSKD+WjgsSBtXLq25d5Yuw2RO04BuqM?=
 =?us-ascii?Q?8H9LymDjwmBSCjhm46T0iC0w5LId4hvre4WIB0fXx76a168vG3p3TA8h2KG6?=
 =?us-ascii?Q?rgTAfX8CXX2ZonzhphCMhb0PDBNyi6+QXNA3G0DNPgtbYpaYILj1e4clvBN8?=
 =?us-ascii?Q?ZKgp/udvEU9yJjiYlgHNYRK4CaqGIbSFK9tsAOaunC72/McnH7W9oGh75kJA?=
 =?us-ascii?Q?jg34LbyK0OCXHEv9N4H/42eITIsfSbc0pRwEg1fE8Yt2LR6qi/hg1ZPp9sbh?=
 =?us-ascii?Q?9Uvw+qfyS9winYeAjQ5Zi1uIUfyJepSXwhRTEwkgxiFUA4FLv0q1Fp84J9Z7?=
 =?us-ascii?Q?VGTui2keBtefdvXoU40xRZYgqgoqQFaVH+qu/kDpx8vipQttd9JnbwMqx+u3?=
 =?us-ascii?Q?IKcOATJFHrKUYIt55NE0VW5N3K7BjnCYb2TLHq4Z62wuBjtoD1Sn6c4g7JQO?=
 =?us-ascii?Q?R4YHlXrROCOtZBq0qZXoI4W6vpFMYKEPQMyDQGp03dc2KDPl7JogBldySE05?=
 =?us-ascii?Q?m9hLm7nqSoU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9gTpW7IqpzzwRAdvwaQrhkvQqPsPxGax22VD0huEaas4EmVGp43ypsveIY2N?=
 =?us-ascii?Q?SlYdS92YfJPAJhL0XhQmtIgL0GtAY98s/p0Qon3hBrCTyV0DL1OI9pZrV/Gn?=
 =?us-ascii?Q?fG1LCxPYMLyqdaTr++WAUMwwivKM012UVmL7yCOvxuNncV0eM6eY19wxBEOg?=
 =?us-ascii?Q?AFTl5g5JZSxLVlGVGtqbocfGMBrgBKAE8TuGfrPEhYk+f/iRw2gLQakoG6fN?=
 =?us-ascii?Q?DPsQ7Kl+SwpSdwMq3a/CDIltkvf9dZ8aXUWCHk+BJ2XSK7P3C5zpUhpLbO5X?=
 =?us-ascii?Q?P7N+YaNa/vjkoxEwcvG4OkiaraT+Jh+9JEg5/vyGBnCZc4MmB/TjKDciqPXj?=
 =?us-ascii?Q?rXPZLVOO8xpT3ybPDS7JJntgv7jIHIXKsjPmycJJvW696WFC7NMAYLhSLNOT?=
 =?us-ascii?Q?jgjQ+kBE2RhX3Csj0EkQbqq3PcRyl/ii1DFBSWilMTopDlIVYp+CWl0E/0Zg?=
 =?us-ascii?Q?O81uAR9YdKwOkIclK+F0X+NcAhB2Jhn+DyZ8/yIGgq2q9F4eRH2iJCdhn6AG?=
 =?us-ascii?Q?QKe5opLhT1WplcmwgPGVDmwVdftbdG98vQ7I77Lav7rvIHHnOZToMwjRjzeK?=
 =?us-ascii?Q?XrBopv/Jen4mTC3CY0tHf5lCu4Vve6nsHmu9JyJ8/+Q92VaJOFoQ78cTnA0q?=
 =?us-ascii?Q?ID2XjOACiIzVdgR5Lvqdp5GGO2IGajOITHBLrS8PsdKzyF72bWsU6+m6nP4S?=
 =?us-ascii?Q?6NnRWAUNoVc9kviPmqIFFbvZXXJ6TfI7+FzlqNWPPonB9y1rL0qRd6KziM1H?=
 =?us-ascii?Q?06SAFSls2k4kqqql9yzdSjo9dGt26PqyoRdQFoR2E8LZsnempSY4OSzdakNn?=
 =?us-ascii?Q?CP/7eB1mK1jyHlafY2bKS5+gj9iM3td9Eb0nkbzDfKCpgECmz0JoK0rP3qsV?=
 =?us-ascii?Q?2V0aHUQ3HLFH8GPDn2pzrPr4fCDI7TAhRch76fBYeVvRzSLQqkO7PQpKik2m?=
 =?us-ascii?Q?pmRtIs8HDPqYvcwoe7dMYj9kJQXTXhQjz69slgm0gVn3E8sdoe486CWIhRcH?=
 =?us-ascii?Q?5kkmq/ermt77lN2QyKsw2Y5QXB3ywYgFy3Vjdt4InCIsozgGHH/bOlMoq35v?=
 =?us-ascii?Q?QrNNxEFTxH14UnTt/9cttT3vGQMqwzaznhkssLT5aGtRJzzo+mzhTmqCn0OD?=
 =?us-ascii?Q?ntTfj2FpW+XyNcKhfqYTWDTzFoNQWXUvO1fIz/J28+AIOkJ02/phDK5IOFZi?=
 =?us-ascii?Q?o0I6f2etpCdITRTzMTXR9omWHm1cBJFhp0enPZxnl/G4zfEGRLI9tfLiDAYX?=
 =?us-ascii?Q?1LDxsYVuuHmwMLHwFJFn038JlJRmyACEk2Vck1ydHsl2puQCFJc3V+ibJfGU?=
 =?us-ascii?Q?PSZqBEx3SMCfc79LU1YmulxivcYrTdP15msowB5gxnLh+Xjy8WEty01VVY4s?=
 =?us-ascii?Q?yR9bfMoE0bN0nXHDgA88PTFHOOfPLVaRf2enp4a0wMceXGJEFPHtjgmyRif4?=
 =?us-ascii?Q?J1L2XfSo8x4WK57jYnaarlHiqyrAyxam58jnh6wNhb0bXyLIgZdJBfW5R76V?=
 =?us-ascii?Q?XvdCGroGATJRp41vAy/wkIP+Ek1FwmB0loZemt1cpBvkXFHCtAU4h6ISO/C+?=
 =?us-ascii?Q?SCX7aB1VITu4QZ4Yuz/eMW7KYjQZYhQNJaFvVHelEAVFBJi0vqhwpyDS2IoF?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 018994be-3a79-4d51-75a8-08ddfb6b3d30
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 13:06:56.4453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNwrueJL/wOlhQkV3AbxS8BPBXdtKRRjFecEyN+z5Mzk4ErRZZfLLdYOErq5LYSp/qyTsvIAFvZd0G7NKrMG+iXldNzcprGKAE5IY3JceX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9351
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

On Wed, Sep 24, 2025 at 01:34:20PM +0100, Kevin Traynor wrote:
> Since Intel drivers moved from 'net/*' to 'net/intel/*' there are some
> changes required when enabling or disabling those drivers from the meson
> command line. e.g. 'net/ixgbe' no longer works and needs to be replaced
> by 'net/intel/ixgbe'
> 
> These patches are to allow backwards compatibility for legacy driver names
> and wildcarding of nested drivers e.g. 'net/ixgbe' and 'net/*'
> 
> v2:
> 1/2
> - removed deprecation warning
> - simplified loop and updated comments
> - added Fixes tag
> 2/2
> - Updated list-dir-globs.py to allow recursive wildcards
> - simplified to use '**'
> - added Fixes tag
> 
> Kevin Traynor (2):
>   build: add backward compatibility for nested drivers
>   build: add backward compatibility for wildcarding nested drivers
> 
>  buildtools/list-dir-globs.py |  2 +-
>  drivers/meson.build          | 43 +++++++++++++++++++++++++++++++-----
>  2 files changed, 38 insertions(+), 7 deletions(-)
> 
> -- 
Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>

