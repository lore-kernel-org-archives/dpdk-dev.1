Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA93760700E7
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 17:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ChMv03rI
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7330C40299;
	Wed,  4 Nov 2026 18:31:33 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTPS id 2946540281;
 Wed,  4 Nov 2026 18:31:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793813492; x=1825349492;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=I7ZbEKYnhlO0Kh00lL8eBbgWU7lco8qoS7JX7tFlftM=;
 b=ChMv03rIzMllmXcJuXBMlflqJr2tUNHH9aGLUDzxrhRAGW0T+CfBxD1B
 SyeI+5FJuPPZPPzBNYqjIkXiMJQeF9jk9GJ/z3qafYGJoyQ4500D4NtX4
 arRAuoUiPfo4dGKtcq3LLdab4NUiG8yqMgMVb1ufJJ2JNHPP88e9KknrL
 q2sUUdyY/LVZAh8Y63Qcxvz2bJkp8zg9XJszyMWc6WRYDXcwxZyC8YTdm
 sVkuYWCi0+6DFzXjPUeqVWer6f3p2FxQZ1cqGx6DfvKgPx5rvgoKwkXRX
 eEXsuATPkWKiyTKCiM+zv6MfdNbeifrbJMIUX0AiVB2jeC3VoUf1UFGi1 Q==;
X-CSE-ConnectionGUID: Sk9pCE01RRGs4pSSAVHIcQ==
X-CSE-MsgGUID: v3rp4mWfShmPAnFhJiNFsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2477805"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2477805"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 09:31:30 -0800
X-CSE-ConnectionGUID: 9rRMc+fPQwqxPDeTfeG7Zg==
X-CSE-MsgGUID: +Hb+VS02RCybzdxfM9SfCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6602615"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 09:31:30 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 09:31:28 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 09:31:28 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.24) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 09:31:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CXlKYSCOj6CvRB1DlBazj53ZCQT0AxqYbnxnNXzQVDrWKVFXLrmVfnV7BaNENE7AtP7wRThmVvp/KkEhZTntERE/J1NWl1ZOOQwSf9Gc1Sfi7T9vnFXE/4Yf4MtWwTw1jmbMdRE62SU7zHry8bnj3ZzaFSXWf+/G8ssT5gbRR6ROEE46O6R93ipSjqEY57U2RGbwsGbBmMR0RfPa3rB2ylqhe43W8gnhjtycceEzoae87B/zM+t2eTfgtJQON1doX7Z16rthAe7FDZemomhLQgTYMzbuxsnS7Fp6MXDj7c+zraBanNMfrgKGZzgIksJXwZg+Y9mz6RznEiqnlFZ5bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9V3iCC4RWcfAAeqinieU1RoHVc+cEixAVULnPDUIRc=;
 b=jFl0EcWk+Ph2XHrKY+kifLTd260MdskoS9m+hAw5xh+8uPFJjM2TJJVlsU11TufQQYfrGwb229GHxwqukMVH95xs8/CyHi+jy453wSnBmbOOKvv3hE2P061eVuWPWVDKXGk1YswUJPyCgxrDN0vF4pBNEzYg0d6csCcYpfz6mEASltgsInlIIceJ9snrHiof+fb3KdZybqdOkdI+kman/avXoAKWZmk7igYd6OJsy98DJ6ntIJm5hyVG65dlaAPBeCF6L6UdpGyJYnr5nZ1GbPQ1Kdv5AGkzXEJcMkO7w5D1307nWKqZFj+VqqKnl6OdQCVmifWw07QP8pogRGELDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA5PPF16790251B.namprd11.prod.outlook.com
 (2603:10b6:80f:fc04::b04) by CY8PR11MB7313.namprd11.prod.outlook.com
 (2603:10b6:930:9c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 17:31:26 +0000
Received: from SA5PPF16790251B.namprd11.prod.outlook.com
 ([fe80::f936:a75:41d4:c567]) by SA5PPF16790251B.namprd11.prod.outlook.com
 ([fe80::f936:a75:41d4:c567%3]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 17:31:25 +0000
Message-ID: <269bfee7-b433-46cc-ae46-b121481495c3@intel.com>
Date: Wed, 4 Nov 2026 17:31:21 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma/idxd: remove experimental on whole driver
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: <stable@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Conor Walsh
 <conor.walsh@intel.com>
References: <20261008154351.387445-1-bruce.richardson@intel.com>
Content-Language: en-US
From: "Laatz, Kevin" <kevin.laatz@intel.com>
In-Reply-To: <20261008154351.387445-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0248.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::21) To SA5PPF16790251B.namprd11.prod.outlook.com
 (2603:10b6:80f:fc04::b04)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA5PPF16790251B:EE_|CY8PR11MB7313:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b000e64-83d5-4cf0-129a-08df3a997363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|261028144727099003|261026140227099003|261022105027099003|261102123227099003|261021121427099003|261021123027099003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +vQLw+/AkgvlP2UVqO4shSeckITlWxS7pRwEDoTPdPMdgvH4HCABrTXrrMPudyY6pXI/mt8zLSEPA4caomrr+iWq1y9Uossq2VefRidwl6esNaYeaMQbXP88ERaarmM0A/+AZA0FK5fYODT7nTVRir9+SFeqztbDzRbXeXF2ZSeSY9Y37l75zhnLfljfp2EcPJx5jZXFoWBE6MGgqaUGk1dw+LxiJTb4gpcTLHLiX54PIa53JyQ2wBxusvwFVSegA6HFd/JwNkdIqEFm7H2aOKUn45sS0eMpnlY02teZHn3d73y8+FAjkg6nWjLxBCvJMraHhIRHbbZsSFapQFbZe3CJ9t+71o9wc3jNLlE1vhadcHd+SseKmlv4Mm8wbk54btaGkoDkXj2nTIFd6kgzjm2J/hMIzl7VwGcJC7Vm3/Nj6vKlZOhXFgeA91rwcD8qqTKZxQENlEinarw4Ohq3pPB4WQ8W42/f94i13eVnwLQXH41gF3Fe0ttdBrqeZpjU0vf7GXPQ2lxoB+3Y/uWheSuoLm0K+RdTnSxHCElhsa98/s5982e8yT2wbVsr9ThKPhwBjDJtYe3py5KtQP8AfnidP8qXTH5EAdu3F+CIMDh01q2egjxabkSxFKUI9fOn+j8/PX7BNvMiWYf81AnQ9NgTzpr/jrKskMWz4qBPKHk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA5PPF16790251B.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(261028144727099003)(261026140227099003)(261022105027099003)(261102123227099003)(261021121427099003)(261021123027099003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEZzN09UbEdlbGVidkxORkJMcitqSmpZdDFTVlp5QlZvWllZVGUwRk5HTkVk?=
 =?utf-8?B?SnZKZm5ZSVVQS29ta0RSN3FFVkhFVWhjT1JUTzhwSjFsVWhjdm1ZbUZ2eHls?=
 =?utf-8?B?elNkRjNHVzV5Y2lwelFSZm5qc1ZGMkEySEdkSzh2eVp1NmRGNjNrTS9sLzFU?=
 =?utf-8?B?NUZaTU96QXhlc1BUNTBHZi9mWEJhY3grVDlRZDBPMmZLeEVMcTZaSG0rZXB1?=
 =?utf-8?B?RHU2bkhiWUdRYmNXT1psblh4OWdqSG40YllxM0MxRFFBTndWUGIzRDZZaElz?=
 =?utf-8?B?aDRHUlYyL2FQQnlHZUN0N3d1NlowNUorZE5KbzZadzNFRUpWL3k5clBzanQv?=
 =?utf-8?B?T2RvWEsyWEhiWm1lODRCRDFWblNKYnNET0psQkd6dWRTSEpobHZtUm95dW5M?=
 =?utf-8?B?RWtiNjJBRU9yTTAxWFAxcFQ2WU1VaUdsdjNSaWNtOWZVYUozY3RMRXBVazk2?=
 =?utf-8?B?RFhGcWxreWoxMGYyekdCcWcra2tGU0NKbWpCZHVxRDE4NjA3WVZGb0ZHcHFh?=
 =?utf-8?B?UG8xeXgweDFoOFBOUkp6MHJweFJQRVk5Q2VtR0txK0k3dzB3VTlzWHBjSnJB?=
 =?utf-8?B?MTlPOWpCREk1WkMwaDc3bkhLeEVSU3o0ZlZuQ2dKYnlXQTRjbkpFcTJyRzhK?=
 =?utf-8?B?dUQ1R0xSaGxmT0JVdUI5bkJWRFpEOG9aTjR6d1AveWRkalJ1RjhjVEZiaGx1?=
 =?utf-8?B?UFd6NFJuS0VTT1pWeUIwSDNuR05Uc0V2eW9nQ3RnQUVrWlVqRmpPVkluQnBo?=
 =?utf-8?B?azNXMElNYmVIL0N6cVg1Rm1JVFY3OVkzaDM2NHZNUDVIRldoNFQwcnAyS2N0?=
 =?utf-8?B?QmVwVzJGUXBKcVV0SUdBS1RXczJIcUNBbkNFTUl1T2dxQkFpcGEvYTNrMWJi?=
 =?utf-8?B?cnJ6WHdRaU91cW9iZlNtVTh5UjZscWtYY3lCSWljelVkNjNaYlU4SlVLWC81?=
 =?utf-8?B?NGlUTDNEMC9GR2JHTjFHdFNlSmozM3IyM3JPY25LYVF6TS84a3BoajJPc29z?=
 =?utf-8?B?U3crZ1llY3pOR1RLSmxiSFZ5NFpSMm5XbDJOa0JYdTZzc2FNNEkvTnRCUkdZ?=
 =?utf-8?B?LzA3YnZ2NFpERmJEVjZvN055cEZkMmk2Z3VZOUcyUmYwellWaUlleC9MQ0ky?=
 =?utf-8?B?NmNTcmdnQTRDM1ZuaGJpb0V6TjNjcXBwalRkOTNHNzJRQURpbGVhQTVZSlpO?=
 =?utf-8?B?Y05tclVVRDhJSURqdUg5cVlxZHl1dHZxUUp3L0s1b1NhZmpjSko5czV0L0dP?=
 =?utf-8?B?T05ZWnEyS0krY0ZBZkZkclZHektkVlVqN1Rid2NMZXdvd2pDYWZXK25sci8r?=
 =?utf-8?B?VnlTdjRneDRmL3ZHL0JsUHBKdW1iYTR5bmVPMFVCWnZIMlhob0NvRGZFQXVD?=
 =?utf-8?B?OEZrSzgzRVpJWEpnRmt4VFZybUNjZHIzQmhMak1SV3JOYlkxemVwN3N1Yklq?=
 =?utf-8?B?bnFuMUlwSGwwVjZQWTBmRGRoSldCeVNpR2ZITjViMnVHZ1Z5bVpOVVdvUk9B?=
 =?utf-8?B?aDFCdmY2VDZ3S1NTdHgxRHc4M1l0SDlENG1XcDBKR1ZKb0ZZVkpwbE5DZ0Y4?=
 =?utf-8?B?MjJaeVpnSUhxT3JTK0ZKSlR4dDRsZWFhVHY1SThJRjdoa3VtdnBZNVIxYnlT?=
 =?utf-8?B?TDE3OFd2TkVwUllyQVlmTmFMYnBpTXhiMEZTMURMYllJdHNocXpZMU1SN2JB?=
 =?utf-8?B?UlY1NEpaZWpsRnpPNGdCdU9NaFN6ZldsSFFGNk1IZ0tvTEZiOHlWMkw2UUtT?=
 =?utf-8?B?WnIrOHhJS29DV0x0Tm9NRWM4MmVtU3U5YnJ6bjRNQy9NY3hkZXlkTURrbitV?=
 =?utf-8?B?UmFBZmJqRXBDWFZ3MU9sZU1YUVBhVE5VUGVuZU8vZDhPWVo5YlNYUDhpUFBZ?=
 =?utf-8?B?UlpwdktsemdBd3g0UWNUVHFNeG1xNVh4d3VtNlByZlpKekJuWTVZc3NzcWlI?=
 =?utf-8?B?bU1QUmw5VVUxYUxFVUF3bWlPOG1HNi9QUUQzSnJuSHhLb0Z0bzlpMXRsTGJ3?=
 =?utf-8?B?bWhzYm15NzRZNkZmN2g1T0tTSVVZMWxVM0tFNjYwSE9xZjNpc2JmWUg1SW94?=
 =?utf-8?B?NkptQzUyeFNNalVTOExKR1g0Q2o4TE1yVmtQZUJVUlZ2ZWFjbUhTU2l4NzJ1?=
 =?utf-8?B?OWV3bm1JS3pkdHlvbGZIOW8xTlVPZXdVTCtORmkzb2xBLzM1ZmsyQmlJYVQ3?=
 =?utf-8?B?VUVEVnNnb04zVXQ4U0h0WmhienVCQkhCc1gzR1RCWkp6eEt3cEdPejB3YWh4?=
 =?utf-8?B?NHp1UWx5UVFuRHpqaUlYcE5YSzdzQ0trTmlVN05xSVRnTXdWL3A1bHhORnB2?=
 =?utf-8?B?cFdoWUtEZ3hkeUFhTXYrMFUxY2hlYllBYkwvS3dvUzNTenBsRlhCZz09?=
X-Exchange-RoutingPolicyChecked: YG16fCXAWLlAFdGrX+vY/8lRMPUlQUflIhBMyHOUu6slHiFVr066n/+YzD1S1p2884e/ea8ueomAmRQkSquO9uJXAZ9mcRd+iRHV14bFN8efRtYkV4JqZTYZBsfDrq4PH6LesHscoZObIKe0qNfmCbhP82ILnCvB883uVIAMzBOxQuMpdPDlTlYr7W449L1KVN8ELvrxkoyt+DAby6xrqxnZJPj4HXkeN9QCukhII2vj34mwue8dNFR/J1XkBXDIJuogPCD2co6GgWkf2La0XJo0R8vpVgY60LIwTzKgj2V+6sesEzl9HU6rye1QpRNITxwgLB6EjCMdxyJmr4lrAQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b000e64-83d5-4cf0-129a-08df3a997363
X-MS-Exchange-CrossTenant-AuthSource: SA5PPF16790251B.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 17:31:25.1379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 80zw+G6IUE/L2swBiot89Z+hEM+joojCu7GSrxyQxm/F6Axzc+dQNByWLu9ap312gV5mPE0NUm3+vSDy2lwqXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7313
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/8/2026 4:43 PM, Bruce Richardson wrote:
> The idxd DMA driver was marked as experimental in MAINTAINERS file.
> Remove this designation as it's been stable for a long time now.
>
> Fixes: e33ad06eaeeb ("dma/idxd: add skeleton for VFIO based DSA device")
> Cc: stable@dpdk.org
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>
> Putting the fixline as the original start of the driver implementation,
> since there is no good commit point to use to identify the stabilization
> of the driver. Since this change should be good to backport to all
> currently supported LTS releases, the orignal addition of the driver
> works fine as a commit being fixed.
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
Acked-by: Kevin Laatz <kevin.laatz@intel.com>
