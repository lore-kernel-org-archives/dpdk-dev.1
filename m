Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBE3C71136
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 15:16:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFAE7402BC;
	Mon, 16 Jun 2025 17:16:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 1C8CF4021E
 for <dev@dpdk.org>; Mon, 16 Jun 2025 17:16:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750086988; x=1781622988;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=FcPs3Khf96vgfVSS8l40bL9iq1Tl2IM6HnwTIPzT8yo=;
 b=HPn207SFxi0Eun/5rgB64yElqAfLOOoDYR8OXOFoqtudzsvBpfSW5Xmy
 H7MbNDfL8oS9NWEpk/vDB9EGHq6GKo8QjbLw0veONQGU8WU4BtsyIrSC4
 d7NAUDDAKdIO/ZKd+LP9bliLoHY3EGWk4TeuRDsq8O+3WvtirnQnvHTpY
 4DVFe6waEuEPZSlaAujqPOldXw6DS3ovd6QYBZ7pZ1YqbVq7drnMhCdND
 w1cmcgiOl+O8eSGBr/7oW9EzidE8RLug8BA2/jm5eendLNw3bIDrcCesb
 UTGrLI/ivVBZ6cqgXZ1WQgSSCeudISleWXb7AK3TKUs0NqpFEOtREjajC A==;
X-CSE-ConnectionGUID: pLI1YPQvQ8uJiMAWRqB07Q==
X-CSE-MsgGUID: gAWpSOFvRL+q20KcMnC33A==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="51347539"
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; d="scan'208";a="51347539"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 08:16:26 -0700
X-CSE-ConnectionGUID: 6TMwE7gXQ7C77Z3r6pYKOw==
X-CSE-MsgGUID: Y7uKLo7NRzSln9ybtKSS3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; d="scan'208";a="148871083"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 08:16:26 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 08:16:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 16 Jun 2025 08:16:25 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.40)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 08:16:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AM2ZQPzeiypNkCY5e6xhcv3o5JPTbvtX5BNE3ZVwWWFgWr0vPJ9dwr1sUHxmHNx0vElj0Xt67b+tRI5DL4y/TdAk3B7Obs6fhppnytkphNJ1aVYuXh/dLf/Ss3A0D2BRmwXDFm7ESfCAWhQzchDCaA3ZDhdFTh40jkB7pFMNbjKcCOa1REyrP0iVvwqJyK9+zD12EGBt/2SWhCkxzXjR4ST4UwzqGRE3TSxJ/HcbCOIy9wUxyAsNQjhozxt4etPTAamCc5XxPy4sltMu0ZN7yvx+UCQ33ImahSX5q3hHa9XUSeBlo1mkoF4b4G49Hr+yiwJsx4ogIx20YgmVFBf/lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkjQIPFPcAPNhG+BCc5JbXOsjJoTluH2RjTQ0jj88fg=;
 b=AjUKmuXYv610S1r+fG1bVh5IpnGEh4jpBsl7rYPSRIndeEtwTo6my7UoJrgPBuNAsIIS1/TKxMKHzj7MK+bwMdXxxC0/1/KPVAuZn9O49HV96SsNmqBFJ3ngqnAFAFlUti2vk9uX63GVHaUxEYT2Ml7OnAXkAF0GV58WhCG3eEH4cCeQfBrlzQotluyQ6Lm2mwD3QONSWnrl+wTyb3Ui1HoIjNyTZFifeVC7jtgC4rCEKrlvOxDd+6nf/isZVeIofI76ImtOktVqxvWSD1YwtVuvU3FZ1hgIM3+x7CEXqFrtttgwVOxMjOaeIiJcBedFpIvup620d+XD3YCxu6lXBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB6613.namprd11.prod.outlook.com (2603:10b6:806:254::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 15:16:22 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 15:16:22 +0000
Date: Mon, 16 Jun 2025 16:16:16 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] buildtools: allow a different minimum meson version for
 Windows
Message-ID: <aFA1QIUz8-c98DHl@bricha3-mobl1.ger.corp.intel.com>
References: <1749831278-8286-1-git-send-email-andremue@linux.microsoft.com>
 <aE_Jf9p5HY17jc1M@bricha3-mobl1.ger.corp.intel.com>
 <aE_VVNiio9Ewz-h2@bricha3-mobl1.ger.corp.intel.com>
 <20250616150944.GA20062@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250616150944.GA20062@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-ClientProxiedBy: DB8P191CA0013.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::23) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB6613:EE_
X-MS-Office365-Filtering-Correlation-Id: 02fcbfcc-9730-4e13-e24b-08ddace8c06d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xlFCKFHay3wBcTk/pOqxL1/iQLR5DrCOk0FgHLEGmtgLUjU9YUBHRvtFNeQN?=
 =?us-ascii?Q?xuEG1FzTfd6kLLi1aRV6INbZ/AbpwYG5tc8qdMG/sBam0t1TGS/QX/yyX/m3?=
 =?us-ascii?Q?5LGNENS3Zu8rPUJWLRMMbZchajZGENavxbc032e2gXVuWlpRgHwpaVg+GWdg?=
 =?us-ascii?Q?slyaFLhTrWuMLKdkvgXQilB1LXvOpXbJra/YTpq6due8ebtCgesOFX/ERoWX?=
 =?us-ascii?Q?nzKtm4fikKvQSoGrHWQU5vheb2/6kaCIUdOdy/+Lkbgp7xbfmRqENLQjwc9Q?=
 =?us-ascii?Q?LXzC2Izyeudd5O4BQqgRNWQMtNy6xLf8tlQ80I+gZgK8Zd73XZ8R3P2QMS06?=
 =?us-ascii?Q?Nsa8oHzyt5HWwNtGxWN7axL0Pg7MGRtdDfsdlrW3T8dEbADFKOYFqQx9naai?=
 =?us-ascii?Q?qjkIcUiQhSH/wGKFxq/MfgIdCXRJVSKJBSYN0/bIhG4SZlU40fkMOeTwOOux?=
 =?us-ascii?Q?yFWXooakvKeMruxRKMc0fc60FLStMjQyA8dZdpKU+MCJYsdrewks4qDwWpJq?=
 =?us-ascii?Q?3C6iS3xDy7oZTnjX1YJADhHg4Paev0dzzlbRJVI02oVWmRn0eNgBJKzVARk8?=
 =?us-ascii?Q?OnUgSmygL9xqJWaAVndfhze5XoLZ5QzvY64NZxs7tuucZrnf920OLs9lcd3/?=
 =?us-ascii?Q?0XP9ch4rvrxB9zlWOBuAkmOtw19XGG9JhZC/Ad7iM6ccLqkPRh3qIfLGss0b?=
 =?us-ascii?Q?kSrvODPUYeSi1G7uYR+8T2qbJZx1/j57zHd6ZHaQsjJA40RlCR1xusKNpJnp?=
 =?us-ascii?Q?fSbglhCcev/9mgCUijShJVA38CfR8XMYUhjAwobsHcPW+pp+kVzrew1vwubf?=
 =?us-ascii?Q?Tti1NybS1XXQYq5K3IEfTu9MTkKGkyBAUF9PI3xutIpWT3loVVXMObFFjHY/?=
 =?us-ascii?Q?pNJz/Qd87arkI1RD5kTRG1ReOeFdin+MO3XHXCbekwVcb0rs5iJJnojdow8j?=
 =?us-ascii?Q?SpqJ5WtnbdusQ5ZYd6NT1TpEH89oujkoqPoqw8uPaSNEQOMQhtASJ6O0bN/P?=
 =?us-ascii?Q?WdJMfoz9lIKIsPpXdwX+SFPRFvq2AD5/dEMBxMdJtpyirimOttDfUGRVb8PV?=
 =?us-ascii?Q?WJnO+6o5w2vlNbd6/YrGn6b7NFPXpfuDtxAIixgTB3ogC94MzvRqnqsKE959?=
 =?us-ascii?Q?mCTbHYu+6/zcx7wGL8itL4dA170tev4FTytrC3gxyOfUe0uotf9jrkGVAetf?=
 =?us-ascii?Q?lxkjPQxM5hK0tOoqfLBHnnIMyidXk3q8yYutFfjFfWY6u4bYDR+1WecugBTD?=
 =?us-ascii?Q?cTFuSEUSu1ezHpWVe84fB+4BlRL9Whs+Y7SDihBiX85/O/ktNWk+gUYXShYr?=
 =?us-ascii?Q?BG7D1+VslfDpLIOH+2D00C5b+IJmzRMYXvWk7bhDpkyRmMu8o9RnYs1kB5zg?=
 =?us-ascii?Q?SxmUEGJl6f9dqo3U5PNSCLr4OlHjnklOoRcV6B3lxNWQwOh4TwIRHYKFe/49?=
 =?us-ascii?Q?hzNQ1++eieg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fyUljMcjnbGPimxNiYQlfV+ARrCoSGf/owjhZje3DYEgFHdbCNGl9xGjoI6D?=
 =?us-ascii?Q?ksq4eup3SEB8fQHLzOkpllJxSjY/dJeNDo/LSNj8HObgaWlt6OzXTx0KC/mO?=
 =?us-ascii?Q?quHMi+9ZZxvKPy6sgCCNEOtLglyPOnZ8PurPy41Uh8eCr5dpJOkvP5FuhanN?=
 =?us-ascii?Q?9OpAV9BdJHgK+WzFRbSIOyIlwVHlyDUFk0I9d3sMjXRp5B1B4HXPpSW/y0F1?=
 =?us-ascii?Q?uJbnlOW9vOO7cnPaYfj+33CIXv3bYBCkUd9IdY+G7hUpMQ/ww0Okjot47joC?=
 =?us-ascii?Q?Z3xe1UvKijbY4uw+HNE53a/2vr5z2px04PE1nd7MIb7TM27Ng6l7yY8ny6/T?=
 =?us-ascii?Q?lrd+cxTuXN9o9nYPhCIvrk4RF1EHFwwPbqL5aeffg8soqvIMfGWau+U8HA8b?=
 =?us-ascii?Q?CuDDcAYRk9wD9kFRJnXGlqN5lZ0DXd7wmlxCK5LFdijzHR9wrCq5/7jaqdmh?=
 =?us-ascii?Q?Sga5wWYbZvg/Msw1Ji5jgX6yxQAeY7HRWFtBMrKUZke+u6cP0FigQUMOMA3b?=
 =?us-ascii?Q?WnHPz9HQsCNaeCFkJIsGhUlhq+imhXJP8pwoWKmb/aZN4U/Ulgzky82XH9b2?=
 =?us-ascii?Q?SdL1umWMMLNiIhWz2F+aUeXgBiHs0cK2uGVj+JR9+Z56Nwr5abY3EYmU028S?=
 =?us-ascii?Q?R/ono+l5BA5VVXbDjIDoeR55gl+O83zY5gINFwNf95IDQdFXNFJU6WJeKQb0?=
 =?us-ascii?Q?HNXoPATHFmbycp2kpE4W/3EYyzGALVLCOcX5/unNe38kasaZtknclyoIoxOk?=
 =?us-ascii?Q?Mc6V7JsqPaBRcIng/ip/oPKf5RZLJ77+Bdq3g1JKcpsDKLQKH793i5gUXIrS?=
 =?us-ascii?Q?1dLfl+/1DgQqFoGbJBw5s9EajerS9fBrBaxW9ziOUrUnAd6EVXBrd6yOBkoR?=
 =?us-ascii?Q?0F8ko+F09U/FLIaPvA4LprNTXDuoIOFoOCCVP9ypjvvsQsbX5stjVWkIbdvJ?=
 =?us-ascii?Q?1bu3PND0mtj7nlO1X0paT8+D+4frqBcZx2hGCvu4CWkMtFQ3h7npy+C6NHCd?=
 =?us-ascii?Q?m4ruUWaJxPC+GN42tUVhc+0h8oREVfVyiSMqzKoDcgnyEX/eWJQuWpUsyKgL?=
 =?us-ascii?Q?DKdPxDV2WfClpZYWncPqcJ8nRgfEQ29dxg3pn3rzM/3GMlNqNFCc0u28PHfO?=
 =?us-ascii?Q?THF+OAJJKQwhy+E5J7GtU07UDPM7n22L2IZQmNKku2kENfry1iDodCLaR+AN?=
 =?us-ascii?Q?p90FV6VfMkW1XbBEi0iRpb1PWsznQJuMzsnxzGPEUV6ovuIIhaTA6tPipqKG?=
 =?us-ascii?Q?7Rz9uJfRP81x9OPLR5C+u53uZ1cluEavpt6E2mJs50hf37fA8YGNxnuZCgyx?=
 =?us-ascii?Q?xiWxL4hPdeU61oaBvbB2hWb3OTlG8iegwyKbppCeblOUeANFv7Ng9s/03UeQ?=
 =?us-ascii?Q?akzBy+aQhF8K44oMT4B9Ig/7X5RHjdEbojpoiS8emYerLxuBOQdbkSxwDau+?=
 =?us-ascii?Q?60VWnqg+4S8lqmyWmfvQD3FUjjpvWxFm0Pd9ei0FxMIcZuuJvdScxwtEpuh4?=
 =?us-ascii?Q?Bjj+hZgVkSaUIb8eD9pnTN9IwAyXmfYe5GK533V8kq8lWRZ6rSqLdBZ3eKB6?=
 =?us-ascii?Q?D+MmN1HvafEu3OYvhSx0QkB+G6Dxa3kdQQl+Am42kffb99QbeJFsex4rPa5c?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02fcbfcc-9730-4e13-e24b-08ddace8c06d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 15:16:21.9534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pz8AAOvLQU7WoEnk68rrK1z29Ue/OL2eMlPdeo1Ms/SZJCq62dycL+zNFhkZHX5xfmSHlbqP8EGB6u2bJa8hhUYEUS7FdOq0t9ATd74FrSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6613
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

On Mon, Jun 16, 2025 at 08:09:44AM -0700, Andre Muezerie wrote:
> On Mon, Jun 16, 2025 at 09:27:00AM +0100, Bruce Richardson wrote:
> > On Mon, Jun 16, 2025 at 08:36:31AM +0100, Bruce Richardson wrote:
> > > On Fri, Jun 13, 2025 at 09:14:38AM -0700, Andre Muezerie wrote:
> > > > There is a minimum meson version specified in the DPDK meson project
> > > > section, which has been documented. This string is parsed by
> > > > buildtools\get-min-meson-version.py and this information is used by
> > > > lab automation to install the corresponding meson package on the
> > > > build machine.
> > > > 
> > > > Turns out that the meson version specified on the DPDK project
> > > > (0.57.x) is buggy on Windows: it has issues related to path
> > > > manipulation, and these issues are causing failures. Therefore,
> > > > a newer meson is required on Windows.
> > > > 
> > > > To avoid bringing the minimum requirements up for all operating
> > > > systems before a more appropriate release, this patch implements
> > > > a mechanism allowing a different version to be specified for Windows.
> > > > 
> > > > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > > 
> > > I am fine with the principle, few comments inline below just on the
> > > specific implementation.
> > > 
> > > /Bruce
> > > 
> > > > ---
> > > >  buildtools/get-min-meson-version.py | 12 ++++++++++--
> > > >  meson.build                         |  9 +++++++++
> > > >  2 files changed, 19 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/buildtools/get-min-meson-version.py b/buildtools/get-min-meson-version.py
> > > > index f0de8fdf2b..10a2596a5a 100755
> > > > --- a/buildtools/get-min-meson-version.py
> > > > +++ b/buildtools/get-min-meson-version.py
> > > > @@ -11,12 +11,19 @@
> > > >  basedir = dirname(buildtools_path)
> > > >  
> > > >  with open(join(basedir, "meson.build")) as f:
> > > > +    if os.name == "nt":
> > > > +        keyword = "windows_meson_version"
> > > > +        pattern = r"windows_meson_version:\s*'>=\s*([0-9\.]+)'"
> > > > +    else:
> > > > +        keyword = "meson_version"
> > > > +        pattern = r"meson_version:\s*'>=\s*([0-9\.]+)'"
> > > > +
> > > 
> > > Minor nit, but I'd suggest shortening this a little to:
> > > 
> > >     keyword = "meson_version"
> > >     if os.name == "nt":
> > >         keyword = "windows_" + keyword
> > >     pattern = fr"{keyword}:\s*'>=\s*([0-9\.]+)'"
> > > 
> > > or even further shortening gives:
> > > 
> > >     keyword = "windows_meson_version" if os.name == "nt" else "meson_version"
> > >     pattern = fr"{keyword}:\s*'>=\s*([0-9\.]+)'"
> > > 
> > > >      for ln in f.readlines():
> > > > -        if "meson_version" not in ln:
> > > > +        if keyword not in ln:
> > > >              continue
> > > >  
> > > >          ln = ln.strip()
> > > > -        ver_match = re.search(r"meson_version:\s*'>=\s*([0-9\.]+)'", ln)
> > > > +        ver_match = re.search(pattern, ln)
> > > >          if not ver_match:
> > > >              print(
> > > >                  f"Meson version specifier not in recognised format: '{ln}'",
> > > > @@ -24,3 +31,4 @@
> > > >              )
> > > >              sys.exit(1)
> > > >          print(ver_match.group(1), end="")
> > > > +        break
> > > > diff --git a/meson.build b/meson.build
> > > > index 5ff68cb3af..1ae51996be 100644
> > > > --- a/meson.build
> > > > +++ b/meson.build
> > > > @@ -13,6 +13,15 @@ project('DPDK', 'c',
> > > >          meson_version: '>= 0.57.2'
> > > >  )
> > > >  
> > > > +# Meson does not support dynamic/conditional values for meson_version in
> > > > +# the project section.
> > > > +# The line below contains the minimum meson version required on Windows,
> > > > +# which gets parsed by get-min-meson-version.py.
> > > > +# It is important to keep this line below the "project" section, so that
> > > > +# the script can make the correct determination according to the operating
> > > > +# system.
> > > > +# windows_meson_version: '>= 1.5.2'
> > > > +
> > > 
> > > Why not pick a string that is not a superset of the general meson_version
> > > one? That would avoid the need to position it below the project one, and
> > > save you having to document that in a long comment. (also avoid the need to
> > > add the "break" into the python script, not that that is a big deal!)
> > > For example, how about using:
> > > 
> > > * windows_min_meson
> > > * windows_meson_ver
> > > * windows meson_min_ver
> > > 
> > Or even: "meson_version_windows", since the rest of the pattern we look for
> > occurs after this string.
> 
> I like the 'meson_version_windows' suggested and will send out an updated patch
> along with the shorter syntax.
> I'll keep the "break" though at it will still be needed to avoid a match on
> Linux when "if keyword not in ln" encounters "meson_version_windows". That
> break makes sense as there's no point in parsing the rest of the file once
> the line we're looking for is found.
> 
Agreed. No prob with keeping it.

If using meson_version_windows, maybe have the comment specifying that
immediately on the next line after the regular meson_version statement. It
would be good to keep the two specifiers together.

/Bruce
