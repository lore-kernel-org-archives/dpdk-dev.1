Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47542D5B841
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Dec 2025 15:33:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 040F04029A;
	Mon, 15 Dec 2025 16:33:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 605AB40151
 for <dev@dpdk.org>; Mon, 15 Dec 2025 16:33:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765812818; x=1797348818;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=srvUKP3MX99MF0rQIFiDKD+hDSjFoEWRGV5KpC29Wok=;
 b=JF3e5ODDBGAfUajrCezWmE/nniqD+IQqcpGAOizelyGrbTqAVNNDSG6w
 hva7sl3losmnfZkV2pIkyKraB0t0qf0dSmrZegUu0ZaXtbczbmiL6p6Kk
 u9OjypE+gRxAE0YDqaOv/Nk4C3mCYUB6rVmF1sZC2WPOfWBX3alrurUjB
 X8MtllRSiVRsARkRlsYf38o1oZizFLKTZ8TwE62NGuV1Ykdn28YY3EZPD
 UvbhJnKEJ5al1aSw02w52W4cO/EjiXxr7xZIsBSbJgcnf8Q6xiG1dg/2M
 jFrfczhElfneK1Vxnt5Wmj73i9Amj90y6JVHTB9voeOOLGymIvNEl/bZt w==;
X-CSE-ConnectionGUID: rdpw3uk4Rb2izLsGlGh2YQ==
X-CSE-MsgGUID: jMw0pLn/SKuDhFqzYCKfjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="67592766"
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; d="scan'208";a="67592766"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2025 07:33:36 -0800
X-CSE-ConnectionGUID: Qbl3PCajTT2R1IZhX984Ew==
X-CSE-MsgGUID: Ia4PRiV9Q1m+54QI0g4Xmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; d="scan'208";a="197504855"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2025 07:33:36 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 15 Dec 2025 07:33:35 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 15 Dec 2025 07:33:35 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.10) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 15 Dec 2025 07:33:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQnxO4zKW5vhGImz0x6L66ur9V9GPbz7BY/OF3jS9xXL0YhhEUKgQ4NI7TteOUS6+i3mcyMSYJHHbAzcNMiPBPqbt8gdTFWYQhS+FrFtgkxzr+u3nTueP1lzf57H6SQBlRUi47YK1VE3SmXuddR3IO0j17bkL1blzl4vF9v6cXSdBFhZIKZJjV/O4d/dQqPav9imv4bh2KBP4DyN2jyQPYugdTnXqBCK0h20L3GXicF2o/lEvva+HFiG+Dh80hVwnV6gx8OXnevfBfokGtG7BCZCPJR8T9+RTEliUB/c5a6E1q+sY4g8jcKsntVvCPir72e/wmLxHaffmSuMgRZLvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBXavc9dqZHBFFXQ6AK/DsynA2nCPnWdQ5ON09iNGOk=;
 b=xTH0QHxbWnAHXK2knR/WQe+jInDY0fvC/Fhb+LfvA4FXSbrpek0qlMJxPMoNYBgprbF0PjhaThDeNqkKOiUmvshKZU52sf+ZU6tWi4GR1Xs+smSVxj4+abzZY/Dtm9jK3y0BE65DYwrd7lcll5uhJYbZnjTBw4G98xsq+LFmbRNsl0sDC8BMMfmyDlTdeCU12msCl2/bG8yNP4S3OmAIScNjnmHXguS4CtCWMKQ75IJn50CL/EeRodPHfoqdfSc3l8Or0XiglA0pCOKNnRWCKu3N8mAjSbK8T8xvVZ+zkVOsNXQoYEhU6Y38kQyhjFKwjD9+gEFBIh0qa5cyDTyFpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB8810.namprd11.prod.outlook.com (2603:10b6:806:468::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 15:33:33 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 15:33:33 +0000
Date: Mon, 15 Dec 2025 15:33:27 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] doc: update QinQ strip & VLAN filter notes
Message-ID: <aUAqRwcjShsjQbOr@bricha3-mobl1.ger.corp.intel.com>
References: <20251202205554.24405-1-anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251202205554.24405-1-anurag.mandal@intel.com>
X-ClientProxiedBy: DUZPR01CA0090.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB8810:EE_
X-MS-Office365-Filtering-Correlation-Id: ac79a9a3-905d-4219-dc3d-08de3bef4dad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CisGVJ1xjLGPZTvuSU69JKpDuQZ91DdI3h891ciBLKgAaNcrbYDMBB8LsHjp?=
 =?us-ascii?Q?0tI+UXHldVCK87UVpS5Dgp4vk22GPW65kuYFymR9fOfuFs+aLfXb90WQzzPZ?=
 =?us-ascii?Q?c5WBtvNwMZfEsE4hYD42u3yXg8l/xta6C1wbbGSmRjwDkkCG5Fpg+AR+dTH9?=
 =?us-ascii?Q?mqFS89hj/4XNU1ycGnLQAhxhPbmMzOiwaXkQW0AiLTC9tmwG1vW5EsYVJqT0?=
 =?us-ascii?Q?fOJutQD20zwkdeN+3FQtwhcrDDiAf7NKj4Ba6dEDBp/pAZnXyeE/phlhQUUx?=
 =?us-ascii?Q?FOt0IgpwErC6l4QbJAIoIvJoqaGau1NnAn2SYnR3odbEfc+tf4Kg/1Os6wwp?=
 =?us-ascii?Q?q/xACsc209vTzXyqqtLatkY6aNOYgqs27lckt/3yQcI21uWTQ4oDbjqGtlYJ?=
 =?us-ascii?Q?hSMmOSp8EfMcFwGbg0uRh7KnK62yBJbrDikeRw/SqkPLeezlWTn6dd0my12C?=
 =?us-ascii?Q?srdOIjSCG7pKIsbIcX0Uy8U7URoTzusAPL6oVH9NsfrX5z7dtft3jQbdyuP5?=
 =?us-ascii?Q?uXzXR5qpgDC1EhRcxldBSDwfjTP9HsoTchw1nQ8RaLL5/vXEPOpJHxlTnuLQ?=
 =?us-ascii?Q?6n2e1dDkSTu/4Fndj4Pj2Zq/OVTHOhy42vSqnOus/3GOYrN9r+cKpGvXmA3w?=
 =?us-ascii?Q?w3CityYh7i2TBUhsx8/qsTwbHAhDOEiZrEiTdsoQ6cQ7RNZBTFC3/5iNBPq0?=
 =?us-ascii?Q?fngp7DPJzJpFnRi9nXOkWWLfjsneiNdyBDIEqX4Oh0Z9q38o2QLyr68rjpCE?=
 =?us-ascii?Q?EgmTQKXnByGR0QGBU2CMlKKlXpdTuIhDHM0v6ttXuN55OuDig8pnDu97vFdi?=
 =?us-ascii?Q?4Rvf/JCP02H9h/dGba2pZ1gcfAIo6/BXOtCf5a541Wk8WH5afL7/WTtCFqIl?=
 =?us-ascii?Q?fVGjLF1eVTINwwTUgoJuVCcpwHb35f8vrGkv0VmA15qE6Hp1WFpGaHTXCp5X?=
 =?us-ascii?Q?+Z1GbPahjfW9kYpwAgX0V7InL6T4g73AJMJkzTo2PcLhVtuyaraykOzy7kLr?=
 =?us-ascii?Q?zRiWNctaqOqDXKxD6ZKOqtGBzQV3kmUeCvKPlTSwN9mnqPIJTVfrRhx46yod?=
 =?us-ascii?Q?35JJdQQIImPPZfkvw7fADKArwAZFNkYvhjzHLtENRuMOPJnV7bHNTkiGtKX5?=
 =?us-ascii?Q?tI7kstMQbw4GmJptHTnjxNIrq3CfPGsxBa8sI8JqMhXaYVNVZL7OMQPOYgCk?=
 =?us-ascii?Q?qoV3gsVHwlj7eR1As37nNwcT2lfWe/kz6i7VtOh+BvQd9UW3NK5K0LWsZqlR?=
 =?us-ascii?Q?MwL7k+bVydF5UTq+lhihxGObElcWV4F/LQYaXOorZq6OnY8EBGA5lW2QJadq?=
 =?us-ascii?Q?oVZSIKq5pOZby4WNN1FbP6yzl5dmmjgUckAfC7/EFXB2nz0sPyKpsK+DvbIO?=
 =?us-ascii?Q?ddVCzr5SUeegVqnmY/fcMrR21WNdeJxs9Z9Hay0KgLRNLcDO10MPkTQYqStB?=
 =?us-ascii?Q?L2ZQozXsYz+Us0RAp9vxDMZHzC/RhiQH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TMU2k3YBYALmPWA+t4RFqr8arr1DYjjjXCzPnAiO1stlf4Bqyn/hQwdzYj37?=
 =?us-ascii?Q?32coQMvEP8OENQQOKDlbZ3kRQYtZCoV/IZJathiGXLKcCMnaCAIdfNgJ7Rs9?=
 =?us-ascii?Q?POtxZWbAHLGVZGCixUOp3myDZ1dBTcqiBidsqgSeBI+rzR98MS4AJV6W9vpz?=
 =?us-ascii?Q?+gVu0nR/z/co8I7fNQWbQrHNr8SuNgCJMw+HWLXHoqtcdMvmb5Ieb5dwNVSd?=
 =?us-ascii?Q?e64+EeYQHOTm1fbDK17ZhLp2So9q3ns6qCmPLeY5jTIvWij2TujsVza2iroj?=
 =?us-ascii?Q?ZiDaItLT1hbxmPBuhrsR5lQBhwxD499AjM7U06PeJ+asOPg8Pxx0J7doiiNf?=
 =?us-ascii?Q?1mszUIb7VJckzC7jzf4cj4YKYBD7UruRfcc+3fgm2/oPcUnjiHIHtdTMiHN9?=
 =?us-ascii?Q?tICiYMxrduVUFnZ23n0jvX14s3V61VmEahqti7Z5Wmux6N2y4UqOJ40pVYh+?=
 =?us-ascii?Q?AmpQaya5gqjY6rxY+ewLh2FEK/+kA5WB3LZ1CRY1T2iZsnEGHq57xvBFRa7L?=
 =?us-ascii?Q?Dja5/9Q+ThLWvjF/j8uh22335TB4T80b449s/SOI/MeeEMuCNLyUNlUiv3r3?=
 =?us-ascii?Q?fIHnt+TSVvbRxGd/+mXvZAPufqYWlhdZkJusXc4aCKsylhn5ZZNGBmzKTwpo?=
 =?us-ascii?Q?aZrcyDh0tLTxMOvE73Vxsm5MEoHR44NRjMpPEqYIcN6nszLuWTQo//WcgJ3u?=
 =?us-ascii?Q?F94KsqQMu1iNjzbwZHNxMQ6YSghUvVFfF3NZahJIWw4/FHfP9VxKaPxGzCgc?=
 =?us-ascii?Q?zGQ1FGbT1APRSjHpuU9zg4fO/FGF0VeLyRkGO7KfpsHHH0m//gEQa7Qr8dQ1?=
 =?us-ascii?Q?k5eFaaSNi0jZ018Akzkj2+SAZcMEb0GVQyG9xxmPWhBYUkQn3bYxXbyyn6xp?=
 =?us-ascii?Q?7epkQi7DlEOmKje0XWPorGIMj4XkoSwSVEPVBst0lzd2FlQXgKKJ1xE2Zzi8?=
 =?us-ascii?Q?Ew2u+JRs1tvOP2VwVs9TVurUEzq0gz6m/O0XoL5J23OYwFVy2a80plrUjtff?=
 =?us-ascii?Q?Gc3zURu5rCvY/HJOMXZzrafSD6mmRvs1ksNB9deJdNqFo07FQDhKBuK6GE2O?=
 =?us-ascii?Q?FYmaVh1lclC/+ivv2OcJwyURZd40bYM3NgdKvJlgxYf9mUfhMGzp612tg0Nm?=
 =?us-ascii?Q?dF2dAVPYGoChLc+wADBTZuBPwzSkNwpkDtO1C0jnFJk/041UJYqJREJgDjxm?=
 =?us-ascii?Q?YT3W+9/w+/D4Rs39qX4dcKrs7WpwvdXSk8OAv84xPrfZJW2knbYFotSxgWhK?=
 =?us-ascii?Q?N+uAaxFlUXG5hGKxNbPQVXb3k7h0ZqwX6DsdA1vBHOvszS81ZT4Ps9uG+IW+?=
 =?us-ascii?Q?vvy7vk77R3yHgPFaafbF7GELywvXv6F1nnCHOKoyQQDNlLiicr4tkwoxB3uQ?=
 =?us-ascii?Q?Q/p5vd8tCmJ3KNdJIxM5g/l6V7240WBxd4XxOH7wOfnyLCQ4xdtIkIY1HI4y?=
 =?us-ascii?Q?qsRV16mKAZTXjrTve0Mp1jBzBsZtJomLF7SVJmeBn+6YP7pHiq2Dku65m2pf?=
 =?us-ascii?Q?46nTZQtreA6duK9CGN2Beouat/DMh+6RB2Ax3zsxP4Cz8ZXA5kPBUA+SYEpI?=
 =?us-ascii?Q?/rzMSlgzd9sEfzoY1djDi8jron7CO8nCZHhcspi4Pghtp0L7gdj7isoYc+5i?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac79a9a3-905d-4219-dc3d-08de3bef4dad
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 15:33:33.0544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W1Q+XT6NCf1IpPNMSPnC6HJ9j3v52rplUFLcA/RWpJfCcqUDA4E0q139drLw7DfOiGGHmfaFkolnFPyAghtuBWKZoEOGeSi2NNSbSEVdkRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8810
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

On Tue, Dec 02, 2025 at 08:55:53PM +0000, Anurag Mandal wrote:
> Tested QinQ stripping with TPIDs 0x88A8 and 0x8100.
> Removed QinQ related obsolete notes for FW version >= 8.4.
> Added new "QinQ strip" section under "Sample Application Notes".
> Added VLAN filter enable command to its notes as, VLAN cannot
> be added to port without it.
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel,

Thanks,
/Bruce
