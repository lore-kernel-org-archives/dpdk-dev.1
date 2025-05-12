Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0370CC3ABC3
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 May 2025 16:36:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF9A64026C;
	Mon, 12 May 2025 18:36:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 8C4C74025F
 for <dev@dpdk.org>; Mon, 12 May 2025 18:36:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747067768; x=1778603768;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=1TJ68YcfLSFiId3F9hTv4zgGzEmiJnfZKT0cFrMISFI=;
 b=dRTVfKzPhkjTT9dyaTueEWDTmuSClMaEEdT8YRt5aKHkKb8ptbkNq4rv
 7+pJKdqY6TosVFECwk+cyYFWtC5M5lPPWKPFhnAekA5fNZNCn1R1fyfmt
 c+RfZOPzbbDRrd+mcyRY2VsNZ2kHMXvUR4zOPPk1RNMtSGpwwpP7flEwM
 16oFIr1pzldTtDznGXKm3XC4DqySDtmlD4z1FSYTqZPmc/MVGLLj5ThMx
 3NoEOOWzu3taKqgPHFzVxCUcrPadhexoZ2Vg0uQiSrpTkqkxPe4nKZBC1
 onseHl2nzgdQXUrkkjDVUJnW4Vbr7EDubZhoZUhdLkYiL8AGtqQHXACiN A==;
X-CSE-ConnectionGUID: AUCBtvcITvS2yQQX5Ig9pg==
X-CSE-MsgGUID: MwiUzg59TFykb33ej3ttPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="52525680"
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; d="scan'208";a="52525680"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2025 09:35:53 -0700
X-CSE-ConnectionGUID: yli8PT5gTFyHp7fXGjp7Sg==
X-CSE-MsgGUID: 6VT5dhbkQhi1zIs/6VCqTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; d="scan'208";a="138353927"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2025 09:35:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 12 May 2025 09:35:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 12 May 2025 09:35:52 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 12 May 2025 09:35:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xHY8YOyYpYdCOfmkDCxzO5EOfK/ijfkoFblwP1WG5q/CSUZIyFGsSq0JIOKq+n8LAfr+da+xaRYaC8wdkxsWRfTxHWGcxddslcWUQMoDV4uEGsnmwY2vAtCgxFvuzEGWDt/9o9NunLbu4xKW991Rk2gbALma39i94gWiNoTJI57a++xT8IuSNVDRE7GM9RNav8JrxwOP9FHo9+uPeU1v6i+Wu6bNiOqoxZLDRy1LXtJJWZ7hYCMM1hX29pyRCuVzuPD2Vspd7NI/rE9NuY60s8QEThWwciNMbnu1vx9IUPsSfXs1j7QQRa4tmok91bT39bfU9WlzXOtPe39+tBdlYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gR7OwggW/Y2c14nNUG39U9S60MaCK6iYK6zIwajQkCw=;
 b=w5gkxT3Zq9S9MHruTI9pgHc1UKR8S6nuHiEUzsTNFa3C4gHGm5Fd2QoMnkiTyPVqU9gcmFsz+rAo+uSQOBlLhpD9sRcNGlf0Pic9i/+80dMWbxuE+nnBtwVEy9Af98V2ip3E++KdHYa3EbtfXZh5Oyx2V0E29MBAptMeBODnV1u03suvmyFs2hslJ0clbnsrhC4CT3/jFYXlEvK1x9fz2dJJLxsZbJqTc0JddK6oVcFvRqURSs79iYpJF3toukE2KA7IdLbH+mDnApDFTsAV7JyZL55MJARw3Bhbp/JP7BbQyOXkUHQtlP7C5eD23/71Fmf9ShHHA2ajItYsi1dlvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB6041.namprd11.prod.outlook.com (2603:10b6:8:60::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Mon, 12 May
 2025 16:35:36 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 16:35:36 +0000
Date: Mon, 12 May 2025 17:35:31 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Pillai, Dhanya R" <dhanya.r.pillai@intel.com>
CC: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH] net/ice: update log message
Message-ID: <aCIjU8sSTDH7_g5B@bricha3-mobl1.ger.corp.intel.com>
References: <20250502152601.699443-1-dhanya.r.pillai@intel.com>
 <20250509162543.142225-1-dhanya.r.pillai@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250509162543.142225-1-dhanya.r.pillai@intel.com>
X-ClientProxiedBy: DB7PR05CA0055.eurprd05.prod.outlook.com
 (2603:10a6:10:2e::32) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: 09431a8a-aaff-4972-3b09-08dd917305bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gkTCf5hpf+L92D1rDnytjcjvZJvUQ7wYursmRwtExp+JyUIaW7PZyzAzk49N?=
 =?us-ascii?Q?haidGtYBu42HYpObEaJtNF7Txy3goqc3ci39DFFhhNi3DPzc1gDxk4BGwapu?=
 =?us-ascii?Q?Nzsdf+lsv9UVS5KK5E8KrK1F9XUsFSrCV3fI++SHqBjtph+2wDdtzF/m3MUi?=
 =?us-ascii?Q?ZK1Kjxv33YSqUZeHh+MS8AY7bqob7LgUcFI8J2UQoebWCSwDfsUDamZz+mBN?=
 =?us-ascii?Q?et3yqFAvNK2/ZMl2yjaXpqn40JXUiTFraPFE2M34uDBaz3njKGPEKbv9zZyh?=
 =?us-ascii?Q?WaO7OVHhS0ryx+J+co3kQczkLXiyDqpfV/54FkxLc0osDNrvxdvqbN2yfGtV?=
 =?us-ascii?Q?irIjLi4afyJDs8rOdL86w/P4T3NlnbBvb9SMK84pqGqjyYjSeMYZoK1A1BBA?=
 =?us-ascii?Q?hI72r0ZPICrLP6TZjDh56hgqIYwe8Ybay5hb/j/HQjosXqxYJ++FgDDiidS4?=
 =?us-ascii?Q?uKWPCWv97RAD5DFHUVhkK6c2nvhABsZ8sc904noFpobVlfYEBisCZqp6JwMc?=
 =?us-ascii?Q?5wapkUaoX1Z/1CB8GNZrruDS/N6vWuqOz+UTIXdUgjV1G2FJtMMxPUBhnrRJ?=
 =?us-ascii?Q?pfArxXEikWCk29nuqIqNb9XiK5727ATtlLgjD6ktZfjWEs5GCJ+bqPLDaMhm?=
 =?us-ascii?Q?TfH6v4UroAOVIJSvL5SeKtTpXg3iIv0osdFO+D2i+MGCUkJ7lbkh9n7iqxRi?=
 =?us-ascii?Q?/SIKOM0nCNI7JL8R2ZcDvh7+4PYHk4iMWVoaQTepU6PVJe/2IYbESYvbzR+C?=
 =?us-ascii?Q?nuY6n6nrm+NRPnmNJHsX8wSby6B46CdoZMyczR0pZ+9zJe1nzkuUydaaMINR?=
 =?us-ascii?Q?xa0FclK5FV7ukpYivkuvwKr56prL+eajx9Daq0956vG7FBUODCOa1Uh0I9RN?=
 =?us-ascii?Q?cYlYn76kQrDmia2iTJNL+II2+YA8nK9T8SqemnFpVFPbTnSulqXgb+nJfY2W?=
 =?us-ascii?Q?mEK/NvqPrz13HVMuVG5U+hCDNC3zjcqHzC2N0cGLpsNGXe/78kXVxjLFafmf?=
 =?us-ascii?Q?/5tqPmntCDOaJF97M4WxmsJIButmIEmLDmOWtx9xl3E3/f1QdtJSgqMiN7ds?=
 =?us-ascii?Q?6yUmQX6nm5LFdAUpJ/lmNLPr2jeNK39sg5gy6O+JN+EmjBoSOV3xuwXtObft?=
 =?us-ascii?Q?zMNYSkDyjzVpSx1N66lA1hVeLN6Wu7GCqhNWvMYG3SCcz1unVR/HSZSkUFIN?=
 =?us-ascii?Q?Wgu75bNYRDntADg+VeB8c2NemKgz0WlgyqqwwXAFryzf/wDVXyOv//RGISum?=
 =?us-ascii?Q?S4TAQrQA3CoMKY5ovqRWTqOqtqukjP5RnwkNJiZPCLFBGpXiLId714X0s4WY?=
 =?us-ascii?Q?rMjVKT+iLOStOKmlN4lssw2dlEnaf3tZhYEmD/UImJUfj1eJD+u2m/PMmJOb?=
 =?us-ascii?Q?irL2EOpHHzzPJGvjKRcJwNcvjBVhlxKVMVbKLTQLSpL3k82TZrt6R1Wqzy/N?=
 =?us-ascii?Q?Z9jyJgpou2Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LsuqpWi2+I9+z5Z26bj532jlshPNJu4xXN/0pCA0FtLl2OOivbPsJhwvrrp6?=
 =?us-ascii?Q?xkhjTn7qbq2CFi5bp89slG/xOoGhWKaDOZ/yqOYGr4zb/NrA0TLlfHQgvL+U?=
 =?us-ascii?Q?xObn6zAXs6vUGuBaEyLol98dV16ZzQKVFNCmdb0HYxNHON4UH3Gh/o5Pq82h?=
 =?us-ascii?Q?ejPq+mzWk+KwMURbCgzhJESb3JL8gGiHJTJJHaPkpXEgbSttR0D5OmUhRYRX?=
 =?us-ascii?Q?Ul9XRoFXEELLU3Ls40KyCb6P3zVMHcaeUNLxrb/mvzX3JFrNIFxXzt9qD1Xk?=
 =?us-ascii?Q?ID+eDPjPp3qa5PqtwmbWZTI7/qkbdOBlWH5JE/10AKiKJCFBUcGIzMLwnwoP?=
 =?us-ascii?Q?3OuVliTlnMbyIa5keqP5N7h4Ir5LhHrs5vTJ3u8gXpTuYjIsb1FPDXZqhOzc?=
 =?us-ascii?Q?Vfxnj/ld+UgFRpf1gnxlgYVMmG5ovlCf6cfCoODYPCYIgsjelzUmFe8PC+d0?=
 =?us-ascii?Q?rpZ4Nn4nGjq+O1KFflgd8QEV0rmQ1Uf2e6dBqq3iLNUD9bvBkmMRN8xN8otf?=
 =?us-ascii?Q?s2eJt1AU/hpqOYE7st+DqAFxlrauSRO2xYs3QSr4YN8fOsJLT/ZSR8vFt/xX?=
 =?us-ascii?Q?aSjTNLzewSE55tmKPTInZvaCHBD2ul8v8N6yKp05xQLcGxiwNw4wkUCWjT6W?=
 =?us-ascii?Q?Aig61TRmbntglwRKlLD7OGtXGtaFwKAT0kEKeUleNo77fRlXyKZoB7bLNqcp?=
 =?us-ascii?Q?7+H5/tOQg+FHuktL5O/WEsYBJ6gtk+boMOnuqFCimS4tGQhixJzIqcy2bVYp?=
 =?us-ascii?Q?him3o7+rBEfrzAnBkGidKoSTGvpdBUFCEe6jsSa8n7kPsX5oxoAOJBO/4LAh?=
 =?us-ascii?Q?nFZeBVI2xXbiEV6++iXx9wofRd33F2ukghqg+tMZX6rC/R19lnV4oeWo9vxG?=
 =?us-ascii?Q?6l1bO9qR8xSxwKN9XlubbQPWmsq/GLHS/JDeDCwB+O8qGM8ZHnXRqp8p/gG6?=
 =?us-ascii?Q?EivjPGhsKv9npU8A0IlSdA9fKs8eDsni6QkKWe2vknDpN6fKccgwZBX88qmj?=
 =?us-ascii?Q?TNyTQ5X0tIOM5gGp4YRwCKl9M/S6dc/vvgAJO1rFIXEmQjHmTVQgnv7pXGD7?=
 =?us-ascii?Q?Z0QRAN0CwH62CS9dO0DX8vPoJ1iNICmvwK/w0mbsZHDeS0l/lHp/B7kR+9AS?=
 =?us-ascii?Q?oQd+SsKoOgsxTOkswMRJtWX7u+5wNDCvA5UUE6ldg1LaQVEkA8QkJwg4+xp5?=
 =?us-ascii?Q?ctEXCmn00vEov3VJGkX7Yf+rzLb5d92TRYZD9IU58uy1o9OklfRe5mY4fUFJ?=
 =?us-ascii?Q?p/zzUQKEF8y+IgxTS9KC0smqrI5bRluQl4wf3GmQoN0Xf8Tq6c1oD3MLFdqz?=
 =?us-ascii?Q?soeRjYbHWOFueoiyL/k0KaZfY64GMqfJEeua2vu9UOsvL+RxquLN4+dXO1xf?=
 =?us-ascii?Q?I2Uv13NxqKVqL7HI3OGChumevdNltnKptisPboA363/vUbVrtAYFsVmYfKWP?=
 =?us-ascii?Q?2uqQTE948K6iwRCOSFfb8ZPv6IFLxCKeqv9u9Bxoy9gEMMNbINJYgMgx3nzg?=
 =?us-ascii?Q?K5PjPo3kmjrLUB9IELIJGam+mFxu/NwVcKzdj0CDGgDeXgqc+ZKk9MWl5Psm?=
 =?us-ascii?Q?L3AHQPGniHCAmkV2qCr41gNtOQtUA5jnYTVcrbpDX1AOcFJ0nM8HwEqMf+C0?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09431a8a-aaff-4972-3b09-08dd917305bb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 16:35:36.1824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wrhCi3ckjcpWmFKOX2Yf17MNpuYDVhBdHwdB1hswgJQ3ewUPZ5ZF2JgHL52krmfG6nVGOUrMYzGwJ2mB2V8yOcqvKy0uHF3gfPcIBHA9nRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6041
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

On Fri, May 09, 2025 at 04:25:38PM +0000, Pillai, Dhanya R wrote:
> Clarified log message for DDP package load failure
> 
> Signed-off-by: Pillai, Dhanya R <dhanya.r.pillai@intel.com>
>

From v1:
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

Applied to dpdk-next-net-intel.
Thanks,
/Bruce

