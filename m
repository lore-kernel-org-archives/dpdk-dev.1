Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1A6CE8D4D
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 16:07:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32AB540EDF;
	Fri, 14 Nov 2025 17:07:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 41CF040EDF
 for <dev@dpdk.org>; Fri, 14 Nov 2025 17:07:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763136476; x=1794672476;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Su+Sat4Kny6+Ah23vx63v7PIOGwa2Yv3gCzeYAoY3ew=;
 b=RfO0fLrErkOni2gyMnL3aT9mugd8RJDDvN8wbPUKPMO5Yz0lQVToZ9oi
 jH45g47lfctloRwVbo4i7UHQizZqli2MOgNTY9XevkFctr88oXClcpXxN
 bJHIZfrB8jOtRuKNLdsnj1a5OGgnfgIFXYJoAMFe9SfuF7tTxgNbaZObo
 tfxBXgEVPdfOtm9pS3bI6YdD15VhuLm16h+/6u8D7B5DX+HfpRtTpr0Ba
 bsUTAowOWLxkOI/VF4bOTPuuyPrxf5tZP7Z2NoyLiKJDff8UeGQvUAfOZ
 V4aCta+5ik4p+mNhi8DyPFh7kDsTBxcMdbVTdq1mHjoe+AD9jLge5OlTs w==;
X-CSE-ConnectionGUID: kFedLsTRT5+thg77m7i+pg==
X-CSE-MsgGUID: ZdzSZvxITDqJbx56l7s/jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11613"; a="64237288"
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; d="scan'208";a="64237288"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2025 08:07:55 -0800
X-CSE-ConnectionGUID: FTl5HPEsSDudpY/AJXT7kg==
X-CSE-MsgGUID: XgNsYCdlRmi6L+CyKfCRhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; d="scan'208";a="194970818"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2025 08:07:56 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 14 Nov 2025 08:07:54 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 14 Nov 2025 08:07:54 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.29) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 14 Nov 2025 08:07:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktHzeC3fZ2szzlgwQi/IQuZcS+9AxNUJKbCP3HKLRijp4FlpM40ptQLMfP9zgusr6Yv9oS1iq7ADHBVJoctrMtuBqc9/+k9OYhByiKbTsgDY6DV/VIelf8owM4Nvt4zKIquDGdyAXsBEDGI9UY/nRBc+JqV1QtW3tkypOniCz2Wjjg4TEd0BMek5YHZUQhcaJ739JLby9uXSGoJcA1klml2B7ooDbdEPRd/fvuqaY9shRgcNAch9D+sFvuCrr+9lW0xQtCOQErurYP89znl9hnJ39TzKhxpobQQ3jZPVDOuKkjIGSWbUeCmPaQOu02VsnG/d32mivOfEj0DWup7YgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Hb/E4MdOeR7nRv8krbfuqkyASmbKV6cIPN03Zt6k00=;
 b=s97naQjzsMdwp8T4tDg5uTYZHH5ocUdftBZtvgXFScl9yeu65/L6vwOHHxYpRBVkYN3ujt1xs9KDQC+d0JzEIXDFYLZBWaVK5yN86JiArBeiasDAJwrOgNQOwV4ji0nDXBEftE5UiHGbUHp/RkQtwzKmqpHhDVaQCuC291paTzFWwyPDqS3t4FAgwz0eaS+/9s7iSk6xHgzz5hUXbCIObjlL550/joXERt/2ITK+spUQa8iv+wZe0CqXqcnY9mQhiVTS1UBG6ThijEo0AOmnhpJgjurgJucKZ/i3EudtFO7BG1e7XK4454YOn5LNIgcgVOsXCGrztEFuOPC16xJiqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ5PPF0FD67B0BC.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::80f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 16:07:53 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 16:07:53 +0000
Date: Fri, 14 Nov 2025 16:07:49 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: [PATCH v2 6/7] test: increase size of memzone name
Message-ID: <aRdT1b8uyDo7Ua3m@bricha3-mobl1.ger.corp.intel.com>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251111221857.443752-1-stephen@networkplumber.org>
 <20251111221857.443752-7-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251111221857.443752-7-stephen@networkplumber.org>
X-ClientProxiedBy: DU7PR01CA0044.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::28) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ5PPF0FD67B0BC:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cbc5615-e250-48f9-7c81-08de2397f77d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QA/oIbOAPmfpR/e9qEVkzrTc6Mhulfja0/HcZWy2gaKhmZSNKqwZwSrG1a1c?=
 =?us-ascii?Q?xwD35Hoq60nsIkpm8gsb4JJJaEZKTDtLWbtvyWIEjrRCztGJcVh6LUkWQElo?=
 =?us-ascii?Q?XxcVIAOF2/3su1Tnf11ZLxbTPt0Cq4Nd4e5ahWLAOmnZAKgDy+h1FY39tiys?=
 =?us-ascii?Q?BhBqjF4ef7c8tup3z04ote1qCY2z6JJBPlm61CmiHt4eWwOX/++vW29qjj9R?=
 =?us-ascii?Q?qEnLKTo5zpdHeqnqgtdyRyrofLpVpWYdjm1XPjhmgqq+QmwtdBZoxPpKNI4E?=
 =?us-ascii?Q?pHjg/fRC6cqRRNkYf/9ygt4MaKfdPjPG3iVXfX5Q2pfvMQs8/nkIrZVXZTg2?=
 =?us-ascii?Q?HmLk3haabDEr1WB/eMqSbyvC70Y063NFOWg+I6Q3tGyjwIh6bRvgvGMYScqt?=
 =?us-ascii?Q?53dLeMuvUEI5Vlwj26vK3yt/HRBSvsms4o4csFkMvff3M+28V3mHG/zy5b21?=
 =?us-ascii?Q?8mIl8yEXJgAxzmT0PnP2RwFHuP6JrAEk8PA3EyP1nslGl9TJfKOE5Thcy6AX?=
 =?us-ascii?Q?S5GKZHOawxRCS6vEtsMA7MOmW8VNzWdRQgwLUGH0YTFgimbaqx5tpRr3Cqq/?=
 =?us-ascii?Q?6f0yFbR3fVF2kXglivldeG37hsNqnkh19aNl23cGbE04sQbBcLFsqEbowE+4?=
 =?us-ascii?Q?YbxLP5sTYkKFtSQ4MPUBm3gxleUZs7DzTwRRIZhCXfAy89GVL7N72wE+PxNv?=
 =?us-ascii?Q?9mIOIK75lkoDLn/c8jSrgq2xHjVQSFfFFyd1AJ0S67i7R4tffgO8l7nA02EO?=
 =?us-ascii?Q?hz3U+3Pkg/wZxG/GukQvf1rHpbP7EWlhnWFT28Mq4cQ78lR7/5X7gURbcuGk?=
 =?us-ascii?Q?gYPXg6V6C3GvjaBzFKfs/519sHQ1SegZyu8lzPArujgTcobat/16IM5AHCAB?=
 =?us-ascii?Q?garYgkzoO5jaqtSRnM1CEEtsECtKpLyncyLVxxSvs7hyf5KMENdEHPNgrnj6?=
 =?us-ascii?Q?1/DIf3n9Iw9lQRVKjyvVUPoGBPrSnJ/FzsgerroeIy7aM6MNyyJri0nOCGuA?=
 =?us-ascii?Q?rpiHCQM1d+ZHMIGpXX9HwkeE39i2ccW1gC8WhgsZ4myr78osIFAFTkhn5nhT?=
 =?us-ascii?Q?BGIbC8uK0uinaV2ixFVMBik+91SnomwVtZH2ePZmB9xvPxzj0MtLpvhKV/KA?=
 =?us-ascii?Q?DNicrBsC0oHUw96NmhoTwRAfnTFnrxOWNTjETEFK0W9+MvQqNvTZIB9FfZdA?=
 =?us-ascii?Q?xtN5Z+zIIChEqP/bKOQ+34OUBeyTTxRmMN2QbidnBj4XAQgT/ATJAzYr7LhO?=
 =?us-ascii?Q?NJ0s3RPeO+T+BZCMH05ACDWFafHHzs/dUzmaQFr2+nhioD6PUtd4WY8rVecR?=
 =?us-ascii?Q?N0MuZJus0cXnCDhlKXOqWGvEf3bx/23cKFrRWSMkhkpwk7h8GTJYICsfu7p3?=
 =?us-ascii?Q?wiLdnnGLLVhr1cCgSK5l4o6WRL3H/OPGUTPpwUGsI+g2zbDJsOP08+PIFsDN?=
 =?us-ascii?Q?dh38jO3ZtzCxCZ3jxY2bg9hrgrma2gaX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lYk4CRQenh9ovsdyShnbt2C63ZBS5oWK6s7zz+i7FgKMwjnlcHDrw/SE1Fwo?=
 =?us-ascii?Q?kKvEGvgRAnmbR0hsG3mTv5/WPVVPoaevK6gwFVw1njPFOIXDWXpyoHwk10KU?=
 =?us-ascii?Q?DWh/9udRkmg7SN3FA9R1h4iBRRJ/KNwyf+4H6eXTeRFuJM3EJbZksVQagtE+?=
 =?us-ascii?Q?WpBjww2J8sEFoKl4yrDhe9bUENDlSL/bnE9ec4SQBsmsH2Lq+CcnT8vAozlv?=
 =?us-ascii?Q?g1UCi8eG+bufvUMXjNnbMN+6wDrNe3wPz0uGH4ROSCRLzU2QNt7rNOdax9lL?=
 =?us-ascii?Q?foR+seMnP6raBP1wiSGw98ijDKr5JAhDCQU2QySgX2QXKZClF7AelUtXaI+v?=
 =?us-ascii?Q?bp4PcF2qXibPTPqNyrSN9NqDiCVkDbP0Eun4OagTVjtBUOxGhogWpWI7K4JI?=
 =?us-ascii?Q?a5ti40pR0X8uWQMFZ/IS7hsk8TUJ8Fu+akyhfJk/hbH0xyXfpc17B2i0hUM8?=
 =?us-ascii?Q?tt+MadmwWDSI1XkkEN6Fb+hSMs8M1sJw2A1PPAWawtWpqBEH5sr+tC+DXshW?=
 =?us-ascii?Q?COZ9GvhZHIEiKdOkkk0+efO8YH72MxSJ7S5yhQN14cksNk+gvwFWpKHL+C46?=
 =?us-ascii?Q?4hTaBPv/DrdTir/d87Q28/LBiZ58+JRALsL3vdpW/NWj7hnP19bQliFu3k9D?=
 =?us-ascii?Q?c0i2tGZ4UC8QrPu8Bj0NcgrwPoX64t3eKI/xVxoPJVCY9ssYkA+2VnV201k3?=
 =?us-ascii?Q?azlCh5E+GpS7tUF7KOGflPhugI9fgYCBQuhq2QCyuH9i9QKU3SMYSYlwskwJ?=
 =?us-ascii?Q?9s+Xre++3Ga5udQhD8pyWUdrK6oWsvfZJxNW3gnP3JEKw9XPX09i+ExgKnMG?=
 =?us-ascii?Q?ijkMefAvcxsgsOZ75axVjGQq7yJgdc4HLHr5wRQfrv2xp0uoDuU7GZu1kU4T?=
 =?us-ascii?Q?TNyK1w4xX2OC2UpWHQhOHrig9lf/jiasWuyqXKNMHgMXxgTzlF+HKy0BqSoQ?=
 =?us-ascii?Q?zc6kxeIt06B1Sn4CLcIt7wuRqmwWzowht2Jn+WW1w2K/4TZ5O/rLZ2Huqf/A?=
 =?us-ascii?Q?Lc/Hl+6rvpUYFERXI9/UxwFJY1rSXEZVBk7WSkGN2fKUrNgGJ4Xb6udHEDq8?=
 =?us-ascii?Q?O1DtmXS9dqhORBC23I/CeU7HYTZY/2sHIF8hShxAokNuRmii6+R8I6WdUC09?=
 =?us-ascii?Q?wRxRpOyBOhxGE2JwIx0uh5sUItKZJoKj0qtP+T6lR3XZCgzmLpwDHG67QPaK?=
 =?us-ascii?Q?9FT5kvtOCIL4yzGDMSbo/D++mDmcJLdznl5TXZvbArNIynezHSgRSLp7iqsw?=
 =?us-ascii?Q?0n03rwJz2XwheuUW6T7F7hiKbF0KurpvPZ1WtH0sKYAJLwhXpTJ2AryuK//S?=
 =?us-ascii?Q?hFEf4NqYM7K9qjRy+l5TawCWtil46Gmn9Ao2lK/14FXKi7I+VFP3SfEfuU5i?=
 =?us-ascii?Q?4MUx05WOfFuv5dFo3vtgUCPcz9IgjVAZlQAaM8/bZoCjeW5Q4BM2my9z8xrE?=
 =?us-ascii?Q?HcXEC0N+B+k6tWjcAmwGWUzJ88ATQQA6Hadci8+FSevlwehZWCq0YjC5NbDz?=
 =?us-ascii?Q?4rnCSIAN421fjKqTF6G8E84wlIsaAlPcpErU3fT+IKt7EGYg6I940R6VW919?=
 =?us-ascii?Q?e8U0ieszbvEcqzhLDO6UpMyS/dqhpbCza6cneRc2aNMwKMGiN4EGu6/YZzH5?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cbc5615-e250-48f9-7c81-08de2397f77d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 16:07:53.4004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jZXa+jSM756JHocbAqO64Qevvnw/oPENiIozXV8DAhjLx/RQa8bOu03WduEnP4saLYB+Vv2ibaisBJBr1SKpOLBLiTMZQWwmCidQOV8+xZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0FD67B0BC
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

On Tue, Nov 11, 2025 at 02:17:23PM -0800, Stephen Hemminger wrote:
> The tests were using a name buffer of 20 characters which could
> overflow if number of memory zones got large. The upper limit
> is defined as RTE_MEMZONE_NAMESIZE so use that.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

> ---
>  app/test/test_memzone.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/app/test/test_memzone.c b/app/test/test_memzone.c
> index 506725ea41..6586dad18d 100644
> --- a/app/test/test_memzone.c
> +++ b/app/test/test_memzone.c
> @@ -872,7 +872,7 @@ test_memzone_free(void)
>  {
>  	const struct rte_memzone **mz;
>  	int i;
> -	char name[20];
> +	char name[RTE_MEMZONE_NAMESIZE];
>  	int rc = -1;
>  
>  	mz = rte_calloc("memzone_test", rte_memzone_max_get() + 1,
> -- 
> 2.51.0
> 
