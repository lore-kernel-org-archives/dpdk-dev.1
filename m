Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA1AC79FB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 07:48:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3345406A2;
	Thu, 10 Sep 2026 09:48:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 468484028F
 for <dev@dpdk.org>; Thu, 10 Sep 2026 09:48:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789026492; x=1820562492;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=sfVfpou/Oq72lb81pEOBx9IAMcZYvdjcb9XFMj035HA=;
 b=mOH8hMCbzM2ZhdyV5aatHSG3wj/T3VDDnQaz/l3JekCneehMfZCgCuQ7
 SDxyu9JrR6HbQ75buQR774idJqgnO13WQyjN4csKv2yPFPNVCadwthZR6
 3bT02jYItSiIHqwJDVprx+rzz/1n9nxt9TqflhCg6Pmknd13Wi9vZU5LZ
 PYXTtVF+wLa+FwqefVJvLrmcuZolxpzUhppkZbUiwCASq92o1ReOfWUPk
 xfhzd15RNS/a4o1yEsri02/iOia4M/8HKbfGM/Tj2ae3vmIDgW+FjJ3IT
 FbZX7ftQ0AQDtDjMIA6nkZq1oFuqfnAC0ZL22lD0bEFWiGk4O3/DHokLl w==;
X-CSE-ConnectionGUID: VfwYhQlcTw+1DafdtEPipA==
X-CSE-MsgGUID: Ykf95FBOT3yBg8xXfi4ozA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="99797852"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; d="scan'208";a="99797852"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 00:48:10 -0700
X-CSE-ConnectionGUID: XT7VZVONT6mCRGZlbukMUg==
X-CSE-MsgGUID: B8psWGX7QU+YsaX9ZNEH5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; d="scan'208";a="270201771"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 00:48:10 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 00:48:09 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 10 Sep 2026 00:48:09 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.38) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 00:48:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Os/TFbE9EixQEGyLmRvx4qg58m70kI01CDKV/JpUbCCY8ll1hGAus82xmCZqgkN6geP5kBMB3Ya27AP/aHn5Cpa8oFZU1jZJSDPVBgw3IABVhlOXguAmL/iWknYBqnNHLkR/7bOetBsX8n09V2z2cjEbwuxfbEiHATwG/O6iFNQHJ5VJWsRuKjrztrSi+Z8mNSYy1kvVsG2W+Vo+fxQx572Es1TQZZ2Ca5J39qmy1LuZsCBZYLjEbTJMBz9x9Dx2W/m/hvZEzO/fWdoJ646vlXXo+aWlbX0m1DIQ3bxAZmgL+0A39B73FXQl/bKWvZkzK29Zl46AHokbByMLPoRK1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGkb/l9Dy41VJkCuo92kSOAL+EKJpGysZ2OXsoBw4oA=;
 b=jVi9R9XqmXv2rjQrJ0QxdC53g0KuWHm/cBx+xzMBCSnFRTJ3tSQJ7SLNnexU5D8r6cfURIWTKM3odOZIUMvNrZcyX56ywWTa77aOuFZpJTPJ9MLhHf9s3Xrzxq0VaM8jdO1PLa4UPxGhpq3ivIW6XZLrroyXswbU91ZLMe4kCZGYOn8JgE7WESuwcuEE4iIwJ0mvc04vjuFNTMipm0kgiUiF2cbzOK1rXT1KCoAx5/IRFetOlTJAg0F2B56rR89MKBkfE0lknpmRrJlCb8C97u0qC+MKz6MiCs7R+ztPH0QVcd6gwSagT/LqOhMoJHb6DN8XnIZFBQWL0r0cegG6IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CO1PR11MB4881.namprd11.prod.outlook.com (2603:10b6:303:91::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 07:48:07 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 07:48:07 +0000
Date: Thu, 10 Sep 2026 08:48:01 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Atul Patel <atul.patel@intel.com>
CC: <aman.deep.singh@intel.com>, <dev@dpdk.org>, <praveen.shetty@intel.com>,
 <dhananjay.shukla@intel.com>
Subject: Re: [PATCH] net/cpfl: fix VF ID calculation for vCPF
Message-ID: <aqJgsdqDhe2u1QW0@bricha3-mobl1.ger.corp.intel.com>
References: <20260827212216.765057-1-atul.patel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260827212216.765057-1-atul.patel@intel.com>
X-ClientProxiedBy: DUZP191CA0071.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::11) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CO1PR11MB4881:EE_
X-MS-Office365-Filtering-Correlation-Id: 41d51d81-41aa-493a-ac26-08df0f0fda16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 5hlaiOSoXROd3raO/IdYy6TuCsRSlVMrlo2qYytg5uEGBAVA15itB0tCa4ewzNkH8pHDa/8SK0YVoMLRx1TW6+5FfY976sCmbTKYZfSTPJXW44op0YSsBozGGE9uuySnnCATC+3ce3IzCboTmRLmCmciDRHwt/59fMIM2eKKX6OX3wVPZfjdyg1kcHQAKdFZ39qNEAJYq6ag09LBnl9JfyjL1mrXCuWYIG9A+BUH3SFqmdUT3smpCCOiiMsD8LxgWrFq6lyMYeYRpT91ygSQiXAx1uqgLHe/vCVZRsP+fD8K1szQFG6cUoupT2DOxaOwhpYEqBWMiIM/URy6J4EIVR909HvSRVVOZ3Mqs9tqQCZ4jSdIt5WTB3HfIohSOmf+PELafpSe9t+CVQI57z0waTAP9Sy1/nJsGPyIc+Muw8rn3+1UDZFA4/+AEKU9/DFd5fawJYY1DZGA7HaSpksjjkw/9d5HObazrO1c+Vnb0m/eSKuFWB1g9XoKC949rDiF9qXTPd0+tpM+iiH8vzh1kVw/bLZq17rmIfEGjoOalSP9F2xhm08DEGTQ+/ibiToDH/cZidvpZg32KCuGXlhrTBX8EpVjx+0gyWKwE1bZYHpWARB5HK8x2b56QKDyfiDZrSV8XaYkMfnp68wZaVM8ztLv8hgW4tYdAvqtsr9tNsM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UIL+KZb7zoaRqI4ohRwvjrOijsSkW2racYTK73MlR8IXPkM+mgvAt6SAr5+K?=
 =?us-ascii?Q?GFyMFnfD/vBOJzjoC0V5sgIrDs8iNXBsaEAT/LcCdLlPbScIMBbucrGSH01R?=
 =?us-ascii?Q?ELU6FkJSuCf+M+fL70lqgNW3iK7TFZMRySoD3IUqsxIGFb8ekOlZ3qddu1oz?=
 =?us-ascii?Q?+SGuSMrJF0Fd71WF8aaK9NHZMbfwZTx11lEu6P9ZKbyEEmiJLbT+bNIP7u94?=
 =?us-ascii?Q?pgQVhrbxVBp6bw6xYhZlSD0sOzmRRkttAnyGiCqtGD744vTpSnC9oYntOqKc?=
 =?us-ascii?Q?10OaLxqdd1rZws+Nvp0O0DtrFCsMuJ3aIinOX+J13OpUOaq97znA4sgiXC2v?=
 =?us-ascii?Q?qy25G7U3actmQy8T4kEnDQIOsirNW6GoJtnU1TV+adePmTefLLfi/63cRrvT?=
 =?us-ascii?Q?Wo6yzSezLMNS6N/Oet66vmkgDMMd8IibxMBTn/Kv7E641xuPV8hxYCiqJDq5?=
 =?us-ascii?Q?EZJDMlaaE4h41DRP8ZvTs/KzdB1c7H+VamnDjXfAKy+2KV0xG+4V33mXBjSI?=
 =?us-ascii?Q?ztD6dlk5JxDh/l2v4V2JYAK2jkJjbfv0AOY1YOsZcbHgnIeCG7KwiO31mzHN?=
 =?us-ascii?Q?j2R3hPkigfu37v31rkzzEJP34TNGs5lbcR2j0EAleiAYqB6brB5yiNPNUwDX?=
 =?us-ascii?Q?0U1OsPtvK8w8iOvBZmalVNF9ZHt99ybukNxU/cwJNfEZhQARHNQX+wGe7f1B?=
 =?us-ascii?Q?6CJTPqlbgakSaH7cx9k9MVUP9cx2vUeKBtFZrHVEXcdPPblNpfxfRkxU0RJb?=
 =?us-ascii?Q?D3WCFTaum3h1ph0p2kQVcRtNJjWIoPGFxjcPjQT0JUbddFK5hDUz3k5qjmo+?=
 =?us-ascii?Q?LMPtL4wQ/TpPVgjQm7DixhEZ/lVF8Y0E551htMOs/M7B1Cy2i/EyQZeMBK6z?=
 =?us-ascii?Q?Xi9GQndWAHIqFthNwOLQJM3EYkhy8o4TmxFl1Kgt5xgXMNS0lyeqfS74/iKd?=
 =?us-ascii?Q?R74JKNUEIhu5532Wjmj1w453RSnYYJrSKLKcaP8awCInKgkYhuEuS+J88HE8?=
 =?us-ascii?Q?z/4tqWmrZ2pSYMCpqykFkRfDspOx8+Hp7RUH5CVK/gJR+wULdFzgPwF2kG7g?=
 =?us-ascii?Q?Td1uzVWY01slmPuJMpk5X7N9W86/b+rYXXJJHg++e6vXphCDHv1z6tchbCER?=
 =?us-ascii?Q?MHWrGIPPk5SRBy4JGcmCpIsqpDChSsTDCjx5dmqAoP7Zd2jhjUEXlWwKQZOv?=
 =?us-ascii?Q?xx4aCsgFHPjq4MMQ8GZAWlHEz6CTAVFpkXvADWvhBzRLPyIRYe9BIDIsPcRk?=
 =?us-ascii?Q?nt2oFcICgVz1a33zfnF9Sh2wotlbKzq6Xn4YPZ8rx6Nw/biWLhOJzWYptlpq?=
 =?us-ascii?Q?+M5Qt71d4T82F0SpR96dFOjbM1MqJdCOQgKjhvMINAbk4uVGL6DKrR57rXA6?=
 =?us-ascii?Q?Cdr/CeM4wZAYTLOO7fgr9Lgy7CqakdSNH0E8QCatLTiYmrZ4UqS6OSdj2Fh1?=
 =?us-ascii?Q?CJeI0Dlj9N7tDo5znaw4Boi/OZ3g0gVX0kp+Q6p76PEvnXrWrDathacAjybR?=
 =?us-ascii?Q?oOQ2e+6qA5yOMj5dsIR4Z9aIbY78cM/XAo8IuLoPl41GVobOx0AKQF2KTM4a?=
 =?us-ascii?Q?0Hfor7rRs13t2S+14BTxASEhynck4MpeJH1rXCNIMuq7mqVYJ9SQ6xzHPCnk?=
 =?us-ascii?Q?RLEdveDxHHvUsrKk6YRyIGSVwuhcAILt3/Xsffow9+T49wdRlXECC7orXNS4?=
 =?us-ascii?Q?xCbRBPPHA8kVc2zTK6aPorT1jCKNUPpe6I936DB8k3xOXuZKNS+EG1lUBktQ?=
 =?us-ascii?Q?KPmY2shpC7O3PGmxY0AZ4BYz0RE09c0=3D?=
X-Exchange-RoutingPolicyChecked: S4vrXgsK29+ulqMqhJCbXbP9XV+wAE+HFzaajj5ObqsH9x3E/WSvtSS1S6mem1EoUSGO6iEvtW/hGtvnkOEDYkuNH9SkB9HZLKbHyVUUwZTvcnFFqlwsoRJQGXNlrAXzSTLcII44i5obP/E7+bOwLxchuJRaYdAbiBxNrqSYXpIctoT1gwKaydtIppdaw3+j7ozEhJ2vx58szza/7Htxpxg206BrrFjnhi2aLRkn0TcXWdkYHw8PzSpT1N3nmp9ltCmS+zCYOJ9to+DkQ3RzO1VXEDu2/CgeevigF7mWEQDYhA21U+IAti3I8oRXUUYdvvNoTMnKzvPfAVpBf5kqSA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d51d81-41aa-493a-ac26-08df0f0fda16
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 07:48:07.0371 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l3hx1E/t4/9PHeF6j4H7/EfaMlntKJpIyuKEzJtgpaW6dHYHTCC538DBfJf/Hh6tnUhuJlG4JZbKXnXBbhwSE4pIzEnXIxMon5fUUWxvxK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4881
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

On Fri, Aug 28, 2026 at 02:52:16AM +0530, Atul Patel wrote:
> The VF ID was incorrectly set to only the PCI function number,
> which fails when VFs span multiple PCI devices (device IDs > 0).
> Calculate the VF ID as (device_id * 8) + function to correctly
> map VFs across devices.
> 
> Fixes: f1ab44fb0ebf ("net/cpfl: add vCPF port info")
> 
> Signed-off-by: Praveen Shetty <praveen.shetty@intel.com>
> Signed-off-by: Atul Patel <atul.patel@intel.com>
> Signed-off-by: Dhananjay Shukla <dhananjay.shukla@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
