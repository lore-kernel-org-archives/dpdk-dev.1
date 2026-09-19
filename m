Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685FFC982D8
	for <dpdk-dev@archiver.kernel.org>; Sat, 19 Sep 2026 16:14:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B127B40DF8;
	Sat, 19 Sep 2026 18:14:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 6497F40DF6
 for <dev@dpdk.org>; Sat, 19 Sep 2026 18:14:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789834464; x=1821370464;
 h=message-id:date:from:subject:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=hpvbHjcJgXfEOug4uU/sPV/EEC+bRs/NY8jH0jRQiiY=;
 b=mD2nKAXY9uYRBGev4IfDura0hbLlFnn8Zvwl4IDi/leSJoL2A8fbqvcb
 w0MQVsd/m9jTVxg/CsKn0ubuNNvDd/FubGEwcIvkd9es/9t2e7dti/W7F
 cIdx24bdTGPC1CZWn5RCTArkEOZtHwVb9xnIiuUh4UMQv5Md1WPeSh5C9
 NljKzFsJVZo6MOIy8em/kJtHwFq3IqU8E6F8ltx/6wCkCtRSLAjd5/OVv
 ItrN44PegAnU/dP0ghU3sQL+Ay05/+IR2FhkOA87YKXLebjBObULnVfIf
 XHFSw9gnejignp4GPXLS0Ih/gc8SFe4KDJ7gGDOOqfrlUn8lHt01ExccK Q==;
X-CSE-ConnectionGUID: +oeOue2CSaWfUI2i/R5Zqw==
X-CSE-MsgGUID: ePOphj7PQhqjYp0blhMr3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="94186276"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; d="scan'208";a="94186276"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 09:14:23 -0700
X-CSE-ConnectionGUID: 57Wl8wqpR+GPmpqOwmlYtQ==
X-CSE-MsgGUID: BpoHP9rOR7KMSEhC0GwFuw==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 09:14:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 09:14:23 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sat, 19 Sep 2026 09:14:23 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.64) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 09:14:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1x1QFhoP0y9ng+lHKsXqthB97VQVqVvT2Rr7JZ5uBjhAVjxT+5Gu93w1JRMgqvj2xDn15NKKPPEt4QFRJ96N+emCFBTcmzRY0iwKKGYQQInuxovqujlIIWPqjE6dXCD9H4gKmJCYXdX+Yh+OhRMx8JKXqv5oJ1+s4A17XcwTjqwP0HQzEG2TEKrNVW/Mu79GSFxmuN/n4M0XWwkN3DWwIJyB6570K74GIUierDXZckmT6D9Kg0qxUfNUhGucaSeN9VG8+2cEcLB66eV0SIhdQMleu8F9mJ/Ic5/tHpcIZ2nsaZZ0wc2oBBodUgQw/7qK4Yf/2yv2Eple3sN1aG6Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/MtU6PhPDZQ5XRqAEl2/TNdYJQvS2KvXCoP8++3Gog=;
 b=LLx46/ZqHRxm7sAgRPgB2uJD9+LtE8YeK4gXcgStBzJ546GpEm9yA8MUn+m9tk9RKcUxoH4CcJIy5i7Y7y8d+Atsq/QA5Xi1qO80UiFtsOfWWTtrllEBTPvHLMFbHcHRzYe0gH69mckHIaNmt9oQx23K0LS+/76pPywqg2nSaCGLFkVMkROlGyo1Qu7VNLBkfEPhS99mNCd5k31Lp5LUuBgpYoe4E0MzL0sCI5W3ixj5HGi71GMwZCU+xtYdeexVHR8gIWKsLkejXsN/Uc8dqP716w3pzjaPQ2ngQtuCh1RSvBmRd8NGZj2fpF9TWPs0KeFzGHydDDj3P6Vxzlphqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by SA0PR11MB4526.namprd11.prod.outlook.com (2603:10b6:806:96::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Sat, 19 Sep
 2026 16:14:21 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0428.014; Sat, 19 Sep 2026
 16:14:21 +0000
Message-ID: <158025d4-00d8-462c-8c68-6e23c432361f@intel.com>
Date: Sat, 19 Sep 2026 17:14:18 +0100
User-Agent: Mozilla Thunderbird
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v3 17/19] net/i40e: reimplement tunnel parsers
To: <dev@dpdk.org>, Bruce Richardson <bruce.richardson@intel.com>
References: <9049334630046d6bfc240a79bdfa68ab1085de6d.1789560946.git.anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <9049334630046d6bfc240a79bdfa68ab1085de6d.1789560946.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0054.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::10) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|SA0PR11MB4526:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e2eda23-0ebf-4c42-19fa-08df1669104a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|10067099003|3023799007|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xgCrRXr/AmDVIwy5+wqqnEWIqYshuphz7mjp3+RNDuJVcMUYcV2lUJQB1FlqdmW0jSM8VgjZmK+PC7yatcfkgb8GhhQ5HidtSnqCOTqrdUmv9kmNey8fesEuTFUi2lKdxzbdgMnNhmcMsi4LLngEKfuoIROPJRSr+qbbgiuDIcapj0U5vqC78feS5GX3kgptiVyJuvjyWK5L7vb53rXMQsGv7dDO3wAMa80DeVEyQoM1w5bRr7Gy8T1TJ1Yrc3Zt9YcF6GLgLZoRNN8FTC4ommpLljF2H2C1zahnUd7mW6fWOYMwu3pD5pd03hOoISLiwwIXwU2uFIEKacRetzsnZAMfMP8FMo7AHORYB85KoL3lgCnQCsdVodjkDE9Bl9enziVufXHf2yxNc0NL8zL0tTUV7MmUMT5n0ggcvBfNlc7ivaOeF9Ls1k41Tr1ZfPoEHwjSx3KLkS5F9YRiSCrj42jv6qnTphuTLF5Ll4/2+e0qWqG9DNmLrqiTMUszX5KarxM+y7fg+VrTtwIE/g7RXE7vGm3kxUAImTveDnfH4KM0GpndfCJfkM+ef6uMOnQ4D+r/odjw0ZcdYV2AEaS8DkJLYAbJHyh5CDc9jZDJ0e2iHSj04DFvX6QDFBp3XVDO858o+Mr3UZBXrHTOR0Gr9AzwMJHXIDfuH7ceR62kFoE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(3023799007)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGt4TTc2M1VHUkVpNGh6U1FMVkN5aEMyTy9xcFZQMjJwYjhCNHM0cXVscHcy?=
 =?utf-8?B?b1pxYmxYRXF1ZXJuRnNIeVN1bU1wVXE2MDZOcmNieTRRTFB2U3RpVnBtdlM2?=
 =?utf-8?B?TEpyV211SXVqUnE3RW5FUVhHa2hIbi94MnFURW9CUDdtUTN3dlBnQzlxeE5W?=
 =?utf-8?B?ZmlpL0grWEkwbDNoYURPRkVBdng4UUwveDhiSmVxTytrZCticUVmYTFmaGFX?=
 =?utf-8?B?OGIrcEkxdXBGUWhsQXl0R0x4ZmUzbi9ieFRMMGJkR1BPblJLU2V3ZEFERkx2?=
 =?utf-8?B?Y2xJUVJpaFJueVVtZ1ZVeGQ2djA0OUwrMXVFVEp6dUNBNUxVYmRDeTlBaWxG?=
 =?utf-8?B?TThoS0toUFRiekZvbWY5Tjh5d2FwQ2c5c1Y3UXFRQy9qY0U4bElweHRCRnRD?=
 =?utf-8?B?ZkNXTDFxUlJibDdoWXQxbDZiWXhDV3d6bVZTdWFmQVVvenBDaHBuT0E1N0Nl?=
 =?utf-8?B?WVg3UzhqdkJlRzM0TjFqdUkzVklsZWFmUEVJMVVZUjcvaDh1OWRBY1FuVlYz?=
 =?utf-8?B?cjYyYzV6N3hjU0RIWGl0ak53Vmh6ZVlRb21kb1Z3bytnR0dkRDdGMFFROFZI?=
 =?utf-8?B?alVySTkvbFl0LzNvUE5aWWZLV3VFZnVrcWlXWmtHSXJaRCszQ3AxaW9ueDJp?=
 =?utf-8?B?bEdUQUVFaG1raUZSZzlkQWJnOGxVRTdSKzIwelFidXROczg0UiszRjBBeFdZ?=
 =?utf-8?B?OEVncnFuTURGWkNaKzFIWENHcHZueUJkMW1OMG9ZZ3BWZ2x4WDRKSC9PRFd5?=
 =?utf-8?B?MUsxQW9tZUFDNU5xbERJTmUveHJvMkxBTmkyenUrMkJqaU5yUjJZYzl6Q0U3?=
 =?utf-8?B?YmVhS3MyQnlCV1dha2xpYW9pVlV6YWRKNktOTU9tZnpHblNLVzQ5d0hXV2R1?=
 =?utf-8?B?cTZRQmo1OWx0eXhQREZmcTkwOHNnMU1XeTlvUjB3T09sdU1TN0c5c3R0OTN1?=
 =?utf-8?B?NWtLemdNV2gyVXhjT21OdkFRN0JoZTZnVUhjNU5hUGIrQ3dYNkxMY25yd0F2?=
 =?utf-8?B?UXNtRGxnVGZseWhjQ2VWYU5kWnNncHpmREc3d3IvMnU3ckE3MlM0Q2p5SVVD?=
 =?utf-8?B?NS9CcWY1Q2V1VmsvdnFyb08zQVZzSGFMVUo2SHBJNWRKSThQNk5QRFNkSEdB?=
 =?utf-8?B?dFJvZ0ZLczhFZ0ZJcGJhNzdZeGVvZGdKM090UVZXM0dCa2o4cG1uYTZudmNW?=
 =?utf-8?B?TGFDMzIrU0VpazNYUU4vTmJaVG1Ia0Zva0NkRmt4Z0kxdW4yNkM4ZHZuMmNk?=
 =?utf-8?B?Q3Rjd2NpWGE2bERSQUNKNGlVSmQ4K0FIbW1hZDdhK0srYWVKTERZd0FUa2kv?=
 =?utf-8?B?RmRrZHhLMG9XS1lvRTRGNHUvcWNQZlZsVnNId2p0UzlodU9IeDNVQ01wMXND?=
 =?utf-8?B?WGlEUDg4Q3dYRzR3TEprZURwN0U3ZXltRlFJOWFPeC9lYTZtZ3ZZSmI4RnFj?=
 =?utf-8?B?enV1THhrS2RqbW5PY0JraktYTmU5Mm1rZ09vRkxjVWhxWWRPWExJQjd1anpt?=
 =?utf-8?B?T2dqempYVGhsZ0p2VFBwTlNYQjBRZ1ZCeGR2d0txZkJBNnlPUVB4UVZBWnNm?=
 =?utf-8?B?bXY0b0xQZTBMcGlRdlFhWTZSZHFvWUlzY0EwVGhWMjl1Z3NKYm10ckF2cVpW?=
 =?utf-8?B?U09SdllGYVdvcktVMXV2dzk2bWx0Y0s0L212TEdoKysrek1hVk5xYzNvS0xS?=
 =?utf-8?B?TklOWnZRSGQzaGIzRVQ1ZElsbmNyRWxBeEVFUjltcWJVT0txOWpqN2l2Q3lK?=
 =?utf-8?B?MVI4OEY5bElDcy9MREtCM0x4KzloMDN0Y0NWeEx6aFJpd2VkUmY3MkFudFFS?=
 =?utf-8?B?S3F3allVSXR0MTNKbG5wMmx1Ylk0VUVSbmJwd05QTWpaaG5RZVlJSWtSaGtL?=
 =?utf-8?B?T1d1aFFQb3V1QWdQRERFK2tETWthYWxDMVRBdUd2V1BjVzZGNEs5Q3J0ckp1?=
 =?utf-8?B?T2VMWFJIRW8rb2d5ckhIYjZWTTdDUlhZUHZPUkQycFVPWHRHL0QyVFJyeHNS?=
 =?utf-8?B?OXp0Q2xOOXhJaEtIN2dUUTZVeno0QURLeVpyTmlXdEVtRE1sQitpR1hEcTRx?=
 =?utf-8?B?bWhYbmVySFpFOTRsYld6ZG8rMFBDQ0VuNmMzVU9vS1g4MlZxdDh5Tk9Sc0JX?=
 =?utf-8?B?S1RRZkkrMHhsVEpwWDBmWmFMMHdVSzE2UHFqSGtmbmlEOGFQWkU0Q0hPeEU0?=
 =?utf-8?B?N0I1blVpeHhUZHQ0NFFyVjZoUmdCOTVmN1BZN09sUCsrQ0NnTXVQSWhiUVlx?=
 =?utf-8?B?bmVwS0lQaGxsdlpLYzRqN0JNd3VkallJWnEzcWpEa2VjZzhBWFRLbmF2TVFj?=
 =?utf-8?B?bmgrTXQ3YkZHUUtJc1hrZ2huQVNnckZxUUlXSDhoQU5kZk5uZmR2VkF5cnNE?=
 =?utf-8?Q?zp3SaHLkyoKhulQc=3D?=
X-Exchange-RoutingPolicyChecked: edHM9pJKP/UpQE4SHOib0z+/f7VfStP5IGuLgWZJ+YWt2ZY/urbntR4dYOoz9rb4p2CH2Akw+uT8ZL308nsLjMeDP7S/hVe1l/M0+zX2XNslOi3WsjVJlqKy0ugltyRXoQbdU9igtIQMDlqI8wGmviuMLBuj/d7rCfjwwdqJn0PnhUNaUjdqTiK5jAUbdOPzPe6xLYKboWZPGVBpnBtZIV0eAKMnTnNL2424nFPblXtoJVluzWUp3gf+Hrh0bGDo28sSlIN4F7+r9xc4Jiv3h9vGsGi4OqsmfeddOt6GwcZSUvkq2gDdKg2hfzfniCRyqgftCYyhskEkdsqjwQodRQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e2eda23-0ebf-4c42-19fa-08df1669104a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 16:14:21.1262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hwzkrr1F+zJbbkhttjsxoC5graeSZnYThwTyBpGg9T03xWwqs3rHU8ld1oSVr2MUXBQeysA0l3c2HFYhqQVMhbwMGslSDV2QCbAXQo/o7mE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4526
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


On 9/16/2026 1:18 PM, Anatoly Burakov wrote:
> Use the new flow graph API and the common parsing framework to implement
> flow parser for tunnel filters: QinQ, VXLAN, NVGRE, MPLS, GTP, and L4.
>
> As a result of transitioning to more formalized validation, some
> checks have become more stringent:
>
> - VLAN TCI mask is now required to be fully masked (all-ones); previously
>    the mask was only checked for eth_proto and any non-zero vlan_tci mask
>    value was silently accepted
>
> In addition to using the new graph infrastructure, some of the checks were
> made more stringent and/or more correct. In particular:
>
> - old code did not check for whether fields other than ports are masked
>    (they are now rejected)
> - old code did not check for whether src/ports are fully masked (masks
>    other than full are now rejected)
> - old code used spec to decide which port to copy (as a result, it was not
>    possible to match port 0 - this is now allowed)
>
> Tunnel engine now also share a refcounted global state, and track all
> flows and do deduplication inside the engine.
>
> Signed-off-by: Anatoly Burakov<anatoly.burakov@intel.com>
> ---
<snip>
> +static int
> +i40e_tunnel_node_vlan_validate(const void *ctx __rte_unused, const struct rte_flow_item *item,
> +		struct rte_flow_error *error)
> +{
> +	const struct rte_flow_item_vlan *vlan_mask = item->mask;
> +
> +	/* matching eth proto not supported */
> +	if (vlan_mask->hdr.eth_proto) {
> +		return rte_flow_error_set(error, EINVAL,
> +				RTE_FLOW_ERROR_TYPE_ITEM, item,
> +				"Invalid VLAN mask");
> +	}
> +
> +	/* VLAN TCI must be fully masked */
> +	if (!CI_FIELD_IS_MASKED(&vlan_mask->hdr.vlan_tci)) {
isn't VLAN TCI optional?
> +		return rte_flow_error_set(error, EINVAL,
> +				RTE_FLOW_ERROR_TYPE_ITEM, item,
> +				"Invalid VLAN mask");
> +	}
> +
> +	return 0;
> +}
> +
<snip>
> +static int
> +i40e_tunnel_node_tcp_process(void *ctx, const struct rte_flow_item *item,
> +		struct rte_flow_error *error __rte_unused)
> +{
> +	struct i40e_tunnel_ctx *tunnel_ctx = ctx;
> +	struct i40e_tunnel_filter_conf *tunnel_filter = &tunnel_ctx->filter;
> +	const struct rte_flow_item_tcp *tcp_spec = item->spec;
> +	const struct rte_flow_item_tcp *tcp_mask = item->mask;
> +
> +	if (tcp_mask->hdr.src_port) {
> +		tunnel_filter->l4_port_type = I40E_L4_PORT_TYPE_SRC;
> +		tunnel_filter->tenant_id = rte_be_to_cpu_32(tcp_spec->hdr.src_port);
nit: just as a thought for future improvement: here and for some other 
protocols, use rte_be_to_cpu_16 instead of _32 and fix 
i40e_tunnel_filter_convert_conf?
> +	} else if (tcp_mask->hdr.dst_port) {
> +		tunnel_filter->l4_port_type = I40E_L4_PORT_TYPE_DST;
> +		tunnel_filter->tenant_id = rte_be_to_cpu_32(tcp_spec->hdr.dst_port);
> +	}
> +	tunnel_filter->tunnel_type = I40E_CLOUD_TYPE_TCP;
> +
> +	return 0;
> +}
> +
<snip>

-- 
Regards,
Vladimir

