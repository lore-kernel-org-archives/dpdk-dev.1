Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C60CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Oct 2025 08:40:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3240C406BA;
	Thu,  2 Oct 2025 10:40:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 7557D400D6
 for <dev@dpdk.org>; Thu,  2 Oct 2025 10:40:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759394444; x=1790930444;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=2K3b1FNDDY0pkAfIvCITTkbU92axqNIBf1xVlZRwV1M=;
 b=KhJrvsxGxToDNke0J7k+n6BNgZYG4MZW9x3oiBzoMAzYYM3fHCZjTowT
 1oQ7I0BY2qdS3l/2I7piXmBGKmGqkzOdaMjrD3/+mYoVFHcTmpVC3sWEO
 /niSRiE4Qb55cXrYUIVwzhYkxjaOvscnl5q3UqaGjG7OFHTvSy+XCId1d
 Cmn+JYNaUuBeJiY38CvgzjmAa3nBWFpDRLrVZnJcZrBmJmvoHEyTFGj0Z
 kPYKhPZ0IFJtTC16hHlsVlH01d9EUSYQz4U4wQOMacRTqhYjLo1o/vc0v
 VqMoDsT85Y7ZdNjlmFZ94cS1Ug3lE6U40BU9zDW6r2JQEJApypmsGe97D g==;
X-CSE-ConnectionGUID: q4v+lr3/TzWNV4pg5UQ2xw==
X-CSE-MsgGUID: d9M+QrjAQBGqtFOXArtVrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="73105685"
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; d="scan'208";a="73105685"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2025 01:40:43 -0700
X-CSE-ConnectionGUID: F3/lVUqXRqSClPXpD03uBw==
X-CSE-MsgGUID: ZZf+6eExQF+nmpNtiHXvQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; d="scan'208";a="183403883"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2025 01:40:45 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 2 Oct 2025 01:40:44 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 2 Oct 2025 01:40:44 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.70) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 2 Oct 2025 01:40:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/A+ErLG00y9HzGgm2/1cnFVqzAWqbkqP9bSEtFnFkdVhYWmo3mqxURIOK81oZDWeyUoGnz0ZTSnphwadicW9/D/zxAqg8Cx6yiGYZKDwss5semLzlnd2r5YImksgc5mLmrvvTGbvIxijdLNpe2tPuGmsC2CFow0Wttx8BXRW1w6KieuBtJqWBN8y0//1pOrSLad8Ne2FqFp2KAnrH0bdWYt1neic754LZ6skVCv2nqLBor+htbL7qXmXylAOxdGiZw7Qxlj5LPqZJ6V2hHgBJiprxAB7jfBZM2TeVTMAZOoQNBqNsbpuW5Rdf6dRDqRekF8pcrl2EcZ8vCguyEIIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxKF2pJo0b/t4wM+H0F7Jl8jUqAFh8JWHRAL9xOP3uI=;
 b=k5oso7+7Qpdy+ALnu4SoySHObE0FkqNHa7h3p6idxLy1iBM2BZaryeH+SyT6zwzMhYH3Chhgq3Ss2E4wDzXG8cEpxQw7nOZ5cMKOh1wBlWVaaK3A5cMqpkrHo4FViPmoRS2Szsm//XSz1U2Lmrwr4vi76GAx4nmfIKkCoQgvqpsj37b9vg2uej3vKMWdwndJreQOgKSQ+re5ssE/sEvZ4D2ACFGT2tHkWAuMDPIhQBq2h/d3jxFJS3GqUvhTeTNsPe9JMAjgdbQ/+dX0LHQmPnDp0hurPNIuIFqGFjdqNt76767ztMKWYUAhxAz2btKY9PlxI0YNH5cr4wug+YwEpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH0PR11MB8234.namprd11.prod.outlook.com (2603:10b6:610:190::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 08:40:38 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 08:40:38 +0000
Date: Thu, 2 Oct 2025 09:40:33 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Kai Ji <kai.ji@intel.com>, <dev@dpdk.org>, <stephen@networkplumber.org>,
 <gakhil@marvell.com>, <konstantin.ananyev@huawei.com>, <thomas@monjalon.net>
Subject: Re: [dpdk-dev v5 1/2] eal: introduce rte_timingsafe_memcmp() based
 on OpenBSD API
Message-ID: <aN46gRTE_aEISRYc@bricha3-mobl1.ger.corp.intel.com>
References: <20250929145049.153078-1-kai.ji@intel.com>
 <20251001153242.55987-1-kai.ji@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6548B@smartserver.smartshare.dk>
 <aN4zVGzxTDI5Ch8g@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65491@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65491@smartserver.smartshare.dk>
X-ClientProxiedBy: DU7P194CA0030.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH0PR11MB8234:EE_
X-MS-Office365-Filtering-Correlation-Id: b8150f3a-209a-4770-052b-08de018f5cc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?2Dv0DXnXsGJjAP3r9AVSzAP+nLpZehaiGKT4+aOUe7E2A+55gMFT4eCPBv?=
 =?iso-8859-1?Q?09o+iNQPw9M5Lpb/jiP4ZDToAkAst7nnWYCJUHuwB1uEQnVwjDYGecXS/Z?=
 =?iso-8859-1?Q?p+nOAoMNjsC2iD1KNg2W/ymBDFbTGbsCp0jsumMbdNcGpjMKvXmHhIYH0k?=
 =?iso-8859-1?Q?3OWEdztUkvbunCrjv2tvhC5B06y8jomk0VHQaB5vY8N/vEu8hEljppSiIp?=
 =?iso-8859-1?Q?pSw/C3WvXC7JpVJWTF86kIXVljrPi5tcmS6MQe1SOYcjykTSbeikl/XJEo?=
 =?iso-8859-1?Q?yTxXSDZmhQat0Ir+EYw5VwaWi0ouRE/yk2IjKSBBZBkwVTiiWdsouXMC1Y?=
 =?iso-8859-1?Q?++p9OafyJnenwMz17Y8MG9TM011/ZtEGIhugGnwDce2nrvy3AaAE0r5dkD?=
 =?iso-8859-1?Q?Hsekb6iDNk189TAw/YDoDClajbvZLNnHj0JGWXvr+RL/bpmcRsJRlD+/Zy?=
 =?iso-8859-1?Q?PucrgOxPOEmsFkkacTEbCY7EMOXzOagGooK3O58EvSyqVO21dUGPdRFfr1?=
 =?iso-8859-1?Q?bIP+mBNhxbFoWSSlSw0UrdY8ahVfOoeIZi0aBdTcuYiqYKHz/4mml0xmQV?=
 =?iso-8859-1?Q?jXWg5eadUZsA5S8bqcYqugwVZgCafiiZK7+tNIKpPV7cmPRYtTE9mQ9Ta3?=
 =?iso-8859-1?Q?atDQQ5uuVp4cN3ATBumAWOc6qa57gS2o3j90L78Dh2U73JP7+uEBjxfIgl?=
 =?iso-8859-1?Q?nOghJw5mXe3j1naI7K/weIi0Goo8+Kw5sN1sw4ixTZ83PCtGkbLocWJpEX?=
 =?iso-8859-1?Q?oIqVou+hjBT7pALX2G9kP6aC76+4vVWXSiXkgr4f/mxvhhfb2aSaYLEOHE?=
 =?iso-8859-1?Q?GrY5h+uk5PJhJI1jpdPH9cMJBDuI2DHOSMHFgDdYFE+Nec3Ah/r45UBVzE?=
 =?iso-8859-1?Q?gwPEjzViqnzpbk6ZCmvINmpnY6EbSw2zUT2lm+4L/NwvBCPm82qHg9QD/U?=
 =?iso-8859-1?Q?n1ASGEEOcg515y3V56zTCasEjBVSMiGE+xJdk5DktzdPAJnCLeqpqGh3XN?=
 =?iso-8859-1?Q?mNfq5gP1YilOPaY5nUZghMgVyoObbrjC1bFzRUWuevtlAwJcvbwv6vmwSo?=
 =?iso-8859-1?Q?8fg+VvHj6f9l1Pz2yqIolFwv5JEQV6AXEVomg74y+MYhFj9qNX8kR30JpJ?=
 =?iso-8859-1?Q?k5Y1PvcVoeXQ7GGZS3rugpF2Dxky7zl39Sfrs/PSd22Ujnzol4153TjsS3?=
 =?iso-8859-1?Q?3jh8DFheoZ5X/+OfI6RQFjqXWYTVooEfLolf5qefiTp8m9ombi5v7P2i7R?=
 =?iso-8859-1?Q?JTeTeqszV7Tx5XZHJnU6lFnO06jp8WAkbTjUvbqGuABg5pzjnmbYKltm7x?=
 =?iso-8859-1?Q?g7WPR3ShBTrmBX4DN/L04ju79YQ1qT6weFQhFfjfHXeQZBC1O7IoQli44y?=
 =?iso-8859-1?Q?gF7KXSsx0AmbmHy0G/INXMUxxa+BAIAuWcJA95+z9bocQ3vVwDz51MyCSq?=
 =?iso-8859-1?Q?FrvBeyyDOnEs7p62Atarcc71MfdWmoHWPbwnIg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?fRri67F8gUki3tvvtJpo9vLf4beWAg5BhrfO80flwy0nUXvdQS0JNml9qs?=
 =?iso-8859-1?Q?webaTHceYPckIW77kpWzty+AkmkeiIELC4v+QLlDW5OMk/1M+3Bh7e6tsS?=
 =?iso-8859-1?Q?GaLabAETO5dsXRJeg/FO+KdPHz2BHKG8F3r5pgHabYx4J1NKWMo7JQ94Z6?=
 =?iso-8859-1?Q?2jGWX+DV8papF4y8USLYRTqTbW592zaJs/VX5dl7QV2iUwzOiKgrTJxjYg?=
 =?iso-8859-1?Q?1amPEHF93j9b2m+vbPh0WBSF+X/7BhrDSTHo4Ew6j3ZjOlP5SFhifxQcKy?=
 =?iso-8859-1?Q?OWTcGL6FnVA0CWjORbmBjGczPK6UK+1vapyXdyyb51Lp2CL4vpJ4DhBtAQ?=
 =?iso-8859-1?Q?ls9Dll6ssPtIVXE7K/2fae8Q1qzl2PhOEtUQcgUvpkI3CyNkc8RJtdOiQ+?=
 =?iso-8859-1?Q?K51fs6LNgrvGsboU6hWL6drPIIR+7JQEYczh0LRKh1ef0AKFIa8HIskqwX?=
 =?iso-8859-1?Q?g9faITSkaAarlVHOVkivX4R92mAr8nip0ef3Hs9vBMMPCm4vNB4MnBH6ru?=
 =?iso-8859-1?Q?jZ9o0o3/pYx0yxPF6ilZijdyTgKKQhJ6FVAWINjaCly0zT8G26/XrWj1gX?=
 =?iso-8859-1?Q?Qj66kGu0F1TR5ItN4YjqYZMrLn3N6n3KjRc/BTUYvwyBJm6iD9pjIEsuvB?=
 =?iso-8859-1?Q?IphZtEUtY5bemsG3NLlArmVd0k+AMfcXZqoqumDdyzmqI1Y63IsKq4xq2p?=
 =?iso-8859-1?Q?R7+7NzI6oi5HQraHUo8ezY/t7dnRj+BLq3C6DP55cFewjqh6Su7A4sHH+d?=
 =?iso-8859-1?Q?bO8QJc2o+KJhj+jUIU1lS8g3dEHxMQry5ku4iR/WcEWu90JLNGMKBlqUoj?=
 =?iso-8859-1?Q?i7h7I4enhzhaElgbCN7tIZgUzkjCVfPQvBSI+ef/Yn9578dq1dOXX0JiRo?=
 =?iso-8859-1?Q?YeI7XLMFru1bOs0DcaF/+FgTCgwUJdGuRVkGfZvSJT6esUqmGa1zyaNeTp?=
 =?iso-8859-1?Q?EuLUWstxh7k269yzxfq4PCsNDP4oQphK6ogFGas+AzTzx9vl/RNaGtYQ9n?=
 =?iso-8859-1?Q?yufmoIl6cgHPpvqI8ui1tXz8qVI1wctsyK9Z946pEL88f81O9YXNSum2pX?=
 =?iso-8859-1?Q?23lbNm1ytZcTL/2pm2SgIHjmNPt8DNuBx30sYxoAPfJKSISmiS+SA1QXEa?=
 =?iso-8859-1?Q?aD4K6ErTFCrZjMhUOmqBc5ErHfB2ONF9QzyA8UD4N7IYhB691PyOYkOpWW?=
 =?iso-8859-1?Q?nt/9kDW1A6v2H9/2YP0J7xDieJoczxzdO7lBrODaeesH+YRxXIhHOh3Wlh?=
 =?iso-8859-1?Q?bcxgMPHIOURcvIRs+du4QVEe1tRzRvB4p5z2H9UOMuFkjSbK6OK9xOH0jP?=
 =?iso-8859-1?Q?E2l17uiLx9PnyY80h7HLqo7JPHNSnBROFjUzbUcBn83l4UKQIH+6DBEqAA?=
 =?iso-8859-1?Q?l4rsEJQS1lnn8+MFXicfFkzWtQn6O4XsKEcObztBH4rjmflPgl46yK2VXF?=
 =?iso-8859-1?Q?S8hbE6vuG6iVuKx+ddRsz7vSM3m5RE9zW5xxIEgZJ+JNNfnN05OtMXy+z/?=
 =?iso-8859-1?Q?PmxGHodZxrZ+IZkSDfpi+DDN8/7uG0iRb4Q2K6AzVnClDBytBTtOZfPH5x?=
 =?iso-8859-1?Q?BwykHx0A0JVDg0FOZq5gt1ge5Lsi0kHSfD13RoxL45DSQCWkl2qVPb/l2z?=
 =?iso-8859-1?Q?PGuy+axYJD4hbedwDc12PBinaaBMsLQugfgW/5P+vC31S7KOQ/WbT84g?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b8150f3a-209a-4770-052b-08de018f5cc3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 08:40:38.3343 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nYgyNOA0/S/KFAJD+rAD5m/KFQk0vsyI/NDwTpzugqYKhKRc/zDQZFgJKQJfjdQS48EsAJEIi4MojpH/86vUGGw8WDqyKF9yUfSdo2mGRfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8234
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

On Thu, Oct 02, 2025 at 10:37:09AM +0200, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Thursday, 2 October 2025 10.10
> > 
> > On Wed, Oct 01, 2025 at 08:57:02PM +0200, Morten Brørup wrote:
> > > > From: Kai Ji [mailto:kai.ji@intel.com]
> > > > Sent: Wednesday, 1 October 2025 17.33
> > > >
> > > > Bugzilla ID: 1773
> > > > https://bugs.dpdk.org/show_bug.cgi?id=1773
> > > >
> > > > Signed-off-by: Kai Ji <kai.ji@intel.com>
> > > > ---
> > > >  lib/eal/include/rte_memory.h | 38
> > ++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 38 insertions(+)
> > > >
> > > > diff --git a/lib/eal/include/rte_memory.h
> > > > b/lib/eal/include/rte_memory.h
> > > > index dcc0e69cfe..6939c1caad 100644
> > > > --- a/lib/eal/include/rte_memory.h
> > > > +++ b/lib/eal/include/rte_memory.h
> > > > @@ -746,6 +746,44 @@ __rte_experimental
> > > >  void
> > > >  rte_memzero_explicit(void *dst, size_t sz);
> > > >
> > > > +/**
> > > > + * @warning
> > > > + * @b EXPERIMENTAL: this API may change without prior notice.
> > > > + *
> > > > + * Constant-time memory comparison.
> > > > + *
> > > > + * This function compares two memory regions in constant time,
> > making
> > > > it
> > > > + * resistant to timing side-channel attacks. The execution time
> > > > depends only
> > > > + * on the length parameter, not on the actual data values being
> > > > compared.
> > > > + *
> > > > + * This is particularly important for cryptographic operations
> > where
> > > > timing
> > > > + * differences could leak information about secret keys,
> > passwords, or
> > > > other
> > > > + * sensitive data.
> > > > + *
> > > > + * @param a
> > > > + *   Pointer to the first memory region to compare
> > > > + * @param b
> > > > + *   Pointer to the second memory region to compare
> > > > + * @param n
> > > > + *   Number of bytes to compare
> > > > + * @return
> > > > + *   0 if the memory regions are identical, non-zero if they
> > differ
> > > > + */
> > > > +__rte_experimental
> > > > +static inline int
> > > > +rte_timingsafe_memcmp(const void *a, const void *b, size_t n)
> > > > +{
> > > > +	const volatile uint8_t *pa = (const volatile uint8_t *)a;
> > > > +	const volatile uint8_t *pb = (const volatile uint8_t *)b;
> > > > +	uint8_t result = 0;
> > > > +	size_t i;
> > > > +
> > > > +	for (i = 0; i < n; i++)
> > > > +		result |= pa[i] ^ pb[i];
> > > > +
> > > > +	return result;
> > > > +}
> > > > +
> > > >  #ifdef __cplusplus
> > > >  }
> > > >  #endif
> > > > --
> > > > 2.34.1
> > >
> > > NAK.
> > > This returns (binary) non-equality only. It does not return (tri-
> > state) <0, 0, or >0, so it's not like memcmp or FreeBSD
> > timingsafe_memcmp.
> > >
> > > Also, please put the function ("memeq") first in the name, and then
> > the extra property ("timingsafe") last, like rte_memzero_explicit.
> > > Like this:
> > > __rte_experimental
> > > static inline bool
> > > rte_memeq_timingsafe(const void *a, const void *b, size_t n)
> > > {
> > > 	const volatile uint8_t *pa = (const volatile uint8_t *)a;
> > > 	const volatile uint8_t *pb = (const volatile uint8_t *)b;
> > > 	uint8_t result = 0;
> > > 	size_t i;
> > >
> > > 	for (i = 0; i < n; i++)
> > > 		result |= pa[i] ^ pb[i];
> > >
> > > 	return result == UINT8_C(0);
> > > }
> > >
> > > Stephen, agree?
> > >
> > 
> > Not sure I agree with you on the naming. I'd rather see us adopt the
> > BSD
> > function (present on multiple BSDs) rather than rolling our own
> > completely
> > new function with new behaviour.
> 
> I don't see any use for timing safe greater/less than comparison, only equality comparison.
> So I assume you are referring to NetBSD's consttime_memequal()?
> 
> Regarding the name of the function, I prefer consistent naming across DPDK, rather than aligning the names of a few functions that happen to exist in BSD with their names there.
> What happens when BSD introduces functions that already exist in DPDK?
> Should we rename rte_memzero_explicit() to rte_explicit_bzero() to align with BSD?
> 
> I prefer rte_memeq_timingsafe() or rte_memeq_consttime(), but will not object to rte_consttime_memequal().
> 
Ok, point taken.
