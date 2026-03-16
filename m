Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7800BF46452
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 11:27:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E1B640611;
	Mon, 16 Mar 2026 12:27:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id A83A3400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 12:27:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773660463; x=1805196463;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=d2SeQf91pMS9rGlKtp2nqHyJx1hpgTnIcsRJyZGKH1A=;
 b=l5lGY5hbJ3/ykKRA1U4FAHLG+lr9XmyMbLIV9+Y+1pXGmTs06dX8H9Un
 cOn/4kNzJ2xgUQ2Hjb7nJvzZLNXNxvAyMxD+TxUZ0Z0W+GFcoBEVK6Lb6
 P9x3NhBdLMJgi0RgBMORfmGimydbLvLVB3sPynwoX3YzgBvRpj/Hb812W
 /L/d3ZB1cmmH9J8tJkTjSv/soxizLCVNq25ftz1hVXulooqx6y8nYhAPn
 9NSjpciy4nMDwuRCEmd0WyiB2D7yNDr3ouB0aID9VgC4NAfVQ/V2Wjnwb
 yo7x7Y4FovH1t1RjUEPFTfrWdqMsmUMEO3KDdyA19ZbEZNqY3EbV0Vu/g A==;
X-CSE-ConnectionGUID: gIfxCf4zTw+R+eSH4y7qZA==
X-CSE-MsgGUID: fwfgJLBBR7OSN8zf6Qh/Jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="78277727"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="78277727"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 04:27:41 -0700
X-CSE-ConnectionGUID: 5lV/FCODS+iPKN2ZuUFeRA==
X-CSE-MsgGUID: hHfx9NX2RNeg7WYUL79C7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="219470651"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 04:27:41 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 04:27:40 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 04:27:40 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.21) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 04:27:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HjHAyka2xf9rVTzf69kcJ9XvjdgKbzJEt9P3zns0GMMDhhNDQ1lIp9VAZlL7g+gr8PSg3Xa4cr4YFJ93uSVXFYuP7fEArwzNckpq0qTLkY52dlW08n/0bbLiKxuzMqyViQzWZ8P4no0QJNtVZFz3E2fAf2ES3jzucnF3HJ62HDuFikroogA+c0na+cmcaSw4v0UeWBGieqGNXFmFi+LZvzLeFsB8IYWwcgnKiG3AwhsJqZUSnmlwnUYLqDeBKOzSnwi0UGS9/BYa4ivesd+v2ajUWNfRFYWjuvrl/m+yp7Tv7hEse0yraNUa6dijJsS/YYltVyq+EG1H7AxNGq3SBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laiJBdHWbN6C7DlywGSx4xvNxpOJZ/Ff1432GwzIdYo=;
 b=bqApM0IDW8G5poiGHnNTa9OMgn85rLvbVVcoY5KT6d2RYdhjJWI2yY5b9pQdbBc02NssCZlQkKsbDnlexP2HRmSyuprKKMIXa67R7u8upocHmyq0aXXVzyFIn8RqWQa9ujBLpKbdE+s/E0Y/2nYNKCVEdugHZ+YpkSmtjHqhXQMWKBO3OZI4JVngvK7HrN1zlYhnoadg5fGhLmsiDTth0K/WCw1LKlMugotewpFQzQNha+yJXamoVnyMS7/4KX+5HiAe1iR25vHra8AwPQIzzSLcSZMgZmn2OFPnsBBFo30lMTyswsRDEcwcmtWtd1aWdfAb2quZfVW/V68WFR6Mtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH2PR11MB8779.namprd11.prod.outlook.com (2603:10b6:610:285::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 11:27:38 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9723.013; Mon, 16 Mar 2026
 11:27:38 +0000
Date: Mon, 16 Mar 2026 11:27:34 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v20 05/25] net/pcap: remove unnecessary casts
Message-ID: <abfpJquKxqewWqJk@bricha3-mobl1.ger.corp.intel.com>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
 <20260310161356.194553-6-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260310161356.194553-6-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0221.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::28) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH2PR11MB8779:EE_
X-MS-Office365-Filtering-Correlation-Id: 53fc2f69-9dbf-4392-0b6a-08de834f076e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info: WgNF6E0UVSiDEqc2wZeY6kQOKuyGSmyo3fz8bd1DINxzdvQe17igxI5h8TU8fpkoQu44mEYs/ZeLS6QigDjV2xtB7+tAjUEFBbK3JwHsCrbbYCKO+bbDflj6J+U0bLsUfwusUZJMrKypldV3IPTSfx2F7lDAAjZLEPumyinbJYNVwdCKwtJ7jpUl6AAKc/X7QnmHFa0bOT9C+MP0hSR9L5X3/VJPHONX+F3neq+1IT+et6m/ctp/c5vLbDsQDj+Zm7dyRcUfgCbTM8OBaIyfQtxJaOUn+rpBdYY/Pj+DbBf6G8g5lDVEcxgzdSxFkKXgE9YDwf/g7KGQ2VA/CjncrPNNxuCG8Yx7Ip6j7XbmduvM6aBEFgiFoDI/OjItxgnePD5hI1M1/w5yBglpc4Dhe3RGh1A9yqBHctHB9Us7vLQ6vhMzCPCOCZ22w0pCHWPD9AADejVDxM0zXDw4GLncedphd3jn//zHAoRZV7zEmgEQrkBCHc4PcP8aETm8GF7BSm7vRoTwuH1xz/2l8Z9I1r2CEompeC599yjW89Z6dRep9j0z9/7HZWTXx1Zm32vejIEQk6qcdhWU6PTx4CuQr31gJj4yV4BP/3Qqi/L/ExadakHuM7OAK66UtDwK9xK+4T1d76oTu1+bf8EDABVkoibOPQTOgGbRJCIB++25Ujo89SBiaBMMbusChYdJntFPo2TvvRQtXEO4hdwiKHkII7maCD7qoiRnA+SAqyiIcEY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UsMfDypBMwwjaiQ8bb3tyMPvarPg/vzlXhN1x4lzhFLgcBsjCqlQa0akXM10?=
 =?us-ascii?Q?yeOUuj8jE5+JC7LHRHTElZkfaJlTI6Nm0UYaNcZRxrIn/2Cr48E5VG7Io0w7?=
 =?us-ascii?Q?wBG9EdL2WOPK+GGiKkNbLf4eJbtLGtTCGaPAqqym8HFswGtjgJEV1oY1hfS7?=
 =?us-ascii?Q?W4TIJL462J5SVv/Rp8LGTiTrxFiruiGlK/6uC77gZZQkkIGboMAk8R3RJZXa?=
 =?us-ascii?Q?zkUAtes1V3ul7SLEfoAqAQ2gwuEvi05dyq5/TGcrIGcI+Ja5K40z+Qp0BDJg?=
 =?us-ascii?Q?uSVlg0woSHjMiJtWJIkQh+xiqiWUhOuu750OkYl02uBW2FU9NmmcCNQcOWl1?=
 =?us-ascii?Q?MlLR2wyktrrypg9r4Mq1ga0RytMXdJGmWc8rBVReZhZKLeY1Xi/bnzZ1Q5O2?=
 =?us-ascii?Q?to660j8mLIsCfh52CR4/hdIumfBK+hQIDIeCcQ3KwjV9BiYmj7FAzRyfYPEo?=
 =?us-ascii?Q?xtE3mzaf1SDN2pS3gyiVLX5YDf3XiLgCU6N0CWaJFgNI+v1Oqrj+D+sYBnti?=
 =?us-ascii?Q?UW1qE/Sf8sMOIp0Jg8S8Gge8f1iI5o5dO9w1sCRvMWXlIEQNEFDTrKDwbx10?=
 =?us-ascii?Q?iFgYlt6aa1FNYqSvoKc0PghrrOjdOFwI71NnUc7MngGx/mlEzk1shjW7Csjt?=
 =?us-ascii?Q?iBJkYezqNXuBna1Nzrh/mUQj/S+t/B8VM64wtWHLNJAaI7RqIOQMICVxP7qk?=
 =?us-ascii?Q?Tm6jYuCHjkjoOXb+KEmbdc5EyLZindc9ZxWIURZ63kXxDWzSCrqr9ZysB1iS?=
 =?us-ascii?Q?vrJVXQ0cbD1SqnuT+FbQqhKoMZgKdfhm0k1E2WHVFp0cHxCt1L7rm4K6ZEpM?=
 =?us-ascii?Q?uiC3z04l+DByOlEkf6tjqsppYq6nZK5BVfCjLUyGs1eQpblIOmuXTmCEKLON?=
 =?us-ascii?Q?tXTOHEj/3IGRZJHfTX2xAqbAsn2S0e7wI0ZywrI3+Ce031U6cQSn/HpUmVwl?=
 =?us-ascii?Q?Bz8GDK41aPOGIJVCZrvodr2KF76YUnEj5Nni6yj7WO3ROaCPNJ3tHO/AEcrQ?=
 =?us-ascii?Q?/34OJ/bxYRrqdPMNsvOiMoF9HPz6on9R1yyyL4W7Zto0Xtsx1oUfCtUYmBDO?=
 =?us-ascii?Q?Eaa6lBEHaYHq73waELhhrBI/uwu0MQGjH4SwvuHyMq7lv+3+r+sWrI5Qh+Qt?=
 =?us-ascii?Q?7q+JOS9nS2zjjxlTc3tSe0471AMcmIurAbRDPtIZ1t0QpDxLwh24qFQNf5qg?=
 =?us-ascii?Q?boWuaPiyCScUd/SToJrxokWqw0LAtMyfPajf75amR/IVs41jhqWv+6y0dQ/6?=
 =?us-ascii?Q?BysdmvvPWUKML4MiuikJvMO9m7ea7B2TVyqAqFv7MGgmfIFdWAdaNPNTDsAL?=
 =?us-ascii?Q?68ZSE0f129qBM+s805PiDvW4rWrSiRBkY9yKt3jxRE9mdRe0I1qsu8I+M5sv?=
 =?us-ascii?Q?gaCHHMQvvIodJUmM8PgzqHB+zcsTnFe1mGI6XknXG+LJ5KpYwdxrlfeEx5Gl?=
 =?us-ascii?Q?JcUDaJOvx9boJ5BNvH0tkgJoQhgRJXKQG0kp3gCQl2lDJG5Fr1U+divFAdVG?=
 =?us-ascii?Q?YRYE7qyc6bZB/mO+1KDimltmdbsgG25Dtcxllod4bx+cR/7WHcMTj/cn2ldT?=
 =?us-ascii?Q?pQTwLP2g2gdr+NYHLfL2uLwSvwBYxIGHbrsOEvkTApfxxui8fU3QRE4Ll+X3?=
 =?us-ascii?Q?RPa/S4sti9FGkZK+LY6N1P5pU7bHDjrTf+vHVDfUGEdq6bg4Q5L80SHD5MX4?=
 =?us-ascii?Q?f/UgjRodPMnc+ABvpWv0NDTGHwMAGjK1cZ2buTHcROoXeACbxiUFO6eavuNr?=
 =?us-ascii?Q?qHIEowPUq1kF/tNKFDLELo4M9TxHXuA=3D?=
X-Exchange-RoutingPolicyChecked: vUUuOKiFDNPfBxBrqYN9bvJoLfWmCe6Ce7nXSkWGRxGDTgGVqLIAv9s6a0EeMREuBCeB5cK1cVvMezmE44G8gbFbUocAUAu/e2q1b1b6XjRMURsyEEdZw1WNEBnJ947rRFjQ8zGtyn4nzPcQ6EG//+9+iF9X9vZ1vPppz8yIedKZVbeDVoZMrlfjlYbwTVdJ5q7aEtrDrHIakBzySitydOMcHg2gJvBS+HQhTVCtpcYRXfHlMoHXSwlqebiKvVyjTkUsxLYGO/O4Vz+ufUsbArTNAvDEx/Wn8SDP5ok7lXUm4PN6JIY+9kHCh5dGfTsij9KlkeVMplwJfRak1of0cg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 53fc2f69-9dbf-4392-0b6a-08de834f076e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 11:27:38.5364 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZETyRthSMpUFbVcwq38x/f7pjIOdving90sf6ehmrLQ59QuGzSBnp2d6CSY3Xoz3gmDqBRzzGgsStWM6rXtRwbZRbCQhn/1sp+E760vIgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8779
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

On Tue, Mar 10, 2026 at 09:09:43AM -0700, Stephen Hemminger wrote:
> The function rte_zmalloc returns void * so cast is unnecessary.
> 
> Correct the indentation in that code. Not really worth backporting.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Though one comment (and mini-rant, sorry!) inline below. Ok with this
change as-is if you aren't respinning the set.


>  drivers/net/pcap/pcap_ethdev.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
> index 4513d46d61..fbd1021c39 100644
> --- a/drivers/net/pcap/pcap_ethdev.c
> +++ b/drivers/net/pcap/pcap_ethdev.c
> @@ -1220,9 +1220,8 @@ pmd_init_internals(struct rte_vdev_device *vdev,
>  	PMD_LOG(INFO, "Creating pcap-backed ethdev on numa socket %d",
>  		numa_node);
>  
> -	pp = (struct pmd_process_private *)
> -		rte_zmalloc(NULL, sizeof(struct pmd_process_private),
> -				RTE_CACHE_LINE_SIZE);
> +	pp = rte_zmalloc(NULL, sizeof(struct pmd_process_private),
> +			 RTE_CACHE_LINE_SIZE);
>  

Not a major issue, but scanning through the existing file it uses more
double-tab indent than aligning with braces. Personally for a refactor like
this I'd just avoid unnecessarily changing the second line. [This is one
reason why I hate this aligning with brackets, if you change the first
line, you have to change the following ones too! Makes refactoring or
renaming have either broken indentation or far larger diffs. Given the
capabilities of AI, I would very much tend towards making our code more
"refactor safe", as changes are less likely to made manually.]

>  	if (pp == NULL) {
>  		PMD_LOG(ERR,
> @@ -1590,10 +1589,8 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
>  		unsigned int i;
>  
>  		internal = eth_dev->data->dev_private;
> -			pp = (struct pmd_process_private *)
> -				rte_zmalloc(NULL,
> -					sizeof(struct pmd_process_private),
> -					RTE_CACHE_LINE_SIZE);
> +		pp = rte_zmalloc(NULL, sizeof(struct pmd_process_private),
> +				 RTE_CACHE_LINE_SIZE);
>  
>  		if (pp == NULL) {
>  			PMD_LOG(ERR,
> -- 
> 2.51.0
> 
