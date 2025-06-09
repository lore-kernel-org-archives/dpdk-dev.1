Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD33C5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 10:24:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A705440661;
	Mon,  9 Jun 2025 12:24:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id E290440658
 for <dev@dpdk.org>; Mon,  9 Jun 2025 12:24:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749464688; x=1781000688;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=SNHNWyQNJRGbZ2zE7QsUfS9mxAtB01JD4CxRuTikDs4=;
 b=klJ+vLBmIvUJZLYUE1IAW7KAn+p6iJduUOOcA7xvLixr7ekhxMyBIbiG
 nef8S+zhu+MVmqoB4Cw7SbWDvR5phhASyS/9VbrfZcvKcOavhheu5RXgG
 Y7myImg8rbZ6mU0LxrvrBPcNgrHO6S0cfPZAUbtLKtAJ624hKZOCpX/6n
 V1elUJzsj9FbNqqe6DEUTj/MTYy2CsK7iQ7NZ5K8fg7yeL44p6W2pE/0p
 YGZXeogVsSZ97oDX5FbrxX/rhbCLaMtlPuS/AWw9T6fuJmv/QVvMLvJZE
 uPtJnx7r/J/jKFQckMnlwALS2x0wiaPQ+P6xaJ4fejGEriahC8nPxeRLW A==;
X-CSE-ConnectionGUID: 1QQ7mAH2Twu9hg9gz1aUxA==
X-CSE-MsgGUID: 7GNTyAihSRCIaPg6s3wESw==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="74068291"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="74068291"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 03:24:47 -0700
X-CSE-ConnectionGUID: brYHlxIOR5qgUVj87vO9yw==
X-CSE-MsgGUID: PNL3OgnPQ2WffLEHuwjxNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="151347445"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 03:24:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 03:24:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 9 Jun 2025 03:24:45 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.64) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 9 Jun 2025 03:24:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gyZIOHsaR7tcmoAuFMhCkUJKMhPw7wPZunZ2CHWRWHt/83DFvi3qqapQ1zE+ektElPjSfGwJFZhJtxPRwaI7aK8KD4xMQnxfHD9qDLc/eX2rWaLn8bp3Dm0T5f5aJMjy3AovzObxwSbUOMh2bMPpAI6ShhaXeULhShNhNRZZ5cRPWfehKTCHGxGzcpe0pUuR9gjX9aRMgdpKs/mk4A4pmKJn3DlOlQaHl5ao9ZzqxQcYK7+lyCSRvz6nsbtzmGbU0aahp7vlxEPkxLpaX1Vgr4Z/nDO4o7tTHBI3F5zky31YKTtYYmSOxQ6DyJVxkw6SSudGG3YuVZcC47+jnvsHJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBMSNiX6UsefRgiDpOfbjg1+R3NHAQTxPK/TO05SyhA=;
 b=xNuWR12Bm2VVn+b/3gS4vMHx1JJXMr99w0MK3jGtqTUGdh1hQ8atmGVzGAqm1j2oAOw+0mhpe6hyKQAQAON/pXussey7eta3+up046Njk+6TwkoKWjeCKGdDJhPuHKpHc4BVsL2+n+VA7U7HUjEGXsp198//zk20L5XTlPZ/y1VsdG8tBxyMt8iBD1IwLC6DBg0TLQuEiWEC7xsyc8xH6NPLV8+AObZrUCNtbCOxlJ1qOrwr2qEUrmtWbL7HTvudYvRWNMF1gjq+hDLjyhx2SBmye2CyLTAQcuZANo3F1mwwFp/kTjOXTZYVxzg0nJez+y4fW0K8vu6x5Ul2NN1UjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB7888.namprd11.prod.outlook.com (2603:10b6:8:e6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Mon, 9 Jun
 2025 10:24:30 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8813.021; Mon, 9 Jun 2025
 10:24:30 +0000
Date: Mon, 9 Jun 2025 11:24:25 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v5 09/34] net/ixgbe: simplify packet type support check
Message-ID: <aEa2We4PzdEdIFPn@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1749229650.git.anatoly.burakov@intel.com>
 <cover.1749229650.git.anatoly.burakov@intel.com>
 <a1e038e421a1bd7a58b4be0cdec953223ef967f0.1749229650.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a1e038e421a1bd7a58b4be0cdec953223ef967f0.1749229650.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZP191CA0006.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: 11526ca1-1dc4-4bb9-c960-08dda73fd1c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/3afLuhkvqMpjb4E+1oULkfgN6yvC9H9EI4E4RXwnFUrICzSUDVpPHDaEW+H?=
 =?us-ascii?Q?6fITZceIF0Zgc0afZ3v+g8u4ifvCs4O4E+ZZi+8wxyYlXfEAe6jlXr3XzqyS?=
 =?us-ascii?Q?e73g/KWZA7tK1Joqj3PkL0UcRwbd6X+sNOYUIMvMYp0Qw7grA+zjU/pNdO16?=
 =?us-ascii?Q?Q8QdXkphjuP5+SfzgJ94hEktu9+l7iK8PwDyblsZ4J3jZdyTDu0M2Mul/4M/?=
 =?us-ascii?Q?pLtgCkPYSpXsC1s4KuwUZ0aGEcoDjsZSEPkC1vt8mhLnsAm6pcVSYgl8cf+g?=
 =?us-ascii?Q?HTq/GXp5BL3lfGw1ovzgHgHpX9e94g+/qtgdt2ef1hJS+LJ0ql5pUX+8ReSw?=
 =?us-ascii?Q?JyUCJxTuUKnQCqZCtrWqYMRveVv2hfa4AwjaQzjYTM2DpakgyxDCst7le6SN?=
 =?us-ascii?Q?rsMYsDuFtlhAlB2nKrhJ0LwO0kMRlx8iEUUzaHfuuLvkKDt7Pvu9r+0PZRTc?=
 =?us-ascii?Q?7VR5IGe6TRPwJ93Rmn8MIXcFyxar195qwM9xrRbfvxSX6KjCmd289JEwdZw3?=
 =?us-ascii?Q?Z3IopcqtHwbxqw4YL2duFdTv4DxgzTxgFke+s26IvQoRdSSKe0cvo6SZdsj5?=
 =?us-ascii?Q?V85Ba3g3sFjpvHV9f2uE+JWFpdTPQNwlfHuAUGsfv7EwwFjgqq5LaQTJoGnp?=
 =?us-ascii?Q?lLniT2EMQw3zxiNyu2weXXeOiiEaeEs8lt04Y+XvFrM9qA6U6iaa0PoRxxo3?=
 =?us-ascii?Q?ZcLKcND/rGglAdTd9NciUMwSUuxtq17yLB92Ee+5xYbtxO2+l10cFWJsAia/?=
 =?us-ascii?Q?pHLCg27X1ODsk9ESVuZiak4ruLh1dz3DLGEqJHVhqvoD51wDVCCB70BDxPd6?=
 =?us-ascii?Q?JgDrk7l4n4RSqHxC8HWX128FBH4V5VyBo5jG7XrmbQzA+5Yd+Lwdo4vBQuNp?=
 =?us-ascii?Q?ezZ+rKjpba3KjvwN6MGLCDRGJmkxiHma7rthxN2znpKseXzvvRY1vNO7Vp+E?=
 =?us-ascii?Q?dJnxjeRaI6hE/x/6NF8J/Bs7f1Yt98RZaiegUxsl4mVsaD7G/ZTKqebpxEOx?=
 =?us-ascii?Q?gZjCtOUCp38MHSaCZaPlhDde5oHvmpFCDrURzGBGHydDKQMoK7PlJbGzJbD1?=
 =?us-ascii?Q?+a+dVvkcu3LznYKnvM2amCaISmwMq/UyTaqlEO9Y+E7bGKopx79p8khFuH3t?=
 =?us-ascii?Q?kHzqngSMrYAuwO6gevcpQ6eVZj5CBeh/fg5MkFkmVl16RXY25b8rFk2V8+PC?=
 =?us-ascii?Q?UGlZg3hXuup5NzWKl1AGx0nsbtRlYq5TbtRdQw8Ot9D2aPjwO+n6s0OokboN?=
 =?us-ascii?Q?whok2ZrECHks9Oqe+x/Lx/uTVq7pXej0Vt7QqZ8dPPWhqD0uEoRY7HOnyd9u?=
 =?us-ascii?Q?DGAM7vGliEx2yFnti/zKNxckNVSxwWSh/zHFl8g7QVA84DAARLdK/ib4Fd7P?=
 =?us-ascii?Q?FWT+XcEv6POKfSVgmX1VNSqglDnrM1NaPRuMIKOkNCIDSpJqXDtCK3gG8V1p?=
 =?us-ascii?Q?ifUxGzzxsdU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6nhxHuEFn/34ec40Pktno/CG3ATTUD4V49GdZ7jYucmYfXCdB6Ok7F9QTi0j?=
 =?us-ascii?Q?vqIIB9ILMgpJtLvC4k/KOZFnfR6mQk2l2FfFEVJqQ0Id1zIUcKK2Owmy+Mmq?=
 =?us-ascii?Q?2+/nJkmiPd8+WPrYM9kV9MxtnMsoubHZT8GJ60ldeSVsiUymgMBAuFkc84z2?=
 =?us-ascii?Q?qXm6XgoASUl8og93QJwkzuuz4lxH2PndhyyFo1zYLCWvTi9LI1ALxHGGzUHx?=
 =?us-ascii?Q?Eb64cd0oKA7k8V/nHwHzUH9R/xOfpmLIMplg7vastNoqQxFOOBQKAI0HE7xG?=
 =?us-ascii?Q?TeG6392G6o2mtR/MChivp/4k8zPu/O5ZoXg6KvcQvzqaykmdBpqG1Jn2MrsB?=
 =?us-ascii?Q?BX2BCjqgK7x4XcEJKLVKZiGEgKuMjkNHd7GOCWwXGsL9BZkschRQBApuxdjy?=
 =?us-ascii?Q?ELcqR0bhJIbaGpjRJcOOCNQpTugCncs8mwjxgSFpkdrDCIuBZnyKfG9+yTg/?=
 =?us-ascii?Q?es8vldi9JDmpjd0iSatDvcOZBVWkD37YqvC1699DeZYfFAMFDpT86q2bDnkw?=
 =?us-ascii?Q?l9yu4Gy4tDl3uOPAWC1t4W013eeKji5N5VsqNOksykXqTWcSGbDBTaJonTi4?=
 =?us-ascii?Q?Gqr0V2czgpot+br/MV3FDU7tpxSM7Q3D2qnnZK9F/5iKyaZ01uklB77UpZW7?=
 =?us-ascii?Q?H4Exhpx8Tkpc6pbtabGJEX38iYaDVL4YXqVk5y4GxhHdSa0OVgh96C4FvTHK?=
 =?us-ascii?Q?SeCLYzX7dOvjxikBvMgWFVhfyZJ5/z0dSJzKzUBOlhTNI8IG7ideMAzr4/lJ?=
 =?us-ascii?Q?3iSbW3JSSZ1cC1mSnOLvvl4xgQLLCidaFrnMfSXsM+Nq4ivCEePbWgRCe8iA?=
 =?us-ascii?Q?t449FpQMqo0XBSHaR991GS5mvszh/AZ+Nasu26w0JuyP5kK0C4Aeh6jxauVi?=
 =?us-ascii?Q?vLvBdm25HmAeLOtTOpE9cCi+RUf5xr9vzJp6I4cbSgFw9KT2j6I2whrSL9M/?=
 =?us-ascii?Q?k6SzfMLvD+zCyO/xZzCfJ2j/TlKoNq3v40w8RhwuBKJF2KToIZZHFuxH3TrJ?=
 =?us-ascii?Q?vIYq1WqqP5TGyL69ugpvv4bNFTLKE3AYCQ0cT3IfKW1gYLXTQc0M5J5AduMF?=
 =?us-ascii?Q?hq5fM8IZSZBaOJxKIZgiFlrFNnxDwhb34JupWIN+HyFjeqHb/9LWceY1Mheo?=
 =?us-ascii?Q?k/PuWZyiaaQOCKvIbw1KpdA8vq8sHI/2ccr1RoEH03gR8kdy3u30399KF96h?=
 =?us-ascii?Q?9qXj0mRsIUXmaNpri5V77cejZhMGNzQA7AbfVPlE+JfNdEzdeVAlZfNutI1G?=
 =?us-ascii?Q?UOI6Y55bGcBuYvt9PmduyIgGw/E7BTetDgyacHnyvR3qKpvoIo3Xuplxl1dY?=
 =?us-ascii?Q?ntmobI8/vI+G3aGNHst+wis3lkMg+PAw8U6tgIguc0l371P+UVyDmpWpwYeP?=
 =?us-ascii?Q?R6ZcpRM8OIQpmnhdW8G2ckm3tQaeGfSdF6VjbgBdW98IAD2rjNJo2osRY7Yp?=
 =?us-ascii?Q?J8WQonXJx5hMWIoS62zvujxG7IuQv26/LNsYusuYNCOgkXNmnAsYbX5kw3xg?=
 =?us-ascii?Q?K+1Dwd9eiwNox+RZ34x5dbhutYlp4HPoAg1xWxH4cJW/Re5Em6ZpoMrP7X+X?=
 =?us-ascii?Q?1WQcDJ/3rg4j/iFJXyyY7DzsyLIoDImPuNZEbulUqFG+8WZyT3tRCp7l1Aop?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11526ca1-1dc4-4bb9-c960-08dda73fd1c0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 10:24:30.1858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y0X1qnM+oulffM0o2h7sJ7sUN7x0g/BpLCjFgb0Gjnurji3flXI4LnnuqYhJQ7+t3pWjJbB9Fu/Q3y6g8W0TFsEZRkh5cIreJYPRYQ1taiM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7888
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

On Fri, Jun 06, 2025 at 06:08:48PM +0100, Anatoly Burakov wrote:
> There are no differences between scalar and vector paths when it comes to
> packet type support, and the only data path currently not covered by the
> check is the VF representor path, because it's not meant to be used
> directly anyway. Simplify the check to reflect that fact.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
