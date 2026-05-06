Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F94CD3445
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 16:21:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92B52402B9;
	Wed,  6 May 2026 18:21:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id CF59C40278;
 Wed,  6 May 2026 18:21:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778084513; x=1809620513;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=tGgF0FyvLQ88piiaxvwf8m1+pFkkhebPe4gKl/NYOFc=;
 b=lvh1Y3lPnR0Et8sLzRB0abCsdKscd8QRs8xYmMQk4puqiqjkzwxyF9OB
 YObobYwtlunl1IA7wvRzEBYQbfEHScd2xMBO4fduuD4weQNBDJUs39Xqo
 YhDabhLgxUwOzzW6/IKsrEGqssybMlQ7nut8bKkc1+bMMWtQaYIJpJKgi
 bpetteQHaSepXGgVtSBLmoiInM7gB6UAlH1/E/J+NfcizmE6SS7oi2non
 yM8zxNkbZDjDnCv96jthiCa0MwDkDKLT2k+LVvkw86n9qIN04lOr1UCN7
 mI6t8iuyZpBqOIS9Omgpxtmr2c7Uud933sthI/gyqn/BNql3HNz0y/pKp w==;
X-CSE-ConnectionGUID: MRnE8oztRXaecN29kj4jtg==
X-CSE-MsgGUID: HT+axJLsTlWPm9BWAwb5RQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="82643928"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; d="scan'208";a="82643928"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 09:21:52 -0700
X-CSE-ConnectionGUID: rLpZIrMaR1yd4NxeT4aTqA==
X-CSE-MsgGUID: ggFD7T+8QZiHiw5ctHh3XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; d="scan'208";a="241191294"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 09:21:52 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 09:21:51 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 6 May 2026 09:21:51 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.5) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 09:21:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XH5jLVN7Kg1tzfBYs91eG90honHnETdt4vxomMDqPjdLHXWC1wQgn6u3ad/YaCvw/xM2nDRrFJbYlP8uAGCmF9UB6aU7S0lZdseqJjxrn+cQUvrG3ACLVDXurGht6ZeYMbAqtUstVSYoTsDw7idHiMGUaRjFVHzhKB7V6gdo1kjGrfiopJ+ZNxmxjlm0Ak10BiHpTs3RqZvL9yu1n+YhbS998URTKPgWFJmeb8P3qJkN0wCbXb+YCctiyFo+kaSMivLuwMhX8QDMD/Elj3twLTjCLhskwVT1UXW8XhV8nFCApN4vxI6aKznbv79i9emvj5FL/wBpiF82atmkUJrVKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkGxKwODHV2iZzE7UFM5tkI9NBCfpZzqH+IJa1fVTP8=;
 b=Mz5/CX0X866610Zege2fNru8fL4Ms/ZNlkQJxI/lljvoWkV3+0pNmYHR3usMHKF3v0BRKjlGlU1F6iADGccph6FCTtf4EvZ7s5uRoeW09BzmzFTV4hOkg+M0WKhXjJLSTZyHlBSajvGR9WXiFK4D+ZUaetICuDqzEXwul/1gmYV/oiDlWcCjh311Swt5VsL35ci9BZAHsUYYHNGQ3PxaZ1iGrWDBzclnUeMi2NUE3/RaCKdNQzCRHQc8Oon9PFFCg/m01ihkYbxFkE5OrV0shJuRp2ICVpnKODUaoesj/Pxkf7OMfNWw7XBvKf7QunGdAnHByRSwEkmN06BCjaV+qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB5173.namprd11.prod.outlook.com (2603:10b6:510:39::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 16:21:44 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9891.015; Wed, 6 May 2026
 16:21:43 +0000
Date: Wed, 6 May 2026 17:21:38 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Daniil Iskhakov <dish@amicon.ru>
CC: Anatoly Burakov <anatoly.burakov@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, <dev@dpdk.org>, <stable@dpdk.org>,
 <sdl.dpdk@linuxtesting.org>, <rrv@amicon.ru>
Subject: Re: [PATCH] net/ixgbe: fix good octets CRC adjustment
Message-ID: <aftqkphZkWfURJBK@bricha3-mobl1.ger.corp.intel.com>
References: <20260504141524.114604-1-dish@amicon.ru>
 <aftpgK7oMYufLKK8@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aftpgK7oMYufLKK8@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DUZPR01CA0302.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB5173:EE_
X-MS-Office365-Filtering-Correlation-Id: 60d5adf6-b001-4bf7-0ab1-08deab8b8fe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: fAdx+cLXE0HYNxcXlHUj2e3l6kVphw5DMlGeFPjnGL3xjaG1QgwhIFyv9XmgZyhDCNFDTATgizo7Gh1mY4MyPZkEkhSfq6x1i+JR40sk3BkFwqd9LMx1zdaGBLgHHbLNAeDO/3zo4Qyg1kE01myU8EY8TF8jrCsqeystq8kX62mpbWdKcAtulFlrbn1p+8RZEOsfde873iPBNL+XhnoH4oQ2XUDkP6pfVV45JpuKSOXJNTFmVSQtUrCXReAQLq0JQ0WPZ8hf7SkbJ9Tx3XLdgKMKKAaqcyXAHmCcJYbtN7zJSzrm6IvyBohygdP9s3zjvL27+kbjMAx1hAdEq7ZxkLsoVzeN4bDYzJ/vCsRGAHtIfrc/BPolfK6vjLn27lRbi2gAHhd9c+VVwNdSJKImeeUcTru2hqFwXJRB5P0VyJwFkWt6u4iIoh56/LO0s00rHWQjn6FEla9PfShNZqRwKKqLLhCfYh6Iv+VGYKkS/fP9qHfJVU7DqKyVpGtWIvqFPulW/Thy2NMsQdvbs05CqrweJGJTZjeFwSv/YqUI0sWkHesc5lNzHL8G3NVQ21B/qKBuBqnjaKZktOSr8NtyOsxTrEcaQyxatsj2VTH0o9RGgrCFjK7kqCKqtRW3jYEzxT8KZ/ntb8vLOjc1APL8NDocuCjg4Eg4dryCqUnnB2C0iKEYafr3xsV2QCGYMGLk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hEYmfIr8m2+JmS5Hf2vj+1eng9RKm4BwG0tU+2f0eHQsQSXMGBfTEGyRLcdZ?=
 =?us-ascii?Q?PgtyR7QMoUhmFRsA2vx3L6Qe+B6fx8z46KgDnesf1pC2CtHH7HneohFqvse4?=
 =?us-ascii?Q?bq0YqRHsENCEqdEMpKzSL9seatNEsw7BYesjh4DHqaupkxZt9om/7TBozPvo?=
 =?us-ascii?Q?q5pPsBI4TsAwOpDJoqswMEY7KI+mLkofumgzT0ibkl8k7W6sA0Vch2kltVKH?=
 =?us-ascii?Q?KON1SlJH9mMLn7LxD1Ly1VV8TzPtHmA+WpgQlSWauqUE96dAgRDVKDTVsYQ6?=
 =?us-ascii?Q?NGooL9q8hfW7QubHXBplubr7zqQobUNCxnlVhyerE85RaEOPt26h+jo1SdbO?=
 =?us-ascii?Q?UBcHZqqZHxK9W9ZqkrZKTAEWYebXzMAreF9lJGG8aAmaNBmL4YPgTrg7lwre?=
 =?us-ascii?Q?zaRJ5NL5dI5OUx0p1NFZASN8ZgIwxnMH9dbTVzsGp927wD/mwxFr97ATjY15?=
 =?us-ascii?Q?sv+Qkm9H8ymuN0wIhuwjO0yrwl4NXRPqyNPNUYYlJRc4r5CF1u/XrF75l4RC?=
 =?us-ascii?Q?LfqJpcLshtIb1Ms2N6DkpT86jzNgp84LDSRvh7yAvOnFh2/oXAAJ7A7Wa0cj?=
 =?us-ascii?Q?Zz7Hc97ybrh6LKrIDlk7pdzq8MbRwcU1wfe+zNSdxwpMjlbIsm8Rit87fLmu?=
 =?us-ascii?Q?72Dykh+guAcxwRKPr/s0p0l9nA1Xw3SWIU6/wqen95sjn5s5pjdr/QodFUDl?=
 =?us-ascii?Q?alkymsRALpTPDwO8U4Gv+mNVtq8dIr69nBFaUwnYH/RItxcZQ5WFq6l8Q6Xc?=
 =?us-ascii?Q?fbJqcQSFRGm7zYEuz8TqTq231oBOvtXoEm7eO4Rx2ub2C9xOmkYMz9xGJf1i?=
 =?us-ascii?Q?tLTfZCxdaWWTa6FC7bmi+XUKCckt9YSzWg8zkJ13WEUhdhk0BaCkBRX/Li4M?=
 =?us-ascii?Q?nGilcT7dZAgRxUQQN4h4b7bUtTm61yl4FaA6ujifNwRCPAvMQx7IH+M3HQUD?=
 =?us-ascii?Q?oRHDStRcgyW8jhFj4wp/rK1qMX6Vi7LKpILWhEHzFDjZJqIcVCXfnr1c+Z5/?=
 =?us-ascii?Q?SHT/5nH327W7EBoZtE5zxfYHqmNeQR8GbaP3gmqq0L250DmlORnNQ2gaMi9H?=
 =?us-ascii?Q?yrjbSmq6g6jNMXbwSSFNYqFtPj8oktZzCn3wSJiqpuh5/RoLcvjyhJ3B8GRx?=
 =?us-ascii?Q?fPhQx5FdZaVnWnyA1uHMHnjWwviICPDp5itcaEooSqrNshUyq2ldQtSRV7Zx?=
 =?us-ascii?Q?Sxi9K52miRIvKx8JjzcsLSwGG76NAmqyTEktAa7KyV0r5HtxXIK32zUL7O+0?=
 =?us-ascii?Q?+/8qrUO2aP/InLiayHxK2141X8+/w5ELjwlUV2EgdFVsTdcqqahD3PJcn0Uv?=
 =?us-ascii?Q?Y7DS2y3kNb2cfykUeg2ogtWrU5bY33ROl3MZ6kFOm8w/eLAkAeztZAsdW9MF?=
 =?us-ascii?Q?c3jjcjoTJBrdgsT43P2vXQ8HbU4h3GOJPRcLX+14ORoChzKwIyQnHP2SWRdE?=
 =?us-ascii?Q?6YePR+ryXPlEcPb4T8NG7jdebWx5gIGYc9o0Ps5vMiHTDdM1V02GyA6K+6mQ?=
 =?us-ascii?Q?Qkvi7A/S2AQg1kYeKb9tBz8iOCaXxCOx169aTnyuWhEEMjishBNdUcyGt+IO?=
 =?us-ascii?Q?gIYBikwLqjP6nV+O1xzoDaW90Dayg18fW9ezjP7OwbqEnEfcV3gUdZb1gsxI?=
 =?us-ascii?Q?12mYwL+hOye02yPz0EQKyA75vR/KuJ1wrJsYhNaTzfuTLE3y6/KQBh4qOx1s?=
 =?us-ascii?Q?qrEuTK7Bx4I2RZyi4TJ2zmvJ7YlJRyQ3/Lu0dXP28mJAGDptwDRCordR4kme?=
 =?us-ascii?Q?zmY5UyGC+E7gON9PQx8KWgRHiFYQ5Ms=3D?=
X-Exchange-RoutingPolicyChecked: boHv5EYc6Luox+DB2vTKb974m8dAXmvUcppKbLwKf9G9WpkfY/WPK3xLE9K830UgyJ0B7I9MUtn4CO1XqKYj072vEF3qu+cEdTCrBpholSyqPLWEq1XhUQUP7Bjmpy7ySKMvaGCrpm8J9EdpkS0wvTEAbpPEej3cYxrKlLptiFM66/xZEm+df7SX4KAYg86twhXV17Wui6UkZ1KVjUPjTgZVqgzLwzkwXPB6G8WxIfIoRFdKRISlzvwNB7yExftKJqgJQG1FmcqchoU8HIyHbDwQrn3FmYsppcdHF6W/V5Cmsiz4JxTe5y/GZHj61iFyKknQCbBV/dd+0HlMniUh3g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d5adf6-b001-4bf7-0ab1-08deab8b8fe4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 16:21:43.8224 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iDTe5VGKpw1IJJJQi/z8AvSk7bQ3g7dAWTpkhHrjO9QIg1c6mwNjVhCc+0icki5Xu6Km5BUsx1ZuVnQHuJcUrqJM18RVCiM/IAOeCZ2AeP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5173
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

On Wed, May 06, 2026 at 05:17:04PM +0100, Bruce Richardson wrote:
> On Mon, May 04, 2026 at 05:15:24PM +0300, Daniil Iskhakov wrote:
> > On some devices, such as 82599, GORC is a 36-bit clear-on-read counter,
> > while GPRC is a 32-bit clear-on-read counter.
> > ixgbe_read_stats_registers() accumulates GORC in a 64-bit software
> > counter and, when CRC stripping is disabled, subtracts the CRC bytes
> > accounted for each received packet.
> > 
> > The driver does not read GPRC directly. Due to an erratum, it derives
> > the good packet delta from the sum of per-queue packet receives instead.
> > The 32-bit QPRC registers are used for this purpose.
> > 
> > delta_gprc is used as an accumulator for those per-queue deltas and is
> > then used to compute the CRC-byte adjustment. Keeping it 32-bit may wrap
> > the accumulated packet delta before it is used to adjust the 64-bit GORC
> > counter.
> > 
> > Make delta_gprc 64-bit so the accumulated packet delta and the CRC-byte
> > adjustment are computed without 32-bit overflow.
> > 
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > 
> > Fixes: c03fcee9abbd ("ixgbe: remove CRC size from byte counters")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Daniil Iskhakov <dish@amicon.ru>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.
Thanks,
/Bruce
