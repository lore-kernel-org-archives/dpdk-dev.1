Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAF1CD4F26
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 09:27:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 654CC40280;
	Fri, 19 Jun 2026 11:27:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 1DAC440279;
 Fri, 19 Jun 2026 11:27:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781861252; x=1813397252;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=4nnRxXmOPCY8UBBdZE6Dvq6shnKdCLuEK44aDzPeJ+I=;
 b=lSNUkBtaK+sj5Z4ybgD7fo1267V6rh8dup/6dD+DLdzspyB+3qT/suI2
 nS7KZmaVK8c1q1SNJ581RAlusKM05IfOb/4+bQwi5YtihmWSvwRxmWSL6
 YJPNa37ITgQaEY81qUvX6iGeU9dD4WJs+Rso39/VXRkoFl6DToFegb+Ya
 LCiZIoAQQeZ2v7BijFkgKXT3icA3DdNcRCeYiDDW2SCLss+WycEqPvzr+
 rhFDNiB5eZpArnYgfPg4LE5DEKGaD2x2Blo5Ueey60AV+3f3tInXu/JLd
 23uUBqO1akvvNpTLYyNj4frhSF2Ff8jfZQTS3/jGHynvi4ZmQywRe7yAJ Q==;
X-CSE-ConnectionGUID: uhIg6YPDRxmol6TC+2T7FQ==
X-CSE-MsgGUID: zUiC8QG5Ql6Ord4zKB173w==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="82485129"
X-IronPort-AV: E=Sophos;i="6.24,213,1774335600"; d="scan'208";a="82485129"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2026 02:27:31 -0700
X-CSE-ConnectionGUID: 3tr9JYUsSk2Vxv+SSj9YMw==
X-CSE-MsgGUID: YGqF52HrQfawSCkUQ+6dAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,213,1774335600"; d="scan'208";a="247721102"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2026 02:27:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 19 Jun 2026 02:27:30 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 19 Jun 2026 02:27:30 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.58)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 19 Jun 2026 02:27:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oiIUV/8ahhrqzzl+4Bl7gJMYaooY1g1GANQY1fI5ikQzo3bM1aw85QSZHwjLjZ0x1ts/1SED3wc3P8sIJsaGW8xwUvhI5V1bYhhtYyInGBS3j9gbc5+upyE7ElNiViQqfoTyMYjO373LlQFQacMiXSdTtzfZFL9zr8qWo/VuOADycvL1mYQ6g2Jeog1LM8dk0rs9aRCMWHP/HHwSJsj8gQLcYNeq2p1XfQxWBZJbvaAm98q7LDPA27L+SrX8ZkPPZ5WfAHdGfEBtCb3YsVBGRmX+lQKDuVczVtULQcco5shUA8kzejq9vv/pTeys6G6TMacPYvYuxFuBl5ifpP8v0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhCE6zGR2EFEZw4LmLm5w7IdWjQN3hlGgUq3d7G4H20=;
 b=c+yd0Gg80XsCA1hL1b2GhgFheit0Aby5OH+9oB8Sz89Xs3hQDyboG93vU8f+m7H8Zx9OnrG36xbkvsp9C5bCr6Gn+nUv57D/GwEcoTHUzXzE6n+q0Gs9yPjOJ7u1xJlGGp3/4y7jztcnxVfyzdjPyAY/rzpB9pDsVX7uEXm5YCrFw2PhdTnfxOPCH2JtLN0hXq3/984OzFhr7RSe0WF6bY/oH9Tk9oazyoi2RbUZk2p9rfO1aB4VUssejv8YA2WRxQ8QkQWb3ML/ILVJmHtzsrTimtYcK+z4i3kFl27LEzgjnLlpij8wUn2H5ymIGLc2l7dfYZsSmtc5qMsOQNhitA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ2PR11MB8404.namprd11.prod.outlook.com (2603:10b6:a03:53f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Fri, 19 Jun
 2026 09:27:28 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0113.015; Fri, 19 Jun 2026
 09:27:28 +0000
Date: Fri, 19 Jun 2026 10:27:22 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v2] net/iavf: report selected burst mode when no-poll
 active
Message-ID: <ajULeqdMB_43-uy4@bricha3-mobl1.ger.corp.intel.com>
References: <20260618094959.97727-1-ciara.loftus@intel.com>
 <20260618121711.371057-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260618121711.371057-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZP191CA0053.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ2PR11MB8404:EE_
X-MS-Office365-Filtering-Correlation-Id: 845b9f58-ddb7-4af9-af5a-08decde4fae4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|18002099003|22082099003|56012099006|11063799006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: iJgBohccUEz3oaBi80ScnlUwtOM1pkCWlb9BsLPdrHmCYGTBqnYPgA9hfqpgag/3g26R8nY/OUY3KDM4CcB34OuZfN/wB1YoPymeJGDUeDrG9CALaUta4daoMe2RvTFzhWz9nCE5eIwHCvsT7AuSRp8o/3rFAR19Mk4E20ZqyEcWiK4CKmYBuaeptJjlDrTBY6A67aSiyNp+NuDzlDwujgT2wpAEAbMcXlYEWF9bF8kooUp+IWOV++LCLZMO6/cU5S4QLIkIbhWbMNVMr2viBWT/ajEd68AmRhzKr83MWEiyzjgIRjeE4l70PMFjdh8daH7MChpeA0XoXxanety5xFQfqDHsBiS4oX91E2twNMr+zazYMURzsd418/UQApYiJVH5zDhonWJnkSIXbO1kdB5mQHWrDYHN66MGgEJRUUft1gANFAZmkLSAChSVDUR4GCxuzJophPnakVTp8+zJW2xNhf5lmmWGFN7yB0xkzidkDYMJC0OuwycZ6/ehS7OFRLpQgtP66uFOye99mpAitsvEINrAbvMjOaiHrpC7rUKPTibxwwqUlr0JwDhc338X8rjofBUSgk4l479kh5BxQcisZkKHTtNA9sRpKqYJmcCQumFvcpPzK7O5KoR8Gnw9gAMCVwUu95b40+Y43AJjBpqoxmuEXIaw6hbiDPQi5KM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cugTHJOU/wosG79WR3xL2gFlpV3HOO9Z8Q58eIVdxGLinKGXr1bh6D8TJaFW?=
 =?us-ascii?Q?b8g1OpZQnMbd1QwPj/ZZR7nYrSwy8/ctDyJ0c7Kd3OXt7XxXusUvCJ6+MvRc?=
 =?us-ascii?Q?mNXW6coz+Q2K/0nkVrLV4pXktH1kukLIGgIcCDdVKo0WO3gJV4ZNv2pEPhtn?=
 =?us-ascii?Q?m9UwK63UaJHC8umXtwOxsePCPpiJkB3kpqDsmofBsJBSs9Kknzu/eyGG5p4/?=
 =?us-ascii?Q?46aikLCogNPegHcidQ8OpIN7wk4FWYdASKnX7yRaaJTVO+4GUHXjxW40BMpt?=
 =?us-ascii?Q?/nZBSgX4xUyUAo+ksYuJ866iM6yQlJ8AGkexMF6tovv41Ps+9aPKoJr8mPCi?=
 =?us-ascii?Q?zSYXsrUkucWAT7cwmicqUfHfQrKbCB03PDgID3qzOkTKlyeARLtwQBtXRA81?=
 =?us-ascii?Q?k+DDKlepKVIBMoYmxt8O5LFLIfqjBTQYtQXBCtce9puXHAtFbEQ+Qk0Z4/LK?=
 =?us-ascii?Q?13kSOSOri9NJ6NOnRcqTG76xCfjr955VyT3dBwNIEFLsEVd2spwWIeUCr+kR?=
 =?us-ascii?Q?/NNVY1KTpkAczpQYyLA+85/74DKOzSeiVkfMnTkIisesKj/Imfqfpi4RNDgz?=
 =?us-ascii?Q?/z3gcg7l8AkaCcNfn8c5i41Y1mPGf9ElYgiS/WBef3d4yEjUMZhJbLPoHTwO?=
 =?us-ascii?Q?0TkNBrKG2PvDAMOJlI91mv5ey7643fziI906MVfu0P+67d6RtkxWkVFtZvCd?=
 =?us-ascii?Q?aCL4uD+lJ9jlL4YzN84WjoIV37eYOHP8k2NmdvVtNkFQiNjz2k5PgRUxGcLN?=
 =?us-ascii?Q?oo8lDx4O0LpM+WSqBW6LVs4fHtqZ9Hd77zD5DGKQGS+8HReaNTxQSv/vpLdJ?=
 =?us-ascii?Q?g9NSBvDqSECdLIg9sgmpfeiXKe27h/sLedemDQRsx8/f0Q+bVixOIqi00qba?=
 =?us-ascii?Q?rT+hy90s3VUUSoyV1qZjqNqr7LgyvyEs3C1gasT9fSca88AiaFEyZI/doG2p?=
 =?us-ascii?Q?XC6YyX6MFAVGv/nZHlfIGHUduo/Nv7vCN/1KwCWoOGhAvQnE5jP8y11Eruhp?=
 =?us-ascii?Q?uVBeXNxBY2BosMXWLC0jAX9CNiwd8zqALOofDS+fi7f8z56+BvAH+H29NiWI?=
 =?us-ascii?Q?P2kmWEHn5IQgkKvlZEAe1ABvz8tetw5876qmkO7+4NJlrh756Hrp9pyQbmBi?=
 =?us-ascii?Q?ht0xeXBVF0z7QMi/5RbPv95m+zJQLLC0nSraCvzi+wk6Cy5+tie7silgfPpf?=
 =?us-ascii?Q?DEa4K1eCSswwn/OQenn1BU7iRLNC2IXfGMaHIA3kNTI4+5JhdJGp6IFvYJ3s?=
 =?us-ascii?Q?1g5EGFJScSg/GhUlyMYyhBWWgbqBBrF7S6Sqj5d0OMTije70j6RL+ahZc4RT?=
 =?us-ascii?Q?A6yCRx1I9ktPcSud/g0ChJLHwX+j32erbzVjw0tZax2R+HCgxFVMchj/GF9u?=
 =?us-ascii?Q?hMi0L8eFoMJuGb2aWZTI+Uc4CNc2SYdhinDZx7/S3zaxNbbjFABFS2qd5Df0?=
 =?us-ascii?Q?37xDi9y04e4YpScFEtJYHJIU/Uc5QY5MXvTCF9AXnOnrEM8y8Kr4CE8YsIAy?=
 =?us-ascii?Q?32XEYaC2iu5NvKmexox13/Jvs/6NM76ZAJpe3woz5Ex74DolfuJKyuVkRfej?=
 =?us-ascii?Q?T3Gfrs7Pb+etvWUbHOOFdSW1+eW9mF1Bb5YT0exnR0Gz6splbUpPtCjcrpdf?=
 =?us-ascii?Q?E8RaDvl0I3VNRLQkDJCFe7cFOfbKqiOdUUiU0ghZ4xR6RAgekDyN3ew1R0gG?=
 =?us-ascii?Q?DdAGE5U4LU+dS7oiNhwBNfVvH1zgDjLffrcby0QjcG05gSKUN1bLhl7uZ+If?=
 =?us-ascii?Q?zo30X3m++5wVYuQsTiJUqWPbyVTiTMc=3D?=
X-Exchange-RoutingPolicyChecked: Gry/gXra0N3FV69oFQeoaHZsJ0oURJeAG1SuBV4IDJ0ULS7c0T1s4bDe3qP/ArO104fp0urIuffImeNylb0LWUNet7TBmnx6h786irFm8aQLilk58IMcWdTb1eMHJ/AhAr3+hqwj0Mtei42COHPoua98AxsbivjAl7OM++8CKhgrbCz4MyBsLtgrjazdgKIq6q2ap3W8d8DqQpzHzRTkxh2U/mAJ73igI79L6Q/AnXRf0C/E/7XHjT6zfrZUGmsKkyI26bzlEuDzAVQfBsEZ/X0qgb33fX8fkTp8Wcvgdmpu/YiIsIwoSMc5jUJEWswzInQijCOfUn0wcxUnO5I0oA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 845b9f58-ddb7-4af9-af5a-08decde4fae4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 09:27:28.0361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OMnkhb+g0Dj5OU8teIOjvMyWlt5gSWtLdiBtk4WRP4D73FU2R4etEg7SadAxNehMrYsjuBwYm+gw7UxKdxEqd06b0lw1P26pUpGRtXXA2vI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8404
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

On Thu, Jun 18, 2026 at 12:17:11PM +0000, Ciara Loftus wrote:
> When the no-poll feature is enabled (it is enabled by default), the
> device burst functions point at the no-poll wrapper for the lifetime of
> the port. As the wrapper occupies the "Disabled" slot in the burst mode
> path-info tables, the Rx/Tx burst mode was always reported as "Disabled"
> regardless of link state, even though the wrapper only drops traffic
> while the link is down and otherwise dispatches to the selected path.
> 
> Report the burst mode of the selected path directly by indexing the
> path-info tables with the selected path type. This fixes the misreport
> while the no-poll wrapper is active and also simplifies the burst mode
> lookup: the previous pointer comparison and table search loop are no
> longer needed.
> 
> Fixes: 0d5a856f5be9 ("net/iavf: support Rx/Tx burst mode info")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.
Thanks,
/Bruce

