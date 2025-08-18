Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5C7CA0ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 16:32:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39F9540267;
	Mon, 18 Aug 2025 18:32:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 8F81640262
 for <dev@dpdk.org>; Mon, 18 Aug 2025 18:32:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755534771; x=1787070771;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=/Pw0VmOcrifLyq0OYeI5XRerU7XgwpIDPjLirOPNFGk=;
 b=AO6W61XuHA64hGrXjUJ3ZJ9RxuG96qUFbW/3I7NKAeFtadOPXmiI81xM
 F47VYpLX07AB5JKi3D3xwHCL9rUvrf28hMbq+Y24TQ1a0EH63/QyT5yB3
 +48aWF3iOZNSXpEiba0rJSxNQnL4R3yiOmOg7ChvxJQh1UMm6VNRKpJQ0
 b9W+GGoGdnO/3y7grPyDcnv6fzxhL/ql39OhMBBQ0OIjeT48Z/vgonTkC
 T8Rg1oyBtOpk22rF5tk+LN/VHLLWVebOddnqTzeixp8sg8CSY2ZjJY1WC
 MC03VeReJRP0xGOymF35avkCdU2t3r6f4A1AmIgm/mZoaAxHQQpMPLcpM Q==;
X-CSE-ConnectionGUID: 3mF1srQsSYeDiUbAVHc2yw==
X-CSE-MsgGUID: mrkVPauxRtWk+v+5Aie7fA==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="57693132"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; d="scan'208";a="57693132"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2025 09:32:50 -0700
X-CSE-ConnectionGUID: SzSfC/S9RBqoB0H5hp5XFg==
X-CSE-MsgGUID: QSN7A+rPTjCyL2Cy5i0Y+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; d="scan'208";a="172822721"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2025 09:32:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 09:32:48 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 18 Aug 2025 09:32:48 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.77) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 09:32:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0mtmBCSZQsPsqitl61+tVApFLsYYKIV/CgZxrxAE8/Ta5enB40w/Vii6ZG4BxD4A9GDXWJckVK2cYwdmwN/8MYEOM+2tvVV0caH/ARp97yAtviwqLrHsMY3OWZse34jFzhLJgWdAnsVVJQCqOY4yaazW3BVFpfwOFEaG/IiliKP8atZMg1JrjJIBNMZ1huiJPPpv8vk4Q9sc4OkQBYTKmbc6aWaN83HsAXoW7N9zLgdi5AN+fpVeUrhJ3i8Svfcm/D1uL67/FXTEYXPfZTvNCtN++Xy/rTIXF2FbgPGf9IdnSj+Lzv2xZiNjed9cLFjWTYxLXtNrTDbX+dhjMvIfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ezGCuck+AWl9bWNhgMwO9N4gNWTMdMGgeGCFCm5tVY=;
 b=qfUCePShuReoVnMOoDkfZiA0FBI5VXi5XAoI9OIH0Lljw5MtYW8SFTbdfzsaHh41CU847ZmZ7wP8mEcAPhbWWSuFSAmBCQ4tBN9soSM3x10zgODnBlcqf/H/Q3u6IsC3S9zzERQBCziT7Ifdr2+tAw1WOSjlCyRFOLd6TYt0rpR3Rw+nFsy3MmSn3+W+M6VMhTwC/qcq9w349ZcHoEBk2cdZiFyRU60TfWD9Zt3IF6UwSC+Fiyw+au/3NWgmcQ0BGuGjxaq47+FsOIes61oW+/F394xDGVLPrB4gS3zFrSEvzLvNSoQTogHol9PDvZaQQ3eue0/ATV3ennkR3UDKvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB6654.namprd11.prod.outlook.com (2603:10b6:806:262::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 18 Aug
 2025 16:32:46 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 16:32:45 +0000
Date: Mon, 18 Aug 2025 17:32:40 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>, Morten =?iso-8859-1?Q?Br=F8rup?=
 <mb@smartsharesystems.com>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v4 2/9] ipsec: replace unnecessary comma operator
Message-ID: <aKNVqOK9gwwDDk10@bricha3-mobl1.ger.corp.intel.com>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20250818161815.23611-1-stephen@networkplumber.org>
 <20250818161815.23611-3-stephen@networkplumber.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250818161815.23611-3-stephen@networkplumber.org>
X-ClientProxiedBy: DB8P191CA0021.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::31) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: 52c9a581-f669-44ac-34ff-08ddde74dcb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?4H12idXe8LNIqjY7ZeqGvh9Y/cmIcf5GPvokg938O/6nr+qKF3qspsFckT?=
 =?iso-8859-1?Q?zBi3wfo8u+L92dykfHjqcxTufM2sLHX1o8y1+wiZvJVtghq08cv1rQRIlG?=
 =?iso-8859-1?Q?HfmeAX9xQ8qY4fBI1XyVDfjs/NCUFbOdJl5pYOaR5+DzA5TeRJ6wflGRBe?=
 =?iso-8859-1?Q?T/PJGUUP+u+US5F+cEFULXTD0qMVomIBcFjQhiB0TKBl8aGUrYgHFMzxm7?=
 =?iso-8859-1?Q?Et1Xp1jy7DVZhwSItdICYq3HXPOkrsUA6nzDthwpM8pJHtAGBGZQdYesIp?=
 =?iso-8859-1?Q?7DEoSTStkbmmBQ5lcPTA//AmIKzr7Hb+LrWRCD3nFThM2/8mxG/NxGP/z/?=
 =?iso-8859-1?Q?MjisH/j3G+qO4kRW/bRqjlLh9D1RwnglOs20Kj+Lz9nI63gY1d49cbw0XS?=
 =?iso-8859-1?Q?GEw3f4I6nQgnlwtVxjJRIPfjhTq/BoNZ+TNd2NqiaJoetuxQcCTYdHyI38?=
 =?iso-8859-1?Q?EEqIEWUrTxu8RU0KziUbi/ysr0JxbLg+UqVvG/KZgbON92oHqgOs6CnYFq?=
 =?iso-8859-1?Q?F0XCT83kLy9lOtKawQoGkoIsfq2ulFWpebZcMIzfeTWXKoJYoL1NGUHEQB?=
 =?iso-8859-1?Q?gH3ugNPXlf+TOQr8uyb8xQOzS2uYaltJYWykS1j7kvWa8y5PfxPVkV+3Ly?=
 =?iso-8859-1?Q?FzTJqhjC1vd5CKzoWcdJ/Dy8oY3tdHhsCSsp5b40l29affCOhdOz7j7m7N?=
 =?iso-8859-1?Q?fs2EGM3Vw+sJDZGct6rlSM4pNO06HMBEhVcjSV/00KwsIcPJggOprLqbhi?=
 =?iso-8859-1?Q?quF/sm4ZrdlsY7GZgkgyKYM4BYezbGUtasfIzy1ZUwcgC+C5CcXdytZ4oS?=
 =?iso-8859-1?Q?sBxqdGtpM8iP/GIEKYLUvVFZWdSn1B1zn/7RibCka/aaVbZxcZEbu2bbmB?=
 =?iso-8859-1?Q?UVvgyW0V4RmrQqCjLKckltEdEd+MbAx7Th2Yv08rKo/bYTQXjmZwtCkvbN?=
 =?iso-8859-1?Q?6J8O58LAZGWaf1xyW+0V5007WJMnf/BpG+59CUnE7MrlE0avydnfC662bX?=
 =?iso-8859-1?Q?G/oAJODqjVqaY8ZoFBnuCRo8P2YYFIPnONy+Y5Xyi8zzyfakkfLDpO+ECh?=
 =?iso-8859-1?Q?vBATnaOilBl6WONUoLm3IsTZJVgfuy5l9Yj4IRZS7DcAACYRScgyRotfNU?=
 =?iso-8859-1?Q?Tzxcn4M5CHs7Bh9rprEwhP73vfS5Y6f69UqNEftGFhZQhT56EZSS/KoA/K?=
 =?iso-8859-1?Q?mKPOGPQ86cFVKlpBWnw9lciQzMqy4Y2DMv0xdToc37R5wsQmcaNE5L3cV8?=
 =?iso-8859-1?Q?RqQBPLEiSBCbBbS7dcFtJR93TAQOHxmtl4t3yFVPeIKHLC76RvqPpKkP/N?=
 =?iso-8859-1?Q?5FcObejIYWaWZ3dhkkRv6WoqPbwF/4qwu6O5J4cJ//x3sTeRF1zO7/GDCq?=
 =?iso-8859-1?Q?2sgGM4cu0cgAsqPA63kx/1U2A9BUU/rMXDESdGwjfMIwz+a8fPUSQqEhcw?=
 =?iso-8859-1?Q?v2BOjGhuVQBrkW3hIkCq8TiX1G0jFiO3rBuS7A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?4hk0XMoXM2GLL7Mq8irm1wvXmxpmFY5sLPS0DOdvQWJFCDSyV6n/Ybz/Kl?=
 =?iso-8859-1?Q?wQ8bzJL14ewgWcnk33Ad2h2XuLf+IQfFOJye2TI0HxIfJqp4NyBRi6o1Rx?=
 =?iso-8859-1?Q?e530ppV/fNN8D10a4UviWndPc1lKJY4m5681CT6SZSLhUbtuLiyrYiVu3T?=
 =?iso-8859-1?Q?cEn+fBtEtSXkeLcR4Be5lXwMzv6N2ofQRPW9+uS2Kg1A6hAWSDFeRKTUdB?=
 =?iso-8859-1?Q?GC7xGRDJwyBTcLjWosHudYOBbh9+aOnhr0O/1ACuZdqxc/Mk7FPnR2RFb6?=
 =?iso-8859-1?Q?DVD47/53+gggaBWOl858beQoiL0pIQSrrILKiJDgyEI+9ZmXtb/mlVVEoR?=
 =?iso-8859-1?Q?7a1yjTQtQGfOqpl0ziT5gsHEfxotUNi6QAwosp+VeEFsLKHL8ZvchvcnLz?=
 =?iso-8859-1?Q?fejPsR7TN227EXni82bt/HU2XJ8JmmhQ1Sz1vW1OEF8hhipV4x+8/IiS8M?=
 =?iso-8859-1?Q?fxlOzVaPSho7jgfMuPOIkBcFA5rJ1QV2n2osMQ+/wZsyefp9Sc04ypV+lA?=
 =?iso-8859-1?Q?/ScJw1YPojFAmy15qXUssznoMjv2vMWjCUr+YTf6azL1eQi6lTDV/GKhWE?=
 =?iso-8859-1?Q?mRz7LAKXW7g/pLRcGB1DWaHV1WLNoj+zIEL9RzjtPQbruQ7/+kgl9Gleda?=
 =?iso-8859-1?Q?M39aEsCBzREFAozy0VOr+b8pSEFMi/HBtCg3w6A4WzP9LWUnaKE/rwaKH7?=
 =?iso-8859-1?Q?aoSKsL6kgRjjh6cl8129rpTvjEl8GTuaFZIhqxn2J0IZcESB+jVuqNi3Y2?=
 =?iso-8859-1?Q?aOw5Y0hTk154BDcHe9zY3qvGwJnpjl7hvOpBy6THjkarUEN5+Y0c/OlsLl?=
 =?iso-8859-1?Q?P8g/gjA6YpQv7NbS/HYmrGYyC4+uvCeWCKs2ufgbVoCgAX0TmGoMLFRW4M?=
 =?iso-8859-1?Q?iYXuYLXHud+VBmACkodtlQ1nL2f5KEb7pLBYuitgXLiChhVVpxZ1jQlHmK?=
 =?iso-8859-1?Q?1Y7hxsAmrfHXp2CBN1Qht+rPTTywVyYcFUF+ZWysavKiq6Gh1hBeDeSm9D?=
 =?iso-8859-1?Q?2KjTPjN8kmilG8HMNxV1lFtx/jCseV7UydxE16X2isTiZ7yZ/n5TYQDfX2?=
 =?iso-8859-1?Q?MWkn0Xm6TXX89aQlvRWIsq1fjrMcSnkEP/GGrEBfuKZte7U4Yvu2y+Y+6y?=
 =?iso-8859-1?Q?TkM3iedp3FHRqw3QE9RzGg0iXaTm9deDokhqd4JfbwzvJoQWzGORbRMG5b?=
 =?iso-8859-1?Q?pyl8sgDaUTvv5qppA3wAdbC/cjG48NSRB4MXpYwGxChdGsJ9QbW77q46gV?=
 =?iso-8859-1?Q?cHhpupWUiQ5S/kEd6s8X9VRbDreCopRfUt1jDbNhnbvBg/I+zGLO9NifZ2?=
 =?iso-8859-1?Q?9ynFJsY5KQGZi+Io19BON74Yy5qMBhgrIbrreyH7ohiv8HoCKFa9RiCa7+?=
 =?iso-8859-1?Q?bYsm1nroms7KYUpYA+vdLsXwsclFz+/vsezUwPrv23vKsH7aGSgXVzeXYZ?=
 =?iso-8859-1?Q?VktwZ7sPNC5odTc5pC5n6ElHbHOb51dKoPKgRBsWvYEQw1JOCzI4PHaDHV?=
 =?iso-8859-1?Q?mbwmc/YR8KQoH3D8kW7QAjf5f2VerNL1sVPNkFvj5v8IF4jGDa5qY8pfJx?=
 =?iso-8859-1?Q?d/MgXNUR89WHx3KttQ68wUmpmvihNHyEiAb9IHOwXGATAdKzpYVwSlDghW?=
 =?iso-8859-1?Q?YJfjUWpr5G+k17pMIU5W40/DxYs0Sz4r8F81Cde6azfwArFakfxy+k7g?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c9a581-f669-44ac-34ff-08ddde74dcb8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 16:32:45.8506 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PTiXpOexcRTWeTqajd36onHaPj1Fe2NKcbRCRtDajXDairLE8e4sv1abAZduV5JMnFwod5QhB6E4QEH5EuHjtBz+M+61zRwjkTJEmKB63Ek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6654
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

On Mon, Aug 18, 2025 at 09:18:07AM -0700, Stephen Hemminger wrote:
> Use of comma as statement separator is discouraged and
> reported as warning by clang with -Wcomma
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> Acked-by: Chengwen Feng <fengchengwen@huawei.com>
> Acked-by: Morten Brørup <mb@smartsharesystems.com>
> ---
>  lib/ipsec/misc.h | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
