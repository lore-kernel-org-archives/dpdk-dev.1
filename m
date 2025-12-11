Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917DFD41D58
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Dec 2025 15:32:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6DA58406FF;
	Thu, 11 Dec 2025 16:32:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id B324240151;
 Thu, 11 Dec 2025 16:32:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765467151; x=1797003151;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=D31Eup5PfVpKyUQDg2GWakH0L/DcPN8J6aY8QiNje4g=;
 b=n3HJDJu+ASAARD31+gRNe2bz+bAso9Ujk/xbRg8qkyu72g60z44r3M0T
 GKMKggw7C8meJqngsJWWnH1zrpCIIqf7Nq20jERfr/RK2pH0Xdmwn8DSY
 922hWp2DD48C6oxDF9PspvoP2jc4TlrhayZOQGSNnLMLYUsBR0gAZraWl
 wBsH70QwLpypSwTWNIZziI81+N8wOYb2PhSZn9fi4FekDP+LZgmt8thCZ
 j73nz2jiosoYsVRPWK+JJ9KcJnLDJ5eOhPRlRu9mvqpsMGF8T+ltM+71J
 OFJh/0LbR00DIK45pzljQHYB628WFYAYkb0GyL+6uE+LJD0rVSsLgnbbc A==;
X-CSE-ConnectionGUID: JoBk9c00RmCcEJyPdbdlPg==
X-CSE-MsgGUID: AHfLRqHuTRmgmZNbUfOZuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="78914176"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; d="scan'208";a="78914176"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 07:32:29 -0800
X-CSE-ConnectionGUID: z6vBB/e6ThGy8Uovx0bkwA==
X-CSE-MsgGUID: XX0M1gu6SUObBkyyfw9Rwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; d="scan'208";a="201296711"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 07:32:30 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 07:32:29 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 11 Dec 2025 07:32:29 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.1) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 07:32:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dwf7/FTiA5tM74QFzZZMEx6I6ykLeo3AIM+rClR8mU6/KYlF2MNXe+dpe99a46TBxKmBYrgEZ/ZW3l4HPuBrwDu0J8s+X9W8Q6ZWTunXgW9N+LYP/Ru4zdHicdnzl2do44uSJlZXyNeDtiBr85HNUpNIseBNYvWz9/S1NuiV+kCLLgTzHxYugzYbLkGztahpkeM3YOdzKWqLkR6dfdufA+0DXnfoGlu/EeY5lXiX7YwFJDPKSiFRtUCzPHUFTWngqiO+lvYQeLmurz3C8B00x3c/GCs8XM64cdu2Cb1GChColUa9bcSPg9e0ptIN29x1uGHpffgBmKUBjvpLPRgbTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0piDGOSfslGXhg0nWcTwnd4M68d/NxBSVE8y9McM+g=;
 b=hGUkZVKMDhIpx/PHiW2K7TGLg+6+gtHANbKMr7w3Nrvjhz3CgObOkoHcP0DMbKIjc41VWuJLVIVqbimV7+cAymbmlnhAe3K+iYdcedWFrJWmK8EGwFi0cKIPXTArrrPKRYrUuVdF4Pi/f2J2M32xATO5bJhUTavJ51Pr2YPxznHbxW/KetFnY8v/jg75LMQTLWZIVvSRNO0bMgCh5A/vdjEc/0K4iP3WlVi4H9IDNPcPiz3J/OGeniAUwSOaHJwUM2V6EkZNccRC401q9eRnGloNh46GXyFqJj0dLLxmj4wwIvUnmaaHSwC3zwEj2rh8/BVBtaL1drPgZnc+f+omRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB7878.namprd11.prod.outlook.com (2603:10b6:8:f6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Thu, 11 Dec
 2025 15:32:26 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 15:32:24 +0000
Date: Thu, 11 Dec 2025 15:32:18 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Song Yoong Siang <yoong.siang.song@intel.com>
CC: David Zage <david.zage@intel.com>, Soumyadeep Hore
 <soumyadeep.hore@intel.com>, <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v1 1/1] net/e1000: force allocation of context descriptor
 for igc launch time
Message-ID: <aTrkAucUzSwGnbcx@bricha3-mobl1.ger.corp.intel.com>
References: <20251204013009.857273-1-yoong.siang.song@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251204013009.857273-1-yoong.siang.song@intel.com>
X-ClientProxiedBy: DU7P251CA0024.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::11) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: f1273f9e-a7bb-444e-ec96-08de38ca7b7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ps60wLCvNugGt1hM8WMYTr30CmJIMPZjtBgsGsnVme0uw/LokgzppuL3kPGE?=
 =?us-ascii?Q?4n41Cg+MsGP5R7KeoY1PXwR1u9NZapdR3tBhoGw+xxZ0gaG8QTgle/JYUcUC?=
 =?us-ascii?Q?5FCXObP6fN61GTDGbe1XIGVkGr1mWuJE6oTLh9E4GHK9Omfhd3nbb3b05n2+?=
 =?us-ascii?Q?mYwPd19QOjiTLp+NfYEtu9I+ZpemNOll7SsquY02ufSvsKcZ2AvVyKMdk25i?=
 =?us-ascii?Q?tLu3r0XdJP2oq1dD19c79Giizdd++SJW7sSGDpB5prcCkzE0tdAqcZRjkEB9?=
 =?us-ascii?Q?xwKhwrAJhIiziwu55DHbO6rw47gN19jc74mNrikcGaUuEiHDIxZuQ8GFiLH1?=
 =?us-ascii?Q?VqWdyHdKEAzuzTbCXN6TpdtvWu7/3PwtNEb8PYxsgX4t6icuqz5FuamGx44s?=
 =?us-ascii?Q?l2Buft4GXvaV0LhJ2gx83dcEiZp6tfr61Dw7uIZ9oqlhkMHdJZPAMsRt9esa?=
 =?us-ascii?Q?6OtkvxGyj7lo7wnjyGZ0fz3stURZnA0VWbxKzC803xpHOyeIVK7EuVw84yNf?=
 =?us-ascii?Q?hE0XvjU/KU3TB0OjS0nySXkwYazE2AGZWiam7atZs2BeZd+2gq0Np/hRTDAW?=
 =?us-ascii?Q?EU6iQjVBeAeNY6WgnzqAVoBWOqc8TY1tUhO+lR/l3uc+sQ5x/fD0OAjBhKHm?=
 =?us-ascii?Q?zXSWVTSaOQUKdfBTJJs53OyIj+UagitclNjSmwkqNGPDXfqAMjxndeu85JmX?=
 =?us-ascii?Q?yBlBv50NgJfY84NQa5pwuVIiL9PbaXh5I2wl4raFb1x4tZA3DcVzeKnGnaZL?=
 =?us-ascii?Q?Kk03dW6ZP8+Y7QlAm6fo1/dlagVRycwGP1DaY+KXwMYwuVcuoW9Zjkuq0NWt?=
 =?us-ascii?Q?hNTDM6mORRfQ8PYfBAxzJt1uctD7hkZ+xalt0+jspGiL5pNu06r3ggihrUnH?=
 =?us-ascii?Q?5iq76DDTRlTxd0V63oKotIrUx3p13eT03JFMsB6AKMY5kcB5p2UGbTqYutWQ?=
 =?us-ascii?Q?FEUw/drl1qJiC91WJK4wDkVjy0f3jWtN4YXFoqCA51ASar4NaQmC2RpkwaW2?=
 =?us-ascii?Q?nXNZIuCYMdPhaOGYA1zGv16G590ETnPUScGF6JWvTofz5EYnvfkkU1+imQpV?=
 =?us-ascii?Q?leTRj139Gi/aySSIHQJBHdw8rrGAZZFAx8Roj9+OPaPgNGe3Xbo5Zhs2AXNl?=
 =?us-ascii?Q?U2CU/0WWYfFHw4MpVtUZQn/mabHHQ6dPj2lrxX+oX/62zPAypqZYeGMAFEVD?=
 =?us-ascii?Q?XARfUpL81auxPtTnxOxrbY8Gi5yXz+/vrAnLuCYkHI7NaVfmpzf0fvNAz3A6?=
 =?us-ascii?Q?ZLX3Co3J3Wb5tKS8iI6dfIL4Ii+j4tYmXC3DgyZ6jsrS0a2K/eCTZ+ysPEph?=
 =?us-ascii?Q?VknM6Mv4FhaooLLdVY/NNy2MjpDk68bwLO0kAMq/tD++trhv6OvhuEcf/YdC?=
 =?us-ascii?Q?qUtrZFCGwAiqFH8ui6WS17yQZIS8lmbUxU5tswYFyeYkyC5ej53fUPCz2ITR?=
 =?us-ascii?Q?kFKBzyDWYH09kEYqPsQpw0jexujOJvIe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tM4rnVHZJbk0hXhIP1VJ6jDdZboFNBmuu6BGFHS9oKBqx2mjXRn0CtUWE8gY?=
 =?us-ascii?Q?WB3uCGNDxtP8K6t1PQvKUYT+pTUVjHLCm48JkHAe4nqwBfwRFFvjIR4wUxWp?=
 =?us-ascii?Q?gQnc6JcOj1R2awI0XHSopicNxGMtZgif8qv9BNT6dLakyDH6UsISeKDwQJa3?=
 =?us-ascii?Q?hlqHiZw1PaWy2tVBTq+ghplGoDa4MwP7ZMzvSVKunEM6BIeJAwDUYUWjjxpl?=
 =?us-ascii?Q?kDGTPV0oe8mDFkvbeJm+vFHJzlPSnM7dwxhpTz2aS4M/dk23rUYNQuFuXuVT?=
 =?us-ascii?Q?85klJBfTBI2g5uuP82ffq4I/itciKULA0RUA5nXltbotaiv6keRz1titvoYq?=
 =?us-ascii?Q?2VbtgfrhI+WuyxDm56Tsagfz42n6WHanWcB90tsSgpVoaMMIJG05nN2zEpgh?=
 =?us-ascii?Q?7kzClc+MyufVvhBYjVUT0troRj3zdWV3p56kDVX9S0ZKi5WEVCWsg1oVOIsv?=
 =?us-ascii?Q?rZNqsBkwrxSlYj/jLJjKJAzHTGusREyy5zy54AzaMg/D2erH8h285wMHVtH1?=
 =?us-ascii?Q?S+dkbP8MrqzgDWh4KByspTsAUp6RcgacyMAWJKOh6wNUxytAWbyfR6HotOP1?=
 =?us-ascii?Q?wTdzeHFGuMINXAKNRwSkJ272KbEdP/FVt/fP5FmWwO88FwiIqd+DpFFUQuHZ?=
 =?us-ascii?Q?7KgdlU26+0VbqNzpBkp5p8cUA6/grmPWB3JhFcBTkr4N2aFBb/seBG//QtRW?=
 =?us-ascii?Q?AnnmWg87JfgENkmdgASZb9659ikBVy0sARQD0Ssi8wHNzp4sA5gsyJa4CnLJ?=
 =?us-ascii?Q?ejzH0iznG/h6nhmGKvv4b+sisJXIc/vdoD810u5jOJ88FlNv7R1L5EupgLu5?=
 =?us-ascii?Q?GAj199DbV9VuOnQx7kR7yogU158mjaUAFnCiJSjdhbb3j0/77/Z6K6XCdGvN?=
 =?us-ascii?Q?vkHH7Sa1qiIOTBx6rdaQf7SnXYwjadhN3Qi6tWmLBpWU09kDSrpPSuZ+P3Dl?=
 =?us-ascii?Q?cwwlFfN0523yvbV8V3ERkXXAxGoiQPZCljAjH0O5lBMD8OWYL807UUuxKsYe?=
 =?us-ascii?Q?s4juwCBVsnYepslyxiJDOfBSGF5HXI6XWbt2CtrCQfnt+ktWB/GDyv7d1tvj?=
 =?us-ascii?Q?WdR/3gX0/fR0Xwwn89CVdDndRdQQhBO+AY1J6Kku7QUj+ku0nC66h3/VYR3I?=
 =?us-ascii?Q?Mt5FeM3dioxv+xBsHD2QPrfu7VfGyZzV2DRJb64HYNkFF6S+yx+7rAyCOCOf?=
 =?us-ascii?Q?Q82m6AZNozy97I+Z2CaZQp9s3cfxwuBWM4ICGAAv+f5O5PaPzEeGVlNyK7jq?=
 =?us-ascii?Q?BYGBrMill2dN3qdNdUvx0GItQ9qu3ktohFw5zVWpXjTL37TzCb6FGbB5olQK?=
 =?us-ascii?Q?iLVgYfrI3PRV+IopXUfK1CgKC+ECKkCfgQu4NUXg97SBgt63JAGI+7Cxr6Tk?=
 =?us-ascii?Q?kWmsNyiFbwVfZNp/v9bKGuky0jrYHeYKSMcZUKAVaWDGbUdAel/Eww0whvh5?=
 =?us-ascii?Q?lJuQpD5/OprcJADCxGNJnUVkHmS0M3eEmSHUs8fdKDMbXpHI5bIlMzovkolM?=
 =?us-ascii?Q?ee+9R/JI1PMJdjI3lrgGYnBLz+CTguDEeFL1fcSgkfrg82NiHOBycgu89wtm?=
 =?us-ascii?Q?Buv7jemSVjGg+v1/Q/Kf1xe9aRMTRnvtDKr/wX3xjIYHk7dT2nB+wcoPfgvq?=
 =?us-ascii?Q?xA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1273f9e-a7bb-444e-ec96-08de38ca7b7f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 15:32:24.2598 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TZmheH2QwopfhHDA6MafBm8flZDxlgVr2Cu640Gqu9eei1z1NTqKyexjqOmvXS8ClRt9FwPsHbhrApWI9Z5Ygb+kK9bDmI0FbopnPvfG3Rg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7878
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

On Thu, Dec 04, 2025 at 09:30:08AM +0800, Song Yoong Siang wrote:
> When the timestamp dynamic flag is set in the mbuf offload flags, force
> allocation of a new context descriptor. The launch time feature requires a
> dedicated context descriptor to specify the desired launch time for packet.
> 
> Testing was performed on two Intel ADL-S platforms with i226 NICs
> connected back-to-back. A DPDK sample application is created to send two
> bursts of packets with 100,000 nanosecond burst interval. Each burst is
> having 5 UDP packets and only the first packet in the burst using launch
> time feature. Meanwhile, the tcpdump command below is used on the link
> partner to capture the delta of Rx hardware timestamp of the 10 packets:
> 
> tcpdump -ttt -ni enp1s0 --time-stamp-precision=nano -j adapter_unsynced
> 
> Without this patch, packets of second burst are transmitted immediately as
> the driver din't create context descriptor for the launch time, as shown
> in tcpdump log below:
> 
>   00:00:00.000000000 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
>   00:00:00.000008384 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
>   00:00:00.000008381 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
>   00:00:00.000008384 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
>   00:00:00.000008384 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
>   00:00:00.000008384 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
>   00:00:00.000008387 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
>   00:00:00.000008384 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
>   00:00:00.000008381 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
>   00:00:00.000008387 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
> 
> With this patch, packets of second burst are properly held until the
> intended 100,000 nanosecond intervals, demonstrating correct launch time
> behavior. As shown in tcpdump log below, the delta of first packet
> between first and second bursts is 8387 + 8384 + 8384 + 8384 + 66461 =
> 100,000 nanosecond.
> 
>   00:00:00.000000000 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
>   00:00:00.000008387 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
>   00:00:00.000008384 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
>   00:00:00.000008384 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
>   00:00:00.000008384 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
>   00:00:00.000066461 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
>   00:00:00.000008387 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
>   00:00:00.000008384 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
>   00:00:00.000008384 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
>   00:00:00.000008384 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
> 
> Fixes: 9630f7c71ecd ("net/igc: enable launch time offloading")
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Zage <david.zage@intel.com>
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

