Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53816C5B572
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 15:09:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E3B4427E4;
	Thu, 13 Aug 2026 17:09:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 7A825402D3
 for <dev@dpdk.org>; Thu, 13 Aug 2026 17:09:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786633747; x=1818169747;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=RQaPMygWlbBc378arGyD+7CBIUxkoH/wXhq+OLL6pJM=;
 b=Dmwr7IUqbZ0a1bMXH1u9qfF2LDXmt6RYyVXcslaXjsTBxc185Jg3adba
 29T9fjK1A3iv9ydMzgVWgTszFJb4fwLtq19d0P+l0tskDZWcUcKkxRKsw
 JtRtV21f02N8bdIWi3HksEoftSKvswUHcEIeHZpP/ZfYMZQVngdBw6a4D
 i7ZkaD0kQyc+K3iJRpO4Y59UNjhAIaYgreOA8g8bDUdP2dYGJsIlYjmx4
 3+VkGk54a6FaFJOnHvru1Jd7IobF0pQ/scJJf7+fAU2C62HJS0O6pjjEE
 5sxxkh8cSnYsy8ujQ1Nm9/FANd/qVoVNz8fPxf3djS/BDyDelQWNByo0x Q==;
X-CSE-ConnectionGUID: MnX+5WhCQuSGrl0nOG35/g==
X-CSE-MsgGUID: DsoLnk5TTzq6VyrLFmasgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87231847"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="87231847"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 08:09:06 -0700
X-CSE-ConnectionGUID: u6LVMhbxR6+kr1T5Vx/1Uw==
X-CSE-MsgGUID: A5SRcfyuRCeFvOEX41tPSg==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 08:07:31 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 08:07:30 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 08:07:30 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.16) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 08:07:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ii7DfdfglENykS+IPBzSIACNpCQLUBdbyLAYocgi2W7Oz0VHZ/pILWTeTYgQ6MMWIMK+7PE0KooRbH08XKLK2PZ6tZBGMn+/05KEKlBJt/UaDIObRjpRSQ/phHvQ8eay84Awz6aj16AFDNbdD/y6ww4E1GOr4bfJIU4G+na2PnOZ9AurXJ17iV7H7t6XPjNVNAcxFDh4k7I96ZH89o8Q4imYs2+QpZwEX1+XQ1DK5bwv7OpUt9kFhcgWCw00aE3+EH2aVOa98Z/+nzX7UlxNV0aLuM0gSDazbiE1i3tAzancDAc8qCi4QP9SnW5b6SQZWUmq0F6EXJJ8vZq7q3II9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXP3AIvU8aXg9eVP6R0IRV2vz+w8XEa+kF/vJO7LVfQ=;
 b=K2P6XFzqc6wri0U9J0bCRdPjzpmLrDfeaYDPLwzPGaw990VWnPJEPxfQPZztc0oDyuDhC/0p0+jbRKWnbrWnSHmNb6pWbMF5fvThR9N5kMZS2I/Bf6XOuM4DJjzg8V6nv1Pq1piatPNW6GeaYoBWc5vcHSsgA0FVAu240D2VE8Ih6cfRTpcW+Bho8fejKqwk9nFRxD3eQqsZyVNYYoEpW/i/eufbTeSXcHkaL5Yi1t41MZ6tSOvWokEBF6STfrs6hFCNbBPE8HAM+ZV3e3N0Tf+c9P5QWpR+tzDLHrieNekJTDBhWk0ig6DFfBLq5Od5D9qcgTPSWBiCvR1t2Nxd1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by IA1PR11MB6146.namprd11.prod.outlook.com (2603:10b6:208:3ee::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 13 Aug
 2026 15:07:25 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 15:07:23 +0000
Date: Thu, 13 Aug 2026 16:07:18 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Hailin Xu <hailinx.xu@intel.com>
CC: <dev@dpdk.org>, <manjunathgouda.hosamani@intel.com>
Subject: Re: [PATCH v1] doc/ice: Add E835 to ice guide
Message-ID: <an3dpmK6j_sn0QEl@bricha3-mobl1.ger.corp.intel.com>
References: <20260810020420.128869-1-hailinx.xu@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260810020420.128869-1-hailinx.xu@intel.com>
X-ClientProxiedBy: DUZPR01CA0244.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::13) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|IA1PR11MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: 88abca23-db01-40bf-1960-08def94c9432
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|10067099003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: wKbI+ALxWpXssL/5CvrZnOmY9QgqIJ0MByrOfuCzPnuomqOik5LVVHGwU/HfkXPp3nK8YrQdtbDrZtB3HhDS/pRBP1CwiinM4T38NYlarCqfeL7qbOBhdk8XNUpLjwZmIiTuW0SPIsBuQm+9UshOxteH36RNe9w+2qy+wMucJZF8xE2+8Cm/dJEtqn0d26VkXF/icBzbMlRamf9fTo6Tg62K1hIqsAQ0NLqpsrBKEJFavMEbwX9+V0gr+61sUku6EYDxmq5cSKs3ryLd3J2QxqmzzmQ1EgT47KvBTcLUonYxhglFgl0ysoEUmr2+/omm8N8BGfdcbcVKLEEGMHf1n/z6KTC7fQHPYMIh/3SjI06os/4hFIIr4XWz5KfxeHCOiTFa1aZnHT8XA1Cb/oaZCQiAck7uEJW9FxsgGWRk2KEotfJOEoyIn5iwtbgz8qnjjOKhADc/5bXMSXx8xYHRxi1ZjjbJwMcmEr0WbTvMN6gf9U/kFxelC2WmRR2Qa+C+alSvoQdB0T1r8u/EicYOPU9/JjPgR6RJHgbdGOiHqlWQotC+bePuqipjrMYSzJISVJ6hAl+UrjYhcYc0EUR2QwPymaVSSTc0FVKjAe2lKBtJwGtcX6pFOuguzXPN8PWS4+5HoC3UQYijVZyzL0iGbBKBwZrFbGJlVyOZlVgC2SI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4obX4+EaptNFgUGejML4X12VFfvZNsLPsAt1bteTFk3zmXH+pyjsH2ev64CE?=
 =?us-ascii?Q?Oy0nEshvxRbNCF+L3ECDHCOccrbJht5uvC1am76RrXxz1vcMEscH94WCtBCF?=
 =?us-ascii?Q?WV4dgzj1e0AREu4djJ/gP+4hQTlt99hNrrM0bhY1sETtqvv8BdiiaR//1Cl8?=
 =?us-ascii?Q?2bKQAuznxdNitzBx+49txlDZZzUl4Pn3RZzX5ywyM4kAw5jzO1H0MrEp7pIy?=
 =?us-ascii?Q?Q8/gVeEvrKtvNmb+EHM+5lCEFvPTQPeeVN5TmuFRHJFP+6t87M4/QeczfLNw?=
 =?us-ascii?Q?uJ+MrfUSV03uPjY4SS4I1mtUpbyJYPRtH0IGU2NPY+JFBCWTBMoZ9EgVvQSD?=
 =?us-ascii?Q?qqYW/krG32aJL+3fcZBTxteS6c66mv7UZtRcWxVHuck4atv8rcVsQaEToaYr?=
 =?us-ascii?Q?5wJdzl4DnWvuCQe6zy3qZSBeywkrDlH5xdlF8yLQGTOnGoDPcEIZKsUij7xl?=
 =?us-ascii?Q?YNUjH5O5ZwsecfIUGZ9ejvFANQI0vF6wNhDehPxxCcWqjH83q8M/SG+ypIRG?=
 =?us-ascii?Q?P1I6Ku8EGoec+Sf2XtpC4iRGjIvN34wiYlDQJ7SI6K0g6xAk0UlG+hKjN96j?=
 =?us-ascii?Q?VwnWeVaoExxB3uN/CkGv3AFxK95tlhWp3vR1LxCKlJz4Y+q7chmFhaGetr9L?=
 =?us-ascii?Q?BAc974sx3f40XqwLpLSnFeuoy0Q/S+gNe9B40NYfeTLFuUWf96fZOFfPEpug?=
 =?us-ascii?Q?z93lReBn8BzMQPhMYIUrMZGtUSdae2zNFlEUdp9YaMfCkKO3M9Yaoh16KNh+?=
 =?us-ascii?Q?DeSfnXFQoAUX8yyGxSXNANCcFG3aTYng9gojtgI4tXKQLANAbVeCFtqo1hFO?=
 =?us-ascii?Q?R3f2hGKhAP5EetSNlnKV19oEtzp+lpF5fBxwiA2WP6r7lO9fqqDj8mywQttW?=
 =?us-ascii?Q?l+Tdf4cim1uYVzoNBUHf6spu1B6kjmoMrIRHCAUR0JzhkJ6OUD5xtSwrCiI6?=
 =?us-ascii?Q?THfIDAz2r6LM3TqmqNg+S517+md9cC8fi0K1p5I3iaC21bF7aJybKyMzbKtJ?=
 =?us-ascii?Q?m7rePD8LWSW1MSuZk+RHjrVIMYP23Hg8b0k4AZcKpgSWPpOqo3q/SYjTDTiV?=
 =?us-ascii?Q?WIrDFedeaN+b32gNYx2JM69jGin5QxghuRU/7QAh7nhEF36vvlyBtMrioilX?=
 =?us-ascii?Q?PB9PCuoipjxL1hCX+tx5Ft8X59geG1TqtxwqrZIC90QIfvEdqmksEjrzaWEH?=
 =?us-ascii?Q?BLtkwRSetMDwgz6S010HQNm536jOgyzf5sS4RkU/k3BHOVZjTArnObX8q0Dv?=
 =?us-ascii?Q?9PWjC88vbV5AMQmSl8nS272f5YiEaIydn85gIMGPMaVxntT0gFGkC8+cEa/Q?=
 =?us-ascii?Q?+YdiJhQtNjgepX0uqxHu/53qeAufFg8ezAsMoC0Io8KvqcZk4hTh2phL3Rab?=
 =?us-ascii?Q?zbe4PH3YQEQ/TaSSk7p8yBmyk6Bi0PPlS4D9se3U0Vvwuol+UaW3U3J8VnHf?=
 =?us-ascii?Q?Z3AkoDge7nxQjLB5m8fi8un/sWFSHT4t5SGRbek7+xzO06AkDizz/j2Qotmi?=
 =?us-ascii?Q?K7Z6k3JpbLzQqpNaqNRYfWb7H3l0Zeq+ZU/p77JBTe8i75XzEqjeMm14GhKC?=
 =?us-ascii?Q?dcyQoU+pKS26flrt8I3AXIwvbqCLS9NLNlRVxMLrRhS9fml2asjYQ6V5yhhU?=
 =?us-ascii?Q?dM0dpB5iQkuXw2ZhnE8kkIRjOVhukB+61zCW6NfiMB28oN0NRQ1N7Lxo+POu?=
 =?us-ascii?Q?3KMlOjIE4p2qsJRvjB+ngbjdLcGU1Tpwv2MRyxDCs73rFG2t3lle3T7lVd7N?=
 =?us-ascii?Q?sEPcOoNE2h0OuPtCdvSqbeMyFmwmwNE=3D?=
X-Exchange-RoutingPolicyChecked: hIijAKjzU4j1vo9JJH7n70wIgG3qhjI8KyDmjdwh5ZXrcGXioHc1XbjCgSl/X3RFwRq9YRuDwFWDL41wdxkiyld7Mf2HGKBH1JBniwdmP4miWIQ50gls/LHjJnhWse2DXlX4O/8Wk5qQpqHcYyJDQRkMtlQlV8MBf33vgL/G9r9MLLqXGBTMHa4oZ5iv7r29N/nYBL1TfshHLQXpObsrO7b7CExnzTd2C3E0PqyMqPgqjzYEkoievEXpORZcP7pecf1DXoBVEpWMLuKcqv4L92d4jYhLSnKm97lQY2jV1MpLkh8Q3d1BTTRJaOrWy9v/+y14KAiTga91h58ipa8HXg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 88abca23-db01-40bf-1960-08def94c9432
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 15:07:23.4212 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: abBOgHozNHquUZpIXn5m7pnhDgSGEpFRzPYg4luewCccWqsF84pj3xZ9pj43TN1DS4qKchbJ33k9A9cTPJ5mKYhk6Mw9a0XC+lKmIy8nxXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6146
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

On Mon, Aug 10, 2026 at 10:04:20AM +0800, Hailin Xu wrote:
> Signed-off-by: Hailin Xu <hailinx.xu@intel.com>
> ---
>  doc/guides/nics/ice.rst | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Some suggested tweaks below, which I will make on apply, thanks.

> 
> diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
> index b671422ad7..e908b11f6b 100644
> --- a/doc/guides/nics/ice.rst
> +++ b/doc/guides/nics/ice.rst
> @@ -13,6 +13,7 @@ the following controllers,
>  - Intel Ethernet Connection E823
>  - Intel Ethernet Connection E825
>  - Intel Ethernet Controller E830
> +- Intel Ethernet Controller E835
>  
>  Linux Prerequisites
>  -------------------
> @@ -58,16 +59,16 @@ The full list of in-tree and out-of-tree Linux kernel drivers from kernel.org
>  and Linux distributions that were tested and verified
>  are listed in the Tested Platforms section of the Release Notes for each release.
>  
> -=====  =============  ===========  =========  ============  =======  =======
> -DPDK   Kernel Driver  Default DDP  COMMS DDP  Wireless DDP  E810 FW  E830 FW
> -=====  =============  ===========  =========  ============  =======  =======
> -26.07     2.6.6         1.3.59      1.3.63       1.3.28      5.0      2.10
> -26.03     2.4.5         1.3.53      1.3.61       1.3.25      4.91     1.20
> -25.11     2.3.14        1.3.43      1.3.55       1.3.25      4.9      1.11
> +=====  =============  ===========  =========  ============  =======  ============
> +DPDK   Kernel Driver  Default DDP  COMMS DDP  Wireless DDP  E810 FW  E830&E835 FW

I think it might be better to write as "E830/E835" rather than using an
"&". It seems a bit easier to read.

> +=====  =============  ===========  =========  ============  =======  ============
> +26.07     2.6.6         1.3.59      1.3.63       1.3.28      5.0        2.10
> +26.03     2.4.5         1.3.53      1.3.61       1.3.25      4.91       1.20
> +25.11     2.3.14        1.3.43      1.3.55       1.3.25      4.9        1.11

I don't think it's worth adding an extra space to these numbers, increasing
the diff unnecessarily. It's only really the headers which change.

>  24.11     1.15.4        1.3.36      1.3.46       1.3.14      4.6
>  23.11     1.13.7        1.3.36      1.3.46       1.3.14      4.4
>  22.11     1.10.1        1.3.30      1.3.37       1.3.10      4.1
> -=====  =============  ===========  =========  ============  =======  =======
> +=====  =============  ===========  =========  ============  =======  ============
>  
>  
>  Dynamic Device Personalization (DDP) package loading
> -- 
> 2.34.1
> 
