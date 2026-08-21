Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5560C5DF7D
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 16:37:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 616234028C;
	Fri, 21 Aug 2026 18:37:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 2EA094027B
 for <dev@dpdk.org>; Fri, 21 Aug 2026 18:37:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787330227; x=1818866227;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=kcIg7uMA0OrsTYy0niQxYi1N73eS7dTjpvzgfeZUniU=;
 b=XD/l+irvgXRAWhk60t8V/utSyx1bBXG227LevsdduXKuEZuDB7efdxnu
 LzdyIlf0Tq+D2GW8IQBZdEZG4BbtFdwwJMGTwmDtm9kpN5Eqtq8v7/or8
 Xvtt0nO06xyv+OXc++xK1u7styOOexs4xWXBcH4ZeEFiTGHbddKZzwV/1
 EiV8cAZJExIwT9D9OIjsK2s+H+yvGMnBgHxViWTSDEzZNvGz1U/NpXPAq
 y7ju/qAnAf+D1UcwtjeIvLv6Dcq+dO5UrAulnYCWt/34mlv12K0WQBvIq
 t0P0dPG9NPZR0/XsTt/mVVe6+rvdpfX6JpjUf+qiV5HdNo+iaE6PG0dgu g==;
X-CSE-ConnectionGUID: +y3IDqUVRdyQ+NQECwVUlg==
X-CSE-MsgGUID: gEkpGvbVQa2dZH0C2rfZBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="88012127"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; d="scan'208";a="88012127"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 09:36:51 -0700
X-CSE-ConnectionGUID: ytraHkd0TX6mkKka163XJA==
X-CSE-MsgGUID: GMR0eCN6TIaOqvkE5ZugbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; d="scan'208";a="263110699"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 09:36:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 09:36:51 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 21 Aug 2026 09:36:51 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.6) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 21 Aug 2026 09:36:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qmuPd5m3e17mIl5UZuwNRbGZC8z0xMdwxbYiYhZmmANUq6C0QYX/5ekBwgtwE0J8Vb+pzMuj2shXb6v4Bmk0Moj6NpITiE9EHLqw8yEYakXBVu4aXTQMZD1O1Iq6c64YC56/vXRu2YPzAk/fA8QTWcdrK2BNdiqHx4PqXnCMGFdlJGTf1jXcxuazhjBG12Wa8yRAb8NFUq70g5pRxoPFsHwkY7UBvJvhXN1y2WnfGrR271//1E5AKUcB2NTVJiCfe7Y0SxEe5X/HuJKixyOGHDSdUYtkHJMr1olmjfJbo6Axufd5Sgte/ClxfEIeMK+eATtLB0X6JjVU8Q844vH2mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=066xIjelwOJIvdiXBE+77bwhlKFvbxvhF1denMx/I0E=;
 b=qL6dNwAG9wQXG1UdDZcz6Kbd9+m3l9VXO7/vTYLpKWk9Z7H2zIFctLQbm1MCgZwQ6UhbtFuoUKdNf6CIgylu0q2guz3jcb+ht1THjXedeFXZv7z5fChYPoR96PGLCpthEBFrbLt2QIzyFyNDwypngpHigWyu7p+YKhIQ8C6/cHk5UM3QSAFzds4w4mJVhh6ge6R0vmLaWPIfozxl5vOB5RdPoRx7sKmwK1dJ3Hxaa+G60FJgfHstr87pp9EQhPjW47BS9dkR19CBmDuaqXXCwvjbLelyUeCIf0W6+08lK/jDVOClZ0IcmSsVcTSS3oX5f7o/sje1Q6puGZGu3+KfAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by LVXPR11MB9732.namprd11.prod.outlook.com (2603:10b6:408:388::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 16:36:45 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 16:36:45 +0000
Date: Fri, 21 Aug 2026 17:36:41 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 0/2] I40E refactors
Message-ID: <aoh-mcbeiilDateU@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1787149329.git.anatoly.burakov@intel.com>
 <cover.1787303683.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1787303683.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DB9PR06CA0025.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::30) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|LVXPR11MB9732:EE_
X-MS-Office365-Filtering-Correlation-Id: 97e4af56-9885-4e73-c6d9-08deffa263a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|6133799003|11063799006|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JPSKolyBXa/aAbSNlYnoSs2oSAmVFzfejfGUxsl29Jc0hSI+/xNsjObIjkxKI6723u8xTgxoiwVandYMiRJanbX/vFtPArFkQI5VBx3sPI6getEQh+4XIsjL0+l32uB/L9yIkRjGtwUn2tKAyTBMBEwTjnQ2SgiXQ8oJvaTNRFsul6VV8ZUevIL+ukw9Hi/HAyLL9oO9BKX1jtV43zuAAIP7u2K2ZgayBIGj1VZM0rO6gsvbCVlKud2DpOVIxxITNkTgdvGbbFvR/0bTDMtZejvtRjPkqcCAHxV7N+h4lusV3PuJTj9iZ4wz3laGL+Fzbzds8Iyoi5MiBg82aImaowlYErY5GbhDZ+zvg60gIBaUbsd35OzG6VEmYOaph4eMQlMQ+JjjxhYejiC2rS/eqPuXm6p4UEinFPwZCEeXivrK8drJyupilpIHRv0wyPbV5Nk+BOC0VoWu694m2a4ba4Tcx8y1IQFX+S8GdaxBO+YJw7B19oNK0DU3bIdcydh29+TA6cLs8kOQ/RVRJ+Om06jfVVCLXmMGegn6myoVuaP5JQEoeT3b29cOw2dtFTb1tddf/s5WHetmxyI9GoKU0v6cRAaWWhRHVuzIQPrIuUzQKfjNKUAmKX26jqtxZ41px2kmRY5dTBN+iFlJ+FvlxlvR3ktyKJZ0ZqFl0Z1cmW8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(11063799006)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GSDgkmtUyegiyP+uT4ZpYKWjaPMXseosdtUaZJAX8iXq1MICQhaMW8cWGKjd?=
 =?us-ascii?Q?m8k2zJo6dNHA7WZWVLq+C2z4+RarQ+zhi3BjUz2AXGCH0Ulh3AO8CAk1Dijn?=
 =?us-ascii?Q?ZIEe494Et28CWsn+LPyREM3yafxt6yKSeKsO7mEfDhoLOXrArbHNH3JCTnUY?=
 =?us-ascii?Q?YWLCZMGgAPztZSn7KIXNRH4ZXItoOzLjm/SsQsXN1T6NmSZcTa1y/ELp4YoT?=
 =?us-ascii?Q?RdIIpwf+1i/J9vyKOyMzly8R2eBcQSaUI7vEQZdczPv5EaNPCKa9Trjpyrip?=
 =?us-ascii?Q?7Bnncl3zqTOTrJ/v5I7A2G6MlOpm50+3B8jzizJcEMnfZn+fL5gxHRKAuDLh?=
 =?us-ascii?Q?lNnWCXP7uScS4OBuj1LiWNzgtqkV9e5CPFIf8DVssKD/CKNEjrn7Jdg57pVu?=
 =?us-ascii?Q?sHzwoyloIEJ2xvZJkxQlP4nSn/a5EKV00F633PZMNYxHOAhxYPgBeO5nPpmM?=
 =?us-ascii?Q?i63rVxZYVmHDBFkuhzOvs64nFk4uyq2CWvz9j0HSkVr6f49GxeNF1V1jteD0?=
 =?us-ascii?Q?BbYdPKEjE4QzuNn21HjuCY7tjKSO9JSn/nOcPkUQXxvp/otJ19ph3u3lNFFh?=
 =?us-ascii?Q?l9VPoqh+fSgD6vu8Se0S1cR0ih1Gb2JQ7pw9Iy1qPZO29N9RwfyHPLKa8Hd6?=
 =?us-ascii?Q?V83rQBZiTpw2RmlIc0hhJlmEJhcIpBJd7baiXM4TrRQPdJLodnUuC3u18Kwd?=
 =?us-ascii?Q?MNzxrTtmxe3F9C3WdBSEkmEmD+UCbrvvDNqo/pibhAU2/7I1ScifKVwGS4s4?=
 =?us-ascii?Q?XWX9mjnfzqLNz2qNM04Yl9pwUNRhbjCwpxi4cdIeyMPnS/HyTfyP7AAA+FP4?=
 =?us-ascii?Q?l0KnFtjZpsxu9xb8Pul2LaC71DKi8aLHsxY83jEs05fLZ2BWk46hMav7ZekC?=
 =?us-ascii?Q?Q7eRR2E/z1341dSNOBLgAD06BMiUj3A8AoBgYF8mmXw+DrD+xe/tU9MQi+sb?=
 =?us-ascii?Q?ecxPoWNfXzKncOEAJT5TSvQgnmfl8bZ9WQFkLndz1eQTUQJ6I+W2fPbV/0kJ?=
 =?us-ascii?Q?ZsF3sooh5C7ExNDJdnmdvsHCscO2DzPR/MK7Tctj7NHo15LyCtbcawXpXuSA?=
 =?us-ascii?Q?mrW0O/NiH7r0Iy1H6sOz5xlu8AHvbrlmigAtrFp8+5cc5hug2rTSCVhVxlOY?=
 =?us-ascii?Q?3Ao1ooH2t9T2GpQfTMKfdEmArNr4MUZsacEGZQsGL0/6mzlLPhGOBI5eT0Ml?=
 =?us-ascii?Q?nCn9vrxIR2xbCBG0YzWhnB2rAV/fjb0qM8GCInizqfHBAt3KiLMoEhdDDO1q?=
 =?us-ascii?Q?mAd2WxVhTHPQS8NtQW6E68FN4KToW1gEpIyQ9X8fyB3t6o9ezxkAm5AVXM5N?=
 =?us-ascii?Q?PWVWicLQTFO3umb25WWe6TYJpGWnfmE8NgHyUnQ3L5wGiIyJFO0+4LxaVzu5?=
 =?us-ascii?Q?6+mk8cvSbVDcKS4S5ZCpD/HinY2+P0Dcmk+zoJdrYVjZrrlX4wfXzuZ+IZhj?=
 =?us-ascii?Q?R/AMEFJqB45z6bVAKQmntCyNCJMBwRgbpUbkSekbzs/0wWNf5UIRYwJSozvF?=
 =?us-ascii?Q?Uu+Cqf39JxH6vcdBrknekWlGD8ck7gUyAf/UxHkUM2ykAFdXQcQo2TZnYyOD?=
 =?us-ascii?Q?iSDBP2CF8cpQSBxsR17Yycq2ccRPC25nh1KFecEs7TJwaGISvqfYW6+lw8F3?=
 =?us-ascii?Q?WX44sMO9VfBXYXriUGF34auNoEdfQ4ksAuzz9xBgS6xkNQKM0iXFkT/Y6vJ2?=
 =?us-ascii?Q?4fuSbL9UwAKZclkHob0AzCuQ6Z1sGyenN2CgGDw/ZG49XagsXbPiHc3QX3vq?=
 =?us-ascii?Q?fv8BtjjZCwC2FVuh5IfM6uXtehOUZAs=3D?=
X-Exchange-RoutingPolicyChecked: CbIKhm4kTsbDH2bC+QcSXB3/dpIgrJrarK44WINN7OjOD0pWji4h8OpJJ7mOCH11GvGTS5fvMTjpvex+CJDnS0x48cKbfWTe97wmRCVR/haXGyPV5looA/PF9DY22GLJNkECp6b1Yq6b7s8UDov4v0UlgmEwYfgeoILvqY8+Ixte6N3WLD9VLPpe0Dukj33HDxH8geYoYdmxZGRN7IYidszpau3kJq/JRswmjU2NLyIEvso6Ej1655DL6qoTLzdZbbqO5lHhb4YG5MYsCijDGJpLgIwyRZBk1Vw4hKWs4/pZiNXZnI2U8e8N63PLgohP48gTQU2+tbrbXxPxtHpBIA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e4af56-9885-4e73-c6d9-08deffa263a1
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:36:45.6508 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2M0PySZHzClxola+/fKk/QN86qQfS2leMLC3dkLGQw6WMF041krrzcQVk9OwjQhbD5A+2b9UyK2AmozV7CcjjoBsz2/cN3fqP7i4CTFGJrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR11MB9732
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

On Fri, Aug 21, 2026 at 10:15:29AM +0100, Anatoly Burakov wrote:
> A small amount of refactor in hash engine to prepare for future
> code. Specifically, disentangling the mutable filter list metadata
> from immutable RSS configuration supplied from rte_flow API, and
> getting rid of embedded rte_flow RSS conf struct and replacing it
> with direct values embedded in config struct.
> 
> v1 -> v2:
> - Fix patch 1 returning non-NULL pointers to queue/key when lengths
>   of either are 0
> 
> Anatoly Burakov (2):
>   net/i40e: do not use flow RSS conf struct
>   net/i40e: move mutable fields out of RSS config
> 
>  drivers/net/intel/i40e/i40e_ethdev.h |  18 +++-
>  drivers/net/intel/i40e/i40e_flow.c   |  13 ++-
>  drivers/net/intel/i40e/i40e_hash.c   | 125 +++++++++++++--------------
>  drivers/net/intel/i40e/i40e_hash.h   |   1 -
>  4 files changed, 83 insertions(+), 74 deletions(-)
> 
Series applied to dpdk-next-net-intel

Thanks,
/Bruce
