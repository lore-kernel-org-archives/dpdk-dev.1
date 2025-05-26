Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90B3C54FB3
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 08:16:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A79B402A0;
	Mon, 26 May 2025 10:16:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 1F46A40299
 for <dev@dpdk.org>; Mon, 26 May 2025 10:16:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748247377; x=1779783377;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=QxjE5YGOWMi6XdPnh2kyNh4w3yfOcnG5a4KLefQGet4=;
 b=Rtp5q4e8eoL56uBGQxueopmVAiKwt0L4u/q+TGsJ6vxhUqzN39u/S0gx
 tADrP92LltbvPYPKFDxbPF1wqv0Pclw/Cu3hBbIZ/gRtw19x9Ch3h0wKn
 ldsvFcDjz32HDvXXF37Q5iOIVCI0hxxGNOPCGFM8dKi2Ft6l7bpNcJoL9
 IDWn6Whi5rZdTC9k5k21uhiA4A/JP/rK2BtAZveIaa7s0lRYIG+GOdLbz
 eNRAbfXAjceT/eKUchiXoeilIoDgJ/ZPzuMLGiigNlG/NodoPntVRkwMY
 OCrSoxq83fZ4hRaTmOjMFr74R+ezY6gcnI7kKSrhNwFXdkK+9nkAQC28+ A==;
X-CSE-ConnectionGUID: YCmvEvcVSjubbpaa3/QkWQ==
X-CSE-MsgGUID: DqNteQAeToeOtQ58VntCiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11444"; a="50322397"
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; d="scan'208";a="50322397"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 01:16:14 -0700
X-CSE-ConnectionGUID: phjCzm7SQce4RizF/sxuuA==
X-CSE-MsgGUID: tqFFMEquS/a1rTGNoqHUEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; d="scan'208";a="147425048"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 01:16:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 26 May 2025 01:16:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 26 May 2025 01:16:05 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.89)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 26 May 2025 01:16:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sjn8DktZFEHcd4JGNlbeuBnAwsY9ugILNl+HR7zO73/Cm3k4B03pwrJ/b+y2Mw5sdIVcEs1//Or8bhFett5XxZNniR10kDRblGXJ7cGvm6WYDY7L9Olt0IKyuSO+vnYFC2Wu+6HTC6BP46/jNLjAvMqXiSkmp2NT/LEXCMicmo0vemVP/wmvPr/ftkcWYaq4UjgjMXACpgLkqcWRZPRiWZGbBjiQQT003xtILxIiD2TTVMyVjdK77kRANB3hNoPPNbvDG/VJPpax5Srcb2OLLQRzlKKLEzR8XkoMjg4mF2QalJMSWENnmb97ktuqe/eKsFkOqcZVgdMzJhaZJGL56Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oh9X6E45XxlNuGEE/yTkDkjyc3VvE4Hxj0gi46vjCc=;
 b=asZdyBX7z6ZqLPFKiCrKO8f2ig04OeHyqQ/+7qcK6E1PG+/zuAoF1hu9/9tf4PBEbAZwy2aSLzVfP+NAiq14pbehGjYgvNIufdjhSNte1tPrbIW5EXPNwrMs3FAXIq8zDuJG/8m4EBlxv4BN7/bSSSJglii2YeSmzJbfnTw5k/xTwLqNX/Qh2YQUIk9DDrCyPf/LLmB4mmjejbfFJaVQYiJMJKIzfAl+uKliDmnIGK6O2vIHphsNcszzck6SZFEoVTYQDE50laGEh1i5O/RnLbAKBtL4EojeaBAclbLwyqgqjnMv2rJ6N0fsDcbIFItPgK2TxXi5+dI1EG6k3pwX0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB7470.namprd11.prod.outlook.com (2603:10b6:510:288::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Mon, 26 May
 2025 08:15:21 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8746.030; Mon, 26 May 2025
 08:15:21 +0000
Date: Mon, 26 May 2025 09:15:09 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <pbhagavatula@marvell.com>
CC: <jerinj@marvell.com>, <vattunuru@marvell.com>, <g.singh@nxp.com>,
 <sachin.saxena@nxp.com>, <hemant.agrawal@nxp.com>, <fengchengwen@huawei.com>, 
 <kevin.laatz@intel.com>, <conor.walsh@intel.com>, <gmuthukrishn@marvell.com>, 
 <vvelumuri@marvell.com>, <anatoly.burakov@intel.com>, <dev@dpdk.org>
Subject: Re: [25.11 PATCH v3 0/5] Introduce DMA enqueue/dequeue operations
Message-ID: <aDQjDZowik8E7Jfh@bricha3-mobl1.ger.corp.intel.com>
References: <20250519185604.5584-1-pbhagavatula@marvell.com>
 <20250524091316.10056-1-pbhagavatula@marvell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250524091316.10056-1-pbhagavatula@marvell.com>
X-ClientProxiedBy: DUZPR01CA0059.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: 97ec3e14-f438-41a7-901b-08dd9c2d756c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+iI9Pqp4pIWMOYHAnnsAA/iS3r/nzS7yhYC3FcV48DFzalb7m0mQ9Q0ovIA7?=
 =?us-ascii?Q?8VM+SlJ9xwXS9ctmZtqdT7ZzYurlQaqJcfv8mcl0zpOFSXR7aFW8I2/+uUoU?=
 =?us-ascii?Q?1NOLhJTFSeljdA2UL+MpynLA8CDRU4yyIGj29Sv1A1JZfRGL3YXUiQWTeSva?=
 =?us-ascii?Q?pAjbEe89Hbdc1MsgPbKjB5x7vOoJ5SlJw7c1EQAruV4dE83gWTWz28QGOTM4?=
 =?us-ascii?Q?Xp6+lMQiyNlwpEsJhCIV2UUmBbQY29B4O2eRASvsN4e5P9dp8G/sLtWPsC7/?=
 =?us-ascii?Q?dlOyunw8STGnK4icMnOeengpSn91wLz9nf2jDYwyKgfqNAJ2prIUkiwXeKdC?=
 =?us-ascii?Q?l5P+FpDMz3UbxqNM46m/clDW0vH2Bqwu0uqDVJY4atAUi8cs8mjZ9HIQb/q3?=
 =?us-ascii?Q?c6Jy+mf2aVAD1+Jpf/4TpnxzdOhzOOIxczqlOFDiKK2taKQSzm7UJJIa3+ym?=
 =?us-ascii?Q?JmGjs6v1DB/qFXmu+b38CknGtmjlwxjHNl2eHFahDXrwZOovwxhVs5c830yJ?=
 =?us-ascii?Q?oSrCDggbhvbltQYES4otA4foQ9j06EKG4P/A/5fR1VXw8MOqqo+Z0R7mWeOt?=
 =?us-ascii?Q?qImjv96iFAECtRA2MLskjefijxhmGrI6A0MS2F7iumok6TTWdatYUGa4kshu?=
 =?us-ascii?Q?0HvX5XYZI89Pf33fY32q3+0X8Sh2W0YK9AWhfuWrFZhO2JxlfMWsimodAev0?=
 =?us-ascii?Q?4G/H5SM++E1zNQESQFaXoA4XkAve1GdEfOQ6Vr41rQhTHs+c05MLZxL4SOfl?=
 =?us-ascii?Q?kQPIp0PQA1z/CCKZ0vxX0NqF/m16M8u3v3jYQvDS9YYkYZCNUBCHhDw1ic9b?=
 =?us-ascii?Q?2B5FPOhZbSnCQVAwYizfQ9EiyW343gsuFL+u7gwihlLG0Fykl18um1fqAGp/?=
 =?us-ascii?Q?k3fti+VC564P3LATcGBZqcRxQ4DNbdnXW7wKlGC77HaeteD0TA1PL53DFxbr?=
 =?us-ascii?Q?hNx/KnUfV4zCkR4sLgmtAZF4/+LtSEkNhCeuNmXOS7Z/qJ995r1MNQFlgKxZ?=
 =?us-ascii?Q?clMRVJpGctYQsC2qmYtt/yhe/7H3p/skusq40qemJijNTKQ+/mZANxj6VzTO?=
 =?us-ascii?Q?jQLb9uRsmD9nd0eLzF/Qp7EKK9vm0oSG2KBIb8ybj56+bdAMwFTlhpC3pECq?=
 =?us-ascii?Q?DrX1R/AWqcQA5c8oU/x6YN8I4HibYk2GtpoDx6iiX6N36LrAMDjzo+voENB1?=
 =?us-ascii?Q?fOKvd0RAbHZ7SOKcsBvYtFY6g3VlIOmtySXKSaXkT/N5DfZDkjQ1BH8R1u3F?=
 =?us-ascii?Q?XQNXSg0qrx8BFRqBc5LVyw/LutaBLULyNbXqcOTAKxK1g0LHCSreI4+V6Lye?=
 =?us-ascii?Q?eYLk0l/8yCrQdywJQLxa8oJcGtgCr5Ev4Q6c+6RKv1kG0wSC70VBumyRS9pe?=
 =?us-ascii?Q?Psh3RgHYShfHDhOKiaUAhUmVlZ83Q2q2HNuZdG3OOn5uMWAtepHjNym8We8P?=
 =?us-ascii?Q?oQ2bvII5/kU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hGBsFkM7bKZL7ZCyE4LFdlh002fGiODpUUpZSn80mCJkYR0UDK5nDyeQferd?=
 =?us-ascii?Q?a8w1U7cFB+HmgiZIulXADqYjwxZnVtiqoMQIYmsP5m2dwYlZ9aIUiFLdm3i3?=
 =?us-ascii?Q?QJXsnNuTmyzQvIm/7/uKhYB8ffdspKAJ5tFETeoNYZjKh8CnmKuXDWQ2lSCW?=
 =?us-ascii?Q?wU/BpXp4rZyC5rNUxeRZJufOpZ/Yhhw/14Y+JbilpaCHMZvs4X9BlY0a1aCy?=
 =?us-ascii?Q?ygCWMFLJafnzq4PNWbEiPS0oMi++VUOvNucr+TnUWTXoaNaN7V/qrsjlqZrW?=
 =?us-ascii?Q?g/bTJdbIn+GBLsvqB1R6ufTd0iJ9ioSjiZBY2eB9DJX1hBlWSvl9cocFKUS0?=
 =?us-ascii?Q?OUS6MbFMn67PnMfXWcAR36tWTVLciWpddSe4cnSyJECnEZ9gPx3MuzXkkK7u?=
 =?us-ascii?Q?0pDt6uMnd+7c4UkvYz/TzVfqcbXfibmoI/fqYnCURf9UqLLshy618jK3UvXi?=
 =?us-ascii?Q?VZ32UYAKtD5iQ4FYj/naHIBWiED+4BiL8xlixEtnWtp5sY3787a0/rXoFYBS?=
 =?us-ascii?Q?DCiict4TazfXEnc5MG4XxaLqB/SKZ3mo/bri2n7Q6Q57cWlck/GRaeHDes6o?=
 =?us-ascii?Q?Nyqog9HKExtO3jPr8eE0OQ+5uRZ6x7XIDwWGKZs6nNNc5Qz9rHxV1qNzbOEg?=
 =?us-ascii?Q?WCbRMefEHF9QiD+iszH9BM9wjM6ZNKplmBaNhYx+VW5FU7WN1EkgPcZzAOqD?=
 =?us-ascii?Q?SBwuaecBUOCqIDgGEbS+iGYSngaXOXyoxpJCRvp/GpZP2yO/aba6DUZ4TBTV?=
 =?us-ascii?Q?6BwiDqiPtbjmjCxOnQ96gGpzyEK8Y/6o9HgZY4V0UNlLU/+Myk4wvERBioc5?=
 =?us-ascii?Q?k1mZg8RP8OBZGpommKo5NxeZk/zAfhOzK34DrJ5NxrIVIBV6QlphtonSR2PJ?=
 =?us-ascii?Q?SOjbJRbE3pNpAyyf1xeZaEwKjIPuYCB1NdCTV6qYvP6dCXNyFNYhDZBRQ28p?=
 =?us-ascii?Q?7irtFBXi8YZZGSjAMVZMVJ3eSgAb8oujQUCo4ktLDfG5meDP7ysprcipDOH2?=
 =?us-ascii?Q?8PKy5IhXpaHBaziQikvu8RXBNLvkMaYSB+wod6W2/3IWkzQN9d/iKEgZinB4?=
 =?us-ascii?Q?udxDhFTKvK59m8s9nQFVW7yoo8cAyl1hfoj0fjEo+G1ZxVaGOkkRecYlV9/g?=
 =?us-ascii?Q?Z2yBg/YKEZkDCtQeWtqF6jxASvWYiYpDcQp7YHjXabwRALsVzTqyt22i/Og3?=
 =?us-ascii?Q?KqbMqBNCLOUzyKjar8qpXwSrow6467+r0vNBGVG22UoDdCssfJoVxs27oO6V?=
 =?us-ascii?Q?j5tIQURWNHw/YDETznlyott5R6BnG7H6PqRaocLq1ohM1zd72etANAlxIx2J?=
 =?us-ascii?Q?K5cRomM188Kw+Th4PVQ5CmUVVlISU//Xj0swoHQAZ6qBENgJHQkpQkcLJBnk?=
 =?us-ascii?Q?L3l9e82uzA1lghk8pgbCEj+AbSL7ZDyLzB7+V4lx4WCAWLbVjcdHWt1HHC0H?=
 =?us-ascii?Q?b7El8KLpsropv9aktCGhKyzARTRieNH0hztb4imPqiEAWZLqXQYipLB3lRMi?=
 =?us-ascii?Q?Rk7xqh1ENrlLHNU10qwxpTGELvtQJXWPBwPqgRMA32nFukqcEW5InnKHt/MQ?=
 =?us-ascii?Q?VfPKdpVeagHtC0/W9Q+krwkbqBxVrXPYlCbwZGYVpDQNi3MjKK9ptZgvrLbX?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ec3e14-f438-41a7-901b-08dd9c2d756c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 08:15:21.5596 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dn+IWSvdWCTlmojcrcKdxk5/xGC3jculcNN+9FXTh7Y1ESCjEcaegxCOlDdQIN0VXGnNHTpEd7MHO0bSAf+G9cCEMmixXAhhE9ICr4zLrTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7470
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

On Sat, May 24, 2025 at 02:43:10PM +0530, pbhagavatula@marvell.com wrote:
> From: Pavan Nikhilesh <pbhagavatula@marvell.com>
> 
> Introduce DMA enqueue/dequeue operations to the DMA device library.
> 
> Add configuration flags to rte_dma_config instead of boolean for
> individual features.
> 
> The enqueue/dequeue operations allow applications to communicate with the
> DMA device using the rte_dma_op structure, providing a more flexible and
> efficient way to manage DMA operations.
> 

While I have no really strong objections to this addition to the dmadev
API, I'd appreciate if you could explain WHY or how this method of working
is more efficient in your usecase? When designing the dmadev APIs
originally, we looked at using both an enqueue-type API as well as the
implemented individual-op-based APIs. IIRC at that time testing showed that
using the single ops directly was faster than using the enqueue APIs, so
I'm wondering what exactly has changed, or is different about your usecase?

/Bruce
