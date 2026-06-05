Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B771CD6E7D
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 14:55:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5044A40659;
	Fri,  5 Jun 2026 16:54:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 3E6AA402D3
 for <dev@dpdk.org>; Fri,  5 Jun 2026 16:54:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780671298; x=1812207298;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=yuJH7u5gq41mITUuyXWV3L9FIqEHkuB60AGJjSRhn54=;
 b=hRgXzTOMyhEEWd0C9uWUjqztokwLnevNcpdwi56wPvDJXCArP8QIpFvh
 SLP9Cewpg4ydvdQKbzAXtwZA5x2Gj+TbPicW0vZq6cgqgqrxjYr64yMgh
 Qou6lKMyW01mR0UEmPooF+BeaAze7W5teoRV+BRUmEIj1Pp2cXZymJpqb
 i+QCFWVArqmrU3aNyX+D0Lh7oJpmCb6a6JlsmG3QfASMaHK6ZaXSBv/MA
 XbxDq39CypMbne2H5QKnobeRgxTHegE6LBcm/vFg5YwvXldmqdSNoo9Sx
 S80A15C/N57ccyCzdfJjyfyt6jdBx2sLSi8XOI1+NQFtjJNuNkfdE8G8s Q==;
X-CSE-ConnectionGUID: qNrlZaC9RBGpMtFgfNZ2Ig==
X-CSE-MsgGUID: kjdTJpguROOhlBtFezWvFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81251078"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="81251078"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 07:54:57 -0700
X-CSE-ConnectionGUID: CzZ7p011Tm2pz6kAVAFCYQ==
X-CSE-MsgGUID: 69EGiauCTL60pRSlEVLWHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="244979198"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 07:54:56 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 07:54:55 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 5 Jun 2026 07:54:55 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.51)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 07:54:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMqX3apf+3cJgza8OvC2fmT1mHyePNS7pjV2eFyvXEu0h286aHWZz7WD38RdY4LKwJa6npFo6BqcJ33OegC7D74CmjZYxLuii/iK1+cAQXq6SHEOMI2AyVj1Q7oV+FzfQB1PLMmZ7QrwA3UuK1bUbD8fGIaa26dwK08qcPLhkdf97MpDe+nKnObdyA7OpJtfTTrjWnVLusCfLZ+8uBjqX+o/PSG6rYTbP7sbyK+ZljKCkGVoVL590518hvSkOBPZLx4JgLIQ6AuJCanV+DxntKq35gJzenZ4QSAIhZWarB/kxXDJJd/xbDOKa2jpoqPaf5W0l+NwmscvYyckuajxeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTmVG7oODaem1XXcAA2Zbs2G3fmr6v45a5UbrIVlE9s=;
 b=mZwu15JFqjmd4IPUblJYo/z6/gO8iIxrbbsnOPxF/yMmshIvvubkmwaME3/4WtA6Bw68Rmw5O24JXV6AGAx8pZqwki364nwSlFaXuADLU0NuIk5JcjQWU0h3xY8O1gsptpcCcJs6CyYl8+eGrVJSJ2q7fsK2xwFY4qK3wlzl8imvuOQK4Sni6vCiTLBup6vt8aLtKIGYrrMPsa7nN5WDW8/SZEa+c70UNRUXUKiJIYmb9HNdt6y40qQNle9WqA8VvSdR2UXNRjoP9DBemf4RXbYW/CjpJSCGVOan2mnw1jOAYAoNLQJfpdnBEkInwHcUSr53iMU8LRKyxVBvlpr9iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SA1PR11MB6615.namprd11.prod.outlook.com (2603:10b6:806:256::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 14:54:51 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 14:54:51 +0000
Message-ID: <73a0a871-b4ca-45b6-90ee-a22e78a1460d@intel.com>
Date: Fri, 5 Jun 2026 16:54:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] net/ice: pin outer Ethertype for L2TPv2 flow rules
To: Shaiq Wani <shaiq.wani@intel.com>, <dev@dpdk.org>,
 <bruce.richardson@intel.com>, <aman.deep.singh@intel.com>
References: <20260427023115.1225843-1-shaiq.wani@intel.com>
 <20260427023115.1225843-8-shaiq.wani@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260427023115.1225843-8-shaiq.wani@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0309.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::8) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SA1PR11MB6615:EE_
X-MS-Office365-Filtering-Correlation-Id: b5fc5aff-abc4-45fe-ce1d-08dec3126590
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099006|11063799006|5023799004|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: giEyLJV47lKI4yLbQAL9pshJz/x8NeIBUhDT2fSBX58b4n29gpfOE8MDqYRJQXIR9WR8l7635zv4e0JIQnRbtDr+KBNEiFTJRT16k3vxjiiyMZ9kI7+1UOmCyfHOBO4BnIjAL4I3cVPZr7RgY4tF5PxXMXGuDWq4mP080gx7RZ6Eqk++MPC1tn8TC95BESlk0rH+J1wKWwbx1Fuu4G8aUtxN5TedvJDQkyUh2djmVS0gfm20qcvr3exoUET1IPtEZ4gNRa54FeorndxsstNXsWpsz9f21PkPw9CIuFmFQ54dlNAzupkXLy6UbT8C9ImIzQgRYZDtaL8CsylB6NHUqC+RRP94k8Y9bnLRulRwvm7cK1FO2UfXhBlflrK6q7r5lVu9GVZEt4jbOzUSEl1qtifLeCcXppJOFZiR63OMod2Z4HYire+8CPPRw+K1zCE1qW8LYCYxPwyTJwfgr2u/EEa6c8EXGJ81pQghCXx6ICeWWnxVO54GMfvmtogYhYE84t5m833HTXSJORoSTzdfv3Vh7QRhiMii1dF7sIFvhLe5MT6WNz/XdT5c5X+ICYpVvHFRBB3BZY9p4hXYEOOnfH75DOLjP314hMt7odhm3+QDAiNrgLtrA2C/HFx6q8kAGpDH2cTBxjqGth2/T1/MLj16gyvIAKb00aY5+xBHEl9yFUGF1ZVLpYSZZ6Q3AFbS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099006)(11063799006)(5023799004)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dS9jZEhSMEkrMC8veitFZGMzU1dmenNlREQ4aExoU1gwYjlGbUUvWkQ1Rmxo?=
 =?utf-8?B?eFVBNSt6S1NJeHV3SUlTRXJzQkJZMHZuc1pFd2c0QS9wK1N3UHpNYW9nckZC?=
 =?utf-8?B?dE12N1Y4dEpRSHhMNDFIektVNkNWN0RyVVZLTEhFckN0M1RRTFlBTVFUL3BE?=
 =?utf-8?B?dEZNdmhFRzljT0lyWlpZQ0o3TkFaYUJmQjBWY0hJZitBbEVnamJCa3dvdU1M?=
 =?utf-8?B?bjcvRHhLdkhybGlMRGlEdVVlODZPNnR6cWluYVlIMDF2MThqa3dhcDVZMFc1?=
 =?utf-8?B?ZHplSlpGZGZOS0c5d1loUTc2YlZuOC80dmpDTTFZM1RGSlFjRmtSeHgvd0xx?=
 =?utf-8?B?Q1NNVkpZb2NYb2lzZ2t2TC9DK0FrV3BzM2lhSW1rY2pOQzdPN2tBa0l6TzY3?=
 =?utf-8?B?K3FLR0xZNG5SeVp2S0FSQlRieFlrY0xoVjVoRllGSmFIOG9ZMUdGSlJEb2ky?=
 =?utf-8?B?RVJ1M3E4NnFLTXlNTXdRZll1OHFxcmNLRmtXTTRjWll5WTNLRUM5dVBCQnNz?=
 =?utf-8?B?TUkrT2l6enhxRkVueFV5M1JGaThpQkE2SER1VnVwYUFURnpVdkdacjNjOGtJ?=
 =?utf-8?B?d2ZjL0ZvL1JWdkhkcEswRTdZTWwwQmVlS3M5S2srNGp5TklVV0o0UFA4eDls?=
 =?utf-8?B?Yjh3U1lOMXlzS0pQb04yTjM1SE1sYTRCbWRKUFkveHZZR1RPN0tQalh5dGJT?=
 =?utf-8?B?UkdMVURZUVlGK2hMVjRqaG9tN2ljKzZQWDJITVdDUUlHa1dCWE0xVXpoL25h?=
 =?utf-8?B?LzBwKzM3Sm15c25UdFMrblRTS3FyK0x4Q1A4bmlvV3FhTXdKdE1lek1QNDJ1?=
 =?utf-8?B?VmYySVRXSkFJWE00UFJnMTQ3WFIwYXJPMlBKZTZnbFRoUlN0U2QvZU5ZWWxv?=
 =?utf-8?B?cXFmUTZmYVJOQnNieFFPL0FuREFiL214bjVGM1YwcFZJWGdWaXNpaHJNYjBF?=
 =?utf-8?B?bGxwNDAvTmFEWG9zcnRRUDNCemtna0U2NFRlR2M2SWIzYW5DT0E5Mkl5ZnhF?=
 =?utf-8?B?UnJhZXE4N3FvUWxLeTE1Q0ZMU3JwTEw1QmRuZmN1L0ZxOXF0UmhVbzd2TlVC?=
 =?utf-8?B?aElZMDVWejN4MGFQaFQzVTdHd2FxdzdPRkx6anJGWUtaQnZNRU5vWmJyS2Z3?=
 =?utf-8?B?c2Z6Nm4vS1ozQTBSNVFnOUtxSk4vUWRCeE1HNm96OEJFNExWK3NLRVVwdGxC?=
 =?utf-8?B?RTF1ZVJtUktXOWZkZ1FBOFlUbitKNWJQVWNwcytoK09McjdRR1lLRUlJZUpG?=
 =?utf-8?B?akxiMWt5MldRWmJ5ajd3NFpJQnFQNnZva1gwVldjQk1zb1djYjN1dUY1NG5E?=
 =?utf-8?B?M1U0YVpDZktDK1I0Y0NtMTc1YUdQYjZxVm5CcmNMb0g3Zm80bWxoNWw4TzMv?=
 =?utf-8?B?SGR4elBrc3dlZ0lZQ0g5OUtkU0dCRUV1cGkyWUkweFBBMlZyTVZIb3NHV0Jq?=
 =?utf-8?B?WHhzcERwWEF5MjA1N2lTa1diM3hPZ2N5dGZ5dnh6eDFxNmlYdEFQR2tRNEVu?=
 =?utf-8?B?ZWVMTEhPekZpYnRkVk43U0Ywb2JjOEtoV005NUlHZS9lZkhyRnVQLzNIR1Y5?=
 =?utf-8?B?ZDhxaXQzeXNEWkNjclRVNlFsWUttYUNHdmlXNENudnhTTUc3YUdkUFZRakpH?=
 =?utf-8?B?QkE3ZFlIU0xmWm14RGRxQ29oejBmMGRQNHk4ejc3ajV2Q2RWd0w0ZWNUME0x?=
 =?utf-8?B?QXhZZ01nK0hNbzBvcDVZWGZTa28rU3ZhWlhQR2hwQkhHa0hnM0wvWkx3RVNl?=
 =?utf-8?B?OGVidG1PYjZiR045TW1ILzVuRkIxeEhmWVpRQUwxNnVNUDBjUUlaNWFUaVY4?=
 =?utf-8?B?YW9UU25ueHhQTDA2bmFtZDZML1lWZGJaVEFuSnl6QzFUTmFwazZKajV6Q0ZH?=
 =?utf-8?B?ZE5nb0k3eUJSeDB4VEVHZ3g5WStIdklLbDZEZHJTZS9oMXJVTVpGZytTOTVH?=
 =?utf-8?B?N3RteTN6K1lvMU14VEpqOHZPNk8yZzd5Wk9nMjdIOHJJZklSSkZtaDJUUUtU?=
 =?utf-8?B?UGxoUXIzbUN6aUhyY1FDWDQycW9ScmY3aWRJekw3Y0xaTGtwaG1pSkdob3BC?=
 =?utf-8?B?TCtqOVlSZHV0K2tMRzVlK1NHdFpoTlJ6bnY5YitKb3NldjZNT2xaODd5ZU9u?=
 =?utf-8?B?aEs2QklDeXVKYzRGUWU4NDRsUE5jaGxuVmdjbWFjMUVQR3VuSHF4YkVQTmhY?=
 =?utf-8?B?WlMwRkZYQmI0WlJWaUtZZE5QbnlwYTR1MDB3VTRGNmRrQkRlSG8vZ0tnVU1m?=
 =?utf-8?B?VWpibFl5UkFkbkswN3NrYUJPRDVFS0xRUnpicDRKMHJRRE1zdC9Ka0RNQ2lJ?=
 =?utf-8?B?QzFFa2dVdEFhQVJBU3d2d01HZkJyMFhXMUp1NXUzdzhXbTlrd2dhM0ZNV3A2?=
 =?utf-8?Q?PvgNWxjf/vUPX7EA=3D?=
X-Exchange-RoutingPolicyChecked: eRZnl/PyQXsGIg2P9oiDsrdi5+nj6j8Y98g24qaJAIg03QZIO1EcH3trDay8t4FPxVwV4AQnOxi72oHf5nkCwDAlckBsvplKctb3Ki5yCaIZcX+EndIg+CpWGgv8tSW2lqqkob6LWHy4NyfXQa1h3sQslY2635m5VMyHVenOlU3vsTGqh5ZfJK857Xepj/qFjpqXKU8LzCF85RXNghr4mxxiq6+T/S/9tXeC+88jXTOvIYdCrKg08Pp5ir3+ye/HS9b7PO9is7BOITcUZDJ2f9dbdR+Tgu3AHI9EVbICynGXVNS8b75SXDeDEqc3o4/gQSmovbtSVGTATNael5UyZQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b5fc5aff-abc4-45fe-ce1d-08dec3126590
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 14:54:51.6259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c4EIDvVcQdMqyhh9PI9LrKW2RsrU0+LyLMYb5m9mRpUmexEewb6UctvoxPAml+uMtevjYzvWee3COC8W9FoOVVr27HtfW3b7IFBRajaDdcs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6615
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

On 4/27/2026 4:31 AM, Shaiq Wani wrote:
> L2TPv2 flow rules do not include the outer Ethertype in the input set,
> so a rule created for outer IPv6 also matches packets with outer IPv4
> (and vice versa). The hardware profile cannot distinguish the two
> families because nothing in the match key differentiates them.
> 
> Add ICE_INSET_ETHERTYPE to input_set_o and set ext_data.ether_type to
> 0x0800 or 0x86DD based on the outer L3 item, so the profile includes
> the Ethertype field and rejects cross-family mismatches.
> 
> Fixes: 733640dae75e ("net/ice: support L2TPv2 flow pattern matching")
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
