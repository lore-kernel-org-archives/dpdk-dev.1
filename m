Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6206AC2D0CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 10:56:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20A62402DC;
	Thu, 15 May 2025 12:56:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id A140040289
 for <dev@dpdk.org>; Thu, 15 May 2025 12:56:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747306615; x=1778842615;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Xyj+UwWJ16ehip0tj2Gzib87D0Y4gvl0irBP9vqLtJ4=;
 b=VJMCkzRJG0TStGhnoaCFPXmw7xPMs88DR40XEf8H9xG8czfW/Fh74bwF
 SxVhyaIKn7Xc2utzju4WHVOPQZd8w5AoMDI+u6IN6LRMGfWVVJiOjkzQn
 mGmx2/pWNuiSb5XcZObMbvXQVLhAQ4tKs0Yv36G2zSpskU2p9oZXtDmw0
 Nm71ZTQEKaldcpSoT2GfjYoI851YRWZRQIgFIsXgFSOvNk0LYw+e+dmXF
 Q5gu3+aJesyHcsckNp6gw9NjfHBR2jMoAH07c76Vvf2EN9W/YbjQwyO3f
 RU3F+YlYmkVTWjzusMDGFzDB2Vb8Un+xHrmjC1o3Ytg4TVJcnX4e0LJPr Q==;
X-CSE-ConnectionGUID: BdQzOEreTh2efVFi39DS4Q==
X-CSE-MsgGUID: 3toS2XU0RMKuAguxT+HNKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="66787546"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="66787546"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 03:56:54 -0700
X-CSE-ConnectionGUID: pmFAm1ZoSTi0TQo9gUoD/g==
X-CSE-MsgGUID: 4O+jhOmMQfOZiSQSJIJOeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; d="scan'208";a="175452575"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 03:56:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 03:56:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 03:56:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 03:56:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fIm8oyLOMdL860vlHQnvImEeG+KVXQRZp/gYAXAs3i/EgoRToAbUUlqFMnuRNzevSb96HIetGf8airH1ON0gOy39s5rXyjk03M2zNsKHqKDHpU7aPr9/5B1WM7A7Wx2FXGgN/6jQDZxzAmz0IT9jg9ynZFkmHscnCbUZYQEML3IiSFE7VK5eWjTHOAAqsqu5/JkIz2t+ot8rRfud9mPZxdUCOkRqLpTnEz9qmjLTEEmdzebeiRItVwVe05dvkqSBij5FIgbs+COTpEKijIY3WUgA5zgnQG0lFGfg57/seXG8aiIyIEtf5/MtyI9MZqehVmKIohxg+4cQEZOGzmiNAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qk1tuBW5YIiPUcLgAT5KUjhV1h+NRzljzdQUO0chvAU=;
 b=nCuvkZLIKCd0AzWv3IZmfU+evIVNJVc0pA6C1B60j38tuK2MEZx5EgYgJkPBnDxNIPqBh2/n545wmBulI874C6FX7ugY2TALBKbxHrLBYxCfxi5xm5I7vdY9KX9c1UbuRza+0XasspgXMuldikGZi5El0t6BVNEhk75A96rhnjL2uEdRfYdu6k8Ii7nuLnBHCFO5B2nNcc4i/Kfbk1UqbzwQirCKOT+C5dbd4iBAlvz2EMgvNnrBg+Y5DsrqLhT8xorYbISNmuclZ5NYHPnjWjJsf0NIOeCY9oYbs8Am9SOWA/m06te4IN4R5Q+JGcFgG4eaCjHIrfrdPg8h4AHDGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY5PR11MB6163.namprd11.prod.outlook.com (2603:10b6:930:28::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 10:56:51 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 10:56:51 +0000
Date: Thu, 15 May 2025 11:56:45 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 07/13] net/intel: generalize vectorized Rx rearm
Message-ID: <aCXIbXy3vci3pIa-@bricha3-mobl1.ger.corp.intel.com>
References: <afcd4013458bdb8b970e7ed57d6a1ede0ee654b8.1747054471.git.anatoly.burakov@intel.com>
 <3c9411fcb3a01ac7dfc72011a5860c190d80ad4f.1747054471.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3c9411fcb3a01ac7dfc72011a5860c190d80ad4f.1747054471.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0086.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY5PR11MB6163:EE_
X-MS-Office365-Filtering-Correlation-Id: b95d02a2-7313-4c51-88ec-08dd939f323d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mogkN8t6Irz0j7PUZF/EiwbAJrq3PdcCfrvj+z4yvffzUwKd/OqJnmmi3JMG?=
 =?us-ascii?Q?fgLJHYxCaPwIR1I95WnOxDz1rUkyTp1mpNHhC2hTskxP83VGiL3KLG1FIDTF?=
 =?us-ascii?Q?avHA8QID2QDFB/LDtDv9qoV6wwGmY62Zb+9ST++MYxKcQLVrYy7Km0jkeiGH?=
 =?us-ascii?Q?yLTypoSTWah6H6tF0hMDiUIDffB+zE6pwySNf/QqJ+M7Du1AqpQtWu9s3RZ7?=
 =?us-ascii?Q?DSrGCwMGlnBe1cXeild3uR5904NlatExsnEcGW5mbZG1wrRMJOqGpmI/DPhb?=
 =?us-ascii?Q?d1qJaijJAYyUAw01w0/FydFYYhUKhuuHrH85dOzfXGNmCd2NomA+F9N0XMNl?=
 =?us-ascii?Q?kaWnrtelfh2U8roxVrp4EiUAfV+RvQdtm/2LMCVX96Y50l13CfUrup5v2oFx?=
 =?us-ascii?Q?C8k+Zz90MsOqQ9e5GjaxDoRVA5z8F/SEtVO7rNuBk8Bg/EazMwGBA005SB5D?=
 =?us-ascii?Q?KpjuQ6ttPghh7+OeGHkLZoABZ0PHnBSrrfMt4Mn3i9FH816QkrquA3QGqB/O?=
 =?us-ascii?Q?oRCBusy7yAgI7MWtN9XKjeWZGJ4buOEVwMqmGXMRE+aO+r+2clhwxPb7hNok?=
 =?us-ascii?Q?tXA07nDnm87SDzjO+ktTzGZmynyjP4bHldMQUUr6NKnfRik2o/g2Uz2NW9+K?=
 =?us-ascii?Q?3Y3MVZWwlHp6ofTStHNjRlj/oy6hsU91FABda2eefRZrOi11d49jv5WnPPa7?=
 =?us-ascii?Q?3EN2URfQlI6NtGhXfUqEGVD53EgvWnyhdOEtv6Ub0uwNpv3nRjBCyE+qVKE3?=
 =?us-ascii?Q?WEf+iKL8PpJ2/J9Q+z8jixy8KM8C+QLRN3yQTSjXZoSkw3W4cithH+IZvZ64?=
 =?us-ascii?Q?8Wvxgf9bqN20OpjuN/Dxy+2PMTogmu1f75LA6mZcM/Wl17Q0byQA87C8H3n6?=
 =?us-ascii?Q?aPOZPym4sc56dVnQlEo5B4yGG8RTTKWx1NTbGD0WJCm1AP1kG7rkb7OoOAmM?=
 =?us-ascii?Q?x1N0V7+CSjiYF2+FCaUFjM6TWRpNINyzn+ZYAXYdtp0MFKsCE5E1x08Gprif?=
 =?us-ascii?Q?0DTbg1UtnH6yym+SPcAjRQoqQy+NDIkKUWdFE6haMR/WHCSWqxwqi2y29cJB?=
 =?us-ascii?Q?SKm8gAayonoDxqH5/VVU7qOHLDvxhNKw8cXeS79+N+1XjQaGvHR4kq2u3hk2?=
 =?us-ascii?Q?6L/tNVvRjslkBlgdS1OfSnUo10YtlmITYLCab3MxHN+/GBmtJXFmFhOj9Nki?=
 =?us-ascii?Q?0wJ3xa5ps8WYE79qkd50C2yTFNrEB/CCg+/3WCQvlSnoysdh4E8SJcovRq71?=
 =?us-ascii?Q?3QW+UctG80P3pgRNPhEYndgCZpBfkQLMDCYalBRqVgVXhW7YqZayGET9vDlV?=
 =?us-ascii?Q?m5hFGm1zwWh/xZFYYp7+3TO5K0HQ4y6t2fCPGbim8ZwvTlc9gnYJmuFep+YQ?=
 =?us-ascii?Q?nAiIrf2hVCmylm4mUDIVCH8vI9mnQhaDKmcBJ7DT4o/kLIvoTFWuc99dW3gb?=
 =?us-ascii?Q?YDmNBDmzeas=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xpAbTlp9En02kZjVms4AAmHiTXjMng4oVKh4Lpc+7WT6Q/J76cFhOB/7zswU?=
 =?us-ascii?Q?0AKvtpsOeIS5IZWtsEx11T1qI/N+OnZOT4xLKKx2KntkxDHEvA3aIacvgdC9?=
 =?us-ascii?Q?UKzmaXTe7/a7GHs6bqUPkyIHBXwY8xVw3TDfCkFd5XuyxrTYrgXzBJ8pswaG?=
 =?us-ascii?Q?YemjntrQfLNMJj9J8fdB7/SMutY5aXaOGmFHUM5m34mw9wEzhP9K485/rG5e?=
 =?us-ascii?Q?6X4HQX7DrE8LB+PMkueFlk5HPMA7O0logyO19Q+ittolJ9czs7QUHAybf5vl?=
 =?us-ascii?Q?NeLS1T8dnQiGBZzOGeF8cNMh6Fk9a45pd+jFd7p5qx28JI0h9Sjus/yfF1Kk?=
 =?us-ascii?Q?PfO8Gl5YghcUqGk2SpgmG1IoQEesXB/O60ebwslJnhgFPJsDns+/jdYtlz1U?=
 =?us-ascii?Q?qiKJAv8JZsntokGE4Ej+BUUc105exxjytkTg1piBeP+gCp1sWbwYSlbyC0nt?=
 =?us-ascii?Q?xbdquPMaL3mnJB9HYVqL4Ook+C6dbX0g1vH7WOIZEHeMTRG7loQSdGOHYXt7?=
 =?us-ascii?Q?oA8ei3mN9RW1qZKsoMiA/jtgFs7lM5YpolIvigZj3J0MqwiFnToMC9ILKYJk?=
 =?us-ascii?Q?RaVmFXyQWmw8vd4EYIUauzxYaILkfoHtdbOBFg8ROEBzEIGNpGYpHYU0/rUf?=
 =?us-ascii?Q?ynrHwoeAWB2VbJttN14EGAw3M2jIA1v7BZbVNJ4baaNqTu/LFLd791cFhX8D?=
 =?us-ascii?Q?z/5QGzLGlxPDFaFNqLK2JErebEL1hqLEqzruswWTsskOvCc717suV7mE5Mqi?=
 =?us-ascii?Q?cDwLpcxqbbUIz7QcEPLHRapiB9tTfkiiSIzxJp3eQaZNL3RlAYhCOKWtmhz1?=
 =?us-ascii?Q?uwZfbzPXWyNdrNs87CAAm7wW0ae9zrsiIsIkjjKTpsVuFUDm8P1DjheyQmN5?=
 =?us-ascii?Q?Fh38EtbXU6T8Fnn6opSoVT/XYTWeQ0yBSZT8qAzLBKqk3eTMlgdZCsOlyQyj?=
 =?us-ascii?Q?GQsc/FR0ocgqwV06xiXs/d4kO8bTv5e8ZfcsVxv8C6xLOKYUXe/9Kj4aeMil?=
 =?us-ascii?Q?jFw0kqOwtT5hnc4cXTX4Wj0Abo5ULJVrnNcy9TDgQbkHWg8nFlLSvvwktaRx?=
 =?us-ascii?Q?7fhQIzuoZ5OKmWNFm21kvQkUGmEjr2ieuGTuVxtdmD4vhF1VJ11WGk48ydfg?=
 =?us-ascii?Q?Ok1kHNofKkwatI8x6NJp+G2KPZ8W8Jy/evYoCdmJm6aAaOx/c8lGtp9Q+Op+?=
 =?us-ascii?Q?n317t4xTMoF22GKEnsRTIECrAKiPXboVFR4SMI/PZ//MTOb7vlscC7RdLLk1?=
 =?us-ascii?Q?WAaSmNeXPvSq4vasIO3VEkfQh9QDk8FkIeiCT5i9Fv3dk8TpZauZLC0Chccg?=
 =?us-ascii?Q?mxJBRnqB5XNFvbi3IpgrErP0jhsu2PuW30iiby/Y/S5jlCDC8LNfnRXBW8A3?=
 =?us-ascii?Q?3oIRuObmwW+16ZmOP3stsE9FHt+CyecwEj9W+aKN8hvhDNZGSMUlIdqmjyKK?=
 =?us-ascii?Q?a9d2zlDEgMe05OS1aISx9Q5KTW9ZmnmtR/yoxSUSn0PSkKpbS8/bh8/YVYAu?=
 =?us-ascii?Q?tFaoSLZVpCRA3zcOhaw+27YXNp2+bEymhc7k4oCNWNyJZ6fWT1EgcM2Fu3HT?=
 =?us-ascii?Q?vrQjGVz3HeLGeUpTolVfAJfQ8TP6RLlyGsOo6oQQH374nmBq66Qi/Wij5nJ0?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b95d02a2-7313-4c51-88ec-08dd939f323d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 10:56:51.1022 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywkLRiY5lvq13kglwp5aMikcs/J+H76/4EjpkkaXJf1pmHerULFeT5r34zxHP+Z61nK318MylUoUiz78m109Lauwg/+IVjsZ9IOXd5nppig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6163
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

On Mon, May 12, 2025 at 01:54:33PM +0100, Anatoly Burakov wrote:
> There is certain amount of duplication between various drivers when it
> comes to Rx ring rearm. This patch takes implementation from ice driver
> as a base because it has support for no IOVA in mbuf as well as all
> vector implementations, and moves them to a common file.
> 
> The driver Rx rearm code used copious amounts of #ifdef-ery to
> discriminate between 16- and 32-byte descriptor support, but we cannot do
> that in the common code because we will not have access to those
> definitions. So, instead, we use copious amounts of compile-time constant

I was initially wondering why we don't have access to the definitions, but
then I realised it was because the common code doesn't know whether to use
the I40E, ICE or IAVF definition. :-)
However, this leads me to consider whether, if we need to keep these
definitions, we are better to just use a single one, rather than one per
driver.

> propagation and force-inlining to ensure that the compiler generates
> effectively the same code it generated back when it was in the driver. We
> also add a compile-time definition for vectorization levels for x86
> vector instructions to discriminate between different instruction sets.
> This too is constant-propagated, and thus should not affect performance.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>

More comments inline below. While I realise this is mostly a copy-paste
transfer, I think we can do some cleanup in the process.

/Bruce

> ---
>  drivers/net/intel/common/rx.h               |   3 +
>  drivers/net/intel/common/rx_vec_sse.h       | 323 ++++++++++++++++++++
>  drivers/net/intel/ice/ice_rxtx.h            |   2 +-
>  drivers/net/intel/ice/ice_rxtx_common_avx.h | 233 --------------
>  drivers/net/intel/ice/ice_rxtx_vec_avx2.c   |   5 +-
>  drivers/net/intel/ice/ice_rxtx_vec_avx512.c |   5 +-
>  drivers/net/intel/ice/ice_rxtx_vec_sse.c    |  77 +----
>  7 files changed, 336 insertions(+), 312 deletions(-)
>  create mode 100644 drivers/net/intel/common/rx_vec_sse.h
>  delete mode 100644 drivers/net/intel/ice/ice_rxtx_common_avx.h
> 
> diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
> index 2d9328ae89..65e920fdd1 100644
> --- a/drivers/net/intel/common/rx.h
> +++ b/drivers/net/intel/common/rx.h
> @@ -14,6 +14,8 @@
>  #define CI_RX_BURST 32
>  #define CI_RX_MAX_BURST 32
>  #define CI_RX_MAX_NSEG 2
> +#define CI_VPMD_DESCS_PER_LOOP 4

Do all our vector PMDs use the same DESC_PER_LOOP value? Do the AVX2 and
AVX512 paths not do 8 at a time?

> +#define CI_VPMD_RX_REARM_THRESH 64
>  
>  struct ci_rx_queue;
>  
> @@ -40,6 +42,7 @@ struct ci_rx_queue {
>  		volatile union ice_32b_rx_flex_desc *ice_rx_32b_ring;
>  		volatile union iavf_16byte_rx_desc *iavf_rx_16b_ring;
>  		volatile union iavf_32byte_rx_desc *iavf_rx_32b_ring;
> +		volatile void *rx_ring; /**< Generic */
>  	};
>  	volatile uint8_t *qrx_tail;   /**< register address of tail */
>  	struct ci_rx_entry *sw_ring; /**< address of RX software ring. */
> diff --git a/drivers/net/intel/common/rx_vec_sse.h b/drivers/net/intel/common/rx_vec_sse.h
> new file mode 100644
> index 0000000000..6fe0baf38b
> --- /dev/null
> +++ b/drivers/net/intel/common/rx_vec_sse.h

This file should be called "rx_vec_x86.h", I think, since it has got both
SSE and AVX code in it.

> @@ -0,0 +1,323 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2024 Intel Corporation

Date -> 2025

> + */
> +
> +#ifndef _COMMON_INTEL_RX_VEC_SSE_H_
> +#define _COMMON_INTEL_RX_VEC_SSE_H_
> +
> +#include <stdint.h>
> +
> +#include <ethdev_driver.h>
> +#include <rte_io.h>
> +
> +#include "rx.h"
> +
> +enum ci_rx_vec_level {
> +	CI_RX_VEC_LEVEL_SSE = 0,
> +	CI_RX_VEC_LEVEL_AVX2,
> +	CI_RX_VEC_LEVEL_AVX512,
> +};
> +
> +static inline int
> +_ci_rxq_rearm_get_bufs(struct ci_rx_queue *rxq, const size_t desc_len)
> +{
> +	struct ci_rx_entry *rxp = &rxq->sw_ring[rxq->rxrearm_start];
> +	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
> +	volatile void *rxdp;
> +	int i;
> +
> +	rxdp = RTE_PTR_ADD(rxq->rx_ring, rxq->rxrearm_start * desc_len);
> +
> +	if (rte_mempool_get_bulk(rxq->mp,
> +				 (void **)rxp,
> +				 rearm_thresh) < 0) {

Since we are copying the code to a new place, maybe we can lengthen the
lines a bit to the 100 char limit. I suspect this can be all on one line,
increasing readability.

> +		if (rxq->rxrearm_nb + rearm_thresh >= rxq->nb_rx_desc) {
> +			__m128i dma_addr0;
> +
> +			dma_addr0 = _mm_setzero_si128();
> +			for (i = 0; i < CI_VPMD_DESCS_PER_LOOP; i++) {
> +				rxp[i].mbuf = &rxq->fake_mbuf;
> +				const void *ptr = RTE_PTR_ADD(rxdp, i * desc_len);

If we drop the const here, the cast should not be necessary at all in the
line below, I think.

> +				_mm_store_si128(RTE_CAST_PTR(__m128i *, ptr),
> +						dma_addr0);
> +			}
> +		}
> +		rte_eth_devices[rxq->port_id].data->rx_mbuf_alloc_failed += rearm_thresh;
> +		return -1;
> +	}
> +	return 0;
> +}
> +
> +/*
> + * SSE code path can handle both 16-byte and 32-byte descriptors with one code
> + * path, as we only ever write 16 bytes at a time.
> + */
> +static __rte_always_inline void
> +_ci_rxq_rearm_sse(struct ci_rx_queue *rxq, const size_t desc_len)
> +{
> +	const __m128i hdr_room = _mm_set1_epi64x(RTE_PKTMBUF_HEADROOM);

Minor nit, but we are referring to this as "headroom" not "header-room" so
the prefix should probably be "hd_room" (or hdroom), not "hdr_room" :-)

> +	const __m128i zero = _mm_setzero_si128();
> +	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
> +	struct ci_rx_entry *rxp = &rxq->sw_ring[rxq->rxrearm_start];
> +	volatile void *rxdp;
> +	int i;
> +
> +	rxdp = RTE_PTR_ADD(rxq->rx_ring, rxq->rxrearm_start * desc_len);
> +
> +	/* Initialize the mbufs in vector, process 2 mbufs in one loop */
> +	for (i = 0; i < rearm_thresh; i += 2, rxp += 2, rxdp = RTE_PTR_ADD(rxdp, 2 * desc_len)) {
> +		volatile void *ptr0 = RTE_PTR_ADD(rxdp, 0);
> +		volatile void *ptr1 = RTE_PTR_ADD(rxdp, desc_len);

We don't need the volatile casts here, since we only ever cast them away
when used with store_si128. In fact, I suspect we don't ever need to have
rxdp be volatile either.

> +		__m128i vaddr0, vaddr1;
> +		__m128i dma_addr0, dma_addr1;
> +		struct rte_mbuf *mb0, *mb1;
> +
> +		mb0 = rxp[0].mbuf;
> +		mb1 = rxp[1].mbuf;
> +
> +#if RTE_IOVA_IN_MBUF
> +		/* load buf_addr(lo 64bit) and buf_iova(hi 64bit) */
> +		RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
> +				offsetof(struct rte_mbuf, buf_addr) + 8);
> +#endif
> +		vaddr0 = _mm_loadu_si128((__m128i *)&mb0->buf_addr);
> +		vaddr1 = _mm_loadu_si128((__m128i *)&mb1->buf_addr);
> +
> +		/* add headroom to address values */
> +		vaddr0 = _mm_add_epi64(vaddr0, hdr_room);
> +		vaddr1 = _mm_add_epi64(vaddr1, hdr_room);
> +
> +#if RTE_IOVA_IN_MBUF
> +		/* move IOVA to Packet Buffer Address, erase Header Buffer Address */
> +		dma_addr0 = _mm_unpackhi_epi64(vaddr0, zero);
> +		dma_addr1 = _mm_unpackhi_epi64(vaddr1, zero);
> +#else
> +		/* erase Header Buffer Address */
> +		dma_addr0 = _mm_unpacklo_epi64(vaddr0, zero);
> +		dma_addr1 = _mm_unpacklo_epi64(vaddr1, zero);
> +#endif
> +
> +		/* flush desc with pa dma_addr */
> +		_mm_store_si128(RTE_CAST_PTR(__m128i *, ptr0), dma_addr0);
> +		_mm_store_si128(RTE_CAST_PTR(__m128i *, ptr1), dma_addr1);
> +	}
> +}
> +
> +#ifdef __AVX2__
> +/* AVX2 version for 16-byte descriptors, handles 4 buffers at a time */
> +static __rte_always_inline void
> +_ci_rxq_rearm_avx2(struct ci_rx_queue *rxq)
> +{
> +	struct ci_rx_entry *rxp = &rxq->sw_ring[rxq->rxrearm_start];
> +	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
> +	const size_t desc_len = 16;
> +	volatile void *rxdp;
> +	const __m256i hdr_room = _mm256_set1_epi64x(RTE_PKTMBUF_HEADROOM);
> +	const __m256i zero = _mm256_setzero_si256();
> +	int i;
> +
> +	rxdp = RTE_PTR_ADD(rxq->rx_ring, rxq->rxrearm_start * desc_len);
> +
> +	/* Initialize the mbufs in vector, process 4 mbufs in one loop */
> +	for (i = 0; i < rearm_thresh; i += 4, rxp += 4, rxdp = RTE_PTR_ADD(rxdp, 4 * desc_len)) {
> +		volatile void *ptr0 = RTE_PTR_ADD(rxdp, 0);
> +		volatile void *ptr1 = RTE_PTR_ADD(rxdp, desc_len * 2);

Again, we can drop volatile, I think.

> +		__m128i vaddr0, vaddr1, vaddr2, vaddr3;
> +		__m256i vaddr0_1, vaddr2_3;
> +		__m256i dma_addr0_1, dma_addr2_3;
> +		struct rte_mbuf *mb0, *mb1, *mb2, *mb3;
> +
> +		mb0 = rxp[0].mbuf;
> +		mb1 = rxp[1].mbuf;
> +		mb2 = rxp[2].mbuf;
> +		mb3 = rxp[3].mbuf;
> +
> +#if RTE_IOVA_IN_MBUF
> +		/* load buf_addr(lo 64bit) and buf_iova(hi 64bit) */
> +		RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
> +				offsetof(struct rte_mbuf, buf_addr) + 8);
> +#endif
> +		vaddr0 = _mm_loadu_si128((__m128i *)&mb0->buf_addr);
> +		vaddr1 = _mm_loadu_si128((__m128i *)&mb1->buf_addr);
> +		vaddr2 = _mm_loadu_si128((__m128i *)&mb2->buf_addr);
> +		vaddr3 = _mm_loadu_si128((__m128i *)&mb3->buf_addr);
> +
> +		/**
> +		 * merge 0 & 1, by casting 0 to 256-bit and inserting 1
> +		 * into the high lanes. Similarly for 2 & 3
> +		 */
> +		vaddr0_1 =
> +			_mm256_inserti128_si256(_mm256_castsi128_si256(vaddr0),
> +						vaddr1, 1);

Can these statements now fit on a single 100-character line?

> +		vaddr2_3 =
> +			_mm256_inserti128_si256(_mm256_castsi128_si256(vaddr2),
> +						vaddr3, 1);
> +
> +		/* add headroom to address values */
> +		vaddr0_1 = _mm256_add_epi64(vaddr0_1, hdr_room);
> +		vaddr0_1 = _mm256_add_epi64(vaddr0_1, hdr_room);
> +
> +#if RTE_IOVA_IN_MBUF
> +		/* extract IOVA addr into Packet Buffer Address, erase Header Buffer Address */
> +		dma_addr0_1 = _mm256_unpackhi_epi64(vaddr0_1, zero);
> +		dma_addr2_3 = _mm256_unpackhi_epi64(vaddr2_3, zero);
> +#else
> +		/* erase Header Buffer Address */
> +		dma_addr0_1 = _mm256_unpacklo_epi64(vaddr0_1, zero);
> +		dma_addr2_3 = _mm256_unpacklo_epi64(vaddr2_3, zero);
> +#endif
> +
> +		/* flush desc with pa dma_addr */
> +		_mm256_store_si256(RTE_CAST_PTR(__m256i *, ptr0), dma_addr0_1);
> +		_mm256_store_si256(RTE_CAST_PTR(__m256i *, ptr1), dma_addr2_3);
> +	}
> +}
> +#endif /* __AVX2__ */
> +
> +#ifdef __AVX512VL__
> +/* AVX512 version for 16-byte descriptors, handles 8 buffers at a time */
> +static __rte_always_inline void
> +_ci_rxq_rearm_avx512(struct ci_rx_queue *rxq)
> +{
> +	struct ci_rx_entry *rxp = &rxq->sw_ring[rxq->rxrearm_start];
> +	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
> +	const size_t desc_len = 16;
> +	volatile void *rxdp;
> +	int i;
> +	struct rte_mbuf *mb0, *mb1, *mb2, *mb3;
> +	struct rte_mbuf *mb4, *mb5, *mb6, *mb7;
> +	__m512i dma_addr0_3, dma_addr4_7;
> +	__m512i hdr_room = _mm512_set1_epi64(RTE_PKTMBUF_HEADROOM);
> +	__m512i zero = _mm512_setzero_si512();
> +
> +	rxdp = RTE_PTR_ADD(rxq->rx_ring, rxq->rxrearm_start * desc_len);
> +
> +	/* Initialize the mbufs in vector, process 8 mbufs in one loop */
> +	for (i = 0; i < rearm_thresh; i += 8, rxp += 8, rxdp = RTE_PTR_ADD(rxdp, 8 * desc_len)) {
> +		volatile void *ptr0 = RTE_PTR_ADD(rxdp, 0);
> +		volatile void *ptr1 = RTE_PTR_ADD(rxdp, desc_len * 4);
> +		__m128i vaddr0, vaddr1, vaddr2, vaddr3;
> +		__m128i vaddr4, vaddr5, vaddr6, vaddr7;
> +		__m256i vaddr0_1, vaddr2_3;
> +		__m256i vaddr4_5, vaddr6_7;
> +		__m512i vaddr0_3, vaddr4_7;

Rather than defining all of these variables here, many of which are
throw-away, if we define them on first use the code will be shorter, just
as readable, and also the variables can be made "const".

> +
> +		mb0 = rxp[0].mbuf;
> +		mb1 = rxp[1].mbuf;
> +		mb2 = rxp[2].mbuf;
> +		mb3 = rxp[3].mbuf;
> +		mb4 = rxp[4].mbuf;
> +		mb5 = rxp[5].mbuf;
> +		mb6 = rxp[6].mbuf;
> +		mb7 = rxp[7].mbuf;
> +
> +#if RTE_IOVA_IN_MBUF
> +		/* load buf_addr(lo 64bit) and buf_iova(hi 64bit) */
> +		RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
> +				offsetof(struct rte_mbuf, buf_addr) + 8);
> +#endif
> +		vaddr0 = _mm_loadu_si128((__m128i *)&mb0->buf_addr);
> +		vaddr1 = _mm_loadu_si128((__m128i *)&mb1->buf_addr);
> +		vaddr2 = _mm_loadu_si128((__m128i *)&mb2->buf_addr);
> +		vaddr3 = _mm_loadu_si128((__m128i *)&mb3->buf_addr);
> +		vaddr4 = _mm_loadu_si128((__m128i *)&mb4->buf_addr);
> +		vaddr5 = _mm_loadu_si128((__m128i *)&mb5->buf_addr);
> +		vaddr6 = _mm_loadu_si128((__m128i *)&mb6->buf_addr);
> +		vaddr7 = _mm_loadu_si128((__m128i *)&mb7->buf_addr);
> +
> +		/**
> +		 * merge 0 & 1, by casting 0 to 256-bit and inserting 1
> +		 * into the high lanes. Similarly for 2 & 3, and so on.
> +		 */
> +		vaddr0_1 =
> +			_mm256_inserti128_si256(_mm256_castsi128_si256(vaddr0),
> +						vaddr1, 1);
> +		vaddr2_3 =
> +			_mm256_inserti128_si256(_mm256_castsi128_si256(vaddr2),
> +						vaddr3, 1);
> +		vaddr4_5 =
> +			_mm256_inserti128_si256(_mm256_castsi128_si256(vaddr4),
> +						vaddr5, 1);
> +		vaddr6_7 =
> +			_mm256_inserti128_si256(_mm256_castsi128_si256(vaddr6),
> +						vaddr7, 1);
> +		vaddr0_3 =
> +			_mm512_inserti64x4(_mm512_castsi256_si512(vaddr0_1),
> +						vaddr2_3, 1);
> +		vaddr4_7 =
> +			_mm512_inserti64x4(_mm512_castsi256_si512(vaddr4_5),
> +						vaddr6_7, 1);
> +
> +		/* add headroom to address values */
> +		vaddr0_3 = _mm512_add_epi64(vaddr0_3, hdr_room);
> +		dma_addr4_7 = _mm512_add_epi64(dma_addr4_7, hdr_room);
> +
> +#if RTE_IOVA_IN_MBUF
> +		/* extract IOVA addr into Packet Buffer Address, erase Header Buffer Address */
> +		dma_addr0_3 = _mm512_unpackhi_epi64(vaddr0_3, zero);
> +		dma_addr4_7 = _mm512_unpackhi_epi64(vaddr4_7, zero);
> +#else
> +		/* erase Header Buffer Address */
> +		dma_addr0_3 = _mm512_unpacklo_epi64(vaddr0_3, zero);
> +		dma_addr4_7 = _mm512_unpacklo_epi64(vaddr4_7, zero);
> +#endif
> +
> +		/* flush desc with pa dma_addr */
> +		_mm512_store_si512(RTE_CAST_PTR(__m512i *, ptr0), dma_addr0_3);
> +		_mm512_store_si512(RTE_CAST_PTR(__m512i *, ptr1), dma_addr4_7);
> +	}
> +}
> +#endif /* __AVX512VL__ */
> +
> +static __rte_always_inline void
> +ci_rxq_rearm(struct ci_rx_queue *rxq, const size_t desc_len,
> +		const enum ci_rx_vec_level vec_level)
> +{
> +	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
> +	uint16_t rx_id;
> +
> +	/* Pull 'n' more MBUFs into the software ring */
> +	if (_ci_rxq_rearm_get_bufs(rxq, desc_len) < 0)
> +		return;
> +
> +	if (desc_len == 16) {
> +		switch (vec_level) {
> +		case CI_RX_VEC_LEVEL_AVX512:
> +#ifdef __AVX512VL__
> +			_ci_rxq_rearm_avx512(rxq);
> +			break;
> +#else
> +			/* fall back to AVX2 unless requested not to */
> +			/* fall through */
> +#endif
> +		case CI_RX_VEC_LEVEL_AVX2:
> +#ifdef __AVX2__
> +			_ci_rxq_rearm_avx2(rxq);
> +			break;
> +#else
> +			/* fall back to SSE if AVX2 isn't supported */
> +			/* fall through */
> +#endif
> +		case CI_RX_VEC_LEVEL_SSE:
> +			_ci_rxq_rearm_sse(rxq, desc_len);
> +			break;
> +		}
> +	} else {
> +		/* for 32-byte descriptors only support SSE */
> +		_ci_rxq_rearm_sse(rxq, desc_len);
> +	}
> +
> +	rxq->rxrearm_start += rearm_thresh;
> +	if (rxq->rxrearm_start >= rxq->nb_rx_desc)
> +		rxq->rxrearm_start = 0;
> +
> +	rxq->rxrearm_nb -= rearm_thresh;
> +
> +	rx_id = (uint16_t)((rxq->rxrearm_start == 0) ?
> +			     (rxq->nb_rx_desc - 1) : (rxq->rxrearm_start - 1));
> +
> +	/* Update the tail pointer on the NIC */
> +	rte_write32_wc(rte_cpu_to_le_32(rx_id), rxq->qrx_tail);
> +}
> +
> +#endif /* _COMMON_INTEL_RX_VEC_SSE_H_ */

<snip>
