Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B119ACA600C
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 10:15:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7FE540274;
	Thu,  8 Oct 2026 12:15:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 6BC414026D
 for <dev@dpdk.org>; Thu,  8 Oct 2026 12:15:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791454556; x=1822990556;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=4TfWXo2bJQOLclGaznceEOTN/rTjvk+DNbhsvqjNPB0=;
 b=PIKnJ+G7FcWFZJkkzbCtnJGIFp37tdSJNbP5crHogy2V8VG2ZeDbs0YM
 o/65X9IRtqInnCqtHfuEV5hCU0F8ELpXnEeL+FhPl52vPBnF2fH3t7Qq6
 Rv5J1kEb12lNFkogMM3yvz8ZiS5P3iWVZDO4UMfSm29CY6ak7gw/tWmty
 HAijh3I7+mIhoIzUl1yL5MohJFKZAx3K4AldZql93kchaeo0ZacnpUt6t
 A7Kn3Yzcd99SDj4LQ979ClEBQfXeWvepepaUX/KM8/inU280dz3dmfsap
 F//8V/zI2XkKeA0MB19mNMLCfq0cU+Vg7ZU+hhC4d7lN9sX1nLnftCCFD Q==;
X-CSE-ConnectionGUID: oWNzVno1TVS9bIBsglM7cQ==
X-CSE-MsgGUID: XfXnAzS5R4eiK096O8WN6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="131683"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="131683"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 03:15:55 -0700
X-CSE-ConnectionGUID: Gy9ek0JcRL+ruKhglc+IDQ==
X-CSE-MsgGUID: fWXfQR9ERpeEHKh17Le7gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="1747602"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 03:15:55 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 03:15:55 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 03:15:55 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.51) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 03:15:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ab+GI0zXZ8lr5OH5EadUbeCv6IcmEJckrjouNYiLa08BW99f9gAYP7cpWFZWZtJ7mjFtLjn6TL18AMPBXbXUJpS8GQFLXN8Z3EYRWUlnM8hmNobs1ShBPWL61CLdOXgtTq6xSNl3qShUk2vPsq3nMdD6XoP2Vkq7VNoZ1EurUh8W5CVIYUwrHRiAuTF6QEEqT5Z+yQjnvVYHkCtf/B/3EGwl0NQ6wOJ1fOI/whXvgSY1gFWiaPUqjwIoLtFVsZlbtNc5Q8FK4+d4YRoxUkgnF2HvGRRdoHUsp5ppwEUiyqbIQLia4sPE7E0NF6ZC22YH5VfSan7hASQJlVU/zYmG7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLIftdNBu0H7cqHkev80agueOdTi7C9zWY8cxtFAWAo=;
 b=iU7A5RVPO4cZdGoG5axfIDMyXF1at1SzhDIfMWckg0CS5/34BNbFgg5M1U9DtGnkYrJ4dNySjwOOI2OYsYLhs11cFxLBS7SWXmMOG8w19ob2PBWNXBIF82t2j+MHCzqooOfmznp7soF2/a5cJCLfh2+H+q0KkvEQzYFbTltbba0cVvxpBV69iQtLcAiya3W0n2Wm07v3Vfb/NlyGBltCQ83MrP0JEOT9WJv001+HbtRyD/Bymwcm4h4u2EYG/Od7YzTwgtGiZmb+QZsamc/cEiJFTaltYgJut42pKVWuZRlmM96VkdUHdpDBpvVBFR+X/hBDTx1R9+oNQ4RuCOxg3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DM4PR11MB6336.namprd11.prod.outlook.com (2603:10b6:8:b9::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.15; Thu, 8 Oct 2026 10:15:33 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 10:15:33 +0000
Date: Thu, 8 Oct 2026 11:15:28 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Chengwen Feng <fengchengwen@huawei.com>
Subject: Re: [PATCH 15/20] argparse: promote API to stable
Message-ID: <asdtP8pIoLM2A8Ib@bricha3-mobl1.ger.corp.intel.com>
References: <20261007214115.3092715-1-stephen@networkplumber.org>
 <20261007214115.3092715-16-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261007214115.3092715-16-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0048.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::17) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DM4PR11MB6336:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b497560-50f6-4b0e-ce05-08df25251633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|6133799003|22082099003|18002099003|4143699003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Ljiox63p3d2774c1WDHTb/d6UGu2k/8ocN2AP3u19fRQnkKMUOLhF3N14/fPEGhHKBrgUE8frkhYR4XZ4N78uhJPmkEwp2//8oDs1yM8wAhWESWD3hg7D00+q57C4bW1/Lu8E9mTLZQsCzjGSPNyNEiToPw/F5mw3V6DA2cCCQSK6p1pfdsiD5ncCkEH3w7cOpG+1mymRLoCiaPOtLM7bhMleqFdynVFJ5BSunJTikjNMweDaTK+7wD7TLuseHGhQLLaQOISJMBOMJ5JbeArVC9LOfNkUQX1wOE0amgNxU0ttSTNTBVOekEcviWaNlWbEFQhsH9AcUG155gS933XS0anfywjlaMyrN/KIiiK7jJy+nNhAg7Y/kRbfW3GxSYozGGswVVGO/s+3aDzLZ7obgBC84S16AXZ6DjtCX03oKpX/F0rsoFjHlC5qNyFfEzuKYPArsfR2n4U/LP2KGBcfL7LwqRwA3qlZsl3ZKXQUHOq3tkBi+4zVUQDxvKytiVG8E861rVzSYUxKELBe9AFeOFz2GBUhbPwhSH3Csz4MxeRJ9N2PPGW0VXINFTEoy/oXlDEe0fjv7nXm51s6g73Vig+Ce0W+fEWqGFJt59JfgsYVTIiROZEwPDV1XkZIJoTy+IWHNjRUtiK5FnBuZ90pq8RliW0mQHUy82jE8FjNR0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(4143699003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MXz0uFuEFRx5+CyR/wJMXvKmfQAqy0YfuB+R8gWEvTnDzjjI93sVWekLDRST?=
 =?us-ascii?Q?TmvZtnQZmJ556rIHavYUibK4S3V6Xv7ajbOaGcTQHLwAIXQvJPc8uiivRI7F?=
 =?us-ascii?Q?ZRsAL/NR10YVHv3WJ/qgjU49kus1Nyglgt9oQO+qR5ntrggx1zwx0zVxbVF/?=
 =?us-ascii?Q?KSkBp4b4qUKqS9oPZN5qo7QUkmRzX6wH7et1/746PW7qyqfHuGgaQm+KGKxT?=
 =?us-ascii?Q?ew2Wfc1LjdsNQD3XqadUav1ZYEUiFzl+rOKqLsfoAL4eY28o0wxJSEYFO1Jd?=
 =?us-ascii?Q?Hp5scnG2J04oQxqGHDX39IKDNb39DEj6Xhw/7FA0UCxQQkPfytuV/mO86UCU?=
 =?us-ascii?Q?ykNLl45jLxrhoWbiZPqlqisVVKzLFi3PU/8CskZ6M3LmNIVON10Z5myrHIQU?=
 =?us-ascii?Q?Orhlo4KwDHGw/O8GnOhQQGXkBUqi1Utl4nggbP1Uz2UsW7G/v5FUYr8rZLGp?=
 =?us-ascii?Q?mTo4XWf4t9xvIWUs9GuqNHmIxaRuCSFB079bDa/DnntCGbeUg86fFy1FTCV4?=
 =?us-ascii?Q?Ik0t88S29uTBOpLLImbKZAW3dyWniP3cptLv7dgVE4/mjxiBfuKxhHMSBU9v?=
 =?us-ascii?Q?xZ2pmSoXJoWZf7qGXOMm9Nqgn8cw3hsAP9HD41bDn9RlZOCBe4I4JCKLyNIj?=
 =?us-ascii?Q?dxfOzWrTHleUVAv1MtchNmO+4pYtNfAaLCO8CrrOcH9KBMHpxhKiecuuufeo?=
 =?us-ascii?Q?R/Ia+vYi7kPtwRbR4IIwdvk/yZMhBOnS6Hhp+5IDXVV74x8O7CAujShTXWOw?=
 =?us-ascii?Q?glnvFQTy5ow97w9hWJBcKDsA1TboqU6e9K/vG371kFjZ4j7v+4zb214aXTmi?=
 =?us-ascii?Q?QX+hZnJL5V95mNbCrtfAYPsiLD/FWXlzPgGi88v56UqXqPXgZgGZkLR/YCJb?=
 =?us-ascii?Q?9wrToyy7+cQIj7gcPPshz5KHrsU3jx82jJYaueSO5/5y5NMNtpfu3mu9Plj9?=
 =?us-ascii?Q?CFMqfW8LM59m6tyONoFvyLKYAdEJFQgeT0MgdGtmq7j8KXo2B6Ax/E7Y3HJh?=
 =?us-ascii?Q?7jHapI55yb6IqZNIfb58mil1YA2OqPrv1UBO6qPJOMhQJkR6dnm0XmtW4irP?=
 =?us-ascii?Q?g7M20wYbmnp/eiU4e16iLMkDtTbowRHcgdCn6dIU2g64M7ILKSLjCK7jKUks?=
 =?us-ascii?Q?G+rzJBSl0zjNQQ00/3RQ/1WEkT6gkF4pK0Qv2DwpSJfdTjciSWnWXogbgOsm?=
 =?us-ascii?Q?F9xJcpLJssmV66dbmq10cb1hG3hegvnUSzrGg21KPwI18wECHdGYZXTdns5Z?=
 =?us-ascii?Q?rUa2UQx/vkEalvpJVnzJB//pj9EbBKhaITzDCN8eo9gC5R4Nc9DyBi2Ux10e?=
 =?us-ascii?Q?Oq2pXfoBnzgjUYnGEgyBOElKumshzARVw2D0QJ5Bjmtm/8FZrQjZhUcRrw0k?=
 =?us-ascii?Q?5XJlJKqi07Awof9368b/pIPvZAKGLHSEimmdedr1qkfLhqYeKg1Ov2sGrUIF?=
 =?us-ascii?Q?rj1b3MYGLlTUYUN7QSh1qtH/TZWHPJWkc5T4yzWEmIZfv6RPtcrqybDLswoh?=
 =?us-ascii?Q?MLVaJd+vQFQL/BCi2eb8RFimT7vEX7vaS3IhdKA5DcOr4Fle3dkBjAVno1fR?=
 =?us-ascii?Q?uS/N7OrbZ2QTfsDKN0Jf+CSdpujEevqcvz+Aa8lz+maxP0yjwblAhB9VukJL?=
 =?us-ascii?Q?appHUvm9AMkT3RlUJOn2XSDIr51hZUrBPNjTZJRScKURt0+s7TdIGbnIoHJg?=
 =?us-ascii?Q?s8V5D7rPCdhiIKj34jenNBm1IJ86+mcbzSLVxREL05dJvhuakBpr4hLTb64b?=
 =?us-ascii?Q?vY1cGrZxqbSPnLAB8uCArV5sG7uIE60=3D?=
X-Exchange-RoutingPolicyChecked: Gc2VmRub/Bo4g5n+JhMmQFx1C/6lAZueDRHymZR7mvTof82PO6Oczc3PnHIClWOy7BbAb0+EPQxLkXH2jPTHdX+QWvHQnkzHH4YLYbDTcyQSKuX7BkrK70eXenHuNrQBKaRXTjKjrffcySmeRVrPcS3usyZbW5g3Y7QmIvmTIT56u+etFunWdt+k00u23gjKbMuKel7AQGszqFMPj3ppi65fVxQPWWdOouBMMyw9AuHfs9YPP3c2bWoUzx0bjSUTWrwX11haJu0QeaPa3S0/aZzNk0Q+ODUuaOnnkXyYY+qFHXOzZ1aubOvDoSLblSCC2KmJKT/Kres8TLUfu+nwtQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b497560-50f6-4b0e-ce05-08df25251633
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 10:15:33.2423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I5iQ+SKR76Pmfg5A6zXxJ4PeNXIDHCETHTGYkVW5M8B8tqIa+GA0ytOy7ybvLQhRb0GEqcwnPGmZDz3IANJRDh6hyxh65wF8kZWDmc5p7wU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6336
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

On Wed, Oct 07, 2026 at 02:39:45PM -0700, Stephen Hemminger wrote:
> The rte_argparse_parse() and rte_argparse_parse_type() functions were
> added in 24.03 and rte_argparse_print_help() in 25.11. No prototype has
> changed and they are used by the EAL option parsing as well as several
> applications and examples, so the interface is settled.
> 
> This promotes the whole library, so the header no longer needs
> rte_compat.h.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  doc/guides/rel_notes/release_26_11.rst |  2 ++
>  lib/argparse/rte_argparse.c            |  6 +++---
>  lib/argparse/rte_argparse.h            | 13 -------------
>  3 files changed, 5 insertions(+), 16 deletions(-)
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
