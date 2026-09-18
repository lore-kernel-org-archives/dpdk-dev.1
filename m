Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679E5C982DA
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 11:48:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 323B643289;
	Fri, 18 Sep 2026 13:48:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id CB1E14027C;
 Fri, 18 Sep 2026 13:48:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789732093; x=1821268093;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=j3WPULFn/m6yiFlHTccFAx5M33GDZUn+4qOBHhNIONo=;
 b=G2q3ZXZH+O5Vu/FnW5xawBz5wO54Cp0npUpds9wxwyA7d7/xQBw/W/5v
 arB4qLyvIwZNwFTSQzlsOJQXHjsbWyKjqRsrlbOB5NUODcMgKFxYfxEAx
 2SJnY5WHTMc5MeI7BJJJKjQHwkUIaRyq9YZ0h2C9gycpsoZK4GKQM/Cut
 nnZLbIiZHNm8DNwja5LrChwQKwcKVY+hlWE8e7rM5axxSmidQAKaU5cv/
 d+nET6UKEbZq6hllm/ztOo3+KXhnLrXx9wXUhsgq4J8MzGMGI4RdelqO8
 yJY8QDBcIVPSlgahMS/7cURQBu8L8ZWzfCs5RqwOV1rfzuRoxTMUjGBoB g==;
X-CSE-ConnectionGUID: rjkQJoniR4mq67e8BPKheQ==
X-CSE-MsgGUID: 70C0ypReSLCdSsgItMCuJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="89164165"
X-IronPort-AV: E=Sophos;i="6.27,108,1787036400"; d="scan'208";a="89164165"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 04:48:11 -0700
X-CSE-ConnectionGUID: C0E/24EcT2KRhHoW/hCJ5Q==
X-CSE-MsgGUID: nSH0KADORSWBq5eZ0M0blA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,108,1787036400"; d="scan'208";a="270679843"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 04:48:11 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 04:48:11 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 04:48:11 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.64) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 04:48:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UiM9w0qYWnOh8fDvLRGZi0bm6uGws38uF5tenBA5HZ58bNsXNV2sC/9IWKemMwolHHMDYdWzorUCymrOjYV1W0Iy1sNBC3WYEi9RSj9HhRAAhOlqVHt7EhADuFtoJ7Gss+NOLEhtTrCNH55NoZ0zfG5fZnwA+HjLiDJNOTmCQwWuCXuP3NARoVNcWkSRYCLml/jfgqXdyEiBfgmTe64W/zQ3pbTOPhSGpirmXsJC+DvBl0vcatR7gPxDz9z0zwwLH0ra7QfvoBXNcXKR+tRJrhH5zAvrk3lXL87a+M/z5WnDvrgaTa8KSHxZy0qiGj9qKPYskmG1+CELo7dOi93ZJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YqUWxFbbiK86JBvLO32HmipuvCTHR0oVmcNTHlh7BWg=;
 b=g85nXlr43DsyPibkpBvaJ0GXv0RR4QHiNGx8BpnQG8mMwhrt5qYvM5lTlcr1eq+3HEKaFwjAu8ylG0RjN9T0DTrEi81Piusof4xA8Inw1B3snASWtCdGPfvubc4LB4jrwHm+8HIsXv1qQt8/JTAKWzTyz0W2+31KyCum8pLuj230k0KfUKJIUekfQwAOEphIpIlGeQk0ZxFdh3EHLfyxcqdE7KQKjRiS2ToVKmv01Fyk/IjyzoESLVOnCX9CmEJ0JCcFrjJNF4aHVPFkEW6VdpUvBQwQ82HO+j0xFKWKLY2xG0ifyIcXZUjwnh1QzjnxRI3JgRxEb/9ERlFzQTVhVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH7PR11MB8570.namprd11.prod.outlook.com (2603:10b6:510:2ff::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 11:48:00 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Fri, 18 Sep 2026
 11:48:00 +0000
Date: Fri, 18 Sep 2026 12:47:55 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Zhang Tengfei <zhtfdev@gmail.com>
CC: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH] net/ixgbe: fix leak of filters on flow create
Message-ID: <aq0k6zi3wZyQxN0X@bricha3-mobl1.ger.corp.intel.com>
References: <20260914133836.14644-1-zhtfdev@gmail.com>
 <aq0jGjFFXkPSH_kX@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aq0jGjFFXkPSH_kX@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DB9PR06CA0013.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::18) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH7PR11MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: d82c251b-5b15-4ff6-1503-08df157ab077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: dLmLQtleatkWgCEZ18ju4ns8/vbAUScz3DtR3pvdbhn39kn1xVYE+Q7RRAjlupImL90lFNcqV9IG1TiE3hdyas6DfMS3SgF/iV+HKo3Ee0DfkiCre/O5+D6ju3uQ5jLl+nZohzVDcDUCI+dm7NELoMzhTHxMbGUCb7TiHMNgZwDr5LhxcFsbYwAQV8ECXJsxqp45VlqSyCNwh9ue1nSXK4wSaKcn3S8a9xnPJxbc1qBGDZh8i8rAQwafK+utuv0vjFirgl8m06MhOF/GeoACJmYkhoKda502Os6Ck+Umh8OsST/GYefsBcttv4wAbYIiXVHFfdVOoG4ynsg/o3BGtDjEctTj66AeEbbFXLHzqO2zhb7B391i7iknLlyNS9KOdOUrLU1N2QGe7bUG8bpfnJNuWNGHtwI9llRQ9kQx59lIcvS/ioXsUGhAWbwMlrmOj3iHqCp4ZASwKX+qqZWQ1+Ht8lV7UkAFfN1zRbhu0SdmYMUobcTf/jIITBPBvFyf1JogubUluvoKAB0QMOc/Hn2Twbz/SMNvN7W1DDXE5aaFgl6xVRsttxm3cH4DxvBPg+V42zflySb576/OxzbnF+l87tTPWkGdLeqfA2UqCr4zmj5EMqIZI92l56+w6gU72mrvvECUz1xM9imXq4XXn9PWGxnmKiZHDG/vd2xeJqI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hkmJz9avTqjzM4jC6iaN1IUURdkzGa4A2wj9bGWS4bKWakpXKjXzdnfWCCnO?=
 =?us-ascii?Q?z2A+SCut9v8Xmqso/8BsASjXR1q8diHTLenrLZ/JmHy2g3b80eKN6kexB8tT?=
 =?us-ascii?Q?U514HARddbL2o4t0sQVpUCYdtNjtOrSTzNjWlfgXsLeGpxIN66jhYyUtvx7B?=
 =?us-ascii?Q?VmVHh4SIEUiRGBQ7/PNFmNjcOwUe37qZ4zMS4BbvPFkrsJTk23o/R249N2Dc?=
 =?us-ascii?Q?Ffe+O1eQHR1zJOcffoA28TJ37yfcmxhbncImVoCJBVHhZ1SJCAsElO54Zr01?=
 =?us-ascii?Q?Cxx3UigEpdo7ZT1ycDX49LmZ7oqTQsWFfVcZPXkfjkc84kp+S8AhPkH7YE50?=
 =?us-ascii?Q?9kI/aD2UG+JRmrZO5bpN6xZrlAToipUj3GUw291qpYj5oFgAMJ8+tYEZUwDQ?=
 =?us-ascii?Q?LR9hgPN2KRhxP1vCEuDupcc8lXWBeoVRLGw5WL3IxGb2YsuNND3AQxamdkRm?=
 =?us-ascii?Q?zINSI3v83tlSvXS1wof1+NVyY1mm2ZFCeps0ouMswAXYe3yMmmTscrgrKQP/?=
 =?us-ascii?Q?dsDSi1wQBL8xe6gbAvivQwovSHGg0vHgj3WQHCZwh1dbrfkpQQCxAQ2kIXiM?=
 =?us-ascii?Q?BnZ2J2oavHik77JQwYCSGFrV8M2JN0zxO2lDd49d7jcTjJBP0UoxPZhitiL4?=
 =?us-ascii?Q?Dwkrlxc/CrIizkf7ki+hdL9qaCaL3p/zv+UyIE2CILivEyec3A9YdEMClmBg?=
 =?us-ascii?Q?LJqw8Xr8+njNs74Kk76cqNDCvb2H9BFH4BQBfNRJq4YGeUT51N4tdh7ScDyf?=
 =?us-ascii?Q?mwokZI71RHN8k94kUMQBmRNXLcvqyKmOsUdIMR610Vh5vT92HoFpavMRH3GT?=
 =?us-ascii?Q?z3o2N2k3uM2GzUXFHrSvUvR8Fm5PuATLhX6oGu0cMub3A5UZyIcSImrFJ2+n?=
 =?us-ascii?Q?26UZDVfL0pTBCHx9OUvl+1SLqolL+3JMhMCS02VEGfzezCtZwAukdP/KsatV?=
 =?us-ascii?Q?SNPNWm7jCTVn/PZhZA51aojekKNE0Gt4GXO6qNNMZVvHUKTPUEYinzhVXDUT?=
 =?us-ascii?Q?xTHYrVulDFnBxWpVXIUWg+gUlE9/yO8own7QaIzbZd2vk+iBflz5Tshz3eY/?=
 =?us-ascii?Q?qSseYPtH3zoG/dwSWPsqq+26E3NVU5VUnpm96hdXK3qiOcV042qjpvGYUa2M?=
 =?us-ascii?Q?L6TXvTG5EnjxKIfHE9SfjPzAyfcCE89rEEvBLC3q1R7T5v5M4MSppFQvRsI5?=
 =?us-ascii?Q?QuyfGcBd03iQUGP93K/LUzuz/3hLxuU/EKFSuiw4LkLzt9BOAJ4tl0ayNVpx?=
 =?us-ascii?Q?9FemtWuw+rN9AbMaOl3VtCfckC8/k5Pb8/qaSXFh8YK0TlD0RV3x3RjGZSYA?=
 =?us-ascii?Q?KUjI7nFfwarPCl4GsBX5n6DsWZFMA2brX0ztzvoryeHW+imkzN+6/ASDFlwJ?=
 =?us-ascii?Q?2M8T0ZDNF1+vE4puTPpLcELXzUtVXMVhT0j2ZmzcY8TNMY7k6qtCi5dOkyzQ?=
 =?us-ascii?Q?aO9nwCmUzuighO5clhPRFf2lIkWB/GrdoU97ieOYA55tgoB6JJWccWE+E2eQ?=
 =?us-ascii?Q?Jalzd7m/UvNFIMjbQasKYyYTG6zfO/eAMjujH8HGAk9gDmhCc/ppwwBoidaR?=
 =?us-ascii?Q?lJ+KpNySaIMha7whgqCrGl5je0UBBU6O6cpIjGd4dWUIwOFqfE7ovNg7k1P/?=
 =?us-ascii?Q?2H5bUgUg87301dcIpkzqZfvEMXMD1i60Ot8ynCdlyyoLxGtHAs8Btvb4V/Gk?=
 =?us-ascii?Q?Q382YRg9u+9xuzdgQ08VgQ91lPt0jkquRRGrwlzdu3JnMl5nLU8obqxgZlwQ?=
 =?us-ascii?Q?Q2WL6LgPMT/hAdWaNyK24QXSVCbDWA0=3D?=
X-Exchange-RoutingPolicyChecked: qa1ylCTcwCC5Y588gzq/omwa6L62zd9wdl11032SR2dgQblbaZbFVhQQ8P1qEgDAIsaoiYrVkjvo59oxb9IUsTmZdAhEassK6U615tn90OnkSkxsiJRmMuMgAAilKko+XxE6/hSSgE8wjtMhlBUln6QvIfEMenUSlPfSLfjMfemKUZ12NoCTaS3ibrClhgA87EFEU9N7ME5g9wBp8X4Lri00Jhd1i2hQ9Cla/2ywmOy86KnOUCaLngEVSkOsZPIbT9PPM9dGcc5+Qc5FiCmcm32ak4TITCh8s6IpcgQIOmcx4hau0ojZq3tKtwO4k153qwCflnIoBp7iAr3lgtz/jQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d82c251b-5b15-4ff6-1503-08df157ab077
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 11:48:00.3028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W/Dxty2UddslU07LVoK193/wMWKvG2Qeb7xNHEBF+LwV8G79BKRezlFSiMbQfxVXQ54oL80hbkT1/+ceMjFeoAeln9xXKg1PFRltK/HRLEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8570
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

On Fri, Sep 18, 2026 at 12:40:10PM +0100, Bruce Richardson wrote:
> On Mon, Sep 14, 2026 at 09:38:36PM +0800, Zhang Tengfei wrote:
> > ixgbe_flow_create() programs ntuple, ethertype, SYN, FDIR, L2 tunnel and
> > RSS filters into hardware before allocating the software flow object.
> > If that allocation fails, create returns an error but leaves the
> > hardware filter installed. The application has no handle to destroy it.
> > 
> > Allocate the software copy first, then program the hardware. On a
> > programming failure, free the copy. Set ENOMEM when allocation fails
> > so the error path does not report success.
> > 
> > L2 tunnel add failures now return immediately instead of falling
> > through to RSS parsing, which cannot succeed for a VF/PF E-tag rule
> > and overwrote the original error.
> > 
> > Fixes: 72c135a89f80 ("net/ixgbe: create consistent filter")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>
> > ---
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> This patch needs rebase though. The memcpy calls in the driver have been
> replaced by struct assignments. Will try updating on apply.
> 
Patch applied to dpdk-next-net-intel.

Thanks,
/Bruce
