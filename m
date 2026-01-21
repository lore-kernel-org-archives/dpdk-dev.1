Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DCCC44536
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 16:21:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8E40427C5;
	Wed, 21 Jan 2026 17:21:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id E25A040261;
 Wed, 21 Jan 2026 17:21:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769012468; x=1800548468;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=mehbYCRGK6jjei4tE4SBjuB1JqXBupQaK3i6Na1zif0=;
 b=Iy50/GX0nYNKdHIECUXy+QUwE5c07ZoTQcZxCa/nXIyXCBXFcJYT5XB0
 rWKBNJ15xNIlb89TAaB0DWP5fCbYo47fwbNo/CepzXKtrKSFYddCnkjYl
 3IoCBdE7MIB9b/EIW7rxomAZPfbTzyN1kKJaA2z7RA23TAcgNNL+Dsic5
 rQLZLBmj85OU6Db9laAv9wwsUt9cOfhGLuIU2ICjl/I7N1zYiB6KANk+n
 Mah1XTmBumFI7KbPJx/WxE2rRGERn6x9V8kLS/IxnPom9cvKxDNwMPudw
 BCtUc40aMXWekv7PBFaXp2XYDCZwE+1UDLENwjNfKFiNue1JIHkE7QDqS w==;
X-CSE-ConnectionGUID: KAmXV1fKTZWYGGOp6Aq5Xg==
X-CSE-MsgGUID: zhZQJa2HSEWSYQrVt19JXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="70212900"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; d="scan'208";a="70212900"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2026 08:21:07 -0800
X-CSE-ConnectionGUID: F7BMEafLT5q5wmeCLlm83A==
X-CSE-MsgGUID: PDF21aYtTBGmqGXvBhePfA==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2026 08:21:07 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 08:20:55 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 21 Jan 2026 08:20:55 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.37) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 08:20:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fGA5MxFF8A4xgyXlWlD0cda9dMWGoH8wBFYforxypTErK7YmUh3nE74JuYhEUdhgDfplehVauzBwWXBM2gR96krICW/JWlbgQKciIulms/RUk4K+IZoM8taa7aCNcEz+6r8OVXjviL+3LD3BU4a3endAYluq0J7Ac5oeW/heY4WW+A4szzMA9aMb9+XANCoH/1mdd1DtwM7VTf5WicfavLve1FNSIRmGhn1ipBaZAGCF1SI2O+uolQTBQsD9iMKs/HlYYvxn2ghIAoA6NAdtcZTuMCt2Tj799e1YqShviTt2qh2uEyPmUn+ETYqgEhlaK+ahj36m5G1oJeg99gxjlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eznWSfANTdTywLCHs3Q29WDZsMi0joDIlyD/ChZz6cM=;
 b=glhMFfKApl+6RWlA1UY2zALB+OTby9Mi22p58IhPYx/7YiyOWR3UwJ3nxbCgvYx1tRA0w2DOOVA/W7xRlJsbrZ7OpJWrIhrN4L8Usx2Mk5tOiEhbyUyj56Xggy3nmovviFGF9pptHvbNBrM+FK0/BvNUmvEpZc82jRVIssp1jrWR404BhthzwOC2Mm4iUu1ent6/kVCBVZUq25iZfEdf5mSnFOxXLgoV0Weu9R4ReGqTckZH7ZneiixkjBhLZ2nxVcf1y8So/ZqHWS2mKRnCiEATqoZbxXo+XVDajzTFUrgU9Lkdf9yEz/IGPCQ32CgGN7lPBcuZXDKuVPiAOsP7qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA3PR11MB9064.namprd11.prod.outlook.com (2603:10b6:208:57f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 16:20:52 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9542.009; Wed, 21 Jan 2026
 16:20:52 +0000
Date: Wed, 21 Jan 2026 16:20:47 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Marat Khalili <marat.khalili@huawei.com>
Subject: Re: [PATCH v2 4/6] test: fix unsupported BPF instructions in elf
 load test
Message-ID: <aXD830VATBKKSAiE@bricha3-mobl1.ger.corp.intel.com>
References: <0260118201223.323024-1-stephen@networkplumber.org>
 <20260120015759.301155-1-stephen@networkplumber.org>
 <20260120015759.301155-5-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260120015759.301155-5-stephen@networkplumber.org>
X-ClientProxiedBy: DUZP191CA0013.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::10) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA3PR11MB9064:EE_
X-MS-Office365-Filtering-Correlation-Id: 853e9279-b887-4ee2-c499-08de59090bed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JinT0MEMfw+t4oM3b2K+HqYDWvBcumIeSMeF3xuFY/3q7Tx68CiQg6Qd5c/p?=
 =?us-ascii?Q?Zegpz1CHCZSEPIzTqjRrtZDvV3hRZaP/e/0T8c53z7JqlYuf58J41yUQQnED?=
 =?us-ascii?Q?j97znAPO9zmJhckfgsGKfyzXQ0jZa81EUq21qzshgghffpLnYrCM/uo8OL6b?=
 =?us-ascii?Q?9Bm30xqtITiIMPFKgh/HpUlnn1FH9NJedkkTlDCq92renT48MhctW4lDmacr?=
 =?us-ascii?Q?pS3Kc0v9Q3eGQBXjK38f0muG1MIL/tf5dg1kXN0MWZMZqjamM8kxBpp5MIOM?=
 =?us-ascii?Q?Dp5Du1hNbI8838G6v/Suuo+dxeSEPeT71df2Vp+ra1ilP7CqGR0p6Z4csoB3?=
 =?us-ascii?Q?AkcBSexUJm8Izn/UHdTGMwHxXQbV7bjxR/OEKagHZul0uNnuOTXcl5szuFg0?=
 =?us-ascii?Q?ep0HTozDb9vrcP8ciowVZjNbvo60MzECp0hhlUaU7rGPmutQWqJBJGd4Pwus?=
 =?us-ascii?Q?zNPmyf37Cu4BdfsFZLFWg/8P87iigpkRsPKq299JldGz0zmToADYhZf3yFGC?=
 =?us-ascii?Q?GIdbmZJMWuyrUbm5qzomiQPWsh1CGWIutaTnG37q+9UmjVU27hRROv/KbKoy?=
 =?us-ascii?Q?BaOPp8jYm9de8pn3pKL/l3+E94kT3UYl2PRfEgmCGqQE1V4OOlrj51CERZ7z?=
 =?us-ascii?Q?pxWRpQqdSE1mQrw5K2vMfzWj2mynKHKd2K7RgZg1Q51pin17RzIO01n9Gazz?=
 =?us-ascii?Q?ZVlm0Uyu/X0JV6oh3PtrzTSjI5Lof2mKzQQol1QuxazACwv/R86TvEl52hRy?=
 =?us-ascii?Q?PvKIRTFc67TNQ9ijF6YyYCL0TAXZ1tyRaTcXZW0d3MyCD1yX3Au+wFe0zhpL?=
 =?us-ascii?Q?b6aB8Rfs0fqcAhOoC2sjC+Wm695a/UHNEm4/4VgxH0CfC1I5F6+ZYaSuTlha?=
 =?us-ascii?Q?We2XWWl0h0c0oeKKq8238hwiPjoOAmo3neyeGUdfG3wXWtncn2CAwIWmEzcb?=
 =?us-ascii?Q?6msb/rwAr5mprBRW//3VpSBQJqoq7OIcp4irql68VhgYd4/AYoHCG/Z0VUie?=
 =?us-ascii?Q?XOvHULM6K5LIBFDUtXGzu6i2C0ygv4SQgBeIp0AIxOkcte1cU8e1Za061+S6?=
 =?us-ascii?Q?qmy2cT9yMyDMKMpISHQrY3pTvvuDQazRpYa7RAErWtVhMEIyjoH9z8S+Gc+2?=
 =?us-ascii?Q?wWVIwIaN9DCP0j66dNTPrAl8qMuZhLjQxSkJ00G5mz1/JqEg0zc5D1VlF+ks?=
 =?us-ascii?Q?d5d0DHLzLQSoIp4EfIALRgmsSe5cT21P6dsl/5ko1YV2usime8cBoawnhBec?=
 =?us-ascii?Q?/H2lIhXpAUjWjmMo577tPv21GjTBat6vUmgZHoYd6/PAiY050jb7gDiERC/d?=
 =?us-ascii?Q?zY5ypZ8kwkErer/Aocl3qyoVmaQqdPTlHeBMzmJnv2gLGN8qkaHVMVL5pFnd?=
 =?us-ascii?Q?3NjwnyZk2iM6HEsyUOz1yyVi/VxE0pwDkHMuKnL61yNNDZ0Te9q35NBpPo11?=
 =?us-ascii?Q?dJP7fI0pd1aGPlxdyEZAw633EuCUu34Nfg54tYxGCNlBkHGXSONX5z57OLBU?=
 =?us-ascii?Q?g5lMtYa1baN5KpQHRRiJFPW8YtEDtVE9YXiGmWXH+4k10sHycpcUEQ6Eaftk?=
 =?us-ascii?Q?xmwXa2VDgqJnZ8EZSwU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mxhHczuaQ8PmHAKKAm6TaHDygkbZIrd7Zd6UUrUPWR81NbStmWqxFQp3rx4N?=
 =?us-ascii?Q?l0/DsH5XIGvG+9HnKTLyebcVimNGTeRinEcPAGdHr4/azWP6nUZDpxl67DAu?=
 =?us-ascii?Q?Zs0uGKtPi/45dAbKa0XGGZdU0e2s+WerlQFEbT15euqe4ZslR0bbeGc8iVVg?=
 =?us-ascii?Q?bPv+Ce5B0wDTi/kOMBqeSx7V/zJjDzad6xNsmJB4wFNi7vck3Dg+YbR8IIWx?=
 =?us-ascii?Q?DEnQJ1gMabFN1qW3Gv0XnLrpiQUGzlhjqUUwym/9J8zkxJ53m7R1xoASCb8e?=
 =?us-ascii?Q?o5W5FZoJq5x8XTCQ6/gUbJJjuGYrDcIPcSz7tW1Fm8x33KrHc/g767LeDAcj?=
 =?us-ascii?Q?4Zitdn2Kz/5SVqvvhvULc3oz6hdZCcojTOj8X6wBsk+MbHCbE6lZz2QcafT3?=
 =?us-ascii?Q?iopmurw2gaxG4BC1TkcatV5OSEFOpSCqujld1CaIGXtQsf3reiEZfDCp7iB0?=
 =?us-ascii?Q?yA3yuXkzzJRgMU76TrKct3Gx7+WU8UFNKFEj8z6Cuj9m/7h3umLL4vfcsmOZ?=
 =?us-ascii?Q?PLSqZ+i6/4gLfcVFrkixIImDzk6sXJ8zBIfpr5ga0ioC81TXvTjwIE91vsw5?=
 =?us-ascii?Q?R36v2Dc9qSGD/8EHeesgcCvD4ZAxnEzxwJ9l7JsvrYW5Q6n2tjbb/6oYLsEn?=
 =?us-ascii?Q?3dJtaL85qom/g9we0zgiONFBsHpIXmAU/GtL7vgkmYFKPLvokBKJVnt6NIqA?=
 =?us-ascii?Q?BE36GnoAaqDXFBUCV8LLCn6HABmmMgmVYzGcN1eKJ30emJqWVDs3yioJka2L?=
 =?us-ascii?Q?ZX6RXEV9C1SVOeCWAmttp4uHUTMUxYFqbyAv3L5Dxd2izjDhqq4VL4x28sAB?=
 =?us-ascii?Q?/A0zRyJh7dAB57YDmPbbqNwoeTvAE8LDfcMEc5fh08QIhCL+uIXwsHjzd4W7?=
 =?us-ascii?Q?HS0THaYNEWMzYOB8YEb0YIAoaffgYvhnqlqMD+MriWwo5mNcL1cZkUVI6TGA?=
 =?us-ascii?Q?H/pYIm4rvCY7bxe/BcerlkhOK4lvYQKz+Iuk74c+6e1wu5F/K1zqyOMOzz7Y?=
 =?us-ascii?Q?j42INI80K78g8IN0I3cABtZHm2PsiemJTUOvf2lb3aJxfiFEvBR4sgwRF3xk?=
 =?us-ascii?Q?n/mfwln1CeLK6he0gzwc5ab67KyOdOlFMcHJZZftgcESB+aHftW5rRWxY2NM?=
 =?us-ascii?Q?HUNMEXc7S3Q/eKmDTgqDZpQxU0OrjKiNztijZYWBie/yrOAWJgMaI/BOdDHf?=
 =?us-ascii?Q?TxiHOv4mvVQRuX+Dsk24zoQjX2lPrTQev7n0TAtfUBej007huPs2wlkaeD4a?=
 =?us-ascii?Q?SpJEL1T+HvJUzKqME7DKt5YG0qmJg/gDAQ508hSdPNPZ/q0uc3I06mYjrOgn?=
 =?us-ascii?Q?kV4pzI16v+oD1638uPuc5zGUuNsF4ezu89cU0m5+l8gWYJrs8VR0NmEUhknx?=
 =?us-ascii?Q?oayr44e/4Y1rbkczD/ctALYFuAB0KJhyoOvd9HEGVNHcXvmptJPFSXyTVVdW?=
 =?us-ascii?Q?W7PXktkGtw3Yn74Z3CFxPjyVkJmYVmBPd1x29BxqBMzM5TghOXt7cBgoXlaQ?=
 =?us-ascii?Q?+QEwGAQOfUG12iOb2SmvpNOpohHTn/xoRPn75ju+w7kCFUWPHOBVujJPKNZb?=
 =?us-ascii?Q?NMnfSXW1Ko2wpE64vAEQmXBcHheDGPaqfNseoWDgYY6CQS/nWjicYxkxWRGM?=
 =?us-ascii?Q?/s3Y6ZeguUDr/F1NbZPs9ecJhFgmFzO1IjozaEBHibtO358c4783PQW8581j?=
 =?us-ascii?Q?BNbFiwI8eKAhwTN79mbyAQJjfHu/OKN4aQV3oLshqDVxEt/egKIvwZotChI0?=
 =?us-ascii?Q?pTbmaSSJxK6sStwhI199uEUJjSozbUs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 853e9279-b887-4ee2-c499-08de59090bed
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 16:20:52.4863 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TvN6mSpk6lb4vqLXGMFnj/J8u6YqbyUCIroDQKhn+3aAeLUDIptx7vkm+GN/7YHy9PD9IdWgW7G0bAkxV/lceQuo9VG/O0o3Lu4NF+yyIi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9064
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

On Mon, Jan 19, 2026 at 05:55:07PM -0800, Stephen Hemminger wrote:
> The DPDK BPF library only handles the base BPF instructions.
> It does not handle JMP32 which would cause the bpf_elf_load
> test to fail on clang 20 or later.
> 
> Bugzilla ID: 1844
> Fixes: cf1e03f881af ("test/bpf: add ELF loading")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Marat Khalili <marat.khalili@huawei.com>
> ---
>  app/test/bpf/meson.build | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/app/test/bpf/meson.build b/app/test/bpf/meson.build
> index aaecfa7018..91c1b434f8 100644
> --- a/app/test/bpf/meson.build
> +++ b/app/test/bpf/meson.build
> @@ -24,7 +24,8 @@ if not xxd.found()
>  endif
>  
>  # BPF compiler flags
> -bpf_cflags = [ '-O2', '-target', 'bpf', '-g', '-c']
> +# At present: DPDK BPF does not support v3 or later
> +bpf_cflags = [ '-O2', '-target', 'bpf', '-mcpu=v2', '-g', '-c']
>  
>  # Enable test in test_bpf.c
>  cflags += '-DTEST_BPF_ELF_LOAD'
> -- 

One small additional thing in the bpf autotest, is that the test fails if
net/null driver is disabled. It would be good if it reported skipped in
that case.

/Bruce
