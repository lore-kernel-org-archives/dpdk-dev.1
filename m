Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCE0C88E53
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 14:04:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9986B427B3;
	Tue, 15 Sep 2026 16:04:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 06FE0427CB
 for <dev@dpdk.org>; Tue, 15 Sep 2026 16:04:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789481084; x=1821017084;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=dV4FhhHZcPwc2g70XwLz0Wpy5YvjzP9OMcRnR3VP/Y8=;
 b=lT2t4u07yrAIalsQKT0FAEVSOX7qKQyIeUvUAok7mzZl8kTCHRJZgEj0
 v4zuybTBGIGvrsyLpmWrGzsEAVZhjpUjRgnZZpQ245ZNCBDus0AMRj3Hb
 +sL6AWIXo2YQ0vNvpIaNHatTKFaqkEpDdg4ouY/CTvvXD0UGIwRxf8FWI
 E45C8nbqbZv60rLCUpj8+uTg0inyi8ql2SWGb3APs4UsAggurO5ZQDaMb
 5oO7HzeaEh3Wv/vWP4YbdXtu3/Sls+2FbEwgT/d5Z0p94opCHQ0DtRYqD
 K77iyxsBPUvd6i1Qlh6WoyEAnUNrQGYD6f+P5EKYGxf+itoJqvtrLDe5x w==;
X-CSE-ConnectionGUID: 6SBwibtpSyuSKXVD7ywNRw==
X-CSE-MsgGUID: MYszhboaTV2RlrNofRWyxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="101361275"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="101361275"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 07:04:42 -0700
X-CSE-ConnectionGUID: UjUu0Q51Qiuo5AJ/DNpJDQ==
X-CSE-MsgGUID: lqEbDRh5ThuasAQDF9iSwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="273560355"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 07:04:42 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 07:04:41 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 07:04:41 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.5) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 07:04:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8kok1OY/brCV0DS1Cf72F1sKUo1N3TVH8BNc0XbkAnqlOhw3Cx54mJJkW3F1pcqfz5PZIgqWGOETTp7H0nU5bfyPbhwaDSuhuhMt+xj79hwpXI1kWxnKH9pubRBtF1CsviBt8rjvDiHzXuTrfzp3qNdMGuuNdU6y2q7n1WNOp30FiAvZbYd+ZpF0DZ5J9DLKbVSBoTlfcUMwLUb9XG7ZVanX8fGFr0gyEsO5aPDfXt4W0NgYvZn8qfzGDg+bNbDWVGeKFXpRvXqx35+D+WpD2Kl2PunuzCtLpqEt4AjqaBzNIy6l/UZZnDnxLkIr21ZSV1rDUIdk3ixFAhAXg/Gpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUbEV7pbFVAxmmGwGZZEKgtj+Yz4i6gsHo9HPz14rok=;
 b=XGQVntysUcQZLScjeI8VrIZlJCg3fLgOWlOFmmD+6+tuOjAO5Yf9ZAqnevTlsOP0Mktb+MZxWcU1O8Q7yE9aip0XhmOIPMi2gGg4yKnS7TDXFE+Sw6yo2wwRcRvgqOrcmgTUaK6EF0gE6nMB7qzrFdZ2T/b1WuAQ6x3swKMZY1ywWGLWr8485IiNXB1J/N6RUB3WDw1sNS8PMH3XB9jkQO0bswwBs9AeVoqMlSEiNPrJEi0M9LfQoyS4qthdzXOVZKdW6RvgcvgAsWnu56wGXgeYyQdQwsI349bH/a6t/ALXuTBnBTSRk7fCttpXQaqykVj438LGa8AgQBOKANYgmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH7PR11MB7478.namprd11.prod.outlook.com (2603:10b6:510:269::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 14:04:33 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 14:04:32 +0000
Date: Tue, 15 Sep 2026 15:04:27 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Radu Nicolau <radu.nicolau@intel.com>
CC: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>, Jingjing Wu
 <jingjing.wu@intel.com>, Declan Doherty <declan.doherty@intel.com>, "Abhijit
 Sinha" <abhijit.sinha@intel.com>
Subject: Re: [PATCH v1 1/1] net/iavf: fix memory leak on IPsec SP delete
Message-ID: <aqlQaxFKhdADn4yS@bricha3-mobl1.ger.corp.intel.com>
References: <d722699838f742d88098fd31cabac1101b5dc429.1789382934.git.anatoly.burakov@intel.com>
 <8ae87b91-d9ce-41d2-bc17-4abf554d017f@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8ae87b91-d9ce-41d2-bc17-4abf554d017f@intel.com>
X-ClientProxiedBy: DU7P189CA0030.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::34) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH7PR11MB7478:EE_
X-MS-Office365-Filtering-Correlation-Id: 67dda6b5-7976-4e68-fc53-08df1332444a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 3OOXNAvMNbaod/B2xqSIEjWw4iSYwjbGow23VHgEdVKqNh/Xins5m1JdLxz1CEdA1fN0ZW6PXyUMSCq4oc1Nzl2kdYZ9WxPlXJdOR9IB4IYgWENwtQj+uKKxQ196I+F/an34p6aWCxdxVqTddklebe8bX8kPb8swbCZhn1yciTeG14n6vTcsn8gGBIc1Wu3KsR54+8IRWqtHFN0A08SSLq6zQm9nqsuuLRayOPG+m+19pLHbnOO/q1X6/hUbC31PtVixT09BlKx/IEtvWwskDil/HGqpYGht5Caekeq9xaDbeEoICUainz7trkYSHvLmhfrX8vVn5M/8TltWi45HO7DdgCA7WdC0PS+OEYG963kkX71NN3/JmUxjDei5VHE1HloOy6NN31aw87BdmjgWReQzEqDSRrb/Z9U+r1kVQQIZEUE1JiTKbDEfersY9hDZ+Ikvvl3JYE60UwgLGOXeFm41KXpgiQjVHKfA06ggVsSBwwuf1EKt9vBoW5nab6V1ghZHZJukRyN/VW6/XF8hkxVmSiw05j8WP4V4sF1wJZ/5qmnn12L19kliUyDElD/mgTm7fWWLcyzLBLLz9QwrP6ANy9tvlw976AqN8JcVKsEcaDvGzb5ybIhV8Z88mLUetapp7ZaXQeMFbzr2OkHLSASArPvX0ss7THI6VKoywc4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gfpInXHC7pvjIVMbKEntOWaFWXFM7gM4bQqhyrlby2jO2MTE9P90v2yzisy4?=
 =?us-ascii?Q?20k4qzb0kC4LaUvgCuGtsWkQ67hqS+wH0mzzx9XMlYyE1AL0G4yM2yN6aGPv?=
 =?us-ascii?Q?gzVEyZRxl0MUG5R2d/d98PqX80D2Fe20H6qQqI4Sibcla0k2hBbKw2p0GGqX?=
 =?us-ascii?Q?NRKzU7dDQ2korE3Rm485g8yTedaWYuBlgDgZmBISFRi79xs5CGAKXaoDzu0U?=
 =?us-ascii?Q?qjNSf0yACRoPiPjw3qtNK3CctKbbKj9sO4KywWVpIWhSzTtf3ihx5Gw2lhWb?=
 =?us-ascii?Q?2il0SUDWiE2aaHniSNk24AZte5lvlOcHiaCSxxDwvrQBziRDyZEHMyHLilvG?=
 =?us-ascii?Q?4AWwBXY9jsF56XynZQ9lPIgKI0h+0U/ZHf1a9oVlEHZMjJK5ajg4PR4RG01L?=
 =?us-ascii?Q?kR96jLo1keAHPE5Mx8q6sROJ3d4d3FrTjd26RG3uyRd14zu3sbepZ8rtF/P9?=
 =?us-ascii?Q?w7YJPIHWZvT2zS21qNHHrvb27Kl6+VOKTGvXAkvPkEAbTNaCeM9MQbmrIz4M?=
 =?us-ascii?Q?iGxtihIvr+cR2MIXyXnUMb9YUUiApM7i6wE3LA94YQRZTuvumvay4rQd9EU+?=
 =?us-ascii?Q?tkRRjCnGuRSh2YioDDA35gWSTcL1bVyqgFekqTxYBaErn2wF3FAc2Bpmdmdu?=
 =?us-ascii?Q?W0SS9tb8lTc0KT3om9PUtUiegL9kJnYhAD65Q+zH0oDqcCqe41RsTtOCPQ/A?=
 =?us-ascii?Q?KemGTNXUXoeMunIbB+j8Tz2NIjwAMCxB0OrZs72Gx9Yoe3nKPbNk2GoDAyd/?=
 =?us-ascii?Q?/YbJNaP/63Ij3KeeUaEYp0vUIUxEDED3TBk1lcqCAJzRFC9Ypl+cL+6jOibF?=
 =?us-ascii?Q?5A76ZrOXcI+t9K/VoF8hVpCDBGOsrN03fmYSpY7y2wkZzUEsZzwDE3MYrlyw?=
 =?us-ascii?Q?FWygYGBlVDlLO2LHdrpvWHAteXqO4vqlrwgHD08dHC66LchSMUEKv4rUgsT7?=
 =?us-ascii?Q?7UBPWIhXjfPBZeLqPTjuJj9MWYHsO0PV1DbNQMQnFVxVfTeBIbX9qlPd2zjG?=
 =?us-ascii?Q?cKIJz3qbogrT0td9Z9FGqqIS8EGYSJGtwC5NvYTLNI5NbGd0UbyPyJb4JOyV?=
 =?us-ascii?Q?TBDDU9SIfqvXcWfj8fweeQKjSdTN8VKA3TyDrTYBhGNNgH8nspAd/kMg0Gmg?=
 =?us-ascii?Q?b/ZDeGwitEPGyMU/i14NudtwwC+XRZqswJ/xS+4xUIQG5K2ES5pHp6Booxcu?=
 =?us-ascii?Q?n1cAp+rI1X62bJnW1bu9tdheRvX/98AIBCmmvUnytckoZwf1Vaa69cpkaLMA?=
 =?us-ascii?Q?5N1Be69N+aPzIPEVwCIrCrf01MLxdM5ueCVP8r9n1dI5xzOiSII7YpCKq2i1?=
 =?us-ascii?Q?TpNY3IHTrtcq93Y7kkFcOPCQItBLh8LG56Ic5l1uyutbfM0LkoIGHakGinT0?=
 =?us-ascii?Q?CW7YR6xreKOgDPVjEOoEK+VW3axDRk7IukY+fxH+3B5XXZEGMC2koz4WCBj5?=
 =?us-ascii?Q?d3F2LKvr4x7xtf2+lZqYPAhyJKlmWjnjIm+knlA7lBlrO8AHVoH6CO+bGwg3?=
 =?us-ascii?Q?3ATe6AAbRrIAjwqYZaCchz1wXwaz6BOhRT3OM2ANzr6tBNAYGgMk9Xc4YeD1?=
 =?us-ascii?Q?hFZb7jkLbO357AlDYpOGwN4U7kAYURugCEqZ73ecTgW8OmS6VaDQ/M8MlvUT?=
 =?us-ascii?Q?+8XQgaNFxaTdYOWwzd/IoNGqyUeM92DA4ww8+aSUYs7Vve1hUODO1YSyFKCn?=
 =?us-ascii?Q?25n/BiC4HlEfbDC8OtH8JoyPPhxaTbEpbBcVLpvVX4r55PmTJCqkRE1qOcj5?=
 =?us-ascii?Q?OrOhpt6oA+J0mwPlg/XLR7b/9KlmS+k=3D?=
X-Exchange-RoutingPolicyChecked: qy9CaotRrrNaozi4joIGNxtMHwfSp6G1/1yxFxGz5o38IRv+6qFaBHz/I+u8HKAN0YC+lxgAJ+AdGU8p4my8enTvLIeVlnQeHpBuXyggc8qK6E12471HHNB9k3tkTgyd96/9WJXHW6TPwDhoSVQVZRlnEJRvS/oqyz2UefRMlbR3jg2ekFHwYyYOK/BHqL3nSlUamvnMTjTz/IuXmhSpprmY05ay59kklkzqWLT866suMYQU83xvV3eb3CC1lGgPyI8xND9/nLJY1NNgruXPLWmvkZi2mPuV3kDFpAdfsB0fbM1w4IZDyKPdxNJZ+WABwxdaNbOi0EwTtm26WYzbMQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 67dda6b5-7976-4e68-fc53-08df1332444a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 14:04:32.6826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +PBj+W3imAyMISaVDECdMkHaKaL876lp2Xgmg0EBFbkJs8f13dLLqD/480jiS4ri0Wr/3Pu2mCZ+HwnbINMXscaF42WwR1y3jVTKkXx8EeM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7478
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

On Mon, Sep 14, 2026 at 05:13:24PM +0100, Radu Nicolau wrote:
> 
> On 14-Sep-26 11:49 AM, Anatoly Burakov wrote:
> > When deleting IPsec SP, we return status response without freeing the
> > request/response buffers. Do not return and proceed to freeing instead.
> > 
> > Fixes: 6bc987ecb860 ("net/iavf: support IPsec inline crypto")
> > Cc: radu.nicolau@intel.com
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > ---
> Acked-by: Radu Nicolau <radu.nicolau@intel.com>

Applied to dpdk-next-net-intel.
Thanks,
/Bruce
