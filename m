Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF72CD8CB9
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 12:34:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 707394026D;
	Wed, 10 Jun 2026 14:34:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id A6FFA40269
 for <dev@dpdk.org>; Wed, 10 Jun 2026 14:34:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781094877; x=1812630877;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=y+5u9G/prusxQAxZyfajIH94Vcc9D2EWOumYfLIG39E=;
 b=FWR7o0CcM9rf0dkmJx/wrt/LjGX6F6GUyFkLGJj2BY1JYvaVLsUKVegS
 PqHXcIjKbAh7FTRfgmWiuQCWLmrFhgEHnAI547V9QQcv+AazWe+sv8iG1
 WDwbmO0qAdrGjF6fyKjU8Y44fGnp7Iu11sfA3zKwucQjbRT8UZ2uyRQwQ
 zKfJLA0ES+ueOdpOK0XQ/9TAa+Iqu2TrFXxt43ClxOKvoLAGIaXsrSZ8B
 uZu1Ox9mGtsnRT+nYO3adRFd0oSjZCTBRB7XNXC8Ht5B+RwB2TF4ipbyk
 ukVkdEm2f6jMB5wDMXos3Meq7WlBgyQ5ZSUBqCr7qEbpOOAGFCjX3/BME A==;
X-CSE-ConnectionGUID: 3sBtYE0iSNaf8OmGfXbuMw==
X-CSE-MsgGUID: 30PKahmNTHifontnl2fSGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81733890"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="81733890"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 05:34:35 -0700
X-CSE-ConnectionGUID: 72XsTMHxRjKsdiV1DfR77Q==
X-CSE-MsgGUID: JfrYkkBAQbmOpx2bOlZJjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="245312506"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 05:34:36 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 05:34:34 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 10 Jun 2026 05:34:34 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.9) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 05:34:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWmQoa64HLShbAMvyHiF0oqAaHMajndJ1nlgFyh6snKTB4e975oqinALeCl/Y8jQ7lZUl/9cAOJU1cQP2SY38vrVUhntx8HBiRoJ05eDLgG/qeLoUEW03mxxoyBom4OAHD9IZZMXwPJE/bbxKrp9JLNG+TWdHD7JHWPfnLGjzuKUmr+nglOpbNElW3aMPUMXqQ0CHuax6FLQv6ttfE7Uj5pHonGU84vU4WbO1NJxeNELXHljVFNV57PsI69ZpmQvy9AztJRzfFoV48jdRH+6HRN4bUfDXwKUIIeHQ0qVj5mqNTo3c1JPAKCly5X0vtpR4QCrpFx+1KL6Cqg2D+NHtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2eNO8qeGP+rfLqgw9iplvx0eNhCxopYhKA/C8AUwCvw=;
 b=HXGwFuGOMp6I8IOZ8uRG+eFHlQXNCqZ4ywqFuL1VI+8jXhTp8TA1ViaKXzfqqB0DCasxtOTC3iEJZElWW0/48emCl4ofHGB4sM1LRPImRQkEHc8sYTch4dOOT50Si3ofiq/Tsx+6AG/C5mVpt7J24/CY7apN4+Tjn0DwPAwG7TKmtvC1lsFIhPhZY4oCCxhb24apZVgDbgXnukrIv7ARAWSTdMkcEc9ZVb7rMmBWndkdbrXzNMhPVNku5+TZWK1L1A5ITATzOtLmKxZT7lIaY68juhgvF020puOA95V/9vUwP9xq/BUwMk7IFbA7S10djhlKSoSAkMSoWxC/feBOog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MN2PR11MB4534.namprd11.prod.outlook.com (2603:10b6:208:265::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Wed, 10 Jun
 2026 12:34:32 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 12:34:32 +0000
Date: Wed, 10 Jun 2026 13:34:26 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>, Jingjing Wu
 <jingjing.wu@intel.com>, Praveen Shetty <praveen.shetty@intel.com>,
 <dev@dpdk.org>
Subject: Re: [PATCH v7] net/idpf: update for new mempool cache algorithm
Message-ID: <ailZ0hlozLYsp6bg@bricha3-mobl1.ger.corp.intel.com>
References: <20260408141315.904381-1-mb@smartsharesystems.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65902@smartserver.smartshare.dk>
 <ailLDte3Xo8jsUWf@bricha3-mobl1.ger.corp.intel.com>
 <b0-eVG8rSLyIiCcsmRSskA@monjalon.net>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b0-eVG8rSLyIiCcsmRSskA@monjalon.net>
X-ClientProxiedBy: DU7P189CA0030.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::34) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MN2PR11MB4534:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ecb1397-28e9-4406-ad8a-08dec6ec9f64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|4143699003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: EZ2imWkDtMaDAOer7YKYxs80jZ8pYW91SQFMywH6f7lvRAPeT94lOpaG/jNIBBTE4ONnbVTmAclim5CC0fjvXadCilzSdh0i9a98n18szXdiJu2gzuKIf9++GSv4sTbT7fAcusHcws8hrcnz2BSUYgA67Alk8dR4meI3SlyWllFQ6ukbxkOzjgN6qCGFCrbCpdDSbVp/Vdn0QFQmPtt2Cp2W3jW7/AwyqoUt9aPhIhNCP7z6D7ZRFXyXx7RDt2z4HOfu9amFNV1ZjVuV9XgKu5IPevjzTaXtV+C1FRcjo0rcYorvZYwKbqRohnyy/ou80OdAIDsNps5ypqAfp2zGCzMfDhNGJu0PwRN8xTVWHsGL5feOgpqgrJRSaYCawQFlDqjkFEugdpgLd1QYRjVvM7Ue0qFlwW4LZo0clOnMdEuQGKQtcmfriM7/F4N0ruSl9oOARzgh+HbjKdgHmPD6kCMWF/lKCimFEBSY8hk0yoH+T8+jfXmwlxLD9VSkL0C3xwkGXrrclwPNoNvXRKmshuNcBU6uSFJ2GmHJMfFBMj24+1+wEt/LbwDR7Vh+ZwqlZjf0ShWn+8S/sjFuANjwoXbN3Mw1lEUYzpHgXJy49bf2sKKeXm72NsDtmILh67xmXnYXviZWOEYxqSqz5kY7alUVx1DEMUumSMJ8FHCHy1vtV1kPdnXE80IZt1+pMfDt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(4143699003)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?A5zkdlScB4IFTr6Qsvqelc3oHfbnl20oyM/DwgbY4aNyQhXNSBfjtW5OEY?=
 =?iso-8859-1?Q?UYcpPs7OGnWRHo5CPa0qe+5fVVQ9tAAsIM4JwTKhnlPavkbDXqLPeH6APW?=
 =?iso-8859-1?Q?++iDDpGba8PPOA+Eb42svKEpKsg6wgBazBMWOGzdrRXJouiBjVFkdvA5NV?=
 =?iso-8859-1?Q?9Si38dijvOBsO3utbXbK1aL/6RMhE80lfUi2l/0O8y1/BVEUk4bAow/+3v?=
 =?iso-8859-1?Q?pUo0fRVMB46sQAVtyz/VckUT3zL/KPYjYDJrrplzP911nT4XPfYlcjNGB5?=
 =?iso-8859-1?Q?U5NG3Lg5qVV3eYTyw65kCXDTQtvbw9pQrQocNgBMqKsifmDyrKGRAQEp15?=
 =?iso-8859-1?Q?d0RzQrE7/iq/l4sLTS8RAOkT/wjxIc6kFBgTcnxpsQnpY7ShRPLjwms2aT?=
 =?iso-8859-1?Q?wf6ry1atVgQkb1MY6IHnloETfBU9IsVcPLtVpbW/G2UW+EUdtw+WE68Qfg?=
 =?iso-8859-1?Q?ditWfNhRMkwYjfL1o1dh/MmM3MHTx0eoDvrxq30rOshJ70efVRTKihUaaq?=
 =?iso-8859-1?Q?qQszV3ZkoCv4zgzXX3doQEkoE563Bwto4OlaULyfowMmkKqbK5MmHpWmx7?=
 =?iso-8859-1?Q?/73UWqMJAeoDX7bZmfIaPAR/LgYi1Js/SphVPI8jkElkqmNoDXehYUnMD+?=
 =?iso-8859-1?Q?C7I4DetXodOXQq+6wWhkbtljl/dCCY8ksB+cCLb+SiCHhAoX5uGv70vZmM?=
 =?iso-8859-1?Q?dMk1UtkqfIS+1uE8/QTKtdIcVQfej6R/6jXUG8flFWrHQ4prOr97+u2EIs?=
 =?iso-8859-1?Q?7cpU+WleZaPAS3iD3khm///Aw33BiPA5KfuSFlKxFxy0nYmOgnPGXoInTJ?=
 =?iso-8859-1?Q?evffZ3HgkSdJXNQqwx5893pc6W8blrNGmPLLVtWLh1tSzalXLVEdrxUCF0?=
 =?iso-8859-1?Q?Q6bdlt7BXuEgjICFj411u4TjnGcgJghxqILOmkiXP4Al4ZDfbLHgnKFa0I?=
 =?iso-8859-1?Q?UlWGZcpj+RUcR8M16LJVhoZOAv2BwzA08vLDuQcTyfnYiQCqKZuO44O5Gr?=
 =?iso-8859-1?Q?Ai6txZJqznRpvK8BaP8HH8/mJxJUjcEVReTqgd9idDdjfynZDr+e4PHk9/?=
 =?iso-8859-1?Q?+zcrzozlQMJaP8ALn9GQ7P9hOVftd71019qD5JhVdEORIa2iJ2yobDNyat?=
 =?iso-8859-1?Q?DRQIppPbPzI6xaszX4U7rWE4czRCiSVqgTpwpQoAiqlN5uE6resrXvkJx8?=
 =?iso-8859-1?Q?B86tgXDhXFt8YrfeumeiQai3nOklYbNEwAOIFMYtiAejLVYizI527yKczn?=
 =?iso-8859-1?Q?eAu2b6d5cTRxrvH/OUERbhuyKwrEwLwmL5Kz0mrqZUbXPryWacBJ4OV62U?=
 =?iso-8859-1?Q?eX3XTPxXbt0Nj3QCgjtjjGz0k8H6xNORh74fM5Om8s2EQskJVgZR6+BBDy?=
 =?iso-8859-1?Q?IyzhJ6IU7H42Q6v3v3S44d6U9cx4VWHtn64y33iNl+W4vJ0ISuVwjmicwL?=
 =?iso-8859-1?Q?95WqcswzgiRJqCc/lGJVTV3QVbnwPGBSzN+UUmx0+ZwaMml+bYRj39/kn0?=
 =?iso-8859-1?Q?YOgYr9yhZzixXyYoCopL8OZg64fxPiy5m0Ao52s6WBQ2XyUNBi0bHuHvHD?=
 =?iso-8859-1?Q?DaaJsG5y4773yNSLc0YFXQMpzZxUuSH/fRMRwuoLWzdJ/dNOl+wPAtVk2K?=
 =?iso-8859-1?Q?E8lH9a4DROBBFkiFvjG4vxY1HCNPsLkUhn76e+f+Lpy9n2/BonLcmF3Xle?=
 =?iso-8859-1?Q?V2BIHdrYFbsCFeQzaQQrEq+whfCTZ8LeNCV0+KWEVXq8ydRFIMQ6s5mwmG?=
 =?iso-8859-1?Q?XPNvoqEVwyNvK1/HnAIZqjC+p9an8qGN5HnC+A+xC0UF+VTzypD9sFSEbY?=
 =?iso-8859-1?Q?7t3ljK7j+kswXuxztazPJe4WaKoDD9E=3D?=
X-Exchange-RoutingPolicyChecked: qvaufhn67aD+VajuIxm3Y2tKTe//bQgAaqs9+npFQe6QK/FlDdoxaupTikZGJd3TnDzeFr1eqcpoc/HZY+WnDp0dIKK1hF8nrY9Qcg3KTe6Ay0BSxCTkEsXHw+5r/XvIFPxHG8Bn2jtzH0Oi7ke26EfhTaSGDHTd9AiLLnpMygRLEyQ9R/F6dUyUOnEFULBBhl0eNY0heznoflHmw2vyl0WvM97DbW2nsTk/hIAGgj8uWvEUt8jgGn62Gfk8mcsagvb2h2EV1na6odwfh/f2Fx8Xy7t+7D4dl6Xz4ubZdBbEtcrtMH8PvDGfgRlOamhR8Vd19sfJHxrqeAzjqthunw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ecb1397-28e9-4406-ad8a-08dec6ec9f64
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 12:34:32.4457 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYHxv93ZevgPaK2FhhU28qGMUY1w41EvFA8oWHVLUM2U0VoBZyAUMiEuHRfRAa+GxbmVpRAK8TeqWTHRmEOyKBuE5gLOUdNymMVK/K3ATFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4534
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

On Wed, Jun 10, 2026 at 02:17:43PM +0200, Thomas Monjalon wrote:
> 10/06/2026 13:31, Bruce Richardson:
> > On Wed, Jun 10, 2026 at 01:21:38PM +0200, Morten Brørup wrote:
> > > Intel idpf maintainers,
> > > 
> > > PING for review.
> > > 
> > > The mempool library has been improved [1], so the idpf PMD - which bypasses the mempool API - must be updated to match the library implementation. This patch does that.
> > > 
> > > [1]: https://git.dpdk.org/dpdk/commit/?id=f5e1310f16e0909e7e7f71807123644c63b23cba
> > > 
> > > 
> > > Venlig hilsen / Kind regards,
> > > -Morten Brørup
> > > 
> > Yep. I was waiting to see what happened to the mempool patch before
> > considering this for next-net-intel.
> 
> I've merged it directly in main with dpaa mempool patches.
> 
Ok, thanks.
/Bruce
