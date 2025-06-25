Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B2BC7115C
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 10:48:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F0054060A;
	Wed, 25 Jun 2025 12:48:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 61F57402B1
 for <dev@dpdk.org>; Wed, 25 Jun 2025 12:48:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750848484; x=1782384484;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=XR6hWxwq/89j1pHnb25/n/oDUG8sn9e/e7T4dWhI4ks=;
 b=SzF4nFB5ev1vXZ1saS3kDml1yvnU+mMNl1ueHC/8doFiCSg0Zb6al5a2
 cFsjGBwV25dIBHig9jnnypuCxqx/izqYT1cvpbXzTVNxvP/TfbTUt1oEO
 7eHEc4k0nQgeuoMO6/gyN/7ktM+gfnVOJ9YiL/MbV+Y/iyW/lGJqlWAbM
 viwJX7HJQVQX27BjbbPBPdt48HQrbie6SwJNA4UOCiw2AeMWLG2w07i6a
 SkDYuTcaxnJAe+Ed70yqwjiipazCdQeDkEl/Xp/yA1ADZ8TwvTCAWkrO/
 OMfN4CJdwvbpisBapUjEH6sc1kp+Ggefy2kvTU6OvCaOkWFtt8fNa0G4I A==;
X-CSE-ConnectionGUID: 9nWLr2mESce6pmF5AQ10Og==
X-CSE-MsgGUID: 034GclQ+SECzMFDvMAA8xA==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="52227588"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; d="scan'208";a="52227588"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2025 03:48:03 -0700
X-CSE-ConnectionGUID: XVXLPATCS0e6hwC4z5T/ow==
X-CSE-MsgGUID: gQHWQ4JERX+eH0iQaZNyBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; d="scan'208";a="183215912"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2025 03:48:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 03:48:02 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 25 Jun 2025 03:48:02 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.82)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 03:48:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=amEnwRY3xxrtN/tWDE1L2MBZ1+/IFW8lWzQfjNLSiytwMoicTd6jSm967TfGi058aij8RtZjUUUHDXpAlBd0sUc9BXIy7vE9+Ep5yjc+9ZlWJDGbWiHNk7tb80ShCG4olA8dOoKbFvoEOxS0OkM5L13AKmryAvEebWd3qTyayEfGq376WTJs1NDQ7FQQH4J/eR8HcNjfLL3URGdYPFUhzYHHg/js8upzACvrrv9T3ZdeT0Lcz1Eib1SYhRspibt7sF/5rEfy5pxHAXCq0r/jFoGcmnghPPni1FHKveAg29F6dvNgU67k3EJu6GsFX9ucwWlsbe/ZuVKYmiOkwelc5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yvCwMwLxVxUYvy4UuYSZxA2urIaeGarwW22gqnQJxA=;
 b=y9Zrju5Btf8A91jNeL7A1qsgN65FzQI/EOB4rVCrmhEjed0db2POLcZeIi0tM/2hTgINwJ5TGALWfVSPib/Xr6V8udicXp+M6Wg2/oYayPNNJpEVwbV/f31TzDko8D2ZGCgHWIctvt4mp14rSYmoVuCfJhmXpEqM/0IKqTBoM2Andht+7gUta9T62s5tQ+LB00FfTIoZHECP00DAEaPdM2M2DPRojS27S6OZnK5sQyk3ADaNtak/FeVkrZaMIrJU/YZJRGXljuZ93+GvvJJLYqgclbHAmBBS9J2fSKRsei9XWrpU5tilUY5RuJ4ctCwWMpUDogTLK77xX/2PSdmO+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB6016.namprd11.prod.outlook.com (2603:10b6:8:75::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 10:47:59 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 10:47:59 +0000
Date: Wed, 25 Jun 2025 11:47:54 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] net/i40e: Fast release optimizations
Message-ID: <aFvT2qlUuS9_Tgcc@bricha3-mobl1.ger.corp.intel.com>
References: <20250624061238.89259-1-mb@smartsharesystems.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250624061238.89259-1-mb@smartsharesystems.com>
X-ClientProxiedBy: DB7PR02CA0021.eurprd02.prod.outlook.com
 (2603:10a6:10:52::34) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB6016:EE_
X-MS-Office365-Filtering-Correlation-Id: 57d9cebb-203a-4c0b-c75d-08ddb3d5c051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?8fj8X7NtaS/piAfGCQOIcYKPDuHQBSz4EuSIx85n+97tSQOSJiSN0GdMcv?=
 =?iso-8859-1?Q?1RUP69fZeP8xM71CouKOfyU/n5v9WE0YE6CBy9+Q30973kHf32SiO59UXW?=
 =?iso-8859-1?Q?PnC7okeccfyhK6vvcdldEQozllFQN0+vH49gDtsHSlcq2geQavOY4h4REZ?=
 =?iso-8859-1?Q?cRiEcRnPZBbG8M7Prt2fl+W3k51i+8KI2RsArX7mwifQtkmBORSiAC2Z18?=
 =?iso-8859-1?Q?UUMMcASyU+4AmzABQomhEO6dwpbaGViAJ8OPpZbuQPHh+x6YjPjuJT3XOa?=
 =?iso-8859-1?Q?uM4DL8aQiW/BG3gAUmngKc8xH4wZLXRzhYr5H1L9DpsDT6p0zlAaXUGwmU?=
 =?iso-8859-1?Q?ioIsqghlW+RS8BOGnG3OJ4XF2TfJlJaxTxiE21BmykmofOX4apWMTzoVP4?=
 =?iso-8859-1?Q?EEp1ZBG73XXayRl5p9OL4AebhpzxSe/8dU+1W37SG7B3bbnoptd68BXUgc?=
 =?iso-8859-1?Q?bhD+fiGz1nkzJvHpZ1kltJYQaJoDSMbo5tECkKmJyiO6OJ/OqJPKhzGB/A?=
 =?iso-8859-1?Q?YZhisr+V5Ycfd1gOBk6f5NjXmojJuc4Jnyj3HkWK3vjmrofNnwQntGyR9U?=
 =?iso-8859-1?Q?/ciCxLRUnncI1NCA7HT3P2kN9TCwvy1cpB8slZMow5p024khA2Uh6xh9CG?=
 =?iso-8859-1?Q?Inst5KDbvMtIeltzUaMQwMUYds8J2KlKhZ/OUhYmw/CRflLKnyla2s6XsD?=
 =?iso-8859-1?Q?mEJkjnzcgjuIh2NIfLjwZEuGq/i5hTovpMKxpM+NFnZlh5VD9KFMvF8Vi9?=
 =?iso-8859-1?Q?6YfaPamT2Gjku+F77L0dHSAX6q1L9LdHKuteYerCakdDOpoiaY9t5tB6QD?=
 =?iso-8859-1?Q?3Ee3QI+vln3Hbi2dNjijMrDb173tINgf0qqwMD/iIueQv0Sx8rdzzm9L5E?=
 =?iso-8859-1?Q?dwBEZK+jrGfWZQnrBwiBFyNKMiGyTjqDg1HtRml02U4hviVxljKn5Rsf7Q?=
 =?iso-8859-1?Q?j2aUQqpwiEWYd2wBcIjEuQ2w4wxmRMtwbtkCgyT50R49r5mw4sh7z/Beng?=
 =?iso-8859-1?Q?+oRRwgMQlHFMb3OPvQH0lu0HtYHHC8VIdgeUXDDw4b/iIGRcKVsJWtxFXu?=
 =?iso-8859-1?Q?TQ0XrMop0wRoQNUs+aNjHveOvsY7SMApXGV0y65W9EoSpXz0v6xMrzEBOz?=
 =?iso-8859-1?Q?XWVcAECmthMcc/+Va1omYh/heJFf+QhfqYSfdJ+tV4gWB7w6qFYlZdtPjB?=
 =?iso-8859-1?Q?7xPagK0cjvh0LIepFN62cOZfPw+LLSmzUezxVrAayvom3p18vAqm89nmq8?=
 =?iso-8859-1?Q?4bpg6R3UqPQhH1WOFJSpNTypmP/I1syBcSI/SmVnrXI6ib7TtbgjWRhtyO?=
 =?iso-8859-1?Q?zTMmIhV7YQjhiG2mhUihAtJBaotPsfmS+JQHtRfuY05PRh1XqhdO6KObrD?=
 =?iso-8859-1?Q?1pbBgqhfUSDYVtINgzFscKnF7GBzQZVtbV7UHA1ECG3/ZEsW+eaLUODAk/?=
 =?iso-8859-1?Q?BweigmELI+CNs2NUC9w4S7LGIjfJfJvzzOJBWw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?VZNQ7lqc6Xv2zD8ZR+xLMVzuB4TXGtgJNDdNXs2SRcclYl5UxzYmI6x+kf?=
 =?iso-8859-1?Q?4vopAaCTfxWigCcC3DML3L9cI8WrVOJ7dhqwFjw54Q92ukw1kGgHmIKucw?=
 =?iso-8859-1?Q?Nx9HLlu74PRdIvxbwPFx4HA/fdGbetstqGUHBJBZbqvNGkC5DbIdnn2h5Q?=
 =?iso-8859-1?Q?9szFvXCy/PFV7km/sOMzmCYlc7ViP3/sG+UNGpRfxJP6/RBdigrSCaBbBW?=
 =?iso-8859-1?Q?ij/H0EC7xyrUUPwKSEZEvLMS1AWzJvs4TJ22zK0iqLAC8VCZkL77MU4Zri?=
 =?iso-8859-1?Q?dbIplGBDQW11IKys3MZQZeobxwPHNlulOqybJ1zQgo8jzkEqdhja7TMX+O?=
 =?iso-8859-1?Q?tAcsFoazUbNYhRRcSVfs8cT3ueU+qJ1fqwJVrOnUqmvNQfnt6P3OHrooP7?=
 =?iso-8859-1?Q?AERuoOMc2gaCKRagWBrPqDi0F11IvWwznSVlr59oGuKlexbLBJ7dsSRurR?=
 =?iso-8859-1?Q?DlQ1Q15OcCkzHWdztFowzgsJBV9A7oSclTi10Y0ABXJ+7XqarpPNbJTksk?=
 =?iso-8859-1?Q?lGxNYBMUVtcjOsa3I1u637WxM+koYrro4r85dj0dOv2C8wGx+99FVVOZOV?=
 =?iso-8859-1?Q?sntGenZLbifh3n1E4GNrcnQnlHxmyYNQ0UCi4Dw0r2iDJAHN3LUfAIg5oG?=
 =?iso-8859-1?Q?ILpnYoulb7AEWlgL9sQTVOjK4R2YWf7EiueljVzk3mtxfgsZRtAo7VM0jF?=
 =?iso-8859-1?Q?SZpmA4PI+qaYe2bAWgmIhCmyz3MzVqHKsjXhX+vPDQddC0MGQdk7Qg6wji?=
 =?iso-8859-1?Q?HbJYiFeee+EkadzwOnJVodfeq4rlv1ZxGpyGfC3F38qlH+L1LqlH+a1/kv?=
 =?iso-8859-1?Q?nCXmdVxBNeksh0G+92eKZb1plxUwqKsaFnCuLZMijOOO27y0agjfczgS11?=
 =?iso-8859-1?Q?9Iae2c8XKkVUaSV/Utk8KGR9J1leXL0E7q28YuU+Irili1YS4ZBqpszghY?=
 =?iso-8859-1?Q?A+p5pxMj8HVRVdv9Cer0TmxDWWnQWlDvwVXVkESYxqk/W01yalFwAxQ57u?=
 =?iso-8859-1?Q?zSloW2zuIy1I08VWHJB8i0t55PYSjKU0ibhCtzbPIj7gAoq9XCoJcMeMOY?=
 =?iso-8859-1?Q?tXOJR6XGUzB0A2hFkGgE3Vx/0OPLX286BYk1QzJ3ie7QCszXhz/EDJwh1s?=
 =?iso-8859-1?Q?nm/ZM6PdSNV4a7kYaOK77s7zzsCCEobWkJdtr46LcGRcYWxzKNQAhjELBM?=
 =?iso-8859-1?Q?+kCPAKYOl4iSj+7Or7l6BhuEG/9VwJrySgWmOczvast2vmtWauVRogSaLx?=
 =?iso-8859-1?Q?7LCUI9w3D54Zz+YcXS1ZbZoUHIl/+SDCD7wWqkSIebw/GJ6rGiFU+5tRnH?=
 =?iso-8859-1?Q?4xC0YPSWJ4tB/6sMOvYSY5Ws3gB3FRCOcdt7q/cyLy0iDhfn5+FLf08wD2?=
 =?iso-8859-1?Q?hnUcq9307B1xs0wapLuqqLPZp2wkY++IRuqHX5iKfrfBxRkFVhlu/ZVKYP?=
 =?iso-8859-1?Q?5c/mdzOKQqMa0AX8w1qw1Zplfr7lPNfzMuuZJ+02WH6VQITyoiB6zmIEAg?=
 =?iso-8859-1?Q?dthgTUGiQ8/Yho8JMotR6QpN8OnwxeqSBiuL3cNKwx+luwsnKvYwYLON1W?=
 =?iso-8859-1?Q?/N2LqzwchX+MFByufEzuvdFjRQsizNYEFElIS+c9F+Gj/jKqn6zSXj0PNs?=
 =?iso-8859-1?Q?V8ksP1l9rZQDUFAz3kHWIoiI/CIG5Wmx7Yb3f9FTounYOVqepJ7z3pLw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d9cebb-203a-4c0b-c75d-08ddb3d5c051
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 10:47:59.4358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KE4reIKUyZqJv8vzlcPO+PnYzxXc7u47WuEe3+xvotpCLSnaJ6W57kFq8eybWmyJfALAUHJ+YJjyxjqI56UlfRy6PLMV/FPHa2gd4BOB37w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6016
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

On Tue, Jun 24, 2025 at 06:12:38AM +0000, Morten Brørup wrote:
> When fast releasing mbufs, the mbufs are not accessed, so do not prefetch
> them.
> This saves a mbuf load operation for each fast released TX mbuf.
> 
> When fast release of mbufs is enabled for a TX queue, cache the mbuf
> mempool pointer in the TX queue structure.
> This saves one mbuf load operation for each burst of fast released TX
> mbufs.
> 
> The txep->mbuf pointer is not used after the mbuf has been freed, so do
> not reset the pointer.
> This saves a txep store operation for each TX mbuf freed.
> 
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
> ---
>  drivers/net/intel/common/tx.h                 |  5 +++
>  .../i40e/i40e_recycle_mbufs_vec_common.c      |  4 +-
>  drivers/net/intel/i40e/i40e_rxtx.c            | 39 ++++++++++---------
>  3 files changed, 28 insertions(+), 20 deletions(-)
> 
Thanks, Morten. This optimization probably applies other places in our
drivers too. I'll look at this patch - and where else it can apply - for
25.11, since we are nearing the end of the 25.07 release cycle.

/Bruce
