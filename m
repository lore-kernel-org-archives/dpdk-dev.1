Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66F5EF48ED
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 08:45:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93BBA402B2;
	Fri, 13 Feb 2026 09:45:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 4006E402A9
 for <dev@dpdk.org>; Fri, 13 Feb 2026 09:44:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770972298; x=1802508298;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=g8IJdKrFql/kRDFxbTFYEd/iieHjuCj7Wo+ioDA06HE=;
 b=OaokONj9jp9GILHRQoueYoKTTGbP42dpKPzia4xTAL0k01zXZzbNDUyT
 T0gG4ty82nRixgZUwN2CNVwggllyB9sLg6lQm8eMTtQUpmIG6wufUjMvA
 lFT0UuO7xEUkC8kmiRZXnm9eJ0fXlZu0Pp+mKP8QlhUESGgkfhL1ow176
 pnMXnQ0PuoN94pTB4McAdQ5ef0Jl3qRWbVDX+Bi2DK93JLnDNcy+0/nT+
 ZHM7N6oC97WvxLPAHwTi1rHCT+HGZTb5zfpeozY/21qkhenNee6U1LmIc
 JvYvbKwAZ1PBWwXdVw4eEZC+8ILjLpeMMx1ow0vqQ9czUg1c9vF0oqJBX A==;
X-CSE-ConnectionGUID: yglSDSU6Sya67WQizgZT1Q==
X-CSE-MsgGUID: NY/YEbT4R+mAHUUrfoe7vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="71868650"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="71868650"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 00:44:57 -0800
X-CSE-ConnectionGUID: iiZkXDUEQFeQpMHqbbStsg==
X-CSE-MsgGUID: mP4sFosFRPuINeq1MrXeYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="217006100"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 00:44:57 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 00:44:56 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 13 Feb 2026 00:44:56 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.22) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 00:44:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3ZncAmzcTQwAlYlc0OvABHZR0MJ33LIBcIpMGWa5DgFUVY4+F7REpGIRLf5JF69kEG97cCLwe6HGBvGvZSCWOTwXkIP4jszT88/aDcJYAiuL4Q3idW4pVOeZVDrIhL2eTQRtQ3p/Su288ekdcc4MXVVuJvr21RGbNVLZUL03Q3OFYOGo55+l7UB8SWm8+BVB6keixx0YIA9UEwtDQ65CsV7pznLNUEyc0VywqRYLlv2dZAiU6FNyZToOQtW22FQpcHmoJmdo/fGRhE4pVA6xnckfBp+QG6E14zxvUxuEeddLUS987lrTOIqlLj1utc9mmmlvV307EdcfJfRQyxrIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47dk/KED9wWkWeMCh0IHmO7vjYZBkWgQL0ZCCZST72E=;
 b=AearB2wIb9wvMrpHKEwHfBjSwdq7sKpYNuZzSw20c1HdC1cctG0rchS5AZSbKrKEQDg95v4qtNq7lPHevYhWA9Kkjl9GweX0W8xVrLVXR9mgqev2nSa+2nU2iX3WFBCh9ep0l/B9V5LtkgMwlfHGS+ZjL0qccYuubn+QZBG5Ity5ORUdxbEDnkUa2A83F65C81lIOdp0TkheSpUAHFrcNzZUuEaDUI8UdVbB26N8XuqRBfTJpqkNguTzG6ZgjDKOuQo8+FhFcCJpgHxfE+9+475VX4dPhCVYf6EwqzeJ4wTQUtWXzTNFzcuwODZr6TGUZ3Z9t6d+D5G/IXxTwx6CkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 BY1PR11MB8032.namprd11.prod.outlook.com (2603:10b6:a03:524::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.18; Fri, 13 Feb 2026 08:44:54 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 08:44:54 +0000
Message-ID: <6cdb4c37-0e01-42d5-a2a4-e80bb7c4d390@intel.com>
Date: Fri, 13 Feb 2026 09:44:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/12] net/ixgbe: fix memory leak in security flows
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>, "Declan
 Doherty" <declan.doherty@intel.com>, Radu Nicolau <radu.nicolau@intel.com>
References: <cover.1770900757.git.anatoly.burakov@intel.com>
 <cover.1770900757.git.anatoly.burakov@intel.com>
 <25cd42dbf99da44057b6e48cb04f61bd406db3f2.1770900758.git.anatoly.burakov@intel.com>
 <aY4Jnsjw2DDRW1QH@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <aY4Jnsjw2DDRW1QH@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P194CA0028.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::12) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|BY1PR11MB8032:EE_
X-MS-Office365-Filtering-Correlation-Id: 507b7ff1-2280-41ea-ed32-08de6adc28e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHRQYTNqWjRMdXhybmp5NEFWSm1HSVhRMk9lSm5yenVQbzU4dkttb2g2eTR2?=
 =?utf-8?B?MkVSdmRDVEdQVHhrMTZpaS81T0JFYmpMYkZaK3R6MG52Y0hPR3VIYmFkTXht?=
 =?utf-8?B?anNVUGhzY295eHNmNExhMFFBdlBFMWo3T3R4WFBuMldMck1PRmZIME90ajU1?=
 =?utf-8?B?U201MVpKalNNZzl4dVVXQVpSNGp2Z1RSMnZ4bXNpb3BDY0g0MU51eHdwaGpB?=
 =?utf-8?B?VU01YUgxSDBwejVQc0M5ZGdjRkhvOTNTZVFZNnByYWhtY2tCcnhFVGxmS3M4?=
 =?utf-8?B?SXRyaXJhYnk4bkdOZkpXeEg0eDlva1RGMk9uRjdCb29zdkZlMkZxZ2FBTjlw?=
 =?utf-8?B?ekYzSTEvdTVZM3RPUmE4cFJySnFtRWRMMFl0bUNIc0sxVFp2UndrTFE4TnUv?=
 =?utf-8?B?QVpzQ1J0M3NFMHQxTTZkQWd6WkVWaCtJbi90cnJ6MStUbjJKaDZqM1o4UXRz?=
 =?utf-8?B?UFZtNEcvcVRhU0dOdE5iZlJrWnRwV2sxMDdoWDJpSDJ6SmtsV1NjWmpHSlM4?=
 =?utf-8?B?aExQc0NkNmJleFd1WmF4NnpKSkFKcm13SFRFalpvU29rb0NJQWpESFh0WXpB?=
 =?utf-8?B?TG9RMFZmMExaUFhQSFJTQzE2ODZBQlJ0cm95dk1IbXN3RDQ5bG8vRkRqZ0ho?=
 =?utf-8?B?WWhqRWNFM2lJaTA5T0Z2d2p4eHhqWlE0M010a0xCenZNWDhlSGZUUE9TbW9Y?=
 =?utf-8?B?aHFLdFo1dS9iQlV6UkkwOGVXWUY4SjJyM2tYOFNXaFBMT1BaTEJqcWM5VjR0?=
 =?utf-8?B?K01WWXErSkdqN1FKTXZ1UncxTHk0dTVBb3JtbmNUUEgrQ2xlVHB2Q1orcmpY?=
 =?utf-8?B?L1N0QUVYN2poV1l3SzdzNUJCbittVzh5NGpQZjZNaE40ZUpzRHBzRmo2bTZh?=
 =?utf-8?B?NFZvcXJxYjJDcmYzakNqWGk0SDhvY2l0WlE3LzlaK3cwZHNrSGd4NmhkTklu?=
 =?utf-8?B?RUFyaG1yQnA3TWI5UUhQb2hvWTJwa3kvL2JiQWNZdUtkenpnL0RvR2Y2Z1Mr?=
 =?utf-8?B?bmlvT3dsWkxkYTM0WkNiMDNpMUM2TVhiMEpxeEZNR0VXTjhzNEZVK2puMDdp?=
 =?utf-8?B?VXdlV2FFRUhqWW42Y3FhSzc2TmhIbVE5MXN3TUFYWjJkYlVYSUJtK1dqNDMy?=
 =?utf-8?B?a3BRaHNmRFlNd2oxUlNMR2tCY295RlB6N1lCVlNSWkhZZU9MVWhPQ0NONkY5?=
 =?utf-8?B?eXdBZDF3dnNKNUJhYVdpbWRienV0dFNzUE5ndno3ajRYZXdCVGZMbEFWbmli?=
 =?utf-8?B?REh6ZDFGNmV3cjFLeXhRZWFRY1VDbDVqNG9FK3ExTy9iSHVlNkluUTJlNGRX?=
 =?utf-8?B?bGt0djdlTmRVamxjNnZGQ3ZwZVNvQ05UK3NRWTlNV21ReDFUSWVPK3JQTUxa?=
 =?utf-8?B?SHZWK1VxQjVnZ2h1QWl6QUNBRHROUjVRV3YwMEdXWHFRNUptaXJFejdKQzR4?=
 =?utf-8?B?ODBTWlZ1eVYxSnVCTVF2Tk5UWWdWVkJKMWJhU2pqbXQ5dzRhQjFtdE9zWCtF?=
 =?utf-8?B?dGtYdk5vL09PdktRUEFxNjMrVEM2Wi9YMk5ZcTA1S056LzI4K3pMSnduTlZi?=
 =?utf-8?B?dGFRV0NTSU1ETklUbFFGQ0VjVnppZFdWM1B0OVJDNnI5QUN3WnhuYmk0UGF5?=
 =?utf-8?B?QlI0RGNHcG9saVJmQUFiUVBPckZrRmYzdmthSkcwY0ZPNVpjM09jNk9CMEd3?=
 =?utf-8?B?Q3RGa1AwVy93UXVaaDBlbUp5VjdPOXcrVlZOaThBRkc1WUtlVXVhMWh3NHl2?=
 =?utf-8?B?NEZOTUtWMDRndnRGK3g5MUlyNVZraWNQd1RZSE5YTmhFRCt2K1daN2lhaThj?=
 =?utf-8?B?SkdCbHF4MkFMNllkTnhWeEtid3Y4dCtVNGQ0ZHdEaXdtRDBDdG84RmxwL3Jo?=
 =?utf-8?B?UEdjUnRkTXlOMktHMFVZcjNjVWpzS3NaNzNnYmYvRk1sdSswSjlpbDZucTR6?=
 =?utf-8?B?bWw5RjFYS2g5bFRFekhzam1GUmgwVzFVajlsZTZabmVyNFN4V0VoeVB1Tyt1?=
 =?utf-8?B?dnpIQXZGN0hzOEFjWmNGdWxNK21ZZy9YQzIyaXZZTStiWjEzSk53dlIza0Jh?=
 =?utf-8?B?LzYrUTd6Z0ZZYUlNY0tERXBjdVowTEVYUWF6WjM3S3Nsa2ZyUXc0SXUrQy9G?=
 =?utf-8?Q?rplk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkRqbWwvQ21vRmxONmZVbnlDOW5vNVJjT05iejYrKzdsSU1qY2lLNnRBVlR4?=
 =?utf-8?B?N0V2YzVNVDBUQWJ0VmRGZmE5Skk2aVVOQURRUHNnSmJPWGNzd2F0UDI0Tita?=
 =?utf-8?B?YkJ6ZFVqS1ozRy9LSXdzOW53d2FsMGlpdFpFZDQzVDc3K1MzQ2Y3TGJwOEpC?=
 =?utf-8?B?TnlkK28rUGJzeU5OSng5ZmEvMWY5VVNWRVZ3dEl1bnBXK0FoQ3NhVWFaZTMr?=
 =?utf-8?B?T3UrRzBZcWkvRG41K3BRbGZTV0VrZ09kc0dqQUxpT3U3RWtGNEl3OFg1cGhh?=
 =?utf-8?B?YitCdHBvOEI0SWVIVlpyMnhyTlRkM3ZNVXBYYytuMmRtMVg3REIxNWxrV2NX?=
 =?utf-8?B?Q3pCYldScGtXczRWaGhudzdRdmVUL3g1QWFIZGhId29DdHpkQW9KanlBS0xh?=
 =?utf-8?B?cS9HZitPbDdIbFF3WlltMnpKbWRsTlNhb1VQUjFyQys3ZDUwVzRPaFI0QXFn?=
 =?utf-8?B?RnlrUUhhWnY2cUJUOHpTSXBhUWJ2R1l2VkhxS3JQcHE0OFBjaDVEOW9PUks4?=
 =?utf-8?B?SmprWlBFeHk5ZlZ1WVAyVmhqQlc4L20rNjhlMjFoT0NJK1ZzODJxclh6OFJI?=
 =?utf-8?B?NStqK2hCNHZWaVVHaW93ZWtyaytwNnNTSW1QYU9qUUYxdW91ZFpqRVkvYVE1?=
 =?utf-8?B?b1lEWi9Gd0duTW80OFZmNGFwUEhXVjJBODVMcS81Z09Cc01yeTE5aUR3Y2w1?=
 =?utf-8?B?akxGZnU4d1dxcWtKMlF1Zk44UWQ1cyt5eWVNeStDdmVUeFFPM2Uxa2Jna2VM?=
 =?utf-8?B?YWNncWpMQjFDZ1BqK0R6M2xwTkcwMUZYSzdVZ29Dbkx3Kzg0bHUvbTNRTEdq?=
 =?utf-8?B?LzVyQyt1blhSNUdVWlg3S3FkcVk0ZlRpcG5tVUI5emZxbDF4aG5QNUZ1c0px?=
 =?utf-8?B?aEVrTTM0c21zUUg4Y09ucG9ZNmRJZlB3SzFXTEIzK0hRVEJ6QzFZTjMzU3ZF?=
 =?utf-8?B?N1VhMHhpNUVieENETmZ5Um9RbjVZRUcrUGJSMVJBanJ1aStlb2xabWlsYytw?=
 =?utf-8?B?OU5BMHNWd0MzTmFybys0SURSSWxSSmlZVWkra3JMVE0wRTRZbXpPY0t3N1dC?=
 =?utf-8?B?aTZZajFCMExyV0U4YXhQS1FKNU5TVFhKeEhndzBBbEd3K1k2ZWxvaDYzYmt4?=
 =?utf-8?B?eDJ5REpYTWtUbGh0QUVBSFRjQUdLRWRhYndiczN0d3J1UnFtN3o0Rk9FY1hy?=
 =?utf-8?B?akFoZ2NhOVFUY0ZPV2MrSHBoLzRRYjJQQUFBdkEvQ3Q4eFhsTlN6WHgyOGZR?=
 =?utf-8?B?RHVKeGR0Q01QRGxWM0U0eURDVGtUckxzcFpjNzFkb3pPWlZ3VzJ2NU5Hb0Ur?=
 =?utf-8?B?RWlETHJKRytiYUxsRkNKNU9JN3IyUWxzVUxmcGNldTR6NnE1SWJGOUhoODBp?=
 =?utf-8?B?N2NMc1dLLzM2enhWS3dGS0Y4bW1oaUZTaGk1VnZQVlp0SU9JTUNhYkF3K2Qv?=
 =?utf-8?B?ZUdyUXpsa3E0ZkszRm12TCtJNm9WK1I3aVRBNzByYkt0SUh0ZWZHMDFxMEJo?=
 =?utf-8?B?aXMrRURISkxCVFNCa3REMXlrb05YUDRyWm9FbG9SL250QmF0eHg5R0lFVFVK?=
 =?utf-8?B?QUdnWjVKTnJFN3pmc2c1ZDA2NHErd0FtN1ZIbHdNVXJiU2JjTHB5YnVmMkt1?=
 =?utf-8?B?d0c5WnBzUTE0eXhCQ0pha2xia3NUZitDS3hRZnlJZXgzM1BCMTFRSDh1WE16?=
 =?utf-8?B?OEl5VFRWNGkrblJmYnNpcCtXNVA3b3JvWXFFdGpqV1ExUEpPZStQRzNoNE5j?=
 =?utf-8?B?K0x6Z2ZLSHdENWtjSUxzWmRzeWc0c1R6UnhRV1dtYXBPbkRxYUZ4M1dYbks0?=
 =?utf-8?B?K2c3RHF2a0VpRUgvSFlLQWlNUGtQZGZCNHVqT1I0SGtaUm1kdS9xNmlWb1hQ?=
 =?utf-8?B?ZTRMTnI2WnZtSnVCMHlPZWsydnBZamZIZHRqSDVJcDV2clBvVVdIYnhZNUhV?=
 =?utf-8?B?Zk1KanNianNZUmNWdjZRcXE1cHFaTmtNN25kS0dsUlFJSWhPNWhqS2NJZXVK?=
 =?utf-8?B?QXZITEM2SnRPQm5taGZaS1c2eXpKbmhEZXhtdTZlcmJxMFlQMnRkdmZCODV3?=
 =?utf-8?B?Z2RUNE5oTHU3UEx2cDRXNVU3RzB6Rkg3OGh0Mk96V2w0Si9BSUd1Z0JVRHox?=
 =?utf-8?B?aCtIRTdYazZsbDZkVGw1aWVoNGZ4YkJtaEMrL0ZsTjMvNHhnZkJ5UlAwdDVw?=
 =?utf-8?B?cjMyeWZJNStlTlZpakhJWU1NSVkrVUdRaHdrWURFeWZ6N1dEUHNlMmk5UlFs?=
 =?utf-8?B?SFROZ1RjZCsxRk5OeUxmTk15K3ZEMlNyZS81L2JhSS8yK2VIa1p6L21pSDRZ?=
 =?utf-8?B?czlsL3RIc0QrKzkreG5BTnE5YTVZOW1kV2dMSGNUdDhqTzcvYW5JbWZWNFpB?=
 =?utf-8?Q?Pq1lDmERFCkjgBdw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 507b7ff1-2280-41ea-ed32-08de6adc28e6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 08:44:54.6931 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OpP+J01e1m49djmpQoDa/E2rYNcjrZRDCCIiELsbv6b2lYvMs2gwmyz8kY+jwWJbH97OlIufASBHfhyuFD3NvrleFUTPsHs50XOSZal16O8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8032
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

On 2/12/2026 6:10 PM, Bruce Richardson wrote:
> On Thu, Feb 12, 2026 at 12:53:25PM +0000, Anatoly Burakov wrote:
>> Currently, security flows are implemented as a special case and do not go
>> through the normal flow create/destroy infrastructure. However, because of
>> that, it is impossible to destroy such flows once created. Fix it by adding
>> a flag to rte_flow indicating that it is a security flow, so that it can be
>> destroyed later.
>>
>> Additionally, security flows return pointer to allocated `rte_flow` struct
>> unconditionally, even though the underlying call to ipsec code might have
>> failed. Fix that by checking the return value from the filter function
>> before returning.
>>
>> Fixes: 9a0752f498d2 ("net/ixgbe: enable inline IPsec")
>> Cc: radu.nicolau@intel.com
>> Cc: stable@dpdk.org
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>

<snip>

>> @@ -3350,6 +3354,12 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
>>   		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
>>   	struct ixgbe_rss_conf_ele *rss_filter_ptr;
>>   
>> +	/* Special case for SECURITY flows */
>> +	if (flow->is_security) {
>> +		ret = 0;
> 
> Rather than assigning ret explicitly here, I think it might be better just
> to set it = 0  at definition, and leaving this as a simple goto free. [It
> would also head off any future compiler warnings about ret being
> uninitialized :-)]
> 

I actually remember a lot of commits *removing* that sort of thing, with 
the idea being that we *want* to have these warnings to make sure every 
path is covered. Additionally, I personally prefer it this way for 
clarity (i.e. explicitly indicating success).

I can still fix it if you have strong feelings on it, but I'd rather 
leave it as is.

-- 
Thanks,
Anatoly
