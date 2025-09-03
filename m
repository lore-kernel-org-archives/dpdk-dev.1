Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72B2CA0FF2
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 11:19:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFA1E402BD;
	Wed,  3 Sep 2025 13:19:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id ADF5340281
 for <dev@dpdk.org>; Wed,  3 Sep 2025 13:19:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756898373; x=1788434373;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=vrqHBtx3Iy+IbnfV0OM0tlAsDKvpGsExhmCq1oNVrss=;
 b=murf28n5MVMVHSqJv1lj1a2T7NLqxpGiKHNgnf2cEYyJ76RzUsK7DWFX
 XRXpmuilzhrz9vEBH+lhtJGT4lnBsJh4snv6P1TQY0KtC4x7VGNjFNBnt
 kSinvY/V9Sso6uUf8xLFJrcCG5gyyQq1vd5w8EkHp3uFiPhNX3uOiZtok
 SPbsdrpNgy/rYc9N6+dsCtimIiv3asJ6yVfd4O6J4aK3Au1v+0jqQiXlL
 FclC4HVcjRq3+zghoTcrGCH5vjx+ATIfQGOfG1kqrW1IHIgJ6h61+HFDx
 1FFM12HnkJbnVVy/tD2DaoxFBpn0PJzPeyW17e5S8x/wiD2vIPfOoyrSQ g==;
X-CSE-ConnectionGUID: /yNW7H0eRgK1Nq6BxCr3AA==
X-CSE-MsgGUID: 0ZnDMvedROCEvbpIA1uh8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63041376"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="63041376"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2025 04:19:32 -0700
X-CSE-ConnectionGUID: G+WOYlXqRw6ov0bw7wt2nQ==
X-CSE-MsgGUID: bCu599lFQzKLjr1nA8+nVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,235,1751266800"; d="scan'208";a="175708596"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2025 04:19:20 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 04:19:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 04:19:10 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.79)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 04:19:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g00cga2AZUBgmPlnJeiq53IfjaaegslvlvmJxrFxHa81mxK3J0oRXYv2Clx2eCcV8/91txrIQApsC/jWc9tmJ1HUjP25HYadwdKU3QDAlovutUN/CQMqHUV44MBNFceWHnrBHfXDI6nmL8ajQwHks2Vv5TzU8iRQ7sl1yNQTgQnvhEszCpCADrwpIx6cf9y3/xewkzDhKPqQ4wF1Um1WQKDCHryP3BXk3ztVsrDZhs32KsakaSzOs0U9FK0Vque4hGMc1huc9rFIEDeN/8umYTLok3ViN8Rs8PwNgwsK2ctOWtVPYNZ7yvAPmPztKfgTA9HHfpC3tIZcg9DId9O02g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yowxgsXduOK4UyUggr+Qj6K33aai+YnXwe/lQm5iUbY=;
 b=MdVGkM6QYv4R3BmpX8A/01aQkwHvgkO5Rov6zM3vrseky4AULaH5DyKziMQIbeoJFKH8aTbVkmJ+5plsIcme2cskbYEf8aRqAuRf+GtaNQTKgGNPCW4jEcmbVg/EeSBueLYBWf+OaqWpRXI6gPA7gt3EfVukRKGxI6X7J9hyWel/+EH/EGObF1klLBbYiUfa86pLQ0ipqzJMt+LJxM1qzway2SwinRo3pebcSdPuzHpV7moaS2yo0QAQENesDY3UtztOFYNZhgWxnvSHl8KxZ0cmAwjDYN1bnsWk/PCfeuO2QnOSYKvsUi9LP6xDgQI7rIbGbQVzc1rdwGdtQnPtNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB6064.namprd11.prod.outlook.com (2603:10b6:8:77::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 11:19:07 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 11:19:07 +0000
Date: Wed, 3 Sep 2025 12:19:02 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <thomas@monjalon.net>, <dev@dpdk.org>
Subject: Re: [PATCH] maintainers: update for packet buffer library
Message-ID: <aLgkJiH5mieDQt-9@bricha3-mobl1.ger.corp.intel.com>
References: <20250903110006.44202-1-mb@smartsharesystems.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250903110006.44202-1-mb@smartsharesystems.com>
X-ClientProxiedBy: DB3PR08CA0021.eurprd08.prod.outlook.com (2603:10a6:8::34)
 To DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB6064:EE_
X-MS-Office365-Filtering-Correlation-Id: ed03aa7f-5342-4a2c-3e78-08ddeadbb265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?EoizkZBH2bZbJlEtvnay9/fl3hEncjzUsweNChfJjQpCnl6HV5CukFLi6X?=
 =?iso-8859-1?Q?NLAnkTEqCIocTxwyAKyiShQED77gIL/N0NQJ+0cLNQ37L8N8+nV6BOfEuR?=
 =?iso-8859-1?Q?5Too2lxe8aZMitBEN4w6i8FB67TNOcB+G8eKtQPU6MWP5ERvu94wa77aes?=
 =?iso-8859-1?Q?ahsCFHsoW4bs2F8LjtDX3J+/aaR2B+onCQsVCmshacTpX5a8VSYv63JpBp?=
 =?iso-8859-1?Q?Oz9kB9F1QNDqvH0+pW3oMe+rGLED10hb89ige3r9XAF2KFs4SYWY5dS1oL?=
 =?iso-8859-1?Q?Y7eQjXuHA1m1sgHYOj2vKa7LSKKm+M8rP1sNAKBEwS68yPMBh9KcaDyNtU?=
 =?iso-8859-1?Q?hOMmA0D5vVRme1vCxCIa+mhmoy+13ueJN73Z0QEDFGNVOnpj/cxtwVzjIL?=
 =?iso-8859-1?Q?VpT/4KHM/vDdGOxrvxdNBqM9Lmqx3J1Wn5xOBF3LJ8Z/0K6B9EcBTuw/9g?=
 =?iso-8859-1?Q?zcW3lL0e9GDerE4IjBcSCIGdzlasfNxY+Xm2nIcYPYP2vOw4lcIid8r0rr?=
 =?iso-8859-1?Q?VlV2M4Q6uhIn9oHhOkUErN+BzfWDyU/OpRN6PFGzvCuGSh1UUvZpbqQFFn?=
 =?iso-8859-1?Q?GMgVvqwdrsdhTnJBuMZmAOR1h1xXPC4wKx1pXoM7WC0pPW16SfxBFD0W5+?=
 =?iso-8859-1?Q?yQpYZd1uORQJ6141wpqWq/eIJh0JKC5aiAwr4DiSUHG50Scbz562TjPs6z?=
 =?iso-8859-1?Q?5M3lC01AE44nVTDVEM8p+Fw7ZCtyyeFkgmm552pJ/q5PY067cD3thyGkp8?=
 =?iso-8859-1?Q?7Up5EmaOsvCSG3nh7eNZ2e3L69hcM8VpP68q4NzRDNhQSrD/TCS4pG8SjQ?=
 =?iso-8859-1?Q?N8M811xHz+YrFSIrmFet2bHpYNjzF3mXwyn0CRCTVpVZlnBQhNvS9r+oDJ?=
 =?iso-8859-1?Q?KhSboaSGJ9yXVxJaDTZXZ4oHP0TPSwMvvClvBmprPYEHX8FZNcYDkog/DJ?=
 =?iso-8859-1?Q?EPBZApKvgjQIrbhNIBIHC62YKuMQ5pFxnKjOpSLyZlTWRwMpNGgz5lI8Ww?=
 =?iso-8859-1?Q?h3mk9yVng+KHKhY0DevoZ20IwY6Qq3IuR1GOXK8EIGjOMv391bBdl4yHcM?=
 =?iso-8859-1?Q?mIvQ51OahiZqxJcOrcW0ebcAsZg22Nl3qeVVFvkhRIeKAe6+y6Y3BuQ6t8?=
 =?iso-8859-1?Q?4ydMtIVG5yvyzK30uloH+ZooeTfZ+s01eB/SnGrpEufmzv0ds/gto/396j?=
 =?iso-8859-1?Q?g5mEXsH2ocJDDJfP7GC75SRn7U/WgBCBfduwinzKnxmNQ9G+H4jxeiUVTF?=
 =?iso-8859-1?Q?P1Sq595bEZoWGvPdpkjhbF4QcC4UI6oo9coVF59AGGTK1R37svIXiLUNzP?=
 =?iso-8859-1?Q?624zoWj0/tvO5PhDM8WyC+5e9tSP87n7NhSlEld7V98DWzoTEwIronflkv?=
 =?iso-8859-1?Q?9OtezEJdsYH2E1pqkgv1Q621FgdIw+8NVCEbg4mOjCzibQ5uHnFdcC1X/1?=
 =?iso-8859-1?Q?O4xkIOSUJ+iczOVjQIFlmJicQF0Re6Tn09xYSg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?EF8WP6VKI5dEOGDLrsTt0rxH4mibAubTZTt/qOhXaTH/B20fgYFUTqUsZq?=
 =?iso-8859-1?Q?0FIeVqNve7afK8S/+tjcli5vadkeKAkb8+l7gfjZAsivRP2AtLaKw2qRHG?=
 =?iso-8859-1?Q?ZRhHy/jZskMG3tMBpaVq4VgHHRNwegqVIlKrRW3yfZjNGzHmsL6t8ZOrfO?=
 =?iso-8859-1?Q?rpcD10OS+Im/n3OlwiSlkqIeLZuOZUaVkzNXktWrPNkAs/E8Ll+iuW41/2?=
 =?iso-8859-1?Q?Qhh00+OkEBF9CtvwC59fMCeFcumkYZJ16Sy3LjQgVmdmrSAQjt68zzxQDe?=
 =?iso-8859-1?Q?llCPDcemELiBxI+dfIDiRIYnRINF/o9T2LOiBvZRogIWlCrn3XlBMHeyBi?=
 =?iso-8859-1?Q?WRmjRD8yOMSsP/Lxr9DYV1oC6ppK/HanM+vom8uXvRpT6v7s3314mfesYA?=
 =?iso-8859-1?Q?LrG7ILgtC4Wm6XtulKp+PlxJhIYW0R1Nxv5xqqayv/0yEPfB5vuNl/9k+S?=
 =?iso-8859-1?Q?SMuY+g0/xao6C8P0rxc98Q3qEuWbkUSP1CkSb9FcbJh+IpV2s3CZLfYPpf?=
 =?iso-8859-1?Q?5VkXFzx4gwemiSlGrAUrQsPsuoHcb8nPu3JIoDKhb7dVkraaOb9B9haLJ8?=
 =?iso-8859-1?Q?pNsSxG91n8RTNi0nKBjVAicVxuu0aqUQrHgR0qiK09EMn8VHsF+0ivuPg5?=
 =?iso-8859-1?Q?uCf18cw2X7dKf4iKQolyRCC3iIrAf/OgvwsiQ0iawqyaFlylXF78HTj4Rv?=
 =?iso-8859-1?Q?usv0c2wh24SOo8tg34XzmCIn/L0bmWS3rFDwzI2EzpxAosdJdl9q4FcQv5?=
 =?iso-8859-1?Q?y4Eplu0aSxQE6QMME8zIKXGofPztBt0gFj/c5i9mbTafwJwC0xM+iT7Qww?=
 =?iso-8859-1?Q?JiABOoGhWaUw52x3CTc25ZkHbjpqytDxs99LL7Xec3tFlZYKjaLoYVpmJJ?=
 =?iso-8859-1?Q?jR/JYedJdKq6mzX/ibPAIOp1Ivgu4lihCJohaI51RsoOB0ivKJDDqFgGMR?=
 =?iso-8859-1?Q?c2UJ5Y0kTae7EY33EuiLMG9LzIKtfRWoPRoJF6s7okK2UdhTx9xvDzBFIz?=
 =?iso-8859-1?Q?IkH+9G1hVOYPGHi5nkgVfibT77YI6Nm12/Axqjihtan9ClKFgyHIBeXLGO?=
 =?iso-8859-1?Q?Gnhaf8nnYoaBmsvdDADOfLBNIUJbuPq/2PguNXGlyjQ6d7EJuCgftzE8AT?=
 =?iso-8859-1?Q?u+XbPYFXf2N7RTVXlVAFB+CYvWGHnYhEANqQI7Jrj3PWN6M19SosixpnO8?=
 =?iso-8859-1?Q?bPGIuLcqqB0gKwRavOjyhCkt6aOubEH1+B3/4puTR92OTiVRHD/Oyp3WV+?=
 =?iso-8859-1?Q?MU+KkJCwHlxhfVFzQd6Brru5C1QjEMe2b19cCpVdAbSOZEoSOH/liGqAGY?=
 =?iso-8859-1?Q?93eSG38QHydxC/VmLMYgZUUr9otEQHQGyirfGEucFptTwfXqovrWR4jK6N?=
 =?iso-8859-1?Q?EWGU7DFwxlAzqJu3NlPz5Q4bGoi2IakwPLqssThvFXnboM1IK+TAtPQddS?=
 =?iso-8859-1?Q?fmD50m5sJSFdA3+SDQw8DRJ6x5wi/+t3wBCKcdnq1WGkg0bIg2d+mi3gwQ?=
 =?iso-8859-1?Q?Ch3ECST+p9h6bWfQVU2VAFYHIvG1VrxsjA7+l+WVkrhY17hyULD3U6sOjV?=
 =?iso-8859-1?Q?sHbjcOeUrozCyuBBhfhrwqIB1wQrSyfErGeTpcV2BQv5tsedRvNvM4wZkT?=
 =?iso-8859-1?Q?QR776VvbJb74au4v9X/grk3GgC+i0uMo/w+vVQvZST1es0YCmN/wLmJQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed03aa7f-5342-4a2c-3e78-08ddeadbb265
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 11:19:06.9960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GEQBu2OENxtpopLPex5ROwLD9u2vGYn1rsfvei1iAGKMqr4998gazifcCKYVR1TGLigl2otXQGy6tFSd06PNBz1gufBwfk//kWvhkqYLzY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6064
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

On Wed, Sep 03, 2025 at 11:00:06AM +0000, Morten Brørup wrote:
> Add myself as maintainer for the packet buffer (mbuf) library.
> 
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
Thank you for agreeing to step up into this role.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

