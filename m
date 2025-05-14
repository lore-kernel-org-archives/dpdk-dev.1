Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B68C3ABD8
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 May 2025 13:30:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA91C402E5;
	Wed, 14 May 2025 15:30:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 98BAA402C8
 for <dev@dpdk.org>; Wed, 14 May 2025 15:30:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747229433; x=1778765433;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=sj9izVMqLouVg44oQhw7h9tgkMTa7sC92Yx9uNFQz6g=;
 b=lLmXVr8CxAnP8TR+053/ppbpTMChmc2Y8pg50hP4hTk31TORp6yFGJ1q
 uhfGz5RQgJq2wUxd5Ao1CgEfFmzj5AGoCOGZNfqrhjPWDAqgkwrf9yfCL
 /xaOKBY0zkf8zhp7LR3ryepDouRMzDVwBkN03UR+G7e3AHPUsYvTvHoOh
 KqRyfgRf/15HUk/LsnekhEg97OBbp5Ch5PUwAsqzjWJtE7u6PXKOd0noX
 q8xTCaL+OM2wuSB5hQWyE4pAebxOrZWMxyXu2Xjlq71L/OB2e6d8X7otR
 eclU+mMZsa4criMpcJPOFDyqIbnbw+4+kAZe76qCvnQpQuG+idrkkwVml A==;
X-CSE-ConnectionGUID: R7zeJ06RRS+hXEEjXbcAhg==
X-CSE-MsgGUID: al+YCpODQLeDTg8r3C1c2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="59783066"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; d="scan'208";a="59783066"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 06:30:32 -0700
X-CSE-ConnectionGUID: eh6/QQEvQKubHJe0DwPgaQ==
X-CSE-MsgGUID: KIlHl22jSVq3WvlLOZAOng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; d="scan'208";a="142911794"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 06:30:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 14 May 2025 06:30:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 14 May 2025 06:30:32 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 14 May 2025 06:30:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mkp0Lym9kZr+ERs4bektnQ7BKCn60Ax2Lw8SKI3QVlEo533SEQYoCp0SDlFk2RxsWoRoV8txDyKGiqPkpic5NuCNG1jFaaFwO5pq9A/c0rWvwKlBkI70YAcU7u4FD6Pfdc3EPU4lcl8z7AFjj1BmAByQn3QDO/HQW4eH2Fhk1S5da4er7zDYGJxeUNar4U4xepbQsjWCc/70bmb1GczviOXJn8/zuFHHhEYHlLJiZrLskMB+C7in8xQQlkptUcfDVlAEGlwFQRcu4tP8evTHQq07O9CdsP+JdWFfTz5g1f1NQd4Ju+PIiF/CyodmJVuys6udzWu06lzTKJVgDHGbNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wvVJK4EIT1jlIeyogDhzzjObqvXHlMUDhpZ5FLCT+I=;
 b=ZW4Bs2u1vLm6UxKctLokN1pqxclsS4F1AdmTz2LKsjILeXcIBl13DJqh7qUXRNXtFyQyqr2t+3lIFjM1g0JFzEZcHiefH0vYIi1b7JzNZ1xEtQmR7/Ou2xFuXVFxRG3OexEjKcjIm93gsQnoyIyk6Sf/aD0Kba0leVWgmE7I9uATjyoaqrnwqz/50jPS1MEGSJLKdORhTTdmYXyaoHmGkDpejrlU+UTlIm7E2pkMyV4+kxG/CaT1OpMJVx3JYXABHnBh/wVk5/r3OCMnYJBJoyBft7xMtpUl6x7WBbrOGeswP/lX+/6kAhTL/EL8/2TmigEVrMSotjNh3RdTsJha8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by PH7PR11MB6931.namprd11.prod.outlook.com (2603:10b6:510:206::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 13:29:49 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%5]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 13:29:49 +0000
Date: Wed, 14 May 2025 14:29:44 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Aman Singh <aman.deep.singh@intel.com>
Subject: Re: [PATCH v1 2/2] app/testpmd: sort commands by help string
Message-ID: <aCSayGXBlEC-KYa3@bricha3-mobl1.ger.corp.intel.com>
References: <9d6e0ff75abe0185c5a03aecba3269668860a1f7.1747227723.git.anatoly.burakov@intel.com>
 <608636ba99de43497d42f41787fec7005cc2e52b.1747227723.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <608636ba99de43497d42f41787fec7005cc2e52b.1747227723.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0006.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::13) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|PH7PR11MB6931:EE_
X-MS-Office365-Filtering-Correlation-Id: 343d3bb2-8efc-4b22-7aba-08dd92eb667e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6G+vbmF+hgxTrWbouQNkToZDjCko5LJ48J6Ru7Lneegm3kJU0sVHM9DrMur3?=
 =?us-ascii?Q?CDIj0003Qf+61zFuTjLR6Giv7UQAf6RtID0E6sqFi7Kpc6FaPOpCIzDlUFOL?=
 =?us-ascii?Q?gLlWTNB+13zwhXn6wSKvUXWwTgFH/32Q/yyHRA4XK3KKmeEaO5pmNJ22tsvB?=
 =?us-ascii?Q?euKmjl1DLcSJVYW+NUNbC7qJrnWudU+EPvEffhfKsRz8jSjvZB6uOdwvj0Z0?=
 =?us-ascii?Q?rW8H5Q3QXzG25ja7Lgd6fXRuR6Nt6KNKsEo7PsAxjr6icmBo7cFhkPqPf4az?=
 =?us-ascii?Q?bwrS4CnuJ3uUsudg33vbkgXRIiyY4LUB1o8bXpNRVXgzSxB1g1RlumraDo00?=
 =?us-ascii?Q?4vw20dAgm0ww8EkeKqcaAzeyywvVgPlfPJlu6sVwPpDpilax57I1ooGhNnDX?=
 =?us-ascii?Q?hHZ0lJNITatFaPLZ62tYIVY5ue2ZENGoVpBTV7Enb71fYUkPihvGWXKijHay?=
 =?us-ascii?Q?vKN8A6PSgPmD2gq1tXu+2OVYHDQ1PAI3wSgfRhnFT6qTjJRH8wK9/3PHlGnR?=
 =?us-ascii?Q?zQgzu2VJq+KM5wYnWGjyLoYTGAZ4MO4hXowF7NSaBVJeG5+VrlFnrGbTgUxt?=
 =?us-ascii?Q?iQvZ1bUSriGapJxkgLyZdSAelAWEz90LISePUC4dKZWhj+PevLDRO+wpKQiC?=
 =?us-ascii?Q?85LXhsEkSiIaMV3yFGEN1MTSfpcKUAs1dQq3CuMKk2Z2dw2nUJ6hN8Po17bl?=
 =?us-ascii?Q?0nPUEwCa21YqoRqmsHf3S62pXIl/QTGgsE+STZwVbddOmTi9m7US0QdYtcSf?=
 =?us-ascii?Q?xHGp3cN2wCGk3HQ4aam5zPm4cI3IebT3V2BYzZzkQpxCYjpeWhZDdfGOXzxb?=
 =?us-ascii?Q?k6W1azpMPkPqghDZnbmXW+5UEJtvRpItV0G3MBpGDQqOf/Fh4h4m2O4P5+/b?=
 =?us-ascii?Q?GRW4OPQk3XLA0dB69c3VYbm2taRuM1et5XMnUPIPHcdsKp9LuaWBL9OxuqtO?=
 =?us-ascii?Q?a3Nq0SpI6F+3/Ivl0XLU68zzWTUtTQxaF5wlXi8fn2iQXhDG5Ngo3dSjR9jR?=
 =?us-ascii?Q?YRRqKlBVNMAvb2qUaXegi+YFVl+bimgYkn7TiIwA5bameR/vhELkVCVRl31Q?=
 =?us-ascii?Q?87qNcHRXSJ9/CENauVXwYLDquurAToE0anw03D3OVKIO39eq9Glrg6e2VYF0?=
 =?us-ascii?Q?DQbRR+UevLoGQlexaO62QmtR2aFdv6HS/jXeG/Ho4RA6tsZ+0jwWll6JvyPG?=
 =?us-ascii?Q?cHZg/SFo9QNgmkakPocomKqNmZWQ9hc9sx7rD1BQz9a9qpJH8r6SwKwZxpZe?=
 =?us-ascii?Q?4KMt9kdHlEHXJTa3Fv7J1AGGk95084mzxT+jtVUItvBy8tnZYJxujo6WVZBc?=
 =?us-ascii?Q?joz41ccn+2Y+zjzROLF5Qq87cgaMDY2zPSZP8VwOSsjR1jqIImOg7YTY5cmK?=
 =?us-ascii?Q?dE1BEtMCOQUNiMrPEMObhYdE/QRUIE3CWXojhURCrhjDMjP2nw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VfxhrcyCB5z23E7yluUC9KqOFtzTMSzWCpRtnW4QBPv/YofJy5vRotuzmGvx?=
 =?us-ascii?Q?uoomEOSjXSihS8+GmqjSvJnDFy13gSz880xu9m6rrEWZdwkmPtLe29+MzVK+?=
 =?us-ascii?Q?VfLrELP71/M9Et+ackqWZTDvM6fbk92PWXoIH6DoxYHQqF2egUe4wYyru1TV?=
 =?us-ascii?Q?6ZwwDRxo7g8Gr9FpB7Gn1PUqjONgd6rVUTIZd5t/gC40f/A4CPKZ4z4cYq1v?=
 =?us-ascii?Q?meaqAr6ES3uU/rd7MShj1tehH0ZpyMuLQTMxAKXGgOPbtpgC21TOUQlbPD0T?=
 =?us-ascii?Q?VOOIlaXr7I+GG23xxeLuaUm3KQM1Un9QZ8PubV4VWQ3RFhFJPZAkzfxpYBDu?=
 =?us-ascii?Q?JsZjnc/WtNVM/nMHicRgD+eNTumZkmWFPnEfFDyWj9PX8n/qLk7qoJ12OO5p?=
 =?us-ascii?Q?FjEG+TJ6LwwB6v4hdoi/5ooXAKhgIdv+kn8O8k831+4XZLhdubFiJOG6Ugd1?=
 =?us-ascii?Q?M5+jivcY+x00D7dBKhvRsL5GDcsWGS3Vhl3M3jemCkpxkGCbgP1MDBlITUEj?=
 =?us-ascii?Q?IWrrceeX7C1KYKK2gGwQGLZDI4sdx1pwNGdFHZ13P2Y5lm4EsONNiDmYC0fX?=
 =?us-ascii?Q?sapSj9pftJkos+c9v7jK507rlU0P6Wif1Va4YMqeeD9c7tGyVDqxVuAraaYk?=
 =?us-ascii?Q?49k+EbY8cdz09DlX24xdpftpt7maOpR7oY52X6uf/JSmJsJVs1AK9AhTHbq7?=
 =?us-ascii?Q?x78VXDssF6reaIg+/+6OiwOKJDu/x/3pnqA9oUBzW2mieZA28iw/tgNip/HL?=
 =?us-ascii?Q?iDlGjlos6xB/1E2oSXN3UGG6pKGfDjD54TYxUQqoa+uxuFFQe+8919aJ1ltg?=
 =?us-ascii?Q?Uq0nt/7rOYqLSq899aIyaqs6vd8oLihWYjnsrrXUKDT8Jo28CSSiY19G61xx?=
 =?us-ascii?Q?pdH7iqP4ux8t2Wv8Jxj8wHLJy0rxeCRA/SjclLRTuaKwpTX6V3ifX21dKoh+?=
 =?us-ascii?Q?3fIan/5MBsfzjOzuvdOFAAjnrW5gCgNm6afxy+QK8JCAoUx/yU5USO3zbTau?=
 =?us-ascii?Q?sV2IFm3MF5YrcmEOyqPCUBsKC/MUolGLtvErlF4q0a5eBDDkcPp9fwUmKF+/?=
 =?us-ascii?Q?+0k1e6AWQva8lxYkjuOfN4zzBX8Xb6hLJF+lPtZHkkvneckmOI08S4ER1ujr?=
 =?us-ascii?Q?EKYA4avo7r3C5JAnFUu9XvPm2xNTiuAnsLCVDx6sN6mRs4p9nHFZd6nKKqMP?=
 =?us-ascii?Q?UhwIxNFC5Mn+bBQYF0rPq4k1HlD2ZuruJpt4qV+spsdqc+vBDzRdeNpqAng2?=
 =?us-ascii?Q?/pq+jAaY+TLEvD+B99CJa0/stWKAP7PUmAXCB9Z6tOQP4LupAgjOZClLn2FU?=
 =?us-ascii?Q?bEaM7zf48k03iz/tVSS7ehWh3noIRGyDu/JFFm6FlVxVoGuEi24SxfYiDBer?=
 =?us-ascii?Q?Xw0IvLjRp8+OQcG1c23SttEL9yUAqcMc/oySPREq5GLc5MmKoT6JcpOYiayJ?=
 =?us-ascii?Q?+gixhpKAPWRnah8z22UdGI1JB9gQcIZf4kf6IsKq77z5ISQEqCtax2MdT0x3?=
 =?us-ascii?Q?/GhiJS8K5YSr/H6Cbp/pOqK3fsn5AtUWKlwDmKJfckekrdyHu0jNErKf2I/3?=
 =?us-ascii?Q?BSslcNH7KWJXSj8gwt96Xl8e8ix70ZAU1ctgftAphFSB/YkTNU7mD2JgSdT/?=
 =?us-ascii?Q?7g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 343d3bb2-8efc-4b22-7aba-08dd92eb667e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 13:29:49.2611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pTNXCl48Bp2a1SUHyQS0dRxwpusac3RiO6p2DJyUXBNnNatHBcZg6tjW+E4+aztTSs5kzsqkPERP8VSXvLiCSc4qmxtReFu2DBB5vUA2DE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6931
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

On Wed, May 14, 2025 at 02:02:12PM +0100, Anatoly Burakov wrote:
> When using '?' to find commands, it occasionally is difficult to find the
> needed commands because all commands are not in alphabetical order, but
> rather can be ordered rather arbitrarily.
> 
> To address this, use help string to order commands. This sacrifices some
> amount of grouping (i.e. when tm commands go one after another), but may
> improve discoverability (and most similar commands tend to have similar
> help strings and will be located closer together anyway).
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  app/test-pmd/cmdline.c | 82 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
> 

+1 to sorting
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

