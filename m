Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77D8C87FD2
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 10:53:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 259FF4042E;
	Mon, 11 Aug 2025 12:53:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 331D14013F
 for <dev@dpdk.org>; Mon, 11 Aug 2025 12:53:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754909637; x=1786445637;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=j5gAw9kUVrE/I2JmM37fn5p0Y0+YBYlIO5iycJTn8Vg=;
 b=afKIOV41O12v3EtbUDrk/inIKOWIDKZa7c3qdiWMT0LYVwp2Fqot6keR
 pTBhi3hYc9t5jwibTczy7nkkFnI23pas6IyMi/CjDxumMHGXU8ML8i7UJ
 AX4Svy44DnDXvdgh5c0CDxT990Odirvqlkgst6s1rR1n+04nGgnMwxCke
 kiC14XnaM1tlOgxmXoqg/Cw9U/8Pc6peHdUL6aWNcE0Jq2qcvpxqxRI8U
 sKOQrNngN0hxqmlWOm765R3ICUFt0hVJj3EFNjrKNsyQD2665qq/WfwNA
 +ov/pCiSk1Xz9LrAjY+E4sG0egjSnFwAHouQvTFVJs9Ysj9OpZBpezpNt A==;
X-CSE-ConnectionGUID: XS7/l8yJSF+egvKrFELI3g==
X-CSE-MsgGUID: JoIGjHrCR3uTbzowUYHQRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="68527547"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; d="scan'208";a="68527547"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2025 03:53:52 -0700
X-CSE-ConnectionGUID: r3h9YWncRzubW2KqjflamA==
X-CSE-MsgGUID: VovJJ/YjQCy7aSUQ5nt62Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; d="scan'208";a="165877749"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2025 03:53:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 03:53:50 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 11 Aug 2025 03:53:50 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.53)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 03:53:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P95q/Lh1nWYN3RDcAjvl7VbQm62D8h+rw23zymznPfvnCQlzuPUc2spYYCgwTTwNv3uvi5IQoF5uD1buyURLkwY5oqY/8Qj4cAp77VuikqZjOuMe9fQxeAPU/xRz8BRH9l9mXqwFkoVNkqyvqsyQJAeFO8w80dyvU6gBbAFYFK9nxGQwq0hKx+pHp3uAH7BBaFQ20B1+YFJ/OpxWeFOg8+kxqm6scEF8+UJII/3aNDWgw7Q1gLMuEtfWMGfXXfsOCHfQYjQKrZ1DMXWpKNE2Eb+GvyL1V/MBQeK9ckLvazQVR8YQLz2/Cm9cHRqCQ82N5i/uXfG5npuJIwTmrENFFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MMt1tqPJMCDRbXf7gWalPqBqogJj/XG/VLO/eb758w=;
 b=PDM+rZOqyfQzqK8mFGc2nqXedWE0J/cZoR1NDW4Jh07chqj3Hp/FLz6uEGhRlmNZOBET3+RlSCCBnwFEhyyIaDsf6RFjlFhEsk9jq6h2HP1CFjzdS5fGgw6eRPDIEgpegrRqeggFlRPFpiaV4+fD8UUtthvQd9y2wXhaA2D2e0xl6hhH323M2mdx9L49JJ0T1aobKRPn31nz1HpBoVfVGqbXo0elecm2rlr5McjTzti7mbo7nvqaOa3f0rYL4FFtg90Kg5z9FVTH7UaxhaKoIhCQCN3S9uOCiZoGhm6ur6iyAlsdMOCTAcoISeNgKO5DEGvzvDfGQMbkWSJi31w/aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB5944.namprd11.prod.outlook.com (2603:10b6:510:124::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 10:53:48 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 10:53:47 +0000
Date: Mon, 11 Aug 2025 11:53:39 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 08/15] net/i40e: use the new common vector capability
 function
Message-ID: <aJnLs6ZBzoHxKPsC@bricha3-mobl1.ger.corp.intel.com>
References: <20250725124919.3564890-1-ciara.loftus@intel.com>
 <20250807123949.4063416-1-ciara.loftus@intel.com>
 <20250807123949.4063416-9-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250807123949.4063416-9-ciara.loftus@intel.com>
X-ClientProxiedBy: DU2P251CA0010.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::25) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB5944:EE_
X-MS-Office365-Filtering-Correlation-Id: 6379915a-bca4-40e5-904c-08ddd8c55965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p050tKQJQXselesN/29BOn9jTqZw1OshMypRX77pl2tlVbVQOujSoQNHodOy?=
 =?us-ascii?Q?AQFa2oWriRlU5/D5dQ3N3uwFShDX+oAE2B/0u7q+IbAPRn6Z9a9qJAeIhO+c?=
 =?us-ascii?Q?3vXH+VhQtNCIYU6e71wtPIOXT69MS78+hVKkEkNld9YHmrcObX8UYi/aJzUM?=
 =?us-ascii?Q?FCaiiuxP+sQCFUv+K+gzQwUCn7qjaAS78HV1boAe7OzHolHscpYHgT4uQzoz?=
 =?us-ascii?Q?pvfoRNy7CF6jp+2DGBUlR53Pj8PodLkKjBGXPLBzz1H3Afl7e26HEgBPCa/P?=
 =?us-ascii?Q?4OaEZDBW7NHvUYWfu4omcmee2WlgKUSXGAUSg5ysk4qIWyuZj7L8RDHP5I34?=
 =?us-ascii?Q?9z60JwBapSCUT86mhbl9/x1BSgsHnW2mAMYjyWZVfljYG8whLc3HrRjb+qEN?=
 =?us-ascii?Q?MEIx9UG1f2opINvpUl6lXbeDLS5l9qF9fXYF0IHxkz81p3Yc5Ce4Ko5ainAx?=
 =?us-ascii?Q?KR509tVPuHzgevBbbPSQdbToJH2rVf8bwLac3QZGF9+B1q+ozv0oarXq3OhQ?=
 =?us-ascii?Q?uD/OdsPprBMhybki67kHjp8o7ykJuD/oAKVxTxJtkNXrDaP0/M1RfTAMpqkC?=
 =?us-ascii?Q?ZxJLGfMAiZIYv7zYzcJqA+4Iw5neZCkyElDhrK97WQD2MpCCyEj906ZRmN7c?=
 =?us-ascii?Q?sxjOaHHKYRY5yOgl0jgLSgHCSzJOdS6kVKlUFh6LSuED6wa1NrGjJuBgVYA4?=
 =?us-ascii?Q?dF/3AM+L+jCEtxpIxs4PLJbmIJQ7PKIH6S6Q/bHMZ/JAjN/eXjDXLgA+QKh8?=
 =?us-ascii?Q?zqWMa6jMmRsedKVWVWJeoGos88y0ua981OWkzLlw6Ws4u8+4Y0RVGo7eDyfA?=
 =?us-ascii?Q?54hO1HW6v3QgxkxJXaZgmR4ebDYmA2r5Kd/q7rmVdO8m1uDDwsv1hiGV8qMI?=
 =?us-ascii?Q?iEno7yRqhSY3ewJwgOAJUdIBEfRPQVAxvGHhiHs+XBo3qtN/2r7U2XKywDTu?=
 =?us-ascii?Q?kvdJLLYMUbT6iAkXVhKYkM2t1c9NJZcfD5Mg26CFtv/4ixq4a60VTq8gna5b?=
 =?us-ascii?Q?3WfHk1Su+QGQ99WzrAsjcS1dkQg07bQGK3I3jRBqK8nO8AjcfZivhNvcqJCt?=
 =?us-ascii?Q?oeL3yojzgX6Z5TvCWEf1wffsMehCnq0p+iqVMqHIlhySke5RA+CBpSa8QDRw?=
 =?us-ascii?Q?RLSTn5NeQArS8Xn5mg+/QPeQIV8fdTOp0k83SRXYu5LDPhudq2+GttNKbVjl?=
 =?us-ascii?Q?cHqrM0JmpQ219kr1jI+NXMTQHduWR8hXwdGJ/x6n2iPwPjgPC/g87M7amhtX?=
 =?us-ascii?Q?pXkx+hejHztdQL1d0GpLMs9tJDaiU76uNkwd9yGycEW9x3DxuXJGMwbL8K76?=
 =?us-ascii?Q?ofiDZNiqD/3+fxDKkNmXowiTagXSnBVhAAjrmx/X/xnXxPhgHuNYLFAli43t?=
 =?us-ascii?Q?1RcDVH1ufKHCsyjwKRt70Dvh3WK6b/nfIJvEX9cH//GXYjIFPF/xfn79bQDA?=
 =?us-ascii?Q?1lDEcrOHFtQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k42LQAYZ8tJQK3EfXn4LDG+804QInWG+QzIWXbf5A2ZuML+xvVU0uzVsj0QJ?=
 =?us-ascii?Q?UQ5zGkJ42NVXZdcAC+7i4h3/3c3teme8Xj5vWWwJ4OL3JgRMdTWF6I9vsqwk?=
 =?us-ascii?Q?lmnW7xEVNkoMJ06QhLkq6XPwSyRvx8zq2xaG4M97cw/eNe7tvdd1DL7g8uFI?=
 =?us-ascii?Q?EPCY4ckb3V8eTPU0/nEsfY+Pa4dSNxtWbdy7YPkEz5O9pz4Xvah7cGit2wD6?=
 =?us-ascii?Q?mlaKsX1kbyOAJKblC8td6tFdBUaO6hcpfkD9F0JmuDieL9NsjD1EvKu6M8G1?=
 =?us-ascii?Q?3OAuOnFAoNyK5fOBZovZw5v73RiMZyEdCDFv49EluUKrgaNmAmGw3tB+pjzS?=
 =?us-ascii?Q?EmUMsU5gqtgJA9nqtXSjTEDXguDpS+BPIB/Sw3ZnWQtm+XBwMFyutgBeWlGp?=
 =?us-ascii?Q?c8eFmMWXYVWRPcF+DXiGhD7N0exwIhGW3R3VdICRfWb9fDVCLvuMiOjTKLZN?=
 =?us-ascii?Q?60LNWo76meLtmdtr5wXDhSB9a9xBmPd1bibeDXYFAW6biPkKurPM/mXzzet7?=
 =?us-ascii?Q?6xDRBa2CAwW0Akq6tIq1EFqqVb+AzRn9J6u7zy/Ywgka4KQnelU0H4GHH0qV?=
 =?us-ascii?Q?b7nEDcHeGQVNfa4JjYxK1pPkCU8NpFDXFaHMGZdaKICetzjkHHv/GvZpTSnH?=
 =?us-ascii?Q?q7xOT+g4mhAvg8vsGMjOtnjBNjPh4Ffj0B9yq6G0L+yVZNITxUUKAXW5l3ju?=
 =?us-ascii?Q?G1HUzYvVZSgyTSaUe62h95FtSWMcvFBEqwCDBG8u8alZW024pYr5akV+330Q?=
 =?us-ascii?Q?KAty/XniXdVmOoLmlS/ZrfC8jRjrfJNoEE1csaA8jTOvygnm2KzN++GsACq+?=
 =?us-ascii?Q?bIt2cWDyVaN14MpCQz2y7sBs7llndGRBfBQ6+tAAUf7/dfh80e4kCYkw8bo3?=
 =?us-ascii?Q?jpbFmC0MW0DZZ1c+EUJ1hmFNWJNDoK8uQGzQvifXJL4KxUycpj/Qw7pq6e4+?=
 =?us-ascii?Q?90Ur4OUJs9V8yN/YJ26iqamAE8fCAk8gXSvYmRwLqW+RUDa2UcKcsq41soiT?=
 =?us-ascii?Q?RREv3SqFNyaKEDXih7Ui3L0T1g9QFd5pNWfp8SrPe0wgOTZne0lm5WEhNiVg?=
 =?us-ascii?Q?Q/GTaR12StJsohc7xa3KIx0JGbiJ5EdMjFTVogN6N85z38ai+pD2KPCQFE4C?=
 =?us-ascii?Q?OR08NnAMNxXRHaUx+tuDAt8f35Ac02z91eJ4Nho5S0D2+hw/z0yzYAIfpdc2?=
 =?us-ascii?Q?i/WH7tBxjRwAhe4axNp3R1JumqqDglTZpHQ9mON0tx9Uquwfu9GlOvx/2ESD?=
 =?us-ascii?Q?M2ZtBPpzBpKjvsFgNC8UjbA1AtJID+HayJ1NiJ5kF4sfnYaL05+30j37eZn5?=
 =?us-ascii?Q?z0LfPsRacRLaeCN4nJiZ/WL5rhLtSK1RjyRDefOLpqpp3U6kkZ1XF6DoCK9c?=
 =?us-ascii?Q?GvUXzUC9VE6GajqoyZgOII7H6ValbYyusIPMt8xm/WgpWn+r1+6uDOiomvof?=
 =?us-ascii?Q?1lXu2NQAnNg7hAUjyMGWd6mrPOmTzQllGFbbnVDoiO/NEBAZRjkGKBB1BPPv?=
 =?us-ascii?Q?QSWXCRQ05Q2M6Z5b8oxGUIFBMwEqgm56ZaR3oYxn7qPe6J4oZbStQV8xMGpq?=
 =?us-ascii?Q?CGK6nPCxQwA3UYoJd7ErfDc3S48zsb00Mf01iv1QLQ4U+qgWuYEX/EyP1fRr?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6379915a-bca4-40e5-904c-08ddd8c55965
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 10:53:47.8793 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: scnPCW/AWhw6sJi7XLaqJaCLV3PuXhaYGV+upWpkqnmT235pY0zt+cxAGXvKlmU9TT713RxkL6OCkppxAHpnecOQ1BVFy9qrK/hrU2aUvE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5944
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

On Thu, Aug 07, 2025 at 12:39:42PM +0000, Ciara Loftus wrote:
> Use the new function for determining the maximum simd bitwidth in
> the i40e driver.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Some comments inline below.
> ---
>  drivers/net/intel/i40e/i40e_ethdev.h       |  5 +-
>  drivers/net/intel/i40e/i40e_rxtx.c         | 57 ++++------------------
>  drivers/net/intel/i40e/i40e_rxtx.h         |  1 +
>  drivers/net/intel/i40e/i40e_rxtx_vec_sse.c |  6 +++
>  4 files changed, 18 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
> index c38cb5f340..3fca089d6c 100644
> --- a/drivers/net/intel/i40e/i40e_ethdev.h
> +++ b/drivers/net/intel/i40e/i40e_ethdev.h
> @@ -15,6 +15,7 @@
>  #include <rte_flow_driver.h>
>  #include <rte_tm_driver.h>
>  #include "rte_pmd_i40e.h"
> +#include <rte_vect.h>
>  
>  #include "base/i40e_register.h"
>  #include "base/i40e_type.h"
> @@ -1279,9 +1280,7 @@ struct i40e_adapter {
>  	/* For RSS reta table update */
>  	uint8_t rss_reta_updated;
>  
> -	/* used only on x86, zero on other architectures */
> -	bool tx_use_avx2;
> -	bool tx_use_avx512;
> +	enum rte_vect_max_simd tx_simd_width;
>  };
>  
>  /**
> diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
> index c89359e625..2a6b74ecc7 100644
> --- a/drivers/net/intel/i40e/i40e_rxtx.c
> +++ b/drivers/net/intel/i40e/i40e_rxtx.c
> @@ -3284,32 +3284,6 @@ i40e_recycle_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
>  	}
>  }
>  
> -#ifdef RTE_ARCH_X86
> -static inline bool
> -get_avx_supported(bool request_avx512)
> -{
> -	if (request_avx512) {
> -		if (rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_512 &&
> -		rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1 &&
> -		rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512BW) == 1)
> -#ifdef CC_AVX512_SUPPORT
> -			return true;
> -#else
> -		PMD_DRV_LOG(NOTICE,
> -			"AVX512 is not supported in build env");
> -		return false;
> -#endif
> -	} else {
> -		if (rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_256 &&
> -				rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) == 1 &&
> -				rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1)
> -			return true;
> -	}
> -
> -	return false;
> -}
> -#endif /* RTE_ARCH_X86 */
> -
>  static const struct {
>  	eth_rx_burst_t pkt_burst;
>  	const char *info;
> @@ -3351,7 +3325,7 @@ i40e_set_rx_function(struct rte_eth_dev *dev)
>  	 * conditions to be met and Rx Bulk Allocation should be allowed.
>  	 */
>  #ifdef RTE_ARCH_X86
> -	bool rx_use_avx512 = false, rx_use_avx2 = false;
> +	enum rte_vect_max_simd rx_simd_width = i40e_get_max_simd_bitwidth();
>  #endif
>  	if (i40e_rx_vec_dev_conf_condition_check(dev) || !ad->rx_bulk_alloc_allowed) {
>  		PMD_INIT_LOG(DEBUG, "Port[%d] doesn't meet"
> @@ -3370,35 +3344,29 @@ i40e_set_rx_function(struct rte_eth_dev *dev)
>  				break;
>  			}
>  		}
> -#ifdef RTE_ARCH_X86
> -		rx_use_avx512 = get_avx_supported(1);
> -
> -		if (!rx_use_avx512)
> -			rx_use_avx2 = get_avx_supported(0);
> -#endif
>  	}
>  
>  	if (ad->rx_vec_allowed && rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
>  #ifdef RTE_ARCH_X86
>  		if (dev->data->scattered_rx) {
> -			if (rx_use_avx512) {
> +			if (rx_simd_width == RTE_VECT_SIMD_512) {
>  #ifdef CC_AVX512_SUPPORT
>  				ad->rx_func_type = I40E_RX_AVX512_SCATTERED;
>  #endif

As with the "ice" patch, I suspect you probably don't need these guards.

>  			} else {
> -				ad->rx_func_type = rx_use_avx2 ?
> +				ad->rx_func_type = (rx_simd_width == RTE_VECT_SIMD_256) ?
>  					I40E_RX_AVX2_SCATTERED :
>  					I40E_RX_SCATTERED;
>  				dev->recycle_rx_descriptors_refill =
>  					i40e_recycle_rx_descriptors_refill_vec;
>  			}
>  		} else {
> -			if (rx_use_avx512) {
> +			if (rx_simd_width == RTE_VECT_SIMD_512) {
>  #ifdef CC_AVX512_SUPPORT
>  				ad->rx_func_type = I40E_RX_AVX512;
>  #endif

Ditto.

>  			} else {
> -				ad->rx_func_type = rx_use_avx2 ?
> +				ad->rx_func_type = (rx_simd_width == RTE_VECT_SIMD_256) ?
>  					I40E_RX_AVX2 :
>  					I40E_RX_SSE;
>  				dev->recycle_rx_descriptors_refill =
> @@ -3509,8 +3477,7 @@ i40e_set_tx_function(struct rte_eth_dev *dev)
>  
>  	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
>  #ifdef RTE_ARCH_X86
> -		ad->tx_use_avx2 = false;
> -		ad->tx_use_avx512 = false;
> +		ad->tx_simd_width = i40e_get_max_simd_bitwidth();
>  #endif
>  		if (ad->tx_vec_allowed) {
>  			for (i = 0; i < dev->data->nb_tx_queues; i++) {
> @@ -3522,12 +3489,6 @@ i40e_set_tx_function(struct rte_eth_dev *dev)
>  					break;
>  				}
>  			}
> -#ifdef RTE_ARCH_X86
> -			ad->tx_use_avx512 = get_avx_supported(1);
> -
> -			if (!ad->tx_use_avx512)
> -				ad->tx_use_avx2 = get_avx_supported(0);
> -#endif
>  		}
>  	}
>  
> @@ -3537,7 +3498,7 @@ i40e_set_tx_function(struct rte_eth_dev *dev)
>  	if (ad->tx_simple_allowed) {
>  		if (ad->tx_vec_allowed) {
>  #ifdef RTE_ARCH_X86
> -			if (ad->tx_use_avx512) {
> +			if (ad->tx_simd_width == RTE_VECT_SIMD_512) {
>  #ifdef CC_AVX512_SUPPORT
>  				PMD_DRV_LOG(NOTICE, "Using AVX512 Vector Tx (port %d).",
>  					    dev->data->port_id);

Whether or not the whole block needs and AVX512_SUPPORT guard, the print
statement definitely doesn't need to be inside it. In fact, if the guard is
necessary, there should also be an else block, giving an error that we got
into the block without CC_AVX512_SUPPORT being set. That should never
occur.

> @@ -3545,9 +3506,9 @@ i40e_set_tx_function(struct rte_eth_dev *dev)
>  #endif
>  			} else {
>  				PMD_INIT_LOG(DEBUG, "Using %sVector Tx (port %d).",
> -					     ad->tx_use_avx2 ? "avx2 " : "",
> +					     ad->tx_simd_width == RTE_VECT_SIMD_256 ? "avx2 " : "",
>  					     dev->data->port_id);
> -				dev->tx_pkt_burst = ad->tx_use_avx2 ?
> +				dev->tx_pkt_burst = ad->tx_simd_width == RTE_VECT_SIMD_256 ?
>  						    i40e_xmit_pkts_vec_avx2 :
>  						    i40e_xmit_pkts_vec;
>  				dev->recycle_tx_mbufs_reuse = i40e_recycle_tx_mbufs_reuse_vec;
> diff --git a/drivers/net/intel/i40e/i40e_rxtx.h b/drivers/net/intel/i40e/i40e_rxtx.h
> index 984532c507..b867e18daf 100644
> --- a/drivers/net/intel/i40e/i40e_rxtx.h
> +++ b/drivers/net/intel/i40e/i40e_rxtx.h
> @@ -167,6 +167,7 @@ uint16_t i40e_recv_scattered_pkts_vec_avx512(void *rx_queue,
>  uint16_t i40e_xmit_pkts_vec_avx512(void *tx_queue,
>  				   struct rte_mbuf **tx_pkts,
>  				   uint16_t nb_pkts);
> +enum rte_vect_max_simd i40e_get_max_simd_bitwidth(void);
>  
>  /* For each value it means, datasheet of hardware can tell more details
>   *
> diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c b/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c
> index 15cf07e548..c035408dcc 100644
> --- a/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c
> +++ b/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c
> @@ -715,3 +715,9 @@ i40e_rx_vec_dev_conf_condition_check(struct rte_eth_dev *dev)
>  {
>  	return i40e_rx_vec_dev_conf_condition_check_default(dev);
>  }
> +
> +enum rte_vect_max_simd
> +i40e_get_max_simd_bitwidth(void)
> +{
> +	return ci_get_x86_max_simd_bitwidth();
> +}
> -- 
> 2.34.1
> 
