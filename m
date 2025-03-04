Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23BDC282D0
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Mar 2025 10:50:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D637B40156;
	Tue,  4 Mar 2025 11:50:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 78BFD40041
 for <dev@dpdk.org>; Tue,  4 Mar 2025 11:50:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741085422; x=1772621422;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=DJnWJlvTkNbJWdqKo14K+p7xMdLqhCuQM715jnGMne8=;
 b=jR/VtrjOMqt3pr5Z+rKosgcp9dsue4ewDIq0rxK/LF/f9SgiIh+KFlXb
 5XE1OcQRiPIZ+a94fzy/R0bkOYI+eMaxv3LNbrqYeodYaauXrZCsgfrrN
 WC7iSRKG1bATEZ9pXogEm2GVUmCdX3OsV4CpGPdL2atgV7J5+vB0tXBrd
 d7TP8E9kja9ojxlZDC8xj4knth8Jr2Le831HiZ013C8t5P5TowLljZUZr
 beBVw7XIuq39q8FD7B0G7jl0/T3FgMVpAKUtjVg+fNa1dr+5LyFXx5Vz9
 M/fdFmRUXPKd2XUFMTjJv6w/FRrF/Eo0QNx5asshXqaXuh2gjEL+ujV3Q g==;
X-CSE-ConnectionGUID: MuqOfRonSJS3VbeNw4Cp3w==
X-CSE-MsgGUID: AixtFddzTSaswk7mjwABGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="42246223"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; d="scan'208";a="42246223"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2025 02:50:21 -0800
X-CSE-ConnectionGUID: ynaJjYqASfaQIPLDDKvn/w==
X-CSE-MsgGUID: O67j27PnTNGcHaaHgCVT/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; d="scan'208";a="149130698"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Mar 2025 02:50:21 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Mar 2025 02:50:20 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 02:50:20 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 02:50:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wjd1V1hrzjiByzP/vDzmaAK2YWElS9l1JOcd5UcOS55LMrCy7O7XbulM751T3AAopOpA0A4um6nSRZztNeVz4rFFbe+Po+GEt1/Tu2eNC0F1rHecMWEmgsjkoTRdM9R9SORDu28Ar+iMB4UhN1MGMiU0JrdeI9pn6Lnpee34/H9XirJYk5VjulxCe42VUy4/xdzt0oN+0anowRYW5F0Mvu/16wQrPG2ZQjbXol0eseoI5DPqKAmQMzJ/HIqtL5HccZ3cqPaEdIx54ha/8fGturE9duH9W3KfEnwxRR+Fo/gpxXLReXi0uw34jVlc2xgZGVJiGrDOPBlYmZKzKx8E8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WnDbkkhjx3Wm4+E3c3bvaXlOILa47LO/Eg/gSPJmhLk=;
 b=hUOpaLOjflMFhg0+HRysSxjZs7XSS5tqaVFQdfRhUhwmR/rinUiiJNQc6lBU5599r/LvRHHVOc0HV4EjMNK5+ckyExnyGTMJTtkCEOhK83NCo/5lePFXWMZ66H6ntcXLgdPy0766IfUYH2a1qLQN9JYuybm952GEglxzn7M5k8fGekUJEWfjYslK19+6+I5cxOR3FD/hQiyYssdLeb06VdQqzgMDNoNVnYRMtuAoAwBIE1vLqwYMfTkcKHkeNZRtZEn0scDM4fEXLIvS3mgRNAfExCx+qwP+1Wa2rTtrNQKFKrzzcxmq8js5DeuH3WZGz3rdZcWW5y7L6jgngEkc+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH0PR11MB8143.namprd11.prod.outlook.com (2603:10b6:610:193::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Tue, 4 Mar
 2025 10:49:50 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 10:49:50 +0000
Date: Tue, 4 Mar 2025 10:49:45 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <dev@dpdk.org>, <sameh.gobriel@intel.com>, <yipeng1.wang@intel.com>
Subject: Re: [PATCH v2] member: use common top-level variable for easier
 maintenance
Message-ID: <Z8bayaioc0GyYwgP@bricha3-mobl1.ger.corp.intel.com>
References: <1740769261-736-1-git-send-email-andremue@linux.microsoft.com>
 <1741034874-13573-1-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1741034874-13573-1-git-send-email-andremue@linux.microsoft.com>
X-ClientProxiedBy: DU7P250CA0022.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::6) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH0PR11MB8143:EE_
X-MS-Office365-Filtering-Correlation-Id: c1c2d8ca-e6d8-4231-25bf-08dd5b0a49d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PuqOEKG1CemwebU2exAQ4u+KtjdYK0q0Xp9MLVS1lJuqyPl1EpTep2c5li1L?=
 =?us-ascii?Q?ds/IYEpdDTxBzYRZgYGgddZ/vekXjQ8mBsKUG/MyN6uYxswL6CPd0J5/EGgm?=
 =?us-ascii?Q?mZqybDQhkpPT1h/+tmnLinsZBkmjj+MQBoxhgx/LL1pZxgtiNhETlI+OTexh?=
 =?us-ascii?Q?jojPhYTITrPDYgCUODpgtSfI6QETCwLQj1skH+EPMwgqHyhjQ1YVWP0KFtV6?=
 =?us-ascii?Q?otBm8/o0pqfl26/VGhYx6pDbm5NLbhuO8of31hYTEA3wMe9GZNMHZT8ybNRp?=
 =?us-ascii?Q?mMnQObNkWSkYlsC+cBbyjhznSVK43wzrDvrfpEnZpLXWA0GUYmc7WD+Oic3O?=
 =?us-ascii?Q?2JHbrVSmBhvewHAFqnLXMVT4jdyEeqv5Nk2mlxBgs9jHpmBYUEx+ooD7YzPl?=
 =?us-ascii?Q?5P7cnTEUKScfsm2xxduOcEKWi7VPa5WN8bVwNZHw52lHI64hrAMf5+QQUIIu?=
 =?us-ascii?Q?cjflUdAxUng2R2o0XN875SbZg+hg1wK55XgZeVnrvbvcdOCqKcLk3/gdGJJC?=
 =?us-ascii?Q?BO3p9moVGEOfbgUENF/oenMCUOwPUX0NnIee4EhlZAyNjGgMgI1p0WofbVuj?=
 =?us-ascii?Q?DnIQi362bGxPZBdXcapfTxFv2Ox4DHEQ9C3p9JoBq5KwwD5ytMQTbkPrrcTh?=
 =?us-ascii?Q?nAPvIGfkF5h57zwchCpMjPoCd3DeIht6TRHeO7+N0Exn7epMigufmcNdpFwY?=
 =?us-ascii?Q?6xSrl6yYuW676nxn79ekSigBJcI1wO2PEzocom44huh/mnSNH9hoPnaFJm9E?=
 =?us-ascii?Q?bRvfgVDCAoX4kYtHO1fytEdfij4UPuayHJpFXIodiBRKS4j2oe6VG9Cip1TN?=
 =?us-ascii?Q?Y+KfVlX1q1TSuGFM2NRNkQyb9IdW4dDnJ60V1H5YZzpF8jua7d1gvq1YDCu3?=
 =?us-ascii?Q?gXzPhd6+QGtjRNIxM24UETo+f0GFDF3/9kzMo8ZvSLn8a1Uq7GxL/sPp3Wm4?=
 =?us-ascii?Q?S63XyP77CLHdmBXgeL2DBc9iRSNNYmTxlhXLLjzl+qQswT43cpXIqgQUMd4B?=
 =?us-ascii?Q?+69vWBGzeh8joXoLO1m+YKe6TpVairigFdQkSZVVIfC/tEFBmoeY+BVuMmGL?=
 =?us-ascii?Q?zhK16YQi4JYedCgX7bn2UEY/EM2gktTc+WILER3KFiiiAs+W5/yu+JOap8yZ?=
 =?us-ascii?Q?ftKeYnCf+oNz5IHFDACV+0YdeYtHoguaOqje3rguH4ZAj6LWtDfcqnUHTPUM?=
 =?us-ascii?Q?59jc08qEwdhZjRQz+B870lJjnrCUCW86xtmUgUmGlpJIvSJOP+9yCqXvbUF6?=
 =?us-ascii?Q?on1+iiaRxd9hrfj7TW0HIQjfE4Bfd9pH3ZyVKdWbPqPVWTaCBtTBByYQ0aeG?=
 =?us-ascii?Q?km2mP/dzOAVcTKtsTHwpwGPAbKISWA4xwTqzAgAz2ZhSx9exlqev0K+CviDn?=
 =?us-ascii?Q?dH1cmjUaUL2vVChnPurYop7K3Ghr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nnQkUCBXiBoAV6zB+i8w9eKOo9b1zTf0FPz0xtOtV8RevJ2AUpv8Kc5Ltkyw?=
 =?us-ascii?Q?ZlvUDUu3GktvCmCnguM41XuCyQHmfIF+rWGqcvmeIjUKTt8yc5pf1it+MHDg?=
 =?us-ascii?Q?ZpyipeVvC3Wj2qeZoQ4YNwtp8ioBb1iPtSHDc9/dyurT3/vrcocNCLY8xNTF?=
 =?us-ascii?Q?42i6mWa01aECV9wU4WA9uW1L83uZEmK6PQad+HLA0S2ss6slUIwnhGRTzlk1?=
 =?us-ascii?Q?GkYWOpyv9h3y9IT/Wvg1IO3OWSemoVbUBvzryoyFQ0miaU2y4IT+4LF9LlHl?=
 =?us-ascii?Q?o2fTj3qVJr3LZQRpR9Ta3V2f0Y1x8A4cjWAh2og+VmbUqUp0+PbyJ+qWxrYK?=
 =?us-ascii?Q?+pvBMlOpsShFvu4EbmsMOAVvcKY23QCqdi0OTkUB5YlMHL+SykdGrM2aY3Hv?=
 =?us-ascii?Q?xcbSXSxV9uzZMZQN5TTBoKfTC5WeIMAXQ4YU1Yu1RgpQId6pK3OKAx7uWVD7?=
 =?us-ascii?Q?YADpaYQw7FbT1pPXPylRO+oi3ifCk1zd9E/s+fWhzYsHLiM6HULBA6Gf6Ul2?=
 =?us-ascii?Q?jop05a1dNsUN5p7mYy1V1wXtgSOJxq1EaHW3IxYBjOqb0NLUjgFAo/+/U02I?=
 =?us-ascii?Q?8hq1WrzbfWdLni39ANbiXnYPQbCpoDR6agYDDZRej39ea4tXqAo5Xhkxgjdu?=
 =?us-ascii?Q?qkZwabYH1cHzwM42dd5eri2Ad1JSqkY33o/AQ73312G77x7pEBjTA3bz/LE9?=
 =?us-ascii?Q?jrxAB9sjyuZ3ER/Bf4KfD5EC5RrA/D1diUuoviEKx7JoHXnNc1lthrw5ZzQJ?=
 =?us-ascii?Q?2VnotokRR87OqeGPZ0MqXUXhxYLKhTmbETEPWsRoiCy83X8I/KIN9DVnyM93?=
 =?us-ascii?Q?CnRkoZA7ZAFi39Ddi+3dIbTm9gIRWpcLNJ+Y1G5qlTUswR4+VIUdsSzYhe2F?=
 =?us-ascii?Q?Cg4D4peh7jv6AiXwJfJTh9q0Zt7o4jtjTBq6+QP/vB8rrRRfYzoHq3XOvk3y?=
 =?us-ascii?Q?HiwRvM+QLNteXl1SMCuH27rVvZcMBJ5VxegyoVzKrtkqKX28cYQjYccURq/H?=
 =?us-ascii?Q?RRQ92ZfRAXf52SL2csONAKmzR838qlFuSi21ki4MOP7984XYGuQuWXY8izIz?=
 =?us-ascii?Q?IULsDayW4s0HWM2ErAP1JKG59eKOJptjIUS7UMEnHeOs3Jcwy+nRd7M7aiLQ?=
 =?us-ascii?Q?xguowLgoZRE+1O7XBrrJwdk9ti7XRzfi4Zb1RXx6O0KKaVKQ85+iaPzoHq+6?=
 =?us-ascii?Q?1YhZRa0rUNU8AUT7BMuadzyiEKaa94YBDsvpUL980J+/PHdtmGz5O111Nu5R?=
 =?us-ascii?Q?FmP8Rj1ex0/o5ZaYJbh1cRpr/wbe6U+krloK0WeLdRPyMUqM5L3gOXydsKHU?=
 =?us-ascii?Q?xHVSk7OtHFk4CNKqS6lI/i+jbC0JYNYqiFmuSfa0bTYKe0EwvFEREkGwrFWU?=
 =?us-ascii?Q?tQeqIvygtN4+UMzAfQCAv+P8EsqFbDzuWGXGbOF1Evk2h1723fRyAwmD47E3?=
 =?us-ascii?Q?B7vchRuMmvj7ZyLd77x1hFze2r9vF4KMdeplO8E0vOmO13+1Ao6lixErRUh/?=
 =?us-ascii?Q?6dEmKA7yo4kmsckm/sSl63h40VI13HdXXeViOGmgxfOJXTswkQf3xa/FET5V?=
 =?us-ascii?Q?19mxVnTNMABgzQuKyryMfVukCywFLI6ZMrgQAm0gLKux4Uzfcj8rYYQj8P04?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c2d8ca-e6d8-4231-25bf-08dd5b0a49d9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 10:49:50.4294 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 80pPg+mOPX0gQj1Vs+WRkeky1SkI5m8fxvQm0ehkY/PMwwfjiOKrFHyxR/mp/BV1dvCrcCP/BowdXLWK4ZgKTivzTAIhB9Toi4MspenQ79M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8143
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

On Mon, Mar 03, 2025 at 12:47:54PM -0800, Andre Muezerie wrote:
> Updated meson.build to use common variable cc_avx512_flags for
> msvc and avoiding code duplication for other compilers.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
