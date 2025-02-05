Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8F6C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 15:51:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF28A40289;
	Wed,  5 Feb 2025 16:51:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id CA25340270
 for <dev@dpdk.org>; Wed,  5 Feb 2025 16:51:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738770701; x=1770306701;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=R7q+1jw028y1y1bF0UzUWGA98uztqyJQs/LjGn2TAYk=;
 b=aKvf/62gTsIvmXLHvb0e1kuvM4L53nmwSt7YVTFpjR5YiK1gOPj+xC/S
 UdUiIpKBqXGHX3vmzorLd8zZbnVekhM64fLdh1qS7EI83Q3IOxF8rXXjH
 AV+PAgJrlmdedzWQIir2WhUDj6oSWZrrbZ4Mn/YGj9M6wmfFcCmykH2Y/
 IXO5PD/PXrQF8jd9eJaAgqsAvkMS+m0yVkaIeu0o2rpbHyvwR/f1bO0bN
 byt3x9t8QHu3IWbuZgaeiZKWYqvGuD5PTPkv+PL7nPnV/FF3p91Qb9L0a
 cWsG8DWDGe6It5FaaZRE4+5EqeV1BfUkgG+NS+SAdEFViwpgWP+OVrFJN g==;
X-CSE-ConnectionGUID: 2P4sxQ60QPuQnfy+ZyeaEg==
X-CSE-MsgGUID: 7B3FB3SoRMGLU3bHM1TdnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="56765034"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; d="scan'208";a="56765034"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2025 07:51:40 -0800
X-CSE-ConnectionGUID: ZPfItrLGRJ68rrZd7X6cyA==
X-CSE-MsgGUID: M4JyLKczRmCno88fQKxOKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; d="scan'208";a="110725266"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 05 Feb 2025 07:51:39 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Feb 2025 07:51:36 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Feb 2025 07:51:36 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Feb 2025 07:51:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tGKyk9g+lqStzNqfJeseT3p1gddRLTGRPMVOhTHOl7VulMhRMNWvqT3J40kQNRtno9Ke+zLThFzsDuqG1FVrBbZr5dgokZSqrivbXKilmIun22+4fV0VspLtlhKSDBx06W/nhnylqz4jPunyb3SJhpiagIg3P/66etCTMBO8hOP/nONOzJesPF+D27WpkhpXxBgmSOPaXaq/oPsAv/WKtzb/P/2gCp/QhfDIVGFukEEgimP2XFdpGSxw2DtbNyiORnaw176EJ3krmogcKB4biQj+3ullvGl7d3iFI2gMBjtZ/bTAzKA3FAI0S37mO0WZjOZNsXPxtD1EWFh9tu4jyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bq5YbYNio8ANOU9TQ0VJlzb08rQ7QnBOpGyBXsTgGkk=;
 b=o+Gk1B4tlYvbIwCZZdRQHCJ/KyBSeKtC0fO1jRp6A/zoW0jXjSjvtOUvkHf9e96qvOx6DO21sFOVVSA+br2vpb9ySj2N20/cRg+N5pUApJa9oe6FMC+q0SHUA2ujC5M4XfUVWH/aW4LETBHHKaDkLN0vtX33NGZLGW5igq1mZU/JkgVMeoowDEKMYhMu0/aVe6VThqILF839M08MVc+LOdDKDovYZ8KyBQYEBHd8hKDuYsiXsqWPhE+nKbe7qOQwf5kSw6SZJxiV4sXZFZn4CIVTMeHEEMlvVN68s+nXCqQWf0CTNB4rcNblS5gHNP82TK/8TW4dLgcHGG+QiMn7jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY5PR11MB6186.namprd11.prod.outlook.com (2603:10b6:930:26::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Wed, 5 Feb
 2025 15:51:30 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 15:51:27 +0000
Date: Wed, 5 Feb 2025 15:51:19 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: Renyong Wan <wanry@yunsilicon.com>, <dev@dpdk.org>,
 <ferruh.yigit@amd.com>, <stephen@networkplumber.org>, <qianr@yunsilicon.com>, 
 <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, <xudw@yunsilicon.com>,
 <jacky@yunsilicon.com>, <weihg@yunsilicon.com>
Subject: Re: [PATCH v7 04/15] net/xsc: add xsc dev ops to support VFIO driver
Message-ID: <Z6OI93F0HHsuOzlU@bricha3-mobl1.ger.corp.intel.com>
References: <20250128144649.1956159-1-wanry@yunsilicon.com>
 <2040007.zToM8qfIzz@thomas>
 <Z6N8vYkKc01RQu2p@bricha3-mobl1.ger.corp.intel.com>
 <2301554.KTMopqUuYO@thomas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2301554.KTMopqUuYO@thomas>
X-ClientProxiedBy: DUZPR01CA0311.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY5PR11MB6186:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d4de712-e9c4-436a-a3ba-08dd45fcf36f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aIv8NLlp4JKxMWK/7faxFGItOI3v6tNuMnyDzzBLBFiK964eIAPfxiAlrML/?=
 =?us-ascii?Q?l8LkC+BmyMxGJAHMM9T3V29+nweRg52n9ipUp5L0QPuj0MhDs+jXKAfd6fcM?=
 =?us-ascii?Q?5i6nGUKa/mWe54rAbdo1MTEqff4coEI5fiaf5qN526WRHn2SoLUEAAVL9IRr?=
 =?us-ascii?Q?iJr0zkuR0jkaWX8v8K1Vxs9Zo3OXT277r/KAghN4UXfb9weSSX53fNi7xdu/?=
 =?us-ascii?Q?gp+2+9/fmx5I1QUgq9ippxj7K5gnELSQXXKtgFSlMyoHZqVbrOXgxg4WeR8A?=
 =?us-ascii?Q?cevuQmAU0vNDxpjPZnGwExf3Ly/e8ZbUCGyAWRr8SBVzCjXvS4nqjytzS3lh?=
 =?us-ascii?Q?SJ7lskFgGXNPux/SxRet9pnNZZhv1/m+m3nwb2HIy45M1hwPUMKfzFYMLC2e?=
 =?us-ascii?Q?ypIkwyQmz981GsnG8UO+r3AxzSWy4qcyZR8JAllj22BcHiYi1PZ7/KEfyCm4?=
 =?us-ascii?Q?npc26RV+p8jrHQ5MlXFYOJfig4CY3+9BTCADhUVAamzHJNsCD3nlIbtYMFQP?=
 =?us-ascii?Q?3Tq3Q38hf4+sZra9NFMBnmCoi7EHqixi0KNE6EgAK1g4TFknAKsgGUqFKJQc?=
 =?us-ascii?Q?cJD9KrRdQr7vDwdXbosFJqyAeP0+s1g1Hlscwkfhvjx//6jSXn7w7YfzUIX/?=
 =?us-ascii?Q?RiKlWPliwdnq+6oTguB/K/snfoBfpMykKaBwgqpx89TfNp94Jf0Ze/WeXllV?=
 =?us-ascii?Q?BiaonTl6w6qe+4jGQAnNksWb+hsQhVPmskXjaTlgyHhhdGkNSyTJipNDhL3O?=
 =?us-ascii?Q?xNycOTj1yr88vb2lJ3/zBWFbJ1aC8H4wAnXCH30jP2tCPxjBMuUtV9/YRbiX?=
 =?us-ascii?Q?s46pUNaJVJtW7A3IkV/ahCBAw8YGBdQZKaeBb90kE7Fttff2OvUTvJKc2OS+?=
 =?us-ascii?Q?pooZRzBe29N1GiUhSNzxtatn3AUtZRWzPyMEaD8kHchUlO0uOYDqTwE50Oi6?=
 =?us-ascii?Q?1gqlo4QvioF2wt6ioxsrCCxoHGefiiGGEyVqaiHaBVzvprM/IsVjHmw9dDF/?=
 =?us-ascii?Q?eor08Z7twRZH0D4rPrgHQeQ9KwFkSqLUD6qqv+toLFnF/J8meCwYHZiGqi9t?=
 =?us-ascii?Q?ML0y2Nq3HERrfhr1KBkRYi6qumdk2x+YJnYqouoE/EksJaGaL2JMWRWHNYMv?=
 =?us-ascii?Q?3/cBv9nsyxiMVPNLk5QqqD8uXXwpQI14zlrR/QlG0iYKVX4zzc7W2Dshf1xi?=
 =?us-ascii?Q?dX6RQLtRVnCB0PFq/v9E0hCTev7Z2bIYE22ySNz5FV3SVgeJApx8J4uww7Ba?=
 =?us-ascii?Q?U7PDQIgLHs5zr5HtQjJsOvBIMktNRzt5dJDH6o8q+W14YyQhIfdx/+F0m8SF?=
 =?us-ascii?Q?KrcOax698gSAfmwtjvFj9b50N0peHrJKzrNjclYchy9eXA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4vaoECspg1G9akT221XHssohe0gJz9i8tFJAONTZOErpd2+DHJAsyuZBZVaO?=
 =?us-ascii?Q?DA+Wk1DqLnEC+pR3daSPcgRz9/M2Es/6RPrL0pJ91XJXrmZ3yCMgAjs3KJrb?=
 =?us-ascii?Q?cU9wbp5f3HWpeacb1dBHCpt+iR7RzzYSi/w+FwhTexOZcrt5BvcxX/QsvPxw?=
 =?us-ascii?Q?Bi49N5QkFeQCs1MXdM8M2xy7EGhpM8WfDB83svJwf6TXpdzA8rjIrZPUFWaH?=
 =?us-ascii?Q?yXKzOzRyMC3Il4ZfTuECXI0Rqf6ZqtV7hvSxVqUpBbHMEinj+JUxrdiJ7ftY?=
 =?us-ascii?Q?Lr5Xd1ZGDWizIB/Mpvfo7jlJ4mSTgTenl8j3DOXfEsZOI/cNgu3vFONrnyRl?=
 =?us-ascii?Q?V6QtXWEdc+R7DQMIB/0evnbCKhb5hcS0A7y162NUMzhuSh3A0QTqrYbBeTw+?=
 =?us-ascii?Q?e8XSp2VnhhJy3F4xymqfWbIDCAqFqqEWCjqCxKZiAiWetjczahjBxC4Cta2F?=
 =?us-ascii?Q?ulCNfExDyPps48lJRaC9G99u2wCBoDV4RMCIJj8TBKddSfxisnsde7YBc5Mj?=
 =?us-ascii?Q?JtCP+N1060GPLuB940x+Y7woDRztfFuXjNMeQrMoVVGea1qhfrvcO9BqQFhx?=
 =?us-ascii?Q?6Ol80NQUTtqi3GTaKEZEb5AJWUaAfnzI1IzTgeTEqFTbHiS4VJimkEj2TYPA?=
 =?us-ascii?Q?EVfLGMJWt/8r2+5kzmB1deWUL7wt2EVRHg+Ku3tEAei6zLZquOJX0HnnT0ev?=
 =?us-ascii?Q?zMW0tvx3dVAJUNr+O00xr76wBTQmlbCYjBdKnaHJsWhM1ZVcZja4gC8JJast?=
 =?us-ascii?Q?BtcExxFbNBjc5Nm0BtxNXWSpj0KJfoU1bvWFUAj0RhneI1R1qDr1ZOMhKAPa?=
 =?us-ascii?Q?ybirBEIunDcMv3HP3y2E4/SmNOAF+ZN5/ZgHvQKRy1VbsVTrBCxbY/tIjlf/?=
 =?us-ascii?Q?a8xTEdNY7KcOTbhbALMYgzxllAKk7Q+HFft37DR+IHVTlaR9jmfwi15yhxtz?=
 =?us-ascii?Q?V8WDzoUW85v7OikssaUuN8ZIPJ7C/C9sZWLYRhERync7+sQ5lppEtxMD+WBI?=
 =?us-ascii?Q?Ya70/h2fxgHlsLBh4EiQV4675pC1nvLFOFJD990If8HW+TS5K1kaTZaZio21?=
 =?us-ascii?Q?fs121OHnBg3TdFUD3v2XzczwaDaJ0FOZWZ6TTZuDPgctgL2SArCEy7JsF0HM?=
 =?us-ascii?Q?/GtAAIFDgGiSLqqgl8nMkfg7Hu8hproBHvB9LAlQhhLJ8hC2nL9WNhNWJahM?=
 =?us-ascii?Q?0E6KbJXl3Fb1VPMF56Vcjon6fiKrwZN8eQX2OYAW8mwYrkFIwYH/XtLfxgWk?=
 =?us-ascii?Q?lDBnrEKWNUoLO7hCTl3mZySM8mWlAFtIbT9LcgTDJBwytlBddv8TdUGTWqL2?=
 =?us-ascii?Q?auRGCC5O3Ch6K8QKR5/oTARPWPX4j+n9xUtnEh7V3Fq4qxAhndDTuYM3InHy?=
 =?us-ascii?Q?w/lNm4MLu1i8BMKQApGnwF8Ffr8dF+2uWYwjY2zXFu8Kke3k//zxGMcf0wzO?=
 =?us-ascii?Q?hGKbVa2Um1bVS/qNh84IDaxbwzZZRqU78TITWCR/nuW0edhgYY3N3CseL+mF?=
 =?us-ascii?Q?wT1F38XJQareLLMxrDpwlyxVpt2hc98QBl0z/oflDbz6ZpGRPDr3gi9qRhWq?=
 =?us-ascii?Q?N6cIAljfv5G6yjYe5IC+w6IGWrxdE+cIrakF9awfbBgpQiz9kM/BNYRtmCKE?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4de712-e9c4-436a-a3ba-08dd45fcf36f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:51:27.6299 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sS0wKmHD7P24bL8PqF6WAb82A089AAEDVpOQzOmBhONsiaYtZEkeSdux/6Lq9qibAH2UwAak2axvl6ktTgTNMN4SckvqmdqOtmUiIUCOmGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6186
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

On Wed, Feb 05, 2025 at 04:47:20PM +0100, Thomas Monjalon wrote:
> 05/02/2025 15:59, Bruce Richardson:
> > On Wed, Feb 05, 2025 at 03:43:30PM +0100, Thomas Monjalon wrote:
> > > 05/02/2025 15:37, Renyong Wan:
> > > > On 2025/2/5 19:44, Thomas Monjalon wrote:
> > > > > 28/01/2025 15:46, Renyong Wan:
> > > > >> XSC PMD is designed to support both VFIO and private kernel drivers.
> > > > > What's the benefit of private kernel drivers?  Why are they private?
> > > > 
> > > > Hello Thomas,
> > > > 
> > > > Thanks for your review.
> > > > 
> > > > It can support the bifurcation model without unbinding the kernel
> > > > driver, by utilizing our private kernel driver in conjunction with
> > > > rdma-core. Currently, our kernel driver is not open-source, so it is
> > > > considered a private kernel driver. This patch series only supports the
> > > > VFIO driver. Our kernel driver is currently in the process of being
> > > > open-sourced on kernel.org, and once it is available there, we also
> > > > plan to submit the code that supports our kernel driver to DPDK.
> > > 
> > > OK that's interesting, thank you.
> > > 
> > > I think it would be the first DPDK driver to support both VFIO or
> > > bifurcated model.
> > > 
> > 
> > Not quite the first, but possibly the first net driver? :-). The idxd
> > dmadev driver supports both. It can be used either with VFIO or the kernel
> > idxd driver.
> 
> It announces only VFIO:
> RTE_PMD_REGISTER_KMOD_DEP(IDXD_PMD_DMADEV_NAME_PCI, "vfio-pci");
> 
> How does it work?
> 
It also has its own bus driver that scans for dev nodes (/dev/dsa/wq*) on
probe, and uses those configured for DPDK use. On a system with multiple
device instances you can have one device used by DPDK bound to vfio, and
use a couple of work queues from another device bound to the idxd kernel
driver. More info on the setup is in the docs [1]

/Bruce

[1] https://doc.dpdk.org/guides-24.11/dmadevs/idxd.html#device-setup
