Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52469C3ABBE
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 May 2025 07:28:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CB624027C;
	Thu,  8 May 2025 09:28:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 8AF754025A
 for <dev@dpdk.org>; Thu,  8 May 2025 09:28:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746689318; x=1778225318;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=JaxZB/Qg+bGGGO7M9T2nmEM4GVdjVymC9aADH8dw000=;
 b=Wu3Bf7UWvRfJ9r1MtU90O6TaJ9S6hwg5sF/Rp8HG6nr0qvWAzCAqQw0Y
 X2Ep+dRAiMmxxJmT7VSBi7540XIDH2kKyNmln7HxV2NZGajsdrDQ/OivJ
 /DXF3+ptflLV39LjOGV/Fz4Fev9+wyXces9vaEtOEyEBIlxQ1pkkWHiws
 aL7hxYFeSoswLFVzP9QCQnCI9ZjPwRP/PaQAW4GjnS0dpz39PTN98j+0X
 WRMwew58sFjBNnf3dd8PtcEmOX2qoXvrDwFKW6LK41cblnqX3TSW9murf
 3FPhvjxiNPGWX3+rQcuVxnUDRFj5JkXaJHXUtyS4p0nmuZijLdPB0+H2Q g==;
X-CSE-ConnectionGUID: YPnwtcD1TcW+VuRyXhjDHA==
X-CSE-MsgGUID: gqM77EaFTUGjJh0oBOe9Dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="47713021"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; d="scan'208";a="47713021"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 00:28:36 -0700
X-CSE-ConnectionGUID: 1jIcR6w5Tw+Lwg/c1yq6CA==
X-CSE-MsgGUID: ZFDTrdYQQ/OemldByFmTrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; d="scan'208";a="135906962"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 00:28:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 00:28:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 8 May 2025 00:28:35 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 8 May 2025 00:28:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y9MR/RIcQD09f8Ldcw71/Ok4Mzoj7PeoP6771vszFLxS8kW58FlSyFLLdNJLh+0Apiwfk7W/xBRLSM/fTzyyJFW6CgKrqRCckVKpJNIi0fKutV8Arvi7aiN4V+vPlVfKSPxbxRIiMosBblNcdCR3AXGmnLoYhGeO/tRyoYfZERAqtUTUfSbcvmsJ97qj5JZ57+HsEOMsdr+dNidt40VFprjU+JmgaZVR7OyoE+eYI6BK3cFOsF1bNf5t31b0ZeQio+JNNHB3XwD8NWkE+gzurcwuasix8d963bM1SSDkEdAa/Px0UQ7J42l9tUkHod9tam3xXPk1GdrEAyMKBDfpew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6XvISL8Q/KLea2/RySuQTDAxdQRcAb6XBgqyCJK/I8=;
 b=FBn4T8k+cCDg9mbk64/cYcvuoDEU41JPNsWdIbnqQoiISv3BbPtTCFxC/gQRoMNlgP7qghk/oxYd1+xUekVLl4mYKLgUPk7vWk3Jz4bQrrW7xGmS2o9B6MY3KU6KiM2FAR4p5icK1zNiwZU7C8Cf4PhbgZwNPSW+FS7pwebrpvXRtfwFQhMhN4Z7RsiZXSVbQ/Ewrp4xSvzic7+p5i6U9Vad0YJEW5pNNXRgSMWauzmosgjC355KDT3qdJahVWisDj2koe/00trWMK1AinXcSl+SYSqTQXy0nUaiiW05cjw69FhKGq0cIkhoI64HwQWFexcM4xjGoL9X/kfjGMmGtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW4PR11MB6837.namprd11.prod.outlook.com (2603:10b6:303:221::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 07:27:48 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8699.022; Thu, 8 May 2025
 07:27:47 +0000
Date: Thu, 8 May 2025 08:27:41 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v5 1/3] cmdline: use C standard library as number parser
Message-ID: <aBxc7XgW1xUeiV-t@bricha3-mobl1.ger.corp.intel.com>
References: <7ac1444b7d2d64dc467a22e7ac65cf3cc16246dc.1746188833.git.anatoly.burakov@intel.com>
 <ec8528874aad76348f27c551289e1729b2fdcd25.1746631324.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ec8528874aad76348f27c551289e1729b2fdcd25.1746631324.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: VI1PR07CA0286.eurprd07.prod.outlook.com
 (2603:10a6:800:130::14) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW4PR11MB6837:EE_
X-MS-Office365-Filtering-Correlation-Id: b319cca2-abbc-4024-3a1c-08dd8e01d4bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EN0+HvE4njxtM9/nz2I1H2xBngVEsimuUDr4h27lDxZuRVNw9ipSgM7mHEld?=
 =?us-ascii?Q?8tn+/DTnOPdRlSQaxXjG9Ftf9RkrDDsIAoGSEr2ZK1tWbbaSvfyfiSJCZlYm?=
 =?us-ascii?Q?4mpDxcZNqw70HFxiNUOQ91OpNslpdyJMeCwjAZn/hHNrAUOOIeiYKt0zcF4Z?=
 =?us-ascii?Q?TMwpu51mzM9EKp2nL3Qhbegem9oNQEWHdrKpXwcZeJKKjsflh5Ng16gwXCQd?=
 =?us-ascii?Q?DN5QQk0ME2L9vfzF+OLjER/KogXaRGA8Kc/FbdHWPzaFJHp3MgTLhC6Ev0IB?=
 =?us-ascii?Q?+PVxpIfpeUd0Lnbj4KX9QHxK0oo/KLal6wRz+QupR1C3Ssqg7E9GukALdk0D?=
 =?us-ascii?Q?h9215S3nE6rNRdgb4n3O0eGMYbijWORd9W3WBzSpBI9y3EDx7vX1PtUyYYWx?=
 =?us-ascii?Q?iBeoG2CnBv0VpUegiEBdf6FYC4ML4UwsavquimVHyX39bc0foxz8uHj6vfkO?=
 =?us-ascii?Q?DJcqshwiPI+RM8t/N8e+OSUllSqkdzQ3LfnLr0L741jUlj5xFAMpzFZHbvNk?=
 =?us-ascii?Q?l8JiKsGi/X+DG+et5erDfqCPUXuFROlOPHRr1hRbUyEltaXksqcoOfJxx7E+?=
 =?us-ascii?Q?zUuRSdl9VbiYsVVmO0ZXJVhPp8FZLWmlguDFbDbl4O5Lb28TN4rvnrlkOMqO?=
 =?us-ascii?Q?kEyYnhbTgCPX5OiJNibSAYreYOWO3bEN5+QqAUIDIWQjBKKRo+wFcArjlaqA?=
 =?us-ascii?Q?ZOA6yDrT6ucykUEsi3AislZJ7p+vqcMmUu9EwWvdr2hz8vj/3OXRnvp8Joym?=
 =?us-ascii?Q?gkBexKBU5E1rX2ZwvMWHxgwcAN683GPMDJWJEl5xfwCt3rbr3kauiTth43k5?=
 =?us-ascii?Q?WQIvaVsanXBwAGNKsOTOJj8dTKzv0xeKEfgfzFF/tMUUMIBdSVB/4zdTlS43?=
 =?us-ascii?Q?z9Rna8S9QEbXBRP9FnXAZqTImFEwX6PR4vNGebhK3sy2isPIkn7FQHcXsTfP?=
 =?us-ascii?Q?eUUS4cWMOuyzBsgOBLJBwI9hm36nRqCMKChpUwgfHPK/koddOdM9puZo4n9A?=
 =?us-ascii?Q?bANaLI9Wcb++StrIiWQ/MkuqMD5yPGXK64XgQDvQxwq3tUUNSB/nlIx36JXr?=
 =?us-ascii?Q?+XDzJ4LqVFStwEj/j7thVbEjH84oaSCqPRi+0CkD12+jotVr9EoQBjgINESA?=
 =?us-ascii?Q?Pa55LMDN9VFTC4td8h7LJuTNQPhkabJKezrOeZ/Lt0UwNLa+hYr0x8CX1znF?=
 =?us-ascii?Q?XK308jIYbOpLl/rxqtO6ay0gjTuYW3sDPThqzkUuvFPtlivketZIYXlQtkJ1?=
 =?us-ascii?Q?eyTmvi/Bqi3y49YZAn7O3MDdJt0BkogxZ7o6sTiyyU2ltkqAqsHU0+sxpDUO?=
 =?us-ascii?Q?Fh8uZL2VtjaNTb5RtFxf91Lod22hncYmFbNcU6b/HoXj3O6E32J+qyy2G64x?=
 =?us-ascii?Q?8W2tDq2zw9RIucKBspKgqO3WRjJ3TJHxpUKBn9+O/g4G/wYnW5Nx8TJZwc4k?=
 =?us-ascii?Q?TXug8+jEctc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9XAa1jQvMACy31ByEgIVl37OAwaybbDD0C+H4W1zDa/qCGIdVOLQlhwwXv86?=
 =?us-ascii?Q?E0lhTJ1A4qbkhtpnsOsmX8UGT9duouZyX3zyPOj//TjG2/qIxZb1fEJAQnuu?=
 =?us-ascii?Q?+fNmnU9pCICs0CLl5kNYFwTQ0APMBpBJkvKlG+a5hsUJ2apz1/4XKzWpI+zp?=
 =?us-ascii?Q?ibf5byTZuEdvunf9eWbIz0dsjetFnxA1L6uVKdZn8xOyU0PXiKyYCY5yVHIh?=
 =?us-ascii?Q?mW5KSXCDSGHSbIjJctVyHxWlT6R49WEhWbs2gSIpofl4lJLXyS4i2EZ7tFCX?=
 =?us-ascii?Q?MmSTfiLhiMMHu5rfnRs7jK9FNYNxeSj2lqI2dSrlXV5x4W1A8A5RajL+8Y9N?=
 =?us-ascii?Q?dSNOwRD2PX1snCPmuvj87sJtFuXe1Jh3rDzXEBJgd5yKQRqO3Ks02R/yia4m?=
 =?us-ascii?Q?ywKgN/HRMowewkA9cb+f37ftwAmgzmI64Aub3349njj98Xu6piPvtkcUIoCb?=
 =?us-ascii?Q?qV1lvTScxOc0ks456mPmBnBm+I9TgAOmLWijocnHmmlKqT+yqI81pj2hLyci?=
 =?us-ascii?Q?jyXZRFPnj8pAGvpI9VCx09PFT0JPa00VgvY/zfrUJsz3+VP+4t1gZE/wMl3+?=
 =?us-ascii?Q?WHRhJ7ys4oC5DgMGP3rnAdgdNRwyIMYeb6CE784FA1chRTh3ZJMjaH7MlEyX?=
 =?us-ascii?Q?ANpC4k2qKxU55pSkPNjMt532rKEnKG6ua0ASYGZr82yiChGL8H2ScvxBJZYO?=
 =?us-ascii?Q?GJp+Eetf7lBjewh8fDREQhnOi9E5M0VkVS0AJNUKHJNCU42b8Qpwhmup8720?=
 =?us-ascii?Q?a8g0fmyPV+acS+0luAOeZQBLPTXs5O9MMb/xKZoqnsGteLsJtNKyv3FC1ai0?=
 =?us-ascii?Q?M9Wvkv5idj8TnyqnlOzqD58W/d6LP47FfgMiFNVWrUAZtAnkdKNlO3z9HDjF?=
 =?us-ascii?Q?ptYbmuzWXN16Fnn9teD1cbbakCtDE43EkjFlFrstf/Y3cYFmdZJL5RK8NGcL?=
 =?us-ascii?Q?d27N1sI5UcbRzs7LB1NJLBNmKPhLvdDVwnkHlMvKPDo7Mduolb4dJyeERAsr?=
 =?us-ascii?Q?3ZO6l3POl3jCswdXEfpC+fHR+PPx3H8odaf9aHz8xsHBOoIbi18ickbJEp8Q?=
 =?us-ascii?Q?VpjD0d8zhFvIFD5Agc0uraC6XOCerdpW07RovxMbpP4V4k6QM9zCaUmvkt4C?=
 =?us-ascii?Q?UvFZamLYJO2oxxcP3G7WqOVYDU5XiwWbCtJOB9dFJ8459MsJgHqAh3Oz6h3y?=
 =?us-ascii?Q?Tf5MaeGSGftx5YSNBDD3X1EG9Z+D5LqfDo6WhAy29ZR9mrBCV+GzfplXJ8zb?=
 =?us-ascii?Q?cgliZ9Z6zKE2952N2kl7kR7HluzpenRQd0NJdy1gRMcbWFgq2oVLuC5SPc7M?=
 =?us-ascii?Q?1UtusfwX1O0OLo5PwLAHyIMpLc6A96tjR6eQZ5DCKZa/xpTqHLHFlA5zv+hI?=
 =?us-ascii?Q?wqNu9ZLuYu6WDGTTdPL2ghd66HztkiAUYSQSDy8ccFIgPqVLrRgnPXJfG5kT?=
 =?us-ascii?Q?QecJJn5YwCSFk7vzw9e3Mfco/Gd0gJuMH5xcnL1jybJaA9E7jmev7FxSa9ab?=
 =?us-ascii?Q?ctmxBgMWsD6ySLeVl5jlbWlcDYpjxEDX25NyFQ8Vrj/ZbzswxNViliPeekdz?=
 =?us-ascii?Q?DWyz26T3UTx+LZkR2ERdZsFeqb0nqIx8RUl3l8o3/uchXVNUWDLLFkisFk8g?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b319cca2-abbc-4024-3a1c-08dd8e01d4bc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 07:27:47.4494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +fNHcyTn82oLzR5dFlDUA4DSOKYO+gEB//4XXUCpUYOJ2IoNRuOST3N1soOX+BBF+kuUWzeUnic+SDrtcEW3u4NaO4kTL2u3Njy1jbHYHAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6837
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

On Wed, May 07, 2025 at 04:22:10PM +0100, Anatoly Burakov wrote:
> Remove custom number parser and use C standard library instead. In order to
> keep compatibility with earlier versions of the parser, we have to take
> into account a few quirks:
> 
> - We do not consider "negative" numbers to be valid for anything other than
>   base-10 numbers, whereas C standard library does. We work around that by
>   forcing base-10 when parsing numbers we expect to be negative.

Is it likely to break much in the way of compatibility if we start allowing
negative non-base-10 numbers? If it simplifies our code to allow it, I'd
tend towards doing so unless there is a known case where it might cause
problems.

/Bruce

> - We do not consider numbers such as "+4" to be valid, whereas C standard
>   library does. No one probably relies on this, so we just remove it from
>   our tests, as it is now a valid number.
> - C standard library's strtoull does not do range checks on negative
>   numbers, so we have to parse knowingly-negative numbers as signed. We've
>   already changed this to be the case on account of point 1 from this list,
>   so no biggie.
> - C standard library does not support binary numbers, so we keep around the
>   relevant parts of the custom parser in place to support binary numbers.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---

<snip>
