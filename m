Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8A71125807
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 13:22:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C66E4060A;
	Wed, 11 Mar 2026 14:22:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 08F6040B9A;
 Wed, 11 Mar 2026 14:22:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773235364; x=1804771364;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=EVLFK/AecT1Zjstjob1Zf639wCvTk4fVG7k7Q+UgSvA=;
 b=KpUwd80gjTrMaOfBc8E5lxYlSfgfRS32Cb+jSdad4Ks+RBwei3SM6Htt
 AuqFjl57G65OHqs+n5ye1zTLHOILSKR99Av/69jP3Gpvcic0uLQc3uj/F
 JGAQddzqvsL7NZCOB171HsBs38CeQFMRNEgWpZBObTl5CELL+MkPlv/n9
 Pt9HNvElngknz3zZxwfB79hwznV133BufBH3vThutVFSIwS2uFlw/7WUr
 EyP4uXeueuW+uKEYMGGf6d0T4PoLbp3hvyq5SWz7hxtU9Qm8khLTgI5zb
 nMfSz/1pz9DqJixGqwsnE9lJIqyNjWDrj5m7oDN8NbAHhiPF05YBYzJd+ g==;
X-CSE-ConnectionGUID: XeiVAnHdTbaWVjmpUZC6VQ==
X-CSE-MsgGUID: rkgnBv7fTzGpjmLX39+Aag==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74491781"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="74491781"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 06:22:42 -0700
X-CSE-ConnectionGUID: DnlL27k0RH6HRnLye3pxVw==
X-CSE-MsgGUID: At4K4MedTWOSSwA/yej1TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="220644124"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 06:22:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 06:22:40 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 06:22:40 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.20) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 06:22:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjImz/xchGW5Oj78is/gTyxOLUnk7wk5DqXsc8CgQB8mg2PT8Nw9z4RICvZBBxD5EjNrfCWZHf8gkcdeqWHKA3DvIelrp52JXNe3L5lxDbQyLcdu2lvPEbWeo1+Pev0FQxHYqt2E6AR1yOsmMJOCUwvEsLz1kXydhy5DRkF0bFYXM8y+eiku1zXE2LyauqSC9NSWFehcygld3izoZnaFVkFmxapZ5+rl3Sbu0J9p7cDdqUr2VgvjdLeJ316Y6XsLXeytLYpaGxuYVDhAbwmg+eK2l/K9pCbV0FBOfuSBBv6MqflnhaaEw3tOdHbhlQkIX10niJ7FmMLBiUE6nHDPUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8+uQzOWcnyP7J9RAKELupQ/QrfoK6cZ1ebbVa6yaE0=;
 b=MvifLoseaUaHtcTtBssQf33rKdIr+qft/DXSCUs/ktDgLZv/p12vGIZUP3noaVopKyT2RlTBnhBH0bnjAw1Lfl120s86ywQYW3NzYfyFFyb6e50LX4JcoC3Q8zcLq03SdGqMpJSd5n8oEtsFgi3M2qybqE1A/FJk6SdAX1Z8gJnxM7mPoiDplXLVqYQKPrnLeHqejWLWI5dvki262gQhBnDlRxUXRNj4BoA372u6MzOw9GvoBMo6Fr4zQiZ/TTY4UoqBEJfRUg//FtPTEPls/b+0X1xUq81uBzHU/d65KsJfdeS9b4uH29OHnax84TdPGZKQQJGJQEIL25j8ZmQR7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB7754.namprd11.prod.outlook.com (2603:10b6:208:421::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 13:22:35 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 13:22:33 +0000
Date: Wed, 11 Mar 2026 13:22:28 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] doc: remove references to obsolete testpmd flag
Message-ID: <abFslPT2vVsJ5q7L@bricha3-mobl1.ger.corp.intel.com>
References: <20260310104945.3271920-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260310104945.3271920-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DU6P191CA0035.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::11) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB7754:EE_
X-MS-Office365-Filtering-Correlation-Id: ce00b0b4-17aa-45cc-a44d-08de7f7140cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: Re7K3j/ynUpwdpgTxjUxtCGuAA4GUtFKbvRxKJywrtC5a2sVSIukfSy/VYiZmX6lkfqcO9GT1M6lkqnJ+6yzc3DwgphT2ceYz18MeGKWMkjYwhbThRlVwXoeaFi1ujpW1uq++LMGscEslhwOic1UTP3EU2popBQWenrmMADAGMdo7Z5Rg7XeYhwNADEdadAFpCCyNMASrnvicPhvC4FUtRtCthcGNCbhye2/8wnKpDpWmnbQuo72U/3MIVmkqGuGs1wF3Pwz8AsL4IiMS/Xjacpmx7cSklDVoWkQpz1Fa2FJEzgJhzJwtaRQzjQXkeUbtbi3s5MCK0inbnfL4zcA/1dDtdd4rb8/jSlgdtoDtlyrxxd2vQoivRqdtd/uUsOTZ6B8nFg5EsBDLGCS+Biqud0LIGI7juAsU9+yBB2Fc00szsv8+UyKu+1HaCvmsLM7EXC1sobGsOheTa9KIbnF8LhNLhnWH+zji9L/dimsLAc602kUg89Q0gaDe70l7nvaj8SEif97jSXGqKkGzJMCeSm+LfxMEh/wOPS55oJqu+zFhB6Mz5nplvEgpsXvbYBKP6sK+9yGsJ4dfcPCKGH0ps8XNPNbRZRW9yw5UWNwvBUCZOTJpgCMF0bMx9PZqqoZ8wGOu9fnWi3TdbF+PA3yyUV9O+Ly6zuudnfAxpmhqiczBlmD0A31rVGOHBj7TeHIn3mBtZ/j4MPr3tTAcRmLQHIKc9eDHpe7aB5etynD69w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PX+eywwB+MHbrBBAEw1dWc7qZVBI3nSuTJtH/wTogPlm02Y3QOtDLDyrQvyH?=
 =?us-ascii?Q?zqM9gq79afOBvuz/wovkYaWuFkInQ/kXHYn82BozrZz0OBvrrc6mnAWYG/kO?=
 =?us-ascii?Q?epxw4662J0mpgNJFqe4K1B9Q6H1rcHrJrbOkVPr1UUXe1cuTMTSG2X4qf0lK?=
 =?us-ascii?Q?DTkIMkQd1uvIirUR4USCBbqNUd4VnOADbLvMnmSqFayxwRL5RUg1OKIg5F8b?=
 =?us-ascii?Q?11q+u6qo8OFVmlaPxaU6Cy5gaNZH1J2jwky/zJsMYKdxwrqT3axOoVbF31nT?=
 =?us-ascii?Q?pEQNGN+l1Pq0m3aQ7PwoqId8iUgcP96o7kD6tI5/KAqNWFzvp4bD8tU+LLVO?=
 =?us-ascii?Q?/7KGSksGhGIt7of2XgdqAgSlh/4erwetvNxWqUwiLAYl9bK+8Eigw611WGXo?=
 =?us-ascii?Q?BFMAMhHEQ9xqBnIlVMhllGbU6HeqlF6mMlfiTL2iQucHAI8LSANv3x+eSVEO?=
 =?us-ascii?Q?DG/LVuKhdAbqutZloe2a5mF4FIcN/ISQX3Ro2Mp6tq6SkNr1cPzgNaMdIvPc?=
 =?us-ascii?Q?9usycKAmm/OkL5SYqepEh7axthK7USIK/FDXorX0IfkQYZNkR+7WZ5zZlDpM?=
 =?us-ascii?Q?QUfQPzP+KSQlzsUJt3g+rLDJQav0BVJN2Is2iO8rkqQsBbTAN5JxhlKqOSNk?=
 =?us-ascii?Q?NUJAxGF/q+MC32Y/BvpfLNQZEd970fgTB68DhXdgZiD1V7ueh8TIO0N6qhr7?=
 =?us-ascii?Q?wWGsX8GzDfdM1OtrLbTfKZDNTMX8s7u7fdbXqJw/TbY1ye+x7Cg8Dfqbzb3d?=
 =?us-ascii?Q?2A179UVwz52aqRvjZJa3HFDmeZkB7EomozOhjjldcqFgMqKIq/pnnl6yVdyL?=
 =?us-ascii?Q?oaVm3NyUihoPRfewZ5ouWHaB7KFKhv3/GlQsf2xi11BDsjdecyUgRBMWzgeg?=
 =?us-ascii?Q?7MeNVxNF5U0HmP+1NdQwYpsedcc4DK/3VlqMJxtLA3fvBSOx+AsSkW/QfGJ5?=
 =?us-ascii?Q?2pVxGkg/LBsqRpQ5OuaQB4jkCvTSN69PsYhkuxvyIvcEqD10zmEjUvuZfKYS?=
 =?us-ascii?Q?h4TYpUmSVzUsH3QbQj56Wsq9acs3VgT7GLYeeSFjIp/0vtO/VMCG8B5vcg0t?=
 =?us-ascii?Q?wS7sbGgJYDIMht03DNIo8g8jy0KgADEe/aL2zgYFQsqnpqWMbc9xsXxm4GKt?=
 =?us-ascii?Q?t8qYqTMSUTJJrCQbQScSL5O5fBcDCSJexBL8g5NrsgnLtUJB8rwghvNroFsu?=
 =?us-ascii?Q?oJVWBf9KGu7P5jPhQZJTFg/G7SMMyE8yOnr79ytuLxCefN7kDHWFpnj28R3N?=
 =?us-ascii?Q?BLL1Iuwb2MnCZ9xZ/mDM/HBXvc/fmqaT7PoOxpdmcbOf/AqFsbogbm/P0jzu?=
 =?us-ascii?Q?S+u5pnkWZIrBRizCXvV3g3cEg7fgTfJdxugChB5OSlAItuwfe9vg2hxzenoE?=
 =?us-ascii?Q?gJXHOOdUEBndrqnB0KCQeFzloofy9iNprUjbVtWMAvng7ChIGIij3ISBMue/?=
 =?us-ascii?Q?3L+TeppGM1rTVtjPDAKrpShcvE9iwEH3JjYivmqGr53bo9B7T1l6oNmK1J5S?=
 =?us-ascii?Q?2pEM6RXqreGP3syCBfosFgsoQCeddRIZzaZd4hjojd903198HSKc/U3WIV2D?=
 =?us-ascii?Q?9s+dbsMhc4W8sAl+c4i7HyM/9kj5UoQbASxDM5SbPimpOH+1z6dYRgs2ojdh?=
 =?us-ascii?Q?I6i4pRSbOseKi3vmtrY1tm7BFADpAfwmeM/2beQESN8uAZxysv6O23k7cwQx?=
 =?us-ascii?Q?rd9DTEVVUjYbWtXof5o3eryS9n8LX+mTDhli99Y7eF3auNTaZTJVtbXw9zLl?=
 =?us-ascii?Q?WWYk8NvhyECSGAGbAyDQoXW5WvF+PKA=3D?=
X-Exchange-RoutingPolicyChecked: M6PN0hN84BB8i2elpjIbbUGdinNjOZIYGUg1+F16czpWYsGx8STa6iRr1ts82ZcNP01jOVTVcZg1zq+ssegNuFDS+pF/j3KCaGQ3PHyzqsm0G0gW0Hidl/4P305CGdmj7tMeDD/2K7gExCauKtyOGleBxe49quJIPiu8LrutFlO9ndjqenPhO7QQRv0CAcn10Nt3Krzv7APl9xorJNs0CqXT3UHNI+QjVd5Ns4QzH7+suXsgiUXHs/zuSwTSUkQFcOTr6LNvmZ4sld0lRk+O65LegrxNf/YIgtPEVqUesiUGvk7NLy0Lu8xTZHwYM0at8ptxYqI8rwi8Iu3ums+HcQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ce00b0b4-17aa-45cc-a44d-08de7f7140cd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 13:22:33.1116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2YNy2bG6xR0jaxY+LRr8hvVf7wUrbl1YySpfU6GuLNLGENGUJvyFRRrnv2Nnfcl4GytLrQlNJvqUokRO4VMCRXrqmdrN2HcXcTkL7yevjLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7754
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

On Tue, Mar 10, 2026 at 10:49:45AM +0000, Ciara Loftus wrote:
> The packet-filter-mode flag was removed in a previous commit. Remove
> references to it in the documentation.
> 
> Fixes: 5007ac13189d ("ethdev: remove deprecated Flow Director configuration")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
