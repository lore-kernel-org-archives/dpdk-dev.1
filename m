Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0F1C5DF81
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 08:16:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7DA1740150;
	Thu, 20 Aug 2026 10:16:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 19D0B400EF
 for <dev@dpdk.org>; Thu, 20 Aug 2026 10:16:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787213816; x=1818749816;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=D8Fxp/HdSPxv4YmWDyI2N0QNX9IWJiZFWNrDy6ntWbo=;
 b=ffY7cHTOgGxYkEMxSAfz3qe4n/9Mpz0ObTnDooaiGvbV+t/yzO+JhdFZ
 nQPE8RrS0TaMXqSbYZh+ibCpifnBGoEVIwvAKjuW5EvBcScyxES6Jx16O
 XvENpLLjo1NIl7p38dSBbMUUFbXQVzDmGqQa2KbJ0Een02JCvRSMHsUKl
 uSOPNiaa1X6Xfn6Qqb1tCdiMhdiWXdsyS/1N89ft6EoBntkLQ7ac9edrf
 MuN824MZorQ1aGJbeO3kZb4EVUxhpQ+zG64/QUAd6+BYkfZzl6tS8Hc2a
 rohZngGBLWFNdBVIDNy2CkcIfAwwk6JtSkF8CPlMVlb7ZQ5m+nL+ez5y9 Q==;
X-CSE-ConnectionGUID: 7zNeylF+TTOoY7JGAZpd4g==
X-CSE-MsgGUID: JmDNO6oERfufpGAn321XJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="87505641"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; d="scan'208";a="87505641"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 01:16:53 -0700
X-CSE-ConnectionGUID: BWqkSMPnR+SmN39pSTYt2A==
X-CSE-MsgGUID: okJ37CzrTtiFs5O3Apc7yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; d="scan'208";a="265429585"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 01:16:52 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 01:16:51 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 20 Aug 2026 01:16:51 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.0) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 01:16:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bye3NadnRNGHdYmcJz30UssRS3tGqETcCRV1Jp9Zqps8n4L6jJcj/3XflLDT5ZXBYrwODAlEnvy3i4PusmnL5vQzZOm+OaKUJolhMuxcFob5M6/0kbf2AmRq6vBvbV7d4ayKkLYSl/7CuNHDa5XOR0I4REubWWS/YhlbJXAvv+lk9t8qBJ11yHqgu0hf2RsCslW24paY/t6X4RUk48/tG6Vpk/F4UIggq8488wwbWUBxeny36eOa0Ttw4Yx9uRwpKvKGk51NdLxRGzZrBmO/hIowQjaEDBJ6JB73xQ2H2Vfge3S3AVhflORSB2BJazmT4hXXs/TGvDXDYqVks6LE/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtE1tRJS0yGma030bCl/U7kl6sSCHOxN5UZx6t0QR+o=;
 b=nxWZbDeyaRJCVoOK/u6RJnTvAETi6AK6ouPwR2wCpAZEHuFUihKMQVvUyzFccnrz2IU20PM9NsgF4toTIi7O5TPl7S3i/HPyk9yQ90UchJPiBUNr89EJHeaa1J9SEQst5yL0w/yBW8DwPmxSDwupLBSzL8YOmTj8sh22DkgymLHOfRz9Sc3fV4lbJWQcRM6Ihjvv/k8ROIuQ0jBKsbwcZr1AKKNsvpgixuHhggADi4hFrkxSOg3R19BKie+0fgrCD2rvGtdwv883NOa7muEmSopTNc95tvl10KyHmHtEOKzMWiVh8hXN1AqsrVwMFMEBmghXnZYjEZpKfKGJevsLtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by BL3PR11MB6412.namprd11.prod.outlook.com (2603:10b6:208:3bb::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 08:16:42 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 08:16:41 +0000
Date: Thu, 20 Aug 2026 09:16:37 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>,
 "Konstantin Ananyev" <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH 00/61] reduce use of rte_memcpy
Message-ID: <aoa35b6VvczfTa8c@bricha3-mobl1.ger.corp.intel.com>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35F659FD@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F659FD@smartserver.smartshare.dk>
X-ClientProxiedBy: DUZP191CA0063.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::7) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|BL3PR11MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: 69dc3548-b4c3-4f5c-a679-08defe935d8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|56012099006|3023799007|6133799003|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: J8EHfLZPZf+j9b5rHuXC2Plfr4KGmr1DQydhAQKUnoA4SFsbjGnpAt4xSBWl70u/DotDS/CAy7QWxEa7IulzTDUUpmayJoajwaopNXzvnpe/hwRUgzT/GGms2AdlU/QAgyMejLHr2uTD0vhKT0FG33YTdh1ROIs83SAOLlzZYIZmHOAPZ4KtDiXy44N7LLuoOJX4/WNeePN2l7nahdkHT9FN/T42cHPv5/YBeL/DZl38bhsg2VRvlh6+fV5r3/uFRh5ZeTYuXkPV7n6jYN5exOpUjAZeAEP9IXiimcTkoioQ9cxMqLDBihD0Z4XNExhqKgEjvs+94crIyFhoGioHNnB4rZOX7TQgUjwJkwdWd3G4b9UGa5Np/98IV7lh7CGJ4LlPyVRKP5LR2/ku1y7sl5mSK8GiKHi2iyGJUhON9QcJKUZbDV3RbLlwFgXJoHZzxheYjLlJV3EiLBFAZIajZirBh0nrfEygd2UuRdGOLrsAKPbATt63978v+IJfKwiRan9XKDlQJlUwKW/1ZNc298M7SGZ+Zcr3uFj1Qkd31o2okaDgVpR7AoE0ZujBQPgZ51HqcxWzLGxidSbMnhvd3zFmgwbx2MyFXCeS1urqa2vK7zWZJBSrphbrCGJ8cDFE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(3023799007)(6133799003)(10067099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?QnR/9x8TPh10k6kg3K2kjaWeYiT+jwrzIs93wb3NNf9IX58j0s/pzsJ3or?=
 =?iso-8859-1?Q?mpQWGrTo9HDMfiXVIMiPgVA+WNHPT8M9MtZ8o5/9Y2cqo7hpFzK3Vp6d0V?=
 =?iso-8859-1?Q?iG6WoNsj7Sl5zpz06VHMbLxGWyF8SN799hJ7rhqs5iVLUNq47FE7IAAE/d?=
 =?iso-8859-1?Q?JirhNBlgb+5QcPPF2L5JxXZzy9hXFnvsjS2y4IbXYO7+0znccQJ4vMWmNd?=
 =?iso-8859-1?Q?eWamN7IPKjzSPRN4WCX/iL/847kMd0B+UXj8n0qcptltH5RPgyPk4Sh8cf?=
 =?iso-8859-1?Q?01QgKOrUn2kZmWuCQm5gWDPBxp04QNWamxtwxhw5BwJu7JuRZnIwprBSgN?=
 =?iso-8859-1?Q?VIojCtgdX4hu13BfNbyd7f+7kRbEy1XYjiehOo64VteYYp9cEsDt2fzMKj?=
 =?iso-8859-1?Q?UoOg3jYbgq4/mtSV5SblFx8ddAgYWAvxm5tdByZ/iZjHFR0eJRHLvKE6BH?=
 =?iso-8859-1?Q?SQy2yaywV0oiXSerNba5aLlNRmV2l/F7GPxFg+ZrCukMGUXmycpy/9DOaM?=
 =?iso-8859-1?Q?M8h1iq+Ku14bvRMXN8oatLzFpnThOfYeKJPQR1drIPybT01nkyGsxiQdsf?=
 =?iso-8859-1?Q?k/5u5NWp/GZPCWYJi862AI7ROnfLYKxbJ4RBkiq2e5WtKYKy6AHgtmyJ2r?=
 =?iso-8859-1?Q?NgmAtW2vpxvhwPLNWybIsarT0DZS8c0fQw5PuxPfkZi8ET904wzA4+5wDf?=
 =?iso-8859-1?Q?1SLeTYl1NB3CYZsUrqQCUHntrFbJwjt5Foje4L7q1KyRUNN9LtVJzkIOiB?=
 =?iso-8859-1?Q?4Ai2YfXeYt0oap72q3Fn1MJvZwEPzwhIwduIei4jvBrFqt7/a7MlPIkOm9?=
 =?iso-8859-1?Q?q8wZy6tDfw7GTvqkYYoIR+7SvDpls4CoieGeRptrnOdAVjGPxlOgrwminC?=
 =?iso-8859-1?Q?vcCdRGl6Yj5aKDF1ymkqHu0fjk+fYoL7cLx8qTgWHansT4Wb8DVZQ2j3DT?=
 =?iso-8859-1?Q?6eWpuyFsfcKbaWpDD7AS1cWRZ6Nb+lFfq2NZobgXRilsFHCmvx4W0nfYBs?=
 =?iso-8859-1?Q?sjhLB4lpHKvMZbS9aXxq9kxnIDbz5/5twguf8GvLEVVj19X8BvPcANZLXF?=
 =?iso-8859-1?Q?fJxb/KaGOFAPW+iYEYskY9MS3xj8dTh1jUo5oWh/G2W5YfocrFbzmXuO+K?=
 =?iso-8859-1?Q?GOzIpMArOu6FvuQlCylE+D2EO1OwQRk5V7+CN3t/eFpbKavNdwXGBLHXyH?=
 =?iso-8859-1?Q?KZf82FBML8NOO7zUmILVuRDyreMgsrcm4CEksafrS8V860CieQHaTRxBLZ?=
 =?iso-8859-1?Q?yjGY/QUHO/aFPDUCxId7d02aVGFnunB+QEHSkZG1eFsNdBuxME2ogcoaHi?=
 =?iso-8859-1?Q?YMLZFfiIlYwJioDedWppoov7g5JrgYNVdrMl1Kl7E1Dl7irAsh9s3z4Fxl?=
 =?iso-8859-1?Q?MS/YlT1TbYIDSkNy8SV9K8HvnBocR/fS9QI8YxK3/miw2pCGpzYUC/OL4c?=
 =?iso-8859-1?Q?H/wpWd5byPGP30RtXbgmWR7oiO9guD++j99+YoQg4YzA0ZZinv11O4HpEw?=
 =?iso-8859-1?Q?3su09gS5EmK0h9UDsV9CKM+C15EItDUBiU1Jg4ed3JbGqtOS99KSvX/Vju?=
 =?iso-8859-1?Q?f8cGD2f6iDAqu+Ku0qKbe9ZEVmI01ppzL3+8QVjNHZbpzF6mtadj+iJk8S?=
 =?iso-8859-1?Q?ggQN8kNEmenj0c0lJ7b41ADFfr/1JiaBNmX+Fb0SNpPK4yW3fi5/QiDrfT?=
 =?iso-8859-1?Q?rbnnHYR6K7WA97ExgZtJHr0X+9VezU3edNBvoQYb1Zm27l4rSXkOVU7QQc?=
 =?iso-8859-1?Q?GD7aZgyrV6/DbXsEcH38ZoTYzpZjCoPlPJ13kk47a9679iLedB1ne+hGpZ?=
 =?iso-8859-1?Q?UeVK/N9/3SgGuw1AUJuZK/J8QUbGJy8=3D?=
X-Exchange-RoutingPolicyChecked: g0OPLyeoyfKJ4wt6Wk445l8XaSiDW7hA73murTVp3g43HFHKlppRSxw0nxkxNendH/NxaFEKCNCoG/8eZhi1WVAC5fUiCVMI2y2GfeeEYH6SUFujHYqMFi25l3x/+hJwFH95PEfd/juBbku13mscpYCmElRfK92PRp1uorWrwvN7fD7C5/GEbORpdejf0+gsgOuZQsUk8hJEKtsYU3yguR9bWIQ8YnyIxU/kmjMybyHghKSSCDvTwxfPP/ikR4Mr/5WUVT2W78/lh5VzKhpI6+eO3TMvZ5bfGW5KR3B4UAXdxo/nD1WB8BQwFVtweGdqlOO2RugrjLsbdvxwH6TGyA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 69dc3548-b4c3-4f5c-a679-08defe935d8f
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 08:16:41.7909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2fk80RAserch3UWoR6ASgGUCcdDmrd1XvWxJG6IOLphmjF//4LIeL4irKOcPh+e3zdqyF00JJ+WnutpWJ+2BRC80Hd8la/C6uln2ap92s0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6412
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

On Thu, Aug 20, 2026 at 09:31:40AM +0200, Morten Brørup wrote:
> About replacing rte_memcpy with memcpy()...
> 
> > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > Sent: Thursday, 20 August 2026 07.12
> > 
> > The DPDK function rte_memcpy() only exists as an optimization
> > for shortcomings in performance of libc memcpy() on some platforms.
> 
> Yes, and those platforms should benefit from it.
> 
> E.g. the vhost performance improvements for Haswell and Broadwell [1].
> Where similar performance improvements implemented in the relevant compilers (GCC, Clang, MSVC)?
> 
> [1]: https://github.com/DPDK/dpdk/commit/4b42e90ef0e421dc777f2b2e377eb237cd3675fa
> 
> IMO, performance should remain a high priority for DPDK.
> 
> > Many platforms have no special rte_memcpy() and just use memcpy().
> > 
> > But many analysis and test tools know that memcpy() is a special
> > case and check for overwrite, bounds errors etc. Therefore memcpy()
> > should be preferred wherever possible.
> 
> I think this is the only substantial benefit of replacing rte_memcpy() with memcpy()!
> Could we reap this benefit by having special builds for such tools, where rte_memcpy() is modified to use memcpy() instead?
> Then we wouldn't have to compromise on performance.
> 
> Also, rte_memcpy() used to have a pragma disabling bounds checks due to some Intel drivers using [0] instead of []; the pragma was removed from rte_memcpy() when the Intel drivers were fixed.
> I'm not sufficiently familiar with analysis/test tools to say what they can detect when using memcpy() instead of the copy methods used by rte_memcpy().
> 
> > 
> > This patch series introduces a coccinelle script to find
> > calls to rte_memcpy() where size is fixed, and change them to
> > regular memcpy(). This was the starting point for this cleanup.
> > 
> > There is also some cleanups to include rte_memcpy.h and string.h
> > where needed. Often the includes were happening by some other
> > header. And also removal of rte_memcpy.h where no longer needed.
> > 
> > The result is a 46% reduction in use of rte_memcpy.
> > The remaining rte_memcpy can be cleaned up later:
> >  - drivers with active maintenance (like mlx5);
> >  - changes to rte_memcpy which need benchmarking;
> >  - test code for rte_memcpy can be removed as last step.
> > 
> > No functional change, no warnings in all compilers including LTO.
> 
> memcpy() does not always use inline vector instructions for fixed size copy [2].
> 
> [2]: https://inbox.dpdk.org/dev/98CBD80474FA8B44BF855DF32C47DC35F659B8@smartserver.smartshare.dk/
> 
> 
> Another disadvantage of rte_memcpy() is the lack of developer guidance.
> It is not well documented when to use rte_memcpy() and when to use memcpy().
> We discussed something similar on the Tech Board meeting yesterday; it is not well documented when to use which type of "ring" (normal, RTS, HTS), so maybe we could remove one of them.
> But removing an option is not an improvement, if the removed option would have been the better choice for some use cases.
> 
> PS: The general guidance for rte_memcpy() usage is something like:
> rte_memcpy() only in fast path,
> memcpy() everywhere else,
> assignment "=" when copying fixed size structures.
>

Good guidance indeed.

I like this patchset, but one suggestion to make things easier to review
and double check that we haven't let an unwanted change slip through: can
you maybe split the patchset into 1) patches removing the unused headers from
2) patches replacing the rte_memcpy instances. Some of the patches labelled as
replacing rte_memcpy are actually just removing the header include, e.g.
patch 39, patch 42. [Even within the second group where we are replacing it,
maybe consider splitting between rte_memcpy -> memcpy replacements and
rte_memcpy to struct assignment changes.]

/Bruce
