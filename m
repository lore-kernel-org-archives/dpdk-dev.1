Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99BCC88E4C
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 09:51:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24BD440269;
	Fri, 11 Sep 2026 11:51:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 824AF40264
 for <dev@dpdk.org>; Fri, 11 Sep 2026 11:51:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789120271; x=1820656271;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=0WWSRzU7bsGL7RLNbdIg031tPAr4S2a0aifdbokHY00=;
 b=IInL5HAzmDs7Ly7Eu/F5WIfye95w33Wnhaa58fSHSOVkH2tU2WxgDZvY
 4AO4lFLQo2UCXhZmPfxmEm4PGu2EmikYa0fY1P2N4hg/jhY12OtC2d4uc
 rvq+SNNxSGFuDi2/g1hY4go/9v8hVmjLCXrSxJQcZypcMvmq36NVs9ZVQ
 59ndJWLyd9swvZlTw9/1Yg3bjjW3XVwpzSqCZdDzVVJ6Z6DiFThCcDEhW
 k1lj532atMnMRv5S6innOXix+qGLEUh/UIrEMG9hU0Nc0yGY7yHCBcg4o
 Iuo4Qj5ba5ybjLINgQ/uYYRqcK14v1KmaRuq2jqcpDetbcctUZbFV3b5F A==;
X-CSE-ConnectionGUID: 6vjknBfNTdiTxPKT/rqHQw==
X-CSE-MsgGUID: 44ToEGr7Tj6ETqOrOCK1bA==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89609990"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="89609990"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 02:51:10 -0700
X-CSE-ConnectionGUID: /4d8Pi8uR2uwKJ+/AN9fNQ==
X-CSE-MsgGUID: NrrhLuO3QT+tf+3WOXiB9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="167816"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 02:51:10 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 02:51:09 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 02:51:09 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.50) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 02:51:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UxX43E9s1wGmWcmerfSdYysh/6QXpSn0K37ms1O755V+QFNbgVLGg8exN+tEh8k+F1BdbBSOH2WdnV+AK8U4dljGGtZfkpP5P8HOL0XFcDCAtmZiVVwLGeoipcjHIvvoKKtE+336PpibEIe06pfwteNttmr5ie1niqhive4PCje6gwS7IAcuA+dS4ls19T5dhbW4e+ebpkVArhy2mwIjOeux33SeDOq8XNuu86TEUiweztqZUVgtVgm7D279kBzzKXY1sZI0wt68Q6i5xEX/cQzejEliOe75yctQpTUTAYpxs4KDBs/DtNtgRARhUhNoVIdOmtO00YW2mZ1+72yT/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXaGNGBpNkk0obghlcFDbdBCI1GnnzTKNs7H2IaqG0A=;
 b=PrvH9i0QGeAdun45upf3LRjWq66JxIe7rJ4fXAcItA6dfFh6NeTFE5w2blEXpJPkLxGcwXGr3HoctSfJG9VLaPFQ056ziLwfuKC/no8nL1tylg6wa2Fp/bnBQADo9ZM2t3Oa9iqpbZalzlvjmA3Tp4kH5FFZgwOYlZTFcDXozmNAQuql4C95sKcfRzjVPzrOioVH6FsyV22nXLL53EkK6kWfQjw7wBmr2fdY9SRxLzyX+0Gm7XbAGBs7AxxIMEjbWhoeQ9AHl9D9YdEUPdrtp4kCXhwqEKznp1zYtLqwjOJiK7iJThw72nsyG0+6DwQVu/51hgVTCmM8X0+HbutFOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by LV2PR11MB261624.namprd11.prod.outlook.com (2603:10b6:408:413::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 09:51:08 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 09:51:07 +0000
Date: Fri, 11 Sep 2026 10:51:03 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 67/68] net/pcap: replace use of rte_memcpy
Message-ID: <aqPPB5QHrLAq636P@bricha3-mobl1.ger.corp.intel.com>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
 <20260821192646.146382-68-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260821192646.146382-68-stephen@networkplumber.org>
X-ClientProxiedBy: DU7P251CA0014.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::17) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|LV2PR11MB261624:EE_
X-MS-Office365-Filtering-Correlation-Id: c8914c5a-6a2c-4691-328e-08df0fea33db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: fzKAVdjcx4w6kbCCXa4i358B8nFD/EiVet8QMLD9xUNfJjsMnL/mirbicPai0NCFWDMkLbhp2TEx7esCBpNhzgr5eOcx7+bzMyvQIZ8BV4v8LYIDOGjdD+lYbajxrdQN0nqrTrAXwqN3GQU1fZQPeDhk/l8o+fN/fJEKfo7SZ5qT8HrMBLaELWsQ8FgLzMEvxUC0/X+RG4j6SM1GbPVwD0/9JKFzE06XPZ0tdJw+pX/rBpX5V++g6SpleaFVjoWSKosCWU7JMAnhjz+GvufpWFqQhsUgycDnl3Rezmd7QDjR5JrUvfka8tu8x3RF7i+fjrpV91fxGQMTZLfxwU3jfFrswXVnHTJpcjfaKVSyMdyjVwZv0ALJ+egmoxaVLsBZRDqGhOh9MLrrAcD6a1sYcwb1w9BUkgr2NUQWQB6mbZaf6IQ8q2kNdu1BHHt4wfmzTcXC7RaVA+g96RAzfhLUWCdLoK0BaZX1MudtRx75zqbnpnM60eM9Q3x5EtG5Q/gykz5iAu8nPaa8IEr9LXtUSw2YycuEEWXRY6ydnp+u0Nvd6drtNpKK0Mgw0XG/uTs2yPsXFQr45KeOc2qDyxTvgw4L/FnIHFbFn8YnYXLe9hHq89GdeNxkYOgO+Yr+F95pbA3rvgcZDs6zkVYBfByIPRRggXmUbyiXARcfYefA7YQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0l/JVDGzlwQrBaiMXdr1oG5Efebs4OI5hdqMvYRsXI7bN36Um3mRwvTb1Eu3?=
 =?us-ascii?Q?FP5rwYTh80L887ryRbNcu/Torfghn8twE+HpePtUICtPyUGJKdyGtRaZ7ADD?=
 =?us-ascii?Q?fwMGYlscUOPn5a5xCtt//vqHRBj5QiA86S9LzSnynLRRBpYjQIeDf6AEnTuL?=
 =?us-ascii?Q?2yMcjCVoMgK7lNBggf/iLqb8spHImRUHmSngRQwu6S7/NwRAxdAgJsZhEwZl?=
 =?us-ascii?Q?yGE/+SEzBTfPo/p5lEhHju8frnv9FXPS3yeNv3pVHjqE9scUbV2NZ2XTjzDU?=
 =?us-ascii?Q?cWU8j7E7rlxjRIddgsksBqlgetKCsGrA/O/5a4lH/SzdimtR3M7+G/FQkBdx?=
 =?us-ascii?Q?2+pT+MDEBsbiCbWH2CtrOBfeTlkX14FIV5QvcUplUNS594+OWv8ZQwyKyqcc?=
 =?us-ascii?Q?ZiwcNz2LavYkNezYrxRbTUNW4gz72++oIeUPseu5+cuCUr5QUpi1DDsmsqC8?=
 =?us-ascii?Q?cQWKzJtzM0uA3xNEErSE2KchxhZTOBrxLkzXKENxCZEfEO6qslPpgxmG2/8q?=
 =?us-ascii?Q?ZIqBdcRcoAwPWZjGObllyu6Ur0WgrJ4o1JESry7BZXkGKLqGrSz0D/4t3HIN?=
 =?us-ascii?Q?7xdTJr4UBWo8BEUK3Elgva7rhCbaLj5jWZ8lTUmovWVaXSDPpSFEl6NhAgZP?=
 =?us-ascii?Q?22U6y1jcQ/V/a50UzqJwN/WwTb1b7pQ5bQtHBY03ng7TCWaqmoAjyQlQRxpk?=
 =?us-ascii?Q?tl4hmk4MEYTShEXJyBkTKZI7sZ/P5sXwT40/YMKKRsMVbk/v2o3X6Uhu549H?=
 =?us-ascii?Q?GgJb2IM4z2TTOPGZBPq05c3zN/KGrlw6WTw80QEjj2cz0ctGTnzI1wCBUtgm?=
 =?us-ascii?Q?U7pfCY+9Q1/CWrBYFY0Wi9ye+Y7tFumPXID296Pq4JCGMcbXA2DXDAcoJiqz?=
 =?us-ascii?Q?bAXDmznDaWnmcu2JT2eUXWvOycSoAudHS4JS5WvTm+yq3hqq401v3cPk3caq?=
 =?us-ascii?Q?/WOIPAQjH7CnCTA7lQnDnjek1WWLOXJYgj5KqF3LG8C7RAKCQGqa6tGrBEYW?=
 =?us-ascii?Q?OLlawAYS/o4xCpQqMqnzuZoFmrQQwRXrCWiswLqp0FeMY+rjbXX6oz7tMzOm?=
 =?us-ascii?Q?6yk2APBYsTJHfNC133jQoiJcgHpzbUl/E98CoGbU70F1okN42opJdAVS1qmo?=
 =?us-ascii?Q?EkRuzVH34z9hl5o/JQq803wEVxQveDjKZJ8X7jp74oNw8fCgWywpJ4YOB/Fi?=
 =?us-ascii?Q?VDgtt0g28bgtRwrVwmbSXpgcgrdcVxj0sDSC3Yequp/umGCSkR1xdjlfSXG2?=
 =?us-ascii?Q?F8vQAu8j36epBqiZk2pNawABbWcFfan1L8zq0UEvkRlnTQniKKJzUc+OBVtY?=
 =?us-ascii?Q?O/p32EbfZcEGXtDcQzL/Eqb964KM/HDvZPS3p4KAPo0k4BNTBKUws1ubIY3v?=
 =?us-ascii?Q?cqWAcPdJqriQ+PSKaz0EiB53UT/Ek1Y14Vgk96ZAo6mvc7DLkYhraO1wIqGM?=
 =?us-ascii?Q?oPk4lpzUt2j+Pg8TlGlYG3dAU0oL4BHj3aGeTgXWz1+pI7UdXtqpzngmFwOi?=
 =?us-ascii?Q?Zwlcc4xAkx3mWUpdvXmMbIqFA+MCaMEHus+FpCDgB1ck2yLR7yQ2VMcd7PSy?=
 =?us-ascii?Q?xCTshygVh9pJZnJypmd0HP8a9qpHoSkpO3AIunqHErU99cKdOnS174CCOpDI?=
 =?us-ascii?Q?zPF+9nfa1GLGGiiyPKqPv70IHVhZo+7X8f+R7oh86eyd0lRgpPZs5MceUubk?=
 =?us-ascii?Q?ekc269i91HP2vrhLUSPHyNkwb92lDwHsE7IBJqDT284LSNgi1Ro2Zz1z092I?=
 =?us-ascii?Q?brEhBCZdUaibtcTArhJTtD16Henqle4=3D?=
X-Exchange-RoutingPolicyChecked: TgvNegk3OciwVaLxm9tgbnbrHjhnmyE1ZQ+R5SNk/iWI8yK32fzczEl06ecJ0MwS5uezqjjJyJU3BPcnZt4+nkY0NRZT64X9k8yueZ0ms5jlIYRGG5Sf/OVwBNqV7hRLfx3PpGVPgdvFctD6Ls7rG6gBVKT0pE+nAsOLJVo7mxiD0d/eA9roQg8OgXA1RPYtsVDJYXT3BXkTVpBRn6U7elKeDzYZ0pGzhDiImgEs3UiMt33ciYcNKqh+59evm6MnMxSOYjqDJ68E1DiJxUp9PLj/HPUfc0gC2V0Y6ZLYquHLPKofHqvYw+1NsMlUy5rE3TBFO7QCsnLOBS+wcjfJ/Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: c8914c5a-6a2c-4691-328e-08df0fea33db
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 09:51:07.8484 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sgCN/Uy1r81K9bEBYbMvK+sQSvI+hpWedskBCi1g6nsLPCsM+fGhgHpkcAXYzN+ZnR2NPzn/Fm4Y/XtoVNNqeWG3xz0WURXVXVXwpvCtuXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB261624
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

On Fri, Aug 21, 2026 at 12:25:02PM -0700, Stephen Hemminger wrote:
> The pcap driver is not used for high speed production traffic, so
> any marginal performance difference from using regular memcpy() does
> not matter. Regular memcpy() gets more compile time checking of the
> arguments.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/pcap/pcap_ethdev.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
