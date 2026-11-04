Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C29606A337
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 17:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FGZm4jUd
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1697C40BA2;
	Wed,  4 Nov 2026 18:52:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTPS id E3E0640281;
 Wed,  4 Nov 2026 18:52:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793814748; x=1825350748;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=pnsxdv/Y9kcuUaZ2d/wrYsApgjj7Xf24kkSvJ/JSSR0=;
 b=FGZm4jUd9nWYv8tk+gfmy2D9eNuXAMt3lbsMhxSopky/cG1F+zmq16xJ
 LWPCxyeo3DvOiM3pH7KoIBvOsWxnlWVWLiMJouzPImexfDw7PthnbnI0N
 A1Uc4wj9JJQ3yfEepD4gtaCv3KCxXeWpJZGKjF4qsSMZLrImHH58XAHtu
 wJtXAztaP0gWhDGmBbnpjaFmHgl9hJ38xxloRmZodYrWLT3HlRWhac+dT
 p8s5TWpPtOQfIB3PhPYeDtHWEPFOXwJminRlYVU6M60+Ekd+Z1/CQAip8
 gEi7p4f2CtTfctgY5HBi3jQMJj3eTxuFPfW12g5mBLIP+0xXg0aOXIR/7 A==;
X-CSE-ConnectionGUID: 6zLf6j6vSruVaT4B1SXj/A==
X-CSE-MsgGUID: owxpzO65SwOWIzw2UA0XwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2461588"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2461588"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 09:52:26 -0800
X-CSE-ConnectionGUID: nOuvz82KQxOyfo9U4dYwTQ==
X-CSE-MsgGUID: vdZOjPRmSc6LgQZRf/yLiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6638313"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 09:52:25 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 09:52:24 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 09:52:24 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.5) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 09:52:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8vtW12dcUr6p9Kx6Ln5jJy4+AERVbCeVyRLj7lX0uHxM5BE005Vsv+TrsnJKSfHzQiLIjUrn6mFbJltZzLRRtfAj4xQKFSlOueO0yjCIFRC2U27QM7ToQmaK8JT8ghHCsIrJA2LrwWqKQfQV8ajnRWYmuPVawyjizYTvfS+Q0gzCECx5QoxZevPTm7XCtIdcKrUuBi5vR/Yb6i1c6ljaOHF/JmgXlD256l4jYAeWKbsO0oS0wH6Oq5/6yLc1gw+Q0mNSt7oZi2PoabLAnfKjyxiP9MTxwHAzCeHiAZHM5KMg1G5SB944bLfeMu5aiMpy+kQg29Y5Rg4mwUVI12jdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkVdtzmJdUbpg/xJ7tKptYE0nxpg9GESrlpiinaTWvk=;
 b=kQUOy0N0JokmfAQZlQv8c4RqCe28t8MYtWPEYR+lHWnwXGW1v5MSs5M9aiDyIm/SCS1BIKI7FT7sRwOgzQeP9dgZaIFh2kgXZR0T3TtjdEeD08eHLk69Tprx9NKjCXzSS+AIOXM83CBmAKM1V6DkX+y0NV5BzeNfDSBHh8fPa/uk7utONjZk+rBrvRiJWi8Vb0uJH73B6bZe1J9KcF/EF1ClAG9/WJFQwpAGF1XDrSlY8Ijmugi4XMVSDTENlO7u0DOGHV21gdyca2IqQVvjApjt5TB34wQJdvayLKdMum7k6gfw8NgIPWp0drIfLsMc7vUvtIwCVSUj2Cfe+qcHRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CH4PR11MB704740.namprd11.prod.outlook.com (2603:10b6:610:51d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 17:52:23 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 17:52:23 +0000
Date: Wed, 4 Nov 2026 17:52:18 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v2 2/3] net/iavf: fix event handler leak on init failure
Message-ID: <autw0ugUodpzr59G@bricha3-mobl1.ger.corp.intel.com>
References: <20261104095510.10246-1-ciara.loftus@intel.com>
 <20261104095510.10246-3-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261104095510.10246-3-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZP191CA0020.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::7) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CH4PR11MB704740:EE_
X-MS-Office365-Filtering-Correlation-Id: 59aea9cb-fdb8-456a-77a1-08df3a9c612a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|10067099003|18002099003|22082099003|3023799007|11063799006|4143699003|261022075727099003|261022105027099003|261028144727099003|261102124527099003|261026140227099003|261026121527099003|261102123227099003|261021121427099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: lAVlNbQwY5O0a1KQdyRFbIpspWJR1suUq5gg4BeExGOspmRvEiiS1mkc/erOqgHTsfHI8fIThw5TNFT2mjPClBnXi1l3a+WT8C6lNImZbxkZyxgg/T/iO4mL4yUkPIdoTtfo+hkJ2Sv8wemmXxirSMODJ1c91WOO3zi+fewmj1+mQbhsdjEOZzERUlrNZ5pPaH5kHMQZxykIhIHpVaxjCxVRKkAutOUCN6Y4CrjiGsJvaEDM03XC13HYPZ5ms/6zuJxV9GHc7itF5UAgGS+X3NC/W6teWNbEvu7UFzFtv+nlKajz7On893uX8Ai3shtKrOolzS/nd6ttp1Z0zlX8a+Gxq7Q/LyTuqDpPamnAzk8zzPNnc/Tg/bbUNK39iXklrHlQ2oDdC096EyFJ5rTndqgkBvl9Y9Tgcqk/sJx3K4uTLgGMByjCj41GoyoPSPn+AcopZVx1vSrKUoebmGjxsYWGLcHO6qJDnSTBhV02tH20RqNJ1WVuu3tHK0/oCwGbpRmDSA+O1d8mCG0xTklPFea16whKZzRFnsOW6HDcQySclU4Bz8sAf5yGMwoyPDPbtvRB9UPPSfv7qDYgBGsRvkEPbPUO5VnVUHfuN+bFNdlpZMFVEi/OKhKmeW+xYBSlLpaVkNUNzr7O8o3p0SaA5xPphOYhF6DfEqHdWh7r8G0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(3023799007)(11063799006)(4143699003)(261022075727099003)(261022105027099003)(261028144727099003)(261102124527099003)(261026140227099003)(261026121527099003)(261102123227099003)(261021121427099003)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T3sRDfFjaxBdMSFotuepM94h+MCpL0o4T047IgWj1A+PtWH9FMNHHXPaTM7g?=
 =?us-ascii?Q?EiJ1FF6Cw69lGOpl8h+HYr7hL20DvbBZg58l4nro/P7ZjSkhFCVGTTa6e5N+?=
 =?us-ascii?Q?n+iy/3nvVl2e/JLdEZ+oAzYyUOmCEFUoSWZUg3kr5LuBfI/ouJMz2viNSOtJ?=
 =?us-ascii?Q?7BnxtCVzHLoZ9BDUTWPYatyCVPVdELVnzDe10gqnm8UsKCqCmC9uEDETW0xY?=
 =?us-ascii?Q?k7QlPhlYQyOKxXREGQmJr4aJEq2/gplITd4AJpbGzTSY50OTSMbsVGIKxhC+?=
 =?us-ascii?Q?+V1WFoIcrW44fPFB6ydoIFEbiXGG6WIxwXnJdvaGxvF8mZnaukE7SlMjqQVz?=
 =?us-ascii?Q?bNMSXm63cUlfA6SKWynR6pMJCzuedLEPaleMhsvk9DR402sUVoVVGpnPe/TO?=
 =?us-ascii?Q?RPrKfyJMlWmzenLgzMqIoJ//u+RZLCqFV49tSH8/2OC46+WsRVvTurYPTpbu?=
 =?us-ascii?Q?6CkMDy1VHsTitOL/u3nBIJcXE7+NbNikiQQU0UgVsba6rZaow2oT9EK3Iayw?=
 =?us-ascii?Q?cP68KRA+XW3jUx0Z3gv9YamGrw2dPynXgfJAgqrwJKuZYMDmLKwGPIZBDmd2?=
 =?us-ascii?Q?YM4PYiEq9da3LOGvX9u/Q5NJXgbMQbc+lXznwboiOn9eWjj5KueDKX1chIGT?=
 =?us-ascii?Q?m7HoiFzWcjC85AhG2I71U+WsHfsNOiFHueEIfy/MZHyTH3UbbjEgf+gCtPZZ?=
 =?us-ascii?Q?BcvsHRnM9L04nk+7Tgb2S4p+XdBtaaEaatqhKhetflxykHmwYdNWHV3izmU/?=
 =?us-ascii?Q?kbIztZx+BQ+6jHzhHyRx/oa1Yo7Wg/TXrsHP1A+5FpgNLZnfz8g/k6tNz5NI?=
 =?us-ascii?Q?BLppEVviJMj5HWOPgJztnwYlyYD+xuVKXDegCcNLFNd/UBrOlkmHF+I9sgzr?=
 =?us-ascii?Q?hOPkx4AmRk5T/C3XvsT7o6X40ZNrPBJIrQLBPNCIca9iBXxst7bp8XK7CseS?=
 =?us-ascii?Q?CGKGlslxXkYQ9ZXRZybkPR+ICOVBLe6GqYY5MuQW4Vd5ZywdvvPI8hZqRky5?=
 =?us-ascii?Q?Zxe9hvV+caPex4pPEHhz3RhLOMjdecMpDDVi9DquFluQoTNFD0s7XO+fdiW1?=
 =?us-ascii?Q?fMugjCnOHdOMDk6z6DbgKwe2LUIjfDaUMh0RjAZJjEZAgNaBENBUeup4nm4C?=
 =?us-ascii?Q?HH2ppw7xJDp6E2Acg7jielhJeOu8UUdq95sXdHtvFTNAJHfpx5mWUJhymIHD?=
 =?us-ascii?Q?0t35kxVjMaghalrTc3DAydB7D1krLM+Y3a8Uvxp7YZuJ38W4HRloGBV7HKUv?=
 =?us-ascii?Q?W65Kb+rYuI18cSjudqjljNd/7DLeATG3A8qX9FgmZ9wtw8ippmnJ+3vgw8cq?=
 =?us-ascii?Q?HEvjHzE42Ve9AgC+guwx/7XL1CP4t8aijoogO0AAsOmsBtGP844a65xEaGgi?=
 =?us-ascii?Q?4b8cD4cPcmLeiHv1b1G2zHpecrG2TCD1CCKM9NwGqJVdHzeMZipswF+o2C8E?=
 =?us-ascii?Q?5UWz5Ay2k17IzQbKaDDNChiPpPjzp3VpWt5oW6f66uLjr02Z8Z7Wt80fFFhf?=
 =?us-ascii?Q?qkBl/895yW7lHvZ2AJuGpEOEdezhQZHBbsQTXU1zrrRdbqANqq1T7L9hq96M?=
 =?us-ascii?Q?cUrl854xiJQ5xi/JqP7U8kFo/ZumgCKVFDU2IAO6Byf8cM7bHXUpNfW3UtAD?=
 =?us-ascii?Q?T1oK5rAXt6SrL6Rs0ZjgaoIhIxH8OlYP+gc+cJcy/horqSl/DOSxw5ryWZHT?=
 =?us-ascii?Q?C7kVZjufp/VwgEW5Wy/5f+TECFVxkBQ2txzHO6Uw/gKg2wjLmHf1YqygOZCf?=
 =?us-ascii?Q?sw/Hpyj992F4DOujl0i0tvB1iqmZj/k=3D?=
X-Exchange-RoutingPolicyChecked: WpAfD8bQd87HIgoZIH2DfEHZiGKCAjx5V132tZq5IT0QgTAzljh5DEC+sV1cUb4/XUM+rswDZyJNdiOPQ3Rg8yh4kUjv6kykCnr/6roVIV56/WwzgHyYLMpOvLw2eZzAbEpvS+m0WKmX2KjrZ6d1cwF1TI5BWnI/05uouNc8qBDiSfN4jQQbWV1TDqv+SKAzxNHLVo0BYGfJVEmBksLZA0WRbhIX26DlyejbeURVoh8OTxuMGIdjELNqjhaVevcVQX93c+w3osD2+g3iRh7PKJMsWN43FhQ1PtWRhhraB5qAt2isL2K/9ZY6oJ4wM7CT/j2ugvcFTD3/8gKOJsN4Lg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 59aea9cb-fdb8-456a-77a1-08df3a9c612a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 17:52:23.0248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZhTl8lZMfKjN2vCqmRshLeSJg9YDvhDC3tmgFivOSYFQ5o1yMiwm2w0Os3pSvR/OILHuuFppkr/woplpF9E3wWwnChjHwACPYaLuIQUbglU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR11MB704740
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 09:55:08AM +0000, Ciara Loftus wrote:
> iavf_dev_init() takes a reference on the shared event handler, but
> does not release it if initialisation subsequently fails. The event
> thread and its pipe are then never released.
> 
> Release the reference on these error paths. Skip it during reset
> recovery, where no reference is taken.
> 
> Fixes: cb5c1b91f76f ("net/iavf: add thread for event callbacks")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_ethdev.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
