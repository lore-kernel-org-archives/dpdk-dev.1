Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96DCC71130
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 16:32:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F42040287;
	Mon,  7 Jul 2025 18:32:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 12A574025D;
 Mon,  7 Jul 2025 18:32:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751905952; x=1783441952;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=HZDhoBXui/vNW7xVDhW61exdDvH/lU0DxbyQwpveGeU=;
 b=cIGGdt9UZ7nUO7+TUbj354RoOlvNjhNVEBOXDX7FT+1j4mO4CgD5jxo9
 +JKVhqEdJXCAeOObwAuBpAj3l8++jdDQ/Bbanc5aEyAB1p2oEQaqsK4hZ
 I7u6QPrTxn2MfbjUaYgYjlcNYcIs+1rkKsT/NjdM1MVYqJodZweJ98SFV
 XyJnPNT71yY4kv3ohHLLiMaCqXvk95yk+qM6HpUCDTElra6opPRwfGalo
 3ND1A/dM+CpuFCDekMruofgXG9i9FavktbW2/dQTtSD77iWyMD2XWkFyt
 1i6kMOKP+MmiMp4C7rTplCav8fKBGRrMtK+vsww/JQFJ7Fx2ByUTwPgbD g==;
X-CSE-ConnectionGUID: 8AWeH2r1R0Kf+WHWp919LA==
X-CSE-MsgGUID: F/yeB1aLThG3SBrlhdA0sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="71572826"
X-IronPort-AV: E=Sophos;i="6.16,294,1744095600"; d="scan'208";a="71572826"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2025 09:32:30 -0700
X-CSE-ConnectionGUID: cTSfNes/R7mGuIlCPF8rSg==
X-CSE-MsgGUID: qbzmLM9mTPy3Jyf8mEN03g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,294,1744095600"; d="scan'208";a="155356257"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2025 09:32:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 7 Jul 2025 09:32:29 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 7 Jul 2025 09:32:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.43) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 7 Jul 2025 09:32:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AXtjYbcRdJZMs3PaTAWJM/dw8R7Fs+/XT7pvZRND4lXqyNLQT8GZa3FNcp1IbjqSpLpaZDPB+vUhIZleI9CbO63y6ko1RvpwU+99MoywVhsC5BA199FJkxSo+SQ8+57575mVaGzTcjCC3EQjp0qqSnxAfQK0YSoEdb+LfUL631HYdrt5ekA0biHWOY5mKTjMtIQaLe29cx9RTcS7Z/vMwAwuE2X5P6XbFGxx+VKGF5py5lq3T6vNsM+aV1kolPNYrsZTGwSVXY43DOQLYliK5Uub96ol9DI8mmb9vXJIt6jej+vAwf1P20gKnlH65IHQzGuRV2fvudGRDwy0IxOsZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yihG+AnObxT3JBJ5X7HllyQjVyf/ZCDYlPW052z3Hmw=;
 b=ubncoHvvUAxeVBlDBjsorTCksNb2y3XQGMt675XsmJvTzoAdcrlBPjtjHTJnrhGHpVET8zX5Fqrt2BrpNRvPLUhzvUgy1087lfkuqPEimTv5P/dSim5CA8TXxmPEHBeywlqK3phz8917yqC13DSiDKjVFWTONTgxrOfDJZ5ajehAd1MqxNZZqZijSFbw0/ebCzdFfoNu6EzVoMKVxicvDkvG445lZ+72DE7UIuUBiOnWEf0JFoph+6wkXNxE2iog7V0JqYX16rzjQ9F0zHWEF+BCSTxH3ZsBCpspROCuRxCbL3sJwb4nhvPMq82Voo6ldxW7Tr4Li494Et3wH5Oq4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB5873.namprd11.prod.outlook.com (2603:10b6:806:228::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Mon, 7 Jul
 2025 16:32:27 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 16:32:27 +0000
Date: Mon, 7 Jul 2025 17:32:22 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Dhanya Pillai <dhanya.r.pillai@intel.com>
CC: Kirill Rybalchenko <kirill.rybalchenko@intel.com>, <dev@dpdk.org>,
 <stable@dpdk.org>
Subject: Re: [PATCH] net/i40e: fix missing support for RSS IPv4
Message-ID: <aGv2lukK3qbs-OFC@bricha3-mobl1.ger.corp.intel.com>
References: <20250705215412.200958-1-dhanya.r.pillai@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250705215412.200958-1-dhanya.r.pillai@intel.com>
X-ClientProxiedBy: DUZPR01CA0273.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::14) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB5873:EE_
X-MS-Office365-Filtering-Correlation-Id: 9646b7c2-9a5e-44f7-3f68-08ddbd73dc2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?ku7aUqo2RLAvPL2VtuF0o6Mog1cecgAm47algGLnrZxLzMU88oP44z3M0L?=
 =?iso-8859-1?Q?9sVCYxTNHVVo7s1PGE1PV3dOUbNDKHkb7v+v4m0dUdxJPNfHGjSzEsdnvS?=
 =?iso-8859-1?Q?Lydj15YZrSqSvrqtTXX9hobAerwgr8XScFhBcdBdN2ASJBFkdZwlfZx86D?=
 =?iso-8859-1?Q?BHX8w+8ry1+PqDXUiVd+dxsYLKDFugTib7ZyJMDld0Oy9vD/TYtphY1m1D?=
 =?iso-8859-1?Q?snsfqrO6wrGvzg82i6SypOxpH/+Swn0gGpZxJRx37HGJpEqXYJGpgulxaI?=
 =?iso-8859-1?Q?K+d7WbK6k/yq7qEK3ntaJeIFK6iQaM+mCuLhrQVt5W0EkJKW9iAx7X5pqO?=
 =?iso-8859-1?Q?YvZ9HHkK9kKdEawVOsrtlcvZcAgtaneH/MmOlh8jxNjf3BopBuiA30jA8N?=
 =?iso-8859-1?Q?ISIz81szQ/aQntw8GgtRgM15dq5xHyWwyuURs+MsorQ3KZ8dgRE3UKdC/M?=
 =?iso-8859-1?Q?lcgavRHINwRWwESFY+XGSodIdJkqpQVT9c8PquI1ALwyvNVRAQ9ZDF3rK6?=
 =?iso-8859-1?Q?jb2mhEjWHgOdh6wykMApZs/MBpZQf2YOe5Rg/gjj71B8IgX5cBG+Bd7Oou?=
 =?iso-8859-1?Q?1VOZ87XtT5rKwzFCPRgj/Aj+EVk0UDx5vPs0StKY3djb78E20QMt2V2OPY?=
 =?iso-8859-1?Q?jfzsSMEHKK438QB8i0WTopUZhgidbdFWmv/JwBA/0I5ZKIu58Nh5bPfXOz?=
 =?iso-8859-1?Q?LzinWUrCcySsJiwCmjwDGOfUZrqjUUAH1jzpTxHdqNsqTmmH8sIErEgVx8?=
 =?iso-8859-1?Q?NBfFo+k2pN5IRYnpJMpvNtQLPmf9mAUK+nscguVGY7flxZZhW5/cSk2fj6?=
 =?iso-8859-1?Q?9rkcxFuj7za8qR+2rCtZayv5AB1EFRDFdT8Ch5b2svQqFW/C073DWH1jpn?=
 =?iso-8859-1?Q?c8CBNWU/gbOzLm3HUlbwsMT+rKzOzDPrntiVMEfWhZVpwXHo48k12lcpoD?=
 =?iso-8859-1?Q?DPZUlep5zo1LV6Mualn3hHzOZBgpFlZ9xPtwRSG69N/Ztw/3bRojw85vz/?=
 =?iso-8859-1?Q?A5JOz+lM/WgFjiHpPSQzOzWO9dKVyYtedR6JL2NVtauW6SnbzS4PqSf6Vo?=
 =?iso-8859-1?Q?nZkoAsq7heIfmkfBmbLyy17fRxYUjEp5VXuddPaiYecCs9WCp4CWK8vu6x?=
 =?iso-8859-1?Q?EUWHxbFx+YEFwv3HGGxgm33+PU0/C4p/q0z9wA5ZUPC3gtGN3ITG/VqlOQ?=
 =?iso-8859-1?Q?YO12gaB7qDB4t77OThDU9uriZpVFwWfMaC5ydKmukMUCcJ7uY2ROtc+rfy?=
 =?iso-8859-1?Q?BrOHkXli0MeewFQz6yxC4irP/RRNKAOe3P7fyFxQKcrRkM6yHJI+6gQMd4?=
 =?iso-8859-1?Q?Kasr7mK2V4ecSP3QCCrHWQ/loTes/0DrQJ2rd/GXboQrySNndIYhU5revR?=
 =?iso-8859-1?Q?NB/FCWL9gL3kM42S6+ZcOUid/d9THNK8DaFnZ0CiHX6xySoqAgQQ6PeevH?=
 =?iso-8859-1?Q?LoeyhTd/a0eUyJYLrinuGYV0JBV10IIQDjalXA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?vgj4wf4vPugpw4vEJ+c9fw2iNmDBccDGKrseWVUl7KkgyRrXz3XLryx8P5?=
 =?iso-8859-1?Q?dcS8HRa08gVcQDNSVoixxz8zkvXZ1kamzmxa9+WY4wZ8FmPq6g342+uZVY?=
 =?iso-8859-1?Q?jPU3H4sbz/JBQQRjUeIHUHvwE3/CAQEfmXxAYePQ5PQ0WzLlOTQFOmYHXu?=
 =?iso-8859-1?Q?XWSPa/oLhAy2ttDHUuWr2oNhScA01Ml1vN9cG8JxX5+VI+4W/cn9sN097U?=
 =?iso-8859-1?Q?wxkF2npB6Br5wqgAUgJtuVVzf4mp36q7gynWXeUSM9orxLy4U2NsagasXY?=
 =?iso-8859-1?Q?lnShTFkXsJ/sNM0608gGM5fZvqhBHkCGa7srzS4P47VAIV7ozEaSbXVHkf?=
 =?iso-8859-1?Q?JUkeLJMKKk6SowMrzrzbXlk99YoLGvzqM0Ybz/ktXpnml7RKbnRCPjMRDS?=
 =?iso-8859-1?Q?gFbdVcGr11SuPiZ6oRAEHS7CBtlTY+EL9BLoXCHm696H5DJPyTPlDxKFQ5?=
 =?iso-8859-1?Q?ZSbe47BfxNa4Dt5eg0Mork1TWfMCa+LlCw0+FqZixrtg0RfKhYyCj4V/zI?=
 =?iso-8859-1?Q?01an3f8/xz1BDdn2vzsbK0OBuWoomeH86dbnGypxRjmWSLbjrkAZNo/044?=
 =?iso-8859-1?Q?cTv9O9mSNTtnhk7cpOO2GeUapoDzlCKaifthmO4LytDkM25eOwl0A8ZIsq?=
 =?iso-8859-1?Q?6b7QTzI9wUi95byNs405P1TlPClEmFmKxNQ0iL+k4aGixkzEPpngV+Si6S?=
 =?iso-8859-1?Q?Hg5ioObaPv+ADP3L0SaMM+4KAbXOyIu3F+9SZXpdYJOcgoLRXLjDhSgd3w?=
 =?iso-8859-1?Q?poaO7/4JONOpGnv3tQw/eLOnS0+M3yHcqBoF4nb1XpOVbrCmH3VEUE0Fqf?=
 =?iso-8859-1?Q?wYmYu0z/tg4/cQOdDUUD8DyE9ekW4TNQpjD76WnEF4a5YyHh/dW8ulwfYZ?=
 =?iso-8859-1?Q?5Q7KfiUv0QpNUxajMxnfQDczdczRfNRsIkRbRpohHG0sMaFHn5VpMMEr1Q?=
 =?iso-8859-1?Q?433NfiVpnywg6QXlJZtbliVWkKxViYtNrvCpy7IMFAm8ofOAVoRLI3SxlC?=
 =?iso-8859-1?Q?zmN64xMiyDvwgBsyxQLxofl7oOxcRGKDBnHf1pNk5yg7KFs19RkvApNWax?=
 =?iso-8859-1?Q?Ofb+yZxy/dnkBieLtReIUv8BMgB8ksixb1re6D9VgJJR1K3mae/1OzG/0C?=
 =?iso-8859-1?Q?h9JYS/INZydaBQAkjpbO103OUAEfsdC9C26REfz0MOkf3RpLr5RQkha92d?=
 =?iso-8859-1?Q?uF4B1cwBkHzmDpM4hnf58YSUOlT0q1jyRjiLmJuYf++W8TYaTwzJ+xjUT0?=
 =?iso-8859-1?Q?0kB70dXqTRzIlwyiHKEqkZVkw7QgnTElXTB7yMCGrCNGuAkjJ9aQOAH4HC?=
 =?iso-8859-1?Q?4SDF6nErRRpzJ+6Y3Pw8q1vuDdYoHrHGlWLFkxFCsrIF8LZ5U29YioxJ4Z?=
 =?iso-8859-1?Q?uUeyQtnFNyCqpwAJCpxO5YN8sxMXlAPoG1yb8R75fdfvym/hKxmjFHe5Pn?=
 =?iso-8859-1?Q?CwMj18npzv750ReWJLPDye0bifhQpRRYn5wu76GU2H3mNMShzOmwaqEDDh?=
 =?iso-8859-1?Q?+Z4Ex+gY1Hmjn5llmaKPVn6nKkwj+HSFoPGNOdTSveALYix7LwCdZ3dx8H?=
 =?iso-8859-1?Q?rfNydBoLhTR3Qaq9ytxITHmI9g2NoUj0ZM7wHmzY60xF2ZoMAOXplXtOas?=
 =?iso-8859-1?Q?5CCOL0TW3gZCk4yM3Hx/mkIsHadFHxCH4dTvg/R9O1eMyWoPBI8GkO+A?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9646b7c2-9a5e-44f7-3f68-08ddbd73dc2e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 16:32:27.1953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TPhMUBoFHRh64ew7UK7z8OmA9kaVXLwBK8l0nf/dbV5x+qeUaobjtj7SRq2Z5ZmYc38mXnWqMPSN/XfoHo4LreXjZDs/BwczmoFM1r/jKsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5873
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

On Sat, Jul 05, 2025 at 09:54:07PM +0000, Dhanya Pillai wrote:
> Currently, i40e driver is missing support for RTE_ETH_RSS_IPV4
> flag. Configuring rss function to RTE_ETH_RSS_IPV4 returns
> invalid rss hash function value.
> 
> Fixes: a286ebeb0714 ("net/i40e: add dynamic mapping of SW flow types to HW pctypes")
> Cc: stable@dpdk.org
> 

Reported-by: Morten Brørup <mb@smartsharesystems.com>
> Signed-off-by: Dhanya Pillai <dhanya.r.pillai@intel.com>

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel,

Thanks,
/Bruce
