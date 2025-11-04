Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A7ACCFA04
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 17:16:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3814F40653;
	Tue,  4 Nov 2025 18:16:30 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 197D34028C
 for <dev@dpdk.org>; Tue,  4 Nov 2025 18:16:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762276590; x=1793812590;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=GoHFGN8HVpS2DZwkFYLLDkrcP/mo7/21e4b16AxkrYU=;
 b=Svhm3QyhfjhY3ALQVj+ixwEafu/VA93POfaPg1GRxXE8jclSnQd5+g7V
 IFb9ldPX/ehh1Di3/E0nveHNSjD+i1dyEAqQF4wklTZuY6Ik//CXTBKqO
 Ztq3jJ+64kyp6pwQQwN8SfqxgMRNUemWfhvZkrLd9TrhIM/GJ8GMub8Vl
 32uZEPbyZEg4ztTjoek4eXDj4IhjkErqeYyU3dOrTR0Oyoh2yiN8N5gL6
 j5MCjU6yfvzovpqL5RUqD2V/JuuAVItt3vlzEHfA2H6w2Oj2HEoWB7/ie
 I8A93RK5nOhRVimF6mZllLP3Q0No/pf/fUq6iKcToaRLT/LyG7W6huMpA g==;
X-CSE-ConnectionGUID: kgMsvoe2R7uzl1fpaKIZtw==
X-CSE-MsgGUID: 63VeKOR2SaWiY0yj1VtyEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="81785144"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; d="scan'208";a="81785144"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 09:16:28 -0800
X-CSE-ConnectionGUID: BeErMZ0ITb+Ap7ZmTxepIw==
X-CSE-MsgGUID: 3UcTtw+JRHyDRA/9qIGQkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; d="scan'208";a="186896435"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 09:16:28 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 09:16:27 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 4 Nov 2025 09:16:27 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.51) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 09:16:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=smRZXlBewkDD0LVAsj72w+IS2BTseJLOxxauFSEUXY2keUYFh1cNrlIaSVMK0JJKExC52UkiFgSFTMzZE3Hc1AzNt7nrxyOjeNALeem9FoIpSSkq96K8subtwUADoACH4uKKfdFWSvX5KcoguHNllIzIKNugI2WWIFzQBNm7IfRCi2B3AucgJTOIv6IchVfYNTmcyTyCVdJj6qn61Bby3jqkHDQ46/AoxCD4+HIhSUVP1R2rZZGbZphp+CsZp6Idk6AmD8SFUU3XowKfnkmdnzerX/sFFIz8hSIrcCV/DFHNMbMS7wPXj8Xvmv2SRoGRP/ibs3apDrNp6XmdZ2kQOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdkvhFWy+Z4X3UMQBAQhIQwWFFwLg1yN2TmyKH6rs+U=;
 b=wmYEO11A4e1O44RWPQ0zLnhD1vDx7yU2mR7nUsH3iQpBvfxArk10OAxOmmzoE1opWYdxps8cAfpXdtPm140PkBZ+lHKuE4JVU3AgAPPW85iuZ4tE2WxHYNLg9U0sLHpBgAl85+dS/na/im8ScZ8BAMDd/THupKWFz35XRggULHPlkXwd3emJye2Dj/BUbg3Zxdhtxl6KQfxIjq59YZTtLoHvtusUoTrDnjGhXZJuPUXk8Akk5mnUKl8IAdbB+gu5jCyJ/Ad1smDynTWTZ08GRpo273djnqZWOzIXgePvEnL01eq51xrnFYVeXv+bxOULAcW9/LMlIRXldMpLTb4aHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ2PR11MB7716.namprd11.prod.outlook.com (2603:10b6:a03:4f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 17:16:25 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 17:16:25 +0000
Date: Tue, 4 Nov 2025 17:16:19 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 1/2] net/iavf: fix AVX-512 double VLAN (QinQ) insertion
Message-ID: <aQo049BYyDIxh_JE@bricha3-mobl1.ger.corp.intel.com>
References: <20251031152250.2441980-1-ciara.loftus@intel.com>
 <20251031152250.2441980-2-ciara.loftus@intel.com>
 <aQo0QLplPKmTbZTS@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aQo0QLplPKmTbZTS@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU6P191CA0071.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::28) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ2PR11MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: 1144b814-10c8-4ed4-35fd-08de1bc5e1f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bwKXVmnKYy5y4HBBWCfGU2MFbUSsKcuvhp+/eOxc2h+lTqQBcy+dQe17B1vq?=
 =?us-ascii?Q?bKBB9B7zzpeHqALQgW3Q9EKi34gI6m7IgfNM4RJBDYOC578ALRMDd+Brlctj?=
 =?us-ascii?Q?zAsVzRd5EmlbDo9ZZdXBsIt/h1VdldRLtx3hNqrlFkpRr1r2m8Xy6cuO8tsC?=
 =?us-ascii?Q?4brFgDGFPqlmmyEbVxyiRLM+jzimL0qh10bqnl2BWnQVQwhk44Dpetk8AB8Y?=
 =?us-ascii?Q?2Xuc8iGQCbDoptBH5+GUg0ClG+vOusXDOz/jmu/TBCd8zI4Tgp3w1tb1ymHv?=
 =?us-ascii?Q?aHDLOsJYW9FgXMwdVweZIQHXJSIDgNVyzlfsAmaDNaS/pU7hqx5Yqhye5hnN?=
 =?us-ascii?Q?7+JF/Dvk848KqGs/wkJEvv4kkqhOg0tHr1L+lLImfvRwcXkizXOaA/ZWGpyx?=
 =?us-ascii?Q?MXcn8ymkObunxY3ohK1zEC9bnEDcdoGMTKXeo4qStAek4X3JeehRCkevqwnl?=
 =?us-ascii?Q?5CLhvtvVqEYibflkJlWu2kzxcC1dCnQVE038WQ9Qf2CQvkM7hi0f3l/VtGx1?=
 =?us-ascii?Q?CrL6lkz70yTsgG3pu7a3Q43LhQ2KPimKol9Ysr0FedNOI4PFifeyBKZ9WnZj?=
 =?us-ascii?Q?nFNS3Plhv5uuJkxfuuNqkLgIkgv+odPpyOkclAf6mHDhwiit4JN8qtnZpTiq?=
 =?us-ascii?Q?Yma5o+QJD4T5FXu60npTqsUTYEqgmkHErJKo23XviBQ8nswnkB/13X2LAF3b?=
 =?us-ascii?Q?JywmYVjmDwWUls0tYlpuKzetsG03aYHvQWmgR/HHMkPrCu1H/fA9rF1LAZ+W?=
 =?us-ascii?Q?AIdS83wvxgQo3JfIZFJVR8vm4OteK0hs4IIFeUq9GOxkSDjaDBEVlx5dwPuy?=
 =?us-ascii?Q?8Rp5WjnoFDaT+HFUPT9qs62yH/MO+oLTqSqt505CJyHH68jAIe+ZLIBQYFX/?=
 =?us-ascii?Q?As1uga8v0y0PxbobquxjeKM/QFVKMFNO4yUbAkXB7S69YTO8NE7M2Glqi6s7?=
 =?us-ascii?Q?ZR4DoNI65AZsDSntiAzwoiz/lc3AQ5lmxvnJQ2KfSdq46spkQcbFx31zfWCy?=
 =?us-ascii?Q?70lP+vvXKVLC2kkrggHwJo5ZWSwzsjAX1ZWtmRe9oJnJ29tG/LWKML9ezkGb?=
 =?us-ascii?Q?2n7DE4RBFEieGCgGVKoECsVTIXb85k0n+CpnPA9a/P2tCtnNeeu7tS1rDwhE?=
 =?us-ascii?Q?tGYnfM1gDbisVaHcGoH5q70zI49ReXF958bvwzdcTo3mBfcp94XxRZFedO2a?=
 =?us-ascii?Q?7fDUnMStjVoIuexHL/V4/HZ5e6SDKB6VHbEyc2vxdKNLIPfEu6wNjIkkJ5/a?=
 =?us-ascii?Q?c/dl9IlRFbg/MggU3lDCYWwNqZ00Z21rfSlEEy6AjjOzKF1ccDvkC9WvSE4n?=
 =?us-ascii?Q?yY0XAdHl9Zb+tAoTwv52E6O3SDDozzruRupmtpagxobtNiLGKKWktvVBkO5F?=
 =?us-ascii?Q?zXGodk17jn4xjutErmNKl/abL3ZITwJt0Cdd+BqlSn9RqIDgqY5RsN9sSDT7?=
 =?us-ascii?Q?WmyPAGPhcWzBIk3FJiXv0vi30x1iQs2c?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UW9WS6tzlg6I/PNYzAcvVVoZMTBp4M5ONN1wtBSRaqOAV5A7hLdoD4YOlhLI?=
 =?us-ascii?Q?/39Aahj4J30IdA6FsG1N2O9wDiieqToNRAtqa4hYTZASm6Zn1A9aV6jS9Ca7?=
 =?us-ascii?Q?3te/iBltmOT1NjGsfXGJIo8ovK7iuJaM2HCNrrDHISzXf8HTrT+qsbT1dD2/?=
 =?us-ascii?Q?KMS4dnFFskdFkcwneB568IDpVwhkw7ZXd074hmDP8c3J7avQmLCnRZUhhqpS?=
 =?us-ascii?Q?isssb73Mb9x9AEJ2yTEXcKhWwxFsPQbhvXa4j8m5PUfPi3C5DdUMzb0yIkNI?=
 =?us-ascii?Q?PsNSyCxC0yFzni3yYq2/kZJuOaxnDQ/irIO2Of8zrdT4VF+7mPQbMr3TUP8q?=
 =?us-ascii?Q?qv1fMevVehH9E83ThwVwfIH0V11tyJF9vDMqxvPauzvQ9vXhytsv2E06roqu?=
 =?us-ascii?Q?dw/nyIFPFj+e9rgGWjozMcZTM7EH3+UkzciibhV1Od9FDjjEzhS48aE53fQz?=
 =?us-ascii?Q?dsB6QOpYXzN9gTmZ0gp+FSsN2OH1KSGVDeZViTS8YHfPGTHG6b1y/thpAo4k?=
 =?us-ascii?Q?liz0I5LRyBwpczOSScNAOf+w2ho1PVANVJJrTEYvXUsrVMaNOBKvXL3ghyU1?=
 =?us-ascii?Q?fiOwlP2Jc/qmQBGYKAObCMgBEmv/HyzTGTF2M+ZIebp0wyFFBPcbGr/lXShd?=
 =?us-ascii?Q?offHDxt3pPTDijV90S1IPwV9wbBS3rAMFHXxbbJMBmepWYAQkL10ZKHini1C?=
 =?us-ascii?Q?Dth2ct+okgb/Z7SodZ2DqPT7ED0x0RlrSryZ6Ny65/ygs5RnwfFh2yYOhopu?=
 =?us-ascii?Q?r7D0a2jHA/rNNdDJT7NngkltYPxZz5RkZiTi5ysg3+O9a+mg2CiS7K2kIUaU?=
 =?us-ascii?Q?D05OlQCU7WGM6jVHTymWvVYvGJdU+wkcEGPoah6O+LmfMUt6d17VKST4uwwQ?=
 =?us-ascii?Q?2sAMsx9RtPaPNFaF/SSvrG2do0DKrq0NL4Ytdwple1amTwUK6C+k3DeWh/tv?=
 =?us-ascii?Q?cwI7mdVFktUR8dKDmeQ5OMXZjQ16FhAAMSpAyGr/ZnAcnEEGMZfj7RFyDesQ?=
 =?us-ascii?Q?oSA6k9vewbmT6IZtgiQq6ZQRD0kpzWqFLG/TUULQtlOwh/WpEoMS/SRR4bCC?=
 =?us-ascii?Q?ibMzo8d7M6AIX2mLsklFO5c3ZFuNtulewgATRzK+swL3nlte1aDmd5kffvZ/?=
 =?us-ascii?Q?/6Mzr6uCLweePcR4IjgdZmkAyvz8DtE0UlSv+B6RcgFO7NVRLoihx1lap3do?=
 =?us-ascii?Q?5e3ZR8/c84NsoOf+DlmF6dkuynqLLE5wiLFHZ/tS50KFtWyP1IE6OpIq/iym?=
 =?us-ascii?Q?+3DA8lPrLsnjyPvmDPcMsRjw90P9lKoJ4/9rD2B0S86L9BbgJRuA6++C5O2h?=
 =?us-ascii?Q?TFsQ9c00UDo0is6jHThL1H4/Buox0KLtZ7xw7GDeIb0nG1ek5xCWNe9kIYyI?=
 =?us-ascii?Q?y7AXwTh/LffHNsFXTG9/vkWVIW1p8DGMGQovI0eRJW/rqZPCkCD4xKgqWsXk?=
 =?us-ascii?Q?T6rWIvXvaaJlzd1ExU6PonLFZGHqtnlmQrVA7XK9IcGsZARJbbv4+g6Iw1QM?=
 =?us-ascii?Q?l6dfvyo0gw0hCirYjaSXPn0jnNRjhJ98+NRaNFfWMpN/yFHRl9+e/V1ZJIWk?=
 =?us-ascii?Q?H+zOCGEBj364yE4TM2YUkzUNay7z8XAd4oWLmQbiUhs3i920TkIyJitusQoZ?=
 =?us-ascii?Q?XQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1144b814-10c8-4ed4-35fd-08de1bc5e1f2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:16:24.9576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DviRd/Gg/mn+73qt5xDZOrNxOvDyv5PLko5oUytJhEAqcF9RjzEsDGI9yuow+vnoKwG9uiu51uENtnAWQWQHO/eW+ObJhTZ+sJDU1tr9tus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7716
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

On Tue, Nov 04, 2025 at 05:13:36PM +0000, Bruce Richardson wrote:
> On Fri, Oct 31, 2025 at 03:22:49PM +0000, Ciara Loftus wrote:
> > QinQ insertion was enabled in the bulk transmit function but not the
> > single packet transmit function. Implement it in the single packet
> > function.
> > 
> > Also, fix an issue that would arise in the event an mbuf had both the
> > VLAN and QINQ offload flags set. In this case the L2TAG2 field would be
> > written to twice and could cause the tag to be corrupted. Reorder the
> > logic of populating the L2TAG2 field and ensure that the field is only
> > written to once.
> > 
> 
> While both these described changes fix the same commit, can you please
> split this patch into two, because it fixes two separate issues with that
> code.
> 
> Just one review comment inline below. You can keep my ack on any new
> versions.
> 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> 
> > Fixes: 3aa4efa36438 ("net/iavf: support VLAN insertion in AVX512 Tx")
> > 
> > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > ---
> >  drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 50 ++++++++++---------
> >  drivers/net/intel/iavf/iavf_rxtx_vec_common.h | 10 ++--
> >  2 files changed, 31 insertions(+), 29 deletions(-)
> > 
> > diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
> > index d40a858413..c800ae29e1 100644
> > --- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
> > +++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
> > @@ -2077,7 +2077,13 @@ ctx_vtx1(volatile struct iavf_tx_desc *txdp, struct rte_mbuf *pkt,
> >  	if (((pkt->ol_flags & RTE_MBUF_F_TX_VLAN) || offload)) {
> >  		if (offload)
> >  			iavf_fill_ctx_desc_tunneling_avx512(&low_ctx_qw, pkt);
> > -		if ((pkt->ol_flags & RTE_MBUF_F_TX_VLAN) ||
> > +		if (pkt->ol_flags & RTE_MBUF_F_TX_QINQ) {
> > +			uint64_t qinq_tag = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ?
> > +				(uint64_t)pkt->vlan_tci_outer :
> > +				(uint64_t)pkt->vlan_tci;
> > +			high_ctx_qw |= IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
> > +			low_ctx_qw |= qinq_tag << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
> > +		} else if ((pkt->ol_flags & RTE_MBUF_F_TX_VLAN) &&
> >  				(vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2)) {
> >  			high_ctx_qw |= IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
> >  			low_ctx_qw |= (uint64_t)pkt->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
> 
> We are missing handling here for the case of vlan_flag set and L2TAG2 flag
> not set. However, that is handled by iavf_txd_enable_offload - but only if
> IAVF_TX_VLAN_QINQ_OFFLOAD is set, which it is by default as far as I can see.
> [Maybe a future patch we can remove that define???]. If it's not set, do we
> need to handle the vlan case here? There also seems to be a little
> duplication between the code here and in that function.
> 
> > @@ -2127,17 +2133,6 @@ ctx_vtx(volatile struct iavf_tx_desc *txdp,
> >  				((uint64_t)pkt[0]->data_len <<
> >  					IAVF_TXD_QW1_TX_BUF_SZ_SHIFT);
> >  
> > -		if (pkt[1]->ol_flags & RTE_MBUF_F_TX_VLAN) {
> > -			if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
> > -				hi_ctx_qw1 |=
> > -					IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
> > -				low_ctx_qw1 |=
> > -					(uint64_t)pkt[1]->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
> > -			} else {
> > -				hi_data_qw1 |=
> > -					(uint64_t)pkt[1]->vlan_tci << IAVF_TXD_QW1_L2TAG1_SHIFT;
> > -			}
> > -		}
> >  		if (pkt[1]->ol_flags & RTE_MBUF_F_TX_QINQ) {
> >  			hi_ctx_qw1 |= IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
> >  			if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
> > @@ -2153,22 +2148,21 @@ ctx_vtx(volatile struct iavf_tx_desc *txdp,
> >  				hi_data_qw1 |= (uint64_t)pkt[1]->vlan_tci <<
> >  							IAVF_TXD_QW1_L2TAG1_SHIFT;
> >  			}
> > -		}
> > -		if (IAVF_CHECK_TX_LLDP(pkt[1]))
> > -			hi_ctx_qw1 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK
> > -				<< IAVF_TXD_CTX_QW1_CMD_SHIFT;
> > -
> > -		if (pkt[0]->ol_flags & RTE_MBUF_F_TX_VLAN) {
> > +		} else if (pkt[1]->ol_flags & RTE_MBUF_F_TX_VLAN) {
> >  			if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
> > -				hi_ctx_qw0 |=
> > +				hi_ctx_qw1 |=
> >  					IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
> > -				low_ctx_qw0 |=
> > -					(uint64_t)pkt[0]->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
> > +				low_ctx_qw1 |=
> > +					(uint64_t)pkt[1]->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
> >  			} else {
> > -				hi_data_qw0 |=
> > -					(uint64_t)pkt[0]->vlan_tci << IAVF_TXD_QW1_L2TAG1_SHIFT;
> > +				hi_data_qw1 |=
> > +					(uint64_t)pkt[1]->vlan_tci << IAVF_TXD_QW1_L2TAG1_SHIFT;
> >  			}
> >  		}
> > +		if (IAVF_CHECK_TX_LLDP(pkt[1]))
> > +			hi_ctx_qw1 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK
> > +				<< IAVF_TXD_CTX_QW1_CMD_SHIFT;
> > +
> >  		if (pkt[0]->ol_flags & RTE_MBUF_F_TX_QINQ) {
> >  			hi_ctx_qw0 |= IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
> >  			if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
> > @@ -2184,6 +2178,16 @@ ctx_vtx(volatile struct iavf_tx_desc *txdp,
> >  				hi_data_qw0 |= (uint64_t)pkt[0]->vlan_tci <<
> >  							IAVF_TXD_QW1_L2TAG1_SHIFT;
> >  			}
> > +		} else if (pkt[0]->ol_flags & RTE_MBUF_F_TX_VLAN) {
> > +			if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
> > +				hi_ctx_qw0 |=
> > +					IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
> > +				low_ctx_qw0 |=
> > +					(uint64_t)pkt[0]->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
> > +			} else {
> > +				hi_data_qw0 |=
> > +					(uint64_t)pkt[0]->vlan_tci << IAVF_TXD_QW1_L2TAG1_SHIFT;
> > +			}
> >  		}
> >  		if (IAVF_CHECK_TX_LLDP(pkt[0]))
> >  			hi_ctx_qw0 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK
> > diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
> > index f513777663..bf8faf3632 100644
> > --- a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
> > +++ b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
> > @@ -225,12 +225,6 @@ iavf_txd_enable_offload(__rte_unused struct rte_mbuf *tx_pkt,
> >  #endif
> >  
> >  #ifdef IAVF_TX_VLAN_QINQ_OFFLOAD
> > -	if (ol_flags & RTE_MBUF_F_TX_VLAN && vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1) {
> > -		td_cmd |= IAVF_TX_DESC_CMD_IL2TAG1;
> > -		*txd_hi |= ((uint64_t)tx_pkt->vlan_tci <<
> > -			    IAVF_TXD_QW1_L2TAG1_SHIFT);
> > -	}
> > -
> >  	if (ol_flags & RTE_MBUF_F_TX_QINQ) {
> >  		td_cmd |= IAVF_TX_DESC_CMD_IL2TAG1;
> >  		if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1)
> > @@ -239,6 +233,10 @@ iavf_txd_enable_offload(__rte_unused struct rte_mbuf *tx_pkt,
> >  		else
> >  			*txd_hi |= ((uint64_t)tx_pkt->vlan_tci_outer <<
> >  					IAVF_TXD_QW1_L2TAG1_SHIFT);
> > +	} else if (ol_flags & RTE_MBUF_F_TX_VLAN && vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1) {
> > +		td_cmd |= IAVF_TX_DESC_CMD_IL2TAG1;
> > +		*txd_hi |= ((uint64_t)tx_pkt->vlan_tci <<
> > +			    IAVF_TXD_QW1_L2TAG1_SHIFT);

Very minor nit - this line doesn't need to be wrapped, it fits in 100
chars.

> >  	}
> >  #endif
> >  
> > -- 
> > 2.34.1
> > 
