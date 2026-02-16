Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DD3E63F3F
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 17:24:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A88640296;
	Mon, 16 Feb 2026 18:24:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 5339440289
 for <dev@dpdk.org>; Mon, 16 Feb 2026 18:24:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771262691; x=1802798691;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=e/KiOHLtulikMpQfKaxfVi7MRJp+cQsv1xum3hIqGw8=;
 b=K4jdozSpEXZFddE4tV6/YON7tBVZYEnWJaWxkfurs++qDBVRUEG8Z00R
 vuc8ufuc8IRwD+e/u7vx1C7wC1+5l6rRnPA9QH2fPC/pOvxGYHehMxWSj
 nT3kJ4/9mg7j6ZlbX9womUIycdIzRwqbWGhjrfnBRxlhAlf27yV9KXtIQ
 8isSh4JSWm0k3UQvkQQeJZHxZZqodRWNUcxApwMMPW5xbrHd83Owkk5NY
 EWxDuXX/g916+/jWsHwvOL5WKVDa5ToKGBJd0O0yZGxVKEPYb7tVbr+0D
 zh5HX/KOn+g8RH3Dk3yng6yEqKNKcDuyii8N8dMw+Mm17P8JjxoNRqL/N g==;
X-CSE-ConnectionGUID: WwtCPZhLSAePvO2bYSd6Ow==
X-CSE-MsgGUID: by1VfWyZS9G74Umu3sxi/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="94976531"
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="94976531"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:24:50 -0800
X-CSE-ConnectionGUID: 6tfWEk6sQQmPaTdEVwPz0Q==
X-CSE-MsgGUID: QEg5Tz/wTP29vy2EUfu4QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="212968671"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:24:49 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:24:48 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 16 Feb 2026 09:24:48 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.20) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:24:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHvKRwDZP0VhKt9DHCMEHvvmztoPd+aL6EEEpCp/zSlV/AYeBymuAvz0rFZkhtylQBXHJhJ5H44En9VKzr7SQeLSCiY/eN8zNjMXO6WowliCABP3yJWQ4LkweEm9MwMb5bk9+7yuDP/Wfg6n3cU/djYyWmg9pEUpa7YTe9/EoOveIeWtXVbqklqoxN8FFLY5ybTDSe8kaoA0smSwLnuxVisQqjt81kIve4PXm1ymA/Y1YOv2zSqDu6gXT9O8tQtp+33ylPN3YijuIBGP1pkzYb+XWKIKWKUU57m5IxvQpfvWMNFDvOS/Jn4G2O4zZsOOJe1GAXNA0+AvjvdfRf996Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovtlPR+1NUzQjnyMdKp2ScHUSWFgKz/01a1dyWna7o0=;
 b=CTNk4fieLicHsDjP4I0rbXJj9YV7wEVFvt7j9KV73eVKWDB2fVXI+Yt6r5FuMdJC9LiHaWkmSS2o3qx7Zmqheu8MvSEYtnTo8SFJ9EmVaL8EwzX+XrGdEqlxEgFFktZXafxhSCj8Nv4Sl9F8VhrN5VJIVjBHqatpBxJiufA03a5HuDXlucYWd5u96Yxj7cw1Mm5Tjn94nIC0wUD/P4CKUafX8V3M+uYIuVebMm6I+FMW/GultzkZEtsBPKHEyK4j0AxmWWGFLbnvGPMV3fVw+CN6BQc8wF5Shmv/2hgwYO1r0uv88RgslzoHf3voEOK3qAJa01ZokTIET8DkRAvv3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM6PR11MB4516.namprd11.prod.outlook.com (2603:10b6:5:2a5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 17:24:46 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 17:24:46 +0000
Date: Mon, 16 Feb 2026 17:24:41 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v4 19/27] net/iavf: avoid rte malloc in RSS configuration
Message-ID: <aZNS2ZbtUvL1nYk1@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1770978324.git.anatoly.burakov@intel.com>
 <cover.1770978324.git.anatoly.burakov@intel.com>
 <e69a82ff71fb3cf38056a3882c915c73cd84a7d3.1770978324.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e69a82ff71fb3cf38056a3882c915c73cd84a7d3.1770978324.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0302.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM6PR11MB4516:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a3ddf6f-b15a-4401-3860-08de6d8047be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7142099003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6TnfNTycdUplRq79zjhtBoOFqRLtTQJjaM2D5WNb93GTGsXsXJ3DGTrUCr+K?=
 =?us-ascii?Q?90fiaRlakGvCna2OWq4TEjYFC5k3p7lT1lP4dGFX1xGzmowzP5K3hs0XChqJ?=
 =?us-ascii?Q?cY6FtSUHEeZ1/tq7EMlOp9ggqxV/24bjiDV3yY8zaXjxhlqgzrA+8js4ZwgV?=
 =?us-ascii?Q?7pq35mDaeQqMpHH5U0KIrfItOkV2CRwWja6QIjZWuTcdXQg0t83pkQHWFUFo?=
 =?us-ascii?Q?9LeVi/wiwt1ac+aHzqp5aqMYBs+3Oic+B5OY7HVcGOkPJ6tokjX0ahA3Al/K?=
 =?us-ascii?Q?mVnfsYCuVcgDDtMHzPCkH/rYaJUmYw6Ue3R7DxtHf2JZ+u6Y4Z/0yN4OoTI2?=
 =?us-ascii?Q?A2cHwVpWO+dGgsXPjWU+03m3mpXfJuUGHQRyTal+/OuZ9krhysLiVBypidmA?=
 =?us-ascii?Q?qtJ7jR2+aCxTs0GAmDlJ2pUWSj48MVn3aAyXL1/hRYb+PhFn9cFnRB72nxpz?=
 =?us-ascii?Q?MzAkli2a8g1gPGJKx9o2wO6ts0/mcnF1e39GfKu6s+rXWh9UEVckmplhboka?=
 =?us-ascii?Q?JREnn7UYQpFTm9Mq1eZxQIInEjsQBq+jOC7PPN25DL+JGb1XFoEC+lq9d3+g?=
 =?us-ascii?Q?ruTXjQ0ciGjpyibGOvTBan8pAyk1P923fzt4varineeP8/cXa01v3hVa8GpC?=
 =?us-ascii?Q?sESPvy/itDpcYl/VwyPkBM6WeL7fiLkcf7UanTbO2KDhaCRdaPC7Fi35jWm8?=
 =?us-ascii?Q?oP+tgLt/hr55P769kSonsqp2Y8w6CbsxMvZrMfAqigq6iA8NI8Ep+ghk0kba?=
 =?us-ascii?Q?WvR7novrJ/fCfMQ5ScOU0A0pQFh1z31+edvTjATM49fZUsi/mQGJMIhVEPvH?=
 =?us-ascii?Q?sHb5LusE8zITWEkuT2NM8E1cZTSHpyYJphTEikZ6DLXy9LeVyMTFmnFgz3Y8?=
 =?us-ascii?Q?AFw91Y1K7lBFXFoZEVWIggI2pwqJk6VH3aPlSYlkgoWm9HcpsQFr+qT3ei+9?=
 =?us-ascii?Q?1mxexmdT/cPqxxNN2DWVTt4uJ6a6TkrKbHfn3IiA12xKZ9xyRdPQwHOmaOEz?=
 =?us-ascii?Q?90tv30trs/bL2VQsXgHQ99kSGCUVyb+5ymdVkBDRaA/o45sS3PbQDvfYDFEl?=
 =?us-ascii?Q?6Y7pmjF4sy7Yh6p+g2MqF8B/Z60m5XDNrswdS622jf1BCUxtfBMMyqpyHbjl?=
 =?us-ascii?Q?0lS3xaazR49rJlWoauWqW4ososD0VloAkDq+37v9qaBA8xAgOBLeFEWbhOTT?=
 =?us-ascii?Q?wnYHH1v0HaxAza/0TzkgqKvnRph/KL2paTPz4PI0QTvqSVfbWpm8WOxyqycp?=
 =?us-ascii?Q?W9Ml/7BHhYMBjEwQjx902fHfwYWdU2OF5UyBTeofQqzL6qm2r5ClbA8gja9/?=
 =?us-ascii?Q?LrUVYz0Bs9qUCkP9d2+9EfeLP+NxPgszO3IPuahJ2VXvXO0J1RGYKLECyqsh?=
 =?us-ascii?Q?jmKbrxFd1chRu5edKlhUAgPNTChuRvKoyc9RfK/wIF47ELbmEtQSa3RDhYdV?=
 =?us-ascii?Q?KlvKmtm6kGl59QSF/V6ceLO+f92Bk8Kl/izjuSxeJ9iZ+dU9CwpkiGtBbu3b?=
 =?us-ascii?Q?kFUuSM/gz2upJoZ0wsA6+BJgYTAmKDTCl8XxzfrfVMMlJwbz0zfU4W6WcTcI?=
 =?us-ascii?Q?FkYFsk3ixck74Z81+G0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7142099003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BbdRHa8ZhjfiO2X8ZkfhuqVqv8K0QEFwy8/8cuZ72vuMMkWFIazgzEYsGzHZ?=
 =?us-ascii?Q?vUi35ATfD51+u0a+7OsVfxrlJjempaMO+aYb+fAJy0C02vwa255QgKZQggJZ?=
 =?us-ascii?Q?/ZixIanLbRVzmXbQWu6lyCfWpbY8S9UzFNdeh6PRlDN/PM+WnfX0hMemSphD?=
 =?us-ascii?Q?69TUqgVOaDqwEq729dnkNmSU93t4SYqXD8ZQ5V0BRj0S0Or4TS+EuOfDGH6T?=
 =?us-ascii?Q?nenOp1eco5yLZexGOGj5Zq0xWw1R8/SbzHqHrj6ZrSBTbIMjcUhGNRkX6WdI?=
 =?us-ascii?Q?7MhvR5+1Q50sIbigPrHUuiLmwmj6/AKUYAKtqesHcVfMvqEm9BZ3kdK79erY?=
 =?us-ascii?Q?ATmCRRbyFI6otLSBDcKYPGEtEAp1SSkKZEqVDbqXgr+P95XRhyrIHWlznQ6x?=
 =?us-ascii?Q?oC8K2YZFAcF5CYjdYvLUSPruce5aApz7fQEh784UNQShDfrau2cT/ZhAF29i?=
 =?us-ascii?Q?AChtmOf+Qg2eaK5EgzEV6YLeiNgqa0mF0mXLi8RIKLIh20VMdrLIvVGiHJH6?=
 =?us-ascii?Q?nIb1uVzvYqXefg+RFdHKCjbUKBTDmPO7w9Oted71gEKLD/AamIdb36FELJxB?=
 =?us-ascii?Q?20kQCuHlzyGP1633nsO8WkX2dGIZUmbPp+lxME8rI90VpySlq5WBfOun8kxZ?=
 =?us-ascii?Q?1d6EQ4KJuE24ZJ0O5MvLBe+8fCoFT4kIhZOdQOz5As/aHlwKZChUFCeVaffm?=
 =?us-ascii?Q?MPjbgt5erd38H40CthZGhFLsg419dR05W1xJBLBi+tSZId5c/+Fa71q6xG+m?=
 =?us-ascii?Q?7rfmG5QiZlweP5u+05Nu8je+eYWUJsR25mqE7qE0GwUtsmazBjs2+0t13ZYn?=
 =?us-ascii?Q?oSnqwTGqKQbBglvqJtnWXIb7Z3iWWWYqU4OSNZ84uki2QubxEgCfb+zAId80?=
 =?us-ascii?Q?r5MC3JVc3tgOARCFNLg06MKKSZIljfn/K0ZYiaAYwQj3rNYHp2chcwksXFjx?=
 =?us-ascii?Q?9rBYwlk5IPFI/PiIZ77sM6AuP7hMDF2Jxna9vxIyMHN+qVf+k0l9pe7m4hkA?=
 =?us-ascii?Q?FJAwpGYevbwc9DAxrui5TW3fhYFDgkZ5VDI0iH+ixtMSmRPwLjAmnbrvJ4oP?=
 =?us-ascii?Q?LAi8GMu2FeVbxouS/mw1UX94aI0+Ofs2mRZ7rVnssSZZfJBc4bJQ1AK6WZPc?=
 =?us-ascii?Q?fQWMJQs3s7bBz4A4sC0Hr/zZAAfcOAVlqJeNoMh/0q/ER6xzroqV9mZCAp/h?=
 =?us-ascii?Q?ypGjzho/BVLjYs6w6atLuy+Zb5+m+LFDRWw/BD58tTChu9fu04iiBvNBP8VD?=
 =?us-ascii?Q?IKCIILR/MoZJduGrF5sJqLbzY93zzAxyHDn/eeOkNEaPOfu1NA5J3rcfXmOM?=
 =?us-ascii?Q?rfHLi5AlfWBAPi8upx0VAgKzjs+iWaQEjdwfJmMQcnrA3pKSgwYF7f54nEVi?=
 =?us-ascii?Q?E5I189ATm9Oltu5nAAPkd7jb/gQ81+saYnxSpr0XlDKLkeaInTghfOi+SOvE?=
 =?us-ascii?Q?k1P2bW8/KEU9L37NBM8JhSankawXPUwy/mgQgrUCKiB4UdXUj2MmoyEA74H5?=
 =?us-ascii?Q?VABBdGCMJUyzcAtFOHjkQ2SM961tQlxmxJZ2j774edjhK6uIrep5nwtECVnw?=
 =?us-ascii?Q?szVUSYBs7OYnfLNfJ0lsNVF/Lee5K1resBfCYUTjBmP0JuSuqGf+EMqPonoc?=
 =?us-ascii?Q?V6IjHSe7IJoRV2qj7YMJs0iKL+MNCAq8ZctSrdgmh2QpxQnqC6YvJJOn5zUc?=
 =?us-ascii?Q?xSdmuZMRuZ8pQPU+PNeIWYn3hnfdT1nQcP1AS9jD0QzmENx/GoTbu+rXjiLT?=
 =?us-ascii?Q?p3Xb488z20vt5/Ccz1D+52G3heqMrwE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3ddf6f-b15a-4401-3860-08de6d8047be
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 17:24:46.1016 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xyi5DQm8pQQ//W/RoD+1UfLIpy8UCDQxLu68lZ0ouqnOSp2Q5AU2VqMv3RsoAg5bLjWE3VuGLjILDZvOy7M70mW3tFIpRNG5bO6fLiM6r3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4516
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

On Fri, Feb 13, 2026 at 10:26:30AM +0000, Anatoly Burakov wrote:
> Currently, when configuring RSS (redirection table, lookup table, and
> hash key), we are using rte_zmalloc followed by an immediate rte_free.
> This is not needed as this memory is not being stored anywhere, so
> replace it with regular malloc/free.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_ethdev.c | 4 ++--
>  drivers/net/intel/iavf/iavf_vchnl.c  | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
> index 70eb7e7ec5..d3fa47fd5e 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -1554,7 +1554,7 @@ iavf_dev_rss_reta_update(struct rte_eth_dev *dev,
>  		return -EINVAL;
>  	}
>  
> -	lut = rte_zmalloc("rss_lut", reta_size, 0);
> +	lut = calloc(1, reta_size);

As with i40e, can we make this (and the key allocation below) static based
on max sizes supported?

>  	if (!lut) {
>  		PMD_DRV_LOG(ERR, "No memory can be allocated");
>  		return -ENOMEM;
> @@ -1574,7 +1574,7 @@ iavf_dev_rss_reta_update(struct rte_eth_dev *dev,
>  	ret = iavf_configure_rss_lut(adapter);
>  	if (ret) /* revert back */
>  		rte_memcpy(vf->rss_lut, lut, reta_size);
> -	rte_free(lut);
> +	free(lut);
>  
>  	return ret;
>  }
> diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
> index 9ad39300c6..55986ef909 100644
> --- a/drivers/net/intel/iavf/iavf_vchnl.c
> +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> @@ -1159,7 +1159,7 @@ iavf_configure_rss_lut(struct iavf_adapter *adapter)
>  	int len, err = 0;
>  
>  	len = sizeof(*rss_lut) + vf->vf_res->rss_lut_size - 1;
> -	rss_lut = rte_zmalloc("rss_lut", len, 0);
> +	rss_lut = calloc(1, len);
>  	if (!rss_lut)
>  		return -ENOMEM;
>  
> @@ -1178,7 +1178,7 @@ iavf_configure_rss_lut(struct iavf_adapter *adapter)
>  		PMD_DRV_LOG(ERR,
>  			    "Failed to execute command of OP_CONFIG_RSS_LUT");
>  
> -	rte_free(rss_lut);
> +	free(rss_lut);
>  	return err;
>  }
>  
> @@ -1191,7 +1191,7 @@ iavf_configure_rss_key(struct iavf_adapter *adapter)
>  	int len, err = 0;
>  
>  	len = sizeof(*rss_key) + vf->vf_res->rss_key_size - 1;
> -	rss_key = rte_zmalloc("rss_key", len, 0);
> +	rss_key = calloc(1, len);
>  	if (!rss_key)
>  		return -ENOMEM;
>  
> @@ -1210,7 +1210,7 @@ iavf_configure_rss_key(struct iavf_adapter *adapter)
>  		PMD_DRV_LOG(ERR,
>  			    "Failed to execute command of OP_CONFIG_RSS_KEY");
>  
> -	rte_free(rss_key);
> +	free(rss_key);
>  	return err;
>  }
>  
> -- 
> 2.47.3
> 
