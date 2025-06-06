Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE70BC5AD49
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 11:02:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8480B4028B;
	Fri,  6 Jun 2025 13:02:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id EDBE74026C
 for <dev@dpdk.org>; Fri,  6 Jun 2025 13:02:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749207753; x=1780743753;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=G4Sba8y01GXIqM5g01g0SOMbSRQduILbcMceyIu966M=;
 b=VYEFC22UI1xOWUnzdgLBSZg9Wf4pJ3ocB4xamw6ZbZbLPgUvEuavvB0i
 NAmNQIAup4tJ91r9ivRUreUMZHoBS0d9ulLoa/7fmPzMVqoW0YXK1c9Yy
 D7CvIFRfJWEN6OliwhQGTsLkMg4gnDyb/bkK6ORVpx3ojFJX1mYYKnGh4
 fCcwnJYBha+c0knfVhDo9toJ+gWjh1rfD82Mk+7wmFLTHgjxOvUNn85N2
 giepp/vU+oYpT9H06CEaGe8jw2dmyV8MAAPLd8xw2oGQ2utilR//yu0a4
 MW8RJcf7xY6/Nlgm5WWWxf0oECKpx+vWCaIZBoG6pCoQGXpVdzx6vDrcW Q==;
X-CSE-ConnectionGUID: SkcMrQJPQQSw9oHyyuKcDg==
X-CSE-MsgGUID: AJsPK9/ZTkucE2MzFzw+vA==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="51234502"
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; d="scan'208";a="51234502"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 04:02:31 -0700
X-CSE-ConnectionGUID: qo3FHp2QTkSElV7T/0lnhA==
X-CSE-MsgGUID: f2UqxLGdRFmJvL4xjrDXDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; d="scan'208";a="168980236"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 04:02:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 6 Jun 2025 04:02:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 6 Jun 2025 04:02:30 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.88) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 6 Jun 2025 04:02:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/i1Bo7Bm3jXNN55nNllCGNNE4fxDOY+l2dg4q+nidVH+CdzqVDXtuWwjfd/pb41BRVTMQb61Bw0v2r+TF1ZG2o0Ds0aOets9f9OsW2GWQ6SmZkw+Yl+d2KDcaToahXXaftBFul2sUzmTz6EPfhbYmfXnH4UAy/nNaiK1vJyXVCPraCLwWhx/C7LUn34qiqlIJohhKnhLIHW8hI+KZyV42UzqELDJdYUPDMz8gkMls3q6v6yFUBAeeHjH3QeUglQ7D7LiCouVlduR9niDtalxStpaxCfLMAq0HSJ7Gwnf8fiNvS/1CdM9cpBk9HrWgpfezb6uhsmWRV8O+Q/BQlZhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxULYJB12SBWxHylAJ3oDsD+Ro3GjRQT819SAqr8vlo=;
 b=r0ruJmadL450EOLLDXBw9rO1Wm+D47V1NRvlHI4RGO0mxp9+NLjlKFXQwgcv1DFjQ0QLqHxNaQyhT6wQksMFLfSNjNXn6bKucZVOoaqupd0z5Qm02j0K3WzH/JI2WGdlXObmkF0n8Wa4wdhgwSU8vDSaPF0JZUOS4rJKzKiecmJAYYXcILPtJkryeeIov0IwCVCot8OkYchkfs5xvd9DkpJyYfr1f0JVBIKKjghaNK6+Eg7RwLjy7nyLYy2/WOVI+tTxc/fx3afY9C7Xb2U32nn+UmwnYq9lNaaN3ZYj9dbghFMNdQjft1gQG0zL8UpNTgI2khewhjHt6nAW3yhv1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB7115.namprd11.prod.outlook.com (2603:10b6:806:29a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Fri, 6 Jun
 2025 11:02:25 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8792.033; Fri, 6 Jun 2025
 11:02:25 +0000
Date: Fri, 6 Jun 2025 12:02:20 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Jake Freeland <jfree@FreeBSD.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] kernel/freebsd: Allow contigmem allocation in NUMA domains
Message-ID: <aELKvDCSbPL-kWuN@bricha3-mobl1.ger.corp.intel.com>
References: <20250506174941.1141140-1-jfree@FreeBSD.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250506174941.1141140-1-jfree@FreeBSD.org>
X-ClientProxiedBy: DU2PR04CA0272.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::7) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB7115:EE_
X-MS-Office365-Filtering-Correlation-Id: 72412c18-bde5-4239-b7cf-08dda4e99ebd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G5ceS0wzQ+i/jWkzKW6qa3mT+fOXgvkHBKngLonSe4iheGScbj8V4mZphRhe?=
 =?us-ascii?Q?LnjBdxLZtq9aUuUyvloZf+FgISDzs/oOXqvqgrtM6P1mtivnrXmP2ugxg7dN?=
 =?us-ascii?Q?t+y50i9GQtnTngMcFrkOAkL4RCDSvgqKpLdJNCemg5WAlQitTyNaG7JM/92h?=
 =?us-ascii?Q?Fr99DoSyJ7xaisLEWtwSdTC6hblDQDmbN48tgDrMRJKbOxOut6xGoOT+ENYe?=
 =?us-ascii?Q?QRMz85O+ASW0ENj5L0S3s+Ji4VhidVdQoCKCospz1NUou0k2/2oqdnYPlOT1?=
 =?us-ascii?Q?mtvAfbKduRV0gjzCsywHjY/Pe69cYWbY/0RPNywnvKu92BtIO8vCELHG3LmC?=
 =?us-ascii?Q?6UWuFC+T362tzuEZhhLB25J/QbI+LWY9mXHdPLjarH1JF+fhjTYHUlKHTC+b?=
 =?us-ascii?Q?FZIU9VT9Sp4ipZdoq4sGvJGnBIusgwHRpvC33oZIVVwF1ZlxO9sBYlOyZgFn?=
 =?us-ascii?Q?re9IfRzsgBYqwV5gNkwFSpP9skO0DR1tjE1APA+yQ55B7ElMR2GQvjUcdZJR?=
 =?us-ascii?Q?TO3TJxe92FOj7UsoMjS4N18+K0FwJ20hfKsa0UZAyoWa7BO+e8ilLGQTXegn?=
 =?us-ascii?Q?3n/sF9sz4eYAjX53J0dMYNlUBnD9242m4jAjTJGUUUXdo+OqKGT2ZLNgAh84?=
 =?us-ascii?Q?nKmEIdhEy9D2/XR2rPAwcaycj5J1zfqmo1qtskNnx/chz23kVXdYnh8MEKVt?=
 =?us-ascii?Q?lzppsDOa28xKz0Jz7YKtpakrpQiTM8DCk1wDhqOG9l0eU7ZKnfQkh6FVNFIG?=
 =?us-ascii?Q?CdaCkPAzKrQedUZ49+NgMXM270AikXY7hXGTOP0l2Zw1WZnFcnykiowO+Lvs?=
 =?us-ascii?Q?kanbR4OMXcaE69mgjrW4U02Ynjr1Fd1clnnIU0u4Peiaf8W7xFZ9car5gc9F?=
 =?us-ascii?Q?Bw7X8FQQRBSj7K4Wl2/nRplLFWzsN1tKEublmUL9SpFBU5e/ozrNuCxYE8Le?=
 =?us-ascii?Q?4LJw+1/5oPh9kt+4c/8qr6x15WYOzjq1YbenuDhSYsEce1BTiOhbM8YXEoGA?=
 =?us-ascii?Q?s2DVWNZaXG/K4e2gid/lD5rDiKz3yKRuBn6zDuzwd4B5+jN+0B8cmm9MzYX4?=
 =?us-ascii?Q?1TOSmU4n38Qed/oa4kCNy25B1d05Bj1rRFiM7O7cz43ShoBX6EQmSDYohMrv?=
 =?us-ascii?Q?zjjYr4+zA5OzaQ8p/164edw1/RO6L+GhSJjRYI2CLRpsnk2WycoiylkRkb3j?=
 =?us-ascii?Q?oFfd3uvgFHn4r31IHVBUHVBPl+3ZKQtFXC96lrwfEap/H/Y6V0c/2p8LqC1I?=
 =?us-ascii?Q?Bv2aIaBgWzG68L4krgtrB/CgdzXh+KB1xfhIF6x2N/WK5ZGayLQjcCKDBeQP?=
 =?us-ascii?Q?iO9uvI7gPyPpPC/TPALp7WZ/jHYYZ05+mQYlOOLDO47L8drJ6AsfWSobn3TJ?=
 =?us-ascii?Q?W+rAM38Cx21Z7CIgSd06131XZRDyKBAUvp9KsCMRFFu9p+mmLC1WxLkFCCd1?=
 =?us-ascii?Q?NKhNGa/6k/8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VF8j3OGT6M78+6lczTXb66dvE5mACmbfIPrxRIPJU+M06k8qBzsmLSlaJRXr?=
 =?us-ascii?Q?zGaF5h+MQWWzy8GZZu5q40Rmf1HvI7+x0Wsh53q09l4un5SXiCbYdctONy93?=
 =?us-ascii?Q?Tl3SZUHY1CChdJOXICkZRR/3hTgywU+QqZcx1eyA1e0XeQAf76Fos5NmTafV?=
 =?us-ascii?Q?pPlP/bAvVZVHVBezNchU2sjk2rpgPLfBsfEb3f20iP8N6tAtvwDjasyrcQ+K?=
 =?us-ascii?Q?mIlYNL1+MiZXINylwxxJr8yODx4FdZ3ciHscDQIw0KyQAMIXiUoUDPz+M1rV?=
 =?us-ascii?Q?izIGE/LSQu9qfXQo0FqMR5+yZNKFOMQ7M0sXqu2Iz/g2AQAXjqoMOps/rLMI?=
 =?us-ascii?Q?csUbixcMJVhqo92ffmMnW8fKgvKO3U5iaAAOmUnPciypRIxnoYJRut1FMYMS?=
 =?us-ascii?Q?ukFNDf0wQ22tmMYr3c9DphrR0r+9T6co39VUphc1r3a6jWTDUA9fudU5IKzm?=
 =?us-ascii?Q?Eh6/z8ZAInWPv3DKATwgwc74qMC/uiEsNLpBIwLQU0RnjBxohYH4HzE70c6L?=
 =?us-ascii?Q?PyBIYp+p4cAz5i5gji1IjY3G/ad2KFDkFKd+2lepvBJOR50UFIFKPqg0fgfp?=
 =?us-ascii?Q?mifUusnj+mfgmmp29Vs93WTmmopUcOU9J7KwIcpqfqIUXkpbWq5lbHB8aC72?=
 =?us-ascii?Q?/TIhUZFTHoTb5bNJCI9tFk9l6PMNtcnUhO32eFuCWEgku89IXuqLBJCL+dGC?=
 =?us-ascii?Q?kfak+4Czxf7+TycLQXvK2JbSC2L7jgcmGibVQo9Sj8gUTwuOwzidFwujQCUp?=
 =?us-ascii?Q?FzMl/AfZzX4XZ6cDBJ+tcj62m3C1M/+TlAHRRJUBRZs+sKF4GS52Dm5Nm3F+?=
 =?us-ascii?Q?2EuDk2Nn4xVzA2wPD/LMoqTTz99LIq8FzpsMmROKEbUzoYZLCEZM4w2NHOm8?=
 =?us-ascii?Q?cgbzwSbOoIcnLweuIaUaV/BMgVujM2ZxEEB+O3O9+6Z7qgQn466D7slGLFzN?=
 =?us-ascii?Q?OaCKojs8+Q8usBXRXfecmKuauNHZMssLIkRQIYBw87i8723sWuae39LPTEr1?=
 =?us-ascii?Q?P7F0PzDPUSCk7ZxEoI/ajz4TkHhlXbNXPOKYF5VFc0ML10C0c4eSlq8bvgaU?=
 =?us-ascii?Q?40HIADqfCaJ9vZsEebt/pJjz+ZKDqL+clzDCMhHY6YJOfFx4HRqKUg4157Ls?=
 =?us-ascii?Q?M/jOAxtQWAbE14+5g89TOWAW51mChsvmpGd1e1q9vGGYBaK6pt/GeN7Xp5jJ?=
 =?us-ascii?Q?Z8p3BWKvxl6C62eGmdffrtyHia5/b5O28rxtaeyApSVjWupzlSBLOgeLOgL9?=
 =?us-ascii?Q?QN2sOAxoJWVlZDrugaOi6yckJJrKagGW3wu0R0qSd8yvSbNjDCu2VEOMj4gh?=
 =?us-ascii?Q?fIrNVJ2QEGDXAsq248AmkphzmakVeCCt/wzp20DfpsgWodLlvDPeSlkLUVZe?=
 =?us-ascii?Q?NbR63ClK9i4W5Yj60Xkl2q/C1ZhgPOM7a6URy5+78BNfv49goeggNObKCRM5?=
 =?us-ascii?Q?BDDCyXhWtHtPFIlYt8SivEItDtCyu7nKp7MIJAD02x6PVAd6Ipod7DGNkhuT?=
 =?us-ascii?Q?4hQ/V9nZgCv993dyWTjFsS9pG/Sn8V9lISbWXs+czItQFwASKYLMC1sAwU00?=
 =?us-ascii?Q?xmovawlvXHqK1IbgFTvVlqP+v+a33k+WCJLN1LYLmWTAF8/yE9lKspMqHYgL?=
 =?us-ascii?Q?JA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72412c18-bde5-4239-b7cf-08dda4e99ebd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 11:02:25.7364 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sjj2QaeZyy345ofPbuJIFee0TkUgDp98kO8DGe+AqOWygbur+5nqlKbukdU6Q5tf6oZXwrzIuO7UEQ5Su8Kr8L6OQ4Xo6irbwG3ZKjaAYfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7115
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

On Tue, May 06, 2025 at 12:48:38PM -0500, Jake Freeland wrote:
> Allow the user to specify a list of comma separated NUMA domains in
> `hw.contigmem.domains` to allocate memory from. All contigmem will be
> allocated in an interleaved fashion across the specified domains using
> the DOMAINSET_POLICY_INTERLEAVE policy from domainset(9).
> 
> If `hw.contigmem.domains` is unset, memory will be interleaved across
> all NUMA domains on the system.
> 
> Signed-off-by: Jake Freeland <jfree@FreeBSD.org>

Thanks for the patch.

I think it could do with some documentation including some usage examples,
for the user to know what goes in the hw.contigmem.domains parameter. I'm a
little unclear myself on how this new setting should be used.

My own thoughts on the general problem is that the memory allocation per
NUMA node should be specified in a similar pattern to that done when using
the DPDK socket-mem parameter. So, for example, to allocate 1G on each of
two numa nodes, one should provide the value "1024,1024", or to allocate
only on NUMA node 1, "0,1024". Something similar would be nice to have for
contigmem specification. [Using a string rather than numeric type, would
also have the advantage that we could further improve usability by allowing
"k,M,G" suffixes on the numeric values.]

What do you think?

/Bruce

> ---
>  kernel/freebsd/contigmem/contigmem.c | 66 +++++++++++++++++++++++++++-
>  1 file changed, 64 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/freebsd/contigmem/contigmem.c b/kernel/freebsd/contigmem/contigmem.c
> index 591e46dded..01234567df 100644
> --- a/kernel/freebsd/contigmem/contigmem.c
> +++ b/kernel/freebsd/contigmem/contigmem.c
> @@ -9,6 +9,8 @@ __FBSDID("$FreeBSD$");
>  #include <sys/bio.h>
>  #include <sys/bus.h>
>  #include <sys/conf.h>
> +#include <sys/ctype.h>
> +#include <sys/domainset.h>
>  #include <sys/kernel.h>
>  #include <sys/malloc.h>
>  #include <sys/module.h>
> @@ -53,6 +55,12 @@ static int              contigmem_num_buffers = RTE_CONTIGMEM_DEFAULT_NUM_BUFS;
>  static int64_t          contigmem_buffer_size = RTE_CONTIGMEM_DEFAULT_BUF_SIZE;
>  static bool             contigmem_coredump_enable;
> 
> +static char		contigmem_domainstr[DOMAINSET_SETSIZE * 2];
> +static struct domainset contigmem_domainset = {
> +	.ds_policy = DOMAINSET_POLICY_INTERLEAVE,
> +	.ds_prefer = -1,
> +};
> +
>  static eventhandler_tag contigmem_eh_tag;
>  static struct contigmem_buffer contigmem_buffers[RTE_CONTIGMEM_MAX_NUM_BUFS];
>  static struct cdev     *contigmem_cdev = NULL;
> @@ -61,6 +69,8 @@ static int              contigmem_refcnt;
>  TUNABLE_INT("hw.contigmem.num_buffers", &contigmem_num_buffers);
>  TUNABLE_QUAD("hw.contigmem.buffer_size", &contigmem_buffer_size);
>  TUNABLE_BOOL("hw.contigmem.coredump_enable", &contigmem_coredump_enable);
> +TUNABLE_STR("hw.contigmem.domains", contigmem_domainstr,
> +	sizeof(contigmem_domainstr));
> 
>  static SYSCTL_NODE(_hw, OID_AUTO, contigmem, CTLFLAG_RD, 0, "contigmem");
> 
> @@ -75,6 +85,8 @@ SYSCTL_BOOL(_hw_contigmem, OID_AUTO, coredump_enable, CTLFLAG_RD,
> 
>  static SYSCTL_NODE(_hw_contigmem, OID_AUTO, physaddr, CTLFLAG_RD, 0,
>  	"physaddr");
> +static SYSCTL_NODE(_hw_contigmem, OID_AUTO, domain, CTLFLAG_RD, 0,
> +	"domain");
> 
>  MALLOC_DEFINE(M_CONTIGMEM, "contigmem", "contigmem(4) allocations");
> 
> @@ -114,9 +126,50 @@ static struct cdevsw contigmem_ops = {
>  	.d_close        = contigmem_close,
>  };
> 
> +static void
> +contigmem_domains_parse(void)
> +{
> +	domainid_t did;
> +	char *dstr;
> +
> +	int i = 0;
> +	char name[12];
> +
> +	/*
> +	 * If hw.contigmem.domains is not set, then evenly
> +	 * distribute memory across all domains.
> +	 */
> +	if (*contigmem_domainstr == '\0') {
> +		DOMAINSET_COPY(&all_domains, &contigmem_domainset.ds_mask);
> +		return;
> +	}
> +
> +	dstr = contigmem_domainstr;
> +	while (*dstr != '\0') {
> +		if (!isdigit(*dstr)) {
> +			++dstr;
> +			continue;
> +		}
> +		did = strtoul(dstr, &dstr, 0);
> +		DOMAINSET_SET(did, &contigmem_domainset.ds_mask);
> +
> +		snprintf(name, sizeof(name), "%d", i++);
> +		/* We should be adding ds_mask as a bitset. */
> +		SYSCTL_ADD_INT(NULL,
> +			&SYSCTL_NODE_CHILDREN(_hw_contigmem, domain), OID_AUTO,
> +			name, CTLTYPE_INT | CTLFLAG_RD, SYSCTL_NULL_INT_PTR,
> +			did, "Contiguous memory NUMA domain");
> +	}
> +	SYSCTL_ADD_INT(NULL,
> +		&SYSCTL_NODE_CHILDREN(_hw, contigmem), OID_AUTO,
> +		"num_domains", CTLTYPE_INT | CTLFLAG_RD, SYSCTL_NULL_INT_PTR,
> +		i, "Number of contiguous memory NUMA domains");
> +}
> +
>  static int
>  contigmem_load(void)
>  {
> +	struct domainset *ds;
>  	char index_string[8], description[32];
>  	int  i, error = 0;
>  	void *addr;
> @@ -136,9 +189,18 @@ contigmem_load(void)
>  		goto error;
>  	}
> 
> +	contigmem_domains_parse();
> +	ds = domainset_create(&contigmem_domainset);
> +	if (ds == NULL) {
> +		printf("invalid domain string: %s\n", contigmem_domainstr);
> +		error = EINVAL;
> +		goto error;
> +	}
> +
>  	for (i = 0; i < contigmem_num_buffers; i++) {
> -		addr = contigmalloc(contigmem_buffer_size, M_CONTIGMEM, M_ZERO,
> -			0, BUS_SPACE_MAXADDR, contigmem_buffer_size, 0);
> +		addr = contigmalloc_domainset(contigmem_buffer_size,
> +			M_CONTIGMEM, ds, M_ZERO, 0, BUS_SPACE_MAXADDR,
> +			contigmem_buffer_size, 0);
>  		if (addr == NULL) {
>  			printf("contigmalloc failed for buffer %d\n", i);
>  			error = ENOMEM;
> --
> 2.47.2
> 
