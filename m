Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5C7EA811E
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 14:13:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3967E400D7;
	Tue, 10 Feb 2026 15:13:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 05ABC400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 15:13:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770732837; x=1802268837;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=GkBWumFQf6Vh3L+QXGwGtMMYOYLA/cfw0SMilhuizjE=;
 b=nimcK00LJKSOLWU4XBp44iTDwCk6L06OTsReQ6p5zfFPCWG6o1LAkTul
 0wLNng0xxHhLhyYFLIazULMx2Lr3OOenrsYqZpmYNZHhvn2yfkJlszWcM
 IioSbWO6vsiMOS9LNL1mgtlxJ4rnlDsHvPQH4sqTB9TBXU//Qr39yU8AP
 0aXOp7pVLH9CraA+/FGLothlB4ReFUdvyHHRmqNcKUCJrx8/K1kk7pCV8
 Oo9iSqmQFIRhv4/Dy2xlXoZYIN3AxjqSbrVEoc1+zm+L1iClk5PjbRimo
 d/n2jhGf/7DhrdaYD03zoCN/QlxvCOAjRkHK9d12sHpbCMh60YGWPYeaY g==;
X-CSE-ConnectionGUID: RRzFWGXWRpSl5uaSY941yQ==
X-CSE-MsgGUID: 3oKs/UpHSciuEGkHG7ohUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="71072513"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71072513"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 06:13:56 -0800
X-CSE-ConnectionGUID: V9NRPEGTRJGITywNty6aHQ==
X-CSE-MsgGUID: tNxyA3j9TPC8gW+2L1Uk+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="249573640"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 06:13:56 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 06:13:55 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 06:13:55 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.38) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 06:13:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P24Kc7bPcck5zcw18r4wyRvvHi9B4o/lvg308XbeUGNXI6huR6qo7g1N3O7qF/9cS+RduR4bk9eNZLYNYhAqPJpOBMTZAlYyY6zGP6hoT0H8tZ0EzyfaYDJOjMfBEGDvLYQQvFtOc3yjpZXTheLXcyKPWQH/JlWmhn5RBYuUHC1yOLLcx9FjwBcyK4JTSM0BJe0iED6uhVlIEEazPe6hP086Rsn+ud4wZzri8pIVMtzy9lHa/gJQ/LYpIcj2EssTEuAShSpe5o7vKOzIvq2Uqf3f7dYQaYqsW7EYk8cvtR8EX7ULSLlPzQ9R9W2yz4JH/e645x9PguIAjmSViUMHww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnfVsx79KxLjv26tOaoIARLnF7fLGMa09lNwYeVsT4w=;
 b=XhEbnPgfZNEQnGD91PaTd4CKN9MPpO0MZxGPmdO24mLHCHAd5xwqqLiPw0HiqQIQys/IH7MClgKtkiG4Xn93wcvd6Fz3gmVZ8Lw4fKAfkTLbho++a7bE/w5DrFg5Z9X8cyq/+LH0giCe4KyJAqJrkPTNSDygCDQu6qWwaMvZlb76w2zDIzO12zt/3X9hI/xgcuiU3GeO4QBoCDzq5vP/SZ9Aebn17DCgJCYVqGk2culbIZEGi7M/bWnVy45c80UwWWUCvTlFUjzYrOw2OL39opGMEM/zeB1UNF+OuZJ5w2DbapWx+df/+O+KXLbVfXhY8vk2Dn1WA8P3duvSRzfM9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA0PR11MB4557.namprd11.prod.outlook.com (2603:10b6:806:96::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Tue, 10 Feb
 2026 14:13:53 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 14:13:53 +0000
Date: Tue, 10 Feb 2026 14:13:49 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 22/35] net/intel: mark mid-burst ring cleanup as
 unlikely
Message-ID: <aYs9HVCcD-TwnoUr@bricha3-mobl1.ger.corp.intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-23-bruce.richardson@intel.com>
 <fbe24b80-d463-4dda-92ec-9c8a8f702a63@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fbe24b80-d463-4dda-92ec-9c8a8f702a63@intel.com>
X-ClientProxiedBy: DUZP191CA0002.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA0PR11MB4557:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fa8cc44-40f8-4e20-e334-08de68ae9f04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u41T3OsatEHIDikROL7rOe30/uplGrSp/Grohdt3EKfv9ei/C1SPGNzxLIgm?=
 =?us-ascii?Q?fSFM8irYHwZKcMWgdHJrQIJ1xa0/o0/BAffQGgMj/H1iN4elHCZeTdKo7nLA?=
 =?us-ascii?Q?rlHEAyFFFlHMaU9M1ROMkTw+LiSVYQF2pg+d35Du7bUfaVVDa+eGWhZMevmB?=
 =?us-ascii?Q?FU3j32tP+DwUPp/FKQSucvSlmbo2eYWdbij3QCliZyiGTxsO9s0l3hqbp2ip?=
 =?us-ascii?Q?+p6/ESBJECNXd9eqL79viwrxugHmEtZiPnJ0PYdGgjQt43vgq/ZYzkNGPwgn?=
 =?us-ascii?Q?r8Qgadny0ieVBNMwWoBX/M1k2hcFFEjjRKuB6pBANIxCQj2C0AcMsCVWguX6?=
 =?us-ascii?Q?H6Q9LBynUl8RXV+LD7UZP2B8ZvEsx1wlHsyaSA77NGci/oVGrVEezt06LdQA?=
 =?us-ascii?Q?XfZe+DvHBU0nlmHiBsMei+wyRS/tpS3N17aGM/gxfa4QB9sGlwIXTVqL/ehg?=
 =?us-ascii?Q?PVZBRCu66MToPT/DqOkfPLK/ItnTEHbvXnvirL6VgIG03//kwkOfrRUDKv+c?=
 =?us-ascii?Q?66ew00BBJWB55TGk8RjSK5U+vM/DBzJRkaCpoYb/xRE60TNMrNULkMdT4EUo?=
 =?us-ascii?Q?DymemKuVYbcLZKeK3soYXW1nabFX7O+I3WuVjeRy2Fih+zbAWf+oonTa21zN?=
 =?us-ascii?Q?MLPp5s1NRYi0HNK8NUsvfaaTT8u8yd4IwMXimI/EFFBrDmyQreEcn7eOK438?=
 =?us-ascii?Q?cmfOssYFrzkdcCw/EG7hNGZiva3itd05uKMHSpYxu9wn5wHtSm5dKQskfV2O?=
 =?us-ascii?Q?eUN7xjjEj9i+I0Wn+P6xsXwusEUVJXAscEdHgb/luNdIjriI6gUStm+Q5+Bn?=
 =?us-ascii?Q?VtcyGhnHGvYFdJQdR3gjRR/8zNy3MlYWxuPUq18FpVDMesYWtgspQFB/9bH6?=
 =?us-ascii?Q?Pb5Dql/RBJ0dBuRWYzWhzd49xPB4xV4SEzJabZGhwbVVAoHNfm1FmmoTbjzw?=
 =?us-ascii?Q?q9dXaRmXkg4njKO0T82RNgOmzALQs+LLboEH+ZWF38ID/cqfScIXVDiWdExs?=
 =?us-ascii?Q?ski47KbtNsfbqEvg+EUYcf9P0RC46utWz7z+FiMKbW/0+LP3ncr1h+3bFJD7?=
 =?us-ascii?Q?KYP6Ql8WjxJl4z+zPpy+37R6DE5EYJuDVPUxMZL0YUzCJ5c8QUHqtr0Yl+Tu?=
 =?us-ascii?Q?3oxMaHLCJvyEVOFCjgYaF1vbDfNTMXKXweKSU100wFMm/fOMN5G81ExLUdRX?=
 =?us-ascii?Q?FWlUr6zTo0mf5IB/5BDJmz7MtLaQDxIMepGKjrzxPnDSEfHDJd1t+u5dG6eR?=
 =?us-ascii?Q?DPhaUWAqtMOdIkOGlqcX7pv22ZNJ6EmD1uKf1K5ZU+NMhROupYgobBEljhmm?=
 =?us-ascii?Q?BME9lEDhMIn0ILo8XC5u5lYzGgBBodbrZj6clBl7z9hDAyifuT/x3ua72DQE?=
 =?us-ascii?Q?ZKg3asvZylDqI0PpNxFwcLleMO5FrrIOQYHY4Ppq6yrNeRb7wbFZd2KCmAdE?=
 =?us-ascii?Q?MuWrHYgtvd7C7d55riZb0ODb9qVpucGmYuwk6JMBbco/ot59kL9TWxuR+Z6h?=
 =?us-ascii?Q?zISqB3hyQhoh70bpZGSQZHmG5kKKaG9lUugWgGeJerDjB9zruiG0SfKx4Mk2?=
 =?us-ascii?Q?X2RsVDxsIoxzDG2k9xg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tIBSB3BVzR0fV5r1ZrUkw8pxIK6HaLmf210trd0UaqlHndk9F/2sALSE+JLQ?=
 =?us-ascii?Q?TslgnYQef/nYZoUt5bdc5G9oC9z+wKbesay9pC2tA3zASu5+zxmgdR3ncJ17?=
 =?us-ascii?Q?UY14rY4Pj9tql70GLkxVj7GzqfqTYDRbOn/qSqt4sjDvZBo3YZOUdMVvZS4s?=
 =?us-ascii?Q?lgiFXQiMrTl3W3ewQTxiEuHh43aeZFSYFZwwfVKOg+czsDUF9X4kQZZwGTnN?=
 =?us-ascii?Q?+UdvyjjbWfcPE01lnuPmM/WsJPPIK4j0WVd0RT82dUyFvSUJ5AYjz3zwAphn?=
 =?us-ascii?Q?yOEuYPPDACng9MXXcCnVnWm/ahPz/AcrIPFfyMFUZB7Wrq/QbNhXSs8Tk0/4?=
 =?us-ascii?Q?pA3cWroDFvD+tROZDWcelqw4A0s/BngSOuuqcJ8JeRspXZ9cth9vZzygRcG1?=
 =?us-ascii?Q?ZbX25dp8Zkr3c6DWHf4de5JbQVac3aNm0jNbWFiuOFm8dFHQGXcv5nlAZv9e?=
 =?us-ascii?Q?UhBc+C1pj8jD6LgbsbwiXbiINXGqTCdf8d+ZRZH1m3jC6Ysd/SQNhz5Q05CH?=
 =?us-ascii?Q?eVNRjBVY6BcXfeEGVztvcZmZSpa2B/nuoh6Yvz0+AIZLaWu5EJSV569PhvtH?=
 =?us-ascii?Q?1hWRifznuDxHXAErrO7rwQCkTql62PHUO93oIaWNpIPtG9p3z/D8oOGhKTnJ?=
 =?us-ascii?Q?FjT3qQTTPP43IV0QPRBxploqDNVLsMy+qnWft43cNg54VnrfbMn9RXVvcLCt?=
 =?us-ascii?Q?4xnJEO6HtiJT9ROmPHTwtbgHzK635POHNUO7clJXVtpTQe6T2cOMv29N7BrO?=
 =?us-ascii?Q?VxZiv1RQFDvl5C3hkTInVCeir1YQUdvj2fTCgy45yr7b4rqvXWp76JJ4H1LB?=
 =?us-ascii?Q?Ta6q6YuCwsjuD6EdvIFqOUZyYqrkN3mCWC91UTpNrRF4XK/drNQjmNqldFv4?=
 =?us-ascii?Q?RHLr3PzGR8zlvsYjvPdVc8vKplLzSNB0lrxlJEwACJ7XEC/FBJlfQPSnYR6B?=
 =?us-ascii?Q?soguQuaeTyVoCq0fDU5TOM4YpbrJuMB2tqX+de9BjT2QLvbJp+xC7vKUhSUV?=
 =?us-ascii?Q?b32PaIaL3SIcjsjmCyN8fAtcRbJIJsIrfXl+h8lfHEhXCEfkCf/KYqtMZ91g?=
 =?us-ascii?Q?tT/W+StuL1HwFT7TqX/QAVRXkk87ae9aKRKdwuNknPyfqGLZ5kqEiLVai6py?=
 =?us-ascii?Q?p5iUSnRG3QQhET+RDcsDowNmVkHUe1u+zbqKBv96X7gOprlpTl+217rwTtgR?=
 =?us-ascii?Q?8lXREL5wPF1Aghz51K5htefJlfSLLiDSwy5IfQ+fdffVr/+WKBmxCag9PNFS?=
 =?us-ascii?Q?lMvknJF3m8Tn8lnHq5jjWkyIYARP18W7gqZfj1yJPb06Ur5smy/KElJ8n2By?=
 =?us-ascii?Q?6ow4aPWIKHX1173OxkQczFi43/dYkCEPdBbmBJYorZA0YIwQpCP7ktFJgImf?=
 =?us-ascii?Q?WViTJ1YrwtbNTOFioCbH3JoUaN+kDKWlpGgXIthedAjQ6xrUE8gy+FXPYQDn?=
 =?us-ascii?Q?p6M2+6asySu7+5iDh5+t+0cqQuDpwzxgQUUacasI/Z7TdcCllEC0qEEAwypD?=
 =?us-ascii?Q?f+0ouQjydeJ8lXMIugDIHn6gxURUNf1IBznIeaG108AkjCwVv8eEkoUJp/N5?=
 =?us-ascii?Q?JyI2ms5Oq2rpM2zr3cbLjjHE8QAeAG6NpTkAZfchpsZ38W1ttOe3gOmqAajW?=
 =?us-ascii?Q?ncoO1/r2JQG+fLg2AOfgPat76oTa+TVxlzdNrh6ME6zm5Xu2y7ct59NeFfw3?=
 =?us-ascii?Q?2zyaQJ23Uwnw2MdKIQOlsv4B2fwwnA6ilSE3zMxoY486CeAg5sjpxbJ96zCD?=
 =?us-ascii?Q?3aSCCAXTK8fDxNUg0fgz5i1cLq0hWRQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa8cc44-40f8-4e20-e334-08de68ae9f04
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 14:13:53.5659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dMa8HB0/AbcmqJR9u1gMwqUKChX5URCUZfz8LGldu7ukPKF7utPL/p04eM7v8HLGtq5BneFaknp0H2wv+f0CZrgkJN/PGlBR5KnFkX4nAII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4557
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

On Tue, Feb 10, 2026 at 02:36:56PM +0100, Burakov, Anatoly wrote:
> On 2/9/2026 5:45 PM, Bruce Richardson wrote:
> > It should rarely be the case that we need to cleanup the descriptor ring
> > mid-burst, so mark as unlikely to help performance.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> 
> Does it measurably help performance? I'm by no means a performance person so
> this isn't really my wheelhouse, but I remember enough patches removing
> "unlikely() for performance reasons" to get suspicious!
> 
> -- 
Yes, I tend to be suspicous too. I will reverify and, if not measurable,
will drop this patch from the set.

/Bruce
