Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33FBCA0EEB
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 16:07:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18EE6402ED;
	Tue, 19 Aug 2025 18:07:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 07829402E4
 for <dev@dpdk.org>; Tue, 19 Aug 2025 18:07:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755619658; x=1787155658;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=QaaRFV8QP7GQBh8xyBfl+6bjmH7swSPTL0KOdkChwpM=;
 b=SaDH3iMvD4YPNzXSaPISOuvpgVpQVosIrfLyfteQGnbi5BK2w+2h71pz
 bkj97H+x2Rspi7+LqpZbpwitulP5Bd+/BwTj42/mR/2gTnvpTWFKbJUPn
 ayLstRXXIVWJp0Lv1562uqTTdpqTBgKPpuIXbZpmLbk5dHoYH2R4MO4jx
 sInpQDJZLerQ1hlMjiQRTmypyzUmxW7DT3AF/v41Pda/KoYC/IX8grgAC
 URPdLr6Fda2jet1N8h+RLYFmbBmfA/xxbH8RGkHJNw1xvz818lCkHqZM+
 Ns9cpOOYg2GqabJ0Q0b3Yl432fN3RpjBE8RpVwF5NYAv3SVyDSc5aKOP6 Q==;
X-CSE-ConnectionGUID: At2aw00gR/GG9TrPeprGdQ==
X-CSE-MsgGUID: Nx/yQxxcQDmaWOm6gnmXsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57725362"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; d="scan'208";a="57725362"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2025 09:07:37 -0700
X-CSE-ConnectionGUID: sl3zoUt8RvqDv2/iwxFBOw==
X-CSE-MsgGUID: Dt0xxHY8S2GwN4RjH4+e9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; d="scan'208";a="167068105"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2025 09:07:36 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 09:07:36 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 19 Aug 2025 09:07:36 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.83)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 09:07:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=clDzSTzOLUYRT9Mb8sKZuGydhrdvjxdmm4Aq2EyyjFdnPyiR/YY7LOMI4ooz9bYalVLiFMIRFz5kOauPGfJ0Nnb+xsOVy4LTCKyqx8m9TFXACIq/4cjcFHf5eOqWM8g+FvTUVI8MncQ/BwPgclOfvOd3vrKUEBkiuPxIf9ICsuZNKY/z2ta1N4PDYyqPRTzeHDoXmgzdjaeeBcgWRq7iqgYwpWTl3EEie7PoujicDbTwmHT7oGB1CEr4O1TrZEtKtsu+3ZEEgdbn0XTPwBv9NYzEzXMkO/HPJsx0eZ7n5Yte99Sxp0WgaYNyHQSNn6DCcXQbUvIFzOTrk6kdmS0B5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twcynAjTPSukDKv6Od3DNKES07ct8vkVIpM1ajJpKWI=;
 b=b8CE513K3pf/VvognctQf8ABJrUbM0zMxuuSphYOrBuYaOnmij2IBB8AlIi3+wwYOHpu/Sf7yiJ6STghiisACLBDmgw+FSQ1PoUvLXrMnd8/G7Q+57dU0j5ywnu7H2v4vEVX8TQ/Nf88/SBR5RqbferpK2TJ93yJcpIZP1ZRjroNxu3trfJ7bv9YJsCt9cn765uWodVGJFmFXFHNEgBnXbePVsIYTzHauaKmM5cQYOUS/sh89vmar3lvQPmc6kfm+rAqphCrNS9/fnuvFYHzHTkp85V/Bx0OfwCOUaoPFe04FHf2Rn6VhofGJepBHu4n/JA4x//dx8QiBoiC1hQyoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS4PPFFCBF1B4C7.namprd11.prod.outlook.com (2603:10b6:f:fc02::62) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Tue, 19 Aug
 2025 16:07:32 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 16:07:32 +0000
Date: Tue, 19 Aug 2025 17:07:28 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Thomas Monjalon <thomas@monjalon.net>, <dev@dpdk.org>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>
Subject: Re: [RFC 01/47] eal: add BSD version of queue.h
Message-ID: <aKShQNPf9lmRtOnf@bricha3-mobl1.ger.corp.intel.com>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <2598643.Sgy9Pd6rRy@thomas> <20250819082444.66718343@hermes.local>
 <2710899.tIAgqjz4sF@thomas>
 <aKSa7Hjb-UIh-4Ak@bricha3-mobl1.ger.corp.intel.com>
 <20250819090341.0ce15d26@hermes.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250819090341.0ce15d26@hermes.local>
X-ClientProxiedBy: DU7PR01CA0036.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::25) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS4PPFFCBF1B4C7:EE_
X-MS-Office365-Filtering-Correlation-Id: eb44fd3d-9e5a-43bf-e67f-08dddf3a8128
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e4Bbt+09aB4z/3ZPm9XDmqd/NZ7/CLSasQW0lkmIKjKbJZVV+OkYiKuQNgru?=
 =?us-ascii?Q?qZ3xZttxd3+e/t+borZOcGVlQHXoigztzWhGUC2YdP1JuswN2VEEbc+K60lB?=
 =?us-ascii?Q?lepUWCk3qA4pr7HCoIsr9wP2MzTaqwv34EmBSN9If6330H26w/o1Zs/21x0W?=
 =?us-ascii?Q?rbvMriAjZyhlVR0z0X08gO/zMbBggqSqxq/asVmbhldLilF+Lk5F7CVJIPdi?=
 =?us-ascii?Q?uCe2C4XHtNVMva/ArXmMuXMigIxkNjSqzXb+g3dnezQTPXhd8sRHUpeVa1YM?=
 =?us-ascii?Q?6ASYplwh6LzYymnpSBA2wIfcGqF5E0Ms6sbSLcVB5GykzWkUQ6/Owwmfdmue?=
 =?us-ascii?Q?q6sGvvp7R5kgbyuYfgnMjsWyDwquPL2oxXigohl2eIjUJUrs42OIYQC0VB2f?=
 =?us-ascii?Q?D6ICuVP3xXjIVucwBoBkw2Et6kAs4V6o69wBlFUg1cY6Ol3Ok/PMR3rvXMQ4?=
 =?us-ascii?Q?YXs5Rtvl4qjYyyJiQK/siUHY+3k0iDWvtrM47hOIJRLxusLPQhm8HBBOJX6V?=
 =?us-ascii?Q?lFQad1WT3fUEwGthIeWWhVHckTSNfIn1rdT+yD1D0eDRYJDlZCKWCMM7m6J6?=
 =?us-ascii?Q?LP9B1qNHzDZq0z/wr1iPGUsef2wSz4IAox2DYl1AKK+5mQZiQEZ5IIzsKfse?=
 =?us-ascii?Q?RaHZBwnUlLfH427dd7T9GPwo1ZANiWuTkPLM9YoHYwyw1ZxMQTzVaSalA4DO?=
 =?us-ascii?Q?cAzJmZMqjptYLTtEIpNwNpW9FiAzXTsY3UabqxhUJj9AQan9zRLNvh0Tt0B1?=
 =?us-ascii?Q?5HnQCllGkoy7UJ+kx7QSoI5o8ZPrwFgI8gThIQ7tu1wwEU5aJOmwL6OgLgDK?=
 =?us-ascii?Q?1HFlKOD3Gu2QOy5rFjDeYd+L7CUtuJwRIPGvIlGcxxivL0M5sZpTruZdWJIL?=
 =?us-ascii?Q?E6Sao74pU8gkcdfK9e/wdhAwXShNpSBwbW9Ch15o+WbXPU39s7+aEoivw+qR?=
 =?us-ascii?Q?We9b+QZImMp2KWKSpqOuC+07vN/YUZBsADguZyKT/AD3vw5NZcikq/hZQgLF?=
 =?us-ascii?Q?AMPMf2FT5y/qAxLelpkWX5FHqe/qPKwiSOgzliOjtrW5A8PnfHK/QKUnLyIb?=
 =?us-ascii?Q?p5ROGekvYnJ0ewS7d1uxWXUqU0sbi3svOu+uzVCUck7/A7H0aU897OYa3ssc?=
 =?us-ascii?Q?kUDvf6mIYPjqzHC/dBIgHQiZyoMOSueDm8MmH96ayggaeiUQ7LR7DNGCrDGa?=
 =?us-ascii?Q?9DNKwy3GyADqmuWlqFGjJU+nsmQpmeFK8MPsBfXOmYkPUr+9p8Rw05i0nE6Y?=
 =?us-ascii?Q?LqkzOfU71gi1Dj7nZDd3dwVnnHmXQOYPr/4tL7tAk4j9a/fROZuxOlVQPTIS?=
 =?us-ascii?Q?/8k8RGMo8QdInrZPlHjKlE8iQ64sS4Zm8cUeABiIxgz9BeSbMamVSJVirvuG?=
 =?us-ascii?Q?cZRJSjNp/ziU07fRPVcOr0Ze7Wrcaxp2Z4WmuCW8ZOd7xLvODOpde+n/d9L2?=
 =?us-ascii?Q?nyutSlzUp7k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zTDiPCjpFNxUHelx5/wC1GTOyefHx8cnavZwroiQaO8WuFRaBlJB/LRl2gj3?=
 =?us-ascii?Q?QS+OSY2/jPCrlif5bG8XzffRcQpgs9HeQzYZ+gbar4rvC67oB4vp3/jUI8uR?=
 =?us-ascii?Q?2JOGLd+43oxxBnxZdyApR8z83lz6rFmMjthxQ84jY7pZLQG7fR5sIol+CN14?=
 =?us-ascii?Q?PECQyDNb2ldMRTCgSEDKxD3b6S0VB0mPALjxGBjo5Iqd+G75QkbNtzPS/WsX?=
 =?us-ascii?Q?Q5oVKLX/17FozF1831JqfOmXio3QMh/GUW+ZiO/arIq8FEAU7gTxYiKSKVco?=
 =?us-ascii?Q?Gaa34vfUJnnyw93dbO19XVPYq+QkZMapIztNbYRj3M0brwvAn02ai139owEV?=
 =?us-ascii?Q?jguKxnqZ3XkmBk7V3JIVAwVtvAjt24k9k0IFad9/A5+rD3PFf/dsV8EjUgM/?=
 =?us-ascii?Q?fBh2lsYW4MivyY1DMN74qGgTHbT6kxhCWfu5OwOsFLISKtQr4fcVia5auGFU?=
 =?us-ascii?Q?x1SY9Ct72pKeRSqCv1ibzszW3B4Ocqe2pShElmGLcj1eHWuBvkHYOVXbJWiw?=
 =?us-ascii?Q?P9cDj+6i8X7J7nYItVco8kYfzc1CtDQMnXkBa4VEtcH9SQT5W2MPnCAc1y3r?=
 =?us-ascii?Q?TDx3kXoEk3ozb/14vG4RLG8rwNG+rclCXdfQlJKg9hmCvSmDmvHVSHiPipuk?=
 =?us-ascii?Q?KoBP5jGNXed8LOCkX1xSp5zQWYWRMx3vqC2ud/AbNcP8UPgwlNaaWXH3QTpc?=
 =?us-ascii?Q?k0ecEx/NqDHzPN1s/cUiwa7/uXSP6K+RFhQOd9d4PEvgtKvfey9zh6rIpsPI?=
 =?us-ascii?Q?wvgbh3PJIrF0RlQAfMG8hYppdaS140CNUQ7JqaVuTvZ0TGza4QcBT9r1j+LI?=
 =?us-ascii?Q?0HufiXGPcdP/n2gwu8tU8HGrvzpFIJlDluq9DoXTaSwK3wZRjYK54ZGf9OKd?=
 =?us-ascii?Q?75+wmjr8qkM8yc6Pubt9y6nf0osWaCOMdYCZa4ZAGuOtKBlPpZ2f5lTTQ7qJ?=
 =?us-ascii?Q?y/4c7ca42EAnHjGnKAGWF+yNm0XU/zkcVONr95kl5HjF+Ih7AcY1fAQnnzrX?=
 =?us-ascii?Q?hrAJ3sxpCnDf7PPQI3I1r/SsB/m7N12rS669Ltq9RtkuHU68tyYQwSRUlRTu?=
 =?us-ascii?Q?c0cptFVTx3EVcI8n56D9+bOcmO+wzP5r8ZZ/C2goXin2kdMf22MiwuRbf6jx?=
 =?us-ascii?Q?wGO2SaZuQDFLWn4u760O8z9xwysdGic6pn/HMRfC4LP2E2e/e9P+4K1hIx2l?=
 =?us-ascii?Q?CCwj0mW8OMfGbyVspdOzi1Y1cibx9Ied5Q6yPuiIMfWjlb5akYvZF/l4CIWK?=
 =?us-ascii?Q?Ld3BRH6GbRp5VsV5y3eFdyY9MFr/NvxgdJ+9IPpegpFD8cilsICxb3DOmeIp?=
 =?us-ascii?Q?mdoN5aWqQvxoalEbf4yN9QW4bsmDzusAkjSKF9GYrFRj9m3j8mlJOzaKiNzp?=
 =?us-ascii?Q?WjFSyzl3HcC6Jar31oixM4MEgB3ZaPMuK+97+ghMgsrVprj/0R+iolRs7HoX?=
 =?us-ascii?Q?/+bfIX7noFSmpukoioVu2PGJWWTFkzxfPJqY6neoYaaTGVrNhwyRfFracOgB?=
 =?us-ascii?Q?VVhIm0xftRh4xk/XfWLKxhZq0zDcryZNy/G6hTm2vP1LB5c2a8MrSImDLVcm?=
 =?us-ascii?Q?zMmONg2Hs5eqbudd66cYQQabVZI3VsHxt3bPeANqHIiXW8FHC0+JXOGV0a8s?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb44fd3d-9e5a-43bf-e67f-08dddf3a8128
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 16:07:32.6588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wr1Zmwofy/DYBlB0/4eDTTmlcCsERDMJU1fuoMU6nH8Udt82c3ENnD3ecAS0DWxjJ2p8nYUdCMYthgMQ78NJu9n0XyKNnTmIxsNgczve+9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFFCBF1B4C7
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

On Tue, Aug 19, 2025 at 09:03:41AM -0700, Stephen Hemminger wrote:
> On Tue, 19 Aug 2025 16:40:28 +0100
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > On Tue, Aug 19, 2025 at 05:29:28PM +0200, Thomas Monjalon wrote:
> > > 19/08/2025 17:24, Stephen Hemminger:  
> > > > On Tue, 19 Aug 2025 10:37:27 +0200
> > > > Thomas Monjalon <thomas@monjalon.net> wrote:
> > > >   
> > > > > 19/08/2025 01:27, Stephen Hemminger:  
> > > > > > +++ b/lib/eal/include/bsd_queue.h
> > > > > > @@ -0,0 +1,1075 @@
> > > > > > +/*-
> > > > > > + * SPDX-License-Identifier: BSD-3-Clause
> > > > > > + *
> > > > > > + * Copyright (c) 1991, 1993
> > > > > > + *     The Regents of the University of California.  All rights reserved.
> > > > > > + *
> > > > > > + * This is a copy of sys/queue.h which is used to overcome
> > > > > > + * missing parts in the glibc version (and Windows).
> > > > > > + */
> > > > > > +
> > > > > > +#ifndef _SYS_QUEUE_H_
> > > > > > +#define _SYS_QUEUE_H_    
> > > > > 
> > > > > Shouldn't we rename this include flag? with RTE_ prefix?  
> > > > 
> > > > 
> > > > No, by keeping the same prefix if the user includes both sys/queue.h and bsd_queue.h
> > > > there will be no confilcts.  
> > > 
> > > You mean by checking _SYS_QUEUE_H_ which is the same as sys/queue.h?
> > > So if I include sys/queue.h first, I will have a limited version.
> > > It means we should not include it before any DPDK include.
> > > It looks like a limitation for DPDK users.
> > >   
> > I think we should define two defines for our header, and warn if
> > sys/queue.h is included first.
> > 
> > #ifndef _RTE_BSD_QUEUE_H_
> > #ifdef _SYS_QUEUE_H_
> > #warning ...
> > #endif
> > 
> > #define _RTE_BSD_QUEUE_H_
> > #define _SYS_QUEUE_H_
> > 
> > ...
> > 
> > #endif
> > 
> > This way, sys/queue.h contents will be skipped after our header, but if
> > it's included first, the user gets a warning about incomplete
> > implementation.
> > 
> > /Bruce
> 
> There is a similar issue with kernel headers already. And it lead
> to lots if #ifdef __UAPI_DEF_XXX which I want to avoid.
> 
> Rather just do wholesale replacement and if application includes
> the other header, it will work since the BSD stuff is only used
> as add on.
> 
That level of ifdef checks what my suggestions above is trying to avoid.
Just by having our own header define, as well as defining the standing
sys/queue.h one, we can avoid having queue.h included after us, and also
warn the user if they have already included the incomplete header. [Though
for correctness, I suppose the first endif above should be an #else, so
avoid dup definitions if that occurs]

/Bruce
