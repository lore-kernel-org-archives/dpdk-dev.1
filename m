Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788D6CAC5A5
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 15:49:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C859E40A8A;
	Wed, 24 Sep 2025 17:49:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 9351240613;
 Wed, 24 Sep 2025 17:49:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758728990; x=1790264990;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=9YxH0PEkTXqOw2gH5r3NLaHQlzvg+c3IX7tDB5NhlUo=;
 b=nNuPH0ofhfyY662Owl4Rovkt1Fk32aJ4pSjTYg+WMUsZN7QyOwZgIKjD
 BUtOyI+Ds+xbqMN7ATZafS4FULQxTDXZMCsJezG9Ib+nCFI3t0an4j7O9
 rZppaLuTIGZLZmG5Q/8ft1Is9l1Zny4JUc+rzr0i56PYZ4FGuuHyVgLk9
 52AX8Hv+/ED2CVaNxPVtl9uWENsCiYGMAtbzYwL7DnZ6IYwY5opkTHG4V
 a1WeityA236/fqkW4AyrHkh6Js27UmDK79J34XSddJfT4DvPUIXOlb0OR
 K/uxXq7sT1qchgdBGdYZWPKEmmyuZqX2GYnhNelBbz65JcfM8QcZz/DXD g==;
X-CSE-ConnectionGUID: BRO56xw1Tn+ogFZHKVKRNQ==
X-CSE-MsgGUID: 8Mups5TRSg+ccMroYL2U0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="72387291"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="72387291"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 08:49:48 -0700
X-CSE-ConnectionGUID: 2ocDkrvRQeqdNzDsS+NY6Q==
X-CSE-MsgGUID: zrip/OJoTIG9T1g6QJy9Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="182234348"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 08:49:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 24 Sep 2025 08:49:47 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 24 Sep 2025 08:49:47 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.23) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Sep 2025 08:49:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hsEYA1D6xJ5ybZwAQMz0SnbCZYxvpGNHxSwblpqfklnBAVzqMSY7l3L2JTQID/2q0q5O870queaVmbt4lbTZtcOuaHKiMJ5FmurXsYxpYvKj/zT0dTghZlnnWQsNz+cjkJWPbEJws1csMZJdvov/tG8sERD7tcdKQV3LVMCN77Ci7uNAn2pmBpBLGnhyGyxECYhuxXtYeLqQTsqRoMOkKhOHAVAkIJrfg4mqb9Sw0pH34xR9vuri+a9I5U5WlBb6yt2dS7aHEE50/WLuJNUq8FwpSeooDUOTb5w75ifZ660bBogfr2JhScHqyH1w0uIPLHNq+1/w3NRb262O5sOI0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fp1gV5J2+TS3YlCNyRz5uDGmJJooBIg1Av7JCwhmIMg=;
 b=B4KR+xUJQO/9spL8D8UjpT00npCIWp03ok8xM5YMYScWySa8fgi6r5g9W1HMIOI0EiZhHqDdacb9iocpXUWunfuK+UOhSQ9IYJF+c78gle85iyc+d6nx2goxeJl3YsM9L7AmodSFTAgEf2490+X6OZc08fHIK0/aVoK7UuwYej/ZWIiPtoJ3tESKIzx2NjfQIjozsFwUi5eqxYGKAEq1HwkKzdCwXPlL8lkgcl04YmlqNhcMdPV1/aVOebNkkTI+w7jf+7K+9nmDBChT98F34sXzZlBQbO5Yb8Q/MaicGpsNoXz0ytuvUoTr1QpfozTiTez919iJxwa0m299rH0t0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB6846.namprd11.prod.outlook.com (2603:10b6:806:2b0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 15:49:44 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 15:49:44 +0000
Date: Wed, 24 Sep 2025 16:49:39 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Byron Marohn <byron.marohn@intel.com>, 
 Yipeng Wang <yipeng1.wang@intel.com>, Keith Wiles <keith.wiles@intel.com>, 
 Harry van Haaren <harry.van.haaren@intel.com>, Luca Boccassi
 <luca.boccassi@microsoft.com>, Sean Morrissey <sean.morrissey@intel.com>
Subject: Re: [PATCH v3 1/2] efd: fix AVX2 support
Message-ID: <aNQTE0xFgdDBhC2b@bricha3-mobl1.ger.corp.intel.com>
References: <20250918073135.1273767-1-thomas@monjalon.net>
 <20250924154641.2684705-1-thomas@monjalon.net>
 <20250924154641.2684705-2-thomas@monjalon.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250924154641.2684705-2-thomas@monjalon.net>
X-ClientProxiedBy: DU6P191CA0007.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::22) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB6846:EE_
X-MS-Office365-Filtering-Correlation-Id: f31c23e6-04ae-4a74-d525-08ddfb81fb38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PnO6YlzCs+8iCm+zej9yGhxHfgPlJUSC3lOn6tJIbCeRceRkSPNsTk+Khvs7?=
 =?us-ascii?Q?oVTaLVEpWUuFyszaFr57i5jUFHPgN6FvBuIZquF4HasYAYpeDovJZWFQiX77?=
 =?us-ascii?Q?aFsmWiVblEeuFqIZxihHomqqHXxqnhLF0UvZ8LBQuvPjOaOMjBKxlcahQMLc?=
 =?us-ascii?Q?06DS+wnDJPz84kXc6u89hejsFFIUrdDTW4DMdlaXTh6VOMprCiPE9JF9Sy2/?=
 =?us-ascii?Q?gfEA+iY2II5LKutZpJmJHObpP4rvHVl7BTAnEeA8jd8IL/zx9HTPpD4X+NMm?=
 =?us-ascii?Q?TxomKN4iWuTf1Heb4H2qRyWLkgiY5UCdGJ2GR9HzJ+oR3H0ry4AdkufxEtGy?=
 =?us-ascii?Q?x3hIFo/4RHvR8nNaHD/Nk0zFzvh7ZUwaADW1nVsfSn5BHjdkVbMSP/g74c5I?=
 =?us-ascii?Q?tki4nPkRn6NiJa1BORz/aRBD+51n+M6u/fL5TwSnDtcsnEIwQvw1GArQBO9r?=
 =?us-ascii?Q?Z1fJ8bE/3txpJHOHFQgbe/3yhAXbzsa6vMV46j/w3feTCzGtrpislb4bmlaD?=
 =?us-ascii?Q?xLZGVqmZun4n0hT/SRHouj9wvYvFiIJ3wpjTU4hb2+tc+PpOgHZO1vwrMKCi?=
 =?us-ascii?Q?oMH/Q/VGrElYjJ2xK2MWIYbAFIIxJuLyT2QuF7pgqaVtcVTbFEU8DhAUOfI7?=
 =?us-ascii?Q?lhP5e8pr9ByEPfHHjZ09sSKj/BAb18NExDyBT0NI3bsGu0M16eXt+CWspISe?=
 =?us-ascii?Q?PwdRW29lgsLljwaO5c//0vm5S0KNYdtEcSs6nFXentn+EEOS1mMQ1/gvyzls?=
 =?us-ascii?Q?ymXvztXA6V1nFY3sBFHTLAVW1eReUkT86Rih3/4TaVN7ADlHPPRw/z8NCHHp?=
 =?us-ascii?Q?G+K8ptz9slFFIcmz8td4Kg5azaQT7PGvfbVwPhlt/tyLSd8kpLcVCY1V7byC?=
 =?us-ascii?Q?w+1vVM7PsrGgfhJirOMKYVG9HKo55bipMU1aTxylhzoGzFZa6OXeeGaRm2fl?=
 =?us-ascii?Q?e43syjN1MvyrSGo8DNO5f7kiKT1IR+2rrIswMIoDd+pR1f+UbxiFKAS510JT?=
 =?us-ascii?Q?gaearvVEzmCcTe+M1vSrnpb7VYRinwTiynZ8Xy72+lVW/PrIMEMVgUcr+4vg?=
 =?us-ascii?Q?VMJcDoMQea4s1Hyg9ZUWP33yClvQoQWZGP2blfL5sQgJsJgwgx+jdFxiaF4W?=
 =?us-ascii?Q?buw891Jaw8VL3NmP93bhmFRzrQBHe0BZ1YjndmRcpQky6ZegMbZVfOQY/bR4?=
 =?us-ascii?Q?lIxAVAGfHeJeU9jpMUbUm6c95Hx+PO2G/whAAZc6LAnijpkeeng0ymcFjqBb?=
 =?us-ascii?Q?Pybz/DC8INzvHiczVX8bViNGKPIKkAufRwO+8PaNylJ1VZ23TDPOwCuW7ONP?=
 =?us-ascii?Q?w2haPDx/SjUa9fni2zjRa3rsMlF6tQ4A+8E3jGrL4rA41JHIRr9E2200TkYp?=
 =?us-ascii?Q?sJB/hH9KOMwvBiYEhx3vRDLSeS2G09DUU8h6e11cKAcXPp/z+jQ08YrUGSgG?=
 =?us-ascii?Q?HPAvRGmIp1s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qojKiOrjKE/0nZDXOSnAKcuFo6U0o6+RgBBlN83l20/f18bZd1/F2F5WIgXM?=
 =?us-ascii?Q?bMaag6Jw49rtQ/IZQNkXT32+LhMV62ug9pY/jHOl1II5Zwq6ASl8ltopKnVN?=
 =?us-ascii?Q?WfiHsTnYc0VC1zPjjKXu695jrIfm/T3hedB85MYeSPJH70sJRNYpqEzr/29P?=
 =?us-ascii?Q?b81qQX227PkLCARPs9x4JUdTTmdVaryROhmk6Y5MK6HtYKxHlChGAGmj5Bu3?=
 =?us-ascii?Q?qa01ErqzRrx9PWDwr8LHZvoLNF8dqNQWcf+NKKwQdMPLltlGscIaNjJo7Du3?=
 =?us-ascii?Q?eCpBwoVMTey191B5EpfJMmGiS8YkG5gD+V0mp0h3pke46bYc4RYRJcMM7DlQ?=
 =?us-ascii?Q?39kKRW+JqCL40qLdhhQi5je5o8doJ9M8EdmOC0Ao8ozPTJALGLUXOguQ+H9Q?=
 =?us-ascii?Q?eikYf7aZFuylbKu7cuib82i+OBAd+8aRJv9cpjb//9YB2uRLSGSgVsgbzCxQ?=
 =?us-ascii?Q?78Gylzz67jCJ+fxAfMdujFOOfDmT876yvxGShsECORdbTwU4wRNS/S1u+IBP?=
 =?us-ascii?Q?z8mb1RXWB/bvZeWmF5yjOlzq4thO34pN65iZZnIlChGCWgccaza96KLA5MlX?=
 =?us-ascii?Q?Vex5QpKoOZ9rYSX106NCe1YMVwsbkPro0RA8sS3Vxij/CXbK8al5581wc6Z/?=
 =?us-ascii?Q?rFFZOTva+N61CUMRAJSO/BpPAd7TyhdsJ1Kv1rJO5e+qF1mrc35QICn9Uu2S?=
 =?us-ascii?Q?7WZ8ZEzQrxruoelfqajCh9WN5ThDNUzFEhkQC9S3rzJ3z/FWIWiaA/6Xw4NF?=
 =?us-ascii?Q?8MgeZDH9v+amCPliKjUQZRxoORoAuqe4VjDM+OPSFX8OPYSvVvfOnCSEKYYi?=
 =?us-ascii?Q?aN1NUxyxSavELuDqQq2EcPxdQXgUUjJNllhgBgE5vUIASFlesHQIGMhKqdBx?=
 =?us-ascii?Q?wlOEpXNmLlOgLgTeinV4PjkKd5HTTIs2fOfEahvxXMbSCir1UcnEClZ9IEWx?=
 =?us-ascii?Q?unAuCQEb+yq0EPvVZM4bxpaRDuKGpAZaOdpuLhFi9a7bgvbq1nKvPSoYQ9wb?=
 =?us-ascii?Q?e0WuPIUJnWVxV465TLXWMvt42t36dJZtxLlRmoDtnd3zqSetDFUnqVXoK9t/?=
 =?us-ascii?Q?AxxYp3/8hH54kc7BxdGxizKSLMGp0HwTHSt0Lc45Z6j8FdRtYgfWHNWK2WFL?=
 =?us-ascii?Q?KhSdhq4U9S5Tb6PArQ+y1txakckMaEOabLV1QNjqGynPCkYmmEMA6JztHCvv?=
 =?us-ascii?Q?Xv37/MqtWeYRJ7vS+H8gsIqzLcGDvWth+7FyR0RiFwgZgbjpeIFYTP5xpjik?=
 =?us-ascii?Q?ePAOXHP+aoPYP889F+Lk/6hls6GzPbtLxZdu0rP0V40NhcRQEQ3U+uAaRFdC?=
 =?us-ascii?Q?bD7WtovwPH3TZs31Bll5xal3JOjRyO8zoZvf1c70a65JQzDADeDgCpTE0IP7?=
 =?us-ascii?Q?uhJZpTWmVh5hVspapLztVHzr3jcRBI+k7BLQY6tKVPDtjtcOauBvydftAMFS?=
 =?us-ascii?Q?wixEXCpFtFmwd+5X7rkm6Zb7rtcqIBFSnio5h+LmChPG3SzVEVMHvl7dpFnm?=
 =?us-ascii?Q?K2u8Ye16FQNStoS0uYVQAoANW3cvNTErSlRTgrEAaWDK01mqoSxZ6wYcY+l1?=
 =?us-ascii?Q?dmHK5TjvCDkp9GNuPi7xqryfPpn4vrxG7tIFpOjs61ozHrh8Dk2wrR5ZfgxU?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f31c23e6-04ae-4a74-d525-08ddfb81fb38
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 15:49:44.2680 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yo17vH27YjxcSSQPjS7dTkE2eyghPaDTvihVRZg6Z9/ctAu76fxOZ7KCj895lkoxO8z9qpk+IH/FaDoTpgJdFvU15B65zv4APq/yX4RpGFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6846
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

On Wed, Sep 24, 2025 at 05:43:17PM +0200, Thomas Monjalon wrote:
> When switching to Meson build, the compilation check on CC_SUPPORT_AVX2
> became obsolete, thus the case EFD_LOOKUP_AVX2 became dead.
> The function efd_lookup_internal_avx2() was never called,
> and its header include rte_efd_x86.h has been removed later.
> 
> EFD_LOOKUP_AVX2 is chosen at runtime after checking AVX2 availability,
> so the obsolete build-time check for AVX2 can be simply removed,
> and the missing include added back.
> 
> Fixes: 5b9656b157d3 ("lib: build with meson")
> Fixes: 30a1de105a5f ("lib: remove unneeded header includes")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
