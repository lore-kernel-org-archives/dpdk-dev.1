Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413EACCD1AB
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Oct 2025 09:08:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 10DFF400D6;
	Wed, 22 Oct 2025 11:08:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id A4BD8400D5
 for <dev@dpdk.org>; Wed, 22 Oct 2025 11:08:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761124123; x=1792660123;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=bgZZ2WEuupwQSdeahV8P/hbwf7Fo0gRdbnZGTwI2yT8=;
 b=HOQQR7YanoetGbFfzSmvLrpCBR1ZmJ9PEI4gZ25Vezu1mhxqs//V7djC
 +ZOrfzm4tdJBvbKSmto1TQawEJgqEwiQMNlH3y6zxVMwitO/5PIqVdItN
 xF3CpVZn08fFZ0bymChYUazTkrtBW+anw5jE5t67t7cjs70wQr4f+IXM0
 A25z0ER4hRYs7Fh6IUY0F60cv+rmzt2vsJUgoNHnngLMCkZKd9qQPnmwL
 iD76moFns0R5Jlgn1/cxtXwlMxxeNq5EKCx66EmrRNZsNaZgULIqtoT+P
 5uQ+kqrbWUFQGTm20HApFKZxhl4nlVeU+ZcN87OF+d6PjDSfxzJXTHS4i A==;
X-CSE-ConnectionGUID: eGf8AlV/SGaiMCkoHD30KQ==
X-CSE-MsgGUID: MQMFjslyQOiXfpG9+wMVGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67102971"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="67102971"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2025 02:08:42 -0700
X-CSE-ConnectionGUID: oznlqloFQZSKzlTYbDhAsg==
X-CSE-MsgGUID: RDR/TyVUSta9i9+aEE2GVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; d="scan'208";a="214464352"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2025 02:08:41 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 02:08:40 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 22 Oct 2025 02:08:40 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.10) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 02:08:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OzzNxAtnh8mPj6B0YhoO6Tcy3BI5DPiS4tuQ985y58/jp9zAWr4nOEtnLIPjUSIZ3hgcxzjwvsowqG5pKikmc0r3NsW+NbEZPTtwMGx/irAImSRnKTnU8f5hSUOYi8dBF3KrN9df6MSry01GcMTvETZRSKKv9uB8UqZPGsBIvsKTkn0GX3CttHkm4mPZbYL6ApkZdRyFmFdYYJF7y/JYZWFRNDc+8rCgFCawOj8bZJT3qY/Ztrf0Nf0oiU3XkQPUiFP84p8GAT7ss4U08n+w8Dec9ISlQKOEBJjdqnSlaPuuV3oBqd3OlkU/njevlttmu6jPqD1cQ6f9z5O70TXEZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHIO1JbzHZSP1dSCUJ8WSqPX8nrNyDKPmrhr83kHSBM=;
 b=VBrZHPHvkkK8H46H4+O7B5U0IyxoHqUJJEZqUKcdER8C8elviD3w/yDZV9Hoez5V+dzpgMwUE0lfMxPPp2IBdo199e4L4f/qaWGTgR8+xyqIMt/UUIlN3ygzpjIbe2tmFY7DW0UB4nO+iqn7hsvJgsw2bs+mrdDXoD3lHMxr4NbnQh10fqVanI3ZFbOafMpULgfu+Lyvh1RWDeDq6I7Qn7WhlAxmMmNFbDgNuLsM4mA+LvcfXIXM/515W2r2IJilBBi25bFOeHFulN0y2BrBAbfVt9aPHc9Bu+R0FuuEc5NMg9n1rRhro3clJR5oEBGOxcqbCNP8ETwCZbsb0pLUfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB8252.namprd11.prod.outlook.com (2603:10b6:510:1aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 09:08:33 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 09:08:33 +0000
Date: Wed, 22 Oct 2025 10:08:29 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, Stephen Hemminger <stephen@networkplumber.org>, "Wathsala
 Vithanage" <wathsala.vithanage@arm.com>
Subject: Re: [PATCH v2] mbuf: optimize segment prefree
Message-ID: <aPifDTMMaD2FRMun@bricha3-mobl1.ger.corp.intel.com>
References: <20250827213535.21602-1-mb@smartsharesystems.com>
 <20251020120202.80114-1-mb@smartsharesystems.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251020120202.80114-1-mb@smartsharesystems.com>
X-ClientProxiedBy: DB7PR05CA0034.eurprd05.prod.outlook.com
 (2603:10a6:10:36::47) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB8252:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d7c5e1f-eb96-4fbe-bd05-08de114a9393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?3SLWJzy9TJGk7CItJM242QFO5cnlZDkqyh66rR5ORmcUq0aWRyE7bpgdgf?=
 =?iso-8859-1?Q?IZp9LAQPXC+ba8WTmiKG5uQBk7boOc2YFB1DO9qItkL7WQPgQe4fYxzLXE?=
 =?iso-8859-1?Q?CVyMIZhWnTFiFr6d4bkTtpvL+EEfwNQjGcjJFVjA+Ocu+dHn2dq/sh7GbW?=
 =?iso-8859-1?Q?7Hi0ilOhwHErLJ3prT+M7kiRz/1Tbf6DBsOnxg6aIJZL6rLt3pkbHgEDgS?=
 =?iso-8859-1?Q?Ada5tWnyEW5zgOyZxofP9oUQx6jK2Uv3rWT4ILVZ3JuRv6Z6ILgxie1Ivg?=
 =?iso-8859-1?Q?5YdBGWnrGksYeGWFd4rwRzNUBZXow3wJsAhv7EzEnMYmdVt+XkFXK0OPNK?=
 =?iso-8859-1?Q?HxJB2Yung9CeaWYaLIiI+fq6GXkzT4GRuS9LzrIsBt7T4ahX6fFkKgvaee?=
 =?iso-8859-1?Q?L2D/KYaxqOG/s66rA8mPqrzL1al/Vs+Oh+2DMMosUUQVplW0c2VOk+Fuxc?=
 =?iso-8859-1?Q?phQEJctd0ntrXRjnOnF+ixZN2km49igTpE0bWXbuKzJXeTntzPGDHoQslx?=
 =?iso-8859-1?Q?YTYd/KOjswf+JE0VOZXOvedbPAhYuDh1Fg/13EA6rFfElcy1lp3hrPPxux?=
 =?iso-8859-1?Q?LpyzzGngtUZOzYELJq70QfTyQpDZrF1MlOMrCF78pNevbj5uPgGomlT1eK?=
 =?iso-8859-1?Q?wLXIG/qzvNv1JL73FckOjqN4A5FHMeOwg8ZhxtQ+XKMknNLIss+J5eHXTL?=
 =?iso-8859-1?Q?YXMq+v6rq7NXRoFnjHaoKPQJaWPSv4JzZKh2hIXjMi1LbhVNYTfdXH59hx?=
 =?iso-8859-1?Q?FJSr/DaLvk3aa2LYnGem63numcISepkWFt8Te7wgnUuEXeM8r57b2wQL9Y?=
 =?iso-8859-1?Q?vKjS3YUCnKCVRxzezYZ1pqXRwzcjB2hHSeCztfFmGUgqQE6XMCiGCAq0C+?=
 =?iso-8859-1?Q?gxLtogXB2i0VrVmmM2A6SqGmxmrahmI9g6jaTK0m/DlCRvUr+FkVqY+WkU?=
 =?iso-8859-1?Q?fSPttNU4sMNXDkFiqYk+m6g5wX1bckeJMgBDKYnrsnS5J9VlDhpvwMfznx?=
 =?iso-8859-1?Q?O2ANz2VseiICM11GSd7vlUWjFd9wEJ8QbU6+7ykbB/YZWquc5zYp9oDfwp?=
 =?iso-8859-1?Q?IgRmUWr8AkuLNKlW4MsuUeU09UGoKN1tTz8LHAvyCD8VZ505TSJ/xB7Aqf?=
 =?iso-8859-1?Q?ckfcu7DWFLCEz6cs2PamdyPV34O0aSuricGbFLdKEEqKEdmtt87qz0J/61?=
 =?iso-8859-1?Q?dTfrZy8IgKaPEw/3ysoFF2586fCGgMvseRASGHG9BWnMwqmjxn1kOiXmJG?=
 =?iso-8859-1?Q?TkxwZFhfa/Gkponu62jduJjBnyi2tNalbYAg3m/N5+ivLFYjSoOyP2j4nf?=
 =?iso-8859-1?Q?ZhbBwrrA0nqP/LW0Ai38yjR/4s6ePpwVCl/s/9xmJjG+s0gbcMCVDTkhc8?=
 =?iso-8859-1?Q?2gBRSOXVLPpFxwXKK+ErFBdl5o91Qe4pzU6Tzi6fgVaL5WtUFbx+j2vs5h?=
 =?iso-8859-1?Q?WVPUnUXzT7Pea1eFUEjKX7l7WvV6zdpFKUOrxA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?bzCc2TlW4n5rYldvr4wLr77nQ/BjNLjKTbjWyuJcdKqNScb57+6NvEWTjK?=
 =?iso-8859-1?Q?7Lq8rp9/nVH5o0g5L2soiAcTOBKzTEVYdyZ1V4BGAXUzASHdFMTLt+Ghnk?=
 =?iso-8859-1?Q?FeDjNQbu9K0Fb+cmfShDEz96SAla0+rh9b8bgJw0yzv29VHrsH10Zy4aDX?=
 =?iso-8859-1?Q?8EP+khinSTNotwgO5LW8qhpIySlBKu4dFB2bGHga3EGYwEMKgqZL24Cxqk?=
 =?iso-8859-1?Q?l7zySgV6dmwkLAyQs4rYNXNj5UJj+Fck9CBoV/MUSlpzozUn2naU3aegSW?=
 =?iso-8859-1?Q?B6AJ5+GmeQ3839+xi1HwaxJ8kcu/0+pWtVj6JUJ4ntGxH013e6grUBli3/?=
 =?iso-8859-1?Q?3sCG4Rr/38KSTg5JdD3I9uvwjbIw7C0jCbC7I2y90JE0ll3wQp/63AsM5t?=
 =?iso-8859-1?Q?Y5+Oy007TxfvID+8nmjRxODY5CyqWeoD42jP18q0zWpc1SDIQug4gkEp/s?=
 =?iso-8859-1?Q?XlR8HkBSEvA9sf2qXCWL6H+la0l0LkF1PmohP6VKdIfmOWhjxWcuU9zvkK?=
 =?iso-8859-1?Q?Ao1r2uYRe6IF3Xo9b1OTjseQ88lNxBy2vV6q0JFbj07Bs8Cd8Bq6jbLxjM?=
 =?iso-8859-1?Q?lS2OAfPBkKhqwxBbqldFVEtFw5JBahwpE1MELTzG9UbvXNObYNoEfhbx71?=
 =?iso-8859-1?Q?5fUGslpZqC8QoUdnCXd9opTNjgiRVsaI1Ob20jWeFBEVwTTSfTXMOv9PPT?=
 =?iso-8859-1?Q?gufuB7qalFpAz/55vbMNkuRRUiZ6brUzHXObs7x5Wu6eO4XEZexGdKJBIK?=
 =?iso-8859-1?Q?C5ZbqdkJrL3Vy7iyhqoZ0cMy8D2LWC515l6w/zGgwKESZ+BYmgBGav6fGT?=
 =?iso-8859-1?Q?7tn/ionDTkAIT1EGMs4x/T88uimQzGHWU+79MnoBSt+h4hingECqhKmNAf?=
 =?iso-8859-1?Q?rRsZ8omi0PEWdxS0Cx/Fug3ZGbZBCZqyC+Sp9DVJh3M7KPECnGA9rQc4eg?=
 =?iso-8859-1?Q?p/Qayf6l4VQAPzSr6X/DSLgXmMLWWAmvZ9CUqqXtSRZiEhS38WKJcgw5zb?=
 =?iso-8859-1?Q?cW2L3l4687CR7gbtCFx2dQCGuFejfJCCvCOQjvGPvI2Lh+kKh4Xro/IyZi?=
 =?iso-8859-1?Q?s/KskFIPREmL8WYfwNjLXV8UWrvk+p/B14B4Hy7GIb0uxSJZQZoAkZMUnJ?=
 =?iso-8859-1?Q?sx+SOuC7Dp8eZdw+PZDeBqFdlNHvs0q1s96S/M0vEBqF1ZP8QNmOKRQy3Z?=
 =?iso-8859-1?Q?8yjaBFpMwQJFdN+sw+CV3touKhEaO6h0iOP1JyWKIK6RIAQOnQXlTTtmo2?=
 =?iso-8859-1?Q?y56BFoyVJ07lvxWwO+Eb+zKesiDo+Wt+8g50kbcnTT1qeuX2Xuxbv8cVvQ?=
 =?iso-8859-1?Q?AyKjr9OnYUjT/M+lR2hoRYd/1kJXRVyGgAKAmkEEj8P7jS5PAGU+rcJhZz?=
 =?iso-8859-1?Q?4PiFDtmBicPAQ+7GTG86De7hd0z5rFMsOWI7imxfbrbqfkiWWXwRvUxyBz?=
 =?iso-8859-1?Q?zWQ5grgFHlLksUc/DtOW+V/qyWebURlK8KbO4DO72B+2XsiOZT0INHPORC?=
 =?iso-8859-1?Q?hRp+vl2ZJGFWiMEV1QOVcdb9W0YphdLy3ulVeL4TpxzDkGzH38eyOvlypO?=
 =?iso-8859-1?Q?5cL8DieRRqZDl7eCUSj6YonrAhTcsFi5DVkRQfk5JYjbeeB85LUXwQm+jN?=
 =?iso-8859-1?Q?Lffhz/jMNuusjwkxNQ/w3hffBA5v0t++XkiYfAPH3POdJDzO/pKZV0iw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7c5e1f-eb96-4fbe-bd05-08de114a9393
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 09:08:33.6407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KnfpLQd0uSTbW8y8iVGXh+kVFHDvgq5b7CZa4mpl0qMy1+fIlQTUQzM/7MmHH0ThR+uolZexwhN+FOe0MDMug6Pa0XqR9SB6x19m+U7NMjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8252
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

On Mon, Oct 20, 2025 at 12:02:01PM +0000, Morten Brørup wrote:
> Refactored rte_pktmbuf_prefree_seg() for both performance and readability.
> 
> With the optimized RTE_MBUF_DIRECT() macro, the common likely code path
> now fits within one instruction cache line on x86-64 when built with GCC.
> 
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>

Reviewed-by: Bruce Richardson <bruce.richardson@intel.com>

Comments inline below.

> ---
> v2:
> * Fixed typo in commit description.
> * Fixed indentation.
> * Added detailed description to the optimized RTE_MBUF_DIRECT() macro.
>   (Stephen Hemminger)
> * Added static_assert() to verify that the optimized RTE_MBUF_DIRECT()
>   macro is valid, specifically that the tested bits are in the MSB of the
>   64-bit field.
> ---
>  lib/mbuf/rte_mbuf.h      | 51 +++++++++++++++-------------------------
>  lib/mbuf/rte_mbuf_core.h | 27 +++++++++++++++++++++
>  2 files changed, 46 insertions(+), 32 deletions(-)
> 
> diff --git a/lib/mbuf/rte_mbuf.h b/lib/mbuf/rte_mbuf.h
> index 3df22125de..2004391f57 100644
> --- a/lib/mbuf/rte_mbuf.h
> +++ b/lib/mbuf/rte_mbuf.h
> @@ -31,6 +31,7 @@
>   * http://www.kohala.com/start/tcpipiv2.html
>   */
>  
> +#include <stdbool.h>
>  #include <stdint.h>
>  
>  #include <rte_common.h>
> @@ -1458,44 +1459,30 @@ static inline int __rte_pktmbuf_pinned_extbuf_decref(struct rte_mbuf *m)
>  static __rte_always_inline struct rte_mbuf *
>  rte_pktmbuf_prefree_seg(struct rte_mbuf *m)
>  {
> -	__rte_mbuf_sanity_check(m, 0);
> -
> -	if (likely(rte_mbuf_refcnt_read(m) == 1)) {
> -
> -		if (!RTE_MBUF_DIRECT(m)) {
> -			rte_pktmbuf_detach(m);
> -			if (RTE_MBUF_HAS_EXTBUF(m) &&
> -			    RTE_MBUF_HAS_PINNED_EXTBUF(m) &&
> -			    __rte_pktmbuf_pinned_extbuf_decref(m))
> -				return NULL;
> -		}
> -
> -		if (m->next != NULL)
> -			m->next = NULL;
> -		if (m->nb_segs != 1)
> -			m->nb_segs = 1;
> +	bool refcnt_not_one;
>  
> -		return m;
> +	__rte_mbuf_sanity_check(m, 0);
>  
> -	} else if (__rte_mbuf_refcnt_update(m, -1) == 0) {
> +	refcnt_not_one = unlikely(rte_mbuf_refcnt_read(m) != 1);
> +	if (refcnt_not_one && __rte_mbuf_refcnt_update(m, -1) != 0)
> +		return NULL;
>  
> -		if (!RTE_MBUF_DIRECT(m)) {
> -			rte_pktmbuf_detach(m);
> -			if (RTE_MBUF_HAS_EXTBUF(m) &&
> -			    RTE_MBUF_HAS_PINNED_EXTBUF(m) &&
> -			    __rte_pktmbuf_pinned_extbuf_decref(m))
> -				return NULL;
> -		}
> +	if (unlikely(!RTE_MBUF_DIRECT(m))) {
> +		rte_pktmbuf_detach(m);
> +		if (RTE_MBUF_HAS_EXTBUF(m) &&
> +				RTE_MBUF_HAS_PINNED_EXTBUF(m) &&
> +				__rte_pktmbuf_pinned_extbuf_decref(m))
> +			return NULL;
> +	}
>  
> -		if (m->next != NULL)
> -			m->next = NULL;
> -		if (m->nb_segs != 1)
> -			m->nb_segs = 1;
> +	if (refcnt_not_one)
>  		rte_mbuf_refcnt_set(m, 1);
> +	if (m->nb_segs != 1)
> +		m->nb_segs = 1;
> +	if (m->next != NULL)
> +		m->next = NULL;
>  
> -		return m;
> -	}
> -	return NULL;
> +	return m;
>  }
>  

Nice refactor, much more readable, thanks.

>  /**
> diff --git a/lib/mbuf/rte_mbuf_core.h b/lib/mbuf/rte_mbuf_core.h
> index a0df265b5d..41f40e1967 100644
> --- a/lib/mbuf/rte_mbuf_core.h
> +++ b/lib/mbuf/rte_mbuf_core.h
> @@ -715,6 +715,33 @@ struct rte_mbuf_ext_shared_info {
>  #define RTE_MBUF_DIRECT(mb) \
>  	(!((mb)->ol_flags & (RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL)))
>  
> +#if defined(RTE_TOOLCHAIN_GCC) && defined(RTE_ARCH_X86)
> +/* Optimization for code size.
> + * GCC only optimizes single-bit MSB tests this way, so we do it by hand with multi-bit.
> + *
> + * The flags RTE_MBUF_F_INDIRECT and RTE_MBUF_F_EXTERNAL are both in the MSB of the
> + * 64-bit ol_flags field, so we only compare this one byte instead of all 64 bits.
> + * On little endian architecture, the MSB of a 64-bit integer is at byte offest 7.
> + *
> + * Note: Tested using GCC version 16.0.0 20251019 (experimental).
> + *
> + * Without this optimization, GCC generates 17 bytes of instructions:
> + *      movabs rax,0x6000000000000000       // 10 bytes
> + *      and    rax,QWORD PTR [rdi+0x18]     // 4 bytes
> + *      sete   al                           // 3 bytes
> + * With this optimization, GCC generates only 7 bytes of instructions:
> + *      test   BYTE PTR [rdi+0x1f],0x60     // 4 bytes
> + *      sete   al                           // 3 bytes
> + */
> +#undef RTE_MBUF_DIRECT
> +#define RTE_MBUF_DIRECT(mb) \
> +	(!(((const uint8_t *)(mb))[offsetof(struct rte_mbuf, ol_flags) + 7] & \
> +	(uint8_t)((RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL) >> (7 * 8))))
> +static_assert(((RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL) >> (7 * 8)) << (7 * 8) ==
> +	(RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL),
> +	"RTE_MBUF_F_INDIRECT and/or RTE_MBUF_F_EXTERNAL are not in MSB.");
> +#endif
> +
Couple of comments/thoughts/questions here.

* This looks like a compiler limitation that should be fixed in GCC. IF we
  put this optimization in, how will we know when/if we can remove it again
  in future? I'm not sure we want this hanging around forever.
* Can the static_assert - which just checks flags are in the MSB - be
* simplified to e.g.
  "((RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL) << CHAR_BIT) == 0"
  or "__builtin_ctzll(...) > (7 * CHAR_BIT)"
* As in prev bullet, I tend to prefer use of CHAR_BIT over hard-coded 8.
* Is it necessary to limit this to just GCC and x86? If it leads to the
  best code on x86, why not include for all compilers? What about non-x86
  LE platforms?
* Does the actual macro need to be that long and complex? If we simplify a
  bit, does the compiler go back to generating bad code? For example:
  using "(mb->ol_flags >> 56) & ((RTE_MBUF_F_INDIRECT | ..) >> 56)"
* If the above is true, do we need to actually put this in in assembler to
  guarantee compiler generates good code in all situations?
