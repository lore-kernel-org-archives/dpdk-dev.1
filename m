Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F0BC79FAA
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 07:36:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5EA484026E;
	Tue,  8 Sep 2026 09:36:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 500744026A
 for <dev@dpdk.org>; Tue,  8 Sep 2026 09:36:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788852987; x=1820388987;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=YAiuHjK2jOU/fgHdhxYq3cXhl989AVAAH2DHj7vaS1U=;
 b=gLcdogh0tnnFAaAFGiDwXKIFUYgpC0xhGpUVp3cA8e0uQAmhQOyxN2dG
 TzDLq4G7TbtHM4xNI9z1Hx7qbEnfuOgdkjoX17aZkB+RLgvIFZgl6jyCg
 Vnmfm6OLERqUy4U0/4vW/o1B/Unki4Fyc3a1oNEA7OAQ8Erfvf0t1vdth
 URrYPKasY/X8K1ck1hBYrDOZkNc4T0P70OFqc/yDwWv742XsyYVCbbdq+
 orhA8CmYYemRsEEmeN8Vsk8a+69xu6br/jt7rpw+PtB2dIe2z/WrKUsdp
 t3egFl6ASYiPFABQGG3izG1ThWFamL0/0RB6klGStmBc370gziddDYHMF Q==;
X-CSE-ConnectionGUID: FXP9l9Z/S2yHgecn8PX5wQ==
X-CSE-MsgGUID: sV1IpUTnQli1z0APtmXESg==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="88396104"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="88396104"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 00:36:24 -0700
X-CSE-ConnectionGUID: kDXg6V5/RTevi90jDwzqoQ==
X-CSE-MsgGUID: JSpntbanQJOmvTNBeFyoKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="268346181"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 00:36:24 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 00:36:23 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 00:36:23 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.59) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 00:36:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gt5dZqMsFJJit6DgqD+o1oC21d3hGrNE2sTJUtD0CON/zNikjs2YLZGgwQ+/4BN35Tz47IezpnWN/ehNmIvAKRIAton4RVdx5Cf5q2fucjGW0Da4RaWG7eMkL+XukyrOuR8KVwh1Bcvyu4VV5vdjFdTfYVil0PpQo/rqSVk035vSZ1MuNWSbmx1hSl5XqUF6Aqx9ImU67xT3OYco/Me1U+c5vtwgQhmbrJWSGLojIayolCSjYBsuaMvYGY3uw6rXn09+XFPpc0cLbeYbZ7hTrUqLW4l1F41cSLLZWyAga+WM4UvyemRWbdTLbR9FI9zOmMEI6iGND47yO0pB/Xy00g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NuDlx+rf6aIuBSXJUsErGi0pjbE6woOby0l2hPzSpyI=;
 b=wU1M94Cp3BHc2kJ9ACGne4MPxEYtPe5TYAx/vIk3HevYWxe600TijkSgZujxmL+lOPCRUb1si0697OJPDqLBF4KxQmTsVd+3fcswuq7jeLfXSUlXVeUM7OPUgegxBldZbghVw1xCCF9QV8cOTOwBf2+oidV6a9vslxlAlBAF6kSLNvn876zsdPPTgrgt0pBawCp2V07YU+qCfkIULP+m2J/hPwat9F+unOg6A8m1XMLWrXB3tMXoIQJBlhhio7kQ4BV6FMwJNXSnzaKks/G0tulzD8VvBETLd9RaQNw4PMqBFBStX88brXCiuw5Y+Ncxbm564UNnwnbNURJpYbDxTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.14; Tue, 8 Sep 2026 07:36:16 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 07:36:15 +0000
Date: Tue, 8 Sep 2026 08:36:10 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v5] devtools: add Python-based patch style checker
Message-ID: <ap-66tpoTRRnvyyZ@bricha3-mobl1.ger.corp.intel.com>
References: <20260131215602.46997-1-stephen@networkplumber.org>
 <20260907165808.320840-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260907165808.320840-1-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0268.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::16) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DM3PR11MB8736:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cb0e664-41ff-4cd4-1967-08df0d7bdd17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|6133799003|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: bdaFHaUM5xoQFHvWCSuypkCTVNQvdUtJbq5eXgthrxi24hLHH59oaJQjZDujgtN2GLbekRoNV8avisQ/ro8M876UF2jRpH5sQWDGxWmCTI0quhrfyZtxgTQ3pTVjzRbVAwSQQ6kIrzhM4A1FJOJMSy0CixT6SfCI07DeXBftjIb6fXqAeqwCBOc+pKQ+tYRC5nSBIBn829Qtyv85Q7MVkOdVDOXg3mdbWx9wUWn454uiJeJHtRSeDc+j7EYwmxORyC9d58ZvKn1kKUj07/ycSRCnDaUnqAdFywDriXvyux9noZ4UcXklTuhwD4A4vHrmnd2mV40hUkmfGwb4jxwoLBFTykmSRpBszl29/pspsiVa+9a1j/2tTATRiDc+SKkaS/rYCoeVJdkCigQAZ6WxJ9lLryO0ziFOqZmtQRmOSUv9EXfLUDCxsgvzTXTv4JULMlkFOO5XwP0HNguRl7/JWRzxXY4DN26fQgpMLd7i7jSTRjmo8e+EOi6B5uVwSBQ0xWiqpOWlkrcF9yXr6v8futQITjWn/DEq/YHHNiEa9J2FlVZEzS5UTFUzwGa0kMDlKeaPmWYHDjZk56j9MxsnCHh7b+R1xxzfm7GzWGkdVsg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UQLS1vC6grjGwlMmvU3Mk+/XUfIuF0gM369vskNmRWFV7dtVDi3LbbwY7IAf?=
 =?us-ascii?Q?4Oe7T3EESL0fGJ/UYZt08DQKa/RnmeOcsrfMkYAAZpYEJr6qdMhA6I+UgBl3?=
 =?us-ascii?Q?3odBpNimZT5NjQd0FYgCe3N2n4KxtXOtfyD9cwZj+FU2TJVE4AJVEuimh9D1?=
 =?us-ascii?Q?Q3o7iBWfZ3SrYlT0a0nXMXwP4tHf7F8hJww2t8BZLWFd6MnJOf7RCnumcHQt?=
 =?us-ascii?Q?q7koj11XL4u/e149N71QenM0jwISaQJUR8en9gbvIqi6HC+TN5PeCysVg+Uz?=
 =?us-ascii?Q?GkkDyMlSl8AdRZnPZNMCxfrCnsf1wkw0rEjmCof55FsgU18N5CSDnfsT6qoS?=
 =?us-ascii?Q?NWXbOXENm8HvcUudYiVJcB3Wi3fdwJCd2FT0rjjw3oMcYo/LXc2O5/yUPrM4?=
 =?us-ascii?Q?fvHcXaTCV2QwdN0j33kW6Fmwbq5t/kUWxRE/6dJ3pAJqbxLmcwRQpPDAldbE?=
 =?us-ascii?Q?22dCqkoPvr92n9hEsfkexxvn3ysz/UGerDwiCGeOEwwMzaAuuYomPKnS1PYd?=
 =?us-ascii?Q?CTURNIxB7BpkOsSjGfJXoiTbQDbgcC+5bbEJfWpeQdSNj8dQN+HZglEqT15K?=
 =?us-ascii?Q?/EnfdI4orP9I9oDBrryQ1b4VyGYkdlKd79mRzDuQ9HeoubRaQePwzBl6Og8r?=
 =?us-ascii?Q?20BEgSImZfDuZ/lzyzuPIm+RoNd21iTYbBc5HkzXMSzEzbX2sDjjoE64wUr6?=
 =?us-ascii?Q?RWoDdkZYcPsSj7EpeXABgmR7mRPVx86KDUa2XC+kqA0Sonwsz+PsWYYVqQ3e?=
 =?us-ascii?Q?TrzaYZPiY/Fr2kjt5OcYssT2GPh0h0IRLPXrYlHQlBkPSmAzxUKi4h1LJOsx?=
 =?us-ascii?Q?lti26w/XXBcafm/iQ0ZxqhLgjSgc+leeyuVjAxHN54eeleXyIaPDjDMG041T?=
 =?us-ascii?Q?iFQkwWHwmSeZWBOQ0wIKo1Ywz3EI1LsbRyqz7vuw4VRfq6S5NzuaRRFxrjPQ?=
 =?us-ascii?Q?ddzFzT2D65D2T+J1GMp7/I5sauFKehjMbklay+zs6e4sSaEp2gy9uz6L3mdr?=
 =?us-ascii?Q?67qLUdfFDsaxgtq3avwBSfIgFEnqh+rb2gGUqcR8KALS66mOIqK4q+Icb4nG?=
 =?us-ascii?Q?JXPOjNUlcjlsm5IIRv7g1yqgBJGHvPpFXgi3QwTAjE+AyybcDbdQyZaNFa4y?=
 =?us-ascii?Q?0VZWmHwaFxNqWX2JhNV94JZfqH7905N1oTl6RhMNangHQLjZFOc9mGA4rdKm?=
 =?us-ascii?Q?sWi0bwiM2fer/ZLuhg8wfQdtbUZgy2+SYXFPq9D6GtqHg9A/9FYPiaj1rt5v?=
 =?us-ascii?Q?Tn2gtdpA9nEz5HPP0WvnsnOyztDQZRMd8/XwiFwGZf5E98BXnY+Z/IB4BB/O?=
 =?us-ascii?Q?PwVBahnHw8J1Zh9bxx+FG1gFl6LkfxscWt9ove3s/b6KQVmDwrGyScoPoFzk?=
 =?us-ascii?Q?eSEPb2SrMMbvCgGrYbvt2LRnF9FV94Pbuq0sWAuGXUGuEcJLTLUUEeL8JFRe?=
 =?us-ascii?Q?8bijD0Kzglz3bwGWqLnsN1d/6zJyaa1CDN6C1jD67c4cxa/3y8lv7tWM0Qpx?=
 =?us-ascii?Q?3evK8F3JHEv9ch/MXXuv1y7pmUrdeyA985l8zrG26/AVQgS9lt6+z/o5rejQ?=
 =?us-ascii?Q?OnF8ZxWB+A/Hl0GfgVAK97xLgsN4ozGnEO8nAqSAFlUg5ydnAVX+LqJ/c8+z?=
 =?us-ascii?Q?qYI6lArsMhyrWnk6uIBfFmrbwo7JQm1z5GIWkyBOfT0CwVn8CxLlAYCPty7T?=
 =?us-ascii?Q?hl0Tw3iTJL5QgAYeDImozrIaW6rdQqG5T2PXgYJ/ixUFnfAeroDtNDZOa4CL?=
 =?us-ascii?Q?h9bzHztQl3QymuF4fRjmFnz/+B4al9Y=3D?=
X-Exchange-RoutingPolicyChecked: oMtqdNFYi9wjTikeUZ1ABcoZxFVSgbsdewhI0uvT9wnfHNf3Z3XhRCIko+QIhNyxiCl+OvGEE6NHtLcvJ48AiMUfCGZECRYZ8SDq/aZc1PoR+NyF9CqJh+9GE3mHDSgpLGnvaSQPUls1CeU9vg2FvjzHgdfRvtNzDiDEArEoe3fI2P8obvtjK+tg+s35r604h5EvbfJ77W0RTWoO6Y/b9XuUtocSF94W+2BNKLjo3W2NpcFLYF5yoMk9i9eFbRzjY3ikpTlAP+vxfhHaDPhyC4BiQOTWAIMAUOtlJVqJ+apZwsXHSGezWGeS9xVwrg7FvGmbhoxOyGrT+JNKXSzHzA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb0e664-41ff-4cd4-1967-08df0d7bdd17
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 07:36:15.5257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: leFF/CABJiYMPFOzs/V69shS9i9XPqRMGacwx0orBRe7JVnCRc5iGYzCEWpo/NneAJpEIcR91Wm0DPIFsN2m53gYq7JYBIyVgkDqS74NUPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8736
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

On Mon, Sep 07, 2026 at 09:57:30AM -0700, Stephen Hemminger wrote:
> Add dpdk-checkpatch.py as a standalone alternative to checkpatches.sh.
> Unlike the existing shell script wrapper around checkpatch.pl, this
> requires no Linux kernel source tree or Perl installation and is
> significantly faster (~0.4s vs ~2m23s on a recent patch series).
> 
> Supports the same usage patterns: patch files, mbox bundles, git commit
> ranges (-r), last N commits (-n), and stdin. Implements common style
> checks (spacing, line length, spelling via codespell) plus
> DPDK-specific forbidden token and tag checks.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
> v5 - revise to cover more and have less false positives
> 
>  devtools/dpdk-checkpatch.py | 2062 +++++++++++++++++++++++++++++++++++
>  1 file changed, 2062 insertions(+)
>  create mode 100755 devtools/dpdk-checkpatch.py
> 

<snip>

> +
> +                    # STRNCPY: should use strlcpy
> +                    if re.search(r"\bstrncpy\s*\(", content):
> +                        self.add_result(
> +                            "WARNING",
> +                            "STRNCPY",
> +                            "Prefer strlcpy over strncpy - see: https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com/",

That's not the link you want for that. While it does, in fairness, point out an
issue with strlcpy (which also applies to other fns like snprintf), strlcpy
is still far safer than strncpy, and currently the most widely available
safe replacement. I think a short message saying to use strlcpy over
strncpy is sufficient.

> +                            filename,
> +                            line_num,
> +                            content,
> +                        )
> +
> +                    # STRCPY: unsafe string copy
> +                    if re.search(r"\bstrcpy\s*\(", content):
> +                        self.add_result(
> +                            "ERROR",
> +                            "STRCPY",
> +                            "strcpy is unsafe - use strlcpy or snprintf",

Merge this check with above one, no need to check separately for strcpy and
strncpy when both have the same replacement. Also, no need to mention use
of snprintf in the message. Suggest join check with message:

"Use strlcpy over strcpy/strncpy"

> +                            filename,
> +                            line_num,
> +                            content,
> +                        )
> +
<snip>
