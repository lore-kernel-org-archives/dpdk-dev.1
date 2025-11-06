Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2447CCFA03
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 15:10:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 197DA402E1;
	Thu,  6 Nov 2025 16:10:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id C2DDD4013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 16:10:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762441856; x=1793977856;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=2dbDURPO0SfpWu909Slmyfm79505beNx+C43hwYnqVU=;
 b=EmUpHA3/d8PEdpqhIBcwZDC5ul/C09MAyaf4xGM2EBKd1I7bLKlHySTa
 tB3NXk/ACUImfKTiasYUWxvDy2RJ/0AkhIGsOzw9XY6KrA7T2wk0QPLX1
 anDFWDIysj0V8oyULRC3E3Xrl++L4ZMGXpzVSkhs3tASdO8Xiqki0zU14
 QwZCpWVvfgKtKSxyL7POu75VaWCBy3RToUq5SJKXBYlK+qM3OeCqC587n
 DaneQA/aj1Y21kCxAqxdPrngP2gWXInWGx5wq5eacOLKGqfjHHxt9ZiLo
 2ukF6lvR9X5Hj4mmx8LwaNOg40DS1R+i1+I40M6ebJJGQJCbA57R367dz A==;
X-CSE-ConnectionGUID: nGcGlAG+SGKTa7k4soKFjA==
X-CSE-MsgGUID: tKHqLiB2QV+AgSLFN9q5OA==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="87210174"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="87210174"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 07:10:55 -0800
X-CSE-ConnectionGUID: +jVXZ+LIT+SKl+9szXr81g==
X-CSE-MsgGUID: ym89nOIXRxKRkQIsu5cP8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="218533478"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 07:10:54 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 07:10:54 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 6 Nov 2025 07:10:54 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.53) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 07:10:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZdypKwerjA+OWhgingJlS4ILd4hC9B4hXY/THFj4qsDNirMla76w9VUm1OrSq4gU5YSTx/xF5uU455kCxQMWkioiCY+sJTqhoa95VkMc/TiaXgOEaY+NogkWqr1j52qD7yZbsepU94hM8LUtAW9O0BoQV8L/jn1e8ZsarAVAXy6s5/PcnfedSJFCz+j7EZVKIdDYfjQkq74oyc9JQNKl/Po6FeghEsLAFH5smr+aiPNKYJXZaACISgh3iAfdxQihFDzXI7uj5bYk7lh6R8PleY6R/3D97AxDrWlfEl96mxJqZNVZrfzV73TT8sjh/dYJAnVi7ikAQWAHbcSXtd9aRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0ZbXxWwCbnxQRn+bQIIVvK+mohI+rQ4IiqnEoRrOE4=;
 b=xIT5NSTJo05/oW0jXdPHyi54sUXTE0r3+PDOVQWGiHixkE5SrAXIpj2Vtt37W/x03IuXt7LSH09xBDCm0GxqbifNB7VqFa2zlbOsGq7FcXn98prOzkaYIzqzvgvEar4N+/lBciYXeygGoZWB2zrF9yek4ppqK5WSRfzqQ8V7+02BpDcuWeDRkoO15OeDwhGHKK3+tLk2LxBEz+Xr+/ZsJtZNTvauDV1nYGq+joX3w5gdoncJJDTfJL61Yu45xEH/IA10ddqLsvCBzVJBQmCxUpQVCXTg8XkokNnGv50s/DjlQ3gtigcW1igaYwlMBL1wIx0bOXxG5cexc+iXyRbmXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB4885.namprd11.prod.outlook.com (2603:10b6:510:35::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Thu, 6 Nov
 2025 15:10:17 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 15:10:17 +0000
Date: Thu, 6 Nov 2025 15:10:13 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 5/6] net/iavf: fix QinQ insertion for single packet Tx
Message-ID: <aQy6VfloQLWbYttU@bricha3-mobl1.ger.corp.intel.com>
References: <20251105152642.2981673-1-ciara.loftus@intel.com>
 <20251106115016.3035639-1-ciara.loftus@intel.com>
 <20251106115016.3035639-6-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251106115016.3035639-6-ciara.loftus@intel.com>
X-ClientProxiedBy: DU2P250CA0013.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB4885:EE_
X-MS-Office365-Filtering-Correlation-Id: 75f8e9ad-0d46-4331-90d0-08de1d469861
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?imsr65pFk4dSYz7ukqYiXQl0kmUlliZIPILrV3zacEXCedloAdaKPILlmuLn?=
 =?us-ascii?Q?Nb95EJBuVu0kXR/wWF00oC8mMJ+ImlvD0l4YlPbYV64BuzqaFg0dQHYJEuBb?=
 =?us-ascii?Q?DgSOuCzhwlUhN6X32b8CQL7sMA5TwhcT6iPqnRBMQf+XjMhQ+0Y1wOjEgnTP?=
 =?us-ascii?Q?xaWJKJlBUBpj1Q4H1xLrkwhMJWHUOXSymqzDeC5XgecCWKOui6ib/fRBSDcA?=
 =?us-ascii?Q?i7uCVEdPTvqAYkPEvCVUVYO3WwhpX0o2eFILhhw52CTVADY+wyCyxWQA3cAU?=
 =?us-ascii?Q?T3UEGJrjC+6g7+PJN+M9/Wt3dNGQ3aWB2uxyySxoyd2m43iID7knaqogPI/+?=
 =?us-ascii?Q?SwCIRL5/aIsDy/UZa/P/G0oqq6S5j1clXHNy69pA930qJgmqGBzTI5Sg9e0h?=
 =?us-ascii?Q?jR8mU+ZOCjNuO4S5+vZw849qEQzTNgqBRiA5C6ZOJtgDKmkViEYfVICkmpXj?=
 =?us-ascii?Q?DrZ5Cr38mKvxV8pFkgSvUk8XtnLWVhk20ubiKjsIQwJS4bVhG361TtA1JB6S?=
 =?us-ascii?Q?JhAeYnf4SSAkNS1qzR/0z7Ik59BKauEqQ42qTrEtg9X6MPOSo24F068g5Z2g?=
 =?us-ascii?Q?ihdSiYar3X7//I2OMg6qP0IIxCJs7VUF8+vDQWmqNAGfPEaejNRnGTCAP9A1?=
 =?us-ascii?Q?3+6nwT5xoStCCF18dSlnmz4zBg0fKmzUq46jHF5mYvoITyjjb+4esZkGnSGg?=
 =?us-ascii?Q?tSssYb4tigdsOSf+LbdusM62r7Jzo8oNdRab4UihIaBEywiW+WiskFrUwukL?=
 =?us-ascii?Q?3qrVM4Vjpi568floYVLF7z/2a97AZa9WlJi+FoG4WKWFelId2zh9h+NFzVTp?=
 =?us-ascii?Q?w+YxPnUD+HQgsPZ2okPPkfDazlrUBfAKyIEuj/qZblhJHim16CfMS/4Lp9eO?=
 =?us-ascii?Q?B3bs8qLoeIsnrzPXwbSJpwn5tiiFlGMMFFuoBiuTtJHRpXbk8BKGwLbT9P8h?=
 =?us-ascii?Q?MHqqdFrQuq4nF9SKalV9gPxtr43O+F3BR9NB2gaX2nWaku86cDe/pj8K7XmZ?=
 =?us-ascii?Q?4EfaafKMz4iXwfo81HozGlZE+KddXn+RuhD7CPw18TKNDUCuLhzydbzFy/oJ?=
 =?us-ascii?Q?yT9ofvOCgTZa48Fr7W10cJML9pSYVmyjLndZQG4x4i+h724AI0OoqSbqaONO?=
 =?us-ascii?Q?O3yvUPDR/QwtU4XpzEDR3OjFEEyT+vfy04iHn9Hjditxq7/B34g2nd17NqSf?=
 =?us-ascii?Q?EJ5eVToThGf2HpBG7p6lqBIpa1xhAVIkCCsNYkt3mFMX9+dizuNHOl9U4hue?=
 =?us-ascii?Q?OiL17qMEmEqnMvK57PBcyviDG+VaL2NcSyJnEauKAoBa5kam39dL6WSkHCwI?=
 =?us-ascii?Q?Y1CH+4RkyKZPJrssma26jOX6RY/IkgbkyFPcLqhr539BMBOkkLVPz7V8MBRS?=
 =?us-ascii?Q?avBfKwGKY31MtU0z1cQgjuI+uukdiUf8zcPoGnFgxmLGwCy3P7hiaoE9Wglo?=
 =?us-ascii?Q?lF3t6hxoiWMm+yCq+dkNyQHiGMNrQHPq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yQZ1FL4rV+1TcHl1bHRQuRbgiLBNAG3MYnNUl86KnBUZgJOO60Tj3069cBqo?=
 =?us-ascii?Q?gt8Iurpwvofl9dX2Dpv9Y16DfFG2jVFcl1GNMaVgZSLGGDW/+pXJgzzV7tHE?=
 =?us-ascii?Q?W4TQkELXmogIaoOr3Q6LxIPLy/zt2fPYDUnDzafCw43/QxJcugmgO6hX7so6?=
 =?us-ascii?Q?IvRaZMBva53qf0P1q5v6eYFb9hx92hBtfVL1bw8E+itHpNOPKZ0M6MVKgGpK?=
 =?us-ascii?Q?1rjCpi9PJDwxzkAtxbuF2xdqIj4yvJRJ7xr6LmhPJry7isH0nVOgOiEmaxrn?=
 =?us-ascii?Q?eJF9P6A2l0mfIeD3RI2TNQeS176b4gZ3sIkzSyFkhV8BolFJRvfdl4trj5A9?=
 =?us-ascii?Q?mEEtvFc8Rt/qaPb/qfx6vGDuBKa7Zw+oxa2rbss3uQhYFrpC6GUQc9af6yFV?=
 =?us-ascii?Q?vOnvOXnJsrq0muFagUc+7XYVuADk3sNTXyhAltUKKwVCWV3xejU5uPGVxlK/?=
 =?us-ascii?Q?AN64mo5SbG2S6aWwcOB5Rsc6liV3HLtVC5I/OnsQg71iBfaDX6BGViQ8NeY1?=
 =?us-ascii?Q?y1WVZddn3sUVk3o9lu338OW0TlS1cVIU21IK8mKzxTVpS2Uxm+if3Zel9QT4?=
 =?us-ascii?Q?aMKoOHHRRQ0DxAj83a1m7WhtK5B+cZ3vS5hhAd5GtZu5F+9kvTHiGOLejTAP?=
 =?us-ascii?Q?ygpAM8R6ZCEqIi3VSiz7PlBW1dV28IoXZBshE+5EqlOx1bs/NdTwpmbkoQJr?=
 =?us-ascii?Q?YAlRLkVw3LMBpvXyfdQhPKsbOcpf5HEIcCyXD6FDwS5YQ4CY0OakiiOo6Zh5?=
 =?us-ascii?Q?UVjPwpGssMV4pxjRfshY7BUlyKNbAqTNlUH9L+OqSMHYFPJ4SeTLL2DdxV2i?=
 =?us-ascii?Q?dAxqBkxpJ1CPqeGVvWkBGNn/vVOcODApr1ejzWQDCq8X9NitF40rsLWM02jw?=
 =?us-ascii?Q?+wNLmz9RX3ZUT549N/JEDb/xENkSe7VaCME8zcKlKJEXvpRLbZ+sv0HgmF6a?=
 =?us-ascii?Q?YtVryVM/mOD0COwtaEj++I25Q1p6a2nPSbfP+n6yP9bW6EOz7yr43dkSRGur?=
 =?us-ascii?Q?IZAfzZnCPtHsvaBW/Qd6kT0/Am0r6MuaSQ49bgE3MoWn+3A8hvtK6K0X0et1?=
 =?us-ascii?Q?3WSM/81YpVIR+TW/ruMg16Z12fFd71sXfYMmrXkBmSFPq2eSgLzV5N5QZSo4?=
 =?us-ascii?Q?TJ56I9kCJnvAQCXKt00sEV/Odzm1yZ/TVUbAiQ1nbkS7rXsnDxZTbOXt4EyG?=
 =?us-ascii?Q?UItW/TwVu1WSBIDhOR1AsBiwst1ed1CfhB++euuP8vhqRPT48t6j/F9M2bG8?=
 =?us-ascii?Q?WhPbxaohDJC9/u2nCImH95I9eUErYnLcfvZ80cQOrCAWJJCEtMayAiWKXibo?=
 =?us-ascii?Q?ZiBFc44C/3qJ2m/DRowSS4625PATRW+66E5tRnuhhqlBlhFWgV0Jg3eHIO+Q?=
 =?us-ascii?Q?Pq01WlgnuDgX8vVJQc90eW50oKo8Vbbd0eqolVYs/1LQF1Uv8+uNxCXD4Tpa?=
 =?us-ascii?Q?pKciuk2ykZ+Dw1ychLiYrQxEQH67VCZoNqEkelHk29fMElZttLc3HjlgQJKA?=
 =?us-ascii?Q?TT9iSxvGAiCyHo3Zt//WxpH0DQYFbWDKrHW025EGK9pdqflDaVSK6xbhCrI9?=
 =?us-ascii?Q?qR4Ysl54mFy3Lh4v3D/V6gswLCXdsnpIHUc9WwaRQNDJJGwG7eakpk2tFdNc?=
 =?us-ascii?Q?zw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f8e9ad-0d46-4331-90d0-08de1d469861
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 15:10:17.6318 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hyL+aJ5+5QXlL1Y9AIHciECJkSObM2LNRwhx3FpkWYApvtqxPx8bzy207zNa5gwSKOcR5X5gt9TlQGU45sljPocZXk0Bcj2ycf4sQY93AO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4885
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

On Thu, Nov 06, 2025 at 11:50:15AM +0000, Ciara Loftus wrote:
> QinQ insertion was enabled in the bulk transmit function but not the
> single packet transmit function. Implement it in the single packet
> function.
> 
> Fixes: 3aa4efa36438 ("net/iavf: support VLAN insertion in AVX512 Tx")
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
