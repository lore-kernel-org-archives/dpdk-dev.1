Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17587CD6E55
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 15:56:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66E6A4064C;
	Wed,  3 Jun 2026 17:56:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id DA830402CC
 for <dev@dpdk.org>; Wed,  3 Jun 2026 17:56:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780502191; x=1812038191;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=Ie2o69Z1JfcZYcOlp1WrDkz14yE90kAVnyXOuH4Qnl0=;
 b=kY8XylSSuWvLncUjTb+NhUr4ntZK9YfMNXW9Aia2NVScxb4sbI2oR3w/
 4XBttOGIDt3y+YiMZVjAEoMzvF3B6gvcHxMsHEIv0sgFlBNhlXsqkpxzw
 lq8PEYO3vhfBZchi0eCVTAjy98hFEY2HKewu/6fe89/u9y3ziRM1+87Uc
 W30EqDZ0FAdBhP743Qk/nM/aguXGDyqdASQDQ7896a3PM2W6eGal9BnFf
 dtgLwRlgYVg+pCoYxL8tLeXVe+v/XUixO9oz6pFzYzqLgxAg4caYwJgjL
 KrqKAZbRPd7flKJVK8ztf5Aocuyclahon94kDzPi+zjp9XeMc0UGnHKo1 A==;
X-CSE-ConnectionGUID: rX++K9mqQiCoJ10nNxE6+Q==
X-CSE-MsgGUID: cozweJKnS3Sv+oasf9hKzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="81176001"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; d="scan'208";a="81176001"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 08:56:30 -0700
X-CSE-ConnectionGUID: wZsY2ZnmQfi9MwTHKe2cGA==
X-CSE-MsgGUID: uBi2HNUIQGqfVe0+nWJOyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; d="scan'208";a="237936894"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 08:56:30 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 08:56:29 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 08:56:29 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.4) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 08:56:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X0qt80p7PKWaNbzQVv4wViJvCM5yEZrOxYSRoSpMhtBiTaDEZeBV2Auo8vc8/SMKVmGfbo0eWjC4qtugGKJ44Hsqr51ZKwKTVnxZjputYd/VEMmOKqlG/SGspiBtC/tVKBylbKBND3QToECuAoq+cF14+wOQqL0ngETSXM/sPZm9pRIauriI5NsGzd3QfycB6IWVz0vJzY/ZTuDKyhlcJjnCQzshSWYUfHkf8g/Hrm7mHGiKbtnFrRtFIMJB5j1z0ufQFdePBkbVT3cFaJ6Aa42TJWSIbqaxs0OzpApel97rpMDSG8aQnYtFdnd88ophsBPnFPplfM6tHWpnRj6FwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YuALW/m2oznadW4O1YelGaHIScn0I+BzeWveWWDENj8=;
 b=oqHRYelmQA0oVWnmMbur0krlegdp+mC8DOc7/aKGnS4rJRUGltbMdgrC9qUsa/c48iEQqe2R9AwtIeGEsInsqzoBRCWaKo5+t6CegRENoXzzNFKHIDP3abo412XKWmn4kPjk40aShodHep3gsQRvOZwR5WgAqZlWqZP+6OGsclst3BuTFXFoPbuHoxOoufJj++xcL6h7cF73YBahhuRLNFay2aTALKHFzHwc67AhnVjs/UAQGfRL1mr3T3svgASJqTLKmG1PKQMfxlbbytScMOV3pqdBIAefWnFDyeIBTtBz56NTJOX6rjoQ1BDtjxGcwXKqWjn6oHpL6+CWIP4r1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ2PR11MB7671.namprd11.prod.outlook.com (2603:10b6:a03:4c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 15:56:27 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 15:56:27 +0000
Date: Wed, 3 Jun 2026 16:56:21 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, <ciara.loftus@intel.com>
Subject: Re: [PATCH v4 0/2] net/intel: optimize for fast-free hint
Message-ID: <aiBOpZbi4JohjSaP@bricha3-mobl1.ger.corp.intel.com>
References: <20260123112032.2174361-1-bruce.richardson@intel.com>
 <20260602154513.1079865-1-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F658DD@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F658DD@smartserver.smartshare.dk>
X-ClientProxiedBy: DU7P189CA0030.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::34) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ2PR11MB7671:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e12901d-e4ff-4973-977f-08dec188ab46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3iENpxCGHlHRlOBAXKfUbSD0zePGaVa0vgKijKBWisQQmSNDvCRGT96rjP8D/VzlUjZYJi0cqoEg3cJppYGIbbDLTJO3n3UVgrbsTl6aK6dMQ7U+taivL50uokOHE/zan47hNlr8MHcvG6i+DzVHYLeNmgKrBbhC8+Qynbh/amPxn5RYeP1YAULFfVFcFZecSzfj3oMhjN7umAz+xBoo5FPNLw72W3xPI3gD4lA5PRZichGFvIAFKbR1rS09MVeYCAlVGXLZAB7B++Llw1HIFknAplZY+mh/DQ069mVAhwfyBQ99LbOEBG3b9GVb1PJgh5MP7k45fA7PkNa6Yd9awGv42E8vJ+g0HLWmEXYlqM8EgHjIE/C001moSvUQt+QukncJa4l3EX5YZSRaSOvMBK1UxX6ksre6Bkfk953gaNnlKMC5Qd+r3PIFvwdJwVClqGWn9tRaOESnTgIdHzAQp3rIOU0t/hXmyHjDS3OY9p+SlMR+LhCzUo0NgCOOSQgnYgAmHLAuTF160qiEZAXGx1+tlp2x105U1cTICSBGYlkTl34DGDggBDgTt+JGst69U54mJ1cDtj90eeK1P5X2xDnsKDK70mmFqQCoSHxsDWtaI3PkAw6MxgvWjemlbjWSG32bpBFTivEqHjrM4Bp0TK28m0EAIBxj/eW1X7I+GKFFNbH8Tp4dDJTc4dZPG8te
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?+Ec4D1pYjH46H1Vz3w5lTnxl9fuLsGSVq4ZOFtObIC1M6K5JvlQHq8t9Ts?=
 =?iso-8859-1?Q?R4PFCqDQ9HFY919ccWNN1VfbCZeNQJXjzjFwfRphdPtGrHcSNcARlN23A2?=
 =?iso-8859-1?Q?Hi/3U87Heao6MO0GPY2w9i7TOTcqg+M1YOqDoL/+LNWEA6qW/cApteJNTV?=
 =?iso-8859-1?Q?1twBZeeY3yt6rR1moAd2PNm8RIgh0ZEtVd1/IHlfvui3k74ysc0sJPuiQQ?=
 =?iso-8859-1?Q?6UpdSjH8RcrTqCGoDGwkEmxfl3oWvxjvIAsqpZouLIerMHODZnHnhqWj+3?=
 =?iso-8859-1?Q?Ppj8Me2LKEPwc+LbH4hVJq4ZDvm9UchlbOcP6mgY3OmvNE7LeXLztbOlqp?=
 =?iso-8859-1?Q?JyUIOuTe3gulPDGWzDT6xZ5dMAMjS4extrFycJ/eLCucPxluYKVx4vnWAF?=
 =?iso-8859-1?Q?IKgjxCHs4sR/46UK7J7SgP+GD9/xNbfS+cZJd3bdzUUrE6A9vz7N19VqmX?=
 =?iso-8859-1?Q?HEj6asaVnsy1PBIx7o4Ge9mLDPT/I2eLJpLXqrBjLWBenvhCpA+Brwecgh?=
 =?iso-8859-1?Q?o6qiC/fddmN2/9mIDs9EbLjaILdJI81EXVJ3lS7lW1QlTcnMikc6dpjJ51?=
 =?iso-8859-1?Q?Ch78GjAjbuoNpzGHUlLspVc/Twcqnauy2om2ZIlKrX790vKpalguA9ZyjS?=
 =?iso-8859-1?Q?aAZD8A5YDpaCsTzktMMu6U17nQkVvn1sAqJpm/7QNXzl3CgdgMAqZjPEeJ?=
 =?iso-8859-1?Q?3PU0HmO27SqQBikNZMIYls6DODIPt2r+DiUDY0ezfD539+248BSN3c/5Ty?=
 =?iso-8859-1?Q?Gc6CtZy85h3L7h3g4N0NP1jue42L2WbvUPc6sFN0/7CWp96CLRdCAK73v6?=
 =?iso-8859-1?Q?LsSrqx+Y4/16U6ZW6gG2JQSzVjGBAfDYccRfUOWx8qbpSLgGifIM3Yjb79?=
 =?iso-8859-1?Q?aL0bWdJoCSFvs7uSj1oJZOPrBiPZUn2Onw2I1Xo5JWxegdBhPJRZE1C2wW?=
 =?iso-8859-1?Q?NxqeQxBnz6uyez68c1f8zI8Wngyx880vJ7S84y+o0tskdSIy1qqa5q6HS9?=
 =?iso-8859-1?Q?f7jEt2VkMMsMbmsWYOvuii4j9SJeq9H9R6ggpsLXCLMFDVtN/5PJ8HqmsT?=
 =?iso-8859-1?Q?Qdldk8lztG51XbNZp4e/5tjmNji3G0l51bxL6bLMKH/vSFUqWqXrXrR8Q6?=
 =?iso-8859-1?Q?hl6lEbjj165IB7zyJmYxqwsTRF9iyTGpwpcAURrxXBIo72gOVjarVW70pI?=
 =?iso-8859-1?Q?qbpZjg7OasQw+9/Hvd5Uoi6kfy2mLUV4RTlB0LCoSlc/OwPI4XFFCBGS/5?=
 =?iso-8859-1?Q?UNALWUX+iHwsqapjO4tw8YRPJCT7OdB5ZfwvEqNvZPnVOQVcseFGVS0bFz?=
 =?iso-8859-1?Q?kAVtvm/2XKtUGy9HrHk9qFc7rCash30hULy6qdnxq1jQj5cURz0boEtTxf?=
 =?iso-8859-1?Q?jb44ZAYtJ9OtGoTAZdb4ENoxPuIhwLJWKBHU01srz/j6DXQzCbLBUjSI39?=
 =?iso-8859-1?Q?ETu4lp6ZhY4kXp/czC1oW7T/X5qkvh4ACzsCh3lJgwafZwjS5BjTtmW1D6?=
 =?iso-8859-1?Q?im7uR9Ve/2in7G7Wvt2yjtx+cZcdnpRoyBFzMUYgcYqiwPiyekgoUCq7Q0?=
 =?iso-8859-1?Q?M65zoZ1jhtgFUpN90huNJwu7NP0FnO68JB6DuSRRRgaRG8lvoWBuQVhsOK?=
 =?iso-8859-1?Q?bixKCNi8t+dNaSltpgKFMDG6xWbgRSlx83fkEcQ+x0iurFVi2kdzH47AZV?=
 =?iso-8859-1?Q?5TtfaIiZRKyWZuCt3qNPJzTdJmXAnlaltziR8L26SMbfcLUz7MSf+9k9Vm?=
 =?iso-8859-1?Q?Oj0W92eiBAs3Q6RVK9s4+1nNEhOLxV+Ld0ApyBNI8jJ1SN+24W71XgnQr/?=
 =?iso-8859-1?Q?KYheHDTHce3h4Q8qEgU0MFyZ/1bM8Jk=3D?=
X-Exchange-RoutingPolicyChecked: rOunx6Wowy1lMRT12vmC1m0D2je80SRhy6M77KdszKZ8Uq/S4b/5reGYnG3C3UN6OUwcczHg8yPH33H16byniwLci9eObx8BKNotN8h3SMRsHsjJ8GXrbyEzuo6Fn5U75v4rupqe89QW/AqSFp+sRwcD7vmuIrFPz2NXGpkuahRcAa68El1R0LBfCfKx24SxYm22pbmdBXtfBgdk88JcQ0PfLKEHeO+OZoGorf16/ziYfpPCRb8gDQoUrHpDr0O7nvjoVMbY+pFOwF1zMrKsgWSLOrkKKQShfJgacXm5Gg3zjw0rJJiOdqrZQyXsrBHarzm9P6PyiXuT+sQN3EwVXA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e12901d-e4ff-4973-977f-08dec188ab46
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 15:56:27.0184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 145iMG7d7vg055Fe+SiucqRPRg+QhA1C+YfzRI34UuCKCjQYpsarItm0FrpFxJeWo4m71Q93ZLpKHAWmzSuS6cBAf01TroKCbxQBfIVznl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7671
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

On Tue, Jun 02, 2026 at 06:26:13PM +0200, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Tuesday, 2 June 2026 17.45
> > 
> > When the fast-free hint is provided to the driver we know that the
> > mbufs
> > have refcnt of 1 and are from the same mempool. Therefore, we can
> > optimize a bit for this case even in the scalar path of our drivers.
> > 
> > ---
> > v4:
> > * add precursor patch to adjust mbuf pointers so that the DD bit
> >   is written to a descriptor with a valid mbuf pointer associated
> >   with it.
> > 
> > v3:
> > * used mbuf_raw_free_bulk rather than mempool function directly
> > * check for fast_free via mp pointer rather than flags
> > * remove unnecessary prefetches
> > 
> > V2: Fix issues with original submission:
> > * missed check for NULL mbufs
> > * fixed issue with freeing directly from sw_ring in scalar path which
> >   doesn't work as thats not a flag array of pointers
> > * fixed missing null assignment in case of large segments for TSO
> > 
> > 
> > Bruce Richardson (2):
> >   net/intel: write mbuf for last Tx desc of segment
> >   net/intel: optimize for fast-free hint
> > 
> >  drivers/net/intel/common/tx.h        | 21 ++++--
> >  drivers/net/intel/common/tx_scalar.h | 98 +++++++++++++++++++++-------
> >  2 files changed, 90 insertions(+), 29 deletions(-)
> > 
> > --
> > 2.53.0
> 
> Good catch by Ciara, and good solution to it.
> Series-Acked-by: Morten Brørup <mb@smartsharesystems.com>
> 
Applied to dpdk-next-net-intel.
Thanks for all the reviews folks. Quick tests on next-net-intel tree with
scalar driver show a nice perf bump from this change.

/Bruce
