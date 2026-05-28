Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798E7CD4F54
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 13:14:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65E2D4021F;
	Thu, 28 May 2026 15:13:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 50D524003C
 for <dev@dpdk.org>; Thu, 28 May 2026 15:13:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779974037; x=1811510037;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=pl76dHERl26EMW+QYd1QMqZ4DtDbyVfxWXvYspBXotM=;
 b=AmgrPqdsYaQ9P0fEgLErCD1tFQt5zHyzEStnAOV5kcWGmXBLzLgkrh4A
 GQNgyg+1Rr0epJ7JsC5kTqRRZVJ67FipdxhZtSm9pmskH026ihlH80qwh
 q1aMrbM79jHXjAuwaXHx/NrQUjsiRQcjZxaDdt6I5N2qjdkjRFFhKrxQl
 uQt0AMOm/jp1YHP+PhO82LZ88fgGhEPDyRg9pKe3iFLTUzs5KV5QOaWDY
 vkimjbh3ZiwUAars7iD7pc8v0yJgST7d8F3tXsi5WWcCgpH9ef5I4wnOL
 FI3y25+IZBwXfkhIEdk5phcWnMqu4G00fTVBMZBjxppa+oYLWEpZ2EPH6 Q==;
X-CSE-ConnectionGUID: P2B+JacES8+Y8wWICQEc4g==
X-CSE-MsgGUID: X/FpM1WVRje1dCEiUqKh8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="91384887"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; d="scan'208";a="91384887"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2026 06:13:53 -0700
X-CSE-ConnectionGUID: b3GlX6YnTXm7DvTOsq+H1g==
X-CSE-MsgGUID: hmiXZ0L4Sdmr6gjpp8+iEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; d="scan'208";a="239972968"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2026 06:13:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 06:13:52 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 28 May 2026 06:13:52 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.48) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 06:13:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jjicQSfrrHA+//q/9SLIIU2gNAs2jveouLNyTqERNOExc4glUxZ9nzlC2iqonzolArah5Vtt39F1G6s3QAYJf+Pqn1XFA/OqUEvLxz4hrQjy7OQU/wKCrLAtLgD12HhMxHDTsMwwle4TuLJhvC5KpikAgWovZ1yG6Y6Zs3IPWkCy1iB3GOIX/meWIFR+kFVHywsQM2xrYYjGjq6BFRxw4RMilXTjzFnSUQUFjS7dPR+U7phihnl9Lh6Ze5cEydoNg/ev5D5wdamxhazhufAB1gm+Ahnp6E8RvlxJXxrcEszfv/vCNbXafp4rHlWXcnqjQrfAGB+PoxF/kHU0HS14fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rk2OOOD6HV1h5LuebWBMKmbXZlYyYqGNVgsHOqCGdw=;
 b=xunywON0xqUeeRpy30N9kGgcH1rK81cOtD3HqCy+EjzoKu8tIor9UuKBoKFcUSM16QLTMg3nU7IBltHwCzU2B4N020L98UZf8ave8zhEMo8SJkz9bVKTKkHhr3QJ6Pe15kGJTgsJ5uTVOJZlA4DopqjLmMgdALVrFhdeRbak992m2RyWFuoEiT66mBZ+B6MlCtPCuXaY3m0hEYOcF3JpxIwGejT/lP/bKetWzKztTTNIBL2Yb41x6JTmPwd/eq3WNsXjOOm257ohJ7GBTDyk4J85isZ8Ii6hV1MKoemnQiZPw4/06ITLnIjfT7P+PaXWU5snmpGYBfwT6mu5YrPZAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB7823.namprd11.prod.outlook.com (2603:10b6:208:3f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Thu, 28 May
 2026 13:13:49 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 13:13:48 +0000
Date: Thu, 28 May 2026 14:13:40 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v5 04/27] net/intel/common: add common flow attr validation
Message-ID: <ahg_hFvDIpwzYEyQ@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1779717943.git.anatoly.burakov@intel.com>
 <cover.1779717943.git.anatoly.burakov@intel.com>
 <d75e9a02b40ccfe8fd2e00977ee99e9be95ca9ad.1779717944.git.anatoly.burakov@intel.com>
 <ahbxgjoGdAEm99kj@bricha3-mobl1.ger.corp.intel.com>
 <9dbc8a94-ceca-41f0-b759-a23cbae76902@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9dbc8a94-ceca-41f0-b759-a23cbae76902@intel.com>
X-ClientProxiedBy: DU2PR04CA0087.eurprd04.prod.outlook.com
 (2603:10a6:10:232::32) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b31e6f9-bd81-45b1-661c-08debcbaf482
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099006|4143699003|5023799004|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: LhYRj/I9NBkQzxUzTOHk5SLbZfhfJSubj49TJW/pBApIQdQcLRVXM7sdOfXQEc1NyNUjJXIH4IG1bjFBOpuNHGOqofYGXDGk6hs/ceFVSEpgt5u/MJ/ruYXIpoAI6t29TMGkLFqEEtXPuyrUeqw2+97GJwe5vMMeW2jj/jlH6+jc0m80D0svLvR0drf3Imiv3VF06w6i5J7SkTzKRElMz1tiPH3QlHk7+Fe6VfpCxPBiToIq7TYyo1E89xDzI0sgv5z8uIU9Tt7ii69Tek6IgSgqZqSoHAF+W/DqwHC6eec41/qFYJDayjgmAapX3Ttf+cDov2pZDILhU9JseD7NXySJgSi9e96L+yd3CgINmALkmJ1hpRWdfV6enFG+TKM0SyvIrbxtUj/0XIWQmHM5/F0/aZmNX7HSW90n2yHzR0RiJbaOh52oc64cqpT5IPjPPPX3ekbWPk30xKilNVhDA2IQ8/RYRCSb/IBbIqb7AjlbZhNSMs/uSevARywt08XTU5Ga/Ic8do7JXwoIpgS2yWtjVZHyi3q3I0z7F2rwYyNXuNEE7owsbsDQqC9SmjR9IUglrAfrG7HQ8h2B1YgY9eUbFxfAGff23HAsquuiD6hrUs84gCWNa5AZA6f17xWbDPXLx6cAePd+R4w7ehQsc6LArJA+m6c+lVml04Thk1yV50gk9OdpAAqXjN8D5iuj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099006)(4143699003)(5023799004)(3023799007)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MSstlcI4eOoLLtHL5yVI16vp6lOK2HJj1y/U6bP3bs0hZGkOJJqeXvapdq4h?=
 =?us-ascii?Q?klBEalmw/MGe7tdGYGBy9cms72Vve+uw1Oyr/HfWLUSxJq/HzYyXamq575dJ?=
 =?us-ascii?Q?NEZkMtRGAsunZdcp5iipslPbhr2wBX3DxzyfMY0AhrmbvYXE2dwVq6041eK/?=
 =?us-ascii?Q?z7ms256UIYQuyETPo9DJzAUadtjBIqHswxzzZ8rszJcx5+NQDntm8G3y5ktu?=
 =?us-ascii?Q?KKj4cmxjV4SWj8pQ5e0ZhxvPJ4P5PEyjRdXCL3W92FiHfEsE8HRvAFBrsInW?=
 =?us-ascii?Q?CW27S5l/Bt1NDylJbcVxzU3pGbslOoaPVJ0VmOrE6RtoW0UuAhgMvn969gB8?=
 =?us-ascii?Q?XyrLjWqi72DH95OwjyPt/i5ecaGQ5KVZqE0fuSPGpeN7zB/OoDxKdAbpkA0x?=
 =?us-ascii?Q?GqZ0DhXy3vPeM3QC6L8ReANmZbo4gUdfk/+zpYRmSQiyq8X4HPjIo3FeqMGh?=
 =?us-ascii?Q?qoV/phagjGl5fYPnnPoMK9FCDUY/4ZANLtJcJyjpmvubUBw522Kvw9HfgmjL?=
 =?us-ascii?Q?MRUBZYbsV5tyLoQ5Nv2WGc7GHPBUqT96snF0BoA0UdMW89uF/4ymANo9udjV?=
 =?us-ascii?Q?z4bam0X2+Zil0Aptf6nSVE08XuLYgfG2QHPpR+5cxfdT2jfMX7MKHEI9bYJI?=
 =?us-ascii?Q?bxG1vgLVlo6gsRCrWT9iHqTfIpqsv0Qku3YC2NUNN33QErhK9XCNQD/mvtH0?=
 =?us-ascii?Q?6Lb2bJBLD182wUS/nJYGPlA50rp4gIg+EREaQWAJA91i/xE7OXT9g5bHU6Kv?=
 =?us-ascii?Q?gG0eFIGzPAQPBWCB76GmhtdISXBHZEkSFw0Jhz47pb32Wnm+FOLpgGRw4wW+?=
 =?us-ascii?Q?0e9+BIGoeYy6V8uA6ekwVUJjvHe4j4c5hhTgp3tbLWf6LaB74FA1VXDulN4T?=
 =?us-ascii?Q?z7QAr7aC4yEUSEQRk74m+97+R1hVRTRBq3kpX8wMnKjMLTaPiyDmaE3vczC9?=
 =?us-ascii?Q?DW8ckUeGYutL1njft6ESzby7x/82ejGaX8sJbxelF+54YwbijQPzikRrEwO0?=
 =?us-ascii?Q?a5bfAhrEL9lXwvPEaLgQmYGjdT47E3cWtGRawM09IirvCzj5Ak1dkQ2omEJ6?=
 =?us-ascii?Q?9DRQSz7wLHHXc5PvUJPkJKZaurmpSKfCzvvHJwbC8t8JdJlhpGoSdyNtc3uM?=
 =?us-ascii?Q?CkY5jfNK31WYwf2wl4GVZakxzUV2hhUDD4v+bPLEyu5aMtBZZ28rnxFwExzN?=
 =?us-ascii?Q?VUKyVQuSN06Ebm/B01m4PxZDMCZVNasirQRgKaghxPPMK6WBj7kSRhXKSaay?=
 =?us-ascii?Q?jo0W930d8p1NmmRojWoyE+gOX61w4fTURQJ1OPH4berCzjgptQGEWTyztcGR?=
 =?us-ascii?Q?sX40hdmXo/5zattj6TTV5uROuoxuuysSGL+I0BFAXVXURJBQKSgWIw5vUiNh?=
 =?us-ascii?Q?vPaMeAiAYd6ULIgCtdzrSpbh74sxnm5O+M8sZ0aidqmJzpCIAQcgQiuzYdhz?=
 =?us-ascii?Q?NpfdOntz4qBCMPW0v3k+Hh28qgu2QbR3m8MJox17MGq85sTpPaRVsQYipDwx?=
 =?us-ascii?Q?1DCcvSafsASqYykEOehByH+KH00kgRnzHK0Pmaqgv31q1LUkMBZbUNn66Cqt?=
 =?us-ascii?Q?Rw/f7yR+geG92v8NUOHeroGTULIUlTFMOVaZW0+R+Y5SNftAhtduoTrh0B76?=
 =?us-ascii?Q?IfNhDJlD9N4+gC+gEjU0BwuFGxuiqkI0txUyNBQjndwAvUgugq0h7o8LGfa7?=
 =?us-ascii?Q?2eYwjgGrFBWIs3Yx4g+U/T8tFLTud+M5Pank5BQIXBPY9VupusQDgx2NKfIW?=
 =?us-ascii?Q?dnEe2wIfmPhzIgrAFFGOekLVJVFluTs=3D?=
X-Exchange-RoutingPolicyChecked: hoy+w2PLJT0p8qRYoFuD0DcJkVRBDg6dARYY4k2/i9BiD81NjUE8Z2cwHRNjGaXCnWyAYaJc6hNuxTiB4DttXtJrUpsolvvNM/wq1luJelGT9v7FBrrlPQZ5tgGqEvIQbesHugyasvSX4VHuMMBIfiOwFQwfTVLiDscDOb7A0eh2AY9GjA7yJpKP7Ue1Cm5CgdaG2AEgBfFmS/0+TZPXvbQPaaDVRVUWMri5WtGjjjttEJcwYjlz+w3NKl5aIr0WM2wmddO/Qq3aWy3FLp46o6yWrdlz4Ni+xHgdXeITAbmYVDSBpLSyNgLso3KS8s0asW4ycUmtoflhX6QXIAYXUw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b31e6f9-bd81-45b1-661c-08debcbaf482
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 13:13:48.7907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V/ICARfuSfpwLOCJxLBZFO1UhEj7mkeKciUQicsFTu6YPRFrN8PcWK9lG79G4O8Wd7L3e9snU8kPAr5m9VYwUP6LA9DOs04Q87PzV+E4U30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7823
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

On Thu, May 28, 2026 at 02:39:47PM +0200, Burakov, Anatoly wrote:
> On 5/27/2026 3:28 PM, Bruce Richardson wrote:
> > On Mon, May 25, 2026 at 03:06:23PM +0100, Anatoly Burakov wrote:
> > > There are a lot of commonalities between what kinds of flow attr each Intel
> > > driver supports. Add a helper function that will validate attr based on
> > > common requirements and (optional) parameter checks.
> > > 
> > > Things we check for:
> > > - Rejecting NULL attr (obviously)
> > > - Default to ingress flows
> > > - Transfer, group, priority, and egress are not allowed unless requested
> > > 
> > > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > > ---
> > >   drivers/net/intel/common/flow_check.h | 69 +++++++++++++++++++++++++++
> > >   1 file changed, 69 insertions(+)
> > > 
> > > diff --git a/drivers/net/intel/common/flow_check.h b/drivers/net/intel/common/flow_check.h
> > > index 74fb28ae3d..0572028664 100644
> > > --- a/drivers/net/intel/common/flow_check.h
> > > +++ b/drivers/net/intel/common/flow_check.h
> > > @@ -54,6 +54,7 @@ ci_flow_action_type_in_list(const enum rte_flow_action_type type,
> > >   /* Forward declarations */
> > >   struct ci_flow_actions;
> > >   struct ci_flow_actions_check_param;
> > > +struct ci_flow_attr_check_param;
> > >   static inline const char *
> > >   ci_flow_action_type_to_str(enum rte_flow_action_type type)
> > > @@ -271,6 +272,74 @@ ci_flow_check_actions(const struct rte_flow_action *actions,
> > >   	return parsed_actions->count == 0 ? -EINVAL : 0;
> > >   }
> > > +/**
> > > + * Parameter structure for attr check.
> > > + */
> > > +struct ci_flow_attr_check_param {
> > > +	bool allow_priority; /**< True if priority attribute is allowed. */
> > > +	bool allow_transfer; /**< True if transfer attribute is allowed. */
> > > +	bool allow_group;    /**< True if group attribute is allowed. */
> > > +	bool expect_egress;  /**< True if egress attribute is expected. */
> > > +};
> > > +
> > > +/**
> > > + * Validate rte_flow_attr structure against specified constraints.
> > > + *
> > > + * @param attr Pointer to rte_flow_attr structure to validate.
> > > + * @param attr_param Pointer to ci_flow_attr_check_param structure specifying constraints.
> > > + * @param error Pointer to rte_flow_error structure for error reporting.
> > > + *
> > > + * @return 0 on success, negative errno on failure.
> > > + */
> > > +static inline int
> > > +ci_flow_check_attr(const struct rte_flow_attr *attr,
> > > +		const struct ci_flow_attr_check_param *attr_param,
> > > +		struct rte_flow_error *error)
> > > +{
> > > +	if (attr == NULL) {
> > > +		return rte_flow_error_set(error, EINVAL,
> > > +					  RTE_FLOW_ERROR_TYPE_ATTR, attr,
> > > +					  "NULL attribute");
> > > +	}
> > > +
> > > +	/* Direction must be either ingress or egress */
> > > +	if (attr->ingress == attr->egress) {
> > > +		return rte_flow_error_set(error, EINVAL,
> > > +					  RTE_FLOW_ERROR_TYPE_ATTR, attr,
> > > +					  "Either ingress or egress must be set");
> > > +	}
> > > +
> > > +	/* Expect ingress by default */
> > > +	if (attr->egress && (attr_param == NULL || !attr_param->expect_egress)) {
> > > +		return rte_flow_error_set(error, EINVAL,
> > > +					  RTE_FLOW_ERROR_TYPE_ATTR_EGRESS, attr,
> > > +					  "Egress not supported");
> > > +	}
> > 
> > I think "allow_egress" is possibly a better name here. "expect_egress"
> > implies that egress must be present, but the logic here seems to be only
> > allowing egress if the flag is provided.
> 
> No, the check right above this prevents unspecified egress *if* ingress is
> also specified.

So the error message above should be "Either ingress or egress must be set,
but not both"?

> Meaning, one of egress/ingress *must* be specified, and if
> it's egress, it is only allowed when we are expecting egress.
> 
Yes, so it's either ingress or egress but egress is only allowed in some
cases. But nothing in this check prevents ingress alone when expect_egress
is set, so egress is allowed but not required, so I still think
"allow_egress" is a better name. "expect_egress" is a bit ambivilent, in
that it's unclear how strong that expectation is - is it an error, or just
a warning if the expectation is not met, for example?

/Bruce
