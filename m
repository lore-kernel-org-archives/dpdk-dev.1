Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EACD2ECF7
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 14:21:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A718B40E32;
	Tue, 20 Jan 2026 15:21:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id F3E494013F
 for <dev@dpdk.org>; Tue, 20 Jan 2026 15:21:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768918890; x=1800454890;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=/CXK92QSgrL3BKeoW9hvSGe6g9Nje7cenF23woAahJI=;
 b=fo9Sn6GL5Mb5GFv8D/1xUm/QIacTQn7+m9N7QvddZOfQM8yettshk8rV
 UlM8fbofJhdlfVFSSRAuVvETXrYV6pDKo/LFMypuDRNZ8FkJp6hKg0AmE
 CleJgMN7uvj6xbhbR2up5Z8ZRajrYQ2XYg0a/RoajKkxehyx8zS7KW0zz
 XWWb3kM/frvRWsGc9QBatDiORfyn65R1TFQPpibI8gOQfr0rQ6FLoEXLF
 8Te4byhCVR/c/G1RN7ja7oUS9ZGJO+NucPQK/gUk4IMgc3XmKCll+KmxC
 8xRY2hleCIj6K6E14bfwFAj9JXw/EAV6YtogwzP8MOmd2FKTTS4+yMoMp w==;
X-CSE-ConnectionGUID: f9DqSDztSECGbB6LDkR+wQ==
X-CSE-MsgGUID: ugkOBzkIQheRCIVA24X0Xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="73996879"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; d="scan'208";a="73996879"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2026 06:21:29 -0800
X-CSE-ConnectionGUID: juF+iAxkS/WegnilrcJdxQ==
X-CSE-MsgGUID: 9EBZTQ4cRF2qCgSpKvHv/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; d="scan'208";a="206554002"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2026 06:21:29 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 06:21:28 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 20 Jan 2026 06:21:28 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.40) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 06:21:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNjmtnt9cbQVQCMiQJD/ZKebXww+mrBJO7ULoZbQhIt73XkIi3PdSoXZjstZMH+xDCFQWaRQn5Em/OOwL/8SLrWOQt+S+n/fsTWwrj53zDeIStOyaZFVEh8Hwb8vr4+qkMGlnflPOL+r3nNkHHQ8XOcTivDP5CZocLHBRYJ0XljJ8koTcdYmDf0UiXoXEgVfB6rFAtqXE4Z7EhaU/0glcM4rSjJxZeIl5Llfwx9D5j9XX0U12hfUfpizDL9xaBIkhCw1NhXJkmbLBzWqYZ8QnEwSDyl8+Foi0U1GLlAApVdgHM3Nh5RG/WkU1sRFMsCKh/Bp7XiZajQXWBBLIniLrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDYL+sTE0FImPFcQDxK6AbF166IOdqNERHdkdIMkPnA=;
 b=SaghTg+5uHqR3dbwGbnsWPyrcOx43ka/xpbHBNxPHxWQkl6KmzfMo8jKCwrCvVMJO8Ncb+P3oVCx9AQw2h+iv7jpoEm7KySLDS8m04khH9cz0GxYZ2nxtBu8g8SpFsWZOqmlMlCKjUJS9VJIR3cGZ8bar9oqsqzT0y5ua3JnrbijEvf3PqiavxeYHPypjVegKWhhfUbrZRhbQ7kEOpAvzypt9SSv4iD8Fhri8pPRfrvjKF6L/lFRZAPJyb5nXAqTXJFWy+BdTNfbl392JkeuVHY4xHTgBfts9QsJclSOlvekN/dF4Le0lKQNPvw074oxISmXsPufLzrrOLyzA9Mu9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB5032.namprd11.prod.outlook.com (2603:10b6:510:3a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 14:21:26 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 14:21:26 +0000
Date: Tue, 20 Jan 2026 14:21:21 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4] doc: add AGENTS.md for AI-powered code review tools
Message-ID: <aW-PYSNzhfKiEY7D@bricha3-mobl1.ger.corp.intel.com>
References: <20260109014106.398156-1-stephen@networkplumber.org>
 <20260116174741.15502-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260116174741.15502-1-stephen@networkplumber.org>
X-ClientProxiedBy: DU2PR04CA0288.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::23) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB5032:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b53b301-d522-461a-b86e-08de582f31fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uIn+jT4KJNgifjYMz7U6ZDESm4uwypbviDAzEVVHfOS+/HbpWmHgi2OB065n?=
 =?us-ascii?Q?emCem4B2Gj4jtuibyVa4agCcYyK8WXbZKYFIHExIgNonZzu6QZUt2GvGq84G?=
 =?us-ascii?Q?i7EEDurdKtk51IzfowaABre+xmkTyYFV0xOrN3vrOkOP0QppQIt6V7VYXW37?=
 =?us-ascii?Q?1XJeoQHCQTteuXXBDxGULXUhee2zpllMt5Rn00jMwokg8sG/hKgAZ53F31JT?=
 =?us-ascii?Q?7RasBktiSEpBg6oJJkQXZILrb2Z4E6mpN7E+qWZZUA1G3AawGMAUQZvaaHrP?=
 =?us-ascii?Q?M4t8x1I9ygD8IY+89LbKHn0eZjrCchCn7K+R/vC/wdisgydcZvJseGdfsSV+?=
 =?us-ascii?Q?vPlWHT2emSYf/MjVbN2bgB2RlrVy/sETV7CoePhlQIEznNdw/vQcfMHgtB3O?=
 =?us-ascii?Q?TD2nUAF39YZQFHGdNg0Iqy9XhD//nhz94ivSusXSnZQf3qqscD4jDPy9lPpf?=
 =?us-ascii?Q?82YWGtDrupkSRWKGeJJPhasSisuBXX6kdzNtuY2R5LI6odlm7CGIu5wPdnDE?=
 =?us-ascii?Q?15ulRL/pFcIBqwVusLq2eROsH2ZKLTXUGC1dNDLONJQDZP16Jp7PMxE+Z6ix?=
 =?us-ascii?Q?cc9p4piL1h4aqELI7ELxDOJOddim6ae0wTgY2701DRCJJuG13aXgb1yibJgk?=
 =?us-ascii?Q?m/7+WlGfzUIUJ39dowZDNgtsLN05dwkBSCCUg+p+sqfJogrrZBDdtLljl7c7?=
 =?us-ascii?Q?0KeOBgHU+Yrg08vjF43ZNoqzF47GhE72LLhvT+Fl/6SHNJkCZxes6eh1MDP6?=
 =?us-ascii?Q?bcdrD9A6rRSrP4ulwByk4qOVC2FJh6I6U3WfBGiR9my0WJ6inrsnssiJm0dS?=
 =?us-ascii?Q?vFsQLQpd6RPqm5IyQxSAjTqL1mzlN30//X1/W2W+R2HYO0mkW2LauTaNr2ru?=
 =?us-ascii?Q?zknNhqPr3fGh7elJG4rqZkk0IdlK2c56wlsc8h3yQXCFQPY/9JBDNfD5Sl9K?=
 =?us-ascii?Q?k2XlxW4zOGGtFCigxf7NsvVzOfPEYa0FyXatcM5P7ryXfU2stgWp9lx7yVpp?=
 =?us-ascii?Q?Fso1jhzotJNzmw9DrE44+AIdhzNmHkDYyhrTc6DhLAo9NKx/FbmOXVFwFDk3?=
 =?us-ascii?Q?LmRe6PNAYRWHVdfHsuqEu5lrmbMDNwVXrlTjBD4X23gh+CHzRUFkvRJufJ1E?=
 =?us-ascii?Q?qIF70aSDypT970Tgjd5mxNKHaou2/B+sGp4zHLdEOFBGubNEjWJPh//crcrU?=
 =?us-ascii?Q?UOV9TSbqNxjd8V7+5Mgg7foaun09VBHpY9iiMaDl/Benln/mRK70w6/xsEHO?=
 =?us-ascii?Q?ywZV8nxrn7dH634UI25BJ5YV4KYOEqTg2bM7F/qRx2R6VJS/rwZd4jrwBL71?=
 =?us-ascii?Q?bilkgJXyb4FN7ftVOBa+ycIknjskeFQIpCoWDMizs/Wyp3CUT2TjUQlSdU0r?=
 =?us-ascii?Q?a8CYxrtW72OusLVh/OkSy4Hrg3QG7noRHFEktjksm+sa6YDdHfsveCMWCE0B?=
 =?us-ascii?Q?ebyF3KkwHQIB20HWUZpqe1Iu8NfYoD3+q2Igy7GpwCh/r03BMO0Yyj0hRVmW?=
 =?us-ascii?Q?M5mzA5WXIjoZ+cvaaTqrQGynlUEMGj/UW0GuJ13Lg02NMKQRTJSVsHX8sS0J?=
 =?us-ascii?Q?f6YXz0KOjbm7oOillNzNxW+U2iMWNqTayPjtQK2I?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N6mOnaKUNUL3iQTEMoSBqFDLKKeE8LEmmL7HPrssb4YFPIg9RxQGWklYM3bw?=
 =?us-ascii?Q?3xmccNggDs9av8AhwXo8BF5mPg884LNEStK3Y3yEll0itymuipy4K2VniSLz?=
 =?us-ascii?Q?wNTpgCp2ax1WZojxjLxZyQOCjEz1Zh22v6Uz23VWL1m4eDRUJ8Z9Ih5d6Bea?=
 =?us-ascii?Q?NEE5jraXs96vdxNkKjGsMSWivrdMufBZT8rHyoMC5VTyJDfwva77+NryhvLb?=
 =?us-ascii?Q?U08MtGYuabpujrR+A7/RYcXAIoBkrwruFKF+uCIBI/V2/56kwltkuy3gTqbC?=
 =?us-ascii?Q?Yw5UxP7B6PGtHVUBFUxT40X2d0mwsahWeTNEsMlDVSDlfIVZWiTjBTE5/24Y?=
 =?us-ascii?Q?0I/4ymARbfrSHsnNGQNnJer/1UIdts8764KjAeVGtb5iJuHQ5VT3psSPr4ae?=
 =?us-ascii?Q?nsQ5gFXE6pePbNtailZ2PCSPIyqBQDuJOROmbJOeplKXVYK4dwaCoVDX4CZv?=
 =?us-ascii?Q?t0DDPJtrNLBuV3Cj+aMvgYPaX0hbgIx/NaXYDIcjIDGsX0NNPufpT9AYC23p?=
 =?us-ascii?Q?t4rf7m23SKTInryBkNrYV3vqO9rDFVd8REsZLFeOy9oz9qcKn/rC2289qQsH?=
 =?us-ascii?Q?oqf/ml4haoRh+ihkfArqZkvdX5CvW50E4S54jztezKojnl5vP6sArT1jluNf?=
 =?us-ascii?Q?9DYMMd7fqgGYAggh9ytEX4EErdpY7ihLva9L9U6NjiQSw1+aryHHq+bTQEWb?=
 =?us-ascii?Q?ZEUZKeUXG5XwsKwIUt+whrg074FyuX099c747rgrGOZx4E8IjSeCBsF8hQlZ?=
 =?us-ascii?Q?0a/mlgC96Y69bVSDYGfrlVxuwv4l0bmPDH3zioI0twAIlJGVnUnXrt0kiTbc?=
 =?us-ascii?Q?Ug/qARwBNUWeD6g064eQ+tMsSEiWr8lcU5t2tqqxpNxRIcc88hV34m2dW1Wf?=
 =?us-ascii?Q?q76mQLXXtgXYvJo+U3Xy3TLjf04FvRV/tCU3DE1hB4i71CmH5Brdab+7tb4t?=
 =?us-ascii?Q?mJzGh2hAX6hfTmXkq0u45cXhID3K7iSfgOSpm/eaMy6yDdj259s7soqPpgqh?=
 =?us-ascii?Q?ZVxrCvOUEBIiqQJl17WYk+99Eg3rpuE8xSu79BQx5/Q8z/JjUnXA8/RJpi1A?=
 =?us-ascii?Q?ZkNT6f8rTUeXwLFryvK22CNtKWIXIzPslTU5f77wZO1sLK/RardOcr6FVa/f?=
 =?us-ascii?Q?cItwvmY6rfyp4duZwMKkfqDn+EBcVICTyBvKsR82fV9sJhkVpKYk1ZLnAq+F?=
 =?us-ascii?Q?oXRTWWmu49ojOKNZ9iGnicyh4F2MZYvoHu9gA4BhuprSpnIk5yMmYVJdI2X7?=
 =?us-ascii?Q?Dr4CGzbS0WE0WT9I0qL2riwzIO/7o9kpBOkvCR0lbsA9VyzVZkPHvxJUtwRx?=
 =?us-ascii?Q?Lnqo0Vm3Sp24bstKb75ymgXXWmDsciVvWr7+KzPZZYxkr2c3yMYWee7G8C0R?=
 =?us-ascii?Q?p1yZKpDY5FbTgeZ0eY0hF1Xc3MwiUrAfR17xXuB1JL/yauL5HllXSGqTl/TE?=
 =?us-ascii?Q?dlZmzak8Hc8yMFhYtc7sC5H0U9EyaM41YCqpmwszwXr+vhOop5gXkGggfrHY?=
 =?us-ascii?Q?sYks7LoeHQcefUrpDg/HcLqa8oapsT2mdctpf85/AUExGx7kGh4etOcP+blg?=
 =?us-ascii?Q?4+vQNth6Zct8sljnXwMfv47VMKDAupyfCKV/Lkaf4ZRfY+iuqx8RcTrVa6fT?=
 =?us-ascii?Q?QdbDuqqJCpBqkrE0poUI75pAD0PmGHKrOF8XR717uFFhF639NySPZK+oGZHS?=
 =?us-ascii?Q?XMKJeTW3jxjxxtHtNrrRh3kn/O7Eomkp7va3OjfhQ4/bPZJhYs25ofGq9+2f?=
 =?us-ascii?Q?M/wdv4L1a8LWHnKRxZ0hZAsa1VPirnI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b53b301-d522-461a-b86e-08de582f31fc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 14:21:26.0940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ok/aer/fI6AmyvVBViAzXkgWhGvIPG7/sVQhOFyla4lIBlIrayDElVMSUcASiI4Gpm2DLOW0WKJctQqMTOy/BWLmcCqabl0x6SgcL9Rh2dw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5032
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

On Fri, Jan 16, 2026 at 09:46:41AM -0800, Stephen Hemminger wrote:
> Add a structured reference document that enables AI code review tools
> to validate DPDK contributions against project standards. This document
> consolidates requirements from multiple sources into a machine-readable
> format optimized for automated validation workflows.
> 
> The AGENTS.md file synthesizes guidelines from:
> - DPDK Contributing Code documentation (patches.rst)
> - DPDK Coding Style guidelines (coding_style.rst)
> - DPDK validation scripts (check-git-log.sh, checkpatches.sh)
> - Linux kernel patch submission process
> - SPDX License Identifier specification
> - DPDK Coccinelle scripts (cocci)
> - common items spotted on mailing list review
> 
> Key sections include:
> - SPDX license and copyright header requirements
> - Commit message format with precise limits (60 char subject,
>   75 char body) and tag ordering rules
> - C coding style including explicit comparison requirements
> - Forbidden tokens table derived from checkpatches.sh
> - API tag placement rules for experimental and internal APIs
> - Patch validation checklists with severity levels
> 
> The forbidden tokens section documents restrictions on deprecated
> atomics, logging functions, threading APIs, and compiler built-ins
> that are checked by the existing checkpatches.sh infrastructure.
> 
> Severity levels (error/warning/info) align with the exit codes and
> messaging from check-git-log.sh and checkpatches.sh to help automated
> tools prioritize feedback appropriately.
> 
> References:
> - https://doc.dpdk.org/guides/contributing/patches.html
> - https://doc.dpdk.org/guides/contributing/coding_style.html
> - devtools/check-git-log.sh
> - devtools/checkpatches.sh
> - devtools/cocci/
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
> 
> v4 - revise based on use in reviewing patchs
>      get rid of false positives from variable declarations
>      add checks for rte_malloc and rte_memcpy
> 
> 
>  devtools/AGENTS.md | 939 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 939 insertions(+)
>  create mode 100644 devtools/AGENTS.md
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Even if not perfect, like to see this in main repo, to make it easier for
all to have AI review of patches - especially maintainers merging to
subtrees! :-)
