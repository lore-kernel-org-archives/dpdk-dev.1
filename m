Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1F0D116F1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 11:49:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 602EC402F1;
	Mon,  1 Dec 2025 12:49:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 1A427402F1;
 Mon,  1 Dec 2025 12:49:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764589793; x=1796125793;
 h=date:from:to:subject:message-id:references:in-reply-to:
 mime-version; bh=I72l0EWasmUiID8nzU535iEm/b/UF3GSiNUztwY25RE=;
 b=N7M5HegaRNvPctvk4c66tq5IMzF+FKUbeqvqY/GDMqjJjVr0atTx7ST6
 obecYHE6QizDc4YSccdDvATRV3AwDSIMo2hgI9GVPYNisr+ZYpqdppjCM
 elLCO6RLa0j6TifL4mI3ngzLvFmVuqp/gP7YBX6q/Mj+V36unnF1nwtRY
 kUYOMDJfip26yxYrEI5vlpdEOkPuM1GbLgfLQd5OFxTXw+8Zk+y6Cj6SU
 j17F2KecEm6yZgycpfzasyctI0KOB9/nvmUiGgfJ/CB6kUhfpvnJY09RY
 WxXQY8r7E7mzWA2Oy+Zw3P+twCGP5envQUeEf/UBQshgXk3mREQdAeYwS Q==;
X-CSE-ConnectionGUID: qxItQCrJTlarl1AxNx/nUw==
X-CSE-MsgGUID: Ly3uM5WVQuqGbVQp6qs25Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="83915305"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; d="scan'208";a="83915305"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2025 03:49:52 -0800
X-CSE-ConnectionGUID: rQUxNrgKTeOzk4Zf/4gXPg==
X-CSE-MsgGUID: 0w9IiFMxR4imE6ple43Opw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; d="scan'208";a="225033836"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2025 03:49:52 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 1 Dec 2025 03:49:51 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 1 Dec 2025 03:49:51 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.27) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 1 Dec 2025 03:49:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVeE2h0QHzaYmOxoVDpKSNHCV7qbNsSkfgzUnkqT76+oLQiv6KiSKTLhdLwm7AH1AVIYbdPXU4bLjOKImZ60+nY4uBEns4qbaWaSqfhF2cR54zSzzHHtp0ShL0lVxH7DotjhEHCSQTcQzkYX7VJO+fT+hfUK0KmVmTDHXyADDQ3607vxjQ6XWNDx9YM8x6kAiVHrRPmvfURPUDdmXpohVRg9kqq/Icw/Zf4rjixvkd21pm3tPlUehDZzISjU08uO/etG6bhY92K75brSCcFDRotXsQsw1l53stpe+B+eT0PqLqlqp2TVLEp47LcGDOgcIWc8mRxGE+IwIJRBhBiLjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Io9KK8pzlCphPDRc+CzA59NIGAQMPZOuC5CM1XOuXCk=;
 b=qPBgB8iWBiPI2Ttik1XJaAGj8AY2+kvZiQAb9cnN/kz+GHV8L0P3eCV29UPjlDanDsqs2nfqB51wSjTInygXCFP5m+UABDYfA2ebN0Mj8/panAUa8/cD55c0Wh/ff6IL2GjqGhbQgUel7Ztx81ybi9qlZuZdCyEihSA/jE8Llh9GWtrCeogiqDOQmQILrXtTAGDUKnM4dwwQjdZQDwAzjYcbmutHoHslguu2q4lmeS48JfHnEkCZpUx7Sq4T2i4sZZ2n0SwYKeQuP8bCJTOHINS1n+ViAj0ao4dUGHu2VE3DIaBdtmUNwkoz3/BXOh/fieZWyq3feV5Mr5rH1pbPew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA4PR11MB8889.namprd11.prod.outlook.com (2603:10b6:208:565::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 11:49:49 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 11:49:49 +0000
Date: Mon, 1 Dec 2025 11:49:44 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v3 00/31] build DPDK with Wshadow flag
Message-ID: <aS2A2A6UiWxCHUTl@bricha3-mobl1.ger.corp.intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251201114448.1441377-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251201114448.1441377-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DU2PR04CA0156.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::11) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA4PR11MB8889:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a7a6341-be9b-4b1e-71fe-08de30cfbb31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Nme0XliLt38PmQpmiHsIgwkCgTGTUhpPAQ8GJcIBl375MRa3AV1uwRQ4Ehht?=
 =?us-ascii?Q?dYsF6GdJ97PHXfR6XjeXq0pBVky9DeaQrHPvea8tkmh1uqJJ2mbxo2lrjD3o?=
 =?us-ascii?Q?8wzEGGsUe7FOdQizVN9uKLPxiqZmGkpnH+QouKwWRtJ9eLaU319D42qa0NI6?=
 =?us-ascii?Q?y7V24WSlE6Kb0qlpMN/AjpNADBAVK10Vpz6Z82VZq7XTswanPYyuoPe4eij6?=
 =?us-ascii?Q?fvj4cQa4QmcnxnpDz0CiMxZM1NGJWoGFf6TyDTUWsohDLrLa0p8HM4F0kkav?=
 =?us-ascii?Q?StAhUJfZ18n9jt+JW8kA05xFYr5AqB3nnFojoDgQKj25UrbYmABu2YyQ2KGn?=
 =?us-ascii?Q?MkqOmVxJsudMTuJR5XUQYRofEwzFOGExGuEj6SROcfnLWoJeRLAJrYw1kj0y?=
 =?us-ascii?Q?At+/JImtQ+n1xeZHq9utxblPAwftd7IQlCVPVrrfVA1dsif7u/ii4FP2UdMN?=
 =?us-ascii?Q?F+LNMPN7A+BhlriYyeo1/Li1NVSatzKNjx12wKshJS1r4P7kduYkXgguvyqr?=
 =?us-ascii?Q?F332blyigEtGGyKRK8hC2rWifQV3sgfgzg3pItK5PahO7E9uom45etbYy447?=
 =?us-ascii?Q?LQ9idEHP97KGxfU5kfSh0cP6uiNHq9El7ZH1os6kCAZkZ1/jG7NubAqtqIhn?=
 =?us-ascii?Q?7OayON0VEYo7IhvXsEyJ75VcuYrM9OY1YXKg6g+MboJNtucW+376o7B/fZLH?=
 =?us-ascii?Q?g5met1a1XFEGXNS+mVO8ZLl8lqmhaARH74oXZ8DnWZ70tw9oPXZLTgTQjLUT?=
 =?us-ascii?Q?0qlpd5SY8X3y+VnzwEoa1yI5LpSMt1zcpstuo9nCumjkgZjyOdj0uFzJw8So?=
 =?us-ascii?Q?L+P9J1ebtPT22D6pmAd4/07h8O7PXetnyHKFTjZOK0FdW3ScWZkga6FM76gT?=
 =?us-ascii?Q?eUmUR3iVzZHAn145/ZqUF3+QawRJUBNP86AEAhbO/5Th6wTWaDn2Zn+4jKbX?=
 =?us-ascii?Q?dDr9K4rD/luAd3HZ5fUUVdFMZiNEIlxuqg3qC+zXpavicxIE3jMQnxWri5ND?=
 =?us-ascii?Q?hYqEp2u1ws2/leU7IEKV6R8VeJ3KDJDpO6EOjwwy/ElQphmTQYheCGeqzw2A?=
 =?us-ascii?Q?Lj4CU44ZxoZS35loYG5K0s9JnZ4f+H0rkZlcPXGALti/hkWAppHtlODj9yCZ?=
 =?us-ascii?Q?J7qEzvSoC6mD57yujyvOCeLL/y1AMdHcfW7fKsk3ZbhKBft5O1446kWpB4cP?=
 =?us-ascii?Q?+Wv5h5fMmKghnpkEqZ/eN7YIjc+6x3rYTjJSJCu2yxy1ZiVhO6DFflWfpfuZ?=
 =?us-ascii?Q?MwIboIgXm08C4pmjiWaFQ5KNkUKqOLZ5FzmxLWzd2lF66O5QDEv+R8Pe/nwM?=
 =?us-ascii?Q?bVU3nFajt8Nezx0Z9yYW+VQ57p8hAdio0sMxWnOFISoUKET8yB4hxIVgNQ4J?=
 =?us-ascii?Q?H66TufSAgq3aYFkvv6hwu3HJ7JRS1U+r9y4H6doT2qyP3ndnYlVWuch3PQU5?=
 =?us-ascii?Q?9fWmKMNY7pocjPVfz9e3jUXq49hb8jB2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eoHzSGtbIoBvFAVvH9j4qJFJKeRqfndKKGjOq7pWkAYhzAp2w+2s4+dR7qff?=
 =?us-ascii?Q?hDdIEUyBTv44GTmwZoGLxDFP8Xa5xPf1EH6Lrg8I+xRlww+tbtHplAEOIsyI?=
 =?us-ascii?Q?ZnYdjKs+bfQX5qxmhhOZ2uZedL5qbu/6Q449silsCo1F+iUzVYk0/SeLZmc+?=
 =?us-ascii?Q?aMFiQHdYX+a1/ZNqywp++n5HBZDUgXmtQB4833vIRkDDixOnPejWI64Jwr9G?=
 =?us-ascii?Q?2h4Chot9UtPbjC9rBJTRQIAjioezF7Qb0JOKwq9y0Dxs0+ydBv8LjuJnySHj?=
 =?us-ascii?Q?FnQTuhY/7LeMN1VavHgGd7JBW59pP/G46QScGT/YTA9Y2eEl3m/dehPQHpjn?=
 =?us-ascii?Q?QfZvVmYXwNqTwXvsxU6rUxTbPZs0ItjbeCtZIWjTtYoBDp51wQOYnnjQ4vPX?=
 =?us-ascii?Q?Ayhr4CiSGEOayd8o6JaJXDDrG4fB97syQYuGAmLf8IzTqIyVkVYO13bKdY0P?=
 =?us-ascii?Q?IahJ2IXq7iqZNUz6u6fkV5kcr6WTzvj+vEWdTPMZxOTYt5ZwDYZxbEEc92jf?=
 =?us-ascii?Q?CEeGphYAQAcmZZhFg6j6QqzDwCau2iPcn/ii7xMlmSyusLL3Kvx8aflydJF1?=
 =?us-ascii?Q?gMkVeQS7EcVKzRQNIi6uijHr3sWatzTmdrH7URqisMwSDE+YsfJcvK59sXfJ?=
 =?us-ascii?Q?047Ol2oHpDlaD0RQUcnga/3U4etgDCeoSx87KAzRykbupWJBGy5UUpftnGRL?=
 =?us-ascii?Q?I9Hszlw4NQrS9o8tS3/36BXp3bi1zMaRih++faO0osX1NxvEISrlDl/DXZN1?=
 =?us-ascii?Q?uG5ZBzaqX5YudH9g4pWJLvSg+MMtUz4XQ5hXO9+6yiM5MW0wzxv53D29X6q0?=
 =?us-ascii?Q?Zfd8ayDmXru88MMmaBukG2nD1JYXQrRmcw1RciMSa65tlwgOAHiSOqxoMi84?=
 =?us-ascii?Q?4CoFAxrewV5qPiXpLrTRpmDHOO/rRlC4hSoe5Wo2jmRA3WDGrhsaBORUcmlf?=
 =?us-ascii?Q?yoJS4qBfeSQoV9PP0dz670u7ddYbJeiE+XPxKgy0ca2CRsL3+q8RPIFjK0iO?=
 =?us-ascii?Q?nEYMaxRxNSI4QvgGBy2zFx7Y97j9dZmetgcYA+CPzjGR0XSf91e1cK+qcZST?=
 =?us-ascii?Q?Ki9FtohlU5tMXhCHzZyVMRPWxTTkjFyIi9qhmiTvgnGMPhMllEQoOMLK713K?=
 =?us-ascii?Q?sM2P3oN4gAzmwfeRfAxALujrOI18LefPIdZp+8Z/8F3+efyEXoJULTcANnh1?=
 =?us-ascii?Q?ibNYpO5bea6GWXiqOqymKqWxQmS0xyK62VbbMs8le6qdYNZpeU8HQJN57zZ5?=
 =?us-ascii?Q?qf7JhUgpQ4D7jvzSmwHd0dSLT9tbVpKqnPXjpT/2alleGTsxi6C6wSrDxeLd?=
 =?us-ascii?Q?MeGlD+Q8i8jrDaOnacNUPV4ItPnn++bfPjJf+a81M/frjnrNhT+EZWWEVFOZ?=
 =?us-ascii?Q?1QwvMgc8RjUuyMU5qiPAwL5dlCFJ3Lak88LoPlH3+CwzmqdNvgNU8hqsh4Xg?=
 =?us-ascii?Q?PG7UijfgQxF09UDUl0YrvgiXirSkbfyrWQyybVpvqKRS/mAKxNWPkSSO+wnb?=
 =?us-ascii?Q?qeNRYdWM4DwvD8MNkL/D5ZwzxLrwS0zm7OiO34yHk7nFJnvrgLgDQ0EzoQ63?=
 =?us-ascii?Q?wHfbZ8hUw7UhrjJXW5UIXnIfYwbq25H5TqqqEFpdsPJI66F9+pAhPa046uTn?=
 =?us-ascii?Q?Hg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a7a6341-be9b-4b1e-71fe-08de30cfbb31
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 11:49:49.1791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u2aROEMqGPnkz8SwAcpOLKeohIqzDweeNon4pGZh5p0IoW3OTl+2INfBleIk2LWZJ42ZP6Bn8pBoCKVmf5FN2DrgAesFzcE0eNP1bwEqG0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8889
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

On Mon, Dec 01, 2025 at 11:44:17AM +0000, Bruce Richardson wrote:
> As flagged in bugs #1742, #1743 and others, much of DPDK fails to build
> when -Wshadow flag is passed to the build. This patchset fixes many issues
> of this nature, but not all, in the hopes we can move towards enabling that
> warning flag for all components for DPDK in future. This patchset fixes the
> following components in DPDK:
> 
> * all libraries
> * Intel net drivers
> * all apps in the "app" folder
> 
> For the rest of the drivers and example applications, any component which
> does not build successfully with the shadow warning enabled has it
> explicitly disabled via cflags. Then the last patch adds -Wshadow to the
> global DPDK build, which should prevent any regressions in components which
> are already working.
> 
> At that point, we should not have any regressions and we can, over time,
> reduce the number of components needing the -Wno-shadow flag.
> 
> v3:
> * rebase on 25.11 release.
> 
@stable tree maintainers.

Where feasible, for many of the patches in this set, I've marked them as
bug fixes against older commits which introduced the shadowing. However,
I'll leave it up to you to decide if it's worth backporting this particular
series or not. The remaining commits which are not tagged as fixes or which
don't have offending commits identified should probably be backported too
if you are backporting any. IMHO, I don't see much point in backporting
only part of the series - either it should all be backported (bar last
patch) or none of it.

Regards,
/Bruce
