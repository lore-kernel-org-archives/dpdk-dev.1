Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC5AC83F1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 11:12:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70DA9402CC;
	Wed, 23 Jul 2025 13:12:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 7898240264
 for <dev@dpdk.org>; Wed, 23 Jul 2025 13:12:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753269167; x=1784805167;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=hrgzO1tSDu/aCBBFaKFx2MQLWjt7DCF/8Uoua/0ipY0=;
 b=bwl7qoWbuZkkQlVy3iTnQcZH5LguWgSiI6KK+fcygrBEzT3AemYq+1B8
 6+wXiJalBimB2mvfWthQPntEbx3+jVUdk4p9MCz6fvhC75qYLPfuNySPa
 ejFsMtZcYu+XlCXb56pdriVr/WfORY2oL2LEKB4TAvlGZho8R+mzkenDw
 UEvCMTBuNMwy+0WxDHK8ISW5KJk19LAeisy9OmZCg0a6x35qhIO8Ge5Ou
 T3/DaKhscmiax9GNhrXkha4IGwPdHDjv3+BXeNsvQLYXvklkWH5o7Zlb6
 RKqv+seV09HoHqyrFw7hEjfkXCDmy13pmX98o4/SnrM+LcPGB+WiSvhrT g==;
X-CSE-ConnectionGUID: Dg2yBjBKSqGnoEUK86U0lA==
X-CSE-MsgGUID: q/k5w9aiRnGzg0OexbuLBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="59205645"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; d="scan'208";a="59205645"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2025 04:12:46 -0700
X-CSE-ConnectionGUID: ixlZUvCmSZqQOnggv2RycQ==
X-CSE-MsgGUID: +A5GGcvrSliV+qCmRIm/CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; d="scan'208";a="160156760"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2025 04:12:45 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 04:12:45 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 04:12:45 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.42) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 04:12:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HoIHn7XfjV+m+10/eNUTfEUzIfVcSEgc2UECtTQX4sjHLuqTtsZTBR+O60W2RmtfABM9petJWt8fUrrJYobAHSy1MWzAAxp+AnRPATT2ZglJYuOog62vkPBEQMmIu8d6vWpvTno5gtHYvTuahps1GBG9yIhR0WcQADDZRGtp4zvZNKnfLefbsp1bwuBxd4RRW85lR12hQA0YwrkJWK/90bb8tD58AAAVlNaS8KShrJJAoeVvr39FaQiQU9Xm4O0V3MfBcZX9+N0CENezX95+wPLgzmmdMN/gzdYgVZtLp4FAcAASP1k3qLJ+ddfLXi5NKQ4cvCFs4oA+FApk17oq/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTJm+aJwHHVMFfibvZ1E4r1jQfYhC82XcSYm7sWV4ek=;
 b=jpB7fHH4zbkxItW+aAmWnYO633CYCtSSWfSq+AvLPiRHkak2q9NvCrKXX6thcvt6vlGWdNOsz7zVsWZCPIaWow8tLf7T3ABZZ5xc14JgIHmT/DR78b+QPCzwESr7/Q/x4kQRmIzAk6tA7lqVbrJSh+XxVIBN7mOasBuhKNBMCsM+/njELuwWWDI/HYXaPs3pqf9cnazYh7nHuCKkkLwgJW8fOir7VKKeiMsb3OWbpj41KK3RQp6Y9xmhcuq4xeL3Y4+sBJtpi4G2jEOuqRJqD7VQrGZOmpQdaLpK7U+x/vqDAWUFojFd9RViarjV6h8faKzaNVtGcUIpKd0okzITHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB8253.namprd11.prod.outlook.com (2603:10b6:806:250::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 11:12:41 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 11:12:41 +0000
Date: Wed, 23 Jul 2025 12:12:37 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>
Subject: Re: [PATCH 1/2] version: 25.11.0-rc0
Message-ID: <aIDDpWm_M6m2SCIp@bricha3-mobl1.ger.corp.intel.com>
References: <20250722132441.3700305-1-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250722132441.3700305-1-david.marchand@redhat.com>
X-ClientProxiedBy: DU2PR04CA0276.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::11) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB8253:EE_
X-MS-Office365-Filtering-Correlation-Id: 885418e9-b826-4d41-7212-08ddc9d9d77e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xwT39Diq7PRN+arptcAbSZO/+HqbRAMHyjw4ADpwZw6Er5GYAtkNn9mGZLuc?=
 =?us-ascii?Q?YeqKtkzyiiCqfmT8U5nyt10r3KlmiW7+AkfhmyKBtQfW+fS5sR4CpTlaUac9?=
 =?us-ascii?Q?B6M9HzaLlWTCaIoneMZeErdpuI3yq6Bx27pC1+EWJT8EYr3u/NrESIJBJS3U?=
 =?us-ascii?Q?xFBBgcMV3IAFshjjBJqzru6O85fN6NFbdDxorSD4eSI3x7Xz2hSbky4K26ea?=
 =?us-ascii?Q?zyye1E81afKYgBoEbpxfEGJNI0WSSTptHjHjCh7Vp2vHD2ez9QEW++2prl6N?=
 =?us-ascii?Q?cWuzXr3R61sOk4wkjYB4YSjLqTTanaG6zp/53xTAt8Wii/mJRb0JKXQVFflL?=
 =?us-ascii?Q?m1Rx1RShd2cvfgxCoouk+F7cQEZsZ8APoCK3JPAWX8dTK9/8VPBtaLjrwBM0?=
 =?us-ascii?Q?7mtsBR4YYrNsWZPJxBUSxN6It1KgPqymHah2Wq+LTjJLccL3nQzw4skw8ci4?=
 =?us-ascii?Q?M+RAa2D5gAnh0mq84S7eNkYosvW/C/FDU7MzhjjE/UBbE23OyeVboO9sBiDH?=
 =?us-ascii?Q?ciy8MReEsDgeCxSb0Xq8S9doHZmeWbwIUtLyMEBJhUhKWnsHJMuSPP7rCUXn?=
 =?us-ascii?Q?Ru8JzqaXqJlpSzWnddxbLd2e8VVQpW903YRpOHf+RIdnxsf7cTiAPPXNEHa5?=
 =?us-ascii?Q?groq9iVD0eyYNuOm8kZI8gz+z2qnIAo3Qpu2obLVIM57vmH2ZzOpjRNP9f5p?=
 =?us-ascii?Q?R2mUWrQcNKvEau79SGPqitqu2Shwde2xSAtEUm7Vo3sJG70YRWjQC1K+HCXQ?=
 =?us-ascii?Q?JjVaYNIEsDDkRjFQdCCevdrwheosUqdszcvwmKVNyEzBMfIJr9FROyu3EcnA?=
 =?us-ascii?Q?Mth2jeCkX77S2gYP2r4le7MHvSi9wUtsXaiamxgi1DH+gvjb7gkhJa7XBW+e?=
 =?us-ascii?Q?trx+ZGMTK4lVA3URE68n/oDMhOHXfyukOGWPv8BRlMKviZ9/P5k4GY8lQjKx?=
 =?us-ascii?Q?jwKhuZXOXCi7q0Z9R0cE/3AUqM7EC76h1PXoj6/Wlj/YkQyGggcPPPWekQMx?=
 =?us-ascii?Q?yTxpju87VdyBz/I0Pl5qJCdFOghdJSbtqqTIXtGJLSlmMyTXIUw/UqO4TtVv?=
 =?us-ascii?Q?2erXVBe3D7fyE0D1DS6eMtbtfU4kYH1LtgLTZHLhJyPtVh2YccMhM2U/bjSG?=
 =?us-ascii?Q?vX3VMb9Lf2I/5coYUMwXiNJkij6ocjf9L8gIlgBaigNZxigfXhaVTpCp2Bsi?=
 =?us-ascii?Q?1yhR9A9I8+SL/FcbteFPQ7mWzg9LgrhctFhL8jnuPMxBHKtqqRv4swq85cP9?=
 =?us-ascii?Q?az0gFcQeUuSf4jHSGLybmwYnhepYTtwvB1We6PWlcWH47c1/emTN/0S3dZjM?=
 =?us-ascii?Q?O7+Q1zns81IyQBvwL3qK027mk311LGOJOyfivIqCAluDDehvh5LHDGmqLxR+?=
 =?us-ascii?Q?hDIdU9jhf5aY5OhNp5dU4CJtsL58wCpU2y0/JWWFP3bEjhAY9HYMZClX1ZH6?=
 =?us-ascii?Q?nMJhwqJnKEo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UI8WXn6mDJZRX9wOgIbSfSEbKsXzEA+h2I4zu/OOan/YfmnaIQR3TdikVZ5Q?=
 =?us-ascii?Q?qUtQPPIhPmkWbh1IR5w9gDERz+/YKiQ8jcgq2wPho2TWNKo2xTnF3QYHH4b6?=
 =?us-ascii?Q?ycaz70HXXefHvm0TBG5nWMFFNaSXnYbvU/sEXRu9FiHucTMhFrZubJSydwg2?=
 =?us-ascii?Q?t99Da0ZJ3XYnhZU+s8bnQUJECzyb5RfEqFjUpkfOYYEPm7rfImjrz33P6nt1?=
 =?us-ascii?Q?edryddPH/oDR7Tvw4n2nBzQ5XMYsE540OnpuIkPCacQpDrqOLQHLfqqTSioI?=
 =?us-ascii?Q?oLG+RnxjR186cI4TDubLFIsONkLKKBvvr0UAhebecj6jYaUemha1koNFQQ46?=
 =?us-ascii?Q?uzaMFhgq/MS64Flh4mdEvYqPVhKLgkdWySUJAx8FcFwqc3G3p3K7J/2ycqJT?=
 =?us-ascii?Q?gp0Nc5TawMOi29zQc3FrWGhnYfsKnRPwAb+6lWMSRwLlbt+LTwh5ipIsABmO?=
 =?us-ascii?Q?iJJID6TG9swXC/4Wj60VgJRvuIN+JfBesXOjCMpaXFcn/Ef6FuvdGb8tGV1w?=
 =?us-ascii?Q?EYcy5nUe47YOpLG6tmqGEOWYhqCqN6uFQTW7gYwRhMOi0URc/9ymk1VSQqIT?=
 =?us-ascii?Q?qW2Xe/Jx8M9JrCWOnVX8lxgnbl/wIVl61Enrl9nv5z2FM8e3xo9Em81rmn+6?=
 =?us-ascii?Q?WF2pgqhAr8K5y234hW4Ncy/JogBhTqJ3u9t6NhitUbRido6hzxsHwfk16JFG?=
 =?us-ascii?Q?QdYLsFYluipsUz33b4OTw4hJpShx0j8Qk5LbQgyZNTQlIXAUghsic8IFmLvV?=
 =?us-ascii?Q?D5NT/a16vazdrU8afPalJnGFmBy30d+ot8VmoBxQ2ZhtaH2RsU/ADdCVOh/K?=
 =?us-ascii?Q?ae1JPvk6hfGpMSDtpuVksSp+rUGBwU16vpxz/JlMQNe76nSxf13fcN7nR3/e?=
 =?us-ascii?Q?kMzDl42vlqashX5ij/g+d0EPO8dXfmEcgyjhk/2N+Olgs3QcoiATmmlxpRak?=
 =?us-ascii?Q?1bZWZwRLDnr1GNnyx4QE/Wq19ePmJFlpxL5y5n/fdf30suezIqMEU/RmNSN2?=
 =?us-ascii?Q?P4k4EDSSVJ55iatqBgapBmttSfH5tP8aYklr8ea/5aHZV1k8TkbkgXiTLcRb?=
 =?us-ascii?Q?n0WG46jwOPp5phF0EE+jBhcG7XnjtUMQNVXG4yhpY1CxvpOjvSgFYi+K8ETN?=
 =?us-ascii?Q?zuD7vzln3pILhO8GUMmPAd9tveUq8L+A6vCotOtsjxUP3Jag3ZMBvOH9xfWd?=
 =?us-ascii?Q?d+JwmtoUgX1LTI7QFW9X8eD+4K8FAN0BmFrJBAfl1iszAJwW714bE1T6Uz2y?=
 =?us-ascii?Q?5zdBuI9EeCruroIJmOeaC5sXPLc1b6oc5In9T0g9HxAR6fCWOrDz/aS7O+lZ?=
 =?us-ascii?Q?55MbChKL8yKLWFpfpiM3bSr8qXeq7pnj4vZsymlZni1VT4AwuTVDKFo4ne11?=
 =?us-ascii?Q?tUp24m2KNaGw1XzYvIhRySRzPqYIZGwTDCEhaULsoO32M456dQI26bA0VyuZ?=
 =?us-ascii?Q?e6BU0xVqAwuURzuOttzCeRC6LyRX2N2Ts3YeID0CJCubh+R65Zh4w2rmWpjg?=
 =?us-ascii?Q?fP2FYg2jJhgbA+39OchQYLL9UfnQebK9rbsZgf+KNWYl3whN0AaXcYzSlGj+?=
 =?us-ascii?Q?waTLWL+xqBQQaZNL7VDrJoiDj8/ireD/9bsrnbOQh3pMk5BXFWGFeDho2G+p?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 885418e9-b826-4d41-7212-08ddc9d9d77e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 11:12:41.8171 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4AgTHqiKYRV7rvA1hhinr4guMEnJ964/5UNR71FNYz+TN+V/M0ypSdiaLNZEQ/Yv3alwDAFvqKSs+PR+KCOiIo0ywlTlvSB2JcbTbooN+Fk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8253
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

On Tue, Jul 22, 2025 at 03:24:40PM +0200, David Marchand wrote:
> Start a new release cycle with empty release notes.
> 
> The ABI version becomes 26.0.
> The ABI exceptions are dropped and CI ABI checks are disabled because
> compatibility is not preserved.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  .github/workflows/build.yml            |   4 +-
>  ABI_VERSION                            |   2 +-
>  VERSION                                |   2 +-
>  devtools/libabigail.abignore           |  14 ---
>  doc/guides/rel_notes/index.rst         |   1 +
>  doc/guides/rel_notes/release_25_11.rst | 136 +++++++++++++++++++++++++
>  6 files changed, 141 insertions(+), 18 deletions(-)
>  create mode 100644 doc/guides/rel_notes/release_25_11.rst
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Thanks for this, this opens up the release notes for 25.11, unblocking us
from sending patches referencing it!
