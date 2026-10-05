Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7ECCA5FFC
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 15:34:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C47CC4065A;
	Mon,  5 Oct 2026 17:34:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id EA98F4028E;
 Mon,  5 Oct 2026 17:34:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791214477; x=1822750477;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=7FeOmCmLdvdRoi1NM/Kjd3y0iJzKpjd66YPocLq2quQ=;
 b=Sch7ip+2P6XP9YBxKbs3TI4mvwyK3iTTishbyrMgob72FYGndPq3aEOb
 2puK5A5o4jpc79VIxeZraciQjutmdPz4a1ixcWYo2RI1E0t3888yQN+YV
 4AF4NPzLh75J83yH/Jm+wM9jK/C/A8c2nytr3VBf6kS80xSmUCkLti20i
 auRzYKD00UnaLEoZylfbEceQ16OdPeb0+p5YUJ1Q6Oxy8al7Jk1Ug8/Oz
 XJPtTLznSJVLnfdc/gezvvdBsCNH+lw0mqPjxo3cCKLr1R4cMn5NIwUTx
 hmaObmVS016hcTSHasfyCfLMnGqmDk0pKvjjDzFfGiwaheV+H1LT9WZaa A==;
X-CSE-ConnectionGUID: u/f3t6tFTJ6g/PWD/XTYbA==
X-CSE-MsgGUID: oZhAk/rrQ2u0QQKfZrNLaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="108267160"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="108267160"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 08:34:36 -0700
X-CSE-ConnectionGUID: AHaP55ODTvanWVk6Th9rYA==
X-CSE-MsgGUID: +EOvNsSHQjWL7i1smJ0joQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="303103683"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 08:34:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 08:34:36 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 08:34:36 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.65) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 08:34:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZSlGXY/Xws7s/lWDZtAYewoC5UcvCDH21GWHPjQph9bSwGCJkOYXZaVVCuCybALX+7WGTIgKwN2Vzd8rOUzRRzmyrVYcx2hsxjo/WgAUs9nXtESW72Is2AF/L9mYZ1QtTUWK3ieGwAhbpkW2Z12cDTYVuaARu/gYvhyEpiVSliNHmmj5eLb0KqQIA+N8Iwc/6BZXiIi0bYkKYN+qNXngYm/toigXc9yj85VZbzlFcunSGfvZnssG1T+x3hZmWhHlEaCuWQrkGAq1+i+bPbPxnth6txTbemJs6/qxZgXJxXDJm3qdrecgYsqmCOZKVtLwlW4VcDGnJH2q3Lr6IUNqvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJ7RLuiIWiFWfzWvlBxOeahZkDjOCbjDkDDI5u03nEs=;
 b=A/x4r1kP8pHwW71OrVuhcFESPr3tLEgQb1Zde8cgXgIOzHsxfZAccOZ5i3G7I1EoPLGGI/7aNFIENai1PhchdC9RLYoDo+M6Of38irH4h+q5Btm4Ij40XyVwLuH87A6oUdtsbNuKvYChjVvXO06hf9in8jQxtC0Gpjh5aKDAXuK9kRdimKuGNjm2nR6i5IzR38GN8xerbI76K2RkoaadRU8rKragW9NYMjsd3kWJo5bS3vJ2uVbcL8F0VrHwNNNe5pq3UPaljvzzfmGIvziODjPUgRMXPzOnQHWCw9Pj/AEvHYC2KiLT7ptqfidV3nua5ucQ0j8K2XnvhtfspB08aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SA1PR11MB796993.namprd11.prod.outlook.com (2603:10b6:806:51a::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 15:34:31 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0451.014; Mon, 5 Oct 2026
 15:34:31 +0000
Date: Mon, 5 Oct 2026 16:34:26 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
CC: <stable@dpdk.org>
Subject: Re: [PATCH] net/ice: ignore WRED parameters for tail drop in DCF
Message-ID: <asPDghS19etuUuoC@bricha3-mobl1.ger.corp.intel.com>
References: <20260914101003.55635-1-naa@amicon.ru>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260914101003.55635-1-naa@amicon.ru>
X-ClientProxiedBy: DU7P251CA0022.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::24) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SA1PR11MB796993:EE_
X-MS-Office365-Filtering-Correlation-Id: 77129f41-2841-43a0-a931-08df22f62696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: CKpgxQJbZpTu8f3EHu8rsbaCEs9rYZ1cXZJ5gEJda/yH3dX5PhAK71FD4YoY6uFPwerF6kz8/zOwtGoQ16H3McNjp7CIXJWIJfS7fcwxHLJ3h0lvG6FcBF4hU/6o5aGePh1W8e99Jl3Y747o4dQJf90pVtWu7lq7nmndjH0+8nm+6vfgoMrEblAVQHBODv08HPXQ6wm/zaGtBh2MQL2hXtBLu4eFZwJ0QOZdZ6tD9pCOhR+Yfs0KLoOs4dMVpwo7kBaj1YimRZsaY7wi2Ov4xzo2aaUccn7ISd20TgPBOT9mSLpkc4Pu2//8XNvxjCl7Y4w0gs9TQG2Qyao+U6OhUPDlBMI9dD7BnXwmUi21IJCR7pNQDh6hQ/OihrWoO73acefiC89sVazPGsJS8M4AZlv4JKLvUM1Wr3yuzmNGwcqONI5HaWIXTP4iO4JVDFtplTie0A11b9Laqtns+r6vGsk5gX8HUBZCTJ1e75p/b9s0e+Yd0cmrwwJj4Z0HUe253RyNOuxWLHV90Aoi7B/uBoyWKL4btQVNrYA9ePmTGP0SYPK9/fMaiihPMk2T+jPXuHujBQd3IswzzjceptUKAkb41AgR2wCimOI4yLVMAohNd2J6THN7j8qbzO4jJKcyOoMAWDhpL4RTaUCufLNKzdhTWttWs5Be/n+5/xcc1d4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yD6WITPPKliKEV4XhnYj4Hgqm8KSrFbkePIyx32xXEM5Qa8xRwb7X2ztegRR?=
 =?us-ascii?Q?MERzw7bxo8pkHicKzETFfjx+L9PXAeTIJfp0LxmeB9UZSDsjEeeH9/C0jJ9E?=
 =?us-ascii?Q?ddKaDUI9sX00WNyh8GtHWgn/Hwof3Ud9ZoA0uQZ58q2EO1SR30ufPg4PEo9U?=
 =?us-ascii?Q?vfsn6ye0KyVt0/0j8pCMnMpwwQV9GXsKyg/2mOFzgi9nM7Egf6dZYxqnsRT0?=
 =?us-ascii?Q?7bujF0yrK8GGZx3y8Dzunx2e2Nfi/bKBhcRppceti9vx3RtZsgNXLyqaHC/l?=
 =?us-ascii?Q?WOXV+uLlGoAxSU7ZhehwQnt+MKrEFFG8Yir7DftHw5QSCkjKZEls05yPb7gb?=
 =?us-ascii?Q?zM1MEcV8+5jiY/5wSm/iR3vORhj2VwJaRgbpqVyTmeBQ1/+B8EUkmhxz1PNw?=
 =?us-ascii?Q?v4i6SP+0NJw3AgV4lDrc/r6F/KBntofViSYDhHsN9EL4sjD4l6GGEPNUygKe?=
 =?us-ascii?Q?EevofIGUz3FVqZ9tH783K5K9ObbpguDM9FiFKY6gIa03ExEsLYgS3HRMNo44?=
 =?us-ascii?Q?bkxJbMgNgj0cVri3488d4ZfgSN6uOBUVHVv70wYL4eGgJZAiver9FYwFZRL6?=
 =?us-ascii?Q?JZK/Y2zkEur/IUV2THhfD6xvR5VAtIJ60igiObnMcz4WpzOTtl4UGXzzrh2C?=
 =?us-ascii?Q?eUlkW+KFodXff349rlX1doVK0cjuITdWoopBQp9zisZhoFp1vbGZ5sdxXv3v?=
 =?us-ascii?Q?S1zy9qpm2U+M6NN5ZwTpAHuLUEUcHf5SxN6VYmR3A0TCdgtiPYlNLhQu6TL3?=
 =?us-ascii?Q?m1zQwMYpEg0fq4rkiN87101jTPgjmsW80Jb4UInT3sHDstuFh2uQHsM5uIYt?=
 =?us-ascii?Q?Xz3pjvBdJDkZOdl2J93hIF06pLMpbDtR9CQIRkNZZsrWH95Pujc+fWl2ewlb?=
 =?us-ascii?Q?UBHnk3Xu5RzD/QrQ8j+QRp0dAryxZFS2DmP3/lbzxh2i464jzCiTSuzTCSzV?=
 =?us-ascii?Q?E103Mk/Lz0FqW4QO+CK2w2DLCJesP15vX32CvSVnmqzolv0AfhHt9ctxzOnC?=
 =?us-ascii?Q?7ruct3RyN1Z+6rPYe103OSqkzJdQrNdK17Wyv4Rahn3mpuKrwMYfSVD39uw+?=
 =?us-ascii?Q?uKNIC4eLUINRdcX5OddSBh65jf5WodGmpQrBzZ2zHliiehxDQXe+fQlCxJTx?=
 =?us-ascii?Q?hcu0zRqeD4ImF3OktR8DfkTQQOhtky15X/tivdbSI2iQTf+95j8hrfL0Q+vr?=
 =?us-ascii?Q?8Yk+XeyhO0bti/0pCnNZl0UYjmMIS14ByFZtADWborIctX/Au4DgRO4j6Ipy?=
 =?us-ascii?Q?UdLw2BLsMYj03XUCHjC9BXCJn2+QCUCEy5gSoN+obf+ne6nRKRKy3nhvlfoc?=
 =?us-ascii?Q?ner6z4amZfFYx09OlIVSS/U77eVVUhZWnJHLCJdKrxBVj33tVtG8S1UwyOXp?=
 =?us-ascii?Q?vJc642+mrE3GX/AH/I4hB8hJJg3SC0utxeybHdVL2RY1ztfAiTwCgWDto0s8?=
 =?us-ascii?Q?nsijuWIvWDfRL2ny30aw03Nhs+O3IDL4oEAmUcbwHN10TYSuEh74s27FpmTz?=
 =?us-ascii?Q?S8J5lXU7M39+oKJhV0ZacRZXxrqhEwIAWn4U3Cx24Rwlg61VjBBkWWwJtF0j?=
 =?us-ascii?Q?xFBG3QOW/pnU401U+NJ0J/aSazGYLEUzctxr7llfvnI4L6L8vFMuuCwPL3gc?=
 =?us-ascii?Q?UiuNSK1Lv3yABUouG8jfo90B+/I6ZZxFItsHHLCXOHPGxsdY163sArigeWTU?=
 =?us-ascii?Q?grzwfPXo9ihwOU2R+V6MFdZuUcF+HBTPycXBw2H55qXejaZSra8zIB1AqF8n?=
 =?us-ascii?Q?EuwwNYBTFLhPIFjqJtGTutlkD9Gb9ok=3D?=
X-Exchange-RoutingPolicyChecked: LpAZy1rl5s9vJAgd6rAphok2Zzt+FJ+Wa+lhg6N3kdoN37VkGTMDs2MH8TS8QvnpV/OOinz6tZbagb1BP6/o5hwDcZ34Tpkq4tIeWYkeIV1oVSQne0Mmq5+Gbu4q5MMINFd04tisAwLVFUrEFgwzoviwBFwFCAkgthzta25jvO7WUuHGDRVEHi9d/ARg860AAFDQcQuNulNTmlHftpD0sQMyy75p6gajGK/qLuBfG0TzE79QJ2Yr9fdMFSFAJR1HL0UaK2OAoMwU1+udcPIqrwiZAmu5RwfXYw3Odj1fJ5+hLFSrZRIIohOEVgy6aoUx/Ym2K2si1hf/V9VYrLYNOw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 77129f41-2841-43a0-a931-08df22f62696
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 15:34:31.6017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RpTlzKVsFV0cBAJ2WTegp5TeZrunrjKFfOoYoQlJdZh43L+Qa0h8hB89RqWcxdy7DCUoo1aXdrJk7P+0F5hMcsT5xUBS+1MdchmS6c/fllA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB796993
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

On Mon, Sep 14, 2026 at 01:10:03PM +0300, Artem Novikov wrote:
> The traffic management API defines leaf WRED parameters as valid only
> when the congestion management mode is WRED. DCF only accepts tail drop,
> but still validates the WRED profile and shared contexts. A tail-drop
> node with a zero-initialized, unused WRED profile is therefore rejected
> unless the application supplies RTE_TM_WRED_PROFILE_ID_NONE.
> 
> Compare the mode explicitly against RTE_TM_CMAN_TAIL_DROP and reject
> unsupported modes with a precise error message. Do not validate WRED
> parameters for the supported tail-drop mode.
> 
> Fixes: 3a6bfc37eaf4 ("net/ice: support QoS config VF bandwidth in DCF")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Artem Novikov <naa@amicon.ru>
> ---
>  drivers/net/intel/ice/ice_dcf_sched.c | 23 ++---------------------
>  1 file changed, 2 insertions(+), 21 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel

/Bruce

