Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07700D38FE6
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 16:36:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E33284060A;
	Wed, 14 Jan 2026 17:36:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 3802E4027D;
 Wed, 14 Jan 2026 17:36:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768408600; x=1799944600;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=Snc1PvOW1FYoPqFAWhu/gol07pidyDCGC2moCiWqxrA=;
 b=aysmKw6WlHrL86KVNnVnuUHd9GOn86u6mTb4edSp77ZRHYY3JaDDnVPy
 QnTBPncg8iQ6c6OIZhZEKPmJB+0AkMDR7nwYuMqvUIenp5w32WG4mSmv5
 SWA0pQn7VNrBOhbLPH2BeIilkmCtnLW87sL5DSJsEc0AmrroH92l4lfmr
 WQq8HgLIUqKC42y0FrNZszwyn9Xr8XV49Dr40vJkmgDZSTOKTV0Q4K33B
 hEE/cSQ4Vt363sU972/Xjomw1D7zdm7oOcM3Pdv14nyhtFRJIdstoTUyG
 yKEPkKcSp2zrJXJXU4YqYMde3VYA1aGCe4p3x86ncqRnjwnMSgW5URMAd w==;
X-CSE-ConnectionGUID: A6lSe3+zT9C8gRxaGGQkwQ==
X-CSE-MsgGUID: w+mvoZWUTdWAQBTypuj3DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="81075404"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="81075404"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 08:36:39 -0800
X-CSE-ConnectionGUID: bjBkA6gvTTyNSaCheFXz4A==
X-CSE-MsgGUID: rKxkt3krR8+ym7YE7cWOWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="204510086"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 08:36:39 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 14 Jan 2026 08:36:38 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 14 Jan 2026 08:36:38 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.1) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 14 Jan 2026 08:36:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hzkan6GPrrq2+zvX36NpuQFJTOEfhbqfnxpyJwySC/oywLkkMz43FlxmJFcT4sHYCFWrHah1e5tQnY9q2fQFGYo7R651iGpYg323zjbNopCW0+USBjOuqXrPWsYB+grg0GcANxU4qLzGpuJ/wEbNMBWpJxoYxTSNr/UwTJBXYpxU0HODKmhNdepccI7h0oUFBW3slpP0MtwRAKkkiVnBRHgvMZrTeRlg0QNi0pYMTQi67STVrRycDe4ffTA40+d6Ccf/RTKEXJCLpS7+TT5cdxuAgx05RAganfFzMRZDLhMplAKUI1Hp2yMpPVg6mm69F/lJe281S+zbHhHaypWYgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQWV3rU03vgaSP0pXpwqL+BagOV88HXUBGspn0XeaPA=;
 b=sLgZpJShgiDKPMeU4oNr9/veI0c6T6Je561KZtSIET37x9jf0jQJkL1GGqYEo49YpzD1zOKYEe20QMaYP99qIR4n7gTREKikPeP30PSbKV031zFW21i6Q8tKZNqyXEYwMd75+3jaw5AwNY1Z4t8W7gvX/X1NqTgN26NXyvRd6Mz1zT0atY0bHKn0s6Kz6kMH03qUN4bOSr0LeNNAH2s03oZcOSxDJOI81AQbC9ty+f7V7JPlY9bCBNLFjh57uyc1Jaz2MuUWT0LTyMczmGB1x6wvT5/HOqBD0+/qfu0gG8UxyU7RUAaIe/5xOXNfolwQFwk32qpp/5dLs66PDek3cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA2PR11MB5100.namprd11.prod.outlook.com (2603:10b6:806:119::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 16:36:31 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 16:36:31 +0000
Date: Wed, 14 Jan 2026 16:36:26 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>, <techboard@dpdk.org>, 
 <dev@dpdk.org>
Subject: Re: mbuf fast-free requirements analysis
Message-ID: <aWfGCglFfkpOAxgh@bricha3-mobl1.ger.corp.intel.com>
References: <98CBD80474FA8B44BF855DF32C47DC35F655E0@smartserver.smartshare.dk>
 <aT_1J0If92bxkLG0@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6565B@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6565B@smartserver.smartshare.dk>
X-ClientProxiedBy: DUZPR01CA0250.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::6) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA2PR11MB5100:EE_
X-MS-Office365-Filtering-Correlation-Id: 748281b7-ab13-4193-e195-08de538b1279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?MkEZIx4Cv2Zv6PeCs8bB/rRu/yXZENk9i3HaZH0kg7JyrG4+uKQLvhCUs3?=
 =?iso-8859-1?Q?mY6MdmuvLtcOOBmXDL1rBBZuatIzyP+wn6Ed06Ry+5RC8XauOXCF7ZZMuZ?=
 =?iso-8859-1?Q?WjHBywIlk7ddpIJpcHcU0f80Ui8k7wnB58z3g14xoJUWWAsOToJKcvUEWy?=
 =?iso-8859-1?Q?L9BEcgv6UAGZ7zUFh7fjy+ILOAdcIe5DzXfsqL7TgVIzdDB/NKnHr16i/f?=
 =?iso-8859-1?Q?qTO9h3gQ9IvpmoCtQfup3U83+6kh0onr5K2plPD+zL7AbsTg34C8JFsuQS?=
 =?iso-8859-1?Q?MsJ/e8Zv5dlJrkrDwzGa2cguZXP00bKqL5o+ev8qJeqIQIB5LTtsYP6jZE?=
 =?iso-8859-1?Q?9z0rvvaYN2PEet7Dk4ONm8LOPmuiLIXslhQQz5TVDKjxoiuJwwwdKsqjqc?=
 =?iso-8859-1?Q?NlIkgysKxUMXKSevTvhcb81ST60Xz5bKt4xU04L2ShmfLbdJw5EPw/O6Sq?=
 =?iso-8859-1?Q?0aSKxMHkWrgHabHBt0Ug/dDZslEIZXzNMGvWt9QMVGMGYxEXw7rF0gO6jN?=
 =?iso-8859-1?Q?KBl9u3+EUfqbvnHRL+LK5xJpzOh9uamOmJk5+VPGBp6/suYz7n6ENyXHZy?=
 =?iso-8859-1?Q?9MeajZvYAVTspECBVuaNtBfsOnR0yWvcYrwCWkWgsucJ0wGs5xZOAjsAqk?=
 =?iso-8859-1?Q?kbHRIPsVSqiyqr0Kn5mhWd/3TCuZlaa3lK5P9Fyfc1Qp/TTCnRSqXITWEo?=
 =?iso-8859-1?Q?AeHOUgWMw5QPUlckHViw2ctRJKHphFnXqZXFlie7THPaLErHYP+PYSFQUX?=
 =?iso-8859-1?Q?eEJKUmuIGAuK9HDOfcDSst/ndyPXpSXu8iq/l8o3c/rzp5ax3PzSi0kQuq?=
 =?iso-8859-1?Q?6NCDZd0VHIz+TtWqk7T0wpadYXHFWF1yibfBTcOUWqcy3xM8/JLrlrz0Z4?=
 =?iso-8859-1?Q?hIPWvTRCRNwAiXwFeh0KHqpsORbyJBPcPPsyfXCKg93EujXjoyFUaBtqQV?=
 =?iso-8859-1?Q?WxTBKgW+KT0py0vYOpvIhc+RBnxYsTl1n3qp0JR90WZXDIDiwD3WsUaeqg?=
 =?iso-8859-1?Q?Palz0wKom48K4wbNNfVmChAZAkwn/nkmxVzNKzPWAI2UmPrWcb4vMUP94w?=
 =?iso-8859-1?Q?Iwmbg8A6++KsZMBk9RRkFvTNq6lHgOskXThotb7Rxp+YY6xaiYbf77ev5r?=
 =?iso-8859-1?Q?BMnZe4k0GCXYPM7bNkP62oQW6EVT5QlTTH6Deu8B9SbReWXRYRO3CpPXlW?=
 =?iso-8859-1?Q?pky/XHMZ7XFX3XXzv/RkRRsLlW58I/1/Otw2ZB1IvWdWY3vM0GQeBhs+TS?=
 =?iso-8859-1?Q?us3p07KCTOW3NP29OUSiUl2UqizBOG2G3QTRn0N1tt+DGXuc5NVSE8/qWv?=
 =?iso-8859-1?Q?UXmw0WqkOkT+VPSy2EI9VY8jwUp2X2C2tFHwBKxCC6jYwMgERqgyhWgj9P?=
 =?iso-8859-1?Q?/tuD+P22X3B6ei4YSAD8rholbtfmUYBsbwr5JgBtbsXs5w5GTtU739ION9?=
 =?iso-8859-1?Q?23bh0do08PoMAaMjETgZxVS45sqfm6CGEWpgpxENmOoB3Lr4BxuvEb3/fJ?=
 =?iso-8859-1?Q?30spxy+HDxjQRn/vpBJ9H2PZtiW7pJB+LaoFg/tdxHYnhzFPO2nYsWGqsP?=
 =?iso-8859-1?Q?NztXbj5w8c9Omh4OpWcbpP8msFIFle9pTaElRqW5Eh3PD8fHXAn72HO4BS?=
 =?iso-8859-1?Q?CvVePUApDqcvdARLgE8zZvk463V4ZSHE4w?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?wnay+EwYxdwwQkjPjQlxKpDPNTBuSUSLFL5zyC2wj2gAjKSSs3M/NIx5z0?=
 =?iso-8859-1?Q?/gdSB/wZrL8aBKziQqvPyVeOXwnuMYd6yNB4RXZ7CtUZpJ5dQe6gh8sTX0?=
 =?iso-8859-1?Q?AAqJD9kj++hpxmgjqhLLr/HhIfr00BXwOoOxTQyowv7IAMEdokrg+mxf15?=
 =?iso-8859-1?Q?a/9MWBz/PfBc50CCkLhXy9tHHvZm/qBChGaVpxBQ9+vs8wLPKojIh+yJSp?=
 =?iso-8859-1?Q?ClAXSNMwF0uIArcTSw8p/NKAAsO+JzXwznCn22AMtYMQImApbQ3vBgTuzP?=
 =?iso-8859-1?Q?XBCDjYJgdFNbLWFfS8tsNcoPzbDTu6AfGzQtk0taRkbM4yaiuWcWSVYpeC?=
 =?iso-8859-1?Q?nKg6bB1xG0IfDYDSAJxwRjqCXVl4kfAO66rshQ5WdrNiYJuWCqD1L1CrR8?=
 =?iso-8859-1?Q?FWJf5DIBeZTOxQiX8SOaPk8ZWNoOApgypY8Onf8vungE8ellkpy3q8uZVy?=
 =?iso-8859-1?Q?5wGuWF5M7p/q7CBLcByO9AYraRo15k05op32HMzRI9J8a0AB6DfEHeBGWz?=
 =?iso-8859-1?Q?yv+zhU6GBtf17ffIQVfce+9oHLLnfqYkCk7UVd0I0CijK6wU3nWuXuoQY9?=
 =?iso-8859-1?Q?eOStr5dkclDC8kDmaRkuJTKqFPJfzNs318DYtSkm4l6wBMqQLiS3XhwADQ?=
 =?iso-8859-1?Q?Fi4OAgTOjIy8Qjn/czud+UAGivXshhbnMXQh4zNPtKX2wUaVbEyceGaJod?=
 =?iso-8859-1?Q?k8zZkKbxjfHuDqBOnHtDeytg+v+86VRmBg2x7Jic+V1HAYJDxBtXNYuuda?=
 =?iso-8859-1?Q?0QPInfgusWVS2SGBB9l17+O78deeM5a7ox1D/viVwXNsJeuWqQj5O2PqTa?=
 =?iso-8859-1?Q?4iFubnO1FjU5tixvOT5sT8ydsLzkcI7eK0p8iWxG9rLb3ODgiMRkArjtsq?=
 =?iso-8859-1?Q?2NL32sPoQLB6Q5hLsL+T5HKXkBN0BEDYUxmz5RiSzgeuWLYnI+IEqbvihc?=
 =?iso-8859-1?Q?hZr2+WaV2jsdWFrlrt91eBHpyEPcX/tvG7E4uw59amOznUv9CI3mDJoeQE?=
 =?iso-8859-1?Q?AvVCBCZXqF4V7Uc63X8PI4JkZcQ/3i/xtQ0wvP4iM6A/2nhwjpBbZJpQj5?=
 =?iso-8859-1?Q?xHg8h1JeFdMjbEoPZbXmbpOfsFxHDwc0fS4JvDs7zM+VTR1TwbhCn0WGcc?=
 =?iso-8859-1?Q?d7uehWypGvXPUVgiY6XRNVbISLh+n0/3vTT6hAo4V05heZ+ak+ZV5dh0u8?=
 =?iso-8859-1?Q?644EipNzxBsvGsGSpv0hNfSL1ieOC0l2rKRwnbCmzAsEeG/coAlfYjPmMC?=
 =?iso-8859-1?Q?TF/BoN3A+sW57UZILixbGsOLYYUyit+Etpybz+NKPd9X9lkiEroOxqymz+?=
 =?iso-8859-1?Q?tpfvtFrejMWaz7jUlqM6XYi69a5C0rm/V608BvUd+N4vkt1k2zQYJqLFSQ?=
 =?iso-8859-1?Q?PjfsLEebJUblJus7nvqNh+LWdPDvLg+zlJxS9UBMURyY/5n2KDgPYUwIr/?=
 =?iso-8859-1?Q?FiiFf6bVXnhZWnRhr3VJl1glIDQHFEpbAnFxsDGThoowgc9aA/ZUku835E?=
 =?iso-8859-1?Q?QJYQbLbhe/wGYRWcQXF/Xs+APoDYHOVw5SyasrsFoWAb5KLpI7VOX62EYr?=
 =?iso-8859-1?Q?EFjNJmWUAvReeRPsNAI21mbff4ijQyAmiuzdZ/0abOcUSN022IhwudSoGy?=
 =?iso-8859-1?Q?7IkFo09QIm+H8akmH/b4FJOo5b+5TWhb5vjq2XMl26dH1ilWleW9gTEHsu?=
 =?iso-8859-1?Q?ZWuzwpnaLFq/p/kDY9rNWdp4TjXd0ysSeafnM9fB4MjGEHAf2Hynlj7u+i?=
 =?iso-8859-1?Q?lX+o5qscrHN9DAE5upjFbh6mSQpFgUbk/BGsRfNpRuF8Vaulu9G1ZTE8j3?=
 =?iso-8859-1?Q?4vshxcDUP1bfCjdo7Gvu6kUNMS4KpVk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 748281b7-ab13-4193-e195-08de538b1279
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:36:31.0755 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aFwTqQ2ric/xEIka/c6vvdL7E3dUCwBM8+lhc0kapSXVyAx7Aq6+1raT913H4vqhnuygmERDRu+flKQd8AzLF/AP0FLD28vhCUlRUg5ITVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5100
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

On Wed, Jan 14, 2026 at 04:31:31PM +0100, Morten Brørup wrote:
> > > If I'm not mistaken, the mbuf library is not a barrier for fast-
> > freeing
> > > segmented packet mbufs, and thus fast-free of jumbo frames is
> > possible.
> > >
> > > We need a driver developer to confirm that my suggested approach -
> > > resetting the mbuf fields, incl. 'm->nb_segs' and 'm->next', when
> > > preparing the Tx descriptor - is viable.
> > >
> > Excellent analysis, Morten. If I get a chance some time this release
> > cycle,
> > I will try implementing this change in our drivers, see if any
> > difference
> > is made.
> 
> Bruce,
> 
> Have you had a chance to look into the driver change requirements?
> If not, could you please try scratching the surface, to build a gut feeling.

I'll try and take a look this week. Juggling a few things at the moment, so
I had forgotten about this. Sorry.

More comments inline below.

/Bruce

> 
> I wonder if the vector implementations have strong requirements that packets are not segmented...
> 
> The i40 driver only sets "tx_simple_allowed" and "tx_vec_allowed" flags when MBUF_FAST_FREE is set:
> https://elixir.bootlin.com/dpdk/v25.11/source/drivers/net/intel/i40e/i40e_rxtx.c#L3502
>

Actually, it allows but does not require FAST_FREE. The check is just
verifying that the flags with everything *but* FAST_FREE masked out is the
same as the original flags, i.e. FAST_FREE is just ignored.
 
> And only when these two flags are set, it uses a vector Tx function:
> https://elixir.bootlin.com/dpdk/v25.11/source/drivers/net/intel/i40e/i40e_rxtx.c#L3550
> And a special Tx Prep function:
> https://elixir.bootlin.com/dpdk/v25.11/source/drivers/net/intel/i40e/i40e_rxtx.c#L3584
> Which fails if nb_segs != 1:
> https://elixir.bootlin.com/dpdk/v25.11/source/drivers/net/intel/i40e/i40e_rxtx.c#L1675
> 
> So currently it does.
> But does it need to?... That is the question.
> Paraphrasing:
> Can the Tx function only be vectorized when the code path doesn't have branches depending on the number of segments?
> If so, then this may be the main reason for not supporting segmented packets with FAST_FREE.
> 
> In that case, we cannot remove the single-segment requirement from FAST_FREE without sacrificing the performance boost from vectorizing.

No, based on what I state above, this should not be a blocker. The vector
paths do require us to guarantee only one segment per packet - without
additional context descriptors - so only one descriptor per packet
(generally, or always one + ctx, in one code-path case). FAST_FREE can be
used in conjunction with that but should not be a requirement. See [1]
where in vector cleanup we explicitly check for FAST_FREE.

Similarly for scalar code path, in my latest rework, I am attempting to
standardize the use of FAST_FREE optimizations even when we have a slightly
slower Tx path [2].

[1] https://github.com/DPDK/dpdk/blob/main/drivers/net/intel/common/tx.h
[2] https://patches.dpdk.org/project/dpdk/patch/20260113151505.1871271-31-bruce.richardson@intel.com/

> 
> But then we can proceed pursuing alternative optimizations, as suggested by Konstantin.
> 
> Here's another idea:
> The Tx function could pre-scan each Tx burst for multi-segment packets, to decide if the burst should be processed by the vector code path or a fallback code path (which can also handle multi-segment packets).
> 
> 
> -Morten
> 
