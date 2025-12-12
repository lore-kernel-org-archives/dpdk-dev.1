Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE18D59D7B
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Dec 2025 17:52:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D987D4027D;
	Fri, 12 Dec 2025 18:52:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id D23D340268
 for <dev@dpdk.org>; Fri, 12 Dec 2025 18:52:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765561946; x=1797097946;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=HjFqEl+ptPv2MVimGADTsKqTwvqc5itaWguPil2pnn0=;
 b=HFYYZSmTi5GDRtJIffscRQ80a5RdjxW8wIJ31m2/FIHchdoqV3zWlcxy
 CSwHOw423GV8TGuGLAqkH3OB8zE+N+NBEK3hS2rbM+R2HORE/KaCpx+Lo
 OnQhxF5195Z+L9vXLpKUzsyc9Uvvn2pWIMubAeS/eogs4lSveiCHlnEvO
 aAacI527K8ymjJpJaD61zh3442l1S0FfMFiit0ECwVzl2l5sbCzsmLI34
 42ySwOvcFK/YwSkoxfJr56KM/rS6AUmpuA/johCWewziyksTqXd0guSX1
 jsy1VJMao82ToRrwFsRR5m5i8dB0fVhVqxqAN/qk8UVtxYl7xAyf7OFHP g==;
X-CSE-ConnectionGUID: OGNgDEziRROmaSR5Knf4Wg==
X-CSE-MsgGUID: 7GoGo9GIThCwF7mFaBGRow==
X-IronPort-AV: E=McAfee;i="6800,10657,11640"; a="66558750"
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; d="scan'208";a="66558750"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2025 09:52:25 -0800
X-CSE-ConnectionGUID: YEBk2ry/SI2DUh2jQt5Vow==
X-CSE-MsgGUID: mS3eFajHQ4Kagrd+NCSaSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; d="scan'208";a="197207248"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2025 09:52:25 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Dec 2025 09:52:24 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 12 Dec 2025 09:52:24 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.11) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Dec 2025 09:52:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gyPKNkShAN2uQdws/dAE8RaNv0FZlvGEU/7VICzJZV2JtdYtMR1wJ/iYbKVPGr8uPLyLVp37wwjznIrAQvRWMHXr/osddhdfbvvJVnwXRJu22p/R+/FTwTESMCpAN8NsXbL7uCktD9rEObSi0MvUHPfH5Hhf31l/h7d/BioRPBckPn/nN4ePvU41Q7F8H1I+qfMmzmXjSndNYyKopVOlxyN+kI9KxHYDBLPiCq6pCOwclFT2KiB8PV2HCd9r1P+PKtZM8pdt6N9n6UnAhCxCpm/JCYkUqpIS4ESRALgS9TZbTjFtMo+wx4+CNnHPXxYQOZN0fJ5DbXHWBgeH6y2L6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDYoH0nGR7T5w/UOr3IXIvI9g5S/3iSj+QC5BVd8534=;
 b=qP3L/4NN+1vIOpLfYiQB0fFww79xYODObhs3utJUNuyMIAWHMqtHOsGjMypSjJCYv7YrDv/w3R0RsUsuNKfKHBx8ML6UwHRKuWzjtqrlbiYgIYaJrPAyYZAd08qGP6AMMnfGs7naMVsYP45aBXBZQhroHF1uIXiVZiOa/sT/FRLyWtt8rI+KRWO3zSTZlbuqwT5UPh6IMu6sCv99+OiXTEfJ2dzSV80008/oXDbOjQ2sulXlrxJmPlELAYvzYbltd9ZCEMSEGKI6mzJ+LvfcjHPQjJKRmpLRok/vyBDYhhUktdkMWEjAINlVnTpnhE9aKWBvbXJFC7RJp0yNUXBBfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW3PR11MB4682.namprd11.prod.outlook.com (2603:10b6:303:2e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.12; Fri, 12 Dec
 2025 17:52:21 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 17:52:21 +0000
Date: Fri, 12 Dec 2025 17:52:15 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [RFC PATCH 0/7] Add script for real-time telemetry monitoring
Message-ID: <aTxWTww_gHjwQfBw@bricha3-mobl1.ger.corp.intel.com>
References: <20251210165532.103450-1-bruce.richardson@intel.com>
 <20251212143249.2fdbeaab@stephen-xps.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251212143249.2fdbeaab@stephen-xps.local>
X-ClientProxiedBy: DUZPR01CA0291.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::9) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW3PR11MB4682:EE_
X-MS-Office365-Filtering-Correlation-Id: 64041ada-1cdd-4eb8-8723-08de39a732d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fYLllqEJbfiVpHARhMAgKfxZDAlgJRJqHEwQMPsCTxdeUyFBiCQeYOcs8s8a?=
 =?us-ascii?Q?lbsTtUwpYfszlehWzJjIQt8WZaiscyKHBmvP70kGrmMR1i/+SBbothLc8x2D?=
 =?us-ascii?Q?OnzUumBMTgU1cuso/6AUSpPCcbM5F71gJ8frW44QRJF8HSKXgnvEide8zwAR?=
 =?us-ascii?Q?mx2I3xTUrUcD6EBs8IUdX9KsbZpQlIwPWmdI8fjtYxegw57jV+WjIoV4U0An?=
 =?us-ascii?Q?2XqswOk57+CHhoYMjAiWKsrmq5r5gvICDhUnhT0PCSp4iqeV09akUsh4YFyu?=
 =?us-ascii?Q?H3m4AsW8fRJhm3FsKD8npQGGNAz2FpwnTRdxNR5mvuHNHCnHAdWYf5GowNLQ?=
 =?us-ascii?Q?7DU6586AUK5oItxFW9Wl6buH0XYglzGbYlj1GcSsa/5ZmDmtrikZq2oxC76i?=
 =?us-ascii?Q?VRbeRe9P/1GonTF4UjZ5i4YdUcjDAdqa0JqCWrr+yWqn80fUnArhvbcWZ9sX?=
 =?us-ascii?Q?38MV/zME1VqwpCwM5wZ2DVNvwk2BTWcJ3dUmt+ty2x2JIOyYqOzdWflEm2Bz?=
 =?us-ascii?Q?AJlmlsIYM7MPRpAW6/zmP2gNpdQo0sjWBG9SCrNap0J1Nac0rz9cSGchyQ6k?=
 =?us-ascii?Q?nap6KtDMly18yCjsGIkViE8My8OppIJCeVm8CksGpd1NPrFxwrBAn+DPA72n?=
 =?us-ascii?Q?T/sSTKJ3aBzDAbjau6ggTMUonHaXE/DQwYVOO3JhQqXhFlwzyGqx71qbTz5p?=
 =?us-ascii?Q?ai1l1UPit25tU7nGHWIYQlT5Gr0LmpxEV8G1HVAMXnNh7gqWghzqPlpEewCU?=
 =?us-ascii?Q?ncOa3r8QhLPZVYnqtbI+Wb1FDeWlTSq2ttySFUmtIpOKdKA7uVV60zosrkJG?=
 =?us-ascii?Q?elujleykLHflQqtlue3PTe7MyePJDhv61y80zsdz8PGST7F+tbrXvE/vxfvL?=
 =?us-ascii?Q?/nzkJSTKIVMs6/ui6GYxpxPpOFkOsfprxmA9/uX5PuOQE3yvSGIACg3F5XNn?=
 =?us-ascii?Q?ghDWOmK4gHJR90IpruI0jjlX9fbmtgRZguavYhgvmnGBMa3ohQA3U2FkXjDT?=
 =?us-ascii?Q?ciQexmFI3lo0Fa/lhfgI37kHEqnGBrVmln2rrUcK2mHsDOn0+eFjGrPHauZP?=
 =?us-ascii?Q?hT/jdPS7U3yRHGtTQH9c46s3FLyHZDyhKzk5M2JJ+XaR8VeJW7mwDXFrVWIb?=
 =?us-ascii?Q?vmJEXaej2Zg/EbBgmplJiTgaKG360rm4o9AkOarm8fjCmVwjJJ5tGnIX3HEa?=
 =?us-ascii?Q?zWhO54yj0NIGxMvoQ65uAFsMxdJr5Jur9V0ZsQh32oKr+QEWWFS8eQnFMIUY?=
 =?us-ascii?Q?oz3bd4rB7jlHrykyZvmROwRfyaZEFpW5RYUB58zDiwmlDRMwAnyo6wwMUzff?=
 =?us-ascii?Q?8yUJyxh93BDzP8S7wrQOGKMw4qLN03Zzd3YBWYOzCl/if4Y+MvW7l5Avxm6n?=
 =?us-ascii?Q?sAOKt9DdBu4YM3Kqh2P6dgFPD67QHa8rTrulGvFcrGS7MpQXGZEzUwCxnZUX?=
 =?us-ascii?Q?dUh4cHF2q7ZnrbYEviYFX9yIFNLUEUIrnrRV7e3ugiOrcYpU7C5dnQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XTMZglqwgfOq7DdZpYS48LCm/eR5xHlSJ9QGDSKYmzHuDZ+ljHOp3cQtl11W?=
 =?us-ascii?Q?DfzGGTTVyW87UoLSaGyKXReUKO9bbIsmx6ZiB14kIhLj6Y+L+8ALXReiMZeD?=
 =?us-ascii?Q?Idykl1Xm4LvzLK59nhc/KPuLfIFXIZ8PyPgJIcxmm/5/pfje3bB5QoIQMFPo?=
 =?us-ascii?Q?RXg95suwfnSgXClnCQWsNGDqCdZ/TcsX3C4KxQrJBtUy7EYomZHv6vEfiVoe?=
 =?us-ascii?Q?lauF8CBlX3wP0IbxawRP7fV9N0BjKrsvFl1I3Fi8SKbmWQcuKcf4Grn7uRff?=
 =?us-ascii?Q?ep4HviVkspCeRXZRyv3c+3cYVVsg9pX5Tw5GypRJdbnQIiccf92RdvA9vX8m?=
 =?us-ascii?Q?ibcyL9VR9LWD+JWrY411Ju1RPBVVsO6UYQXRYWDMG2oeeTScyIX3BjzuGPgh?=
 =?us-ascii?Q?hF2D+acLTtxAHIN13ujL7bfcWzoBCJDI7FwSERDd2hhs7KpHQkmUMg/vG7Fp?=
 =?us-ascii?Q?cS4GlSYMU+KnOum8zvNy6W6kK8Z9ar90MCrBLubNDDLsVgrkjnBhye4JtTSo?=
 =?us-ascii?Q?n2/BGY2ecDoBrju+E4/hPIl9TB/qdXBrr7DPJb0etb1Lvr4U9IwB3r6nDfCR?=
 =?us-ascii?Q?ePsS9pyfv1xoHZXMGhFuBeZSMuzTor4ZgG3KbH/zGQDVPPSoeriwLtZehQ44?=
 =?us-ascii?Q?OrruwNMhcA9Q4UU/gIF82ZwQ/f+cf9dbk12boUrzX5If3c1cXzdIzlhsUGO9?=
 =?us-ascii?Q?G89G8lkU02luuZ+p6RcFgb4jhxLdd07ufmcYD93t6dTu+6bdqFTc5ZUPMtIr?=
 =?us-ascii?Q?PNMYtFwdwLaa07hLLZLQsgQtQeCqdw6+G98E7v6xRlkGhi7VA7WMXeMKSOP+?=
 =?us-ascii?Q?hgGMvaeA8n1dFd/mNAtkvtlug0yL1eAO4jXg7HN3jpeyUXvfjxD/sfw8MPF+?=
 =?us-ascii?Q?o6u8jrEVBXNUVoGvpyf5/Td5gslUAst1GW/GRtDQ8Pfjs/ZHJwRAO0f4qBP2?=
 =?us-ascii?Q?eMXwvP7AWHxVWp9p+YR24NVUqY+n4NhjLB2cqUKrFBunJhYu135siThwPXrG?=
 =?us-ascii?Q?yFwIFPoN2xKIBqfTLccL2BtT641EV0qT5826RaLEuAdqBGcLgvbm4Eoq2mkP?=
 =?us-ascii?Q?o6ZChDw96eyXe0w4mbpe/xWSu6VqI1t8rLIKTVJtk2t3E5dsF6bVHIf5U3aO?=
 =?us-ascii?Q?BhWJuMXO6pkFYxcWT57OeVFsdt4gGvArIT3LMRuBYDHoIaJFxODlKIKi8DXm?=
 =?us-ascii?Q?mQj6a46DS8GIUZHXfaeRpweP3Bm0NNGCwWfZQ3J1ukw2QRFSycknHM3zezbH?=
 =?us-ascii?Q?xIK6cks1Linau1O+wjO8gUs4zwoAo1YNgcDkLbIY/fqtZYjV67wEcTH+ByvS?=
 =?us-ascii?Q?mBWTp56x/rPuu8PcxjCX2t9TsnfrPnuc2BfiyD0nenrGSxnDMWpgErbnbWjB?=
 =?us-ascii?Q?mQGgMDmmgqBL5KRm41Ky0aNwNN4ppuv/HeLgvu9b8uAtAoXJZSUgvi6Kejg4?=
 =?us-ascii?Q?vrIS5m11xHWCrzqpRehFvvbyZkzblw3Iwoxc5bMjHA6gATogWF7gDsNSjxMW?=
 =?us-ascii?Q?WMcAaPwdPXkzs+IDsW26m7zeuV5vDBInQRdWNrqUKcHrRPfiF/qqoeIFiBZR?=
 =?us-ascii?Q?jovvcn/xBQjtQGzLI+jJUrwb4KEPLF/CgA9S0Zls/myjurcxJQo4Oe66xCy0?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64041ada-1cdd-4eb8-8723-08de39a732d2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 17:52:21.0246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R39e920C9cdX26aBdgGAGXkapRqQv6ZuRNkpoPlta5hJ4kVWujEFd+eB2NZJ76TszgmFtB+hetQ3sfVxuGpg16XY2rURz/sdHyOQSYBALX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4682
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

On Fri, Dec 12, 2025 at 02:32:49PM +0900, Stephen Hemminger wrote:
> On Wed, 10 Dec 2025 16:55:25 +0000
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > TL;DR
> > ------
> > 
> > For a  quick demo, apply patces, run e.g. testpmd and then in a separate
> > terminal run:
> > 
> >   ./usertools/dpdk-telemetry-watcher.py -d1T eth.tx
> > 
> > Output, updated once per second, will be traffic rate per port e.g.:
> > 
> > Connected to application: "dpdk-testpmd"
> > Time       /ethdev/stats,0.opackets /ethdev/stats,1.opackets        Total
> > 16:29:12                  5,213,119                5,214,304   10,427,423
> > 
> > 
<snip>
> > 
> >  usertools/dpdk-telemetry-watcher.py | 429 ++++++++++++++++++++++++++++
> >  usertools/meson.build               |   1 +
> >  2 files changed, 430 insertions(+)
> >  create mode 100755 usertools/dpdk-telemetry-watcher.py
> > 
> > --
> > 2.51.0
> 
> 
> The TUI patch was
> https://patchwork.dpdk.org/project/dpdk/patch/20220831115250.362189-2-conor.walsh@intel.com/
>

Took a look at that patch proposal, and here are some of the main
differences between the two scripts:

* the telemetry-tui is a full-screen app which is a lot prettier and
  probably much more suitable for non-experts.
* the script I provided is FAR less user friendly and operates at a much
  more "techie" level
* on the other hand, it's more flexible because of that:
  - can be used to display any numeric stats - the tui is hard-coded to show
    particular NIC stats - including e.g. cryptodev, or dmadev ones
  - can show deltas and totals as desired
  - can quit after a certain fixed amount of time
* my script is probably more limited in terms of what can be displayed,
  since it assumes that you want one-line of output per update. TUI
  displays lots of (fixed)stats simultaneously
* TUI as proposed has a few glitches - got a divide by zero error when run
  against a testpmd instance that didn't have traffic running, so all stats
  were zero. (That's an easy fix though)
* The new script I propose has one major feature that I would look to add
  to the TUI if we merged that - the reconnection support. I find it very
  handy to run the watcher script and leave it running while I start and
  stop whatever app(s) I'm using.
* My script has no additional dependencies beyond stock python, while the
  TUI requires one additional dependency "rich" to manage the TUI. It also
  can use a second dependency "plotext" (not Ubuntu packaged) to display
  charts if so desired.

Just my quick assessment of the two from a quick try of the TUI one.

/Bruce
