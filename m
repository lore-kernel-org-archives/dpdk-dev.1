Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E96A10ED64A
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 11:30:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B359402C5;
	Fri, 27 Mar 2026 12:30:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 32C3840280;
 Fri, 27 Mar 2026 12:30:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774611003; x=1806147003;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=venpxzSWd9lydNt3d5E9MCQf48D+jmqW+UwQ8c6OywU=;
 b=C7ln6V22op5Yx9f3JyTT0Wq3kUTVTWQ+0k6PAMWaorsuoicjXyDUEDZk
 mFKjEFEYCHuBhIKRcu4IfkyoW3zI9rjB2frVzcTx3Qu/7j7v994lFe3al
 iqvTMTjAQSTOfTPQreUPmLJ6eLJc+dj8SlpeB9s/v3aYuwco3JvIMVdjd
 VMDHckPwugcs4YHjzTY2Cwcyg02+WZqyQvLoPiA4Zr4xCXG0OZA2OVe89
 kGYJgJOV0E7UyzPrBQ008l4v5GAu7d5biigchrCj3+ke8mamlKVl0Kao7
 pK/zA2O/m8WT33akqX+oQyTe3MefA7vrLO1K5Yk527YlF4sXduiyAkWU6 A==;
X-CSE-ConnectionGUID: t/wxkk8ITLOJFH0KZwZjrQ==
X-CSE-MsgGUID: Xwyd9psMTR6vqM9ovwYmNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="86302629"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; d="scan'208";a="86302629"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 04:30:02 -0700
X-CSE-ConnectionGUID: P5EN2wugSnm3YY+99JCWSQ==
X-CSE-MsgGUID: cgqFPBEoS2qLWa8zZA0evw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; d="scan'208";a="220896242"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 04:30:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 04:30:01 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Mar 2026 04:30:01 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.12) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 04:30:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZbP78Jinlj9pbxqvl4TShU6/TMWiUf+o+H7476U5ZoMxFBuc74g2fMmx8+9PXFI0vscaMubkjRjMIRAZn7fU+yezz1OzIe5kkFzg4vbg7SACLr/xMPO0i2yKHdIV51QjGy1r5Q7rCqsWNRY1oAy/OJXpwR1C8QC+LnaKKanyXXkXfvjyxwzKhLdS3WG9wDlRrt+Ts8DZCsh2fndaR118fpo/ABlGZxurGVPxXytccT2MCNyeHuOT5108brnJ7qjCR4mt8ZfDx1HVMsHcYWtePbmWNB0f4tH/pC4nYEA21hEZy4Dwy06GR6zmyTVyzOETaGk6Eb2RcD79y3BDDmFbRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3CP4zyczA1FgBkSKqmuK48Cag7a7HGGDga2v/QoUMQ=;
 b=DT5stAxwT4uau81qxJrXPes9gsb6fa4GwUL1Ym4UgiyJQLhc1qcadYQm9et2DAEg8znC8BxhaeveT2aWKpe2QOjOcaLLsfY2ZN+JlfmrMcP6ZDd18088FsHptzk+LxAJNp47xiZ/ZYbQJ1IynFmQwmB6mTvatdfewlvCTZW9VhwyDGgrBPu0GM5A4DSnfPFtxNjFm+Khjnb0GupE8hZrBm7Z+Gw2qCopO81Otewop1CEc5tHUmQr9iS/VCFr/HDxSjpIFso6qN3o22V9oXVRVcp1nKiySccBBDziwLN4QwqVuF6Whp4SVpck1Irkrw8mRkL138ENyYQ3sabocrrwCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH8PR11MB9457.namprd11.prod.outlook.com (2603:10b6:610:2c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Fri, 27 Mar
 2026 11:29:59 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.006; Fri, 27 Mar 2026
 11:29:59 +0000
Date: Fri, 27 Mar 2026 11:29:54 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH] net/ice: fix RSS LUT access for global LUT VSI
Message-ID: <acZqMkNeJgCneRga@bricha3-mobl1.ger.corp.intel.com>
References: <20260325163959.3968209-1-vladimir.medvedkin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260325163959.3968209-1-vladimir.medvedkin@intel.com>
X-ClientProxiedBy: DU2PR04CA0342.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH8PR11MB9457:EE_
X-MS-Office365-Filtering-Correlation-Id: 3318aa54-18f3-4f5d-0148-08de8bf42e0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 0PdUzDx7/OBQSQuCZbYVflBZVlQVi5hMsR65Yvt9UghGTD4hlBjMXfHCE6ABovLPTh7VnFINmbbAvExzWZ72QZsOK1w2KO9xunTcXq3FSMyelisQXehIRHnaJpBp8KY2QRd4F0OnQY0rBzgI5YP2Qoh994wpcYE0EkVCqtvIdSqKhH84uDL+OVElWLmgOGowSNsfQWpQPxl7KYkM74x2dR7+GBzdqqmyo0Tseu8iJ3ewNHqrBnxE2CFyW5+4DzWXO7NpJe9KyShmWW1+ZbD24Hs0K5/q3vVGqIBM5hAfYKCxSJJSNHV/JyeJygzIPGDQJwWuB4k/auhbu5/biWAg3C7oJbVNIfszaH6JSikkZy90rAQ7xrQJBvamJ4SIu7s8u10NQUxO+xdfyPZuWHEQ+PQUbpo4rs5FIcEY/k/na84M9L7kaMcL/walmhu86TIf0UV1m6vpgRu6VkeYQePdi08cATSiX0jZ5rWIqFRngXvVAZNp4PEyBATweTu93ZIp5fFvTC8TGt6eFkrTTHp8ULMBHQsqROWGAOC6fSY5sbez03NGwft/LOhG2NRJu2LW8/p+9guRqn5r+sGv67d1PuM6jLfpbhgbN5UINfwMP6c9yqY2HEczBETDhub9mdhkCBbu3+YVP34LKChr7XbBuGpVR7hsjKVCvhr4nULoPGjQ9/+8jKHM9KYJy4cZV6c04XLdvaN/m7iLCkcZMP3HMmPpU45HilmgiUxtz8zwZpM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YUPgw5rU1A1AV1Z4dXyn+rfGyFQ0tFvZo3qyhk4Yv3K1QLhOeZ6Gid7pf7If?=
 =?us-ascii?Q?+IYkUOXQmrv1NnP9SO7A1cupTImIZlLcN5eIoXBWy2IoVNIsqwPWIb7ies2s?=
 =?us-ascii?Q?MZsbpvo0JpmsXR2kTg/SNKWoJ34S2CTyIF+5aW+GcnUuWdZm7LUCs9rszOQ4?=
 =?us-ascii?Q?ZUAfQ0Pc0jJINfghPqKtnGR9s8vFs3GEils0/43YESxqf2mNTlD4v9wQGuAr?=
 =?us-ascii?Q?r2pqq552c6Z+KSs3csuChtx/EXRUwqHo1mqoyRW/B7HUg68IPLo8vraEGN2t?=
 =?us-ascii?Q?PU29MtO0g1D2ukp0SKDpqg0yy6NpY23dii4JZEo4tP8NzcOQ7bmLFbs1IAS2?=
 =?us-ascii?Q?7Xv3kOhLPZ/sCBD78HjLA8971Ym3Fi6hjU8J1oBUkY8Orcx2CVzu9LuXJoKy?=
 =?us-ascii?Q?JNQ/OJa4D1Kxl+vWmx8JQsbk9kiW5Wi/aGij7DgPWppEcGrEtV56+Byb1JGZ?=
 =?us-ascii?Q?RNDrHOZjLHyY/2p3jM/R7dK04Qya5XSdimQ74gSivvnWZWT2O0PL9auEietI?=
 =?us-ascii?Q?EwYaF+hHMysBLQMtSheFj1fX5+SoW/KAZFlYtBprUOmccg12L0FwDqDjaBWh?=
 =?us-ascii?Q?M84+XKvFa0Rh5nICfFt0UfZFEFeLb16h0jIct1yrg3gAf/QV4aVXGKafTpOM?=
 =?us-ascii?Q?5kR9/guXGgxwNXxsCYDBiWoJhkoweCIErwKL7IapbISJTTJOxv48/8Hf9U64?=
 =?us-ascii?Q?7wvAc754QbfJ+5yTGAakuM3JPWOhrFqjYcLA/NFio32ic5V/ZUPbciFBjBZP?=
 =?us-ascii?Q?Y7YpVgv9t2HOAFup+MydtYqPP4vObCciYZGF30ib+GlkOPCJJ1Up0YAFQYFW?=
 =?us-ascii?Q?lKjTXxA+j6+vw5KjbYuSRdQ0M/oyKgWF7Znn2RnLfqcGQH1ZNdOqST+rf3ET?=
 =?us-ascii?Q?B8m9pJZdLDMaruH0+EIwvX+ZSSnlRFWz+gw80Byn4MOHGbAQf92dxq4RpMXO?=
 =?us-ascii?Q?3GaMU7zMnqB/VWrdLfxe/hnjW1RsJ4im+pEY7iSlQMyvBuQAqrHOMqZjOyIE?=
 =?us-ascii?Q?GkFNJRT4+FBqnqxrNrNlbhZZd7aDPO7Tq89Ab1lZooYRC872v3fjYh17IQfL?=
 =?us-ascii?Q?ZdBrMnsi41hO/Yzg81Jbre3Faq3PBGS7uJEhnHGZkJpLkV/7qN8yBQZU2YTF?=
 =?us-ascii?Q?msJbtMyeelWPASuds+y6v1GTP4NyGE3fj29Ru4kpWTqw3ZIqx9sGR5YnozkY?=
 =?us-ascii?Q?8Dd3KH6nYpHjyJBMvOuRR4nZlCsMmSL1wrXCZNIuzoL06zF2IR6U3yFyvXYD?=
 =?us-ascii?Q?94pxd2hfKp1gzEnD8/L0IjbV30l0Et/d4NwshORcENBr/wMUlMCOepZ8Btmb?=
 =?us-ascii?Q?u65k1CFLByMsWWkcHiRQx9twbjlcsu0u7QWknFCfEbgKNYXC5IewrE6ZnciT?=
 =?us-ascii?Q?pIO8PHRQAToF+Wgmkh84fT6pKzoAVcHSb4cGq5KQFYYj1GgQW8DkaWYVYX9O?=
 =?us-ascii?Q?MYxEXP6mHCeg0VygEZGcn1M0TZs7u1ppj5foBKo68SrZWmqUFdgOznwUnE2v?=
 =?us-ascii?Q?rQDD/ghcpXhTyD2zQjuWsyt+KRbWUThRUZlIAudXI897yla1EKEcBZk9h9/b?=
 =?us-ascii?Q?U0Q5PDRVTFgy2nI1jnASGNAILo0azMHcEceAmXCNa3CK8tZVJPnyDPUnv6d6?=
 =?us-ascii?Q?WhvVECjsJlpLuGp24BUWemOwNQbpYjr67bIo82hKMmxOMsDw7CtAJGl8yMuA?=
 =?us-ascii?Q?h0MZFO/Yd+XMqj5jlDybepXrPDqtqblctpSbYFhu34DYzgj5ou7WBrolcyy6?=
 =?us-ascii?Q?zymuzxN6BSF67UiA2+Qm0ykQs+Qkeks=3D?=
X-Exchange-RoutingPolicyChecked: onNgE8e8derBY1dk9ODGFasBTh9pMIDTuGcciLhVOFbYNAf63jv+G6gUZ069ikjQOhnUp+TzcK98zEbsR7kGJrdExbNPQS9paNJlOgRtNKPwlcZv1J4ADA0/5V3QfIFM4/4xaWotYOyOYVSkvTRam/E57kz/UDqko/FZdJ5WFknve9Z1SGgwwG9pRaip2G7S8MI4xReuswxT4wcAhSzgOMkPnlMXDc55SQ/srSOfZFYy1JHkZAkYONh702QfE2QrmcE0d3EuV1m7ARxFNWfKUpphdjwnHZILFmKkdlvsK0x0pEOD28k2HNoSexLlo2g2Sd/a8R56lOskXZsdK3NRsQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3318aa54-18f3-4f5d-0148-08de8bf42e0f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 11:29:59.5869 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CoBTGR/R3U8Ar86ftYS1Bi63rVlyWVnMJJVm9q6xqpOzO//h0xdsoTiMiKXpWaRbpGXv68jEfLn9qXDe/a/ZdgbV4zuY2N98rsmcNk9tdww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB9457
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

On Wed, Mar 25, 2026 at 04:39:58PM +0000, Vladimir Medvedkin wrote:
> When global RSS LUT is enabled, get/set RSS LUT still uses PF LUT
> parameters in AQ commands, with lut_type set to PF and global_lut_id 0.
> As a result, the operation may target the wrong LUT.
> 
> Use global LUT parameters when global LUT is allocated for the VSI,
> and keep PF LUT parameters otherwise.
> 
> Fixes: 193a11ffd3e6 ("net/ice: adjust RSS LUT settings")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

