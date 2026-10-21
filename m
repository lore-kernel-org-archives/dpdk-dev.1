Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CAF606A319
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a9xrMO55
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C68740615;
	Wed, 21 Oct 2026 11:27:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 9AC29402CE
 for <dev@dpdk.org>; Wed, 21 Oct 2026 11:27:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792574870; x=1824110870;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=kcvKI03y90Q2MBPu2f4qK0JdZ2+l9TkvHdudUlYICsY=;
 b=a9xrMO55WRT+Y1iXsoN2aIyJQUVsaMiHZQUkt2pNBKPiFOybc6pnU4UU
 DamOCPWuiBspIJ72B9ef9jtIKmeV32w6PiXiZ28I8N655VTmaAZ1WWt8r
 tTSmHCs1oebHS8cGsC4uXM8XnlQUN4sJacgpSQr7h5NIyj2GYSqlXwCBD
 meZ6iJqlsmkPAyNEC/ZuoELheo7lNHSMkX1c7iljstch9+gVYkxX4+8eu
 qwIJH2HX+pC3f9OryfdiwbK/SXdP5d2d6zOdBM9oZ0udT5kFfg7IwbBLJ
 XZQb74PGR5TBF5pHV81i5h3SqTgi0NHGL7phCvyiP+QW5c8UEKAmwmcRb A==;
X-CSE-ConnectionGUID: +JvE/1bkQtC9PgtCGC2Lag==
X-CSE-MsgGUID: Nq89WE13QQOrBGwR8xrQug==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1193075"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1193075"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 02:27:48 -0700
X-CSE-ConnectionGUID: QHdA2+JcTGGyaDKxMJw8jA==
X-CSE-MsgGUID: e5ClYQAqRjapQG5ozOhANQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3036369"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 02:27:47 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 02:27:45 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 02:27:45 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.31) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 02:27:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oRaj/RyAr7asA3fADCZarqVXDJRMcm6uqdNjFBxXWl7X48Waa5Ju5lZM6gkZH0RlNf0FKLov+assODxSa9X5QSkQq6ZogjdIZyvKuC0Noew82KOM/1TjuzPQzA7UrvqLMPvwoUO+rWf8qvY7uZGfIZUkV5a/AY1xuduAfasx9HmXJYUnRg1d5T8P7t6LUqsKWfMAo6RDFx+9Y+wbR+fhkeIozoF410tIlQn52ByZtaTILOKTGpnotB4gxmLBhtjTvizhZG1q4Y1O218cm3/nby6ASUGrzay0sukwWXuwub680YnCtp3ZlZeuWgtpWd5nQKYYTCCe+C3N0+bhqC55LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtzYMime6154WCWzeTixOz9rH+FBthooek1g2IQzrPg=;
 b=yF9RkR0FeA1jxGovbvlglsGKlBeAS+veERBvnGgSqRa0mWslmQTBcJwE7WuUNubvHeQelSxF+Qmmq8cg6wlNDQPTbkeUMV36UnTgIDTtlemqau4VNUpFX5o3snkg3v45AqKloGgDwSYfLVt2VB07mXZD5Hwlydpe2ostfA4ksyiRt7naQ/QwFxLr89bnX1F/+kshzkq2eIJCnJx5MpDOzoqdSOmKzwbJhHa1T44LqRqqnxg2ERjs8SMzNBxR/XbUnl73aibj46oyMAC1XJ3krKFlE0QGcv/EPJr/RflEmeCK011WbwoKOUtwtgJ1mbCwN9pmXczvGgcR14rkZZQZaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SA1PR11MB9634.namprd11.prod.outlook.com (2603:10b6:806:4dc::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 09:26:01 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 09:26:01 +0000
Date: Wed, 21 Oct 2026 10:25:56 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1 5/6] net/ice: use caller-owned pattern match storage
Message-ID: <atiFJHpIIhwH_AHh@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1792498154.git.anatoly.burakov@intel.com>
 <c28b60359f98c25af67e95d90d1f17d55d90309e.1792498154.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c28b60359f98c25af67e95d90d1f17d55d90309e.1792498154.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0024.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::11) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SA1PR11MB9634:EE_
X-MS-Office365-Filtering-Correlation-Id: b44c2b73-49f7-4404-cddd-08df2f555263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|4143699003|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Nv4O+ZKGr5a6Woc0YiCXx++bKvQNLt712Iu+7/oGnsPdA58r0YVBxeB0sysKQaw/Op7oK9Ic/En5FaLDGiGV7P8Nq8onGbz1dpgymaZ5dALp7ggeDR3WeVBmkDMZMlIOcsnuF/lQd85A5lQsLQ5Wngr9ZsljGDZzh4kFFPeTQ7q3a1tsWlvtYazmW4AQLwMMChdGeDk3OeMGt5m8lL3Ny36JSv8dIupXbC8TcOG5UNCOBw6h/c+5o1uvjPgM5t+gNCabbufWKpfdi5xJ2GNs4ayzKwHTtnVBoxJc/wZN9o9knJcXt11fxEyAwQq4LI4vpsWHNXAlW5e260XtLz0ReGwl5g/iLL4nwWDLIG+VXpC8rydpxPTlMxxGFdhS8qJPVp7TtGFs0hhe4Bvcl7Tnuitg/SD8R0kCMll4NnX5y32Jhd0LiWzGRB3nJSqBHzXMlYxt1JblSpGlh6dhUEXSSItQLUfNAPJ0kpKm/89DSsxY3EmkNdn8wsWcszx/ZbeDuhm9l2tqbvQwj6vlkvU0Jjk1LdEX/vEXno/E4d5RhBaUM8H+cfTALVUPt0dHXOwFdLXpdNqRcB3Tn2Q0YmdPWvwigPJMM7B6dPUBxqFI6oX0LnVxdilGDhQYwRF94LuhTldY2uNaU+JNW7PsEK1cL5GGUZc/h+cOZoPkQxaB5nM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?csq/O1wnqIwDArReuRoK2DqPL+APAcrHEmO7qKr9B0nBY6ObPKlo94WY78dO?=
 =?us-ascii?Q?1RftfhDC9vsUuhUgmodZJig9jOdHbujvZrXYQNY6T0JwEsMzshXzIwb94Niu?=
 =?us-ascii?Q?/4mdqImu+w219VzyEOMXoAe7pUhTXIo+30NoF1YH4QJsqZOW/uIguu6fwv2g?=
 =?us-ascii?Q?3nlneF7OvTNJGXWK415y2TjayMy+YwrK+yRKae8XbtW6LxMNd2amWiLid0CN?=
 =?us-ascii?Q?t0ro7ftHhTUPa1k7ZcqwPT+xrnEK9SbiyD/55hi890HcSzp55u/royZ6R7vS?=
 =?us-ascii?Q?iRAkBCMd3WN3OvqM7f4qFkxElwFPBrohPKPEW4wdKygxzOMyuk/gqC3X9Mvf?=
 =?us-ascii?Q?0ndlRVmevxorwnCfHN/f1U2XnVQtajx1STEL3LNAz6ZC6Kf4lKp5V0gQ0ik0?=
 =?us-ascii?Q?VnMFvExVIasi8hXGfa+ndGxPZYFXEkkZauSvu16WVSuw7YIG2F9WilnkWbfE?=
 =?us-ascii?Q?AR60v0KoQw5CrMjmCj1SSHO9RiYGRnZ0iLTBhaDJf9KMMwKr8l83cWHNcfDR?=
 =?us-ascii?Q?AdQJQ4shx9HNAA82Ia3Li/wY5A+Jasht3je3/Gw5lFHpsY6+uLqAqPjLiO56?=
 =?us-ascii?Q?HPlVfdd0oKB3nOes6683SDuuDGsPy8/ieruscSwXl9y2Ww9AayKxpDqXeooi?=
 =?us-ascii?Q?7XCVUUwsVqojPewoKvdSFl67zGx63Rc+lTr7b2uv5xYePXQXeIyb0K43ls2x?=
 =?us-ascii?Q?IKYCerleuSJdXlqaogFL8llcZ8529W1ZaE0nIIj1LbBMfmWncPNAXKXoAA5w?=
 =?us-ascii?Q?n2GRrGxUg+8cKvE6jSdlenvbJBKVsjR+1WUbNRXGqkpKWCvoIPApOkgbjcU4?=
 =?us-ascii?Q?RPf9i4WlYbSueEOBFr5enfSyPQWmNan7P/v1B4Rb5Oa1ONInaoEg3HsmLlnx?=
 =?us-ascii?Q?jg8Gd87A/17Gg0v5HKu54kuw2tZD7zf6bt8ibGE5gVTBsFmoj5do/3RTdY/P?=
 =?us-ascii?Q?OXxylRsdhJDVwUdQBu2JD60oVLdhx2tMD0jvD8jS5K4uLm6EuaWZPC19E9ER?=
 =?us-ascii?Q?TQeUjiTZo6aRbsXx/7ey8ioE5p5gUuQkk5GF4oEhbegxzMsAaR9oA5+pzgEb?=
 =?us-ascii?Q?14/JED9zMih8qxBao1/t1YMr7tE/LVAvO2NWYilVBildCEDyuTQxQNMklnBJ?=
 =?us-ascii?Q?Gxk9ZfWgNVNHeZVefFtY+CdgC2GUU1JkYkFWwhMgRXPvUxrT29ule/pk1tmG?=
 =?us-ascii?Q?cQ87Vi3Cq4x2tPcbnI/cejjSJcHvcOaOuG2DKWu6jZNNU6cKznFf1bFhZeGZ?=
 =?us-ascii?Q?emD/N6HltrPbQDZYlmTtHG4vZCyZrpy0oJHc65J91Z9yRuOassRIeetxLHJm?=
 =?us-ascii?Q?6xt7EzHsoYvxhiVXm/U+HSxb4yGRRGmq9yXmadpRJZj0NcBWp22q5wQ/+YSq?=
 =?us-ascii?Q?URfNLiKM5oeQvLJ+EJdtpzwm7FGa9g5YhhfOAE6asiZLZleErh7L1YycJGa8?=
 =?us-ascii?Q?Y9PrSgEiYw8biIclO1Z+p7dimEntDipFEEiq7oGTrlNXv/7Ptlz3jbcTrsoa?=
 =?us-ascii?Q?aqJ18uQvYyZF9u2AjFBs5X+xOxKq1kTaJfhFqPV91ne5CORnQkTKq2/7301/?=
 =?us-ascii?Q?82Zwwv0+R0mgjMDDQQviFgLEIHet0Ikxx0xNyZwO29O0aLqBQh9p3f1T9a1a?=
 =?us-ascii?Q?7Ani77SKlJ+2wQcA8j8opc30cvbGTQN2gJbKTLx3DfcpLNKb8QvCBcbqOloN?=
 =?us-ascii?Q?WZ7Tx6ygPpYCyUpMAJrbwNtZp7L5T8Q3lCLNVBA3dMRQBa/bY7xteAZ4Mp4A?=
 =?us-ascii?Q?w3NHkrGS9VXVnn6iY7t7S2j5jOfCeJQ=3D?=
X-Exchange-RoutingPolicyChecked: Znk1+5MbroOpQj8zzoPfiHzezS7q9LfjKK43pwe/AKRhDMx9QXEGCg0GwC8AaprfWL01lND0OSYUteGAp07qD2FCSOWGpvWwK/+Or0nNQdb27aLgq2AMd7erhRx0YQlvaaWOHE8dCr0Qq5YdmOVp+LST9tIDA7gmi/eJIDZx6IwWPQqiEDxP4PyM+NNTaQGWgZNEbTHnX/OHyWYr2lcW1blDsH/o7z2Gig8Ay8VaDCNwxmrPnt5I81y+EuotcLijDuF+6mQub1aRn/DHXoVPCm/hxPpaDQ936rytKDHS9xzKO+DIDH/6ApKZru5i/ggzB7J3rkwODt8U5QWzegBjrA==
X-MS-Exchange-CrossTenant-Network-Message-Id: b44c2b73-49f7-4404-cddd-08df2f555263
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 09:26:01.1820 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8Ym7fzvH3bM6cGx/Rhmmz5xuk77kDhzuwQRxB3eQGpR94TUtY7HSGrY7eQnWKLxl/JGmSM5EqvFysRohylaS/hxrt1jWUwOOBhLidYGfnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9634
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 01:11:08PM +0100, Anatoly Burakov wrote:
> Pattern lookup allocates a match item just to copy an entry from the
> engine's supported-pattern table. Each engine must then free this
> temporary object after parsing.
> 
> Make `ice_search_pattern_match_item()` fill caller-provided storage
> and return a status code. Use stack-local match items in all four
> engines, removing the allocation and corresponding cleanup paths.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

I'm sure there are still plenty more cleanups that can be done converting
dynamic to stack storage. Even a quick review of this change shows that the
"rss_meta_ptr" value in ice_hash_parse_pattern_action can be just put on
stack to simplify the code.
> ---
>  drivers/net/intel/ice/ice_acl_filter.c    | 22 ++++++++------------
>  drivers/net/intel/ice/ice_fdir_filter.c   | 18 ++++++++--------
>  drivers/net/intel/ice/ice_generic_flow.c  | 25 +++++------------------
>  drivers/net/intel/ice/ice_generic_flow.h  |  3 ++-
>  drivers/net/intel/ice/ice_hash.c          | 13 +++++-------
>  drivers/net/intel/ice/ice_switch_filter.c | 14 +++++--------
>  6 files changed, 34 insertions(+), 61 deletions(-)
> 
