Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74204C88E4C
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 10:18:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3FF640269;
	Fri, 11 Sep 2026 12:18:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 2EF9740264
 for <dev@dpdk.org>; Fri, 11 Sep 2026 12:18:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789121916; x=1820657916;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=oOwV6P4Ap+al41AGupyRA3ba9wQWAvGoIEnlwVHhbsA=;
 b=QyuT/z8+o67hxUpQdL18KhRHQR2tdLMNACk49QEWuqHycOusYfJGOc3/
 ueFKx9riopCJHjxXEWx/um8mp6sSkgWwtYMvQY4C5FFeLOYk8sk4OezVS
 PjZEf0qPvzPCO1CLaDQyVbfjSw+KbFRCCfwHAlZQH4qpld3FfjCGhKlQY
 X9Rkal4GVIkeC5a8MPtv4CAG5Ck9YPEPSHlfvaf9/n0xXa0C63IpzaX8s
 +l00SDo9s9N+1ajbD6+aQw3i7reKPYIw8bo7y45ZT8mU4PjbnQIwfPpRk
 y7slHpkvYZ4Tg/9it4KkP36az1QFL6K2ikwSWfkSmVoE62j5SADXtrSIQ Q==;
X-CSE-ConnectionGUID: dhZIlsvFTHyPfWz3BsNErA==
X-CSE-MsgGUID: LzuFwxXWQ8W2QcnDTJT1LA==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89348577"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="89348577"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 03:18:34 -0700
X-CSE-ConnectionGUID: 6JhG0T3FQ7q2vuEZvf6j3g==
X-CSE-MsgGUID: fZXwwTNOR46cDPJ13/GaXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="310141172"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 03:18:34 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 03:18:33 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 03:18:33 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.31) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 03:18:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lr1E6rba/F8oW1UEbN8PnCZlVRy4+P8OPVYG/eoh3vFLz8ZhiIfQ2THgHgjJ8YjTbSwHwr5bidI6ZgjQ1tlMoHUjGaguyofZQ5++wgkwPwazLq/6cjXLv1JPZZ3vVWGWJH/BCcpIXtRtP7ROApVCKrbtEx8F06xVg9rxBlEC+9mK+oOhn2ofXXfRiG9hgqhTPJs0X8gqSI0WhboHptlsJAQ6nWHRl9LZ4pZUjTdjVGXh5FeNxDb3+XZrLF/qtSnbP7oxaiRrviJnGk1kSI+rj5jbz8EAIYW6GdsNgd7q78wtUnnJZIAeqqXh2iZ0vhFiwkn0EbaG0QPFfE8Qdl4c+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wJYywjmxP/OCkQw33JM+/UaRm7algn7lzPx9dh4O6U=;
 b=sG7j3LMTLgBmt2NxhCM/YpN1KLe5YRPoc57AIbBSQPha3L1s4Ehel+LFtXhY+iye25M5V4rD2F+kDS/nkcsY9YMzdx0um4c6BT24H7TLpGU9coRS/+YJK3Pwkfmt6+a3RfjO4t5NXIC6RhIVH42nSl6gx3IvCJOuop1g/NvoIh8nzVz6GJM1BuBLe75wtq6u0ctfPU36wl5rTocjIAxUaJxU4bolR+OQ2fhOt7Ew55N+Yq1qGyKmpyAjDLcAwWZcs2NStC3KU4y2iuPfnPSTJ+pL7YUQAlFRAxWD4d14AEdyNMZyGmsdymD9tEKdqiM/nk0aW6Bi3/ZG3KTWnaiXAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DSWPR11MB9692.namprd11.prod.outlook.com (2603:10b6:8:353::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 10:18:25 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 10:18:25 +0000
Date: Fri, 11 Sep 2026 11:18:20 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 00/68] reduce use of rte_memcpy
Message-ID: <aqPVbJj8uwNagJ9-@bricha3-mobl1.ger.corp.intel.com>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
 <aqPSjAonmnLRwr5-@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aqPSjAonmnLRwr5-@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DB9PR01CA0026.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::31) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DSWPR11MB9692:EE_
X-MS-Office365-Filtering-Correlation-Id: b3b56a83-0dd8-49d5-8ce1-08df0fee03da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|11063799006|56012099006|6133799003|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Bvtdz5e0hghiuGiZmiUUPurxMssUZnWU4IYbi2VwiRyqkqCj6ArMnKd6R/R2rvYUz7mRu2mCK4fdjUQGqKo4u9vnsT2Cr2sVAygPhD4qrmm4JDutCkgbbUEOkINCz7dmd2jlFyvsa55hZoeDktucOzBdZHYD0eDOMQI4enBFj+On/XsgZEwpaHcQcmppjoX5VkZofH7CMkjWwvl7b1y9cn9b2fLQu/IlV3efS8J4ZI9i4Pm4XEnrVx6GOZRWU5xRB59H3BUmJqbLOpaKFrKIrETYm06Lu7ResCARQ06e8w7O5Yo2rI/E3vZuMjdB2cuCbzDrhn8UsyyTE0WC3MwGbN2w0ycYDPbAng/gjp1N95QooXT4mhICGcYNLVar6wgbCZ24gtHAP9xMTbAa7yA4uBVMu1XZZoPExYEB7nSiSP9k6urBkkfhzHSf7SDe18nxW/fP3cvpq5zDMlyxauq0uUMjfkNjdtlxXQXBSrgun1JQbO0adH8tiJ5p7lSFkabqSff0zOTguIC6vrrxx5wVDNkqMEyGRKc9RLTH0IPf4DzFuS/B5lbLUKBNQ+H3YQadqwykMQkKGlM79sDXG7IU6XBJDhMjP0hTy7YcOHo64LhPOVQHg4weeUrBMCtoWVZsABoN8oN9Rpd5XZUE43AMCIz1eD8IIcGlgg9qgNcTZ+Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(56012099006)(6133799003)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IwgRcM+2Sdeh0PxdCvw+Y5PbQ4rQB8NvXpRW7aZQ10ndWxsAHmtE8PkP0T6r?=
 =?us-ascii?Q?+hw0i6Z5PovmmOnzqsJ4bjZefDfGVNUx2kf0Fv2OkOadta4MjtRR+dP4SohJ?=
 =?us-ascii?Q?a6oV48atNAsSArDyzr3Hu7iimrd9WBKN/w+okWVg4aAlNQlveon0i4PIA21i?=
 =?us-ascii?Q?AwJQEVgZGzQTnykrFTX+WD7RYDjwgplEC0huyTLeWKM2vjLMvLLcufh5YMA1?=
 =?us-ascii?Q?uFlvNQZ22v0TseTgtoLRLojXuHutYbGYmiWO12cRkKH/zHqBLXvhqSsShnd3?=
 =?us-ascii?Q?ru3cRK2QoHbMHf3n+j0bcUWK7piZmwYoRl6amoHbIT1COsuONrgzbOXLqqoa?=
 =?us-ascii?Q?2rogirGL24oZ/fbP0V0t1PIC1HTO/ZtBa4+alng0kX5DE5uWyo70vwjnLR6b?=
 =?us-ascii?Q?u7lRswGkbkFprZQ9V0qVBUYwFSADX+Dd42Zy2nZ++wmQ2XlUOTfRhn83d0hN?=
 =?us-ascii?Q?viJW5cjiZYcxM67p3nGsePVom9abuvilbiZ4JXTyYm6B638xlllvBgvRhrEj?=
 =?us-ascii?Q?OO/9MvidnOHcTxKN8lYwR91FCcM+1rmuKJc5s5xtH5Jj0q/xytBkhb5/Pxul?=
 =?us-ascii?Q?HlC739kPaNDE1DEctdNKoRPJ2u81/+6Qch/BKh0UUWvqxtUncy8RAjPGiuK5?=
 =?us-ascii?Q?f9rHNjttSyRAf6YSkf8UPqWiHWJHONyn4xhAizmrFmYrdOdZKq9j6FZtUXAL?=
 =?us-ascii?Q?Q7ZslxZcwQjqfNp5yv6WZuuPPUpc15HPQv2ZBdOQYB++EIRmahM6By1n3R4x?=
 =?us-ascii?Q?99yJY6L4pk//JxJswYDcIQohhG9bLCkGUuSx4MIaDsSp6NpMsTIuqHIY/wrm?=
 =?us-ascii?Q?NXMcf4yjIc6AYFSj2hX2gclgA0HPshKnFE8WB2x0HIr52fj3dFTltlWd37yw?=
 =?us-ascii?Q?OnD2/c/JUkzXrYhUaIXtw97Fef9rWNa7VmjHuCkB0Hic+QrV6bR4lACFHdoR?=
 =?us-ascii?Q?/3m6cba+9vSsr+sNfy6L9XAmztVys2LOa8O3DyJ1fIUKomoDeDYm02Q8OQQw?=
 =?us-ascii?Q?6mQdgInRRsZdnzkD9Ray3Sb9WRmKwjvrnZvSRMLg1jqVkfwmnuUzR/VF/QW7?=
 =?us-ascii?Q?/c6W0hFulvNx5QJNTczduBp1iYe0UcRN7tAAYX0/wQ+1WnrxOvg9i73F+gmN?=
 =?us-ascii?Q?dn91hXMTqNHSUvYqebesYqtCQ0NGcbYdwiuXYZD08wdT09SJ9YQ2HPyYPmTI?=
 =?us-ascii?Q?fwMTXW5LoWiBO1OwuCGWaT/aTZsunfuWjVt4K4K5rf69UBu2omxmOwsjs0Ti?=
 =?us-ascii?Q?BT2wdvB81+AzoTnqMFCzzdgiV+DUbXJcYG5M0LcPrb9yiaV+Lb7HrQxaQcuq?=
 =?us-ascii?Q?FZZEQ/GfEennggPHZAELcg83QXr1wwedmR17kX6WOgrVYSr3iV9iETTY1X1t?=
 =?us-ascii?Q?j9dqlyRbQCG87grlufvrWLB3JPbnLei32+lLwKFvnI2yRMhRzrt6rByWKHbm?=
 =?us-ascii?Q?2wFDYohJF0NGqeyzwXuevo4sOyovUl3dbdXT17rv+y7xBW7yaWm5h8D+cCy0?=
 =?us-ascii?Q?VUzCwL0AFBfa1LAP+ywW2UwM101fHrWmCnSben/2ds88Yqvq2S1qyQqhnImR?=
 =?us-ascii?Q?K2jj5b5kSSgD3OcGzjPr8wW2Ec4IQSJ5ahseOde8Qv6zT5PUq3Ds5R8QR/mh?=
 =?us-ascii?Q?uyAVdwAiSGOrU36A5qfcpa4B+rQjHxXVkIEIpLyfLIY2/3PhQGcDLSoojIvT?=
 =?us-ascii?Q?835hAlVxSDWPPUFMsV87WPDgGtzsgr1AFYi7iOE7liFUFZCrAA2GbuNytQce?=
 =?us-ascii?Q?Z+jtH7qrAuVrcFy02/T13wboTmBRtJI=3D?=
X-Exchange-RoutingPolicyChecked: QWHA1wUT/rv/udx5VFeI/dEsIekKXnIbKlZePuoJpAOf/9zmquucHXN4r3TPfC8R0HsoVW7im4In2MQQImW6MOusIcHKF9eFAR7gP3JXEiTgXX8zamZwnWcqwpcZoJ+NVyMpojyBxuTyG9jcSxcEnauplWrOPaVW1sMID+keLR8ZfcaFMhxLZOSPghqhHRdr650+h5ibhkQenJQSZBFHIXiVWpvmJCwaQO3FluMk0PVKIWEZWYsH2G/L9fl2x2169Zh5SX4j6cNG+aGAxAtdOV68abybsErX5a6t3Lb/88Ix87X5EAo6XZ1o2w6yV/LgrkHpBQh2V17YL8q5Xj+ecg==
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b56a83-0dd8-49d5-8ce1-08df0fee03da
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 10:18:25.3701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k2Bx4ciW0ZFuHDKQCgx8WpCcdX5pnFiL0t9OjVqdOTtmSVBNERSi0r7Eeb0cQDC9xpZKxO4XAYRVzYk1snAV6r3dKB3sz37pR/gq/lmJWTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9692
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

On Fri, Sep 11, 2026 at 11:06:04AM +0100, Bruce Richardson wrote:
> On Fri, Aug 21, 2026 at 12:23:55PM -0700, Stephen Hemminger wrote:
> > The DPDK function rte_memcpy() only exists as an optimization
> > for shortcomings in performance of libc memcpy() on some platforms.
> > Many platforms have no special rte_memcpy() and just use memcpy().
> > 
> > But many analysis and test tools know that memcpy() is a special
> > case and check for overwrite, bounds errors etc. Therefore memcpy()
> > should be preferred where ever possible.
> > 
> > This patch series introduces a coccinelle script to find
> > calls to rte_memcpy() where size is fixed, and change them to
> > regular memcpy(). Many of the patch series is just the results
> > of that script.
> > 
> > There is also some cleanups to include rte_memcpy.h where it
> > was not being done before; the include was happening by some other header.
> > And also removal of rte_memcpy.h where no longer needed.
> > 
> > The result is a 45% reduction in use of rte_memcpy (1008 call
> > sites down to 551). The leftover cases are places where rte_memcpy
> > is used in data path; and test code for rte_memcpy.
> > 
> > v2:
> >   - reorder the series so it bisects cleanly: the patches adding
> >     the missing includes of rte_memcpy.h now come first, before
> >     any patch that removes an include or replaces a call. In v1
> >     those were at the end of the series, so intermediate commits
> >     could fail to build.
> >   - move the documentation patch describing when to use
> >     rte_memcpy() to the front of the series, so the rationale for
> >     the rest of the changes is established first.
> > 
> 
> I like this series, and the rework of the order in v2 is ok, but I actually
> think the patchset should be split - at least into 2, if not more.
> 
> The patches removing the unnecessary include of rte_memcpy from C files
> should be split out into a separate patchset. There are a number of these
> in the series, and many have an incorrect patch title and description, a
> couple of which I flagged (I was working backward through the patchset -
> don't ask why, cos I don't know!). That patchset is a trivial review and
> merge case, since if it builds it's fine.
> 
> That then cuts down the rest of the set by a bit, making it more trackable.
						s/trackable/tractable/
> If possible, I'd actually like to see another patchset separated out to
> cover the case where you replace all constant-sized rte_memcpy calls, which
> use sizeof, with regular memcpy. Having all patches doing the same thing
> again makes it trivial to review and ack.
> 
Further suggestion - can you just do up a 2 patch set with the cocci script
as patch 1, and a single replacement patch from running it as patch 2 (or
one patch per app/lib/drivers/...)?
