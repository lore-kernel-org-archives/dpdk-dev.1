Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB63E9A02D
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 18:00:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E171740261;
	Tue, 17 Feb 2026 19:00:02 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 1F868400EF;
 Tue, 17 Feb 2026 19:00:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771351202; x=1802887202;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=MLO5K7NHz4GG2mPZGtZ+mnlkKZ6VMLcou5hjVVQvqlU=;
 b=QTyn8RKLZq2/4co4gBeLEKaed5jVegqjqLs/pgGmiMEnrbV5GSHBA33V
 InTT32lqxkeH75wVkBY6zBLf4lpPcP//bKcei/toXLcV4G6/leD9sB5Y3
 Lr1Vu/gw6gli20jjiJRm6GEwewkKhqXhLZP09UdHr8rE+SvMMoE+Dw4Fm
 AYAjGf6DtsqWVSXqdT0lJYkjRnhM6yp5iiWoJI/M1QntNkvH2vFb6U+C2
 Clmgg0n3diT3bDpDo9QEFVWETgQVD0PgcDZqhDtAeVMBkA3RSV+kv5+1q
 OSPyRJ0ERCJ9FuG75a0vxgDD/kiABuP8ZMoE/UbpW9C9TLvXXnUESDdfP w==;
X-CSE-ConnectionGUID: HOctMnOORcSjFhTiGkhRLQ==
X-CSE-MsgGUID: rLCX4pwxTq6qzYgdJ5/5Aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="72473212"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="72473212"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 10:00:00 -0800
X-CSE-ConnectionGUID: J3wQ3iKdQJqJzXpAvQFFnA==
X-CSE-MsgGUID: 806QcEXFS9Kfr4j1Y+oT5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="213196141"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 10:00:00 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 09:59:59 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 17 Feb 2026 09:59:59 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.4) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 09:59:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a1+Hde5+Y7w/w/qIxGC/ZmjJDnVu1EKKFhmsUlYv8udM8gcAZsMjwVbDqeMxy3R0Cgh841A2pKHtsm+oyakqkm47rUyw2ELK6WktLFGzOroQyROVM+pZyKZi6Ih830VcXv9PiWLB0p7KZnAUdKd0KpKQXIJLE6ZN4vpQ8cumw9Yt4azautZWPD2g87mfORI48Ri31WGTvPtgS6tGNB5TJ89+YJuKFPuQLBdRmgAazlu127/zV6xQnNx8qjohUfO+4ZSzpwyJen3m4zUvvBRdwExa4/KeBwsw4VdS8hZAsx/M4/Bb+Mpx3LSohQ18hJLdTAxvM8B63z9x43boN2rggA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=InEx2funSNhNtkreoNLkqlZm3GdMna4x1/3O0Z/JYW8=;
 b=DAyueLzWBJWmfBxIvkRV55eTMEM6GVQzKlN6y3QMyNvSCTTCkyPEYl7BbxlB/sBXwck6yYu/YuTH83gcdQr+SxhLnNBJ9hYd6oeA24V9idbtq00JVREbWlUSH5+3n1vrQn+lS7UXNveCFa9Gb3HzIR/fnnHBkEVmNB4x9dhJtvuH1nhR5utrqB5tRHfLTIbWBllhueNJ1tFkxnnQ2s5tkUhJgjn4MhpjRz4lZFe4n3BBHKccpgMmBVyU2PfoPRdAGUoo72MJQo7OlaXyFA3+mqAresUau5CsuemXHrfKn2I5z232GmxsX4EJ3wUNJDajkjf/P8OjiL7Lm21CrIxSTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA4PR11MB9011.namprd11.prod.outlook.com (2603:10b6:208:56b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Tue, 17 Feb
 2026 17:59:57 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9632.010; Tue, 17 Feb 2026
 17:59:57 +0000
Date: Tue, 17 Feb 2026 17:59:51 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <thierry.herbelot@6wind.com>, <dev@dpdk.org>, <rjarry@redhat.com>,
 <stable@dpdk.org>
Subject: Re: [PATCH] usertools/pmdinfo: fix search for PMD info string
Message-ID: <aZSsl2wcdM6RFDKL@bricha3-mobl1.ger.corp.intel.com>
References: <20260123162104.1854187-1-thierry.herbelot@6wind.com>
 <20260217124844.1458644-1-bruce.richardson@intel.com>
 <CAJFAV8wcc_+6AY2029ZV8=ft9qYmbztStodF88tVXUS_UPPXMw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8wcc_+6AY2029ZV8=ft9qYmbztStodF88tVXUS_UPPXMw@mail.gmail.com>
X-ClientProxiedBy: DB9PR01CA0002.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::7) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA4PR11MB9011:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dfdd58c-50e4-4532-9ccd-08de6e4e5c76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nmxS7BK91mdo/RleXLro9zOJlcWFuddyZJN3yCO2botIdhVnFdViE9A8m8lk?=
 =?us-ascii?Q?b+pacyDFKXD51usiXsDc/gPy0zM6TSgPyd1BnLrop1nmDXs5FE5BuJ332aEQ?=
 =?us-ascii?Q?EhQOwCM3e0N8tjz/NvhcsGyg/u/d49rZzuRo5PVDnlhc0hc+v6xEngGxrUGW?=
 =?us-ascii?Q?1QEYMUkDaAdcOfebDns/ZGqXKkW8TRcflcISEywCuI1TJ8u7Td/dyQBjV5H+?=
 =?us-ascii?Q?ZdTGjcdln8EEDyHOxikFLOp+Q64vtJk64hkmrFsKlaQjSM7cixIbqivFmayy?=
 =?us-ascii?Q?cz3BhKCNnw0rYuNJdx7Qo0Y1Tb3el1FFrioBMmcsU09UldvOR8NAw/bVGyuc?=
 =?us-ascii?Q?+tWg51oh7BIpEH9wsHB6IrkwkjUAP8kOFvT8Ub5rB1bVtDxui0W7CpE0503L?=
 =?us-ascii?Q?men5vtYTW/nkY/dXT2wy5n7HlTrDUpVRCEUqcLkHeyeN/aPCUmGbQVaEbGry?=
 =?us-ascii?Q?gwDdIu58KuvkprLF7yZ32Ojimp/1OCL6BHt3UZW3yhTaehloWuv6O4gse7s0?=
 =?us-ascii?Q?jeOYwOKqUXT2nxepqe0mOQ+6SghfSATesl47e5TjgXQj/1V5Z3xc+LGIUMbH?=
 =?us-ascii?Q?UeVfRGQvz9fQv0KjJ/mqxEI78LVqBdzZ8MIECeWUiHFJtzD48pBo0INryYG7?=
 =?us-ascii?Q?5HQ86pq2D4cQEL2Z2hWnvR0gai1DSjANPYH7pm7tWAw8rxCcpJPRVse4joQh?=
 =?us-ascii?Q?jTJJddzJmi3/4mJk5FBGb9xypkmOSf1WJpTWz444xRU/V3kuYGmlNW1BzZl7?=
 =?us-ascii?Q?SN7P/DAVIlKmBpHkBudldpkxCssXsoX5Qk7/zE6Jxa+X6sV+5bxgtMUjcIWF?=
 =?us-ascii?Q?Tc5cAZWI6jk8rirHGLjP7P1m86vb01TjKiTH3uhYRSQP2Xn7DbvRALeNsgb9?=
 =?us-ascii?Q?/eOkyU6aSJQFusl4WZTC/Fxe+bWfG57vv9AHXyy9ASbS4qFHiVizI0jKyN+N?=
 =?us-ascii?Q?hynZgnMqE1dNzeCx4UPOc2bJSUpnfYBqM4HAHpHtiLpAKOL8LTlUIy3H2efS?=
 =?us-ascii?Q?LrkYxMV2simYTrGqJ2yjwg6nBu3tet3uAF7WJdPLLQHFpw11eje1oCvQQiSb?=
 =?us-ascii?Q?turuEa7fvJXo3ERweLEvuGYbmeRyeM65L8B8dCxUndY0Q6oxKgaDU9SEVTSO?=
 =?us-ascii?Q?9HqEvLXKJjCGM3X8JmEhUilqJifKXnkdaHlB0UKdE4JqScd1CjIdxSIUr+rx?=
 =?us-ascii?Q?r5AZssQrszhFc05P4GvWCx6AWrPOQJQSc/quUyx+tWeBNJu9mQzEVchkEo1s?=
 =?us-ascii?Q?1JHbqtYAjrQKuVjJ/Syz3iNgBLLGwosqXoPhFPkyv2eQUBZZ6hBC76aMGmee?=
 =?us-ascii?Q?bESg5OPmh2wQmbBOckpD9va1HPQgrY6TkHIttrJjuWypM04ct7FEp5rvwf3K?=
 =?us-ascii?Q?pNniWJ0WnOfJQkUJFjkQ6R2kqkF5n2I4Cues+YoB55EVdJudXFs9++y14jnk?=
 =?us-ascii?Q?MAu8nLhQkLQ/5QdTOSrNzfGCEOuTsYxRHygxZ8CE6CuNKUZMwie8qVmpXxpJ?=
 =?us-ascii?Q?JXFpjLUWHkmGfGQzGUVnHs14uIp+wgeVrhl8Nn7xGlCmJncyPAYH0VJTLdqB?=
 =?us-ascii?Q?6R67JVtzdBRX1guv6Wo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wuJEApwI5nJqA5ueIhyjXGuZkVpijsh2O8O4VjpEiFQhbut27xwci6rEJxIL?=
 =?us-ascii?Q?GTRWgP+QfmmusaykobZgvig/0naQJAbYCKIKpgZ2MxAEh4/p4nX57daWw6HV?=
 =?us-ascii?Q?ZZPzOjb6bHnyzaS9SLQ0COegUcFZSBar8b0lDqP2DjcBwfbf8ev0pDDYMxMn?=
 =?us-ascii?Q?qreUChx1joFXuhej2htfwUf1lz8mYIMaDhM9UkVs/BI4QPePTV925HXvlSkF?=
 =?us-ascii?Q?eFOe6HRWGLmxtnQOjI/DJkyUSCZb3A8VRRK03EpCvwkUb5ZBtrfxY7h91aCd?=
 =?us-ascii?Q?MPYc1i3uYz2Kpr2ewPCPteKwM+exn9gW624QbaRzAqJqigSsscqhHmN48ttC?=
 =?us-ascii?Q?BIi9vzJ5Ryj+LnTnwku4/nRAwdWxPsjYwUFV21hgvYsc69/vSYp0JGXmt24q?=
 =?us-ascii?Q?QAFinKXtrUzPLHrYOhDU90IGY/1smQTCa2tsVtpFznnHebK8jXwOPrH8i/sG?=
 =?us-ascii?Q?uAVTjY/Ek4TogJefjdRllLPXWSWgEv9h6Rr61kGrR3b7a1GyDdKow1aVuH6v?=
 =?us-ascii?Q?J2PkhY9YPSFi3M6LwQSLNGIm44S1ZnPQjeqIFJ5N7sSdG/0tDKyzERCa6rPO?=
 =?us-ascii?Q?z2M9ReomcDNfeB1mE5usMgZM80wnCY70oGXCvYf9BZZet/4JU6gOiFczumaZ?=
 =?us-ascii?Q?7ML3LEOUSxN/lJwZA16jy8pq770oeeK/oiSmicWqsmagCP2Quw+2QJdqQ3LR?=
 =?us-ascii?Q?FOG1MXj4LWAnd4jF9VrXikKBz83WmU2Qq6HsgvKb5cxkcDYVeznHc5yc0G5Q?=
 =?us-ascii?Q?XR60MXQznNOrz6/Y6sz8R1iOz4WLD4/k6fF0CgjnncbVnCZkUZWOIxb4eVGw?=
 =?us-ascii?Q?77tGdLlZGedpOJgl1zlt310eXQCUHeenTo2OwpVF2AYL4lJ0zMJAV/EmpU33?=
 =?us-ascii?Q?zrTQ+pwnIR66ujRulzfhWAdxH8WSreAMMbaOw7fUV2cPPtKwjnUpWU3OYAur?=
 =?us-ascii?Q?IBs7CFSzTNVEhsSRQ2XMP/2nyMF9IclNzudLQUavoz/ff/CTHksjsid8GA0R?=
 =?us-ascii?Q?k8dtH2eGlHMOtBe/TnD1+Fl3RZQXYN1sz0vlgKBbdQnts0taoj2sWMo8/zLR?=
 =?us-ascii?Q?VNf/wGoLVcTOWyQbhUBsgYuqSEv+CpVBOALwhkYn0iyWHB+oN14Q/y0JAVQG?=
 =?us-ascii?Q?5VP+LUFG2siyUEqf63NOYST8ge4RCF6RE3WA6p7bnTFNjNHhhz50k3uSoOjR?=
 =?us-ascii?Q?1U9zOCsari24C3w+cvvtExOxbS0fMUStBVR37mMzgZq9AMc1AN4t2i/zRAOj?=
 =?us-ascii?Q?eOuxWk3Op2fudMmLlgZlKK6Uy6PKt3/vRRKDrFXKkzKB7wJKNMP0Q9sIzc/A?=
 =?us-ascii?Q?BbFq6WBKHgOxXt/DOLKG56QoSEdBxyGvDtrRu0LpMjNBatMreuj4u3yj5TxD?=
 =?us-ascii?Q?4RJCQhdrnPgCIIHRDujqnYxiD2PpFdh+KuFTRzuVai54Rm+Vc/JomYNszeMi?=
 =?us-ascii?Q?/KvYIcvyyrjbkVHTqfHWhs7RkxD9IO8yamm6aYLefZMoLyMRlXoST2VNnBly?=
 =?us-ascii?Q?TqrF+UGUw63xZX1wMo88++f8fXppMh8rIdxrBbHd/qw3h+Xm0qmLInKAn3cS?=
 =?us-ascii?Q?woXgbTaHBPl+gCYVVYNdsHdOhwCZIZDY32iMUYtI818UMNu5CUy3BzONqlTL?=
 =?us-ascii?Q?qS8gACeiwjCStHBSvpfoapklsa3ArLUKje4JOTEZ1Neg2krAXdoicdeQKBlB?=
 =?us-ascii?Q?1PQR/ClHOFPp8OXBkEqAmL4mqG33EIc+UprE3J4C7Rt/Pw2UgZRrv56bBvvJ?=
 =?us-ascii?Q?ysMFwoDZDhGtnYKzySeq4/jU4W8fCO8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dfdd58c-50e4-4532-9ccd-08de6e4e5c76
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 17:59:57.3131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /HSlbjv7RffAsoUIBxmA+47dMGpZSiZqOE7PN1fcLFBLvNtBJ6Pc5dI6Iz6HjncMI9YWgu1hsc8r7b8U2kLRXqOS19Q/M/l4HPf6YBQ1iyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9011
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

On Tue, Feb 17, 2026 at 06:53:20PM +0100, David Marchand wrote:
> On Tue, 17 Feb 2026 at 13:49, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > The PMD_INFO_STRING constant string is not guaranteed to appear in the
> > output binary immediately after an unprintable character. Because of
> > this, in some cases the information for a driver could be missed by the
> > PMD info script as it only checks for the prefix at the start of strings
> > that it finds. Change the script to use "s.find()" rather than
> > "s.startswith()" to fix this issue.
> >
> > Fixes: 0ce3cf4afd04 ("usertools/pmdinfo: rewrite simpler script")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Surprising we hit this issue only now.

Agreed. Two thoughts here:
1. are the compilers normally arranging the data in ways that nearly
guarantee that the strings are not prefixed by other printable data?
2. if we were missing a couple of drivers from dpdk-pmdinfo, would it
really be noticed? Even in the reported case, there were actually 3 missing
driver listings, but only one was actually noticed.

I'd suspect #2 myself. :-)

> Acked-by: David Marchand <david.marchand@redhat.com>
> 
> It would be good to hear back from the initial reporter.
> 
Agreed. I'd like independent confirmation that this fixes the issue on RHEL
9 as reported.

/Bruce
