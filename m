Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E927E7BD91
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 11:32:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FED240289;
	Mon, 16 Feb 2026 12:32:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id AA65540269;
 Mon, 16 Feb 2026 12:32:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771241561; x=1802777561;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=WwZXbWd/kloIjN4tcl4ecejNdSF9D75btXHAxtRc/Y4=;
 b=aZj5rnwHmrdPpyZLgU41uXp/d6oiP9qACyfWNZO8lSiq6kC1wHxypH21
 3cnI8ivrxKzXbWXel9bfP5aPU/lo5H/mPjaL2GDGBKkGCkEQGXYWkNL9O
 DwBPmn3wOorbSIkrZtraC4RJmjZUkRgDY+9XScKvZxhzcCMz18pXelZO3
 /LcJhCIlpxaew6AxiMWBK6mbo/EtkJRMvkqrZw3YO5SWe3ek+bewClcFM
 1NvHohDjaowJdUziRB/PyGHU3X1+47UX70Uw7yQaerB6Y/fL8N39rri+f
 UEV1ojOdtIjeHM8G22cCZzSClD3duQI0nhFARjCribGhMj6xf4xjgE2S9 Q==;
X-CSE-ConnectionGUID: CwEZTPmpTEaE6otZtmLX1w==
X-CSE-MsgGUID: Q2UGC172Tq6AYC1nDkBLyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11702"; a="72415649"
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="72415649"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 03:32:36 -0800
X-CSE-ConnectionGUID: IJBlPEUtR4ugVz6DwjClVw==
X-CSE-MsgGUID: 1ovfzVIjTVKEzJlI+TJWnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="212144673"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 03:32:33 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 03:32:33 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 16 Feb 2026 03:32:33 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.9) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 03:32:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SxH1dWDb5UVmNmQ22j81bUeloOgrMtq9NHUfLvfkJ5KSSSXqwggF98BlQr+n1h0VcARkHy6XOsp/7YL3nc7lVsHEC+h1XyYgYJH9XoPQiDekM04tn0et/8gXvtrGPhOL9E//4JGrvAl1icIiNfCiVyNlcpDW6KAltHv1O+xC7IXiecwx5Wu+XBVHI7Kb+iyjlH739ZGj8/0G16DwTBFLfIW6M/bfra46Xzo9iCMi7YwGRPfD5WzgzU1zZXAhBH5U8tyZmsBwWg4YB/UiI0zgVT+bxqHvVcLUwlo8FflfUoMcRB909NO5eKT2E47Jh9l0IVnxoV/LN0pJIl4W7Ffvig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BH2sDElNi5WbI/WxUlDJPyfWqSDskIr3Fxh/tbnFZh0=;
 b=aElUkEC2u73qFzfIV9G/So3KMsLYF9UBSwxxzsgIq0D43SeWzWlNdP+QHEkLoSmNM0TxHpTAG5hVdxil5LSLsXxRI6gxhDYagqHCUAAFYk2uyvUQXy1V+Y1hkIA8M18RHqxzK+P17E979vwS9ITVIRYTTH2o1aZK+XpqHQMbX/+QAKViR3q4OPMANyg9rl6BcxmIIhGWwUUm9/Yoq7pRpMftxnd+CWLbl9MxJpFmrsJtYqB0EwYZeXHfl2iDKYGRBlMEfN0baiZdhLHClf494wHoczSy0zHmzQFrcOnIeE/hhbZ4sqAq+S5YtB8vVitNikUUg9cenab7NVvWWZQuJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA4PR11MB9345.namprd11.prod.outlook.com (2603:10b6:208:56c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Mon, 16 Feb
 2026 11:32:31 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 11:32:31 +0000
Date: Mon, 16 Feb 2026 11:32:25 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thierry Herbelot <thierry.herbelot@6wind.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Anatoly Burakov
 <anatoly.burakov@intel.com>, <stable@dpdk.org>, Olivier Matz
 <olivier.matz@6wind.com>, <david.marchand@redhat.com>
Subject: Re: [V2] drivers/net: reorder Intel drivers list in meson script
Message-ID: <aZMASdK2HOCqukIs@bricha3-mobl1.ger.corp.intel.com>
References: <20260123162104.1854187-1-thierry.herbelot@6wind.com>
 <20260123162707.1854505-1-thierry.herbelot@6wind.com>
 <aXOm1Xep0eINPO3y@bricha3-mobl1.ger.corp.intel.com>
 <82710dcc-d2f9-4e69-9f5f-ac70135e2333@6wind.com>
 <aZL177s7Wu3vLsPl@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aZL177s7Wu3vLsPl@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DUZPR01CA0049.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::9) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA4PR11MB9345:EE_
X-MS-Office365-Filtering-Correlation-Id: 6940aa1a-a42d-45bf-4847-08de6d4f1227
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tEXMghn05+JEUGzEwgeurV3vZDjKoN6MFZclEcYPw155hqYJEVkOQjNdt4xI?=
 =?us-ascii?Q?z5hOdYBvNU2AH+aR5X0ov3MvDaNIALzvU1FbyfDEpNGrK/p9+JzzINMp+Ke7?=
 =?us-ascii?Q?h/4pJZLjE+opmJU+XpnmIKZCzPrQXCxMEIJsQX79UUINzXElFbFVwuRt6xtD?=
 =?us-ascii?Q?I4xbD7HTPj4YyW8u7GhzISe/hsg1duRmFv1MJSFWV/dEJEVGMvfkpQRJK8D4?=
 =?us-ascii?Q?kEnLUr1DDNJS7PxhJ3zNbtzJKqrUaVtpmko39mK2CK4ADYEVZsvNrHhvgKqV?=
 =?us-ascii?Q?rOxHP32nWv97MjA11E4ofkQPnJexJ3+95bVI5GhK7RwrIH5WSPyCIFzPPktz?=
 =?us-ascii?Q?+2iF1VM1HMFMtK4ZsdC/vfdmjC4TQTqn9HU2K/dnkgrxHcLhoL5ONdIXis7G?=
 =?us-ascii?Q?gEQdqujgzbEjFByxH2ntmpsfAbNoGXpckN/RvQD75puVNn9NuaQUPgufmk9M?=
 =?us-ascii?Q?Ur5tl2sHgH/eHmyHXTv8+kHtLGOhReTwrb7UPABc/QinAEnetihmEyFN86Vb?=
 =?us-ascii?Q?3IFwhgANFOb8tleei1ROj/UbGwPVfjJ76mr12hAIvqZ0+vSKfja2yvLyX1uR?=
 =?us-ascii?Q?WHadq1C5atBtvkl7yb5IJHrzLX4phyek4V3FMNcP2Fl+0gGVY/riMOS/Ur0E?=
 =?us-ascii?Q?Oc6C5E8/9dwBYDrzkx6P2iNBWgMDcEpanVtZdReDsiVCowjVelK4JSOwFqAb?=
 =?us-ascii?Q?RwUIxUxlEhklvNLM/eAdrUguHgcNvm7RdcEx3egccpDooR8WESWUIFQ4u93u?=
 =?us-ascii?Q?N661mcAtuBxlGywvCo+FF9eB2pLmOPC9L+jNYNf84zUKye0YywmRSfjOKJzq?=
 =?us-ascii?Q?Atlk1VYuUcxKejA93wiWK/0K98WHRLd7/5dVLF2o6zAvUwygfeIvhTTAztaD?=
 =?us-ascii?Q?akASyUWMQ1ugz7YZ5LY4wegYIx4EWb16/yxlwA4ur5SqQjv0jrwMjVKyAL1N?=
 =?us-ascii?Q?UMCtJhYBelzhmJrhcpmgyWu5U6Te/6hILnHLmxgdmxzgTOJvYA9TATAhnIqr?=
 =?us-ascii?Q?wCM1LPhje9VNHXkJfU8Nm3BgKtudvXFirMAz86YWOTADkSuHeMUB8yDM7z0b?=
 =?us-ascii?Q?a8fgnANWYYkp2iPBa+ymXmZxTIY8wenywl7191sB2MQnsSkgWp8uymIEkodw?=
 =?us-ascii?Q?hX+q/Gg8LhTtKXc388sZhniHpVXrHu/Vc5Jy9kyXlknlhEioX2NXRzxw3FYv?=
 =?us-ascii?Q?xgCA8CUaZvUqoLgXJgFmzhtpAEJabvZd/1G+VHw4U7ejekYNnPX8pEFhmO+4?=
 =?us-ascii?Q?XwU5eIN/U0m1YXu47ptSTtVeUj5WUXhT6wakQNHAY3C4Xt6Z/H2D3HcR/VDu?=
 =?us-ascii?Q?PPjPRmqYDY61oVLGPP1z+rjJ8f98o/CNzzkhNvVCFDsVjv4DRR1FmYzbeUB9?=
 =?us-ascii?Q?fisMR1wwgSkVYpCtLlmnuIKs/E2GHNjb8CdQIjDXwm3xibmRqXafGOKaZr+d?=
 =?us-ascii?Q?JgQ4CJX8h4Am4JHB7GluR/EKBHW/+N671J7nvZ97W7x0oeSSpvLRk+dTB4jh?=
 =?us-ascii?Q?uSQaKcRkX081WIpNGkQkmAzuw8j5hKpuqa1243vRUmFKludD20LG1hPDrFXh?=
 =?us-ascii?Q?/RTtZwMtxihNx1SaLuI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DnSGjPc7n7Srk9Xby5IAnUNKsLvM3TS+GHInHorYapjQO1FwuiqGbtFC78/m?=
 =?us-ascii?Q?U8xrURI1nxXzgAsX61pZn2AiSygHPbtZ4aRQOJD2RfgGjJZ0RvKxWEQwQj64?=
 =?us-ascii?Q?BsHVVD4htHMUX1sRcqu/fkCf7PSlFkNSutLtRrC4oWoYOH3z1kiE/y+ucXJy?=
 =?us-ascii?Q?jh33ZlSHhi5Sc+Bia+49gnLrGJnvgnvINsWdLvw7S3HErqpqm2QrBkx6Lsu2?=
 =?us-ascii?Q?34+NnjUYS07eqWstDuLRuX1KDvHtMec41qoWqdyD9p8hHv2mEF7wjgOSKxB6?=
 =?us-ascii?Q?7XXh1isFnKGG2REt4ACYXXwNye3W9oeBVexsULfR78g04NdDtflSqjbJgW15?=
 =?us-ascii?Q?D6Lit6V4Fh6B1OUycElMtus5OxXUf9xcjXjKc6XqOcVwOMo5xFk56dFsnKgp?=
 =?us-ascii?Q?GwBWFriR38XPbv4zzyqlGcB2lB+x0g+48DhlaK3R2bJYrB4VyToYuv5AhbDJ?=
 =?us-ascii?Q?4NP9z6Ezh1K3w8m7zmZESBRfBipfcKEvrfdT1Pa1gBD6nbCY6L4HeTRx7QyF?=
 =?us-ascii?Q?bxwpRr5QJ/8mVtYuM/5YNU1SNSHDmuEj7fLGL5R8uuBV57+EZvKoZc9tAYnY?=
 =?us-ascii?Q?S1YCHpTTE288m3x2IZDdBBYy0QWz7Ttk6X6o1zFDy92fJsFGJGuFN6l5sE4R?=
 =?us-ascii?Q?P0+B8NltfggiR+Od2nCgQxJfLzQj5q69Ic/VoaUlQFNAeWQ/mEfJ5yk0+sA8?=
 =?us-ascii?Q?iv/eqMTgZIhAjb+QQOi62/nMxc8HJKTBh3cuBDF5iyETk1loINc7ZDIXdqFj?=
 =?us-ascii?Q?G2uMose/wX5is5AV6RPGUb2m8cqptYzFN9nucJ1BzHr6NjvPf85I3RsfDLwk?=
 =?us-ascii?Q?sR/B/2rvQTbSjMfIh+GM1vwQFOTW45Pw4QowNbNR2IO4gsk7KzWlfNqVs26Q?=
 =?us-ascii?Q?nmRFbuGlHTTvhSYP7dFN37FZB+KrUpdTVRCjIZEVibmBu8gUx5mNmXLcwYYk?=
 =?us-ascii?Q?AVyPYYhW4J0T0dt14bRcWfrs3KHRwzWan9Ya85Y8uvGBRlDW8APSnLfbmIKf?=
 =?us-ascii?Q?pcev6w588psbGrrXKQKikIr2IJBvmIItG03VgMiFfo27oFXZb9FJ1xxDrmdQ?=
 =?us-ascii?Q?yGfV2Zl+XCKCes+vIPNP6HBZz78GgEpiIi3+2LJ2+J+u5ZY8Ypm6ylVxjgNX?=
 =?us-ascii?Q?zwyNezcO4vtHoWw/GTnK0l6dozwGO3+JLAri8ZoO/DuHXv0BreOTRkxqDcYP?=
 =?us-ascii?Q?vygBTe+GmVHDuwgfudE0eT+DQfLlYCeXZlXr7ziUIwtELoUOKiZa5A75iBHT?=
 =?us-ascii?Q?xc9NfjJ0QI39lJVzbxBpE+ge4cbVeS45XMSb+rkmJ3a+uJnPC6IMyznax3RP?=
 =?us-ascii?Q?OV+W8Fcgeg0CeDPFxec9xP1Wvkoaga1s54aOLjKbaZdSnvFoSRdxKZeCOnVh?=
 =?us-ascii?Q?Ool7LABfGB3WHKVLPPUQXpmWj5ezN2O9QV7WXfnCoFA8oRdrwXyvT6O3eHo3?=
 =?us-ascii?Q?DhZpSb6O9Up65pYcC0AdHYkZM/VXSBJqJ7rZFjToBN27spP3t51xu2/QmdYd?=
 =?us-ascii?Q?uBT1XwM15GFiZVVnFLtF7HyXN/MDSb4RLCU/Pqa566zkt7hRWXphJZ1h5TAr?=
 =?us-ascii?Q?h/7pSfdr8NjSrbijI0LkE2g1O/oDc1QiuIjZMRDj7WcwZi5R4dw148s19cwZ?=
 =?us-ascii?Q?TII4DYBDkvIB4FCBxIT3rJNkkVIvmgMy7zc/hpmtrtYTAFbKFbCgYZGQkser?=
 =?us-ascii?Q?fp2aH1cUYWvvLbF13lR97duTs1vPwVPYqlO2quapTd3nUPOlcs8qUoBksPYA?=
 =?us-ascii?Q?peBHRFKnBAMh4Z132r0vzwIxTRssNtA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6940aa1a-a42d-45bf-4847-08de6d4f1227
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 11:32:30.9688 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OO8XtKzCYUonzm2YkHoA0Sx/qomdp2tx6enD9KesulS+g5u+lAd/wvKXasUebpeLZ7JTF7oZ5ugMIK/kLvmtO6f7GcFQFiRFaA1T4908Hhk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9345
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

On Mon, Feb 16, 2026 at 10:48:15AM +0000, Bruce Richardson wrote:
> On Fri, Jan 23, 2026 at 05:57:41PM +0100, Thierry Herbelot wrote:
> > On 1/23/26 17:50, Bruce Richardson wrote:
> > > On Fri, Jan 23, 2026 at 05:27:07PM +0100, Thierry Herbelot wrote:
> > > > After an upstream patch (see Fixes), net_ixgbe_vf is no longer
> > > > declared in testpmd PMD info, when compiling under Redhat-9:
> > > > 
> > > > > $ meson setup build && ninja -C build
> > > > > $ ./usertools/dpdk-pmdinfo.py build/app/dpdk-testpmd|grep ixgbe
> > > > >      "name": "net_ixgbe",
> > > > 
> > > > Name 'net_ixgbe_vf' should also be reported.
> > > > 
> > > > One workaround is to move 'intel/ixgbe' as last in the list of Intel
> > > > drivers. This restores net_ixgbe_vf under Redhat-9:
> > > > 
> > > > > $ meson setup build && ninja -C build
> > > > > $ ./usertools/dpdk-pmdinfo.py build/app/dpdk-testpmd|grep ixgbe
> > > > >      "name": "net_ixgbe_vf",
> > > > >      "name": "net_ixgbe",
> > > > 
> > > > Fixes: 04f1b16c54f3 ("drivers: merge common and net idpf drivers")
> > > > Signed-off-by: Thierry Herbelot <thierry.herbelot@6wind.com>
> > > > ---
> > > > V2: use shorter lines in commit log.
> > > > ---
> > > >   drivers/net/meson.build | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/net/meson.build b/drivers/net/meson.build
> > > > index c7dae4ad273c..8d96244cdbb0 100644
> > > > --- a/drivers/net/meson.build
> > > > +++ b/drivers/net/meson.build
> > > > @@ -32,8 +32,8 @@ drivers = [
> > > >           'intel/ice',
> > > >           'intel/idpf',
> > > >           'intel/ipn3ke',
> > > > -        'intel/ixgbe',
> > > >           'intel/cpfl',  # depends on idpf, so must come after it
> > > > +        'intel/ixgbe',
> > > >           'ionic',
> > > >           'mana',
> > > >           'memif',
> > > 
> > > This is a strange one - did you do any investgation into why or how this
> > > fixes things? You describe it as a workaround so any hints towards a proper
> > > root cause and fix are welcome :-)
> > 
> > Hello Bruce,
> > 
> > This is indeed a bit puzzling: it seems that the expected ELF section is
> > present, a 'strings' dump shows no difference between a 'full' testpmd and
> > one missing ixgbe_vf. Still pmdinfo is missing one PMD.
> > 
> > The issue was not seen when using Ubuntu-24.04.
> > 
> [Not unexpectedly,] it appears that there is more to it than just missing
> this driver. Installing a centos 9 VM and doing a clang build and comparing
> the pmdinfo output to the GCC build output, I find there are in fact 3
> missing drivers in the output: net_dpaa2, net_ixgbe_vf, and net_sfc_efx.
> 
> Changing the order of things to move down ixgbe makes ixgbe_vf and sfc_efx
> reappear, but sadly net_vcpf now disappears. :-(
> Therefore, more investigation and root causing is needed to find a proper
> fix.
> 
Doing a bit of poking with strings on the various binaries has shown why
some of these strings are not showing up despite being present in the
binary. In some cases, the bytes leading up to "PMD_INFO_STRING=" are
printable characters, in which case the PMD gets omitted from the output as
the ascii string found does not _start_ with PMD_INFO_STRING.

Given this info, I'm not sure whether this should be fixed in the code, is
a compiler issue, or whether we should just modify our script to find
PMD_INFO_STRING anywhere in output strings not just at the start.

Suggestions?

/Bruce
