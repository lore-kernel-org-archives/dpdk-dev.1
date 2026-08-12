Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB948C5B572
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 12:35:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C1D040298;
	Wed, 12 Aug 2026 14:35:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id D4AFA4025F
 for <dev@dpdk.org>; Wed, 12 Aug 2026 14:35:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786538123; x=1818074123;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=Zh+KGTHiiadcfa2RwL2/QK11Vwd3D/SqfHw7XwYUCyo=;
 b=cH5tQYRr+a3QHLdxu+i6BOE2KK3WA4C8t8TCltjoFa6EAWwwdH14XyuP
 bSP07NZQ7knKYZDdx0TytWc3ohDRghk4nhuJN+2FMk2bu/pidZe/5/RzR
 2V4GrHmFaB9Ng+AXzRce0mt4vNZdFbSDzoiRZuTAGpehbq16SDzgb/Keh
 R6Y34OB6yq7FyrOfoREDqT6dqcxKzih7niv+I+dcxt5aTSp3497YkcxF/
 zVtcHce0Oclj3rAW1aaHq1ZEoH+97lSsHeJe71e3Y2FYcaIsAvj1CKQyE
 lp4fhMHzKuhCNWFQNAITZzbpjK5SmJvatktW0gawbDbmhH4MrTaCNXo51 g==;
X-CSE-ConnectionGUID: 0dpJWFb9TwOVbQ+c8CYGrQ==
X-CSE-MsgGUID: iKs45P8QQLKEh+WRog6ilQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="98237198"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="98237198"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 05:35:22 -0700
X-CSE-ConnectionGUID: UjSnYScxRI2CF7J67uUjng==
X-CSE-MsgGUID: sg3ZsdZ1SSylsVfTqQdwTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="267889528"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 05:35:22 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 05:35:21 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 05:35:21 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.25) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 05:35:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FlaNUjZPkrFDCLQM5E45VSYN9E2ouhFjUlfthhc+bISiz9IlB8stumwSB/t/VdtBuhK8T9iQy2LSdYlpuivWILys6K/GKyJUbtTh0K5dcHMTFUrG12Y0qVDHXnf670vWj5MJ7PVDe7d0fU36oQJ5HSuLVVRapmG/hI+3mmtWGX0k9aPuhr9cFG7IrE1FZQd0Fzet+nwDrZ1hZIBtwKdlrei/JQzPkY6U6HNieO5wDIA5hO1SQO/qhx4SxuBLfM5ntWBg0f1T74qv+BTZMmNP6Jg5Lyz3DUn+boCqriqZv9w1XKAeBlV4Mfv/u1ZZDGB+yU8bNTu6SpxyjWcVDKvBRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6L6OqC+ycBwRkraDXIkt8FS2XYcMCy7v7wDYNj9/K1M=;
 b=KJGbkjOt0WEUrnhZkrif8fm1IdqSq3OFWpx0Ucj8z4qLFDDufIgcRIZokhCZ8Pl2rTrISvbLxW93+lNz9ko95Glfh9rm7q5fdSzFcub5mueWd3seMiXfNDP8jRuiyNC33MpJLjffuLLf1r7AN69tkQ3QSH7aeEK+1UF8gdp14cbEE1N72gJ4r5UqTDWo58IuMJundco3TYaX4mIaCkkkk7F//ZGE2etQJwlMSsFytTZkZ7xw27dzcX89ES7RxKkmpLMW0SssadVDO/skLhp902O4Cf7XP9KkzMiTORFV2QByTWTN1Urz94TeB6Gy2KaDfjZeMx7Pd9r/9NjhS90fUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by SA3PR11MB7464.namprd11.prod.outlook.com (2603:10b6:806:31b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 12:35:13 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 12:35:13 +0000
Date: Wed, 12 Aug 2026 13:35:09 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Mattias =?iso-8859-1?Q?R=F6nnblom?= <hofors@lysator.liu.se>,
 <dev@dpdk.org>, Konstantin Ananyev <konstantin.ananyev@huawei.com>, Mattias
 =?iso-8859-1?Q?R=F6nnblom?= <mattias.ronnblom@ericsson.com>, "Yogaraj
 Baskaravel" <yogaraj.baskaravel@ericsson.com>, Stephen Hemminger
 <stephen@networkplumber.org>
Subject: Re: [RFC v4 0/3] lib/fastmem: fast small-object allocator
Message-ID: <anxofR25oKeYXAHa@bricha3-mobl1.ger.corp.intel.com>
References: <20260527173042.93867-2-hofors@lysator.liu.se>
 <20260530092634.46218-1-hofors@lysator.liu.se>
 <98CBD80474FA8B44BF855DF32C47DC35F659D1@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F659D1@smartserver.smartshare.dk>
X-ClientProxiedBy: DU2PR04CA0203.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::28) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|SA3PR11MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: fe2b0e91-5d09-41b4-a257-08def86e279f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|11063799006|10067099003|6133799003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: qRpz8wv6AMfuPrpsdZPGfrA98wyrFGeUkpkvCBMKRfxC1SS1Pc49V+tQ40CvFGs7OfD2248KcxyqWe20vZNnPDEtDVQcm3DXUi2SWdkh7oil/2EGquPbV0C2tq3J9dbL7yCanZ9D83l/H3YNwwJXeG+iLNGyxuuIn+ibjqRr5z8s6f7Wf5SZg2wGKzsolhEkvn3t977ltoCRPkcKL8cOJUiGCsiR+w9Tfbo0HmgZjrbKUgoEuZlhMRb5GLezmOYfA9CpdpW8v/DkIwDDClc2wKBPnafxi5lbbtILrZ3XS18/FxtnWKRPxM4jdgMRlhRNy/cB4BiP5RyyB2Btp/PI4ruuYjLnbzY7i7K+OstojS5uoDI0YNrdHnVBdEhwowH1rMhK7IHswPqTq2mCF9jT1/aj+b+F3R3rTl7SW3oxmBLNHJvvnDaE/xvz7zZbWtC9/u/drmDXmDLCCHLI6Hvnski3jiQZiDvlBprHZxgklxAHslll9pR12pvuHn+5mu09ZPLAKecOH6HKrib1RMhXoqHRyI58nk1t7XAPac3fT2o1ccYlBFbmDRmbwCGFmbWOt6o2IkmmVoCURb7Qylt7iJ7wa72S6QzsRAu/CRLpVj0bwhsdkRoA5tUNMwNoRsFT1qflhFV2+lBTnYdlTdt4v+sooqicVP4OiSYoT7cE4H8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(11063799006)(10067099003)(6133799003)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?/XTF3AM5gox/K5U/LFHUXwHPMPf6kBY5M1Di8YHEqTwpNfL7rJE+zC2lvw?=
 =?iso-8859-1?Q?E9vmGMtjWCpLZpGQcvrCLbC+oZvciN4lzgfPRWd++trVHIx9C7vo5+QWRQ?=
 =?iso-8859-1?Q?856QJdrZG90tGHJ4kzYKPzuVg5Wj344zr6diDbB/C4Q4nLXdz5DNigQxkk?=
 =?iso-8859-1?Q?2hry+HRptkNL5jlTXIo0ZdMM2SvU/cl0UxSrgulu6FafuId1UpHxMjtDBD?=
 =?iso-8859-1?Q?nWQmPVxtpQgE9995HO5I9qr4qbhzSiFgsyCmY7DMujyR8agms0IJLV9HKT?=
 =?iso-8859-1?Q?6RM4AztHm260VPyCmBkh8/ZDtpKXWE/RWANSvcXwudBZpb7f+/dNhVajuw?=
 =?iso-8859-1?Q?ADCJqEehaDAAXYQD31GsCKjGgdb5kaWkXu+ZS12Q/8mPz3smBA/AUoqIr+?=
 =?iso-8859-1?Q?E2LoEoZeik1pvLS/I9a2Fgp7Tv8yMHBB9ltek6EwSEdx3cy8ffUl6m70Do?=
 =?iso-8859-1?Q?8STIXKwZBP18nwCkCHq4NFpmoiuOnUTW+7+DHecYolgQ8hXzAmlLpyV6hL?=
 =?iso-8859-1?Q?v2u9y+jRGrNfzr1JylyW39FABQ+RQmymdQlGBA76rQ8wgdFAhJ3X89yUYS?=
 =?iso-8859-1?Q?+SpYdSNyJx8I1p1vE88s+8/Jqv9MmvN/EhJo22XnHy7ImXPTpIGGEiMJP4?=
 =?iso-8859-1?Q?Sw5NnORWi/1rk01AeIKV1mJPVvKjTKf7G9KGtyQ1Fi3rRKPZ2yrQo1AdzN?=
 =?iso-8859-1?Q?YLpwGkeQs3ZF0aimoLBTkY2/Za+UwvdIyMUsdAb+7fCF/GYIO5e+jfWClm?=
 =?iso-8859-1?Q?hhp0df+T+rSHEzIwKn1WGBYJj/NUwkFZekm+zTrTBeeY3FpLxyHPSBRqBw?=
 =?iso-8859-1?Q?4aPNjYNM96avuvlaD9Fds5kBQSPVcb+H1pMwhbNX4j2fdtVyl1xozB9XOs?=
 =?iso-8859-1?Q?fe70qXapzFpB3Xah3U90vZe8Aevs9w+rxDT6Vo+QvS8/WsoC1jnzatV0RQ?=
 =?iso-8859-1?Q?U+25zGC+7HOMYXdQzbVPo3i2KqeWon1YrxGkU/qFcTGbXXjPpXUajhEdee?=
 =?iso-8859-1?Q?fJuA8ynUTWUyMYLKFrc4BR+mp+9rxM8oz3itN1yhSqiyzIUbP1mSA7PoVu?=
 =?iso-8859-1?Q?cWggfldR/b6hRplkHHb2yN+5bGiVkQWOphqX7SKNP2N0c2adNRJGOchEA2?=
 =?iso-8859-1?Q?dq13iUSpMSkQNuqbHpTCVPd0zs2PprZyZ1SG1icmWFS92oyJgE1KkR2aGU?=
 =?iso-8859-1?Q?hH+rbSao6MzgMhLH5tihsmhlXrEoNCrhYdf+76EfOa07SBNG99haZGiV0/?=
 =?iso-8859-1?Q?LSgBT2p3hctuQ7doqGX9WpsRux8TfJdP4YCL6owRHmeOcjCZQPtJkft82n?=
 =?iso-8859-1?Q?zQM/G/XvUIiVyQJp9IOKMMVysBpoJWogm4u8BvzsqgfYLu2alpIeWPj2n6?=
 =?iso-8859-1?Q?6aQGKWFjEGt4sEg1uKJrHiruy2i0QB4VPL6edM/mOQavzn+4wF0ZpwIQRU?=
 =?iso-8859-1?Q?xcI87bbAgaCup39yCPm9ykn3MDUvtNqm9kRK65xuF5KhyZFBBVpdMZFFeo?=
 =?iso-8859-1?Q?qNazXThek4oxAMZdpefhilNT+lQZHLPcmvL15VkfIUf/4dL+qzJS2rVoXo?=
 =?iso-8859-1?Q?e3yP44m+H4Vp4nRQ4Y1BHYg2Zd1m2xKR69upFBhZsFE2BJltJTCFr5cAcl?=
 =?iso-8859-1?Q?PBMBlDiJPeMpfHmQYblGEM5UmmMXLcy5TvrdEGWR0jh0yzNMvKJ3bQiNIV?=
 =?iso-8859-1?Q?zsD8LwzJe2wV12L4/vuTF5/sx9Xm0l02f56Qxw9SRj7Tp3coaF8iSRxuU6?=
 =?iso-8859-1?Q?53MUFenPbMGXjorZEbVMzQf2oH+LHQ5Pmkk/elXZFxreGKpuuXwBAHL8RT?=
 =?iso-8859-1?Q?WLf59RHuwptsgb+dkaKDBdLxdTvtAOg=3D?=
X-Exchange-RoutingPolicyChecked: RP3R+yGt7RJElVydKHIcXO1l4ObcZNKilek+bV7H9MvMXbNqGdH30vpPkpqVJeYfiOem3HnKSF732ctuV9GN+vXFLPLesE6GJBOTMDWdTXVqP3afJe4oD3dXBR4JymkyYxh3kQyDGx+pKEdfB1iRn2MbgAXRvd7CalRBVYNLVemfS1Knaw8/Jyxfky+d5Y/kDpqnqeOKxxh0ObhC77iM9aKC7cnzVfeJl0SfgTtRr5X2Rw/PoIS4AQgYB0qrU4M3VeT//0WPVT+IA6fKjJSofNRYv2jVRYXtjLgUn8297BHKTdJ+3/9RDU2IYmnDVBJjNgDHscxKlGnbdY2EnSBudg==
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2b0e91-5d09-41b4-a257-08def86e279f
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 12:35:13.0825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GCocZ1Ma2wUrfgyKXS6tNBeqhnqesEAM1FjbdSBHj2kcwW+0Y77np8J4kt7dM/6NYvG5NZVAAx/I4gT/xf3BoOKP+hgjh7qd0EXN0R1fGfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7464
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

On Mon, Aug 10, 2026 at 06:09:59PM +0200, Morten Brørup wrote:
> > 3. Per-lcore caches: bounded LIFO stacks (no locks on the hot
> >    path). Cache misses trigger bulk transfers to/from the shared
> >    bin under a spinlock.
> 
> I haven't looked at the v4 code in detail, so forgive me if my concern is already addressed.
> 
> I am worried that a non-EAL thread can be preempted while holding a fastmem lock.
> Could this cause an EAL thread to stall in the fastmem lib under the wrong circumstances?
> If so, can this be avoided in any way?
> 
> The Lock-Free Stack has a solution using single-linked lists and a 128-bit CAS operation.
> The solution is quite slow (due to linked list traversal with retry on collision), but progress is practically guaranteed.
> 
This is an issue with many DPDK libraries, even rings and most mempool
implementations. I think it's up to the app developer to ensure that
preemption of non-EAL threads does not cause data-plane issues.

/Bruce
