Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05323CCD1BE
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 16:14:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59B2B40151;
	Thu, 23 Oct 2025 18:14:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 5008B40144;
 Thu, 23 Oct 2025 18:14:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761236094; x=1792772094;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=49uO3JTv5IskYbW4D76HkozSFb7kKtcnskht3nma5pA=;
 b=aazOG1KvdSKbjEj/aBKdAVG5PTKGTQKqQ6qlU9xrI93pk/wcSOCSmdqD
 j2ik2C1WPrUXOeu3tZoeS9WVqcviUStYFYwh/eqjA7/a1J3mQJqxhMtsR
 FZ3x7vfGs4vvay+kAIo0a2yqj9xCaiKYmn6pctgmGALxG/riKDUeyvf1K
 h/hevmj0YaKvHxKWPL4LOeIKPEbcZRbQhraKWymcg3e8FECpiddqlFZl3
 i9HSP4iTaJp9h6X/AOuTjCV4JPOTdwI8R72pua6B/9Cp2UluhxTjVuD2w
 kT5wmEZO6PbqHyEQQa9Ib7xH5pgE0ffUJ0pfDol3VZCVziysdkvV+nSj6 w==;
X-CSE-ConnectionGUID: 0NQy5xuJSKafFKVsymIVmA==
X-CSE-MsgGUID: 6IlvFWJ3T4CkeERW60aTbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63448680"
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; d="scan'208";a="63448680"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 09:14:53 -0700
X-CSE-ConnectionGUID: kM0HOyvtTVCWsAsv+OxQMQ==
X-CSE-MsgGUID: mnZXNU3mSMWRXdDYJtiNTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; d="scan'208";a="183371799"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 09:14:51 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 09:14:48 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 23 Oct 2025 09:14:48 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.70)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 09:14:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HttMBXVnjTiyBwbLi3KkyD9QnkMTFaQsDqkBVxcuIRV535UqfLOt4RPCvx6A+Ld5alkjCL4M0jD+Mby6tAA+K7E0QUrfRh7H4UUCIAl6MiKhr3mh02jJ3D7dK+RrEWMEO0LxSALmqEGlb/HykgtjrMOLb7JjvSpvuXeD+cpBOaN/wXl1UoVJEoZk7omZSfMSlwlnHX0rdfuPsLMvJt0lUUDOEZ/2xjs50SUachOkmzDOM4sDRx/xn+iEnjKhx6O6OrHrqo3udtszq1plcZuaT94vF1Vm6l9WnRhS2wxwygAU/ySCzTX+P2VYWUeBGds5Nskc4puYKcPKlI9ltMbU9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUoRL0glNXAlX08Vb6GU15iYBtwzwz3DaOXs2J6Rb4k=;
 b=fOykQtokrDuY6SpYfvvrms+HOw1Vw2JOhwSNipIwqHlJ5CKRYwhGSsmbibrRfdE+1h8G2XAHGOFnn8ZpH6Z+s14/k82ljLrLzchCMXDbKa19p4/fwKpJrl9k+daUQBOh2TSsnAF4zPOq0GU0IzlQJMPk12rm6dEWgfmAVAGP3zNYmXm4DRnMci80kXddvKpkJ5BeY9RijJaJonqB1IUTrEGVr/mrAnOILPBDRC+i8DJ5uMNnZhze4JWdNWWetzDvbNkiwgchaGEk9NQBPutwcx/GB7wj5Grtmn5DLbktAje1N0pP8HTXFjWtiafMB73F0tXc/G5Fj/6gSSJxVkkqsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM3PR11MB8671.namprd11.prod.outlook.com (2603:10b6:0:42::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 16:14:46 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 16:14:46 +0000
Date: Thu, 23 Oct 2025 17:14:40 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Reshma Pattan
 <reshma.pattan@intel.com>, Suanming Mou <suanmingm@nvidia.com>, "Anatoly
 Burakov" <anatoly.burakov@intel.com>
Subject: Re: [PATCH v4 2/8] pdump: handle primary process exit
Message-ID: <aPpUcBXP3xpeaKM3@bricha3-mobl1.ger.corp.intel.com>
References: <250811213632.16023-1-stephen@networkplumber.org>
 <20251023154748.38535-1-stephen@networkplumber.org>
 <20251023154748.38535-3-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251023154748.38535-3-stephen@networkplumber.org>
X-ClientProxiedBy: DU7P194CA0019.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::34) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM3PR11MB8671:EE_
X-MS-Office365-Filtering-Correlation-Id: 0857da65-c471-46e7-d0e5-08de124f4859
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s4mr2crmRNV8lZhQSOAszxjzYmp1XpAdc5R3GfbAdBL8ZnM3/HAAnOD+813x?=
 =?us-ascii?Q?+8cFLUXQHoKPe0Alm0CN5ujx93XFeEQbO/Vx85aDhEPaOGQzT5YsxaGQZM14?=
 =?us-ascii?Q?EAvlSJU7tzDZLj99rmQXVyM8FaVldGlEL8Xw0LB8jnAgw3bSB15pE4JkTbHB?=
 =?us-ascii?Q?ZBBoojvLzlekcVYzvEEWTAuZWwMe8slACY+JYYy3KHrQ+zpnU6pgOAvOWwe/?=
 =?us-ascii?Q?qzFRX/lw0Yf67BySK9EUJaqgOr1KtJq6zZM57C9VyE11T6e1n+rGq5KvLNOn?=
 =?us-ascii?Q?48tXexiYKMcAI13Cf5P/1rF4Pulo5tSIziEmUfnxg4ZPB+PUoC42L/5byr+b?=
 =?us-ascii?Q?+a2j3a+QbOJmtpPeKqUbDZsTaxdRhqEZ0UWq40vx41zf1w+qDRPlm1FoVEXl?=
 =?us-ascii?Q?AJGQ4qulnAxib4EBFRl9FSKBcUaPRt1btjKOGMALQ75v6bNuFu2RuSZ9vkZU?=
 =?us-ascii?Q?MMs1kiKXlFU7Vkz8ThpUknfuABeb9bM+5a8uB6B7+nUQVtfr2sQD20uvELYx?=
 =?us-ascii?Q?COrsd+wdnAx2XjqDIliw59TdQNIH1gxmZV/6VUjYWhA0+XxEvCX7JZfirFe7?=
 =?us-ascii?Q?QirBEf4FOFmbngyxbIHMqJX42EAD8S19mltErmLkg1nMOUS2E0wl50SJTQRz?=
 =?us-ascii?Q?NzSM4OcL4Ib+u7SfksuPuIey9Oxtys1os/VcuaxHQal6faMrjIS+UHwKpF25?=
 =?us-ascii?Q?gcqLMRjijBzyADIyykYDxQW9wEZkiDbfsVFknpFWfmWY1Gv78NCevzyEjGGP?=
 =?us-ascii?Q?BFJj1pTbjvJhPiwx+NAQQT9OR2sbdh/bNlT8Xmuflixc3mJcQ8+WyNKdWUp/?=
 =?us-ascii?Q?tJOKZSBVMw2XbDrS4hSwI61ahkq6B0U4xlFYttprJLh2j6aVMHKu8CJzvmmC?=
 =?us-ascii?Q?fkK2Qe4D9gspyPZJlxbQ1O5I2/QnOVHzpdO60bBs2fkz07u6ysWPiYEIC9WN?=
 =?us-ascii?Q?fkvVtXHymsZDj/RVfKpQ3MRBlaGtIKVFtz6GfnV9mVmmb89t+ePSw0JLBYkz?=
 =?us-ascii?Q?v+/18Xa/TMoRzDJC3PwnjlOL8VOpG0MCJnNZlIlaeEy9V3Ty24yt6y9kT8kP?=
 =?us-ascii?Q?RDnfVMEnMQP1dlmccIFzQVBrzS1Jwn2GIPXRdAmjsjMk3EleMRt44n96DbUg?=
 =?us-ascii?Q?tsjpsUCXHWi22K//+EMlgSN7VuXsPNbb/U/1B/hS4IBcWbnJa/c6R7FQgVd2?=
 =?us-ascii?Q?EZCdxFC7AzW1Wc+GdoUyp55SQ19Id7JanQjzsqKFQbCyUn8fPYkLb+vZau9C?=
 =?us-ascii?Q?6s2YJF5uhKwTDH4aHFwf96Rkf+noKoMXGC7TNqZdDgyZ93yvY4e/jU/j4RxL?=
 =?us-ascii?Q?alBB1jWZLefBNtkADRxa6sk0eEzV0FPogcmH3Ce7CMbpvSN9wAhotq+0IJRM?=
 =?us-ascii?Q?nCTO2sK6UH20kNIiC+MRBQ4Epd+2T6MQPytPd4/pc5ZLtvXWoO6tkFX0kjul?=
 =?us-ascii?Q?RRJDoELMKuR4Z6cOtO16z9Pzj1NIHphN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PW35Bm29o6c1qME8YCo5QtoWx/qpF2GxotGegiRlUQJ2DnhS5D0k1qw6cQP1?=
 =?us-ascii?Q?LI1dKI6jgH+kZOY3qxlyDXKYC+V1VD7srJH56gAQ7TVOHtBLiAWZ3EcWuEJK?=
 =?us-ascii?Q?ox7UL3xtNWjvQmiixbg+xGXz1c04JnGpJK+rbuXBF6WBZBG8Ed2BNVaqq4bT?=
 =?us-ascii?Q?/498MylzG2X03F4FiX3+okiC4Q/nfPo+Vo6znMeB54OUSxK++UrFQJOBQeMc?=
 =?us-ascii?Q?rzx2UXt5pNo0+DoVsIOqi3wMpX7E7dKB8d0l1I4LpdaqWdLWGjznn3AEmFSW?=
 =?us-ascii?Q?Cf5mb3f1TFBN/UVj81wTCGPWSMmAPTfqYFoiL2Ns7Ak0D3RDocy+gkMOBabi?=
 =?us-ascii?Q?BvArG9BzpTysg+KaZpYLmPypYAVIhPU4UT+thLUIctXTGqMgE29z3e+gMbGQ?=
 =?us-ascii?Q?HpnWEjBh3XHwzwywROtT2AVPQi8y+RZaA2vewaCpNuaMJlnlvxlOysrR4JM5?=
 =?us-ascii?Q?YiWsofdk7r9ASlD5ayqoE2PiaQsUCeF+TOju7T90WolSUtY4F/bb2nmvDHGL?=
 =?us-ascii?Q?9w7+5yNX8uQ7pit3HLCHbOfagtVidnTTgrEqurleaEjcHiPVZEQ1fHXWEMQn?=
 =?us-ascii?Q?OChy1K3MaswKkHuLtsR/w2emHM2FvXp8qzDFEp1aUojuwZLFHpVueWYjS6g3?=
 =?us-ascii?Q?pDr46RXpBFL4rmBdqXppG6v9Qup+FXY/S8ydfPl4tlYiRpucwSMB3FMLlIUy?=
 =?us-ascii?Q?S0dD/B6qn8vOyIZDsBBWWWrqfEj9yC0oeZp0Bc+yrNDD05NOCyCTJ4/x62wG?=
 =?us-ascii?Q?UCLMuaRxQpnGWC0236lUAIS1E+/KSN0zCJt9onSPzUP6mPOEnltXHvt4vpmQ?=
 =?us-ascii?Q?vNzcl9VpagWNV8YMQ75gGvSw+WJ/BoKoiS+7IKVsX5t/PCmApRp70H8qgtUz?=
 =?us-ascii?Q?RXHa0FP3UBlzE31D+2+aeU8ApFHFDhUIoPnp6ANyF1/kJ/bzCizTJSapWz75?=
 =?us-ascii?Q?oLS5wgft2S9x584u0+CR4RkRn4iRwHM5LYP6ulC9zQiAizJ7sir+s6giPj4a?=
 =?us-ascii?Q?X5W8jrqRFXic/GXBbNQ/QoqX+MLUfGpBDaT9xthrQYpLHnpF8gCd+SuGY/HS?=
 =?us-ascii?Q?DKrDKywrJ9LAoZO7/H/UnFrDrQfxGRS07T7ECEGet0yXxMtdR6D1oAbdi+kh?=
 =?us-ascii?Q?0E8y/FtSKcykMv2QH31QIS6C1j4g6r6ZeW18P+fwFpHloy6DD+Xlm6D+2CUF?=
 =?us-ascii?Q?u1yuxBDlHSCJZzPzBzgoqH6HWVSmmDefEJF+hTSICr67XBMHDQ5kA72w66Yu?=
 =?us-ascii?Q?85Tp0zFdLb4sm552Ag/a2a56R6maPUrJ0O0dwwsqslaKizl0EPToKrTDqBm7?=
 =?us-ascii?Q?h3tqbn8f8tYNAHQrl9JTmZkQCLHQtgw1CElIXgtCUGRrh+ZXvRBks1Hb+/qS?=
 =?us-ascii?Q?3KzsGBCQIcJCFLFfXQ/ZKKLuz5lsj849FAshalzuVeqScbTtjHCqwFe2iYOF?=
 =?us-ascii?Q?ITNV6ckYbs5COe6GCbkpSFjiQwTKVCwfYmwwmhYd6r7j1+OZB/nMZqqW32DV?=
 =?us-ascii?Q?sb4eo1qXS4rHapfJ5890ots1QTTWrr6V7jZmVPReeeOSwAGapSIHsZmk12Ro?=
 =?us-ascii?Q?vZtcav6z/tczOErxA9uYDi7n7LNH/eH3ZmYrGI3sVIor4Tz/OaFA9NdvBt3X?=
 =?us-ascii?Q?RQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0857da65-c471-46e7-d0e5-08de124f4859
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 16:14:46.0163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vwMvOWaRzSZep9mRRB/lKOkaaJmPoosYiUcgABx+zvDDWpsIQbnk+vf2WJo75CdLf+72R625NLyGZDfzzPB7D1QINKvPFpNubPsEqIFCaQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8671
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

On Thu, Oct 23, 2025 at 08:46:23AM -0700, Stephen Hemminger wrote:
> If primary process exits, then it is not possible (or needed)
> to cleanup resources. Instead just exit after closing the
> capture file.
> 
> Bugzilla ID: 1760
> Fixes: a99a311ba101 ("app/pdump: exit with primary process")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

