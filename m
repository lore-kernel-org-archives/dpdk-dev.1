Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83724FD9E0C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 19:47:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F9C64027F;
	Thu, 26 Feb 2026 20:47:33 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id DADAA400D6;
 Thu, 26 Feb 2026 20:47:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772135251; x=1803671251;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=XK4TsAiUb9KKarkOprltqANU8Pc5rLjP1lUOgMac4cQ=;
 b=ZTEuA2OCG3lu2MCfkAuTgI7xTspijBRWknitW7nERYOopD4WQUCGYEhO
 E8xfRZ1tTZlMJ7ML7gGJr0C/Pz7tO1EH9MLaRFfb3CrvUTJcIaQdho7Y4
 r6jRWJ9yaIR+PDttGLYQTM2DmLQNSROb9yJa6zzPghqrjE3z7e+x3YhFQ
 VcwO2UChA3l3+8+C4eQZ4zqUDqWtCWW6+7YPHNQWjrZq6jyK0RgoBfU8A
 QCbXSMgbtAOYtlyOxd/VMHR3qKIYyfMCxV7qpulo/2Li/NMnloQoPoSdo
 5v7YkyWr21VtQ0AocE59c/otsUceVBe0ZSYQ6C1+xm8KksuQ9A2wUX7uj Q==;
X-CSE-ConnectionGUID: X1gkBg0FQh+W68cbSnc3jA==
X-CSE-MsgGUID: dlaMraaQS7GTh+Dzl/PVeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="72416626"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="72416626"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 11:47:29 -0800
X-CSE-ConnectionGUID: +ydlbAKITTq8RyMWsLNK1g==
X-CSE-MsgGUID: m5xZx+mTQAerKHA/n0fBEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="254443212"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 11:47:30 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 11:47:29 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Feb 2026 11:47:29 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.70) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 11:47:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WgwCuxalLgi4iz98AqGncoaTfAvkd6kJG+XAiB5VV78uMK1t/DXcQFIajamzHTyuKg/wZJzPPdRsH6fFy0dALlxRWMkCDEmDq6Auci1J1GRsYujE1MatZh8DilMLkNrrkE3mv2kZ5Qq4XX+6cJ6c5R7c43hZO3XlgSJhBgZEBef7KcsmtEQwffub1NfvPrX1KsT6o8NSU1KHWzU9B6T7O0q5dM9DqzTbyxYZ7iedRKcTjn8Y6SpBRUU/uqUiXKVu1xROtk7wyqcppCkyWdGzF2XXgFRCA+U5T3akhLWbhkKGxTU/hw3gsCA+jT4AGplYZFa0Hw0lRagphV63E6QKRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwFr3y0kout7KQV4BvWAKrcvHDAAXN+8R/fre2cN+g4=;
 b=coOWXGcvrAtngqg9D4QGdJisgjOgy+lHkYslhECXQU/ELfrO6XKW1YG4g0fwVo3ci3mqE0ykr6S1OKlnj3mvxbw3z8yi4yTb6dseEV1sW9fEue464YE03oXqwxwCaggGmEr0L0Fkq0l0pi3iIP79v1Yr62RBNT0JYRWApj+xJuG1ptQgL1hsz3U2gCVeX3TJCMJtEomsYvum9dCBLsRisWlXHmxoYwE+TZENjQ04jJ2E8pKe1PpaIN7N5cCLdjbr8Eg9ei96YSE/XSCrNhRqKZt23a7l/B5hwtmq4YLNNRBg/KR8D1gxXZ7tHnSe82k2S8SuUmGOwVLxmuewA4a/pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB7588.namprd11.prod.outlook.com (2603:10b6:510:28b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 19:47:25 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 19:47:25 +0000
Date: Thu, 26 Feb 2026 19:47:18 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Radu Nicolau <radu.nicolau@intel.com>
CC: Marat Khalili <marat.khalili@huawei.com>, "stable@dpdk.org"
 <stable@dpdk.org>, "stephen@networkplumber.org" <stephen@networkplumber.org>, 
 Yipeng Wang <yipeng1.wang@intel.com>, Sameh Gobriel
 <sameh.gobriel@intel.com>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>, 
 Pablo de Lara <pablo.de.lara.guarch@intel.com>, Yerden Zhumabekov
 <e_zhumabekov@sts.kz>, "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH] hash: fix pointer alignment
Message-ID: <aaCjRvcjabv2PFuO@bricha3-mobl1.ger.corp.intel.com>
References: <20260226142206.860737-1-radu.nicolau@intel.com>
 <cc3138af2b6d4f4ebb806db04affd487@huawei.com>
 <b28a0e99-8642-499d-95a8-a6ed30f939d4@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b28a0e99-8642-499d-95a8-a6ed30f939d4@intel.com>
X-ClientProxiedBy: DBBPR09CA0048.eurprd09.prod.outlook.com
 (2603:10a6:10:d4::36) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB7588:EE_
X-MS-Office365-Filtering-Correlation-Id: cbb275b2-490b-4bf6-5de3-08de756fdd5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info: EinmsNaedw98a7Srze0tWfsGnhe328d1AvLZ82JAY2gqOr34b/x0TJcIXu0q9VgPr0K3+wqxeMWiqS35uRUqvxQFUEswFMJEfxhUpWLCXKzTn03oyIp7VkEzqjvKEOm0v7YPbaSURXLqRUX0H3+CDznckT6XpEu1AUyMu7DYXgf26Rc+S6M3dvAoz2VfMHncevyuqq7hqC+sdXqmlHjrbIQ4cq8bOq76A+Ii74QeofYihT369+ErX6LbXmg5p/WHQdR4taHpL5tFMdipwe4MEsqiD+O2BiZRWlPEvbRvJnEQlbYf/pS5zR/8/sb3jTe6LGGMhFhPMKoXcovOr3HvpNL1dd8hhhzD8Mo87ELReR0MuML0yj8zs6BDQLiocyJAFSDJhYcuA+fpzxE+vfkUuf3Gb4qOEMNyRV/0vY56L9MoCs3B5cVJNb29XLt3DGE1FDTvcHBcha2OjqnTcEx0SZgJLazIznfjhdr9cvlajiIjcFYFDmcYFlxlrFEuREksHFOgBGw9x5CJqYaJI8tieM/DkHVGhnbTLV8Zrc78XgTV9KRx4SPG0XHkgoMkU4gHVMaK/Ufg5FggtT+LEAdSlIhb7jMs9ZcHfKR+UKjkAhULL0X0GaFNNcFJGZPg5WEoxWJGhsxBN4hu4MjknKzQssN4mHXHax5Eui+53fYf5yYTQpEb6pvCYMIPQHG8XvzOEDfkJA7vbdXi0Einoc6NVAz+Q6JXMP+Ik6qCsFmrCmc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7142099003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gEDagHAGQrNDllrzq3YrtbVX7639hC5PsGx4nvUAwz+4A9Qb/LLhZkZvFyTA?=
 =?us-ascii?Q?7sbbbTnxfceq/LhEPC9vd90ku2ycagXYiGGy0NdTvUaVpfbUBop890LVRV69?=
 =?us-ascii?Q?2cP2zI9A9pYiSuxgxBaTa7iLqDe9gdQP3VanWUw4C2F2NUdcJ15Xe7Nz0rmY?=
 =?us-ascii?Q?kmZjpDobLL2z1VW5SuUyGpZzz0Q8SzDBT9UVpkYEI3SxXq8BoxOWwTQ11qw2?=
 =?us-ascii?Q?E8RVGAYq0331K8jC/QqFMzvqDjrXHx0ou1RAYMkx3EKkWp4rWJps8U+y3GjT?=
 =?us-ascii?Q?/5/17PQ9b3R7Y5urUkvS4qggBDbBi7V6SuFgfwVzc53GwcQl7Nfji2tgpeDT?=
 =?us-ascii?Q?uq55w6KsnwbvjqnFhvGjTDkLiBBNkU9nGRtI1UIFJITLDvTAtzD0w729twJa?=
 =?us-ascii?Q?rNbvx5tx06ggiX81FCz48WJrGv80zF/QqFwXZ+3AUFEy/G6VBTOkop1sCFD7?=
 =?us-ascii?Q?gDZhiJNKLzHg+BDwnAqRWjtfMWetOkiN2oi1vQLqGfUVtdx8cZ+VCecta5N8?=
 =?us-ascii?Q?Y35wWWsmBmyI18+sxEkOnlSYuAs8WCY3Oe9uhmPjvxn8ChGKYSFcq04hBjV4?=
 =?us-ascii?Q?uACJQDPLDqCcir/A1PyAKX6vGGNxXS5uJ/1mJZ0LfuzzhtoLuYaX6CPiNNa6?=
 =?us-ascii?Q?RDVP5ROUrttDLI1UviKvEhO2fYJOtAqkCuBxQt2gReHZEz4dwkPgq7o/Cgph?=
 =?us-ascii?Q?7Y5Be+I7Bh8dDjFMir3iuIz91jnoeFj3C7SZADb4DTYjKa7Ev2/ELu3dnrF7?=
 =?us-ascii?Q?cb9CcINiInigGNJMawlPTbQeq3pIoBtGX/Y8F7tzI2YZj2bszOId4T8Wffuy?=
 =?us-ascii?Q?u5RoMbZpp9djmkjeBeoc+uU8Vivufl/nxIOCINH0xJMBVGcFoVHPbXpJFwp/?=
 =?us-ascii?Q?3DDI1swHALSYorbVPcKiOO//Y+mE1Eoe0N+PFficjQ+49NfHQNEyKB0Qyrfa?=
 =?us-ascii?Q?VxrgPPARsWIk5b9riHe4JlBDpHluk9LBhpihYK0g/uBRWr3+RW4KBc+rw6KF?=
 =?us-ascii?Q?K/Ni0xEHc10XFWqKsIf0s2O5+Mb7OiI7OGXGNJhce0fP/UC3Fm/DqJtyQ6vu?=
 =?us-ascii?Q?2U/YK10WVqYDToyFNVM3VXPSa7wbAc64nlDcscjMliPTSrQ96T9+BKcHYFs/?=
 =?us-ascii?Q?P0oFUgArrn3ipIoz/Pu/U5850OGj+3aERZEZDTaTmFIF3QGHVn1asApl9JXJ?=
 =?us-ascii?Q?z/8lPE+XAXqodky5xuK3eqjxt5AWsyZfqI8LoCbQU++NO/kOAjilK89uUMek?=
 =?us-ascii?Q?7pEOJP7OlLqruSs9XXo+eq9EA3JTORepKeQbbCPmjBOYF4OCJ0r66Z23XXty?=
 =?us-ascii?Q?c05p+6mATmQvlW2J3x2v6KnezMm1xl1Oyp0fODPqF7shBaV/1Odye4u8jdQb?=
 =?us-ascii?Q?bW4Vm9/afJp5ByBQ84mp2+/xTQ5FdL/mW5P6lRJFkrz2dY9ZJ16KD/Ffy+fd?=
 =?us-ascii?Q?t0+cqcXeNRpLvzlho3cc0XGJb5RwRclho/z5YsPsjxeBxu6Hs78FGZSvmtl/?=
 =?us-ascii?Q?mIZKByzz0LMK992xLt22tdWlvxjDVdA+GS383rhw7pLOfizVOEJmhRgiMQjP?=
 =?us-ascii?Q?XWqsDWlF1r+HRe3yv5avZisczeWFBgBVFOD0fkiZT3Coj98jHJ749u+mc7bB?=
 =?us-ascii?Q?Hi8a401bchnbk+J7jC1uVOvwSlcaDUzIEQP7RxkwdeGlazjcSVKpxeQddELX?=
 =?us-ascii?Q?JCIGzzsuUEn6YmYf7qP6QYPUVva46UnBa47jgLnR2eCuZDVMFnWPsiCMrV2r?=
 =?us-ascii?Q?/qMsUsdk1TjhABT6C7saeAiiE87Xrbs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb275b2-490b-4bf6-5de3-08de756fdd5b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 19:47:25.1555 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r9HX+wctLXdEhObyVUKs7bTVXCaw9uiJw0ideXeMuDsYKmvGsLxcM5QX3+8OZisiK0dbTBUoMJtTZXZlLKPySaxPEYO3oE9hEKxJ/+h6if8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7588
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

On Thu, Feb 26, 2026 at 04:43:26PM +0000, Radu Nicolau wrote:
> 
> On 26-Feb-26 4:22 PM, Marat Khalili wrote:
> > > diff --git a/lib/hash/rte_hash_crc.h b/lib/hash/rte_hash_crc.h
> > > index fa07c97685..66f11fafcd 100644
> > > --- a/lib/hash/rte_hash_crc.h
> > > +++ b/lib/hash/rte_hash_crc.h
> > > @@ -127,6 +127,24 @@ rte_hash_crc(const void *data, uint32_t data_len, uint32_t init_val)
> > >   	unsigned i;
> > >   	uintptr_t pd = (uintptr_t) data;
> > > 
> > > +	/* align input to 8 byte boundary if needed */
> > > +	if ((pd & 0x7) && data_len >= 8) {
> > Perhaps the case data_len < 8 should also be included, with each of the if's below checking and correcting data_len individually?
> 
> No need to include this case; if data_len < 8 it will skip the for loop and
> fall through those 3 if's, and get processed there.
> 
> 
> > 
> > > +		uintptr_t unaligned_bytes = 8 - (pd & 0x7);
> > > +		data_len -= unaligned_bytes;
> > > +		if (unaligned_bytes & 0x4) {
> > > +			init_val = rte_hash_crc_4byte(*(const uint32_t *)pd, init_val);
> > > +			pd += 4;
> > > +		}
> > > +		if (unaligned_bytes & 0x2) {
> > > +			init_val = rte_hash_crc_2byte(*(const uint16_t *)pd, init_val);
> > > +			pd += 2;
> > > +		}
> > > +		if (unaligned_bytes & 0x1) {
> > > +			init_val = rte_hash_crc_1byte(*(const uint8_t *)pd, init_val);
> > > +			pd += 1;
> > > +		}
> > Shouldn't the order be the opposite?
> As long as we process the right number of bytes the order doesn't matter.

But if we reverse the order we get more natural alignment. If the data
pointer is off-by-one, e.g. 0x65, and unaligned_bytes == 7, if we do as
here, we calculate the 4-byte version and 2-byte versions with 1-byte
alignment of the data. By reversing the order, we would do the 2-byte
calculation on 2-byte aligned data, and the 4-byte calc on 4-byte aligned
data etc.
