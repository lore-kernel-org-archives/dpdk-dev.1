Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2442CCD8CB2
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 08:26:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1AAB74026D;
	Wed, 10 Jun 2026 10:26:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 7988E40151
 for <dev@dpdk.org>; Wed, 10 Jun 2026 10:26:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781079978; x=1812615978;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=YP+JI6YijGfpQ4YEr0cj+3y9vsAg0WHjVXZL6bnK41E=;
 b=AFlDadyKu1QJkrH1RuVCuLBxbiLYhfetx2GebsvhZ6eDSyy9TUC96Zmw
 stjTgo8sboes72ZGuxlA7BPUFb8j9MpW2XACYZrhh7O4JzRcjcyLgnsoe
 dniEW7K+SCCwiCkQXdjIsNtF5mR8xx9N5NAx+KuuoIhoFy3by+JBG0QI5
 a5SLrRZWcl0PjURSn23Rx6oA9RRTNaxWC9bKk4T5WkjHpOQO9p2FJ636i
 IjICU4HM2m+JDy064I0vuqFXNhtwMEhkc4DyMWMrP/+n/tttLeTLBCf/o
 HlPKRg2+p9Dc27xhDjHmrh5R/t0oNPm/vncJFUNwqops5EhgOAAfj0UrM A==;
X-CSE-ConnectionGUID: c1U55WE9QwGSong/LF6VaQ==
X-CSE-MsgGUID: tGWjH2iFRFyRrw6ESb2c0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="93254962"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="93254962"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 01:26:16 -0700
X-CSE-ConnectionGUID: NB7C71w5R2Sgs91uP0JiaA==
X-CSE-MsgGUID: oCDZ/k5sRuORdxsVSyUhVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="250042176"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 01:26:16 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 01:26:15 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 10 Jun 2026 01:26:15 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.32) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 01:26:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DkhZuDZE6Cn2FhicEIw9p5sRzI6/i2om398eVLovyqDR9t8TXgEVB1F/zsstu4RGKchlvgm4B9KHRrWnwDiJkH+X/MZBzeh66lx1XOiAxseL12Ri2s9Aj3X53kKMCoSIvWIrh1HGTdiIyBH8LomWsjQA1G4b3zVo1ylz2losxN0CTg70MrRHjpeHYfTMSSADhk7hCjQ974Mti9Ljpq089hASeb/pqypudHMZ4AoVcU5SB/EE+XAIfhfvAinpmVUZtd6m3bar5aBXLZUA9OxwyytyGNfX5lbMJc247eo5sMSVnYXPhOXjTR8cYM7Q7Kf0Uldo7PsJMyymCIAjod2puw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+m9dJ2uT3H9bWcWROWq1nG18zlKHg7OJAviTw3PeI0=;
 b=zWwJur8KMxuGatPPr7PY2vE6wjWvb6mbFcbhYwIWlFIgNnRnxVuowGkjpFMeV8TFi1LCU9QgLC22sNQ+NKuWQakw/bF4YxAFaqlPxNSBTaWXaq9f3tNqIbVNFrjqBlMlsVHpmL4jPJ9fbkq9/ENkB5PqxexEwm6FmzmhWpo2gVgqE6FprxTx+VyVitqjFLoU1d5kgV/PSCsAb3k5bNg5CdbhI/CX4BY+mc88QjUgW+/CcF6aA9ed+GF+sciRqeME21VLtv/o9hx0qnAsJcuaKZI8qpqP3i1Kuuystg8PGrUIqWYFEBPKUaogwOEtKKW19mgxbiFUNS5iHZ1RhqHPng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB6735.namprd11.prod.outlook.com (2603:10b6:806:25e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 10 Jun 2026
 08:26:08 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 08:26:08 +0000
Date: Wed, 10 Jun 2026 09:26:03 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Talluri, ChaitanyababuX"
 <chaitanyababux.talluri@intel.com>
Subject: Re: [PATCH 1/3] net/iavf: downgrade opcode 0 ARQ log to debug
Message-ID: <aikfm7nvrPABJ6S8@bricha3-mobl1.ger.corp.intel.com>
References: <20260608145518.1705524-1-ciara.loftus@intel.com>
 <20260608145518.1705524-2-ciara.loftus@intel.com>
 <aigjEm-RskU5s45v@bricha3-mobl1.ger.corp.intel.com>
 <IA4PR11MB927828E81A5F1EC7C81BABF48E1A2@IA4PR11MB9278.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA4PR11MB927828E81A5F1EC7C81BABF48E1A2@IA4PR11MB9278.namprd11.prod.outlook.com>
X-ClientProxiedBy: DU6P191CA0015.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b369b0c-e6f6-4be9-b942-08dec6c9ebc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|4143699003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: gtTBg/Ck1B1f3uV+l1RfLobPVb88giQi9RTFrmsXKxPbrz8bXTq5eSUGvwOBf5u2JPekD10o9Y/j2rw455wkdha+583x3ugOf+ZJUNCLkFuo7KMVyrsljV3T6f/4YvDJCsCm9NfkFxcXldCJKummdJjoDhCHygs0NTqUY4gwqD+ljIVDqa3qkHg57NokZu1NVBiN3vphcyA7iEy8AaatzUX2ns+12mHNCtY7vr0b+LhsHVL+TZMC2qfKkRDVn2r6C855WvNBtr7qaKqFafj6zHGgzfJVXCDEbhItmnPbEXO2vKquXrjEnEe6jSsiEkSbCDF7DcGo4nqIGPUxY4oTBAiguiT8rqZwH3hwnIhhpqUh11IfpzjcYCjEHhZk8xidNI6Ypo7pbcCr7YXwJfTpF4lJJCwtnBF6nBnb+seSxUlLl9Eg2xpzz7IrLObH4PxE7RI5NmYoaruixOo4ocUhy2C0SDMZaE6tdS5PBxoLXk8cUOaD6r08yRe2akNDuts6JpBKpQqxcaVOkbWJryUbWvidpTxsY8huM0d0zpsJnXlo7ZL9LSzxOx3qoDoqvb0Bez+9vkP2GXpn9pP45aJipejSo5WKUbm00GZi3dc6ZhK9M5twP3VVhPUqfwAcx287I4eiG4xR4IXyTopOOQxtejTD7RnxgP0DwZhcOcCOVJo0G16hRJH5oK72GDlbAf+a
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(4143699003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n1xcvK/pfDfqztKPtTSGiaWM1PPwxiL6SGWuKiCimJrOh+pdmX/EfCDVs5jL?=
 =?us-ascii?Q?5dBG+9t1hz3GOUSREy2KfLso8uEqjITkk3wN3kRoe/y+rr94tYtZZQ71xnBV?=
 =?us-ascii?Q?G6aNoGRc6VlkCFNSW1X5dJ3ERvKhDUU0iAkwGtSHvUHEj9sqHSx7POjxeSu3?=
 =?us-ascii?Q?opvIRODkFnmqczQmScACG4/tgT1K/7LCIVTBRboiQxvWD9e1pB1/ov4X4oSi?=
 =?us-ascii?Q?nlu8u4QGPfdARWMMn08sy6AmJyvvUIjsOT/alo8a7Yubg8KaGkXNBar8x+vT?=
 =?us-ascii?Q?Uhyk70L8RWq71WCm/ZySOKZsr1CjWS5Wek1ZYVL7u9neDSwDvPjDb2E4ZGkL?=
 =?us-ascii?Q?eajlk9KqXo9n+7Kt7lq+gvInzY6/lDxTW2o1grxVlAduTR10ddzQiJs5CwYd?=
 =?us-ascii?Q?8Z9/fCdCEEpCsTLyBvbM2Mws+8jWZf4y/Ho4lIqqhiZqycJgcJJ5i05QYUiG?=
 =?us-ascii?Q?acZ8sPgd/5Id/nUTTPRzBPhudcBOMIwMuDSReurxk+WuWQitPDT3awbkAScI?=
 =?us-ascii?Q?a0H8z3q7NggN6+UjLGByizyyMIOV/B1iV2nZd00uk066olqFXlr44Nhk9Xwt?=
 =?us-ascii?Q?jWPtUq/j1vUEJZ2WZphr/YO82wkza2uEbG+DeJTFCkEhglkjRy5cdGQAckuj?=
 =?us-ascii?Q?yWe9UHeJmBPh0NO6K0Nf5o3aAcWVVfK+m3fIEmiZpiYJYOTI4paopmALKr+N?=
 =?us-ascii?Q?KaIX0+3Nh1OejFnrxFOkGqMva1p0Ad7178KtKV9pbi82+Vy/nrVdqkCuFkph?=
 =?us-ascii?Q?vLbM8AA1H2jLX+a0XEHyROSu3/CsDI2KCiDFl9gacQoQ4AOnUTSkA3wgu4KZ?=
 =?us-ascii?Q?5YOMVrdq5qeCDEEOybCEOp78/Zv5x+H0whcmV968aL4TO0DHUxQA3QQKIYmN?=
 =?us-ascii?Q?jkzmPfcIJ4Ev/E5NasoyvDZAVFfb5K1E9sJ2WD4ybsyDrmCQ/x7ejmVow0PS?=
 =?us-ascii?Q?rxCBQn0HghdbxIb2nBkojsj+3HI7jqOoGcn0ZEVFND9PXuX0II2SMKW5uNHl?=
 =?us-ascii?Q?7PTlWIGeS2Swes/IR23JNq2pHZM8knxanY/bz/6itOYCT4sQ2JCloOTxJ3pA?=
 =?us-ascii?Q?OPs87e9b7w6ahPvTLZs8l3d0da0/MkuX3L2gu3PeIQfF3kzsx+t41yWO+rGW?=
 =?us-ascii?Q?/Gou4rArzDRGP/ZvmpS/sPiJbFSFlazpMLHCHIYgDd2YYk8BLgtxYetSVBXn?=
 =?us-ascii?Q?PuZ4JwR3MXwPG52JVZHiJUojd17ERemYF7Xi27cZtuL5wyzPSbaeFn+JseTj?=
 =?us-ascii?Q?DHil0osxePxzpm8gzD9uH/cUXCvxH+uCLlmILc0ikKJq5/wRbMFYhDbOor/O?=
 =?us-ascii?Q?bes5t9DHnjUzP+cj4sM2OE4tkIxeoDRTMXb/lwRnVDX74VqYE0K40N3FA7F/?=
 =?us-ascii?Q?xO+3QHFAtzGCL7SQr5+fKvsr1IBsJIlanXZrgcPv1z2ojUmBKH6yVtrzj9/P?=
 =?us-ascii?Q?Uhht9kXHElQqVXo91WE+IATz1OZu60p34yxLT8Dp5JOuKlhcHcNbDuEGt50u?=
 =?us-ascii?Q?3e/pxAsKHZCn7iBsTFWdBP7KVI6kOC8k62auyMRGTS3uueeRZRIgvtJ0Gzli?=
 =?us-ascii?Q?Bsl0H767rRh2EQKUvhdkcRgmC6AlAH7dF1EIPgLzKVfzI8CNCKYS5+p/8QHy?=
 =?us-ascii?Q?PEeXRVkhcjZVNaf0bKs1aG5YNpHSjujMLvCj85kLf5WaP9S7kkGIVpWQJovK?=
 =?us-ascii?Q?LjoK6Rvk4QhlUwWrnt/Qd1sesTfRSgwExbO6T4N4DuP9aD7KvpV+aC6v93B6?=
 =?us-ascii?Q?v2ytB4P+QQLci0/UYsx4qYJ2wxzay3w=3D?=
X-Exchange-RoutingPolicyChecked: CMsNvn9fs0URft/vIq+4VOnXKrWWUG6fw8akF2WZtzgEQ2AuagOMcErN2kT1uCGaeUPQjjmqwnYqz5zZ9H7GLtDe9dnD9aJHl4WTNnPDzTCslZ3lM4EtfWaDAkoY9e8e2a2WcpJM9s7neLSrbX5+2l5S5XC27ZdLwHc1FRbBS4SuCgF/OAdB6Kh6jJCkKDAYhsG++dNc4vJTxUs8XmG1XOSADzy5ntw0rUZRCAjZHwrZeeQWBGB1FWgQ2aluFFfRfUfWo8todxtOWVreuA5dELZ4Thf0f4Smaz00YKjlT74o9iwIG6uQ86x0iLB+pZ8OAAQrCWUeeopB92V7WTSY9Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b369b0c-e6f6-4be9-b942-08dec6c9ebc7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 08:26:08.2001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3qMJp7Eq2BvY4Un6jcVX0WnjmI9P0rQTbkpRN7YnHWZ6soIV5G6lBl09jRrrt6AsdQaS5Wy982nWE4V8VmEsN39eItQ1m7g03ioJziFKSyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6735
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

On Wed, Jun 10, 2026 at 09:13:21AM +0100, Loftus, Ciara wrote:
> > Subject: Re: [PATCH 1/3] net/iavf: downgrade opcode 0 ARQ log to debug
> > 
> > On Mon, Jun 08, 2026 at 02:55:16PM +0000, Ciara Loftus wrote:
> > > From: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
> > >
> > > After admin queue reinitialisation, completions from uninitialised
> > > ARQ ring descriptor memory may arrive before any real PF response.
> > > These carry opcode 0 (`VIRTCHNL_OP_UNKNOWN`) and trigger a WARNING
> > > log on every poll iteration, flooding the log during reset recovery.
> > >
> > > Treat opcode 0 as a distinct case and log it at DEBUG level, while
> > > retaining WARNING for genuine opcode mismatches.
> > >
> > > Signed-off-by: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
> > > ---
> > >  drivers/net/intel/iavf/iavf_vchnl.c | 11 +++++++++--
> > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > >
> > Should this be backported as a bugfix?
> 
> The issue has been present since the driver was added, but only
> triggered in practise more recently with the addition of the reset
> logic.
> I think this tag can be added:
> 
> Fixes: 2d23ed74c079 ("net/iavf: enable iavf PMD")
> Cc: stable@dpdk.org
> 
> Let me know if you need a respin.

Sorry, never waited for your reply before applying patch, and has already
been pulled to main. Since the issue only recent appears we are probably ok
without backport then. If you think it needs it, I suggest sending an extra
copy of this patch to stable, so that it can be added to the list there.

/Bruce
