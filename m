Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5119BCCF9EE
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 17:20:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F4964028D;
	Wed, 29 Oct 2025 18:20:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id DE26040150
 for <dev@dpdk.org>; Wed, 29 Oct 2025 18:20:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761758453; x=1793294453;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=t5tHCCImpAHQD34tPrFgVgw6eefcgy1L5Jq+ATrfUQQ=;
 b=jALUNl0ehyun0aKSX70w7b9qUlntaIN2LEDFInOvZ3vfLSyvG0FFbr7j
 dJkVjVGxUoGr9mFTFBah9e2ZSsRkfV9MjHOpR+s0OgTPi/94RgUJWqWDD
 psiGwQyiRYNSI2Z7uwNgYfd1wJZzw+mfT9qEiKXUTSIm9PzCpeNwNT6J5
 2ZfBj5ad4DvrhfYRU0YMmqs4V/zCYjKRjx0Q7jnKppTbPsgMUP/7r5tTB
 PIAyYn7R5xTSWtTBnnoJz2SMpNNEkr9BK2RUWVcuPBvixVk1quMeYbifx
 HRemXgq9Honwu71G+K/wsRQySkuJJ6BRxC14Ytyty2EqMrHaKDmOI1bK1 w==;
X-CSE-ConnectionGUID: Z9OcfgBkT4GS0rDdrSWcCA==
X-CSE-MsgGUID: ZQja8K/+TR+TqkMUhPNebA==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="89357402"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; d="scan'208";a="89357402"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 10:20:52 -0700
X-CSE-ConnectionGUID: icPt4TW6RPWnMYSEf+oa6A==
X-CSE-MsgGUID: 3hEW3K3TTlCxoCAQSJzbzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; d="scan'208";a="190082736"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 10:20:52 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 10:20:51 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 10:20:51 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.19) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 10:20:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2Yf7Au0aPT6mHeneE7zj/kFvZ1PtNMS2xhmhpb72WsR4GQ0Q03Up9/QKnha4FXDto7tTeTl85KSSxq5PobemA/7elVliuwLsUE1cmCQWKvnT08+5k4k0aPGU+OlwCUEZzu/bEFmv0PeUuF/wvZfxEybU9jYvVjP3JlLV2NDJ+p/ZvFR3j5lEbSI10RBkR5elaOe3jsn8rIJ3Is+C2WxsO4zD8XSC1Vf/Xex09d20Isz2SYF/ncTqp3j62bHnA7U/snkYeSytg5+oBc+PJrHQjcp3i7z34jNYXZ3bZZY5caaWgkkhTAJ2VFMQzLtzXVVUCJXcGoMe3Ws5XScrv/l/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4sqyhCY5Q9LgEmekdZLoAipn5cxkX8lMGqJZJQKqTeI=;
 b=YdezVbbq+o+sIMgPMxnY40gRn4vv96hTWe9MXbELiI6bPuXsiamh6kWU0fyTGYG73tQc7r9GwuGJKWmYDySodhOuXXTwfrL6YKNMMtTUekhzrP7n+FONbc1VeWDurV/F8KFEWHxRF2TjZseq2IFlsCAbmHmE0CXKcZTu08qqBYpNlrTVQvbDK1AP1/yVhunf78Ul/1tLg55TGMt5eixb/Xy0TylV2lDCBub17aGfqux4IOAzEx/Kwb88ir6N/eVS70Bu9lboiVkB8fsAFiNirGLAyoDd7pvBM/Nyr8ksPT3cHn/u0Ys+sJbcY+dZN2zxTYlvA4edANIPlwdfKM7bjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ2PR11MB8516.namprd11.prod.outlook.com (2603:10b6:a03:56c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 17:20:49 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 17:20:49 +0000
Date: Wed, 29 Oct 2025 17:20:44 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v1 1/1] doc/ice: document protocol agnostic filtering
Message-ID: <aQJM7CpYmbKLvABW@bricha3-mobl1.ger.corp.intel.com>
References: <f2bf17ce5b8f64dade7a5505ed0aaf30343e3888.1761751024.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f2bf17ce5b8f64dade7a5505ed0aaf30343e3888.1761751024.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU7P190CA0030.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::7) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ2PR11MB8516:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cf80b2f-d35e-4735-371d-08de170f8116
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d8dT2KgQurs7udToLd7IKdnRELkjX244jC30bqKJ7jyEyVWRw2uUhVAhLKHO?=
 =?us-ascii?Q?Txp18sUxkqg2GCwMtaPtVoT5JbjIj8TabbgWPXUoSKSeVEDGMAdH3Ea1DFTX?=
 =?us-ascii?Q?z21RjvkazMwT7FcURpIorBRhcLSFoL4DYeCGb7ZadNPISDuyPo3guCdIePFh?=
 =?us-ascii?Q?dhs/+TTqqnhqqvvTPQrKabw8jyWXgJIUZ4pn+TuuLLHkG2HsLXnuBvaGTH8z?=
 =?us-ascii?Q?9YsIoKB/mRWpEYzB314hU9AkK0oYowbxfbYxVszC8z2exsc9SyEczkXt4VI/?=
 =?us-ascii?Q?i0VtAoHzwJdvOfJreJZjBMZtBxnNQzEBhDR5Bq/R8MvzKxTyUx3V4rBoG81g?=
 =?us-ascii?Q?KRmbWttqlW0V5LF9qfk/WhwG2SagtgJjSoVeBZsmNEifZ8WlvkTYzW0SdLs4?=
 =?us-ascii?Q?E6M31PhbVNmolydfFW9gtjcE1JzjWTn1Pd/ltaIjGyBFEf+cSyOV+k0lGKNK?=
 =?us-ascii?Q?hQHqruoiEOtcAagSgSXhT44Pb+YdPvPmZqtrKrsRKX2jDmDFDKm5ivn7/5yZ?=
 =?us-ascii?Q?1EPGhaB3UphLBg0HcI5kcNQCTb5MCDYBhbDq0YwvwmJXyoVmC7tZN6OspPuj?=
 =?us-ascii?Q?9+qn1WaoBaAsxRdAsdbLrA6/aJ7xg6C+Rn6ig3eYepPkBQoC/pND/NF0sf5Y?=
 =?us-ascii?Q?jLsSP2welJloy+ozv1XdHbuk68Xxnvpx3e0E+4oPopNqeUSFN/RsbnT3uxWL?=
 =?us-ascii?Q?KRdjnaU+JsGuKdZWwppz0ySst1MvQq0oLpZhzfNSaeMVE6FE0Q+yOEt+HxWK?=
 =?us-ascii?Q?ZyZ0me8UuNN7pnZ9xNrIRtJskxsaVLeMojXSb5VTxe0yRJ5m2O3vBHPlLfL/?=
 =?us-ascii?Q?d2F0UwtS43PT7In0cF/k/zcL7R6lzCKCgC3YhtfcovW/wEP17Jr5hn+123Q7?=
 =?us-ascii?Q?SOrRdb6FGUwXvy81O2WHCWHbawlqa4nJP2G7JTGVxXZqXRYZIuz610x4gxHS?=
 =?us-ascii?Q?odVhhr6JKIXdEukkDUb2s+bfSdF/9FUusR8i3p8X2nRJM43DWPTzrPIKO+LM?=
 =?us-ascii?Q?lbIWCloYfahgWp/jYCX/Xt4nPbvO7qIRGU5bVqnWuRcBXFPZICD0TF+CsJvZ?=
 =?us-ascii?Q?JE4Y7qbJFgNfg/tYrU1BJQ8ofaezKeFfN4ZqmnSLTRKpVZeNdsUvJn/YsFfZ?=
 =?us-ascii?Q?x2VmYz9UoA5eivvOTvNsMyK6igksK3hmX0JzelzXEYbo+2C/CQ4qAzeGkE42?=
 =?us-ascii?Q?eIRwPqG3D8pDcSz07uzso454eMvMJQy6JZ0vnsK1mywWLv/RDyn+s1H/eimp?=
 =?us-ascii?Q?Ylo6Lnk9jVQEAYFqlhY55nPeolX7MPnXSID6oQrSgzEIfHQaLO8ZRTGWWm0P?=
 =?us-ascii?Q?esNSGHmDpN3Q5d6ivGSzxaHNac5Quv74YPlEhOVgifSzgQY+H43j/Ko+1ZQI?=
 =?us-ascii?Q?RA9mqkwcuLnkEo6M8RKDwY0hjgb3sjzl5IQ3Dwp6Evg5RVJmvm6APSHeVmFB?=
 =?us-ascii?Q?Nr7vWdNw2GZZXPONNdHuKm+DhIYPVzSV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IqnLnHFjqff19T2TkSOmc4dBI7ql+Z5k+I1zM4cilJ+SokSfj/fS0EA+wpHw?=
 =?us-ascii?Q?O1xE/RAxF9EDdUXvjtGVqsn4luHbY26BnBVsqU3zP3RaovJnrUHmsv7ZtEEx?=
 =?us-ascii?Q?6GpMV16jM//XVFcJS3ZNpr7+0tfykiLYtsQ8g5gdajLCG50K54B0ll5H3L10?=
 =?us-ascii?Q?0C1RhlSAVWxX6WmELiuP7Cc4oEJiZdm2PrNGvm/qs8gGWRNWHHyzhEU3OZvo?=
 =?us-ascii?Q?c+Lp+oEw7BpT9Ymt2x67mjn7N7oa2tGDEMea/KZ2F1eb0g2ofkk9tJ4v0+2A?=
 =?us-ascii?Q?6T732k8bYKKYInN2x9i9TJ1t6LnwVzFMXDBCyUNA51upIMRaW3B8/EyeFo5J?=
 =?us-ascii?Q?sBnSXrtdrU06d8iUtyVtdBeMoYaLxLpKzmEkJ7p3n+ijGKYHFnVeMdRL9EhP?=
 =?us-ascii?Q?s9kljia2q6PAF8HDSvecu8+dZ0PDZETVaLdVi4g58PH8hjFUeKLtcngX76QD?=
 =?us-ascii?Q?MYSLiw0peZ94zE9WO4mdf4u1SVeei/NhXom/5ZxfJta3ikw5SXkt9dfhSHRL?=
 =?us-ascii?Q?cN63Epxz+zKdRPFEcnixIzKan1eq+faadkRgnLT9fzyM7yrg0Uvl0jotKpPP?=
 =?us-ascii?Q?rTNVXLUb7m77gXoqWOFNd2wt/ol1un0a0eqfMPR110b45nOHiD72BZqnXa8O?=
 =?us-ascii?Q?V4iC0jfO0EIdCnuPQ0duHfMzJ1lRWd65jFJbMW/13J4JcPi24TmuqX6xwrEv?=
 =?us-ascii?Q?zXgoTrndBZml6JibajJZPXAPDoDl2h7Wm6TO2yH7H2x0XWOWc7LMwYF+UUJU?=
 =?us-ascii?Q?uE2dPyaKVn8J/PdP9Z2Q0ydgSSN6OIdZZJ3IV3Neec/0qwxmKerEECHhcrje?=
 =?us-ascii?Q?x+QmWv0J6Vu6gej6c4k9maADgeKsuGNsWJhoIQH2cHpRPfmCze2g4fNfDMuM?=
 =?us-ascii?Q?uLO04K/bzkUXYhDUVYoDAc/5xlgwChTaaZjHhKhJffT6KLmNntlXunQmNTZU?=
 =?us-ascii?Q?dT6FILB29Q2WxPLCYZy4SnoLyHTwJVCOPsTTe4DHYbLMb5Se8KzzAas1M2Wf?=
 =?us-ascii?Q?JN/1kADNkCLcAwKCIHfJPMc2FL+pGN1UySiXjUiPPFF52srfdfFWGf4oPLEe?=
 =?us-ascii?Q?jtymEcoiyok8efxQ4Q5s78fO3Z3VYZUg0wK85YYGYY5B5WkLnomh6gfjFVt9?=
 =?us-ascii?Q?02CkLon5Hv2C6gi4HcauGs6kJg1pVMes7XVXXlj7jWZo2/GRA2nwagK/GwBX?=
 =?us-ascii?Q?AF3dkGwVOAJQY5GHVXh2P/OHWyjX0zWMWs8qax8qPkLOAz+bFIY+FlRhBJgA?=
 =?us-ascii?Q?pSDo9UqOa4nJ/pb61Ae3SAg5hYx5Vz9VLAZCCriUY17ZsbjviLV1Bxoh9ug8?=
 =?us-ascii?Q?2JmzmZjGrFlis9suTPrSvZ8abJwzWauS1CrwQgnFo8YulXeBvGgvoy4rMe9M?=
 =?us-ascii?Q?CttoEYFcxf85yc8NMUUCXqcVLrPAaByFMTI+nIxehZGGsrnrWJSzMkeYRSwa?=
 =?us-ascii?Q?5l6lSdMy7Y0erQmXZPefg6JLWmxHlJwqksS72zbXrjEDoBqhAlX7T/kJ1aP4?=
 =?us-ascii?Q?DQ0ia/ex2n+yXQgW9UNrlwfYCdKfhn8ZXqZA4KyeFx1XRJBBX6wjSx+5bRtM?=
 =?us-ascii?Q?we3Zvwhz6mbsnyP5DKul711pClskgTkW9j+aXBvYQRHWVbgEop1TQtoz2dyj?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf80b2f-d35e-4735-371d-08de170f8116
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 17:20:49.3101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbw9ZHM2/olfcI7CdS5hR9ckamb6Gfqzdgw+7zEZ7sqrg8Dx/jykU8+pB1iasv9k7tt8cIH8J3wYZHmortgA53yx1vvQ2USOaCFIsfEbLiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8516
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

On Wed, Oct 29, 2025 at 03:17:14PM +0000, Anatoly Burakov wrote:
> Current documentation for protocol agnostic filtering for ICE driver is a
> bit terse and relies on a lot of assumed knowledge. Document the feature
> better and make all of the assumptions explicit.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---

Thanks Anatoly,

review comments inline below.

/Bruce

>  doc/guides/nics/ice.rst | 143 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 133 insertions(+), 10 deletions(-)
> 
> diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
> index 7e9ba23102..cb06abcdbc 100644
> --- a/doc/guides/nics/ice.rst
> +++ b/doc/guides/nics/ice.rst
> @@ -506,20 +506,143 @@ For each engine, a list of supported patterns is maintained in a global array
>  named ``ice_<engine>_supported_pattern``. The Ice PMD will reject any rule with
>  a pattern that is not included in the supported list.
>  
> +Protocol Agnostic Filtering
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
>  One notable feature is the ice PMD's ability to leverage the Raw pattern,
> -enabling protocol-agnostic flow offloading. Here is an example of creating
> -a rule that matches an IPv4 destination address of 1.2.3.4 and redirects it to
> -queue 3 using a raw pattern::
> -
> -  flow create 0 ingress group 2 pattern raw \
> -  pattern spec \
> -  00000000000000000000000008004500001400004000401000000000000001020304 \
> -  pattern mask \
> -  000000000000000000000000000000000000000000000000000000000000ffffffff \
> -  end actions queue index 3 / mark id 3 / end
> +enabling protocol-agnostic flow offloading. This feature allows users to create
> +flow rules for any protocol recognized by the hardware parser, by manually
> +specifying the raw packet structure. Therefore, flow offloading can be used even
> +in cases where desired protocol isn't explicitly supported by RTE_FLOW interface.
> +

A general comment, relevant to all docs. For the rst document files, don't
wrap the lines at/after a column boundary. Instead, it's recommended to
break the lines at a suitable punctuation boundary. This means that editing
the middle of a line is not going to cause rewrapping of all subsequent
lines.

> +Raw Pattern Components
> +++++++++++++++++++++++
> +
> +Raw patterns consist of two key components:
> +
> +**Pattern Spec**
> +  An ASCII hexadecimal string representing the complete packet structure that defines
> +  the packet type and protocol layout. The hardware parser analyzes this structure
> +  to determine the packet type (PTYPE) and identify protocol headers and their offsets.
> +  This specification must represent a valid packet structure that the hardware
> +  can parse and classify. If the hardware parser does not support a particular protocol
> +  stack, it may not correctly identify the packet type.
> +
> +**Pattern Mask**
> +  An ASCII hexadecimal string of the same length as the spec that determines which specific
> +  fields within the packet will be extracted and used for matching. The mask controls
> +  field extraction without affecting the packet type identification.
> +
> +It is important to note that raw pattern must be the only flow item in the flow item list.
> +

I think this should be called out in a dedicated NOTE block, or some other
way highlighted.

> +Generating Raw Pattern Values
> ++++++++++++++++++++++++++++++
> +
> +To create raw patterns, follow these steps:
> +
> +1. **Verify parser support**: Confirm that the hardware parser supports the protocol
> +   combination needed for the intended flow rule. This can be checked against
> +   the documentation for the DDP package currently in use.
> +
> +2. **Build the packet template**: Create a complete, valid packet header with all
> +   necessary sections (Ethernet, IP, UDP/TCP, etc.) using the exact field values
> +   that need to be matched.
> +
> +3. **Convert to hexadecimal**: Transform the entire header into a continuous
> +   ASCII hexadecimal string, with each byte represented as two hex characters.
> +
> +4. **Create the extraction mask**: Generate a mask of the same length as the spec, where set bits
> +   would indicate the fields used for extraction/matching.
> +
> +VPP project's `flow_parse.py` script can be used to generate packet templates and masks for raw patterns.
> +This tool takes a human-readable flow description and outputs the corresponding ASCII hexadecimal spec and mask.
> +

Can you include a link directly to the script?

> +Example usage:
> +
> +.. code-block:: console
> +
> +   python3 flow_parse.py --show -p "mac()/ipv4(src=1.1.1.1,dst=2.2.2.2)/udp()"
> +
> +Output:
> +
> +   {'flow': {'generic': {'pattern': {'spec': b'00000000000100000000000208004500001c000000000011000001010101020202020000000000080000',
> +   'mask': b'0000000000000000000000000000000000000000000000000000ffffffffffffffff0000000000000000'}}}}
> +
> +.. note::
> +   Ensure the spec represents complete protocol headers, as the hardware parser processes
> +   fields at 16-bit boundaries. Incomplete or truncated headers may result in unpredictable
> +   field extraction behavior.
> +
> +Action Support and Usage
> +^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +After constructing the raw pattern spec and mask, they can be used in the flow API with pattern type "raw".
> +
> +The following is an example of a minimal Ethernet + IPv4 header template. Source and destination IPv4 addresses are
> +part of the match key; all other fields are ignored.
> +
> +Spec (packet template):
> +  000000000001              Destination MAC (6 bytes)
> +  000000000002              Source MAC (6 bytes)
> +  0800                      EtherType = IPv4
> +  4500001c0000000000110000  IPv4 header, protocol = UDP
> +  01010101                  Source IP = 1.1.1.1
> +  02020202                  Destination IP = 2.2.2.2
> +  0000000000080000          UDP header
> +
> +Mask:
> +  000000000000              Destination MAC (ignored)
> +  000000000000              Source MAC (ignored)
> +  0000                      EtherType (ignored)
> +  000000000000000000000000  IPv4/UDP header (ignored)
> +  ffffffff                  Source IP (match all 32 bits)
> +  ffffffff                  Destination IP (match all 32 bits)
> +  0000000000000000          UDP header (ignored)
> +
> +This spec will match any non-fragmented IPv4/UDP packet whose source IP is 1.1.1.1 and destination IP is 2.2.2.2.
> +
> +Currently, the following actions are supported:
> +
> +- **mark**: Attaches a user-defined integer value to matching packets. Can be specified together with another action.
> +
> +- **queue**: Directs matching packets to a specific receive queue.
> +
> +- **drop**: Discards matching packets at the hardware level.
> +
> +- **rss**: Enables Receive Side Scaling (RSS) for matching packets.
> +
> +Constraints:
> +  * For RSS, only the global configuration is used; per-rule queue lists or RSS keys are not supported.
> +
> +To direct matching packets to a specific queue, and set mbuf FDIR metadata:
> +
> +.. code-block:: console
> +
> +   flow create 0 ingress pattern raw \
> +     pattern spec 00000000000100000000000208004500001c000000000011000001010101020202020000000000080000 \
> +     pattern mask 0000000000000000000000000000000000000000000000000000ffffffffffffffff0000000000000000 / end \
> +     actions queue index 3 mark id 3 / end
> +

This is testpmd commands, not C code, right? Can you call that out?
Should some C API calls be included, as end apps are not likely to
configure things using testpmd commands.

> +To use masked bits (IPv4 source/destination addresses) to distribute such packets via RSS:
> +
> +.. code-block:: console
> +
> +   flow create 0 ingress pattern raw \
> +     pattern spec 00000000000100000000000208004500001c000000000011000001010101020202020000000000080000 \
> +     pattern mask 0000000000000000000000000000000000000000000000000000ffffffffffffffff0000000000000000 / end \
> +     actions rss / end
> +
> +**Limitations**
>  
>  Currently, raw pattern support is limited to the FDIR and Hash engines.
>  
> +.. note::
> +
> +   **DDP Package Dependency**: Raw pattern functionality relies on the loaded
> +   DDP package to define available packet types and protocol parsing rules.
> +   Different DDP packages (OS Default, COMMS, Wireless) may support different
> +   protocol combinations and PTYPE mappings.
> +
>  Traffic Management Support
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
> -- 
> 2.47.3
> 
