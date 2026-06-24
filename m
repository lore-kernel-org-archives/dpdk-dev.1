Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9FFCDB47F
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 12:33:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79046402D2;
	Wed, 24 Jun 2026 14:33:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 967F6400EF;
 Wed, 24 Jun 2026 14:33:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782304404; x=1813840404;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=r75U0bmkL4rzKDX/X0JTqm2d5O0WHedX1qa1Gqra+BA=;
 b=idvHsIE9aJBsZKXysBeMsKN/a/x+yCpirOze9Os9PSxp2gqlL3R04q3E
 hU1TNGF5P07WRCxRRQ7RJmDGTfrHCtRbBnayRi1yV8XX72Sh+x6Rp0RDn
 3dDrwt/pYD1pjheZT9J8uEqAlT3C3ER55EaucbuOKlHfq/kw5fJ7HvFKA
 om609KN3zOCKDYNPhmGU/vVUyIOmDZZa6bfSscTnYfwABgOMJc66nJCSH
 O+AZJD80GEK364cT9Ewlh4Lr+ZdWAsZ5DS6bDOT96Ut1D2BJA2XTPf99I
 wj6BvZnkkvyLSR9g1Br0PXTN6Yn5OcRpClsx8S26U/L3TClBMrD9iXXum g==;
X-CSE-ConnectionGUID: EJK0e007QT6TUCb26tvChA==
X-CSE-MsgGUID: jryv2yaFTt6++l4wN9fJMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="70572750"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="70572750"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 05:33:22 -0700
X-CSE-ConnectionGUID: VHXQN1fCRNmxgOE4meP0Ow==
X-CSE-MsgGUID: SGPZk1blQmSYXTeG6GGu5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="245730017"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 05:33:22 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 24 Jun 2026 05:33:22 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 24 Jun 2026 05:33:22 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.7) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 24 Jun 2026 05:33:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bYWU9Ubm/9Xz3GseAVq/3ySglVLHaynCwX5CLBPMwjfzAtewzR7yEVODlJR3Bfly9eRzNV8VZQn1tfmfCtnT8HSb5tJNAp1hRtvLAZmwJNA6dP8qg2z1zoawwQVZcbuo81AdROOijYphY37Hf1BN8BzCAmzFRDx1wNy6nq0utl0/KGPyGJQ8SYt5G0WJpGeO54FWuzkoCrW8oc402AxAIi2TfUWVPuCRrixLgXvybXgLq6H3fVa0TQuu8dYk4yGggNrwIwQiA5GkHQaykJWEWCtdEgdsbPTW6no5Rgk4r/0pyf6ZrX8ibuGtgFlY3kMOsfpqDdcbJcAXeKWogGBowg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAHTBeSb/DWcdu/beyYV60nzPjx6zdUM6t+IinwFRCE=;
 b=D9XJ2o2Xb2Oz/RmSD9HueaCIOfRmq1S2P67hbxVZV+gthMiuBG8d3kFm22WHXyO/OqkyP6IDukezkZtNwqI4NqbWEkU3hWubsVRb+6c3lCJL8ftel3wie+5WvGMks/Jc0CDJ96fplfCth6rFV74k8tEWkxp3bG7iKbYgcrzWBct7YnHaX/zv+3ewQ2KeyckOqeNeHM/BeEaoQUfU/XpUFWW5MSDprntsXoAjTPJWZk43OyMNH6zPeV3ONMK8Yi+62/5Vw06YPy7vVu6XZAiz5reLJia0dHILCCMt8oDFXXITon4D209zBg/0RJTnjXmelkAvEtZvW9sb3wrAQDG5Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by DM3PPFB0F355549.namprd11.prod.outlook.com (2603:10b6:f:fc00::f45)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 12:33:13 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0159.014; Wed, 24 Jun 2026
 12:33:13 +0000
Date: Wed, 24 Jun 2026 13:33:08 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Shetty, Praveen"
 <praveen.shetty@intel.com>, "Burakov, Anatoly" <anatoly.burakov@intel.com>,
 "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>, "Wani, Shaiq"
 <shaiq.wani@intel.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH] net/intel: fix use of non-recommended string functions
Message-ID: <ajvOhJ8mYMKQ0AUI@bricha3-mobl1.ger.corp.intel.com>
References: <20260623112221.677931-1-bruce.richardson@intel.com>
 <IA4PR11MB92788919362D4E5CF700DACA8EED2@IA4PR11MB9278.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA4PR11MB92788919362D4E5CF700DACA8EED2@IA4PR11MB9278.namprd11.prod.outlook.com>
X-ClientProxiedBy: DU2PR04CA0066.eurprd04.prod.outlook.com
 (2603:10a6:10:232::11) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|DM3PPFB0F355549:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e4946bf-76ae-425d-8de9-08ded1ecc233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|6133799003|22082099003|18002099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: zayqlCNx3XfO6UHqz6hDSRNYsYwJroXrgMOcEZvauhqnnZ/LMH8ndQYdEqBtIOmcRroK7N0II9+CtCsZ85ohu7/RZerHmsBo6JjVl0lhkOkOV5q8gWjvdPggJaItNSGtjFQeuKSZo+VUdR9bZTCuDwEXxCo+/4LitDusfqFIw5gSJekanH/xNxv6u9LApjjo3kuctt7D/uuubFzCKvHEp54orfn3YYDPl9vaRkyvTgsCfI8Bq7jj/eldRVkLh2JQBPgRRIqaFvFZqqqjrL7AOY9gnU8uTnd0gD7cUzVScJ8NbKhTFpTIYHVEqwztnLtB/Gb6UudQSGGmyrT+CzbaJtL0jwuXE+LABtL+/lHHQVh36TeUCzWd3x/EMat9codvvVxDqla64IK/kjJVQKILKJV5ooG8VHXbFxBEJMxJF9rwDX3NDktGGPYIRVwn0H2Mgy+BT7kVJlPPdxIqoS2eTTTc+ZqBqzPt67AB5mJdjIod2LVNahWCRS2wWqsMhaADwYhdpzaw6McEVqUoFzuADaIKvM+/Pacvn41llifG+g1jrhITf8M6LCcHmrESV9Y+iaZGY5B+u1KHkMGh5ao6EB0UvCkvQDoDjvRUh+BSOKOalZx5+s+6queWklvO5sXOenVPYdKQSddA6FyEKucVdKl6RGbE58ZE/o8mx5e2+EM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3Hq2IE8+fVSouTJba6dCfSJcuKLqHSb+7cSmB00ALtw/NOUH8J5CAzkhk+0R?=
 =?us-ascii?Q?hbCGSE1/KHSWCg7304Xy4xteTydORfn0FimggB7rXmbjtfEEIljCnt0DqqSF?=
 =?us-ascii?Q?zJZh4jBgzVWPvwC7BlqqHOW2qj2KJmes3FzmmT1ulp+UawtNOB5HFAfSImHb?=
 =?us-ascii?Q?zbeC6ufb46yAH0v7hbH8icULC7y3gfaK0t51F3t6pS8HRp2WAzpAX4kCTfbW?=
 =?us-ascii?Q?ugl84pESjqI6iXGM3QEZFfbeyxvthc7Qn+HJFamDtLLv+Fvm+X3kPOks50eJ?=
 =?us-ascii?Q?OKEtHfMqD2VkpouF/FBdnDkgnb+2GIVBZszo8dceqhLjY2u3hk2WAbFdKasB?=
 =?us-ascii?Q?PaE+VA00zNP5b5rsxgf8uXmFpfrSTN3h9WtcJBVdC8tp6QAey+MMnF5mdUDJ?=
 =?us-ascii?Q?mSo5loANdr8uSWvPazom/HjLpC6evEMbpNN2uMXuQmx5IOujAtILKcmKT1l2?=
 =?us-ascii?Q?Dozm9suk6YT4kW7T1fKBTtfPljv8/scjEvLRiK1szGgD8wryKa4vdnF5TvEW?=
 =?us-ascii?Q?QmwoRLNIT4m6v9DjgrpSpGhmyAEkhOSJi4jF3duppIYNRakVWW9fO2vnAjua?=
 =?us-ascii?Q?pyZKfMns/OzTUQ4LF540YWN4glc1HElItpubva45gNfxgcmc1bUYj05s6sgh?=
 =?us-ascii?Q?fNmO9RcJj9UcFK5QoVOTV3puLS1MEI6DPiFRfQM/jHwqJEolsQJDW/j+yLYp?=
 =?us-ascii?Q?bH8rfwF8UtAI63/rT/6OUtsSyLBLwVV/UJ1m6JqAXKXnnFwWDTA1k+PXc3Iz?=
 =?us-ascii?Q?jdQNT8/gteq5pW6GhAbiWLktjqDmweRMJk3l4wuiidNPECwuYLmrzNL6H/V0?=
 =?us-ascii?Q?iIr0SRPd1aXRWzlR3XiWUWsyZpXSFh+ft9y2iBwjTcKB7rQJy4Tpph38aAWi?=
 =?us-ascii?Q?w61I7ST/yOGSgOWoHIguWLe2GsW+qIPev6a0/BA+5aEg6oPRVAncmEz7KfG1?=
 =?us-ascii?Q?dj6oIhsAutJ2G/9pnDslYhu9LAi3CKeDUw+loJX8qw4Yl4rZ5Twve8K2YNZy?=
 =?us-ascii?Q?3GIGbnjeIEwfceWK4cxPABPWxCVOnwuYYjei8QhyvcEi8OHa4oUrD9DQkxgR?=
 =?us-ascii?Q?3lirkkAHtB7iuxJt0Vxd84ior8hWew1iysmoE+Bz7/TQMHrA7uRagotY157B?=
 =?us-ascii?Q?riWNroa7v1bShi0SYlwFJh7y0ld9Xw12xXrLZeh9muU9qXG9DZLDligX5vW4?=
 =?us-ascii?Q?kuPnK08az/8X0c2xXZLy8zGFpl/JEJZjp8IW4D4pokafXELAawqvVIcgR8ur?=
 =?us-ascii?Q?+7oC0Puo2rPajhvQySjHykMYx1gZNLxmbFCXvN59ILByqp/BTVeg8Ilwbax7?=
 =?us-ascii?Q?1fNh/TNaOl3zDKI4gjRPzkROLoucewuv38FmLCdrx+Ss1fm0Z20YzAPn4flp?=
 =?us-ascii?Q?9/6qRuPcgV+ZXCDuldo9rlUXaZ+9r82Hcv8QnNi0qpOHEVD8sMrb8JRpE7/B?=
 =?us-ascii?Q?l4k7TaXIhkUYwkEvFLZS2xylE2CRHC10/XFHs8yyDKTQJgJHCXoevye4VuVy?=
 =?us-ascii?Q?U4QHjZjrVNGMcK4paLeJEWuD5HG6wFX7m7FOrvFEIYcZtG5mPnQC+2s+MPw/?=
 =?us-ascii?Q?II0QwV4p1FzxhzEPNVrKxjXg1imCt0yOKnLN1S4tfwKoHzA7U2lZUGs2RTzO?=
 =?us-ascii?Q?58pQ2/Dw1qsbJ4Bendwqdktm6MRslL9NJ1feFDQBZBWkcdofsZIzWA9jQ7Ek?=
 =?us-ascii?Q?7oOmUcFruFPWO0H3YGIO7xMC7xeRgrdsV1MO/CT+W6UN1hmpcSLGvx1Eh+xJ?=
 =?us-ascii?Q?FkGgpl4qN8gSluRSze3lkrQeM+yilsM=3D?=
X-Exchange-RoutingPolicyChecked: scNX8LaCVhz3qnXm880vq62iIxefAXvk3M/c+cvGmN47o8AEjvDk97yIPauJJgex1t//qD9vulu3v0j+9iVSIA24B44uCoLRFnlNX44F+DGe97Qq5jEkBl4dHEazM2Jni1ENnHBEK+3ib8DCrHIAiHjTv6QLRL3atFu3IbpUtU8SDoVi/bnlyRHF+JrxrRimkgWhw0yWFkg81y9HWdjMO1yxITFboWNOIEteyGx7dONyo3aaMLcFT4Jw554DeCtMywfzKvFJT2hFscGWLfVEOxE/A9sEknYu1oJC6/WUfGLyZEAsKLYyat7hWMXEFfoFtkaS4zwGIzz8anokDxJK9A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4946bf-76ae-425d-8de9-08ded1ecc233
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 12:33:13.5532 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +n124JwVgeRncsMhy/ghsCVb3B45wIftRnndxfImteXHLsTsxQWOSLGgrYrsXe4vLg4mETi8hX4pp//Bzucc5AoqFoBhlaTdMYKTgoVEhS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFB0F355549
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

On Wed, Jun 24, 2026 at 10:51:11AM +0100, Loftus, Ciara wrote:
> > Subject: [PATCH] net/intel: fix use of non-recommended string functions
> > 
> > Replace use of the strncpy and strcpy functions with the safer strlcpy
> > alternative, which both bounds-checks and guarantees null termination.
> > In the process also replace instances of strcat with strlcat where
> > appropriate.
> > 
> > Fixes: 2d823ecd671c ("net/cpfl: support device initialization")
> > Fixes: c4c59ae62793 ("net/cpfl: refactor flow parser")
> > Fixes: c10881d3ee74 ("net/cpfl: support flow prog action")
> > Fixes: 9481b0902efe ("net/ice: send driver version to firmware")
> > Fixes: 7f7cbf80bdb7 ("net/ice: factorize firmware loading")
> > Fixes: 549343c25db8 ("net/idpf: support device initialization")
> > Fixes: 484f8e407a94 ("net/igb: support xstats by ID")
> > Fixes: fca82a8accf9 ("net/ixgbe: support xstats by ID")
> > Fixes: e163c18a15b0 ("net/i40e: update ptype and pctype info")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Acked-by: Ciara Loftus <ciara.loftus@intel.com>
> 
Applied to dpdk-next-net-intel.

/Bruce
