Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C81D1039B
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Nov 2025 17:01:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 819B240C35;
	Wed, 26 Nov 2025 18:01:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 33158402D1
 for <dev@dpdk.org>; Wed, 26 Nov 2025 18:01:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764176479; x=1795712479;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=sc3gXayM/5cBTrM61Rf17OxdB2aMTp+JvA7lOuSQDhA=;
 b=WFsZivtHjnz9wmiCJP0o+5KBvaa/PYYxgP338ZsoM8RVR+7W9p2hOQop
 nuyoGyAfyWXki7k1acDvcJupSmQhKsQqANEO7V5PXc1L/4VJX0c1CDVgN
 ge9+QQ1C7wu5V2Q49yqep8Kt0wGfukKm2dhwhoF3lBpDQLg2u0Qs0eXPt
 Px42GGp5t9w30HWBg2RomwMOHoBvaLyCsX9aBWp4vh9+pvWgnuOIQl3nO
 wc+10PBHmRX9dIG8IMEqqPDgBLPcki5FTrEzYcTFWSurLqHr/venJsZ63
 PtQK4EuJ4XMJckjWGQ0ND/P/kTzbmDRsE55pfBszp/4vLjJwBT9ZuxryF A==;
X-CSE-ConnectionGUID: p/GsEKqVS2y8zNickI3pJA==
X-CSE-MsgGUID: s/LNQXdASGyE4LoxRDkPuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="66182171"
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; d="scan'208";a="66182171"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2025 09:01:18 -0800
X-CSE-ConnectionGUID: suxQY/lnSxGMaOS/PSZuxQ==
X-CSE-MsgGUID: r9R3B36+SQy8S064V6+UHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; d="scan'208";a="198104185"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2025 09:01:19 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 26 Nov 2025 09:01:17 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 26 Nov 2025 09:01:17 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.19) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 26 Nov 2025 09:01:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pEnfKh4Y0kmWyccstD4mp+Zr82fsbYYYgIX3p29RIZRWRniw6HyMB5Mo5Qo/B+9ItcC9sA82x8ZUBiTTk/ZsMy8tXtx7GXfrqw44We6S+6JgRd046L5AlyRBJLaoxzB5AxC0zq+CDjLotUt4F9FLLhsDP3QmW5HxWU8pvav5sH1B1reB/5264KVgau7eVnhxHAYlpiF8Ih0AkytLvO9rps+pHraWEENgTK3F/sIKQaJSiKyrD6HKFVnqbEbWkN8I7MdTJkPrq8PWgkmMRCO1eHf8bnt5EuMMcXMYbagCr/WZUVetzlFz6EfT1+ojtCqAwHEGvJ1M/bcwWSzlELVtrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cm5dvWje2YkxmTZJxLp9asryTZwi4liNPn1TS03z3Jo=;
 b=r+BzZ+Ojbj1PtFHR+Gd3N+sW0SeDtedJrCvmcJrRCQMgKgXPexAIOGJllb9UjQx0wja79Mj8eC3uIUtKAuntAqiLJrgGQZMgOE89RYJfgF61J1Vtkk1uvwVfEnkDinaENyE1yQ8c7U5zkAxAtbeD8A0svldnOYnsHDdled+W8mgaw0Jl0J951yXOfRB0rjjVCYCkh7nFyoLC4OQiMeaW4Ux6OE4IhP4voa5sMftHiyQ5XV+6G+qsli9xQ/Aa0XhKETl2phKDrBTagI8xQSbPSwjTUqQ5w/QpBXAHQdHBgOLHBtaw8t3nAs+jXlPCna16si8YfZ4voUvBNJPdK1lpSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM3PR11MB8681.namprd11.prod.outlook.com (2603:10b6:0:49::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.12; Wed, 26 Nov 2025 17:01:15 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9343.016; Wed, 26 Nov 2025
 17:01:15 +0000
Date: Wed, 26 Nov 2025 17:01:10 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
CC: "Hore, Soumyadeep" <soumyadeep.hore@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "Greenwalt, Paul" <paul.greenwalt@intel.com>, "Medvedkin,
 Vladimir" <vladimir.medvedkin@intel.com>, "Jiale, SongX"
 <songx.jiale@intel.com>
Subject: Re: [PATCH] net/iavf: check PTP capabilities during init
Message-ID: <aScyVljrA4myMP9K@bricha3-mobl1.ger.corp.intel.com>
References: <20251121-jk-dpdk-iavf-rx-timestamping-fix-v1-1-21c9a337a6f2@intel.com>
 <CY8PR11MB774717DEAC152077562DB837F9D1A@CY8PR11MB7747.namprd11.prod.outlook.com>
 <aSWrIkJwhbsf7YvI@bricha3-mobl1.ger.corp.intel.com>
 <c6635526-a576-44ec-89f1-985779ba0ee0@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c6635526-a576-44ec-89f1-985779ba0ee0@intel.com>
X-ClientProxiedBy: DU2PR04CA0339.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM3PR11MB8681:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c0f5685-4223-45e2-2b3c-08de2d0d6901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PxJfSUEompVsLQCAY6MG15O/8p3bc04/KEV6ZaRquva0uCgpq/rlX+L8tr22?=
 =?us-ascii?Q?E6jh/36Mcp2tTkrbMTkaXVmbscHLLdBLhYBjU4kKIZG2NPrREQgmlovkzxjy?=
 =?us-ascii?Q?j2vvkUbgcVToLxF4j1i6JisxLv9B/o0bxUyDp8+c1HPb7R84fZBWnC/cCNWG?=
 =?us-ascii?Q?Nn39mGWVIja7ndJ8B2yY/kWvG+iYjf3cimeTWAcMewLzc14KNgKa74TKlb4i?=
 =?us-ascii?Q?e4qrMUbIHdULqx8okf6cRg+5Pq5mmYDsDSxyE+nTOXOJ5FXiMCK2osc3J8rp?=
 =?us-ascii?Q?d7OyL9yKxW1PfHerVpQOAg2n08dzPW5OLgqrVmbOz4yzjyRwtvWFAvcNRICN?=
 =?us-ascii?Q?kvN74EJWngUpbImyqzR8KbwCvglSvm6eJJ2b+Mix009LGgq1JH+yUlZmvvcR?=
 =?us-ascii?Q?SRnxgCAi3kasjpzLfIje5UtOvHoCduCiB+JdYqN9bj12Ywss+utJ3ppfqLhw?=
 =?us-ascii?Q?nqdjt26L1TXdwJvClvUjBp54PQRByfWV08S7P25mAO0/h53jw5lAhFppbCH+?=
 =?us-ascii?Q?BOcr+5DLNgN9HWW7eh6oIvOMO6pyX1KREimdlxyrUKrWJe1lyK2tmX0nDlMK?=
 =?us-ascii?Q?L/erIcXyC/YCmqoa4JdSbtM/Gavo+KkNjIAj/2OTSIU9dkBwpel+2DZCx2dL?=
 =?us-ascii?Q?qy0fIQCHvpNtMF3GYmiM7sQoaXmFZrYmLu+9bkmgqXboLT51GJ+LbpVy9PZW?=
 =?us-ascii?Q?eW+EAMNJ7ci2nPywx82KuXwIXQqx51L1MTMrWQKs6NgGPLb0z7/kKlEtOHkx?=
 =?us-ascii?Q?/ZqyXqzw/BqboQxJHrPQZAc2BPkaFdBFKau+7Shpkd6y3nFgG0opWZp+pG0J?=
 =?us-ascii?Q?TvcI744lkp/rKCp7nCwTEghZRoWH6RAv53hzn53zAMhM/8KOrpQ63LAXHs2G?=
 =?us-ascii?Q?VHxOouaQeqFPf5oDg6qfMXs0s4yNWV4hnP4NV1Hq38iIAfq245hsr45SaPiw?=
 =?us-ascii?Q?2AHLWkzNK06ch2juYmozsJ2+HfWhtS/its0SxjczwJZFJ3BsLEthkO1rPRiR?=
 =?us-ascii?Q?rAsC/MGz8xp/8yqJMyTPozWsIjz5jcGpgaKceJT5JPEYmT+CvH0nduCXeYFU?=
 =?us-ascii?Q?DsU4mO7nog+PsIE4EaNZuyZb/9UzqSae5CGCPZIXi3an4fu9TTq7zW6Enb0r?=
 =?us-ascii?Q?biRUzCsHHWAWGuDGji4hLPn4zlBXow9Z4Qayt4Geji2cWPu3e6cV0QQySBHJ?=
 =?us-ascii?Q?FcKQUsFcin51bcUAeWd5q1nyYpmprJ1E46wBzKB1/kJEZmC1VH3lxhzOvyCB?=
 =?us-ascii?Q?vhpLy8t3ImwZqa/YsQ/xzZDmlqwzghGtDdnx2g5Nv+CSHVMQPsSI+0HDQ9dB?=
 =?us-ascii?Q?0DzM0nKEwbD9LZXXwlbZfRoSkTqWL0pxIBmVWz9UwUuQcrnfJX8OMmZ030sr?=
 =?us-ascii?Q?C3QtaJCcbxy+j1djRoUOwba969zBKvbIMMYn5LEZjwkThzJGCIWfcieXmHs3?=
 =?us-ascii?Q?11wLsuO+KGXjag7oHOxbTAsL0X1Z/OxPGUjUXEH262VbHUD6peG7WQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZGorUfeGpBn7JPv8lNIfMV/soogv+vZszt4e5LgyTPMBKOXrP3DiZ66+Vhtf?=
 =?us-ascii?Q?1txRhdfrnwP1lNQPCXe7ikzlLgwZFgh4nCHeKvRfB5STu2HD5v/6SQC8qSF8?=
 =?us-ascii?Q?n6IIN53zB+3bfRPBP2235Vg94SPdThLYIhyhBrH5DurrMiurmmHW9WtWsV+E?=
 =?us-ascii?Q?Hl2ImUioGvCjmQ+QVJiGwHlwvVKd7XrXdUnATBDLM5J8dWLMD+TRd484o1UC?=
 =?us-ascii?Q?HKHiyiH5yWgvm+nDO/HnvAnvislrUhXX7z3x6AMem4UkX+h6t/85bvdEQbOV?=
 =?us-ascii?Q?t1yDIfDEV8oWfqHXWkT12Cap/LCVJ/gWhZizWj5TFWkIaRR6YLdsInzqMUzg?=
 =?us-ascii?Q?95hIaNAfk8OerphFCJpcKIOyRkXUYrgzfQv2wHeXdzv8C0sHmlJ0S4LKa84/?=
 =?us-ascii?Q?TYBLho68g6UBsjb9J3I/2QZhO6ONyC7t0Ow/uDRFd2oOKl0/HFUEJqBgS9JJ?=
 =?us-ascii?Q?y3Q5KE9ntJK3hfSR1RpNPb9L4VbYmWxCLvIDveGestxWplvn7QYSDMFET217?=
 =?us-ascii?Q?dUk59LwaytvcNJl4aggVZIELLzfsQEEGXMy0I2EQO0OntiTZVQRNyA57Afzs?=
 =?us-ascii?Q?nNNsiSoVoYxYfCqCu+7xqvFwWDD1+DP1+T09Ekb9CogX7EpWEnIo6ELvtp7i?=
 =?us-ascii?Q?wM4gIIW5rJS0diKcS7WhH5TDg6WbOOxuaLOQYW45xa6kXNRD+lysMUm+idoM?=
 =?us-ascii?Q?+s59KUrXDUshl0qAg+7hlFukmB9rG6csWfBrN0W6zO5zCKzMLpuBPWGXbhIU?=
 =?us-ascii?Q?i3if8vavBwBwx4UKPzah7fNuKvK8IaZOLPIBWpEeRk5dDe2GSCXTR1FfEchG?=
 =?us-ascii?Q?NK1XRYI0hJG+XAulVBpaugtA6PKXynGHRtMLg4/Cv1WF9E8uCdtcUZbTzcdz?=
 =?us-ascii?Q?HsGuVOKKK/CSR6IHL+z/UoTwPK0yaTV0QW6a2OvHKLZc1rxU/B87Dt//DiBw?=
 =?us-ascii?Q?1Gldaq31yiGC+fuIge95l9opSDtYuFhFFxxElVwwh+HB+ROExtqxTQiSlAcC?=
 =?us-ascii?Q?Hfp7rEqDNPi+zyoV6KQlW5+dpdWLeFCS0Zlijmd3kE1wruOdpX+X7wV0M0E9?=
 =?us-ascii?Q?K0gjicSN3nv9PLG8P66ChIsZZtSDfOi4cGnlAP1yKiQzqROA0geO0uA5cgcS?=
 =?us-ascii?Q?SUWdaJnaVUVh5tP7gmR5YEk7jkwaesFXrItnHZBO/XzUduXjiL+CyvUesrav?=
 =?us-ascii?Q?VSfcjRB/LGDslS23Noz6ITSFw0kHCyzQPu/fWLCb1atr2vZaXe9ML6tUAVx6?=
 =?us-ascii?Q?2YebrBF3MT1TJl/82+WoKI2iw82S4yRNE0K38xQS8eF1efqyJqRfybAlilEw?=
 =?us-ascii?Q?VGJ4WA+Zmk3hHddbRPmxQRL4eG+XPh1skxLV+YCaIA/+Lu3C7uClrBxvi/9V?=
 =?us-ascii?Q?s7jv3gJZa1SXNImtq8KOcrcWWtm2+NluhJ0bGImh9qhaEAfwGf4Noe1Vz+hA?=
 =?us-ascii?Q?d/yiMtTniVIVh3l4SzHWr/OzQecHBRG90CFdnsykYqP8vtTV8N9LyLCXIwAr?=
 =?us-ascii?Q?k7fblFo7h4Szr/8YFaTs44AWK5yBlh6owTm7p5yJeL9M3leB/4Rash0Mo4NS?=
 =?us-ascii?Q?Iy4i/0+etw90hZs7WFLbqq+1KQdXEqMXnC2mzvWS4eq0wytxsuB9fQeVM19P?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0f5685-4223-45e2-2b3c-08de2d0d6901
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 17:01:15.6872 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gsI9G8yL5emzef4zdxfOfNzQhb3nwpnY5wnqhf2lcpIo5BdCTRh4LOn0mWVgDmStL0pa0rT7ciGtrKYJiS7mVqNICz/KPtd3+Ry7rJWBLGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8681
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

On Tue, Nov 25, 2025 at 03:57:10PM -0800, Jacob Keller wrote:
> 
> 
> On 11/25/2025 5:12 AM, Bruce Richardson wrote:
> > On Tue, Nov 25, 2025 at 10:30:37AM +0000, Hore, Soumyadeep wrote:
> >> Hi Jacob,
> >>
> >> Currently PTP features are not enabled in DPDK. We only have the Rx timestamp API in place. Typically the change that you want needs to be implemented in ethdev_ops.timesync_enable(), which is not implemented.
> >>
> > At this stage we are post final RC for 25.11, so taking this patch would be
> > risky anyway. Let's target 26.03 for this, and then look to  backport to
> > 25.11.1
> > 
> > Thanks,
> > /Bruce
> 
> Sure. In that case i think we need to revert the other change that
> checked the RX_TIMESTAMP flag as it corrected one issue but caused a
> regression in Rx timestamp offload when it *is* functional.
> 
> I think its commit d21c2fe6e5a1 ("net/iavf: fix check for PF Rx
> timestamp support"). That commit without this fix will incorrectly
> prevent enabling Rx timestamps.
> 
I've sent a revert patch now[1]. Please verify that this revert is correct
and ok for inclusion as a last-minute fix in final 25.11 release.

Thanks,
/Bruce

[1] https://patches.dpdk.org/project/dpdk/patch/20251126165943.1536164-1-bruce.richardson@intel.com/
