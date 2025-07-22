Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F04C83F25
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 08:41:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A121E402A5;
	Tue, 22 Jul 2025 10:41:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id E363F40265;
 Tue, 22 Jul 2025 10:41:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753173677; x=1784709677;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=fDP+QfBfzYyR1NmkWfR4FUl6LSVFkgA2tm6Pel9z9jk=;
 b=SSCbJPpzGewhWZEHn4zLZ1sqGbM7FodyTZ9NZzMati0wN0iFCzKGWNCF
 qYoU3/HW7YNU9e2fNN7Hba8JKTBykSzB9aKPd2ISGMWdHsIc8Ycz4lwTQ
 5+5K2lYO4h71srxh7pfqXH2OKr5k0appay04hpfrW7GaUmq+o9hSlKWk2
 FRKbefiqfxHaPHdxI6+SdDlLf0ng63EPkEY7QGZHCgRi6JS3N6lUM7x25
 1O2uokxSs5UtXRylvdNVHgTlfQQLV3ZS7ytAhpBPx5rjVep/JV1BfcwcU
 C5SQIwqijcPNefXnCPaPnSbBb2hVEwlZ6B39/pE6n2HpX4wXZxew6dVfB w==;
X-CSE-ConnectionGUID: SaT+EBraTROY/zTpu2Fg4g==
X-CSE-MsgGUID: vWexRfrUSmGaGyevx0pETQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="55525542"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; d="scan'208";a="55525542"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2025 01:41:07 -0700
X-CSE-ConnectionGUID: Rl9mXqzaRlaCRdxmLhCvvA==
X-CSE-MsgGUID: MZmWt2zrRVePvhvzL0dHHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; d="scan'208";a="158852941"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2025 01:41:06 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 01:41:05 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 01:41:05 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.67) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 01:41:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmRf/zLNsutBNlq+7Xz3j0/wypwuipalwOo1DulTvDh+N2B9PkpvsAzYJ5dnGt0cBUz8aLiTlakN/BSKsCT8MnDuXiNtwQ/iFWmEGDf+8GANq9XDQGrfESGSFZVTuhKy1v3/CXXwUpq/itfa4hHS4TK/9Lhjn1FBpp+xqr6Pl5uzWIgPe6/e8BFlEIuDNgJdT8H5O1YgSPAHIiFaO+F4+fZNyqmG4cSiCzpw2rMvdbgEo8CAo8SPSeMc5XwklS5kySkkzQjntGUu12OoSPfK8Lm76lqW+t5RMmVSSJAu6Btn9I1TYMYmb2ArjCc7FuQ0eacWGEpK0rPVqIhHcETJlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpnaL7yOhakYSeNJzJ2No0MBhhDu9DOHxAOwghlQRv4=;
 b=FQ/pW1UHKzzggSKOLRaLLMMVM/yqPJJVi7LanXdb2JAxmXlDDlTy5Ty9SCZtZ8/xeEniopG+/q02emwSDLz5im6gm+mJzI2wG0Xve4J6t9eWCF8yKQKhoWD/T9XoktZMtk0gLz9q7HoNjJ1cV9J6thuUbBTtQX5fWK0CBKIJHfRZk8K7OCKv1UivYoDR0r6lVGApb0dB0GWccITSvW4UuUOkV3x0oRuXuaxspvF/TFXdMXzBpP6tCFcC00J6tbx2szGY+FtqSyWYLefMLYWkbtHLBcdbGmV1EnE56JE1V1JkEtRVIebwoQyOVok1opICCZtSAZSsQAxNo6XyY/gylA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LV3PR11MB8579.namprd11.prod.outlook.com (2603:10b6:408:1b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Tue, 22 Jul
 2025 08:40:22 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 08:40:22 +0000
Date: Tue, 22 Jul 2025 09:40:15 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Mattias =?iso-8859-1?Q?R=F6nnblom?= <mattias.ronnblom@ericsson.com>
CC: <dev@dpdk.org>, Jack Bond-Preston <jack.bond-preston@foss.arm.com>,
 Mattias =?iso-8859-1?Q?R=F6nnblom?= <hofors@lysator.liu.se>,
 <stable@dpdk.org>
Subject: Re: [PATCH] bitops: improve power of 2 alignment function
 documentation
Message-ID: <aH9Ob8sReOBJw-yv@bricha3-mobl1.ger.corp.intel.com>
References: <20250722075321.121254-1-mattias.ronnblom@ericsson.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250722075321.121254-1-mattias.ronnblom@ericsson.com>
X-ClientProxiedBy: DU7PR01CA0045.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LV3PR11MB8579:EE_
X-MS-Office365-Filtering-Correlation-Id: c8727d00-96c1-4b27-cf2d-08ddc8fb6551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?0TPTH/kSdguT7bE447+5M8KaYi/6CVH3AX4op4BiTc+ale25nMZhOVyMkk?=
 =?iso-8859-1?Q?Q+hTAKVtc5ZO8JJWQ1LGOsnuU7oqGzgYcrUa/I94LBSokbPyIll1of5qON?=
 =?iso-8859-1?Q?H+IyDYzT0Kwfu+LdjMdr270tAx/OqqkOBoU0vFyDme2HBpL/hJ+1RGS0Ss?=
 =?iso-8859-1?Q?i/FYItZdojydfnCuugaNrbFN7zMsv5PsueE3qU63cGWQtcRUly5pVt3GV2?=
 =?iso-8859-1?Q?iyTyAeMv09l64h4Z9TF6s4S1OAeSkh/aBeWSP93RSol1vP+sxDDhMf+iwE?=
 =?iso-8859-1?Q?6keF7Njl6vviQH9IvBjDd6WI+7Hcwetx6V/2oUxNF5zSEvMQAkMc8hV6Mr?=
 =?iso-8859-1?Q?udkB+MI2XzZQNfzRfoWPZw+CS1TxI4aKSogtdj/MyWkKxsQckRW+68krdy?=
 =?iso-8859-1?Q?HLd+EPSJ8ywwG4qVhMuPLJPXDuO/Y3CJEikTVvl7rnOCRsPkaOgSGCsjk8?=
 =?iso-8859-1?Q?F+To/FQ1pEmiQDmNZSCwboMEeoQiAx5eCQLEjiv4sCrziRmLkMb36t/Atw?=
 =?iso-8859-1?Q?0+rXr5pbRtq1mCVfr8AkQ9kKnqTf0WWthzv1rFm2tKzYSVbaieawQJKqhP?=
 =?iso-8859-1?Q?UqKaYNAryEARmpKhZ3Y0I0bZzQ4fGfttse8zaGCQJQ1KMak0iQkkzHLJej?=
 =?iso-8859-1?Q?1vxHorv8WBS2K4tC7E30+SUsrWwpfwGLA27tOH4MQVDj52MERCtEXCAq3J?=
 =?iso-8859-1?Q?m6VWKhi+nkwzXYWjUJvJTtoNIyPPwjKrAV7PTbBtysycXK9w/BHNUopDm0?=
 =?iso-8859-1?Q?iEeli758zcOItdEF7KVnY3rJSY4hjzRzeFbV7zCUfRg7t98jpIWEBDuRvk?=
 =?iso-8859-1?Q?XVYMAFYSHPF6WDrIm79hC1bat00ta3Scg4qTPpAC+hJ9btXhwStq89/xO2?=
 =?iso-8859-1?Q?0QdkrXgd7sYhJu0LZ3MwgEVUv8/kagurDBl3ByEkSk4+foZlC1CSOM5/kB?=
 =?iso-8859-1?Q?u+dh3XIN8AOp+zkgabGLQko1ZtrXwuaYMP4m7lQ4eMX57G9PAePAZf61S8?=
 =?iso-8859-1?Q?pxmN5Vg0OMIAsO0vgJX86mD71GEm3L0xpXB4GbL1BEvcO2SleIKMCZWGeC?=
 =?iso-8859-1?Q?1PQS3NX11kV73RmsyGoajVZMyo5MA1a5ARJxNCb/CayHj1Co1vGIg23pLm?=
 =?iso-8859-1?Q?rRJ66IM/pLJNbFy22E/ztIYG50/m4Bl1wfGkRYVlNC42yH6kvu4o2F/kwM?=
 =?iso-8859-1?Q?mT1o0Niqj1U2KtOCKZVe/iRV4l9r35N+dshuACoPqfffwRnkilx4vCSRTb?=
 =?iso-8859-1?Q?xecFKc/NTBCzu9gsPCdnlPAjA+g+JRN4PbAouTjcp7ft/Z2c/FNKfGE5Oe?=
 =?iso-8859-1?Q?0dpSlmUYNawQAJ0pLIVa/Hw8IKpagxTrodW1kRELmMqkrcEDHP65jwDju4?=
 =?iso-8859-1?Q?04JrAH5AMvTxHQDsvIz0GXUgJeODtD4M2HJVVlZVhybgjYvI7FC14J2+Y4?=
 =?iso-8859-1?Q?T9j/wbyoV/t6ANf86JbHhgNy27iqyO8UZjsTmmdkfz6pQk9FYdmiZnxkhB?=
 =?iso-8859-1?Q?s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?YfFcFhuftMrgAlBc+OQ6F7NPby7EOBr3uIEWkapVl58BitxtJoODyEteUK?=
 =?iso-8859-1?Q?16XLgBUNq+q6Yy0x/z9DVaub82oaW8zVjnVSbZyZy1GSrTURlyQH88AYR9?=
 =?iso-8859-1?Q?E2LJ3DESnRzqqKugOFBeyWRLhPMg9ynCxAHWwe+FT7C2+I2K6H3N9XRHhP?=
 =?iso-8859-1?Q?41OJF7aOSAyxLv++8EDMvKpP0EcS5JqCfbrTFrO4JX2RmFT25/BffrKJWh?=
 =?iso-8859-1?Q?C00sklYJWKWjb2VeHhlFf1lTrZfEOyCnv3QSJor+w94dqESfSBT90DKIJb?=
 =?iso-8859-1?Q?uyLv8btw5yfHaCZGALqEOUvVsw8M6Gajxu7FMcvUfWnKPw5H4iqFNEa3xk?=
 =?iso-8859-1?Q?Ft1yTw77euVgqdvvTW7WHHOEuiuxaDWd5K8tGbA4ypXIAXVpzFvKDXgYWE?=
 =?iso-8859-1?Q?CSpVIPT/0PmvK/NY56DzRn4dCy0zrznZeamnGuqUfHs55aVdeMaCuEWgT9?=
 =?iso-8859-1?Q?DAR/CYQduLKoqqp+EP7SgparMbHkxPPp7WAoZbAqJbxGqM5T7lc6b/FVGB?=
 =?iso-8859-1?Q?tDPSOgCWWYNt7IZQSO++ZoVZDHm/VR1M/4pyjS3pjgkB48WrMC6p+t8NOW?=
 =?iso-8859-1?Q?b11aILQJNiTF4qP4nSrpwcK+8PadSm+ObxcX9XeUVNZDOkhjJX21kBrTUi?=
 =?iso-8859-1?Q?E45NUoVdarh2BkEV8YsRXiT6cQUHmDTsOzTuCc3Wzjfjkf9sEozd+IMKMz?=
 =?iso-8859-1?Q?keeghlgTcUtb+sAuNUgtwphtVfPAkc4C9bT/mS7ybt/WjCC8SfGqkMqH7N?=
 =?iso-8859-1?Q?45u+KFtdvEyFdOFhy7eKVwGeVcuq/HWEE1x475dtML99+7TPGWQIhiAHoC?=
 =?iso-8859-1?Q?qax9afcawcsc3s3XVZzFBhzMBz9q+lKBfglOTAUq3BG7MWUybSKGF5JBxS?=
 =?iso-8859-1?Q?OrCF/61O+88Q4dFppRV1aHrIqbduvIfhLRxHDd5eaKMGygFvgsBjM2OukQ?=
 =?iso-8859-1?Q?g2wHUdOe6C7Dfrk9Z8L04wHqZvM0aS78EuEhsm+n/ywtgP7JUbQEjq6gA6?=
 =?iso-8859-1?Q?XqJfIyDUc2whF0qlmNlN4QwiWV5hDnzplgo98I+Tea+wb193zBg+Y+SBbw?=
 =?iso-8859-1?Q?orfZsTq9XFEOCQmqBnM+FNJ6Dqrz/h4xd4NUojsO15A5zlHzwcKClW4XMh?=
 =?iso-8859-1?Q?tJJdgMXSSTG1QrPPUDfiE5+6cnBDmI3o8yed4HYNtyZW+PebcfndCWUJgL?=
 =?iso-8859-1?Q?zBXuQjwGdSjwL6PfHZKw9vG2wwuf1DObTSP3+ztbIWF+9N4vdq24KD7IEL?=
 =?iso-8859-1?Q?rP1nVIRPnzKNSm4fmvmDrRrbfRgdXgBPLFO/0wnvntDUwOdtizkbOMUC06?=
 =?iso-8859-1?Q?DBaTdJ8+cfUsCz89B7l6S7XZ4d4SJZmjQ0MZvWYKMkg+4/WI2zYoo4jtpN?=
 =?iso-8859-1?Q?8hKLhHrXoeF6Brao3Rsmq9rVriIkMF/vLRjETr97jRf/T63ru0/cUhRrfO?=
 =?iso-8859-1?Q?BkjY0Iw8jdniPLeXc4BwZdRGycUTArluJaCq00fwUN9B8MpnRW8/E8AilF?=
 =?iso-8859-1?Q?ruQrB1/jLYH8MmCf93pBuWEkt8tqIjYrUCfLDMTgbdkMJ/g0KOoso4Svax?=
 =?iso-8859-1?Q?/xNF39p6SScfdyswZXkZ1J6UOzHel81Q+xWAmOgpBpHnZFkZmmYAFgMTez?=
 =?iso-8859-1?Q?eEmvsGYAJvaApy7HUugJv7qVVbjf6nIh7Rg6CmVavd9/FQmyIaKMOqAQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c8727d00-96c1-4b27-cf2d-08ddc8fb6551
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 08:40:22.0473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5qjHPNrqWdWDto3HUNrU6tYjlNKBBqgkJmdlSVZUOH/rnkWoRYcQQlfe3hoBi5h4ZxMHbD58bxgC+4/leDQoIaWcbS/wNbVgCe/TfGJhJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8579
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

On Tue, Jul 22, 2025 at 09:53:21AM +0200, Mattias Rönnblom wrote:
> In the documentation, make clear
> rte_align(32|64)prevpow2(<n>) -> <n>, provided <n> is a power of 2.
> 
> The original documentation stated the "previous" power of 2 would be
> returned, potentially leaving the user to erroneously conclude that,
> for example, rte_align32prevpow2(32) -> 16.
> 
> The rte_align(32|64)pow2(<n>) documentation, suffering from a similar
> issue, is reworded in the same manner.
> 
> Fixes: 08f683174e94 ("eal: add functions for previous power of 2 alignment")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Mattias Rönnblom <mattias.ronnblom@ericsson.com>
> ---
>  lib/eal/include/rte_bitops.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/eal/include/rte_bitops.h b/lib/eal/include/rte_bitops.h
> index b9a6af381b..2d1b9d281c 100644
> --- a/lib/eal/include/rte_bitops.h
> +++ b/lib/eal/include/rte_bitops.h
> @@ -1320,7 +1320,7 @@ rte_is_power_of_2(uint32_t n)
>   *   The integer value to align
>   *
>   * @return
> - *   Input parameter aligned to the next power of 2
> + *   The smallest power of 2 which is greater than or equal to @c x.
>   */

Much clearer, thanks.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

