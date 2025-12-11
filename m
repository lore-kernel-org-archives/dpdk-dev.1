Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB68D41C12
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Dec 2025 09:11:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E346940B98;
	Thu, 11 Dec 2025 10:11:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 35BB440285
 for <dev@dpdk.org>; Thu, 11 Dec 2025 10:11:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765444275; x=1796980275;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=sKgBn0KKauPYR7vBUwS1/Q2+eqOJgH7TYuRmYEWbCqw=;
 b=WctrhL/wGPhVU1MyUdVhpwD84SAsqjRfHoQ3bDtVhWuXoAx6T967nMRE
 WyGowFS2E49AhkCE+/CAZiIbpk3jqZieljFB68+G2U4HNaywALxZkgRiH
 c/QlosADKnJ7fma0v/s8Lf2ZzvtfGj26qdUEYCduveO89NeWQvVeklEFb
 md9hWW84oB97sZ09DTNM71EOsua3KuUl01gJnMhnu10jxOFnu6EET1rfu
 7enBx/+b2WYzx3H1UfUPp4KvprzndzsAwlb+QtZv1lEds4ImxeP76ji2i
 Kq+rjC2Kl9hKYL6sstxovgR5ZRJZiHkPsxJolSv0fNxOqIWBpdf4YW39R g==;
X-CSE-ConnectionGUID: lRTZUbB9RguZJqD31L3zpQ==
X-CSE-MsgGUID: gdgSb6eXThqbiIe+9uxrLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="66606350"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="66606350"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 01:11:13 -0800
X-CSE-ConnectionGUID: zpjqh7aeQn2w3mM4jrqNFA==
X-CSE-MsgGUID: LofUpFs3T6qPR7pTdJLJnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="196022378"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 01:11:13 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 01:11:12 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 11 Dec 2025 01:11:12 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.38) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 01:11:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rXmPoJ58b6c30ER13hXH5pItFaHFicWtsY44ZVYHGfMcFGQ+52HQN5t9NxQYc8XZIzo37nqy0HKYinRh/d9g0/BQ1W/GsMxcinUn2NMUCNVbA9NrlG3vX+svVxMriSW+20NbC97i60zZtU7jhTIjcXmstD/L4tlbrZiWw7VONCUFJHX3DdmE+P5NKAaZSiEsYijAsr05CcevhtuT+su/UwFdLIfjAbgdx9zAvu3QXHqOeRxlBrXwoNZZUB0hhUJP70XHEEztz2RV1zpA/IsQfCg4/hJ2qFfhhLCbuw9SZZRsuB/XSy5dBxEEW23sGGlDZiD5vDoBxqNrh+lOqEiGHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7IUaUk93THkkagCfEoF/isQkMLiyjZ5uiieo6IBKVw=;
 b=EKD9M98Ue85trJciCdiEJr1qrxchVkh9C2VSM2Ait/nuRGs2kUWORNh2bwMn2CKo75F+PKHbV+WRtvB7608IUzqJBudXHqXTZu+/DgkwZNcwfp72HTCzvGPJKaMRnvQEscYyzGPXLpyjwj2nou6ZPoQGbSAVpkiR9TcN3EIFXcIVoeJNnMBFRBKTJ+/QBAni9gTy91r22HxT9WotyqiP8yGUYUasAKWu4WtnD3pa2HNMpHugRK3S3GP+lSTkUWnbi80LeOLp6H0YZGDdSQgiocU1XFdhcwPMPsDCdDNW0vAUNMxCPGv7ieQyrb9SxjCr+m7Zku/iiOHDUZyxQCg9tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Thu, 11 Dec
 2025 09:10:58 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 09:10:58 +0000
Date: Thu, 11 Dec 2025 09:10:53 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [RFC PATCH 0/7] Add script for real-time telemetry monitoring
Message-ID: <aTqKnUEMUxig7u4J@bricha3-mobl1.ger.corp.intel.com>
References: <20251210165532.103450-1-bruce.richardson@intel.com>
 <20251211100910.49a107c6@stephen-xps.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251211100910.49a107c6@stephen-xps.local>
X-ClientProxiedBy: DBBPR09CA0028.eurprd09.prod.outlook.com
 (2603:10a6:10:d4::16) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW5PR11MB5881:EE_
X-MS-Office365-Filtering-Correlation-Id: a9e1426b-966e-42cb-b3f7-08de38953279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l7rniYRU6qCGBseNq9nbYjindMP/+WZAv9K4gCBrESC4EUt+iXy+uZsLHMVr?=
 =?us-ascii?Q?hdGtA0ZvlWyCRf55562T11OpqGh8kBfF/2dfghljqsGqd512JdSitZr7t6yO?=
 =?us-ascii?Q?NMZQvsF2f6i5hMv6Wc7ixWyH4dzpavh1/BfDNoQhJQF/j24Pl2j7q2QMVQXv?=
 =?us-ascii?Q?QyMk3OTlyMDLr2yu8ewSRu4sETwqvkt1dJztR5hf8LvOoZP1hp9TM8MnC2Vs?=
 =?us-ascii?Q?0sGeuVwiIkKyskTjosCGL81RfifqpgKiF1af01vgb2i1ultpPXJk+h6tWhNm?=
 =?us-ascii?Q?U5BHF1mrope0HXRTXNY+UL4Zrnsr1sy/4H3VCFvuXce647lRzB3hTV2WhFXz?=
 =?us-ascii?Q?dhdGstNq0x902xI+aFM2FgyOHhzkc3M2ntUnuo18TiULTkWi1D81okDVl1qD?=
 =?us-ascii?Q?w1t+4tvxmmbif6gZuNeGgm0wqpkdJpD2R5QzyYbhNVgHvPesYXE1mBoSDYCq?=
 =?us-ascii?Q?iuU0Dy29XHr6IXWtVGXwFXJXQfjiIGneP0zDGuvNdV2dXCAlysc7+VXeaNXt?=
 =?us-ascii?Q?Qqvg8I379vogHrn/VZuRWx+G3WzLySnJpVH5G/1IUrxWCrEthame899yRfIs?=
 =?us-ascii?Q?/j3jGFutuUXUCFq8oWGD4evnK/J9CwFPHPXzSuWySYSfbPsJt2UxIEVB/wqp?=
 =?us-ascii?Q?htRfBGpuzWQM4s6voRnfzZb8aXssl9UrHrCT8P+pNxhfQpjj7QdMXqESAQZ7?=
 =?us-ascii?Q?aigYrBSPsWDfOjfO9vTthWYy9p0rPWdavykHDh9FK0/hG5FAEpetONWsAtue?=
 =?us-ascii?Q?UAKf91xr64tvj+xzkbEVp7GtM1U6IQyOrCyK9WcCAWwwBfzpYZwrm/9Y2sSL?=
 =?us-ascii?Q?Ku+wSc51RFzMgL3YETuajz+Ed8KAQplarSOve5vuUIwu2FWmHyP9PcdNz7si?=
 =?us-ascii?Q?2zXNg5htrL+pUXcvFKffcbF8bNaYqUEViEKXx4LWVzcI4Em3TDokYRWcHl4v?=
 =?us-ascii?Q?U7vW7Sn3t7nfD9+4swO0YIy5SkLN59/SAUkRfpCGepKnJROJclfarPcceRGT?=
 =?us-ascii?Q?1ixwb3R0FQ7lVL6t4me/KcBHuakFFJB+58nLPJZebL5yV2zfcngQO0hxXwsM?=
 =?us-ascii?Q?uBzTL3Al8dXwuqCpRb/pq1bH90LlCPGwXfcthKABrTpN+Dvn8DzkLswmk1pI?=
 =?us-ascii?Q?acylD/kUv9kzehyQnjypb4Rt+mtRElou0M/LWp8taiGaeXKzte+Vvl9dILtN?=
 =?us-ascii?Q?P31bv6p5uJCfs8NglDcUB9eUtpC3ZUJhFOsy3z7biDNKY3xvVcg8hrhbrqm4?=
 =?us-ascii?Q?QnaFBS+jOtlx+kx008jX8XUJBbTRAl7+rqG0T+xqlU4FfgmcblAn2s7ykVg0?=
 =?us-ascii?Q?LFI0CWKsvKsw5HOqywLeSr0RNZxEAR6uA7Oql5eqXXAnwqt1CKBBidtvmUtH?=
 =?us-ascii?Q?5oF3vYDrnDew/qzmUxMyW60wn5JSRNJ2xDBQd1RLuYN82t7+lZafdX2VWEZ7?=
 =?us-ascii?Q?xCWJ0cfGNKsndMpECzTr4AX8hx2ut3eP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vpWxjh9hMrCxCECjoRcUpODaBP+RmXd1p1opNcfNVINw9TrWbDMIqIOncTBw?=
 =?us-ascii?Q?vrvgrVabItEeQCk7SIEeDM+tOxBgm2a6qPiS6c9j/YflDQF9W0rd9AQY0zDQ?=
 =?us-ascii?Q?5+/Jhp8Q61pbxf/IUeSv8cpb3CwPfd32896lQdB5OPqiimeSA9QQ1YSA8fTC?=
 =?us-ascii?Q?sVnZwE6eSG1yvAXfO5gVWwciEs5IhqwofdJx0mL8lmbYIPiAgbrzq5CoIPrt?=
 =?us-ascii?Q?nSWPF58+41jux1NTJ58P6p9F1nlnM4FOMnFydOptrxYfdJn9dmaAbGTTAoHx?=
 =?us-ascii?Q?6TxIsUs1D1KASNwflYaiOm5hr17+vlT01rJys8wGRL9F2tMDiUmTWFgc4iIG?=
 =?us-ascii?Q?UBFdzSeprCQwKJHyIIDRadAkuIKxIyWqzijXKSlHv71g+LVGVqJNFPrvj+FU?=
 =?us-ascii?Q?+CVQlF/365sn2vEgfnfqxBxmb5f0UyMH6Wa41GujNPwoYyiQWkoThUk8l+wz?=
 =?us-ascii?Q?KRrfD7lcpbHaAke9gkoFTQ4IwWanJqfRbJM7IdGnrRRO+d3EBPwH8dg7rpRB?=
 =?us-ascii?Q?korV/2RUOTAQWBB7P0U8BA640mpldIF5pBdSy4FHPFO9u6fuwUUuEqtPvaX5?=
 =?us-ascii?Q?YAfPZtX3WioSuv1CBUgI22NvtxY0zUDayOs25GnpIsQBkferBNLn0U946m8B?=
 =?us-ascii?Q?rbqadKmbHqCSoWwV6kszStdAl1NotZDLUCVAR8ZXO3kv/ZQiHGzwYoA36VWJ?=
 =?us-ascii?Q?/b7JREXQwblPtuXyXWug2YOZUgtO9hztSPuh/8eyuBk1AtrEtFClGWLyy9oy?=
 =?us-ascii?Q?bs8bNkoRDCga8NBZ3kSFPGsH91QiuRvML3y+WQTxubUhlUwYHpHnP2B9QFMB?=
 =?us-ascii?Q?ZF9dHbW9GSwH+gFa07jiP6bK0wSEin1QKrOjqFws5moXJJJ880DhhiX2LSDu?=
 =?us-ascii?Q?n2NAwcg4diPiHe09jhXdlFiB40rlcqye1fKW+GUJBJM3JSG+SEkVvwP2fY4S?=
 =?us-ascii?Q?h5Q7AoT35+IjBUx5mSC88/PsJlR625ZBC26Xxy8KQOrX3ytLKUX17SlIm/kH?=
 =?us-ascii?Q?rn8Tdjjt8VhKi3olGAXf1JFA511eNuPkaVhBWaaifL/qbbb6U4h0ObqPn06m?=
 =?us-ascii?Q?Pql2T5JdkRizrdrud0j+M2oO0QuS/iAvUv5xj1/KSKLJOkvDMIfNjO8ABRYs?=
 =?us-ascii?Q?JycKgRWxf81UF4g1C4RzJG9iJS/jqFzoYhgqWLp5oQ3fqUjbqACdZt5kF2Ui?=
 =?us-ascii?Q?KmI0PLtQmVos09iFkCXoAveGgbcGQx4w7U1gwdhwOmyQN6+yKGXxj/m1hsI5?=
 =?us-ascii?Q?16pzwoCX5UIzniTiDhlInOL1zfq94tlbj8jL7J+AaiIyXoO1E79ktzOFTgal?=
 =?us-ascii?Q?V5eT5G+JSZxR50jRD2+hJYC9S23Kw5ejnlqAjdb/1oEeXVja0vL+HtO3EYx4?=
 =?us-ascii?Q?gY8G1XnBDUfGN6udVCIPwTHuTKow6hSQb3miAO85N059r55PR50Gl4SSrY/G?=
 =?us-ascii?Q?WGZ7wjArLsx+Ey/stnDOIN1lE889yOa/cTbQgRt+MHrOh1dloZ0NPC21obSK?=
 =?us-ascii?Q?z/s47Q+1RhDIVCkHiIlVmumqWiYt08+xyxA/canefZ3N+SYBuH6bd0MN4YA5?=
 =?us-ascii?Q?9UkDnty3KtHb9CLdV5AqG0/oRVHwHt5uAZ5/8+PJKC40AIP8BHiFw+XD1hV/?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e1426b-966e-42cb-b3f7-08de38953279
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 09:10:58.6123 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F1TqsGtGq8cLSWU/t8NvLlrIrDhI58cWYVAIfkpkXfRElrkWT9ndSpVU1Oe+fOwkOhOJw8YMsb/tkGPTjMff/ZstOetD2/K5a7jUDNxOTGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5881
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

On Thu, Dec 11, 2025 at 10:09:10AM +0900, Stephen Hemminger wrote:
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
> > Fuller details
> > --------------
> > 
> > While we have the dpdk-telemetry.py CLI app for interactive querying of
> > telemetry on the commandline, and a telemetry exporter script for
> > sending telemetry to external tools for real-time monitoring, we don't
> > have an app that can print real-time stats for DPDK apps on the
> > terminal. This patchset adds such a script, developed with the help of
> > Github copilot to fill a need that I found in my testing. Submitting it
> > here in the hopes that others find it of use.
> > 
> > The script acts as a wrapper around the existing dpdk-telemetry.py
> > script, and pipes the commands to that script and reads the responses,
> > querying it once per second. It takes a number of flag parameters, such
> > as the ones above:
> >  - "-d" for delta values, i.e. PPS rather than total packets
> >  - "-1" for single-line output, i.e. no scrolling up the screen
> >  - "-T" to display a total column
> > 
> > Other flag parameters can be seen by looking at the help output.
> > 
> > Beyond the flags, the script also takes a number of positional
> > parameters, which refer to specific stats to display. These stats must
> > be numeric values, and should take the form of the telemetry command to
> > send, followed by a "." and the stat within the result which is to be
> > tracked. As above, a stat would be e.g. "/ethdev/stats,0.opackets",
> > where we send "/ethdev/stats,0" to telemetry and extract the "opackets"
> > part of the result.
> > 
> > However, specifying individual stats can be awkward, so some shortcuts
> > are provided too for the common case of monitoring ethernet ports. Any
> > positional arg starting with "eth" will be replaced by the set of
> > equivalent values for each port, e.g. "eth.imissed" will track the
> > imissed value on all ports in use in the app. The ipackets and opackets
> > values, as common metrics, are also available as shortened values as
> > just "rx" and "tx", so in the example above, "eth.tx" means to track the
> > opackets stat for every ethdev port.
> > 
> > Finally, the script also has reconnection support so you can leave it
> > running while you start and stop your application in another terminal.
> > The watcher will try and reconnect to a running instance every second.
> > 
> 
> 
> There was a previous submission of a nice telemetry TUI which seems to have
> been abandoned, is there overlap with this?
> 

Possibly. I didn't remember that being submitted in the past. This was just
something I came up with a while back for my own use, and find it really
handy for quickly getting some perf numbers. Therefore I thought others
might find it of use too.

/Bruce
