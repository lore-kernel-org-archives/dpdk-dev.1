Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5B4C021A9
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Feb 2025 15:28:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84934400EF;
	Mon, 17 Feb 2025 16:28:36 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 2A9D1400D6
 for <dev@dpdk.org>; Mon, 17 Feb 2025 16:28:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739806116; x=1771342116;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=UvuGXjCTXEskB+8Gblg98zz4qbbh+ediM/hwE4dh3U4=;
 b=C4E8ij/67LaNZQ0EfXoFs630vwMCbwJ/DeNgohzWCxyWFeyKmOLH8waS
 gozuGo/5sXAbUY5i/bcPGnAa0COh3blSDAPU39O6Gm/LNgGg3+CnUXS/1
 8GL808MPDi9HMdq/YysIAZsYjscO4Qsq2QYTcXG/H62xxGOu707S9dH7/
 8gwK+yF9k1OX/7qajscMxeZ/10Q98NY5FhtOZid/TdCNhXg3QFu8K3C+x
 nb6xN0f83HDKMPFKEsfwP+/cSLfPOOXSGQmHtl7qxbEvgS1hoTN9c+Z7x
 m6DXHgiwUcbKNGub1B6dm5gcrOznKctNs2KgmksJK4QiDBdm3dcg3C8A0 w==;
X-CSE-ConnectionGUID: WvM6o8C1Srew1FfRY3bD4A==
X-CSE-MsgGUID: leAFnjmCS3G1wTwBNlan+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="39679243"
X-IronPort-AV: E=Sophos;i="6.13,293,1732608000"; d="scan'208";a="39679243"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 07:28:34 -0800
X-CSE-ConnectionGUID: RKhtQj2/QVCm6XQKbjSPzA==
X-CSE-MsgGUID: S36/ouiGREKamjvBeDvuuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="114015905"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 07:28:33 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 17 Feb 2025 07:28:33 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 07:28:33 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Feb 2025 07:28:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+9IP7kwuTPZ8MfX8+Iv/bG9hj3G4tOJzZRI6frGwICDOVPpAOF20Jo5WeIcpbyajFAHIw3MZ/Y2FHekliIbnmEMByZAshbmZMssgqyJh6vX1PEJYSr/ycbRCj1LBPdCpTh/nTek3pq5oyRghdJQ3emt+v4D8OnsOgBKWMUrdm3GPFvBvEAVluZbIDWDRts8Az+U/eQxUgwPLFtYUmRAAaKz/9JZ9wVnDyLN3liezQe0Uhn5CP+6iU+gDz3nrkjUmzpeowKgfT7Lw5jQ7yroeDHodT8omtsc24y7Y6/k5pn58IEZWzjMg/Y9FGu624J7JPdup7hCseiREOD+xWVCug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UVaCm2WR4YD756ufWp1aLN372H3rkZhZpFG3Kirgz8=;
 b=Ofo1hHBPv75W2ncVaz5tw1J1bLHSDaub5AYVeEm7zXMcq2aPKChcmzIZGiQutOqITSy0DR/7f2nZVRiDT6MGmuUn5SggTsSf8lAlv81Awtq7O6cXBCT93EaXJFG1tyng+f3GMdvbh0LGvFc1vInWuyi0SJEsv2WzX/oLOE1hYeX9w6TTm692zzyP+MIv3XE+dGLbSHHEkhDAF65MTIlfq65ecdh2s/g8j88pwI7AQolorSpB2YsFJTqmhaVV0NqPHNjORKJ2RiBOtDbpES+U/yhq/jxazpWKR0bDSowdf4MasVypYs5vC8K/v9WN5AF5y8Rg71y6gNgmYqDk9RiRaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MN6PR11MB8242.namprd11.prod.outlook.com (2603:10b6:208:474::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Mon, 17 Feb
 2025 15:28:25 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 15:28:25 +0000
Date: Mon, 17 Feb 2025 15:28:20 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 1/4] net/e1000: prevent crashes in secondary processes
Message-ID: <Z7NVlLPlS1lx1G9j@bricha3-mobl1.ger.corp.intel.com>
References: <3c323577ce36cf4425d2c2def85d0d6644b87dc8.1734020337.git.anatoly.burakov@intel.com>
 <cd3ef1f143afdef81cf7086bf0e6a3e49c43fbff.1739800426.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cd3ef1f143afdef81cf7086bf0e6a3e49c43fbff.1739800426.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU7P195CA0009.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::10) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MN6PR11MB8242:EE_
X-MS-Office365-Filtering-Correlation-Id: 707a8b38-73ff-4fa6-5b70-08dd4f67b883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PhI0wzyRrulHC+T1gyP8P0+DVu0gur+Xir1WfZplk5wqbRgwPz+3bsQyEjZQ?=
 =?us-ascii?Q?/K6mXG4SH9W7pBrTE6cQKTjFVWIPCx80eG3HkwgixVLNj4PJvUNOQnKgu1zT?=
 =?us-ascii?Q?zQNsOYaEpXLQ/MDmrB+rbhopSE7/2xIK1NKB7y87CuC6Yg6arpgOUhUL6SyK?=
 =?us-ascii?Q?wQo3r+N1R4ccz/KQJ/xob88niwPA6GriIm54/H+ID5s8kAAET4Z38QduKrds?=
 =?us-ascii?Q?cB7Qzveyy6qRGMx9LY7+F5Y0Mb6uM+XkElX1yCRuP9gfan+37bSGlG70V9fS?=
 =?us-ascii?Q?o1l+6KbE9jSTckhpE5r1KqbeUq4iBtpJUVgOZ3oxaR/J/CuTkMXJQcedhCdk?=
 =?us-ascii?Q?8sqYtJpAC79OxJUBCjnciUlcYfbUcWmIQ2t5oywxMAa/wufOczAmk0aEV8FG?=
 =?us-ascii?Q?tFxBjjLrOLPAw0QrPVzKHnlBQR9/Vq4Eff/dLaIEolZvx+PN9yk74Q92lL9m?=
 =?us-ascii?Q?+Mt6Sar2xma9DWByjWA3T4NNFlSSQ0TYn8LQCpzZTqrNDWiFQ2ewFYcbihBW?=
 =?us-ascii?Q?rPMw5gcebyHklIk6hKvvlas773GxRsbrMXCxV7p+tzGRidF8oGeKh43zBwuQ?=
 =?us-ascii?Q?B7OHLCGx0UnwuLA4V4KiI/Iidvu4mEEZ2kX784rt4dQtSTW5rgZGnBnM4K4U?=
 =?us-ascii?Q?/Qr6lyiI8BjVTJqE0kJif7lvY8TCszxhE1z1X71WDt19C4EZrHdvGxu3CzAR?=
 =?us-ascii?Q?gk8xC4IXJaSqbyg1wo8Hr3LYj1lQ4JlVA8n1TfUc1oSKHKbV2If+/6XUsZGj?=
 =?us-ascii?Q?wBEpFwp6WyZm9jQaUzaTET13FUzk0PJSY3iQ+NjjgqEcSgMtt/8maIAypmlL?=
 =?us-ascii?Q?48FgQ7rz8ORDj8X4YZYPhsWI1PSo5rQkNNNl40cYmnnuD6m6QbA/S1PyA+YF?=
 =?us-ascii?Q?Fe51NrPEYxuHIUzNvXBSDpkFpUh0iHSI7Qsk7Unjxc8SDMvv7fFM7U9c+Pks?=
 =?us-ascii?Q?mTbR6fpECs5I+CjspYYbuV39mi08CadRdECeC16E+04xD/zueoC9yM2+AXVn?=
 =?us-ascii?Q?WRDC74rpVqiU3EmkhLUVczmD4H9NUhQq3pPTLOSj9F1PgWs6ZAI4Tr+pYLoK?=
 =?us-ascii?Q?mtEuuVDJESsUAK/boNQm2KDOlXaR8u6eCXUU1vtW6adyqPA6UNZaRUjlPOSG?=
 =?us-ascii?Q?8efbpQqor6e+AIGTwshQ17wLpKP6QSCFQOFBznJ8Cf1tABJikesLFxKRJFOt?=
 =?us-ascii?Q?6vfPKZ+d54jwNhMYNOYqprPhNrQ4N8WThxhtqBGR57f0qr2DXUFjetH6nQJ/?=
 =?us-ascii?Q?QfVedRcnYFNAvhKewed+6FuVpXPRe8RwySEcdDzwW75OINe91rug/Sc/1D/6?=
 =?us-ascii?Q?F+8PvQoJbT3gmxfMvm8x/egoojun6+LXmnSP+55JkhnPxU/rQZ1dE4NtVSvm?=
 =?us-ascii?Q?/DiSMi6RjKF/XYaIE1GcR/ojHQ2B?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9Kd3+LPNAjZNf+RAXg1nAcErV3atuEBDQ9I/nC2klI7eMy0S/w8tegCqHt5s?=
 =?us-ascii?Q?WOy8pskAXhTfNvyqZdJcCJKkhE8C5aHWvj7sbSvxm3zAX4UbSDA7AAUPc+dK?=
 =?us-ascii?Q?64dDOmHfPOhUP/k7YyEwQTWBszP/yIl3fzn5hdcaU0kKa/SnPoKfB6xr1kYx?=
 =?us-ascii?Q?o5eVH7BQsUPpIjD6mEXAZICovg8uzZCCyD7kXS1A68IVE2Z2nX07aZybuMRx?=
 =?us-ascii?Q?D+IQnR0UwaqHdQ0WPp7GS8TntrLo2mo6xIxNCOFEgBn5lFXqYSG21ZW95IAL?=
 =?us-ascii?Q?fQErvbuYXNkYHxDLnW3xy4nkVKzSdGnu1nNNC/t3CUV5wOt2WlW4s+wgAeU0?=
 =?us-ascii?Q?lKBZS3ceQtEr08ho4ox+dNdn57Gix/ln/xZ9Uxi1S8iTBlUKJxWSLgaXFalQ?=
 =?us-ascii?Q?hEhRiYk7PXe1jrL6gQAHopkJp0HtzaHiHNo1zanAb21jiUXxYiK27RFlpa34?=
 =?us-ascii?Q?gEw/kTUXzBZfQ8Z40x72wAla7jrItD7+4Sdg/DJZ0XRZNGBzedcQQYMoRkrG?=
 =?us-ascii?Q?4zS8N39nZxLNKrnCHb8pWPVLQCjQvG+AJtAR2Tsoo9fLwusz/3owD6H+dWqx?=
 =?us-ascii?Q?ILLJtpXT0t4Ta6t7JLMDnEtj0dXPPaAl5I8vh8VpFNBoNxcHvLMA20obQHCH?=
 =?us-ascii?Q?MbTA78JRAuAFhng94XEwquyebjbD3F/hG3A1rTeb82ONIvNhiOnGOTLYXpKi?=
 =?us-ascii?Q?S5YSO0r3OckPn/29eFVVwM8Ouuh6gxl5a5eVvyLwwr11vRoi3ANsH1U4gyhR?=
 =?us-ascii?Q?1DU3iWErisYf6NrrhnEyCnL0C4bQXe5LNeazdCrF9h82T46cdTmrIN5MfGMK?=
 =?us-ascii?Q?uXHJzFITMmHObYQ03a00jJUeL0QlLBk3ZL3FyRBoUyFIPuU5K7zNnAt8uk49?=
 =?us-ascii?Q?bxHm+ozkEpNUwZ4L0/B9Jy565OT7ylpVJZk2h8TbqAhen6wMBDD7HRHAofmx?=
 =?us-ascii?Q?59yrEvXQ+B5BZLI9CxffsA0Qy9Tq9VICUwLdiI4VIAJOigkrdyNABWVRuCHs?=
 =?us-ascii?Q?o7M6IXIrNBnK8l1TLj4O3NqvCd5/b/hOtL6sS9rtn40S6rVk1LWsCMZJLMTS?=
 =?us-ascii?Q?X9IH7t8Bm2Oxvw8qPQ6besYMBsiYQOix8fa42Z4WR+8jjgw4730wWXt+shZN?=
 =?us-ascii?Q?khsfe8hOPTx/+pukInOaAj3Aop1pZ591ZIFH546lK7dj2QZben/ozy+Pj4kq?=
 =?us-ascii?Q?vkRtrXgb+g/VnMTMV5/tRdCf70o/fCXD3nlxv1IPg1oPNlq8xAZJX07A1Lz7?=
 =?us-ascii?Q?M7LoFfNunWlax0E4B9YchwSfPtasKs3ZQQY1xNumVLn8Dh9k3Fz4C2QV7mtA?=
 =?us-ascii?Q?WcrM8vM1PBCm3lGX69e8jQHin/HHEyed0MCd2mv+s6smi77OR5RSqCxxCKud?=
 =?us-ascii?Q?Lcda2JjFqD+JiSXM5VCaQmqpX4uUQjFbMdC1x8Iht/VQvvtaV78DAzMynO9R?=
 =?us-ascii?Q?w7icy/wSnskmyPLANplB7SjWkU2euqM3k+zFgG6N0fp/NBA/B6VwSBYfKsH8?=
 =?us-ascii?Q?qi36UjvjZB0JcEIMVqpw2Eg8SLX5hysiiJv14+YQU1Qh6O9iAo6jz971XtxD?=
 =?us-ascii?Q?BKJTmxq7wI513LQMsP0lNOpcaF+s1Bj/o/Hi+CddikC5IEbjVgQX5u+P6Sfz?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 707a8b38-73ff-4fa6-5b70-08dd4f67b883
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 15:28:25.3615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oHJjlCx0UiPXTU+O6y3lbIRCji84YSpXwbPn6dtetTct+KpzlfWYEdLMJUek4tjwtjA5AYXW2hSNcr5S3/MATuOlVsY7ZdSPmYhOxR74tks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8242
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

On Mon, Feb 17, 2025 at 01:54:05PM +0000, Anatoly Burakov wrote:
> Currently, the architecture of e1000 base driver is such that it uses
> function pointers internally. These are not guaranteed to be valid in
> secondary processes, which can lead to crashes. This patch prevents EM
> ethdev driver from calling into these functions.
> 
> Fixes: 805803445a02 ("e1000: support EM devices (also known as e1000/e1000e)")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---

Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel with patches 1-3 merged into a single patch.

Thanks,
/Bruce
