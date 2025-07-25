Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DE9C87FCA
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Jul 2025 14:51:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C968E40144;
	Fri, 25 Jul 2025 16:51:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 42E45400D5
 for <dev@dpdk.org>; Fri, 25 Jul 2025 16:51:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753455088; x=1784991088;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=t5x0Abhhs36h0M4k+aLOJMrRvKsmgfzWMk5jDpMXlpM=;
 b=Qqei64bcaVGZ03EQb6wn/QS4mxzHT6G/mCPvlq4Ffokb7OWXmQ71fSsY
 c3g83mWN70sacgq+YD96Gh1BfxW9BPX0r1aUuGk41SSrNtwtY+MfmZhXx
 kRRiAjUhax7O1dxsnWn+lNLV27E89VmOxKXTQCeNMrTOQUxuW9GXsmgpo
 AHQtmh3eEuQqd2vIEZ3XPCQcYCclKzjdUu02qirqL3XKeUZvrMMNoZe5/
 Y07hchZmc1yRiYSwBnYDlFkRX9pv+mEs4cLn9XCOacoqrhg6XHcD036pS
 AOirxWpYJ5H713Sb9Q9YkVR5LcMrechfqKi2CHakj5i6lp66AIgTL5XSt Q==;
X-CSE-ConnectionGUID: dBpQ7F3NSXKiMnJI12zTlA==
X-CSE-MsgGUID: dQytXt3kTtKexIZVNG3mjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="66360749"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="66360749"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2025 07:51:27 -0700
X-CSE-ConnectionGUID: coeWQGGvS26biawPthjUJw==
X-CSE-MsgGUID: j4qLkMKCSH+tOHbiHza5Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="161291190"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2025 07:51:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 07:51:26 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 25 Jul 2025 07:51:26 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.55)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 25 Jul 2025 07:51:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sC34LzpyW1BnlL4t74emmcWB+4N1vyVKmgfF/8w+pAzywjA6Gk/jKFB3iyKVWqdd1YNiX8nsgmm3yHwf3mDedJ6duPEqcGSq4C5qv6vQYUykN211A5I7vOerPySYPJhm3kmDDGBUaHMBrKgbOf4TjjGxkLmOd2w2O7UtYTSvOZjAUrU9ekrgIAhggEBQXccSqiz+inHBr6Jc8sQJVQ/PQLHZ9iq7JGzPlMLkeYd72sI2Stc1yfORnwp8uk+syqQHIYqaqGMMekSEDpMY/hdmvfE9sa3WxneZmu/wqZDfmvOyfpZnLsnDPqnkD/EaVqab+wbM6s6Qitk7FXheWRPUTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsf5rOIKAohDUuw3gaOyM7dMYBhMHp+YPXsusun0Eks=;
 b=ltSf7vR/mCts8E4eUh26PMPvTzjNu4Fc3muCsxmDhDXqnRmEUnf0Le64mzGcuN2Nn+E3vYbjj2bjnQtxJW4ZKwpAARpQpl0i4HVzK7HzhBTvfrX1PtHJbcPs3T6LepG/tAgnG48KeOqDyk1YJz7smNCq+R1bgzp1BtlslGoAk9nPasbRd3u4sGn7/njCulnc4DtTvEPFF/7OdfwvZFAWwI4VZPv0rS5SAdl9IZP7CLKIY8+Fu98OnzxSLlYgBDHbL3WFbVDZXBqhFm4VZ6jNxcVbWti0bMoL7Doqiqzniy4L/Y1Fb/Lg3LCimcVz5gM2QPlEV5clPXNBwe0uXd14xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by PH3PPF55C5E51F2.namprd11.prod.outlook.com (2603:10b6:518:1::d20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Fri, 25 Jul
 2025 14:51:24 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%5]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 14:51:24 +0000
Date: Fri, 25 Jul 2025 15:51:14 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [RFC PATCH 09/14] net/iavf: remove redundant field from iavf
 adapter struct
Message-ID: <aIOZ4t9GIU9By8Lb@bricha3-mobl1.ger.corp.intel.com>
References: <20250725124919.3564890-1-ciara.loftus@intel.com>
 <20250725124919.3564890-10-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250725124919.3564890-10-ciara.loftus@intel.com>
X-ClientProxiedBy: DB8P191CA0025.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::35) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|PH3PPF55C5E51F2:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d9e29f0-0c07-40f9-8bd1-08ddcb8ab9da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3QPGaPQ2lwBsb+YNj/laSjSYqxSund69px0CRHaTj8cFq8jtafxl9QgYD40/?=
 =?us-ascii?Q?r3Nj2hn0gJGGand8/y4LdPDXm8tVwKphBBj34eku7C8Q1KXsAdRa+dY9Ne6D?=
 =?us-ascii?Q?AXbLBAmTDZii5u1fV8OQjcgfFa3WkALQ0LyuquqWemkgJnZ59202AZd/0tRE?=
 =?us-ascii?Q?VhQMqNROm/QnhUjvaQKTVGgtPqWYCQ2YKJTJQhYP4PgxkDg/2LeMf3hbExdw?=
 =?us-ascii?Q?m2hMB8IEK37i7us6wunJ9oXUWC3iDIzBjhW6Xa8sYA5vlQ6A1qkXXxbpyzYV?=
 =?us-ascii?Q?sJtAy3Lqf/7L/KDRUE1zbH4ESFB+hKE3fcyPuhwckRTfYf2WRAi128iZosXI?=
 =?us-ascii?Q?6mK++A+KTcGp1mXY/cTFBH1NT0SZO95IzNWFz7ZtkYyp7lzjQni+saqh3Wyg?=
 =?us-ascii?Q?0vDh6OyDsmDFJegZdnj/iOVJkDN1QsOI2ekKlHxBZ4AG1VisyzoUYZoWY7Pb?=
 =?us-ascii?Q?PCzupr/lapaz/lHnqw2DWoyKyAF/V6vwNL1IkvKqukdACj+/8mxcpQk4l8GN?=
 =?us-ascii?Q?sbyPGRua4NkvCpKXMXIVZVqxBWKNXfYwDMX7hw776GP0HrIqlH7wgKmxgFkj?=
 =?us-ascii?Q?fyrqftzVW7H+uRC8PDBqNdR4yYX02Wgx6n9soKM4fLphXt8HoigZO4HDPX8M?=
 =?us-ascii?Q?BCP/VNM0XO+chUUEh1aLax2NgkchPAIevfzCNEmakcWXXA1MKfJAv4tozqMU?=
 =?us-ascii?Q?g1gD2/RKLcfLV4VEPOuGn12FPLHxdTRIi2J0yFHM+fznfdYkNZMVbJYgeziu?=
 =?us-ascii?Q?fbL/NWW89MQCZq/K7u15SVb1DnF6LuMT6kSDTMAN6SgVtbrM8fCqZJoyfidD?=
 =?us-ascii?Q?gmXoDrQLdCIcVTxOFu4oS6ilu78JywdZQMzL2TyRS0vbLXnVMYlGqHi9GbKY?=
 =?us-ascii?Q?LkF2LTTtqbmJi37b0mlngFqkktoaffPDiuyqAyCB8H1XXGJ6aUECI03CkaJk?=
 =?us-ascii?Q?3+RvrWPUi9s6cxbNu5X4I12mobqwpBq02J2cswYhhiOl3eKYKUqdJIzmGvRh?=
 =?us-ascii?Q?Efm1rUMNTA5q1akD8hM9893laNBLbeoIaNbV998SWYecobteZGvT7NLEB7/f?=
 =?us-ascii?Q?ggvSqudSPDHJhLEotB+hlZaYQHj+JKDXlmLgPwKnCW01I9oIOylV70zMgMFM?=
 =?us-ascii?Q?KcW3IuLuCC4YrVR+4D/IXQ4NVEuj2hlP9Z7ay3dZWEfEcfX4ycn92S3JlrbO?=
 =?us-ascii?Q?F+uz6zODUBjNQbasf69U8Rg7EwohR6pYE04ZeqfFIYwUF0OqHsr7mUM22fGN?=
 =?us-ascii?Q?CcwRAeyn2AwzKMtnV4mgJl8YZwWb3SQnLRszAKuL1rIYMNGjn+0f4JkELt0b?=
 =?us-ascii?Q?Nav2ng7CyQRnAjHnsJg4znFbL6Lrrr0kqApMaFaE8yTBiXh0mEym6Yj0lV5n?=
 =?us-ascii?Q?srZbxnAgchMBep6fgyE+snWgtAFsqD5jf/TzzYZKu0HJzJaUPwLSFbkj6aCt?=
 =?us-ascii?Q?puX1gj2ofew=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W7o4KfuokQXu77PkVdMBjDCT5WgLrsGfnRBZdcMdIEC4GNJDdQ8aZNuQb/nM?=
 =?us-ascii?Q?C6zwz1Qk4X+C24Nb6T5i/5Ok0NL1G7MTwivPDShnUNYhQFnp8wvspaMepUuS?=
 =?us-ascii?Q?SlkKzlJrqTpMWNwQf0J/MQUVZYuYZaD3SyQQ6pfcwh0znCtQzSJfIrMT+blq?=
 =?us-ascii?Q?oBpqn+9r5gAIHJJKIlqMoJO6fbf/1+m67ttfI7lrkVAVaj0iZY9xSgEEjInb?=
 =?us-ascii?Q?S+5JXVQm8lP+YlbHWjOxxFMlMMCjoMryRzvnaLXtI5b5/Mi9pfMD2CoEO8O5?=
 =?us-ascii?Q?nx6fTd8hlr2wirw3ylNlsdl3gc0Yf7A8odQQN8ViyKx5+tQx0oiD2dPbb2MH?=
 =?us-ascii?Q?wf3nZ8xmS+YKL3lvCjOlNuqVHLdwDuXi7tFfAPFKHckbErkNxdqtYHBr/LwK?=
 =?us-ascii?Q?5AAPRBTddXlDXRM/S2QF3HjVnuBeCmi8R4LPjZICr7JYQ9RecF+9nXWxJa8S?=
 =?us-ascii?Q?fI83kX0vS5iqO0KUyVuIppDu2bXoTRCX0rP1wIjYGRSa2FUjkDAC+mr96tyR?=
 =?us-ascii?Q?V8jwzs4fzJAu97R812SCeHUx0m/JKzVhzSc4g27o5uAfR24Lpf2ZM8fMYIvQ?=
 =?us-ascii?Q?/yuUn7e6YZTtj3MUXybQLXjS38VX2ZLZlDOGOrra9kIdaR0NI2/CxfEIF3Qg?=
 =?us-ascii?Q?SW6WVvtyy8WG4VY+WGq9fefgePQ2W+J/MoTJh3B9oU5d7Jc0X2ARDi/ySma3?=
 =?us-ascii?Q?3fxOEIozmukZn2pqdo6PWalr6y1vFpGLxWJVT5dtK1c+JPTsGRirsn5xcwHr?=
 =?us-ascii?Q?CG1A6aHAo7ivSgeCkrbUFYIbWUfF+Snt6vRpi9LWSazdfFLDGheY72UGHcvh?=
 =?us-ascii?Q?Pmr8wDD70PMObkf9r1fAor2HGN8GL8F9j+BPY8VCaLl9X1EF+YHEwdN2+y32?=
 =?us-ascii?Q?RCNaxWJW1exk1ZcDhyEADFZPhzmSVcr+U8IJsimiRG6oSCgM9rr+n8DYVIkH?=
 =?us-ascii?Q?g+3Uua8PN9ZCZPUVCGaSyaIIHw6Q5KA+jvFyBmxQPVQ+gE9fqdn34Yr9xw6E?=
 =?us-ascii?Q?+kEXd0B+DoX02PU8Ccg0Ax18F28bgekHyiWpEfswAaPbjglvjD7yYeyhyhNk?=
 =?us-ascii?Q?QWED6Jb/1BNbVem3Y6j7TZnd4sS7LgsAgcToPYeLdPxZSF8m+FtHR3/UWfAS?=
 =?us-ascii?Q?UL5f/4kV4vl2my3WzlkJfVTo10ECc8kEULFCxseJYSpKazkE7QB1AenEiEwa?=
 =?us-ascii?Q?0B9T+XTrPwCgTUCicr+t3AFpMqPJ8C77rF+OzmSW3WV5gnyhQc6cBcFwnymV?=
 =?us-ascii?Q?HV32St4tlbIGPRCDMsiECZNPkECMv/C5JpPMDRNi38B60/+l782PSodVosH5?=
 =?us-ascii?Q?nIGh6+CmLYNb0sIBfX0mthfqpuC+z21IuS5SslHH9CknXhBSjdxN3scgqDZA?=
 =?us-ascii?Q?ilkNwd+uMs5DBgnMAOtM4z9bDanjC1M4OKJlYpaOrPUDgQuwC7nnBBBL9hm7?=
 =?us-ascii?Q?x78ec5DhFbg8HfJdVw0zFVNLCVkFdwwAccwD4sO1xTISleZict3nBcmvkvbY?=
 =?us-ascii?Q?ooiZ4/A9DMKysWUwEEAnGQOWZsYGT7mgez3X6fkO+/P8jGSiEWScmbCrQa0g?=
 =?us-ascii?Q?5+ReBeZM35EgXW/xotWmK+WKXrSeDzlbJB49B4YU7vWBIsAZmtewkQWMxEJM?=
 =?us-ascii?Q?9w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9e29f0-0c07-40f9-8bd1-08ddcb8ab9da
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 14:51:24.2167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1BGtwKKgA1dqpIEcGKT/GSP5ooo7VZzQWUAbU9cOYvgno8yRd+NrztMQXqLeriZ1Fy/j0MXr4j6XamaBmzx1yJ4su14eMrZ5ohk2VBU4wIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF55C5E51F2
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

On Fri, Jul 25, 2025 at 12:49:14PM +0000, Ciara Loftus wrote:
> The variable rx_vec_allowed was only used in one function, so
> it's not necessary to have it part of the iavf_adapater structure.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
