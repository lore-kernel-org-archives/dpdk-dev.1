Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1585CA9EC0
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 18:46:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3041240A80;
	Sat, 10 Oct 2026 20:46:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id C7BB840A80
 for <dev@dpdk.org>; Sat, 10 Oct 2026 20:46:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791657975; x=1823193975;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=T+yM9kP4+v+KQgahEK4upPvpyd85T0sQsezKO2nBSmE=;
 b=LDaPS0ykrjzKRqrABNWGf5mTtG0uILn6zQ6sOJ9etvfdO4T7aLl+ZXh+
 RZyLPqm8hFL3dZrKh5HwqWvSQWt8Jfys9FEa4M9AstbJv8SbLpRicWaGS
 7b42weBwl0YNUEQe2TldvrDv4U+MrZA5y3GOxTAow3mdC1nqykGXIw+o1
 ORa++6zpbJhwtOeooCb3XqGByDU7hor17i3b5eh8b81M55lcximJwayNk
 Pi5Sox71qoPF+uPIRXvJMW4veeF3fVnt4I8Peu2sMQWtbWC+pjvUvDVdF
 /WMH/kLXTwD4Z9XwkjNV5roKxubT8AMjz+clhokn2ec3N+TqBcAhCwF+h A==;
X-CSE-ConnectionGUID: zGYFV0W9TeKYgK7TzANXtg==
X-CSE-MsgGUID: +GC7PNmXTsGK8FHTnNe40g==
X-IronPort-AV: E=McAfee;i="6800,10657,11931"; a="521733"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="521733"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 11:46:14 -0700
X-CSE-ConnectionGUID: cc7PXw/7QVC4wbL2UsmJKg==
X-CSE-MsgGUID: 4QlT03KdRey84mpkU9u+Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="878492"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 11:46:14 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 11:46:13 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sat, 10 Oct 2026 11:46:13 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.49) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 11:46:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XVnwAh7P6noHiW+z6Wwuy4XpX2pjZYaC8OLtrEL+xDMaNhWrshxskq022quZq8aLKlB/I8ut60fFZ8MCfFm9FVY3I1ginIahlKsKZaHue/leXL6hK63sdfVevy4cUDM5Sb9GVlmNhTap0bibX4XvX9gnxylr7It1FSNiRGa4czPEOOc0bVzfomSruO/QWSXB6w5ymlJJzB4WWasW+nzZfPpV4qaFka6/1FaTeHSdPGzV0DxmNzZmf+UmYMriPoU28Vv6P7AR9iyEog21WDv9XPHw+cuBPMBhICj2TvSQF1ig/uVNYoM7yHlgIC2aIriIZW02CTgGjvDON7+T2SpPmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TuEQ66sKTrVArNLnx5caPOafBt9Uwu5MwKyysFuj+pM=;
 b=V6mPDFl2qfq5m3YqQ2QJUaOISEsb12EZhQ1w5VdLoZSE0FnQmDhLe2K/8HCt7YQV+mPurwVyC/jRJ4KzroisinlI6LZn3jTYuQq4IDQGVwOannOOK8oY6MrwPqGy7yF3ruLQvgp6zvr7tWOwVp6elRjCFsC0c9CQjStne+bg3jpj7z2dx1w+ikAl4vnVZVGYBsVf9EfReGZ8h6KGdHCXlSS+xe3xgzsD5gOiszm1baTNliZhENKiYnpKCdQ18qHQ2QKm0U0PULDh08ycdBLV6JZP07QUNpijQFnuFdCZgxbaVYLbIwdWwjzJ41d/loLAxPfbypihnwu2lE2D7ypDlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by SA0PR11MB4527.namprd11.prod.outlook.com (2603:10b6:806:72::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sat, 10 Oct
 2026 18:46:11 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 18:46:11 +0000
Message-ID: <e9c8ef57-ae01-4420-ac1c-45b52ffd470b@intel.com>
Date: Sat, 10 Oct 2026 19:46:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 24/25] net/i40e: reimplement hash parser
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Bruce
 Richardson" <bruce.richardson@intel.com>
References: <e87ba9418c8b9684634c23c0afbed7c00abf880e.1791543156.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <e87ba9418c8b9684634c23c0afbed7c00abf880e.1791543156.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P195CA0002.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::9) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|SA0PR11MB4527:EE_
X-MS-Office365-Filtering-Correlation-Id: 8946a9af-403a-4d1a-1787-08df26fec13e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|6133799003|10067099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: MAR4wBjabvnx5G1Gtc3E3sbUZP6zWFaB1aIHu+lnJK1pCyIdVC31tWvTaxbzckqymeB4QohZc70wAYM2H6bskaI2PaPvTmUufd36ke2ouIHosW35JHeC7HVrLiWRwOFjgn5OuFitwrku1br6brtD/Q/iSVpogQE1qP0JpJLMjaeqcdXKL7Gwy6lwBXucEjab1jJqKpwmj8aaONvQ0ffQswGUKnIA/2ynkOGIKcc9eX7oZm6MJqy3F93G3UDwCw4t1qlLN19RkCQ4lrrcBzrThxWLGJB4spInmX9k09qSiEPEMD7A/fV8SopfylONd923c7tyhDHO60YzZj3WPE+H9iUlmiQsc3S8n2urO+4qGS9V4D+aPeVgS7DMgUce1LnuTDrlOq2mjKi+tDQ7jeupOdHm0PWJ1a6rZ6inPqKPw9C4Q62/pk0lo8iTy7waR/Z8s5765/20cp5xa3KmaOWzHSfy9vV1KEbxCJaTfxPP2C2/U4DEBTkLyrV6jVWxchXDV1HqlrWgh7V9H7i00JHTv/eJT6m5idqg24O2XhvywGrj8VY/n+wGKoaPMzvttekDezd8nPHaRAy5fC3qpJ08ESD7zTRjfigN1eWTrH5IV8nECVb4lkMDAbY8VD5/+9Pwy0AytMnsh+ub2sHRzVK+AIE2D6rELUnknHiXBB12Lg8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHpMdnhwcEFCRitpRzFZcDZCMTdDZ2FFRWIxSzBEZU9SV1k5czFwZXdzeHo2?=
 =?utf-8?B?RDVDYklRNzVlVkhDWDBHbklqVURBK2NaQ3pEUDdTRmNSVzIyQVNJNkhGNWl5?=
 =?utf-8?B?RXExd09kalhXWnlXZmZYQ2NiRTI1aW54OVhCdS84R205T0s1MEpvZ1dtNC94?=
 =?utf-8?B?dG9lUm92VXd0cncxY2RZeW13Z0ZwbjZqUXIxVXRQWTdOMXFnWlBYUk5HMkhJ?=
 =?utf-8?B?R2tLTGFFenZIeklwcXBXK1hTMmlVTkRlNVdmWXZBNmFnUGxjZzRzdjJiUGhi?=
 =?utf-8?B?dGs2OE01L2ZSRngwTGNJRE1iMFZmWG5GdVlTR09oMnJvakJ4UzRlWTRFdUt0?=
 =?utf-8?B?RUJGWjViUjJPbTF5YmNDODJXMnNWWWFHNit6ZVpCV01FMGp5ZXdPQ2hGN0p5?=
 =?utf-8?B?UGVFTHA3amlKTDdhTytiQUw3RTd4M0JMUFZDNzNyM0hlU0xDbTJnVzhMa1RO?=
 =?utf-8?B?TkxaTk5FUHFCajRxVFVKUm0ya0dTOTFFdkF4eE44WFg5aHdaWURZLzUzcXNz?=
 =?utf-8?B?cXJwSW1PeVE0SjJHQzl2SGg1WHFyZUQ3anNzZThFd2hPMy9uSGl6VGxQVzRq?=
 =?utf-8?B?L0h1aVZvZjlKbG8zWC9aaFJMZXpKVEhSWFd3c2FxOEZRbVVWNG9xQUhiaVZI?=
 =?utf-8?B?SnFFWUhFNXc5TDhhMDl1OWdRV2NDNmJLZysybStyR2M1ZVZqUi9hVFYyYnBT?=
 =?utf-8?B?WnorMDBvK1MyYnZYbVpmOFp4V3RkQytmUWk0MTBZWUJScHpjN245N2VpKzQv?=
 =?utf-8?B?WWFKK1RicE81Q2xvMEJiM1ZHNTByVlp6TDhIcHE0bEtXZWRnaTIrYUFCc2FM?=
 =?utf-8?B?T3VYMHZXL0hwaHlJdWVuMXZNN2Z6QWlUQU4yT1dkSUJUYjhzUk5NVDJwdzJ1?=
 =?utf-8?B?aDVzdTZUUXVaYXI5VXovZGJSM3dVb0x4cVhCYnUvL1lXbEJ3NXFKUXlLeTBD?=
 =?utf-8?B?ODQ5Z1A5VU5UVHBDYnFKdXZzVEV1dGpQd0pPaXl4Vm82TkVvdy9Wcm1Way9C?=
 =?utf-8?B?a3BkZTZPTDZneDhiUGVTZzZ0SytwUHNoUWhoVUpQZHdrWUhxbFZ4RVJBUGRx?=
 =?utf-8?B?b2pCalk2K1pJUithclVXMUV1YzFQOUxoSHh3NG55bzNlUyt3Q082NkllaWxJ?=
 =?utf-8?B?Ynl4RzNhM3Z3M2J0K3loTWtRcXlmK3FHRithVlV1MkQ2YzRXNU9SQ05zRm10?=
 =?utf-8?B?OEVqdHhhRHdySUlEVDNhSFFaUFFuV1ZXRnpRYkJzY2RYVmYxWWMrMlRlUmpL?=
 =?utf-8?B?YXUyYU42TUw3aGxaQUhRRW4xTVhSZU15TVpydnV2bHMrU0pTS0cvVitqaElQ?=
 =?utf-8?B?Ulk1SVhWblEzWER1M3FUR3NIeWFLeXQyR1R1eGVjNXNYWVJyVDduSmtkQ2pH?=
 =?utf-8?B?RG15QWprU0RSd1MzNGYvV0N2dXlZN2ZSL0FlNjA0UFNaYlZSY1l0VmhzZXA1?=
 =?utf-8?B?K1pCY2hLYUlSOXpTQjA5MmV3YU1FWE8wVTJ1a3VnbnAzQlROeEkvR0dqVjFE?=
 =?utf-8?B?eWI3S2gyZHpkdXZGK0ZaQ1V0WndEcFExbVYyNElRNUR2bk9nMEd2UlJFVXhS?=
 =?utf-8?B?R0J1Y1h4YTVWR291ZDRRVEY0dEdtcEExa2pLbGJuNnFGdDNIc254VVU2Z21x?=
 =?utf-8?B?Wm96T0FnTWpjcjAyMHFWRTBManFkSWlNdEFsWFIvRDREZ1lxWGQ2NzNrQkFL?=
 =?utf-8?B?Mlk4b0I2MWRyc2lrWWE5WC85ekdLRXVFVFdDMS80YnRjMXpQMk1TZHppZFRx?=
 =?utf-8?B?OG9HbCtoNkxQZ1dMSzZWbEY5ZjhTdklwV1JsTjZHeFRxK1pjQUV5R2dMTzh2?=
 =?utf-8?B?MWVYelgxaEoycFpKbnJkc3o3Mks0amZ1YjFONm5sNnRPWmowTFlnL3VxN3B3?=
 =?utf-8?B?M00zNFRXYkVSL21hcXRPbzZFV3p1c3JSZnlQZ2xNbjl4eFk2R2NBc1pLN0lt?=
 =?utf-8?B?OFZyR09Vc3RjSW03MnBZbVlqdVRONSsrL09STDIzMFhNMEFtdzB0Q0plSkRP?=
 =?utf-8?B?YzlPRzE2OXVScEdRZDBoRTFSYTN3VHN1SWtMQmhRSmNmYVZidFVhY0ZFYk5H?=
 =?utf-8?B?WDR2eFE4WFowcUxmRXBqSHZZN0lVakdLMk4vbnA2NG05NjB6L1c0cWN4OHli?=
 =?utf-8?B?WGdjbnJoZGNPNGxLN1Zwb3NQVlM2VWpCd1VlU1IyUmQweGZaaDlxTFhCNUxm?=
 =?utf-8?B?cnJOd2hyQXJPSk1HL2hpRXl0TDdZeHlMMU1jR2tZcXArQ0hlQjN2czM3K050?=
 =?utf-8?B?WE9qeFp2NTFrK0tkWDFPbURERkh5N2tnVHBLVmFadzNMSTdPWUtGTFovSFln?=
 =?utf-8?B?N1BXS2ZtaW16MC83NEl1L28vM0Roa05TZkVNZHA0UUlLSkhlR2dUQUx6U0NW?=
 =?utf-8?Q?auDtKmQQPY13JZX0=3D?=
X-Exchange-RoutingPolicyChecked: TnwOqCglzXfilQ2h3WngrlS66Ok4FRKC2+acuKpMg08ibZ1g53t1vYcuMhrmythiM6FfVIw0ygk7JX1yDq2uhZcogsht3JZqmvLZWeA9QOHZHyI1GfoUA5ppnruW+lsjY4V8JhoZedUc1lm8oCBUZKrEMNhuSnUl/ZP+KKCUR4AegVEcofV7ePNlcq31JrkfRqWsmf7JmkHJrMYWUti9KzPrDcNCLY6H9QQDS6RQqbr3JrTeD/4mMn1ZZnWfUNRfay+F173yJ6KHTGyIsZXuF1Lv0Crckr302m1ozpUiFq+2sfA5hNGC8OTKceSqTETzIjO8W92xWCwVjZJCgBR2iA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8946a9af-403a-4d1a-1787-08df26fec13e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 18:46:11.6909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jVbGiY/4CytZchaShKmqB58dORu1NU/xg/9/hjGGl5YbW/AgcLalMlTz8ez0IgJGZaQ6alJw1xiq8Dnhi7XH6k10g4SpBCwnmT8NEjRtO3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4527
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

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 10/9/2026 11:59 AM, Anatoly Burakov wrote:
> Use the new flow graph API and the common parsing framework to implement
> flow parser for RSS.
>
> The RSS parser was bypassing the other generic infrastructure, probably
> because it was very convoluted and did not map onto that model very well.
> It has now been made a first-class citizen.
>
> The hash parser is multiple engines that share state, so each engine will
> attach to the shared refcounted RSS configuration state.
>
> Additionally, this is the final engine in i40e, so remaining legacy flow
> infrastructure has been removed.
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>
-- 
Regards,
Vladimir

