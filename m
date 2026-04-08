Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2082910F9957
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Apr 2026 15:29:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 440AB402D3;
	Wed,  8 Apr 2026 17:29:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 7A9D84013F
 for <dev@dpdk.org>; Wed,  8 Apr 2026 17:29:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775662169; x=1807198169;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=bLFU2O5wI5PPtqVrDY3JxvOMghEvPuUqbwTBcwfAWPU=;
 b=KjERVGhnR8wrNmaNBmXVcFH6fFmI50AcHmK9Cv4DYrZe+Es5hAIAF3EX
 umXVENFe0qlQRsDIhyqyUGhPjY2+vkyK/eE8FxKZpKYnhedEx8eTC1Gu9
 N8UoJGxjAAHDso1iD7uThAUvCfwdctfCtIAGzdceBQ6uv95X5saeGufJ0
 6Ad35MRjuuUIMQHPwuiug5yp3kfMV2ClmKq9YzfdPArCfDqpWRXy/7POF
 ltEjYVFDwWGACMLcOzcOF8Z2swdo+Xx450cmnbabh1hMvX0FrlLEfucux
 qv9xKVEiX1ohcrw0vVkyUw/IYj+7BPnUF8zri9Ji4OpfS87xIEEYczZfG A==;
X-CSE-ConnectionGUID: +eQQdH7XRzSnZnm8LsDlsA==
X-CSE-MsgGUID: DXrr935eSjq4tEnq5AhKRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76663710"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="76663710"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 08:29:28 -0700
X-CSE-ConnectionGUID: pjdS8zlAS4i3VeMKb0+7xA==
X-CSE-MsgGUID: Jj6i929+SUyi/tQIexO35g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="233377185"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 08:29:28 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 08:29:27 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 8 Apr 2026 08:29:27 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.47) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 08:29:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHyopvqyij/a/36LlmofkhE4bf4NMqGo0SqvTZGN4NfKAofdf4c8HdMQsBKEsnrwouNGjuaZEX5US+NyW+8h84tbuv9fCA3b3IllfX3oPVsVTKXyY9z3hWmhW/PmO0nYsQahJzRCuydMBlUVs+ed6i2eLXm8AODim3WJx3rYqsQ0rTltZSh8dOSMQnlK7rxYqeTsB3REbNESmYy0bUkmLwDbWJQCHBUUA52eiG2VS31njiLcT7XRlgoIiyGKMx8CgfIFAZ3kzLEZYggUJ2oCprGQHjRvzVkleaW9tqiKMguNcqURvASE/hj+gtzmYndEnVP+mmrNhtRQ1hbsyRGNpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zgh95KItA0Sg361xrXJVxPm1TOgi/piRJAIGYPPpeQ=;
 b=eJ6cvfZYmsJsxfZms38mzL0XobHRj7FE3GYfflrrtevjUZM4TXzImFB7XGE6PrVlwQBMHiMsy3pkvG0qLY4DP//RxbXvHUg642eDNNR9huaqYDFrz0TyknLu1aVaYTir0/Ety+2TatoB+KlBkvRzBIMMx0EOL95M1rWyIAlqzjburqhvV9yIWPnVMJkA5/34LPGRqscWkW9zIZIlWHRIeAw/U31rcFuYxrv//MDS0uhUsxAyXUSXY6CPwkDI+IOQEHVR7hdQa6k/FnTbXagTl74EFSu556lMju3qNjeSgGWkxoU5GBCWwmAdk1e6YME5wNQgJCWzNiV71jbFglWgTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB6215.namprd11.prod.outlook.com (2603:10b6:8:a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Wed, 8 Apr
 2026 15:29:18 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.018; Wed, 8 Apr 2026
 15:29:18 +0000
Date: Wed, 8 Apr 2026 16:29:14 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH] net/intel: introduce a dedicated idpf complq struct
Message-ID: <adZ0SpRI9xkfBRBX@bricha3-mobl1.ger.corp.intel.com>
References: <20260406044125.3170558-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260406044125.3170558-1-shaiq.wani@intel.com>
X-ClientProxiedBy: DUZPR01CA0007.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::11) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB6215:EE_
X-MS-Office365-Filtering-Correlation-Id: 9185de92-71bd-499f-f730-08de958399b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: rau0D2KczRvZSiVdKcke1/mUChQAQG8LCQg+VL+ow+ATcvN5mBVSrWRgbkhd9mXblp4L4OvX7KhevpR7aRffggxSOwD+NWgWPYiTKYJ9P/maUUaSsXOuKiRVWhVmRgyyu0xCF4Bt601UJ8EuQh9pN60QI5jBurw+qWwhoHSARJqiR+pTTjRDc5a0Citxmn+CaF69mK+EepD6TSd/EC50+Cb27fkaFhTHSh+7ncyC7Zbq8tewwUeDKKCUy8GSVt7FkRRnkuwf29vgQMENSVF2y+us5wvZgkoDPg8lJfK4ue79CU+qKrGKMv2aa2dwha1w5D52Fzi/kr4CecAu9s0LVzA6SE3wxQTkkCEW3ZHCBH50XRNbMWWNXm7BJ93BgbPc8CAONWh8nrEVzBPIljupjnB0r2Y5Sw8h9DJByzb8bfuly/CIELhaijSdXrNXz1pZqEj5+S1Gn8qk651ddT0VpWsIlf9eI29cQTTb2rbEetfJsojEPGuDXTxFjYx/eVmnyLXhLC2MnmJSA3gOw0+rsKwMgcNCEBEumbyg6GiLH4yEihacKFzlbwNVHfs+hO6eq6KVn0WQsBLwazONQrQAjRyYPZM/AJu5GM5wmdLBwByDiH0VdpeJoiVA3RNKqmPHtQu0SOyN5pzW4Db3IKmDxQfZ4HvFlBg34doM+n20zow1rJ8pDl8d9IkGIZPpoXGP7xJUtU16zAojUwfmHdfH99WBOHGqvCUP4jYstu1+Z8E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c/gVe4Hq8KyvMydZN9lri8A5wPYlHEppcqaR67kJ4N9ck2ja1zhueXeNkGtg?=
 =?us-ascii?Q?dnFBHkc8b0/kDRmap4NsVO1Ad+5FJs/xLHHqdOaNmKP6JsSSVABJ99F02QKa?=
 =?us-ascii?Q?c1wdddQ+ubaeHv5IdOXisJIy7eYVFju2eJ+wM6e8SSFLPA5SKpfdYWlR3Dp8?=
 =?us-ascii?Q?sGlvW9zU3/BRYNHAu7+bIDEqGA99aqfU/zo5ktxoNVjK/Z/kXmTswkLzs+fl?=
 =?us-ascii?Q?WpFy65e6SrrB05bm+cwYaZ/0t+gM+buDQcJ48kmFOBvby9t3C/fQ9RG5euDI?=
 =?us-ascii?Q?YZSATxb+FdoLvARTPsRoz44AI0UOVo+j3+nDcGCpsRgoJTxi4ivYi6gKPJxy?=
 =?us-ascii?Q?x6bi5FzW3t/EYkfwzutwtgVASRmY+h6A982p8V9UN0y8Ywf+RVJMMSCdSrtX?=
 =?us-ascii?Q?dZ3BSPSfLCanskzndhxlq6ODyQrr9xabIxO+rpfESWdMYwRTb1HmqcVuR3++?=
 =?us-ascii?Q?qInAFEGAAoBDDxeuytRs8Fnvgry6+QQySCraRt0TMa1g3/5ES1j3k1TmYfMj?=
 =?us-ascii?Q?eBVynFB9HxaOHrobbP9wZ4x9rRu2Qj2BMBriaKa+zxrc7+t9w2JjYCV805Kp?=
 =?us-ascii?Q?ETUR5Hyh73KS8ocpsgJuCcrYM+FTb3KT/SYqnh/6sMFwCuy9H+72Fayt0dLn?=
 =?us-ascii?Q?+Lw4WZlw85nXLEy4DkLlBQrvs0O+lDoGyy+3njvJUWJOykfBGDLw1NH4x6/A?=
 =?us-ascii?Q?GdXwEbpD2PadIfbnGnJ4Ec0ZbjMwUhXlNSYtsDi9frnfNwX2wqN7FlKhTbHX?=
 =?us-ascii?Q?tcMju/RAbgguN/qVLff1mJQvH0worKIZB9GqIuqXi3T13p88am7FLTfCXVRZ?=
 =?us-ascii?Q?s1+zKeamKmcvrNT2+Mc/S87o9mXWN5y3+OZRy1hHv6iRGuoWOt7/8lAASp+c?=
 =?us-ascii?Q?K49cvVk6JTVw4W1+9/vWjbMzN29uk80jgYbXvIODt1JpmERsewYAIhSbYW+W?=
 =?us-ascii?Q?LvExgClVcJveQzK+mSZizlXmukZMWNObcSN3gblwLxncw9IuEraTRW9Z28SY?=
 =?us-ascii?Q?Hi8hdunMZA9pv2J7/GGKYwnMexpdZTPJlasmaPMboFT69aMncHZmy14hvsW7?=
 =?us-ascii?Q?d+vXm26z0lvwDYOAskSoGgNze5LNIA6sig8Vv5cjTe+UcNE+m9FgeryL82gI?=
 =?us-ascii?Q?XFbliu5Wbmw3QlEJL45h4QYgkTmIGK9YSNqeceWxvkKT7oeOtn0bcMRMFK4l?=
 =?us-ascii?Q?frn8NZQhStujeISeQmv6fsSsgpiPAKJfSpLSInOyVFdl+AeFb1/bWk5+6XmP?=
 =?us-ascii?Q?rx+oLyTiY+6a09voXIsUZk84Wa8DpMpL1LsIRUl/394QqOFKAFcvGNycEImJ?=
 =?us-ascii?Q?+zCac1yt9Y5JLuEJRLRXZbmHw8zo2GySVQqWIXnbfPDU9fYlinkeonxbnVgc?=
 =?us-ascii?Q?Ye5/OyAWBXq64StGDA9rdgjv5oN97cv8K+8KZUbc2XCg5Zv2DGH/VztRGL3j?=
 =?us-ascii?Q?+GsC6wCfJqhia6i8MCLbGYalcP9fjXqPppGpz+s1hQ7Na/C/a/G706yli3mW?=
 =?us-ascii?Q?qgzdvHI7z8MHeuqCwDCT5cyRHPMcZoQ39JNtwCGIr6OWh06tqJBz7DCx5rF2?=
 =?us-ascii?Q?9OnSzcDri2/IOcoFE6Pbx1gYF5y3AnnNvWDGV7ym+JP6VVOG6iCfESLw0v5U?=
 =?us-ascii?Q?sJHW6vEU+xSRE12zsuSuz80s0Bnphfu7a6JVa7hbw0XY6KCMNiWdAQRSWVW8?=
 =?us-ascii?Q?KnqxE45iv9WLrdBcoS7SqUce7TWpMwZDs71hdrwXfcGEZx6nac+rNVkx9vml?=
 =?us-ascii?Q?EkOZVU2nxzUGCzoql3Vkc35a/Jb7wq0=3D?=
X-Exchange-RoutingPolicyChecked: MMaHJFf/h8aS/dxktTSfi5JCc+kq0qe9mUIBV9edEaBOyKCuRF58pmQB1fb+cUxAt11UrdmrPCYdUjXcltdsPCrcmVyS1mPHljAjiMMOFTIernVQOwSJWWkpGwUxkBUjAqnVHZjwVuk0O4bptg9kxkB4ncBphTJmP0SW/gMEtNIhyxf++TfDBP+/itFV3DW2l8fcMY3L1D9qPLXPwF8hnme1U0Q0Urkp7YyFvvnfpHDIjGHQffeOIDhBWv+x7rDBU/xI/MQvXri/xiJi3Kq1DIWAayNNTUip28x72L2FsAI1KweaQ9XTODFeKDkwP3OtV8DTHy1KytcMXMOJdnzwkQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9185de92-71bd-499f-f730-08de958399b5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 15:29:18.6540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IoLLcdWvuundI7yVz6jo9MPxmWJn7LwOVz3EYU+s/8ti+p6n4deIGwTE3Ku36FiBkYYhttN6uChHjIRMyuPCBCAmu4300gXmM4zqfWZ+zYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6215
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

On Mon, Apr 06, 2026 at 10:11:25AM +0530, Shaiq Wani wrote:
> The IDPF split-queue completion queue was using ci_tx_queue, a structure
> designed for TX descriptor queues, wasting ~96 bytes per completion
> queue. Additionally, the CQ-only fields (compl_ring, txqs, tx_start_qid,
> expected_gen_id) bloated ci_tx_queue for every other Intel driver that
> shares it.
> 
> Introduce struct idpf_complq with exactly the fields needed by the
> completion queue. This brings the CQ allocation down from ~150 bytes
> to ~48 bytes.
> 
> Suggested-by: Bruce Richardson <bruce.richardson@intel.com>
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---
>  drivers/net/intel/common/tx.h                    | 11 +++--------
>  drivers/net/intel/cpfl/cpfl_ethdev.h             |  2 +-
>  drivers/net/intel/cpfl/cpfl_rxtx.c               | 11 ++++++-----
>  drivers/net/intel/idpf/idpf_common_rxtx.c        |  4 ++--
>  drivers/net/intel/idpf/idpf_common_rxtx.h        | 16 +++++++++++++++-
>  drivers/net/intel/idpf/idpf_common_rxtx_avx2.c   |  4 ++--
>  drivers/net/intel/idpf/idpf_common_rxtx_avx512.c |  4 ++--
>  drivers/net/intel/idpf/idpf_rxtx.c               |  2 +-
>  8 files changed, 32 insertions(+), 22 deletions(-)
>
Recheck-request: iol-unit-arm64-testing, iol-intel-Functional, rebase=next-net-intel
