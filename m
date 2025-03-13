Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC26C282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 10:35:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F17B040EAB;
	Thu, 13 Mar 2025 11:35:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 9335E40E49
 for <dev@dpdk.org>; Thu, 13 Mar 2025 11:35:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741862126; x=1773398126;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=nWQH30AYX2D5+WQxHMRyHWRbrmyk85UDsh1KKI2Ftig=;
 b=ItS7mGJJFBS12YG62/Nhbp8cT0zo0+HeFCOb2h4Sj9Cfivo5c3hVEnns
 AyxcbyyaxlYDpz3+iQgJkXphEFRW2PY1zOC/WVcwOa4AmWxEJDHVqn634
 27Sw/O39eMfkGohc+Kplkbn7tauose/cOCinZ94YuHtu5CseEKW2XXtVA
 0JLOrK1/jcqJowssbSi/XZZ65+tL4tHkyEwvaYcfjxc4gsGZgSEL2PetJ
 /GH7Lap16aZERhSS/wyiQrcS+9a6ly5c5hf6c7h45YwhR8CtyE6jOhkgF
 iban2GFS22xG8ZxAZ+jWl9bDf6ZHYIQCZlOgTulVhVZ9VeXNrMGaIgBxS A==;
X-CSE-ConnectionGUID: b34blvFWTRWHhoiVjIywag==
X-CSE-MsgGUID: wOQAjak2RPGvaIztenWtVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="46755691"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; d="scan'208";a="46755691"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2025 03:35:24 -0700
X-CSE-ConnectionGUID: KpL5u1HPSYiOT1iArQEtCg==
X-CSE-MsgGUID: 4FxM+jAuRGigQEoAUMCcXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; d="scan'208";a="125990807"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 Mar 2025 03:35:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Mar 2025 03:35:23 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Mar 2025 03:35:23 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 03:35:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yEXquxZQuxGP/cabgWjLMzMv8HRP1CKRXpY5DtnDrg0h3Fo2nKA+BeKR9yZcs9zS4cxzzFoUyLA8bmE2LXu0Ylzx6h9oDwRlYXBdzsvADyQfGOOUmm4r22ABA1vFWnCgXvdXmuHXYEBAaytk8pQdT8YlBy0p8xHNKjY++6bOLXSM3zWB/wXqLQ108zrwYZGWkx9cbWSRlntavuxWzaAGJBXF/8bdIh2all1qJHvnPQiB/C6Foh2MEsPCID1GEB1bn+D1yRWE2H5GYFZNGYDYRL6RzprLXt3VKSoiXIb+6I+7Q7aVzBule/7jJ0eT+PGf7kFTs1Ln3aCQ/YKz9wr8zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b30FcueLyUZ5VDFGkbxwmMQjtOTdNJU4EgwAypDCXPE=;
 b=Yr+xgkWNgxnbu+CRw02u/AJHY3oXPgd5yF0Pypl5HDihZzOKu1Gyh2ElVcJgVJJYb/SsutYJ36dje2my27loBdH/SRZPnSCoimUysP/+1yh5gAH9FsF4mroiXrT14cSQ4BAcdlHJx3HhvUOwQyyZ78RGNwwS9eUG4KVWGgaybnN8w2YMjeuy4nGQuQ7jB/xrKFSgw/DaCb9laO2zOgToKZiyQwh2Zges/brO4izihjqw/yEdeS/Lx4Fml/0sa9Q7f0nXr97jQmC1hLgF5QrT15XRPob974KClKr6MFN4CM8avRtRBk3iKfGhMTy5wdKzO/fPHrOT9SMsEy6q8mYLOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA0PR11MB7284.namprd11.prod.outlook.com (2603:10b6:208:438::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 10:35:20 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 10:35:20 +0000
Date: Thu, 13 Mar 2025 10:35:15 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Andre Muezerie <andremue@linux.microsoft.com>, <dev@dpdk.org>,
 <sameh.gobriel@intel.com>, <vladimir.medvedkin@intel.com>,
 <yipeng1.wang@intel.com>
Subject: Re: [PATCH v3 1/3] eal: add function rte_size_to_str
Message-ID: <Z9K0417yO-5Gl08C@bricha3-mobl1.ger.corp.intel.com>
References: <1741291408-26509-1-git-send-email-andremue@linux.microsoft.com>
 <1741807714-26748-1-git-send-email-andremue@linux.microsoft.com>
 <1741807714-26748-2-git-send-email-andremue@linux.microsoft.com>
 <Z9Kg3C-L22fTKebl@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FAFC@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FAFC@smartserver.smartshare.dk>
X-ClientProxiedBy: DU2PR04CA0020.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::25) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA0PR11MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: 746d7782-5116-4c38-f447-08dd621ac0ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?lgdpccOMXtcU1F+/04ZFwhyRnzqKT7b0s903Ve+Z2Aym1VW6LUhS6ljYtk?=
 =?iso-8859-1?Q?r8HypJsmB92W5cgLfrE6EcuXRjUIjxoMYeoBnRt8eAne7GXLTi+TIKUdr1?=
 =?iso-8859-1?Q?sw8/IOjgotn9/FGRiLMTzJbaZa9wruYQnRwmXGvtuG/3gTMgTzPpXAPGQV?=
 =?iso-8859-1?Q?jXEy126oNgg+OBdv+sJ2IaJkUaFgG/QXmCH6qux3Xt4uiD1Ia8+2qEUzPf?=
 =?iso-8859-1?Q?ZgJJ0yT54Grsn5IsyLidis3WRuZB2qgnt4Yl/YFC2jSUm9BCtJHjPDo4TP?=
 =?iso-8859-1?Q?LkNL0M6T4c/cccI+I1qhRLHOh/Qo1YZ9SeuWNhvFDQe5hjtAWUyBMycBq8?=
 =?iso-8859-1?Q?nCOy+rEIJkaN1ZnZpjCewvd/W1Zamb3MRjIlMEd1ITCQixKMBKeeOnjF2i?=
 =?iso-8859-1?Q?klhNy1+LIqqSBRhv4LtWUNlNXDfqQOFfdn1+iG61ynp/C64mJ+oYudW9VI?=
 =?iso-8859-1?Q?9xpiGutsfGn6wJ0bvaMLBHIm6kNMr7F3scP4DDbqmuSTrK8rDq31UBydbP?=
 =?iso-8859-1?Q?ITWQBn61TRL7oA/cwQiOE+MM2ZDKZFHWCon22TLgj2G1wyEowmcxHlwEbX?=
 =?iso-8859-1?Q?ShPgZThJjgmf09PS/4aK2bms9nP+8kAN2Oj6s7ohR9t94gT0H2TB5uFaGG?=
 =?iso-8859-1?Q?poQ6bPBtz+uRc0sY8ofVYCzVqsLkRWviTXSfzIhe/FEOvmQKvVDDEY4t75?=
 =?iso-8859-1?Q?AW/Wr0xq75ezh1e+5/1Rq7kx6k6XXrEyqbrrvq8tdMZiSg39vpPZuSjlrZ?=
 =?iso-8859-1?Q?7NC+yaM24NG7MAtYm12/BXf2S3IXh761s3KBhJeuK4MmvZ6H5/qneOIG/T?=
 =?iso-8859-1?Q?9z9mFZJStFArjkJicSBedzGpylKmERN1t1WFRfYgBKimVeKA173lhWb9TL?=
 =?iso-8859-1?Q?ar29Vbrp/dkiJcxJH4XHBDJA1lvKYD5jWY5qaA5+iwP92o977pFkMyoW0z?=
 =?iso-8859-1?Q?3QHz81K22wM/HH/s4KkxQsDW80lulgtqXdRYV8qhepiSB63e4qQRfQirBl?=
 =?iso-8859-1?Q?G6IoSZ/xUT2THpD8U2rv4O3CrZr4bJ2ooPBUYUH3tbnlaT0egIOeOewfir?=
 =?iso-8859-1?Q?3tdgASdKRv0MIucov/Ij4L65mBJFbsU53SkigSWIx46isicZJIwNxQCmwE?=
 =?iso-8859-1?Q?+TyCj2b1bFgePwHn1URU1vCKG7buPByQ4B0Ia+Uu/Ps5iZ3WWJFDFzQ7wC?=
 =?iso-8859-1?Q?gcv1goqDsO80SQyOzDxSn9pWo5gSKM+mn01tR91phBny5iMLhMuqQatLGU?=
 =?iso-8859-1?Q?txdfXtOX8giODQ71MjCnuBaBr/q9fABhNim77oBO9xTWT8tacC0c3J98H1?=
 =?iso-8859-1?Q?LwaTnXRv1AdcHjGeP0ka1ZJZcdCbuZCQDOQd8Ib/6xz0xGGQyxe3LNDvs/?=
 =?iso-8859-1?Q?d2n6Xr2+fn7H+dAVRFKUWNCI0bm7RrYTGt78UFlYkATs8r27DlElI/wuSi?=
 =?iso-8859-1?Q?vXcD4Ro4zvO+JRrO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Pnqh+L2jdVTYFO6u5M7XecuobWV255CuOJuyh7sfcEhWeGapWZbdrNsBSb?=
 =?iso-8859-1?Q?m/jIWDkhHntL0U7nigSF5s5r/TWynOi6zhg4O37IYRrL68AURhXOSqt5mC?=
 =?iso-8859-1?Q?89M8BGTFQddw1bLE1vNQ+3xlf9biESTyYXoqKWUHcxu3GyKSITAIy337g5?=
 =?iso-8859-1?Q?vMSWEky3ctvH2XeacPlAkGSm8XX2ogkOrTXZvlNwBQlx+JU7RKdD5mAA6Q?=
 =?iso-8859-1?Q?flFOn5KSjVPoYrxwLxn4qRk5jwFcyY1RyU3rP7Y4Ac3WZntgaZ+DxvTC6S?=
 =?iso-8859-1?Q?eLeCqpmkvrn7RH3/yU5ry0RLEkIPoQjhSwPnwsNhHgs7+q7pcRU/L0JxD0?=
 =?iso-8859-1?Q?4Hk+YTMOHansnoSsLiv1KsFIUpa7P3ITDeMhE9uN5r9bxpMkhn5J/XUc7q?=
 =?iso-8859-1?Q?cbL4aJ2U5s14+OTmoUURvnvGMTflm9OPTbjoXnCxL1mhg925+960Cl28p6?=
 =?iso-8859-1?Q?fBHPAshpeAQxehlNPZAAXQJgKzRUt/MQPoAaTJJRqOJ5tUzk9+EI+DqgUK?=
 =?iso-8859-1?Q?8E72Droe9vKPZVFBydsYSxCHas5j1N//4BwJfg48z+GDrs93Q7wU4QMGsL?=
 =?iso-8859-1?Q?oZ1zvUWAQu6ZNnaMK4xsuLIdJgaQW2I5vSvmY8+R98g4TNIa7pOd7dgm5K?=
 =?iso-8859-1?Q?mvqFVWLazwuc3krR/ULjLz4zQ41Mvzv4Rdp6/166pK8CGiD7a9D31b0rdc?=
 =?iso-8859-1?Q?xaP4qsvAsvdhEZQ6enBIrWw680y4tlqvjnm6H6jMnBivxDzd3nO22aCkyP?=
 =?iso-8859-1?Q?x9mXU0dcmNWrEqH+5jFcushCphpf6I4yypikEmZAhls3wg6jyLEcJXWyC/?=
 =?iso-8859-1?Q?oNHoAVMEekm1Lkz6kDV7h8AfymHAZR+Ib6FwIMlbDtZq3OwN3TPXEZur0I?=
 =?iso-8859-1?Q?HRYiS3sAbLw4cAtu0HGqTJ2XFwZpi1YnAztYkpYupY2frCIoMPCq46TsF5?=
 =?iso-8859-1?Q?Pb/aF2GFyDSdOWPxQzvzr1NWwoMNar4tfbeoCg6B66+mOdJd+1Ugl9gKV9?=
 =?iso-8859-1?Q?EAsESMTBN26e+BXdauwc4bwB1v7m8/JJy2CqaEQJgSk05LelTE6uRgBNHO?=
 =?iso-8859-1?Q?29nGSkdZ+NcnjsAqlZiPKiwMgqQFAimxhddfu3P5MSxnOb5Uvkx51XOJFU?=
 =?iso-8859-1?Q?lBAi5Fb8D4QNatW9z3Bbc12XEeiTNSXKkhpuWM9lI8R174cYlop5ABw7Ea?=
 =?iso-8859-1?Q?xZaRYzXHKhpau61+yX3YUhDi3xTXUKDeiMbUi2xzSkZ9xXv8r68y+YCSz4?=
 =?iso-8859-1?Q?TY5B+xU2cxBBgsdYWj4WaMp2uTmxaUOA2HKSv1gkLOJoyR02nxTo+5DfX7?=
 =?iso-8859-1?Q?1cbsb6l2nQ2jlvy3I5Yzf3kAOVA2WuUw9EkLh+QTrRTfcOov2e9+A2WVB/?=
 =?iso-8859-1?Q?m/2w50G968E31w7VVYsuXBbcy5uDX7J0E5Hy128x2G/RDblkEC7cTlFq1H?=
 =?iso-8859-1?Q?5ivcAvE1mVY2CvTmIpneHkbQE3v9oAR5d6fPXKx1fHWEeoeiwwM/YLusoz?=
 =?iso-8859-1?Q?xbHzbWDW20NshtAXC5Gces7wxvQt0xbasW+GKwI2lZvc8bbHLQ/km10zd4?=
 =?iso-8859-1?Q?2B4ZUOdbXjs0v7UyHB7ocYkM4O5fl+AP0gUQFCUwU8S+PZBxA11cSQDIK7?=
 =?iso-8859-1?Q?zjIOo4+wpLKhR3bDBnaQVpb30HtICEuVMdTkAQSo/ywBhOhIPbe1WHwA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 746d7782-5116-4c38-f447-08dd621ac0ec
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 10:35:20.4096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mQS1s98acF8Tfph+/epgTlquCD6MgGUbpDRTRz5l10wVvnTVW17pUrgwBdmgVPWjqmIZxoxSeZx0l1pWf5IcGulconoo0pz4cT4KMvaBp1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7284
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

On Thu, Mar 13, 2025 at 11:07:47AM +0100, Morten Brørup wrote:
> > > +{
> > > +	const char *prefix = "kMGTPE";
> > 
> > Why is "k" in lower case compared to the others all in upper-case?
> 
> That's what the standardization bodies decided. Let's stick with that!
> 
Ok

> 
> > > + * Sample outputs with "use_iec" disabled and enabled: + * 0 : "0 ",
> > > "0 " + * 700 : "700 ", "700 " + * 1000 : "1.00 k", "1000 " + * 1024 :
> > > "1.02 k", "1.00 ki" + * 21474836480 : "21.5 G", "20.0 Gi" + *
> > > 109951162777600 : "110 T", "100 Ti" + *
> > 
> > I would omit the space before the suffixes in the output. As well as
> > looking better to me, it also solves the issue of the non-suffixed
> > numbers having a trailing space.
> 
> The space could be optional, like the "use_iec" parameter.  I would
> certainly expect the space when appending a unit, e.g. "bit/s": "700
> bit/s" or "1.00 kbit/s".
> 
> Or when the appended unit is seconds, e.g. for latency/jitter: "12.3 ms"
> or "123 us".
> 
> With raw numbers (i.e. without a unit appended), it's probably a matter
> of personal preference, so I'm not going to insist here.  I still prefer
> it, but only when a postfix is present.
> 
> In the SmartShare GUI, we output with the space, and accept input both
> with and without it.
> 
Ok to keep the space within the string or have it optional. Although it
seems weird to me initially having a trailing space in some cases but not
others, it does make sense in the case of appending something like "bits",
or "B" to the string. Therefore, ok to keep things as now. Tend towards not
having an optional parameter for it, for the sake of simplicity, but ok
either way.

/Bruce
