Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA65CCA470
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 13:31:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13EA3402A2;
	Tue, 30 Sep 2025 15:31:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id A51C34025F
 for <dev@dpdk.org>; Tue, 30 Sep 2025 15:31:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759239093; x=1790775093;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=3Kq0rbIqH4s7RlP3I4l5rVgwOzeUpUSsnaZ4ejsqw9Q=;
 b=ZU4kfnUuPlNM4WKj2zP3nSM0YSNlchBZ+EWbMhsbi1WPD8fpZeihrwhp
 HxR6QLhgDxWNkvZ8o0aN+vw9J9EODGCYewwYyqZ2w8FtYZNW5ewJ44xJy
 QxQExK8k/TWDbxg6JlWn8tts2wT3hfnEQBO7eQ2oO4HaJohn0SQ7GuU16
 RxEBIV72DGhYyB84JliGXM87RmiGhTUev9ZDitmR8Kl1bkoGTRi+lAhL/
 BK3xVHBPRqtN12HFp8pZtGNueDs7ET1PXaWv+2oe5WvFsSjx9d5o648Bz
 MF1zLJeKo2O3Z/oTq/qd5fUiAuIfJvU/vi2T4LC3oj7V2yv38fu37sy4N A==;
X-CSE-ConnectionGUID: UcQIb8izQo6bcZrJB+IuGA==
X-CSE-MsgGUID: 5GYyhMi6Su61vjrzQGss5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="84111640"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; d="scan'208";a="84111640"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2025 06:31:26 -0700
X-CSE-ConnectionGUID: 7Y6LskzcTZGHGu5jPdZejg==
X-CSE-MsgGUID: MDEIPecnQ3W1T/p6gwLLfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; d="scan'208";a="179288348"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2025 06:31:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 06:31:11 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 30 Sep 2025 06:31:11 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.64) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 06:31:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TKmdfXpiZQvsjQ/2qLZ0PCPZyODhh+C+as1nvjfZSe91PouW8zr3xk4bLmJ8cipO875K/+Jgy1nNGjJNKJAye7yIGei/AbYS17C7B2rZYvzGcl55UmiCmddigS7K2kg1Dp/xU9FBcBzKreMMbfWkxy2ZJVveG06CcAZwT+hU0x2bEFI/eVso2Na9Sa3AFSdOsYM6XKT5+u0HCRHTmHhEpAXOqKI8uCGPL/7hlxMaWsczDyrpt7UdLHs58ckw6cPO2MojeGyuyGi732VYAfNbiajyI8MBUXGYj7AnF2tMeGgCT9OesM97yuynEoM7wXVABQIX6k+Sy92sZGedpdDsuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0azgiQbrAt3zrUrZdaIqvwRXPFPqydMAqb4yacdj0I=;
 b=FbDapDhRNILmUOLoTFaFmuaZk47c0an06AlsoChpuCg9lUiqEIp1Pc7bYzSRWZ6+JEGV4ijL9ffDMr378K9XspFV6pr7M+MrB+8pees7y2FegtP5TaczrLV+pR9e7XAHxJNpxoBrbVbvvAPmdnuUeoJROceg2zPcHEG7QVyZ7Eed2hOo3WrTQKo5dY3MyLPxz4yTC0r2sFJkCspZfOwi0fzKN2yfB5WP8ob5IVsy54d+o4TIBWSpBQrLCgzJtK+j9r7g7TNSa6gHvsPJdc6P4VZ3rPnvskNJXazzFZrmQeeYHBKzzI9T1w7mbh8+uWxQ8pBiNhvuKgh5XhLR3uSTtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW3PR11MB4763.namprd11.prod.outlook.com (2603:10b6:303:2c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Tue, 30 Sep
 2025 13:31:09 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 13:31:09 +0000
Date: Tue, 30 Sep 2025 14:31:04 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v6 0/9] rework EAL argument parsing
Message-ID: <aNvbmC-D5c5GBALw@bricha3-mobl1.ger.corp.intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20250722140316.3568603-1-bruce.richardson@intel.com>
 <CAJFAV8wpg-UEhWTBPU5+Q47cz22hsYU+jrcCg8Hz=+PZ0OQUqQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8wpg-UEhWTBPU5+Q47cz22hsYU+jrcCg8Hz=+PZ0OQUqQ@mail.gmail.com>
X-ClientProxiedBy: DU2P250CA0025.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::30) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW3PR11MB4763:EE_
X-MS-Office365-Filtering-Correlation-Id: 339333d9-654e-489c-ee11-08de00259d85
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jyFRCkLCb6ASCDDorOEeXuHX5NmqGbNJAwX/m8ziv7Hwx6hj0CaLAVGTG7d8?=
 =?us-ascii?Q?VVfPGUwtmT4TQSyp8uEXmbK+9zXULAPkmbIEKnjEibiCvkDfRp/ikUer/4ej?=
 =?us-ascii?Q?Jn7/EirTP4SUcdiBu54kOTZCZ+mysdoTfQkpGHcEziy3dNHtyEJM0Qu9olSp?=
 =?us-ascii?Q?douPQt/51eijVdle9WLza32vlRdjp7/4Jv3+x6W4cVagFEKVWEgtmPxknsbi?=
 =?us-ascii?Q?q+3r7sUCTjMn8OhoSJ0AomJ296dNhwy4pxiJug4bovTh9kc4ESmlU0i7Du73?=
 =?us-ascii?Q?0q1d0Wtp0c0xWjXZhgqHHi0eyS///WFpNutxW+PIAWhpsQ4vkWj/CkYRib7m?=
 =?us-ascii?Q?a+9kcBR+2mfxHFiCjhY0Ga6Beh4L/x+d+/w6OQRKHSdwzPc9fr7SSZ8q1UzB?=
 =?us-ascii?Q?XfLXPU2bLP/rw52TowBzpcP2SH3YfNsPWsNkWeFmL5FN9A8MNwyx4bBqCezi?=
 =?us-ascii?Q?RHIQQpEKKKea67qAUL8aB2vV/6EPXwZgqrnSACm5/ui/NH0iZ1dEWinFTuFM?=
 =?us-ascii?Q?tD8g8AnjdkvBgEvLKhlaTPTpRZvCDx1GAFOOgiFzPZPTc62PglRmse9tx6Ob?=
 =?us-ascii?Q?qOIFPH7r03//0rKGFCeIlp206B97qXH9WkmuXoHaHliJC/rS79PXawTIh09H?=
 =?us-ascii?Q?Kna+7hpZJPWAZp50ZukUi9sn2jpX+SLOVKXmHxbnFR1JlSIqq22fXVoI45tx?=
 =?us-ascii?Q?umvQWTywhYclwM/p9x+ljU+4LEUJzL+/mVYrEaeMGjOsNhRacINdioi5NPEA?=
 =?us-ascii?Q?XqZ+sOyNymmPZz4+SQPI+eNuHbEbwLx4cFvL9d7T18xzNhHIo/RX/xfK+c7z?=
 =?us-ascii?Q?kEyzM9wJm41wGYDMgXJNGQmnOsXiPiwQAOxnswyf6nPBKqHg7O3MrBv2yYtI?=
 =?us-ascii?Q?lvxdp1f6VkoOiU83FMaX957m865xsrNUQ6ke9EDJ+iVE81DBSJJ8k1VuYZMK?=
 =?us-ascii?Q?maPPXwtoH+kiXz9AEoNjvJJOKsQKUMQtP0sQ8ltYExs7JLcZTsas/O2PUP+0?=
 =?us-ascii?Q?FBeAiTxf5yM2bgnVE+sLVizkhRKl6TLiKUBmLF7QDrU2syn1rV7iPK6dN+l0?=
 =?us-ascii?Q?xneJpIXRTVW4O2iOJiJDfMJ8bynXDO0QXA4QLs49i/RyrdlG+gOkszL45Pos?=
 =?us-ascii?Q?1dMUElQzoFMVb2lM+MoOc0VPkH14R/IEGptq5/t4tD0YBSveFqlkG6HbjEpS?=
 =?us-ascii?Q?B1DuSrIg2zzr1zwPPsx+lxm9mcJmbytOS53fK1++KBNuXjFN6JL65uB5BRWX?=
 =?us-ascii?Q?4PDbBhIbeEWQEWTL/d0PNYW2LaHubtm6JK95zFDcY9gUaCEcLl3PWjaHHKDw?=
 =?us-ascii?Q?IqSakw+8VqtIKwvB5r10mj0QaxktQLpC9TxlXGxO0h+Qb72Lpj1yhUXn8tu0?=
 =?us-ascii?Q?9xNwIbcHq3Hg5ulnybpz0WbueAuky2IEPFtqU7/4jiz4tccs5he7NKEylI7W?=
 =?us-ascii?Q?Z8RRlk5pOrbtCONe9OrCCul7AS+rl+mP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y+47pdcJVl+MFw6UUtLgUG1ogGrBzZ6Tq/PxCPlyTZ2gaALkaXiNq1Nwlmn0?=
 =?us-ascii?Q?aFW3ekTivVt9pWxxy7IOcqWLZCKZmG0o5iQ3kyJE1PxY6ee7TwetQQGjhsbL?=
 =?us-ascii?Q?+rPE1G1KwrmphXA1VwvfBU+jZeDyWVXmTJ/idu6gOhqpTJTvSHRv+yiER4qh?=
 =?us-ascii?Q?+nOs1FOwQBkSmWXshTkQcnv2znnMdmthFBMiagQejDcFpThCZgsP3ucOXcS8?=
 =?us-ascii?Q?R9yRH9CqeXgR0lRc0DkghcO29EvSz6EUmpCdoqJpNTICJ5ZA90LgVnejByKr?=
 =?us-ascii?Q?/lYxW4oe3snLCxjB6sPCT8jgOX3g3LuGqUGu1DgyZPL5ZR/IVJs646gXZaoi?=
 =?us-ascii?Q?4Kd45JmaWpM6Nw1ssbFPrfPhIw7KnDVq/ZxHTcE9SkF4jz8uDZagkiE6+LmC?=
 =?us-ascii?Q?fzPfsu+jcy8hZY80ZVFUke3gSlfLh/6SZtRndtyDXtyNi4ix6zLuCoIJdySI?=
 =?us-ascii?Q?+iEulEG5oU1+RO48vrcl4EtSzfWxEe5tm2d73MYB6eI+4yTxSqu5c3IRM2ur?=
 =?us-ascii?Q?gA7XNZ+pGiSP/t4bBWMn6+XqXuzDIIfhY6YhykMFkR/WTyayGrim1Ie/Mp18?=
 =?us-ascii?Q?e2qmGCTjLnkXGP80AKl/flkWXUpha4amqzDfdi974Wc2XYO3XFoY6CBJ2BTp?=
 =?us-ascii?Q?TWE3VoCNv2PWZcG5c5qzwhEs00Ah1z+vrdZbECNXjwygjejwN8TCw9drmEnt?=
 =?us-ascii?Q?sZaLUCktimgtlLR6+JhrO6opVcJsm+oybTi52lDqEYd+NfF9MFGEXp60A2ZK?=
 =?us-ascii?Q?Fy48E4CmX0AfTjjtNrAtYPUPUsvZBB1M3IKRGfqOVILp1UbpeeOmcCfd5d5E?=
 =?us-ascii?Q?ZvTTzy08V0veusdLtHL8cQ24GdQwRqfBZqHE+fcWgFThxfFeVMNhdQYoSCGy?=
 =?us-ascii?Q?iyn/D7/oNxEuivGCzL6qN/GabFKWNOZ6x3VNmYGYp7q43fdHbXD4hVR6Q3PK?=
 =?us-ascii?Q?sB1NVREF5azIsj823ejvIfGl3TbZUjW6gAgb+AYzhTSxJwWZDeOw+2Zf3nNH?=
 =?us-ascii?Q?nJN+zAK0sLKyZQwIM3yD2dOyXi5F2Dg4tmEPWbqKxdfShvAhp1rldLLbMRo2?=
 =?us-ascii?Q?WW5AK/IsZLVhBRu03Vc8pyqch9DEA06LlOpKIErt1Nn3gt+5UnsTnzJZZaaS?=
 =?us-ascii?Q?6E9IPQdXEwZj/c3O2Nz6V+WrIbzq8zhoAdJCv5Isq7mMtBsStCjSfJZrxASR?=
 =?us-ascii?Q?j0EjlViXVl93CtVCy7Ui82rA9J+UF5p5d/mIudquHNq/5rDsikk2WQPLM8Zl?=
 =?us-ascii?Q?RzPQOVYcI7KYrU1ZQvl2J03NGGz85VIn9Q7FfgyURfyqPNhsrRiNW0gyUqRh?=
 =?us-ascii?Q?gvNAeBpUon3Zya4XqbgPeUMBlgpxUnHEV8OCmT8YgHsN8ZOOQdPKEIMNO1bz?=
 =?us-ascii?Q?uu83lni8ZxBSWi4LbgNv09QWQuSRl+BcLXZA7ww/V4COptF/fsWpdpVsTu+6?=
 =?us-ascii?Q?4AlzikknIUZOEAtZFbv58d7TMNil8opix+cu5LyF0ewdupksXPHdIcvMrFgI?=
 =?us-ascii?Q?zE3tnMhrUqyYCbwIwIh0hZkqWAKiW6Zb4cq10tia0/5IH10ylO4++uiQB10h?=
 =?us-ascii?Q?8DmfbXQ+jOz0ktZbXtxZbWsyASPDW5qlLZY68w1rWQ43VRt635QyExoUfiHU?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 339333d9-654e-489c-ee11-08de00259d85
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 13:31:09.2133 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QwY0p72eUlcpqCCkuUqtem3l49BQ3vWb8dt/Muuy2T2tbx2f1oorZwiiGhMx5pSR1oFsjqLZE4tq5Zw4R16AajMxoxu5H6ylN/RozdMgk9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4763
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

On Tue, Sep 30, 2025 at 03:06:14PM +0200, David Marchand wrote:
> Hello Bruce,
> 
> On Tue, 22 Jul 2025 at 16:04, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > When processing cmdline arguments in DPDK, we always do so with very
> > little context. So, for example, when processing the "-l" flag, we have
> > no idea whether there will be later a --proc-type=secondary flag. We
> > have all sorts of post-arg-processing checks in place to try and catch
> > these scenarios.
> >
> > To improve this situation, this patchset tries to simplify the handling
> > of argument processing, by explicitly doing an initial pass to collate
> > all arguments into a structure. Thereafter, the actual arg parsing is
> > done in a fixed order, meaning that e.g. when processing the
> > --main-lcore flag, we have already processed the service core flags. We
> > also can far quicker and easier check for conflicting options, since
> > they can all be checked for NULL/non-NULL in the arg structure
> > immediately after the struct has been populated.
> >
> > To do the initial argument gathering, this RFC uses the existing
> > argparse library in DPDK. With recent changes, and two additional
> > patches at the start of this set, this library now meets our needs for
> > EAL argument parsing and allows us to not need to do direct getopt
> > argument processing inside EAL at all.
> >
> > An additional benefit of this work is that the argument parsing for EAL
> > is much more centralised into common options and the options list file.
> > This single list with ifdefs makes it clear to the viewer what options
> > are common across OS's, vs what are unix-only or linux-only.
> 
> I sent a few comments, but the series looks good to me up to HEAD~2.
> 
> I am still pondering on the new options as I don't see the need for
> multiple options.
> 
> I have in mind the case when (containerised) dpdk applications are
> started with no EAL core options, and they rely on cpu affinity and
> EAL discovery.
> For them, if we don't want to touch the default behavior of the -l
> option, a simple -L ( / --lcore-remap) option would be enough.
> And this -L option could accept an optional base value for remapping
> to a certain range for multiprocess?
> 

That can work, but the complication is that -l option allows remapping
within it, and the interactions get complicated. So we'd have to disallow
the advanced remapping syntax with the -l option. That should be doable, I
suppose. Let me investigate and respin.

/Bruce
