Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93050C369D5
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Apr 2025 15:38:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFA6D40678;
	Mon, 28 Apr 2025 17:38:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 8A0204021F;
 Mon, 28 Apr 2025 17:38:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745854706; x=1777390706;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=XLI+bRPA1jfLo+Sj0d2uArZq90kOFuBwbnoZf3RnbFo=;
 b=Z9unHQ9ATNqV4RxJW9Av/BZemDn1nRmMCIDuZ8JYT1IeZk8/8lGKnC29
 ZNSuL/Qy0aO0UTQowDxrltJIE+P8MGASDde+Y4xogF8hGWh0c7MFFTKk5
 eV0fiJxLXrYL19/IKgC+OmfocX0es0be/vOeHnw7nce5emcpoPdt1u+nq
 b4SCkT59fKouPxw95JqIKZqxwAqDIfqF8KLddAKkBr6Z4NblKMCdXutMd
 o0XarF40FkpCUv9UmI6evBwwLoP2HIhujGhb+xD5Brrn3XKWRRuaZqJHU
 nmCUD1op+vLIhSU72C84/UOhthSygRTU9eo8ANN0jIUTmjaMhn9DrY1xr w==;
X-CSE-ConnectionGUID: 0Q0bw/erS72yvetsgMPcMQ==
X-CSE-MsgGUID: W09eUoemTOew5nuvqhSZwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="46567752"
X-IronPort-AV: E=Sophos;i="6.15,246,1739865600"; d="scan'208";a="46567752"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2025 08:38:25 -0700
X-CSE-ConnectionGUID: fK3H5pnRSdKzWJeCIU1aRw==
X-CSE-MsgGUID: S5A+DDKcT7Gr+WLnqj4ANg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,246,1739865600"; d="scan'208";a="137598960"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2025 08:38:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 28 Apr 2025 08:38:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 28 Apr 2025 08:38:24 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 28 Apr 2025 08:38:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ce8dmtDcEI3qhNZSdDIZnLJue3NugU7jstbyzTJ/SMNwBGpIhVxNpWgDcEx5/fSUrXAinOxdcZH135DhBTOY9x/u8KYSBnglwK1xmSOX3zeHB28OpGFNa9zyl8xj2y3aJRa3JtVKX1oUxCQyRZDlYNAnkmv6sUZCcEtDHrDlvUX1o0yc3AoZaccHn1rXQh6UvQloE55JICDFNWsYOPROcUQKJ8cgR42P1QSiSn+VPi+j83kRG6LaM/4R0hI4DD2coB0rjGscqnVB4QFdsVrbfUIYCWPvL5D1ZZV7ufbMCi5RokPU/Cdqs4JwTGeaVb9wxQIj6LWLapMs52Pj4rCvPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2Ot7Rzwiejzalxvk6kXdkk20acx8kDozxM8cZwXhPE=;
 b=TXAK3XE5A0irdsLtgLZdP0IlKKw7dlKe6EHlqmvaGWh6HMnbAXdRSA7Z2CSYkKHJdPBUCM1+0RX/v5ym79Wya3L2G/mpaVXOtuYezRuOpmVyUhvVfMQMPey4iDKBQcBT6XozRHsSz4CMGNxk6G7xM5S/jbGWhHB2zVLe0+GzHqQXqwdiRfAitz+tkdzE6uPuEYdR7V9l4pD49wUpk6t0DPCLD3TMIsvNkB+fDWfOBYPj+rN8uc8o3WrL1MX4pJdVGACxsZ/gYvy89TOFI+gbTiGjPRVkf3G7w+RJFBZu7nsxa5G0i1B+WX5DKlXQrI9XvAe8BsyhFV5zcCkhAswJYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA3PR11MB8001.namprd11.prod.outlook.com (2603:10b6:806:2f5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 15:37:49 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 15:37:49 +0000
Date: Mon, 28 Apr 2025 16:37:44 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Yuan Wang <yuanx.wang@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] net/e1000: fix eeprom dump failure
Message-ID: <aA-gyMpePWTBiqzr@bricha3-mobl1.ger.corp.intel.com>
References: <20250415074802.454733-1-yuanx.wang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250415074802.454733-1-yuanx.wang@intel.com>
X-ClientProxiedBy: DU7P194CA0013.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA3PR11MB8001:EE_
X-MS-Office365-Filtering-Correlation-Id: c7a22690-e4ff-41ef-ae23-08dd866aa19c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ap8MkVX6LiRXeLNtizEfjNODr913qxvZtDnefEXq0HptKz2b5LZig5nuYH3U?=
 =?us-ascii?Q?kg+28MlUREBhKi5vc+tS2VSLFzALcFYdFXNDM6QKf7ln1T1LcC1+A9wYQ4Do?=
 =?us-ascii?Q?5J3QKgq8KdhYvjj4XVie02QxOlRbZu1QWDTm/tKyWtZ0qCUxq0XGk+T9zhAX?=
 =?us-ascii?Q?5fDT0clQFkt+qAbzy68RL3MNDeWDk/VlMeQGZx7mK2gvBWo1atib3vLhE/C+?=
 =?us-ascii?Q?kwawrKm8MRPzPu3yWgP1ZLL3JkSJD8tYDvcFOL/VKmDgTB8LKZwS0ob8A2w3?=
 =?us-ascii?Q?+d5WLv42ZsdiIoekc3N9rcLRcw/KQn9BiWMa4VxTlcFiDtfSaqInLaV3miQV?=
 =?us-ascii?Q?dIA3q7AYOuJ2YUm1LFixWSF+ZtoWYZrP/tTPi1PQsysTrk72Te2vX1FnMeTa?=
 =?us-ascii?Q?vShfU9u5cq/8ekrPJzO5a/taKj4Xdo/xcxLgAsUPtRDBUA4gvOpzwU0KbpUN?=
 =?us-ascii?Q?diHYt6rwzc87yxbkMJ8Y9vYNX3ohCpzCiE/WRNPCGMx4ASqG4dK/DueCSdPB?=
 =?us-ascii?Q?F7odoph+aA4l+Kf2C+GikNWEkOOxD1WG8X7PTkDfuZBFGDKY2fL4/MOanFM/?=
 =?us-ascii?Q?9X4QAdICAiGnpptNpKYau434IFzJ1oYUzMu5k1Vt05IDN4H7xN8G2bWs5jhF?=
 =?us-ascii?Q?omA5rUKH0ePm83dQCLW5IeNJNu/Sr30zNsuGJ4HQRiVANR0tKnIzLtqZ9BD1?=
 =?us-ascii?Q?Krz1nZ8ezC9uoyjY31peBeekfYuU2IeDhDcN1UDPpFm868YUbPhgi2/OQPk+?=
 =?us-ascii?Q?lGiEFdFytln7MriH0XzzxbotYXaje/7HDUwFri7HnRtKvcggSKF5eYzEfYoa?=
 =?us-ascii?Q?1XiImvSzWVEnCxqBW6YK3KUwVund6jCn3nZKrcVKhxrXaWGbcVxSNGB3KzEL?=
 =?us-ascii?Q?yWWGc9pUMRkZdBauJXikvehuG/tsrB2zjtTyKMFmVzRanuSbbod6D2Xgil0q?=
 =?us-ascii?Q?jPOkmq6YcxjDEqkJq2zeP1zwad3NqDaCQEOXeqQhMKyf3HjXXTuudhiMVbvR?=
 =?us-ascii?Q?j45lr89g6e3jcbR2PJJbKTh5M1o6fT5ZRr5pjlz9hqV9qFpW0Ffi/qtbvwuZ?=
 =?us-ascii?Q?2D8FY4ZwdF7txf8RhwOl3WvQEeFDAxS87FL5aZFOa7lJ+2ADsQkTZTVXdxG4?=
 =?us-ascii?Q?kR2QOpjgpNr32cYdyZu+qY5zgZk1F6jJc/QT2x0ymj7fjaQqelsXEKPekcG9?=
 =?us-ascii?Q?I8JBwfoHJfIy0/jYZuhHWom4Vqh+w94fiQ5DVhd81jJ1E670+3ze3T0Gbazx?=
 =?us-ascii?Q?MwibhPG2lEZSNlMVc/rqvL0fRff6kBvja6eaJWjgf6fq6SsH6Um4kXAJ0U83?=
 =?us-ascii?Q?P9APRcbCuU3O9lGtRdL7bO9qLEmAJB9JQ9M2ZDwIKitGEyFVb1M+TkAwM9U1?=
 =?us-ascii?Q?SmOdbic59W39QC4SN1kUrObdszmeauHOv3WBuNtwj2pimC2WFDPQPj2y/3RX?=
 =?us-ascii?Q?gnKk1enTYj8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uwcPpgLKTpgmWc1e9srvslpnnc/9m25M/rAlJWf1+uh3Ow/90/F6do+S6lg8?=
 =?us-ascii?Q?2P3/gQEkN+QItKBaCgYarAFqRWk2OajAHX9SiOcT7nR3P2RnjBtR+loegZM6?=
 =?us-ascii?Q?+OHg27/ZdnVQYhol6n/vqLTwcMgMAdWQcDjYh3EBLiQW32C6BtdcuLjG/Kd+?=
 =?us-ascii?Q?nxuFQjVjP+zBEcsZ2STkqn1ihaNz5WeWBgVf0vYHLyQyJvlNHb/Rn3+kETmr?=
 =?us-ascii?Q?6j4oC5+LAxH0CTBiyN+Y+HOg0ODJRZIlgpiS7b1k6JJk6eyX3jHfWAAfY3l6?=
 =?us-ascii?Q?u0R6K8DmXFHPT0gIICU8w0TEPMYW465akZHBbOug5ngZh0iVE2KGu8pHycB7?=
 =?us-ascii?Q?EMntz3GdkJLQN/TRVaj+4iDqNbcve08v0+nFaPc2i5t2qXv/cJdz/72+q6E8?=
 =?us-ascii?Q?eRh2OxJvluj3TQnEmQflu3ROBGSPj9RwI8rK9Ecm8l3QwSjLzw5QdzZphRKt?=
 =?us-ascii?Q?2UeQtjq6ThIwtmn182kDp9SJ9opf3/SMeqNzLORDqzIqQ1FmFyHGsgMCzbbp?=
 =?us-ascii?Q?CXhAYdB9lyVxX1m1Q5QPHTE/JuSAGYmDspKXMBWHfJcE/JX8JHf4gEWsfkUw?=
 =?us-ascii?Q?5UaE3eB234PUawdrh5ZHR0ifc2scDkPJ8vzusPMiJ/ysaSsQSr+UPGEQD61Q?=
 =?us-ascii?Q?FXD7kZOva8s7MouvpDcLYlkOBVeGrKT2S2FEi9Gp1UQ3x7vrYWclDXLOXGXm?=
 =?us-ascii?Q?wKw4Y7wXMhhSWjfE2JUn0z6kZR1dEL00gbB3XfDUqWO/t6AgdKYYaX4LspwX?=
 =?us-ascii?Q?MhfVP+6oISqoEV3M0Oei67iGrDou3MRoFhQtjrsMTIBjskQhBK8ixc8MdLzG?=
 =?us-ascii?Q?O2n/nVx+XW4KkZQp05f4AavU8A9MMaKbOVS6I7yjWOdQWIx8sti0wKSGqGNX?=
 =?us-ascii?Q?aKOyDiAtAVTw3+o4Oez5mweCku7D0iEzLeNuVNsWF0x+IuwIExQStatCDJf/?=
 =?us-ascii?Q?XLlnpMrk2CtcX88Vrzl2+sJyv+f5r3ZJNVJ7kBBYmXTREcDyp7VH30O6JBal?=
 =?us-ascii?Q?1UbZSrNd92JMUTcvje7SxqIYLkxkykMrHMD/B4VTFJmYjOOz59zZvg+68glZ?=
 =?us-ascii?Q?oDsR1E7vgZ9H14JzS+4X+QIcWD0p5+LAWhy/YoHe6KNt+obMbm9ouXnDgq+j?=
 =?us-ascii?Q?EzZT6N1G5RpQKAHV6eOCHiDuL2Xhih82LRhZdf6WgIVO+HOkxxX6XjYlVe+y?=
 =?us-ascii?Q?O3EWBHXpxOVCPm7wNfonpn/5gY4ow6mlIJdbVnf/LAwLCQBQzDUhX6KUdhCs?=
 =?us-ascii?Q?46V7K9BacJvwit4JDuJPVnvsakOPXxoa9HAdTaGUtJsyXzZtCrCrJ3028yc+?=
 =?us-ascii?Q?64TQ3jCeXn7SlmF7Uk6xTDTiLOkDIgbgm3aXxYuND25UggXrcHVdKvrijqeW?=
 =?us-ascii?Q?pdg4zz9nCxWa40ZfbWZae3Yurf7p91xxSQtsS3hWcKKjDB24KzqE5phrKG6w?=
 =?us-ascii?Q?l40z7/EAsEoPF0GPjErMYycxBcHhitnlozQ+N6nLdA+3bsc7dxDwGo7m8RTl?=
 =?us-ascii?Q?IsDfmZd6FX0YWdwBWnlGueQkbz+ELOZk9zOyYfEWpp3R2el0XeKMP7nvYpK1?=
 =?us-ascii?Q?HHBopozIMTop1ibovSUZGTHnhp36KffiGMGQ36ouJab1CTYKOJTc/gQjkyNG?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a22690-e4ff-41ef-ae23-08dd866aa19c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 15:37:49.4257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2/+3M9OhvU197o7BOOeKeaAt4i+F6Ft5IpIOfoBhhPZKmyZwj87RBRpyPM8+PpQ5ihjVHpb+bYC5zt2KKoBpsQO6taZnrUp/bxfeutbipVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8001
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

On Tue, Apr 15, 2025 at 03:48:02PM +0800, Yuan Wang wrote:
> There is a incorrect comparison in get_eeprom that cause epprom dump fail.
> This patch fixes this issue.
> 
> Fixes: 83c314da4c38 (igb: add access to specific device info)
> Cc: stable@dpdk.org
> 
> Signed-off-by: Yuan Wang <yuanx.wang@intel.com>
> ---
>  drivers/net/intel/e1000/igb_ethdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/intel/e1000/igb_ethdev.c b/drivers/net/intel/e1000/igb_ethdev.c
> index cbd2f15f5f..738c0ef895 100644
> --- a/drivers/net/intel/e1000/igb_ethdev.c
> +++ b/drivers/net/intel/e1000/igb_ethdev.c
> @@ -5219,7 +5219,7 @@ eth_igb_get_eeprom(struct rte_eth_dev *dev,
>  	first = in_eeprom->offset >> 1;
>  	length = in_eeprom->length >> 1;
>  	if ((first >= hw->nvm.word_size) ||
> -	    ((first + length) >= hw->nvm.word_size))
> +	    ((first + length) > hw->nvm.word_size))
>  		return -EINVAL;
>  

Fix makes sense.
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel

Thanks,
/Bruce
