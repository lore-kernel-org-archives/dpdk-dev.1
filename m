Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C9BC19776
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Feb 2025 14:31:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F09D40609;
	Fri, 28 Feb 2025 15:31:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id E733A402DD
 for <dev@dpdk.org>; Fri, 28 Feb 2025 15:31:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740753068; x=1772289068;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=8++MLrOsmbxGbuli91bXEjwKLzS0IVOXvl6RN75LNeg=;
 b=Wq/DoGXZW1ePWLnRiA+XsG2FmtJRAHMQ4KBhbhHpe/YahGGbtJfI3jdr
 CQQbAqzrc+mTN2BBHDUJZZsW4eJssbaCYwDjrZIGLZ3xNl8fQHx9qIaHh
 M5qGxK0qbZdBwPoOUclGH5+b6CGBy6VpqS+lwsobqbEbD2YgOxZaR72Ds
 /nMq1XBM+plJLQkPB5SgvS5Ht2Oa9jLb2rA0jm8vZ0bhLpVuuuWKHFvAP
 Yn3QV0jFtGO6pnvQsDdeESgrW8T0lBsKSP73gKhsSGRqXfJivnum/qhbx
 md8HexFKach6wTHsQaxNjAGtcggExceijAkcO1ZyXKi13ftjTAE5QNN/Z w==;
X-CSE-ConnectionGUID: Diy/E0rpSJS7pVf7RzND8Q==
X-CSE-MsgGUID: ksbPDFyTQ26GJtDXAz1QLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="45333723"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; d="scan'208";a="45333723"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2025 06:31:05 -0800
X-CSE-ConnectionGUID: 1Z9indXtSa2S33aM9YQitA==
X-CSE-MsgGUID: Hv+qu6cyTA+XYVAoP6irRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="122587571"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2025 06:31:06 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 28 Feb 2025 06:31:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Feb 2025 06:31:04 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Feb 2025 06:31:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hnyGg61KvnoBJz6rkN5hmvLW3W/u2iFU4eKq87Mkgjd1HoaTsOwlqDW8izk9PMBKfhnyam/213UawV1lWHGVuUNG0CdqgZM2EHkHJ86tF2HUbsmJnpv0HXEMk/z9b1T7HNi2NVaw3MfNFwUbldZilddCNNPzk9ZXzfPNtQYi4VyzQg4g57VfF9z4bBvToWjXDJC4h7eYfeMdSbZAqT8suIBT1B5VnYfqxqCdXDK9Xw9zdGJKi3tuOSkFynmedQzaf0tSufZLZfRYQAc9HR5sOyVm0dnKcmH7LwXq8U8ErwwBsZ73Uiqx9raDjxgUOEGETs6q68Y4BmJY1dJJEdBEnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3ajLwgTG5PbuHf25rH63kR6hqbzRN58tDYrp4KnGhs=;
 b=oAqrfBV6Pgw9LxzpqazaYjehme2HikzMSL0N5tUu9IvWMDFjjn1/VYv5MwRcFuATFf0NeJpWdxQ8uKW/JpUZpAodupTHZ1sp8lOW4rw4B8ZD+zSJPCSLAc/3C9QuI7kTLsfJsV5ZW715HCTWX5sJZtA+SrFDCsITkpRcUuhp/r5In2YCjcI8D5Vey7wiiNeAvQEXbkA76HYhP56VoZzAwf+37+/zNPK48p6HiRnoBSrjrDJAFRt7oyT5/84LtH4ZY8gVxphWPVvR+WrX8zTzfhC1x++RDKDbAiJiTG/ESqNjJLTPhG4Csda3w05rebtgSl4vUK/aDEwb35xjXVrhrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BY1PR11MB8031.namprd11.prod.outlook.com (2603:10b6:a03:529::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 14:30:59 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8489.019; Fri, 28 Feb 2025
 14:30:59 +0000
Date: Fri, 28 Feb 2025 14:30:54 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, Yipeng Wang
 <yipeng1.wang@intel.com>, Sameh Gobriel <sameh.gobriel@intel.com>,
 <dev@dpdk.org>
Subject: Re: [PATCH 1/2] config: allow AVX512 instructions to be used with MSVC
Message-ID: <Z8HIngY9yOjI3tTQ@bricha3-mobl1.ger.corp.intel.com>
References: <1740707537-10517-1-git-send-email-andremue@linux.microsoft.com>
 <1740707537-10517-2-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1740707537-10517-2-git-send-email-andremue@linux.microsoft.com>
X-ClientProxiedBy: DU7P251CA0008.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BY1PR11MB8031:EE_
X-MS-Office365-Filtering-Correlation-Id: fbffed4d-0e50-44df-e1d7-08dd580484d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pkkaW+wQo+M4j4h9i7LJLLntVnR30gD2csMC2zmuqNEOBreUEhd2GQCG/4Vz?=
 =?us-ascii?Q?zMKlo68+bNfdZ5VVOjfZyZNu3IrzG53smgVg2jK7MrcPudaSnPir64UF190c?=
 =?us-ascii?Q?JdHGlv0kImNM5VXy5/ZLBbg/Qvt8O5n+oXd73kCQ9E3a+x0dC+Dlx21CncA8?=
 =?us-ascii?Q?REndAAGiw+uAHIEVC3EhvMhMSK6vxG0tEcejKMp1YASztKFBxxstVQM+n4CT?=
 =?us-ascii?Q?GLEXwQ1M6naJRy092fjwYhbN4a2H48+XzlDWXcM8UC1ufRausjzQrw27nPHi?=
 =?us-ascii?Q?I3+zUcWbAmUk1vRHb5B71gU7YMSMXTz5UcVZuCpC+1xudo6+7QvSKh1hI4OM?=
 =?us-ascii?Q?gBxHFlAA13crllgWOLf9SRX9MVUH/7EpT1wlC56XR4vgE5UlFpKLw/Xam9pM?=
 =?us-ascii?Q?gaxAugzr+swOFwgGVno8ZlrqPGiupm9wn7zHP5o/Jb3XjvZfaxM7bi9F303U?=
 =?us-ascii?Q?I8uSccHrTdrfvJSWT/f1DHpaBrs4C8vC1hn/zzbOZAEl2Yjv/HKrlfu//oRo?=
 =?us-ascii?Q?kxQr8qOzUJZAw3bfLEREwzawfHBPyKzopX2lsj2Ce1uATGSGTJaLqsODGvUe?=
 =?us-ascii?Q?ZM/FY4e1Mtj8GMLkn3f7pal4LZk7npYgF/fXpCu7J3YRJ7UiexanaLqF/Cq9?=
 =?us-ascii?Q?nCSd38hTC+t6gKTmptWm4qr4gBrM5kCTJG6x/gMJRR728q1zIQuhiKYuGkb8?=
 =?us-ascii?Q?5S/ASSqQm70etPDCrpr0e9zA8SJlBGCZXImTyvtKb5TfOM//D5Wh7qgBkSpP?=
 =?us-ascii?Q?MZI2/7RULDn0YdRDeMPH9VATvVtaofQ5syluyzC50YL9BhrZ4lRoeP3D/ssX?=
 =?us-ascii?Q?PP9VTzEXbDdqAWgqXFGp1dWuTvCvwBBYRrBgHpihg8TkAgWAjMHeDZjPNslC?=
 =?us-ascii?Q?paRBMD2MvziETprBVrPe8uK/GQEtLcajeU1ZaE4Wq8oPGemTmJiTBaFzcuOC?=
 =?us-ascii?Q?qRoWB9/ZvLHjbxse+Vf9Y48OoMGrq+Zm9oLb00I9YnwyillnqAegdFhkKu4p?=
 =?us-ascii?Q?2g/tOQaRPlsmggXoro1rbzBEnaYxJ3be1crjt2LJGuN21L0bDwYmvPiLXfyA?=
 =?us-ascii?Q?q2DCTcRWppV0W9yIfgUGCofIDSb2QGHk4i39vHmbut4qc9empZhZmH6aqe1m?=
 =?us-ascii?Q?BNL44rQuXFnYhqTr/YC+f/oieFJB3vbo/eSW5dQEg3YO/486DQmJ6qFs4Hrg?=
 =?us-ascii?Q?BM9gToYpCjfG0vQ9p7Pnopm+FfW+JgsCtPpaxjb64F1xoapYMmuijpfZ+Ovt?=
 =?us-ascii?Q?bE6hV5lDZhQv5CuiQeLRD6gzzJqDkjJmtuvXluQwTBpAwPjpOA6sBad2xW0J?=
 =?us-ascii?Q?pmOgJZHOcjF1+lqhTJwLeEIdrrhFot1NWnCMSv7uT0smObprEk0AG22Ybq8j?=
 =?us-ascii?Q?3ajk7bdvGbZTaN6UAaFEeOUzle/afW4GYVH70a3Jmg5AtgUnpw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(13003099007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H0feHOCh0HawXee4emXAzMTzD+XJkGUjiJueFXSNOIyAIliz84x/+gPjNZhl?=
 =?us-ascii?Q?ETEo+UZVDHVr8utfxeQa/eHQUqc5/bvk1yqfkMQiJIBmovoklTon+gKInrig?=
 =?us-ascii?Q?OqnKi4FatPUpucuIEHDLBmfaJLphcDyJwGWp9u99+LPsbjtMg/iBqFsVNyTU?=
 =?us-ascii?Q?U+mbGnN8cMeXYebRMLsPxrOLqfLtPeLUS1tjtnM7kKCbtLGdF6FYMp3TP8gN?=
 =?us-ascii?Q?bD8I+OpHW1QZh/gj+v0APnJPdJPk85hFaMNgiSqZIqNF0k9Z25W8jsjSwMHx?=
 =?us-ascii?Q?YXUDvWN50Q999Czb1Mmf6IXklKxq9369ujroQS0gKGzu1kFdQj6SLUvEbDS4?=
 =?us-ascii?Q?AZvevhV9RM27BG1pqlK4xy7qNU6psMx+PClRrb4j4eZBN3/4ZXpUHDcFZgrt?=
 =?us-ascii?Q?jF/+1SeNFDl7OagICoCvmewFbSRiGS6z49ufnqjwIBPOWtVNr8JNde73U0lB?=
 =?us-ascii?Q?r4ciL6XdzcVlaYyzOhEuBJxedA6vMlEfvdK1yOtbFBTfBvTNCW6pD8BPD4n7?=
 =?us-ascii?Q?/KmD+zUbh6y+5cnRjayArDEOK7GBF3sug5CzuUvbqWFfmXbmS59BJq5z0Rxm?=
 =?us-ascii?Q?SK1ImIMxUGfMBPlz1dGgWo8DvX6z5eknTQwUnl0byH7ZSBiKlvw+S5CjdzXe?=
 =?us-ascii?Q?aVdnDxviEV3/JwX2sPUAPJXdFs2uoM2r5StpNmmCmfayYi8u69st429yn276?=
 =?us-ascii?Q?Fgsgi3grvBLjKTLcbwv5SAkqT3EKJDE7txm58B6IqF258DF4QHO/VOdejFRp?=
 =?us-ascii?Q?mJq0iZOyRiloeGLSSebiuHjJYg+RoD5cEt5BN6HSkAiu68r24IO5PqWONSlK?=
 =?us-ascii?Q?krpeCIesxsmYGz0NyxpmfxQO2BufA3QcUNxbqAR0ZsmFnTgASBd4TKP0MMf/?=
 =?us-ascii?Q?SfviK5YG+q2Qq3cUorfWpoSWgS1spVaZ1b1NPQcx0N5PQqp5RkadyaxyPc/h?=
 =?us-ascii?Q?Z6jUpIseVq01wX0CZnq1rxmV9KTtezTVp7AjV2HETDc2wtrfZFTxtJhb+LxM?=
 =?us-ascii?Q?oUoGzJ9UpMclPPfKXR20a18KcnG6aq/SLnhzkbgCdGSTG4GuutGJ/NdlHnFX?=
 =?us-ascii?Q?gkVp6VsasDykjS4YDBUzzgo9E9d/pw1bfKm47vyIzHHw+jRcPS4O0B2fnaBy?=
 =?us-ascii?Q?DoV6nhzQRsvPP+VSZtje4NOinKfoiB4XPZlP4386PlRHurHG4DS3krliWbxN?=
 =?us-ascii?Q?ATscq/SJYHhStMVZo4EniCGJu80oZPUOJN+By7qd5/A5AarsaTDp/sRuDAVm?=
 =?us-ascii?Q?bxb+GJb+C6f3GjsCIp1HCUH0T2uDY/c3EwwuqMB7EQ57tJw8J/PtDqJ5Fgji?=
 =?us-ascii?Q?JjwwYtY+r2dzQ9TXyv1LWa3T4AYKy+HV7tp6RyVwfLesoRGDSUcaZngEJ1nJ?=
 =?us-ascii?Q?8Fmnyml7sILkeXIkl5DZFdK0mnMjMdBG75Ib2BBg9KQNhY3jGWij7WBrTKYi?=
 =?us-ascii?Q?GjsQwpkYqQ0wU4HoPyCnou3nJhLERzZ/c5Ii+G8+osi/5deCwRy8cNEozlWm?=
 =?us-ascii?Q?jWGqIAFGVCdIqYsYTNQJthsrkCiuVH1bc1mwQIP97seUBCqmj7rgXvyFqFKO?=
 =?us-ascii?Q?oAbokosh43iWbIj4jNVkavxxHd0JgWh4gd7nytLjCp4QE4/YJ0gqchtuTI+U?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fbffed4d-0e50-44df-e1d7-08dd580484d7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 14:30:59.0762 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uYtjaVO95lSge7Pt7Ce/zbdQDUBv3qRCB2VQrpOGLbVSzeiqdgKlzonwe4holgZPloEk64bCtzkEk2al0Br+XlKPdo7THwZVe2fHYYrOrDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8031
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

On Thu, Feb 27, 2025 at 05:52:16PM -0800, Andre Muezerie wrote:
> Up to now MSVC has being used with the default mode, which uses SSE2
> instructions for scalar floating-point and vector calculations.
> https://learn.microsoft.com/en-us/cpp/build/reference/arch-x64?view=msvc-170
> 
> This patch allows users to specify the CPU for which the generated
> code should be optimized for in the same way it's done for GCC: by
> passing the CPU name.
> When no explicit CPU name is passed, 'native' is assumed (like it
> happens with GCC) and the code will be optimized for the same CPU
> type used to compile the code.
> 
> MSVC does not provide this functionality natively, so logic was
> added to a new meson.build file under config/x86/msvc to handle
> these differences, detecting which
> instruction sets are supported by the CPU(s), passing the best
> options to MSVC and setting the correct macros (like __AVX512F__)
> so that the DPDK code can rely on them like it is done with GCC.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

Thanks for splitting out this change from the earlier one, it allows more
focused review.
However, I think within this, we can split things a bit further two, and I
think this patch could do with being split into separate changes.
Specifically:
* one patch for reordering the x86/meson.build file, i.e. just move the
  code about and put a subdir_done() for MSVC once common part is
  completed. That patch is a quick review since all you are doing is moving
  things about.
* separate patch for adding the new msvc file +  one-line change to add it
  to the x86/meson.build file.
* library changes in separate patch - or perhaps two patches so individual
  maintainers can ack.

Some other comments inline below too.
Thanks,
/Bruce

> ---
>  config/x86/meson.build      |  87 +++++------
>  config/x86/msvc/meson.build | 287 ++++++++++++++++++++++++++++++++++++
>  lib/acl/meson.build         |   8 +-
>  lib/member/meson.build      |  11 +-
>  4 files changed, 343 insertions(+), 50 deletions(-)
>  create mode 100644 config/x86/msvc/meson.build
> 
> diff --git a/config/x86/meson.build b/config/x86/meson.build
> index 47a5b0c04a..8a88280998 100644
> --- a/config/x86/meson.build
> +++ b/config/x86/meson.build
> @@ -1,6 +1,50 @@
>  # SPDX-License-Identifier: BSD-3-Clause
>  # Copyright(c) 2017-2020 Intel Corporation
>  
> +dpdk_conf.set('RTE_ARCH_X86', 1)
> +if dpdk_conf.get('RTE_ARCH_64')
> +    dpdk_conf.set('RTE_ARCH_X86_64', 1)
> +    dpdk_conf.set('RTE_ARCH', 'x86_64')
> +else
> +    dpdk_conf.set('RTE_ARCH_I686', 1)
> +    dpdk_conf.set('RTE_ARCH', 'i686')
> +endif
> +
> +dpdk_conf.set('RTE_CACHE_LINE_SIZE', 64)
> +dpdk_conf.set('RTE_MAX_LCORE', 128)
> +
> +epyc_zen_cores = {
> +    '__znver5__':768,
> +    '__znver4__':512,
> +    '__znver3__':256,
> +    '__znver2__':256,
> +    '__znver1__':128
> +    }
> +
> +cpu_instruction_set = get_option('cpu_instruction_set')
> +if cpu_instruction_set == 'native'
> +    foreach m:epyc_zen_cores.keys()
> +        if cc.get_define(m, args: machine_args) != ''
> +            dpdk_conf.set('RTE_MAX_LCORE', epyc_zen_cores[m])
> +            break
> +        endif
> +    endforeach
> +else
> +    foreach m:epyc_zen_cores.keys()
> +        if m.contains(cpu_instruction_set)
> +            dpdk_conf.set('RTE_MAX_LCORE', epyc_zen_cores[m])
> +            break
> +        endif
> +    endforeach
> +endif
> +
> +dpdk_conf.set('RTE_MAX_NUMA_NODES', 32)
> +
> +if is_ms_compiler
> +    subdir('msvc')
> +    subdir_done()
> +endif
> +
>  # get binutils version for the workaround of Bug 97
>  binutils_ok = true
>  if is_linux or cc.get_id() == 'gcc'
> @@ -14,7 +58,8 @@ if is_linux or cc.get_id() == 'gcc'
>      endif
>  endif
>  
> -cc_avx512_flags = ['-mavx512f', '-mavx512vl', '-mavx512dq', '-mavx512bw']
> +cc_avx2_flags = ['-mavx2']
> +cc_avx512_flags = ['-mavx512f', '-mavx512vl', '-mavx512dq', '-mavx512bw', '-mavx512cd']
>  cc_has_avx512 = false
>  target_has_avx512 = false
>  if (binutils_ok and cc.has_multi_arguments(cc_avx512_flags)
> @@ -82,43 +127,3 @@ foreach f:optional_flags
>          compile_time_cpuflags += ['RTE_CPUFLAG_' + f]
>      endif
>  endforeach
> -
> -
> -dpdk_conf.set('RTE_ARCH_X86', 1)
> -if dpdk_conf.get('RTE_ARCH_64')
> -    dpdk_conf.set('RTE_ARCH_X86_64', 1)
> -    dpdk_conf.set('RTE_ARCH', 'x86_64')
> -else
> -    dpdk_conf.set('RTE_ARCH_I686', 1)
> -    dpdk_conf.set('RTE_ARCH', 'i686')
> -endif
> -
> -dpdk_conf.set('RTE_CACHE_LINE_SIZE', 64)
> -dpdk_conf.set('RTE_MAX_LCORE', 128)
> -
> -epyc_zen_cores = {
> -    '__znver5__':768,
> -    '__znver4__':512,
> -    '__znver3__':256,
> -    '__znver2__':256,
> -    '__znver1__':128
> -    }
> -
> -cpu_instruction_set = get_option('cpu_instruction_set')
> -if cpu_instruction_set == 'native'
> -    foreach m:epyc_zen_cores.keys()
> -        if cc.get_define(m, args: machine_args) != ''
> -            dpdk_conf.set('RTE_MAX_LCORE', epyc_zen_cores[m])
> -            break
> -        endif
> -    endforeach
> -else
> -    foreach m:epyc_zen_cores.keys()
> -        if m.contains(cpu_instruction_set)
> -            dpdk_conf.set('RTE_MAX_LCORE', epyc_zen_cores[m])
> -            break
> -        endif
> -    endforeach
> -endif
> -
> -dpdk_conf.set('RTE_MAX_NUMA_NODES', 32)

For changes to config/x86/meson.build you can add my Ack if it's a separate
patch.

> diff --git a/config/x86/msvc/meson.build b/config/x86/msvc/meson.build
> new file mode 100644
> index 0000000000..646c9a8515
> --- /dev/null
> +++ b/config/x86/msvc/meson.build
> @@ -0,0 +1,287 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2025 Microsoft Corporation
> +
> +cc_avx2_flags = ['/arch:AVX2']
> +cc_avx512_flags = ['/arch:AVX512']
> +cc_has_avx512 = true
> +
> +cpuid_code = '''
> +    #include <stdio.h>
> +    #include <stdint.h>
> +    #include <intrin.h>
> +
> +    uint32_t f1_ECX = 0;
> +    uint32_t f1_EDX = 0;
> +    uint32_t f7_EBX = 0;
> +    uint32_t f7_ECX = 0;
> +
> +    void get_support_flags()
> +    {
> +        int ids_max;
> +        int data[4];
> +
> +        /*
> +         * Calling __cpuid with 0x0 as the function_id argument
> +         * gets the number of the highest valid function ID.
> +         */
> +        __cpuid(data, 0);
> +        ids_max = data[0];
> +
> +        if (1 <= ids_max) {
> +            __cpuidex(data, 1, 0);
> +            f1_ECX = data[2];
> +            f1_EDX = data[3];
> +
> +            if (7 <= ids_max) {
> +                __cpuidex(data, 7, 0);
> +                f7_EBX = data[1];
> +                f7_ECX = data[2];
> +            }
> +        }
> +    }
> +
> +    int get_instruction_support()
> +    {
> +        get_support_flags();
> +
> +    #ifdef SSE3
> +        return (f1_ECX & (1UL << 0)) ? 1 : 0;
> +    #endif
> +    #ifdef PCLMUL
> +        return (f1_ECX & (1UL << 1)) ? 1 : 0;
> +    #endif
> +    #ifdef SSSE3
> +        return (f1_ECX & (1UL << 9)) ? 1 : 0;
> +    #endif
> +    #ifdef SSE4_1
> +        return (f1_ECX & (1UL << 19)) ? 1 : 0;
> +    #endif
> +    #ifdef SSE4_2
> +        return (f1_ECX & (1UL << 20)) ? 1 : 0;
> +    #endif
> +    #ifdef AES
> +        return (f1_ECX & (1UL << 25)) ? 1 : 0;
> +    #endif
> +    #ifdef AVX
> +        return (f1_ECX & (1UL << 28)) ? 1 : 0;
> +    #endif
> +    #ifdef RDRND
> +        return (f1_ECX & (1UL << 30)) ? 1 : 0;
> +    #endif
> +    #ifdef SSE
> +        return (f1_EDX & (1UL << 25)) ? 1 : 0;
> +    #endif
> +    #ifdef SSE2
> +        return (f1_EDX & (1UL << 26)) ? 1 : 0;
> +    #endif
> +    #ifdef AVX2
> +        return (f7_EBX & (1UL << 5)) ? 1 : 0;
> +    #endif
> +    #ifdef AVX512F
> +        return (f7_EBX & (1UL << 16)) ? 1 : 0;
> +    #endif
> +    #ifdef AVX512DQ
> +        return (f7_EBX & (1UL << 17)) ? 1 : 0;
> +    #endif
> +    #ifdef RDSEED
> +        return (f7_EBX & (1UL << 18)) ? 1 : 0;
> +    #endif
> +    #ifdef AVX512IFMA
> +        return (f7_EBX & (1UL << 21)) ? 1 : 0;
> +    #endif
> +    #ifdef AVX512CD
> +        return (f7_EBX & (1UL << 28)) ? 1 : 0;
> +    #endif
> +    #ifdef AVX512BW
> +        return (f7_EBX & (1UL << 30)) ? 1 : 0;
> +    #endif
> +    #ifdef AVX512VL
> +        return (f7_EBX & (1UL << 31)) ? 1 : 0;
> +    #endif
> +    #ifdef GFNI
> +        return (f7_ECX & (1UL << 8)) ? 1 : 0;
> +    #endif
> +    #ifdef VPCLMULQDQ
> +        return (f7_ECX & (1UL << 10)) ? 1 : 0;
> +    #endif
> +
> +        return -1;
> +    }
> +
> +    int main(int argc, char *argv[])
> +    {
> +        int res = get_instruction_support();
> +        if (res == -1) {
> +            printf("Unknown instruction set");
> +            return -1;
> +        }
> +        printf("%d", res);
> +
> +        return 0;
> +    }
> +'''
> +
> +# The data in the table below can be found here:
> +# https://gcc.gnu.org/onlinedocs/gcc/x86-Options.html
> +# A tool to easily update this table can be found under devtools/dump-cpu-flags.
> +# The table only contains CPUs that have SSE4.2, as this instruction set is required by DPDK.
> +# That means that in addition to the instruction sets mentioned in the table, all these CPUs
> +# also have ['SSE', 'SSE2', 'SSE3', 'SSEE3', 'SSE4_1', 'SSE4_2']
> +cpu_type_to_flags = {
> +       'x86-64-v2': [],
> +       'x86-64-v3': ['AVX', 'AVX2'],
> +       'x86-64-v4': ['AVX', 'AVX2', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD'],
> +         'nehalem': [],
> +          'corei7': [],
> +        'westmere': ['PCLMUL'],
> +     'sandybridge': ['AVX', 'PCLMUL'],
> +      'corei7-avx': ['AVX', 'PCLMUL'],
> +       'ivybridge': ['AVX', 'PCLMUL', 'RDRND'],
> +      'core-avx-i': ['AVX', 'PCLMUL', 'RDRND'],
> +         'haswell': ['AVX', 'PCLMUL', 'RDRND', 'AVX2'],
> +       'core-avx2': ['AVX', 'PCLMUL', 'RDRND', 'AVX2'],
> +       'broadwell': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED'],
> +         'skylake': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES'],
> +  'skylake-avx512': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD'],
> +     'cascadelake': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD'],
> +      'cannonlake': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD', 'AVX512IFMA'],
> +      'cooperlake': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD'],
> +  'icelake-client': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD', 'AVX512IFMA', 'GFNI'],
> +  'icelake-server': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD', 'AVX512IFMA', 'GFNI'],
> +       'tigerlake': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD', 'AVX512IFMA', 'GFNI'],
> +      'rocketlake': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD', 'AVX512IFMA', 'GFNI'],
> +       'alderlake': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'GFNI'],
> +      'raptorlake': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'GFNI'],
> +      'meteorlake': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'GFNI'],
> +       'gracemont': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'GFNI'],
> +       'arrowlake': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'GFNI'],
> +     'arrowlake-s': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'GFNI'],
> +       'lunarlake': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'GFNI'],
> +     'pantherlake': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'GFNI'],
> +  'sapphirerapids': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD', 'AVX512IFMA', 'GFNI'],
> +   'emeraldrapids': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD', 'AVX512IFMA', 'GFNI'],
> +   'graniterapids': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD', 'AVX512IFMA', 'GFNI'],
> + 'graniterapids-d': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD', 'AVX512IFMA', 'GFNI'],
> +   'diamondrapids': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD', 'AVX512IFMA', 'GFNI'],
> +      'silvermont': ['PCLMUL', 'RDRND'],
> +             'slm': ['PCLMUL', 'RDRND'],
> +        'goldmont': ['PCLMUL', 'RDRND', 'RDSEED', 'AES'],
> +   'goldmont-plus': ['PCLMUL', 'RDRND', 'RDSEED', 'AES'],
> +         'tremont': ['PCLMUL', 'RDRND', 'RDSEED', 'AES', 'GFNI'],
> +    'sierraforest': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'GFNI'],
> +      'grandridge': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'GFNI'],
> +'clearwaterforest': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'GFNI'],
> +          'bdver1': ['AVX', 'PCLMUL', 'AES'],
> +          'bdver2': ['AVX', 'PCLMUL', 'AES'],
> +          'bdver3': ['AVX', 'PCLMUL', 'AES'],
> +          'bdver4': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'AES'],
> +          'znver1': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES'],
> +          'znver2': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES'],
> +          'znver3': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ'],
> +          'znver4': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD', 'AVX512IFMA', 'GFNI'],
> +          'znver5': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD', 'AVX512IFMA', 'GFNI'],
> +          'btver2': ['AVX', 'PCLMUL', 'AES'],
> +        'lujiazui': ['PCLMUL', 'RDRND', 'RDSEED', 'AES'],
> +        'yongfeng': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES'],
> +      'shijidadao': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES'],
> +}
> +
> +# Determine cpu_flags for a given configuration.
> +# SSE instructions up to 4.2 are required for DPDK.
> +cpu_flags = ['SSE', 'SSE2', 'SSE3', 'SSEE3', 'SSE4_1', 'SSE4_2']
> +
> +message('cpu_instruction_set: @0@'.format(cpu_instruction_set))
> +
> +if cpu_instruction_set == ''
> +    # Nothing to do as cpu_flags already holds all the required flags.
> +elif cpu_instruction_set == 'native'
> +    # MSVC behaves differently than GCC regarding supported instruction sets.
> +    # While GCC will create macros like __AVX512F__ when such instruction set is
> +    # supported by the current CPU, MSVC does not do that. MSVC will create that
> +    # macro when parameter /arch:AVX512 is passed to the compiler, even when the
> +    # CPU does not have that instruction set (by design). So there's a need to
> +    # look at CPUID flags to figure out what is really supported by the CPU, so
> +    # that the correct /arch value can be passed to the compiler.
> +    # The macros also need to be explicitly defined, as /arch will not create all
> +    # macros GCC creates under the same conditions.
> +    # As an example, /arch:AVX512 creates __AVX512BW__, but does not create __SSE2__.
> +    # More details available here:
> +    # https://learn.microsoft.com/en-us/cpp/preprocessor/predefined-macros
> +
> +    optional_flags = [
> +            'PCLMUL',
> +            'AES',
> +            'AVX',
> +            'RDRND',
> +            'AVX2',
> +            'AVX512F',
> +            'AVX512BW',
> +            'AVX512DQ',
> +            'AVX512VL',
> +            'AVX512CD',
> +            'AVX512IFMA',
> +            'GFNI',
> +            'RDSEED',
> +            'VPCLMULQDQ',
> +    ]
> +    foreach f:optional_flags
> +        result = cc.run(cpuid_code, args: '-D@0@'.format(f),
> +                        name: 'instruction set @0@'.format(f))

Is building a new binary for each instruction set the best way to do this?
Would it not be better to have a single binary that outputs all the
instruction sets in one go?

> +        has_instr_set = result.returncode() == 0 and result.stdout() == '1'
> +        if has_instr_set
> +            cpu_flags += f
> +        endif
> +        message('Target has @0@: @1@'.format(f, has_instr_set))
> +    endforeach
> +else
> +    # An explicit cpu_instruction_set was provided. Get cpu_flags
> +    # from cpu_type_to_flags table.
> +    if cpu_instruction_set not in cpu_type_to_flags
> +        error('CPU not known or not supported. Please update the table with known CPUs if needed.')
> +    endif
> +    cpu_flags += cpu_type_to_flags[cpu_instruction_set]
> +endif
> +
> +# Now that all cpu_flags are known, set compile_time_cpuflags and also
> +# machine_args to ensure that the instruction set #defines (like __SSE2__)
> +# are always present in the preprocessor.
> +message('cpu_flags: @0@'.format(cpu_flags))
> +
> +foreach flag:cpu_flags
> +    machine_args += '/D__@0@__'.format(flag)
> +    if flag == 'PCLMUL'
> +        flag = 'PCLMULQDQ'
> +    elif flag == 'RDRND'
> +        flag = 'RDRAND'
> +    endif
> +    compile_time_cpuflags += ['RTE_CPUFLAG_' + flag]
> +endforeach
> +
> +# Per https://learn.microsoft.com/en-us/cpp/build/reference/arch-x64?view=msvc-170
> +# option '/arch:AVX512' enables all five flags used in the expression below.
> +target_has_avx512 = ('AVX512F'  in cpu_flags and
> +                     'AVX512BW' in cpu_flags and
> +                     'AVX512DQ' in cpu_flags and
> +                     'AVX512CD' in cpu_flags and
> +                     'AVX512VL' in cpu_flags)
> +
> +# Decide which instruction sets should be used by the compiler.
> +# With MSVC, intrinsic functions are always enabled. However, for the
> +# compiler to use an extended instruction set for automatically
> +# generated code "/arch" needs to be passed. So we instruct the compiler
> +# to use the largest set that is supported by the CPU. It is implied that
> +# smaller sets than the largest selected are included, as described here:
> +# https://learn.microsoft.com/en-us/cpp/build/reference/arch-x64?view=msvc-170
> +if 'RTE_CPUFLAG_AVX512F' in compile_time_cpuflags
> +    machine_args += ['/arch:AVX512']
> +elif 'RTE_CPUFLAG_AVX2' in compile_time_cpuflags
> +    machine_args += ['/arch:AVX2']
> +elif 'RTE_CPUFLAG_AVX' in compile_time_cpuflags
> +    machine_args += ['/arch:AVX']
> +else
> +    # SSE4.2 is expected to always be available
> +    machine_args += ['/arch:SSE4.2']
> +endif
> +
> +message('machine_args: @0@'.format(machine_args))
> +message('compile_time_cpuflags: @0@'.format(compile_time_cpuflags))
> diff --git a/lib/acl/meson.build b/lib/acl/meson.build
> index fefe131a48..6ba53fbba4 100644
> --- a/lib/acl/meson.build
> +++ b/lib/acl/meson.build
> @@ -55,15 +55,11 @@ if dpdk_conf.has('RTE_ARCH_X86')
>              sources += files('acl_run_avx512.c')
>              cflags += '-DCC_AVX512_SUPPORT'
>  
> -        elif cc.has_multi_arguments('-mavx512f', '-mavx512vl',
> -                    '-mavx512cd', '-mavx512bw')
> -
> +        elif cc.has_multi_arguments(cc_avx512_flags)
>              avx512_tmplib = static_library('avx512_tmp',
>                  'acl_run_avx512.c',
>                  dependencies: static_rte_eal,
> -                c_args: cflags +
> -                    ['-mavx512f', '-mavx512vl',
> -                     '-mavx512cd', '-mavx512bw'])
> +                c_args: cflags + cc_avx512_flags)
>              objs += avx512_tmplib.extract_objects(
>                      'acl_run_avx512.c')
>              cflags += '-DCC_AVX512_SUPPORT'

Ack from me for this change too.

> diff --git a/lib/member/meson.build b/lib/member/meson.build
> index f92cbb7f25..8416dc6f8a 100644
> --- a/lib/member/meson.build
> +++ b/lib/member/meson.build
> @@ -33,6 +33,12 @@ if dpdk_conf.has('RTE_ARCH_X86_64') and binutils_ok
>      # compiler flags, and then have the .o file from static lib
>      # linked into main lib.
>  
> +    if is_ms_compiler
> +        member_avx512_args = cc_avx512_flags
> +    else
> +        member_avx512_args = ['-mavx512f', '-mavx512dq', '-mavx512ifma']
> +    endif
> +

is ifma included as msvc as part of the AVX512 flags? How does this work
for the windows build?

>      # check if all required flags already enabled
>      sketch_avx512_flags = ['__AVX512F__', '__AVX512DQ__', '__AVX512IFMA__']
>  
> @@ -46,13 +52,12 @@ if dpdk_conf.has('RTE_ARCH_X86_64') and binutils_ok
>      if sketch_avx512_on == true
>          cflags += ['-DCC_AVX512_SUPPORT']
>          sources += files('rte_member_sketch_avx512.c')
> -    elif cc.has_multi_arguments('-mavx512f', '-mavx512dq', '-mavx512ifma')
> +    elif cc.has_multi_arguments(member_avx512_args)
>          sketch_avx512_tmp = static_library('sketch_avx512_tmp',
>              'rte_member_sketch_avx512.c',
>              include_directories: includes,
>              dependencies: [static_rte_eal, static_rte_hash],
> -            c_args: cflags +
> -                ['-mavx512f', '-mavx512dq', '-mavx512ifma'])
> +            c_args: cflags + member_avx512_args)
>          objs += sketch_avx512_tmp.extract_objects('rte_member_sketch_avx512.c')
>          cflags += ['-DCC_AVX512_SUPPORT']
>      endif
> -- 
> 2.48.1.vfs.0.0
> 
