Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4CDCD4F5E
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 17:05:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C4C5A402EB;
	Tue, 19 May 2026 19:05:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id A620C402E9
 for <dev@dpdk.org>; Tue, 19 May 2026 19:05:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779210351; x=1810746351;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=fQUt51vKWu8PAT1DLXUb31q5YfWzGD5zm2btNWtUyp0=;
 b=bF/rosGUto8T57Ssbwg+DV0vKltm9luTpVtfOylScBj5q2A0637ahojt
 xZQoFFNPhl2GKCQQFktbj92kJYYmJKKCgRql+8JndVVkCUEhYsT5oKox1
 pbC8aU+mYAExHmqEifnd3w0H1QY7/jVx3SFZHOVp7gnUGJC/5Mm95mbmp
 Wb3IDZrDoTZE1mJKszhHTIW1MRHbMGtzcGiXjRhvu+x0pPamn0Vx7UDke
 AKVVYTRbZoO7DE+uwzuE2acbG1N1WOiXGDGO8opgz1oTTWvC9OmSFQAP7
 A22/DUJwvzmRwa9pYVYFO3JwIo2NatkwLnmoUzYFRcNkvOLXz1/oEKJCd w==;
X-CSE-ConnectionGUID: EAYiZ/XaRCa8aH2sWsOwwQ==
X-CSE-MsgGUID: 1XFSF9RnQcu9Nd5zSan2Hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="82662987"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="82662987"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 10:05:49 -0700
X-CSE-ConnectionGUID: F/CLnK3uSYmjj55RI0QyeQ==
X-CSE-MsgGUID: Tpwe1IyoRsqLpa8/21PqjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="244798240"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 10:05:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 10:05:48 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 19 May 2026 10:05:48 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.29) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 10:05:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CgZcGmqegjQJ8cgqDwxVSfzB8PXP/CocLLHDuMgPzQ7wOiPje+WpnJEerPkbJ3yHGL8AKvMGVy1gZc/faZHViVgDhQru2xZ1H4v1aAkzsrKMoZu5CWIt5Atzdowg8PPPd0ZYLle41oSGjWl/DRakxe16EZbD1TkuhX31E8EZ+w5/C61K6skqhxXVLIEQkn37yXc513zDxWL+wLd/Y7BqVqL1vR7IntyebwiF67C03aSCwSBvenkNLikCCR7pZ7FyMoR+AM5nZJurr3HMuhTTcpB5uy3QhaPshx8zHxzl4XQAPTDHy3bDaGOBiSwlJBQQaAsmnLK5N/DCD3g9vEcWdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCQXY9+bEatNXES1qF0qmsuC79IJ5uqwUYFeAdBwc/E=;
 b=HPW1e3lKD+uMSIaBmT4Sk9j9MqmI2sWJpD4JUB4UarXOskVz8nhW7x1d8FJphXuyfROoc9WJQ5vmBq7SmcVIwmn0ltvyUtfEWiRpk42WRKgtVbsHnyac3TVLVqA0hrH26eCUIRYqetWhVznqy/i2V4soPCHRL4F0TngDxjJ9OVQmacRSekhiGo4r7etSYNu3SYIj/lbJs5IIHzsjuySQ7O7qQxJUZrodkcHJDRj8UiMUF1qn6HsB6qpvNx7s9CvmLkfw4tJs+ahMrEJLKbcZYDwhKjdyFBb4c84KR3IaLOOoH9aFOokaigJNraaCjgZMSNWPRSEdeEGS0wkewYPTBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB6822.namprd11.prod.outlook.com (2603:10b6:806:29f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 17:05:43 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 17:05:43 +0000
Date: Tue, 19 May 2026 18:05:38 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
CC: <manoj.kumar.subbarao@intel.com>, <aman.deep.singh@intel.com>,
 <dev@dpdk.org>
Subject: Re: [PATCH v1 2/2] doc: update recommended matching versions for
 cpfl and idpf
Message-ID: <agyYYj_wSrSRDpCJ@bricha3-mobl1.ger.corp.intel.com>
References: <20260509015408.29188-1-soumyadeep.hore@intel.com>
 <20260509015408.29188-3-soumyadeep.hore@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260509015408.29188-3-soumyadeep.hore@intel.com>
X-ClientProxiedBy: DUZPR01CA0178.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB6822:EE_
X-MS-Office365-Filtering-Correlation-Id: 25a676e4-2b2c-4a6e-3855-08deb5c8dc56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|11063799006|22082099003|18002099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info: Tgbpk7jnEDkFa+6URi2g+XxqgNK64VWrSjAZJJiLYQbVcSeOxsxZskL9/b+f3mJ0HKefhV2ATMV/N2U7sRXeBIgKVTePayvuJrutl846yG7+m+td/loj59+nURIuqsMS+hNrcQ4c/j+qTL480MGGAZXv0YU3uSGdZKBBpQ5RQeMbBHDR7+v7+bKn03VKa41x1C50SrGHVIYWu6ixr5uu9I+1kNCos8OdZ4OUhIkTXcIedHniiLz/+Dvfcm8JrohMQm6s+fOgW2kKIqEPFwr6aNWnhL0CHokKtY9vszAc4s8RrM6jbjRDQQEl7L7OlrBdfTsCV9vEeeCSMigeR3p2Lk6Vbnd4W/3nuP93TA2ym9nIRLvqTyw7uAlPdAx12mtMdiXrvMyrndsvUFc1h+GUzZ0xSzH3F20pCRgjkQBz1UpdnZ60SL29MPub7PmEQNVPohnUNxBaQcHk5+2RCyNH5YGV1bVEHmnsv+rQIc0MXf+y0zeE4aPOYttBo5MawDJSRgkZo1+rk0cJAlRW1TlPi2rJpUMHDg+16eXiJ6iC/tX/ZtCVIGeUeAJ5lBu6mrYjEsXcil9BVincOOE6rcgoDEFrlJbib6jxU/5zyjYId4fr1MDMkxbPetgPDHo01QNMBmLIEPY0M27tahV9r2XVePGqVvpRrz8KHCA7HQUB7S5Y5gJ7l3Z3nMIySScEGps3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(11063799006)(22082099003)(18002099003)(56012099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j/YaGPcQo6VB6vdYUVQDM6g2dLD9303SRhwmINJIs/PfRJLgSExy4+RnM2u4?=
 =?us-ascii?Q?BVMEYYeaP9uqDrZfTibSpK5AeRcytwkWDuk8SYqaWG+e0zUCrvMs1GaMB0jG?=
 =?us-ascii?Q?L1eDfJI8jI1N0IjobIjwAE1wC0j9hvRxuQqBzox8KgB+PF2uoHhex7szCzDD?=
 =?us-ascii?Q?xwI1kJQ0kqcTbNj+KZ/Ox9BKyOBx/elmfDUVXgkP3aeL1gNVbGh4C60vltm4?=
 =?us-ascii?Q?vAtFOKdj6Vrj5YSmDQsuX3WQ9qwDzKvH736WEeWkTwcZQMnuAKtOYKS7kvNv?=
 =?us-ascii?Q?Aeh0gknntvBFXfKeigPImrhjyYRQlH2fqN+9Pckhi2+5mQTbCWTWui79hu4G?=
 =?us-ascii?Q?sNVvb8lkOiH+1qNqGc/A0F+NDiSsCGptvltW9Wu/fPUbLnNAhoMb9QPjE4DW?=
 =?us-ascii?Q?QLCNeEyTNxFys04xSOq7aGNDT5Cpx4KI71vL+cDc0sKNCN6lSzJ1wmYw1R6W?=
 =?us-ascii?Q?fZsI99BFiYebdDlR6qGGAD1tR9RWDY4W/V/VoREOEod6giFUhPUo+k74amaU?=
 =?us-ascii?Q?I9XeMflHtgSiq+pK6dzOskRWu0k+po4buUwXacHg0kG0NMi53wXxpMtTr0gA?=
 =?us-ascii?Q?+1aTbVflWgBuRjVWrgHjD4f5yM5QTbU2Lw3ze3E19rrofjeSTU4qY0R0HDPl?=
 =?us-ascii?Q?DrR0yi6T58eeYjNOvodTC5TkeJx/3SvoNtK3g47JlVgEoa0V/FMhH7D/AxAA?=
 =?us-ascii?Q?C6RfDu2SVaHFhAANlW6EjHNwM7+TdwptHth2ixvzSzuQ31BVwN5Jk5CYku30?=
 =?us-ascii?Q?ZaAYvlPrRKY065Pl0YTNyEe6FrAhx6B8wGyrq7+EnXyjWjhE4/JXyHD10CMY?=
 =?us-ascii?Q?y4CzkiTF5+OnIyBu7mKHURVAu9NVXUrn4WN086CXgsz8cT6IYXTQOgCraO1X?=
 =?us-ascii?Q?u9pozqWVpY9JAmjXawGixindchHnzhpAwF411qVZLKSCwZYjU3bjm8OuzgQf?=
 =?us-ascii?Q?+1T5EI/bkquWf0GUhKaM4kmuUnuDG04vZUZJ2HsssuB/gnEUgQalTrfZJLlj?=
 =?us-ascii?Q?VCyicC5uJQTHftsSFfWgn+xCg4MsmW6uD7ZZ08edk3TWrJgtGA4FiX6ph2tl?=
 =?us-ascii?Q?UGkyLa8Ms7gw8fW+diFJeRUq1oY4e6jmjuEwu+R8SdhdgSV/PnqcpEcNDJvX?=
 =?us-ascii?Q?OMBOCt884EgFhfRoln5uxGGu0bAdCzDnXj2eZ1SjWiX8IXzLYdqhqhY1tYT9?=
 =?us-ascii?Q?3G1D0b+6U20oSlvSEHHJno7BJqHYbYSxRtZ5yWXZZFvtemW4gjoH3Sn0gvqZ?=
 =?us-ascii?Q?EEFAZ5OgCYDa4IzEXiHgf69yNMYW6Xe3S9vTP4S9HNXvmOLZRMeZvVuxCDpH?=
 =?us-ascii?Q?UbErPIYDmrwH+wui7Q+f/gzDD7VIF6XBL6QWNtSFiCV0wm2gerteIFwMtHAp?=
 =?us-ascii?Q?7m3h4YwIrSmhfxy9/dSYUZJLOY88pL3frIDqxypDARQZSWcObw8sfiNk6bDg?=
 =?us-ascii?Q?cvGTsz6LEAZREAUwSr3suDNYavyEPSI9hUoAyihhVIgcXt+88RjVn4IzWySM?=
 =?us-ascii?Q?dVH4gWL5JKOXViBiXuCTR1hVwxzM6qmuKyPnfc/vylxfaxLcvGZpMPOllmMP?=
 =?us-ascii?Q?PRgwtZ3KFL+5aLn2DIlzkkOyrVkwPFXJ5xkdiZT2eUZIkCY+B1yn/y0USKbE?=
 =?us-ascii?Q?suXn9LzXiKAs9uwzGLJkcvU7ze/yOIWLEe78pBRnP2HkRunVk97E8YZA1Y4E?=
 =?us-ascii?Q?qECOILkiGUJFKWbQ3/2iQz8uIZVrKtaBu9yd4vOZh6kLnK0UpWOqR2k442WV?=
 =?us-ascii?Q?wMW12R7o+Xou07jbFlJ2aR3JIlVForg=3D?=
X-Exchange-RoutingPolicyChecked: ZHUUkx/8exM4+A5+9TIhKkos0GfnHASukXU76T3JDTkKpNEpiDRDklYi1vyySKAAByIhFZovo8jMIZ+cWtw/diEPhlrGNZ0rgR+djcGz4eaIMvP44E7fL8eSQs0JPotRS3onuSQkdVnG6QAfuwpCNT6xfjpFSSzjqI8PA+Mw0vkdKj9APSj+RaWGmzOY0HUo9jG4tgBaouk4/V/0exg4uo2+A8hMJQFurtTM3y1gZrKSZ6gIOdiEtvQ+8v0NDBYtA/HziEzLoq/l0MZqvs425pcALbjEhgrloVdXxB3ySPAYNPDC9eTqPBvPG3ARJY8k923WjkOP+jn9j95llyBNVQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a676e4-2b2c-4a6e-3855-08deb5c8dc56
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 17:05:43.0791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JrppqeY3z1Z1gYiSX9oa3HiO8NjCTfVW4BBQ0fiKWxdCdSinBfvI64MAKA730Et6yP1VRc92m92uilZTJjZzUrncvtwGDVWEjhZUMQb4tyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6822
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

On Fri, May 08, 2026 at 09:54:08PM -0400, Soumyadeep Hore wrote:
> Update the recommended MEV-ts release version corresponding to DPDK
> release in the cpfl and idpf drivers documentation.
> 
> Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
> ---
>  doc/guides/nics/cpfl.rst | 2 ++
>  doc/guides/nics/idpf.rst | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/doc/guides/nics/cpfl.rst b/doc/guides/nics/cpfl.rst
> index bc42c524ea..da884f5e3b 100644
> --- a/doc/guides/nics/cpfl.rst
> +++ b/doc/guides/nics/cpfl.rst
> @@ -41,6 +41,8 @@ Here is the suggested matching list which has been tested and verified.
>     +------------+------------------+
>     |    25.07   |       2.0        |
>     +------------+------------------+
> +   |    26.07   |       2.2        |
> +   +------------+------------------+
>  

This is strange, having just the .07 releases listed in the table. Is the
same version for 25.07 applicable for 25.11? Perhaps we can update the
table to cover that, so that only LTS versions are listed apart from the
latest release.

Other feedback, to help align with e.g. tables in ice and i40e drivers.
This is not mandatory for this patch, but it would be nice to have IMHO:

* list only LTS releases (i.e. remove 23.07)
* list releases in descending order, so that latest is on top
* rework table to use the new RST table format (see ice.rst for example).

Regards,
/Bruce
>  
>  Configuration
> diff --git a/doc/guides/nics/idpf.rst b/doc/guides/nics/idpf.rst
> index c7c76190c8..a6f611c09b 100644
> --- a/doc/guides/nics/idpf.rst
> +++ b/doc/guides/nics/idpf.rst
> @@ -37,6 +37,8 @@ Here is the suggested matching list which has been tested and verified.
>     +------------+---------------+------------------+
>     |    25.07   |    0.0.772    |       2.0        |
>     +------------+---------------+------------------+
> +   |    26.07   |    0.0.780    |       2.2        |
> +   +------------+---------------+------------------+
>  
>  
>  Configuration
> -- 
> 2.47.1
> 
