Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957F2C83F22
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 19:47:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 637EA4013F;
	Wed, 16 Jul 2025 21:47:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 35850400D6
 for <dev@dpdk.org>; Wed, 16 Jul 2025 21:47:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752695235; x=1784231235;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=/tsAEBA9moxVoA9CD4Bfr5P8vfek82ENdJyCqmwnZnM=;
 b=EYhKwz8RB+pMZzOGz5SIqXAgs5rqGE5IMMd9clf62gDl3rIYQyH0YLZy
 wZwe4fotcZLAaHrmrD8pfC3nUIJeZfbegXxJ360fM1LvuDpXEol43WcGb
 5r8kwjepm5NGEP1+3asq+FPGEKiVWjcnG6zEHeYxjsKt53CFhJVbPYr4W
 GLYwqzJLjWj6DyraOprERqJm4BczHkmJ5RyA033Ke/pKMg96953hsZwae
 UXHDeONS2HkH3nwW1vdZSUMfT10CCVS7cR5iFOPUYOCOx1XGG8mldKDqL
 UvOYq0vJEpgBIbFPOFqsppGYOK3to+8ycySZLtEQRVbnuy0s8Mfea17jf w==;
X-CSE-ConnectionGUID: IBQvga9NTte+5O9NqWAd3w==
X-CSE-MsgGUID: NoCVXztiQROvaDPqR+9fug==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="55047884"
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; d="scan'208";a="55047884"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2025 12:47:14 -0700
X-CSE-ConnectionGUID: 38qy1yAvRXmQzu1/jG9Xig==
X-CSE-MsgGUID: 1+h/kTbFTEiClMzf6sxNWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; d="scan'208";a="157673571"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2025 12:47:14 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 12:47:13 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 16 Jul 2025 12:47:13 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.80) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 12:47:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snTl23AMvT/r9xYMo+d353oX3BOFQjiy1wlIiAZx0WJW8QovyQmlAK9NWSbFpmC42TPESSRwUpHg8++leLZeMEtgNa/oUHxl3Alo8SZehd4PMqWdtlNBYToJfcwBiwdq8eGGLP9Q/oPrZwB7CqXW/8piYkLfA0eVPJZJ0PSiDj4BBp4SlraDwjXrdh+uAPppxZbLEAsoFStuBmMNh40aQjf/LnXIGIukO7f7eNccA/kpbFRIH5647wk3hYLUfB6G5OczunqqXtZbKFkhRxYWPUu9u/jn9iix/exJNeWZXG0tRpG6yvMxp1fBSeNXmWKBoIRDEIS3cX+7NlCgTmP0/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ox7EumD6QCVnnQp+iTsL45P7mufZADnA1Ayg0RowB5w=;
 b=zHRtolm8KsNJ6JaWnIT3fJdKQg4DocjPe9jhMGe/b3F2qrjLgkrJdeGUFo+p3zNub6iinHKB95Oa5WmUVe8ajGS0X5KPulplMvhPAexUN0E5cD18qFDijeKGz83LxVMlGEoLmra7gVMthO7GEeS2SPEAs9HtsZZ7ThMLlrNtnrJy/CwgctZudyMhPgRfqVbduFKSL0t5cLoet7MNPs8vksPjtwyKTeuhdDcakKddsY1INxzUS/8/T2v7B7RWdf76u3sgoBCEnDCVW5WcuuPv0uX+hSMMpjr/BH6PHiagBY4FC8RiotmwEstunjjh9AR+4qqG+ijxINJgDkhGX1R2cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BL3PR11MB6313.namprd11.prod.outlook.com (2603:10b6:208:3b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 19:47:04 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8922.023; Wed, 16 Jul 2025
 19:47:04 +0000
Date: Wed, 16 Jul 2025 20:46:59 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Dean Marx <dmarx@iol.unh.edu>
CC: <dev@dpdk.org>
Subject: Re: [RFC PATCH] doc: clarify VLAN and QinQ stripping behaviour
Message-ID: <aHgBs5DGU48mTnwz@bricha3-mobl1.ger.corp.intel.com>
References: <20250714133014.44597-1-bruce.richardson@intel.com>
 <CABD7UXPVg56UwvmtOsssBwV2HzmgV4ZJZCb=FrnVQKkggtD2+Q@mail.gmail.com>
 <aHd6x3kT053EvX2g@bricha3-mobl1.ger.corp.intel.com>
 <CABD7UXPtChUUOdz3gfiyKqY4Rn2_0F8Ck4O6ypq9woATD7hfCw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CABD7UXPtChUUOdz3gfiyKqY4Rn2_0F8Ck4O6ypq9woATD7hfCw@mail.gmail.com>
X-ClientProxiedBy: DUZP191CA0010.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::27) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BL3PR11MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fe8f318-5910-4918-8a09-08ddc4a189e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rnjpOczwcEPC5pTES/24NLv9kppT4DyIsCnb8wbIOvTe/GAJoIyxfQOqQBU9?=
 =?us-ascii?Q?sJknGYcpfQpCzP71gLIC+IMaIKIfOCMNEkpGj3o5VjOXsl0cTEH7d8v5PpA3?=
 =?us-ascii?Q?zQt/uSTTuar85T/7Suc4c8tDdjb+POXvpEZVa2dtn2rpxGunesyh5ch1AQLr?=
 =?us-ascii?Q?bYZoIw9pTWzkw+9jePpsc34LDDnp8N7Y4XfEKtEdKkBqXdN5NWDpPPLqm/CO?=
 =?us-ascii?Q?j6bTEprlfWKiPX7Dsm1qLFGLMjPwfA+l3Bs70LZYbbIa9E7JgnodYm+XbdBQ?=
 =?us-ascii?Q?YpTZ3r/LKKB3riEmCgE2o+0DB0juMiAhRVoc1fLdD/F+Hf/PAjsFLD1U5PAm?=
 =?us-ascii?Q?d2QWLM83Z3tf1tHQrcj4t6sqIJkDglcw4mQaUWKem2mIC8UQnZPL27a9MiKf?=
 =?us-ascii?Q?LyPwm2zQzUUZUEEg1aayuORA0IA5uP+V33+3Xnk7UiqfKIM2uYmJw9WHJ2K6?=
 =?us-ascii?Q?uOb1KWXjj2BKOw/u7wJkjRppxTtkriPdShXaY60HKiHJJfDzoMos6m/mqqyr?=
 =?us-ascii?Q?IK6CoT8Nk4waI31RnmnM25nUyWZvjr14ZsU+TwI+jI5rr8SJFot3RYQuWiuv?=
 =?us-ascii?Q?co6uAYrBAazDoR4D89OcHyTgjChp/OLVxpWzBVxXHjUSufgHcNMmPi8B9rqT?=
 =?us-ascii?Q?vhWmM018N4xMNyF9ugnHjHZSRIcWaP5Dc5di4xnheWfZ2+xNCk9Ac2BQdVEK?=
 =?us-ascii?Q?ExamAP7UdjiCBNJuwTdIQ1N9UzYEb7P1KIpgA/0AVk+qRHqDskJe2/c15T76?=
 =?us-ascii?Q?lwlBbMoDSlIggfkEHPytd8P/0s0UBErt+QUrpKxgYqESr6DBj7Q5909J4DgK?=
 =?us-ascii?Q?+6MNSYuWs30E5mUeKPeoitp9Jnvk2UoccsDKlcAcnLB0ZYSq91wvxnlZ8AgX?=
 =?us-ascii?Q?RKsQ9IhbscP/6/cRBZQfDerQrOQLVMVMqcRx0cZRUl3/gr1l9iS8O0pfecIb?=
 =?us-ascii?Q?lG33WsTLlE+4AndbXAXzgeZ9rVXyOm0Rc6faWvAk55me1xXN1VSY7uaLbGE5?=
 =?us-ascii?Q?Qqiw2XWjyA7yf2g9/jNZiGNchqKgd/o05iD8r4KWAexeC4865mRK/FQ47O/x?=
 =?us-ascii?Q?Qf3BcyHMJGmyYdsOLOjUGlUCzQtDfF2Q1kFpti5j9DBm9N1eMKaiQmgnKUJK?=
 =?us-ascii?Q?dvEZRjqOP3fMk+lqL5XQPMN8qoCk0Bv+TYoYveaHRyZ7vdGzKzYUpu0EGwpX?=
 =?us-ascii?Q?QChe78OWgZix4lCiCpqfvF+1YP4vYUMCaNs63ANdGm0CiksNrEqNoyrp3voC?=
 =?us-ascii?Q?1akBrVO1cBqEbAMjcZOvDZaNGBTD74VKvGum1JCndy4/Jpcnu3uL5t9lWxt2?=
 =?us-ascii?Q?tc/ZSE/nS7GYBxmVPD89xzNTV+XVb9Kz05uw+NzBDxhNP1htPTFyfGLiJVYS?=
 =?us-ascii?Q?dGJeAUmYIuLQHT9OLKe61JX5IDxjcwIDWH0VBqi0aVLNyPZIJJ7PoF5lrJ/F?=
 =?us-ascii?Q?zN6RZ1tRuO4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TqTNYYCfjnFbqhXLmPmlzJyaY7oEVfdyX6GYvCKuQIUnkNk2ezygrnJQRxwb?=
 =?us-ascii?Q?mYcTYuaBSsLByGucIRfn6FzIKojHX0qx9myfLZnd7zrfOH51Z3qfxiopbWBQ?=
 =?us-ascii?Q?LJSyt5M6PUDrNXIptVHZMhKxlxIHlck6/ku+efjeAqTau1OcSFgnlEVr0v17?=
 =?us-ascii?Q?jefrEod1pEo4/73ZJzxWleXaezh9tT98AK4ZLgeDK7d5wJnaW6+OPayoumBs?=
 =?us-ascii?Q?baFXXp24SZJSG1gFH56LOhVDEUxA/wLmn9GMg/sAtUAm/TG/l6S2MeJ32DZ3?=
 =?us-ascii?Q?LDNa7e5toLjwz7BQjBtTInnqIqYQyTnFOxKx8Eg0V58VTTcD7u6pQ3YzdV+b?=
 =?us-ascii?Q?EyBRnGSoAbzzgmmsGpSVHVHYFBw64lOFwoz62GPhWFheNZ4JZyTee/D5mFGy?=
 =?us-ascii?Q?5qDfxp21D46XA/xRIjf5go1VyMxM7P6UcuFO4e+yPKT0Mu0uiwnqiT+OnS/d?=
 =?us-ascii?Q?f5KsWhxpUOlJxmeq4573OAd+S95c+nl5uCQQLyinrM4JXIf/9Zc8phbjCyut?=
 =?us-ascii?Q?nW1r2NvBZVwz/rc0VftYMCLmMkAlA8340r/o3ckjX7eOAcTCkDfIY6hvbcwW?=
 =?us-ascii?Q?QSMTjokc1chquhyG5SGkO9mEoen6FkEQ2CCAIqZJtaNWegkifHWzIBmp9NFh?=
 =?us-ascii?Q?6W5aVciji9dTBWnGcP1VXwXMCAR49Fp5Uu7FYv3K92rJUKK4y89aaGWPAlRF?=
 =?us-ascii?Q?mWVYwSgURBagxiLYW7SF1epgzSIGdzfBRIP+KPYdFlG5zekMUhTiZC9z3BZU?=
 =?us-ascii?Q?4C4hST9EvKceETvlUxDHpP0hM5xsAy/HnxshknqsMRy3+7xM9TMLpzb50MkW?=
 =?us-ascii?Q?BuNrWbNZp/usDuLR0zVjgi+5/60E05CQNXXfH56iG//H29YoSwdcXlleEZea?=
 =?us-ascii?Q?Q3Wpmtfou1zrtq6hUUDpGrk7ORJsgydPVWtq+jHKD8gCqYkAb8Pymavv9+R/?=
 =?us-ascii?Q?iyZnYgv/jTKUdPZeI5npsckN+GC8Bh/E9yByONw7/Vse3/j6GZRp1GUoKdWH?=
 =?us-ascii?Q?GXM1NgvkWO41w4RR6bTiqhSq9nmPV95WYN+wluzOYIaM1UeCJlPs2waOjA/7?=
 =?us-ascii?Q?5FZkcH7jQY3xhzj7a3BNIIDoav76ijKMp0VXSLKsrINapdRCag6R2+q5lAqV?=
 =?us-ascii?Q?30u51TLa7OOr1qN0V5vim9idUJXFJLZdSWkCN57cnT1ViGS+Q0nZ+DDNvf2b?=
 =?us-ascii?Q?hmjPzdUZRzaQKIMgcIwYEg/0WBtBaHDJyBt0zvcVu4OGvyvsdkJTC5XAkfbE?=
 =?us-ascii?Q?2K4J4EC2lGLSdu9vqG8r0quZLE9t7L0oWoAnQZ7Kii7bf6Wf9kBSiUaX9byu?=
 =?us-ascii?Q?/7B845ZEYKlpRv1SiQOevKDc6Tnm1bebxc94Cd3NZzuCgMtFzSAqULZdWB2D?=
 =?us-ascii?Q?Nyolcfhplp6vdpNZMQZ5ff44hcJEb+R2oHp4dQxeCygJb6pRKnb7u+ZLzPqt?=
 =?us-ascii?Q?De2xb+NizevicV+ib/LEsuiDYd+b+PxQli39lEUSUdMLAHMk2ALL9hukNmJm?=
 =?us-ascii?Q?gp/LcA2wFQfBSAMI0XHwmW1BK6MSDhw+0ooLc1qZAL7yNGZMzTYToLhMIQ5P?=
 =?us-ascii?Q?woVCJJsw9H5mbvmD6zRBnhoJfReyZpkhY2LSm6Y6jdY0TL1ZgT41G43yBstJ?=
 =?us-ascii?Q?Ew=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe8f318-5910-4918-8a09-08ddc4a189e3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 19:47:04.2434 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m5EtxfvQFCk8M2JVgYiBfh1UXzGVC0xOAFlE0MFrABLOY8R+2i8ug5iFB4RnUSdkHf4YBrX7hGvOTtBfQPjubaRSUWTciKPiZ9/M/88+pJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6313
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

On Wed, Jul 16, 2025 at 03:24:55PM -0400, Dean Marx wrote:
> I've created a list of test cases which I'm planning on implementing
> in future QinQ testing. After talking with Bruce about some Intel test
> results earlier, I've got a solid idea of what the expected behaviors
> are in five of these, but I'm unsure about the other three. If anyone
> is able to provide some insight as to what they believe these expected
> behaviors should be, please let me know as it would be immensely
> helpful. Thanks!
> 
> Vlan Strip ON and QinQ Strip OFF:
> 1. Single VLAN:
>     Expected result: VLAN Stripped
> 2. Double VLAN:
>     Expected result: Should strip outer VLAN
> 3. Single 0x88a8 tag only:
>     Expected result: 0x88a8 tag stripped
> 4. Single VLAN + 1 0x88a8 tag:
>     Expected result: 0x88a8 tag stripped, inner VLAN untouched

Technically, the result goes for the test case of "0x88a8 tag +
Single VLAN", since the 88a8 tag is first. :-)
The "Single VLAN + 0x88a8 Tag" would be a 5th test case if you
want to try it. Expected result should be again that outer tag is stripped.

As for the expected results you quote, those may or may not be expected
depending on whether hardware supports multiple VLAN tag eth-types or
configurable VLAN tag eth-types. From my testing, in at least some of our
NICs by default, they ONLY strip VLAN tags if they have a 0x8100 tag.
However, I would be surprised if that is not configurable.

> 
> Vlan Strip ON and QinQ Strip ON:
> 1. Single VLAN:
>     Expected result: VLAN stripped
> 2. Double VLAN:
>     Expected result: Unknown (Outer VLAN stripped?)
> 3. Single 0x88a8 tag only:
>     Expected result: Unknown (0x88a8 tag stripped?)
> 4. Single VLAN + 1 0x88a8 tag:
>     Expected result: Unknown (0x88a8 tag stripped and VLAN tag stripped?)

Again, the expected result would likely depend on what are configured
ethtypes for recognised VLANs.

/Bruce
