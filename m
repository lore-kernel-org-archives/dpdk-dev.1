Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D75C02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 17:35:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D51742EB1;
	Fri,  7 Feb 2025 18:35:33 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id CF42F42E9C
 for <dev@dpdk.org>; Fri,  7 Feb 2025 18:35:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738949732; x=1770485732;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=GL6pEW6CTkmobkgov+z0RYXh9RnwabshLP1NiIf55j0=;
 b=SD7QVBPaLT1yIQts9eBpom85JWuYiFKyOyNR1A5aEzPutlmcEfATck/s
 d756oVua/IIrddOfJRqckla6SPn34DMipzu21U50hiYioWVS4xOWNAXlW
 LGFTvG2njCmm943y7LOZ63esV4MuJXmUg0jnPQj6QMIQQgqVdhwSvHb9C
 ii8gvk+59sFZTPrYDAUndN4eFgIYf0qno2roCrhqJdnUljopEhQ19k7j3
 2fJ9UFxiJoZKfpnM6RBVkmCfVv5GsMgKUZ4Ohy6JI7Ar+vJ9Biv5thnk1
 CKCB+WyTgqFIvplHg16LWx9D3zvkveyViVHPb2ynqks6v9KEoe2M2JR5h g==;
X-CSE-ConnectionGUID: rCo5i4v3TeiECnFUki9YFA==
X-CSE-MsgGUID: S4qeHoKJSyqGi8F9j654wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="39752321"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="39752321"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 09:35:31 -0800
X-CSE-ConnectionGUID: kxTT8qu3SlWU3CNdA8R0vQ==
X-CSE-MsgGUID: Lhuhm5oOQNSTG37R72MCZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="116192515"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 Feb 2025 09:35:30 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Feb 2025 09:35:30 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 7 Feb 2025 09:35:30 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Feb 2025 09:35:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MnD9jqpx9BVn0sd79HC+pXP7pXUexSn1KNKye7NarqiDxow+Veg1xLl7+Q6uYvgxWt40tlmCF4x/68NsFA3zkEDKJ/xa3AvPQ29JpxdzNs7lHlnERyclmuEnXxM2EsqiOHunq10ZiAnCH+I3WfCNIv9/bmqp8+hHU1l/f8wTZMNz/QTfRh9kJ+NLdqjC5gaYwCJE+5R4B7Qb+yqXv1abHwBJPoowIx7P0kOOptZWaqDbZBmwRZJE378Xo4y1zF5UjaXVSwm9MOe6Nu8gDXl6h7iH6GWjxbBWXZjZQusWjzX5KcjAlDWHrq+Sc2GFFgX0T4vdNuoGFVDdwNCWD5ss1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1oJRgMNKmo1xEqxtfdJROa53/sCWDey5JFg0unM0I+A=;
 b=UvL4LCdWU+iwQncDWYk/pxA6of6H8Iegc/yElQiyPSd8NlsIpiOkVzU3cWtHPj4CQhlRwLvI0WK0xu/l0UK6la7h5uV+nLBJxIw1HX8tZIJnY9AmWcr2h1srOAd435vljTjdp4CEzniI169ixNzYklUiz0qP89oBZIGvugK738hUp4Pf22B09GnG1ycr1L29xFqWxejx9bW2jyQx7Swm0imaKDISPitMrnqVVkMms+GxMmk8T0PubbtMlGcNqkt8yzIiJOrPH4zTouUj0GYl5hncIIOz13QIGzL2vfiV9+atvbK2H5BfhwtN0rlz4xJ1NQ9ktee4t6Sw8dTKs1vT4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by LV3PR11MB8483.namprd11.prod.outlook.com (2603:10b6:408:1b0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 17:35:27 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%6]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 17:35:27 +0000
Date: Fri, 7 Feb 2025 17:35:22 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 00/36] Merge Intel IGC and E1000 drivers, and update
 E1000 base code
Message-ID: <Z6ZEWn3MJvd2xVM3@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738932113.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1738932113.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DB3PR06CA0031.eurprd06.prod.outlook.com (2603:10a6:8:1::44)
 To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|LV3PR11MB8483:EE_
X-MS-Office365-Filtering-Correlation-Id: 1353ccf3-7a23-4f1b-2aa6-08dd479dcf5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FYPQm5fv5IxkdBvXm5K8SIpKnSp8G2MquEmUaxmdfDlJfs9Grw/YcdbvezlC?=
 =?us-ascii?Q?/3THRnnl3YCvPXb0uoHVegDpekuH98ZsTifRYXBRMaQjvTwAs5Mzhvy61yLI?=
 =?us-ascii?Q?M2HvwXJdkniAAUA7NeqqT8Aw68cCOfAwUMqaSdZJY/oaiEtySWV6XrZa82gL?=
 =?us-ascii?Q?uLu56s9vvyQl9ik8g53MKI3CA+iBA67y67pHfaXQPks0GNS2HwXawzXTsFX2?=
 =?us-ascii?Q?oAanR3cQZNS+EuKMxoWZnvoMlwualzDFt8dokX6I7RoPD2K8XCYhKp9xpgc3?=
 =?us-ascii?Q?tqBuEuwuRNLMEhnPOeXyb5U1/r9VvEMl1YyMVEhmTkfNXAOQ0h1Zwe4hA/l+?=
 =?us-ascii?Q?RjhGTBBBDfpvXA0yDAX2HxirwvpUUElwHC2m97cYfKMFyn0f5frvpK9kZRyY?=
 =?us-ascii?Q?liHa9bl5NQdFcVfFnka79AW1npKYtqESCPwhW33Mu48CSmVS/XGhqSH8cO/e?=
 =?us-ascii?Q?eVm8TNwqBsCdTkN5urkhv6MYLGbz9tfyYL9Q0Jv/F49wIejviNgJnTiDEx7W?=
 =?us-ascii?Q?IQ5kba+EwA6G9DoAHEy6px27yqO1BBYunNQKYgU+fEWuSeDCbYpgcjeNEcdC?=
 =?us-ascii?Q?f74c7hc44vc49vAueCYOuk00KJr1kWOpujcbVhLsSTGv0mk6/njTwspkCGVB?=
 =?us-ascii?Q?8mRlid9+VDgB6qCdaacD+4ka+asZ18HA5xTNsoto0E4iBTtOMWy3FyADA3JX?=
 =?us-ascii?Q?0I0tK+aM1u5lEoPU9HKzffzV7T3G61rJGqaH+m/OhO+i2W9XtwOYLAFSsy88?=
 =?us-ascii?Q?DxfIiSC3xiSt3PSut05tOXGqBw+HAOwvffB3h6gFnG74lAJlkR9HR1sD//TG?=
 =?us-ascii?Q?ffpZBH15h2TKY4vLCG1trZuynugD8WRey7Ax6jTBZQ0hdDUGQHK1xDglkpRy?=
 =?us-ascii?Q?3x/PyRTAfQfyvs53qj2DcsnfqRxbij5nYqXY1TTxwHzm6dBM0C4mXIEbohaK?=
 =?us-ascii?Q?6q6IKUX5tzO44WEK2NnWs1FXGBzd5yHHI/LlGGdAuyq5w8FGgf5V25DzdRFt?=
 =?us-ascii?Q?+fJ0wzeHNvpbSGdIyGsOmWHU2sztECvrRRbsB0+Fl/DSEaXAmuq9ZfK64hAj?=
 =?us-ascii?Q?8hFJEUWPDQ8ezNspxzB0E8UGkYp5KGZY3i53avBJJ4GE4bbi57hEJFffJDOq?=
 =?us-ascii?Q?VFSjw5ZLtIsXQuNgZXH5xTXE4ubj2Ikl6IBnHaTC4HpYdy7hwpSiEvTlzQ+Z?=
 =?us-ascii?Q?iAT7KZK/ou8/OOPMieHu6uZrZdemvipX31plnO24LmaLzLS+AEyPEaOdKWN4?=
 =?us-ascii?Q?PiYnoBhmRS3vjLSeV2/x205iGIxRdD5EesfLMnODVaK+6IPqyzJ5Bf62SxIr?=
 =?us-ascii?Q?L0ma52cnpJVGpo5l3a+nxHcB2MgnOupCcV5sCdoryL9sYnZJkz9g3g8Iqn+n?=
 =?us-ascii?Q?6kVr10vz09n0fDdM/z7Fe4PFikka?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0T21DAI/GJU3WXgu0x+FiNHU5EYCmor18b8x0db668PUx+0rQw00ZT971ET1?=
 =?us-ascii?Q?rAX0j+vUFQDJcV/HAu49MPx8xPP9jdKpeJ2aX/DzJmtoey92skTUiqdC36IL?=
 =?us-ascii?Q?X6hlhMuHkBki4JWBRZZ2X7ab4csDPyM+GAYuGxcmhoQvWtTsJop1StoILYxR?=
 =?us-ascii?Q?/pvD49RBIMgNYSm/LAmftN0HTHH+btZOh/ONb2KmDiPWNcGuu1hAV4WfOYDf?=
 =?us-ascii?Q?IO6Ddqj4cRbymz1xGb+WJWvCvZUyhUSgc9SOh5KOedVXkq0XIoyZssnKno6d?=
 =?us-ascii?Q?i3nuawjMyz1FeH2656UfvinjrDD3KeHk2L9UEHVl5um1wN4r7fJ/pNA5g2+i?=
 =?us-ascii?Q?P1kEyWyPhstbQV0f9s6ep+jaLk1LMUmrRpOr6zAiF3CdsQ3l9Ik39xvtYGm/?=
 =?us-ascii?Q?0jnK7VKGg8mQh56nyZZBW3lh4FlPX+YofhjwD7kJ4vIXAw1hIXAyKJWpKCSO?=
 =?us-ascii?Q?hdx4IGsPJ+QgN9bH6/XUmSutxag25UPcA6WUYDt5F2+18OsRH2C4V4d8tq8g?=
 =?us-ascii?Q?EWxCCCA5HLR04cBM8GGENfWT3i1PGzmUZtynj8Iys6KSTAgd/mBa2s4L0Fb0?=
 =?us-ascii?Q?2Iit0Reb8Fax8w43jKZv61RtV0H3NMuxgLn0vTX+DQ7fyiyCBKieu2D5Tba0?=
 =?us-ascii?Q?tg2rQynN4XBhhHghiNz5cvoVcB5kHXCjJgaiGOWuals/3xOPe2nX8Q+ufNiq?=
 =?us-ascii?Q?XnJWbbL46qrYb88P8hd1MpVLlouMl+266jow+4iFr+K07l29cEug+U0LrMHr?=
 =?us-ascii?Q?w7IYQ0Tpgmaxv14XX4ljod04FZ6bArX8aDj0wGQmBSznQPQ0VX4WO6sHDlLv?=
 =?us-ascii?Q?g1fiwzIwohf5ML1rywW+ZhxduY97j+iLBo9JiYudv4qV4ZLg6hBOjCxCdunm?=
 =?us-ascii?Q?vOJb3gIQgjYZkoNSl4sKSJIxX74hqPdan6b6vkw+qCYWVlbP6ItlCtIDSLjY?=
 =?us-ascii?Q?z5dVo9KreMPrqqxRhhLtJ/V3leIUjjp/7AnSVyp80zb/04pfMZ45OIeCyqJZ?=
 =?us-ascii?Q?VFjikkMGZgU6+YjbOmLb3dRs9uedqCjJn1Y+wqpFhfO7SyotFUYchhqegvH6?=
 =?us-ascii?Q?F2EM32nR2ExkX8hneef5Ns3Fr4vt8LTc6WPEMVP60p2MQxsmCoUaeMgr5i4C?=
 =?us-ascii?Q?Rhhu0kKEIzqcInp8eoiUDe35tUABdSUGwuifcYjPfE0WHXMdfGHw32iZWmQX?=
 =?us-ascii?Q?2aElwQb46kJxXY/EtvE6tQtSGRkkL7AAxgcbwCsmlC9maAf5/nvyZw4mNpRh?=
 =?us-ascii?Q?rGqdoSE46zkXjTGbU4W17PzyWYz027lWhyfk9zef5LHPh85OqeXveusitJyd?=
 =?us-ascii?Q?zO2x8L2T9E9Aoxh5/O4wFRN6r5ILbPyIIuzD+J9fEjSzLGVIcEmHhfbl98On?=
 =?us-ascii?Q?dG5OhXUZSPkK2wkWf2PzCZLXtqZD5D/4YWPtLhaX/6bET+FgIU9iLt8r3KE7?=
 =?us-ascii?Q?RB7a4ASQ0uEklfyFAPKPoO0xpd++CzNTCl6cy+NXShtNys5qtxfp6XQm8HvF?=
 =?us-ascii?Q?q/OfvbIIMDD4J4KTvleepiFLDEX55XMCziJQzHdDxr0++/OktX5kk8AZR9kt?=
 =?us-ascii?Q?2vvnfUGL6ruMMUYjZHEwKy6rJsjuk/gbeRGdK2rIG03TRO043muLIa5gggd9?=
 =?us-ascii?Q?JA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1353ccf3-7a23-4f1b-2aa6-08dd479dcf5c
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 17:35:27.2276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ABINJRcoF8b0VtTc8HN5+GztFBQuOgeAFahjJV+hzxu1feeRPsykBHLQpESmVVO7CY5YljqJ5OCkBDNM0Jx4ilHz4hpqilfjyKug1rEiTUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8483
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

On Fri, Feb 07, 2025 at 12:44:52PM +0000, Anatoly Burakov wrote:
> Intel IGC and E1000 drivers are distinct, but they are actually generated
> from the same base code. This patchset will merge together all e1000-derived
> drivers into one common base, with three different ethdev driver
> frontends (EM, IGB, and IGC).
> 
> After the merge is done, base code is also updated to latest snapshot.
> 
> v2 -> v3:
> - Fixes to drivers were separated out as a separate patchset [1]
> - Fixed signoffs and authorship
> - Fixed check-git-log and check-meson warnings
> - Added libabigail ignore for the removed driver
> - Added release notes
> - Updated MAINTAINERS file
> 
> v1 -> v2:
> - igc code is now a direct copy from IGC rather than a rebuild-from-source
> - i225-related fixes are now separate, not squashed
> - removed unused args warning workaround
> 
Thanks for all the work, Anatoly.

Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.

/Bruce
