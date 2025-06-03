Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92626C5AE59
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 17:05:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79F6A410D3;
	Tue,  3 Jun 2025 19:05:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 2B1FC40E64
 for <dev@dpdk.org>; Tue,  3 Jun 2025 19:05:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748970357; x=1780506357;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=XxzEoKyvPcWmYa+3LGpjw0EqN9ZvmzTgMrpmF0icrbU=;
 b=YfzG0eruCs0j7B5uluEjIuvAx7mz0mE1b0FT1bHueKlAawlBb5t6nruV
 gYyF2X4GlJME4JR83IQVGjyVaouI4BUWlatLrHJaOHI5YdZZEkR/pUSXv
 HyQkOs6UoawaJnDWS4U1+0GP2NjhM1FGp+XV0wOp6gyT/owga980pQ7wt
 coT3zXGnWtllmkzfMpHlSeR5jST+qrJLRtbxK7d2NTXZ+3bMHfNn70kSX
 G6cCtWB7WE1DdS16cqEsv4bdF0OaYmbzl9rf+35kzB9t5nxO1FuOMLOjg
 82/ZOjKgd7VUM2IQ0K+3Pk+JVIpvE8uM+YQQ50yq+iyBgyJNhBMP6cEQI g==;
X-CSE-ConnectionGUID: HD7aOQPoRBCV+JYrksw4cw==
X-CSE-MsgGUID: DqCiRElNT7Kdp7nEPaVCmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="51092930"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="51092930"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 10:05:56 -0700
X-CSE-ConnectionGUID: Thvkzq4+SlaALUcBGVrmUA==
X-CSE-MsgGUID: 9zJ14vC8RQq1oeu3oXcP5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="150073854"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 10:05:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 10:05:55 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 10:05:55 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.78)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 10:05:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UiARxOHjSnY9iwSL3nIzWLMNBZSlVY6eURPf4r9yBhOsj5hMI8Sln0uD+w4ZyObXZHPBx661wc18COdHBzIizc44gOnhp0CIMC/Hdot3AKlA+9HILagASiprrM6A8lPv2XDjPx6RBOa8P/YZeaDd6Fi24rRpgAW7oY7MNj37PEJSrFrZNV4IO9zUbv2lgiiHoVNFJ6YErHPk9sxOMiyaRu9UEhYJpxcX9qaOS9BR8ETbq2EWXjassmlRQyjcp29SDZf8rpv1LtQz4qoLg7yQImxFuQ0Snk2A7+Zch5hEIBvh9gfzSsx3vDhRueHPLHyMBdq7jRoDlJQoRsrGCWtjFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfv1d2y9yfqB5yt9RIyP0H5AsP2m9z9OinaLnw+wW/4=;
 b=mFrcHwKd4PoF6X2Rn6BKRKebx5dFfL3fm01KPSSkVL6mSfhar9G8sjnvIN9yfq5stOF379SqwH/MVZpysC64b8YFhK+E/m2xf5GE4ct/40A+6k4kKkKCsr9+cxJFbwK8xr+qczPSMMxz/SOI6peyKVk40TXY6n6++dj7BixzDo++fpGpZkdPGYe52dPBEbXb1NFqm/CirhCbd44Jl7or0Hr2RVTtWmYQK9HtyPr9xA7xyAmRFqpynwawJ1CLzX8JFV+LNI7AUYaMdUT1CZyEO3vnEvfPXjNnGia324RAoZbd8qhHrDHEIekC8AzFcdAPkQVvGfg07un/Kk9Afdu1LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB8327.namprd11.prod.outlook.com (2603:10b6:806:378::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 17:05:51 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8792.033; Tue, 3 Jun 2025
 17:05:49 +0000
Date: Tue, 3 Jun 2025 18:05:44 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>, "Ian
 Stokes" <ian.stokes@intel.com>
Subject: Re: [PATCH v4 18/25] net/iavf: use the common Rx queue structure
Message-ID: <aD8raHiP-llXtWVD@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1748612803.git.anatoly.burakov@intel.com>
 <cover.1748612803.git.anatoly.burakov@intel.com>
 <91d5bc47beeea861b9249e52743e8843973a9e58.1748612803.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <91d5bc47beeea861b9249e52743e8843973a9e58.1748612803.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU7P251CA0027.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::25) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: b2b6a32e-4e27-47fb-a3ca-08dda2c0e38b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Pn6F/ov1knYsHQpjH35R3GODuj4sC3oYzFRReoF0hVaOkEeT6r5BOLWJQCHZ?=
 =?us-ascii?Q?qrm0UusUGu3qbNlWtUgEE1x4P192/5sKTHp80lI1410Q2JzODdP1GaJcVPKP?=
 =?us-ascii?Q?IJBXDRU5dIj29/5mMiOsUNVjI3DowgWdxMNqbN4Mh3kUMdz9EGZp6zLlNU9S?=
 =?us-ascii?Q?+I1QIWdt7czw8WmILK7GhlPLpEsgNuCYcuJzU6cJh6mphQkc2UQwQYGcCfw+?=
 =?us-ascii?Q?Fay+kVviySJGkyqjjslu9TGCCNfVaLrzCPKLoiTqWqJPXM1l6dTovIip9kUy?=
 =?us-ascii?Q?T8GGhS3ZBhUPpmcDXTv736XV4+7TP3REYiEFaqeijo45fVpWARjjaNwUBntz?=
 =?us-ascii?Q?/pBLfQxjbItmJFr8lIOtVu4XiPrvVpiQ6iyrWR0Dizx+kuV2zl7pumI9ACWU?=
 =?us-ascii?Q?NuiINQWGh58+xs7ItlpM1r6byol12OzaYdcIhDLQbCYxsBQtzBj/8+Hhv1mn?=
 =?us-ascii?Q?eCKyR9+L9oHnz6cp2dLgtKeM938yukRUgrYOh4CTsMKgUjHZi2PCPSckm/s5?=
 =?us-ascii?Q?T5cx6Oiz/1sJqYD4sxa//W7tSi4F6UVnlKbP8deXZVOqHwEpSe2eVzUou2CV?=
 =?us-ascii?Q?yafYw3XIwgKTo7lBj/DLIfpAiblYM9HTVE7nQrl8O3xI4O/vbD7z7C7zXf4n?=
 =?us-ascii?Q?qBhxL76AxMEFnn/XtpEvXtDpJ3RCWQrC2w1HXBc6/7QRbJGcdhTNvbEvaa0k?=
 =?us-ascii?Q?g4PYOPW9G+I98wQwxkotC2kRGSPIc3xQLb8lK8c3cdpv3jAQzdvArTU2oyMM?=
 =?us-ascii?Q?DCSK2lPSrqpc5hXQUJOhC/NHudw3kWNf8WaHReubr+D7qI2VhHcyEmxOjjo3?=
 =?us-ascii?Q?1MBj+mhVDolPOA4i0aGourlgPNWRDR6XBX6exC8i8iqF8DQaUtCZYPUlMdr6?=
 =?us-ascii?Q?4ocC/DeRZ8BmGRY2Q0q6vY/Cl5hvbGNEC2k+tAlJepz8YvXUrfV9ZSx1Fr5x?=
 =?us-ascii?Q?HbnbZuPNCaJ7K9HduTn+neB+lsi9tKabemCYJc07DHJo4hmdRw/QENhVs2gz?=
 =?us-ascii?Q?T2tdleCfEFAXQRWme2PYjuPICFh/QR4C4AMV/ViBh7ucBDmb/JcZ5RnIwIUF?=
 =?us-ascii?Q?WhR7zqGcBtHEX1QpqabVs0ZYfZRh0nTIfV64vB2prR2JvgaPaqniyK4rejIE?=
 =?us-ascii?Q?q+Q3tm0SM5p50sbOc+7rHWb4BSHOW0QT9FrxGU3ntqdpI1hOYYTJnLl/wwi3?=
 =?us-ascii?Q?4aUUCzyWuAZf7t6yBTHyWmrQl8Y5HJcNloqzLzlD9NJpoSaCd12BvC4wJZlG?=
 =?us-ascii?Q?806H1nEljQsiboOIfjzxCW8U9tEW1i/eYPZjAkzyJoEB7WgPTwOUXCU6Bm3P?=
 =?us-ascii?Q?WQWwRYxOTcQCfaJwsa7KB+9alUfS7xpp7lvZEhD2b1oVvMvZtEEho1gVz9Zj?=
 =?us-ascii?Q?0oMAd/3kBHfBqhyvA4E+fPbZdCEChIbxPyqP1e0H9wLJDTy5hDZdiqJLCcjw?=
 =?us-ascii?Q?UMkvNerarXQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3pvey8j45LSJPgHnZPdVGIknz/j9TqHyX/QQIb8upPbKYVbpPEIVszU1nf1h?=
 =?us-ascii?Q?yfoFLEJ9YJlnNWPKAfR4FHv7c+NT6MvQFfIN1dtWLfqZzUrRCqkbiECwXS1y?=
 =?us-ascii?Q?yoez1AhDSIegk5p5ZRxGNdQxdsMpNLSn6zMSkDXoSVv5gEHgTVypaEMSxNkJ?=
 =?us-ascii?Q?0WhyVVrVx722MvNaANHyn/vG8+Vre7F1Nbiju3QWePijEnvWyySrWxkEch6I?=
 =?us-ascii?Q?3jofgTY/vDfDM+pKET0TgVwJXrMd8889G/R3zIMMMC5ptmRITAPiH3xevDDr?=
 =?us-ascii?Q?ixrJYCXeSCuyA5YennjFuANJs68hoLEBJHYsySyqmQDwPTRRn9AIQAjgnNI2?=
 =?us-ascii?Q?lw0xZ/CBIB27gLE+xGkubpcvamg87FPf2dqXMAW4knLZJJtjwhk07R3DGNho?=
 =?us-ascii?Q?D4Z/35Iy6QGSQlEeGTitiPC+FRrx6xYc0dEtW4naVbJ86lQkVGsHOwjf9zmr?=
 =?us-ascii?Q?xX8Kq+AheztHYA9Gltnl2F6QXoVzPRG6effRpnQLtJ+nz7qoO6FXZ/quaD9y?=
 =?us-ascii?Q?U1gnJTpspZpMTHIyVMZywMhQECxr53FzuFH+AL2Jt7eMKx8AX/gGRB+S1bMT?=
 =?us-ascii?Q?YGg3bIl4EPorp9A84xh4szn0exbXd0aDEbxy1DoJqJTiTqbZhMVqA9ebRgi2?=
 =?us-ascii?Q?PQDJcJPxlXWHf6IM1PPYeIWdeZfB9Gzvq+s303cGny702SVxD103wzvYlf0p?=
 =?us-ascii?Q?34Ci1y78/8vBle5o4MNqykQW3kpt/qy95NnU0WelGmEumFJXShpZdGgBIUHK?=
 =?us-ascii?Q?5lX7r3eml/nP+bW+6uGxdgBf+2R8RRG34xLGyhXpv2MI5J9WrArH31JigYny?=
 =?us-ascii?Q?JnBOdWp1uzFh07P8gGVWszQh5jdIgwxo4DxIAQKg7EcuOShx6tz8Lzq/xZGD?=
 =?us-ascii?Q?/wGGwJrfv1JjJ39K1+dUdY5JNpfIqMEaYTa/F3TS/xZA5xM1oXMht1vdX6BI?=
 =?us-ascii?Q?awj/cRXgajaRenxWACTLFiRLNwtdTivScisH9jJ3wBUTH5e527+bM9JAk5Ow?=
 =?us-ascii?Q?Tbo92TwUeazcRaRpRjVIVV9ySH7o7/1788O4Hz/kG8eSxCdNAJVJCY3DDhXv?=
 =?us-ascii?Q?Muimj5FW59o+ip7CFB1sJEOFpv2eQCzb6wUpuvbk58otvGQQ1q3ue1IfSwcp?=
 =?us-ascii?Q?Gfbsg0ueOxm4P+qqCr6FfEFW13iNPETmfhuM71qqxQQC8pI3rpmxWAzfwoaQ?=
 =?us-ascii?Q?Mf21tg9j4RsQjtFcONK1XoVpHuGdW4J1V40uDUyTtVbUWqbcggQhTp4Voinz?=
 =?us-ascii?Q?HOfMzwz3XzFh9cq1tU+po8y4pNallfZJEOXEZ9volIOp/v9Jd4Cd8IsDpXNa?=
 =?us-ascii?Q?xOX5nE4dOM8mXq+qkzQ8OD7pOxc9DAcJ7Qm4aps+vg+BCrMmiyXiAp+SQTv4?=
 =?us-ascii?Q?PSF9kQs39+49ClxCO1MNytL2lbVJuCVOehTG3lVVnoLHp12JfufjG4tpreZm?=
 =?us-ascii?Q?hsaSlo7pi9nWivgonjWtBMDMIZvbgMjmIOGZOCADntmDIATSDsIljz/G8tPO?=
 =?us-ascii?Q?ZrU3Up+IDHrhAkGUwEJmFltyMB5rDSvOqik5+kNpQZ28MLHTcYkdziLv4W/H?=
 =?us-ascii?Q?E9a0CGOJki8DfTxNOdDmW3bRXNML1ob2pmfcs9Yci+pnAdDrouU7Y1G6c4Z8?=
 =?us-ascii?Q?3g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b6a32e-4e27-47fb-a3ca-08dda2c0e38b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 17:05:49.3855 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 20y5tfp7lzAw4WQ2AF6nwdFQuMCNKLF6SatjM+2x5pPh/qTr+3p5dGGKphj6yxEIQBW8vgMvCQkRnHhC963PkdilxfztymZhkw5cDxVViJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8327
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

On Fri, May 30, 2025 at 02:57:14PM +0100, Anatoly Burakov wrote:
> Make the iavf driver use the new common Rx queue structure.
> 
> The iavf driver supports both 16-byte and 32-byte descriptors, in both
> regular and flex formats, so replace all usages of iavf-specific versions
> of these descriptors with the common ones.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---

This will need rework, I think, based on the feedback to the earlier iavf
patch about removing support for 16-byte descriptors from driver.
