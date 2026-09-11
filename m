Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECB7C88E4C
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 09:52:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F25D740269;
	Fri, 11 Sep 2026 11:52:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
 by mails.dpdk.org (Postfix) with ESMTP id 1816B40264
 for <dev@dpdk.org>; Fri, 11 Sep 2026 11:52:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789120368; x=1820656368;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=a0esG8jd6CYaF6SlZAKsRtTGxhetAVBDYQMWIGtou2k=;
 b=QVNfjQOWFyTDG9sLAxjivPT9qtvwHxuNkzreAp0e7eeJso+B4YLtKj2i
 PQts+liUD1034hquENp7mOY/GaZltD35xeU6XxAQ2wxEX+ItgsTMdo649
 XMJFbfALLv4QkHxc/nYKev/IEpiiR48JRG/0r4QH2l/cslOOF7rt9JCB3
 p3PO432cUSmhrX8MK2w4OMlhcqO6IR8F4W3pzVJAVexkE1Tl1bsTrStlA
 55JxuGJ6xWo4OH/d5oPgRhd/2gna04z694b9w7ODuKwk1SkS7+7AVnh3V
 dPQO1jv6dQbP6Du6thQBEMVoI4kyi5PoR3fdnEI6T7lsm5owZQDlkOUBG w==;
X-CSE-ConnectionGUID: Vphx0x+zTWyE3IoP/IYfOQ==
X-CSE-MsgGUID: J/YgjDPFTa2ABtFxwr7oZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89952"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="89952"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 02:52:47 -0700
X-CSE-ConnectionGUID: Ku5rNekcT1aShFhR2SazZw==
X-CSE-MsgGUID: t/VVGTX8QBKK97tsqb81eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="170758"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 02:52:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 02:52:46 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 02:52:46 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.55) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 02:52:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CAr9keehL5rAioFapa8yisw9KGjtithRslKTY5CUO3gndk95dzze8pYc29h3sAPVI4w/MsGuYSvvgESGyDpPhdABFusV0QW7YUzDUD9iI6vWnzCNqs50Gc3GcmMbcmeq4dxO9Em//4WOZpj/ua2r/vZs4805jvyb/uWGuLthTfxh5K+WYj4raNNkPwhwUGOnE1icnPlQA6idSFa47bk5kM/Vqd/TIEXu+oN5Wl9YZjiUaspAM2jXBAEbQwUMftzl/iDz/krhxyDBSmIisSi9bShsmUx516Y1A8SBUDHzMfaTv7YsTLtYQxdZvOZSwrW0bYspuAsK5sApVtcfUOUyZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QcEW0e17D72C6qpVLTtHVs9RB4UeFbslUA3QcsL4fA=;
 b=d7fuq/MTnX+9/RAkC5vqiFVRQztfUtUPBomVvoVwb4PGrkhSfa9jCbHntjG7/RDoXLmD7n8BW2Bi50pQzTy3FRVxjYXmWe4AfI/205+e+2drv5qrB4AMfOLV2RIRAukfAERBHfA1aOSY6ope705o07SwIcBrXed2wZGG6xd3h0kY6KBUpKQsPJfc0Ip0PnZCw6jUkX8a41GyAr7VRIeKguuRjWuoTPBOpe/a3i/KvNsudVoJJBkXkipUK2QORCpy/4xx7ZNjmciYQ8jw4No+DzYAGonuNN4LCfe1BSBe6h7ctMLlyFnnpXB0B/MuUVdbKLcTcMJt+xJyjtcmU+OqxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH8PR11MB7118.namprd11.prod.outlook.com (2603:10b6:510:216::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 09:52:40 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 09:52:40 +0000
Date: Fri, 11 Sep 2026 10:52:35 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v2 63/68] rib: remove rte_memcpy include
Message-ID: <aqPPYzId8SQbzEAP@bricha3-mobl1.ger.corp.intel.com>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
 <20260821192646.146382-64-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260821192646.146382-64-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0125.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::17) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH8PR11MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: a7e3d884-6891-4793-bcdf-08df0fea6b1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|10067099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: v95ezlM+cGqzUVdOklvD1gnWnqL1ft3wJKJw/jnXTlX8R6U6pvbxDVTejFjNnYdB0TUu3iZ8UhZdMb9Ii/6wefiBuEHaJSbvp5/LskeeoveiVlExlaQb9wQUkUPR12+OJE2IqRwiuAIMFmsqbvTkhSV1NuOL24Rz6iAjLKUYbE7JVpp+E2PnMOQDAeLLpaacngRKjc6/sDZSs+Gj6D/NR9M6VxpSFrCjGOb0GLI3G4mdWxy8k+lKT364NlNPzdO783FbwLt45Q4NR2Yz7ldq/cAQmEGfj+l8VBzOXqusrGCQtS6ZPrzi1Ra5EbvmobjpHWMquhvkMxvl8XyornjCHMxNEfTs2iP+NyYJHFnFndpT+/KHqWxKtkjIKrwW+h63lx2aNrVnqAKCki1mqXUOxHYaQrH24nOI44Kun/4+ADFE/iN/GjVtSOwpSYf1OfA6anSamc3CDwT5fAFdtCNv5gd3EHTZKdh/pRXHTGZvWdEkkaxr920LgRUNI+X5xKzpj6cphmrpqX2AH4qKbrOyAMeo4rXjs8/glhy6/RSfdGhe7p321VvXMhc6XAU8CmhEqS3/1NykDjQMRlL5EK3W2dvzVCiJ5rHBG2Kj5DDJMArEyoTPlFTeiiPWveJpgt7S4smn3fFa3Ve3QZT5uNwnFOSYVfl9YEpTX03Wk6sWa1E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(10067099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tHqdBh6Dk0p2sYvFpzzcM9lbnX5ltU6uT6EXqkWOjW1Npl4m5RKZgSMeZW73?=
 =?us-ascii?Q?Q6qytvb8H2jxWgG3jpxRN07xOs7VXpCeewYfShSJrJk/T6eawmIjte03po3V?=
 =?us-ascii?Q?IvdLctFR1CoRKkB7vRIGRpno+lBk+4OFLtTiFWrq/ATOj0AQM1d8lj0o1/SB?=
 =?us-ascii?Q?5Yy7cMr/wqzrtjVCQj0hN7sDEMDq5Q6RiyhdFJZymvf12A1sj8ZM7qCte2Y0?=
 =?us-ascii?Q?ci52IVs9y94um/plGQ60Cg9zCB5/0WoloCrWEJHN3hK3lyW9ChavJfJEGvE6?=
 =?us-ascii?Q?O+ffBCwIFMdrUMLwrxnncYMJvTDR4bddO6niCeyBOsGfAEknIu0cf/Yvxjud?=
 =?us-ascii?Q?PkANaxK6go61xg7S5F4rXgJHZh+S7oHeqAbK1rtKuqIg+ww1TnfLpXGpX6or?=
 =?us-ascii?Q?mB0rmy+rUtm+D4j1CebbzYCEd5a/ITEz4FnjHbOo4JpLlQCTusU9VnD8X8Qx?=
 =?us-ascii?Q?PIFhhNUb/kcFxTX3AcGc8G+Fb3HrSTj38qs7jX6MDyj0+fehKJuHY2nWIPE6?=
 =?us-ascii?Q?EDnZSikGVHgQ74B+tE3NbQeqN+EJMowB7mTIjaRfO8W9HVq8U0nPsI+igpK1?=
 =?us-ascii?Q?tzo99ZEOjFpEg/tCTcV/Zxr1vhl3ZTG5xFoaMGlV1IpZyK9UmF7ULo6HMIeB?=
 =?us-ascii?Q?S/S5HWpuNyRHzJ7vpOkNgi/uq5a5BT+t1Kt88Dbfg7LxoLRPpSDCp4qsf74x?=
 =?us-ascii?Q?zbhjPJVsihc9lfrih2ITkib4nXjLRgZ9gbNgIlxpSy2rkMyxTuIl1bBuCm+k?=
 =?us-ascii?Q?s6eDE8Kg3FFudMuln6BuejCKDJD8dmgmzHAXZUch3jnNjC/MZ3fnAaz5VI5E?=
 =?us-ascii?Q?myRVw/rPsDPk5aqeZAT5L4ZyQqu4H66D+ybUJvCw27pDYqpmoNaYXqo9eLyH?=
 =?us-ascii?Q?ttw7hyFPHpGwPDELEfonewHlS2n3jS1qptYSB0ZLQmVEFfHr16yH21vBy28m?=
 =?us-ascii?Q?byxGig6YJ9ZuYkAM86bsDkCmZs2GbTUrDEx/4GtUh7OAQYaNPlJL7lT1icxG?=
 =?us-ascii?Q?7wFuyC0EvJmukROBlOGy1/UV4Wx88i83ROtCUwBZ6/Q7eON6SOrF2DcNjflw?=
 =?us-ascii?Q?p7mauLQCg4LskzJNvmFGjbo3hcxv32wKxiigGDmMjB7uKoLEF5OxM4Maj613?=
 =?us-ascii?Q?XTIrlMFEHt/4iUIm+L47NuT3FXw9AlsdFhJSoeUwyRpT185FjeF1pHIv+WvH?=
 =?us-ascii?Q?CTVKf1yr6b+rMmI/DR4vH8hCAU8i5AatiAHBypDlHi1jRRQ68fI79Ql9vOS3?=
 =?us-ascii?Q?en5BTCqYkw/my5Cr6WbkiDMRaEaY8ylo5pqvBkwWtZoUIt5OURFvaPlyv6s/?=
 =?us-ascii?Q?KVc7z1I3rRUbPBvB41gbPYeuLn0+N22AjfLJ2/B13krp6yoWku/519QVddii?=
 =?us-ascii?Q?XY5GtMTpcyyUo9HYFzU8c+tih6FDPAHZNqKpPQmnspg6DgpPo/tAh9vXWr+6?=
 =?us-ascii?Q?kjNxCs+IpeLOW44OE2+n2OQSHCpjCsBVonJ3o8n95y+VDyFuogxdi6Q306JL?=
 =?us-ascii?Q?FbgwMq+40C+vi3emj7nqaLj/NbvqeQIKo31IhyWpH/8lpn2rfGl9sgZccB0Z?=
 =?us-ascii?Q?oAA02FMeQIUFFmv17VQKOSW8z7PRvKeeJ1WXkzwdDRJqt2lxvN4kWpVZfQKD?=
 =?us-ascii?Q?rp4/S4JNvvqdHMAgro/wjbeZTxY7nZMpog6Xzg1dx1jq2PhS2jNtF5Uf/MyC?=
 =?us-ascii?Q?glSMeCq1e4yFFPpWWR+QPsvs4Ur0tUYWNutlJ8tXsdqUHXJlpdDkTPmdOGpF?=
 =?us-ascii?Q?vwQZVB5JGUUPJRVdxXccRIQY8icMU+k=3D?=
X-Exchange-RoutingPolicyChecked: oyP8vgRVOoj6KwNyIS3xMQugdhL7B59XpLRtlNZ3WI/sofDDgwAj5DZdrcimvDdOAWNcE6rPEabNtwHAmlNc8KypcIoI+28vHQfiL3McJCiuFQuEY0h06hBhPC0VycK7G4dPd/k/7zcds1wUEdvuFzE3vhwMtz6msFl0f/Tjt4D42EaRSr1zjl3bb2nLpYthiI6qqyresAX9XTDkDVE1Vf63o3BfSh4pCCmp9f2rHOZ5XvGHQtMQP4ZrIVCddtfsTcifH09pij9BCuXQZGx4CDtJ00U0He+z3i6QEPqSzRhnqA7hkvjr4KFVp14jNPxYPklXDS+EEUs3jZR3E4R6Ew==
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e3d884-6891-4793-bcdf-08df0fea6b1d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 09:52:40.5309 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fZKSaMhObXY7zAVwGOGZyR8kV2NAofsoTa3yPRbBQwxmTOwQzeAKdAOxmC/J3gjvP4dTgCZijMcxguzHdTOWiB7vTBj2L8etP65Ml2tLlHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7118
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

On Fri, Aug 21, 2026 at 12:24:58PM -0700, Stephen Hemminger wrote:
> The rte_memcpy function is no longer used in this library.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/rib/rte_rib6.h | 1 -
>  1 file changed, 1 deletion(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

> diff --git a/lib/rib/rte_rib6.h b/lib/rib/rte_rib6.h
> index e3fb464ae6..2e554579d1 100644
> --- a/lib/rib/rte_rib6.h
> +++ b/lib/rib/rte_rib6.h
> @@ -14,7 +14,6 @@
>   * Level compressed tree implementation for IPv6 Longest Prefix Match
>   */
>  
> -#include <rte_memcpy.h>
>  #include <rte_ip6.h>
>  
>  #ifdef __cplusplus
> -- 
> 2.53.0
> 
