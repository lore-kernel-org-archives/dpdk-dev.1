Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1420CEDF15D
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 13:05:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62B6A4042E;
	Fri, 13 Feb 2026 14:05:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 4E0AF40287;
 Fri, 13 Feb 2026 14:05:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770987926; x=1802523926;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=QrnvNOPmM/be9AfyecxWidoOgMaXUEiXSgsEBwEtsrs=;
 b=DnizJZjpYWcGJd4P7NLM+1p1Tup4p58N8lpk9ozugydLvvLm3CsviuAr
 cyFTDPVqr550/HoSdieaVWuKA4MVcOcKH3QFQq/q0LoVekn3wlbayPGYG
 iQ6seOx6Y9DUsL4je+LuNo+tMamKaNufB1Fv/yZdX+AqzVlxfTTLTwNOX
 yI8PJ15d5bWfPbdKHQlkLLq4AUKwLyWp5kje7kwHj2LzXhCYjUPxMVKHi
 bSaryoxhSvpM8UptSgFRLRG8Ik0Pmt/wMNGFh4ksBltl2fzrF1MuD2RnK
 wqB7/SwxcYm5BXYagCo3bRW2U88wZvMV6pyz6ZoDuZGNhtafbU1L5JEMN w==;
X-CSE-ConnectionGUID: DORhZ+3QS+moXwkjTsE8bg==
X-CSE-MsgGUID: LWIoijSdRESDk9nD3fdYYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="75792696"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="75792696"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 05:05:25 -0800
X-CSE-ConnectionGUID: njlEojKERI2H4DJ69HlaMg==
X-CSE-MsgGUID: UttM/MTjSPCLws7qAW1pJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="242334204"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 05:05:25 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 05:05:24 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 13 Feb 2026 05:05:24 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.32)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 05:05:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r3Iz81skLmoIl6+XucUmdZ9nFRq74GU9ZE53gJ8W7ar2zh/Nc+UrOWenCndeEyoU0BBHGtDS3XQVy6zjMQpuBZgD2zWjczuptf8jg1Tmwm0iSQAb05bdvu3ygbkxFjqEpK81lttCUJ5rL6+THn/OEpH7Bg2AXhUPnV6Wu8hGnJu8iP5KFfWp3HEkHz74iURNu+qQfEWqxSe5/iEsAZeAaUzddh1cS8GdnGyWkRoVLrgQY+hhloPjdwUKgLhcmr3KEXhQnJXVf0Hq6s0LfVsRPGQvU34ulvocMUGv8uQp4TbX7cnEMwZiXK7MsrLlr1AhAmxwLZ/9NAyZEPYnhAQ7Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyBVuiwe/uh+gVPHwIR+lVTFiFnLTNQdD6k8hyXHvgA=;
 b=bgONpGsZujaVsS8uGEwjvhpMkXjZAmXYK2D+p/HY/CUltP4uOvSVKrce/8oVaREnWOy+8rey3EDh+v7U+p0j+medc9yMJgOeE2//JCjzsp1jLFBZgaTXSbTqYicD5CT7iRcHGtTmpmuo9gahfpkxcrdgb+Yzb6w3CrCyHD0cbBsLzuFnUnSI6J5Lp/XRHfVm0ypcb54c0sP64YTKlJ0Z6rh3TJgZIONXs9goylDALlx4A6oxc0z+xvVWXJyqry0S4X8Kf626+uaPyqp7jDL9Ws+g56NdEaDMXK9+GdtqWKaKiJU5aTTBfl47tewFCThSejA9wnRgUdvsa/SHGuI/nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CYXPR11MB8711.namprd11.prod.outlook.com (2603:10b6:930:d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 13:05:22 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 13:05:21 +0000
Date: Fri, 13 Feb 2026 13:05:17 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Venkatesh Vemula <venkatesh.vemula@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <shaiq.wani@intel.com>,
 <stable@dpdk.org>
Subject: Re: [PATCH v2] net/intel: changes to avoid comma operator misuse
 warnings
Message-ID: <aY8hjd_t9yrsFgFU@bricha3-mobl1.ger.corp.intel.com>
References: <20251106082354.1534181-1-venkatesh.vemula@intel.com>
 <20260120064156.420244-1-venkatesh.vemula@intel.com>
 <aY8bHYULOs-DTmLN@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aY8bHYULOs-DTmLN@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DUZPR01CA0035.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CYXPR11MB8711:EE_
X-MS-Office365-Filtering-Correlation-Id: ad545ce3-89ec-4e74-6f10-08de6b008b52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0m58kqgxZPvpf3aXlfIfPhSSuFGaSlESfSVORWI9dKQ7R2vgucdWjxSEaT7o?=
 =?us-ascii?Q?zBu/aDLE6kG9VI7prINPXvIxNfCwNnC4mQrYyQ6vneYdmkzmKDKwLTXY6Wab?=
 =?us-ascii?Q?H0omA9nWH//JUxjkUWGm0S1DpnRtpngZE9dKUjZlyZvqUUP09iwnHtMLRorf?=
 =?us-ascii?Q?mBtjSphJHL4BaTQimwm4j6GaaMgzsjA8WVok6YJyUvfsJXfQoIQtqELBR0P4?=
 =?us-ascii?Q?cMkT6rR1VYj5o4qCci7WY3tQFckhTI/EBbBACg5VTeuNGbN4Is2vJh6vPGf8?=
 =?us-ascii?Q?0yn1Su+O5ljapCSP000RiHSKrQfjbIBjJaz7/u3l5ci+2ttEkR6eoDhjOAu1?=
 =?us-ascii?Q?zCRN2FLnG4YljoQLgiAvdnbEmHyhAdBPoljxicKn8UV50Ijpe+etXAThj1ML?=
 =?us-ascii?Q?+R/9eB9FfvybIKJzAm/Ah5E3o+0bTDTA9rMQ5fnR2egTPU2qCMClA4JaWMtk?=
 =?us-ascii?Q?9YnS14lwR5XDtPP2IHgtjB6C6bf7yihCXHWqn8ZKpBllYCmxnaOKl1lsoAwv?=
 =?us-ascii?Q?ej7+Z/ZGbUiOlXOen3QQ2paw0ahIlZ9JRMKaLH62ArLBah8u5HABPn3vD+mo?=
 =?us-ascii?Q?bmJ/DnJV96kXTWtnc4yTXb6JBfNiEDNL9ts5F1xBIadsXvPjs48/uKaqKh8D?=
 =?us-ascii?Q?ntOqq1an1rsREcjxfmgJKH+J7Il/lPliVfDvMwpozh2gwX6NRm2wIR6maQkV?=
 =?us-ascii?Q?yGBeW0BKQe98S4Te+8qMQByvndhGRjAejVJvQM+LHx+DwQoTFP7r+AeKMjjg?=
 =?us-ascii?Q?YoskpP13KVQN1JRt2x6nS4Q6MR0QMb/e7dbyLWfHcRZPy4uZogTrR9Jxpx1c?=
 =?us-ascii?Q?Wvm8H+mYfQkUOPAp4VkP/pR34+HWbVq+AvxHPy54n0HiftdgCTq+mXfzp62m?=
 =?us-ascii?Q?INkThW5HSQXUzLMFdcOX31FzqlZRoXK5/QOqE7opjWI2X7/7hi0Khd8WptJB?=
 =?us-ascii?Q?ad1MJuwzjtEhrOtkgUKAAMRb5HtYyD2+OluqEfITLlMzxIegbNK5Ixb8nCrC?=
 =?us-ascii?Q?U5fnWF6JBnDmz2queu98KUcJ6feO8XkC/sjmKVAkzOOISknM1qy/WaRzOSpq?=
 =?us-ascii?Q?lfrS0ARKmwrg2swl7NJiSFOWG53t2L7ZbRBnWPW42k25yIw0+mZSnKMD7Nbf?=
 =?us-ascii?Q?QHhNy9XBntZrgiZ2ZuPVtsQmSrKBG+9ndPlugR/68zzLNcE0GigGyyh/ZQKU?=
 =?us-ascii?Q?UQNHx/9QpFfvFTH1josh+y14y3E2e+CLCm7IlcRMIBvNC6ywNeq5g1Ax+5ok?=
 =?us-ascii?Q?h8oodPZc3MkfaE3jWPu3irhogrDleCxdu/lQBJ8lUlJ0cLdERa2bQYUSXsd6?=
 =?us-ascii?Q?vUyIw4NZBVGVVHYh5M5MhSfogwps3QnlhdpCVwBUQzrk4MRcM8f4Gyx2h7hm?=
 =?us-ascii?Q?Uw/qGtlK9kcrPRy/a4CslYEgiFjHNkq7/W5/NivB1yNaBpA7V8MtNMS8N6Vg?=
 =?us-ascii?Q?oy48BF+kc2QptnUfXVbEO5mRP6F9rPryuJuZ1HcUxJu8B2VG+cuqhNL/cV4z?=
 =?us-ascii?Q?azsbTymJf/nD1rBycmDQACiHePy4UsmACtHEgIq7namHO61h055nZ9uagtVL?=
 =?us-ascii?Q?zQxQ3hOOk9KKrcERSVQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9iCMzn9b9iQ8erFIWqIxFVDLQZzV1Y/kVPcHXYf44kgrd9p8+mU9mZ2rJqsT?=
 =?us-ascii?Q?raxcEZj45BfCwsmEB+Lzrk1N0L+sGznfu7y4UGBJR8r+WdqEPFi4EW6+KKo1?=
 =?us-ascii?Q?UTtdBPmpQVKouxiikQL8oRnAsb/oVtn6cPBn2/ObUOpf/SmP/Sul6equGSDJ?=
 =?us-ascii?Q?vesif+GmRfly8CETj2ge16kaokR1oys4Lq8I/MuOl8bP1PPeYy93kUd0P+H4?=
 =?us-ascii?Q?/rFiLUvu/rGv39HeAIOUs9NILmKA9iwdsBOiCxvnx/QMa06XhlzeZsQZctOB?=
 =?us-ascii?Q?Kdah7OpW22yG94g+dJukuVNZ20Ihyy1YWGoH9wEZovQDk1g6BOXuO18NoLRi?=
 =?us-ascii?Q?ejr36ome1+VVgaLHUZY8nsFBhQscmrQiKC8Ky/jjTcscTE2WX1pFqSKTQ8Kx?=
 =?us-ascii?Q?AuVGe+MOb3OFVfRU+6RLUu73aVJPogGeR4ywqc6YDzD5O7mUB7lEEMJSjlw2?=
 =?us-ascii?Q?jO3PtXMidBCprfTx0JXvf6/eCQ+v3cUvA+mAuaxnhvmKo3GXUpaaN4JCBf20?=
 =?us-ascii?Q?4xI86iDGQKvbRZbBjE/KC5qlcICJ6MRAaPbhRUveKYitUP7a7NR4xtNVFLhg?=
 =?us-ascii?Q?X4lzTMxBa3DpX6cvq72934yrxzmFAAueY9vC/d8SAyJ0D9rrQFtgCodqCRlc?=
 =?us-ascii?Q?f5u+Fw712QBqfiHWsaBMcXZD5lmuhDwkPIC+Z563RAY8JYfaXBIbbENWaSuZ?=
 =?us-ascii?Q?uqJTD//mXpIGnLWRN92uTRsDmYgt0jnwqQYa8WuQgNlfW0pwP4ZShGiocUDk?=
 =?us-ascii?Q?NmEDYRpe0i1ve6zLpkt0m7g1h1M3B/bPwV5JD2gWvAGOid5VkLcnf5Gs3Pip?=
 =?us-ascii?Q?gf4FdB8ic6Ez9uGzLkDlRBGBGIsPKrAt72QLHFwuyF0t0PwlHjzXHWIVt3Sh?=
 =?us-ascii?Q?Isa5G26XpmZsj+jM+8LdF2iiiZhrrO3DjO+4o8Rj5D753SEnXC6DW0uSWSw2?=
 =?us-ascii?Q?toXAZrJAfCPoaS0XuCFG+G8/MqD9scsU319f3gWzIYq9ADBUXEAZ+cVga5py?=
 =?us-ascii?Q?Dq/kqoPSUFpWuVjk/ghZsr+5iGJIjvYMsAOSI6wKhrHiMwVv8gfWcrxqNGxc?=
 =?us-ascii?Q?FrRy9lt85WZHQUwL4cz2HS1v7fvdSY2cjcfskDvOBOLIxWRt1BIs9NjCOYGU?=
 =?us-ascii?Q?WgRZbnLRCNK6aFJCNi7LNuloijk9kFSWkFSgAm+HIB4Asa0LKJg5H+hfQaTY?=
 =?us-ascii?Q?/wAOg19Gn3d0bvyffqQLoIBALUAp6B7uCdjnUZmphXWfTI3oo2kLn3dZI5ej?=
 =?us-ascii?Q?xzUiK8gjbmY/eyXzMU696XmGezmX++EMSC/Zt+c2CODA2GZvSy4Jtwm+O6uN?=
 =?us-ascii?Q?PtrMrg1Yq/KCPe/CB92p/tTmRAEHvr/KHfQ0oqfb1GqfoT4r+/yQRZ6S8gcR?=
 =?us-ascii?Q?jN0mGk9sj9JxCHwIqROQeJFYELEGAeWw2Q2J3uV5UqGp3k3gCN1k6ekaqUDl?=
 =?us-ascii?Q?JkweRRjkswNPlZpN6nSaIp6aGFWoKmixjiXC++YJ8+4yI/sysYykt7aAv6N8?=
 =?us-ascii?Q?St8oDOUjx92IM8zY+uSq/b8pwa89qluaZQjqCcQr3xEzoaAlMAX9KIjuF0ay?=
 =?us-ascii?Q?3auLhBLZnZf9yJy0iuh2yKV0t0N5fJMNlGn9XALVpSYNxFIUYOwmCRHIAMqZ?=
 =?us-ascii?Q?AF4s8e0m1wQXrbzBO4mNYTsH1cCZfzjXq9k3SFqRfiTZ681r2dpHHuk8V/o2?=
 =?us-ascii?Q?kPkd6ZpSlzZWJ011Zqta7hW+OAHwaNeUjUf6zvSeb5ukHy+mswkbj7pa9l9U?=
 =?us-ascii?Q?USHkouwuSVeQuu7ONTFOd31MJbtj6NI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ad545ce3-89ec-4e74-6f10-08de6b008b52
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 13:05:21.7227 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FKGWGpW6ZeiEUYiX+WzfOgVJMOWWYwyWZGMiEdqQZzLBjHObwZt4a+TvgrDyiHlU2Y+5XoqNCMEUhIE5KPy9ArmwVoDstEEFNYnOHgvY3rY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8711
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

On Fri, Feb 13, 2026 at 12:37:49PM +0000, Bruce Richardson wrote:
> On Tue, Jan 20, 2026 at 06:41:56AM +0000, Venkatesh Vemula wrote:
> > fixed comma operator misuse warnings with clang compiler
> > for intel PMDs when -Wcomma enabled.
> > 
> > Bugzilla ID: 1809
> > Fixes: b3fa893d84d6 ("i40e: fix using memory after free")
> > Fixes: aed68d5b0e81 ("net/i40e: add AVX2 Tx function")
> > Fixes: e6a6a138919f ("net/i40e: add AVX512 vector path")
> > Fixes: af0c246a3800 ("net/iavf: enable AVX2 for iavf")
> > Fixes: 9ab9514c150e ("net/iavf: enable AVX512 for Tx")
> > Fixes: f9cf4f864150 ("net/ice: support device initialization")
> > Fixes: 2d5f6953d56d ("net/ice: support vector AVX2 in Tx")
> > Fixes: 7f85d5ebcfe1 ("net/ice: add AVX512 vector path")
> > Fixes: afac6261461f ("common/idpf: enable AVX2 for single queue Tx")
> > Fixes: 5bf87b45b2c8 ("net/idpf: add AVX512 data path for single queue model")
> > Fixes: e528d7c74819 ("common/idpf: add AVX512 data path for split queue model")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Venkatesh Vemula <venkatesh.vemula@intel.com>
> > ---
> >  drivers/net/intel/i40e/i40e_ethdev.c             | 10 ++++------
> >  drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c      |  4 ++--
> >  drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c    |  2 +-
> >  drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c      |  4 ++--
> >  drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c    |  6 +++---
> >  drivers/net/intel/ice/ice_ethdev.c               | 10 ++++------
> >  drivers/net/intel/ice/ice_rxtx_vec_avx2.c        |  4 ++--
> >  drivers/net/intel/ice/ice_rxtx_vec_avx512.c      |  2 +-
> >  drivers/net/intel/idpf/idpf_common_rxtx_avx2.c   |  4 ++--
> >  drivers/net/intel/idpf/idpf_common_rxtx_avx512.c |  8 ++++----
> >  10 files changed, 25 insertions(+), 29 deletions(-)
> > 
> For changes, so far as they go:
> 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> However, there is little point in this fix right now because the warnings
> are disabled at a global driver level. I think if we do this, we need to
> re-enable the warnings for these drivers to prevent new issues from
> creeping in.
> 
Changed my mind :-). We might as well take this patch. Even if other
warnings creep in, it still makes any subsequent work easier.

Applied to dpdk-next-net-intel.

Thanks,
/Bruce
