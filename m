Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E197CA5FED
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 14:21:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5FBE40E4C;
	Tue,  6 Oct 2026 16:21:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 44A6B40262;
 Tue,  6 Oct 2026 16:21:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791296513; x=1822832513;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ff8QijQa9EJStuZjgssE5t1SOpFpv7613fHJKrb0uBc=;
 b=JEsSJVpWLSEoObDy0SQK/YDiBufH0A2AHb4kPMY4v1/P4NpLgdWq/GOH
 uocxNI6YfdEtvVX68JGD8UHVyV/3ntB0nxwqCf3Bceg01O3CJG18DrKvN
 iQLx4Yr2KxZY5tcX4TBTJ4PZCcyfbKXC4LZuq3q75Dz7LHG4AeWQoepKQ
 MJyG0TgKFjrPfCaFj0UplEQ27PO0vlT0X7jk4y0RRr9xPXkIhNSn5k3lz
 4Bnbw6XQLdZhlqsnFT2zRgnfDmSaCZf0rHVQPgfVOwvjcnomtSBxmsMeE
 fk5vFu2ZEZ74WmHXe7Lh0jdc+Mo4/F4FS9yhxjAIzjOV3d1O5XWCNa4Y1 Q==;
X-CSE-ConnectionGUID: cmHINhWbQfGnp0ZuEkHmaw==
X-CSE-MsgGUID: jyMIF7wEQkK5JDx+SkRYCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="38727"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="38727"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 07:21:52 -0700
X-CSE-ConnectionGUID: ntczL6z+Rx6oAzzrkPipyA==
X-CSE-MsgGUID: OD2sVxQqQj6ryoFmNDcjpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="275810867"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 07:21:52 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 07:21:52 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 07:21:52 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.20) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 07:21:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dzi9HtiDK2+5A05tzcx4W18WcDX6YuQIJeHvj+sYW4WLx7kcUEWOiAg23DIod7OAYofGqSTSFm5+IRucjOo6ntdTVTIY/ZzQpYJ4vvWtI0QXoUOatieVHMH0q9ZbYMko0J1OpRw7wor0Z8pndefrtbz3cwhOY7F0RJddgHy1m41ZBiOH73AT+4Re7Vdw0w+SGd7lv02OznTsGWo2Lt+0Se7oaapqrk759Biz1Ljx1+idmZUhHDORC0pL3VfTSQjqYdsy7ijtNVYQTYiBGZTkq4tJdPbQbxYHriChfks1tlCOjRZQtixL+1juWsN4trhhIgxvvFFz9pVw+Snrp1G9aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=loz1nlUjxuqsQV4rv5rHJxRzdvvOgIkmdYouUXofigs=;
 b=WAjEAryWoSr9NUv26nzAS8Hb7O8IHm1PRJXmIpfJpP+DWejV/fZdDQ5FYZiL0RBArAl144D0Rfw1QtNFflYRSsneI/l5xlqbJqnGL5PXLSRWLFPQiA2Yh1t5Nh3z+XejDYSVvY1ZNFV6JAh8EOQkyTw98cDdxwWVLzx/Yg0LxqzJdZGCh3yPHW+ywJJstKfDCjmeVVqn1txtyx44du7cqGUmT1ZwcSJWHIJfV25+wTqewBgNCWzhhdHSaNM0gqxmTBjQSLkhWQ1ShHLCKP4BXmHERd05HV/aQICYYLIqmOk2iq2RL1UOc2cqJ1246oPHdv4Ni6/xTBLsyN8765Ei8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SA1PR11MB7085.namprd11.prod.outlook.com (2603:10b6:806:2ba::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.15; Tue, 6 Oct 2026 14:21:49 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 14:21:49 +0000
Message-ID: <e01185dc-89d1-452e-b2d6-e75082befe55@intel.com>
Date: Tue, 6 Oct 2026 16:21:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ice: fix missing type casts for flex descriptors
To: Omar Munchaev <omarmunchaev@gmail.com>, <dev@dpdk.org>
CC: Omar Munchaev <omar.munchaev@gmail.com>, <stable@dpdk.org>, "Bruce
 Richardson" <bruce.richardson@intel.com>
References: <20260928172759.3369704-1-omar.munchaev@gmail.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20260928172759.3369704-1-omar.munchaev@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0064.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::24) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SA1PR11MB7085:EE_
X-MS-Office365-Filtering-Correlation-Id: ec6ff3e5-f59b-425a-e601-08df23b52882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ZhRteOpg8wK+SQ+Ai97jZhR4v8WFhNAhTCjRF9cZwVQWVVWoxxAdCe7v1Z95gBTqqCHN3lSYh/m1QqPhGi1VwwnQTIkYc4Djwe/dXcZtIQwOKwdeOeScKtAADQ7H4rmLQW4lzD26ZdCcg6jLhzbhMxlTAIAXQjWRMzzm1wbu0QUDjv6aBlpmv1n2p/tPDvTDx0S/2+8d92JeRvXAWhC+zJw0yFu6b0h73AcCYOLGbBjpKFFW9aPve3LYHymtsMz8CiNq4K2fd6AqIdCkF2JVP7NfFRtAa7/FlUTwwd4or/YCIsnTYzN0T0JIWLAJ5PrZNyxhm7JJel+XT/1397dvqy4Jb2rmoMdP12gmZRJYuBfVLSiRol1Do8kew7mTeRddKrL5ubFenQnl1Fp0rLuKstSWB2/pnkLOgHmu6FbMAVzJy2ogx5xtYPIjxgQmjwOQLIzs6yELiewhPIGoKY8wpDzaDr6vkCDVwIrs+AzzBOrfXOtq5o+QkRjmqHgbd5leNRYALhFcY67jHnqs3dcXwUEczA3fMCa5lYqzVBc5NwLqZR/qnG2r04UbMQR9YdYOyoJYt/euF9oNjvjb6X7uLntvhtKMvZcg5iGFeuEvHoVx5+MPKP8+9f7hc4y13ad2orzE8DbQuZ3RIpkD8Q6tLditgJne1hS7T9N8sp4tBgE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXVTUjd1L2dEQ1laRU1LYXR3NHQ5RGZ0eTlTSVRQSldYSHQ4TFFxVVRtYmp6?=
 =?utf-8?B?UXlOdjRVWXhKd2QxNnZzRmV2cnY1YWlOMFVQRllFVjdKMGt2TEZnVW1LODIy?=
 =?utf-8?B?eHJtanZRU3czRzRiUTV4MUhuMHl3UjdIOHZUcjhZTVJ4L3R6dWtCcDZKUzV1?=
 =?utf-8?B?MzhERUdid3J0dUVmdGYxeDFvK3ZwcW95L2RVMXFuQUdhWFNUSU1YblB6WTRX?=
 =?utf-8?B?bWwyTys3YklvQWh4QWFXcTNsb0VvMWFMWEs3RG5admJkd1gyUUFrWVAyVkIy?=
 =?utf-8?B?OWxwQkhLcWNHRGJsVEpWRXl6YStGdmNzWk1IV1BvelFvZS9RbXhub1V4L3Jq?=
 =?utf-8?B?b0Rtb1FKSnRKZzJQbEI1aStmaXNBdU5FQXlNUVFlY2J2MUhuTmtkRm1wZ29r?=
 =?utf-8?B?S1ZURkNPbmlNanM2TTNleDFHUkhocVdwWFIzbDB2L1RSOHVlNWFHNmhDOFR2?=
 =?utf-8?B?THd5SElVWHhrM0VzdWc3bCthNS9tNzVrU2YrRlZ1OTk0ZGRjU1ZrRnNrYmU4?=
 =?utf-8?B?S3loUlArU0hQdHI0a1lMVnJWSlBZRkFnSVI1VERwR0NKdkVWYXQxWHFrTkFW?=
 =?utf-8?B?ck1vSGhybEVNSjFhTGs1c2Q2dDEvcWlDclJBRDdhUGNHS2ZnczgrbG1sRWJK?=
 =?utf-8?B?Ym5iTzNsSEtqblhHWXl5V0VuMkkzc0VZM0w3SXRVcHMxUkFoRExVNkN6aGNG?=
 =?utf-8?B?Zm9wZFV6YnQzV1BCTGlwSDNiaklYZ0owS0RXK1dzOUY5N0VEL1NlbzJWMG5s?=
 =?utf-8?B?NUNaaVgrd3RvRTh4NlVUOEJiSHhQVEhESUk0SElkcHMvTnV3OStRL3dtVDE1?=
 =?utf-8?B?ZXZyRzBCY2hlVG13ZExRdWlQRmZ5dWV2T0dvTTFpa09MNE1HU0h5Yk52THVz?=
 =?utf-8?B?azVlWFpIUy9VVmYzM0NWTUF0MkhhVkVnYUZTOE55dUJRV2xWS0tOelBaKzk0?=
 =?utf-8?B?a3daU3dmc0oySGRTd1dXZmFCS2FwQ0luTGlxL2RsSWVMc1JWcU9wSUZuSHlR?=
 =?utf-8?B?Sjk4WU1Rd0Y3cEowRmliem1BTktPdzFyYm1ETnJVZnk1MkdWK1o3dGtUeGxB?=
 =?utf-8?B?V3VEM05EWnlNRjFFd1ZMOE16SXZFclhCM3YraGlNa212bVpzMTBrNmkwRC93?=
 =?utf-8?B?Ni9BVWJvdjVQTzlEaVdVS1dtSStNbGIxRDJEbDRON2YzYTZ6c0xtUGJJWlR1?=
 =?utf-8?B?a1hHR01aYnBoaEhwRVQ3VjU0OEpIR3JxK0ZlOWlDM0JxUWRzeEIrdWs1ZXh4?=
 =?utf-8?B?VHdRVVVjWFUrZW9GZ2FvN0htUktxM3JGSk9TaWxySm9NSHRKUStMcGlWQjZF?=
 =?utf-8?B?SC9Qak5uYitjVTZYYjNDOWV3cEswdk1GZG15RWU3WEgxY2FkcFpZekc4YjBQ?=
 =?utf-8?B?SjRkMmlvTE11RG95c3Npa2M2UkZkeC91eDh0V3BwSDhTS0hPY3NNdC8zRGFX?=
 =?utf-8?B?SVNYa3JIbnZsblFzbkxMS0grUGJlbEZBR1g1M1RSWHhBZHhIdEY3dXZQK2tt?=
 =?utf-8?B?OWFoamZoeWJXUS84U21NNElyM0liSkxQV2RVTExPaGhsNlpoS1lXK3dNMmJ3?=
 =?utf-8?B?ZWJ4L3Y2NHZvNTBydVZXNDd3M2Q1Z1hEdHNlTG92enhzcUJHZE5ua2U0TmZo?=
 =?utf-8?B?V1Y5UGtNUElYSXpVNTRRckdBS09NR2tacG5JMU5yUWVzTksrenFYN0lQbEFT?=
 =?utf-8?B?N2l6TUdEeDJkTnpjNjladHJuaXU1QjBzckErMVNJYlo1dklNMzFpUzR3UFBJ?=
 =?utf-8?B?NWVTUklKU21lR0d2NXNuZWdsYUF3RWQ5cjVhZzJ2enFqcEJOZWFCSHBkUXha?=
 =?utf-8?B?T01oWjhFU1BINGQ3bHpwMkJTcmhOcGQreEhJVzhhMUlYYXdLR1NpelZtRmFE?=
 =?utf-8?B?ak9uMjBQOEl2dW1FcDkwSVB2V0hxMDNZd1l0dkdJY011dzlSNmRUODRLWE9j?=
 =?utf-8?B?K2ZiZm0zV0RsUXhDOSszb3hYTmZDbTMxNm1rcVAyR3BseHI2MUFPZ0kxb1Iw?=
 =?utf-8?B?L01TRCtVUmhvajFZYk15cVB2dHRsUE90MGgvblNPQjE2L1ZZaWlNZk5FTzFu?=
 =?utf-8?B?S01WYjdQVjh4THdQNGFJNEdIcFl3SHFvUFR4OEUzbTlQYnhjdHdlS1JEK3FJ?=
 =?utf-8?B?SmdXcEEzTE1JeXpReGVTRGl2ZHpvUHNQRDlZNUtCcVE1OEVHa0t4S0FaMDlo?=
 =?utf-8?B?M2UvNnFBYlBnL3VCMHM0QTRRTzN2YmkyZnRkWkc0QklibmptR2JnNjhKeGtG?=
 =?utf-8?B?dW9yMkRzTjhOdmVpbWQ0Mkp2dHMreDBXenJwUXJCdWthTERHM0xiMis3S0ZL?=
 =?utf-8?B?Sm9ZTUJ2cHd3WjZ1R1RoMUxqSHJiTngzQ2s0UU9zQWNUYThsRk1Yd0ZMcTBh?=
 =?utf-8?Q?49KhTnYXocAhYp+Y=3D?=
X-Exchange-RoutingPolicyChecked: obU/YmVeArrPHF4IQzI1EtT4uWpEWmm472VvV1M8gxzu5l6gWoxXSp904Pzo/y02w4bBSYF28EbBjwyBTsdlYg1bG1Lxvp9wEIKA/26gt0s+6OMPqvtYmuolglujlDYQuVx6swDBP+tZ+p9lDVWMxjYfa82Pa8qZwvd2vNUr7L5CuXZnwufU1of4x1ZjonkhTQcC1chTKm/GJsR+oUBqrkGSD8F+RVZX0zChjj91rWzMqOYTprVvzGw5gUxdDr2VhCVuQeSb5cuc7R8Bl9FTIEmKDA/iFM1SpdHl8NyT1FL3c0cLGwZxiDW81iz+Y1WNPSY3sX1946X6LAwhFMMAOw==
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6ff3e5-f59b-425a-e601-08df23b52882
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 14:21:48.9163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yJfJDEUArKiJKT+vGh+txLI4sZE3/bnBARUMWYP8YmKVFOwTJMlX+T6jQE2Il+0l+hXo8wR/uc0itWklLPcW4mWnagI6iI2j++bD1syul70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7085
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

On 9/28/2026 7:27 PM, Omar Munchaev wrote:
> When ice driver was ported to use the common Rx descriptor format,
> some type casts were missed. Add them.
> 
> Fixes: e70342ba90a83 ("net/ice: use common Rx queue structure")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Omar Munchaev <omar.munchaev@gmail.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
