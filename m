Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877E7CD342C
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 15:41:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 746044026D;
	Wed,  6 May 2026 17:41:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 93697400D7;
 Wed,  6 May 2026 17:41:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778082064; x=1809618064;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=LoeAF1Mp8ek6PaerzeXWImZvvwy9yBKz4PEG6DM+JHA=;
 b=mdFwRUombyK0SPOfxdRg27jCViXTjcTopxPMq4e4zKkCJRxNMrEiEIYl
 E+5CW0po+2+kMvjHZl3c45xMi1EoF5hkKglZ9V9JFPzXvlMHYjw8/oy7c
 Aj9hxn9YpsfO8C9Cu1b82aHnImfjLPRF9Jt6ey8MZqk81lVrLq46Mq+vP
 k07YpfUUxgMLsIwcOOajpAQUdjbvUMLS22yXqGNjRpA9PNSE0hXx+xnP4
 DFcppLRgKlb9Mj1f0x7WgATEX+WpIpCyV+Qk8ltc8IxBIfu6JK8xfeUMX
 xQX2aDpZZ50CPiv2liM8WmMLwsClHIjKBbuuLuLB6FAEmoDjyRlSvX0Od Q==;
X-CSE-ConnectionGUID: bqYGsknKQDmQEPUURbpS2g==
X-CSE-MsgGUID: Rui3kKCQSHWh/iWWEf00iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="66548458"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; d="scan'208";a="66548458"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 08:41:03 -0700
X-CSE-ConnectionGUID: mHOitZ5rSZy5UwnibnfAZg==
X-CSE-MsgGUID: QcgYZXp+TZuMiHRCZa5mhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; d="scan'208";a="233075220"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 08:41:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 08:41:02 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 6 May 2026 08:41:02 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.64) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 08:41:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hn09QRjDaeQ6HeIPgO7FaeuskRqj47mNTQFKoAj902S6aODhRfZIjPwyahhOAiRR7TQLqHne2n6wr7/cBdHOqozGTV16LZf6GKEXwLUU3qLnGuzlpOw0bjBOth6BWyzmK5Blo3IHgrG0/SCmSix3PlG7e1zeJnzV1NZrcaiBDuVuBrXVBiio5zNNZ1BDwy6jHwfh8O1lQjGfWVUGNvEUy2uubb0/GHCCZpuNcmgY0hmG7eFYrHFRVa9Q/LG6f8czLn3+546Und2VIQnLw+gckR7ie34hrZTtqR3eqAJObM61i73oYP5FBS3q3v1fbqbDzOCFl246OyLfzip/J4u3Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1h0NNHtfi2ldDuYrKAmc3gxVFluCnFHi+g2kkB2xRM=;
 b=l3BtghsFdQi1DSb6+VjCNgozVNuO7hHc6kBz2VOGF6d7KVDeXwFz0rrvcHZxFDrFQySR25jI1y7uFh1EmNygHb8amArGiYrda8Co4AdHF5CdemLRtVqILYheH9s1vFpn76+x5Dp9YFIDdXvneIzQUwEhNkhkeEFZfANmx6MK1L0RsmTx7Dci+HryF6mD8m38hSA3TjBFLaXQRBLs4sR/Xuh0oDdQQYaPerG6EOs4y0ejAmm5gZ6IIKmMEdYcSafUiWVe1CVakllwSkHSizPLtZtSe9iQAjmWox/pSSEGSR0psouMwOvNxxToAn7R2DSrqONTn4jhrc7cmLrYgV2F/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH8PR11MB9607.namprd11.prod.outlook.com (2603:10b6:510:3a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 15:40:59 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9891.015; Wed, 6 May 2026
 15:40:59 +0000
Date: Wed, 6 May 2026 16:40:54 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH 2/2] net/ice: fix shaper profile reference count tracking
Message-ID: <afthBnLp-4p5ssjp@bricha3-mobl1.ger.corp.intel.com>
References: <20260501105755.1136087-1-ciara.loftus@intel.com>
 <20260501105755.1136087-2-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260501105755.1136087-2-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0309.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::9) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH8PR11MB9607:EE_
X-MS-Office365-Filtering-Correlation-Id: a38f5a2f-d1c8-435b-9020-08deab85dec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 5IRLkd9UtOvAPxP2d3NsZPn7yM1BX+BZUPTVxlqpMvOK01cOVfoa7kmE7ZsY5LGc2ma8+ObmCzEqMG/YX0YyGwGT6+xFDwD0Ci5Aw4CDvdR4irU8q9YB2yE7ck5Yf9/XMzs3KhfUhGetoO8fLfRBrN9OtChL4C3MRBoVGDrBGAo8yZOVBfVWYFwlkDjyKIM/u3sC5lvjH0koFBlrn2a/sTzaWxZxCn+xts/d7PN7etE53rOVT/7HSRlaTcG0e4oOma97Ev2zSzCXv/kX0G2F3WWPNlSMKvKoWZnF3CUObuT6hufpwU8OCX1rhtxStgGa2+eBnDK5ZJitHn578XXJ96KvNtOai3wf2FQx+j3Fhp4hMyv6jKcFlTCJpX+zL25oQ2qmGn/UCtO7aklxUfWtIlVWBHYXT7/TCaAaeT3QWc+jpLPKgXXdG0rp5Z29AN+hgzf8dDiOjM+Ewltb0W/GDLfMyU+Z/jQS8scZ+WXhbMxlaY7bzEkXI2ytxKURJaQzljG0fkk0+zhVpnCkH+brqyJvTasHhVoUAwFq/llg1DgB/Y9VrZ4aSlXGMzWK5HALtkswtu1709EMguGq2H0vSKix15zOo+T1A2uBSXWb1VTVbWMzkMnMk/l41c1RVjtQhlKY1qF9TO1nKWN5k/q+juIAbu0uHccu/6Z2ZPuY/yzGxhjdw7BjZp4L+RVAJXGb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9GQeMmpjCBFZgd2nNY4NF6rf3W5ulo3as486sR6NKW1r9xyeUP4aiG7/qCpA?=
 =?us-ascii?Q?Qx/EUfxzk8xz0Yfqqbf1+aZ9d1rPvP4cFNq43lee30jQSlL1w9GF2L+XgLEq?=
 =?us-ascii?Q?VOgFvH56i5GZL/QWrLeD+6P/1s82GUVefuY+GS/hjHBySxZ0AWDg6Qqr8DiZ?=
 =?us-ascii?Q?Kd5NaGBNK9E7snfuZE521ODzO5Si/dIBgZiWybiYy8TqRGGaj/Ya9pwReoCN?=
 =?us-ascii?Q?PAAqf01WtaMGmBknMTwivP2HO870eHSQjee3YhjC748IJ+Mlef/prfBFwn1m?=
 =?us-ascii?Q?nammT6mcNaaZxtHFVRX/7wxMn/rTlcUEcpgykj62YjpDJVFQ6WgYYRU0NsCJ?=
 =?us-ascii?Q?c7Y4mDAwuI88yMIC+iK0VTC9iVRNHxs//Nv0HgRdlcsG68zPuAQQzFbWWDGL?=
 =?us-ascii?Q?UhWzF0uzso783xvsODgi8Y+RY4OhU6F07mF9tMUntZnIrakTTiq2S5dOqMgE?=
 =?us-ascii?Q?t5Yj3+JrmSBuY0vIb+ByoEWUdQs0ZpvSGz8HHJtHTRdIXOCwfOV1KdlXMU7B?=
 =?us-ascii?Q?gfEph20p0u+SUAKZdna4wOEFiZUUVeFCLtbKsnDOpNhdVjhWN9DPBlJ43foi?=
 =?us-ascii?Q?UEcRmtqf2MUL1QUXK5pgWihxae2uGvT69iLUa60TrNtNdYbk9Rw1r+PxOCIj?=
 =?us-ascii?Q?wjr79iBHB5066sR0ay8B358leYP+uF/Vu4D9bwoibhIbvNxl+hSbLLn4vBbU?=
 =?us-ascii?Q?KBXIIutoBFktWUanSSNPZ+8RS3pEDS4akl4VhuN0sJtcd+hhyngTqEevBwNg?=
 =?us-ascii?Q?14E2OyZMkV3rcaS8gJHQBdCqwHhLxqxo/Xg2xkDxKTndL57k8WqZ9Muq6SUH?=
 =?us-ascii?Q?qnc2Ydt2USkXnAaENCyNGZtfCeyxX3747+V7/2zztTws+7u6mSHAVJv9djV2?=
 =?us-ascii?Q?yTyW6XsCuT29lfUj1H+TPRc2RBtBEzgMdgc+OxSWNVpLjfKxs/Vvpd0qSNwR?=
 =?us-ascii?Q?JDVPIU+tjgCkd4j5Lvauo7j2kWJy8F5ljG4ui58QRqSZM8qiEikkIIBqnddu?=
 =?us-ascii?Q?adzSpEiYx8g2ATxgLlTWx/RVCl3vgY8RdVjmjvv1y4fRm2sNAhneCGQwdJBk?=
 =?us-ascii?Q?V5ncMLnJFxuPr/GtYdR3LMK2ti1TawVPTxbZjCA+wIr4yE7HFQOmP0Cg1Kj3?=
 =?us-ascii?Q?5pNHDpJsLHtLHYqX/cs3AHiw8vvs6gItA71qiqMvQ/qRkRfZeQQiyRDOI404?=
 =?us-ascii?Q?M6S3tWmgoWpBGzHyUZn8XoRZg29y3fP2b6n6vIlZd2F7FTgihmtgJLb8EpiB?=
 =?us-ascii?Q?VwJHCutRJ9LJqRK4TBVwnZ0jJkbCNpJGieZ7DQNkU9Q3tepAp1nNfvWc5w5f?=
 =?us-ascii?Q?MDLOHl/oRNJClKtgrReEhUdHYz+MKqqOgjdJrNw97ntJlFkwxD0p3/K+Metr?=
 =?us-ascii?Q?D3da5OgYkrPRDLJWZ6aic6SNyFdIgUvgawwsHiKlnsxPkwM7CZw17sg5mDm7?=
 =?us-ascii?Q?YtPu0/hIWGHsr/wLEbc2mr68+6FxX3w84RAhjccys4nIqiFrNeQcu6ULggrR?=
 =?us-ascii?Q?aM8voIU1Im4WS8sRO+6bIEniWxe78GQn7RA3RBf6YJcemwICyzwGzY8gmkEF?=
 =?us-ascii?Q?93MKW1VwN3XVJM3gT0rAWqyDZvPFI/K/1iPz3EyPs1+UOK8KH1b6TOV/NA7t?=
 =?us-ascii?Q?id1NjPulfvzOc1BwsLUmJ8xnUxNYsKVByccfflHnd+ICiwkVV2VL+84u2fO3?=
 =?us-ascii?Q?KoTLe943Sg79mdWo4sZ/wIHs5QzGr4b4eA4r0b3cuKFogLlz9H8vfIACTNmS?=
 =?us-ascii?Q?I8NbdXAYg4H3gQ4fCrrjLo8lO3P/DXY=3D?=
X-Exchange-RoutingPolicyChecked: GuCfXQ9lcvl1chluIpqKIGxByAs9wbcwQ85Z6lhSSFrckS+PIscdhOv0tK8iNojC0FXWoxG6o31PUMKVdX/OaFBwyYF0chHmJsWN8ytZqnWDdNThxjxtvEs0CE8s1m++fET7+sJAbyg9buN5xHQ0V9I7mE4ql+Fswx3L29Y1hrg2xHDyViPfDYwIfDR+e/PGtFy78x8fynTbdVgbmLc2Sg8BGRucQ9Ynk1ktsrnvyiCHvEm/MxZAp/ngmhd7xMsO0b8/zOmN5ClrG8JuBPU29KAJiFgpPNInDDWfUk4vz7VyVn8TQX6l4rV7J4hlw44nyWCGPE/RYddHu63pOVnBtg==
X-MS-Exchange-CrossTenant-Network-Message-Id: a38f5a2f-d1c8-435b-9020-08deab85dec2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 15:40:59.0875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z1Os4kZj/rgeeoKswQjwK/3BuJFgCvx+MT4PqidQpLTeMOX3w2HF4W8uoWj66nGvqTM7amxJcmDzAPtUWzmXD6dn4XeIGrqxX6eSx5Zx+g8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9607
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

On Fri, May 01, 2026 at 10:57:55AM +0000, Ciara Loftus wrote:
> Currently, when a TM node is added with a shaper profile assigned,
> the profile's reference count is not incremented. Equally, when a node
> is deleted, the count is not decremented. As a result, the guard that
> blocks deletion of an in-use profile never triggers, allowing the profile
> to be freed while nodes still hold a pointer to it.
> 
> Fix by maintaining the reference count correctly when nodes take or
> release a shaper profile, so that deletion of an in-use profile is
> properly rejected.
> 
> Fixes: 8c481c3bb65b ("net/ice: support queue and queue group bandwidth limit")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
