Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CC6C83F1B
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 10:37:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3F6F4021E;
	Wed, 16 Jul 2025 12:37:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 8CE6D4013F
 for <dev@dpdk.org>; Wed, 16 Jul 2025 12:37:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752662253; x=1784198253;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=r2u7cLFJ6Ys3UGl95CYr7kd3isMNAW64ujaKMLB49aw=;
 b=n9qFjV6l2/TNEQhPOQKBBbqGGFwiDQ8dIQklHlJTUmE3vPmzee0X21B1
 gAoIZcxEGZUbtYVA/I7CixYgxnobAW52xYXefBRPksAoX+0F5Uz9b41lZ
 A9nzLonpF69NFsgzm8uyjPIfPNOzHN0rxJ70nF4g4MjndhiCos67xCGJb
 OvuHvC+GBjEQ93l1T1PYC+4NY1eyQUus5KEyvgUYwGcQqV3ivBIF3hh0Q
 HEqak3FwLavVcNQqgOB5QdMSq0QH9VcAqQviR8vq85g5DjVUMQTh+mZCH
 XOB8ararfWbglvY87hwAQLXIfUrM4VjMeuVqzqnEerYf0zxf5CaK5DnpG Q==;
X-CSE-ConnectionGUID: IcTMTxAJTIKWvlVSbSy+4A==
X-CSE-MsgGUID: ExhQK2tXR3SyBiiUcUD7Yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54777261"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; d="scan'208";a="54777261"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2025 03:37:31 -0700
X-CSE-ConnectionGUID: sveUAI31TIeJHA4+7HZUNA==
X-CSE-MsgGUID: O/7n6W31RS6naXZfJmNa4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; d="scan'208";a="181160768"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2025 03:37:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 03:37:29 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 16 Jul 2025 03:37:29 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.50) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 16 Jul 2025 03:37:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QDN8B6cbTRhJgs48ugJF0SZOyRYmhwWIIDYfscp7UQg2oqM6zCCkj/9eQylGkDZjfvFSPiAKAyVv2Lx5sBSQaFTcAY/OqmWHiKqlV4iTpcOsIAAFuOan3bcJh/wp9pFLzhw7eIM4KLGbQFwy2t1c2Ie9VMTNNsYJNjpxd2K00/K/htalOY5ZazEROvsmWjUz7oXSGuhaxIXfP+4xizjBguAq6XhwxVGK/D7d8wp67gZOHprFpXyT4kDyLaySChEvNuzIHsrNjKnrBPf6J13W2XHAqEZrOOTkMmXgWMCu8MC4oFyQUHWAkVfS8BVz3ADBGtJVPkW32i0BkdCUEwXr9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Poh+2OoroNK1kWjXLwaUhkTj6mCFKYap1B3Y5yofVp8=;
 b=U/5K28lXQ04dEcaf0pylY46X/s3EpiZ0Wt0nPiI2ofDWoJpdM+7TwlhfW7xJkF09h5gZ9qolHTnFBlj9aQO7AdTCH/iegnLVwQSZ3sXyiRg4rG4uB1z7o4Gk/c1TzwYX3zvwhLlTDALtgHWAt6d5jtYhovqvty7XF4PjYHNW3BJusvo+tsCSdFiah7JrLo2INKpVLJxkhzAcCtG4z9NXjLrcVdoQ8/ZVvqyNIYZa/TnAc+BwZCJwbkV1Ejq8UX2OgnrovupB2cJ8dkFZfpde9I0n77mcRCezEGIHqjHe2rfPAYzfWRiJTdNLzZaogAnX5DO2/ouSzo5CvMxthsvn5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB7638.namprd11.prod.outlook.com (2603:10b6:806:34b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Wed, 16 Jul
 2025 10:37:23 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8922.023; Wed, 16 Jul 2025
 10:37:23 +0000
Date: Wed, 16 Jul 2025 11:37:18 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>, Matan Azrad <matan@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Bing
 Zhao" <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>
Subject: Re: [PATCH] doc: remove Mellanox acquisition explanation
Message-ID: <aHeA3jXjcq80QERe@bricha3-mobl1.ger.corp.intel.com>
References: <20250716101516.224980-1-thomas@monjalon.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250716101516.224980-1-thomas@monjalon.net>
X-ClientProxiedBy: DB9PR05CA0026.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::31) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: fe5ec141-e269-42cb-0c03-08ddc454c027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dn1Tr+NllLrtlybTiio3R1Pc+5sw6E7wQsUDjjsIFttAu5KI50tepahBKpZr?=
 =?us-ascii?Q?koYg7laSzVCQHX+wh5VNAMKEcpmCqWxJQTwhzDBvtF0M4lbiYhuOmXzYvTq1?=
 =?us-ascii?Q?zLwnIG07tj7cyeyC7sk8xlAHIK1gynljtayKcj0jVxWkgKwXKwpRgAMnO37l?=
 =?us-ascii?Q?okYjygW7ydFuB6omalEliOfZZ8iTLwCRtRVSXxccG4NkA5xUdqQqi30YGoik?=
 =?us-ascii?Q?Z+xkEx6M8ZPLPrYvRPBXhsaSZBNwI6FKjCwbT/QdR7HGabCyXZ60ftnCpezS?=
 =?us-ascii?Q?OEYuEz1GGCJg3WH8mU8bqLIp/YFiJSfF0aW+cCDUNA8biZ+4TJxPZwYSJO4t?=
 =?us-ascii?Q?cLGGKdHMZFGXFJuEI9zZQ7D81/r1p13uwQ9wBwuhC3r4r3/N7F+r8J2kowg4?=
 =?us-ascii?Q?OphN5Lzbz2AItXL3feFmjMJukJWyYYE7T2wxG1NnnzZuCAWeQdTYF/l2vku1?=
 =?us-ascii?Q?P8mE+psh4mwwud+C1Cy7y8XEP03aseWld9IZZCzF2deBHTFX5MkwJyo6unyl?=
 =?us-ascii?Q?ERKVC89t/PpHF9+5644F4THwAgUgTxy97mu07bRwIWo7NmeKgac45rOkCQ16?=
 =?us-ascii?Q?hLoPchNK6ANHvVPYaZ5/rzBj3mPrDW2zcHL3W2bOmFTFILAvUKZBiyrfRiYN?=
 =?us-ascii?Q?MNT9yzeloxfAwiOeP80PXNpW4bohelOlMhfYNvS2TnLHtx+KOVB2wQNRiKwY?=
 =?us-ascii?Q?2327mnooCByQJH3IjssXWiLMk1PM59VTZBecgLPi8dess1zcnPIKQlHNNxUs?=
 =?us-ascii?Q?ALBQFXqvp1nx12TZaVdcCxU2PUIrrpd6dupvgvVeF2uIp9FaMbcVa8A99GNT?=
 =?us-ascii?Q?y8BYVyCeOUspWhg+Z3fxq31KyfJZoPsc6Y6VTaWq33caITavcXeNJPs4UOeu?=
 =?us-ascii?Q?rUfsQRbw1zTK57X3IrNCV7D0oEZrIhiXdu1vUeM8rSpOcLr33DpoCcgeJqhs?=
 =?us-ascii?Q?qZqjnWk9rONHEsmOsQfnEJiTEydMI5MP05lbvpElr+iK5FYVS4Z1/GBgQ1Dr?=
 =?us-ascii?Q?ZiZY6XLPBHHSN9/WXLVbRiihyPUW0IAYOye4IgL4D/BCsaA7hCBzpFbFvmYq?=
 =?us-ascii?Q?1Alt4pZSr2oW0brWmE6JcfrCzhIOaDiJJ9xDTK+nvpcaxQSfQ20Hn8r8st1z?=
 =?us-ascii?Q?7BCPLZQi5XjTd/sp9Cvud46wqRmrMSQkpXAapg7MHNTyq3gGi9Aa7VUVnJ+o?=
 =?us-ascii?Q?ZPndnG8XuvAfwvnlj74M4ZFVie3CIRKw4dNnbH3eX/nV4ucIamP+8oAnxCQI?=
 =?us-ascii?Q?oEu3PCHQN/FsiRzZDfIZJHHdNuHtnviqP+WJ2iEgAdn+E25ryBoXVO/lzZdJ?=
 =?us-ascii?Q?XQpPiUC4HDPl+D8TvJPFZPmZDOVZbxjYMUIulpM482yXd2sRG8iE9n0ZDIh8?=
 =?us-ascii?Q?QLTZZLt5Qsy6gxmMRrTJ7e6a6pQHfP+5rQX/m8ZoQ7eQHFTzeE86jPRDxUMr?=
 =?us-ascii?Q?5jHxtvOCn7M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bOyxKnyDpP0CBbkJ5aBzSuMjit1XCNcsHAusacF3Ll7lj24vVldcXypBEuJq?=
 =?us-ascii?Q?jpBase9YHDi/se+Klbug/AusS6CHhTLhJer/9JMgXJbO7v6nwO0n6xkUVyHi?=
 =?us-ascii?Q?UzPkG6SrnwhrDxAT6kMpw4hrS/WYJARv5TJqX2p0anXRhC+DI3xwfwyzojSu?=
 =?us-ascii?Q?zPvcf+IsD24qbBaU3TMM2MkvPqqVqpF/fx7X5WAnjWpZxWu+4D4yi/HMzK88?=
 =?us-ascii?Q?w2tK1B5aLLFGcnt8rFwolokiuvIvgdhykzi4ks9vDT9H89g7g55RSPIAsz8v?=
 =?us-ascii?Q?w1CyohPK7NHc+WZUA2RL7LtvE59HQlS+ttVMt35y8xYn0lEhKvikWcBSwTLh?=
 =?us-ascii?Q?TUfpcIq36C1XnXHhb0w9TX/C1CMEEFQc2MmRFfDd+lpa557YqGOmtdQFCg/z?=
 =?us-ascii?Q?pjPZFN5fvUBC2cgmNj4/iDs6NJvQSYw6ndSf9nn22b4D2OmmOw36wljg80lA?=
 =?us-ascii?Q?ppxBSf7wvIQ+rOSATMZEK4QL5s7rwrk+0MllE7Q1aaHVK0QV9oQqL+6NGO6t?=
 =?us-ascii?Q?jFxGmau/m3x4SzYktuUxWb/aoY6HYi/bWXbPUWxrIb+5Q0alkNsmhD163gS9?=
 =?us-ascii?Q?XwSNPrI/bA3BH2ZHtdj6HAzqsrXcysPJobmJ7cMyOcp1JtluLJe3zFufTbt+?=
 =?us-ascii?Q?85Trad+JJ533wFJYgpbwhI8emsFcL8BoiaqPALF2YFgyXo/M80OG538sfhwR?=
 =?us-ascii?Q?Kepi0Zblm9QXEhjA5V5OWbx7lYqsqHyzEmtl+32rXfhGRoUAzHeAksfj+6QA?=
 =?us-ascii?Q?g0Tj7slhJ3qkRcMrlecj4OBDnIjsmkTIhmFj2lzbBoTOMsiSxFDYDXQv2UkV?=
 =?us-ascii?Q?uNmYoaxju0til9T56AxSf6WQ5D5dxakH7x4oxJ+P7EyJlx3Vp9M1q62F+7Gq?=
 =?us-ascii?Q?BvqfE4+7dfCT5pn/IiOYQfEZGyR5UADb0IraWrX499Qs3ysRXlz1508ZYilL?=
 =?us-ascii?Q?VbPXCDyr70BYnWyZD5LqqP623Bco7Qe5+kZiSREomjMzFcfdxBg7OLbpkOKv?=
 =?us-ascii?Q?38Q74z2T6s/G+jA4XkGKpw16oUcW7980lOvtTfjyotI9UJQ9i6sEVAMfqr8G?=
 =?us-ascii?Q?9c16rMceKJtSwgPG6DHE3bzBF3wIY7ZVxJlOwlJvg1ZL3+ognWSXupHAO8C4?=
 =?us-ascii?Q?jkZ/KQNHqVlFvcY1NmHBQl/AzrHR1sRdKse2YSjcJ/lCiHZ8czYlemoDB9Ar?=
 =?us-ascii?Q?MfFsY1Pk6iKHwS+g2TzBxPpoy6F2aWaBjgyZwvSJdiwEeAlfkluhy8u80j9r?=
 =?us-ascii?Q?iWYEXOG2gm6dfqttbMdKA8iOhQAROiqqDYCplp200kfI6EsvuHxeHe1TMd3x?=
 =?us-ascii?Q?weVcWg/lDe/VdwuRKP3d6h5MT0eRv1CpkxvEzudJ/rh+Zflkk759d01eJ1gH?=
 =?us-ascii?Q?sh+zm0K6LyUP4ZcOEM77ZQXugc2J0hl2BcxHPsANh2NsxR9JQShsLV+xcG05?=
 =?us-ascii?Q?gH3gNtmbyHLVBIYRF52lq0oeGHA5RTb2WaeQtw5pKLn+s95a1ZT2iWQOGtVw?=
 =?us-ascii?Q?As2B/a/7RCkQTkkjH1/McQ58jbFegWv+GBGewBxqImyMV8PqmiQGuDvH1C0C?=
 =?us-ascii?Q?LP6RYm1FsKihz7LOlkAllsslRq8xIOOPsxc3TQ1XOv589sXayA/XCJpwxC9a?=
 =?us-ascii?Q?Pg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fe5ec141-e269-42cb-0c03-08ddc454c027
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 10:37:23.7496 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B0KQWSr2fdFQBUyl7ne1Un7R9LK1HaFcxYXxJKqdcFMR2ERyNpulWrVujlM1bzojIzSys6+VkwqVFP4/DHKgnHpdf7pqt02IwySafJ62O+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7638
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

On Wed, Jul 16, 2025 at 12:15:16PM +0200, Thomas Monjalon wrote:
> Time has passed since Mellanox acquisition by NVIDIA.
> No need to explain this anymore.
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> ---

I wonder if we should include in DPDK a "future_cleanups" doc which
describes cleanups that can or should be done at specific points. For
example, after a specific release or date, or after we drop support for a
compiler or kernel version. After we add a workaround for a particular
tooling issue (or other change), it would be nice to have somewhere to
record when exactly the workaround can be removed and how/why to do so.

/Bruce

