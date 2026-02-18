Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B923E9A03B
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 10:05:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEC9840395;
	Wed, 18 Feb 2026 11:05:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 6C89A402A3
 for <dev@dpdk.org>; Wed, 18 Feb 2026 11:05:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771409109; x=1802945109;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=P7llwfXp1AdGwWSefr4Aj/J4cfv3r7LiAefN3TBV5XE=;
 b=VJDI0bzUg08S+vCDbZBApd22O0pwrUHTBFV974wzoHiDcfgmVBpNRGoZ
 XxDECZiZUJ3q8AAjxqb0XNEsJq2flQ4NSclXTStydB5pUFBdITu6KvrAM
 LXp8xwAMScCWzJv3Yw2CdvRZpebjMT0QngJrX+lbaQ9r1+6POdUD5CWca
 rgc+oL3WjwFgjdEzJuRu474FvIvQlONSxPhXnLpaVT0I2ZgW9q/6WPyob
 qYxiPhIgWxW0Z3TUU63iTqU6Sszi2D7s56F0cbRQ/i+npu5mAeH1TBW2g
 9DY6/o4tRN8HhkcnfOaZSRv+/z4a96rBQPhbUEwfMlDxuI8gJvbcSn4Qh A==;
X-CSE-ConnectionGUID: a1GfBW7sTsuAr38W6EUm2g==
X-CSE-MsgGUID: 3W97MC3BTtSAhH7mYKl8CQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="60051849"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="60051849"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 02:05:08 -0800
X-CSE-ConnectionGUID: 1fh3u5dfRA6/uPU1/1WdWg==
X-CSE-MsgGUID: ppMPcA6MQN221buPoEbL4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="214005676"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 02:05:08 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 02:05:07 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 18 Feb 2026 02:05:07 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.49)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 02:05:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GestRW33FDxhqgnO3QQ1ARIhhqhN8wGEyOA/aU5FqAmkuc7Qaf7Q19/UpBck8NQBde5ZPbwuQFntxyXusY2Tuza8WZSJisTxQKbgATi63mJVC5yWEAJl8mbIduSBvi80GTaAF6H684izDyiqKrxvu8JS7niMzz8+8KvohLleOXZvxOfkoOpkYbU2oe+SikFPIdMwV/4g1oO29GP/M8I7ekurLsfvrKQmlbWFnLAm2LmK+/DMo0bCv838yquFet4Ldp/nYwEiBT+EwFdO/VVGahSbll8PitNMgbErNke5qsBYMnFkvVsh1yufbOCedGuIoOC/4xO8Tu7Ats400LjjdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1DGGXWkUwfqgwdrVYL4wSwYjYj3c4TABC8TxJraG9w=;
 b=B1B3hVkCAkhEFE3UUv99YcujE3UEGnhVowLePUlVQEY9K6768ND5M+jT0/q2wrC8brTUTp+z3dbqL8EdbWxlNLCToYSqzt43+p1Np2SyvKeOVPkZnV6EjZwvIOPfMppoxSkOXybMd5TJR88TRxZehv3OJvnJanSIeTFgFf8d67l8WhsNFZvzn+bU9RxcvA/ZFIHR5k5Hg/1Cc4ed0iaQgxWQctI5EjyqPV3mvKD0Ye6ykSJila1S5x074AsDJ06l325f860of+37LyXXHEGGbxjpp3JIdFekw8L2LYHBgYItS43tg/pDnp8+/VgMoY4txr14kZW3IjSq11/N9hIXZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA7PR11MB9542.namprd11.prod.outlook.com (2603:10b6:806:4d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 10:05:05 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 10:05:05 +0000
Date: Wed, 18 Feb 2026 10:05:00 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 05/10] net/cpfl: prevent Rx path selection after
 device start
Message-ID: <aZWOzP9N1WgiUFSp@bricha3-mobl1.ger.corp.intel.com>
References: <20260205124627.371733-1-ciara.loftus@intel.com>
 <20260218094937.1652391-1-ciara.loftus@intel.com>
 <20260218094937.1652391-6-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260218094937.1652391-6-ciara.loftus@intel.com>
X-ClientProxiedBy: DU2PR04CA0268.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::33) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA7PR11MB9542:EE_
X-MS-Office365-Filtering-Correlation-Id: 84079bb1-39f8-44f0-e63e-08de6ed53098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1rR6YecQA0VAHrDAB3OKBijRuz/oz+nTbtSd7BPef9qoChqsN9AOJEACWbhy?=
 =?us-ascii?Q?yjR8YMq1IRWpPem8LdIew421j03Vv93XEqIjpubNYIeQoHZpl4BCKbsN4RGv?=
 =?us-ascii?Q?nvq18zlrv0uX3H4fxqT1bx4tgr25t6taOrsI5atZ6aC2RvNbdkQU7iuoVuhB?=
 =?us-ascii?Q?4GyfgZPtwLBSPoJxEBVR5me2kt5dE0KlOf0Hj9qhyHKSNZwb2j486YgOZn9I?=
 =?us-ascii?Q?GIHJ1HcjZlzCArUAw9bVr2xnCXTofk3Z2RHCADNY8DkqqEeKoZSTxYvX1cp0?=
 =?us-ascii?Q?OKxffATfjFEoFg83BxSfg7QgZX6nK5wv4d9rjHT9eqfYfvs+L2I9W69J4maq?=
 =?us-ascii?Q?naYQ/CNPFq5FkioN4F99e40exVtXYzPhCOkbzv0nshV3XsiRiRA+MyYg9wWw?=
 =?us-ascii?Q?HxXUnCpqPIJADMUNM+VJEC/vB/C82JdrnS4aYUukQJySjiUJ1JkpR9yL8gi8?=
 =?us-ascii?Q?eqIJN0OkjhlfezLsRbNc5F8VxF3HzCD3DCK4yo6RdbJvCYQTTHIT5jXLHi9z?=
 =?us-ascii?Q?DISqQhiLJH4QOfsrkckF5UFXCzCdM/DgV1S4dnvtSSRa82RL6DexKJyqdda8?=
 =?us-ascii?Q?ocBMvoW7O/0+3rBS7yvXDFJnb/AJsdTmmP7sSUydiDAoIsHYuSMFlYnUvYD+?=
 =?us-ascii?Q?0pU3JAlsfyIFYQPZWci1jP5CiEVOS5B7E/aHcEyG2vivYJa7Ln3Xa1g+jSHo?=
 =?us-ascii?Q?24g9fnRCQYgvjmgQ9fFRnJ/fpn+eRlJp6EO9CreSC82UD/WAitPCaNLfUSdr?=
 =?us-ascii?Q?4LFSA1DXbQE4bXghhGlqvCE82z1YzgBRqkAEbN2Zofj9IaiewD2FSheCl7Lc?=
 =?us-ascii?Q?eEMzvtQ/ce4kv6WXuocMFFfSTGEw1SWBmu3tyJUQld4Au2ST8kx/UXVMXo0p?=
 =?us-ascii?Q?+dvV9WGSjeALVT1DGU47YgbhrrxVJVwg/c9sbQiavc5xKoA14YgHnSUTB3Ec?=
 =?us-ascii?Q?1WYXkIcnWkYMmGnkw1lYiXTb1W94AsXCg1D6x7jlX23tYUlTj0RHsEdEJj1k?=
 =?us-ascii?Q?hUZtIN+h7VNtx0Z/+vbklQafSjFH6QJNgVcAK3x2XXd4jzXYAgmVxQSlWtDf?=
 =?us-ascii?Q?Gn++fZKYP9RB9Yl9uwpYAVj5yKOVdKJdrVJR3n9sOc2g6/Kl3EaD1BYBFw1y?=
 =?us-ascii?Q?ZGIj1FdLeIO6cbiWbCfPTLYPgosIhKmNKtyGb80NnDoUA/krw8zuN8gcl9EI?=
 =?us-ascii?Q?qSxuOY6xEHJj7HXSAwnQn1R3v34NnAuS56ojbNaxru+EmE+Mx32cmHfn06ZD?=
 =?us-ascii?Q?Worwby/t4QEWyuWv/eXsJbjeq/FfqmCV5E5QCUPo0IbOuPlcOcmmmazwS+ks?=
 =?us-ascii?Q?b2nt4z7rhngAAIee+Ngcvi5Ug7RPQ1eYgeD4XPl0KLdyPq/LWYxXxwuTroR4?=
 =?us-ascii?Q?W3BfZJ4uJrcWIAQfxu8GMQ9jO+2tCa4QGRYuYhe0Fd7GH2wVBrf4eqIQf4e7?=
 =?us-ascii?Q?FIL6EfETBN1+a3pEi5+5TGywrBVFxM+t9NWnnG6k3lSa+47QH97QueC60ztb?=
 =?us-ascii?Q?eZSQ8ab+z4k4byYQBFcrdQOqJfFqyR0gpyRVct5EXpURc6IrwR5acDFRDlpy?=
 =?us-ascii?Q?jYRuWzY6/SVr+e3Kkjs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YTUTpNe9OfBsdr7LbUoqqx7GETBfdNVBpbWw6+iojGvQvmwZFJIBdbpDNCgS?=
 =?us-ascii?Q?b84UUP7dHI4m6cse7d57RuB3pjfYqIF/jqid7KrPyOau8P48W0dhTbNkevTD?=
 =?us-ascii?Q?gtwP6k6iFlWAM0LYEMB5tJkjmEzYbD6kVOEl2/tusvziS4VLtGDzXAseoaUI?=
 =?us-ascii?Q?ujhcp5MEfrmPcexLz2CmLlU68feY4NS+sUnEPSvVqVvomFAMp8KOz1zu68+B?=
 =?us-ascii?Q?VjCMzBRKs1ki9NCn+cGH4Y4Y00OeZCxs6ZASSJuPeq5O+jrA7UY/qF06KUuB?=
 =?us-ascii?Q?dT2NQ+LNOV3Vr5dZYTr9vQiW/MWWuiIl3lwUB+S+vcnfElNDktV5n+64y0Fk?=
 =?us-ascii?Q?ZaK38PydAgTuiLEKXKZcr8hTs5DkE/KyIcx4U66vqcQfE9SrZzY77wP8jIGa?=
 =?us-ascii?Q?ZvH/P/Q0u9XlpVy7JJGPg2NLlITv6MRaBH9MtahCyWMYzW+bq8roHNx8+gtX?=
 =?us-ascii?Q?pkmUH6OV86wwjXX5UbDXcan3L6otuEcGSFEE2vTA/yqJhEyc423n23eAa617?=
 =?us-ascii?Q?er+aKcoHjGEZg0bMR+W4//HaWpD11lQBnhNxyx+w7mLkQXSLGci6FL69F8My?=
 =?us-ascii?Q?Saph5D8V5Pb01swxqMaTFsk1en1WzEWboGZgl7GqYeQ1Px6R4ghJ+JExpWVh?=
 =?us-ascii?Q?Z38eJQWys8p5/A7CCvmyXWkl7UZnzJV79epQq7cDFgxXRfTVosjHS2KHCsZ9?=
 =?us-ascii?Q?yPocdq6ao/vMofAplU/bZIFDswASMcC4OVQ2BKi1gRoAbB9Zt4riAvI5unW4?=
 =?us-ascii?Q?l7jML38z9/s0jy11kJsscZ6tLFiu91DwpZNjbQa5y4oQmnYOav5JXNsuhoI0?=
 =?us-ascii?Q?wQUeVgxHnGZ+qkBq/NBgd2HZj1MM/PVDi0PJKrB7x4chDa/EWVqIY1dl5wRb?=
 =?us-ascii?Q?xELxs0Gn6caHCoBhrAiCt57ECheiVl4h7UL5ijqnR/YQhhQFPfJiMCtNbG4Y?=
 =?us-ascii?Q?NGEQ0xs+c/Enn8Ajn187g8Y/8tmp/mbNb21oQjHZfiaBRbNKyFyg7h2o1lfc?=
 =?us-ascii?Q?D43Jb+i5yq/qTh9lHnRGFwUtjsTWkC2fB1wYFqZk2KfjBjFuj70JbxepyMOp?=
 =?us-ascii?Q?NzWnhCi935/kDSkpF4p6qb5B00SLubRdMOyyLPuipClt+8XEmgaSHk9SpTgQ?=
 =?us-ascii?Q?hl6lMg4zb/98mT1NWRMWUN0k09h+U24dx7nZILwtogdAdt0OswdjjCBonVAK?=
 =?us-ascii?Q?Vow3yknVA05d3/yqgTe62gfZdpcbS9zBUUL1nywt+vHaRibNvzEpYEJS+hie?=
 =?us-ascii?Q?1GWkekh7J6z8D72iKs44FA5cJv/ynspbQM9cbShdVP/vkvemgT1c065lmafq?=
 =?us-ascii?Q?18sTrSi0LiFIvlsyAl0TOHd1pCFJYCTeiOZ3SCkgjZpDepepcAFZE9CRzOQd?=
 =?us-ascii?Q?LM8k5uZ2S6gh6WUdivlMH81iGlN+88/ZU/faZx17NyP+qs6Mpjkk6kSGWCUk?=
 =?us-ascii?Q?m9ytsyoVlIytPjE2v+gZvxJXg85E5XEA0722ifKLqgvtWxrucNl82JlvCbmz?=
 =?us-ascii?Q?GMkwO4XMKdjZTLjRQcuzEtz3fknGRgJDpVJlB0YD4Dy1Aj9lIAE49GVn51ks?=
 =?us-ascii?Q?EwO/CLo1zTg3mHwlbjcShC9qQg3mF7Vq+i8hGnp2RzPi0iNj8SqAedtYsbRq?=
 =?us-ascii?Q?vWlTwv43oZjc83G5LR3VdONrpJJZs6mX38HGNu3C7pVF9hj2IsEGxJzI5sok?=
 =?us-ascii?Q?OExG2toVsnru4aYJ4OZOi5/PEmBv0xHI+PR6SqkameN0zdMt7FOqidYOPR3I?=
 =?us-ascii?Q?axTGsDqp5ZhJSdiQkUbx4h/3fda3AI0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 84079bb1-39f8-44f0-e63e-08de6ed53098
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 10:05:05.6526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xwlq6uv96/cdBbKL9Zq7gjq9pWmn/UZKA7IhDsdeu0BMUvyul16BFFVcvklbSfUWuzfXCpFmMVNB5NIOpJqe1/uNCM5yGSc3K1KUG9QtCdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA7PR11MB9542
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

On Wed, Feb 18, 2026 at 09:49:32AM +0000, Ciara Loftus wrote:
> To fall in line with other drivers using the Rx path selection
> infrastructure, prevent Rx path selection after the device has started.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
> * Fix unused label error for non x86 arch
> ---
>  drivers/net/intel/cpfl/cpfl_rxtx.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
