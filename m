Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45995CD3442
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 08:11:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31D6440265;
	Thu,  7 May 2026 10:11:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 0E89E4025A
 for <dev@dpdk.org>; Thu,  7 May 2026 10:11:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778141471; x=1809677471;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=APFOfxeGP5zLDmj//HHvfOgihxG9b2hiTVJC8zTlNPk=;
 b=EhxVWpbNEoMn/+2QHSKashq5JD41wVBY/y8q7CRBybYe5LMeFFXnVUPH
 c9ojYYILV0hqM2365EvaMF7IsQuCgJhTK5HMPgUPYdUvs80FkT+13Mrkj
 CPUT5kGU6t0xdSlT4GOY/zdGooYZ5wsg713LBUjqD4fsGSb8Bt3RpnLLQ
 byBkfn7PP0yXz7NONGNMdKlWc8w4PHOFjvxJGAJrQxcBGmsXcIBj9FmNc
 XhtNRACdfbWKd/TjWF2EWcb1+zOQGxldB5extZesCDZeDPnf2aGFi0Aeq
 Hjt+oqVc61eXZKRIuH/a7qTlsrDGN8kcuOfRrG19MZAyudqFuFtLIemsP w==;
X-CSE-ConnectionGUID: HnIxoFsrTYqkHNI7kHBoyg==
X-CSE-MsgGUID: HvVpoKKPTkO9lFkjLMcarA==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="79074880"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="79074880"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 01:10:58 -0700
X-CSE-ConnectionGUID: ePKgYBvmSTKcOeMoCGLdZw==
X-CSE-MsgGUID: DWphVYu7QEuhQYa8nqk8Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="241395127"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 01:10:58 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 01:10:57 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 7 May 2026 01:10:57 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.58) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 01:10:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UEznyRRMEyxw/B8M99Q1a+utN5dS0z2LLoCsA7q8mta1gjG6llYBXp0G3OLfXsLsWPBj2vgR0jw8ncKHHgBW6ZTygZmk3VNlKi7GREyYoLbkYMsd+LFlb7l7vnsdTsfVPdukSK0vklUJ+l417lVryyIHlbNyq3rKUOImXXmbSGd0UIfxHBvUKrZSdgZtl/d905lJ+nj3N8B37i51XNzLAJjbKPK+N96Q/Qem9bg4zldO3e/j6szR+2EEKNX3LU0SP8ewgFO2laKcTAqSfT7F/Yo/dAt8Sl9QKE2se2gATBXOU1I+oKNt0TWrJG4xnqVIC3gcvHyf8fmFCbZg119cRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCZX7g95zqmuj02XapUq4AgyvZLJ9WetEOsOwyU/Ljk=;
 b=XS1bocle3phxuD56oNdqxvsqLfl+8ZG1GVyNTa5k5Ovh7RKg0LICC43Jj3UBh/1qyBohK3YcFHcxytQBSo1thae63v67htQLK2SSBjwCVcQpxqtL7f5sI1l3nGFmSeOYpMj3Ys7SSuOJXxexvgawoyGGCoOm0t1Ai1r5Ta4fw/RTqS0AcATWrxzPU7F9oahdGw1QMx97j/o/HEqNCoOyWCdepCpEhWNRH8x4obdhxn8qK+PkMGfsjQaMFtIreOSI6tnV5d973B3HpJkfqgzJ1vDhp2P4fa+1ifWDBhuQQouhRS1yj6A+/PFxFYPVfSBELAptgDokGPSv5o7VRD/N4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW4PR11MB6713.namprd11.prod.outlook.com (2603:10b6:303:1e8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 08:10:53 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9891.015; Thu, 7 May 2026
 08:10:53 +0000
Date: Thu, 7 May 2026 09:10:48 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [RFC v2 0/4] flow_compile: textual flow rule compiler
Message-ID: <afxJCBfkbui5clep@bricha3-mobl1.ger.corp.intel.com>
References: <20260505183917.370281-1-sismis@dyna-nic.com>
 <20260507001501.608724-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260507001501.608724-1-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0077.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW4PR11MB6713:EE_
X-MS-Office365-Filtering-Correlation-Id: 28a04a88-9f1e-48f5-854e-08deac102867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|20052099010|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: HpUqrW3+i/RPuWa+SlQz5RpZ8NTD9sQf+ZmDLsvHS9TIbZaouBSezhdw+q+Au9DdkNuy+hQprXTVeHCqD10MftwZeeGdoClYkCganXSzgVmlnUeju3CRYRrKygxJGF3nLEntcRDk8Aoo4N9buUgn5eu8zAmtdn+jlzBJM227c+zj4V7/LRif+7M6gE0AdxS3qaBYNDV5R/duT1HC6IKGhEzwA4GlT7Hwyz1eKuFVU7UxcGaz6hLdpawU9zY7XioMAyPMihF7sQSdfaaNXh6tNKLwtnnaSnesrX38aqbNrrxkXUd06HEOlhuqSzeWFCqxNjpVhhV+QJrbaRjJ348g9TyCzZyymlRrufX1Cu1iqakdnJaQHc0G5ZbAb3emNUgxWaqwljHAQ6XfL5O4LYzy8JQjZR/kwVN1fTaRi3PmLZu8KM8s8vt2MGHb5pD9SJMwxyR2G5OrFUhnY4841ByLZWCcW+VIUe5o9jV0iBB5OMhpoXk5RjXxiI6HBCNrhaA9aEYpJw1ngRnEbGxtFxNuk8v+oDnhbW7C0ta8T/w4qV2JlvuQCMp57EpreGWmSa6MKVLSQc4HZT0ULf3MAYAgCY0Nayx57XSjk45E2h2KkKLt7OBT6YEhaP1kqQ2hj8ZWq6MIFPbD7tjWeXnA/J+PzuJYdNz4Gv5WMOA94OkN0aCd9hiw2zDdpIWCRV3zpuawAQvLnE4xQuiRV2dtu6x4jg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(20052099010)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H+bKvJfDXWKLv7CCtAFiALd1y7L4CXcWGOsYpwR7MCZCfTHB7VCnX+UHgptF?=
 =?us-ascii?Q?yKGsX+SuZ8BDIgsaq3fwlAfs77zgREIGAgOnwPR6a+eydXGuzW00IcZKsxeM?=
 =?us-ascii?Q?IgKDT1ik6GzXvwjN8Ixpqqk8BV1lGdFh3OVha8aUWGDPJIrAntf2hY7WEUye?=
 =?us-ascii?Q?HLPlIKvCCORL49gnIDsbwoUizUiHnvP9tmumgVxlhQgxDDQ2inQRrq85E1iH?=
 =?us-ascii?Q?GAn5pKgq3JlPMYvd+6SqfIpXTdzS1tCXAhPk15z481DrIlVlBUxBHdL57h3F?=
 =?us-ascii?Q?+fdFz96QNNURO0yCwYQYkEh+QdgakTXyoxNhN6NcHcx+3P56jlBZ5PbdJbT/?=
 =?us-ascii?Q?II/+EAysPiiYS/jQAjguPj77V1HlPIEQrm74p5HfTtfrdryEwAbUiebKEXCM?=
 =?us-ascii?Q?HffPonMPPcX6wvDjNx2f5P3BFVsWpN0pKaZvTusBl/KNwhFTLT6B96nWxKUD?=
 =?us-ascii?Q?wDnnFbjvTZjk/UZVp/G0l1JJYgAVT3+vwxh2r4L9KbaRk24HajhMjagq1i+T?=
 =?us-ascii?Q?9YpB83/FOkL3EiRrb89UrRSNY1LfMpvUxy8TmGlhOBFD3COsJo0l15RWNotz?=
 =?us-ascii?Q?zwGjRvGbH7rAx2p6bnoa4FGcoAbDJR/fRfMZpppJuD3/qiMLaRb85hsy1uoS?=
 =?us-ascii?Q?CNRNlqmF2kJTod5PkRo88au91IUT+4MMmWTuXCSALwZemjBq31r0NQecwnog?=
 =?us-ascii?Q?RAHvf98Y8ol5cx/+inHhbPf7DxXPZO6gBsXZsF/UHvLGEzywNXXFNpV28EAo?=
 =?us-ascii?Q?00hySp9ndhmo7s4o0/cZrIUlPrI/YQyMCRze+SFaTqPAJ50VX0rvlSmkK0QN?=
 =?us-ascii?Q?GICNS+BqzerfPAToGTEdSng/CUYeo4GDPXpntnF7LDfyIPY3873LwTIS6C64?=
 =?us-ascii?Q?dXqE3RloRee4L/c1xuy1A+LNeIK1gSJE1g06L1heGvkMNxIDrUQNqieMEjdX?=
 =?us-ascii?Q?8C9t01t+pLWN2d+DBAbrM96PLmkpU92/c6Hw6WPV8AAU7ywn2Je5xwMVZDVQ?=
 =?us-ascii?Q?uQGxy2n5E5HXKy9dzeZ7kNVvvXq4ZSPvhIlkIWTLSMHyCT9I7Lp1oiLnQye2?=
 =?us-ascii?Q?TmCe+mgBt/g3hSuyBLIDTzbQapYM6nNBj+6QsY9GoPa2mjbb8mfE2uhBgqjy?=
 =?us-ascii?Q?jyHGx+lDk8n3EAJeAdjtytXib0B9QnasiM36VNL0vSWUGzuOtK8eDpDZpl7V?=
 =?us-ascii?Q?kEVeH8ROI5UJL3zImNMv8s8sNrWsiH1KhQ5u2zQpzmEKHRtvv4yI8twNteWD?=
 =?us-ascii?Q?zxazR3rs0SsvVfAOkMaAQ9/2EWISkNfyrZ8ulqKEDGloWg+jv7Knkdndio2d?=
 =?us-ascii?Q?LJgpA3yrhUQ8ble9FKCe902oArh6Tns9SSM9LLLs4p86HugIYOrcwS2+Xtd5?=
 =?us-ascii?Q?B3/TTxbuf/2wNTbHKsINSbHbo+UXeLy1QedGMqDQLtlEMnR91MCl3aJJkJvd?=
 =?us-ascii?Q?Sk4RI2FxbQcV4al7+g/AW6jYQr4GhwtEFJuRdH6Fl/X4p6Xk3O42IH7CfvTu?=
 =?us-ascii?Q?WR1Y89qDMKVBD3B0aFniR2UKzjj8MdMKuH2K/rISHhSrPEbSdYFhXjry9F6V?=
 =?us-ascii?Q?7dP1qhtxgMe7XQiVP7Yw9mctKONasq5G37Fg1UJI/Q/dwWmPkO7Kj23a2Laj?=
 =?us-ascii?Q?I2vKbjO6eTRjnp5gizP9PeQArVoYfbOQHxzkxOZ5Qdtaneo3Xq9Zj6P1wcFd?=
 =?us-ascii?Q?Y2LD9S54t9+SKPs7eY7l3e1ftfJ1/4r65qr2jct/0QNnKDxefuJCYp7DLGHT?=
 =?us-ascii?Q?dNxY0mD0RCkoymlRbP6dw+ZbE+Q+DaY=3D?=
X-Exchange-RoutingPolicyChecked: Y2UIUJiPVjh6gJLoEECgaFyRUzVe3m2Ld94HDf69xFim9PQuCsi8ZCDpk4ccsx2+y7RIcxEpRzd3wqT8m5Ay88To9t8SXKaBXF0ObVAYBwo2sFJfB6yLxjtJijDMYK4oS2I0H/4NJq6SLow3rffhiCZynd2V/8nOy2e1A9lv/+5ztvKZ04CklgXhl1nf7erk2L+9huxEQRrvNOfEuhDz1LW4jyhvD/UYNVImJZZxayy1XMXFJOEHeaArP45xR4guDaaO0kb8aQjLOXyNx8xDhlcfsM10SjxsFQHr8YDsBc2pEHu7nVXeFjeiAfeEiEchuKmPp92dRHFTYN4dcnE5Xw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a04a88-9f1e-48f5-854e-08deac102867
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 08:10:53.3588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q2wLd7P6guY/0f0EttEdfPsLKJHPGJF8K+tQGq4kZ4CYLmr63W7IHlzgPm73jQAd4M5lH1xMftMBEpgJLF/i0hBD8JBM16i/RBL83RKFmhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6713
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

On Wed, May 06, 2026 at 05:06:47PM -0700, Stephen Hemminger wrote:
> Background
> ----------
> 
> Multiple efforts over the past few cycles have tried to make
> testpmd's flow rule grammar reusable from outside testpmd.
> External applications that need rte_flow want a documented way
> to turn human-written rules into the rte_flow_attr/item/action
> arrays accepted by rte_flow_create().
> 
> The most recent attempt is Lukas Sismis's series, currently at
> v12:
> 
>   http://patches.dpdk.org/project/dpdk/list/?series=37384
> 
> That series factors testpmd's existing cmdline_flow.c into a
> library and updates testpmd to consume it.  It works, but
> inherits two properties of cmdline_flow.c that I think are worth
> avoiding in a reusable library:
> 
>   - Coupling to librte_cmdline.  Even after the v12 split into
>     a "simple" part and a "cmdline" part, the parser is still
>     organized around testpmd's command interpreter, and v12 has
>     cmdline depending on ethdev to break a previous circular
>     dependency.  A library used by daemons, control planes, or
>     unit tests should not need that.
> 
>   - Ad-hoc grammar.  cmdline_flow.c implements parsing per-token
>     in long dispatch logic; the grammar emerges from the code
>     rather than being stated, and adding a new flow item
>     requires touching the parser.
> 
> This RFC explores a different shape and is posted to ask the
> list which one is preferred before more work goes into either.
> 
> I started a new green-field library for parsing flow rules
> (with AI assistance for the boilerplate).  It is young but
> passes tests and reviews clean under the project's AI review
> guidelines.
> 
> This series
> -----------
> 
> lib/flow_compile -- a small new library providing the same
> service via a pcap_compile()-style API:
> 
>     char errbuf[RTE_FLOW_COMPILE_ERRBUF_SIZE];
>     struct rte_flow_compile *fc = rte_flow_compile(rule, errbuf);
>     if (fc == NULL)
>             fail(errbuf);            /* "line:col: message" */
> 
>     rte_flow_compile_create(port_id, fc, &flow_error);
>     rte_flow_compile_free(fc);
> 
> Design properties:
> 
>   - Flex lexer plus bison grammar.  Both are reentrant
>     (%option reentrant, %define api.pure full), so multiple
>     compilations may run concurrently and the parser holds no
>     static mutable state.  The grammar itself is short
>     (~200 lines) because all per-type knowledge lives in
>     descriptor tables, not in productions.
> 
>   - Parser is driven entirely by descriptor tables of items and
>     actions.  Adding a new flow item is a table edit, not a
>     grammar change.  A custom-setter hook on each field is the
>     escape valve for layouts that don't fit a plain byte range
>     (bitfields, indirect arrays).
> 
>   - Dependencies: rte_ethdev (for rte_flow.h) and rte_net (for
>     MAC parsing).  No librte_cmdline.  Flex and bison are
>     required at build time to regenerate the lexer and parser;
>     if either tool is missing the library is silently skipped
>     via meson's has_flex_bison check, the same pattern other
>     DPDK components use for optional generators.
> 
>   - Per-allocation rte_zmalloc for spec/mask/last/conf payloads;
>     rte_flow_compile_free() walks the pattern and action arrays
>     and releases every non-NULL slot before freeing the arrays.
>     Parse-error paths use the same walker, so partially
>     constructed rules clean up uniformly.  ASan/LSan run clean
>     on the autotest, including the failure cases.
> 
> The grammar follows testpmd's syntax closely so familiar rules
> carry over:
> 
>     ingress pattern eth / ipv4 src is 10.0.0.1 / end
>     actions queue index 3 / count / end
> 
> and is documented as a formal BNF in the programmer's guide
> chapter (patch 2).
> 
> Initial coverage: eth, vlan, ipv4, ipv6, tcp, udp, vxlan,
> port_id, port_representor, represented_port items; drop,
> passthru, queue, mark, jump, count, port_id and representor
> variants, of_pop_vlan, vxlan_decap actions.  Variable-conf
> items and actions (RSS, RAW) need custom setters and are
> deferred to a follow-up.
> 
> What this RFC is *not*
> ----------------------
> 
> Not a replacement for cmdline_flow.c in testpmd.  If the shape
> here is acceptable, the next step is a separate series adding a
> "flow compile <port> <rule>" command in testpmd alongside the
> existing parser, so users can adopt the library incrementally
> without breaking scripts that depend on the current syntax.
> 
> What I'd like feedback on
> -------------------------
> 
> 1. API shape.  pcap_compile-style (one string -> opaque object ->
>    arrays) versus the three-call attr/pattern/actions form
>    Sismis's v12 exposes.  What does your application actually
>    want?
> 

For this, I wonder if we also could do with a second API for the creation
which takes a list of tokens rather than just a single string. Thinking
about integration with testpmd, or with apps which already have some
commandline interface which produces a list of tokens, having to re-stitch
the tokens together into one string seems awkward.

Also, have you already investigated how this might be integrated into
testpmd? Do we have the capability to pass multi-token strings via cmdline?

> 2. Library placement.  Stand-alone at lib/flow_compile/ versus
>    addition to lib/ethdev.  This series treats it as a
>    control-path parser layered on top of ethdev rather than
>    part of ethdev itself; v12 places its parser inside ethdev.
> 

+1 to external to ethdev

> 3. Table-driven extension model.  Is "to add a new flow item,
>    add a row to the descriptor table" the right contract?
>    Should the tables live alongside each rte_flow_item_*
>    definition in rte_flow.h, or in their own file as here?
> 
> 4. Build-tool dependency.  Flex and bison are not currently
>    required to build DPDK.  Adding a library that needs them
>    (with a clean has_flex_bison fallback so the rest of DPDK
>    still builds without them) is the cleanest way I see to get
>    a real grammar. If this gets used by testpmd then
>    what is now an optional dependency would get hardened in.
> 

Flex and bison are very common build tools. I don't see an issue with this
dependency.

> 5. Convergence.  If this design is preferred, I'm happy to
>    coordinate with Lukas to fold in the testpmd-side changes
>    from his series.
> 
> 6. Readability. AI generated code like this tends to be
>    either opaque or too verbose for humans. Often have to
>    nudge it into submission.
> 

For readability, can you (or the AI's working for you :-) ) split the main
patch into a couple of patches for easier review and comment. It's a very
large single patch to go through in one go.

/Bruce
