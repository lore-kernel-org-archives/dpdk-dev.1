Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088B1C54E65
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 10:15:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2009842759;
	Wed, 21 May 2025 12:15:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id C17E642759;
 Wed, 21 May 2025 12:15:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747822533; x=1779358533;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=RXTgg4ehno3n1oZYymdLr3DNpxcuJ4OKuOBxw4lTOwM=;
 b=WO3PyNZsnpacj7k0Gdr4pT/Je11o0Vv83ywcBwOeUsPdV4lu3PhuPgQp
 QSxMfpfmq8ePMXmreR7qaHEtx5PjHY7dCGLFZdOp1CSkZahW9LZFeOVDX
 Dj2doz+8IgNwjuU31pDcvcT0Ng3kHLd0jgG/WxUttvc9rRuJ/PxulYxii
 qpD1j51wcXqGCzhi/GQ9LKNv5PmHo4ADBxAbcIQryD/95sPlKXRf31D6/
 PvVlDryTXTk3+umXHhccuiD8NOuuPaM2emUyG3s3dtzNq1pr3ReSeDiP0
 sFubGJ/uHDYne5nEMGWG0jkpGbkZq5+OP50XUlx5VWE/pP+XqK1sdsb8i A==;
X-CSE-ConnectionGUID: WC9rwkloTH6xuufN5b0Reg==
X-CSE-MsgGUID: X2qTkGO+RcqTJgjhjvgTRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="60836949"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="60836949"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 03:15:32 -0700
X-CSE-ConnectionGUID: g4e8GSHHTzupmRPY0tCW9g==
X-CSE-MsgGUID: ChwkhxqcQli4gdeBjZS9Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="145250691"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 03:15:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 03:15:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 03:15:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 03:15:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQSDhe5m09q6kKxrOJmtdVN/otHTti1DjNZ/BOOcs4k9wd5s5Re3Pl/Anx6pyp69F55JWh3bxQGx1TUsd9AQH0jMLATj52MceiYByBrDskLXoNirWp831BthSw6ZamgkSrGQ84ASjOBT6XVcdrf/FSD6SB4mf1yC1sdMJ0UCrPD2wqR3brXjPc4wli79phmfSGYzBpcjgbvvgfIPeVDAMuk4NeddG64rbenZRFLdfg8RMqgvV/Sa+aqTRpM7l0phL1aEqhbVKoXGZJgGrfKNJy5YqEgQdNuUq4IJA5bmAD3pYb5iLh+GWdKD4vY+Ec26mBOXoU24jnrxYp8spTUYmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEK98qGfbfca3ZrgwVNnLuEnVJoFVOdpD5S+6qwrxnw=;
 b=sPtw6sJf5L68WWtmzq9XT4xUpVDxOwv6VIFHGArFdATZWXSG6Vuq4SWogsokJMkg8PqrRcDS5i/4JcwxpSwWwdDUyVRYJkWqVhgGdzybw6TPOUNNMtvNoBduJ4LN/8nCn4BJl9D55Td9ke72slo27mAGhuVf9q7BW6br+TKH9cEskW87/MxdlZaDUn9qVhuUuHqKgwPVckUVHTuzWIrxdp+JWxUI37BcBj78xXvOIioo4+xfr7lyk8XducSJHRygjUaa0ZsQj6bXlQFpkXASc9TNUYbppVfxgXQwQaM714v+iDLI4YAkp5IbpBoY9Qdfz9WjRjmiXLdJH8vSkKU1mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ5PPF06F7EC6B5.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::807) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 10:14:59 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 10:14:59 +0000
Date: Wed, 21 May 2025 11:14:53 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Deng, KaiwenX" <kaiwenx.deng@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>,
 "Zhang, Qi Z" <qi.z.zhang@intel.com>, Yaroslav Brustinov <ybrustin@cisco.com>
Subject: Re: [PATCH] net/intel: fix igb tx queue offloads capability
Message-ID: <aC2nnefRrjONN-uv@bricha3-mobl1.ger.corp.intel.com>
References: <20250414085353.848901-1-kaiwenx.deng@intel.com>
 <aA-c2XuK7SFVKqqZ@bricha3-mobl1.ger.corp.intel.com>
 <IA1PR11MB7853D99DFF2993A5E3F1C4828E88A@IA1PR11MB7853.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA1PR11MB7853D99DFF2993A5E3F1C4828E88A@IA1PR11MB7853.namprd11.prod.outlook.com>
X-ClientProxiedBy: DB8PR04CA0030.eurprd04.prod.outlook.com
 (2603:10a6:10:110::40) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ5PPF06F7EC6B5:EE_
X-MS-Office365-Filtering-Correlation-Id: 67d5d7bd-13d4-41f0-dd17-08dd9850579d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NCHh4PHxgFoGaVdJf35XawtTaP4viROLEe6iJ/eSXSpXX2RIzqzKSlAuzNpq?=
 =?us-ascii?Q?Oduc7cSmgEMu2In2SajElBnlsS0PUH9mlqmGjd4eKVmbxkoH+7J2ofY1uTp+?=
 =?us-ascii?Q?B0ydMuZEcyd+5dVz/4lsyV60gdUdmJNV7Hwf2zdE9mPlIlACoXp7VNQ7moI/?=
 =?us-ascii?Q?KOl/00IMSHRlVbHzSKmtHA9B/701ZYgMRgHfM3/YZw17OLKnS59dzf1JYmRz?=
 =?us-ascii?Q?yR79/4Iq0jbRFvvl7Vmmu83Tf6nec+1AKOmUrfrPEYcfuxaqeuPSH/H8Zv0z?=
 =?us-ascii?Q?Zjt0T36Spv6grWIptTdG1rnIJIVQBk+1Dc/RMF5UoF9UbzQbLHiLPt6H2y6A?=
 =?us-ascii?Q?raKpObTfKHdWaWmvRN6+RLiisQwMgTKo9nQZNHOY5mmNMfsFbBALuweYjk1W?=
 =?us-ascii?Q?fZJWaFMbOd97OanzLWks3HB4zAQfeQf952BA5E/da72dhSViFPBZU1GWn9Th?=
 =?us-ascii?Q?IHdPclBGQr1TINIorjU9wTwfhExxBSMtFDYQKeqOFfDUd/CWpPXkcMGIePvy?=
 =?us-ascii?Q?9njh6sV6yolWwW92z3pAOEnzeUk7Ai1+ithId2YdIVHH/cmjg1JgSidpB67U?=
 =?us-ascii?Q?DxxKJv5Zhfr8CpYrus2GsXKB/jCLxvtejkk8xkbiWMv2mGioojz8aBiMnRRa?=
 =?us-ascii?Q?IZodZb0npZOFoR7QXbczXUqPfokUEyp3kSWw8cyr6N3WzYDrP+tHwkyK9xUi?=
 =?us-ascii?Q?LoDrgv5NB0qIDHo/KFbaIZTM52BI1M1fhwXJriAfifGsR1JrtsJ1nX9KGpCX?=
 =?us-ascii?Q?YY7e1K5z+sr4YfZYhAjp/sz5lI8KnNnD5nqnPWlR3MYFuzOLjN9cCh8h5W2B?=
 =?us-ascii?Q?fgviqnPitFqABVdGBuuRNm+7SsDcE+n2j604X29J+GHzFN224F9xQF90W4ib?=
 =?us-ascii?Q?We0sYQZiNlfO63cui/ab3Ng425yprS+u+gUJhEtAy3ciGxnhsfpPT4yOPCIh?=
 =?us-ascii?Q?EvQBEWypVH6KcWQ6ph3nKVfmJAVThM3pMLq6+xlARvCs54zISwCmD9nsN6r+?=
 =?us-ascii?Q?IE3BDe7sUAm3Z5s+kc8G2Uanm51rkzy8hVdMkSPF3cm/q4vRoAkKi0hOrsIr?=
 =?us-ascii?Q?62UjfTNCHoC77Hrgzh6c3Y4h/ET6bHdSTK46dXwBkffWWR2MBBS7Hvv89Bkp?=
 =?us-ascii?Q?l4uL+Zfv12nuRlUCiz3yRSTbqnUQQJLlxnOVthrpscb1pyzFgD+EQcjeb+aC?=
 =?us-ascii?Q?2at5raCNWJqi41d0qSiYWOI6LzP3EqnDTkxwF5Se4I0A5exD6yVrBvKwCXlg?=
 =?us-ascii?Q?6iT1CSxWWEIhpvC1dnpaRIqos9tX13FpkJBE4243xqZdoHTCvaKK3lDi2yLE?=
 =?us-ascii?Q?pBI8VrtcVCvVQ/jm0N6RdL7stl9m87igpVuTVKmD1gTOnhyQjTQZsbAXiLmV?=
 =?us-ascii?Q?jaPEaj14zG7RGpoYQudqTjAdBF/wodtwiiCD16z6PgwaURG4Bdj0BpHeMAnQ?=
 =?us-ascii?Q?cXgukbrbGnk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B45d29vu3A/MGAMwVfnGtdD90d0b4k1ChfoAGxHWYi0LTkOvqygXBPp0xRZH?=
 =?us-ascii?Q?xcPeC8TziTKqW+LidZ6sEyhB5E/roYFgzUoSvzijoOzhIP676CmA0E6IrvHI?=
 =?us-ascii?Q?P8pqi5ze0sVZqQjOQD4Mn9+kP3z2BNHLs+o2Izv9KizmctaH6vyFGmN/M+p6?=
 =?us-ascii?Q?osC+Jmg/rx6pOwuDKTNcDJlvVcZ07PRYiHNvUDkxJqTS8NrrURK8d0CGNrVY?=
 =?us-ascii?Q?+YYXyacfQrOOuJJqw9iqCftEUgRYw6ehY0UmdKDZyio3jgK5OAcM3JsvIgbX?=
 =?us-ascii?Q?EkakFdb2Ttqvk367elgPJd/6R+EHngmGbOhbsEHS4dSnlm9RBXNiGA1a60Ui?=
 =?us-ascii?Q?+u9MjbHXLfIy52E6AtgP/t4AeWahccr1yf/D3V7Z42IKbIR5dMSURI/xY8GC?=
 =?us-ascii?Q?Utp8h1vBqwTBNPAIc4T8EOr+1T6eqEiXfnAjVX+U7+/ggRFX0f8UG1XknPJd?=
 =?us-ascii?Q?U13iA8AIoBqQ9cmcmO1/vyNgDyxQ4aOLLY/chFkHbCklMhc7cRcL3Qr0EH4X?=
 =?us-ascii?Q?iM4C8mExnu0dSKShP7grCFOj/ESHFiu1Bm0wMf698/yXH3by53OgGzmVehjs?=
 =?us-ascii?Q?0UC77TDIp/2sTBmw3Xt8/B/1YFVCAVTkq+NP2z5IzEE+YX1b1CH2QbDaz4tL?=
 =?us-ascii?Q?1UIYP47UJERVhO+uVXHBFlUTaTSlO5DLDHii+3fByTwqCYWmvNA/AMHZ3z2W?=
 =?us-ascii?Q?4MoMZUeRqSyTjz+CVrZoM/TZluIEYgKtJJiPpVqLY1cDQ/p2yp5PI9X2weOK?=
 =?us-ascii?Q?lQverI9FkunF/DOAT2U6kS9+6Ti/q2hAf4vDCFstSOmCpGP+ILl7iVBF6KMZ?=
 =?us-ascii?Q?mSHG1hYAVUzyThDD4kjgkTMNBISiz5ApIALsQbdTcX008uDVw+tOEoT6/nZZ?=
 =?us-ascii?Q?AhGIskUrwveW7OxIuJdkPpRLbwF1r0zI2vjD1KYnQuBX50DX9xKJYMpV2AE6?=
 =?us-ascii?Q?rO9GcAQ0fatBC9oPVRVxSHaSg/GQ7TxxY8OgPpLqwVKhJOdRFbGZygfY6wK1?=
 =?us-ascii?Q?5X8i6X55cbR2aw8DDe96GTQY/qCHa1T8ONwey6pJMKKpvFh1as7p7a1XzM2N?=
 =?us-ascii?Q?jPfbwJkqbFd1nV9f+14WgiV6tVneu3w6l5Ct4/y7vwHrXzrh7Rl7iWSN3M2s?=
 =?us-ascii?Q?+Vpy6q0WyFYhPVaSz+N7Hxo0ZJpkPt7pfMx/1VD7AkaToxs6+PyI6aEpMchp?=
 =?us-ascii?Q?1109QkKAJpHpE5++W+nO4O7Pspka8S+Sju8LLY5MagRTRpt/kTtwZHykB/pi?=
 =?us-ascii?Q?yEBnesLP5fhLtidGRVBhwLrBtiOTUlI42tm/vfvT5aXz5wy2BoosH3n13P0U?=
 =?us-ascii?Q?x0KiitbFx29hnuIYLeFbXHuut3BWY0QhDyD19fojLugg/MZaMSo3ifg46oiA?=
 =?us-ascii?Q?Z09MmdmL5uHahsbGhr8kTlMnBNZzxjSW3YLFsap3BGqOT2DkJGAFms1on4V7?=
 =?us-ascii?Q?WwsscFngex0hINMzvOJ1prYD0VTNeo8dyWIQtrMEBx3+3WJCgfXp+Qeu7FvE?=
 =?us-ascii?Q?L69K3sa6vZNjuQ+CsyypmDP+6/QvETp8enublnE4v+T15IUZTdgcyWDDP3U3?=
 =?us-ascii?Q?/vDntPvwDMv9A1PBofRw1sSHF6dE/JmvDFenEiT3nO9pPaeRhqStdzaFwvzf?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d5d7bd-13d4-41f0-dd17-08dd9850579d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 10:14:59.3300 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: izMJSI2WyNHQmjklhneAPKUlB3txkTye7zpRpAkeQc6s3OAlm64bXJH3HaEX23jse8RGnP/TfKDgiDTyVTLUSpGPRBIELo0w61+AwACFAPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF06F7EC6B5
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

On Wed, May 07, 2025 at 09:59:04AM +0100, Deng, KaiwenX wrote:
> 
> 
> > -----Original Message-----
> > From: Richardson, Bruce <bruce.richardson@intel.com>
> > Sent: Monday, April 28, 2025 11:21 PM
> > To: Deng, KaiwenX <kaiwenx.deng@intel.com>
> > Cc: dev@dpdk.org; stable@dpdk.org; Zhang, Qi Z <qi.z.zhang@intel.com>;
> > Yaroslav Brustinov <ybrustin@cisco.com>
> > Subject: Re: [PATCH] net/intel: fix igb tx queue offloads capability
> > 
> > On Mon, Apr 14, 2025 at 04:53:52PM +0800, Kaiwen Deng wrote:
> > > The igb driver assigns the tx port offload capability to the tx queue
> > > offload capability.
> > >
> > > This commit will fix this issue.
> > >
> > > Fixes: daa3b0833f08 ("net/e1000: fix Tx offload capability typos")
> > > Cc: stable@dpdk.org
> > >
> > > Signed-off-by: Kaiwen Deng <kaiwenx.deng@intel.com>
> > > ---
> > >  drivers/net/intel/e1000/igb_rxtx.c | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/net/intel/e1000/igb_rxtx.c
> > > b/drivers/net/intel/e1000/igb_rxtx.c
> > > index 4276bb6d31..b63de2354f 100644
> > > --- a/drivers/net/intel/e1000/igb_rxtx.c
> > > +++ b/drivers/net/intel/e1000/igb_rxtx.c
> > > @@ -1490,11 +1490,9 @@ igb_get_tx_port_offloads_capa(struct
> > > rte_eth_dev *dev)  uint64_t  igb_get_tx_queue_offloads_capa(struct
> > > rte_eth_dev *dev)  {
> > > -	uint64_t tx_queue_offload_capa;
> > > -
> > > -	tx_queue_offload_capa = igb_get_tx_port_offloads_capa(dev);
> > > +	RTE_SET_USED(dev);
> > >
> > > -	return tx_queue_offload_capa;
> > > +	return 0;
> > >  }
> > >
> > 
> > I suspect there may be more instances in the code where we do this. For
> > example, I see the same pattern used in em_rxtx.c in e1000. Can you quickly
> > check our other drivers to see if the same mistake is repeated elsewhere other
> > than "igb" and "em"?
> Hi Bruce,
> After checking, the same error is not repeated anywhere else except on "igb" and "em" .
> However, I noticed that there is only one txq available for the "em" device, and according 
> to the comments in the code, This design may be intentional, as port offloading and queue 
> offloading are practically the same in the case of only one txq.

Ok, thanks for investigating and explaining. This patch seems fine so.

/Bruce
