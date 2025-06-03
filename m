Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04013C5AE59
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 16:20:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EEA3E40E64;
	Tue,  3 Jun 2025 18:20:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 190B840E3B
 for <dev@dpdk.org>; Tue,  3 Jun 2025 18:19:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748967599; x=1780503599;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=z+uaGdlzTPFWkaAjZw8FgNpmI9mBoHWyZYyzOfSc5ug=;
 b=k3Ip6syOEhHREg6OhjgE3AO/zbWnep3FNdjMxU6UChE53INZrck/26Hj
 X2gN2rwX3hHkbLJfXfOZzzMJaAsG1MOl0nWU317bTuJaFKIME8WV2eUX0
 YM9Z7bME3uIQB4enznwWrfAZxUhuM7GUtauBYosWbIZtIsB4t3CKnkIPs
 OH0fdNjEipUjAp/asyLzyAHxMtmJxBwAJpyn7QY22HWaO9STKM9mrPQGq
 9AeYZ3fh+Zyg5eyQv6b/mkkadEWVLRdrX3dJQqgE+DETA5dd9az6Y27+M
 2f+06pu5UYJLOoTqigN7mG9FEtPWmStHUeGhoY4gH3TwoiuzgvwqHreRP Q==;
X-CSE-ConnectionGUID: 7t/WFDX1SDGXt3wGX19AhQ==
X-CSE-MsgGUID: xqFdWnU1S+GZ4/LVzLuUlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="68571019"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="68571019"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 09:19:58 -0700
X-CSE-ConnectionGUID: F6xS1srGRUK6ilaMGspC/A==
X-CSE-MsgGUID: 7pWwaaWjTXqoltTQa57rMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="182082100"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 09:19:58 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 09:19:57 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 09:19:57 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.78) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 09:19:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y9x0D0w6Z6rkx+OcLm+4iN3dIYDx6HzIqIQmlbFiJ677XB0lMU6sVmHJE6G2c5AgFISFfQGnInkMG/s52JP979gqBcMHvq/vznTnoFx2OHIIXqiO2LrK8jN9nojy8ssodNSo2LTBxVA313jIhvW2KhgYVgIk1YX0npm+A4Vlefmm8ChknrxbPcXE24KUAmIIk8pVnAYqonKjnXUWUu8Zp8CILeF756YbZ5dVbwu+MYYoSUsIx1h5ak+kKcGxacfgjB1GUO7DxxIcEZR2+t60fpn4CZxd/2IF+5NuseevqU2a0lqV5GBqFnloRdjeo031303CTVJ8mhwDb+7tiTAobw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1RWhqlzKNDUsHemZEkMXcQmu6Wz2/orAETv6y4xhWM=;
 b=uVozx9Mdl4B3i1rH7bvd7xn+D23PzEJb1k238MegR80lak5byZ5EVusVmeKLja5dN8/s7FQEIRllHiAOn+wK+d3VqZBGiy/NmB97pkgrHNKTr85VJdeZrqc1C3yCPLYO9oYX004Eu09Z3tmsmb5lPsE7fpzhJ+pEwMvLUKrMty/lMKQLpVG+hd+l2AcL0PK86sR6nlw70l4XN7+hwVxv0yCxPq11y73D/NyIgEHXSDpMX10Dpd3O62DCYg2ki/Sz5L7rJJA7V+s60tYJ9i2Oe+ldxCmrLHkXRmNhV93VQpG98o3RftjiEtmYmnnza14OIY7iOvxmANGR2o3gynmWkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS4PPFEDAA4523C.namprd11.prod.outlook.com (2603:10b6:f:fc02::5f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Tue, 3 Jun
 2025 16:19:54 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8792.033; Tue, 3 Jun 2025
 16:19:54 +0000
Date: Tue, 3 Jun 2025 17:19:49 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 12/25] net/i40e: clean up definitions
Message-ID: <aD8gpd60yt5vtytF@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1748612803.git.anatoly.burakov@intel.com>
 <cover.1748612803.git.anatoly.burakov@intel.com>
 <345f3e05c1761f203d1a75cf52b1c45c3124fe04.1748612803.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <345f3e05c1761f203d1a75cf52b1c45c3124fe04.1748612803.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0223.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::10) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS4PPFEDAA4523C:EE_
X-MS-Office365-Filtering-Correlation-Id: ca380265-393f-4f82-f973-08dda2ba7972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PVglDLxvzji6Xw9xzewlP3HHhSlDabu2JrxCLaMA6AbFQ5vDfz6usTpviBfb?=
 =?us-ascii?Q?7/XCcTho8uVXZTbYSR/3UEJLfOHnfqfC3t6Fhi1HfbCJDS3e4cw5H9RZ6ryl?=
 =?us-ascii?Q?m2eIfa88GO4xnUkL47at0p+NbFtubKA3zPeUuAl4vtXzPtOf0+/o1BAugG0q?=
 =?us-ascii?Q?YUFd5yUnUWG8dCAwGJ91gwsE/sjlqQzAHutAYbK+zFTNloEUDJXCgvHDH4Yz?=
 =?us-ascii?Q?gdOZbcF6gN50DEIA9tRPpfpPCipHzDaJqOvDfGIbC7XSVbJeyISSh/tD4WSP?=
 =?us-ascii?Q?hldUwp9VeJi5m8NC5MEzP6dWK56IrEm/9x4pWOueULVYtTDUFbgbrBmwcpg7?=
 =?us-ascii?Q?FrlqA9Et2h4P2oZXredY5swPLxj5TLljUECn3211Y9WiDEzZcxzxy8KhmG6Z?=
 =?us-ascii?Q?T2S9IpMbsypQvqk9B2szSyqCyiwYybAhWEDlHfA+iBQw/rAw62e2PZw3Zgh5?=
 =?us-ascii?Q?ijOicNa7TMtMqlbXpK9NqcB9mdGWh0KkN99PgWZv3eK0maf8oyu9VzBusDOF?=
 =?us-ascii?Q?Ri/Hm/0s5OnkPifygouCdOHp0DxyV16iujX509Pt5WVSu1cB3jiV2k4gvDQF?=
 =?us-ascii?Q?8Og+hVE21jqX2uOUJUz/EKFmzNqlIsPlb5j2AbBG11Km0XR1gxVVtlC9FJB8?=
 =?us-ascii?Q?SpL9XZpp4rvP2tlHCKd4dKcxyk/C/03WrI6WRR8f+XsrwWxJKVHWkGhpcOOx?=
 =?us-ascii?Q?LY3vAw5PKBvv+fiqLPb42t58F/Eb7qgsvbJun90f4bDLf+A4ZU1IYRw3W7QR?=
 =?us-ascii?Q?faZGgFlVkuXYlszLd0T1Z9hJJrXe3XYkIGQKFB2KuUzhjq6EW25hakkqHzqt?=
 =?us-ascii?Q?VCF9Vpb5k7B493Q2y60nIInqtgDhDuJEea3fg6MGsoCT3tBwMA/LpAEYNkCp?=
 =?us-ascii?Q?1TOtF/p7KAabxpGlvRCQ5H2CpjppV0eoQUV+jgJ5USMFstl03DzJe5ba+KCp?=
 =?us-ascii?Q?KMh7VkTZcxDhbLyQ+wkgEXIAT7OdozNjQRNAFgNgXkv3YH+1hoqXmH+LtpSu?=
 =?us-ascii?Q?GfZQqm4F20XfBfdMMqHMZl8xXpLhsEyt9iov4lfl8CLBiyMEi5G4dEcdfFZ2?=
 =?us-ascii?Q?NcHV+xz+aMfNs4FlCccnW7Q7ZajornIE2DeWCLiJ0dQG8hzyKI042Uzpj8U2?=
 =?us-ascii?Q?kpOTsKJYpRQ37XUxLXlKlQNcn9bZab3fbAdHyr6RziBakIGPW0VBtstHI5Ju?=
 =?us-ascii?Q?SIlY+KR1FFp+mMwsoG4uzW6h9ycNYrymiiPWFzlkVz5AraiU+jtLh8sZ4FKb?=
 =?us-ascii?Q?QBL/3JWuc154OlequEUKr7rD0+UqPWsOlFaS0cJMH+BPGIGI0piSeYMsTbqk?=
 =?us-ascii?Q?/cmuL/d1SvIZm8UiF1e45tJ0/Xc+8uJON/Cs+zRxYLDJhKdYfT4q9GWvtHLk?=
 =?us-ascii?Q?QkEgDzseG/mYUDzKc5oQZp9vnDTfNaf3kVfqUmVpncyR2faRwhY8l4RrjeJT?=
 =?us-ascii?Q?zENPcCMDgpo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X/J/pRDp5WCRxl5iOmVFv+3nYy+7Z4qywf/oQ+QE5ijUQ8avujhRJBiQZ0Ac?=
 =?us-ascii?Q?XgDDDx/jSKvDZpsCpFQwcgPwbRkRdDILm17531R0BB4ZPKZfq6WhwJmo36tS?=
 =?us-ascii?Q?lH106u3twapAR75WB6oijNkDHlcEBHlbEZmzocWAJYcA3kCYKA9Qfsjv/RMU?=
 =?us-ascii?Q?FHg+Goekzi0oOuMP26kOVee7UiW0Dt4O7d/kyK/uwh1ZQtPFq+djLU6ffbr2?=
 =?us-ascii?Q?uUBR5kU1oJeGORY/xcQDkryFRAIw8MdXvoEsxO0sQw47bM5XDD/YxZGQpWPh?=
 =?us-ascii?Q?0athP0xonG0/TVQQQ9otQoJ1HTFAjlZij9/VGnxzAaZlRQLW/WRlnr6IEXSn?=
 =?us-ascii?Q?5XcK3xOnahX3SBkq0ouBFVYeBRTpv45tCTMja2uA2TF/dLfgeDzus3SH5fa0?=
 =?us-ascii?Q?S1y3hbgVJXXi7llwVz5bw8pswg4EB1XbWcfcehQ/RFeWKp0EHMT3/DrVRmyv?=
 =?us-ascii?Q?xkx/XMiG80pkGV2/3AJPZFjvi0GefGpU0mOYy9ealXSBb37ahcHASXpfI/TD?=
 =?us-ascii?Q?/kvzGv7Iw7KpDB3m2w7lWPg5WJpNRwnCCF35EXew1U696Vvbl0WITpyDHOMU?=
 =?us-ascii?Q?iuQ+cq9Jmm29yiVbBgJKVrCiGBVR67/AEoxf/AHSfoObsbiJB2kbQ4ecf9Hd?=
 =?us-ascii?Q?3i45I3/QMXmA+uTWkzNsk28W6KGqr8bp9ezqtuhEliUZJ2u5XvRkvnMV10ag?=
 =?us-ascii?Q?Og/P+QscKSfyq/tDNRFKHhwTbvU/wyKbog0k5FfMxkp+yQ/K8gfInR7qm5Rd?=
 =?us-ascii?Q?HI3LvkkzfPVtLwIJ5g1b22TeQmu5I1kykaAV+5KuMvkLYcReIteTb7XvlnuE?=
 =?us-ascii?Q?lD8sbqLPBOuW+U7eayx95GFcJdtXowayDGryamnP/vBS8yr5JgyR3qef57Ii?=
 =?us-ascii?Q?yEW6zUJKckOm1sA69GTdpF+Kh5/bOEQcsh+2gZaamxjPfFYcD34GUJAxjeIr?=
 =?us-ascii?Q?qTZzTbZZSXQhqElZvst1Yd7wbe2RcLzpw9holdb8Sq959ys88DOpwWOFfBAd?=
 =?us-ascii?Q?h9OJOwAHYb5nBhRbkOUm18wJE3J4304FB5QPxV9keHMad6b1JtdkujkLrUtP?=
 =?us-ascii?Q?FSS7W78FaIHwsYAU2tk98wg7ZpMnBB7UwEu3dZpExT5vJZPpg8eQ/MfGYjzb?=
 =?us-ascii?Q?x40nKusnOplWu8IaMO8f8JdXCgPBJT8EzojvxEjg7ZSQmSYQxKPI9Iv8ZLjB?=
 =?us-ascii?Q?9e6C183TtKGrQxzqN324bCYVEGFjXsxJepfGeaEc+5MWweDkDzabvfNt1YTE?=
 =?us-ascii?Q?nAbRjKtCPm/jOj2QPI5Cnn0dabOGNSW187ONFosZBpHz0bq5/Taa6SYJnaOx?=
 =?us-ascii?Q?mPwYxBTax9Kv560pPcWF2nVfw1XgTaevFpo68vJ7sWWNeQ10jey5gU3vPDcP?=
 =?us-ascii?Q?1Yel0kO4bRkuQ55kA3Z4hzIVIo4oDMSDig7x+DoxwKA9suOIZnp+aVv384sL?=
 =?us-ascii?Q?e+qZmwfFzxbA0PcfbV6Tu84OvnSGR1lTPbf0UvngImpBFsSrQ7fpyjva2ZA7?=
 =?us-ascii?Q?NDac55kU5MpJUhCyDQYBp0yfDZySSKoy2oHtwxNkflWaKnwAgDIRB5hEOTUG?=
 =?us-ascii?Q?qyiL28/E21Ziizi6xFq3zakOxVHrxBcP0YX0CD/+GBvC8pYlTbmeqzhQFzUk?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca380265-393f-4f82-f973-08dda2ba7972
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 16:19:54.3197 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZsaFw3wVmD5Ln3nR8xNMELjTNht6JkQrReIKuIyLV4WoiAzcr3dkmzwJBDj3dF+ptJPzeZ/VrN0uRvobVOFlE/zyjbOXM1nY8hMMa1zkd3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFEDAA4523C
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

On Fri, May 30, 2025 at 02:57:08PM +0100, Anatoly Burakov wrote:
> This commit does the following cleanups:
> 
> - Remove RTE_ prefix from internal definitions
> - Mark vector-PMD related definitions with a special naming convention
> - Remove unused definitions
> - Create "descriptors per loop" for different vector implementations
>   (regular for SSE, Neon, AltiVec, wide for AVX2, AVX512)
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
> 
As with previous patch, should probably explicitly call out the prefix for
bullet point 2.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

