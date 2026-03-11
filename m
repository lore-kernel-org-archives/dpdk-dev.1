Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B54112586B
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 19:09:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2066640A76;
	Wed, 11 Mar 2026 20:09:56 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id E0C7E4060A
 for <dev@dpdk.org>; Wed, 11 Mar 2026 20:09:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773256194; x=1804792194;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=WzcLbrWHl4lzfATEaZoGD7hOd0MlPidSaawKu+iCcPM=;
 b=QJYX6kvQ5bKxWpHP9VivvO5RwZWo0rDPYojXRXZ0B1Yyqbq1Px5BB2oe
 jQn5pH3SA7QHt2bYJQtxW2cYVc20uPHdotWR4+0xF2fD552FO8TchPTkn
 x6AqhwapqWo9Me3+xaNWE6kxvpNn7W5AnqE7QFwvdjEoqqxgHMjHobYAk
 4P/DIXpSKuf4Yp5Ru6V5513/g5AGxI+iQT+U0qDHiZJFkG2gCcPMK9IqV
 8z6a8rk6R314+j727kkN7i+dxF8Qog+tJljdxu/k8Q055Q1vQ7glMTW/n
 M2TEjppNPRyWSoTp2gjunsCWUsmzK4/HWBKSl7lk554MGrJ20qdN6zMxy w==;
X-CSE-ConnectionGUID: GXDZ2XTbRk6bxKzIall9MA==
X-CSE-MsgGUID: /hnWf0mNQ3OxC+FWU5a6aA==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74526814"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="74526814"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 12:09:52 -0700
X-CSE-ConnectionGUID: o7u5NFkiR1qBYzIyA7BhGA==
X-CSE-MsgGUID: 320oxGRpQnOW/wTJsKd4cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="223077063"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 12:09:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 12:09:50 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 12:09:50 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.1) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 12:09:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=phBPgu8CjkhiPlhAiSHFNhrDFhy2C/bypW6rwchxlDWs81PIImnFziYhQoPXxXWCsmYVTqepp0YKND4aJlpg1pzo8WL0WRXucghXALqMEm6aCzRNJJhf5j+AbdniEZiK99dHZbWD7WVA+kcQC5410G+AIx8jLKv8Vw3dzvgRngRDf+938ppnZTaXqdVdBR8X4NugQQ50lp0jYPFM8IMlt/ChE4VwcNmqEReFvyJfmQlZpaBZbg91TIV0nChJ/7XorbHXbEKN46hBhlgRDbB7I1Oi86DGQp6ivPetG33p4cqFEr+7Lm2R0LwDjbvt2QO88WfjM9yIwjbMYBz8osGAPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4sHDpWf2w6EMc23UO9krzkhUVejUjYQAN7oAaXVKgM=;
 b=dK8a8fcvn3XlwKKouSdWfjP1JUWu17Ii6fGyMXD/nwWDA3IamRSsywFZyK4yesE3FM2gzrYi1BJLK4iUJJ7CVFHbpXoli1ExzlTcAg4QER83kMPf6PLASa2VrOXWCAOPs1UZMprcw+TBT+6KLOEFGFcdfQ28osMTzcG5b7hS2bumKSetggGK4pvqsC7VYt7gfIAP55rkliJMhxzv4jlTgIx2p6S7AFdF+IjHSndKInnvjHQ5PI4Nq30yL5UgnIj/X0wz+joUc5ai6sG8l2v3A5ETaQhX70A+SMSruGykrYJ0S88T5c+mh+G/sbBayguz2f/AkbJvejkiVoRSBqxeOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB6725.namprd11.prod.outlook.com (2603:10b6:806:267::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 19:09:47 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 19:09:47 +0000
Date: Wed, 11 Mar 2026 19:09:41 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 "Vipin Varghese" <vipin.varghese@amd.com>, Stephen Hemminger
 <stephen@networkplumber.org>, Liangxing Wang <wangliangxing@hygon.cn>,
 Thiyagarajan P <Thiyagarajan.P@amd.com>, Bala Murali Krishna
 <Bala.MuraliKrishna@amd.com>
Subject: Re: [PATCH v7] eal/x86: optimize memcpy of small sizes
Message-ID: <abG99TTs1W3-iX1e@bricha3-mobl1.ger.corp.intel.com>
References: <20251120114554.950287-1-mb@smartsharesystems.com>
 <20260220110824.235784-1-mb@smartsharesystems.com>
 <abGfSARwKc4TV_dU@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6577E@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6577E@smartserver.smartshare.dk>
X-ClientProxiedBy: DU7P251CA0002.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::26) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB6725:EE_
X-MS-Office365-Filtering-Correlation-Id: b93d0c64-7fc6-43ee-c205-08de7fa1c329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 4k+f72Mo6d8q8hL3pfcoTLSdzT5bWtkw8Zvny+ctgCQaUMOCj3T77O2wFncn/0ATrPzg0t1lJh0SURblgTzQu9a9EHBTk8tlAXJxp/tXSKYwpt5MXuGwuc5v9CRDkrw7dWTEZKxbH7xh0Lz2Deu4BoMAXWGVVGYPvD8LXJ6XnKQArTNqNFoz/0Rol0I1FAgf3WhxaWpxJjovlYGdKwdQne7NO1ZGLykAvs09wgtTzrTU9P2f4K64CC+ApJL2HrOB2EXJw2rZra0AgAOcwwK1POxogHroHoTGtrv2oqyFeY1I6vZkn+a//6TjABvL9br6CJgF/ceRbJbOpO62Yn1KL7TMbmvhqVZ5U+ktmKqJO7arXGDA467UTCgCMdbkPAnOve6cgzi7xmi2n6tKj4cZFkY51EUIxDmrGkutvV0TU+7D/UtdEqPP4qJrPWZ6a4FwEHZLIFH5QfAf+3QqLx+IsJHt5BhM8rJ6uEz/WU7D/iL0byCTroEK89gs2dNKFgDgsunsSfbR1+GOlhL731EMDupQIHTLR97xM10v0sUiEUCt6FaLysv9303qj0R9CDSFKbNkxyQbHcOze+w/lbB7HZ4OTp3wTG6CSNQwczhVhZ5kv6cXD5mj2pCA0nkaHPqQP5hVtnR05snrdYfX8oceJPBI2lPnHqgh7bj9+VQylx5XOiyldUCk4sBvnHFLsiLn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?SQvbfQECygu77f92joXoX7poL25FRMGcBHv1dwWV4+JXy2+Rp9lHrQQsk3?=
 =?iso-8859-1?Q?b8LS0o9vS1b2MIU1kFtw1EDcSMI5h88dg6a9zp9HoZvzkvOU4KdKOYbXcE?=
 =?iso-8859-1?Q?PH8MGDJ2MT9q/Mf6KiOkcruph4OMk7itBIR3mb9lqXLpAVe4mLCQfigvRm?=
 =?iso-8859-1?Q?VqZpW++AubM/3PvTaHi4Yel51bA2mbMMVmPUcgEtUjfWN/ZzlRB8VRE6DC?=
 =?iso-8859-1?Q?JR/aEOzXhxs+dRYzNvVtV5SQHZqb8iayB7W623JBkS+eaUGvTcwqyS8XGY?=
 =?iso-8859-1?Q?Rt46i8suvRyx+lWUTc03bPPQfpfuIIW1jon7rD1aqv00osVgOIYajlFGu2?=
 =?iso-8859-1?Q?Neh6PRTMwQtn4IAou7dBnz1/N4ZX3sTClasoBzmmokOzlcEKpFJVe3h1Kz?=
 =?iso-8859-1?Q?T26tERbcel6XHwCOQDLsmFin8CtKwIwkLUC8GZvpDfGJkK5AftEUOg/Pgj?=
 =?iso-8859-1?Q?bK46ikgMf/hruySfEQkNKZRV6VqwwzUGB6CRJPh5OgiLiHV4joHk0edEer?=
 =?iso-8859-1?Q?HxKyywudNctyTxYRcCUeP2TqGyS68z1CorbQXRlEJRzS0PYI6i12mudlEY?=
 =?iso-8859-1?Q?pKNhhx0Ki1n8O3Po450/DgDX7wYuA4rYCNnMTwLVZB5JZxifSuI+1GXIiB?=
 =?iso-8859-1?Q?JGbLr4VSj2bORb4ac29c9zIa2iTz+W+KSwHY6cWPElqn2rrvEBuBviqwPJ?=
 =?iso-8859-1?Q?2FtOAaWXWODt3VkqhQzCKO0lVk2R6yzsrGse1ooIccNcWgpg5DqfoeLaag?=
 =?iso-8859-1?Q?gMlWbSQQ1sMY3nQzaJybX6dIz/oFAh68YNePt3PRiR/bIU8eUxlFu5SqJB?=
 =?iso-8859-1?Q?ozSVxpaRJa5TH0G0LRKUy3Z+sagreuBBfq5Y7lXrFnecnoPx8AACxgZKjr?=
 =?iso-8859-1?Q?0kQidcn07MGbNNoEx1j0q4j9lc/+3GmHlnS5juIePMcoYyVeEfQDbqgPBM?=
 =?iso-8859-1?Q?I1GwF3/7nO3QRSPQNKCoUBvcJl+SY63awD4ZtWsyxu2XRGsVwCvLsBjsCE?=
 =?iso-8859-1?Q?qJYRjviNiE+LFmBbVrat1/6DrbS70InWrxYSbLksYuDwMQwlMB465uvVyO?=
 =?iso-8859-1?Q?od3ddMKaj8V69Iwjk7FCnMGURK/Se5Vaguo/6HpR+JptiZ81mjeB4eZHEQ?=
 =?iso-8859-1?Q?p0MB5Q8gn+o+VlQoqj19H1AzMf2qcHcc0HOsFpvG84h64k+tSuc7efLZbv?=
 =?iso-8859-1?Q?6bJ251Bzz0ElblL7zMODnqgZj5+8ozohmXEd13EOPJ9AVDVlm+Yvtz7Jie?=
 =?iso-8859-1?Q?5yNmZEHVnPGwvn4l3Hn6LR5rAhVJTH417ZEJUCR3HWr/IjEUvG0iCVcMsX?=
 =?iso-8859-1?Q?Kwu2NmM931cXhlXmndc1PfBKYoi3lCze4k9MzN8VEq0YitCprFQKP0PyaU?=
 =?iso-8859-1?Q?BOk7dpjVoE4B7WlLh92OeU95WdVgpvVEYSN5BaL8vHo2xSRVlWpjbR7w60?=
 =?iso-8859-1?Q?KxS2nvbH90DMlDU3LNlXnP2baAjkp7x3lbffTLyBfVeWon6dWOw0iM36pb?=
 =?iso-8859-1?Q?WBf9RaobjiiY6XyTu1vOnTxUOkMde8SWOhvHFEEqHExOkUJrBlq7srQCeM?=
 =?iso-8859-1?Q?8mweDBhDCRfz5jlzlIFw3VfJuQvjiSJY5WKrxyRA3ixXndOViG0u1dwjY5?=
 =?iso-8859-1?Q?6S1F2cvU+fFHGh4hB309ef4B1xseDY5Q2DJBlAT/9f0eV4CyvEHmA+JeaW?=
 =?iso-8859-1?Q?90GzGQieo7sg0yZJgXkfHIlTGDNj8jxshPfIqMWvMFKxB20JMrgTRERrM9?=
 =?iso-8859-1?Q?Z6RdrV0ttFpPZbWTKF5wU/2siUyyYI9Y3s3cRqu5UNO+enZ+aOsoWdkNEO?=
 =?iso-8859-1?Q?pC3JTVECoKrbl0EFLsD3LnrxCQDVwg8=3D?=
X-Exchange-RoutingPolicyChecked: kRDpVzfqvwySioI/AE8VhzFxXet8Dg/hshQubpDrLkIw3aTc2+RvGWyXcGbZadWOlb6zoHtWsiaRZ+D/aibXY8zG6XxT5H9ddAFxU5ulk08HGByIhvT6YiV69TSswt3NlPheIx0pa61MSKX4fzHirFqd/P5AsWLaRSQbl9jRaCWbif9o6P9+w4TEgUpGbFLcV0G9zGppXz5wymYsQP9+Ic8iolsFMK//8WJLrKQUcBRxVvUjQKtS/e/an/KbUW2MeYU7TucxuzaApPGLKJ+avI5oDCZWC8/XrDO5LZTnSxzaYjXYMeTMQrHWK1BrQLqfanfGY5FCi2NCihikVzcH7g==
X-MS-Exchange-CrossTenant-Network-Message-Id: b93d0c64-7fc6-43ee-c205-08de7fa1c329
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 19:09:47.6076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tVEB+4MxxMLc4qDRYcuZcZdSuydZ3QaCsrGUBSzUCd+vXUIJmFp/wboJjSJEn8y2Wt7gAOZkqVkAjLq2gqbTZIWscNpLCdHzypmWLNXG6PY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6725
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

On Wed, Mar 11, 2026 at 07:29:38PM +0100, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Wednesday, 11 March 2026 17.59
> > 
> > On Fri, Feb 20, 2026 at 11:08:24AM +0000, Morten Brørup wrote:
> > > The implementation for copying up to 64 bytes does not depend on
> > address
> > > alignment with the size of the CPU's vector registers. Nonetheless,
> > the
> > > exact same code for copying up to 64 bytes was present in both the
> > aligned
> > > copy function and all the CPU vector register size specific variants
> > of
> > > the unaligned copy functions.
> > > With this patch, the implementation for copying up to 64 bytes was
> > > consolidated into one instance, located in the common copy function,
> > > before checking alignment requirements.
> > > This provides three benefits:
> > > 1. No copy-paste in the source code.
> > > 2. A performance gain for copying up to 64 bytes, because the
> > > address alignment check is avoided in this case.
> > > 3. Reduced instruction memory footprint, because the compiler only
> > > generates one instance of the function for copying up to 64 bytes,
> > instead
> > > of two instances (one in the unaligned copy function, and one in the
> > > aligned copy function).
> > >
> > > Furthermore, the function for copying less than 16 bytes was replaced
> > with
> > > a smarter implementation using fewer branches and potentially fewer
> > > load/store operations.
> > > This function was also extended to handle copying of up to 16 bytes,
> > > instead of up to 15 bytes.
> > > This small extension reduces the code path, and thus improves the
> > > performance, for copying two pointers on 64-bit architectures and
> > four
> > > pointers on 32-bit architectures.
> > >
> > > Also, __rte_restrict was added to source and destination addresses.
> > >
> > > And finally, the missing implementation of rte_mov48() was added.
> > >
> > > Regarding performance, the memcpy performance test showed cache-to-
> > cache
> > > copying of up to 32 bytes now takes 2 cycles, versus ca. 6.5 cycles
> > before
> > > this patch.
> > > Copying 64 bytes now takes 4 cycles, versus 7 cycles before.
> > >
> > > Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
> > > ---
> > > v7:
> > > * Updated patch description. Mainly to clarify that the changes
> > related to
> > >   copying up to 64 bytes simply replaces multiple instances of copy-
> > pasted
> > >   code with one common instance.
> > > * Fixed copy of build time known 16 bytes in rte_mov17_to_32().
> > (Vipin)
> > > * Rebased.
> > > v6:
> > > * Went back to using rte_uintN_alias structures for copying instead
> > of
> > >   using memcpy(). They were there for a reason.
> > >   (Inspired by the discussion about optimizing the checksum
> > function.)
> > > * Removed note about copying uninitialized data.
> > > * Added __rte_restrict to source and destination addresses.
> > >   Updated function descriptions from "should" to "must" not overlap.
> > > * Changed rte_mov48() AVX implementation to copy 32+16 bytes instead
> > of
> > >   copying 32 + 32 overlapping bytes. (Konstantin)
> > > * Ignoring "-Wstringop-overflow" is not needed, so it was removed.
> > > v5:
> > > * Reverted v4: Replace SSE2 _mm_loadu_si128() with SSE3
> > _mm_lddqu_si128().
> > >   It was slower.
> > > * Improved some comments. (Konstantin Ananyev)
> > > * Moved the size range 17..32 inside the size <= 64 branch, so when
> > >   building for SSE, the generated code can start copying the first
> > >   16 bytes before comparing if the size is greater than 32 or not.
> > > * Just require RTE_MEMCPY_AVX for using rte_mov32() in
> > rte_mov33_to_64().
> > > v4:
> > > * Replace SSE2 _mm_loadu_si128() with SSE3 _mm_lddqu_si128().
> > > v3:
> > > * Fixed typo in comment.
> > > v2:
> > > * Updated patch title to reflect that the performance is improved.
> > > * Use the design pattern of two overlapping stores for small copies
> > too.
> > > * Expanded first branch from size < 16 to size <= 16.
> > > * Handle more build time constant copy sizes.
> > > ---
> > >  lib/eal/x86/include/rte_memcpy.h | 526 ++++++++++++++++++++---------
> > --
> > >  1 file changed, 348 insertions(+), 178 deletions(-)
> > >
> > 
> > I'm a little unhappy to see the amount of memcpy code growing rather
> > than
> > shrinking, but since it improves performance I'm ok with it. We should
> > keep
> > it under constant review though.
> 
> Agree!
> 
> I just counted; 149 of the added lines are for handling __rte_constant(n). So it's not as bad as it looks.
> But still growing, which was not the intention.
> When I started working on this patch, the intention was to consolidate the copy-pasted instances for handling up to 64 bytes into one instance. This should have reduced the amount of code.
> But then it somehow grew anyway.
> 
> > 
> > > diff --git a/lib/eal/x86/include/rte_memcpy.h
> > b/lib/eal/x86/include/rte_memcpy.h
> > > index 46d34b8081..ed8e5f8dc4 100644
> > > --- a/lib/eal/x86/include/rte_memcpy.h
> > > +++ b/lib/eal/x86/include/rte_memcpy.h
> > > @@ -22,11 +22,6 @@
> > >  extern "C" {
> > >  #endif
> > >
> > > -#if defined(RTE_TOOLCHAIN_GCC) && (GCC_VERSION >= 100000)
> > > -#pragma GCC diagnostic push
> > > -#pragma GCC diagnostic ignored "-Wstringop-overflow"
> > > -#endif
> > > -
> > >  /*
> > >   * GCC older than version 11 doesn't compile AVX properly, so use
> > SSE instead.
> > >   * There are no problems with AVX2.
> > > @@ -40,9 +35,6 @@ extern "C" {
> > >  /**
> > >   * Copy bytes from one location to another. The locations must not
> > overlap.
> > >   *
> > > - * @note This is implemented as a macro, so it's address should not
> > be taken
> > > - * and care is needed as parameter expressions may be evaluated
> > multiple times.
> > > - *
> > 
> > I'd be wary about completely removing this comment, as we may well want
> > to
> > go back to a macro in the future, e.g. if we decide to remove the
> > custom
> > rte_memcpy altogether. Therefore, rather than removing the comment, can
> > we
> > tweak it to say "This may be implemented as a macro..."
> 
> The comment is still present in the "generic" header file used for the Doxygen documentation:
> https://elixir.bootlin.com/dpdk/v26.03-rc1/source/lib/eal/include/generic/rte_memcpy.h#L99
> 
> All other architectures rely on the "generic" header file, and have no Doxygen comments at all.
> We could also remove them from the x86 implementation.
> That would shrink the file even more. ;-)
> But I'd rather keep the comments - at least for now.
> 
> > 
> > 
> > Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Thank you for quick response, Bruce.
> 
> > 
> > PS: If we want a little further cleanup, I'd consider removing the
> > RTE_MEMCPY_AVX macro and replacing it with a straight check for
> > __AVX2__.
> > CPUs with AVX2 was introduced in 2013, and checking Claude and
> > Wikipedia
> > says that AMD parts started having it in 2015, meaning that there were
> > only
> > a few generations of CPUs >10 years ago which had AVX but not AVX2.
> > [There
> > were later CPUs e.g. lower-end parts, which didn't have AVX2, but they
> > didn't have AVX1 either, so SSE is the only choice there]
> > Not a big cleanup if we did remove it, but sometimes every little
> > helps!
> 
> Good idea. But let's not do it now.
>
Agree on all counts. 
