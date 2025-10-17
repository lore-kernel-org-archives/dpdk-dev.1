Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CEBCCD195
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 14:06:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C804F40DDA;
	Fri, 17 Oct 2025 16:06:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 201D540269
 for <dev@dpdk.org>; Fri, 17 Oct 2025 16:06:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760709964; x=1792245964;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Yrx6a6WhYJyQ2NTcpghMuNoyT8xK/g7IO86kkBWNk7s=;
 b=iLZBXPsRfE/KfmXZqGFrpxxUosdd4FPBDTu8VNl+fNKniKHADvPv5NPe
 RXfIYUn1iU/ZB59+lHxcSpXuV9fyPre927WjNHCTyeEbFv7qjdijF9sww
 m9zle5MweXW6H6nBt0s20qY6dQUdTPSOdGYPGvZFLs5WOEyb/kGmdNder
 iO/yHo6IqjPqdYLvX6vHQpEYsiWRc0wbB7iw6XpbX7+Pl9Q/k3YwUXL95
 FRE6x6auEc/4/iihC9rStyYrp4fJohVx4qmZeQePqPx/4bkmN5u3+M/1o
 XgNSrzZ/cRIQPlXLuDPZEuXxo8v8yDcJ/Iswjg2V/H4c5AozbtMKf7CUj A==;
X-CSE-ConnectionGUID: WU7LLK4rS22cPB6AFnnm5w==
X-CSE-MsgGUID: NM+D6Bc1Qz6+InjMxbyt2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="62960014"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; d="scan'208";a="62960014"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2025 07:05:59 -0700
X-CSE-ConnectionGUID: G06dw3jkQt2RA81X+VNdxA==
X-CSE-MsgGUID: kbtsClXNQGq6YOoZ2NtB/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; d="scan'208";a="187152048"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2025 07:05:59 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 17 Oct 2025 07:05:59 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 17 Oct 2025 07:05:59 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.15) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 17 Oct 2025 07:05:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUz8gY9+vg8ubS4AerneYJT+Rgmv+kYzHtUpzucXSssxObdW54RzN0kkExhGIziX5sq9dGuVLHlvOWgTf1VhGVHIbfeYHbUPFVhvD4hfltqAFWlfOuxhuZbpi/h3SQXsxtL0xjeSXzUb+rA2Ifm7T0hzsBIWst1icTdjYZzcWurpv39SNYyX2jkPYbhkrD8j4nqWKBNxdBKub1s7fwSGo7NB6i9n4GWS0JIesRQXcNBpk+3R/BY/Sqckui+7xlLYVk+WAlZ72gZOo2Fb1Z+thdnNcIpOPCMCJn8gxScOkN8/mQ/ficV25LB8DRN15emuEg2+eZQ4D8TCzApsT8RyHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYfcwge84ocdNIWOuocjtdRLC+Bq36BGY2VR18bhj+M=;
 b=uIuCR/onNlQzwqXHVeY3XrCJsTutexZ/OFyA2WEMZAmpVijgbQl68UazNxyZDPnUst1rFEqRkN8BHDs2sz1qYocjV/JybG0qzv6b/zv0yPikLVXEToI07RkSs85lQxialvwMpf83kcOpeGc20yssJPLDu+xxTnhlphaFSgMXLS4of2CdCuCd028negYnz3W4PfLe5KcVBmYfsx0ptx5lEQXm6af4KwNeZ6ti3W2hvw7xdB2I2TvqbYEx1+LX5d30AkCfmo3QQshxoliPVjSa0i+Q+EZXzSkwpuBkortoeRSkCCQhyrPgDHbEZrKlKbMDLWts5b4rYw3uaxX+DEyM/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB8781.namprd11.prod.outlook.com (2603:10b6:8:256::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 14:05:56 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 14:05:56 +0000
Date: Fri, 17 Oct 2025 15:05:52 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Robin Jarry <rjarry@redhat.com>
CC: <dev@dpdk.org>, Marat Khalili <marat.khalili@huawei.com>
Subject: Re: [PATCH v3 1/2] devtools/mailmap_ctl: script to work with mailmap
Message-ID: <aPJNQHx2kf1jrZmh@bricha3-mobl1.ger.corp.intel.com>
References: <20250808142721.408998-1-bruce.richardson@intel.com>
 <20251017133812.1109638-1-bruce.richardson@intel.com>
 <20251017133812.1109638-2-bruce.richardson@intel.com>
 <DDKN5IUVL6Y2.3MANZ0QIRGHUH@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DDKN5IUVL6Y2.3MANZ0QIRGHUH@redhat.com>
X-ClientProxiedBy: DUZPR01CA0192.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB8781:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e88ba60-871d-4603-3953-08de0d864a8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VEUABSfA3AQwGwhOT71rgki4LNv+0QsAgJl1RG2c9LKZ49FKUeuf+CeIX1HN?=
 =?us-ascii?Q?uVdx+DQy+jvcL31vz0aqENmmTXPdNP/zB/OnD+Mor9xTNV4AdlG4UdUeJAro?=
 =?us-ascii?Q?QHqDLjNaPxO0c5Ll6Gu2fGS7auiLqAW+IzmU6OsOvBQkV4a6jIFc1dR3ZRb1?=
 =?us-ascii?Q?tOA0al8CxQcBJfEF296SuzLZIZzo7ahwVfgxhS+Mu9OXg4qQ4cFsT3C5jX1n?=
 =?us-ascii?Q?+4+P60mC2+3xeBHm8N99j9v59mcYMzNTUaQ+SFq1s/rxPV7SgZxkX3GsAAOC?=
 =?us-ascii?Q?96rQkDfy+9NITLd4P9Rl5E5uQNlWAoJ0Ziu9FFpByxP86hzzBsm5Lsft4p0V?=
 =?us-ascii?Q?Tbthfe9AEkBF+/05Zyt1l5bBy+vL4Q2JqsgXg7nWw4xeeIHSQbsJ7RTfKaab?=
 =?us-ascii?Q?JUiPHqznczsArUSZWAY1TkCvYeGoMsd8NL7gD2TtQgn/jaJ4YJlDqNCGju+8?=
 =?us-ascii?Q?SC4FKY2OMHT5yQXUFDAVq+5/DAcbjoj3BBq5mkk7gYgkV2R1aRQ3Jyjp0MWa?=
 =?us-ascii?Q?XwgUaYPdX4I7k8nFql+lX3lVPxVgs1J8ovwSor59bR9D7iZ90ghl0mrZI3CB?=
 =?us-ascii?Q?Ldi9omncAIAUlJMhO8jE/RP1wb2XD/dBqSJDED1tvldFwg9knX4HDd1kUihu?=
 =?us-ascii?Q?oyKjj0SNRT09WBK0/asJfjT8vRVeqNgY5N5y3lYTpUInyedYwKk3jzxf/6O+?=
 =?us-ascii?Q?VM+HaQaVd8RGZlFuhd3RJPF5O7fAfdLHTT54eGDfA5VUkmbphkPLcbusz+ET?=
 =?us-ascii?Q?N8Fr1Wmge+IOTdyaElHmLfioAvdiPkp6hrYTHTK3WNChRaABzLi0QP1l/e5U?=
 =?us-ascii?Q?dlkz9baejo6qWbp4jBUPxELgBtJ3Sm4v7q8WJvVnE3N3AdqfHbscH2ATJo27?=
 =?us-ascii?Q?vph62knA1DKg1++JWqXWQqFjI552zRlMrLHClLlwbNseUXkr7NHMa4h3TFd9?=
 =?us-ascii?Q?YuqAeu0vfb0xGGJnHaTYPljm33zb8nroCwmPkrGEyUhhKLEtMPgWKyBlc0uq?=
 =?us-ascii?Q?JYNdLNudYPFM9+s+d3f7ucnCPhxBLyjDN3Bs8gHRx6EXDrSvoxk+WtYqg2lD?=
 =?us-ascii?Q?s/HWufzV7swv0uuB3hOVw8Ow3YgAf7QycVAxjjzDdDxPmbeSFOedawkD06A7?=
 =?us-ascii?Q?tRY6zhXRaXP43GHtu4rxl/qOJMhV+4gF3etxxva34TrHve3CBgItpNJk4wNR?=
 =?us-ascii?Q?pco0bzM13lebdhYDGx4/ltYTf2lB/DTR/cR/YvEUArEhu6xj0MPkq70ah1Xw?=
 =?us-ascii?Q?iubQy1HcN5liRAABt7OCczX/EvvO36w2J/w4thv5TUQGsSn+8IZd6HxaqKyR?=
 =?us-ascii?Q?3yLO2piP24m/MBlQC7uxZ1U+G8WZ0QJuC1C8toRwLeDDXVlORAJdm8TO3euM?=
 =?us-ascii?Q?pbXu8pqsXJ0bNVvplrnb9yIEVp0wNawULMp3/hub/cZ/P12Dn7cnzTRWYw/R?=
 =?us-ascii?Q?ClwHzvaBu+LuodSNQlt0fvODr5EO3p6y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HL9l4zRoc7smrOiyuhOJv5WeS4tPiUQ4F+mVZt3/F8aABrbVTozDRCkBtVWE?=
 =?us-ascii?Q?RSNEBNRmul++eEc9KS8oYm/k0vUipjY/jF+ttzy8062f5gZzpWmf9cs8CkBC?=
 =?us-ascii?Q?jt4ARMeEpVCZ8FU9A/jGtvv0zuEBCi3u8WAwfrYM1i61ugsx+c5oEqdXX78+?=
 =?us-ascii?Q?9xHWVBoOcpURxlidXAEPBz/pd0tnUfzbYNG8RS+0wuKtvlX9gy2y4C4FRcUz?=
 =?us-ascii?Q?57FsgAr04tCoAJJo/3j19zmLQx0okrjcd/6UysLvpFdTjWLc3Yuhn2tOg+kq?=
 =?us-ascii?Q?7QFOnxixWYfS85B7hSbRUXI5yxZdpc68ROT17wF7BUqXxrtpat7zV4Ite8Hv?=
 =?us-ascii?Q?yFGt+dQgnhDH8OFFFU0WRFaeU4LYXDJZvnE5BgXsh30ovn0ObyYLJiV0EX7d?=
 =?us-ascii?Q?wrjoD9W0pIsuIoFm//VZbhLdXwEWAcKC8pqZ1bun8Ve68vikiYPE0Uskg1NH?=
 =?us-ascii?Q?BEfzSmFHXgOOoOYD0uPEaIs+bx0I4GXvxRhlQHv7OAyZgwINJ1c/wPoPYhVp?=
 =?us-ascii?Q?2g2QQZ8EbEshRUwhoufshmrxkHQfwx/ZRW9xmW3Pv8+YSu7yt303UsuGfT9W?=
 =?us-ascii?Q?i3W3p9R6ED0jcRTUnVxBzcl21KMq+QyQQHapPrKKvqL8D3x91bKtPOROoeuY?=
 =?us-ascii?Q?oFqQxCGZr73SswfdWS4hd3JF0r+AoZ7/cFg5g5hSp4ZCpe1XU2s30JoAyoGV?=
 =?us-ascii?Q?XA12pAbmgo57JMDrew36zpGCOnsCV5xX++3dkQNs95cRPuP9DKXtP0P0jIpd?=
 =?us-ascii?Q?dgRJeY+k2oTSyPqQuBh6u4FNQCME04iQAOPuQuKy9hNI7Q4c0rThW1awxb+P?=
 =?us-ascii?Q?1Fkm7ZjDq2faMzNPSVwGwW6OtNfXa2B7xy8AbxfFAs87TRUAgldSLHLWLG9c?=
 =?us-ascii?Q?5pNIo6ZjgL4enMhuXuO8I/pbObLKq/Vo23USrJoSLo8AaB3VYgXkZAQV7hle?=
 =?us-ascii?Q?MrFroCgU51Ssm3zRyLq+mIC+ud2GRFe8mMHagHlyMNXiHeSF+ArXJ4fcUJaY?=
 =?us-ascii?Q?xZ5vFBu4+FQ7ZCNDnAMSIGEeImX5g25wV9Ed8d9lsE0pGUxVSpCu/mgniV2E?=
 =?us-ascii?Q?mM395bghHsYULz7nEcpwNtsvClK71TQeF4LHE9x5D8xpinKiM0AMWEFv6C/v?=
 =?us-ascii?Q?dqLLeCvjvTT6SdhPk6g7hVDer4p/XP5EbslxoX12TVH+S9WVWI7bctFxsw++?=
 =?us-ascii?Q?u5iGdN4Pydp72pwSgi7rQI19ZPTVK00m30pVexJ8AWa6qf78fwc69wJ4cQyN?=
 =?us-ascii?Q?Px8BJudWN90zjIfRUBaILRXAdK2gm41Vg0Gke7vgP0RVjgVP3Y4YBFAfHy5h?=
 =?us-ascii?Q?Udq4I88Vq3yoVzqyo+A754MNtRe0J9wFcmzrHakD/shO38SPsnQ0Q/31jqjW?=
 =?us-ascii?Q?7s/fHpEfNz2V3uRaBlzT97jaGuZVOqKkqplJ1Ae6NgMEENjP0lGtruVv46Xu?=
 =?us-ascii?Q?UhYnD7cvRwa4+E0ESlcdDF3ytd9t+dX97j+9VTKC1krH0t080hCOAMOE5ptY?=
 =?us-ascii?Q?BkcNvgZIxkA/F1Hk8aVrquIyUJtk5a20Xbo9/fJtFlNvivUa8yQjLQq5w5q0?=
 =?us-ascii?Q?oI3eDz3ncVPZekyToXeo1GAIvIo+mUXxw9y36ZjXGyjQU/N08h1yLsTDcXnM?=
 =?us-ascii?Q?mA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e88ba60-871d-4603-3953-08de0d864a8c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 14:05:56.5421 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q0RubmJX3kSvWhG0plwqO2Q6dQthxGVJseoCfQ5ZXOHsRU04O9At/qHil/XXPy4Pw+n1f+qhG4JeqHGtVVvVCuyNO9jOgC26A8lz720vIVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8781
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

On Fri, Oct 17, 2025 at 03:45:27PM +0200, Robin Jarry wrote:
> Bruce Richardson, Oct 17, 2025 at 15:38:
> > Add a script to easily add entries to, check and sort the mailmap file.
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > Acked-by: Marat Khalili <marat.khalili@huawei.com>
> > ---
> 
> Hey Bruce, I only have a couple of minor remarks:
> 
> $ isort --profile black --diff devtools/mailmap_ctl.py
> --- devtools/mailmap_ctl.py:before	2025-10-17 15:42:59.507233
> +++ devtools/mailmap_ctl.py:after	2025-10-17 15:43:03.351551
> @@ -6,13 +6,13 @@
>  A tool for manipulating the .mailmap file in DPDK repository.
>  """
> 
> -import sys
> -import re
>  import argparse
>  import itertools
> +import re
> +import sys
>  import unicodedata
> +from dataclasses import dataclass
>  from pathlib import Path
> -from dataclasses import dataclass
> 
> 

So sort order should be alphabetical rather than short to long. Ack!

> $ ruff check devtools/mailmap_ctl.py
> devtools/mailmap_ctl.py:171:5: F841 Local variable `operations` is assigned to but never used
>     |
> 169 |     """Main function."""
> 170 |     # ops and functions implementing them
> 171 |     operations = {"add": add_entry, "check": check_mailmap, "sort": sort_mailmap}
>     |     ^^^^^^^^^^ F841
> 172 |
> 173 |     parser = argparse.ArgumentParser(
>     |
>     = help: Remove assignment to unused variable `operations`
> 

Ack.

> Found 1 error.
> No fixes available (1 hidden fix can be enabled with the `--unsafe-fixes` option).
> 
> 
> With these fixed:
> 
> Reviewed-by: Robin Jarry <rjarry@redhat.com>
> 
> Thanks!
> 
> -- 
> Robin
> 
> > 98% lean.
> 
