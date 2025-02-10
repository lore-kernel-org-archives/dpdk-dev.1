Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224CFC02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 16:08:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D32142794;
	Mon, 10 Feb 2025 17:08:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 8E4B0402A0
 for <dev@dpdk.org>; Mon, 10 Feb 2025 17:08:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739203683; x=1770739683;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=p4ZGwetVMhh9tL1S/F6QFiSLn3i9KTfHchI1W/HTgKw=;
 b=O/OY8A0p6qnL4P0m3fkBANjrYiaJIGnRwxfEm25uff9QzHWSpMHTZJOJ
 8IRZiOT8fwh4zUEZb2d+v55NJJI9lVUbGVUnQEwWEP1MGI37/8vq1sDLV
 sR8/u0T31f03VzUH2t/VrtxtL7SkmGRDbLWWH3FzRKWgPqt3tPtUpnI26
 0TlJUh38lhXUaO+0fiwO6Febgiy9pD9YUG8Yk99jJ6TuhlGtqlVK5WhfV
 ysvZs56XfY7jOiA7NUKdmD3aG/julEtmpOI5XpGDYKxOo1gbStO1EbBIn
 o2poXDkH/qY9vNItHaJs9wQ4mvzUocMVfIJghdfAmov63kL7nxPH6hVXG g==;
X-CSE-ConnectionGUID: jZXlcdDRSxeW4jQTfo4PXQ==
X-CSE-MsgGUID: lnp/Xw4vTPaCtKSUktj1Gw==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="57204476"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; d="scan'208";a="57204476"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2025 08:08:01 -0800
X-CSE-ConnectionGUID: RX6xdrJuQJOdkXBTY8jUeA==
X-CSE-MsgGUID: Pod81e8bTcCwBbSq86rq2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="135489297"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Feb 2025 08:08:01 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Feb 2025 08:08:00 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 10 Feb 2025 08:08:00 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Feb 2025 08:07:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v9uWLj/CAvFGNQGe6yWTQ8apQqRk6DI+FwMm9a/4usattGALbv/Om7wAM9Y0YxT75qyFjw05rjw+g5ORt150TmcZ+dtH2hMlUGzfZWYxjRiVceOj6gEs2OOjRE87DMb4CE8EfaFqF/G8NurQoIRE3QZZjYMmQ2BiVnGVpLY3JGzbFnq9iNs39K/KDRuaaC4oI+FwfuZifJEWww2U5KwbbD21nUW0JMBbofomNU+O+rwvKZRvTNF8NEP/h6uDFmRUZmG3nEP8q2wWAa/qy3XjEFNTNkC25vqqPFUXM3votiHAhN4O0vWuIcbVO1g4FiEVVewCPZAK5Gnoq5hEVE2TUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKgmn30YHem7teEHX9HGVphRSqKHqIda31UebtXnRWM=;
 b=Zm5BvDUE7j/exkQXmU+ywWRsqXBFjlx5p5RIw8J8cVGA0JzfrAVfkT1q0++BUzoKvrVyfghDz4ZGQ1wEcNfbab4mN5HhcrP6skgVmTHLsWS8J7KUpXeB1FKEhZD1I3YH72YBTI/7VhgAABtRUm8VQxl0s6EO+F8ARHR43C4hQElHZDv7c9QVnLUd9BYr7vVZCG14aeB3zeb34+X2s/GiNs2AVu7AMNTfm+c7qSFqVp+lXHhE8N2phn6eazKTNG5Gy/PBrqgs0yzlV29keL3Sut3G51b3NjJ/2gv33WA3Vh+6nOVFckjMDPkJS5P0JGGnj/n5H/beQx7EiJGadiRkHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW5PR11MB5761.namprd11.prod.outlook.com (2603:10b6:303:195::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 16:07:52 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 16:07:52 +0000
Date: Mon, 10 Feb 2025 16:07:46 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Andre Muezerie <andremue@linux.microsoft.com>,
 <anatoly.burakov@intel.com>, <dev@dpdk.org>, <ian.stokes@intel.com>,
 <jochen.behrens@broadcom.com>, <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v5 0/1] use 64-bit shift, avoid signed/unsigned mismatch
Message-ID: <Z6okUp9VJphhw2pG@bricha3-mobl1.ger.corp.intel.com>
References: <1735246770-731-1-git-send-email-andremue@linux.microsoft.com>
 <1738950069-21059-1-git-send-email-andremue@linux.microsoft.com>
 <20250207110157.1283d121@hermes.local>
 <Z6nIWuulEuQ1H3HH@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z6nIWuulEuQ1H3HH@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DUZPR01CA0023.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::17) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW5PR11MB5761:EE_
X-MS-Office365-Filtering-Correlation-Id: 70421608-fcf9-4b47-b92f-08dd49ed1246
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?smNnYGtcoePNp5E4D/l356AsJYfNdCfoULeQ+TCDr2YG0PviCtFfrN6z+Mta?=
 =?us-ascii?Q?+m52sKKC+xH8MpNO75cIlAeNKFAKsTX+oqeV4cd6IcCTlNwXjVxb00jrn/9o?=
 =?us-ascii?Q?UTR826DD0+0z6+rPyIV7ZmHEMtAAvjctqD+RvV7YLX0TSNR0vIUjxES85DZ3?=
 =?us-ascii?Q?WCsEqVg+CYztMx2eGN6tDZF9LN6k5oz5+/XgC5GrbeJHC+zvAbg01D5CEgCs?=
 =?us-ascii?Q?75VtQZw/jszfhJ6homm91CPu/kWWuAW5hagyzzA++gH8ZqKor7lVHuTUdq4U?=
 =?us-ascii?Q?3329FQvezmb5B7l/PJPef15wQqMPwwuy5vTIRD1TFEWqMhS0i12aMFM0F1DL?=
 =?us-ascii?Q?Bh5exLXUiHA3apVDNowdZ1wFvBSgd4YqGOk/BIuxMKnENejRy3lRBl/PXWYN?=
 =?us-ascii?Q?T9DZ8m63sDt7T5rK7sXOJC4Vvyz1gAZV8yLHEYDOmq8HBajY755Guy2hxQri?=
 =?us-ascii?Q?OOzd3LcZg5JZqz8PPVg/2y3V8d9WYJG6cc2+PWqZ6o1tb0KYoaZ/JGhb5wze?=
 =?us-ascii?Q?x/jhfds2fYjgs6NQF0LcVz+lNyrz4mctL3bqW4OgL2DIVRliRhUar4RRbnsf?=
 =?us-ascii?Q?+ivjSAU9J/YZkpawJmbR8rDyEVesoPkp+AthdeLCks44OPvbHfWIpM2sq/vd?=
 =?us-ascii?Q?3idoddkHtD+zJPOdpCKCxsZMlSd01N/nsYin+o5zBO3WFchhafUJPHt+ofKc?=
 =?us-ascii?Q?J1FXvIaIhJN4H1sV4HTpTBF7SFy9U/FVRij9wohoyGgArN7jAKtmm3TwMzAo?=
 =?us-ascii?Q?dIkdANzBCvkFhb/WCmjF//Z3R1rcHPxPiTJ05Abmv8UAKT8fd8zobJ2o/x/Q?=
 =?us-ascii?Q?oPYBs2W6oixeK8TWbDbSkQJUZHMZ/SmBnNDWghQXhaPaDglHN2TPDmLLJacs?=
 =?us-ascii?Q?1hpDCiV7V8npvtRa7qsIkXSleyWzv6PVheM+Tnc2aa2UD5ahQsYQ8oMCmQhY?=
 =?us-ascii?Q?EVO3BYvtBISsf2tek+IviF0NaidjF7svQ65zZwdOJ9T1s6W8tfqhpZMyd4oH?=
 =?us-ascii?Q?FAMllIVY38RAGz5OfeIQOohatU6jUZk4Qt5VCay4r8ddbRc3pzajVy2EL9mf?=
 =?us-ascii?Q?mJhDNZFuMrBXDq8WQl6Q2atxw9R+0jVH5tOe1korZ3/qwHtIHojdUWuf9dKa?=
 =?us-ascii?Q?zxUe9pbU+RYNQOfsS9wb4uXhr+CLRS2hYqyRro3a7AKN+BetNoAePxyt03Ot?=
 =?us-ascii?Q?MfZEJwclwLYmiLMKTUmu+0cnDdbWuUbxda91rlY/G7ZWBMdo0bTXhY0RtLw2?=
 =?us-ascii?Q?R/rkhx9jNHCD2zcoem1AOrKeESXK+O0buWxQ/WE5CBrE3bBQGMcxdkkQn/VY?=
 =?us-ascii?Q?HB1LsAxcYAc41tpdsNzttUwhFw0jWVMl7YL/wLZ6RMfsEQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bqGS507D06D8o/WNaVwnoYUTzZ4c5mya/gNLZ/vZbGYYo7jOAd798/XR3XCM?=
 =?us-ascii?Q?adKkVW5LAbCWY44q4v5CeAh8zgm9BGAbsaTFK0vIYkOzL4jmj6i7w77Zj5H1?=
 =?us-ascii?Q?GDzUvbxvqnXEGwnPYfdQcvMe8SrMo9rKhDggUq8/xApojNtAZk3gCjOZ7Z/O?=
 =?us-ascii?Q?EoqXBxwS77l/63YAgXePYMrTcfJ9Vm4k9FdrIqzdyzHDyYGTNHyONGmq8RX1?=
 =?us-ascii?Q?/mWFyU2ZjQWANgdYqKMgQ6+Mvg2KF55Mk/MyI13BXNDBs5dT9VblKpbgdChC?=
 =?us-ascii?Q?Cb3P1pOqHbyBUW/jvlW2gFUQgdzhPpiZa7ITNFjgdwFwxs6ESY+DsVHvGK5w?=
 =?us-ascii?Q?AjkPksw9jh8tzlN+tDVqoATFkZcNPURAaHm/gGW+1clxsx9hao8NlOKasFMc?=
 =?us-ascii?Q?xAbLKyAQX+tXzpcVAugGMQcf6cSqmURDSO/lZyyVsP6UfV3gcmS629cTLUsv?=
 =?us-ascii?Q?uPTz2tnQ9uqvpCeQo+hntD03sLuUPLe9YOcNJlEa1H3IjxwQyDj0beanrmmd?=
 =?us-ascii?Q?2Yzv6U0oVfy0CjrpvEsQfvBQXj42XGK+u/BIj5TaeYDd3JuUkpg0qlAQ5WmH?=
 =?us-ascii?Q?Q6DU1hivi0I+DIYD7liHr7JIrm3p3xMr517XzJFeJAqYSfImZtXdEmmn6dGn?=
 =?us-ascii?Q?5VKjFq9dwAB+sKdrGMzV5XM3cx91V0bmk2RBUeIraS6OdYH/lFovJaHEtIrJ?=
 =?us-ascii?Q?9O8kIDyjv8lOfwnDbcTAzaSPVRYdXaz3OqHFJE45A7JXuGRRXtlkUfG/dCjp?=
 =?us-ascii?Q?GWxKr8hKuZIoaXBCd7YEsoh5YtOsYsB5IIcp8qPWwjv70Jn2XqGZ2LnVB4lq?=
 =?us-ascii?Q?Tk5aFP2WdvXXD1VQULQiryH/RMzZH4/9WtM5rjMiQC4teQM4K3BScdBZdjsi?=
 =?us-ascii?Q?sp2BBEYgCJHecFP4rWFwCppKXV1GLJOGwa+ILTwaogDU1Z71oopN7hbbUvLC?=
 =?us-ascii?Q?df4tC3kYjUKVzSdQsEHNSp5nMBoZPi9Cqv8r6yIGA8uuajHdwZWcUEuLxSmC?=
 =?us-ascii?Q?pLI08sVn5WzYerVxXV0SN8FNGt0lG0J7n5xzBFiRpW7eYym33eeonix+eYH7?=
 =?us-ascii?Q?Gx9uiucf2hvesSLhCc5MyhIEQHVbo9wxP7Oj2BNBuk6Msg72+ADXNpaJqRbR?=
 =?us-ascii?Q?G3TjaBdYUrdZOxY7SYrfLFKFsDr5BblD+w4l6CbyouW0yb0a82sTipf/vGXp?=
 =?us-ascii?Q?bMUfB6TIh7/5KIL73TVtbvr98RtZC4WidGzzbZ8ROOyK1FNknjVD+bJYNaD8?=
 =?us-ascii?Q?hNM/hdUmdb6yfjOjPKMP1iX2KP3g8d5H1WVed6t0v6IVU2FbKIWWda62imeB?=
 =?us-ascii?Q?uUinQ/Xb4hcdpI19kizmSHsRpoKCsn8p74wwDWVnxz/o2rT8+rjmN/09Vl1w?=
 =?us-ascii?Q?9dHQQKUrxm33PPfCdC+z6lVfKzSbkpHG4F+LPPYDdRUNJswLNIxtg/0E0hcl?=
 =?us-ascii?Q?yA4LUP+ipEVH4TvjTBo5D7xuyQyKNcpRLP7e8Nnll3zxGBAl/YgHdqBc5l3f?=
 =?us-ascii?Q?eY1AuErP+miKnPWvrPwEO62yUlUEf3mmT63KAt4BpfNvz4EjYY2Is9cJ6ZlN?=
 =?us-ascii?Q?XfCFxOi9p5SkiCQWPZXdshrnCCAmgAa6lcR3Wdh6rlsb34SCHygm9CL3Dax/?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70421608-fcf9-4b47-b92f-08dd49ed1246
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 16:07:52.0679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KZJ7SI7ZDfw53pI4aw7q7clXR9QgJ5mGCrRsr1BEXuxCiXgCwYJ90wlSfvoTSS0I5sxXAK31/T8kQr7ysglLQqSmlMQWXA0F08/pNky2PiY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5761
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

On Mon, Feb 10, 2025 at 09:35:22AM +0000, Bruce Richardson wrote:
> On Fri, Feb 07, 2025 at 11:01:57AM -0800, Stephen Hemminger wrote:
> > On Fri,  7 Feb 2025 09:41:08 -0800
> > Andre Muezerie <andremue@linux.microsoft.com> wrote:
> > 
> > > This patch avoids warnings like the ones below emitted by MSVC:
> > > 
> > > 1)
> > > ../drivers/net/ice/base/ice_flg_rd.c(71): warning C4334: '<<':
> > >     result of 32-bit shift implicitly converted to 64 bits
> > >     (was 64-bit shift intended?)
> > > 
> > > 2)
> > > ../drivers/net/ice/ice_dcf_sched.c(177): warning C4018: '>=':
> > >     signed/unsigned mismatch
> > > 
> > > The fix for (1) is to use 64-bit shifting when appropriate
> > > (according to what the result is used for).
> > > 
> > > The fix for (2) is to explicitly cast the variables used in the
> > > comparison.
> > > 
> > > v5:
> > >  * rebase
> > >  * use uint32_t instead of uint32, to better conform to DPDK standards
> > >  * rename variable rqID to rq_id to better conform to DPDK standards
> > >    and avoid checkpatch warning
> > >  * use 2U instead of (uint32)2, which is shorter
> > >  * simplify expression in meson.build using compiler id "gcc"
> > > 
> > > Andre Muezerie (1):
> > >   drivers/net: use 64-bit shift and avoid signed/unsigned mismatch
> > > 
> > >  drivers/net/intel/i40e/i40e_ethdev.c   | 22 +++++++++++-----------
> > >  drivers/net/intel/iavf/iavf_ethdev.c   |  2 +-
> > >  drivers/net/intel/iavf/iavf_rxtx.c     |  2 +-
> > >  drivers/net/intel/iavf/iavf_vchnl.c    |  2 +-
> > >  drivers/net/intel/ice/base/meson.build | 19 +++++++++++++------
> > >  drivers/net/intel/ice/ice_dcf_sched.c  |  2 +-
> > >  drivers/net/intel/ice/ice_ethdev.c     |  4 ++--
> > >  drivers/net/intel/ice/ice_rxtx.c       |  2 +-
> > >  drivers/net/intel/ixgbe/ixgbe_ethdev.c |  2 +-
> > >  9 files changed, 32 insertions(+), 25 deletions(-)
> > 
> > 
> > Since all intel, this should get picked up by next-intel
> 
> V4 had some non-intel changes too. Did they get missed in v5?

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

I've taken v5 into next-next-intel. Any missed bits can be submitted as a
separate patch later.

However, since the patch really contains two separate fixes - one for
bitshifting, another for typecasting - I've actually split it into two
patches. This avoids having a really long commit title - the "and" in the
middle is a bit of a giveaway that the patch should be split IMHO!
Andre, Please review on next-net-intel tree
[https://git.dpdk.org/next/dpdk-next-net-intel/log/]

Applied to dpdk-next-net-intel.

Thanks,
/Bruce
