Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F55E81A5A
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 17:16:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C147D40296;
	Mon, 16 Feb 2026 18:16:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 1308540289
 for <dev@dpdk.org>; Mon, 16 Feb 2026 18:16:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771262216; x=1802798216;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Aj20ZAXxaAGl+TUeotgMbV4zJjTfhCPazFH5YDQFPYQ=;
 b=lAwX01fMTRhLakxto6gWD0dhYUMlBOo+XQnAjIv4ohzyJXPKDwNK5crZ
 M6n7vhNrO+E3+48IqJj5xJo4wrdGCwnC3Zp3v+BB4SWZsBWl2g+Y5mMlP
 ZfP4eZHyF1t/2d3ZewFZH8CIqaQ7zlsYwxq4M8JHEHpi35nM0cjEyqvXr
 6vUWs8tKxPdTbndDwg5pGqKk9enDHonJwzDjOKixzkMKp2nWERFScdv/2
 iw8EEqmNH40aTxDgXdunhh0Oh6vBJsU+h3dTaMBDWXOq51Wy8P/IcWc8E
 sprGl02FLe5SX8T8sHl5rQ9s8i9dDmGtTRkYCSVYT6rbELfV5uAj09ufo w==;
X-CSE-ConnectionGUID: 0a3oB4X0RGSB2lt82elZ3Q==
X-CSE-MsgGUID: aVceBCRvTuajmTqpj/DW/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="94975912"
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="94975912"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:16:55 -0800
X-CSE-ConnectionGUID: CXqe3XK/RPik2VCMbFAUHQ==
X-CSE-MsgGUID: 4Eul7xi/Qp2i21C6SG0lTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="212966726"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:16:54 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:16:54 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 16 Feb 2026 09:16:54 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.68) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:16:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8Qwx/q77QAh51pa48K8+7jJXVzx9EHL9E+ZsheR23X1Hftbgs3UbQrmeBPl+sy38TW3xf/6NzgplnjG7DP8kaDmmD7aETEgQXG7lIR8+dH1pupkqRDoT0pNQWd8wnc5kraocDF7EJyjH7RUc5EPa+IeOakwhoQcfokakgFUPGewm9NMsHENc+ZSCJgsXpnoliGMdRe1XuUsfVBxTCSuxlcXZmzSHD6Fdwto7QUa9cmdVBJ1Rd5dvIAvYzneoIHt9X4/SRmyTQbUw6wMQhfWMmQDPg9ePMFY4Y4ToPAmFlPH7+K26k0rQn156jnPDpnfBIZKnl+FwxZEO926DStkYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhwQ6fYz2zrx52YpZTJikGE48ij9poFMofOVUK2OPbE=;
 b=llKrPFvV5VuwqMQ2BjPGhkOIlDNBug9vdBgGtrLFvkrTLoZ0Yvb78jZ/oYpE/oIUzF8fQgpJMXjQfWRp1kLheUR1ZBNIgvm6ZkEzA6EeFmSi8q1a8vE9De4PgMKrk8JQsO6B9DGPSCK5qj27glX0o9CMBnGwai4UHYuAVYIQEK0+xkbe6I2/6Q4SrVaqNmgF5kURbz2Je++yEIDEGkIlI5ZrzgCGSUnVf7Np+9ul/j1TBZSt+xREz2gDbEFdY6Aimcpaik3Sc6nlKbHbHuGZyPEmumKqQVNuloU3ww7RyOsuhFCciqU5poNozHXQ6W1cHgeLLn1R/QSY5USxxWR9pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ5PPF7CF5FEA5F.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::838) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Mon, 16 Feb
 2026 17:16:43 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 17:16:43 +0000
Date: Mon, 16 Feb 2026 17:16:39 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v4 16/27] net/iavf: remove remnants of pipeline mode
Message-ID: <aZNQ9zSmorlmiSmo@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1770978324.git.anatoly.burakov@intel.com>
 <cover.1770978324.git.anatoly.burakov@intel.com>
 <d54db10b682851454ef5ec632e415225dae6b993.1770978324.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d54db10b682851454ef5ec632e415225dae6b993.1770978324.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0164.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ5PPF7CF5FEA5F:EE_
X-MS-Office365-Filtering-Correlation-Id: 583ca017-e4bf-430a-4213-08de6d7f282a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AiY2GW/Q8J3qO6wnHvggJRqSPww7gSKsIqUKJvUqK1dt2BOMjpdYBpfBFhG7?=
 =?us-ascii?Q?3ZhIfeIhmhENJr4IGsC2R+Nphc04dsa1E7kT2UXv9GIoD9bVFVRzsNlYrtJU?=
 =?us-ascii?Q?M7oJIWgty8/vaigGtfDpPFdrBQpi0SGvWl7h/du64/8vHJLB+YVR+uuqKS0b?=
 =?us-ascii?Q?V5eFFuO0VANzvVJJnQ2v2Dh1kAbjZW5uetHH6wl1RbiZodoeYPONw7iizaUT?=
 =?us-ascii?Q?95Ez9UhhuYc7vye4RMVuxWvKZc2nALSQSiJNe9To3JL4CRDnSHVgYOyowgBs?=
 =?us-ascii?Q?MKBWHw84RsxOyjwJZBsLlsmVC5FHkV94T2lsyv4VWsBDpvxBMJnWYhWTFDbi?=
 =?us-ascii?Q?2Z1S7LWNvpbvTuEjFKUP7JlYN4FfIxMmQN6QaKH2EeaY+PMYYWo9w2e1qvuV?=
 =?us-ascii?Q?qywYUrvGrFWX7msqxVtxGefU4BKjD7hVt0OT63PgTkQDV1wAJRb9BU1y9S10?=
 =?us-ascii?Q?Pn+QHU6QpzVpMM7ih+cljLJwU8+P1BB2jKWxCp12G25Iis0+P36R038P9wTd?=
 =?us-ascii?Q?fQVe/bxONUry0Z2jpkjzDKPwtyVJW8cHqfzyCfay4XmN8YZPKK7tSpbOZNoq?=
 =?us-ascii?Q?1cykR7yO4OULSFt8eUy67n3deyDclb+p9xttLD52cpAsEUccCj9tnkqYyy8Z?=
 =?us-ascii?Q?W4KYZbRAhcq1Y/xoPzQn7D7uAZCD4mlJ8KUcq++GMKDm5N6W9nYiiqwF0k7U?=
 =?us-ascii?Q?U/nPNDZAY2Flr84kxXnQmFi+BAdQcqWYrcwwPAk/Gn8o8rCOwRqjT7D11sp3?=
 =?us-ascii?Q?vUnrG++O2cEWDcweh4uQUlh96GHCWuU0ChT7XqYrzqrL5S712waB/0BoWYAz?=
 =?us-ascii?Q?qNqNKNay+bQmlM/iqMsV73lgAJl0oRYPOUdGPc0abdMV9TgUv8n/mXHlBd8d?=
 =?us-ascii?Q?5NQ1yiscPEV8QsaEFKgRiSIpM6R9nUuKIOAkfmb7t8Oe9ZQ6oGdakgH7uMW7?=
 =?us-ascii?Q?xhFRy99vuiU48OkaCG30M39gHgtlIzTT9UpwLvF7+p5lp4g/Gwc/MI8RTD/f?=
 =?us-ascii?Q?2LAzUr3V7JWtsHANxhU4a1saROAGmJNXQMvPfChuMgfMwD2Fx6OS34so3EUL?=
 =?us-ascii?Q?EwqC/u6MY/s3663ifpqVDg5q6+F0cSCncqSGBt7ve0jUbC03RK9j6GJXWreK?=
 =?us-ascii?Q?myKNxby5HT1rcWf/DLyDoOVQ4SWsu7V8Wz5ia7s3de/UaGAWIV/NmDCk3dcz?=
 =?us-ascii?Q?QsqwOKF8e7swy6CzABkxHgGhnTGYbj7t0KcURnJuD7WbdKuEAv+RHnxiYiJu?=
 =?us-ascii?Q?4u/rZRoqzVKAno6cCMn/pFtp1ngywAHGrFT08TVYL5qN6vXPZES8Rg+Wzaye?=
 =?us-ascii?Q?+D0Cg6yks1GKC5K+O2KGhQm8nxp0RuxY9IMKDBzlnNqhOk+KzpCgstFTOGQj?=
 =?us-ascii?Q?gruoWFmLX31oZUiTLVnBnXrWyxvvbB/ULuNQMCRHbZ6uAyZ49keg+x+5DPj3?=
 =?us-ascii?Q?xb/r64j72IwAqC6MYLfJ7n9MS3wpucTm5zmRZahFIq/ZmDSfNLmD0tVyNHRZ?=
 =?us-ascii?Q?B356T+T0ENKwUIuNozm+ho/41ELSStGkARSjHLBVwxYHEOMlBblMhUHEozKl?=
 =?us-ascii?Q?vGd/xingRk9ph8rM4nY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X8Wc8F74Pb+GQApvMIvNDlACif5rp6x5VnyU4Dcsdc8dpA5hEkiSmbb+FoQJ?=
 =?us-ascii?Q?hKECAhd5UU4DxmdOnY4kY7IkMh8iyWJVt772o2Q9mf+0BNCtmREFjaW99FQt?=
 =?us-ascii?Q?A/Dpp11vzfjf86qEPMzDLDNIix6/0Y4ffM7RpnPc1HbpYrxq9tjCRbKHHMCN?=
 =?us-ascii?Q?qicgAkkhdSSbk5Slt3HbZpoB4pqFmh3UTCsuaxpM+mHq6fQe9Vs8XFNh8vYU?=
 =?us-ascii?Q?r1TfD5KeIqOuds7UiDeYMQMsOFnoBPjO1UkcikH+57g2KxGU8qVDhYRf/nVy?=
 =?us-ascii?Q?V3ZtD7pQrwjnDh2+5F/nRV2/kyZSyUlChituI9HTEEPZAqlBY8sb2KMJQlPp?=
 =?us-ascii?Q?6FQaM7q1dlvevLXF7mCA+86qQJW/zYAX2L4eSOgrOoq33dO2rw1bra5Iy2I1?=
 =?us-ascii?Q?6OaCnkiZxkM3v2E6ZVwAMc73vXfFhTrNJUi16E7nwYlJBvIbm51GteXvnCpA?=
 =?us-ascii?Q?jPEEbNGEs/HIC2UHnK6E+L5t7SarMnaOWP69hdAMkzZqt1d3g7m2oPf0lZ3w?=
 =?us-ascii?Q?6G6uJvlSpc2MbzecxWYFaLCKYSOghUwjKonG1LHfJ23RfFHKjzmfKZ5Kppvg?=
 =?us-ascii?Q?vOM+i2owyTqi6QvfRTDEskDWPLTxH95p/jNrjrgqUdZYqoClbZzTpxrf1ZFO?=
 =?us-ascii?Q?hx3FSbfuIVaTuD9I5jEGJnWSc4c1I2CkuHXjgwvTGPTMys8bD/zLOvC5xX7p?=
 =?us-ascii?Q?s0cY0+3Viy9CxAnGdKW4O84IIzAYMao/VQebnrnl+UzC2uo4xZdFWc5/iOt2?=
 =?us-ascii?Q?1PoaKT/6vaWaOQ1p9D/92sh79unvnXO1nDWYUbDyZ310VEPLECVGqk3FFqcB?=
 =?us-ascii?Q?yJi7mTOrbdUEXS71ijEj4wOplhBM/Wey8Poq+EMvq+njRtKSJzf/NtZwKT8x?=
 =?us-ascii?Q?Heujqf99hYKLtTtzQH7vbwUJZkrsR0SLiBOB0Y3uN0MetcVzut7RypS8uuZF?=
 =?us-ascii?Q?G1FFr88TOWNAv954h+5dkoojhmoLxe0p1QkhPdZayCBY0hWRp9c9yS0oVu7M?=
 =?us-ascii?Q?rdrMrHVGiCqjIB9JYcGw246GgkS/6vOagbA9/1KxpikQZ6ZiHuTX+E/j30Yz?=
 =?us-ascii?Q?hrAujOuNofAFd1UgHaMDKvPOxbzQV1vnhljPxZp4d6SLvn116jwx90PraKQq?=
 =?us-ascii?Q?IhMQGgKGkOFA2AQ8SmSjl7FPJhrR144xhq3IsgkyJS3docrYSyLS2S36/yKD?=
 =?us-ascii?Q?YSwNJ7vaJAR89TTNd2kUBKSlrlklAwnvXCq9jcAk58Yo4lpIQRHKWki3jf6F?=
 =?us-ascii?Q?mt2VVDzkCt2cO2W0rhr2AIBKnOrfb55dTmy7xnG3E7hI6QUUlIeC/02Nz83M?=
 =?us-ascii?Q?vPHpesZdGAlG+0FX71WNEqObZ7cHcvklxnbekDneCQOeuzPx+FBIYoBjU045?=
 =?us-ascii?Q?z7feFRjVHvTOSrOXd0MBlpyX4R5oUjFDx4K6IynNxO+uWlspp7O1jmspIvEH?=
 =?us-ascii?Q?qrSq1GUKJ6gh8WvOUreGiQAHe/eqtXcFW5agf0Ha6rF7nQUGoxorijp9TbHX?=
 =?us-ascii?Q?iXXp4yobxzXgmiOAL8kLliQbt6VkLtCfiDfUkJqSQH2xBr9w299XNAngkBD/?=
 =?us-ascii?Q?/vM6uGY7WuFu5N3iQcullXY587bAaoQmWTn7NWcKmBXU9JrkBMxoI31ujm5V?=
 =?us-ascii?Q?dfdqHdIzIES/Dl8HtVM37YLNDoPpXucdAQQMk+RnggQpqaKF80QL2SGfyNfl?=
 =?us-ascii?Q?cC1NcgFqUbBcsmrlCAihr7yh79DH5NC+oaJyRNalZs0CnXtfnor2CGK8zd6H?=
 =?us-ascii?Q?Gm3NJSRC9Bird+rkVa73NAHAwG3hIM8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 583ca017-e4bf-430a-4213-08de6d7f282a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 17:16:43.6899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TbOzZRqJ8loX1Vd24CUz4i0xKintViAQAPfbbCuc8wDST7Z7e7yUoqT9d8f65WPAhxQDvcr34/Rxaa/h8fgHYGtrB/r4gfArUiG2JHOL24E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7CF5FEA5F
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

On Fri, Feb 13, 2026 at 10:26:27AM +0000, Anatoly Burakov wrote:
> When pipeline mode was removed, some of the things used by pipelines were
> left in the code. Remove them as they are unused.
> 

This needs a fixes tag to point to the removal.

> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_fdir.c         |  1 -
>  drivers/net/intel/iavf/iavf_fsub.c         |  1 -
>  drivers/net/intel/iavf/iavf_generic_flow.h | 15 ---------------
>  drivers/net/intel/iavf/iavf_hash.c         |  1 -
>  drivers/net/intel/iavf/iavf_ipsec_crypto.c |  1 -
>  5 files changed, 19 deletions(-)
> 
