Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DF8CCFA13
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 17:29:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC43C4021F;
	Thu,  6 Nov 2025 18:29:29 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 8D8BB4013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 18:29:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762450169; x=1793986169;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=A7PErcJOOGQilcZhSLb0XD3WqkXDQ6HegCICns+XEdQ=;
 b=JA3eu9YzUKj/puxA8+i5BjO5oZe+1+wmcwq/MrodTH5HrQZx0hxffIFQ
 4TPjQD67whz9JgGa7PZwMl9R0a3Y/igR4c4jkvrpwY2qo+EiFBCBDFylW
 qRd6Sy7zdIbqmrieboEMBo0TqB1UtC1LS16GwtBDL1nExaSjnfRC3u7ed
 4PjQlOQVxjHjjXb8Tt0m7QGHNZyT9awbVbNNSMMKXmlZI0OX2oSjakMsx
 C+xv0HHg+Rr9NGYro9IVVIcVO05CEFguUgBX/lsJe05+fdCdiSXRo1V/V
 GNFOjBsY99f9xCn+z5apyLVbsWVowhANcAb0Lh/kj4FrL7kD2af5ZrxMP Q==;
X-CSE-ConnectionGUID: LO/V38SJTum0T6x7H2Qu4Q==
X-CSE-MsgGUID: pZY7Wv6qS/Guq5+XfZ3Nmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="68457201"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="68457201"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 09:29:28 -0800
X-CSE-ConnectionGUID: USMUXjnYTm+fzNV2n9nnzA==
X-CSE-MsgGUID: 6QUskctoRAONfBWzlFACAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="188532778"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 09:29:27 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 09:29:27 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 6 Nov 2025 09:29:27 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.20) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 09:29:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tnRagKsHqXSc6i9mKdpbED17uKE8g2Kyhuxxr5MaRGLRx1uwn+4O22Cc/A/TivJuNz6QJKAErjxO8cXuPEoWkF7SisJbi5dXVu2sT4e+s5rw6Hr2v6TGfnPIyIsBfXdaLBR8LvNe3wjcjHeNPFPoBSpG8SnJxa5Eb0EdhHTFCv6Vuwtf09LrwtvE/MioZRLxhZl/EcLgf7PACwEsVyZEr3nn8AicKwZw2CgvJtAuxW26pmlCwiJWnF+0/+DeWWHa5wqOeBOvSNBQWdwAxxySNsCFT5xDhlA0vAiy3/0XThVMbd1MylZxZp4FPkjkD0PxFuZFdlvfm58YhsEwN5OAtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFqUgryd0gJj1YZuJqg1zQKyicgGZTEP4AxCOMj162k=;
 b=ObqFPygQ9Pa/sOth3lhgwr1VJ9+VjFZQV4aGW+MANrR8R2lAWgkfeio1JaS/4A6jQKJu7rhxPIIXpgRpYznEU7CK0cwD3jhuoVH7fpEAz2Xjbs/+r0S0tmAZxkPhUCpX5M1wyFV/vGENxbODm6FSAm/deHrTIfS3+SfXJUOYWgEiujNjIUx6yNrXBxOgwZ8dwBhYV13OKxqFaVvgia+hqfa3CpX2e0EPPzGxti6nahWFUEpNMdLDHlqHIyzASwlDXs7/AHj8Hx+l7GnOA16HYhr1wlsm8YMn9ouAV17D3mJX2DHUWqHEHimlNHqG8VY0b+cUHO2QwGIlbFyBqtJHig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW4PR11MB6934.namprd11.prod.outlook.com (2603:10b6:303:229::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Thu, 6 Nov
 2025 17:29:25 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 17:29:25 +0000
Date: Thu, 6 Nov 2025 17:29:19 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>
Subject: Re: [PATCH v5] net/ice: add option to enable source prune
Message-ID: <aQza75Qqh1j1nsJb@bricha3-mobl1.ger.corp.intel.com>
References: <20251101104627.64906-1-anurag.mandal@intel.com>
 <20251106163334.95660-1-anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251106163334.95660-1-anurag.mandal@intel.com>
X-ClientProxiedBy: DB7PR05CA0028.eurprd05.prod.outlook.com
 (2603:10a6:10:36::41) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW4PR11MB6934:EE_
X-MS-Office365-Filtering-Correlation-Id: 155bf650-295c-49c0-3ca4-08de1d5a07e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NxMZB8hwBbNrtpVJdQUwfZMjdrluu7KEB41ohc5yAnwrl5NHkvIgybCW66fq?=
 =?us-ascii?Q?vgLC9NG2NMscwD0WKEvdshiEI8K+l1djswC3srqWU4kBes0ZakpdE1+fevv4?=
 =?us-ascii?Q?rJ+NYAysBHz6Wt1TOtXl9f6tBv65YMtPRMl2prtKi3gyxDi6FylJFTRjb7Rq?=
 =?us-ascii?Q?tnDSEfG4czEExG0+3vvIUMhQVkcKx6dd8DTrEn7TvWaT03cibU4NmY0dMXyF?=
 =?us-ascii?Q?XVn8z0uAeQO0edVsuAaoi7HRgtQUdNK+aTmZ7EFd6R2tWmUIzDFNFWh9UIy4?=
 =?us-ascii?Q?hwkNKnsYldMrb0kgBi/Dpgs3KenV+nKjiDaKSRL1zPrkAfqbjvlMmhDcnnje?=
 =?us-ascii?Q?Yt2u9LjcrYFAHOCKWmVSz4hNLfhNuEjgKnknsLhVP38MoqdmvNN0/S7IRLfv?=
 =?us-ascii?Q?zWGQ90uWSsXFVS1QaQIf1AsGRA6I1diq9flXv17+5RwuAcRlc82T4ZKhVdYw?=
 =?us-ascii?Q?UEVTbv0oXBTh6sXI5exNQOkh9OaCcfVEcnS17qOipKsU7KGR8lH/kgRFcdmv?=
 =?us-ascii?Q?LGhraAsxfInxO2cqXwDl9Wm+1prLJnuEZgGh8LvzdtH8shNwzGExS0RYqYjo?=
 =?us-ascii?Q?uOkLukKFCQvUauAYD7TUfiMvJDzUQsP/Ti+UU8/td3Z5d5fG2lLTt1qCNIQa?=
 =?us-ascii?Q?O4+j4yTJ8F8CmK+jsNCrYhH5x5GMmPQDbyn/AgK+1cybSdL1S2knCRSP/6pB?=
 =?us-ascii?Q?uxXAPQv2Z8JonRBq6J8QJlE5Uz/8LuUNxBsq9g+SuxbP/rf18h9fnEXPZPqC?=
 =?us-ascii?Q?NwC41lUISy6bfH4Pgo2sNCiAHG/3+3d8lkIgHbqIGvao32ch/E8XEobxYoZs?=
 =?us-ascii?Q?3t6M5OcwkHgHBL80P4G5xMVbUTf6f4HKIxbLPi1FJ5zFZDUIxxdLAbzYU3Xc?=
 =?us-ascii?Q?hjZPUZ7CVK35hV+zgwyWlSYfovYeYsDipiHV+Ov86fFtVHDs9TLM9OIGHooQ?=
 =?us-ascii?Q?ZmGdVrv8z2OeNe6d7KaibNtOLjYaXHhxUOPl+SliCeDqr4Vl3zV49ITvzAqW?=
 =?us-ascii?Q?EVF9GsJaKM/Qwda09DK3YkEnU+OiDFWRsqgvFC24Q41L3sA8lOBebE2u3CeI?=
 =?us-ascii?Q?rawsVTqX8oW4/sBshaF8U57P0fqs1avAgsUU8N8aTU0ZaIKT6mvMIcZ//F1h?=
 =?us-ascii?Q?CmXd9vJremGlumbseLvN3vCofYtQuw0/7ZaQ5r5FAkP8sBIQN9PjirzTbWV5?=
 =?us-ascii?Q?z/IhWJtYfNZLTpUTuyDS3COry5vy1qOf9NStjixDmUXsl6hc4/IJgDQIenL8?=
 =?us-ascii?Q?KYD8wGVxB9VsN09gkDfzJHyz/6N1brpywjSw0MaGGSTWq25YAOXEOpSUptlD?=
 =?us-ascii?Q?BsgcNfGAYIc1rzklxsBWinkxOvM+lNVoAZH8Yt+lyIu3kl1hQD+i0TfhIF9B?=
 =?us-ascii?Q?ymG6A08Fs7pB8lcuHww3++5fxkOhO2bFOSEAWcQKBdzmowG3z2ceuSFSGc9+?=
 =?us-ascii?Q?z0isXTdng7R6Hs+0Qjg4e0zIOGG1AQdL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+au82GenvJwRY/KlchHyj1yreZplrl25HnkLrM7o6pyFaSPgLREBO5xx1Jud?=
 =?us-ascii?Q?bdtWXoWeybGLboUKMjhbAyR3+4OgelKvxZuzV+OS14hrg/Nabp7wZLD74tG4?=
 =?us-ascii?Q?OxpOxJku568oAyZvQbBFeXJbOoNjZYxmhg23C2+JH+kJj1ub65EDXdbv0BuV?=
 =?us-ascii?Q?DMp+4QZ52cDavZwIL/1xVVqUw9JPemGOaetz06egfS+iJaFoaEYcngce5fyw?=
 =?us-ascii?Q?2FtIWxJzNQqBeecLnHa1neTTLonpOWa5l8vUl3GjlFp2c4Z1+MHKG/rPBnlX?=
 =?us-ascii?Q?8opNk64mvDcoUWjbl+DmPH9kJ75d2daAcO1jgCzQDjV+SEI49s+Db99ME7WU?=
 =?us-ascii?Q?Od1dbbEsQD3bMUA4mPYM43tTDbffPnkm6AiaSxH61mh3A2bqwEoCiMSzLCbd?=
 =?us-ascii?Q?Pq+1sl3b1oGR9fEiWc/KN8HZ8r5Vf1vn2CU+USQvZ2pOHpnTUvx5YjQuRhpT?=
 =?us-ascii?Q?1B1sAaxOtTJM7k9g3mrF0MQT7lpdR8O4SA+nBveZw0ANLOXyXirM3Lq9iXzs?=
 =?us-ascii?Q?52fJjChVVNLJ7bgkbI80HMz55QyXcRvpk5FKmlBH8F2FwjeQA7vowlSgPYny?=
 =?us-ascii?Q?UZt4JlGeupNnInTDptH2Pn3Mn6jbJby9S/kFZfIIwB1kCnSvG+KmQ2/FYetR?=
 =?us-ascii?Q?wrFrfLIhHQHVSMLtbp7J8IuM42+DMgtsTa3OJqgYUY7lt25qZgJPcij8HyoM?=
 =?us-ascii?Q?9pq5MmGNYZjABd0pfPG13MM8/vIAEzbBE8AfjtPSE15ig0SAGeVoT95H07zH?=
 =?us-ascii?Q?bHjUOc1+tJRy37FZUAAp3irU2afoq3odAk37ggmRiAEoGGZaFx63OAEMpxPp?=
 =?us-ascii?Q?GuueXYGR3n4Y8QsqsgzFuWjzCm8pIwn5KEaNaYbXZbESLILDxilP3EhtJY2v?=
 =?us-ascii?Q?OgHxT136YUA11CAqR6a1M1vLk2L3Rt+6XfvZzaXZZFf133tgSrbpVlNjty0A?=
 =?us-ascii?Q?g1NxZhR1Fj6OSLKfNIoR1mQfw6LexLTnRdpSOKMIgVW66QxxjzjPIqAB0kvw?=
 =?us-ascii?Q?EaiXBUi3vv5MmEVchlhh4OIwCe5ViTE9icYON28xOi8ncVBSNN44qveY1m7r?=
 =?us-ascii?Q?C9skHfg4FOcqmw1+Cq2tQ7MtLu9RmbzsKPyUf/mzEsdr3DMPnA3LUs/3rOHh?=
 =?us-ascii?Q?epjOnHec9VyHYA0nmwif/brZFYnSDWEAkJ+PdMMq52EzE4E40KprcElmNite?=
 =?us-ascii?Q?l38lq3HEAbuwbGsuRbUtydCda3mad7F+9Y2gSXPrOi94MldHtF0bRNXIQM9C?=
 =?us-ascii?Q?2VKESp6bjfXnOOI6WMgrpbkDyywuLOEgojbJiZdBsPZgm5Z/Rl9Xbd7C1VFo?=
 =?us-ascii?Q?axG/3DBfTD3TwGvL639pAGQtHbSEPM+6GVDOKzQCybuq+6vgvS5E1qSgPha7?=
 =?us-ascii?Q?1s57Xm8S7Yiqu82RVu3O7Co4c2OQo38W+DidEyE6JY+JU9q10fbs0fdi+lFO?=
 =?us-ascii?Q?P92iv3NvdBHpTjYknDNAJ2HV+iSiSsOjyncOzwlELd/qnFYhB74Zd88SbpbI?=
 =?us-ascii?Q?KPgn7QFK0Y0vpUXx3s5rumujyLcw3CVnFOpILCf3igpQZc28YI+wcPrAPwBl?=
 =?us-ascii?Q?MvQaZVzG3edsOtkc8Nj4+wCYkTloCSSzfS/AmmYXBFMsKJ16pZ4nGOIylb59?=
 =?us-ascii?Q?+w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 155bf650-295c-49c0-3ca4-08de1d5a07e6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 17:29:25.1938 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e/zwwK+0o1f4y+lOf6RR+RmbaZeGlcl6vt9FJzSiqgOtu5XYk42tfaxM8zWNrtNl0NLAu+V8cOSwMvkrIRxQbR0rL4Yf/Fu1itpOhxqMkEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6934
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

On Thu, Nov 06, 2025 at 04:33:34PM +0000, Anurag Mandal wrote:
> Source prune is disabled by default to support
> VRRP advertisement packets in a vsi of ice PF.
> There is no way to enable source prune itself.
> 
> This patch introduces devarg "source-prune" to
> allow user to enable source prune.
> 
> Enable Source Prune to automatically drop incoming
> packets when their source MAC address matches one
> of the MAC addresses assigned to that same NIC port.
> 
> Tested the following with VRRP advertisement packets
> in a vsi of ice PF:
> 1. Source prune default mode with no devarg option.
> 2. Enable source prune with devarg "source-prune=1".
> 3. Disable source prune with devarg "source-prune=0".
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

