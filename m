Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D17CCFA03
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 14:22:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F5534042E;
	Thu,  6 Nov 2025 15:22:29 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 1AA5A4013F;
 Thu,  6 Nov 2025 15:22:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762438948; x=1793974948;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=txDZzrqky4yF7x8bmbdx5+B0371EImXwsX3w6m4+45c=;
 b=FbYqfS89nHCZvAz23qiQ6ll4SNRjqNjYHwqMSnvpYpVGXd70pRmRrrL6
 f1hn1lRxCodEUfcI2uYMKLOjLK/od69gDoBwEX1Xm4sWjeKS1d0xfuffS
 KzICMjcKdm3Vfjk7MbNoKfjOW1/8Kv8ktyKEYTqM3xkI0YpaRMsTpsgS1
 kKcJD7REGfcgcrVKGm5NJS4RiHzMV5OB7+SfGAVqDDRy2i+FDlDW6xtG8
 GUhIawnF2M7qXIq8EC4716xRoUIpBYsAfMFFq/lY8Q/RIWQWf1XsSTkYv
 xoj4NNcvby2W5NMMQjx6kSwCw6ENi7Tjcd8rhToDG4xY7J2tw5JEwMfC9 Q==;
X-CSE-ConnectionGUID: 6qWHmcGDRkul92+nE+XXWw==
X-CSE-MsgGUID: 0VwsYz+QTNaFrbuFq8liuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="87204688"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="87204688"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 06:22:27 -0800
X-CSE-ConnectionGUID: VwZ47lUdQdaTVOaXAGxrYQ==
X-CSE-MsgGUID: RHBVXu1UQ5in9NOsMJ6SIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="187712408"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 06:22:25 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 06:22:21 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 6 Nov 2025 06:22:21 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.63) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 06:22:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4LmPyiScSEm0f7ZNWWDjHxWQ2FJdiJAl0fPQKXcJQNnP96zg7XTqnqSB7hzxCwS8nsaOYtAQZgEphNlt6fymH8ltV88ti9ntLye5+6GSXDIGwbA2gQCV3Y1it2R/ESy6+BasOsvMpzSIu9KlJ3W4+oYI+MkrvWl3DJt5MO8AgsU/rOJF2y2wNJcNcWESrpn7V+19K1p3iFAJpuJEUTIZ1y9d5Af9F887T6Su+h8/0wSv2IPRjq25Yo5025FMhSUsCEYdWKcfuVDmwrDjLBEfjZPacvmM94YzDZz8zTofcXC6hlv6HsxlOmSGgOzgANpySgJ81hOw+MwMyZ5Pa0uJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6E8jc2lPjXQq+WZoPNEQ1R9g7xbzz2y6URpvq1e8os=;
 b=KAksvrf7SU3aaUH98CgEuZRhesK/WrEOwkGGlCHceB0mvdTTxJSzFSN9tFlbkwnJ70ldxe8zcAv0zZFbX70kyf+Du62Dy/uDr00/T5xRe+Uoc6ZTKv3eDqHlZKrmIyIYMudcD3zNRczaFJhncyqR3zmI1R/uNlzina7xFrukLTNuHlw5oz4JKuslUf0wERw6EPWtDYT5eoGYl+pg56IWiGQ+EUWn6a5EQbiYbIYYT85fwNAM++HiItOVGWv/08NhpLp8xx1ieEQfvz+vr8LEKjGbkGXbLQcfDrlyUFHZqvjY+EZTd2baBPF78pGCFKibi8dRc+1PN2+OJ7wvJrOc/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB7249.namprd11.prod.outlook.com (2603:10b6:610:146::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Thu, 6 Nov
 2025 14:22:17 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 14:22:17 +0000
Date: Thu, 6 Nov 2025 14:22:11 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH v4] net/ice: add option to enable source prune
Message-ID: <aQyvE3RkKiTVy0Eu@bricha3-mobl1.ger.corp.intel.com>
References: <20251101104627.64906-1-anurag.mandal@intel.com>
 <20251105183031.91709-1-anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251105183031.91709-1-anurag.mandal@intel.com>
X-ClientProxiedBy: DB9PR01CA0029.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::34) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB7249:EE_
X-MS-Office365-Filtering-Correlation-Id: fbfb408f-6a7f-4f6d-9dfb-08de1d3fe35a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lonpkKTYfHVuoDIctmjOSOVYTMhfUEh082A6vVA2ZGUe6NyEGNC4VYNAnPQq?=
 =?us-ascii?Q?7DkNCugGEgRzMZKa4Nt4sJEE3b0OPnXh7bvSkp//6X9bIwCyxWpOmOsc9RUa?=
 =?us-ascii?Q?4z8dzGf2ngcAvW8kl0Joxxo0O9prDvKftRqPKCMqQ5hqC5G83wnubxGuvdVF?=
 =?us-ascii?Q?fnjK36wCvEekBAS8+AfXoVgM5CGHIf4pAGBR2Jjp/Nj7lMs9FQgZoJECIPn2?=
 =?us-ascii?Q?uzVY4vcQXEyrNAG9zcY9jAY2+/lghsqT5VLVK0EtfuB1tn3yU1/SrLV1Hz9m?=
 =?us-ascii?Q?FDx7Wcl3BNdqOdzHBN3U3yTIUJJGiYHh7WJV1JBgEC/w/aPfYF/VyUKILi7y?=
 =?us-ascii?Q?nfBsJQexbUAbh4MNSXZvE9qFh9/sFZlXHpRMDGOaE0dqG+6yltrIjTMwMsv0?=
 =?us-ascii?Q?mTo5HVmuneXQrOjrJI6LGFgYvbyVcmvCU3WBAY1n6H6j61tcwJwEhF0rYkjh?=
 =?us-ascii?Q?IKFrYbJSIbJPnMeNDqIGlFC9nT+1vf/6/PUXRmIO2SejXmwUAYXBNHXJYpyw?=
 =?us-ascii?Q?TbB5B1XDrYE4dya3lPKMofKdkVSVZOknirqsB75VQcA0nYg9UkSsq/238iar?=
 =?us-ascii?Q?NBGb7p59eKTj9M7Vr9D5tSOL6/CdN8WqoGFHammmP8ZRpwsQwUZ1zE7I/5MR?=
 =?us-ascii?Q?qG3owDuNEgsJIWQWxWDWQYxMzfOA7J6wHUvHPVsvehCuSn4h6os4GoP74kt1?=
 =?us-ascii?Q?Q/fl5AoGvYH/UpkLWq9xOFZze7ASdyHDjaUsESeVe5DLBevQbRi0yjyijWHm?=
 =?us-ascii?Q?cW04V/smn7Y4tr9L2BFKWqZcTqJGxZyws4TVhtMl+OOm0S02SrYohf9iH0K/?=
 =?us-ascii?Q?mR+6xMj434XVGjth3Jp9mzzZGj9v21olkTbt7pepJFd9BcF3PVK2or63n9ZI?=
 =?us-ascii?Q?62aZxgyvm3lsvlVXg+j8Byf2hDSc0lvAqOG1C/zxCJMxlcuwdAmUjKvpFqcF?=
 =?us-ascii?Q?1Phj9z3Y4vCHRPnxwmLErNL9O9zxx8OcbbGb8fmw84PmKLEQkXZS6KHMvzwL?=
 =?us-ascii?Q?TDoKJxQP+wIvA2XQxru4vlT8gKiZhO/NvGTy7nAaVyRYvA3A2mVgkA3ET2h5?=
 =?us-ascii?Q?Y705Z88aXUoaH0mda09GB56cJMV5G/JBlDE6vQ4FC98/Guq7+S3pnRalX8i4?=
 =?us-ascii?Q?TIBEaYGbF8P6asaDd5yWDUkmhFLHmebNyfGe9XYCGZk80wS4A7/Deho0rWEg?=
 =?us-ascii?Q?HDtBMzAhqjIXiP0NV9T4BBDYazEVqgg1GdjH8szBh/QOegwyOd3uwhMZMEIM?=
 =?us-ascii?Q?66AwoERGcziSylH02HsN37jTZoNygfgyhuKFrv+apPYA79lQ8SH50qW6wBJK?=
 =?us-ascii?Q?bc/GmFSG57XmOQ4QLwLK42fuL3OPExr9NzbYi4ufz9HokmP4PddFNYZj2Ofd?=
 =?us-ascii?Q?n4VoqgCKD2KsoZe83O+9uPSbRX62YP2rSzHZ54r1uzSNwbmxDp9EzjzGm5Hl?=
 =?us-ascii?Q?bmGikUNOn4izbDuHy91ziG4NGl2nafZG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X9mJNEveKv2gEGolPQw6cKgwGFHyHybE/jfWrx5MzA/FoUx8gLMqcgS6ynrK?=
 =?us-ascii?Q?jYslz+d0Ke2E0ZXKd8eyZY4tVoba16cz0TRXe4R48agBxKaJFMYmam2aW34T?=
 =?us-ascii?Q?cRUSeeESmUW8dXvtXIVAejw/WurZjwG0xYuveneswBJ12EUZfsMahfoBB5au?=
 =?us-ascii?Q?NL6ZfMsiBAb7UFC3fyUfuJ1IVX4IA5fid8NYmxhWF6cjWM/d1VzZ2vpk3pdY?=
 =?us-ascii?Q?ajR3rasy0aV5TojjdlojnAZApLlAHqet/8faBGEeGu5uKyrLM3beJOEP1OTq?=
 =?us-ascii?Q?kqOtlaKeeyj6EbWCo0oOUNNI4wKRAeDjJlW8gBNkKBgZU2lAYs/y5b4MIBL+?=
 =?us-ascii?Q?DJsw+iqskuZZYAnapl2hMqt3IaElNT/dAIsumNnvz66pgUl6qieWzeyzREdu?=
 =?us-ascii?Q?oyebelsxf6RzVO1auHetI9DxMMeA+P8Xt6701+Vjbwav7Ynnn6Md1CePt6Kv?=
 =?us-ascii?Q?Jklyas3EvdU+LSimF5bBXHS5PbPUeSDcAn6vzXBka5aVK2VV3Rto3p5e/hxr?=
 =?us-ascii?Q?Mr+Y2E4BjYrD51mEe5/KYFVbQeuYOrLY4kofGeQKRLMll6wjBQ5MhQZOzSbC?=
 =?us-ascii?Q?G+Y/LnQuiJq6qIQWiVu0xxFcEs6ycV21A4KAoSUC1tMyvOCE8Ks2Bnetvdy0?=
 =?us-ascii?Q?TImNR+VHkG47XmkUazGsCyu+nL9e4OkEzcda9EgJztbcGcxIsBX14HKr1cfl?=
 =?us-ascii?Q?7EjAnttn38qZxxQhwIpc+FZ7qb8seui2e44YHRAbbWcYM2Eri+oOuvHWMogD?=
 =?us-ascii?Q?ZhTUFsxhqL4+PklONvjenHu/vgghx4JP+mJMM8gsxWSqtDFcVEX1OoHhuotg?=
 =?us-ascii?Q?U2gE6GA58d94wv3loJ555a1KcueoOXNaDl3WHt0CHf05mrXfxN2EXPHuyZh7?=
 =?us-ascii?Q?Q2UktZnjZsrezQ0QL8BqY4rX4rgHQKu75yQkWN/QtGDpfvfBW9aWop/lDZle?=
 =?us-ascii?Q?7Nszyun76LzxyIZa8XJqAmnLHRA+gtmPYQDO0ZkPeot9Kl4hg4tQIqeUtYSM?=
 =?us-ascii?Q?GddRcvSXlfDhLlvzi1MYTWtJXjAF1c68LlD7qTMS1pXpiFbIpyUtdy5e5u7+?=
 =?us-ascii?Q?mnxg4OpHIp3JAq5r/vZ6lA9+xE3z0SldOTQZPFSLMKjZzoz51gWfSFHwOpNq?=
 =?us-ascii?Q?KHmfQgP/VBLct62qwa8kWZqN1LkjNfx0NqhBPEf7XdkC9PDJ9LKIllnTEAf4?=
 =?us-ascii?Q?oC7SyupTDZ8t5J2ix8Se3mykCSZhJoUNOsq3onPBF/H513pRMDN74t9CACej?=
 =?us-ascii?Q?X3qQ1hCTMVVy/Pzz/isnXRlQQuJlEoWYJIMcsho+v8VCgfMMPFBCZEa93pOx?=
 =?us-ascii?Q?ueKD0A5PB5PZ2GYshFeblrEkzOTX8cCvyMqYuiok4PzSD31F9mQa1ebxzXKK?=
 =?us-ascii?Q?XipYgW9jNkZ2F7qDQCg4RxWg5K1jSF6J5LFOHAcAlHPsL1AovDljJdMMk1oo?=
 =?us-ascii?Q?WQ0479mlDNZvIE5Waj31UhAi4HCYv7JGAak5ZgpFxlFOa3nIn62/o9MWMeu2?=
 =?us-ascii?Q?ZyPLGeEHJiDGRaalobv9hYWBsm57ZL5f+Az4/ud7X3CHGZcGiEIg9ecvgMQv?=
 =?us-ascii?Q?j04Welt2qwJG8H1RQSM8WiyUSS3SAge51cGBJc7SvQYnmFF/6mBzZ6h3AoPl?=
 =?us-ascii?Q?Hg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fbfb408f-6a7f-4f6d-9dfb-08de1d3fe35a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 14:22:17.0930 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GI2XrgujXaUAhdrWkNcdwGOlYjoZCiGXoU2rpgxMKz6BPp9bcXdZRvWusFpHhryTyWG5t/hMc4524OMCS5Ewa9TRQqIxx1acKInKb28J2uo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7249
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

On Wed, Nov 05, 2025 at 06:30:31PM +0000, Anurag Mandal wrote:
> Source prune is disabled by default to support
> VRRP advertisement packets in a vsi of ice PF.
> There is no way to enable source prune itself.
> 
> This patch introduces devarg "source-prune-enable" to allow
> user to enable source prune.
> 
> Enable Source Prune to automatically drop incoming packets when
> their source MAC address matches one of the MAC addresses assigned
> to that same NIC port.
> 
> Tested the following with VRRP advertisement packets in a
> vsi of ice PF:
> 1. Source prune default mode with no devarg option.
> 2. Enable source prune with devarg"source-prune-enable=1".
> 3. Disable source prune with devarg"source-prune-enable=0".
> 
> Fixes: 6f866eb93e79 ("net/ice: fix dropped packets when using VRRP")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
> V4: Adressed Bruce Richardson's comment
>  - changed from private API to devarg option.

This looks a better solution to me than a private API. However, it strikes
me as a new feature, rather than a fix, so I'm not sure backporting is
appropriate.

Couple of comments inline below.

Thanks,
/Bruce

> 
>  doc/guides/nics/ice.rst            | 11 +++++++++++
>  drivers/net/intel/ice/ice_ethdev.c | 25 +++++++++++++++++++++++--
>  drivers/net/intel/ice/ice_ethdev.h |  1 +
>  3 files changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
> index 7e9ba23102..09561b08c5 100644
> --- a/doc/guides/nics/ice.rst
> +++ b/doc/guides/nics/ice.rst
> @@ -183,6 +183,17 @@ Runtime Configuration
>    If the value provided is greater than the number of levels provided by the HW,
>    SW will use the hardware maximum value.
>  
> +- ``Source Prune Enable`` (default ``0``)
> +
> +  Enable Source Prune to automatically drop incoming packets when
> +  their source MAC address matches one of the MAC addresses assigned
> +  to that same NIC port.
> +
> +  Source Prune can be enabled by setting the devargs parameter ``source-prune-enable``,
> +  for example::
> +
> +    -a 80:00.0,source-prune-enable=1
> +
I think the word "enable" is unnecessary. Just having the option be
"source-prune" is probably enough, since source-prune=1 is really the same
as source-prune-enable=1.

>  - ``Protocol extraction for per queue``
>  
>    Configure the RX queues to do protocol extraction into mbuf for protocol
> diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
> index 4669eba7c7..540d0bd977 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -41,6 +41,7 @@
>  #define ICE_DDP_FILENAME_ARG      "ddp_pkg_file"
>  #define ICE_DDP_LOAD_SCHED_ARG    "ddp_load_sched_topo"
>  #define ICE_TM_LEVELS_ARG         "tm_sched_levels"
> +#define ICE_SRC_PRUNE_ENABLE_ARG  "source-prune-enable"
>  #define ICE_LINK_STATE_ON_CLOSE   "link_state_on_close"
>  
>  #define ICE_CYCLECOUNTER_MASK  0xffffffffffffffffULL
> @@ -58,6 +59,7 @@ static const char * const ice_valid_args[] = {
>  	ICE_DDP_FILENAME_ARG,
>  	ICE_DDP_LOAD_SCHED_ARG,
>  	ICE_TM_LEVELS_ARG,
> +	ICE_SRC_PRUNE_ENABLE_ARG,
Removing ENABLE also shortens the enum values, enhancing readability.

>  	ICE_LINK_STATE_ON_CLOSE,
>  	NULL
>  };
> @@ -1716,6 +1718,7 @@ ice_setup_vsi(struct ice_pf *pf, enum ice_vsi_type type)
>  	uint16_t max_txqs[ICE_MAX_TRAFFIC_CLASS] = { 0 };
>  	uint8_t tc_bitmap = 0x1;
>  	uint16_t cfg;
> +	struct ice_adapter *ad = (struct ice_adapter *)hw->back;
>  
>  	/* hw->num_lports = 1 in NIC mode */
>  	vsi = rte_zmalloc(NULL, sizeof(struct ice_vsi), 0);
> @@ -1753,8 +1756,20 @@ ice_setup_vsi(struct ice_pf *pf, enum ice_vsi_type type)
>  		 * by ice_init_hw
>  		 */
>  		vsi_ctx.info.sw_id = hw->port_info->sw_id;
> -		vsi_ctx.info.sw_flags = ICE_AQ_VSI_SW_FLAG_LOCAL_LB;
> -		vsi_ctx.info.sw_flags |= ICE_AQ_VSI_SW_FLAG_SRC_PRUNE;
> +		/* Source Prune */drivers/net/intel/ice/ice_ethdev.c:1707:ice_setup_vsi
> +		if (ad->devargs.source_prune_enable == 1) {
> +			/* Enable source prune */
> +			vsi_ctx.info.sw_flags &=
> +				~(ICE_AQ_VSI_SW_FLAG_LOCAL_LB);
> +			vsi_ctx.info.sw_flags &=
> +				~(ICE_AQ_VSI_SW_FLAG_SRC_PRUNE);

I don't believe we need this branch at all. The VSI context is cleared just
before entering this block, so the sw_flags should already be zero.
Notice how in the second block (existing code) we assign software flags
rather than or-ing in the values.

> +		} else {
> +			/* Disable source prune to support VRRP */
> +			vsi_ctx.info.sw_flags =
> +				ICE_AQ_VSI_SW_FLAG_LOCAL_LB;
> +			vsi_ctx.info.sw_flags |=
> +				ICE_AQ_VSI_SW_FLAG_SRC_PRUNE;
> +		}
>  		cfg = ICE_AQ_VSI_PROP_SW_VALID;
>  		vsi_ctx.info.valid_sections |= rte_cpu_to_le_16(cfg);
>  		vsi_ctx.info.sw_flags2 = ICE_AQ_VSI_SW_FLAG_LAN_ENA;
> @@ -2449,6 +2464,11 @@ static int ice_parse_devargs(struct rte_eth_dev *dev)
>  	if (ret)
>  		goto bail;
>  
> +	ret = rte_kvargs_process(kvlist, ICE_SRC_PRUNE_ENABLE_ARG,
> +				 &parse_bool, &ad->devargs.source_prune_enable);
> +	if (ret)
> +		goto bail;
> +
>  	ret = rte_kvargs_process(kvlist, ICE_LINK_STATE_ON_CLOSE,
>  				 &parse_link_state_on_close, &ad->devargs.link_state_on_close);
>  
> @@ -7659,6 +7679,7 @@ RTE_PMD_REGISTER_PARAM_STRING(net_ice,
>  			      ICE_DDP_FILENAME_ARG "=</path/to/file>"
>  			      ICE_DDP_LOAD_SCHED_ARG "=<0|1>"
>  			      ICE_TM_LEVELS_ARG "=<N>"
> +			      ICE_SRC_PRUNE_ENABLE_ARG "=<0|1>"
>  			      ICE_RX_LOW_LATENCY_ARG "=<0|1>"
>  			      ICE_LINK_STATE_ON_CLOSE "=<down|up|initial>");
>  
> diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
> index 6478d6dfbd..408cbe4a38 100644
> --- a/drivers/net/intel/ice/ice_ethdev.h
> +++ b/drivers/net/intel/ice/ice_ethdev.h
> @@ -614,6 +614,7 @@ struct ice_devargs {
>  	uint8_t pps_out_ena;
>  	uint8_t ddp_load_sched;
>  	uint8_t tm_exposed_levels;
> +	uint8_t source_prune_enable;
>  	int link_state_on_close;
>  	int xtr_field_offs;
>  	uint8_t xtr_flag_offs[PROTO_XTR_MAX];
> -- 
> 2.34.1
> 
