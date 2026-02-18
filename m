Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E63E9A03B
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 10:04:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FFB2402A3;
	Wed, 18 Feb 2026 11:04:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 6A4F840299;
 Wed, 18 Feb 2026 11:04:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771409058; x=1802945058;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=0QMCx3GO9zS2sQ/B7OsacWhclqicit4nnnYDjKS3LH4=;
 b=nRh9KAahX9QYkZzaj9AlCgG/OcPaGC6TR9BhLg2bqQzM2DbpUsfFfuuM
 GUKRYXJf+TkEvQpdRfB0etTEzSwqSapd5U17ePx3nA1jjdOw6271ccGes
 5AwzkcFixVilHB+an47QpSggXMsFfwQ0Bv8O8YuyL7/chbg74BmXPki4a
 LcIIWu6L1S3oCKAMEl0LG28A17tUXyWxS1BJcCDTULcfJKcFeJjeVSyGg
 MEkZMIdSeCy+CKAjDFmenlzis+O5CVkAMG6u5v2yfXoWBRzt2WMJeYTHa
 ZR5qUcAoy9iTNxSKMzMULaob0kqGcOaFhfELFacb4NA0f4BVdeEvERpYH w==;
X-CSE-ConnectionGUID: Hf9T2udtQ7OTUhvPH2O2rw==
X-CSE-MsgGUID: ANoQTjqcQKaaxHUdmnNsMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="89894779"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="89894779"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 02:04:17 -0800
X-CSE-ConnectionGUID: BpCKhdp+RSGHA88OmaMKCA==
X-CSE-MsgGUID: d+NlMq59RjqFZUiWVN46iA==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 02:04:16 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 02:04:16 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 18 Feb 2026 02:04:16 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.47) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 02:04:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mje66qf7qfdPtifbXapd0LF4M6ZMReqtu41zahrrvHfyzZqQs4JE0pskpVs2nOKeaXTWeZkkwJn0qNy9ZZo/euHfB3xpYJdMGZQLe2tGXZVubMflm0Fv6qC2OlBGKwqmkdZ1dfjrKg31o9YqTsc8MOU6FXhGAgZoa46O9XGrJOwIHDjfvIRpzrZrU0a6K5i4fnpedgDc+rKtS5c3oua7KXIxE9loLGsHnU1K63x2DMQCkhhLxa+rnMTlyuu2xX2EpOAVyjQ5uLJtBB2xyD6Z9MAhWimy2L0lza0vj0aTUznESS6QrU5d8DRS7HNrx4pj6yC4JDO26+UipxRx4QvlqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79CTGzz7mmS0lZBQmff8t22SXqMMsmXKWRdQmzKhGtE=;
 b=uY8VvzcFQncZoMzo/tSmFU19FYVNsPdzskN9UF6VmlVEloL/PvRT+CBj2a0W+wYtOT1/WC9RskMlF1dnGZ9W5U4v7T3+zbKTHkCeKCfOJ7lbiWTcFAFSTBXwx3e7FKM7uXrHv5fKVi65ys64urE3kbQNynkGv0FxUCCQsu8AytlHbWzbtw0Fcys0ffA2XUf9TNoRTI29lvUTX2S2EhkzEZgmP07OlOg4A+E5Hipo1OkWl8R35crqjU8XhQNuvmmzLNkkgwYBpJ4CdkAW3kKAfYmjj9pxp1ScXrQyHTrONcf2wDvlmkO20NXpecj6xtkD3l7NoKmPBlfbDwda679yeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA7PR11MB9542.namprd11.prod.outlook.com (2603:10b6:806:4d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 10:04:09 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 10:04:09 +0000
Date: Wed, 18 Feb 2026 10:04:04 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v3 03/10] net/ice: permit secondary process Rx path
 selection
Message-ID: <aZWOlPakBSJ2VdtV@bricha3-mobl1.ger.corp.intel.com>
References: <20260205124627.371733-1-ciara.loftus@intel.com>
 <20260218094937.1652391-1-ciara.loftus@intel.com>
 <20260218094937.1652391-4-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260218094937.1652391-4-ciara.loftus@intel.com>
X-ClientProxiedBy: DU2P251CA0022.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA7PR11MB9542:EE_
X-MS-Office365-Filtering-Correlation-Id: 3358d5d1-4bae-496f-c7f3-08de6ed50ec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DnoRhA9iwAAdCwyLyE98Zfg1UwtQZSDE07mk3SlOqz3L4qpmy1wXMzBSxI8E?=
 =?us-ascii?Q?h+YEwOp8PyTvhR0UWXjHbZKLLh/dODvNcCatQ0IOdxnPtcOswDw9skb2ErjO?=
 =?us-ascii?Q?jYV2RrW7dssr1pfYSGzAboh4Swy4zupmxXxjlqAxhajpJUjGKsUE5H5hQDkC?=
 =?us-ascii?Q?odpsC9VJkihsbRfZ4YlSE951pGqVWenbD8ITjstnBFEn0QEGJlP40ojEi/G6?=
 =?us-ascii?Q?OnkEECYUC4ewfHGUDvlU6k/RX734P60vMR80K1vVtx66Eq9lVk5HazvWT/GS?=
 =?us-ascii?Q?hLGgL7PlGQPAzSRYMsJwSqaBwTcketByAIxWLwORbRpRPIeRd9AlaiW2Uz2t?=
 =?us-ascii?Q?VV5b8uMGCDT244RdF/bso88B4gqvtaqxPq1KBWuY4AOprFF4REL17h8DS1+9?=
 =?us-ascii?Q?jnk9qTgHFIaSTKF2CGeVQ6bfBCGaK8QUQNsNoKpsX2VtOxhaAhb9uyNkJFP+?=
 =?us-ascii?Q?KKOWTzHuqWFLeTTTASwZqO5qURrLqEuOr8oXTj1QPhAGGiliNzfTS2FIJr41?=
 =?us-ascii?Q?IeGGUvIr6m4kgsxWjkOizZ4u2PBeoBEAOL52s4DnaxXffFUNFI9beTt0zm8J?=
 =?us-ascii?Q?kBkS4TXjJEkmZ+6E/9MJkeuq/GZ/jeb3BNM2MCM/ECGq04ar8hynI99lgmlY?=
 =?us-ascii?Q?gjos2YpYwQgWpw0YDgQ9p3avK7oU+5o1jI6/2wkRGSlluutiS+vCMc/LNv2U?=
 =?us-ascii?Q?dqdIsyUeXPjd68vkwYr7T4L13RdQph8a5BEHIU5khcjJvZkyniybLE8WnC/l?=
 =?us-ascii?Q?fDQKtD4L6O0TE1hUfxQ59LaVs8+HaCmJPU1TwLORngH1afAHObuyGcsdR6oA?=
 =?us-ascii?Q?usWm1NZEX1nk5vVFrEV4ZzT33Vh33KumQjLSMBro8Q6YV0T6RK8LbpXW8T3/?=
 =?us-ascii?Q?Yi4dxuo2ATco4M8KQ1dLkJ284h0bnrdhrxdUI815wKrAVCMu/CsZVndCuOq6?=
 =?us-ascii?Q?qc8Y/63yDzPhH81PeaUGLDJd2MMl5t0dQDmMCId9yijpeRvlNud+wX1Vi5fC?=
 =?us-ascii?Q?0rTxuyutNZcJay/p0CiYARUbXt6EelLXYDBH53nNYGOR2TONssJcylt6k1iq?=
 =?us-ascii?Q?SClKk51Q+IGA8o3sEYT5eIIt+HdStS0tYa5eBd7gfzkG/L4kvizlRAtnKvlH?=
 =?us-ascii?Q?uWvJSPrS9JQjqyXS68PdiFAw6hlT9jmk+9oua5PnX8uzE/HmFydu+sDE2Npo?=
 =?us-ascii?Q?d5eiWm5WKrbZ3NacJt8Qj7z5EAyxEscMehiMTYMOXqtm+ZmSaDSQNoBdUJcd?=
 =?us-ascii?Q?/RkyeRQdrv2M4IFM3Gkj8hCU5pqGLg2QKREtoy9CdKs4ArrkZZr9aQwfUga+?=
 =?us-ascii?Q?hvy0uGPC/Ko83b5Ze/6kEAI1khb4J7WqwKTMEsI6OmNEEfUL5LEVdloFRdyw?=
 =?us-ascii?Q?qS/0IQ477B/aRV6D+09NyVfPSTgO6e8eK+gf5TxdIMxIdCeg0mGXUM3N6LyW?=
 =?us-ascii?Q?k8G6uEFQc6JpCd7Jsfr2lxAX+oKEoAubhSmVkqbEr3Cce01stevI3+Drm0ah?=
 =?us-ascii?Q?OCEDUua+rb3uXx7yoDJSLhT/nIp7MYxohKOcV6X2vCoj+oZx+7oqib4BJINR?=
 =?us-ascii?Q?Bq1vztE1cgVVcpM2P28=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nYcvHADyvIkJyCl1zEp0W6CBIw4pqmlKVXOqjxd7TvKtEjQpbGmTV6Zkg2YQ?=
 =?us-ascii?Q?dY/SgAmiDMekbXmm/9XmsHzPMPU3LQz3PcG+SQpCNgAY+80jtb1HY56PsngL?=
 =?us-ascii?Q?azRDo5koSmREIrYaUV51kLggO2iZEfYDsxhXWy+PzFgotYqpsUi95YNUFinb?=
 =?us-ascii?Q?Ig/mq7M8Kfq26qPgr1CAvu65g6V+yQ6KEiyWhyRXPeAXJLPJEKv5bSuKyad9?=
 =?us-ascii?Q?NdLWbJQvDzNJqnwWF18v9QUhBei1yD4Zmc2RACaja4qsXSmMHu0iczsZi1pS?=
 =?us-ascii?Q?hNcRmKIZfhGOaCn7WWiEhz+qxBCSxcw0yqKkVf21QLDTKbmQPYeiQZRlZ//f?=
 =?us-ascii?Q?SII0srtWh/7/ab3Yab+gf7JqtaDHqVW95hmNdlHiFEf99xDQcOpIofXXoWsO?=
 =?us-ascii?Q?+HVn9NoPAAIWh7UMwcrZxuxTNWG8a402yPYwEj05ysOtZof/P0JOmGAlttUX?=
 =?us-ascii?Q?C8+7bxuKhost/dJ/BKZ8Ag3/TW6QkjO2ev4tgCGNA6b9By8jhTXUci6mJ9xj?=
 =?us-ascii?Q?WZqVmU3101VD5ebqY2GQ10iI6a8Kw9nDD7D/5zU1pHouRFfBtEXw0NiIwU1Y?=
 =?us-ascii?Q?GQ28CFhpkiW5eaeTYkgHlLhtp+mgHv7Uce3p9xaHPEQ+ZmbOJsI+vGLPRuJP?=
 =?us-ascii?Q?MtiUIcDbpk6z871xQCVhTmCCInGvAmWaYUQy/jBB7Lqc0Y0LAi34z6MWfwQ5?=
 =?us-ascii?Q?T515BYhQM7FX4fUSdpVdvAXlH8ILMw0fOgCumu1GEz2adhTL2QgbRIQYDnrC?=
 =?us-ascii?Q?zx6GV7NxXi1Bwf29W9OGVgm7PiRx5VVrnoG085ZT256pUAQVrD5Z12dvoNb9?=
 =?us-ascii?Q?WQxuqcPf9vtCHRgr3hTyyH0C+OsLee1UQ8O9L54T5/D1Z0yqtT1LZFVmTGfo?=
 =?us-ascii?Q?DfgFW5kBmXc2y78Ony+B/Lb7Rq9/VXKCfbW8zfngup0J8di0SOBix0/1ADZR?=
 =?us-ascii?Q?HNo8P8uxZTTk2X1Z72xDGIQyoPnu0D8K/aAqVTj7rRQoe0R/A8M7mMFiJRBA?=
 =?us-ascii?Q?p6I5XRKA8d5N9lJgRzMaPy37vaQ+WP8vKsmW0TFO4jjElf1BxOi/KV69ChEc?=
 =?us-ascii?Q?VoCadWJc9Z2Rj5sX6OmhGja3F0g7IUvj5skoX82BvQ2Wv0XaoPee6wfk7VU/?=
 =?us-ascii?Q?wUlHxK9DqLDLXZlfFRkCcxm+4pkKpvI7lLHP327yI1db1/AQGujM9UVxSxCw?=
 =?us-ascii?Q?NFecgOiv4eqZU7REaCEVOJV+CRIPl6aenvKDKt2bP72289lvjytfyma9h3dS?=
 =?us-ascii?Q?nowXdz2iCDZnoDApQWeDiKanK4lYPVcjcE2zGuOu+YXmfC9egNoZ4zL5HYFA?=
 =?us-ascii?Q?hCv8mMaqS5i2kIUZiSkMQ8A/lfLFdHhtOHOtL5e4gnyuqlIYnbEOt4EuWjwy?=
 =?us-ascii?Q?pwT1RAcn3yWKVa+AE7TttOjDIFALA/0DD8h1BBTHjaVNvxMb9NeG6L/W4B1s?=
 =?us-ascii?Q?m/mZKQpGQXNg2NfEW3Ih8zGpZLpSN3IoSy7s2bjFCNffcePfdlQchlun2QSx?=
 =?us-ascii?Q?4znGslJkTgbMBboUHtM0yZ594Z177dkVpuCbZZ951YWSAAG+h+XYVIqFrXun?=
 =?us-ascii?Q?rp2LpngnT3Zzfpg9x9xG2NC6hp6u/kIlfO4gP1JjDGwcKhGIqfGEjk0RgA4Y?=
 =?us-ascii?Q?McpxCdnvepbgx1g1GHz3fAHfJEunJ6a9vK1pmEvERlXejHrFugn+C5E+VJ82?=
 =?us-ascii?Q?0i/uDaROnYN1s5IHCP2E2oyNCrUdl4ShtAU2HWiIMxaHpX8LeQAViljzNkA0?=
 =?us-ascii?Q?RlicnMfxczcZcwmG+HiBmPwIeOouP+o=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3358d5d1-4bae-496f-c7f3-08de6ed50ec9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 10:04:08.9204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YnHfjNa79OjXVPdFlWa/Cc835e2oNyfLHTsNN0Mcf6DjOMki+rx9+VzIZKAZRJATdNZbME09b7mUT6Mlzi73Ke6sZMrGZXOSRvlfLvB2eUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA7PR11MB9542
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

On Wed, Feb 18, 2026 at 09:49:30AM +0000, Ciara Loftus wrote:
> Commit 197e70fb8961 ("net/ice: use same Rx path across processes")
> changed the way that secondary processes selected their Rx burst
> function. Instead of letting secondary processes select their own
> function, they now used the function selected by the primary process.
> However, the primary process only selects the function at device start,
> so if the primary process hadn't started the device by the time the
> secondary process was selecting its Rx burst function, the secondary
> process would not select the correct function.
> 
> This commit addresses this issue by allowing the secondary process to
> select the path if the device has not been started yet.
> 
> Fixes: 197e70fb8961 ("net/ice: use same Rx path across processes")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
