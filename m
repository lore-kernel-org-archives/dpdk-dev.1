Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A881CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 15:52:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67AB240A71;
	Wed, 12 Nov 2025 16:52:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 520AF402AF
 for <dev@dpdk.org>; Wed, 12 Nov 2025 16:52:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762962728; x=1794498728;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=tk5nsdmfiW+k3RedHupns1ymRD9tWhmcBRsKpJWRHa0=;
 b=oEKnmSo/k/bmwON6DgEa2r0eK/5yiDq5fo56KvA5h95O9NLJFVd23ulN
 OtT/PjYLVXCMsRQvG+h0/s54hbZ8h3qFz8e7EnGvsrb7jmwfjuG0P7HQd
 bzCtsaMEr1vMhmDWLxFwxbOhpTQ8dKFwfr18L7yOz+SrJj1s4EXi/ExlF
 e4lPVAPUgEKpvTVyzDnkVTty3efDCCjG6Z5uKp6wFyNj5rfZsXVLroxqp
 mbW8QvutGxGVykTAQDbWi9XGE9Omhv/2rvGYny3Bk7Q1b0LlA5wKAIXKU
 ruF7o/phmzz9AK17J9oDYKZal1ioKM6eg5ZL0Tw8oPE2ZOFisUt/P1fvA A==;
X-CSE-ConnectionGUID: p7GV9JOERL+GNomPVsRDqg==
X-CSE-MsgGUID: N7ZTM7xfTz6jmgcTyoe5oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="64233083"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; d="scan'208";a="64233083"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 07:52:03 -0800
X-CSE-ConnectionGUID: av0uE7RISwqrtmdQo6hs5w==
X-CSE-MsgGUID: uvP5XK/9Sc6/vDim6iM4UA==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 07:52:03 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 07:52:02 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 12 Nov 2025 07:52:02 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.0) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 07:52:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QWFZjq4y40MyMZO2S2plS7mej4Co2xfMoBnFEzT1iP/9a2uFMgD0CV/L3XgutEh4MYyDVTnCtrdsa6HrLSaqXymYFQIw26abBm1gj5jSQ/jQRAI4ojnX3uZvAxTRRUMmxAyT4oHOZtUMPoYq39FB4GfiWSi5lUg8NW4Gp+vUYLKfK8duhXS7V5NoXp4rQ8w5hzeh056xzmZlQEaAeqFO6Q6U5QD95I6gWGyUKS4yUAVcKR2qLR3VRVRMMJHEFBYbHU4z3/HRA2BrZZmW5CnTxqBQBGEZyU7wK77/NlQwDdrXvhRWc3/aGl1tjZqc/hl3LIAuSvTLOCYbP9RRXRMYXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQsgXalnuNhF/4cvEvoanuz0mdhlA02h/u4NoJ/VCWQ=;
 b=VAp4phDZsKrrMDe0Vwujrh0u7IFixFgk7m3LP3SuMhbvQeQJgl0J/jhK/hu4nBn7zud4Qg9tDi/8780rd6kWTDHxYlw+uLSVoH6ZOSLepyewbaJ6duqYIcdOqUdadsIZlIYJQGZaD2vNCki04/6etWRyicoi5Vkf3LmJThOjl4aK6iFP+aUNP6wcOAHBuN/vPQQxBtx8DHNeV9I4KDFaTWSwmN/fd8ydleebVgDRnJyYcqYKZdkpjTPGVi70SE6VhdiaM4D4MnY5G+SUe3DeoaYTTcpDtqbtCJWfl505mkjDz1KyHRoCbgEvL4OzPclT2Z+rsMk3Ajkyvn1fePn6kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB7373.namprd11.prod.outlook.com (2603:10b6:8:103::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 15:52:00 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 15:52:00 +0000
Date: Wed, 12 Nov 2025 15:51:55 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 "Andrzej Wilczynski" <andrzejx.wilczynski@intel.com>, Jedrzej Jagielski
 <jedrzej.jagielski@intel.com>
Subject: Re: [PATCH v1 1/1] net/ixgbe: fix PF link state request mailbox size
Message-ID: <aRStG2sr6wj5cXqW@bricha3-mobl1.ger.corp.intel.com>
References: <2ff7218cef6c77858929c2aad49bf33d925f1865.1762782930.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2ff7218cef6c77858929c2aad49bf33d925f1865.1762782930.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DB8P191CA0026.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::36) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB7373:EE_
X-MS-Office365-Filtering-Correlation-Id: 611b468e-d851-46af-11dc-08de22036a57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ABoWIAI8dszFwSvVIxjyBtZmvrodr5FpLOrjeU6BUvZ0zPac+RqERYHkDn+o?=
 =?us-ascii?Q?u/unTeMHcWVE6lhW0mLNsmv8fdjF17etQvDR2fwmMu1RN14IArHpv0FDp0hn?=
 =?us-ascii?Q?jn+OjBqlZ7woPW2tVBWlP7rokjVlbHDQuQ1kamZvMQWcZQjnGLoe9iMqFSa+?=
 =?us-ascii?Q?E6cJFF0RLaKv0JUl066anSOEaffBeX3gWfksDeepTSuW8CgZtjWMDl5Vyuhe?=
 =?us-ascii?Q?Zxhso4sXa0VoSCNEm4EKVBkwnVPLEq8m+SCcY2XenBHGOJl12aEgq0QhzEBh?=
 =?us-ascii?Q?EXsKqxcISBIRAmFLLH5oHq7dlE2+PaUAj5ekTgm19cLW1PQU6gXQI0uAhaN3?=
 =?us-ascii?Q?4U6dZz45T7Y8IXPcCaImLXZSf7x1GQRukITzUPxb1hdvdEsaVaNJmd0/HmRy?=
 =?us-ascii?Q?AqC7ME3R/qMLXN76ki0KD+mdzog5KViKIpdOd1IoxhgvOQshDl1wTkN8udCM?=
 =?us-ascii?Q?rwMrHTXjZSyut39gyC/DZsl3P5hF2OJkb5Fo/Aepcx4hxucHXyZhOfeewJaN?=
 =?us-ascii?Q?1fh3NlAlXZJ7eszypvLszCANyxs/T2raIH6MUFi7P6HUM5ZSC+YnRLiyn8nV?=
 =?us-ascii?Q?UZ5FXYfFs/qe+iEMmdB0jNZdy+PzrKFt9FV3CMz4bqrMAhadpJDDhVd6AX7I?=
 =?us-ascii?Q?li05UzcceD5tvGyCyJ5sMIET+fky2xj0U0WeK4SSmcjU7TlY7BUetgZg+k6C?=
 =?us-ascii?Q?n2WAxAgv8CEL51z3LqeCADo3Lhr1j0ljWYaok6isNnSgjl2x3paU55p1ctw0?=
 =?us-ascii?Q?J11P5+1tSQk6cQGe1nfgYQUi8EPMan2wb0cjD7BW1MZXqF5nf77VRo0DomRT?=
 =?us-ascii?Q?Ig31OYU8KJMOkZVh1yofXtDuvhk01hm/OqXFHW68gXlaQDhMs8+Syb1HibSO?=
 =?us-ascii?Q?mhq8nLmoIiWW6853yCEng1ctsHpUDvBLP9ziQgCcn5HRJGtaE//rn9mdp+mo?=
 =?us-ascii?Q?JDF9E/kt+LpetNzLh1XeJULeH5BJBvKiYD3iqVPpMnYjxze2lckx1dC9Dywg?=
 =?us-ascii?Q?+/F4iP5eogu5rOCEEOdrkVa2jOzjg2aN7z1OZ35fubC7dnevyYckSqxzR/D2?=
 =?us-ascii?Q?8rDkMt3ASApaAo2FZojxLb2r9b6MYq89K5c+sa1XYCkdulGJLrzF4XU0OA1J?=
 =?us-ascii?Q?dJp1L06LhjcR3PKQLbAIQscXomrx2nmOdGooXDLqV7AnxYi9IkPkj1HrJ8P6?=
 =?us-ascii?Q?8vla5S+1iczgrTOzkt5p3GzDKEs61VJiG8mZPpdXpyJdpkyQVMmm2TPg2o6A?=
 =?us-ascii?Q?oweAVMb0gGN8DD3pZ7FWpHFcbLlBmLUXzMtDDCeMM+z4fBYU9rwMGVcO4fx+?=
 =?us-ascii?Q?G96mDKa+Doz83S3aC1C7FX/t9Mw0Xoc1LONa3/d/5WF0exilD10EE+h9NjPD?=
 =?us-ascii?Q?Kda1dfsuZpKfTxRf9Hzin0AoQUnN40B8cDVFWPqZLQ6Xum2EMfV0dQmpG9r8?=
 =?us-ascii?Q?7kbK/tviuI+4FlRQksCf05VgUNtzB4CL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3Zv3kBPRvxdGfp2wdWX7u0iIOMcvGa45BO5huELYaqegcSMlI2qR7aBwos0e?=
 =?us-ascii?Q?KwMJX0WVAhyKe2InQLRMT6jtTZH4zi1wnGDOPrlcodUUk96A2hVpXvLt99wH?=
 =?us-ascii?Q?tKCXsJE8cej//ygc3TjwwiUl5xSFrqF0B/a+Gf8EgyWJbwc1S7/qWytBtjqN?=
 =?us-ascii?Q?HrbEZEEPzf2thq8aNEVDgXrHC/ksu0JZhB/X44sxXGIryp3CTujbBC0pP9rP?=
 =?us-ascii?Q?DujzfMEN3ulBL1T0XMUCGmq6jIGrU2gR5wMBQ8oyFI/bBxmKY4IvCf2pd3jn?=
 =?us-ascii?Q?cTAYe2nsNzuHis3Duv+247uThBA0LL3FDDe5H6s8havS4Yy7bucOIL0BDTkY?=
 =?us-ascii?Q?b/bWhVZSaJHUb4gUk/uSECiBbqxRUbndqwO28lkMdxuLekRLgyv9Ph4gZahQ?=
 =?us-ascii?Q?ITRCBUiEEllI97DvfkftXEx1WD3aiV50WXYjZbFgjAqNAIEii/Q/TQ56NBwL?=
 =?us-ascii?Q?2tgiwM1Ew7QQtfGidIDIFGPYkpb+2rY8D/XX0KEbON3xeMAIXah6E+svN1XU?=
 =?us-ascii?Q?vkE+Za9K2lVaCxlKTtT9Nr8r6QrDJ3RVJCAld6xmNLFypBNu/pDXDK4maQt/?=
 =?us-ascii?Q?5bJ49s5KN/WaJBPAjHLe6Gpn4UhcwrukEy71zjsLO76bLaryyDWuh6g3uC0n?=
 =?us-ascii?Q?NId17ro2Z3T7WCzTmVhlCKbOHhWMnlBlEKwJfPityINvBt0Drjw+6vCF0ixG?=
 =?us-ascii?Q?bivjyHNXBftuumJYp3oRbSve6WpkoUKvmO92enveHVk7tp7N9+QzS4/zIXdp?=
 =?us-ascii?Q?HBvoLmTCgjqgodYJjvgaLo7ajE8cHYYDJJSLC344ePGzgTkfwKcrJ7Az/CIZ?=
 =?us-ascii?Q?eHfvH7rukzIhiNKGt26F/YT/6IXVsp12mFF8T7y9/Byzs730bdrGp0SXnRtC?=
 =?us-ascii?Q?jM0mkjvlKseSXdyDThrYxHlFsRrYnRnJT817cMFqEsunAHdm9JV+ySW7c4ho?=
 =?us-ascii?Q?ZmK9hsekiLDKdxh8ptkRnowVGKBR16p3ZhAC8jOFJk9aRUOXVSU4/JsT2yf2?=
 =?us-ascii?Q?EBlHeyJMhXAALlXqph7NMwydgf78zFxLO9eFn+Da4C0Z3TqNFESybealaqym?=
 =?us-ascii?Q?obfrP7VJ47rz5ndbbZCoTo3vmZV9oovEkGRPETb7lUPah8lx691zoyA4NgY4?=
 =?us-ascii?Q?oyjoyCKSS+cq2tYtX1rIXQf+JrdQhSdCyvXZVqVLb9V3ZwJPxi/BhYGESrsP?=
 =?us-ascii?Q?6CV5cdwQeFnC85goXqjgFrJzC2VnDoqlb3XpA6kDXBKU79QrLmq/VrAseY/Y?=
 =?us-ascii?Q?r63Jtb0MRWUJwG+ViuqDAyUBx19GSW5dnBSmbniUO5Q1wmuZ/QJJLKx4ZCHs?=
 =?us-ascii?Q?RdjHkkaYguxg9F6aKcdnn7UesANsoJHBQuBkBWeUllNdgjuYpLZ9IR1fdtdv?=
 =?us-ascii?Q?+t/DAlUpLwGuOiA9KtWXG3gZUMNDn5/SADcYSd1ahGaVmBmHfbWtdXyDmBJM?=
 =?us-ascii?Q?rjrKLGIHTCAQbexs2aLf30ubHvfzO00NBqcHfvd9R91qbKWQohLy1NNIwGWj?=
 =?us-ascii?Q?pjSKsluZBGGLL/kxsXygwo9Vh21XbydPv7/WrWCwtY824yR6NP8by8GmTSwB?=
 =?us-ascii?Q?OIRddtOnpSaVPcmPxf43Z3gbRfElUXGqcZqt68R9v9qkWOJWndoW3T+J8jf8?=
 =?us-ascii?Q?jg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 611b468e-d851-46af-11dc-08de22036a57
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 15:51:59.9689 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ITy6aBuis6EcG0LzCDXxFI3feY2vbuuNZ1+/z9lGw/GPgXrivwCuDS7jkodIwKiDORMI/ofV+X+6uOiN8/Qk0o7ACRCYlf7v63EjNYy8cMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7373
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

On Mon, Nov 10, 2025 at 01:55:39PM +0000, Anatoly Burakov wrote:
> From: Andrzej Wilczynski <andrzejx.wilczynski@intel.com>
> 
> Currently, when requesting PF link state over VF mailbox, the buffer sized
> 3 dwords is allocated. However, the `ixgbevf_write_msg_read_ack` function
> is actually called with buffer size of 6 dwords. This leaves an admittedly
> remote possibility of buffer overrun. Fix by adjusting requested size to 3.
> 
> Fixes: adbd71030575 ("net/ixgbe/base: fix link status for E610")
> 
> Signed-off-by: Andrzej Wilczynski <andrzejx.wilczynski@intel.com>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>


