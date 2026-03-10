Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2311BFD4F04
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 16:56:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45D7F40672;
	Tue, 10 Mar 2026 17:56:35 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 73AFA40662
 for <dev@dpdk.org>; Tue, 10 Mar 2026 17:56:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773161793; x=1804697793;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=qdJwxC+CG7LZUyppXSY8ME70KQzA/xpeOEdczT3pXaY=;
 b=nmmSEO9EubYZHMxze2DlK+BW6TMfu55qrSJRlDyFGXOAW8uWx4y0ksS9
 VzekbmWQUo27r44EehLZWFwC7EE6iKnMWaw1VBnPog6e1dkRnAn241J7Q
 BKlmuoovA4iUm9LQXB6uwA3emtmKmkR1/yLKqMyuBSc6KQ5a/CtADaSQf
 Bc/sYmEDX1+ZX0NkUNPKySMmudYtcCsX/Nl8YiI6mX9FccDt/RWGqcSaP
 OyiZmK0Pjj5DlTz23PXGSsGBTvyxnog9qQ4i6NBSiJyqsm8BrzQuz9fQ6
 7lOd/OCL2ku19l/SGntyWiB2+uicYP/7tE0n+GFxqSG1KJdw5fMEJVvEg g==;
X-CSE-ConnectionGUID: NTZVpxOlTCuM3F6GzbhY2g==
X-CSE-MsgGUID: VxOBvnlaRbe3wiHeIYSfqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="91599344"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208";a="91599344"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 09:56:32 -0700
X-CSE-ConnectionGUID: JbeisGrQRBa6ql1SiL6YiQ==
X-CSE-MsgGUID: fseTlr55Q9u9sd54+0O0Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208";a="224874673"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 09:56:32 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 09:56:31 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 10 Mar 2026 09:56:31 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.26) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 09:56:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kmcAnRDw4dcmmnU6swVzRFT9GsOPWaMZDWKvn2yTy9fUGk5xSDq2Ux9bZbzQ2x2Fo7BKseCJP73NmuBlP7UNZ9JORXUwCGOZfc1OB1UsGdPkuVU+DmY7xn/Jt14KzEN1nKITUAHHwL0h6oF2k+ObnPydxRPqXEG+hIOkmUp3XPfloc/AqMnCq4ySku9vbu3u6H3+3DCvZU9tm9c3/SW0VGGRPslIBxATQtdEeDtRpbyrXOg/17b4IfLtcSUKtd6NOnFgSQC58NuDUe62kDeeiRPmQm9IhDCoc3CuSp3nWCG9hAwMy4unqMe5UrooTaIJWA1QXj92DisvNiWUt8MUhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynngPK1VYozJCSvC5X9/0Dy8+FR3/pU7s5A+V2Sbaqk=;
 b=PF0lbHsmbq8Lbfet/31HWNourJ4121BR0VCu+eJOv/K39nAFiv/syVcNiMz/Rd8Mnys/88nC7sF83uG9n2ojitQUfUmk9yXvVmSCSWAe2vT+O3w4XeYzqbC9oQ0tfJQyrgWyyhVm6ywPndFcV4TknnIqJ1s5VEobqGDd4GnzHzebhVxWbvXXUJNt3wf9TuAPJlGBP9Xj8FyeX0ROwXLJT0SCDc8M52AHc//EXguit2u/PTmISaj/DLQgU2PjYblyfTM5skN2l7sQ5AEHgecsnz8SHrIR0BsDFJquwMXseSTLwcrDNchL6eTi0FucwhSLeHfUfSzdTgzx2yp+d5PbVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LV8PR11MB8772.namprd11.prod.outlook.com (2603:10b6:408:200::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 16:56:25 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 16:56:24 +0000
Date: Tue, 10 Mar 2026 16:56:19 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Mingjin Ye <mingjinx.ye@intel.com>
CC: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: [PATCH v2] net/ice: enable link status polling
Message-ID: <abBNM1j-y6JfeQY0@bricha3-mobl1.ger.corp.intel.com>
References: <20241118085150.2587595-1-mingjinx.ye@intel.com>
 <20260213085728.3106335-1-mingjinx.ye@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260213085728.3106335-1-mingjinx.ye@intel.com>
X-ClientProxiedBy: DB9PR01CA0019.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::24) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LV8PR11MB8772:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f38869e-4abf-45b0-295a-08de7ec5f67e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: Xs/11/+DHO1NqrTPIXELGl6nbh6aeT/yQCgkP1aTKVVv5h2DHTWMiKEKITdiVxmvyrl9xpQAB9m2TLFAuwVcKxsYHjmx9QSjQpaVCAdg6lKgEkD/4yQjlfpugyF3jE4RHGS8bWPvHU43WyOblbgwO3NAE5/uMufYfeiRFkcKqEaEjwAO9DsDF9O819c4Mxv5dw2iF/mXDwOTMrmoaN7K7tE6pBDLPforsJGhlu95scY6tKPSahCiQ5mljcSddPrWspp0YzI7UNL0TelGfHW6jZh0EPjdH5gTgG9n1J0a7dSQamRx/U8A9RT1AOQS8aIZgOS/SoCW7t+yMO61DdFUoLPGqw1MxA1y+RPqo6IoMnM0NLf5tklYdD/uiOtPNoOnegirHlkzoa2yybTreXE7zm4ulZ6T3UzEmG9ZdlwkYiXbMFxRpYQr/uTUkIlomjiAPqEsY0VFq3J1mPed0V/P8OkPGh5bZMYPlMP0/nCYl4yodfY42XaIay3gikjD5vma7VJuSeXz3baqxVA234GHl6PG1touclr8xzCHEz2SVVk4KK9FWM1EisVvaB/ao5ZyRqn4qSIapUH1R9IjNnZrf89yuenKf6hATg/q8+zgRNL9n78o5QQAbvgW8uoK9rp7YjlKQJHDlS2jRrnZLTPkvPuTve3Qic+rDiXTeqzEyeGhtqR87+rwo1X+Vc/YG8R5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iHBvOKByGkaMxO6P7UhIWoFu3uTiWqbwcR+eK6iLf8tMPStRbJzYWWKuvTrw?=
 =?us-ascii?Q?aL/I24pIUg+/5oxVIKScBCxsYZ7RB9Lg8f6F12Ozos3EHJ5sJQp9ALeysBvd?=
 =?us-ascii?Q?+mmXiUt0Y0qdxJ82ck9wvbIpsAd+JzCI3cGzUN44yjnJp2ltU5YkASliBIpj?=
 =?us-ascii?Q?+Gg/6ucf602Q7W/WCEHuO2YE2QeIRLm3Xwhluy9bzj+OyZCiXqYN0kGWv5Hh?=
 =?us-ascii?Q?7DYwHcjm4JcNrJwt2j6V1kG/mQqxEXYqLb9s/vvgUFJ0Mb7iDZXY/W4YqP72?=
 =?us-ascii?Q?DZMwdEdfcEAR4zopqzZSdlfKlcc9FCZwS3gcQEd1MVin/+d1+S7wFyLTR9OX?=
 =?us-ascii?Q?sMNLjQm+safIEF68dS2f6iS2ACBYwliT7qLLEoc4/BYwzpPdq2QdXKM5Kpih?=
 =?us-ascii?Q?r79dFn5jTxMqSi1nr4dm9T7YdM+t4elrRjQY5wvLPqKk88XjYVaGUhELJ41l?=
 =?us-ascii?Q?IPKtWdxFuGl7+yaxip/VpfS/nqPmhbwQIbC0Cpgg8e1mSkGTBg89Qp5eYtHD?=
 =?us-ascii?Q?UXsYXQa/VW76R0Aq7q3NyXdZm9ky0/+bWFQc5Uq+ZFYU+zei3mdah+XfMjBx?=
 =?us-ascii?Q?hZPQdfSn3Ai/uiml326JFsmuy9bVeDgBnW5z75M8nnKkjs9940rTr/iDf/7G?=
 =?us-ascii?Q?HLwWy2n69U/PEzk5OJXbv61kzofCX+NG1sdoNr9X70LCnPWHa2BasgVEsfx5?=
 =?us-ascii?Q?HffB9yO5qKYcoDOTWV6w9tKlRpvujUjJhJDFiFncp2hTv9I4wcmZCA+OcfWn?=
 =?us-ascii?Q?vMMEDPhTNcYueLdoT9ed9dVVYYvoMkpf2sUw5rwzKS1LCFBQN0sh9K8m0Mw2?=
 =?us-ascii?Q?B2whZixKZQtEi9JiOi+nRKFYYlFYPOvQ9Do2do8Nu1/n02pZelehI+ct2BfF?=
 =?us-ascii?Q?CqlpdPdRZfoJU5vCBDRVjrNt7kKQo9cXJYwJrpCPUyoRyUMWsvYCSjXUOYEh?=
 =?us-ascii?Q?SQo0cd7ba/zvnaMp++d4xGSk1nQfHH3H2ucxKTMLZKPPNCoxZTvh16h5Ne4k?=
 =?us-ascii?Q?ihmwpdqHvwkNbYwfQI4AkJ4pACm8M2g7aOeTglh/NYn9A9YsAoq+T3Q8cvFg?=
 =?us-ascii?Q?Q9c73mOF7059wKeDlPz7twMq5BjBhb5Ae9A8z0NMi5oab78tuz2Utm2N8bVI?=
 =?us-ascii?Q?hium05XMv7UsmDz64AITmlxmIOn5DOP6EioMzQLKX/CPKxKtrH+f9pWtMlN4?=
 =?us-ascii?Q?f2ZWjU+zhwNTDsX5w4IHDlt7iezkEui+3IQbDceLOFLjW1sPyC924IZQaMix?=
 =?us-ascii?Q?9zqH9nLT62v3+TTc7iIg9NN3JxVVj8mC3TnVAn4A63b7VQ8MpgaMc+QYJfIX?=
 =?us-ascii?Q?8Og8eYVy4XSoVviM6KEH0jYK70uFeIxFZjFB7KEWhT482BFZaBX4Xi3TLqV1?=
 =?us-ascii?Q?/ECUWTZLxObfcH3JEVXWI5rJ6h2KUe+VWs1LjT+JXcw87J7oVz/dxiYbqx7o?=
 =?us-ascii?Q?7I+R8dQhqyCaH/nKoxLWvi9kx9wZ9JO1Mcq69GfbDdG0i8kdktiOgyl6L3A4?=
 =?us-ascii?Q?GTolte7JNcnH+lPReEWh2EBN0HlshMZsg4Mof6xedYxDt8N4GbwbAvE3hYq+?=
 =?us-ascii?Q?ON79nGH8bwovZ9JigVL94TuVRjy04MTnKIl6ovTXJwYDyIUjc0Xq4BrSev4N?=
 =?us-ascii?Q?Bg1LscbQoJAg/or4xPpvvu3cryponLazNeBVgf+2UQorHWttyWjhphkkYoDF?=
 =?us-ascii?Q?E1jn8cthn/RIC8NdiCkrx8oaMOj0OS5Q0BPIRsynrUHgKrqH05X4hYj3pMVx?=
 =?us-ascii?Q?C07m0m+EEXC3rRZCQ4yxSRqC5T1+dEQ=3D?=
X-Exchange-RoutingPolicyChecked: dlD1Zu8vy+4/Sj6C7Emh+LD1sDPZNJ6Nw6pSwflxVFg0C/6Dtqsum2pQxFVLWg0R5WgaZTtI6RxVsJYB9UcrzeAEH+PTs0tXxi/eVB6bkelKV0egWt7XMhEGWn0xQBWt6VrMkGmNBwu+SYR1bGe+B+BM9NBI1BascBCOVh+jIaeB9TSGpRmVR9/Y8Dn+xopSjgyM1lwp3PNJrGyoLKSiwkZpPkHQC0+waCeHgk2k7CO2mdTNIe9cMUsIBNexQn+QGWFO3z6yNWZiqCmCaffBsbkQGwssQpa37lqPrY9PKr7LSCO/jUUK+5lmHwpOEiMsUwl8VvrjdexoApbawpl+UQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f38869e-4abf-45b0-295a-08de7ec5f67e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 16:56:24.4598 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mP1suERyzjqIwi902YohjycmMKpQN3b8/Q7KBKkK03ufHSEug9RhLi0jn6fZFYrBNYm6VGq3N3P0SMDRIX430r3djt7YQgXUG4HjCFtTha4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8772
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

On Fri, Feb 13, 2026 at 08:57:28AM +0000, Mingjin Ye wrote:
> Add the `link_status_poll_ms` devargs parameter (in milliseconds).
> If greater than zero, ICE PF uses an alarm handler to poll link
> status periodically.
> 
> Signed-off-by: Mingjin Ye <mingjinx.ye@intel.com>
> ---
> v2: fix: address issues reported in v1 review.
> ---
>  doc/guides/nics/ice.rst            |   7 ++
>  drivers/net/intel/ice/ice_ethdev.c | 109 +++++++++++++++++++++++++++--
>  drivers/net/intel/ice/ice_ethdev.h |   2 +
>  3 files changed, 114 insertions(+), 4 deletions(-)
> 
I suspect this patch may not be necessary following commit [1]. Please
submit a v3 if that commit does not cover all scenarios sufficiently well.
Marking this v2 as "not applicable" in patchwork.

Thanks,
/Bruce

[1] https://github.com/DPDK/dpdk/commit/e01265e4a9bf259e5ec26010a38d66eec0415559
