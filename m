Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93894EFD20D
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 08:58:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB178402E8;
	Wed, 25 Feb 2026 09:58:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 3541E4021E;
 Wed, 25 Feb 2026 09:58:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772009901; x=1803545901;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=A+AkcUvpdAzGR1h81yNYIYMcG0hy2het+kQXlya3Sng=;
 b=g5TqffwuDfH6enS5CP2qE4altZcJMffMRVcumpj/9w/8z1sWdFDy4gRh
 pLZD3TSMkSjZf7BB9TRC54dH4ErKaO78VwYjbFBG50npfKK3ehnSV/nYc
 NGxy+kfDpW3CPO1nTHMVZdKBm/cW0cTqH7n+HlmRufNG8aF3d6dj6f3hQ
 cYEAPxMVyjIROKRtIykDVOe3zU9BbmTq8zWXD9x+WYmYDkcxw4i3AsCzz
 EgFxjA+UdKVl2Al17IpPObu0DEP/T9fpWOWocLnpVZo3Wiptny8eUkkmL
 QSSaX8DxP7m7oB7U2ov1GWoRnq8BUCujwDFDuhNxRVVLMCy8NkNoOO7oB A==;
X-CSE-ConnectionGUID: +FDCAaeaSsyRuwm3M5pjuw==
X-CSE-MsgGUID: 8Y175+DkQryMUt7GjLkXRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="73148222"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; d="scan'208";a="73148222"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 00:58:19 -0800
X-CSE-ConnectionGUID: hsph6Sn7S0G4vLAck0Z+CA==
X-CSE-MsgGUID: hPn7ZR+HQxK3TkFvshe2Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; d="scan'208";a="253932289"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 00:58:16 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 00:58:15 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 25 Feb 2026 00:58:15 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.61) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 00:58:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sDbWfB/bJ8+Is0VzQ/Vx7kZVbUMqvGYZ5ZeoQQrfxzdTtuGaJMOnlc04RZgxQVpvoR6pLFT4w6BQfwmtG2NYMkesAqbPTR2NoHlfJ6Y5inWPVlT7kmlR8quhalC5cGbLv7kXMMyC0gVfonwV2Z/hFmu5qfGOk90jnMOhR0lU2BtQXc4iWuVwPecFrD56rIV0SEWt5a0Zh+/NURJKNk9LDFXsm4d2jm9mawgjGL+TOnxFNFgwILV3tdsA1kBjCfz+CiUus563thtlkqEIlJGAv7dWQHzt+akpR5zZeqeSVueyqzpSb+UIqjugiIXmJBMkoquud6mYIhTOnpmMW6yBdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e13clBWIS8zxHDtI2X0Q+1aO8PZRbxDGtSKARGf04Tk=;
 b=g/apPPJewYhJ6aB2dYPJ/4AO2CPeiyhBHuNg7b4OMDSKgCMSw/FtH66R6GOdrXbPdrF5OzGhBo4cN2PHjkZAmrDX7SLmvTRBSSoDOC95eF5MXlfdop1dT5zmDw9D6hKCNMb6f91SopJtsYPWhNwCRSkcMhU3wbZxD2n/oKoij2PijBZqr7IVZPB17QcgFqtrxZQFV/1F6JU7+xQH/vMq+b0U6PJl8zTisV4zKBtgald+668uJqehIvh9xzJn1gnpih4DuFLUEzPOQpXPLLRxsGPSYkPipR36ThhvxOJU1UA5/vFyd/2x0d87gPlgJ9ME81Pp1SvDcZGs0PDuNsIdtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 08:58:07 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 08:58:07 +0000
Date: Wed, 25 Feb 2026 08:58:02 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Liangxing Wang <wangliangxing@hygon.cn>
CC: <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <fengchengwen@huawei.com>, <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v3 1/2] examples: extend NUMA nodes limit
Message-ID: <aZ65mls1IimlYxB0@bricha3-mobl1.ger.corp.intel.com>
References: <20260225080510.727493-1-wangliangxing@hygon.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260225080510.727493-1-wangliangxing@hygon.cn>
X-ClientProxiedBy: DUZPR01CA0200.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::10) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CO1PR11MB4820:EE_
X-MS-Office365-Filtering-Correlation-Id: 143929c8-c496-4cd7-0bd9-08de744bfe72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 58fsCIPLdcbH+PB7PWbu4vtpRduuEjgWFPhO6Z0DCzyqc+wP+zgl06bppQZ9oQU8MTnPA2q42v4q0Q5/RmPyOn7fCJVDJ0oP0DiZGqbcScfPf6IRSnElsPqcGc+fHU5vfIG88IRUnDGzK5t7kVX0ZzLWQ7tH4epE8DBCw+QaIs+5PGEV4cR7XJTJcdwZkbrVgF673L8fxUvrJ9crcjGH1COLHw3pRg2Jmzj2HiIs5L+eqiMVPpTLx5HAFnDBXcmYFT2kMJ9sjBhMYA5IVAzSFskkO0Y94G5ULtdLrD4tOOevEqm48JIV64tWxhsmgt0YA2tWyXMiNkfisB6IXzi0f0oF+dpY9LSUfMIlGF1LGm53nU1nVkPWby3VsKVrbf8ujxq7cYsj3WgPhw1ve6xL9MGdYfCZ0+2eJU7V+nd91ko3iAuKeOXZa8MxrSzLxT9D8M5OBKuVBlP6UqG2ZPi6i7SdgGTzQCihALUXh6gWyZUnpWkOr1nA7FTPNP2N1m0CVeD+OS+1fw6SfYPqCP7CJUW3lFXTywpIzb7A5uyvrMtFPHxqDZTE12mDP2aWpSwmYR8SkEAJAVvxYwEXnpotdpOyraDQ8W+DXlAlbZ3tmj2tZaFAolzt2jYl1QLqn9duxXTdGt+sxbZfOxPrWVnbIurJmcij8C/dnhAjERprdRdGAZVolsPVaWAun95kInm75iYQBYAvyRQuZbqBc0soqwV3dEkNVx2kcE9QoFT9Xv4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i/o6Av3/H+/2lql1CB7qvxxgHbIr/n/UZ72OqXJ5c8fBWUW9fOzdrhTBtD6q?=
 =?us-ascii?Q?KQHVR0aUgTJhOtyWsUMkHrKJkoWntFGdM/AFUEu/vIoNcfSjclYVNmtir9We?=
 =?us-ascii?Q?f8FccTRV3DCeLL+U8atE+iuu6sGpaEylG9ZRsAnetyVScKQzfTqDUBgTu/nG?=
 =?us-ascii?Q?30vjDV2A3Q1GUkZ40W866g2PYD9EDOx08ulPc8bY/IpdQPzPN6gp1EIqH2sE?=
 =?us-ascii?Q?+wa9GseylG3RoStiIkketr23J3frInLl/RoP+uObV/PNEVFAPAeYu/KBXqZa?=
 =?us-ascii?Q?w02F+T2DXycienTo8SdBiy1PIbcuI38TR5kq0oCknCNzI+VNsiWkLUfCtR1G?=
 =?us-ascii?Q?SDS6y7MeCR/t/KgxqySz6llXFb+JYbbwH8nZSzCT506rWZ1b46BqS6bR89NH?=
 =?us-ascii?Q?usoUGGfB0aNeeVVM8LNqtCibnaFsbavXFzWj0apaspvT+E67lEkT6dDlJlgJ?=
 =?us-ascii?Q?EKXTrcQlCRRmX3gLMBQci3vFopeqyncdVHIZVBY4Z4ehUcFm9alB7vooX5l6?=
 =?us-ascii?Q?mQTnRy7gcpLG6TaAbJyUDQ7bXVpfwFi+qTQVzfNufar6/i6cb556/0E07/to?=
 =?us-ascii?Q?Fmiq+kMz1ZxaEmMv/1q7chE2XP9UN5Bh2KI3n2pLeDEmYFqqUQm/FkzDZTEb?=
 =?us-ascii?Q?12UfbqM+tpZeWe2trVixLgFOvnD2eaHF54micHr08tBdLAZ7E47KnI/orVjC?=
 =?us-ascii?Q?vzme4z88CzavYSZIV6PQrC14RqUVvBd1PmCTpxZkesQiLjdpBIAXP2FE/JxI?=
 =?us-ascii?Q?xkDvh+CDGzE2R9qYJ11d3bs2qut/SUzEsZ7pJcnUAZZVw3DLiYRHg8dAlC5V?=
 =?us-ascii?Q?GHv8LK/0Yfr73Mq1XyD2QoK6/Z/sqaR8ynbubGzEETO9nbLO6eUmsuI53GIj?=
 =?us-ascii?Q?CGgvwzX4V92HgoOF5FqKDqTvcJ6GYZZtU6w+XpOiBWOJ2A5G/SASs8KnhC+r?=
 =?us-ascii?Q?1TVZ8g3R/y4YTwPeYwMeBsK0Ai72uZ24IU89HiMhpUy+dWSicHBypQAifk0b?=
 =?us-ascii?Q?Hq01pU5DRcsdwT8RPiLfMhJAHHZCXdvUI9LT4Wh3i94O2ADvmfjUAy56ElZ3?=
 =?us-ascii?Q?r1IPpV+wr5zfVrh1U+25Re+b7mgxbE2OFj5/vOFKXg1qxGyB+Gk40+eXfZwF?=
 =?us-ascii?Q?y6ws4QYRHVVQ2+XzLO5pL8OzGq8AGove4+4mHTsVTR4V0zAPm8Z9WIBLhPpP?=
 =?us-ascii?Q?D9mujS7N77u2VQLH9A+2Lv89MK+HrgWzCRguBEWKcy2xGwJcHaOKHFpgc1EP?=
 =?us-ascii?Q?B9nLEEKcpphc61YYQeZFfhAcWuA134P0UGytDLLNwQ0JqJ53bLDIf8nDhTPL?=
 =?us-ascii?Q?D+l4p/f59zu3t4P/1swZMk2h6bLwrZik/rFTK5L3t1BsvcolU/WA889BakPM?=
 =?us-ascii?Q?w2HK2ASyNrXQYB/LUsAiho00NLwbqm8tcnbv/W5OIGpvz9gMTiTYgR0kPdf+?=
 =?us-ascii?Q?JdIKap5AaJzRUtuE8IZjQVHppeHfzle/dVMRYWMzYKU22SPdBE9qtqxrPAKC?=
 =?us-ascii?Q?voRy3MdcfDwkOrIV74S7r/WPon3DXUxLNmYPmCbPsAtFcX8RJ1aGuNoTN5pI?=
 =?us-ascii?Q?+CNHxMIAG362uPYDr7Rw0wOBSjQFCufw1az4Bz0L6hJgPYANuI8hc1diE0gC?=
 =?us-ascii?Q?p+WQfi83sZcoENywN3ywGy6sJz8inE3neEEK/UmViUT3nstGHFdiitrtk/m8?=
 =?us-ascii?Q?EfMLm2cesaG1krv9KQxqCweS2upxeMLfLYhaZXotO6gQRBsec/u01CuWmn19?=
 =?us-ascii?Q?QNR+T7chuJ7Kc3MLA1eUnrfaxLW39Xc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 143929c8-c496-4cd7-0bd9-08de744bfe72
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 08:58:07.4849 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QIcjttJEswyjJUd+ELe1pOTceglerOO8VHgZQ64YZOQsiwbovsNkqkiiUjYjqfTwfMjlI1/aVoDjPKfi9nzF2GJt5md8FxwjLBH6sQFV76I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4820
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

On Wed, Feb 25, 2026 at 08:05:10AM +0000, Liangxing Wang wrote:
> Use RTE_MAX_NUMA_NODES instead of hardcoded values to extend NUMA nodes
> limit for l3fwd, ipsec-secgw, and vhost_crypto examples.
> 
> Remove unused NB_SOCKETS macro in ip_reassembly.
> 
> Cc: stable@dpdk.org
> 
> Signed-off-by: Liangxing Wang <wangliangxing@hygon.cn>
> ---
>  examples/ip_reassembly/main.c      | 2 --
>  examples/ipsec-secgw/ipsec-secgw.h | 2 +-
>  examples/l3fwd-graph/main.c        | 2 +-
>  examples/l3fwd-power/main.c        | 2 +-
>  examples/l3fwd/l3fwd.h             | 2 +-
>  examples/vhost_crypto/main.c       | 2 +-
>  6 files changed, 5 insertions(+), 7 deletions(-)
> 
LGTM

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

