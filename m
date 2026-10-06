Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9200BCA5FF0
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 10:39:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E17240E0A;
	Tue,  6 Oct 2026 12:39:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id C149B402A2;
 Tue,  6 Oct 2026 12:38:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791283140; x=1822819140;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=fINz/tCTzlyoGfUptQm8nnYCPrFz5Q7appdy+KTd8EU=;
 b=L0Doy7ax37SLaUUeyMNu650ZrUflFjRqlCkCY1NSxMSdZ49UuAQ7i+Ju
 +waJjtpF+bZAJZDKZSeI6uL4Ku346mB36ZIuj3U1Wv/9AaI+/uR79d1nY
 /BmPXc01Qjc4KmIAUWsHCgQgewf3k2MPjGqODA2GkkLCza36cd0RWBq47
 UNY/uyY2PanONK2Ox0mCJ8aPOYozUu+8i8W2ui4TE6xao9zWbsduDMXLJ
 1dMrNh9+qrWkjc8uK/XpFsheRi4Sx9G0aHpfpIME7CkFurbDg47JvrhDw
 E9z20I4fv9yDEAsD5oL50+XSMtHEO4W6gJ/bhXbRBSmWkuWJ/urBb4eJO g==;
X-CSE-ConnectionGUID: dSGB/8JjQSOhDJ/zyXN8ZQ==
X-CSE-MsgGUID: rP87fNtkTLGE+fqb15iXkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="7257"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="7257"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 03:38:58 -0700
X-CSE-ConnectionGUID: 6WZ0n0/CTz+NtgpwKCH5OA==
X-CSE-MsgGUID: qBh+SEAjQY6SF/Wf/TCwmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="305045197"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 03:38:58 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 03:38:57 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 03:38:57 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.53) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 03:38:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KM2ESHqN7nAm3kCiIN/U53myKTDVdjsMsmGKGIU7I2xJXfyy00LV5aPWH+oWmiF+uddOZw2YU1Fx3qplfZv7Eu4B3WYTAz5TzCywLhsnje64H7gG7ILcgiGsM9Lbk++j9R8yk2ePL0U3PRavJZOA+u8+Xq2b3nPA3TCGIFiwyBsns2h9BpZLf1tonM1w7fYTbmiV4LxEKSsxI4QsKqjL/nVdA/NT0f5oEVzZgceWfbZTQzPe5c9ez2CiYQaPQUNe4aa69AGfVyODeNk81DjtOaflF7a5JtpxlHOUXNAZRX55m2yOX8Pvwr4yX23QUG7obFggRMqirPqkhqiRxkAYgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RyJTc8RsTOGtFYQc19ctsKXIopRPNkGrqKQG8qoqiaU=;
 b=b7rZ/skCODkS4o3e05KCdnIBtxWefeLlOSUAcPqNcRZVlVMheltrSOxqge8CdUqisrvh84ee4eI+YZ1o2+BlCjZEsBi6k/8aKgkZq+ur3KJLdrvJo+s7WSZqFhhZZNh8/p5e55soMbtet4iGQJN3cwOZRebYBuLqcQI0nCUPSZfypfs9Wu1rF75c5wCrBnXTfDYgpy27CpXt4d4Ab53sYnkwtNrohHFXtMZAXW/B/YmU/nkdmiMNN6QpaVfhxViRkjsyBRWDuojpfozkXWvBn0VRdfYGDMk42Peij7ikQsHM5gqcxmX7R7Krn4td15o7sWDVayOdgj0aXX6Y+Un6gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 CH3PR11MB8094.namprd11.prod.outlook.com (2603:10b6:610:156::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 6 Oct
 2026 10:38:53 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 10:38:53 +0000
Message-ID: <521f9c58-5da6-46c8-8064-2abf76585946@intel.com>
Date: Tue, 6 Oct 2026 12:38:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ixgbe: fix VF link status for E610
To: Sandeep Penigalapati <sandeep.penigalapati@intel.com>, <dev@dpdk.org>
CC: Vladimir Medvedkin <vladimir.medvedkin@intel.com>, Jedrzej Jagielski
 <jedrzej.jagielski@intel.com>, Andrzej Wilczynski
 <andrzejx.wilczynski@intel.com>, Bruce Richardson
 <bruce.richardson@intel.com>, <stable@dpdk.org>
References: <20260927175240.160260-1-sandeep.penigalapati@intel.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20260927175240.160260-1-sandeep.penigalapati@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0250.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::15) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|CH3PR11MB8094:EE_
X-MS-Office365-Filtering-Correlation-Id: 042db319-0f8f-41e7-33a6-08df2396043b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3MVTcKKaTAzBnShWE8vedrmvxGi1DmAn+I9bE7oE5iIXRuZOM4f9wHjhbMH7tHBPHKQr2RQFEiDOP4jSfkPUHhGL5S4dyEkudEwVQ9Sg96cUWu1j2qtRCx6n9VjL4aefJ2ceZ0mTUVJS+c93yQAqX9d5S76Df46ovFW4pmXwtFpkDP6oDDds3vznj8Cq7j5LUVEIOdFcd2Kh8D9eOIiod+atjb7D6MoV5dJrdGQQrlVqhQ/4Mi2fJtUxlYs4M4FPZVMlYkAOf9B9RzOfuS6J0MXXLDZGoi3gDSxw1JVbROY2HyMxsHuyq4yKLKJIh8iYIer+/9kkDSx+QZg1wXL8RzgGO+MYgF7rMzVIKCTEETPs9aR3Z/wb/LUdaE16QBkCvDTgEI9gcW5b6iINfm6mI3fkEic0M9HMGl+dQvXrKiNJYUL9bBHDXigJgyWwxWcEGRnupag2SvW0Tr2ahlDUOfJpQ05r8GdgvxzN43b1k3HJM22wjUhgDjONLdAUjErlOpXcpV5ak9uJjOZey1Q9FULFUqLbk3/3n4UWJULWCE8KfKhmDwXAFK+VZqML34jZvTg9SLZc4oXAQlKJjOkOsy5Ddjn23v0xh6McjmF4sxHzskNavgszKrLQVBbGr760XtvmksQE+XcAYacQ3YWkDaTrGWCud/vaaKAdj7sMTPI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlJGWGJzREprTG1GVnc1NTJVL0toVlVhdUpDVWlLeWtjQjZEbURzcHd0RkUx?=
 =?utf-8?B?ZjVJejdUUzlET1QxNXcyd2NDdU02U0JPRlB6K0svZlNkb2MwTUdDUE9aSEJE?=
 =?utf-8?B?WWVHamlnbVl0UzRrQW1vclB0OTRPYWE3NFhHUlRZdzJtZGNSQmtKS3FrK0E4?=
 =?utf-8?B?OXVHTWJJL1lDdGlUNjZSRjEyYnBjdGdSeVlqL0daVFBEVGZZK2dHeE01YUtR?=
 =?utf-8?B?dnJIcnBaaGYwcWpqUFh0ek54Ti9BY2JCQ0ZkM2ZqdlZKallXVUluK3NHVnc3?=
 =?utf-8?B?L3V0cVE0RHEyN0JBUXFOM1ZCckJFbXV3OUNpSE5Ob0E1eXJONHBpcGIydWR2?=
 =?utf-8?B?emJvTm5Wb3V6U09JaTVOMUUyWDhXaEcvMEJnbWlSdFpJVmNmTXErR01Fa2lL?=
 =?utf-8?B?MCt6REtBQlNPWEozMzd4NG4zOEdtTjZXUFVWOVZVeXZwbUJtZmE5Tkg4Ykdy?=
 =?utf-8?B?T2k5N1NsS2pZT25UUmVPdHMrR3BYSGhEb3NnMkk0QnNkdXpTYWd0SU9FOStx?=
 =?utf-8?B?TThoN01LMndTbDF2Z0tELzFmZW5VeWtRTW56NEM1aHdqMlkzeWFRbSt4MmhC?=
 =?utf-8?B?NFEyUkRRVEtnYUtEQkx0UHk2Rk9nRklUSDZoaG5GMzgyQS9vUWFRMVNEbXFt?=
 =?utf-8?B?T2hSMGVEdlF6Z3NJNVdvQ01QZUNuUkR5dkZOUy9JS1B3QW1BN0YzOCt5d2ZE?=
 =?utf-8?B?dWh6QVF0SVJ4UXArbVpvRkdRV3VjYUc4OUpiTG9mb3VhMyt3TlNtOC9YbTB4?=
 =?utf-8?B?MFNpYVVTc3ZyL1F3ejFHcllCMVZ5RGRwNmt4QlBkSkJOVi9yVno1YitQamJ1?=
 =?utf-8?B?NHQvQXFMcnRWMEVqNlJENUdFRWNoWWZtem1CWjQySlBRTGp2T1BQZGtJTDFu?=
 =?utf-8?B?Z1pnQU54dXk3dkpycnpaTGU0eGlHQzNRVGY5MldqVzlyaS9DSW1paE95OUQy?=
 =?utf-8?B?NitueGxpVkhtZWJBaktjcWM4aTIvWUpJM3I5b3A4WWMreW82d2NlazBIYXJp?=
 =?utf-8?B?cEJxd1BrY29nUWtaVlIvN1FEOU93THczTkdMVllTTnBTVWUzTm9OUjZTMjVS?=
 =?utf-8?B?NENOM0NzYlJxRWlTeFRMS2hBNW5rTTlXdUhxVEFTNndmK3puWktjU3lGL0Nt?=
 =?utf-8?B?UzRxZWNxckdTekdkL0h4VmMxZWRsK29rSGx6T0pIRUFLUG9ZNzJDOHFFUHdo?=
 =?utf-8?B?YU42K2VnU242a1ZHYTVoTWJxWXhydnFFb0xJUzgzYkpCVUhoYU9zK1FRZk1z?=
 =?utf-8?B?WFFPRDJhODFnQUJzYnpkb2luNFJES0NlY3Zwbzg0Y3h1UmhUYld5c2FIZW1K?=
 =?utf-8?B?TVhGTGpXcWV1SVBMUVJ3bGxsbHh0aTUwd3F3bVdORWdrZmJkNU8xSHJnZS9Z?=
 =?utf-8?B?Y0RNSmluanZpb0xFV2NVYUNVak9UWVI3R1p2Ulo3M0Z4M0JmdHA3NS9IVnZB?=
 =?utf-8?B?RlZ3Yk1mb0VndUZNdktOM3VWMGl3V0FRREZIQ0JuZjgyQnJScEpVMFladVY2?=
 =?utf-8?B?M0VTY2ZwNmpPY1dSRDh3U29UeVFaUE4zQXFlNWdXODMzZlNIWmltMERpZWdi?=
 =?utf-8?B?V3NGNXlDYThmQTJJNUJrRXBId3NxUkIwTzA1UE1LK1JzZnBnaDNpQThjblVo?=
 =?utf-8?B?SUJxeFl4N3BaUEF6ZmZUdHJTMjQ5NHh0aXJGYS9tTHBmVGhiK002L05pQWdN?=
 =?utf-8?B?a2NqdkpEU0RuVXduZ3dneU5DUWZzc2lQSWtMa0lxTzI0cGdMYmJtaFJ0QkMr?=
 =?utf-8?B?Z1lURENMeUhOZWozUnQrTFI1TkdiZ3Nockx4ekxYZmk4b1VjK0U1U0ZhcXF5?=
 =?utf-8?B?NGxIRktNVllHN3liMVcwNlJubU5vR0pJSHpaZzlRUWVkSEVNNnJPM2YvRWV5?=
 =?utf-8?B?TGdXNGdIbHVraUorQ2EwSm9wdDUzSExnWHMvNTFObXlQNE9IQWxOdUFLbmg3?=
 =?utf-8?B?QkN4TXdSZFFmcGtMbzRkUW5KUG9yOUFlMzhUTk5OQzFuS2lsczF4Mk9qSm5N?=
 =?utf-8?B?bWpOaG1LNDZLcmdSS2ZaaWU5UVU5UGZ2Z0NRdVNObDRScWY1ekp2NzF5R3Y2?=
 =?utf-8?B?ZStuaytwZ1E5OVZITFJuZWVocklBTllreE1aRUxsTUtwS0ZWTHA4aUdUU3N6?=
 =?utf-8?B?SE1VT1BYMzh1MWt1YVNsNjFZYUlZV2lwL09hTjZqNXJrUHU1QzFxMFhYaUpw?=
 =?utf-8?B?YzZFQ041Z2laQ3BTOFFCWWlsR0hqeXo5ZGFyOG0wMCtDTGpEU0Y1SHBOalZ5?=
 =?utf-8?B?SkJqWmpIR25EZ3plR0g5VVE5MVZKSXJPNzBMYzR0U3Y1eEtmQ1VtOWUvMGYw?=
 =?utf-8?B?ZVRCalFTWXo3TkU4LytPWGFVTTNFL0tRdlJMQUg3ay9Da05jRnRyeHowOUZr?=
 =?utf-8?Q?Q7KkmejlG+iwny28=3D?=
X-Exchange-RoutingPolicyChecked: tdwPMu5tBAjKBKG6uw/vBvrin7myxN43R5gsQqiaVKOSDa9A+bKK9tW88Wfno/jHkrq0mHgxyan423Ks3fzl0acqCVQtFSr1euhncgAlY2HZpAxonWZaOCiZWShflhwZZkNAguogkQ3hI2C7Oh5e9+dCHK9/SUQLf/9n+B6t2qhKVpN4zZB7TcCbyt1d7ox5OmCL5lmkcGsSvNhMJjLrFg5oc5RVFrnhip5l3LI4DfOQJ5+SjvnRKf0f9K+HnLPh51eUqrAfDDvzY52AAhzT7QYZ/DLnK7ZxXBQbJUn16ITH6RH3CC4Tsxef+VuLYph1nejTf/hTDVD3mZ67lLfvlA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 042db319-0f8f-41e7-33a6-08df2396043b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 10:38:53.4874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: StsAPehB7hUkZ2I05/cvrzjQDwX4raet7e92F+eRsmnKh85RS+sV+gN4iq1TyHOs43A8cTVLz4/XlJuM5SiA7tVolY3Yw3kSFq/mZ5Hqu5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8094
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

On 9/27/2026 7:52 PM, Sandeep Penigalapati wrote:
> E610 VFs report a wrong link speed (e.g. 10G while the PF is at 1G)
> because the speed is decoded from the VFLINKS register, which E610 does
> not use for VF link state.
> 
> Commit adbd71030575 ("net/ixgbe/base: fix link status for E610") added a
> mailbox operation to fetch the link state from the PF and bumped the VF
> mailbox API to 1.6, but the PMD never used it: ixgbevf_negotiate_api()
> caps the API at 1.3 and ixgbevf_check_link() reads VFLINKS instead of the
> base helper.
> 
> Negotiate the mailbox API up to 1.6 and query the PF for the link state
> on E610 VFs. Other MAC types are unchanged.
> 
> Fixes: adbd71030575 ("net/ixgbe/base: fix link status for E610")
> Cc: stable@dpdk.org
> Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
