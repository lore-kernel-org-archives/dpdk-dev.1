Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C009FCC6B38
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 17:23:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB7E9402DF;
	Thu, 15 Oct 2026 19:23:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 5000340658
 for <dev@dpdk.org>; Thu, 15 Oct 2026 19:23:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792085034; x=1823621034;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=zupMOg689Sohi7Qjeu7m8+Jlk+lEXR7dXYF/3Icgj+s=;
 b=C4fuUuVhOE/75h7z5C2BzwbpTLgnzHpF904IX0MxpwbzD9ITcxpy9chY
 yf23C/4e05udzoa35nkRjblrl4rMUkXF4lBkBllGEnt3HV7kKKSEa7lrj
 7uVjh+ALRYosDw8RDidDdxMGElPjpGeypKIiPkFRSDRPNrg4xoYgtDxoI
 E5ZxWcCb+FjPGXD6tU5kgkVe9MVuRw2R0+V7xxGJwkQd4STL5J1XQAwTC
 c1RHW2Av4fOVtBD9sUuWWadpU76mLQ/MZn6/3jobBWMhog7L9JZTfFg/P
 GuAba5m/csuO0+bNNY2Xl9WA7xYdCf+yJdBh6WlmV1MKUDhSfnWIKkhqH A==;
X-CSE-ConnectionGUID: 6Lf1M72dQayV6+lK1qhZcw==
X-CSE-MsgGUID: i0nYP3TcTpOEWUXX8+8Rhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="849393"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="849393"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 10:23:53 -0700
X-CSE-ConnectionGUID: f+dKXkqwSwSDU6bbsnaR2Q==
X-CSE-MsgGUID: IaQzfnREQoaKsowgodBT7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="2062612"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 10:23:53 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 10:23:53 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 10:23:53 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.19) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 10:23:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHDh9QMpvhuTURCDaMD7ZNHk0Z3+N/G5wWa16OneH/26TOwTunkQlXTt2FXKeyKNmVJDcpbMgCv9iD7gLQSSwtRwgRQ4R0eOwFyJ47BSJdyK8osgwmcClV7eQ2IXUHbygK3BH+wkCEtpCXDYlZbRdMdhRQW5ZNuLdAdpqfv2bFjAIh1uHuH70i4qfisKUvZRmO5JHsptd+WRqyYrv1k9VGQNJNEJ5ZRrAboqNF6S2encs97Dlq0X4iA2EFZvy7OXVAhwhMEKgIwiIw4xY50r5JZdaodjgmf08jSfbutU/V9zqrADSRs6YPbKIuxJT7FUToyfKoY7zOcQCNjwiP6DlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8cyjpG8utzgYDZH2+N0ESzBXua/KzbvgyFWY9pa0+8=;
 b=GVcGEa+BqBma6V52sNRfbKjqbfnhZ+czFXZJUsJoXIMHlRxgEjkrffFJqM2qzeOs4MdiC4PUBAoujtGrmDK1A9W+qdiNNrMKVt85Lj1o0qBi/MhHUKgurT8iMdx/Ujs8fL2npYKSx93gt05GXB88CwhE5s2TCrrmWAzIioWLV54/B5gu2GcVdZG0Q5PnOjgRz+ZjzoK5Yebwwalo6BiV+QwbMcOpzz9qG2OLIS4XdfQDNqPIiZc0zR8nmnCV+wHzocLYvg1EJ9smCfKez6KSZxTXdFRq3fw095zFRUN3C/vC5hlJDzdcD6SlIGh7ilX4ae/L/TAbwBzRIftzu3ofIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DS4PR11MB057924.namprd11.prod.outlook.com (2603:10b6:8:508::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 17:23:51 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 17:23:50 +0000
Date: Thu, 15 Oct 2026 18:23:46 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
CC: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH v1 1/1] net/i40e: fix compile issue in raw parsing
Message-ID: <atEMItpL-Wmd9pDv@bricha3-mobl1.ger.corp.intel.com>
References: <9e8c2ae1de56389366cbbbc2bf92492e732c3344.1792051372.git.anatoly.burakov@intel.com>
 <fcd72cd6-9db9-4650-9acd-293720699fe1@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fcd72cd6-9db9-4650-9acd-293720699fe1@intel.com>
X-ClientProxiedBy: DUZPR01CA0029.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::18) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DS4PR11MB057924:EE_
X-MS-Office365-Filtering-Correlation-Id: 18330fd9-dec8-4b87-fce3-08df2ae1143f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: W6y08L4aVwQ+/Vm9bQPyhwlGipgPP6cqmQBr1RMU6pKr/fEiUX94FoRpWSoB0LkZWKe18k+eIFUhebTYNtFRyaEN2PrYz6sEf/TDz63htd6vJp6bormG+tcuwNL+eNoIeHNUQWGNIyYpl1F0SLLHSlSeBEvYzBDhIY6AS4RRX6cH1Cp3eRtDYD10ifsax7syMidVnQAqviGz6Z8mdE0xuBI9gUdSSLGamAvHHtEZ+veTs88+myWUc3NwWrZi4yWG61oDBBUNBetKbD30c+41P3ooNVywtTH+SuOUAfeJloPihnCRIE14W0kEvSCwwWZ0S7XvnD9cEyazA7VEgSQxRvXmajyQILJxY5zRjFhGGewyeRgSlahCTr0FhDsjAzDPB0bofBrt9CkVHSaB1sFURp/9Jv2EAgK+fKMiYBLeoHKcyiiSU8wWazdlMXWQNXY4I1KxE1bvomfMPnIEg9wlNVunBGQhslwfdM/RL8l2f58Yt8RmYfYqNH7g/cOjwicPbXLfhX7apYrgoaaU5PEcE8RyYSbBxISTH4KTtTRkQPNpXfHI695+jm7erBeTInYGyiocuGhaT/oQnBGnjOqgCU4qxs3AaXzqtBigykQrthdQ2BVt/pmoAMJmyjpRA4dCPk+nHyPjNAvPKfM5/rAe9uM+OheG8anydEbp/EPEeRw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vB07J6v4JqAbXfi9HXcqhOYIKw1gzIvqJ9BpzCG9EagiT4SV1XP+VHSBhaCW?=
 =?us-ascii?Q?vDsIAXL73XVi3yvo2YKhVM2ns9PIi0bB9AFT+qw9OzU95kR2g8P25BPsvczi?=
 =?us-ascii?Q?ZV6g1VSxyeF7zdTy0atx+CFVqyWBC/cAMXynN5dgConr3X+tuuR32Fn1xe0h?=
 =?us-ascii?Q?o6YV+5XLCIl+aXYbfrNjrcBw8h3eRFi6wlClH7PlzxHOgt+wxQ8xrZk/FelH?=
 =?us-ascii?Q?1OO8uEWKEMTKMofD1JGvNhMMYdDAERSiSNg/dDz9XQJ3KFb5Ecq44GBifSvp?=
 =?us-ascii?Q?CdQ1iF7+nLEqu1Fhwen883V3Arx9bq6uAdxXXCvjRvhSBgaRGY4PvCrO/ISl?=
 =?us-ascii?Q?tI+wUd39o7twGRMnGmqOr6dQBGr/Zenb0qctLfzSYftgfbmt4VHKx9ahSRkF?=
 =?us-ascii?Q?lBT/s002EQnoGKd1Xbk2tEUZSSP5V2bDaL6IeEVuZ48H/2tQyEiMp0o8xMGr?=
 =?us-ascii?Q?f79iln1XvrRfMRPDFl3tLdwOA/6ZS2ATKEh7qsuUz0fLB801hHfCujV7PcMA?=
 =?us-ascii?Q?Aaw0s7pHcJhmsbnALFLldOSQWxQ3KYkMpfWhcq72WIk23CcbgiGjfI36Rh7d?=
 =?us-ascii?Q?YxljhjuUb0FTgjH4hCSq18byTJ7ghQZnCiEPTy8kXXG7TLwsKs73VsRF+Yr/?=
 =?us-ascii?Q?lzxF/134wYPVa9LzmsCi2Yy7M9hHyL8DFEC5iVz0yFLlT61Pa5zF4sjmKqSf?=
 =?us-ascii?Q?7D6kGZocE4IgutnN7HAeFQSD9UJlXlhRKDB6F4Hq8/MRy3POsrLGC7pVOHzn?=
 =?us-ascii?Q?XCIotcpli+R8sG0dZZnqsGoR6TPBKAwQsFnmcjXAbyG62Le51sPrIb5hukQ/?=
 =?us-ascii?Q?xE8x0Pbboq37B8pi8YBNY5zQK5+SF+g+lCeDBCjYkZYh6J17mrX/dVoA4OvD?=
 =?us-ascii?Q?KMZrxbq4vd7YFSDhHWc6Y7oyLv5wmijH0Of/31If+Kiz7TGYnFjLDXTklhA6?=
 =?us-ascii?Q?sg7YqdhtJp9JMZPRzoDEW6bQqkxD2XJUlRbPzDuNZD/tWT06IWxvJ8hZK4B9?=
 =?us-ascii?Q?kIVJiLOwv5TJGSfRMEZSHYo7Ngz9iJMfUBYFEIiflgQmq7/ArdbcoqLDs5Z1?=
 =?us-ascii?Q?8LnQl8qGxjSrwAVbc4k15FHpBSigXDE2vFMFJpS2ZGD2sUugQkkRCF+RbbAu?=
 =?us-ascii?Q?EDumwX2RqGdWHzpx39hVgEFuEBw/yIhd3WDE1PLXuGKw4TuQ1ar8oN7WdBAN?=
 =?us-ascii?Q?bUNuGnxkFmQBiBclFWpH/fGiPJ0IxdO3K212IPSIMj29g82c4TsBEZv/25kM?=
 =?us-ascii?Q?bbWEHMe6nJQ24yCpdozBmASOEfI9/49opcy+4HjX61sVCtTEZAVCxyZctpLY?=
 =?us-ascii?Q?ByI0pys94OCoW+TaBdTYTV49UuC2Bm1qAn9NNlMgTPC7T5RshYty7n8eo53r?=
 =?us-ascii?Q?HaNd7pFDwVGsfVgDxOljTdIHjRGt1m8zdhPwOOoiIh9f69AtrA4q46LiniRT?=
 =?us-ascii?Q?ynwnocvDjhrulMAMkh8p1rj2A+rfev9epXyT4zrcBHvQqxlrVYRxOPyI7VIh?=
 =?us-ascii?Q?XHvexQ9NN8rIjrw4FjmPKFQZioWntAXyNQU3WSyOArQX4Fhab5WU8a7xrhc2?=
 =?us-ascii?Q?q2qCfBqh7cf5Wb1Eh7E8coxFzGSPpJDahud+Vzf65d4aCHX0NuJMpMglBf0a?=
 =?us-ascii?Q?DkbfW5tgL8av0rGxicgY/6ir1FGD289HWPOf2fgTJuntlXdWBrPfvv2Mw1Aj?=
 =?us-ascii?Q?s+m7tP9a45ph7XefOSPRnuTsoJTv61+Y3iidgEt4O3DnzmAHxHsh9lTjj1kq?=
 =?us-ascii?Q?rfUHbIz6NhfcmDxq4JUyoSQXkTRUcWQ=3D?=
X-Exchange-RoutingPolicyChecked: Ve3rO3T8T9aITUfFv2zLSAQFsPan4Hig8vVgQjV40U1G+EY7QH2y3hJaRR8MOnRwY0BQzWiZw+eLmTWc9knO7Rv3BZ/DHkdQvsYwfy5YFrW685fqWki9Zo071BqvYJbz1mCGPAlHYCaGGo/gKXJm4naWyWKRpwjsFcnTH6IcyYpshZ2PC/FlZ6bPa5KY+9VJ7TwiaShAUs23AabeqaiVcZdCGrLuLFpQatR0HiZPxhzZ56puAJLVWwKWOBe42ZZacJ9QXLkkAniC/O+fWvRfpkTxxWCFwvevXWv4vA2aw22E1ud17mudx4HFB0Kvemur/9rbNb8vw3KTJJwDPgE+1w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 18330fd9-dec8-4b87-fce3-08df2ae1143f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 17:23:50.8538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W2+CwxkEaDxWtDUjFloouNBJTM6c6M3Uod+/dfZPEtNEhO0AtOrP5OIalbKv1EuY/bHLoqxUlgGVdY1CRKsB4xAwx8h2sJjw+oobyUaKfZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB057924
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

On Thu, Oct 15, 2026 at 03:25:34PM +0100, Medvedkin, Vladimir wrote:
> Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> 
> On 10/15/2026 9:02 AM, Anatoly Burakov wrote:
> > When parsing RAW items, we iterate over previously parsed RAW items. They
> > are sized by an enum, but we should not be using an enum for indexing and
> > comparing it against an uint8_t RAW ID. Fix it by using uint8_t instead.
> > 
> > Fixes: c8f6ee59ffe6 ("net/i40e: reimplement FDIR parser")
> > 
> > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > ---
Fix squashed into offending commit in next-net-intel.
Thanks,
/Bruce
