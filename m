Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1989C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 12:57:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F28840E3E;
	Thu, 15 May 2025 14:57:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 59641402DC
 for <dev@dpdk.org>; Thu, 15 May 2025 14:57:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747313872; x=1778849872;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=gF2jFjzCULezVVdfxAkph8lv7Y3BZ6BxxFb99ADyEFE=;
 b=lhp+ARqxV81wVt4PfUFoqpj9kiTBk6FCqOYKaKmXzemghLDHICvHLLwB
 T3HmwZLaRrdVMEC5zWn8WML63KLUL6qYQxBSHgbHOeBYqFh2A05IdeVz7
 9tFW3WV6zls0VGrt4Lcrv6nntHZB8C68Y5NrGOcaBqlqq9VDjQoGc1FUo
 ldvRAY751ThSvIwsLTMBKIUXBkWbInsHzwLZvvcI+ikYLUumo7Tu6vUVp
 wyU4zQAmWRtHQTAqEYLIRkJC5GfZVM6kQ094Cf02KwcWlOFwK/+shVGq7
 B2PsEiYkH0e+Oo4LzPDh1ov2Z0SgzjQ9V+GryCCXmKXENCMjsUFV3SAUt A==;
X-CSE-ConnectionGUID: 2wYcwEQNTX+dG28A5s74KA==
X-CSE-MsgGUID: DDW0jpwOSD6hQQggmrZ9AA==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="74648974"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="74648974"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 05:57:51 -0700
X-CSE-ConnectionGUID: qbNI7g0TTMmp+brqwcuTpA==
X-CSE-MsgGUID: UeMcNJqPRtS3HNZbGlTEdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="138414451"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 05:57:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 05:57:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 05:57:50 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 05:57:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P25Bu6Vlv3wSMaBo6HPZIrwuVzAtVidfnXayukJWhkUyedsqZ9hTRvOuD0Yn2QKvI0Ai1K6UAEJy5LhqqjvzePc8L5CvPswaEPXNgcBb+m8RvXlOyiytt+Ydsng8ljjIVof+aCMTYCyiscvTX3zjHZYaXZgvlJQ9HtnegG+grPQJYbqhbKmSwlx2ZyR1Dw5ho0hiqwciE++O7gc1uDdOHA8qsVCN6d6z6t5XYQ3EnJkRfLdeh/lPkQS+vmA+4zGq4CZMfNZZEi2DufccFzGGneUzGRULK7vi/e7H3XWgQP1ngnxbW5sKluJQKBKkfI7MR2xhVEbT4T9j5y3grbKskw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XpG5nEKuRuuPkU8zhF416F96pJBmQqFtZH/YyLb5AZQ=;
 b=irARue/UMTt0+aLToiQwB+oraGdHEKbWuUGE1WXZ201/a8bTcgkXm6wVOjIJrfI+iEnljUIdGWNKzEG8deesjDVZGBv6a9Zr/iOrkMGbLxrsOehPrPW/2xw5ZHPopi4R20iS5UkTxumlHuFMDkZXH5OVNd6GRMN7wJyvmizIRPi7QrRdIUzyChR67pCFfH6lhhg0xm9Znc79MVe60nMweu9jdA3IPb4NcNaz97C3lqBdcW3YU4hhlI64beJXW57F1VbubtE9XN+1RcFgUpQM+2iZB7A4lcSI1Mnvxnmj74obxLlSH+PktT35kcNM+bfhxm+jVUogATHMN3OjDkbp4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB6943.namprd11.prod.outlook.com (2603:10b6:806:2bc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 12:57:35 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 12:57:34 +0000
Date: Thu, 15 May 2025 13:57:30 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>, "Ian
 Stokes" <ian.stokes@intel.com>
Subject: Re: [PATCH v3 06/13] net/iavf: use the common Rx queue structure
Message-ID: <aCXkuqkk0eNsV2Iq@bricha3-mobl1.ger.corp.intel.com>
References: <afcd4013458bdb8b970e7ed57d6a1ede0ee654b8.1747054471.git.anatoly.burakov@intel.com>
 <85efadfaf90568018e15c47e810c56b693d4a4cb.1747054471.git.anatoly.burakov@intel.com>
 <aCXJIo34sEid9hC2@bricha3-mobl1.ger.corp.intel.com>
 <6cfc5dfa-a693-4c69-b048-3da1d0169645@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6cfc5dfa-a693-4c69-b048-3da1d0169645@intel.com>
X-ClientProxiedBy: DUZPR01CA0035.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB6943:EE_
X-MS-Office365-Filtering-Correlation-Id: fecbec5d-8d83-4d0d-1ec9-08dd93b00fde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DfGk7uNjVqCK1eL//SrR30KohYFKNeeQ7KrbAqhdUQYDb/psVX5mDnKPyzBi?=
 =?us-ascii?Q?yThh3fa0JTMleZodXEgXrmZpGLKQdEELSaQLAJJ9C2yy3o1rPKmtt/L5j1hn?=
 =?us-ascii?Q?m3o28TroyKgh01jae6ZY6PfApbKGm4Jlv5STQeK3dX59D9JBL4yurj6BUf9m?=
 =?us-ascii?Q?DW0gbN/BGj5pEPcaS+nphrNz6VO00BsubJxfnuNgxNf8hAuYGohQwLps5iYN?=
 =?us-ascii?Q?jPD4bNOe+O9aORc25PjqCrAn9jdsLDwdqDh+cpEGzPDpzlBZQpgAoa6csr19?=
 =?us-ascii?Q?e2ePsGKczen/aOm2PtAMdq/UIyRQaPlX6qVOAz7kxheikg5hfjguSLHWF/pO?=
 =?us-ascii?Q?pxF7v64Or150ywilAUd9AIsxPojqBjWJvm8e3eETGrZeHc1xcxWDPCnjKWXs?=
 =?us-ascii?Q?IerZmCo6X0nhvgp04PKn/VXk4JzyIJiNskKg2OQgw2nmxvHy0JcR+Jv3fXgf?=
 =?us-ascii?Q?FO7VVNjDVMsuqGEkq90VoJUf2FxQaEtkoBmQjmw0yBB7t8OizfvkjHeFNA+w?=
 =?us-ascii?Q?np5H2S6CJfIM1H+63xH6xxbq78+4is20Syi3+1J7aVZOjITyK3qlQYT/+N/J?=
 =?us-ascii?Q?pvL+GS34KXtliSaDnia+xLStyN+lbySZf+5ZHHdEK7y+FjJVQLmTT3kS5M5O?=
 =?us-ascii?Q?DSNeDCOkYuTvA9Eg0qniPHx1EkPbstBvFeDTQ6zlnFyhMYAficOe0X9wrp+g?=
 =?us-ascii?Q?UOilA7ORiH9sItXURYc4T/eZqiYepCQh03u4RedPTD7XxuEtEwK0/l5gwmPW?=
 =?us-ascii?Q?f4LD0HFfkCbpWG8aHB9xmFGMv8zmRTHhFiRctrWnmJrarzA+Th5a0wjvl/sJ?=
 =?us-ascii?Q?v1U9pvHkL+FCKdm8oIfsME7+trahw/RFPSEVVRm1Qw58sso8qfZqvhTXs6PD?=
 =?us-ascii?Q?zb4rgkoQc7z5nWFCIIln+fQpqEJdq9c8UnFv3lJTY8oItc9nAyXa0/GT3DJY?=
 =?us-ascii?Q?hr/qX0TxkGyncyQGHnoNRoqnG9k1/KC4INQJFXsAVL44F+jNDUsDlwgvWiTz?=
 =?us-ascii?Q?ocBqhft4JhJWzjOsyP63hM6X28c0VA+PDrEU98pF2jWS0jVAQ/WGdbKSROf/?=
 =?us-ascii?Q?w4b+IsSwfSnx7FQWR+xFG+OWIu97DC6ciXxwgjnYYQHfkwI4EGXVjXAZ/0So?=
 =?us-ascii?Q?h0PTJWqgXaH8TgJ2natn8hT/QckrJSwZkw4EA/iM8789fcR5dF927RkU71TX?=
 =?us-ascii?Q?qOwt+7i3cy3P9/Mjk04emrIZQllg2ZfflW3Abiu9BbrnKwxqW0zSiZ97do1k?=
 =?us-ascii?Q?soN57Zl6WD7aplO7UUH2BDFxUUatHBam5nqy65iefqiwWG3m/qu2BSttJQU+?=
 =?us-ascii?Q?+LqjPWiv/OJytaqRxUCEh/8y2AGxH/yI1hhNkSpHtWAGTB3eyVfGAZCbRbSG?=
 =?us-ascii?Q?m1Yek5KZToXSMmqG6R8ZXynoC5LYge8EfI3cc1IMvhgTx1PVex2fmp671KKQ?=
 =?us-ascii?Q?CwJwAUKNLZc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+yIa3z+HtDJ/mne3P5WIDqLjYNaonD5SkLJegLZ/Da5GtARctkSC7oK1tCDX?=
 =?us-ascii?Q?33qwt8IoOuMRVPHN4VEDldobnmS0BljZDP8jlTbBWlT4nxbxKqUvj5826s38?=
 =?us-ascii?Q?4RPhQbbPAJNjuY8i3SzKmMHWc0frdu1FVnk49VVolAym+R6QhPftkPj2Mgzo?=
 =?us-ascii?Q?G9KHieBDQhNeqAprCe9H7fVYfT+Y06c/4a7sBEuM9w2ToAb9qcO0v9FpfPIv?=
 =?us-ascii?Q?0C7j2IeNms9qDZj4EKcwMA+s16elOIAAYCRI91B1AiXeYmwlIn5KlUlyejqH?=
 =?us-ascii?Q?mWtTIwI2svXGrJva8FUK8yFA2uTDohdOgyA7wRnhQtPM84jmz0Sc+yLhxDS6?=
 =?us-ascii?Q?vRww5RgjHILm9X11yOVtYfw4bT3qfePS+xiYAQzDH6ye0dbu0u7tViip8wfX?=
 =?us-ascii?Q?0JhTCBD1X++CKiLBOpbZBxrgRcgBVYYZdDtW6BwnJAeoAQ5vjjJyaSHxqV8J?=
 =?us-ascii?Q?7HZjzm95mLI2wRAnv4xo0WMDjp3z0Rn6JVfWF5PTTsmh+/Kcjd/j+Hv51umc?=
 =?us-ascii?Q?K6YRTIEwwiDZvl2zSgNnkGUqUvN8O+TOPRrDMZvKG+sg8PIkkERlXxVGpJX3?=
 =?us-ascii?Q?e1AjNsWN5veHvphPIKKve5GJFCpIc7S4zcJ5HaPDNvV/HkwCnRERd6ezazEo?=
 =?us-ascii?Q?d/SVEFaASlTzmirL1TGFJYe0ApniehKsQwyow9ukv988P/4dCvaPHyenQVbA?=
 =?us-ascii?Q?hnRIW4/bfLHvVxsGwn4Eqm+nn+yIWu2WGPDhJgBMRG7tEcClYrJ+5JF6/K1u?=
 =?us-ascii?Q?3Q7JkWd/deNt8+8nthjIlb6RrHqFA/mXXjUzzJ1dOyvAh4apbaSV9g7A74/u?=
 =?us-ascii?Q?RKqo2iG9/2wGuwC3cFM3IOMsluuQXutuwKf/oxhzZv6agSUh14WLOd+D4FO4?=
 =?us-ascii?Q?BSZtniYiM9baTvwY89SVqm2QnaLGMzDzNPst83wZD+T9ob5KGu9ED57mvIdd?=
 =?us-ascii?Q?yfpd+ldPGxsMFsbdvrYzG3Wk+qePWHyudMNhtHlCaAp5t5yRLDzgTdLvfw+D?=
 =?us-ascii?Q?pfXr94geAh73zRr/3c750NkN6/GbyBD2QyqmAqtunKFOz/wZy3ZA0D5o+yWm?=
 =?us-ascii?Q?WcAj7yuFrwBiI4HxmY9OZUGwHJsvn/jsf0ylB/YS+tBHHLybqc6wlXXV9Q6Y?=
 =?us-ascii?Q?nWZYBerXrNGn9sNhVSeyT5LcioR/jESvFJsnPK2loaZcmAOkaAQgGbDRLE0a?=
 =?us-ascii?Q?vICaU07Qn2ZvruTqveaG6jQnW3HzWGAmyJZhXe+b8bHBS9dzhsCoOg76FsVF?=
 =?us-ascii?Q?VSMfOzTPA1eB+I32kSaMxhHkdviCWfknGNnJpNW5KyxBEzqMZoRSA7sugPG9?=
 =?us-ascii?Q?43XA0xHDmo+8Mvps+phmUheT3iO/3E/11nk9rNj39YnIykBCTLNpG0im++wt?=
 =?us-ascii?Q?cqSeZKqJRED2/yYKSHO4E4VMuIG88vdlahFX9D6jBnbp5Jd5b10xJRtpeayi?=
 =?us-ascii?Q?eAx1TSNRtNTZwAMtvgQ4N5S7ONi7vqtNToiyFk/KlN2r25XozBnVodsZIlUk?=
 =?us-ascii?Q?jSNa08OSJ8nYcGA7Fq46VwkkyNi3pZ4dA8FW7yffqpPx3MXvKcz3x82VbXkY?=
 =?us-ascii?Q?wmZ5XiBSS6nJnmOo0JXCDGDLsxBjLaicGXghxpsJySToDDk5MO0MNwiqE8Jr?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fecbec5d-8d83-4d0d-1ec9-08dd93b00fde
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 12:57:34.8530 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4uSvyKZ78ZjNBOXkxAyXig1DsbzWmDo8CRg2Rz/qB2u/fujKM88rx6MjHP3orwOa9puGGbenqq6C/VQ6ihcNc9UM4oWhzdvUvPxjBZE9gJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6943
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

On Thu, May 15, 2025 at 01:11:03PM +0200, Burakov, Anatoly wrote:
> On 5/15/2025 12:59 PM, Bruce Richardson wrote:
> > On Mon, May 12, 2025 at 01:54:32PM +0100, Anatoly Burakov wrote:
> > > Make the iavf driver use the new common Rx queue structure.
> > > 
> > > Because the iavf driver supports both 16-byte and 32-byte descriptor
> > > formats (controlled by RTE_LIBRTE_IAVF_16BYTE_RX_DESC define), the common
> > > queue structure has to take that into account, so the ring queue structure
> > > will have both, while the actual descriptor format is picked by iavf at
> > > compile time using the above macro. Direct usage of Rx queue structure is
> > > now meant to be replaced with a macro access that takes descriptor size
> > > into account.
> > > 
> > > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > > ---
> > > 
> > > Notes:
> > >      v2:
> > >      - Fix compile issues for Arm
> > > 
> > >   drivers/net/intel/common/rx.h                 |  12 ++
> > >   drivers/net/intel/iavf/iavf.h                 |   4 +-
> > >   drivers/net/intel/iavf/iavf_ethdev.c          |  12 +-
> > >   drivers/net/intel/iavf/iavf_rxtx.c            | 192 +++++++++---------
> > >   drivers/net/intel/iavf/iavf_rxtx.h            |  76 ++-----
> > >   drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   |  24 +--
> > >   drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c |  22 +-
> > >   drivers/net/intel/iavf/iavf_rxtx_vec_common.h |  27 ++-
> > >   drivers/net/intel/iavf/iavf_rxtx_vec_neon.c   |  30 +--
> > >   drivers/net/intel/iavf/iavf_rxtx_vec_sse.c    |  46 ++---
> > >   drivers/net/intel/iavf/iavf_vchnl.c           |   6 +-
> > >   11 files changed, 207 insertions(+), 244 deletions(-)
> > > 
> > > diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
> > > index 9a691971bc..2d9328ae89 100644
> > > --- a/drivers/net/intel/common/rx.h
> > > +++ b/drivers/net/intel/common/rx.h
> > > @@ -38,6 +38,8 @@ struct ci_rx_queue {
> > >   		volatile union i40e_32byte_rx_desc *i40e_rx_32b_ring;
> > >   		volatile union ice_16b_rx_flex_desc *ice_rx_16b_ring;
> > >   		volatile union ice_32b_rx_flex_desc *ice_rx_32b_ring;
> > > +		volatile union iavf_16byte_rx_desc *iavf_rx_16b_ring;
> > > +		volatile union iavf_32byte_rx_desc *iavf_rx_32b_ring;
> > >   	};
> > 
> > Aren't the descriptors used by iavf the same as those used by i40e, and the
> > flex descriptors used by it the same as those used by ice? If so, we should
> > look to merge their definitions.
> > 
> 
> They're coming from base code. We can do that, but I'm not sure how that
> would play with the rest of the driver and compatibility between ethdev
> parts and calling into base code.
> 
Hmmm, for the base code, we could just add a typedef for iavf_rx_desc to
i40e_rx_desc in the osdep.h header.

/Bruce
