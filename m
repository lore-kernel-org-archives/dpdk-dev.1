Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470BFC28B20
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 16:58:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BA4940298;
	Fri, 28 Mar 2025 17:58:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 9EBE04028B
 for <dev@dpdk.org>; Fri, 28 Mar 2025 17:58:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743181084; x=1774717084;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=zCnaEm9CgdfKjRiW1pcvopelFEJxHkAMurn1qJbVjc4=;
 b=fRXtma2jTSVggQT68I+mN9Mok/bbW9H7nV3pvJ4v88nOtA4U0lUU88wH
 FsDK5QQJ0qHWQpuKwa1oCDmKXbkaEw6ofnUPBh61qvGQ1XqAITseIZKNG
 3qnpNobM/mTmdJWZih1N8ZgBUhLCUYo/KlsrP49FDDPy92m55vmu3dwjk
 sL6kCZeGiBOITjn0GtdiMFQ3CcqtikE6KWV3nNcWLmfpd/Vt2p8geqV41
 8LpVJHGqdLXRTnkPr2GVuWTwjqCXijgX+4ghWyCethIkd97dvA51Vq725
 waN9nuQaYOpLN2QIKgTJRJspfm03N7VbhuAKHZi8Gt9uymCYswk7Ar5NJ g==;
X-CSE-ConnectionGUID: Tw7YpN9OTee1LO5JW8mvNw==
X-CSE-MsgGUID: PlNzKnDmRvGrh5sS4Xm31A==
X-IronPort-AV: E=McAfee;i="6700,10204,11387"; a="43708813"
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="43708813"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 09:58:02 -0700
X-CSE-ConnectionGUID: 3799R/P4T8Ou+csW1YiloQ==
X-CSE-MsgGUID: hl0VvVe9TtGwxo1nMhzM2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="156424430"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 09:58:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 28 Mar 2025 09:58:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Mar 2025 09:58:01 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Mar 2025 09:58:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TaFiXzKkgSDEp0nkGSFD/bZbr8M+1DvRdZrltLtnFl9XeVm/C/KGxCOk9pguOPrenaqZ2i91tdrhFN+zo4ybVr1ecod6BwXObA3o2SafdupuLUXbRT6f9Kd3+tu/aqBVomhAHtM9JjOb/M4/8RUuT2oPJxw9tkjswDV8jP5i89TEvO3d8ygVrFxtMj1WI6La4SSWqHuY+ul/LY9VW9U9M1e09oZcTsP4/+y1/vUdrGldsm7CY5+KTKoGVxrBY13+91nno2nKqO+x0yt2PyUslTQWl+mNaeGT90w7k7T3FZuIfuJY/CYuYPmCpNVQH9s6h9n9j0G7RuqhpbcjqpL/ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xt2AZHaTpax1sAkooZn1XRBtD/0R4/YPgG8puT590GQ=;
 b=qBRJz4lbW6qb5qGIeK3reMg9m8yxPcUK6VipLVhduHe2BWYfTRvgI/nDGQKrC+/lO+wqbVDeg2w6SiuAyjsptHmpop0SjQAe/rH7h6jgC/YUOiW1cXUQESM+69yxk3Vk6z7J8ZCNODGoC6oKFyCHUabZ11naHBS7lamBjbpAk/6o5+mgdBkolI4Jpm6ZFOdek4jTF29S5KJMzWtokGfURNeFwFUlGcpd6EMzJ8qpltNW3ZnIC70vrCTAkwo+SbzmWANtcSE9Ic1r6hIppiKZOjo8JJRAWxh6Csrw+1/d8Hb8YL3PJ6pZCj/n2raCoKoptmjmDFpNRBj7gDdeqO1e3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB8155.namprd11.prod.outlook.com (2603:10b6:610:164::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.46; Fri, 28 Mar
 2025 16:57:44 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 16:57:44 +0000
Date: Fri, 28 Mar 2025 16:57:38 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH v5 1/4] net/intel: align Tx queue struct field names
Message-ID: <Z-bVAuRV00BMnAHt@bricha3-mobl1.ger.corp.intel.com>
References: <20250327104502.2107300-2-shaiq.wani@intel.com>
 <20250327160437.2296127-1-shaiq.wani@intel.com>
 <20250327160437.2296127-2-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250327160437.2296127-2-shaiq.wani@intel.com>
X-ClientProxiedBy: DBBPR09CA0028.eurprd09.prod.outlook.com
 (2603:10a6:10:d4::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB8155:EE_
X-MS-Office365-Filtering-Correlation-Id: d7cf2dd6-6b12-4efd-1f5e-08dd6e19a89b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gDoZrjQuNDHlixvViIvNEArZOIc8VfBxDkoIKF40+RsM5f0mt82GVTvqH70K?=
 =?us-ascii?Q?RjClnZY0p1XgjJj4Rlzx5/7sToV0jc5AqR0SSxEsvjt4LkdzyHo/y08hp41c?=
 =?us-ascii?Q?WbLpHn1Ckgn4Hfmxaxddo+glNMJOqbiLwz/w00+3OjEFi5Ce5I4N63uWoDp7?=
 =?us-ascii?Q?xnvkSAmKGFlC0L/oGh5c1FQ5/5GtzCVyMCUhwr4PkzBgwrwj/HWk7hVrETmB?=
 =?us-ascii?Q?/p1KfEq0mVMaztxpBbWRIpGqj1bnALw3aUxhY1LFmdt+q6V7kxHd/mjs552s?=
 =?us-ascii?Q?OFU6WHpcUZEOR+xBvP3vXwVF9CZ2hgiDERQh8aIawJbp+vkubPIfnac0P3zB?=
 =?us-ascii?Q?95WKBdVHp9gEgt6YZ4CzDP77OhkWBdkgq8VmT+dCk6b2Qk4uzcEo6qWMz+NO?=
 =?us-ascii?Q?AyFEI/8ugs4dNao0k2la1FPxWKqlfR/wq+uK5mLhiemr5Jrj9VWrHyaBP+lY?=
 =?us-ascii?Q?43YDC/Kkp5YgqrIHsDu3qRRGNBG2p3jXdhlIP+XNCIV9sYvpg1PQcpWfioD0?=
 =?us-ascii?Q?W95P0j8KWXa9EynoXaXU5WCmUhe1uW0GiU9bhhHCuA1nZD1EFM7T31UhgsmV?=
 =?us-ascii?Q?24V4ZT+kLcgFMinO3Yonac95geKBdlnA+0mBLM23TT64yj0C4+23Mc3eB/Ob?=
 =?us-ascii?Q?TPH2I/OnV+YSV2ZTVdmbU/KNzB9uNHrhf6Y4Kw1+n7ENujx8f8Ybc9v85XMp?=
 =?us-ascii?Q?dvSmYyqdC81hYn6zz4RaB3CeL/Tjpam4ecHXInNPkiX7tkKnDUga6oypbQ0j?=
 =?us-ascii?Q?aD3ILS7b7xhtfAz5p+Jp6MPvWMWdMpEAzlI1pI5r4HsI++MprajcqONwasvs?=
 =?us-ascii?Q?2pLQu1qu/Z4sBiGyeLSKb5TMkGc/zz8O7AJwxIK13VTSoZEC/c+uULz+B2qu?=
 =?us-ascii?Q?tKnMhMxepe3jX/C+3Uzmb4Kp6QMgYHeUMBIcFMk7C1PYhMs6zLyx695GgtI5?=
 =?us-ascii?Q?Lhnvq9qn137HkGhvJF1cjXZm9Auy/e2DkgAUknsis+qxD3MtKFxSZhDJiSOi?=
 =?us-ascii?Q?QNh8pqhEJsAbxGopVZPXlSsryf655FZ9hw6JjA8tYb9XZfpiIUN0MIVdl2fs?=
 =?us-ascii?Q?J4Sc9gzk1S5+MXcFeblT7q/cIXoYa9BQSqPhmp+Y5FsKSNgXONTbBwv3sJVh?=
 =?us-ascii?Q?OqBiSuz8NIAQGxB/eJvoYaiIDdxTc07MCvOwVttnihMYseMnGmPkMCcsW0/I?=
 =?us-ascii?Q?/+NpesvCkE8DLnbko/6tH8Th2rLuoeQvxiKpxNdEIt24xM0awJrlDEQMXKoq?=
 =?us-ascii?Q?E8vRhksa4J92LVCkozO9geIGY3MNifZVSbZWshsonbMXsnU5IJvpCegmde9v?=
 =?us-ascii?Q?XMccGvRSJAvDMAsVkMOMTzDFWDnyaWfpbjSVv/X+2UVrSwl47ulJFvG+UNAY?=
 =?us-ascii?Q?C+0WOf2lrX3AUuHhpmEoMOnpL++c?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8GIJW6x2oA3+24LuU8AGb0YR1A0LBFBej7uZgPT4rVDLgpSLD4D9TEmfr83d?=
 =?us-ascii?Q?Qbku2fAtRkjcayX68uDMTe+Wdh0wMBJlek+Pp/g5TXnU/DZFsil8WhgMILbm?=
 =?us-ascii?Q?zlaTMILs0rti7rcanh+fwE3nJir4EhmbrEagT4/0kCdm0ilTRohUAvRP/6fe?=
 =?us-ascii?Q?BLv4CcKumM6x7j42BCrM47xYjMMXqicFPwaWsH1tJMEc8TDfl4fRWR8BNyGU?=
 =?us-ascii?Q?wwtKMVHItlKkA6Uz18WLD/tV0VWurIoOYoS+orZSu7/4EYZAlbfuiXKqE058?=
 =?us-ascii?Q?mvprjoz75TI/FWxO57OJENGyWBSmLcPStlria46mZlamIGuNqebsbfkdrp24?=
 =?us-ascii?Q?4E7KQj+PcdwLnLs4kT7ku06iePXv46RVBAe7r3ZNG7MwdOqPF9J19ja4zgl6?=
 =?us-ascii?Q?dhWKbPj4hqua3L5o3UJPTHVNtAGkvZNZeAQFFm5sjBo+89O9xvPDsVKfKcD4?=
 =?us-ascii?Q?Gi2rUIUysyb6oy7V2HS84cSpoxSk/xJwxVc6a+sRbI3xCu9/V2+uLLVUlOWm?=
 =?us-ascii?Q?BEB3wmblJwJz78ab5bSN5aB4Vwpz6aBxeymOMg/pkoH6t2ORktKyefYRmmxq?=
 =?us-ascii?Q?aEI8mJK+Dh5/ROCGvzwZ3B0bBU486SB3rjq0OAUVtxQYuGjoNpbyX97Yf7RO?=
 =?us-ascii?Q?l347gEOnDZtH0cYzynoQ6i6ICKspHNNXZyLayccNYzwIpxc5zkkDcwlzsILE?=
 =?us-ascii?Q?9HZvPV3R7YM2pm5DCnZQVZSAhxuzJJntSdh7Qh7eTJ6cXJ/AIl6m6f33aIoN?=
 =?us-ascii?Q?tVGr9FGltty+34xTlFWoW4zBMdHCc9R6mFLGNHlvJEfu1l/me/GU6tKsg95z?=
 =?us-ascii?Q?ZXMFFT4iCkbsY5ElziMgQL8wdsrV54sMeqYk+HBE834iEUxO1Uyn1OwO4zew?=
 =?us-ascii?Q?wgVr9KnEI1lp7P6d+9cJiEi4cRIhlvkUw4F04tsFa8UOtADbfZz/+7TIzsyq?=
 =?us-ascii?Q?qRWCSeduTN422SWyQz+JEN78rHr+p2YAMrdV+vE3J6FaIn+iHwW+96khz7uC?=
 =?us-ascii?Q?O3mJyIfdbG6DTRd6UlnCNa6DiQvCka7w0VruQqqkrHIoirllFLbs6hsej1Q/?=
 =?us-ascii?Q?86pi+4mbPYTp5SRRktVe9J7TgaVQAsJlsP48oiF6po+03Lma0RWhkNfbH1OO?=
 =?us-ascii?Q?2r9zr7kjKPcVMlwRlVTLLNpQyrRRyjRs0zZF6kH1EkZzwCaeAYeXHBolD5eF?=
 =?us-ascii?Q?7zU1K1J8mSPQykkumwPnR5XExqpn7+dnvksQJYFx8eGhJ4hyylE/eHq6+Fuu?=
 =?us-ascii?Q?Q9wY2LR5hrOKKoCxj1LeSiUJMxl6pv9d3zUs4GNBf5qLc2XcAqojDsb7dEZk?=
 =?us-ascii?Q?4JUeNfATpCLNoUUBYLnMHPUl0nghWQXGKIYC881bKuUCXo73Yi4UfBhDC8He?=
 =?us-ascii?Q?VSOxKsvIHOXXQvJRs7nA4NJ3MYww1KAudpZgH+OsWC7xRNefN721xfbddo9l?=
 =?us-ascii?Q?O6ynO4moNT5+Z0aqhZIMJk3F6a3Tkkm/iphx69GeXlXEJNR9nAX2K9g0fsW6?=
 =?us-ascii?Q?zf5+FBIIpewDO9NYEfL3QHVJZijnTjVh4P/GlSEqbTEI63Wv0Du5ERpcsCb8?=
 =?us-ascii?Q?rL950aaA2VHM3L1SBOkx4Hit90S24XOSa9O2wk3UAjaeJf5VjAUKvDywp0nY?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d7cf2dd6-6b12-4efd-1f5e-08dd6e19a89b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 16:57:44.0271 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XueA+DmVHOIxYJ5fqismb3wuEJAUi6cCcdq3VhrvvlKcUQNL2TS6OORWatCOv76MlzaKsKGiF1Fc4cJGta5buo1obFHMjGqEz/yQvPzIrcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8155
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

On Thu, Mar 27, 2025 at 09:34:34PM +0530, Shaiq Wani wrote:
> Align the Tx queue struct field names in idpf and
> cpfl driver with the common Tx queue struct.
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

