Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED13FC0219D
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 11:36:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3FFB40EE1;
	Mon, 10 Feb 2025 12:36:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 9E6B740268
 for <dev@dpdk.org>; Mon, 10 Feb 2025 12:36:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739187383; x=1770723383;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Wq4vvJtski+NroNnydzq8aBbJKM7qMboelpH9fGOhCk=;
 b=oF6TD91DzNwch99xEClKvpqesJylY2F8ujYG1Qan9yu29cL9JsWfZjd4
 bg6iYyPKcDTLXkgfkWLEpB9zYn1hccnLcO3ncdqFEfTGCWu0s0cHPuuHD
 MBBqye6MdP1eCJh3DezOcXb0PPSzhoaY+RkVF6QSQrkDLolLZ5/bOZP2P
 5jBxnmAocDC5rxaQhAX5Ct7w7od85nJa9374LAiiJ2xy+7SjvTenvLf6Y
 NMwCxQirzdKcxmZiPYCHTqIlcqBvmM+MrMsZZ/ZtxN33zigfII6MzGJz6
 OVUJ9Vln7BIJVvp01mkP7cEwEQU1+PrxzuOQ5JsY4i6LKptf0SkGDMnNd w==;
X-CSE-ConnectionGUID: gMbstbtWSbSXjUg/eXfFPw==
X-CSE-MsgGUID: ElRuimPVSSi/HkHc4wIFQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="39451053"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; d="scan'208";a="39451053"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2025 03:36:21 -0800
X-CSE-ConnectionGUID: cqGoAZ3ESG6pptbu4zBuLw==
X-CSE-MsgGUID: awBf6fo0TzKNggnp6x6DSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; d="scan'208";a="112119433"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Feb 2025 03:36:21 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Feb 2025 03:36:20 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 10 Feb 2025 03:36:20 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Feb 2025 03:36:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vrczpbJz4U4wZqNGWqf10zQp58kcF/13Cv9u8ybZtcTtjZB2yU4VeP4mwE1iiBY0d54AUbiSP8eF0BDUmBfoGFc9g3BX5W3g4dmVwsFsr/VSeYhFBFNYrcGorU8glvqUHxkpFtkkbrKrLWx2OwdkWPElERV6vRV4lk9hreqOPnUytP6UVxvKncdE6bdgYhAa4GyvbqdwubNw6MGn0aHKYiAdU/QE8s/qhkwB87XxNKc7ZQdxW9lIwxGXGo25qi3aZylYehj90wmQm5F0gllk/8UNjr+WiDcUyAG+onzwC5+LBNqkpzk/5D1lvmrAvEwG5a4BmYGDFeJ0DsZ4AB5JBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGDvOjy8LfHybiEWL5o6uNLOnxqlRVaI2xE9HIfDitM=;
 b=AGFvlxL0OXQe2pNp6JJulRf0Uz6LMHnD7dewvtWIq8pVBlj99EVgaqhBu+L13qL5xc6aP5AaVAmMpwoTOuv0RCiAXiMnpkrQ6xtOTI14FPQw0tvAend7hwGnU6MXnW7kJi1sKG9mKkLNRnZFw47mDh7NXelGLPMqozkj0hVsnAcODbXePmf9gv31eMCnLczhy0vAq4S0r0z0zJAoajdyX6k3nAIl4pSA2a/6MnnnNmxlQluDDGNYS9aUnaPSUizNMwTIs7aCECMViENbTaTRkq4B4MKhJPYukFhkIF3hyUU4GkY64ctoqZww4fzcVWZvD+Se0bFcyyTmYsyYDrVqIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB4998.namprd11.prod.outlook.com (2603:10b6:510:32::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Mon, 10 Feb
 2025 11:36:04 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 11:36:04 +0000
Date: Mon, 10 Feb 2025 11:35:58 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <anatoly.burakov@intel.com>, <dev@dpdk.org>, <ian.stokes@intel.com>,
 <konstantin.v.ananyev@yandex.ru>, <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v2 1/2] drivers/common: fix void function returning a value
Message-ID: <Z6nknpboNqmk4Kxv@bricha3-mobl1.ger.corp.intel.com>
References: <1735254890-18457-3-git-send-email-andremue@linux.microsoft.com>
 <1737559244-9107-1-git-send-email-andremue@linux.microsoft.com>
 <1737559244-9107-2-git-send-email-andremue@linux.microsoft.com>
 <Z5ETEeNFz4NLwIep@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z5ETEeNFz4NLwIep@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU2PR04CA0329.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::34) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB4998:EE_
X-MS-Office365-Filtering-Correlation-Id: 91332613-f031-4361-e416-08dd49c719dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ybl0SP35YGJoJ+5tovcq8nMKxUtD6Z1HNoEmQRX9IaZFiY2az+m6yaBXRilJ?=
 =?us-ascii?Q?LgyTmgVlTy6YEJfPf1qDBuAU7GVZTugRzLGGEj922m/mDxc389M45vfsV63E?=
 =?us-ascii?Q?OkXwaJxgzRjF3WCln32PqeuC5u8WLDcBMkqjj+emwfkovb9JSmeHrDcr38Db?=
 =?us-ascii?Q?LpGpF1hyV63C/NNfs8iXaju7NjZf0W9Y5kxil6vyLhEP8P2jBX9UGtUxBe4L?=
 =?us-ascii?Q?eXCnK3GWuPlpQl4gcGZ2c1J1RrwxFApgFz1KDG2t9E4kDdrPJfA4aQGGVprq?=
 =?us-ascii?Q?CuYHhpRiiCKNEaMbqIPLjkR+odji4p1SfgeZLMmj37jC0OESeqmg6P0tKI62?=
 =?us-ascii?Q?+A9fpIyX/F9++VnCw27+/uP9XBDyWyzdNjaL5lemoHMTK2l1c8BPMoQJu/Ao?=
 =?us-ascii?Q?EMw6FGnNnRpILVJdLVTAoZ/uGcIuPM9mYManjmDKpM0/Xy77tFCtyNg5EfPn?=
 =?us-ascii?Q?5egSgjniSA3snq1qsqYnGNYOxkayIAS0NEZxRHFWFDeNim72LH57sl2xQlfP?=
 =?us-ascii?Q?YnfEO/QPUHA5+NVJfWSlRDrrKtilHkHsV7lJHoiOEx/sQfsO+KrtjIkWYxtz?=
 =?us-ascii?Q?GD53pnxLs7l6xtpvgwXKSQ/i1XpICTD/mpuoxkWMcBsSwDHhIlBpX0frHn0i?=
 =?us-ascii?Q?uKKwxPlk8M+AJAD+wCyPLXSGavtHz0m/b53s0H/wHt7ldxAZBS5cO+FkXQR4?=
 =?us-ascii?Q?jOd2bgqHclBdVoRFx8g5K0qDZtPvJRdcrs8AQ5edFkf/ASO2+Od4/t/i9bVr?=
 =?us-ascii?Q?Jd6biynAVqWOifEMJ/9m72g47zJAkolCsTdaVW2fAS2Yd/v9rnuiAHC1spnI?=
 =?us-ascii?Q?vejRdzLpkNh9hp3oi4g8Q55RGpNdP1yIAwrkeurseowOCBHBSByYOAQFyFkb?=
 =?us-ascii?Q?Mcy7iJ9neXaz4MT4rhVDOVJ5Ep6q4zdxMWX35Bbw/7SjOr7Ni7yc7UjudRBn?=
 =?us-ascii?Q?r3jaCNBjVQgah3BFvWrvszdyL++/75lbW9ku6iy7Hs/RdX8MAdgueorAXDo7?=
 =?us-ascii?Q?QW845WO7lnOhEoS1HpTRpKpskHYO4cxwYamGkHRbdkhpF+RE7ZBTNl7PSz4x?=
 =?us-ascii?Q?ewB5aRjE+Yzh+G6xqKzYK1b3HNLIyrx5SyIhsaR5hNlSUVcXkSC5P0ibANjM?=
 =?us-ascii?Q?QW4R4rZmQHeOmKVMOkt6Iq/HykYpE+CK5QS/TrSkYLLL23C1jABzeCKC9vhi?=
 =?us-ascii?Q?ph2ctxtlhNYr4bkHyN39k1mtuNyOermYwhFXafqvu5anW817RheoZqkP0r5L?=
 =?us-ascii?Q?kXuiE4nIJEkMGqewwIRXWr3mv1cmqIUhyayKjHvgFO3UKWIiA6Km1iFv6rtT?=
 =?us-ascii?Q?jcSB7guzS7c5N6u1G0yLfzN6o1McsL7+hLHo3i3dLLE/sUyU+EPRjRhVPp4H?=
 =?us-ascii?Q?OCVZkiB74H/B0M2kjXyyN3LFQ2RS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?45EoNqnOqW9o4aqKn4rHM7s3rKB0yyxNSt5EPqUH93eMQg1zG3QKd22mvpaZ?=
 =?us-ascii?Q?cTwoiJMKpZlK/MiBgWiaGuru61kaCqgA0TgvgrSlXog9K968YswYrPKg/lbX?=
 =?us-ascii?Q?EAIH/F081Bb0GeClrByhtjkED6+bqZ2XE2zVptWEp38QGAY9rJqNAHHaATl3?=
 =?us-ascii?Q?cqCZqikQl3qS7BryXdRtxpfVDloFrjMgN5eAg3amKQ6SY23VtdXIhJSqmvnx?=
 =?us-ascii?Q?HGhxpU/PXnV79UblC3teufkyI6Hat2CvzKZjREwfFnaL2gEVuH89oim8akWT?=
 =?us-ascii?Q?D/2vD0OUrKTHeAljEAsiczkjfLCP1aF+OBcI0WXA8D2lLEJYoojsX/aveQqA?=
 =?us-ascii?Q?Pe/0ZK6rIxqavN7mv6zr94f10uvQ4rqeCIEmCJx47Kb04iIR1FpE83jPKAap?=
 =?us-ascii?Q?QXnjZxbjj2XRCGvOLSUCxLIi8gbY5r2xZH0sq5EatCaxVcjzBQIfo/sFiJx3?=
 =?us-ascii?Q?wSqiri8GQ9JdpOnpJP7r+0sTFpxjRnJAYDrzYev9RgpD7SYQj3y3qJsSfO0+?=
 =?us-ascii?Q?/rVEKbtUrRy85JiOuyXlHbAHZDcgPKCgoeAjP04DPJIViCNHTy82HwnpasEb?=
 =?us-ascii?Q?3AEkqiHibA2zMLY++glhWi8+PyyDBypj39wF1/bV6ghmvfrBxEgDGuYRMUmU?=
 =?us-ascii?Q?YwkLSeDIiu+laku2CZ3psmy/qniBvs8RYUFnycc8Ec/bNgIIBWNEuIVIKZ2B?=
 =?us-ascii?Q?kHZBAETlspTSJrZ//g51lsZXD/rBGjt5pWd0rxvao1MwWHbIdr6bKT8XINZm?=
 =?us-ascii?Q?A5tBB4SkW6YbEQAEYkaKqvi8PQ360W/OWPL4fsCIdeEM/HWk6UcJ/CRgaFlU?=
 =?us-ascii?Q?fvrsUtDgXn7kFF+IqkbWMIfNy8/eovvyvuL5YJHbvNXqSLH13roZ8cdjkF8v?=
 =?us-ascii?Q?i22iUpqJoY1BoTb+FynZec14NDplMNt9jAwt2uZ9VG+CLtxGJSIVfRpwxWjh?=
 =?us-ascii?Q?6bagQq/2t9pZatpZiuwyrTtfdntaU/mzIyUwx9gQh+4R5GSz2lqLlc43SMfJ?=
 =?us-ascii?Q?o/CK/wATLxX3yrVfsp16NZEv6w+ZWi6m8x6nZHlfcHKbtr40mjHrdzQotKoi?=
 =?us-ascii?Q?ufiAbELc+3KUh816+bBdWlGTFeNlh79N1jkAjjd3B5NCSwyCq7mHX4+/bN36?=
 =?us-ascii?Q?H6Q/j4207jFjNv25xC0JcUMZfXQWWb/JNY4pBPQ1m4P8K9l1gq6kpSSsePW7?=
 =?us-ascii?Q?2hVs6sJ7t64DF0H13lMN2T1FsMIc6lRVMgzIjI4MyVReEFA+belcGyIx0/TX?=
 =?us-ascii?Q?jQNcXmFPMzas7EcgPm/HZFLf5Cln4u0XwqVoLTH6+DrTBWJTQZoIgvdDLbmb?=
 =?us-ascii?Q?El9AId4A7OMD3gg5hdit6WiSih1x2EC1EEzizW80diEBboeIhonqqR7jkjLR?=
 =?us-ascii?Q?t767bbDMaDreQhYNd0rBEE7l+puZ+a58gC/8tXA3Efmo4rQD3AAVgjvBNTzq?=
 =?us-ascii?Q?zvEw1y4b9gTF6Y5knOIs0pC7Dyacgf52Por3GcdxGlFYflr3OytK5UyuTJRz?=
 =?us-ascii?Q?0NxOfAe/kgR4Zb6fACXOrOjh5u6LCEHycWYvHXsuBpNsfoRNoRXyIv6WGvo2?=
 =?us-ascii?Q?/ZR4+aQM2r1B8F2UQff8NAHDpBccYxImC1iaJjMHlOPakWZmN+tzWVpkDpLj?=
 =?us-ascii?Q?UA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 91332613-f031-4361-e416-08dd49c719dd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 11:36:03.9499 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBIw98SspEup1kjWLD8P+yo5tl3upZYt2Jqp+dqC0FA4+2FxQ4Pz+P+rKNQpAHnPFpUq8LawjFcvMOiEApa5MM7YJbb/zPm1zi9xCR4geiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4998
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

On Wed, Jan 22, 2025 at 03:47:29PM +0000, Bruce Richardson wrote:
> On Wed, Jan 22, 2025 at 07:20:43AM -0800, Andre Muezerie wrote:
> > This patch avoids warnings like the one below emitted by MSVC:
> > 
> > ../drivers/common/idpf/idpf_common_rxtx_avx512.c(139):
> >     warning C4098: 'idpf_singleq_rearm':
> >     'void' function returning a value
> > 
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > ---
> >  drivers/common/idpf/idpf_common_rxtx_avx512.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> > 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Fixes: 5bf87b45b2c8 ("net/idpf: add AVX512 data path for single queue model")
Fixes: e528d7c74819 ("common/idpf: add AVX512 data path for split queue model")
Cc: stable@dpdk.org

patch applied to dpdk-next-net-intel

Thanks,
/Bruce
