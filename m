Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FC0C3600B
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Mar 2025 11:27:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A2FC4065A;
	Mon, 31 Mar 2025 13:27:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 303E840650
 for <dev@dpdk.org>; Mon, 31 Mar 2025 13:26:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743420419; x=1774956419;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=quqJ6McGHxrj0qmLrjV7G/1tMdLBXw29dEkqpD5ffPQ=;
 b=U+6vj/f+rXBDEKsLlK7aVJtfQDddr+E/m27pDEpC4lZKImt1GbLx/nLW
 UsSUZDhRBI5k6FbqTIyh8WhQ+WkMD+2Q4PoJhLC4NTmaO8Luy5V36z//U
 RwJBDKSywX3j0av48/NBV5pdj4GeWom9y/gFczHnyeStXrEHN89GoqMMh
 jT9FVfDJRF+tsx04VOCi3HtoPAmz0DxeXXMWvWnPxkCjbO5j6/MEgGO3U
 B3B4hI1DV1Zjhjoj0kdLFiFS4DFq4Yt3oxn3LWR1CCMin2boSPZZRAbO6
 t7PPdG0XuWqhR0//sQHubgP09FaroEqnWZ8YNIxb1u1zR03hxE4kxOdJB Q==;
X-CSE-ConnectionGUID: VxaKB6NYSwaU/trQOn+zXw==
X-CSE-MsgGUID: 0DNWzA8ZTP2wOrICamrlmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11389"; a="48575667"
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; d="scan'208";a="48575667"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2025 04:26:58 -0700
X-CSE-ConnectionGUID: ix6x/mHIRFahMq5DlmepTg==
X-CSE-MsgGUID: dki4JbumRTmxeBXc4yuP0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; d="scan'208";a="131286411"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2025 04:26:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 31 Mar 2025 04:26:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 31 Mar 2025 04:26:57 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 31 Mar 2025 04:26:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNvTY2npYBUpTeb8+DZnASiABHLZjAEFOBw1cQ/OVDMdqtFGrJ175+rmRGexB3cDCVSxgVwBUW6PVoqeJIQoaV6IQQmKUwtsT8yTOseZINu5OnbQJrX/ZwoAW/l9MaomdcTCQ5ui+vUFzP3KfV/NwYfkj5qM5tj91lAdSuj8qzcvnGXkYUn0SUiZ6+g61buiF5BblMAG8+zO1PKT2TEa91MgHRaXVcnwGhKH+AoJzukuOZaXFgBnwfC0ovInrMiAXqqtzZQRUUx077AMfqxB3tFnsxes+RcmxuvAdWyKgScjH3vbMqCALVeZG36/2F4R9HSUzLyPU0V3plk6jifufQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ly3Xqr8ufZT230p66BesR4ZaYrAHq+ZsGol3RI9fNms=;
 b=hlrEx4bauWRroF7lDB/IZLPO8gxK9RC/19bKpvgYkNbuVSTT3RPllgAv7iWGsc0iSXOrRwPFPrCT1a0KWcoFSbm6Ev77r/NwNjfVPav1s0zna+c5LmWq9izw6+1j2/wplru3CcFew2nGK4zGXBLMRlv76zPqoB2QXFfI6a/jF8MJjHAISZr5orAdaZbVGgwF3oLwsNNO9Z9R+p1sz8MF/PJfd+OdXLoEqcq05K/naTvwVBChOQkwpLoW88wjVgu4OZomgxEXPEcFsw5IBOpRrXA8Xkyncuc3cQrPLu2kPq6YRZfc3MtWZaTfEl5BL0N/JaTUTVa9K3JnUqHZuSaQdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB7484.namprd11.prod.outlook.com (2603:10b6:8:14c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 11:26:55 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.043; Mon, 31 Mar 2025
 11:26:55 +0000
Date: Mon, 31 Mar 2025 12:26:48 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
CC: <dev@dpdk.org>, <pravin.pathak@intel.com>
Subject: Re: [PATCH v2] event/dlb2: consolidate AVX512 and SSE changes
Message-ID: <Z-p7-Jb7E97_TWFz@bricha3-mobl1.ger.corp.intel.com>
References: <20250328110044.2458497-1-tirthendu.sarkar@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250328110044.2458497-1-tirthendu.sarkar@intel.com>
X-ClientProxiedBy: DUZP191CA0063.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::7) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: ed43a593-be5e-4985-5437-08dd7046f100
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Qr4wr3ynYoP5m+BDQ09DB8hKxM8GXQZWRTqaXif4thC1zlgbxwR4+bg8TVYh?=
 =?us-ascii?Q?GU2eX4snqOmaeE9Jq4k42g2+ehfaSXptU2t6RTDQwTZYR4mL7O+89DdvNv8X?=
 =?us-ascii?Q?HDKzGZxmHX4Fpm+/MshP/huO2IESW4wr8/AmKOWSX8PlloDwUZ/lLfTxbyK0?=
 =?us-ascii?Q?xqp9vf88I+5PCDCYBxXcweulF8Q2L/I7II8TlW2snXIHC55DTiOBkrK1urDQ?=
 =?us-ascii?Q?ZA84OWGLscpE0DNFfWqd6uRVYdP396T0G5e5bWvYk7Pbd5N/gcIFhJR1YX5T?=
 =?us-ascii?Q?IEHw9dWOD9WsY8t/jdjUF+ELpiCeTMXZsz4th0ShhD8eBBfD5bLJ0/lmxAT3?=
 =?us-ascii?Q?LKi6j34FoaHKHeCUrhrnRKp8JzArKqrHAEKrh0oNsDI0FARSrmG4TXmfRtKV?=
 =?us-ascii?Q?eKCXrNfbctH3ydxda7FSxKVhHCjS3DnYENGP7C0qsg49n3iyttGePgZvqI8z?=
 =?us-ascii?Q?HxG4hEqE8CcXTOt7mbgJdKaYQLeKYzIr6qRHFrJk5VHNx+rCFzJeaD74otPT?=
 =?us-ascii?Q?v925KtxS5Jx5dh6qucrjUP+t/AB7bx8p1AkGo2HFOx+uRYMei1H6qxbcliTa?=
 =?us-ascii?Q?pstN+WFoafvJSinoKlB+fGZvn6TcHE2/hgX6tvHEBNOQwE3GGwY/zwUKwNlP?=
 =?us-ascii?Q?m4VYsYqt3zyzbpxZTrdLCQz+bXAJO6oBPt4tx1Fz3rcXSlNohIT2v3908elf?=
 =?us-ascii?Q?E4HkLnKy1ftW/XZbtMwb5yLVSln/Ksq29u6mnX2IILZ173bm7wSD142ViwZT?=
 =?us-ascii?Q?z55FNYFhzsUgpALUe9ZCL7n4uRMLQWM9XZx//m2HiSgqI6XaG3MSO+Nq1XlB?=
 =?us-ascii?Q?g1mtN8iZK/JKI1nDi7aUdIQgLF3ek+NDQWBH03S4khhsYCrMhRHi/8BZz2tA?=
 =?us-ascii?Q?ciowYXWR2bruw8qH3ZCk6XAjY6Qqx8z1R/0G7Jx28GBVsIjZxmVq5rO2yZFJ?=
 =?us-ascii?Q?XG/2wN0GAvc3WJWreljHHXQ1osTurLPRFOidWA1ZXBpvCP+J27P7Av82c/Lq?=
 =?us-ascii?Q?pL2RdSLVFOH37eBqxL13sQF/aOwu1fXIFeOsZ3LtccqI70qK7sZMd+DHJG3V?=
 =?us-ascii?Q?Yu2jIbSpW3cK/fkpdCX/mgzb6xTrrnhPStyX/PioiBTGfLZmyXMXyhM95qmR?=
 =?us-ascii?Q?HLPb7UscgT0l0Ne224rCOlWIPQbfKV8WitZdhRBYIMz1M9/w8L7a7Blgef5b?=
 =?us-ascii?Q?DruQdlnMdEhmEYkRB1zvLo3889FZ0sWHMQmVXcJRmeI2WvxqygDzkJ/aA2Sm?=
 =?us-ascii?Q?Vj/7uU0IQQq+E+ewu23nbm7m9dnKm5I5xj0yqWeecxf507gvV/ex9xDY6ycS?=
 =?us-ascii?Q?Ut6NyOWFBMC99SpSnTfmO/U44VObwgcMw+xoE42p00hobcd/FLaIh7nNQjob?=
 =?us-ascii?Q?N+9H5bml04bm8ZwMNupNCYoZtPsgAra4XgNpWIFWA9qSzXm7vwaVYNAf9T7u?=
 =?us-ascii?Q?rQQCQiU3L3o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/KqR7Flkb7y6HkWoAVJMnKDhw4AYkgLt/hPsppM/r70xKP7UZBX4x0/QYAso?=
 =?us-ascii?Q?9aBvSfLF41lP0Xcc9MDPuxyBluvxVrZdilbh7v3IHNiuMKYiDpMUfiFG2QMu?=
 =?us-ascii?Q?RLgDCrd/Q/onThMq5SiGLZEdX+b+GBFQQvkkE+1kP1Wlt8F5WIRLpKd3TSNP?=
 =?us-ascii?Q?bb6XOLhj7jnTYz3kq3GcAoScwKdKW61Lzp7TbwiqKaPJooyxsbLn/iQGw6mz?=
 =?us-ascii?Q?xJu51GGZ8J7M+4KnuAHiI1tBtnYF5qq7alALreXvgOSjzp/+bS4jEaI5g434?=
 =?us-ascii?Q?S4I+sPgHkINVq7oECuZgdcPDeChBbTOWNYNYaU6LxTKlbvVThZ+FSv/+Xnwb?=
 =?us-ascii?Q?0H9v+c2dTz2kSWCDTssO+boQT1Gu+UYoLaf+0v7btpn57VO3vpvX3TDniKpv?=
 =?us-ascii?Q?OJgdRBCZ7LEp3kV//4XN1LLSLX/cDFWnZlNfKqGW3Imoms6LTAb5McB3vEP2?=
 =?us-ascii?Q?gbgCu6OipEA9Zz4Sh2a92z8c9bg8orSsv4/Mlal8bGT0yiE62kCiNnKNWbuv?=
 =?us-ascii?Q?FL4AzazR9gF/1dAk/Y+khwU9iXshdTtlLiIiunI+4pBJ2MVKlENvRDB5Yarv?=
 =?us-ascii?Q?fZWkHnMziDyJtSP767D2/Ao63uhdZyjaayW8mKRWidbFt9bj4MmA2bYiobJ+?=
 =?us-ascii?Q?6Ad612Ldyuu76FzORPiyZSdua7h9MT8xOj9IfGD+mu1UVJCs2vkLcI4cmi8O?=
 =?us-ascii?Q?kJKE4MkJ1A2gViJP06GnIlE89bwBWzKM8TQG8u7hMgVgjlEt2/sNZWypwr94?=
 =?us-ascii?Q?fp8YKmWyuMTCZ/psxI/rkmxx1ePWkav1fJjRQu3qvsdxtWN0Tp4vCkaAaoDq?=
 =?us-ascii?Q?HIF1YnvcvbSBlzgghybRpH+s/HjLH7OZNO5ev5wgqDZiQUMI1F2eL8SPiQb9?=
 =?us-ascii?Q?ulxtJYKWIpx2V3A5XNx8LOLqXUMoW+O7HPTuAymYmsuNS51YM4OxkhSlALlr?=
 =?us-ascii?Q?Iu4Q39fSjLCmmWpZoB00iPV3UC2DEs2UD8fqXzlsT8sbHpvJ6syG+FFWxA0u?=
 =?us-ascii?Q?Op0Q7By06ef77+Nsd+z9BCjEE6LkquOPDqHqAnwme1yQRLgMr/qGbissgfNs?=
 =?us-ascii?Q?0vcFuAVjOQ2wYIrERh2uom+2uHGptlD2ZeUvNchD56JLIdI7VXUbjAdyU9Di?=
 =?us-ascii?Q?qYi0Xs9m1WFse0VFVBcGnSkmQLnu2V7x9bAMp8ZOfSbajzAEWnpfiDWfd53w?=
 =?us-ascii?Q?LGDYu75IwobJf+1tFHIdx905iU/B9NoOjA2BwUUDXdJ4gOAtr2pqaLwHvbhk?=
 =?us-ascii?Q?s/LmKy05aRQoGeS8K2NLDRP+4ZhO43ObuZv66hD23R5irlVHuP46YZREoxPC?=
 =?us-ascii?Q?gISCihJzAE3fWeKxXb5cWD9o9McBw+WaphrbFb2XPGsl03E6cJEVWQbK6Jo/?=
 =?us-ascii?Q?/QSd2L8LeMT+tIE/gQNoyZrzOq7fslt0yvAM76EbZr1ChiN3Hmiqd9oVOqNB?=
 =?us-ascii?Q?oBj99riamZwibBvHhqHWfZ1foWxfLDLK7tnkTxJsMyAUPuyWhlD2YnzurBGl?=
 =?us-ascii?Q?dEtb2p953ooPNoY6QiStMcAG/YTsdLGJ2QA60UelD0mXovGs/fluUhM7LhAU?=
 =?us-ascii?Q?6BrUUAyKkABF+ClGyMgshaLxMS88g/q3e6OznJvzW+73NspYk3noRqF41g5k?=
 =?us-ascii?Q?Bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed43a593-be5e-4985-5437-08dd7046f100
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 11:26:55.2537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HPJZmpfxn2nv+Uh0YMKC5MnkD52dDUfGLyZHFBx9L9IlSBsI1upVAfJrZnVcl8bpwU8aySV7qPcgPU/422yEbscyopA1nQs2Bs8326HYV7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7484
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

On Fri, Mar 28, 2025 at 06:00:44AM -0500, Tirthendu Sarkar wrote:
> Streamline code for AVX512 and SSE by consolidating the common code and
> adding runtime check for selecting appropriate path based on CPU
> capability.
> 
> Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
> ---
> v2:
>  - Addressed review comments [Bruce Richardson]

Tested that we can still get the function pointer set to the AVX-512 path
in a generic build.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Some additional feedback inline below. Probably want to do a v3 to fix some
of them.


> 
>  drivers/event/dlb2/dlb2.c        | 199 ++++++++++++++++++++-
>  drivers/event/dlb2/dlb2_avx512.c | 298 ++++---------------------------
>  drivers/event/dlb2/dlb2_priv.h   |   9 +-
>  drivers/event/dlb2/dlb2_sse.c    | 210 +---------------------
>  4 files changed, 241 insertions(+), 475 deletions(-)
> 
> diff --git a/drivers/event/dlb2/dlb2.c b/drivers/event/dlb2/dlb2.c
> index 934fcafcfe..4c0b4686a4 100644
> --- a/drivers/event/dlb2/dlb2.c
> +++ b/drivers/event/dlb2/dlb2.c
> @@ -90,6 +90,9 @@ static struct rte_event_dev_info evdev_dlb2_default_info = {
>  struct process_local_port_data
>  dlb2_port[DLB2_MAX_NUM_PORTS_ALL][DLB2_NUM_PORT_TYPES];
>  
> +static void
> +(*dlb2_build_qes)(struct dlb2_enqueue_qe *qe, const struct rte_event ev[], __m128i sse_qe[]);
> +
>  static void
>  dlb2_free_qe_mem(struct dlb2_port *qm_port)
>  {
> @@ -2069,9 +2072,9 @@ dlb2_eventdev_port_setup(struct rte_eventdev *dev,
>  
>  	if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512VL) &&
>  	    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_512)
> -		ev_port->qm_port.use_avx512 = true;
> +		dlb2_build_qes = dlb2_build_qes_avx512;
>  	else
> -		ev_port->qm_port.use_avx512 = false;
> +		dlb2_build_qes = dlb2_build_qes_sse;
>  
>  	return 0;
>  }
> @@ -2669,6 +2672,21 @@ dlb2_eventdev_start(struct rte_eventdev *dev)
>  	return 0;
>  }
>  
> +static uint8_t cmd_byte_map[DLB2_NUM_PORT_TYPES][DLB2_NUM_HW_SCHED_TYPES] = {
> +	{
> +		/* Load-balanced cmd bytes */
> +		[RTE_EVENT_OP_NEW] = DLB2_NEW_CMD_BYTE,
> +		[RTE_EVENT_OP_FORWARD] = DLB2_FWD_CMD_BYTE,
> +		[RTE_EVENT_OP_RELEASE] = DLB2_COMP_CMD_BYTE,
> +	},
> +	{
> +		/* Directed cmd bytes */
> +		[RTE_EVENT_OP_NEW] = DLB2_NEW_CMD_BYTE,
> +		[RTE_EVENT_OP_FORWARD] = DLB2_NEW_CMD_BYTE,
> +		[RTE_EVENT_OP_RELEASE] = DLB2_NOOP_CMD_BYTE,
> +	},
> +};

Minor nit, but this seems in a strange position in the file, being a
global. As far as I can see, it's only used by the one function -
dlb2_event_build_hcws() - so maybe make it a static local variable there.

> +
>  static inline uint32_t
>  dlb2_port_credits_get(struct dlb2_port *qm_port,
>  		      enum dlb2_hw_queue_types type)
> @@ -2887,6 +2905,183 @@ dlb2_construct_token_pop_qe(struct dlb2_port *qm_port, int idx)
>  	qm_port->owed_tokens = 0;
>  }
>  
> +static inline void
> +dlb2_event_build_hcws(struct dlb2_port *qm_port,
> +		      const struct rte_event ev[],
> +		      int num,
> +		      uint8_t *sched_type,
> +		      uint8_t *queue_id)
> +{

<snip>

> --- a/drivers/event/dlb2/dlb2_sse.c
> +++ b/drivers/event/dlb2/dlb2_sse.c
> @@ -2,172 +2,15 @@
>   * Copyright(c) 2022 Intel Corporation
>   */
>  
> -#include <stdint.h>
> -#include <stdbool.h>
> -
> -#ifndef CC_AVX512_SUPPORT
> -
>  #include "dlb2_priv.h"
> -#include "dlb2_iface.h"
> -#include "dlb2_inline_fns.h"
> -
>  /*
>   * This source file is only used when the compiler on the build machine
>   * does not support AVX512VL.
>   */

This comment needs updating. It's now used when the runtime platform
doesn't support AVX512.

>  
> -static uint8_t cmd_byte_map[DLB2_NUM_PORT_TYPES][DLB2_NUM_HW_SCHED_TYPES] = {
> -	{
> -		/* Load-balanced cmd bytes */
> -		[RTE_EVENT_OP_NEW] = DLB2_NEW_CMD_BYTE,
> -		[RTE_EVENT_OP_FORWARD] = DLB2_FWD_CMD_BYTE,
> -		[RTE_EVENT_OP_RELEASE] = DLB2_COMP_CMD_BYTE,
> -	},
> -	{
> -		/* Directed cmd bytes */
> -		[RTE_EVENT_OP_NEW] = DLB2_NEW_CMD_BYTE,
> -		[RTE_EVENT_OP_FORWARD] = DLB2_NEW_CMD_BYTE,
> -		[RTE_EVENT_OP_RELEASE] = DLB2_NOOP_CMD_BYTE,
> -	},
> -};

<snip>

> +		_mm_storel_epi64((__m128i *)&qe[0].u.opaque_data, sse_qe[0]);
> +		_mm_storeh_pd((double *)&qe[1].u.opaque_data, (__m128d)sse_qe[0]);
> +		_mm_storel_epi64((__m128i *)&qe[2].u.opaque_data, sse_qe[1]);
> +		_mm_storeh_pd((double *)&qe[3].u.opaque_data, (__m128d)sse_qe[1]);
>  
>  		qe[0].data = ev[0].u64;
>  		qe[1].data = ev[1].u64;
>  		qe[2].data = ev[2].u64;
>  		qe[3].data = ev[3].u64;

While I'm not reviewing in detail the SSE/AVX512 code, since this patch
just seems to be moving the code around rather than writing it new, the
approach for building the 4 QEs seems a little strange, in that you do a
lot of work packing the data for 4 QEs into two SSE registers only to then
go unpacking them again. This leads to extra complexity having to document
in comments exactly how things are packed  Why not just build the metadata
for each QE directly into a single SSE register directly without packing?

/Bruce
