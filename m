Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D674CCAC5B0
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 10:58:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C20AF40669;
	Mon, 29 Sep 2025 12:58:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 6A3304028C
 for <dev@dpdk.org>; Mon, 29 Sep 2025 12:58:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759143483; x=1790679483;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=LrmA16D6NOkNsPLh03ohN6IIxPGXmWjDNXldHFzP4gI=;
 b=F1bIdqBaJuMY1eixM5dmTOJXJDIJhKKSibFrWYDdyUDq/s/WCltlO+l7
 yvdfHsCSjeS/uM3lD7YfPm33J9mNLlmY3bhM2igpRbPqZYKa5bCaznsmB
 CC7lzD+LRDaKYB3+w2D4a6YEEaXdeu2Ya1l7+uMn/AyX6hWKuHHDn8R+w
 A0lZl4A/VVxCyRcCNDc5HpxqIrdtP/QUM1T7c3HkoBLSYGsSPa8XxBnbg
 Kcs3LuIJqj0kUQItt9+FdAIwgd5AQMQGNCB2j1hAtHEj56wTx2XG7o5/K
 HF5650utm02MurRl4uxyNU+IQXJYRQCB/GovOaEQ0cofB+sDbMqjmTcGP Q==;
X-CSE-ConnectionGUID: TCfR3Mw4QgaqyT/h8LtbEQ==
X-CSE-MsgGUID: mRDlvqHEQfiU3ElqZvNpQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61429827"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="61429827"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2025 03:58:01 -0700
X-CSE-ConnectionGUID: O9ylCbugTeqB61JQqrJUnw==
X-CSE-MsgGUID: cBWVliZUSBaRA95jzahHCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; d="scan'208";a="178025680"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2025 03:58:00 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 03:58:00 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 03:58:00 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.8) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 03:57:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HBdxbk92fCC6ZTDoYsX2ZK5prgi//2mLqvxV8cmdi2mQ2HhgveZIJg384TojW36eFNxfTgr4scbfOMxj8putdyliLXSLGWNLVlcO8xjPrRFf6mALBvyUE4g5tLZs8DEbtKddshL2H/Uogrv5TbHQgWMGNTIB/QhcTi2vjqagco8TiIjwm62JCkoZ4gnBc8kEgUVg4BnDYcn/lDtQuwqoco+UxtFsMvh28mCQt/lQMJ8i4RIGYyuavRjzj+wchfuPr2npnKnTTL4ZpJvin3QRFaZC7btjbft5q53WkBDG6szAxwbH6HLijgUDDgGCy/HlZ4zBb+/Qwzun9zCc0q3I4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2fNKtUvoUD8OHJhoiqVP6HKdh93SFLdatLRHfn7Et8=;
 b=Vw+VGq/8GDFVVN9TlUL+ChLvfZljyTqjgUqnwN40aw6/h5ZR8PyrQcIVcc18XaBX8os01ykAswC6ren8+K7WN0NYO0ZEEjEBH1DUgHOtzY1X8O+BzDiee4ga4NW2RirkyJvbnTmjKNhJA0E2tOJrRWWx7+3YV3j7x5rwq/y40Skn59BLR6Wjymn2WOk6bKR0BmJPE5PA6lU46dFhBndlScUrpj1NcaZdr7TsmpJYngz+j00XXy/JMFhIV0BYCggf5hDdP0Bt4CqrfTKQde3+n1t6h6duYrq5NEbAJGhZ1PR3ZBQzxw9bPiOkWwDC99xXmdnld/XYwzUmcDFB3Nawlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB6173.namprd11.prod.outlook.com (2603:10b6:8:9b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Mon, 29 Sep
 2025 10:57:57 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 10:57:57 +0000
Date: Mon, 29 Sep 2025 11:57:52 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 0/8] Fixes for ice and iavf docs
Message-ID: <aNpmMEnJdmkArKxj@bricha3-mobl1.ger.corp.intel.com>
References: <20250916142113.3485738-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250916142113.3485738-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DB8PR06CA0065.eurprd06.prod.outlook.com
 (2603:10a6:10:120::39) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB6173:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d2f396a-478d-4394-d045-08ddff470c38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5uxT7bgSydkVEQahRHDNRS0zSF+y2SrB11tEECHpTlwSPe1ADvDa1CxiJsbI?=
 =?us-ascii?Q?6Fa6JSRLe5PaMD4ntWngKb0Qggw4NOSb/xGi/twY5+EZWLqQ6S8dZJOXyZNF?=
 =?us-ascii?Q?X/kZgzaT2lKygd8cVBB50ViUZLFCFzt+Ry/OoEU9AwSMwR0AaP8x++pqmGJL?=
 =?us-ascii?Q?gDDpFV79RJV922T2bjsjBkwIDcSAkd570ud2xxZDGx4W6Y5chPuZwaeoiXFJ?=
 =?us-ascii?Q?p0u+IkbjWRzKqQXLfS51GDA5A5QblpVHUHVuX9MimcuaNXJYG9BFo9kMkedw?=
 =?us-ascii?Q?40VaYnfE0NsAbDN41NgTE3Jv8zZZakMxP0TovZleJeTas/yvqRq7azH/tmQr?=
 =?us-ascii?Q?3mjOAF+sauS7M8ko/KzKKLy3ulUejqgYRKX35z/AnV9zNTlTzn6hfahHjZJq?=
 =?us-ascii?Q?1DH71w+wJ71VMkt/IN3KpEIR0agY2FaOduiU6UxqhYtUj6N6v/x8MfP5dDKl?=
 =?us-ascii?Q?3UHzifQojprzeJ1KlGbe75lEUTJn2xnYyhvD+UHhCjYVdGUWuLQPLRbeHTrq?=
 =?us-ascii?Q?JLzwwyx91gWouLIi3lIX9PFDnzy5bw+8tOLjKJueBMz5t4qDhWVlnzxupBwy?=
 =?us-ascii?Q?N5IjR/8nbAPVsGQVXtzj0k6sg9/xfhfD1SinDIjAHur80ZfiGn9GRa6otFz3?=
 =?us-ascii?Q?LLtpq062rqs1SH9pZogn05/ju5+ugJyD+V6CPc2MpPevshy89ni8NA4hN3lV?=
 =?us-ascii?Q?Oluz5KQ4GLYszFvsHsN0feN+jqfjzlM4ZxBPk1s+j5JDgKcAESXicCGb/nLe?=
 =?us-ascii?Q?nhY46JUkDkbVdM/wwyO8xP4VG0hjanGlNQ5RTk2e1ZYt79THSxl4PeBy8jqp?=
 =?us-ascii?Q?amS1H5lnYNZwvKYUAjX4egYUW/29lZkq5C2C/6wmOdBlpAFBHzrEavwORemp?=
 =?us-ascii?Q?CwgkM94y68O7Bu8JTTQ62E0kjm5kHdDAA/t0+YOKmp8xTQMgb9oH8UhvFkHK?=
 =?us-ascii?Q?ALBuVTskPFh7iq9Nh+nPoD6saiqkqkVnEDMY2bCqUx8s/NX7JaQqPwS0evJs?=
 =?us-ascii?Q?EX66EKEnXq27lnJXMkK8bGmCW0ME4OSN/nD16Dwab1fEP23Muri81r8OHoZk?=
 =?us-ascii?Q?t5onxutDRlkUAfTEwOE8paywcBPJWKNjMYIKRCIVIPANIKTm7ShNu8QJH/cc?=
 =?us-ascii?Q?Z1GJkWfTbUPdLSS9dp6jbxQgCDfYtcfUmNjOMEZV+jLbhjerz0l8RT4ZkcHi?=
 =?us-ascii?Q?JVOHSF/dSxgZ/vqEpq+G+5vKs6jgpGStlKXG1ioosQlB2+m4wy/l24epR7VV?=
 =?us-ascii?Q?E1+b4wJT0Lc1CalGevbgCfQ8hqkQfABsVGrF9M5prXUsZC/7W1aP7aPjdS8n?=
 =?us-ascii?Q?XwWvUZtF8lwgG2FDye6JloA/MRQvUvKiuDzgFR7Xf138AQime7AkcdO/ttLi?=
 =?us-ascii?Q?r4/isRSrwQpauIy/khTKRuhJ6TMMpL6UY01z2mf0296uYaveYS0a6ucNocU4?=
 =?us-ascii?Q?2IOrF1mR8IR0G22LJqEIRGzrFeQEtNZ9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ygqDyd7JzE+nl/xZpkPCStUUS6CZK2Wvwho/NH7ikcgoZJgSPzSOaQYwa3px?=
 =?us-ascii?Q?og2oxQI2aOUmmodQAKD3B5CssXjX5PrBMmeAbmtWKmPNVBaVMcF6xaEm5YXe?=
 =?us-ascii?Q?Mi6uggs1otL+7UIrNfqraS7g1d12g2MKE5RqgaNp6/dN8iW9RlPlt1BgMhRp?=
 =?us-ascii?Q?sPr9qKuHO8S/KyrTMYIFrDKk6NWtQk/xKySroy2ryJ8GXnuB7bzpiNdTzMRK?=
 =?us-ascii?Q?l5w8y5mIJ8tK4ATSDqnZLhlhuX4r5LIU5gLcCgK9n/5FARwiuDD5U0nwpqfv?=
 =?us-ascii?Q?gxEdpjl0tsYRq/GFOu6ay3r8tRzL/FB+2bgjJHhoeWKnDIxalwzUHxqnawVq?=
 =?us-ascii?Q?XPkhYVDzCd/K9C5g/VsMZE56ax3R5RoFtBVOHnrvLL3t/pQlBYXBDrnGfIDM?=
 =?us-ascii?Q?T1vm30+XcNgqsE3vNQXQUGYyWNbxmPzyfGk/Io6SNY96QLX8I9kh2lDgV+6m?=
 =?us-ascii?Q?WnGyDTqgOdGEXeG2wzKlmtZiCQvU5jF9mCeRRR1NALkGe8PRHRqXf/S2/Epd?=
 =?us-ascii?Q?s76nyM/hSmdJCoFkyq41Cd3hXP6SFxiJTvjkBvcl98yvGTuLPeGKrMPf7GIm?=
 =?us-ascii?Q?tQIp/Miwsrpj854m588awQWOSRwkzzn2TtV8He5m1IL61MPr6gXYIpy2WIRk?=
 =?us-ascii?Q?iJRrjDmvF96l/6VL/z5I6jhhabcJ5gsBlqpmldd98m1HvDbmtMVAXdgAD953?=
 =?us-ascii?Q?DUDtQf8GoWB1OgPsR24imJkSEXOgfp5h/HmnXNUhkWA7HUHZkkTsPS50B2OG?=
 =?us-ascii?Q?/8VSB/i63d5HHoy7kyOL+N2dJ10NZ0MObHVHMkVQ1cBnGbdOv/n97V8AbVc5?=
 =?us-ascii?Q?hQ27GtLhLIy+usb2hqiJXXFfQ2VuzxzZCxHCvtbfmCjSdFCwpiITffw5x9Mg?=
 =?us-ascii?Q?8NUWKI/9yWiljp6bHcSZkaT+GARz/qvJTuS9Xj/cmCP/oHOlcW+iAws1yL8e?=
 =?us-ascii?Q?zdijVTxmKqAYGnAC7fGbnaZfiYnmzXDlCL9n0qdrOhUtzWK1DxthP38pS8pF?=
 =?us-ascii?Q?kJb1yDmchsj7HZkLfhVE76Kq42P2kduLEDlUQNAfhsLd3xry09kRT0Dhh0Yn?=
 =?us-ascii?Q?D1zvDAHK90VqswxE1Nrvi8LqmBqVqD+50/hm7fgcIsP5sJDb9NnLI6DP1p7L?=
 =?us-ascii?Q?ygFzVCywBYigQUFIqprISph8RzQn9ZBZFRoKY0D6725oLAtetAvVDfzrBy10?=
 =?us-ascii?Q?8fdv1vXdIsf9rTgjkUUNYvsdpoVij/X7TgPBXamycdtySBX1fwArdmRlMgUW?=
 =?us-ascii?Q?legERTgkdwS4WWSP00yxKJIAJazsjrVLXtLeidlIjFdiRJUaw9JvVn6dEZFp?=
 =?us-ascii?Q?7lqmZ0auiSzcBzLxOaZtHsgFOdslDRyPh+Jo5YbIYPIXHDbTjKiDeql3iiTM?=
 =?us-ascii?Q?r+WGERzHT6S6pWs9Ejf6wyug87k5YGDxj73e/mYJczmMJmEci22ooRTwsa9J?=
 =?us-ascii?Q?ngOybzv3Ryy/QtGG7qngBNPK8GPPhlAG0qjHWvE8oU3C9NxEG8X1MjN3WdaZ?=
 =?us-ascii?Q?CY9PgZ55fY9uXwPDdOfycVdjmKBea15dYQjN1X8KUdeUxqV5Bc+PdJaglJvQ?=
 =?us-ascii?Q?MXjQhcI4l+CXcRtLANePpF+AvGzyis3FVcFufOExAcODp/Q2GgS+WJAXItO6?=
 =?us-ascii?Q?eg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2f396a-478d-4394-d045-08ddff470c38
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 10:57:57.3876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2REgvLdIhFVgFIqnxVxs4MTcmxZ8KtAl2QdFzw9kXBY1mmLMeZnyn+nnBRnjc2Fivx7dGXBZ0Kqtg1hKRLJ1J4/fch/9EgD08QYJbz4S2iQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6173
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

On Tue, Sep 16, 2025 at 02:21:05PM +0000, Ciara Loftus wrote:
> This series is a collection of fixes to the documentation (specifically
> the ini files) for the ice and iavf drivers.
> 
> Ciara Loftus (8):
>   net/ice: document support for free Tx mbuf on demand
>   net/ice: fix documentation of support for TSO
>   net/iavf: fix documentation for speed capabilities
>   net/iavf: document support for fast mbuf free
>   net/iavf: document support for free Tx mbuf on demand
>   net/iavf: document support for burst mode info
>   net/iavf: fix documentation of support for TSO
>   net/iavf: document support for extended statistics
> 
>  doc/guides/nics/features/iavf.ini | 7 +++++--
>  doc/guides/nics/features/ice.ini  | 3 ++-
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> -- 

When reviewing these, I'm not convinced about using "P" (Partial) as a flag
to indicate features that don't work on vector drivers. Since the feature
is present in the driver and works - all be it with a perf hit, as happens
with many features, even those that don't change the actual Rx/Tx function
chosen - I think it should be marked as just "Y", and that using "P" is
confusing. Can we maybe investigate other options here, maybe a footnote or
asterisk on the entry that says: "May not be present in all Rx/Tx paths, for
example, may force driver to use scalar, rather than vector, code paths"

Since the rest of the changes are trivial, I've just applied the other
five patches, (1, 3, 5, 6, 8) to next-net-intel, rather than carry a whole
series through multiple versions.

Thanks,
/Bruce
