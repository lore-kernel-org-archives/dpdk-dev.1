Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72120C61DC2
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 09:26:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F953402BD;
	Wed, 26 Aug 2026 11:26:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id DC7ED400EF
 for <dev@dpdk.org>; Wed, 26 Aug 2026 11:26:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787736393; x=1819272393;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=WrYK9Iaik0y7dwgZt0uCD2xhVvvqKwbm2O1PVmdlfTs=;
 b=gS7+QAViEgsHzAMtolIH6/VCvyUv7kTUolUMof5yjS8VlS2GbYdwpfc5
 HZnRuyBvZqnX8bda+gLgWvWIJ4VptMs/xv9ISrXGGpR4FhSQ1vv0O4Ucy
 FKCMkXeNLGO/CQZ4AfvG3hZEhxk68cW7vWQWEOHnYa/hwOVijZy/q6smk
 fX6VdkFoYYw50km9J99wFhfPWGg8VaiGtqWcLzjUFnhZLRuwcUfJawrZT
 vcnKGQbZRpP4Z743pajZ5S6Y98EZqNLUgCSpW2fnqcE41lhWpzVhwnUAG
 onfrFIlqdh22jghScQCwXEK6f/0zqQyScOFmHMt6YuM9Y+V7GehLztghC g==;
X-CSE-ConnectionGUID: njsGwmyrSd6SUqzdFa80eQ==
X-CSE-MsgGUID: Zz+L6+r1R/OKchFz+7g+6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="92033064"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; d="scan'208";a="92033064"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2026 02:26:31 -0700
X-CSE-ConnectionGUID: Qu01b/HAR9KXxN2PW0t2og==
X-CSE-MsgGUID: OqvVCKuSRkOFQmxBfk5esg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; d="scan'208";a="267549519"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2026 02:26:14 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 26 Aug 2026 02:26:14 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 26 Aug 2026 02:26:14 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.41) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 26 Aug 2026 02:26:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O15C/38e+KKmVN9EYGROgA6bgjds0+HFcnuUL5sN3xsmutOhD0cdbNa5AgLANuNQlzKQA2PBrBSqg8j43FjAIpmltlRMhZgAqYaMLBWUfJqucHPqHjtBJ7SxbljdSmZC4Vb75OaHbSVzyX3SGgZFE0U/uRPJP/yxGMZuzjFQCfSzu1BYTXO0IJ61SKEJMFLJ820M72UxIMR0XdNlBDjbAw+MwOegi2Gj/XquhAEN976dyzJAzaUjLzCVzVCWYrzdSLabPaLyyk97ZlWJsUQbsHPen5e899mPE895T8iSi7Uzvu1/t8HU35XT9QMZnJcr7Bymkt3yvVygtCttIGj4Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgVoVX2yaSv3K2j86RL0KovR3M9dLg5waInYWqgy44I=;
 b=ez8rMAn4oo69nrFCnzFDL8juN/EIGIYqSnhVgOOlV/aPzH30VcDANHW8hDWpKM9BCCBCbJV9LImrpFsryCm26xnqokfSpPzu3AsRQ14kQ6Tv305Kqv5jKuVQJxmGAnojitAkQZ+xYYUPbPLXoXZqJoF5b28HFWgKkPcbO/f+mUJdcj0SABnryhShR80FqHeyxNhN/BC4xShio7PvFvfxcKZOSvhgzx2zl+FN0E3sGRhqkrtxSu2/odJU9bj/pBTfmwvttEKTzZNPEJmhx7YIWWzTWA47pXlb2pH7llz17WUkHMTi4NgzErphL4OpV4QPS7bv6TN3qFv6+Gz6tuvHaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by PH7PR11MB8058.namprd11.prod.outlook.com (2603:10b6:510:24d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 09:26:12 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 09:26:12 +0000
Date: Wed, 26 Aug 2026 10:26:07 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: "Burakov, Anatoly" <anatoly.burakov@intel.com>, <dev@dpdk.org>, Ori Kam
 <orika@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>
Subject: Re: [PATCH v1 01/21] ethdev: add flow graph API
Message-ID: <ao6xL8exTyGVAIRs@bricha3-mobl1.ger.corp.intel.com>
References: <3284b12762de6e3b7791f5e3fa63c78b26ed5e6f.1787233987.git.anatoly.burakov@intel.com>
 <DPk1E-kwRJqv9GCxmKhBVg@monjalon.net>
 <dcb80f5b-31e2-4f64-8d92-f4f4783393f4@intel.com>
 <nA_0NtHGRc2CE05D7MYfOw@monjalon.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <nA_0NtHGRc2CE05D7MYfOw@monjalon.net>
X-ClientProxiedBy: DUZPR01CA0054.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::10) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|PH7PR11MB8058:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d6d0abd-b6d4-43cf-0983-08df035411b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|4143699003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0qCEP4xb6cqEIH+WuQS8lsPpM2kgo4xzMyhyRiSDqzW8zWD1mP2dMHTB+anqYERQJ+vY03Dn3AEore/HP+UJ/5JJo/FFIJu1R9r3wBO4KoOQ5fhu2oKFqvPYHEf5r+r97Ypw2JSO1eSi+A3RmNKlfsgN1xFxhe6GNMKKUJQSmq+i2oN6dzZupBSilKa0bJEqjtqCES3IR7lgo0BGGOxvGukJXVVNQyhbLMrgBEIepXh7AiKNw8Lp4P8q3Vq/eI2tjWa1d3U0Fxn3w8udA2Ig8hx2FGLcxP0fA5y9lZLykt60xMMnVa4vV8+T0UC52/w69Y6/T0vUdDClPBIQu9VI9WH1waoiAaZe/bmmlvHIcMwRRTIjdxeQXxrQNvT1ULG5BjNL3kMbP/cGEsq12i7AnS479EGScVRg0dnUixbYo9kUp569Sh1bW3yeOlKbfscexN766pXOYYQ8NlVLbAJl8RgAF/aNbh6VwifnLRAqYTj2oxvet+DOUMJ3mlYkyBbwwsP3BYKR+WaeyDfpoaZkmzBnhzyJe0iqeDfcncfpdOUOhpmCl66v0HquOVRnOfK3tK30y4YdOcTGpGZr1E/e9GL2Tir7WCKnIXa7eP6xVbGp4kyA8lTz2BcQq2r80qxxQNvxkaltkMw7EReXfxnbQNgWLKog0URi6uvUkCqTDyg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+SF+dxtEVrqiZ+k73464gLyML2Ku8VEPtGw3z9ldEigFjo8+qBOa1Pe5p5hW?=
 =?us-ascii?Q?qpJmtaUgr2Y1zpUuedTHOhco2+VrsidUs7FsEOEE/yH6SyoTBZaRxs6Rdsg5?=
 =?us-ascii?Q?Bomxp5FscKeSdjVKlcdXyqbsTeGczIMdHoDM/FOSNQgbS7ZFX3ykVSquFYNU?=
 =?us-ascii?Q?y3+q37GyKSl4Vbf9e9P/HdoXw2z1LupLcYFUsRqOW6LsQvl4t5KI7ZklsxIg?=
 =?us-ascii?Q?TAqNInp5yHhp3RU03jmR8LEBjGypRZq6HQdasy/zs4OgcQEuC0yw4M0HvH/u?=
 =?us-ascii?Q?zso0uoEqFt3FUe69gMT5DWwGAIZBfuGfAEdk64ZE8PFBzr299L/5H1x0/1n4?=
 =?us-ascii?Q?co8lKRRfzAQEz+l/rH1qRPnixraAnQv3UqCni8He+ahMYc35ZzgdNIDUYT9V?=
 =?us-ascii?Q?L5Dp75ynNLExjrAclWfe4c0tB8d7n9atU8EZEWkiHay+Lkyqn0LeLtH35Baz?=
 =?us-ascii?Q?DXM4nRU/V6Kuq4T36l3/6E3L28j/J759DE+XiDaUS5rYs11q4FNwMG3nDRKZ?=
 =?us-ascii?Q?UwKNnQfuoZT8B9CZVtVG6NgQhtoLFYZmyjPDrjwALz3yZKdSLt9nRw6KxRnl?=
 =?us-ascii?Q?BRi8XeqainpVVOCYDHjAeBLTc6ymcr5ql17GM/vN047czLUmyVnYyUnAa/X7?=
 =?us-ascii?Q?1sHSu/0mfKfKf5ivAwIuqMWzWdAOsqhOFEG3UPpO3ch0bQGLN3zD46+qkWe+?=
 =?us-ascii?Q?zMbC/+WCDxfa/PxxspZhXzsSrxPiWzhE18DMJqLP/odyYh1ymdRucJISgnNy?=
 =?us-ascii?Q?IL6mWVkmYqPMQq147qJtXWY3i3rK4UAzTq3fnUOWI6Lt9XbL1A5+5FZeoXhX?=
 =?us-ascii?Q?I4U3tHZFsr1h8phcCZQXqtpxG5oJ+R/bTsrCkfBVlZd9L9sChMthPXFP+Zs9?=
 =?us-ascii?Q?5qLrLQJ80dIk6GnyIbKqNvBam0Z7xZq8NS7C4G6StOgH0KvKVr2mABRHmAsa?=
 =?us-ascii?Q?Lm+3udL5EmJoOfxjJVGH7ISMxb821mTpS4qDw/nQo1QoQf5D7mlbwK2k5rYY?=
 =?us-ascii?Q?k8BKYCmK7slqL08SDDMlpjTHfsb3EZoP46gGZQdhdO3FRGf75Nsy5HLC+ovf?=
 =?us-ascii?Q?SuThnw/2TOkQ39ADJYXSej6U9UerS2DXfpzSKp95Gu4KHVEC3g6FsIHE9c4k?=
 =?us-ascii?Q?oWh9UmCb2El2DR+HjLShd0peNmTdYbEXZ4IV3G5DFMONNB5tGLP6OqVp3rhB?=
 =?us-ascii?Q?c4fD4/RrGdOU4EZ4CwO5wLFvV4h/Z9sVFslbGCgSkNw4PilhJay+gfnm2R9T?=
 =?us-ascii?Q?A6kgAd8KSoPjCD/JAWeNjNRcWeUmn+9Xp9h4O1sohTPc8XnR1i5+hyh8Ke19?=
 =?us-ascii?Q?Od9pg7jAcNo6Od6AqQOJAhiwL5HPSYX8+tVQ2Pjc01gq0ltYb9ovsROwEQPm?=
 =?us-ascii?Q?lnSeK3c77SusDRlPmkAj9E4su6F0+xWiEiSRSVrFoixIAJXuL0lLmVBwPD+C?=
 =?us-ascii?Q?jxs4/Lu5VWA21RmhagHbFP8LyO0uvJAEBHN4tVqGMyT0lSOC/qHZQ/WvGolr?=
 =?us-ascii?Q?d6EDBk8iyO8kcjnLPWjgn4wy9u15I0ASLNzId1Fq2lgjfIwirztHYDQrHMYx?=
 =?us-ascii?Q?oOtNrHVAdkiBud3UtUIbuB32I8RcQ0sHx5BPTK8VvLmMyeqHVj8C4Q9iFDOP?=
 =?us-ascii?Q?/CR6DKi3npYS0/8bsLUZ2Sd4obvC5iuhjE4f9v0neYnJzZD1Y5j9n9aVv5CD?=
 =?us-ascii?Q?bSFj+7UI1DrwrSe8BMFeQOe92IIKs93g3dU+6+T8zt0lVj7bJ3T4zayudJFp?=
 =?us-ascii?Q?PgRtGfIZuEt431xOyibxMz3mXU/gdJ0=3D?=
X-Exchange-RoutingPolicyChecked: DEpZhGOiq5t8IZj+V1YfHPz+Gr28oJlctdUVxGwe5deZCN+k7zp6t57UESAdmjB4gYiZpKv0T/oJLRLCk+Y0u0yk2KV75jHg0rd1P3gobn+zqlA98uW5qHlHCu7AuLbXQRDLcqzzl83A5rtxjXiLFIc1ix0N5UHb7/IvEzBe79v+Vz8qPicCWoS8yp3QOgjnWwFuRyCGy0sq0ZaqmdfTorUMeDcoUXx3l3dVw9y8n8vic7/1+DmsH7/c9jdJUTV3CGKEh5hdpj3cDYBGco35fXLuz3PbBw94UYW5QtgTpJHz/wZSlbTazl1AfA/9PVErzquDvaz0laz6dDbMZ9aPVw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d6d0abd-b6d4-43cf-0983-08df035411b9
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 09:26:12.1423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cRXar/Ytl7q2kXiL/9Kdwq9LNxW4ETrn8lzEXGEjOE69HkCwCDyF2vnTD8fhqHzZeW9sY86dsoaxlRJMSxCCDWB166fEj3EgZBMTolrKAx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8058
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

On Wed, Aug 26, 2026 at 11:21:57AM +0200, Thomas Monjalon wrote:
> 26/08/2026 10:58, Burakov, Anatoly:
> > On 8/25/2026 3:55 PM, Thomas Monjalon wrote:
> > > 20/08/2026 16:00, Anatoly Burakov:
> > >> This commit adds a flow graph parsing API. This is a helper API intended to
> > >> help ethdev drivers implement rte_flow parsers, as common usages map to
> > >> graph traversal problem very well.
> > >>
> > >> Features provided by the API:
> > >> - Flow graph, edge, and node definitions
> > >> - Graph traversal logic
> > >> - Declarative validation against common flow item types
> > >> - Per-node validation and state processing callbacks
> > > [...]
> > >>   lib/ethdev/rte_flow_graph.h                 | 532 ++++++++++++++
> > > 
> > > Are we sure about the name? Why not "parsing" instead of "graph"?
> > > 
> > 
> > Because it is intended to help build *protocol graphs*, not *generic 
> > flow parsing*. I.e. only things that lend themselves to be represented 
> > by a graph would work with this - things like conntrack wouldn't. So, I 
> > feel like "graph" is a more accurate name for this, because this is only 
> > for enabling the protocol graph walk, not for full flow parsing.
> 
> OK
> 
> > > Is it only for drivers? In this case, no need to make it a public API.
> > 
> > Yes, it is for drivers. It is not a public API, it is not installed into 
> > public headers. If there is anything I forgot to do to remove it from 
> > being public, please let me know.
> 
> You should not use the rte_ prefix for files which are not public.
> I know this convention is not well followed for historical reason,
> like rte_flow_driver.h should be flow_driver.h
> 
Renaming non-public files should not be an issue though, right? I realise
it may cause a couple of problems with backporting, but hopefully not too
many. LTS maintainers, feel free to weigh in!

/Bruce
