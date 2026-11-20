Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E8360A383E
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Nov 2026 11:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a1vrerDW;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=I2UnPC35
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BAA8540263;
	Fri, 20 Nov 2026 12:11:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTPS id B8A2740151
 for <dev@dpdk.org>; Fri, 20 Nov 2026 12:11:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795173103; x=1826709103;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=0oKh42QNUOmHUpyrSz2BAUp8qnv3oQcffwAh5FmYAmU=;
 b=a1vrerDWSsj50Ii/wHkm9fNgXJx3L5me0mdIdylK/2BEIlYHBt4rp23b
 kKk86qfKDU/PPHWJYQUQbLWfMK1aj5aJFSu6xg4Hu6aE+zNFSSN9sC7Ol
 g9Yac+7+4c7KE44SBxmzDnF0Z3NAt0TkM39piK4+eayfb3O6FLGJrha15
 1pC0w3gJ+t9vAyUZGc/YWQolzrsyp3kfAXo2lOjVW7JTGXTVtH/bJ63FB
 IYhRHWm+jgtVxqalI5o/9G2e0nos1ip5TE5K+5V7okv4bZf1rNnxNFZfz
 jKkYl845pUpzowyT+2HdSzVzHow+FPs0ZjyB/9MDCf/3h4Js0OWPG2du4 A==;
X-CSE-ConnectionGUID: BFxHeDC2S86QzWd+4xCuoQ==
X-CSE-MsgGUID: gFD8logjRiykB4jJ4ta/MA==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4077600"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="4077600"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 03:11:40 -0800
X-CSE-ConnectionGUID: xN8uPlgiQMm6HVRBBrxNOQ==
X-CSE-MsgGUID: h1X8jXlUQtai3L9pV7Lcgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; d="scan'208";a="10895446"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 03:11:41 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 03:11:40 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 20 Nov 2026 03:11:40 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.31) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 03:11:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b5RiqLgVehmT1EnROtMBqLsrhje1JUFzvf7Smo5Pd8erteJvqVgbgdqZm8wKhIW4EIzVWdSCIeqj9OFRCxhqhamkMaOOZVWTGv//On1G1x6NiQj/sFx3hSB+lPKM+PNwoRVk5H427WXaUTFSV4IPE9WtEo6ey2bIPmqEg4EKjLM+Zr1qksKL2vXbAeej1JXZHXBsFJ2lmzZvJiC39WHLnyB06vCtqpRykl+sqh1Qw1I3Ta+YkwlDHB950t66UTRksKnorU0RomOdHwoO3pILq2fe++ggvcKaePwJPdrRAEJznFpkQ67hF9frPM9HQjVFPiUmyL1/uWKbtPj9vf9NRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jmpb5Qu8cDIhkIpiMvexmiVi+tCtxgDj0CUEDhbvXzc=;
 b=v8oyMiixlTRLhK3AkTP/CGab16EZoOhTFb7xlG1X3p4o4GidO3eSLCdPCcpn0VCu2wHq3eOpdPQJWhpchZ7/mnlVIpThdirTwCyjo9t1RIcSc03ci+oTcyB6b0Jb5VaN0SyuGvtBT2Q3Jq24GAhZwqzrlQ8OYKY7esGbv2mV299UDZQ7Dq49TajVIWjDf6zRy1rjVSGSaSWXaEXvvuUR6iUdc+PwN166UEaGFzLfPcnxF8sdlZJK6TeWif7fTf5AZTzDK1J1X4TNQBtpvUX01/a0Q+XKkN1RpFd/vINuQycNNIFDP2Bj9DASOTmaFm0kfQcydpflaKkYf1QiqNHpFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jmpb5Qu8cDIhkIpiMvexmiVi+tCtxgDj0CUEDhbvXzc=;
 b=I2UnPC35pE3X+w0i1TKuGHyrXoSm5m/umhNo2sI8PzTYq8ypjwo4BCNfDHenmAh9EoKVzmtMXvkKHQMMTM2a61WZpqu3l08TEwU73nq+ItYX+JJddmYxMqFAAbxELZUiSqRnLmWSxBtRzfxbE+kF/mGhb0VEB1XqjRaT6xj7fDU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SN7PR11MB8067.namprd11.prod.outlook.com (2603:10b6:806:2e8::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 11:11:32 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 11:11:32 +0000
Date: Fri, 20 Nov 2026 11:11:27 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Hailin Xu <hailinx.xu@intel.com>
CC: <dev@dpdk.org>, <manjunathgouda.hosamani@intel.com>
Subject: Re: [PATCH v1 0/3] update latest recommended matching list for intel
 nic
Message-ID: <awAq38xX9E2hAm0a@bricha3-mobl1.ger.corp.intel.com>
References: <20261120031525.300632-1-hailinx.xu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120031525.300632-1-hailinx.xu@intel.com>
X-ClientProxiedBy: DUZPR01CA0030.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::19) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SN7PR11MB8067:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d1a3bd8-4dee-4f2b-e3b8-08df46f7083a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|11063799006|56012099006|261021121427099003|261021123027099003|261021135927099003|261102123227099003|261026140227099003|261022105027099003|261028144727099003|261026121527099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3WSq2NpOL9PmgWSwbLOEhqAxxFm9SpOws0plIQkOWRZB0wPCaIX/mmQTsns+Tf2/UVUqI2QcyiOpFDUA/L1d4XRjZfFrEjU77Bfu2AXgZu/ia7bgwimKlxfVAAOoqSsMMU/Hy+laXAYTdUBvCY5/sSnc9rPve9LOo/UEVP5lysJqV2cUiaa71w1qCQQoiuwVmOXiyYkeu/Xck2e+M8tow8RVODSqXFd7VhFjCTmTBZLSAdFNcZf5A0DILPwRka7aQ04g2mMZoZDgqOGS5Za+BJTi6yU+evvDelBqnyYedvYbYh5cpK3DgdeSpkkM9ntTb8lufvkBXG0ax7nLa7j2kGGF3Yyp96QU4agjIuRCXbklbf1QsysM/aaU3GczTLYhJx/6KIrlqHhlk0jsAVvUJnopJHxtW1xYRKnWR657rbbEt7UKrFSh/DUmO2dKp3soiy8v6N3NQcrkb1nYw2q0KKmBDm6q46KRJksMWxAvPvMfAnNltZlORSo1l0UB+u+YX464U2f5nLgxhbZKxhmX+TT0+TXWUWDIqbyqCD+d2v2zxm/27H9mAbffyR7WaIcwQrRbC14Y8mro0iUrEpunbCBG2uhIAWl4MKdxsSwSYz2B4B9SMvYoRfe6gwxp6neVsFKo6EhPj/Jdp08fp3iDQ/WjOWm6FFV0cSDH/6X/fjQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261021135927099003)(261102123227099003)(261026140227099003)(261022105027099003)(261028144727099003)(261026121527099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OLBG9EgV9W4P6O6NlHsfxXgyPm9lQNvEeZL8nqClbogn+tpEMZ5hLreDEg5B?=
 =?us-ascii?Q?9AmdOrwfhn9QbzNBvinc9fn1YV/fgmh4jEf/yYR7AcdKQBN2/rX96kyyqscW?=
 =?us-ascii?Q?E4LkZo/dsTTEqLHZs2d/miHqoOlB7N4R8vZs+s/sS6ZZxtrJ5PZ1TjJyz1h5?=
 =?us-ascii?Q?SiTssm2itphTRKEwI3O1Qvzmeaf4WPNltdR/mYCIWbI3nP2nBN8IQP7NjbD9?=
 =?us-ascii?Q?CBhDpyxBP2DK2cWwOJKCIGdVtQ1WTPAQnjaF0hD9bmKY4vQ0DXEgvwzPKHgQ?=
 =?us-ascii?Q?GUDB2I/etNDM2v+cdqaFkb19w0Ag/fcqBe0eCeZ1igQQEadgXXR+thX5/EG1?=
 =?us-ascii?Q?/f6vaxQ+r7PVeaGj1eEz8Hr+r7YIAk0632ofvWAbnEGmjagtV0XYgUlgPIqT?=
 =?us-ascii?Q?sg+lUR0/T7sgQWApP+eHW3mTSpGK5KXiJbOr2kkx5/Mhk6GcvV4uM0jDsNYN?=
 =?us-ascii?Q?zNTJhkbLyzmNah1F9w1YswTsW37MH7cF7pA1055a7iOUpuR8sghxBlFoNlyj?=
 =?us-ascii?Q?XPupbf3LHOKtksemNo4plUDPaNYF9EWHCeWMfPuByDkAhxP+Xxr/8hVrXy4V?=
 =?us-ascii?Q?x8eCB9oME0vg56TjAkoupzmilz4NrId8G/70CQV2IKS3FRyjV6Et2a6eoD8U?=
 =?us-ascii?Q?dQJpA6U5o0RVHMUxY4iGByAjbDi+mzb6wc4+tpEZybTpCoXOqoDg401rpB8/?=
 =?us-ascii?Q?XL0NGJPsZNmkPefW6MpC7zSo4VhTxQKMVdqU7iTT9mX49DQVdPKQrjNno4yn?=
 =?us-ascii?Q?dAMWJ3v6S561gX6Y38wf4sflbZFhdW4G50pvycdB7QLeRSpXrTLblUe8Fg0O?=
 =?us-ascii?Q?F/RtQa0shldSAUJUsPFE5F0SYEjacOaGtxqhG2bPjdS9GC/d6x/kiiHS/pF9?=
 =?us-ascii?Q?GvhaRB5PLTcmT+xrvPTQ8SrtMXhfWGQXBYGV9OgRS64BnWpBMCrHJDzUiMpy?=
 =?us-ascii?Q?jkFcd6VyoV6k9Aejr1/zRzJMtoGbGYRXnPXvAWgVdqeKfof2HZkjRds+7ZmJ?=
 =?us-ascii?Q?/DHhlfBA2UnM6425cwLG9/IXSWeVXAWIkyc4CeOgj2D8HInqSOQP/s4D3XZa?=
 =?us-ascii?Q?lgBVkH4KG+XXYE9sQc0cMnuc8aV900OvUSu2sCovVvugliNbebdUJdnpCcFZ?=
 =?us-ascii?Q?zD3o/E5OEh/sHGQ2xd/FA6QNJ+u/qQi61D6fTZpsrKeBVaEXG1FNhAJUYd4p?=
 =?us-ascii?Q?o4mnhyDsCU6gLkF7FF0xsUpXIRqwo9i50cfOv7xzmnpsU4XPAHR+dhiEtlqn?=
 =?us-ascii?Q?PVxrjtNdAvzfySS1oGmYEqEkXC3biuXQ9G6J7vxGQl5Zh2N8xlMSP7vLVTIL?=
 =?us-ascii?Q?dMHvBwfWjK+irNK2Ukyv+FqCLI+pkoPuGzCCgm9Orc4/yD38DysjaZ1SF13o?=
 =?us-ascii?Q?sw/sHXkIvcKN8Qru14yFgMO4mDhiYHgmIKH4YC6J2AZHM6xWFaqrKqfEE+6z?=
 =?us-ascii?Q?MpobH3LzIiSZceEqsk387/J4fgEeLSJTRbj1wxcSNzifN10+hohd6PmzZS+2?=
 =?us-ascii?Q?YO9The4HIhUkYaKk0kX0MNW7/Mq7FDCM8OUwn4l1CLjjOWFzch6mqmFmuB0e?=
 =?us-ascii?Q?QVlOE0zrqKBS99HZQTTyJ1W84bEihAjnyGnrzin2cnCIpkx12Wbf6V/PVWD0?=
 =?us-ascii?Q?147a1NneksBhtw0DcbqKfXxyPPqL00H1yCRtMl9VNr4/uvobsTNLZLNwhLuP?=
 =?us-ascii?Q?egWEP88VC6NgMiFD/KB/LT06vNwbe/E/4eha9BzRq2sDnpMQU07CQRTeujAw?=
 =?us-ascii?Q?zcjV2zFpxjlkQCLgWvqIYnYBqpDCKFA=3D?=
X-Exchange-RoutingPolicyChecked: PL5puRsBQaf9l666rhWhm6RzddchL7iHJw7NZwf4bP0f8MSV8h+B4zLmj8jTXNxhPXTLVxN0THcgTiD/0t6hYhaskmLw568SA6uhUNhrpWlb91FzITjYF5ZmJ6jRvVYvzD0S1UoKctqbN1bCT7z3clv3Rjqz63aYMSbiKte0IOkw1VLt45OaaS/pnreAcjW/VuNDfPgsc1EIIjzOUMJw+9oHfH19AW2b7pZBtUxtPiIvMxyjPgF21OJFhVfi8FU90lIkrZfSr0EUwe5zFrxgbyAoNfHXDoEVYsxIVlvgjKdWr4GrTNuXfktxNN4QJc69Js5X4u9cunFp5SJisxlUyg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1a3bd8-4dee-4f2b-e3b8-08df46f7083a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 11:11:32.0173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Siu23CZVs6oON2xVlgS65DhhMrcmCiz/hU5LR9C3VjWvMr0XlQQWMWmXHacmRRpIfwvprKamby+yYRCuYV9eW1hCFjNXg83b2B0PyKM2cnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8067
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

On Fri, Nov 20, 2026 at 11:15:22AM +0800, Hailin Xu wrote:
> 1. update latest recommended matching list for intel nic.
> 2. remove recommended non LTS versions
> 
> Hailin Xu (3):
>   nics/ice: update ice latest recommended matching list
>   nics/i40e: update i40e latest recommended matching list
>   nics/ixgbe: update ixgbe latest recommended matching list
> 
>  doc/guides/nics/i40e.rst  | 3 +--
>  doc/guides/nics/ice.rst   | 3 +--
>  doc/guides/nics/ixgbe.rst | 3 +--
>  3 files changed, 3 insertions(+), 6 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Series applied to dpdk-next-net-intel.
Thanks,
/Bruce
