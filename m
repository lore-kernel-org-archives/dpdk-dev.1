Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34ADC5AD49
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 May 2025 08:30:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D6A84067D;
	Thu, 29 May 2025 10:30:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 41987402C5
 for <dev@dpdk.org>; Thu, 29 May 2025 10:29:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748507400; x=1780043400;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=9Tj9/NayDBmWojaGDPMVAO+idRYZbiEnkBjLGDzEZWM=;
 b=mfShDDURroJ+3bQKGTtcmeEMtxCsmRqcb1ioCHuIdanceqqJn1Xs67Hm
 DotfFWgp10F+MuBKd89EWCxJNdCMrLGzI37SJQwQQZFl1LbKI0/lBbfFa
 72LNcqKpD4mk2+HhOBeDNS47Huv/G3hzGPCxKRq+JRtutr/aRwRN5wgeZ
 JCVxIY2I1Se7Xg0kwK5KpmtoPRH11kgBOxL6XU6rVtV1KslBbyI5xHhLZ
 6jgaiYXU9XvPo0T5JDiJwn1pejY29ttw8AwIer0la6no1t5thrpFPLKwj
 aKpeS6a2dYCVh4teHkZNvgcwezjRg2gOiZOIcY0fjtywMgXh5doT7WZqS w==;
X-CSE-ConnectionGUID: lYVg5tYnSyeMUs8tNXzlCw==
X-CSE-MsgGUID: dD8NhqqlQICa+Lj2C3oUrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="50613372"
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; d="scan'208";a="50613372"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2025 01:29:59 -0700
X-CSE-ConnectionGUID: dTNBrLlHRqSmPUbtYQFb0w==
X-CSE-MsgGUID: A0oQEY27QhmH3byI/zpZ4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; d="scan'208";a="174373501"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2025 01:29:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 29 May 2025 01:29:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 29 May 2025 01:29:57 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.63)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 29 May 2025 01:29:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GCTO/vwuezUTNh7UQqxRgRTL2+nJA7OyVY4NQKcKnViNRwdZ0DTcEbuwOp9p8CfjRxokyp/wBi4ny3a1FBhZC5ecM7ES/ybS0cvR/F/bob+Tahoulu3rbSyElME7qZgTjwWF++bB/Lc0TwAs3WWBKtcDhLhoqNkjtj7j9ariGlVssKOK9A75JzyUSM+fjQaXkUd4R72hLAHsC4Pj+Oq2zBe3A4lJiUTRzNjyImeAnPjNXaFCVeZ7qOQOL+ThuhPxQvpyqhjMSCIGr5komAXVvx1rI5xTiA2U0oCzRI174yVc8f2wRcQl4wRkIDI9d57l/2bFrQKWodZ7OnhuUiIXuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMAko/8Bs1dktVX+LA+A0BTpTAYY0FX6pm4obcVR0iw=;
 b=u8i0Ezo9BUuR3Vv6yNoNM9DM6IcIOBUxIwOS19aLh/XqmJ74ZIlH/BNoj9wsPsQIIE2i/6pZYcqdh41eiW6GDgEnElHGcRaosnO2pgOyQqJ3zIheOTQ+uBpvN+ES+PHc7Iv8RbJ9SHEUeMdG0i/g1FhFDx2sfVvHj8EDQYMgB+wudyhSWhPuMIeAZcBDLXMxNuy8qpb70pPte2W76H0YBkDL2Y98JuctQLY0H1sWIl3/I7DZo1nUnEUNoFa91zdP+qBsOfURAteeg8/4uPwOOEBQYxtMOy7rsQDHJvWCFlO0/dzpb/2pYgFokKOMCxI6YJkWjPMsX1fIvTRacdVMBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA0PR11MB7881.namprd11.prod.outlook.com (2603:10b6:208:40b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.23; Thu, 29 May
 2025 08:29:48 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8746.030; Thu, 29 May 2025
 08:29:48 +0000
Date: Thu, 29 May 2025 09:29:43 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Dhanya Pillai <dhanya.r.pillai@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 00/10] Update ice base code
Message-ID: <aDga96S6dMfzysGh@bricha3-mobl1.ger.corp.intel.com>
References: <20250527131741.7606-1-dhanya.r.pillai@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250527131741.7606-1-dhanya.r.pillai@intel.com>
X-ClientProxiedBy: DUZPR01CA0012.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::14) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA0PR11MB7881:EE_
X-MS-Office365-Filtering-Correlation-Id: e02cc5f5-3be6-4d5e-cd4b-08dd9e8af978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R0FIPr/4siH0DOuGYo9wTf0hgOMAHGWnHiZIHd5f0qr7IN8vR9/JZPoKnTnL?=
 =?us-ascii?Q?B0AWhu0WXZltPCN3ieChtqTDhzbcA8juIjJ59XqqKyLYNlYNHDxe3V4ThKHU?=
 =?us-ascii?Q?YX7B6rmwfRtc3CyIIPx2DerDEzpOl7yMJcknhxOiyzgAJ6QEjQ/rFtvG1/70?=
 =?us-ascii?Q?iPlIYM48p8orrv9CgEUnRpUBdIpHZjYOBeSNeaGXpovbiGcXu37Kp7tBTpy1?=
 =?us-ascii?Q?6AUVuASCe+Cdd6h1VnszMPc8y04ix0e3AW/X21OK5mSOf2hj5OtnJ7w8TguK?=
 =?us-ascii?Q?TQVu+JI6vTruy4xDWH0pIoebPKg01lOlFAg/hwoYQb7zQL+YZmnNEWnQyTMk?=
 =?us-ascii?Q?4nXL7fwXh+1wdQxbgKBUQf89S+2BNZOMGvTv5XEiUZcpfPhnI0WaAHo3rNTY?=
 =?us-ascii?Q?Sb7V9IJoj51dQYnnMyZeLH964wGwbHwrVjfR8KWqBe7uwH2VxNxVaY8rP6pz?=
 =?us-ascii?Q?RllG2kFG0GrEuGbzp0e7mYAS0YDjKdCvqyfhbvW01i2TGEFl5JK7BWv6DNez?=
 =?us-ascii?Q?hVMahOhEw8p2eLjIIfG1Mk/jmqivZt8O7jJkZ4B6krXGq2reaXPXkwhJz5pN?=
 =?us-ascii?Q?zP7rrUeCvd+6usBWOuqeTYl114H+sPmDsIqYd/5IgaofKG6UnWJUc/AfRTA1?=
 =?us-ascii?Q?hPIUIedBz0K6nK5PLjVtXeWNkeDFzdDNYFrZjdXEloGD1mF1/FLzeNB1ByaI?=
 =?us-ascii?Q?8yxXKmK1pdQeASnKKeGHAQvXwKZQiI2odE0dKlyKdUz0GLGV+X7BctVKQusl?=
 =?us-ascii?Q?ADj+JEuZMbDH7N4EsRrHPjBLNLhLT3pDFi33b2aoCWXG+bvofxCsH3cwSDp7?=
 =?us-ascii?Q?ICiBT1tmBC2avYSpty+maKflJpp5rsEwcT5SFM9oogQRZBN8vGvmOx+T1/KA?=
 =?us-ascii?Q?Jo+dD2zgERIyDHHs//7/Jz/Bvz2DOYqRWCGuSgIYSzFIcgOmLHSSdom0SxRj?=
 =?us-ascii?Q?LZuRGn5J7zlOqYnJKFqNgddyHVNf0JvrB/r41bv1/lZleShBRBJpZe/BYoRJ?=
 =?us-ascii?Q?u4JElCyUduvJqfVJ66MHgQcBHOm7dot7DkD+/UcVuum9BuSWrJULTk2B26KF?=
 =?us-ascii?Q?lTphS0om97yRZPqmSIEKUnHslGbhm+gxHU2eYrPZpL+AbiuX9hhualyqQ7rp?=
 =?us-ascii?Q?3drInta8wwz5PQtz4KE3JOXEiCBfWCWl1rJzjRLQLnQOOD33IPzP2Pelx8SF?=
 =?us-ascii?Q?7bAvJiFrLsM7kCYB0GEYLz2yUOShNhB0B14LNOtuCXl6Je+5OP4WFIUXUsZv?=
 =?us-ascii?Q?yD5cwFOKoiEDaphPPlpILJW+2A5qJ7H1oyXm9F/RJ8lp5hZnp1hpKXDq+ZmO?=
 =?us-ascii?Q?Fp9+mmmKki37tg0YC5uSGHc6klz+79Zy2iE33UCK93wy64R5i25rpwspbk8g?=
 =?us-ascii?Q?dj/svI1Tf2edVKsO3uMZHUUdv32vhR0EcNrrNjH+Sr7sOzeSOQHVwjNkEJG8?=
 =?us-ascii?Q?E6/RqlzCvwc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8MYJs4OV7HNOleIS6qwFqBnXuWmkvGgu9Q6fZ//pJkOLkWEbcxJcyKIrJkSB?=
 =?us-ascii?Q?DMrEUumilbRe1ynSOBOdjLvk78xN9c1QgMpyxspbd1WIHDrNLT2S1ZqNspIS?=
 =?us-ascii?Q?4MkQrUtmIT7f1JLwEwia3ltl5a7K/VHMYasbUeAnfGGr3arwDQM+UrFhvnZ0?=
 =?us-ascii?Q?SzfFgvT1AhXhP60xHuPGgxd/IzFU38QWYch/qUnfEnqDJO5PaZmppYHIhf7v?=
 =?us-ascii?Q?Nw7uRbEjYKY3PowcnwcwpAw4aoPc3y3tG8mz1sNPVXOqp1NA4Jg5O8tiooXp?=
 =?us-ascii?Q?G9pZRpTGIg3zAP8bSiFVYrnaOHg/EgMpHk3vlIuJv++TOvJ56IsZ0LDIzHAw?=
 =?us-ascii?Q?FlpUFwZTCXn38tR5bNHe5XToKRb9bYsfA0vk9NPPEVBwrF753dc03VyfAabp?=
 =?us-ascii?Q?r6qOBJ7w11bWcj9vOZ5J1ZDbwcSkWUjBT+vFGOia+Dof2GZGNdneV7Of1qo+?=
 =?us-ascii?Q?iFICsP0iX5q8fS/1OaDNMTdmBsLvXFI4iivyrUXOGTqA+C043994XgS5jZfp?=
 =?us-ascii?Q?inmLJjIurZnxbrlzsb1GRcpOvG3uNgi9mBvCQyq1jOT1SNsMaKZc1gZbJIGi?=
 =?us-ascii?Q?5sc/NvgznCBhXs2apaFjXTv1CN1mxKgbAjjW9PeEO9tZG43tF4+SmxkNYx3E?=
 =?us-ascii?Q?RW+xzvuK8cyeQbjFCP3gsk5FnRl2ZtFwoBrd5W9EBlAOceBlRQXOPSUqu5ZD?=
 =?us-ascii?Q?PjfN0NRartGWE1u+VvCnTU0zPYbJWC6VFRvm8vqcyIYfaeLnqToXLzs4qstj?=
 =?us-ascii?Q?j40e640MMgOTstocc78Dpq0rR48PPtwvwQutpogYqDTX+1BKGiavMzSN3wI8?=
 =?us-ascii?Q?Bl9kHWxgh3Gf/7s0zpp75X/QjEeyKrXRkWjywNh5mCffWuWNo7r1vBHmv5D7?=
 =?us-ascii?Q?vVZ1Jvw0MwZ50udrJlqmXhuLiYPpdn3Kay237DfcnnOdzbnuBZOj+KxgJEbU?=
 =?us-ascii?Q?8Yn4lq48m/DWtJ/ZYRycV7oVs2k9cB0A0tA+ZPQ3EsgPl3etWehKjFJFRrDu?=
 =?us-ascii?Q?yL/YWo14c3EuK3UIQcEeN999jxw94I/ocDM1756M2sjdkRdA4QUsoRBL+NTq?=
 =?us-ascii?Q?BEa8/BY8GJzDSDvr1GpvJG4ZLohJX6uu1HcGMBte65z5kM1aS4dDhtd+cKyR?=
 =?us-ascii?Q?wuaHzdrgNGdGdNwAhLqLNhaN2TACcDY6eKBv0s0lcMjAz//jVJ6Qs8H2Vq45?=
 =?us-ascii?Q?4vSSL5m0CIlRibrLAjka2CwdUblEuGw/HwWoItVBVx7tgemFXAqee/9vjTtt?=
 =?us-ascii?Q?BtORbNt/zq6oNNibNYTAk4b79Z+sCimJbBTkc98M9tzoNu4Ahsdd3ZZ7DwEl?=
 =?us-ascii?Q?ZAsds0f44GMNZawVoETXVQTUufLM4KWUN1BkY232zyoWSitF0owsPlx2dUYf?=
 =?us-ascii?Q?7LGHhhgXeIp9gWAC4pIdwQvAbbVgUBRZS/myhevmeMpubgveVxgH2q/V5j2r?=
 =?us-ascii?Q?/Ho7PnTeX+y+bRKdxrKg7y7ClRQi3Pv80cVxGGde4OgtYM/gHZfWsaH1Nlr8?=
 =?us-ascii?Q?mzlIDwtFHOdvpl03twdSkkYiyRjp9Q+ZAyCm0pj+3o/RafTijCpDs31rdVAe?=
 =?us-ascii?Q?wK041I5j9109mGIBB30MbRqy7Sb7IaFAIfiu6gxxNcam0auZ6L2iahML35Vp?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e02cc5f5-3be6-4d5e-cd4b-08dd9e8af978
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 08:29:48.8165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dJJwoo8ONEV1bhpKWmiQM9oAi7Lz9j7J+WsTM1sDwfWYcQhcq29AoQrGqduuQH9BRlgssYlcW00lhaN1x4p3AFV07Ss/JkJ2HvTUZxRHCPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7881
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

On Tue, May 27, 2025 at 01:17:19PM +0000, Dhanya Pillai wrote:
> ice base code is updated to latest snapshot.
> 
> v3:
> - Fixed check patch failure in DPDK CI.
> - Added Fixes tag to bug fixes.
> - Corrected author name for couple of patches.
> 
> v2:
> - Added Author Signoff.
> 
> Dhanya Pillai (1):
>   net/ice/base: update version info
> 
> Janardhanan Arumugam (1):
>   net/ice/base: increase reset timeout to 20 seconds
> 
> Lukasz Krakowiak (3):
>   net/ice/base: fix integer overflow issue
>   net/ice/base: set speculative execution barrier
>   net/ice/base: fix typo in desc for dev ID 579F
> 
> Mikolaj Filar (2):
>   net/ice/base: support for MAC rule with own filter flags
>   net/ice/base: configure PHY FEC error in logs for GNRD
> 
> Oleg Akhrem (1):
>   net/ice/base: ptp minimal refactoring
> 
> Paul Greenwalt (1):
>   net/ice/base: fix typo in media type check
> 
> Waldemar Dworakowski (1):
>   net/ice/base: fix type conversion
> 
>  drivers/net/intel/ice/base/README          |  2 +-
>  drivers/net/intel/ice/base/ice_common.c    |  6 ++-
>  drivers/net/intel/ice/base/ice_devids.h    |  2 +-
>  drivers/net/intel/ice/base/ice_flex_pipe.c |  2 +
>  drivers/net/intel/ice/base/ice_osdep.h     |  6 +++
>  drivers/net/intel/ice/base/ice_ptp_hw.c    |  9 ++---
>  drivers/net/intel/ice/base/ice_sched.c     | 10 +++--
>  drivers/net/intel/ice/base/ice_switch.c    | 46 ++++++++++++++++++++--
>  drivers/net/intel/ice/base/ice_switch.h    |  1 +
>  drivers/net/intel/ice/base/ice_type.h      |  2 +-
>  10 files changed, 68 insertions(+), 18 deletions(-)
> 

Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel with the suggested changes.

Thanks,
/Bruce
