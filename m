Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18780CCD195
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 15:41:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3ED884275A;
	Fri, 17 Oct 2025 17:41:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 879E2400D7
 for <dev@dpdk.org>; Fri, 17 Oct 2025 17:41:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760715717; x=1792251717;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=fPc8y8Iqb/rQaHtTySxx85Rht8Bavlqy1+nfqgwVxZk=;
 b=Ovq4dvTC6YujKadDl5i7ReptUGgnbHUHkaKsG1ZJTH1UA7BuUCEgTEEI
 hH3nFuJN8YETI7eS42Q92fk/NXotolpxH40U0fWxttq0PCl7bz4d42vw4
 7ygNtaWeJZjnTKDZKh6b6X9d6/Ot3EW5AwMOTLIcLWKzZ+Uy2msf2c5j5
 k85cvwlDp2vpyZ+cJd/LfPxM3ZlRlcVhVngkk61IU0FXO5aaxCIarXS+B
 sq7sBw08Cdh1GgfyCRz1hYUTOyexTICaYFIMngrni5GiBNn190LaYAIQD
 JgrA7QWjVb/ribJWH4fjiPoggHgO1bHKyUZIC+w/oUmWXipbr++F4wxxz w==;
X-CSE-ConnectionGUID: klp0viywQwy0Jo8XyN8s2Q==
X-CSE-MsgGUID: 7OFP+pBzTnOyAPryc4kdSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="50496379"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; d="scan'208";a="50496379"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2025 08:41:55 -0700
X-CSE-ConnectionGUID: 1LJOU7gJQEG2OUSf69LQlA==
X-CSE-MsgGUID: oerQVsBWQMawBY/6InZ75g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; d="scan'208";a="206465251"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2025 08:41:54 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 17 Oct 2025 08:41:53 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 17 Oct 2025 08:41:53 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.0) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 17 Oct 2025 08:41:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w1Cpx06SOmqcsXO7HOaQG0+V2wKoZyKRIeDW/6+NMfa6scVudn1Vx5Yxc4F9ShiTFKdaJxy9NL3QUw/efAPKZUCiBIgBqgxKgx7zltLJ3ulfpRXYYqLYjPiKHMmz2fpathKPzbWb3wqCCTme/Q/8CbrvSoqWa6lQ5onGoNKQy06/p21C8m0e3Ds3MiO3NCSfeOuNBm5uUIjdVT8Znxu0iImyOjdxnRRXv1LYb/8D61kMlS+SefnxBPEPsha4C4Kn5f1yNSLQbUxOtlmvO9XL4j3zujnzDUCeJgujQ15ZsFgqpauG95IfOmt9PvOy2kQSeRijhPo0zvJ67ciTDecfvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnz15HfBr+58wAGo2mLFK4Tj0e14nTjWu/wWMYepqmA=;
 b=eyeU7DhAwmEEvOZtGS6EBa6cCPurnCQIHzoY/O1S8g6c4YrToVes1S8iGqWGu0RsUYBx9ihvLwjv4BiFtelRDJWNbqinIrSXteqHqh6HGUht0XpeZScJc1r6yKpT2TK4etiCPd8JqscGm/3gLapUrBKMfP4Zz6fs+oq15ChghrJLQvTXCHRwFR614JtyG4jLNbSccCcGeVKeMwicsU7h1DBAZPOd+5I6j9CGC9WEJK54ATiEDrpIJGt+x5VpOg1d01Zk6kPR3byKPiEqJ5+AX8jn5naHN93wvzYJD67myP6vfm/iakVKqeqkJPjs5G6KGZQALku/J9LdRhbcw/ocWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB7559.namprd11.prod.outlook.com (2603:10b6:8:146::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 15:41:51 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 15:41:51 +0000
Date: Fri, 17 Oct 2025 16:41:46 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Sunil Kumar Kori <skori@marvell.com>, Pavan Nikhilesh
 <pbhagavatula@marvell.com>, Jerin Jacob <jerinj@marvell.com>
Subject: Re: [PATCH v5 5/8] examples: remove unnecessary use of comma operator
Message-ID: <aPJjul4Lzuqyx1z2@bricha3-mobl1.ger.corp.intel.com>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20251017150241.28511-1-stephen@networkplumber.org>
 <20251017150241.28511-6-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251017150241.28511-6-stephen@networkplumber.org>
X-ClientProxiedBy: DU7PR01CA0036.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::25) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB7559:EE_
X-MS-Office365-Filtering-Correlation-Id: aba5e591-590d-4d07-8a61-08de0d93b0fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DQOutI9+TPPgJ3nxfT4b0EGmV+z4D4dek0HdCHzQEReLcNfEo+8dBDje7lvc?=
 =?us-ascii?Q?K5k3nvwBV9B1h5S/5AcNOZIRZ+XBCqru9wt5JZYplvLZgFrCO4S702NyIT/m?=
 =?us-ascii?Q?tEjSLl93YoL1FgbgZt5LYUjYMA3//PIMT0nAFoBfC/zK/PeeGJ4wkQrrWFUQ?=
 =?us-ascii?Q?/KkvOVlhBWuL6ShKylOFJiJCOtQdHl7FxUlUzjYzfM/c5SN0l9ijWJM5yiYJ?=
 =?us-ascii?Q?+7EjrwtV18mrolFVHO6rBD+n4EK2nCrkCE07fA+njfNecCG74L6YXwhNHJR5?=
 =?us-ascii?Q?DKSUdEEhnEfnOUpecG9+es8N1a0gqz+AA83SIP093346IKw8/rEJkHfejeaI?=
 =?us-ascii?Q?xU6g3ckyvOQKdOfKmbgGpOjHcATDjbQmKJdxF7fiLm6t32Tj3QHB2FFKsWP/?=
 =?us-ascii?Q?PkCb68+cVLMt/sUrOFgwBM46YusAdlwWdug138qE5tEveKaHS9WVff82/d2S?=
 =?us-ascii?Q?MFwtzBL81P9ac/2frpQhkgFw3h+usleXxWuTrKst3eS6aFoJE/kY6fyqtT5e?=
 =?us-ascii?Q?QthWNIvV2eIwnPkM0Q+B0toWyb8aasFSMS9cluMrgfJYBPK9ILChnU9vJGJQ?=
 =?us-ascii?Q?j8CHivf185qYJlqs0lHnyHhSB/e95OUvJdmqFVu4BrdOH04yIeujGkYLG3ux?=
 =?us-ascii?Q?s8seL/ngoYz9Mj4CF3k+zHVoy81wnr/WD/hqb1TPdj+Lae+wzcGE5wplhXRM?=
 =?us-ascii?Q?8c+++FKE7u+2d6QOEq5FbXuLHZ3Q624NOHcc4V0rJE9xVz28lN64DAeymG3c?=
 =?us-ascii?Q?TtdR8WF8um7IDiM1OziUzahLANL6rpdojQodTbs4Z9RpFkXgEfbLOkL2WPbb?=
 =?us-ascii?Q?ftGjmlilSRI6aHUpRm0aDKBFDeF2dcsDJm29vNt1WbtYfMqsbM02S4PTfwB2?=
 =?us-ascii?Q?BWOSpOnxfOEFcx67N+NeYQXC50IBbLBXFyu2B0WSbpRenDYSYU8HCxM+5A2L?=
 =?us-ascii?Q?BmFr6ZwmpasHs41eVQSIUysD73Iyu0yVEQfnHliPdK9QfuSuXMet5ervLyiQ?=
 =?us-ascii?Q?DrWA1ejSCrjryvRHUr/fqRXqFjO03B0SzAvVkIFg8NC0xxmDddvPJcahussm?=
 =?us-ascii?Q?vOTuJ6M+jmtln2kGZdU5e4IHh6s+qc9712/bkKHbQnO80qSPUYXRO7zsCcGB?=
 =?us-ascii?Q?QjlMa08b4wwIhgx7+l4rwaQmVPazub4pVV7SPR3LRla++nhLJoxz8ALHsdaa?=
 =?us-ascii?Q?D+ighkP1C7sOlIdSObn9ZnQXLVLrVK1ruCNJ7cCcFecWHOU7cbwsUU7CADJq?=
 =?us-ascii?Q?Tx99sQaFsiH6GpyfhRgOT4g/8AYDr4Z5Jb+8E0CsWryRQ+rPshatSTLBV9Gr?=
 =?us-ascii?Q?uxh22AI9D3nYLcEIm8aUIy7rFMFEEGjjRZ5ID/MS8W61YA6yTZd4XZYwIbM5?=
 =?us-ascii?Q?s2YShSxWO3sSf1oQ8EiQzFqGRMCUlr6/HLuz7hv72XBQwM4vdS+d8wPMnw6F?=
 =?us-ascii?Q?j4o4cUiupsw3Elxu3+D7xCBsaHNYDCAk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bjl7dP6P2ADgHaFD0ssfwh0fbTfl03wFwJhUM7uVOvyn8eTf2+VMkoJJdTH4?=
 =?us-ascii?Q?SMpryuCbc4F7St7+c7tMGI4PxMt7FehXILtT746m0lZsCmq6WtgoapeMRMNJ?=
 =?us-ascii?Q?h5kueQ25YSGkVAY41NPrKRaVSFxGGR9Fg5FmQfM33DgIwK5y0KNQawzovaY2?=
 =?us-ascii?Q?b63aHHrQU5kcX598p51jkB4b0b1Co9Kf/O+44XtymHrITgR2wsrsC/LEusPX?=
 =?us-ascii?Q?N6OYJXTX0ok3SFEc/owiBBdSwItHuUnOitEBjnIXDDVzfpcL8Kt8PHlniQnY?=
 =?us-ascii?Q?akFs1ssxXAW7piHvMGHkzgDTY2/S627gt8vQORyO0yPE3iqCwLYVTBV6xYsA?=
 =?us-ascii?Q?3yo2VY88r57GSrCy6IAYv5jbBj4j67Uio/lVqzUyroGlRFgoH3KPClSrBAOc?=
 =?us-ascii?Q?gGihJrKfpOWVmb+oRebt3iL4D8MJi1xdn2wCTYkJbvwPlpqwiMKlyGut/17J?=
 =?us-ascii?Q?yNdTDFH1YL2x/iTlRCJnZcfdDZ9tPvPy1/mTV87Vv3MDIX2ffURXzwYZHt8w?=
 =?us-ascii?Q?7YRBDoMA6YPXioKwDFDSYDJ5qT3vNcYMq6cJTQD7lMkSd4S5RgTwbLGfVoh8?=
 =?us-ascii?Q?CypzN0iR5XiWO3TpW+skNT/n+QemssbL2EM5DIgMsAN3v0zN0P33Hp7T9Tr8?=
 =?us-ascii?Q?Jjn2CX0EAllGVxM3+qoBX5JA9Tv2c2wb9UzfJmWZW9LQgX9j6Znhls1RaQw0?=
 =?us-ascii?Q?BcmZ7YeYT2CrVUQBUM3Exi6TV6qVPtBEsx4lE3BouC77UVz+6eKoX1qUXCaK?=
 =?us-ascii?Q?NkduYG7H3LvzzXEYdRW29DgpgBtf385GbjSZ0tPJBNA43YfeV225/CSBGzCu?=
 =?us-ascii?Q?cqjFygAAANMXDh65JouWYj4+cKHf7aE90f13jUFwneFoHQsvolAKFwMocbc2?=
 =?us-ascii?Q?7c9FD4ClzAHk70ls7UmvztJTWZwHsXs0ov8Jsk/R4idJM9H/R5H3BQARgHvo?=
 =?us-ascii?Q?6TlhrutrUNm+RiphPjghq9NaawjzkU//v62/e1W/x+bA1zXUwdOf/kJlYZEM?=
 =?us-ascii?Q?6QouE7GIzF98pjN8gCfwrBb0HeO3mWP75VQXh8/gUOYhAt8Icv7Mkn9Lo+zh?=
 =?us-ascii?Q?dFoKcGEStPjFKiO+4zewIxF0Ee1xUSYNWxVz78FAlvSZHSAuY+eKBtKJgkQS?=
 =?us-ascii?Q?cjzcd+nq6SGmgcL7Lv+o1PmdbWnVd+OoS30McOq3I0w5190z4lybHrYbcdeX?=
 =?us-ascii?Q?5dScAq5+FboL6w1FMrInXVv2KN6JVQ8kfmgd2vco812ZobyveKP3IZ71c0jV?=
 =?us-ascii?Q?Pc9+cX5q1PLH1Te8zKG1vdb2bBIDTGycd2EqPbf6BeyG/0iRMGiUPZqeEHrA?=
 =?us-ascii?Q?5yJVxys+oZTG72o50z0m4DxRbNZA4Un4QxVCtnDsZUji3jsDGhEH6sBm/Xd1?=
 =?us-ascii?Q?pVv7mVEa/SZ9K3QrOpIV/BUAUgMpdiYhK1tss/SGqvQt+OFtGPtqF1s7YWL0?=
 =?us-ascii?Q?bwiugq8/HaP7VpZOGo7F8ahft2eaYuua7ZyA9PZAGkGiqESMfqXsjuTT34qs?=
 =?us-ascii?Q?cmH3T3OK1dkQgECXX6kxxbVsRxaBR3WLWYwrr8szs2XMq3uwvFbk319vzeDq?=
 =?us-ascii?Q?5yf3hmhtwJW6eQyDuXuVWZaJ2DP975bt4yyLKNsj/EMOjUhx1bYjtX0Q6DO8?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aba5e591-590d-4d07-8a61-08de0d93b0fd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 15:41:51.5851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: htgmI0nLj2rw5amjHw08UrhQ7VPfjlorBtE2otEtXKkziT7DjurQxNMhntoT+2QPBsXG+jgh9LmSO/Be/RB7/qmiOZJE2KMhugak+kNpqOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7559
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

On Fri, Oct 17, 2025 at 08:02:06AM -0700, Stephen Hemminger wrote:
> Use of comma as statement separator is discouraged and
> reported as warning by clang with -Wcomma
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
