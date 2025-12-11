Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44261D41C32
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Dec 2025 13:00:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19868406FF;
	Thu, 11 Dec 2025 14:00:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id D72DA40151
 for <dev@dpdk.org>; Thu, 11 Dec 2025 14:00:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765458041; x=1796994041;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=2oNJRZvz1ZFQFQrW9ZkVJbOIryoccth9CrmzyeikI+8=;
 b=Ufaxv3Ncm4OdrHIFwfx0TOY8R05TVZdGwwUVu/2umOe4vkF4Ane4POqT
 Ayc3NwrCEc/UrELPehNEqtbbLkRISmBeBkDzqMtjAklbjIVnZn7AGwS6f
 R1KNkyfTGNSU8XDapEXfNYG3VA4y4XhhxwhSPSz2Bi94YoPY+n8xjpTN7
 9cJ4IfrNsUr055atGQDfORhqsfHjG5Icgk90daKIxrP9mF2DqLsWFCuSc
 DIjZis3NNW9vqHUwFg7fpEM7YiZ1SJHd11xothVVk8H8AZAWEv8Qi3/0k
 LYG2xBL/0K9/iBj1+GITc47QuRys8CueDuiIUCtipJOdClpxd1ozKBPfj g==;
X-CSE-ConnectionGUID: 4Ls8YmThSuqJr8NS0CmiRA==
X-CSE-MsgGUID: I47bvUR1RE+neOm15T+sZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="71305491"
X-IronPort-AV: E=Sophos;i="6.21,267,1763452800"; d="scan'208";a="71305491"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 05:00:38 -0800
X-CSE-ConnectionGUID: AnMDKhpPTGefQdaBKI64+w==
X-CSE-MsgGUID: 0nzFTGdBR2SixSyCEOheEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,267,1763452800"; d="scan'208";a="197067825"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 05:00:37 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 05:00:37 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 11 Dec 2025 05:00:37 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.14) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 05:00:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ERd7IfXj740ATYKwti02ROcfgn2bgdpQkpjFIb1Wk/R3jJfa2CoyewBZIBbtvNXVP/TJaLhsx6MvjplVwOUVufiaKQYKrhdz6aEwUh7m2BkyjXX1p9+doSqjZUypZ2VaZziln1a4F5hvhD7h4qqE1Zxb2SP9vRpmfdtCF3cM9RrycizsYLEf8U3rH8WY5xR456v0NKI/S0TgRyjobKviJ044kMD5afZEl7hWj4M2Aj9UnH6DBcG7oC28/oQd7fstWUULycs/uYXrYEO5XOGQzWIOL49uTMR1Dx4wkuLKdVolc8V65zPi7hr7mAjBazy6MhbcaIgsgZXjWVqb4N0qOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NplHF+pWgjd+S3bT1cxI+OPaUl75+qE+0iWXPp7eo1s=;
 b=VK5QPjtraGcEKfswMKqBZxQVE/2EqcA50L0dhx4/4ZRZ+QH7cxb6XLLBd1WMV7tgXuZN1q83D0yDGukyb3SJFViZw5svEsSb6ml5t+EnO+Ejwr5JQ+RvpgpnFmIOOY5eThaP/7z3XRF4ZnEq/weRy+/ojky8Dyh8m3cFqtwe7Y/wrud00K7YHSj3I8JWyWPwM5g1B9XWaYVVKaS5JuVN4hJaWm8vEY3S8K11rDTA6rUk6gK7NgucBrrJd6/a4zCbqMTz1jdHj6MLIQz3S544vF3UbGTQZo0A1b/KIxeswu9uQX6WNisiPuxe6SKFxryG57qIhhgVp67FZityiDN4jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM3PPF4D011AE7D.namprd11.prod.outlook.com (2603:10b6:f:fc00::f20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Thu, 11 Dec
 2025 13:00:33 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 13:00:33 +0000
Date: Thu, 11 Dec 2025 13:00:28 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH v10 3/3] doc: note on unsupported completion queue sharing
Message-ID: <aTrAbBuk99U_4iGV@bricha3-mobl1.ger.corp.intel.com>
References: <20250917052658.582872-1-shaiq.wani@intel.com>
 <20251028142202.137392-1-shaiq.wani@intel.com>
 <20251028142202.137392-4-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251028142202.137392-4-shaiq.wani@intel.com>
X-ClientProxiedBy: DU2PR04CA0355.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::34) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM3PPF4D011AE7D:EE_
X-MS-Office365-Filtering-Correlation-Id: 61bdb64e-5991-41a8-b652-08de38b544d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WaLM500v76dbXvwMjdNmzxgIB7gQCMsPgmEVoGwAhMNCG3CM3P1oI5c1h+hF?=
 =?us-ascii?Q?E61UcWWw+ZjBw92nvnFBgT3COhB8uqLzERj2Af6L8YJsKyfth5iMBXsoJUqJ?=
 =?us-ascii?Q?KhxitkNWqbKwXuCf3S7TnuRruWujVund7OAFjy+qfyVJJZOMcXdkQ2/zpWLt?=
 =?us-ascii?Q?qkN9qqJ30m7horTQRm2OrJekogbwILqw1A15PvANLtnmY4IThc1Yvr1mUR4A?=
 =?us-ascii?Q?NqMt5F8vvB+msvJTd3JoG8hKvQRET4ClEcxavVyBI7fR39Vp+37kXBgYDFAZ?=
 =?us-ascii?Q?5JJfEp/6LQF+TX+iUnRtkjMBlp2hcrYXtvSwrPUY5VbEsKXE6K781ymcPlt1?=
 =?us-ascii?Q?ATbX7QIGyMNNEJQ5GQ+eF9WVTQS2ckl4bg3gtnf+VMyDeAPDQt6Bku5yfarU?=
 =?us-ascii?Q?Zah1hqG98f+9sEpjGaWsXZZvIU7sBA1E7F7hMuESccQICTi4w7j21Kuhfhf3?=
 =?us-ascii?Q?PrQmrs+/aghWPGniyJgrfSb1b/Gxha/BWOuKcwdr17KyKZ+Ygq9G+c9CrkrD?=
 =?us-ascii?Q?NoEIamJFLkCDKLw+TUf1AlTW/zlniglYn0w1oCBA1dBVnQIaN2AHdA9Wz+fP?=
 =?us-ascii?Q?VIiWGzP+/hgdo2iNDMpaZ0Ih4UGnVc21Ix7RGj8Z4rg7LluVBFuqGTps4xIg?=
 =?us-ascii?Q?K1T1GV+nPrhQRfc4CMZLszqbNaQX7UFENFwQFILRVkPbBTsPpuhrpCyjg+vv?=
 =?us-ascii?Q?GZCR8gfaZuYpoRGBb18FO7kbiX/9DWstPTObz6Oz93KQyF1JzDqJ9XrlTeAj?=
 =?us-ascii?Q?So1O6ppz1uce4BH9uG8PG6lvtSu5eH4fleV8THy7A263UIO3iK+wHc2g2u6T?=
 =?us-ascii?Q?y3g2rkB3UhKrqy4MUDa8mllAnbVi3rFRqNcMzqm7UcirE+ki0K0ltXHyVx9P?=
 =?us-ascii?Q?dZ/6HtC9PVF6XW5/BQfG0/KJl5o5M23dhpANEtJG11SSFPiguZskCsuXcPI9?=
 =?us-ascii?Q?PoZkiiEc+mtcW+ynXTpiYNtDdsFzUHE0EhH4zD+qqhRVV7Gm00ILCb2UsgEd?=
 =?us-ascii?Q?WONbaezIlNJpx+7sDrnxJ7LvKzF6c7b/CmXr7NpwU6X/yXedAqHu7z0QzaHM?=
 =?us-ascii?Q?8ZQSffNIUAXAFFkXYDnO1BgDluOmcJsZ0tFkTkjtPrK9G5MfURh24ScMPwek?=
 =?us-ascii?Q?uWNb/GeWagbTGHYPsHgYWjLZ5uMDxy3O3gKtpRxLpTprfZU15Wbu8k3VJ/3f?=
 =?us-ascii?Q?3yR5CeFVbnWitl30cvbq4ktMOToSW2V6MRKHA1j0TsJ3nbyvyy28Kz87Jt3J?=
 =?us-ascii?Q?Lv05YHgyUjh+79HqkIIwH7Y5gTnfj6QuXVhMVLNZlob7qDjfuPO6PVax0u7I?=
 =?us-ascii?Q?C2QOfBsnRBvzoMkAgWDK/P/TyZ3CZc+S/cOCgThiO1FNN5FsjpegP0yG9tcY?=
 =?us-ascii?Q?Q61EEZxTB9zkatpHhj8ZFj8jJJOsIWKjFwZo+wUyiDeu2oju1xpgtY+iiStC?=
 =?us-ascii?Q?r4FRfibz70OJBSbWj293z/zJHPObDmn4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O5KK/2M3MwrC0yEkv8KSWMD1eiIfad7d28OwO58g3vLP0RXAmaWAq0kPuEck?=
 =?us-ascii?Q?HTDgVS+qdBxIH1uIOx9Sw6p5chTtmN+BXbQQccOa9MncsnHtyDVUwdU69i7i?=
 =?us-ascii?Q?BBME6V4ODR2K54wFQ4prV1InTnMTO/syEhNZZOUMRM7gE+J/feDMrhtIOBHT?=
 =?us-ascii?Q?1rFgrcfFvdjo20dCpO1jt0BqaGDgDGXcB9OKnLu1gW2675JRJ2nuR2sBjOh7?=
 =?us-ascii?Q?c/oV7kqE2MCYvpeKupvud5yFd53FLNMeQtHegRPbxK9AKF7mw4hdsf1sp8Pv?=
 =?us-ascii?Q?fU2gT1VgWjGSMqHlOCkiJ6hCNQUKgs6cJ/6sAnE5pUh6xYPBtJhSnMi/Tq+b?=
 =?us-ascii?Q?oGL+YGp1zDpc1nMRRMBxLv1KoRxJ3e17kjrsn/W0QBD/HalEodnEKYaz1EUz?=
 =?us-ascii?Q?cjMjrRpVb10V8oPV8uIzPHgMhriYOrFEQVocj6G+E+S43HvOwDw8KkKycJoL?=
 =?us-ascii?Q?kpRP+nKZEaM8n2JYwHUkLEwoNP4dihC1g2CX2mNaFgChqRHom2Ik+lTUJdK+?=
 =?us-ascii?Q?jWSmSAVxoKO37+sIF3RDCZkkDe12VPFKFBcwADEDtglQg2R41/7PNLrUGUUt?=
 =?us-ascii?Q?l4sFVgsLMN8QqC+JsfwF1bFTve3CUW5mZDpyHnsUzOndHf+M9zznV1qdhwe4?=
 =?us-ascii?Q?IZmELZAy+MJDfHuMAoFrccQKajKGZfT3dshJIp5CqRXPHhcYmti7IeEGDmGX?=
 =?us-ascii?Q?FO2G4DoQGAC7JUbKVa3JHwe/5BypQg3Ppkleiloaaw2NyzAwNU4jkWS+gyRZ?=
 =?us-ascii?Q?sgBzCu01rbrdQnVpZYeZNOkO1xnUmZ7sAfJfpmj8r5dhmMinQQi/szbVYK7M?=
 =?us-ascii?Q?WnCMP+6Sd8WFhIKykTQ01jJCw21kHCGwkcv6FuInkyV0skrqaUbmS6J/Pju5?=
 =?us-ascii?Q?5aGnmqetRcH024HaHankugbenPstMU7peM7o7uOIx+FIK4/AM6jwXyhJD9hs?=
 =?us-ascii?Q?KeF6C8euPNyLO7FuNLughCdgaW1C3LXOazs45io/XuTE6R8Cnsk9FtfUhGV/?=
 =?us-ascii?Q?/Gac1bZQfjGbqOVrPtCfMMe1g4AcYYtJqYAWJegqi6M/FVpNG2NDKTmKd8T2?=
 =?us-ascii?Q?4o2dckF4/6oCaTI6i51prgMtX8wwmK2lLOcYQU28aGZyURAUh9qVBtrLxffH?=
 =?us-ascii?Q?c366dBPCtpp5eocigiq/hEum7H1qINT1QI6LumuM9q2lSSjHBmBv9QqaW+Or?=
 =?us-ascii?Q?b9McPqOiaZDXkUJz9wnaoctA2eb8f4rmaiLDBinsL8qwU+CFm/8GGNwyHLNm?=
 =?us-ascii?Q?8kn7GVmGcmKaEiHUdR+dr0eeXJvLIFCMZD0cf0GYstFe36K/tpScutmU3/6r?=
 =?us-ascii?Q?uRmmGQy8hz2lsmy4xgev6iTa7drl+XNxsi2BANG/rs2oPRru0bjA79souDZg?=
 =?us-ascii?Q?NKxsuAdT/7VaI1WxJQ3ApcU3L3TzNj93eYfhwsNeR4Imcn7Ab7fNO/Y5Hijs?=
 =?us-ascii?Q?s5t7abU/TFXsSwN85DRajvzV9Yyr0ZkL/ltoZIiT/lc9qEYd6c1Y8V6DK8uL?=
 =?us-ascii?Q?sUdKfY+qOYy9/pdOfx/OUTbu04ZJqp56fphs6MnSBG/Woxw8c1JncFJ+FTWQ?=
 =?us-ascii?Q?hIEJk6ViE2ZV4Gb4aPsVdCuMSubEhzRohWm+6rCKzCajTk6gj7eVCh6rnEbV?=
 =?us-ascii?Q?wg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 61bdb64e-5991-41a8-b652-08de38b544d8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 13:00:33.0154 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Fhy4YQpAQhw2+C7F8zNWcwjftpnlRsu+6y4aix0RIhm2qR+3iQscaaSz/75fn0P+cv35s9V1hMH4VRfAYeQL3CiQ16fR8x/Hw3XAVabl7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF4D011AE7D
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

On Tue, Oct 28, 2025 at 07:52:02PM +0530, Shaiq Wani wrote:
> Added a note in the IDPF Poll Mode Driver documentation to clarify
> that sharing a completion queue among multiple TX queues serviced
> by different CPU cores is not supported in split queue mode.
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

