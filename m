Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9A6C28B20
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 16:05:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C059640298;
	Fri, 28 Mar 2025 17:05:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id C3CCF4021E
 for <dev@dpdk.org>; Fri, 28 Mar 2025 17:05:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743177944; x=1774713944;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=yFdaNYjvIHLpj9uHxdm29Q2chVNB1zlzaE7xmMDcWpc=;
 b=jMkk1MvUhJue2ZRtWfO66ApruvFz2uFPkMRvLCaI6LZ4asYLpKSPiziy
 EmlMWo1/1ypVfJ9X365/SpOppzpIep43Sevd+M2NnujXcegv+qkLj74yV
 HIDUNj4bj4bcBS+qpfb/Z7HwpnBtefDTfddfUd9bJiKS7S//WD7VoiNC+
 c02edYah5NCRxbkz2v77cqpdfU3NjW6vJFBX3jhS5Y06ENgHPcb6EN4Pd
 iIKjMefSDS85GV3V5ZbR0qTc7CM200S8jvSzz+bQIQe1U7rEzFV/nMRi8
 YntFR+8CzWR5P/Ko197mbMCpLH8PJ5QxB7XMknkSb7og7kdM7T0SHTL/7 Q==;
X-CSE-ConnectionGUID: Ckv2g2vDTKyWBuC7/7DptQ==
X-CSE-MsgGUID: h+62GsYTQ66Srq6A1lUp7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11387"; a="47273911"
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="47273911"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 09:05:43 -0700
X-CSE-ConnectionGUID: yCmCiTIqSpG/Sb7SVG5Ufg==
X-CSE-MsgGUID: tafpehf6TXa08P+N6FXXaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="125300570"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 09:05:43 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 28 Mar 2025 09:05:42 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Mar 2025 09:05:42 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Mar 2025 09:05:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OvbEayTRJhIbp1ha8OwgQ/S6azjm4J/1anOwXgBKYl3ZtQhF+7XKpmU4G1FreySN7MuCSojRu/7KKUgHSFoq+09Y1zpTWZiVy8q5VJanM1qXdfgab+jTTUzO5GkRQUc76XwXDoA4fzkYdf92uzFUqMYCJ13Ye80ISzUU27UmFY2XBSkzxvrAPksd3yVxyh7QbMpnuaJ/uxN8XMlAk3mLmdnsITO8MMxGA+7fvYG6K9muJUEcUJQuNL7vwjiItWcU3j9uz27hbtUs7E1coZqhLkSvinEk6oI44V9DiIdopE2iP3JFVcv0WzCRqoKVsziNFmWJ4zA8CxQ1YOWVcllY4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uycsJ+2tVgDEx7/+ibIZCQkKm2p/7vSn+CBdgNNMbtE=;
 b=xlDBqMGyaRZqCH8glhoPav0oMb2mqgv/o9qMqEZkxwrY0mpm1ZPMijOEqgvTtQGrktWr3XevNpCRCfmrGS9PkGsd3kxYAn224ISO1lewffQgV9p2gkRkuS1pQsqNXDBrqLeYN26SYlTomFum8iyo4xFTnMz4Laeb3ouTvJXF/C6Y4cHqDTOrPpZfg/ZejNmQ8eHKHiTUJZjex30S9fCOObuX21iSM5JBSQU2f8cSpKwHta6fJKEIws/w2HXFKFDit0tD8mqoF4DHV/00o6b18t/k8EqMZt+enH2bD58H4BQjDnnQgbu9nt7VDRyRIGycrRkuPXX7hvjn8aR9eITorg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB6677.namprd11.prod.outlook.com (2603:10b6:806:26b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 16:05:38 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 16:05:37 +0000
Date: Fri, 28 Mar 2025 16:05:33 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
CC: David Marchand <david.marchand@redhat.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v4 0/9] net/intel: clean up base code build
Message-ID: <Z-bIzVxqEGGmOlw0@bricha3-mobl1.ger.corp.intel.com>
References: <20250326155230.1315056-1-bruce.richardson@intel.com>
 <20250328111621.2665257-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250328111621.2665257-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DB7PR05CA0045.eurprd05.prod.outlook.com
 (2603:10a6:10:2e::22) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB6677:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c9a8e6e-1599-4bca-16b9-08dd6e126131
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+0X33b2V1e8JeiklWGHM0aI4qDY+Ygkhnrg5Qtq7A9tp+xEcFsG4R1WvzHsg?=
 =?us-ascii?Q?eYMrnYYj1Q2vyVccXrbNUfsnitNm2Uu/D6GsDuSQleQz3/WV6O9PWiNrFIF2?=
 =?us-ascii?Q?9IcW1H4P5cLPRHyICTQd2uPq/AjceSslRWDSrSBbDHjbC3X1MPr+sviKPLry?=
 =?us-ascii?Q?4EtUwHEYVs/9TzThaXYVDtf93XXSI7Hbb7ZR/9OPAA5nr+OgOlbELn9CyUve?=
 =?us-ascii?Q?iYMV5IJquThkWkB7PrC9MIDX/HSt+WKF5Ki0HE01E2LCE4y9chKqjt1Q+tgJ?=
 =?us-ascii?Q?cLyklTBX9B0GwWXSSRm/FjSqQkmzXtKEI+Q7qiOHoe1qrbCLBtxGeKpO5vZC?=
 =?us-ascii?Q?SP2F7HI6acIX/IKlYsW4WglH0V7F6rhwwyDcdReZnQTY1IhO2SIU5kYS5tiC?=
 =?us-ascii?Q?TP/ZZhx7XKYl0TfeOrPwuIZ3ZRWLuqOOATjXo3ZC8pdoMMs+PZpxC9Um7rcM?=
 =?us-ascii?Q?eDRMtYIN5mGjXe5GMAvPXW9zaD1gVQ154OTRBZEtUWWWp19D22FQnowC85X4?=
 =?us-ascii?Q?14qIsmXmm0cdyl+Gp6kQc2Wbl2cBro0Tu4CYxLNFWIBmrlabFMVz38mupDFH?=
 =?us-ascii?Q?bLt/S8S/BQBqsFQ7sR95vPB56BhYzDHFpSxdAq4/izVwnlyd5+eYHK62RJo7?=
 =?us-ascii?Q?XFm+nMhwckA4IBpP5HXesHcp57MNkQM6m5qGz+kPi4OJjGVeEIh5FA1Rhfv3?=
 =?us-ascii?Q?aYbE7fu/tR307PC6vkXk8pMxcN0ir343axPGP0iKHYukH/sSqn/Av21sadzx?=
 =?us-ascii?Q?fnDhv2shC59Wkc2IgMYyKnizl3T62ETlf716zmYFILzxmqXIKu+2EYAwddQo?=
 =?us-ascii?Q?ysf8Mm129XAF/Kjtvtpn0XSq+ctIrGwg7sDz6d8rNPFRBhC74SO6qvQdk8Ug?=
 =?us-ascii?Q?iBkxsySiEu4AYScNhe1E7ftIsTcZL3hO8E/ay1wIDkkjX+nNdSY4MrBoiH7b?=
 =?us-ascii?Q?pWm2FyDEhFSDvSe7DQSPtRpW3zqUWdRii0rYCKM3giAhIlipYroTj+hP6A4d?=
 =?us-ascii?Q?0TPeAZ4vy8iXg6/bD+KfPG3GpJQoa2m85enkgXKHJ3mDr00a1ZRGwHP276z8?=
 =?us-ascii?Q?rzmub01L0C+Dhy1kFdDzeTEYohYJ7SKalgKcTgbO1uKfcwkPGf4MdniiC/kQ?=
 =?us-ascii?Q?tq04Qp32rrCnniK9ApJIYlBUYmTG8zn/gMtX5pc1e9qeGJ5qnH1Vsu981DqJ?=
 =?us-ascii?Q?RPPD0ArmUPz1hv/k1K8DXQiUk3IaFcuQIkVE8AW0TbhAggKnHs5/I6sReUcM?=
 =?us-ascii?Q?P6rIDBVAZ1cghzJsicyYHY/uMWBEUYnP3Gfgm8FFc1b29Kduy4A1Z13JL3/1?=
 =?us-ascii?Q?k4HhkKqHg2NCJykKZ7HjEJQqOioR0Xc1C6WPelNDVU3r68jWLRCzlwoT5VfE?=
 =?us-ascii?Q?VUXZ3mweHg3eoc5hmWzXrx/UZv3U?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K9kdy91vlTHtoDt2LXCOhu2IRygwNVkvCe0ziDtPPAukV5VqWYIPRDuQ+pkg?=
 =?us-ascii?Q?lCyT4Bz8bPW7OcOZcPePSQ2izupY6fvtzHcSCJRktzAH3kTuQhpySqUpSGM5?=
 =?us-ascii?Q?sZUq71eNDKf62JJ9mjLswHQTZjnobpZjeSOybzW+mlvEWAEWtQBT8va16rqt?=
 =?us-ascii?Q?aYmMmNyTqS/w2087Xk83P56epSTgv84cJAl10b1gMNp8/d2NHcU8ltJ+lS6y?=
 =?us-ascii?Q?itW0Vbomi4ckxbWhe7xoRl+1dGhhxSjhgmeb5z31uVx/VwCAC/lau0/5ZowV?=
 =?us-ascii?Q?ZjEMaHVL9d+Maha0mRJQeAU+3tmdc1CRz0c4FsOoYSw9HHkevFRVZiW9mDj1?=
 =?us-ascii?Q?+ExZaHf06B+6n0I3BkLXgCh8kPxUPSsqjRTIQ4i72bI5rz7s0t9K4Ius8EqM?=
 =?us-ascii?Q?qvy8TEfYl+ZpJ4Tiq/5A7IkVRwuQsBQCaUGOVfdrfjUAJ0duTycSppjGnl84?=
 =?us-ascii?Q?u2LOoP9nSKmQ1QgDhNbwS1HUHS/ZwOSFq44Eo09UheIt5G6dj9ymKFJFfHNi?=
 =?us-ascii?Q?zohn+I+333CRe9dGdy5skBxBX/wttLWcBWPvpf3syun39wQT4aVYTGbMDZZm?=
 =?us-ascii?Q?/PFPUfM06gWSG5Q/D18jWdp9gWwPdu984rzFgi/c+G5x4FQq0u5RHkr/q4yA?=
 =?us-ascii?Q?lMlLkmDYajvu/pktwMFflkOhyjNme6YP9uw4In7syhk9zMavgwfFZcwA6JaH?=
 =?us-ascii?Q?9lJjUuFojUzGlvG9T/v2yq4kacUNKNG4oaKmhqIjQ+HPhMr1a32L35gV4/P4?=
 =?us-ascii?Q?ya2/yeGlbyVH8P5NDO3r75viS+er2KV6KnPoD1OjbnEw9t0lPIw6uqcQXxop?=
 =?us-ascii?Q?Ylxms0v0ms/g4kE2bxIu/+FHRqjPGLFRjnIwJc9eRhuYK6S7iKanq8VoWZyp?=
 =?us-ascii?Q?5HRICWD3iiNtTSw4bLO3bG7NOoelcti2x+EcHRIEW5lwAv4IJktuFshdkPrH?=
 =?us-ascii?Q?YRumImHWy43PE+9xql0HkGJx7csf3/Vk0uYk9C/Z9Hx0lXeG/Vxk5WKw4lbf?=
 =?us-ascii?Q?uUt5sjMey3pUTCDQstGeTlfqyzTP6sTnbhdh4y8u51E4GIm5CBxLTs4nZdcs?=
 =?us-ascii?Q?kUpx4bx3XzJmNddUWIz3C7l3W+w3HPcv6YfLZEVLk+K/ENTdddoWgcKKyiXZ?=
 =?us-ascii?Q?vUtX0w+fEevqkDovMIpFbZ7S0MfucuP1D1/ka+wp7wfHtDEmoVmh0nBK6Y3a?=
 =?us-ascii?Q?6Q3zrBPCl6jbBYVfgxoxuxUwDAt4DBVvt7bQ67aUvi28hOxgbFCcFmrDZnJr?=
 =?us-ascii?Q?X66xyuMxrzo4JwKMd6QdLTNnKTrerurMEA9vB3nrikQfN0EEpE2QiMyezPnx?=
 =?us-ascii?Q?mE+uUKggqQERtq3xIZteqy9RYsbIe6OvNqRXCJBBzLuSpJT6R3VAt0vFyMxU?=
 =?us-ascii?Q?Vl4XoWbDfESo49YK55yShGOTSQab+30m3PTaVwSnRdtxgWrZ/MhidLy2ooMt?=
 =?us-ascii?Q?7uqmgoEiogYANfqEGbpP2/Kwn/bt8vIxM/tahCzURZC/DLZ30Fp1gyhz2OWd?=
 =?us-ascii?Q?RINXJvtf17T+yArFlIQE64bQB4PARCv7KNK9kIIcVr+1i2aYeShLsheTCpGw?=
 =?us-ascii?Q?NCn/SvjhVh6vQBqwtWH4y2qxw98N6Y0mRw5FCagTeIIC7+m5gJAOZJDsT5i5?=
 =?us-ascii?Q?4A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9a8e6e-1599-4bca-16b9-08dd6e126131
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 16:05:37.8306 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MoP4l4bX8aW/VVzTsSTlFZIxy16zz4iLs2nnGyIivyb+MKPqjfKA5n7HpEsP8kftXtpKNV9LnQCP0LH6nlbZs0TY+7sgPFEfrb/A79NXOao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6677
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

On Fri, Mar 28, 2025 at 11:16:12AM +0000, Bruce Richardson wrote:
> Simplify the build of the various intel base code directories, by
> clearing compiler warnings so the files can be compiled directly along
> with the regular driver files.
> 
> v4: replace all functions in ixgbe_osdep.c with macros, removing file.
> v3: add fix for lock checker issues on FreeBSD
> v2: added missing patch for fm10k
> 
> Bruce Richardson (9):
>   net/fm10k/base: fix compilation warnings
>   net/iavf/base: remove unused meson.build file
>   net/ixgbe/base: correct definition of macro
>   net/ixgbe/base: fix compilation warnings
>   net/ixgbe/base: fix lock checker errors
>   net/i40e/base: fix unused value warnings
>   net/i40e/base: fix compiler warnings
>   net/ice/base: reduce warnings for unused variables
>   net/intel: simplify base code builds
> 
Series applied to dpdk-next-net-intel, with one change as discussed on
patch 6.

Regards,
/Bruce
