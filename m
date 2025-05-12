Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60466C3ABC3
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 May 2025 15:29:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53FCC4026C;
	Mon, 12 May 2025 17:29:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id EFF6F4025F
 for <dev@dpdk.org>; Mon, 12 May 2025 17:28:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747063738; x=1778599738;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=n3sfNqTX0G0i83+tZieC5wT/vYyhEj1dVHl8GTwcpLg=;
 b=WdZKAhDNM1ZTdRBz6QgLSQF0zE4XPSHL1PObo+ISzAe2vY/pohFf03sV
 hHnxvFHjZum/45WkI3dN+fycIMw4vtoonZixsVyHk8M0T1e5sB9hHs2dD
 tAxCdTMb0gVMTeIGBOmFi3Oo6au2VNyCrWwDqXEf4QBiUBH2gUJPKhePL
 n0Y/hWiGhrh99hXNcBapCJYmf1O6B9Fe/x7u5WG+CdnmVGWfZ4KasCTTn
 TKBiLLOc+qiBNcHb8K7Dvw+kQVcvrDeJkDyExR9JTY2YV0pgXQyFNxi91
 zcKX2sG96LdvxSEXV6m10hCyYLfH6H+vtuP5sV90MfI9+/OFFrv5/aoBw w==;
X-CSE-ConnectionGUID: ijUD34IJTe6kLjdqHSy8HQ==
X-CSE-MsgGUID: OsOvv2EgQmSGli0/VhmR+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="48768185"
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; d="scan'208";a="48768185"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2025 08:28:56 -0700
X-CSE-ConnectionGUID: e226iwInRIOTeFDt+g190A==
X-CSE-MsgGUID: OwhKdHNvQ0OTCke+pfuPPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; d="scan'208";a="168475991"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2025 08:28:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 12 May 2025 08:28:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 12 May 2025 08:28:48 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 12 May 2025 08:28:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IDOSDTGf3xA464vUOp0hcuxLNfcTrCmoz3qwi+XMpfFH0nVTrH5QdbAXHVvE31Pyok9odGOLctWJ18SOnpHNUjWAAbprYj67P+jmvCGBfht+tdOQYW/kW1mOtisQpqJaDuscf34AG4L5upnnKiUEv62MJIuzoeJ2EomGvJHuFFHr3pWsfdKMAM8DZijldXF2XY2WnYzilY2jmoh5zqHUBljPnjCeQ3aPu+4H5gg1P9OE9mU+fIuFZ6qgrq6j4a/3gOptU0mG5Xs+gCY3Fsx5Z6u5cyFlgV9+xYozTt8xVwaq1yANq9JVV8qwQgBGpLXoYddWoh18tVYUD5Dpxd9oKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKrJF5ph+SMnDsD3qeo/zXeOl9qMoMrO/PNguomjPYY=;
 b=Ap+YvXCiLrEQJystC3VBM04d+AICqord0XqqMyatHS0zg2WOEKcyFcFU8uk0M4KfZ6lRuKzQczEVHYMEVt6FkjGPAsma4KCH9jJvXqTr/+IwSj1i3E995h48F7VfVdsmJssm0ziohb+7Tp2I/tuY0uIpttDmfRbr9a9fsZo4BliSm7Y4rbRg6WZOF9SxOybd96bcmsyM+eaqmXQIIW5q3BC2CZCPlNG66cMXfrv+diOd7VJwPlFTB+1H8zWWDW9F6lZcVc8DjFzJ2lsJ0JIL4ao7Zftzi5CLdh/vuqe09dec9HJyGqJH2G7crbF1BPwEeTsfinDMLXrTVhA8Fk8L/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB6747.namprd11.prod.outlook.com (2603:10b6:510:1b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Mon, 12 May
 2025 15:28:30 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 15:28:30 +0000
Date: Mon, 12 May 2025 16:28:25 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH] build: fix disabling developer mode
Message-ID: <aCITmVz7OAjbNvCo@bricha3-mobl1.ger.corp.intel.com>
References: <20250508044230.133966-1-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250508044230.133966-1-david.marchand@redhat.com>
X-ClientProxiedBy: DUZPR01CA0061.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB6747:EE_
X-MS-Office365-Filtering-Correlation-Id: 6480ba6e-bd55-4943-6ff4-08dd9169a60e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?11jJRMBT6My14Y45j3Z8UJign4vUBuTAbMsGmynhLwwJfv0PWBR5tA1UfGvE?=
 =?us-ascii?Q?Ibr4kSfD4QZsY2YhGzws9EJZ/2GommVu0LssE323p7RNn+nMVTezQx+9AcWR?=
 =?us-ascii?Q?z+lqtbd0rK18kv3Y0QXKD2dpU2cYzLyOsXSfYSx5iVWiYL7LQ1RzMbb6/O7X?=
 =?us-ascii?Q?XCKxWyc9fXvn8ArMEqEN5ODs5qFeg8d2gfxxm3AL/GDI0kRsiHWX42vHwsKz?=
 =?us-ascii?Q?f/WAtDm967n17XmKdOahGlX5s7Pg5a/MNfndWIZqavwYkHHlW9oDzAKRQb+h?=
 =?us-ascii?Q?Y8+J36AyLlJq5mmOcgagV/9DLR8yO6JTJGTu55WRNPKI7BZqxW9ntrnmr3O5?=
 =?us-ascii?Q?zZvaqSDj5osAZm4KOQYKyyPqgrUGLDx2SeEZe4wRspx1DqsUwgIYKlBD03ue?=
 =?us-ascii?Q?qoDFxeSVT+0q0wPRkBPuwqzOqTkPkdR6rhKE4GYn9w1vL7hzeF/av0kRnBVA?=
 =?us-ascii?Q?El5YEH+dqdCSQCtJm4SwCbQ5f4AcrSa4pFCkBKDeP7CZEw+SxOoIOvr0zgzg?=
 =?us-ascii?Q?o5UMGyZm98EzTnuhdehBUBoUeznzqmW532XUb5Xrpq0+HFwfZaTiJjZdIr0p?=
 =?us-ascii?Q?0OL0J+SACRFwNMzQG751Uu/o6pdSnKKjQegkT0fWoCGogRTDHJuFVOJGkMOE?=
 =?us-ascii?Q?5Xx3gqtGZYfapuNnLwJ5bN9HP77KnAu923p43dZSc4jH+4TrDGRxyWMe9/H8?=
 =?us-ascii?Q?+w7crSdAwJuiyL8/2qzw5L+pcnCCZ1LbLkBvaz9TjTYH8LHDm3S+i72ml/db?=
 =?us-ascii?Q?EepbFMPaTKEurqjpI6Szn5P7S9QNCm9yG4k1zf/aQfy1OaYRlzy+Ior/eEUI?=
 =?us-ascii?Q?rOaUH+tAqiuBDTGk3+C+cWK2Jm6WzYzh0zPVRJULSvVW5FTVVA+to19qkwl4?=
 =?us-ascii?Q?7qNIyY/62AvOCSBt6kSQW/xjY+yIZDIDl1xK4SPCGreHAvFuUvYisdNcCt18?=
 =?us-ascii?Q?+bIHZNeYPjsi9zqpcgFRftO/tgjl+fokaabLmWkiTyzs1rCgnhs4kegjRy9b?=
 =?us-ascii?Q?uUZTbgJVRayceDhxaI193bMzL0oFHozZfFvH5Ha+2Vf5N2RAUSPpWlwSirIR?=
 =?us-ascii?Q?ITuU9IC6o7ioQtShRRolXR/4t2p94xV//WUzjYjW/DYo0YjL892FRTlgRMKX?=
 =?us-ascii?Q?BIECrQapbwUkIylEwsKEahJ3GHT72EDJ3uzgaweVg+nRTr7QCSTTZWf+tlbN?=
 =?us-ascii?Q?YTa69XRNMXhlTMZ1J7azYdY90TWQoLYd/n+TguAfe3j46Th0nE6xZoDDJUg2?=
 =?us-ascii?Q?yKKqnUEwj7D9u9WoxqG0KwRYmYGtWA4mVluE3z7yeoCtN6YXI4BtEbfdPhD+?=
 =?us-ascii?Q?CiWhKpqw6Ug+6OA1u/3lRWfJAgB+U7tsFXVdN6X6izvfOSwEvLqfM2cSSgXr?=
 =?us-ascii?Q?yM4WyijZim4e438pp6F2YWyGA5MZTresp5RlkwX0Di1tn8pDTYFBLjxS9VXM?=
 =?us-ascii?Q?1CVoZrhCDos=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZNmqnlKCVNFlCEymAcYhXh/v4MxVtas1YexD9ttHIUDaidHO9wPr5ToVZiA7?=
 =?us-ascii?Q?RinETGYeP41nCiAwCUZljuxl7qnefsCLHVzbx0Xbkt33Fktj0eVAKiYyZgNz?=
 =?us-ascii?Q?7QoO3uazRlaXaCicj64HfrM/QcqE/d4dBDhSqi/OfHZpD/1tLKfnmOx7lsfM?=
 =?us-ascii?Q?ASKugj+Pib8poH5KsF1eyOdjjyM9wpFSDHiaAAFBP9+WaFnsNwhN0y8YElPs?=
 =?us-ascii?Q?tjiW89HwxvEJHO4M8ZSqLXLNBP/b6+0GuxL27SLM0eeCFKSETF8WCJLrjHnu?=
 =?us-ascii?Q?c11bv3eK7yxNE1Zues5T224lrM1IpxjUYrWvt+4zQUejffUib/VqvD1pxzSs?=
 =?us-ascii?Q?t1gOAEjOi6T5LP1pQ+2NsD6cBW8nCcdJCP/3k5nT9ML6F38/SfhxqHTlOHvf?=
 =?us-ascii?Q?lOtLloPzC/8eY4WSlUcfkErGNMCdLPcN5JY2ONrSme6TJC/ZOOnS24nqLMKX?=
 =?us-ascii?Q?Iv+5Ur/YrnYFHWnywDhJEQ4QLRRFWDPC8n11d6kbdxaPkjjvI/kkOdQYvsdd?=
 =?us-ascii?Q?HfC0M5H7/vCAc9tR47BgIzSUWxoKT2CBN0JtcT49UddnU8WMyNEzdrrHcJ+B?=
 =?us-ascii?Q?OIFW0d3vtj2x5cTBhBYACjPHwnG30393k28QHt8uyB7/IaQH70huuFuyfn3I?=
 =?us-ascii?Q?jJfSh3uwYm0gjxeyS2ASqUBW3G9VDC/CwgTom6nzzXIsMbGMCURrJb8R8zBr?=
 =?us-ascii?Q?6fH2D6dek2M17OQZ2CvWm3EVAJSIekBLoRX9M1A7QLfjkdgEdtpP8s2T0NXz?=
 =?us-ascii?Q?gm7nPSWyTzTSOxoNJPsoS0qKqKQjey4G6NSM0ubnpVh7/I9x8lx9O1SEZCqv?=
 =?us-ascii?Q?ZgdS7Ip82VsTOhEg0YXqHTx/rxCoY+hbpy+qi5Y2Cmg5AdUnxXkBkcCEG3PB?=
 =?us-ascii?Q?ccQOxopGTCrOBBzgYwSYlSTp07e2I2Ln1HlC7kefK7qxqSISqgXzy9SAx+vg?=
 =?us-ascii?Q?fzDGy2j2UKB1lQpFm3wPI7Ll2Gx0UVHAA0QEEARAEbsY2a22s57Z1bmCxqrO?=
 =?us-ascii?Q?76CKU/2ccy2O6aCYVf0Iaf1yzuKAC+vNixgMFAh83dmWhYcSb37twDbeeNzK?=
 =?us-ascii?Q?wQSbyljkJBTu7eddtGCCLHYmc05iOozg0OglSnmjyIALu/eIbzKcYzOEZ061?=
 =?us-ascii?Q?Vf1RhxclU8UVK4y1JRIndJTXDJPaE/2i2bGrnUGbgYz9mkSjtun6xdVtoSdW?=
 =?us-ascii?Q?S6ps0Mc1H2dSmaw32xyLaF5nCs22afaVaSdxgDRAmb+w39KWKUCVEfDRuHNK?=
 =?us-ascii?Q?hmCs9DflZSxSuoQ/kplkCsjIKqSAv+BF88p1loqZ7MqyDwonpOyl5aEHwhTv?=
 =?us-ascii?Q?eVfFI/KiDV0QOD370KoaDcsCye20IqxG236rFeQaRo75Ejl9R0fLy9/oRkUB?=
 =?us-ascii?Q?v0v6cBvTZdo3HaMKL4+qUFWslBfuO2XnJP1LQEtwXbhHHF+yUvMKUclIbwKk?=
 =?us-ascii?Q?WEiLkyhYH8MSZpBdFbXQcMrr2OS8dONqJHXsgGJQCjdk+D16wvMVMESHxCzT?=
 =?us-ascii?Q?psGxwZAYrBjRyyBCP3tjgnxtBsQmeDrO+Wf4K6TixILmcu5T8aY2+D5CAxrB?=
 =?us-ascii?Q?OqJqsUtvoLw6UWX5kS75ixmTOSIw2cRXgD073wMPWD6NiI9JGe+7f+gp9wnQ?=
 =?us-ascii?Q?+w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6480ba6e-bd55-4943-6ff4-08dd9169a60e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 15:28:30.2309 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xpm/p99KfCm2FbJfkHGC5O4FSnJ4LnxUigcC88pR2tdjTubUHMsPLW4F4m2fuFQnFD/oT6ubBl7ILn66j7+qyjiPM71IIkRq0uuJw5T0WuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6747
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

On Thu, May 08, 2025 at 06:42:29AM +0200, David Marchand wrote:
> A recent change broke disabling developer mode:
> $ meson setup plop -Ddeveloper_mode=disabled
> ...
> drivers/meson.build:150:14: ERROR: Unknown variable "fs".
> 
> Fixes: 8fa3af6c05f8 ("build: add generic support for base code in drivers")
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  meson.build | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index 8436d1dff8..dfb4cb3aee 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -13,10 +13,11 @@ project('DPDK', 'c',
>          meson_version: '>= 0.57'
>  )
>  
> +fs = import('fs')
> +
>  # check for developer mode
>  developer_mode = false
>  if get_option('developer_mode').auto()
> -    fs = import('fs')
>      developer_mode = fs.exists('.git')
>  else
>      developer_mode = get_option('developer_mode').enabled()
> -- 

Simple fix, LGTM.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

