Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A03C5CFC1
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 11:24:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B1AC4013F;
	Fri, 14 Aug 2026 13:24:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 4BA70400D5
 for <dev@dpdk.org>; Fri, 14 Aug 2026 13:24:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786706681; x=1818242681;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=bzwgpiU5s6OtDBgIWIdUvzKGNsqTvFgF13DGShqD3XU=;
 b=kOnb8XCBb6A+STPrwTaFmPNJ2AQqFVrlT8QwaFFmZrcHwClvax94Sy5h
 +On7wJgxw2XnEPcMxwX372RmbQWloWHJbD48sskcraMgQIxWvSt39UMcM
 p0gItJHaj62BQlACmrcdAjtcXjaYKHR4iuHwk0tzlMpvcKYe1rR3GUPuv
 GaIrQy1JnDq6L9GVOYHAeXK/I4jS0oCnxbl/tQ7tcuXNjgn2ajhz0xiTf
 nPE+0e1bZCCOrQHFEb+/H9NSkzJp/GFns1sR4f6vj8qaB1/d+KxtMCGI/
 IUSr/cmeCRkbTbqESfpx171SLFGXE1CMXFliTeNTBHD2ojxr667xNSvqa w==;
X-CSE-ConnectionGUID: ab1cpzMzToeYRNtuM9pU+A==
X-CSE-MsgGUID: agWdaxfxRM+4zCVYZWeamw==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="86248380"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="86248380"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 04:24:40 -0700
X-CSE-ConnectionGUID: iOV6BYDkRGKCEqQQE+jeEg==
X-CSE-MsgGUID: xDKX0HMHQtOCn8R3eNfv2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="268055453"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 04:24:40 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 14 Aug 2026 04:24:39 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 14 Aug 2026 04:24:39 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.14) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 14 Aug 2026 04:24:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LvIPDBQerwVMdG4gEql7v9frQT4SY/u4n61QSknUJ7FM3fvxbgpwTGQJ3Ys04K7vq8K5CzHB15hYheI18Pc/fpOtuGeBQWYcNNLvy4PeL/qmbc2vxzYMg/DF0r5KoNZolSaYtuESpPUGcr1Fd25IpSNBdEHfmf5KKw65F+QXEGMFmMCniZKRUTDmNFH3173fq0+5Pl4ivyE8wA8pG6qc9Orvz/FPnbVVdOWQtTvzKYQiLpJap2BixNhsofiYLeqM3v3UleSHjPpXr7eZCfLR4gpC7urVqzBt2wJtECKIKH9M6EFHdjUznrpGkDuazhJRDVjx99NNMpuNeJpzC3bIGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FbunYTOjo5pGNHjOdKawvAiXfjxKMQJcMlOTP+LIaXw=;
 b=HvDTUKh3tEWnqo6vMn/rFmqsviVW+wW/ISjfS6oOH0GWVaKd4vEIkNdQNguXsVX4FvpdWiis8MZVgMeayav0GM3xRyNRPsk+qihg4YEq2ubuhU7lfnGW5tVIHUnj6MpyB0/apmLTXkw4O+PZP9vpcvaiJhRq0N6t7JgdDSP3CW9b8bVg+seg91ek4daLg3j/LJJDIMLy9TPdHXpstnbBEhLo2fjNw435wwC0Dd5VLT3hhwofmuU3ESA99OoRm8n92xP+EcQN+JArAevxX+EZCGnuLY2kOksr6OQtmlQnF4Kmpi+VBbn796gkIDIJ/E6jdfVbd6k3UvSeuovdX4yv1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by LVUPR11MB9592.namprd11.prod.outlook.com (2603:10b6:408:3a2::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Fri, 14 Aug
 2026 11:24:32 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 11:24:29 +0000
Date: Fri, 14 Aug 2026 12:24:24 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Hailin Xu <hailinx.xu@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1] nics: add E2200 to the NIC guide
Message-ID: <an766BU0CW0bKY7t@bricha3-mobl1.ger.corp.intel.com>
References: <20260812020907.148153-1-hailinx.xu@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260812020907.148153-1-hailinx.xu@intel.com>
X-ClientProxiedBy: DU7P195CA0020.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::11) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|LVUPR11MB9592:EE_
X-MS-Office365-Filtering-Correlation-Id: 99246b62-5e19-442a-79b8-08def9f69b03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: CCNXW4AFyjyCTw2mU1TSNqlu45CeLKolqOCqjN639Y6QgN7veNCu1O5irs1Xa+6bnT+UQrifF3x7IEUv+EoPoDwm/Fx+pqNXz4Q2xc0neKOmpF0bEl3gazdq1bjFEY3xXk5hGz06CdNJa2A3FDDhaxFk80Te2wPTMR/3reKEFVoTIm/fpQtc9mT2gWWDPByN+ynsTbEL7jT4HsEwPgM4jSsz+I8V0PjTJLrwPb+kO4f3nE1t2ZeHjJBxPM7Arzmadh0IDVWo1lxqcaw1hSw/GS/Va37d+RJJrVTp2WEi3nRj7PPyRDMN9eHEw38E8U3R6NDdbBClwKJfA2BsFaKSaBfwOaMqEY/Y0wiT/sBSVoZtEJWy+6drQXJoJKTfvGFKr4bz/XdnvzfRUHYoTdUTSWH59a+cMPV8Mmodjv/RqwOdQ0zyLZ/TrSt+agpEI0LutlqhHKSf9fYEVToeLvDbeVJ5idoT4+5acPC9mrnSS2at80nxkutpAiwlitb7JakpGtPgJiPAlt722dfsnLvmvr2orWcG0eKVc+s4d9YepUwUbKVVKhtX7uf35cH3Rsvq1a8P9yr6k5WJNeJVqV12H609p1mKlqL9qlX93uLYSWtIbZGo8w/prmBbjwdxuvpCtUijtqWoD6GzdbeQECz8QWJu+ZDwH98kRXKlY4uJaEs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JtLvbttt4OJwP+LFaqHEx7ojTPAzklofMKPoJKdV9pT98e2rzFKqANV7SnVb?=
 =?us-ascii?Q?ieCwOT38JdB+weNzCO9bkfrriD7XX22aholIDFlzu4q+cK5/FgUmwgg/ePhu?=
 =?us-ascii?Q?EZTWN6DrdST/WlWR60+elmeSkv0xmfQnvJ+SWPeWd8H1ktECMHlINVjEecxB?=
 =?us-ascii?Q?XB2rtjQmyKQQA/iB/laPCHVsIKMTNNOaqU8yOVN4B4DKOPRsPDu/D7M47i8o?=
 =?us-ascii?Q?nW95CjvyJ9q6UeEeVuq6qJRqnqTWY3gbj87d9d7IFb2eTMVexQo5uA4nikgm?=
 =?us-ascii?Q?LZnhrmS3kFgANMQgjxp9NZSIt1AISiIL6A0vQopmO6Ox49odFvbsUJW+EFLi?=
 =?us-ascii?Q?ayLndY+3npIJK8tdp/jWivyLj7OYSGsazYbwTwrUZaCQ9VmA8PFtQZkm/uM5?=
 =?us-ascii?Q?3hECFbF5DLs0g5fA2bgIahwCdJ/slIamUWLV2GBM4bfEFKJBexfDn4FL8gZb?=
 =?us-ascii?Q?lhpP1VP+rObGPKZGul3zjj3UdSSQWXjmiT7rqRME0RQCEq6cpTYi0fD/Ip22?=
 =?us-ascii?Q?VdCEG5SjBCRXh5XBAYmlYkt+UphrCAlGTHEEK4qHRWL/k0INka0D0fNQYh5t?=
 =?us-ascii?Q?B+0Gl4Yy/1x4zHA/nRsYPFZYL/revz9G9BLdQbz9uwlf55SNPwQ7PI2SNmmo?=
 =?us-ascii?Q?HjEtDZo1VCxvKBoey7G9rE8GgHYdyAwiGRvdMOuUlVHunthpbLeak/DuPru4?=
 =?us-ascii?Q?lQYjsFFLgSmyZ4n3BHu0lZgrEdFwszDyN9wEEARYOT6chWUK0Du76H9nr212?=
 =?us-ascii?Q?8OjNPyOGgeDrGNkv3pUWY4uB2iUzGaybwgBeqGMPRJnwC0IDufCNm6XJLHiE?=
 =?us-ascii?Q?+cnNHWYF4ZTZpP6oPKZZqe0p/Cn75o1V3zJkkAJzWeuF0Vet1HUsm4ASlfWw?=
 =?us-ascii?Q?KkN5Pa517DPCVkYwVaxJ3Lgnq9oZ5bQNUkCndM4q1QtPeas93Ecg5PC7KK5o?=
 =?us-ascii?Q?ndxyB/3G9H9QS+x7KjiePY1KY6loCwExJg9d1Nt06VZMdhQMoqlguD7OH4Ux?=
 =?us-ascii?Q?pFKkBqIKbaLT1kYVOI/90N+9wObnQIcE/9JweiFdsBsGdWsbzvXt0TKNBLV2?=
 =?us-ascii?Q?BZsiZB/R10dmptJFG33Q6r6vpZQh/7l5Fj30b5IIBLDaThCfxFlCtqrkUP4s?=
 =?us-ascii?Q?8yUnkiZnt82s7jSaM7UR4pxxESLpn8wZKrZ6LKjFFg45a/FXXF9KZpS7KzRx?=
 =?us-ascii?Q?6MP90lh54KnxRlCXpqNUbtIqWpkOVOrdFaYt8IFDRM2SE9NpqwsU+AkE/BCT?=
 =?us-ascii?Q?U+dBGuxQEJmQ+hTdIfTvcHgiHUuY5iUhSyDJYSBJV9WcK6s3gGtKHOVS/p8A?=
 =?us-ascii?Q?FG5/qdKRR2poHcVktprpjPdBpNVidLpGBPTpgpDvdH3xwi1b262RPgeLYdOA?=
 =?us-ascii?Q?pbA5vl2Zq1cbmNuUNm0/kNz2UfrBNZl/ULijEJEZ3U6kpekFIJMRRc4nmK90?=
 =?us-ascii?Q?GefQs5J1RmN3j2KyixiOZcjxXjc6vWYGkU3Nvsk+BsAW4K8iAqVaoJMOm6lV?=
 =?us-ascii?Q?MebS11bT/2ZInav0ZaoBcJ5jP8Re3XtnJ7FNqwabtUU/ph9/imIA290eAjXJ?=
 =?us-ascii?Q?+hz4XJCF6PIbLQVzZ6dfp167W32occ24uQswLqheoWQW2ErK72kWffSSfTyx?=
 =?us-ascii?Q?mDNGvFvn36AC6L5jQBciFxc+RDg0sx4VslxAoZ0W6osUdD5GE1Bvp1IplAAp?=
 =?us-ascii?Q?1pSdt4Diw/DEMh3mN9Z3qU7fOKr7IIA6M0T3qV23Anuipn9zJOM3HdUPdMkm?=
 =?us-ascii?Q?2zo9LuYwWTD+bREwX3kOgvxe85AM9II=3D?=
X-Exchange-RoutingPolicyChecked: MBqfU6ABpvx6At3H1NWeKq1m07R1GWkEJtdvtnSkKMt13OUiGDhr8f51pqWMlnRLiKKA62eiwghOss/Ss6fYaejZFd4n4wXpJVWalk+z1XGZgTIzsFKV5nHkt+EyxNtYxK/jMCzR9CmNjADxLU0sWV18ACB8de8t5pzOwf5KEy3Tu+aioI0IZEf3telG7HlbStdtblTC0jEPvQDUqFKn/TXIXgMm9Wv6Z0OsWrqZOS2BbULVCPkcbVls5vBvnlbWH1An8eI2tOkWqLrlXJU10ak94zrDPF4cFjEGcCLEdfRyJjcQdr+RRQoLGa1i4BuUxskX83/fdAVHTAEwErMvLQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 99246b62-5e19-442a-79b8-08def9f69b03
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 11:24:29.3742 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jPkoOTwRUalRl7dvGADPpNx1gOAjo1do29YEVPlVUfwL3xfUVdQShuJBNUboJJDEZJpvnvnNECoBJXc+AUm0/+0vU3xYyhSaL2Ocl57DDWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9592
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

On Wed, Aug 12, 2026 at 10:09:07AM +0800, Hailin Xu wrote:
> nics/cpfl: add E2200 to cpfi
> nics/idpf: add E2200 to idpf
> 

Needs a proper text description. The commit title probably should start
with "doc" or "doc/nics" rather than just "doc".

> Signed-off-by: Hailin Xu <hailinx.xu@intel.com>
> ---
>  doc/guides/nics/cpfl.rst | 1 +
>  doc/guides/nics/idpf.rst | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/doc/guides/nics/cpfl.rst b/doc/guides/nics/cpfl.rst
> index 3e2788ba03..5964a980ee 100644
> --- a/doc/guides/nics/cpfl.rst
> +++ b/doc/guides/nics/cpfl.rst
> @@ -8,6 +8,7 @@ CPFL Poll Mode Driver
>  
>  The cpfl PMD (**librte_net_cpfl**) provides poll mode driver support for
>  Intel\ |reg| Infrastructure Processing Unit (Intel\ |reg| IPU) E2100.
> +Intel\ |reg| Infrastructure Processing Unit (Intel\ |reg| IPU) E2200.

Since this is not a bulleted list or similar, best to add an "and" in
between the two NIC names.

>  Please refer to
>  https://www.intel.com/content/www/us/en/products/network-io/infrastructure-processing-units/asic/e2000-asic.html
>  for more information.
> diff --git a/doc/guides/nics/idpf.rst b/doc/guides/nics/idpf.rst
> index f4cd69ba7d..1f06eed645 100644
> --- a/doc/guides/nics/idpf.rst
> +++ b/doc/guides/nics/idpf.rst
> @@ -8,7 +8,7 @@ IDPF Poll Mode Driver
>  
>  The idpf PMD (**librte_net_idpf**) provides poll mode driver support for
>  Intel\ |reg| Infrastructure Processing Unit (Intel\ |reg| IPU) E2100.
> -
> +Intel\ |reg| Infrastructure Processing Unit (Intel\ |reg| IPU) E2200.
>  

Similarly here. However, I think in this case you probably want to keep the
two blank lines at end of the section i.e. just adding a new line rather
than replacing a blank line with the new text.

>  Linux Prerequisites
>  -------------------
> -- 
> 2.34.1
> 
Regards,
/Bruce
