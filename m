Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D84D3EE84
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 16:23:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 283394027A;
	Thu, 22 Jan 2026 17:23:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 418204026F
 for <dev@dpdk.org>; Thu, 22 Jan 2026 17:23:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769099030; x=1800635030;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=MP2m6Y+qlyL50tP9XuB59fB9oyVewYqbGydATVqNtKs=;
 b=gQv7D7yKj14Dltw4Hft/SxgkFvCcxhbR0buo1oGL4RDqE/zdlGPDfbo0
 RIb9PYrYtl5GsSePPoagwH5KwXO7Q/mra7UmrFJRRAymQ1+mBMQkO1RK7
 L/wglQwQ8//FzFtyrraM4zuCBKY1hwiWGSNKrugChxsFy706Cl+94Q+cf
 RSbuj8A6B6TmMJR3mc28BAVmSvBjyxM+yhXtcOyQ+hlJZkzhBhgtRmSha
 uFHMdQ1hTmI3cuRju+lseRBR6+k3tz6wBjVB1kh5zyWe5kJLYa4u74Vss
 M5FfAgtclxMzU18cwOT9/kSEJ1cU738NZ/HPCxwThlaxtdBLv0IM5NjL1 w==;
X-CSE-ConnectionGUID: aNh5ORQRQpeMIMnYgH8Guw==
X-CSE-MsgGUID: HtE4i3zCSqW9csbJEHpMjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="87759718"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; d="scan'208";a="87759718"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2026 08:23:48 -0800
X-CSE-ConnectionGUID: nsO/FxxfT4qmIFFI6d+0PQ==
X-CSE-MsgGUID: tRTtJseRQ6S9tB+jKIJrKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; d="scan'208";a="206822164"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2026 08:23:48 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 08:23:47 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 22 Jan 2026 08:23:47 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.10) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 08:23:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FVefhMSUg3Co+eGxa95dH8w9cgerQdB57Sq24Z1cUUE0ZDmIA6cHznmJ3ByIgU6zSp99l8LkvIL4QTtkhgfAeV/qIfJewpHKVaMJ5sCwYnyfjEr/fBJfy+7osvW8s17VZVz1iiFHpVKOOWkY2MuLQMDDl0FotO9OIGmdZkMnhnhLKA60lD5YYkLwgBb4eIs9/GtXYXytC7iorLTN/eMIqBFunrt06qIwTfy1gku8dGAaVL8EXARXMb1jPnFl8TyuT48OeJJzm7vlypqsMX5Hrf7mmpyiyFO/iVtnDXbJ3++Xm02N1u/+SygQbj5JzmH/VBciIJbthLFg6BrEaJ6BkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZSVMcY1XZ7jalYhVvqhq9e1KYa/zg6iLg8hJYSmTiE=;
 b=BvZzZJEJLaV2y01jPRZKCWLc+JtGK8ctIeUryP6X+IPC0AatAOit9nkhybm9Dxfpdt93XGRzJEWK3JNPzZKtrY4+QlCYSV1J9ZrL4oFk4NvAcs/2Naj/7Z0NR8gF7lvbXH3INdSz3FG1Ki/5vj52/kUdX76zIvZovjG9ym16TbLK2pQI8w4YQ5RvQJR12tEvU7B/PXuYqtYpTOXwlg4FBCW1YYC/AzwzAI9Fxyvab5Op88fnhe5T0wHOOWXYMGbT2Nw6bDT2To6gPwI4DcZosgnMqIoGtSpF9jvS6Jx62RRtoCrcf4KfcKjMDYEiCjRg6LA7dkMsuII4HF9dJdvCLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB4799.namprd11.prod.outlook.com (2603:10b6:a03:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Thu, 22 Jan
 2026 16:23:45 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 16:23:45 +0000
Date: Thu, 22 Jan 2026 16:23:39 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH 1/3] test/bpf: skip some testing if null net driver not
 present
Message-ID: <aXJPCy3H8j0pOA1H@bricha3-mobl1.ger.corp.intel.com>
References: <20260122122354.1820368-1-bruce.richardson@intel.com>
 <20260122122354.1820368-2-bruce.richardson@intel.com>
 <20260122081948.5ce3a84b@phoenix.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260122081948.5ce3a84b@phoenix.local>
X-ClientProxiedBy: DUZPR01CA0008.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::17) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB4799:EE_
X-MS-Office365-Filtering-Correlation-Id: 06ece064-b0e5-4e6e-a2de-08de59d29d3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9+PnSpICbY4blZ+cGU/EVWgtR56lswjq+g4euLLdfYFYAN56hi77vYqGQR6B?=
 =?us-ascii?Q?OTP/KSR4xyqZhXGXD+BUzWCdzVAvfdhGl4BQXe6i0f+Fyi7s6pFvv+uGxZwN?=
 =?us-ascii?Q?R2mT66qyeHxDvwvMs/uYaZVFP8+T2yPySEqa0pxMoAyLl5de09nQNx3DmOpc?=
 =?us-ascii?Q?Hskb432A6INDl3TkI/QKzRTZkktQEqn8tb/FwYCf5gdN4l/VjjyjZXGVBpxu?=
 =?us-ascii?Q?FlODZcrMPF+XH+M00e2Y7za2Vr63XkVdb22l19FLcqqKQtDgeO1zHTi5s+yf?=
 =?us-ascii?Q?uD/Tpb8ma5amuLnN6UjrJhw6mN9pUL98UXW0epA58A10M8c2q8aE4LcgoqHk?=
 =?us-ascii?Q?5/v6Wg2uodZPwJvRbmWXwMLbztYYnY/8h44OMLu6zM7XfdCjlDM7dF7vgu6m?=
 =?us-ascii?Q?SJP9ADSiEPLIQQ8VZvtPHpnkK1N38/K0WJKg0T54eRYiomWSWh5lUogYKp5g?=
 =?us-ascii?Q?MhaFLBqOM1AkHYUttPsyGMpNbU2HWdI4cWCxz1CflDzru3q2DdH0/hSlc+h+?=
 =?us-ascii?Q?uk9KTRtSRt5R+6p7YpcLMafDKCOQ6d8bSCPlogXuNKdK6i3e3sJXX+DDSvfd?=
 =?us-ascii?Q?BlcKdCzoCqMIv4K5BSuMjMEwxY0by6LmLECM+AS6pQlFk5jdfVgPlpKkdk1J?=
 =?us-ascii?Q?V7bE5jf3GGv7Fjpg9DyYaeAxsI5yCZTDMDE79kl4CS9mJaGsQHHoFpSC7rCB?=
 =?us-ascii?Q?HlVjKNsQ4WeYCyaDYKDioJLZtpyPWZ+R4hVxE1uz9/XHmZ9tWIh6waooznVX?=
 =?us-ascii?Q?KT+hFsOtY9VYZe/viCHrKO8BLr+xb9fmHe/dFvJ9tmk4w6z1hJkZtI+8sQiW?=
 =?us-ascii?Q?NcthtHjZENuKFrpntzKC7Dc2zr9OFwvOKSRefV8Y9wsinH1wh+6Zm9GAHV2u?=
 =?us-ascii?Q?DlnAyg1B+ie1y6qL8TsmsvmqDZzYAvoZacWVIQZAOvJTzoUVewNKxMOF6c3P?=
 =?us-ascii?Q?8F9Sy5YwBcTJWdHF0aVFQFyRJ5vZHuKKUz3PXqcq+vQVhJE1OnEGgMM1Z4N4?=
 =?us-ascii?Q?xK2RfRrHDxD8ZfZIXbaH5fHu9ihQkQ2jU8Zb9vIL3ahpZVyLd6fB7NmwQ1Rl?=
 =?us-ascii?Q?IMLjQdmyYHQKIQQZ2pDRhruuyLCZhr356nQyuzxGnBJRKOrlKlhvx6cJRVw7?=
 =?us-ascii?Q?gSTqrrTdkXszqrdE1pjnuqAhsLYyoeDKs3HQnP6r48fZpLAwifnsMaLQjsWw?=
 =?us-ascii?Q?a/oPInMNzk+/AMFS6f9hvge3CdvrzfYzgFpWmb2O0Ei5IKeY7zMw2XoqF6tA?=
 =?us-ascii?Q?FmXQSEAq8EUr0VXJzmYsyj+C45xKhJGgL+dSRyZBcXBEKID/O+TOqGaA/H6L?=
 =?us-ascii?Q?M1xTCIIExOudPMYqpd+4DBECvyrPbRZxzrKtUcebofYHJbPjy4Q5kuVBFmxr?=
 =?us-ascii?Q?ea9RlzryTU0s3p1n/CCOq8N4s3QLokuLZvvMBY3edXCtm0hr9AOsgaQsN2Dq?=
 =?us-ascii?Q?JEsW3sb6o4xTptBa+kWfKz/Vm9WN6PybDPECQTHBhJ3AgcqRgOTvLzAdGBZ7?=
 =?us-ascii?Q?w5NICbCV3zdLGpTjDzuMbvGl0Q7qhns1bxXiqGrEjuMrTYFZ3xEzsJvTzQbA?=
 =?us-ascii?Q?SVLlwBJskpoYw+54TKY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GiIdrAGz7xXMLlj3JnYTtauk+Uwh4xlhDZDDZNK4w/mDA61hD/cQD0kaGUpg?=
 =?us-ascii?Q?a1dttn3rjFYMJPKM9aJ4p1KzPljy37P1Imuf07cP1G3HgxKEL7DD8sPmUzZC?=
 =?us-ascii?Q?fPvonhcAfSKVVpezktFMDcAT3OQQF9LXq2Ia/peqBG+0nlcdYV1md10HrnHD?=
 =?us-ascii?Q?b5BXbEJz62b3kU4HAg6eeB7noHKwgJ03Mdph+sYue6RTxU2kyZ8d6T6Opc++?=
 =?us-ascii?Q?XKpmb0vu5eH5aMPsKR4VgMujuGhGYTCIpEvBndnJkpvmq5Xn7h8vO20EBgFg?=
 =?us-ascii?Q?LzrO0Go8Xq9/0dx5aui3yQHf5bpUbIMdr1J9YsFvDmeXxquiiq3llByJVq7J?=
 =?us-ascii?Q?m9FaC2L/airAas6OwsuVwSVg6wL754YVcDPRFJ74NSybJgRFlEtBIkswbMQI?=
 =?us-ascii?Q?y5/3Ybmgbo2KMvCGl8wYj/sEZvizOwEXQC0ldZUdAZQS3j0pWp4tYvPa+xRB?=
 =?us-ascii?Q?IwIfcwvROUiLRfLCjIHbHeHlN2urHEZRAAh70Tf4QBXqQLQPx1pLzOjbm1Lw?=
 =?us-ascii?Q?SOE7LTePQPka1QTpfOcPupf4OELC4a9BGQXrk4tPMzFZMbkAKXsjTogGfgPB?=
 =?us-ascii?Q?uAeNThj6+x/ppukO9Hd4aivBodEGHxWS5bmm1MH8KN18DErb3M62OBk/sdoE?=
 =?us-ascii?Q?/2yH3E0tnpT7c4RrK9v3qKNeAYXN4/bu4hia4HxIc08kaIFzfApz2wDqPZE+?=
 =?us-ascii?Q?KEkPiY59cP6rjbFAjb7LFibkD0QNCXbkWdf+/uKFgp9ShkCqJ6GpdalzwcX7?=
 =?us-ascii?Q?VT4gnIhiyH2Yvaz55MVeskjF/aREDBsCcDjLnXkxreiLpzwNJVjLhL6l9GQn?=
 =?us-ascii?Q?H/VUm5tK7GH3LWBwLwgbhXo0LLsoUE6SYeKfC7neoptJyoMeLEaU+KAGDagk?=
 =?us-ascii?Q?LlgAXs1jSzdMKIParobWxw2ZSMO+ZY2bUplykCqy051NXWl3oQh+MWr9uXnL?=
 =?us-ascii?Q?Iu5RBfb9fSnDTE7m9y9ZHKctXLWuJia8OziPYezPrT/F+y/wTrCie+h/jufN?=
 =?us-ascii?Q?IhuilJPnd4dLFQGxQ1HPM/lrBMrjbRBUgt7EosP54NGAx6LEqguCHycP4w9Y?=
 =?us-ascii?Q?fEo+Uaq6Ie0m64tysFhx7FPcrgu8RMO7KKSf4NJiJdFPh0rmscmJ87knxvgM?=
 =?us-ascii?Q?mtZejiTsQh/nWc6gQkb0Y3cxwgKOBieiGTJK5XqkH8Q3qUcmhmRMmfEOWLHm?=
 =?us-ascii?Q?cPDSRbAvNfmTTv83OS9xjvXBqzjXamQ4jhZ1GJ/b12ToL/WaGRS3Ls+4s6jV?=
 =?us-ascii?Q?XOejs8q0vSGhk5RUmdlkhxIXXjv8Xyixw1kU3h6gsUFHAdIgWImwlbfdpPuF?=
 =?us-ascii?Q?x58FRpjfQhEUkKAiuU6EuIWgtJ2wGPeInWt/GrR1VQoarFVqLAxQMfLNWr5r?=
 =?us-ascii?Q?M5LVC/rTrBvPqkPRZK8uQMVAAQ89WjeLUa63Ekcv9kDkU4uTKbJUmYwp+dCs?=
 =?us-ascii?Q?znTzR5/fe8Zv/J1yxKA8UzDXFsUmIwgGoIl0gxoLyBUf4qKvQ2jzqpiaazaW?=
 =?us-ascii?Q?7xTqJLLsnGE+aDVZlIws3QcnSzyxtScqg0cA+NzoF0wWmcuCnHZykRh8ohB0?=
 =?us-ascii?Q?FhIlQtbwHihGTQde1nrlCW0HtdhseW9JYF1WHFF1jcxgyUbYuJArAIrDMFsq?=
 =?us-ascii?Q?PWQkZ/WyY0ypPJb/zISytUJBYzsHA/F6+cL65bU9VCw27YgWk8sI9AYxK9+i?=
 =?us-ascii?Q?31wHOXH9ZZjVvDr2vzQAZkmbOlRX4vptsPOsPzG27ARyPTz6IJGA13nK5kUt?=
 =?us-ascii?Q?/MAoGrRsoKAScQhQDjuOGtIZFC74xZY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ece064-b0e5-4e6e-a2de-08de59d29d3e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 16:23:45.1028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nPiGfmTnbSBJxcKG4oi+fCyIMJIZxjFMbJUY5d+17edVwgue3Mn7/iq9YV2Iwe+cjGhRt5uHytzAwNPNAYSbg0wFJWHWCcXn9nFAtv/Xd34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4799
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

On Thu, Jan 22, 2026 at 08:19:48AM -0800, Stephen Hemminger wrote:
> On Thu, 22 Jan 2026 12:23:51 +0000
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > Some of the BPF tests require the net/null driver to be present, so skip
> > those tests if it's not found. If the early part of the tests fail,
> > return that failure - on if they succeed do we return skipped on the
> > missing dependency.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >  app/test/test_bpf.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
> > index a7d56f8d86..ae588acb16 100644
> > --- a/app/test/test_bpf.c
> > +++ b/app/test/test_bpf.c
> > @@ -3725,6 +3725,11 @@ test_bpf_elf_rx_load(void)
> >  	return ret == 0 ? TEST_SUCCESS : TEST_FAILED;
> >  }
> >  
> > +#ifdef RTE_NET_NULL
> > +static const bool have_net_null = true;
> > +#else
> > +static const bool have_net_null;  /* statics default to false */
> > +#endif
> >  
> >  static int
> >  test_bpf_elf(void)
> > @@ -3732,6 +3737,10 @@ test_bpf_elf(void)
> >  	int ret;
> >  
> >  	ret = test_bpf_elf_load();
> > +	if (ret == TEST_SUCCESS && !have_net_null) {
> > +		printf("net_null driver not available, skipping remainder of BPF tests\n");
> > +		return TEST_SKIPPED;
> > +	}
> >  	if (ret == TEST_SUCCESS)
> >  		ret = test_bpf_elf_tx_load();
> >  	if (ret == TEST_SUCCESS)
> 
> Only the tests doing ELF load need a device.
> I think that part can be handled at compile time with the #ifdef
> or by splitting the ELF load tests to another file and doing it with meson.build

We could do that using ifdefs, but it means adding ifdefs around lots of
code blocks as the compiler will complain about unused functions if we just
ifdef out the calls to them. That's why I took this approach, to have the
minimal possible ifdef. If we don't want to mark the test as skipped we can
just change it to return success immedately if we don't have the null
driver.

/Bruce
