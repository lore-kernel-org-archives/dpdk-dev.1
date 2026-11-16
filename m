Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C471607070C
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Nov 2026 11:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ilulK6N0;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=HokdYShq
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B805A40299;
	Mon, 16 Nov 2026 12:18:53 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTPS id 36F59400EF;
 Mon, 16 Nov 2026 12:18:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794827932; x=1826363932;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=3FrR4w/J84Kr0jMpuWZ1H8045k8MyCX1iWB8vvSfBZk=;
 b=ilulK6N0wqKsC/hJSuhCIWM2xsXHreBFnYo3BdgeBizUQcED+VfWvl3b
 8cxW0ZvbdXTRRJ4GjfmHKC2DrkstD38IiosEq+n1YJ7hN0OaUp5yO7ucp
 ogXZoyK5/UU/njbflXrk3kpio2XV2XMIYWbqgB7pLWWifanjApupf8gWL
 k6fxvGT6H+uYBA5QiPNK0BJdmMyJEg4avFzg+cnUd6+8309+DaF2HveTj
 2TmDdyXRh9wsWBfcYgPFN4LtzaI7NDvIkocSWXGR81fmmuE1TB9rpBZOg
 EOVGODTG2m7BqYaDYiWa1II/Ly5SYxXvpTw6h2TguGDieqMz0DI7qr0Xp A==;
X-CSE-ConnectionGUID: QSsyTjVGQ62U8CXRQAZuMA==
X-CSE-MsgGUID: nA8yPLvPR42edAqZjgZjuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3550030"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3550030"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 03:18:50 -0800
X-CSE-ConnectionGUID: O1RoJ+nHRp2uDmUmTAUxSg==
X-CSE-MsgGUID: OymMZs/HSDOy3QU5EHVOiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9838323"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 03:18:50 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 16 Nov 2026 03:18:49 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 16 Nov 2026 03:18:49 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.6) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 16 Nov 2026 03:18:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lknTfuy5xjyRzfH6CY//K4N1aX4UFUW+k7NE+cy0iWeWKvL2tVNFgJwRlKhEpN7vgokOmAbGE/tWHy6n5zSRQm+lqo+zJFFNMjbprgllol11WH/kt0RO3M7zFgvlCqW91nl3Tl9zf+SEYw6faWprb7iPFx5T5urPB2xrqI4QX2SXgfk4+SB3rvS2Kzo/MMwNm2z/JRl3S5nrishF6JzUsv+YxdllZ0ZRo8ybtL4zrPV4jiPXpoZ+Q0N7jfcqu3ESse0nyrv6PM9550kh7qx7aCMSTCUEH2Kuh5zxL1gzwyiwhiNZLopMCJ4CI5vyzMbiCfujSzsLUwaDpJ8WY7UKTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8PrSlBboeDbT8JJMQkxmWBA8JBe7sczxXRMuz3mX1U=;
 b=CRyju6kc1P/vPBmmTZ/bNw7aGT6goyFHgWz7VEfH6TCs+boqBaQVPERmYTvjX9MiMEZ23p+NjM0Ever/FfzrXAhLYJjgwHbetx1TmSVUUilPpYe7NILTuZ66cvdU8kQ8n1LPqphaDxWiKstikfGTaiE5PFHYIrSzJuz865356cCw4qtNvcxYaSSNAgVUzqqpgmSXcIZbfCbdEXG3bDtqxmmBPXbILlqMh+EmeP4wDR8MAc3fwYg8obo78D8uXhOxgMO7gHcl96KidbmbVvYnaIGSY4PY3/OQ5Inryq6nvsGygnZBwS4l7GaPJkgh1GB65OXVRBIYf2SyFOSErg7NgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8PrSlBboeDbT8JJMQkxmWBA8JBe7sczxXRMuz3mX1U=;
 b=HokdYShqRLC1rEf+FVLzAERo9rntNvdAf3YOzfUHC+lK+eeOqrqqvPlojvxjmbVnPQ4yYX4Kjrk/ypRLnyIu3g9rvi/diZWMJ9Kqwv3+JalTHOrx71VOTX96Woss4zQOUmganuxEnmixd+gUpUru9La5yCaYUCeR1m1/WRkjCac=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by MN6PR11MB8171.namprd11.prod.outlook.com (2603:10b6:208:471::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 11:18:47 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 11:18:47 +0000
Date: Mon, 16 Nov 2026 11:18:41 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>,
 <vladimir.medvedkin@intel.com>, <brian.johnson@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH v3 2/4] doc: fix i40e guide
Message-ID: <avrmkdl3p3n0A4U4@bricha3-mobl1.ger.corp.intel.com>
References: <20261114075732.183996-1-sandeep.penigalapati@intel.com>
 <20261114084619.190251-1-sandeep.penigalapati@intel.com>
 <20261114084619.190251-3-sandeep.penigalapati@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261114084619.190251-3-sandeep.penigalapati@intel.com>
X-ClientProxiedBy: DB9PR02CA0027.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::32) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|MN6PR11MB8171:EE_
X-MS-Office365-Filtering-Correlation-Id: e185f742-f23d-4134-e1bb-08df43d361d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|6133799003|3023799007|11063799006|4143699003|56012099006|261028144727099003|261102123227099003|261026121527099003|261026140227099003|261022105027099003|261021135927099003|261022113327099003|261021121427099003|261021123027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: rWpGtzK871FQZo+lWuAqaKIYVBwmKAlB3mO6cqJCJ9a6WN/cNG+VoR/yjbxmzRivM5O1p73msRGAVfKt43PT3Xh8achVmE4d7vDzK4XN1QqTRVc07GaESyvCWTqcEItqoPxbiTbzb29Z81ze/U+SP7frhsEWVdFMLbpoVlTBQqNehzy0jFy6d4VX/pA9j31s9lLwrK8qJG/erDza8ZG0n7YFGo5iXUi0eB8zsx1tJT8YSbq7JkfmHIHogV00rI2BAF18GXyouxCaj52gEJWc6bHoX9vA7eYrebcTmfRklPfB01/yR1JVQwPkFdmCkZNDA0Cz5KDMI4Y0bE/bz/87hylPN1B9+UGzE4kh8PmACooBGL4sCg9mYkprD7FAfWhL4g5IHDiMvv+j7+MjlxOhC4+IuEhTEyBo+tzYtN5jSFJ08jG07IV3BeOddDpwGZpdAjxlE2mQ9pT1L5Ny9h7+fX0+8sdoogZjamTiMycwOcZ2tWXET0YZSSvdarx4sLWiKs/QJaV+QP9QPNAIA78NoOs7Rueu3HbV0XNww8Zf8c+tlGE+7mloXlo1Z4Dz/YTtTiTssRPJhPWYsWGPfKjoikcpLK+jQ8vmc8+iB/rB3JNvPphxl54sKfZhD5Tu+8ttKI5FwAk4OJq32hRUxe2Cc9rhmNxfed5IfXy8XrgPzck=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(6133799003)(3023799007)(11063799006)(4143699003)(56012099006)(261028144727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021135927099003)(261022113327099003)(261021121427099003)(261021123027099003)(261022075727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KzUVz0m/pduyK4hkUlPv9Z6B02xCHScoWJJuHaT6sxzfTTFoaMyzQ/G+JSi2?=
 =?us-ascii?Q?KAWbgmD/G5+lNZfD6zF9re/2oBBV3C+HRtg/pmTnapid9n4WxIrvcKy3WyLF?=
 =?us-ascii?Q?XLcQyLStWuZr+DV1jCpX3vKLuWOD5i55st7TKmY6XS/doo0GSZ+z/PjmAhM1?=
 =?us-ascii?Q?hMWmqGWV9aYIJRUzadyubvZczwJO7Bivd8GmR3NpIycS0azj3HYmpdoqifnF?=
 =?us-ascii?Q?G5akgHA77HRkZCCjwKM4kwRw6hqZ36rAqWHZY2f0fktzymogezBWaiBeEro5?=
 =?us-ascii?Q?uxWfrzctuYhXo5du9BiYPc/BrUOPNOiZm+reUAoad8uVME0pOFQMOQon+aL+?=
 =?us-ascii?Q?Ab6p1hUrTJLhZ+zNo0PAfnVAXQtxgKAOzZiCtXJ1jmbyck2Bj5P2hsJGqXrG?=
 =?us-ascii?Q?ZDQcHxbNLX6x2J5pRi9vPzQf27aOjMj/YeaF1NHMv05rALtFnVjJ85STVATa?=
 =?us-ascii?Q?q6HfI8pemxT3mCos/sFd2LitDr8LDYtdBkRn2phFYacoJ4QzsRKOO1MgSoyS?=
 =?us-ascii?Q?bv7rHp6vSsgQbY4rVR9QmdySZWnUqZ/dmFQNG9ODczJTT/XFuW3LCTfpibv/?=
 =?us-ascii?Q?BavDuk0no/i2yrNEtPE24Il98ei8s14NnlkTA/s5tA6zuQwDO0XGobNwcCWC?=
 =?us-ascii?Q?G8MghjeE6Dj0S0CDRZpkNxnXIpiRp8FPT3E2Jr2W4bHdAvZ2De57W81xH93J?=
 =?us-ascii?Q?qiE72ddsgYdCZv0mUbfGzYZHIJNcMgjHXHtaGJL3LXCMK1uNg6Ue9Bpbup1f?=
 =?us-ascii?Q?g2AK882mTjqI0mBrIegtMY+4y6H0Vh+vTJmFTKmxybd0iUW/a7JNgomiMbLb?=
 =?us-ascii?Q?aUMUZ0nrNxaT8L0oNuNe77UTscOcpxcSU2k+Oqk+VETnbJXI/YI0zYxIjmei?=
 =?us-ascii?Q?ADed/8t++l8cHeJFjZD3Xc7HvJ4ROB67jAJBLfdUZsYcIZCo3CgwLRt1CTte?=
 =?us-ascii?Q?uXoZUWK1D0i7Jo2+jNWIeITtXAf/CaneK/6pzmIuLLpnTuNGUcz02ebEA6UE?=
 =?us-ascii?Q?bqxAPwc/ASLCBKr4Cqd7jHXUfsYAlIRGmnVES2JIcblH8DUsG+NpfG8OXCVk?=
 =?us-ascii?Q?xajUeZDIpc6Pme5YCfDqh/4TTgKsa2AOMw0gch0j9WssWV2tgpi0jvWuBjtc?=
 =?us-ascii?Q?5mfOHjiZkvwdNzv5DMCh2dvh12Fww4J+hhMkXQ9OwjItsKN6NOg/c/67EkEt?=
 =?us-ascii?Q?XRrfQKlVDMMa+jOF8yxs8hMi/v/2or2VzClahJeD3jyyg24kCX4BrkdxO0pP?=
 =?us-ascii?Q?S92Ts6CCIrUva9zcCwQPdrmvi4SNcgNwLr/SlI3uv/fuRbDkgSza19pfNfEm?=
 =?us-ascii?Q?I2k3yVieygMR/GDSm+bdzCZ9dEbJhC3pMJMjmusvK+t6SIVuSVe3hboC0Ebf?=
 =?us-ascii?Q?1GMygzF739fzLafsPZ5seMHqusWGNDaEe4y3EoDVnhHwpVWAJpmm52JVP5D9?=
 =?us-ascii?Q?l9d/EgZRphb3X0RmatpsrNpY0S0Pi9hl/VND1zLLbLAx9ExmGCgY2HI0spbu?=
 =?us-ascii?Q?kNMuxKGbHO9J1RjPxh/f2VFEqEw1K4YuHTY6ZZ2VXAx7HPKW9CDP6JoQZNng?=
 =?us-ascii?Q?UDUBrMEgZ4Cuggi40tqxZBZbEassUg6wWda06zN1/zHR8UCZcri1jHis0zz/?=
 =?us-ascii?Q?zC66YxPGLXOJOBJOQ1PUH8i8ThCUwPFKKHVE5hn/vJupne2E6S4dgjDiphbz?=
 =?us-ascii?Q?ExSHrAR+q4D5ZeyTF1OzFNBZzu/JyKJovO1+0hvWvn6zN+elkQ/3zrIxZgO2?=
 =?us-ascii?Q?vnY4ZZn1w0SfG9kztIEW4nmYHHAhh+I=3D?=
X-Exchange-RoutingPolicyChecked: MjC/jSXDWL5VhMh8YZ4rwm4mNH3d4mMBXp/RFLKpHHZT1/1kfUs+lkArbAU8bWpoA9npizXS8M581MUj8oEIYwpP8d0IJS6AtzSN81xeMh2kCc0muQH8ylkq/W98UBvY0ITqsz/pqS9/behprPcHm9IwnZrmSlh5HC+fZZzkD5kCqV4QZc8yFGxRiB852i8frmMgHqBqXI1QMyiloF5Jd3galwZr5R4FOhD+4RyCpEbnCLv1HwDqamoHUGubgsgrBJ4R+NfmR638IxrpHWcpL54GtKXi8Aos0yvBYIEjMtMKUtCKMDB9+8mRmtin2sEfej6F/TszJidMxu6CQCW1Zg==
X-MS-Exchange-CrossTenant-Network-Message-Id: e185f742-f23d-4134-e1bb-08df43d361d0
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 11:18:47.0233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kean4zL0IRKtA8WNCkIsdrhIULdq+ZTVRETMaMI/8BLNS3VcKsEU/H7aOECqVGnDH7HP7qW3qZZwKZEKjuyNMJ6j9xJutYD1B7NuKicgVcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8171
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 14, 2026 at 08:46:17AM +0000, Sandeep Penigalapati wrote:
> Correct several errors in the i40e guide:
> 
> - use the full "Malicious Driver Detection" feature name.
> - correct the queue region device argument description ("serves for"
>   wording, the "off" entry formatting, and the "commits"/"cleans"/
>   "restores" grammar).
> - describe "set vf allmulti" as all-multicast mode instead of the
>   copy-pasted promiscuous-mode description.
> - minor grammar and spacing fixes.
> 
> Fixes: 04c8542f96f7 ("net/i40e: set TC strict priority mode")
> Fixes: 0982ef81a665 ("doc: add DDP in i40e guide")
> Fixes: 9accffad6593 ("net/i40e: add PF MDD event handler")
> Fixes: 94b3c1a72507 ("net/i40e: move testpmd commands")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
> ---
>  doc/guides/nics/i40e.rst | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

See comment inline below.

> diff --git a/doc/guides/nics/i40e.rst b/doc/guides/nics/i40e.rst
> index 29234dbf0f..1df006333b 100644
> --- a/doc/guides/nics/i40e.rst
> +++ b/doc/guides/nics/i40e.rst
> @@ -43,7 +43,7 @@ Features of the i40e PMD are:
>  - Dynamic Device Personalization (DDP)
>  - Queue region configuration
>  - Virtual Function Port Representors
> -- Malicious Device Drive event catch and notify
> +- Malicious Driver Detection event catch and notify
>  - Generic flow API
>  
>  Linux Prerequisites
> @@ -537,7 +537,7 @@ Display information about a GTP profile:
>  
>  Input set configuration
>  ~~~~~~~~~~~~~~~~~~~~~~~
> -Input set for any PCTYPE can be configured with user defined configuration,
> +Input set for any PCTYPE can be configured with user defined configuration.
>  For example, to use only 48bit prefix for IPv6 src address for IPv6 TCP RSS:
>  
>  .. code-block:: console
> @@ -669,7 +669,7 @@ If a TC is set to strict priority mode, it can consume unlimited bandwidth.
>  It means if APP has set the max bandwidth for that TC, it comes to no
>  effect.
>  It's suggested to set the strict priority mode for a TC that is latency
> -sensitive but no consuming much bandwidth.
> +sensitive but not consuming much bandwidth.
>  
>  DCB function
>  ~~~~~~~~~~~~
> @@ -721,7 +721,7 @@ Set flowtype mapping on a RSS queue region on a port::
>  
>  where:
>  
> -* For the flowtype(pctype) of packet,the specific index for each type has
> +* For the flowtype(pctype) of packet, the specific index for each type has
>    been defined in file i40e_type.h as enum i40e_filter_pctype.
>  
>  Set user priority mapping on a RSS queue region on a port::
> @@ -734,13 +734,13 @@ Flush all queue region related configuration on a port::
>  
>  where:
>  
> -* ``on``: is just an enable function which server for other configuration,
> +* ``on``: is just an enable function which serves for other configuration,
>    it is for all configuration about queue region from up layer,
>    at first will only keep in DPDK software stored in driver,
> -  only after "flush on", it commit all configuration to HW.
> +  only after "flush on", it commits all configuration to HW.
>  
> -* ``"off``: is just clean all configuration about queue region just now,
> -  and restore all to DPDK i40e driver default config when start up.
> +* ``off``: cleans all configuration about queue region just now,
> +  and restores all to DPDK i40e driver default config when start up.
>  

AI review points out that these bullets are a little confusing, especially
the "on" one. Suggests the following replacements.

* ``on``: applies all pending queue region configuration to the hardware.
  The queue region commands above only store their configuration in the driver,
  and none of it takes effect until this command is run.

* ``off``: discards all queue region configuration,
  and restores the hardware to the driver default of a single region spanning all queues.

If these edits are ok, will change on apply.

>  Show all queue region related configuration info on a port::
>  
> @@ -765,7 +765,7 @@ set allmulticast (for VF)
>  
>  Set the multicast promiscuous mode for a VF from PF.
>  It's supported by Intel i40e NICs now.
> -In promiscuous mode packets are not dropped if they aren't for the specified MAC address::
> +In all-multicast mode all multicast packets are received regardless of the multicast address filter::
>  
>     testpmd> set vf allmulti (port_id) (vf_id) (on|off)
>  
> @@ -858,7 +858,7 @@ where:
>  
>  * ``target``: A specific software ptype or a mask to represent a group of software ptypes.
>  
> -* ``mask``: A flag indicate if "target" is a specific software ptype(=0) or a ptype mask(=1).
> +* ``mask``: A flag indicates if "target" is a specific software ptype(=0) or a ptype mask(=1).
>  
>  * ``pkt_type``: The new software ptype to replace the old ones.
>  
> -- 
> 2.34.1
> 
