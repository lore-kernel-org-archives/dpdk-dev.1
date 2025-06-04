Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FA7C5B543
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 09:40:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA9A74042E;
	Wed,  4 Jun 2025 11:40:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 10CD04029D
 for <dev@dpdk.org>; Wed,  4 Jun 2025 11:40:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749030040; x=1780566040;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=OTS9g4VzSMIzCOB53WaMXLPFxKPAhQLdKxkJ9wVwsYU=;
 b=Cx/+Cfg0uZ6SqZBDloKR6MemrIMMhQns4wRhpvzK+wOhPGoOtNy/QFsT
 g0HJTAUjziwmOLkXgBKswrYnJvEJQJpIbgfECjZ2CWI6ksG+gwa02Ztyr
 XV0YdxR9rqqxJrU1IkQQYyN+rqBfmqJeLOEJFGR7V5Qubr1T7Zc1Qevji
 +vksCqiQRtM0drD01IbOO3nu/d5SqhX6SfFOG3FUPI3hcQiqzYjMeeto3
 hFx5OFxgH/u3FQClIwDX/RoCTjlHp+LOxOfJ3HAx7CoUvK3DDmIICE94O
 NV3v9NlVH70t7sYLattFGYPOkAQAiUr898fq5bvluH+UljFmujK/V5bqP A==;
X-CSE-ConnectionGUID: c0q4MmZyTOKnVTGiUaYVHg==
X-CSE-MsgGUID: ufX1rK5bTPOBWFFbugOpHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="62491929"
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; d="scan'208";a="62491929"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 02:40:38 -0700
X-CSE-ConnectionGUID: 1jfcMUBsRuGSWfJtGoYiFw==
X-CSE-MsgGUID: CDYaa8ssSOWUbHFRWI7wLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; d="scan'208";a="168310000"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 02:40:31 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 02:40:30 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 4 Jun 2025 02:40:30 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.76) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 02:40:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chdpN3tLCZQk8A4O+H1U674v4R+T73gW0f3fucdcifRPz1YZXbXkgMU0BJQUafWqUVWeHfSsknlikiC8mcOMSB3gESowW6x+mboO0Zf89/bCoDzVh4ci7z/bGuTgvkzfNrBgMgzn6iBksawjeBllY0vgIJb5ACexhaxMURWkQr876Cx07J+3nCRZOx4Efe0qlndzyvH29ukEAAnyfmLORxNLn7b6icsa6O6Ul5l/s0of7ZfNwTZIZu5Heix/OLa4+oq8G0vzpqw3+qiio5M1v0bdoNdXQtuSHhT0v4fyPJEKXex5A1v69Ga6rXQeEBGi35X5e6lkc27AkKQGkP0mTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/k46vmViEFkPjtmyj+3KbCVZSi/MDbPdQ0pNNs55iQ=;
 b=eG/agZrXN8pDKAWiLW9NDNvitosmlAOMSJSSRJOH9FeSs1irb4fzx0yafGPvPvtW26ZGpJZUxeXu33Jjl4znvOc3gHMFRkECHYpGkkr9ZPL9RP/6zAIJSTqBsOkF8jdFrDPs8LtmMiCajKVSO4ZMsr5OWISyL5LqfZccMExLBXDrWqsAmhFjelpaVnBL+6nZd7XobgRMjj6JQBnKwUdmtozI/OONpO5I+dsAJyy+5omp+Q7MACl0rrkKoxVITgF4/mU2x7IMoP/WXBxvFyggSUx7CYWrgy9lmjxGJl57h1x1YI4IixiJ1Qo9zBEnCMm3KeA3/vdv61Bf8uypuPiqyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH3PPF632600ADB.namprd11.prod.outlook.com (2603:10b6:518:1::d27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Wed, 4 Jun
 2025 09:40:20 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8792.033; Wed, 4 Jun 2025
 09:40:20 +0000
Date: Wed, 4 Jun 2025 10:40:15 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v4 22/25] net/ixgbe: use common Rx rearm code
Message-ID: <aEAUf_Zqbz8FopFQ@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1748612803.git.anatoly.burakov@intel.com>
 <cover.1748612803.git.anatoly.burakov@intel.com>
 <94bf598f2c12704cc60e4201bc670c70c2795227.1748612804.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <94bf598f2c12704cc60e4201bc670c70c2795227.1748612804.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0304.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::6) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH3PPF632600ADB:EE_
X-MS-Office365-Filtering-Correlation-Id: 10652bf5-8450-475a-219d-08dda34bd203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?db/FlAd4h0CvjAZQzTNR+vemBpdC5/lsGvc9Ss1MfINy1qXyORuKWTUe3i4l?=
 =?us-ascii?Q?95LteJjZ01URb2t6shfj4GDSMu5nfXmXL4IRdc2azOiw4fdjK6B+nI4n+F/g?=
 =?us-ascii?Q?qkUugZHxg08a1iptWIRyAsuw+wsrN5fqnCZGZejuBWAIueQF4RyU5LiDPSSh?=
 =?us-ascii?Q?RWbe7iZiiEAiJF2bk9YzxBx1ZlmjGgl6Dq0T6wb0BaHtnL2hy6Gg0bv1s8w8?=
 =?us-ascii?Q?U7PBK8FdFC74fZaAs0vfqkxljwqYJAB6oo1rVMHUtoVTpb3wp3mLLX1NqzVu?=
 =?us-ascii?Q?JkAgMuOT/z3etPEqvRDQZZ3+y0X+7/g0n9OcDLwwDE52yEnSOqERKB0mV5Ge?=
 =?us-ascii?Q?GYjGeJUL2Ikt9IiSZHOU6z0basdA8G1qWVzDw3AYFNJ7tLjDAZi9uFzwTt7X?=
 =?us-ascii?Q?Fy0z5townVbzWVjWODi/llvDCc+Bwt/yvbfbld+7EtUfoxe3RVu+8VQ/xCfK?=
 =?us-ascii?Q?IUP5uKKadoA5VvXTGvseHznrGyXp+Fk5HqI3LZPfFFowZQl16zcHnKCTAqp5?=
 =?us-ascii?Q?6wG6DOsShNUyyaAAXDRi74bZhmjPBANofUZHup1CJIDqbvfXG5/47otvSpY8?=
 =?us-ascii?Q?sdiNPlnOJ9LvYajN2ORFKU7qUMglD8iP2HjQ14OG3suaNSfAr5u60H7J1Ejd?=
 =?us-ascii?Q?gK0Na1LVyOZwIeLtYhdmgCNbzO/l0sDJH6vgCrqnpYoVRrAf5ZyG66abTQIp?=
 =?us-ascii?Q?BxU+bG0y09GjtEPArxDxHvvXCgNQ3R18a89i60Q/n/UY82yT7GYahATGtOaU?=
 =?us-ascii?Q?IozmqZG0AiIP+Yi8SgxjbBlDXGP8eXsqc35UFDjOgG8WF+3lMHHsRKfVHk4j?=
 =?us-ascii?Q?AF1BJ+ZlPBENM5Sspjj5yEinjKWwqAQK2kR8swVtQCyuMlKCjz9VDzOg2l/H?=
 =?us-ascii?Q?uiqalnNrOzu7ULNGoo5kqbVietdhdFS9RRnAMurVXj4QIgzMlNlIBHtebpn5?=
 =?us-ascii?Q?LHxfr7OzOwMSkLdWnSRtkqkJp3wLlqr3QTQeFhQoXSr81emIRtOB4zmvCTiL?=
 =?us-ascii?Q?+Q6B12wkpxHaL4TlorqG1bQJ3K1avEWyoXsaFo9FCVYYNgOb/91slpGbUzb6?=
 =?us-ascii?Q?BTk+EpoGCcu5Zl6hRE32OJCtBgG573OGjjKK7a1A2G8zePCKmJwqptaa8Dwx?=
 =?us-ascii?Q?yBwahwv0Ek9YphxT+nEjsgJQ399dk7Btqz6Ogv6BR3ub8CxRgNpLQNwUDlxC?=
 =?us-ascii?Q?2WuKe8KqrevZn1Kdh0fty5m/kmvc9nF33ZNkynyr52Fl+6wDkp8zqRXt4zME?=
 =?us-ascii?Q?a57ejUH5iUy1FQ8JQPTJNtHn31ZBFdjYcdwmCV84eSmtefQ+1zFOWc1RkhCJ?=
 =?us-ascii?Q?u5E4uWY0raa4JS9Ns6JeUK/WRu8uQ9lDiIzkyWo14Dr1IJ5KueLRWB7J/NlI?=
 =?us-ascii?Q?sM3Tm7kbvfM6rivitJL3qtmo2r3kgpofqvge5KMH8kTCcblVaYGXu8mMDNmT?=
 =?us-ascii?Q?/b2t164NCxA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C5aSu/lb6nr6CtI67ImiIVrFtz7GZZ4OL4TemTDmOO+WMJCWlG6WAKBGOEc0?=
 =?us-ascii?Q?8pluZtucMoqSIMDwEvqNPAryWR0Hoa6n+1qQK5FA1SUim3QP4/CrTDFznZ/d?=
 =?us-ascii?Q?W8ua8Wk9F+3OlImtFwRifHImHARJdzmmlq9rdlkHFjZbgg/zqdMETKfoU0Lf?=
 =?us-ascii?Q?EGepqmFPNWF1/unkLd1iLz8oKtgzCw60QYiAK3tspCVMzl8M/n/VhljM+KBr?=
 =?us-ascii?Q?m66vyXcwTtZ3od9YwiAuhm8mHCwAvOwNLnH2kZ3tEq8+CztdC2+Q+Ff8DtWz?=
 =?us-ascii?Q?obZ/t84omw9MhczBc/z0peyuulBXqIUtRjI9H9nDSzzEF18Mx0eR+7KVcKS0?=
 =?us-ascii?Q?dJGLORggeyx0AM9RXoyBSX5j4XyORSdv7bVX33zea6U7Q16rHzQvbcV/Ny/L?=
 =?us-ascii?Q?23cOROwXI7DSUp12HxBkDFXSsnT5ZLzkkAt7Cr8D/fx+LXB8ar7//Skd7J4G?=
 =?us-ascii?Q?7mY7bcdDi9OUouGDi2rW7b7uNI/cYcHCHHZ6kDOnFgnRNOJ39FkuJ94Uukvm?=
 =?us-ascii?Q?qImLWj9o/9oQ+0r7t3rpEM50j6VeFKjLAs+Q8E4spJk/AgzScTk6uqnrWWzT?=
 =?us-ascii?Q?llU3zqWErfGPiRLo8UGzBLxTYXK7jOwS2s8Sj7Qov715b5e4OgEmghDe7T/z?=
 =?us-ascii?Q?E6SSeEKYKkEbkxzzZCSiUpNDj9e+8ACQLftO5KbsrudZmcDGchJJgdL0Z9xd?=
 =?us-ascii?Q?ZUoPWdhRDYLSIWn3PeFK1bmNdzWbzQKFspeiTyVxekTkUkAvhVfCe0lMfYgT?=
 =?us-ascii?Q?72Z0JEs8xfoEH14VcfzFJHFL1P3OzZfqNXjVE4gQLJJshinf9TSAdoeTQsul?=
 =?us-ascii?Q?Ocvu34zk0rr/LmJkBfqSnF99wP2lUkxDLi9gvtOR091hbPMpU6ypy95hwYtG?=
 =?us-ascii?Q?zFtOi1SqM+iFmw0gzrxEnSIWNOF2p3jSBZs9kJTw4owkixKPIMzFa9xgZrT8?=
 =?us-ascii?Q?TGLltsDDMTRy2PDMuoMZ6NxkXrsIxRK0X8od9Gsb94/d/PFOXkNtmkR7xz6q?=
 =?us-ascii?Q?lFXNrU4O+VpXsK+jjFKaQAk5Jg1obm7sLWHoW+1M41V42NHzTJ5oKBpsj1Eo?=
 =?us-ascii?Q?arreDl6nhldRDKTKVGjjCk4Rd/yAdERR6Ke58oL788poDZ3dwwhaTr32cYjT?=
 =?us-ascii?Q?NVYsjSynrUzbg2dl6pQO8R2OA2VsvL7yBORttMtQD6nfsVqX337+ZaVKCPa6?=
 =?us-ascii?Q?i3NBaKSKZ4RxlUYoijjNZ7RRBG5+BOqkfzucFPrETsG0sLOMtHChqsPwwbMY?=
 =?us-ascii?Q?+u485rzoMKmxSMItDvNSqRCEcx8RnO7KgGNsKOoxjKe2X8xYrgIKkOY2oC0g?=
 =?us-ascii?Q?a4TXKrSeP0xbC1y5Bu5b3TU4sVfxoF25ddpG1ZoOQx/YWnd9dlgKJ5KDXoPV?=
 =?us-ascii?Q?TQmOoKhVMMb0HBx4SoO3f/XPXcQ30GZXQ0qo/qdEmBSUWuz2l/Cyr8eEEMnH?=
 =?us-ascii?Q?ZX7jyE5b3oqZ7rYGAnrwl2MAvGtYn5XkSC1IZb/Cm8qbGiZq+mwKRn1WhBOf?=
 =?us-ascii?Q?kgAWav+JM3Wl3Y+vMeaq+sG46ZZcjaUdNrJWCkC40F9UwvKJa7HXl7oEtkk3?=
 =?us-ascii?Q?GMZex8tse7tfgZKR090zC1N9001yCx04N93hV/JfcUIL1exrWWoEzKFETq4o?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 10652bf5-8450-475a-219d-08dda34bd203
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 09:40:19.9692 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EbinQXNAOT6mJxgJwShUFwkSy6jlIqwzsnqEWNb8vm+YXbCyfRypLiqC1CYx9LuW9bW32pt0UvAO4YslC62fJEUJd2Wzc9RDVK70E5MO1ns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF632600ADB
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

On Fri, May 30, 2025 at 02:57:18PM +0100, Anatoly Burakov wrote:
> The ixgbe driver has implementations of vectorized mbuf rearm code that
> is identical to the ones in the common code, so just use those.
> 
> Since ixgbe Rx descriptors are always 16-byte wide, force using 16-byte
> definitions in the common headers with a define flag.
> 
> While we're at it, also make sure to use common definitions for things like
> burst size, rearm threshold, and descriptors per loop, which is currently
> defined separately in each driver.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
> 
> Notes:
>     v3 -> v4:
>     - Use the common descriptor format instead of constant propagation
>     - Use some definitional hackery to work around IXGBE descriptors always being 16-byte
>     - Use the new unified definitions for burst size, rearm threshold, and descriptors per loop
> 
>  drivers/net/intel/ixgbe/ixgbe_rxtx.h          | 21 ++++-
>  drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c | 67 +---------------
>  drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c  | 76 +------------------
>  3 files changed, 26 insertions(+), 138 deletions(-)
> 
> diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.h b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
> index d1847a33dd..0640336156 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_rxtx.h
> +++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
> @@ -5,9 +5,24 @@
>  #ifndef _IXGBE_RXTX_H_
>  #define _IXGBE_RXTX_H_
>  
> +/*
> + * For IXGBE, descriptor size is always 16 bytes, so in order to have all
> + * vectorized and common code building correctly and with proper offsets, force
> + * the common parts to consider IXGBE descriptors to be 16-bytes in size.
> + */
> +#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
> +#define IXGBE_FORCE_16BYTE_DESC
> +#define RTE_NET_INTEL_USE_16BYTE_DESC
> +#endif
> +
>  #include "../common/rx.h"
>  #include "../common/tx.h"
>  
> +#ifdef IXGBE_FORCE_16BYTE_DESC
> +#undef RTE_NET_INTEL_USE_16BYTE_DESC
> +#undef IXGBE_FORCE_16BYTE_DESC
> +#endif
> +

Is there a reason why we need to track the forced nature of the define and
#undef it afterwards, or is it just for code hygiene?

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

