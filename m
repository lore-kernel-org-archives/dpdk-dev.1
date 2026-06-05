Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA61CD6E74
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 13:07:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58F20402BA;
	Fri,  5 Jun 2026 15:07:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 6BF444026A
 for <dev@dpdk.org>; Fri,  5 Jun 2026 15:07:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780664843; x=1812200843;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=S7+vtyXN5W+0aw2aGlYVDb3hWPWWIYrNF2fxJc2ee7Q=;
 b=jiGG/s7ysdTYYZ+nw5NadNshIPITAxbeZa4Wu1+0Mo+dwNrHqh4s9dPa
 WyuGOBkttyG+J4NcvX2L6ulWH7+YVhikaxWqDeqX8yE/LFXmBFUr7hH3S
 5HsdAfjR+D3TFuhLBUrLPX0Pc8sCFK1CHR8vHsKZhsq4zZj5LYa1U0Ox8
 yyL6EkHNUUCCxpNTVmV87CPFwUJhQF8hjBXLRlJxcQysS4xXWUD/qfXpp
 uLmWsoY77FsIAaE4i7zMbwSZm6KqeNnjXYFcfF6tAMmKHKnhEv4b1fXW6
 PVgJEJgqteF2TYuTx6IOSPc356d3kIq9SP5ZJ8WZbXs39ykfhAHEqv0xX Q==;
X-CSE-ConnectionGUID: jjV4uMnTQVOQn2Ni1KA6iA==
X-CSE-MsgGUID: wz4FVex6Sb6biRbXUEaa/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81404931"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="81404931"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 06:07:22 -0700
X-CSE-ConnectionGUID: nWWYRjQ0RtyhBUmeqa+9+A==
X-CSE-MsgGUID: FseYAPPVTyeHxU5FGBOC7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="243747678"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 06:07:21 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 06:07:21 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 5 Jun 2026 06:07:21 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.22) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 06:07:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wT3/M49GKHaTAQPoNVyZujfvfFSuLYi9KAzRylC30vBCLEHW0XYF6bFtSxj346WDqmzXtANbPU4HYWwfmrjQ2i2QaAdDTTrP8E7JvXOIbO9n+FOxZ6XoPS39XRWV85I8oVVRMS+P2B/2ttTPAgqlniocjWWtr/6LBXipMPow8fHOeqSvwp2ignsnIATXY8a0iNibXC3BJgVPYI/Gm/MifTRmK6Et7jItV7/SrKpVxIUBVo+Fbkb+4TrPZn7GbmtU3JBq8vMb8iY7AyAdjkhsaBAoFWAWiDaMH71BjcVgc/c6BjZ3Xcj6Bfipu85bvH3ypEa2JhH7GwgBHz1VB7HRrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bw5FA0LL6H7HRLSgybIhl8dbQLUpZSemWoT/OMZN8sU=;
 b=lRR7u746RSC6BaGY1Xt5+fzkh2PzZT6lehloKpEFRrzA7n06AbjkD52zfaGlJoryEp9dGMtzvG3IjwnKggtZI7YxCso26ARYdsKwhrQPa4NbgoWUsIE8SokBUhxG89voz0EdqxQoxG4ho415eGSvInIgxMzE+jcYtEegOkCp30HJqoUOJtXDdV/Y7xvyrDraHmXgZC2n06FjVev9BnlI3svIjc424DCndm1Awm/sGCrIK7E1qj0Eni3DaCN2ofPZAalMy4aV8g6TkbmlGg8cp+NsljRJgLFnYrZinxOYaVZOOeWRFTgaVnzZzPQGECVysuB33Kb2BFfs7IqVSL01zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by DSVPR11MB9743.namprd11.prod.outlook.com (2603:10b6:8:34d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 13:07:18 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 13:07:15 +0000
Message-ID: <c6c8f711-7efc-4276-8bb9-9b3cf7948906@intel.com>
Date: Fri, 5 Jun 2026 14:07:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fib: fix name of main TRIE instance memory region
To: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, <dev@dpdk.org>
References: <20260316130531.1671904-1-andrew.rybchenko@oktetlabs.ru>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20260316130531.1671904-1-andrew.rybchenko@oktetlabs.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0156.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::11) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|DSVPR11MB9743:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ab29aa0-1c6b-4b43-93c6-08dec3035c43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: +F3/092jL3cUAKtZ3mQbncSl1/zKultp6m8HKTYZf5mOuiW3r42B+SP55bYf3l/SGPnFrFD0rRyJdAtL4XzqRiQe67ksWCsy/DgDB8rGDk6EyaiRpvWeW1F0jqVt4s+9/f2zbDr1QIRg8vEVAlX1VcPsxKWPerkv8X6YLK/Ba1bhPaUM8ORaf/BzUIdfpQg3prjvuf43EraN3HiAwfKIUH0ytB9YdaMFIyyOlT4SzuJoIapI3pn6KPeS6vBd0im4tKuO3ENTtV0uAK3Ldp3Q6i47kCpUJxF8CxZ2lbdT1erNNr2Yih9jEpPLLbOlwVstBV4/qQv+T7oWxSgU2BYrP5Uf+ip5Z8iGWolLSwo2ONpAHwqwKBMrMtcP7CrImaBakx/zeNYEhX7ITW6VvbHmZJOyo+ss3Yf1itwqpuTAs1JA71M1rr+VRbb2KQudtZGh+8cqJc+e/gOK8U+fGbbueOVA0LXxPaSlBfh1cNj1oTZnGJC5o8o5iy+wiEsZbNWHA09lQR4hB54/6yUPgBMTo60j72tM1n9qpbwma9GRR9qzPbC6jZPHtM9fT1c6fsfQxUid6zRyOPiNnKptONAWLoKG/GRtGHniCcMqgbdWjB1lI4KWdR431FdAeRa0v61vKxg2r5KrmCDXnB2q2PqM01E3T49VCoDVabPtupQeLaLmMG3oZ/zD9snvBntdtWzJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE0yWjRzeit3QnFrTERuWm4wYWFyb1R5cmlrdHVNVjRKSE8rUjJBWWlzbURh?=
 =?utf-8?B?RmZFSTlSZ2xKTzBwclp3VmVZNFNXb0FYa0xVajc3VkRkYmorc2xWYWN1SXRm?=
 =?utf-8?B?ZEkzTU40eElYU0U4NUdNeXM3N00zanhXTkZuNEhqVFRCK2o0NzlLWkVTVTRG?=
 =?utf-8?B?clhMK09VTWJVeWVvS1VpVFNKd1UzbUJPQkpHRVZ3anlGTkVaam1ZcFcvTlAx?=
 =?utf-8?B?NHRQNEw4UWFkTUhBcHB5RU5aeTBFRWxOVDZVREpWY3p5KzgrdlpPWHArNVpq?=
 =?utf-8?B?ajlmc2UxcUdjbGNOdFJTeXFRQTZhTmhCQ2hmRnNRalhQc1pvdFBuM3pzZ0lX?=
 =?utf-8?B?cENJVDdiSnVqekhBY2FDQzlNcm5rbHYvc1dJN0d4K1FKUll2dFJlTzE2ckIw?=
 =?utf-8?B?cWMrQkl3cXJMc2RlaVVWMjZ5RUNueVY1MDBmY2xvOEp0Y2lyOFBWTkNvWWM3?=
 =?utf-8?B?cTNQa1B3MUZ1QWpXNGxMTG9odUZNbCs0OGY3NEpiRld6RHBjdnd5THYvTDdI?=
 =?utf-8?B?WTdDaXNWYy9nek9DSDY5b1I0SFJaeUlYQkgrc2VCM1VCcDJ6SnFobTlmbGJW?=
 =?utf-8?B?RjUxTjFWYkd3UUwzNUh0TXB4UDAybnFoMDdnVjZzZ3F0OVVSeGhFRkIzK1dB?=
 =?utf-8?B?ck9MNVB0bVN6clJpNlVZaWpRK0xtcFJWRk1mUysrUGhuQXN0cjVqcGdZRVVp?=
 =?utf-8?B?cEpRb3JGbTQwMjg1cGl4TWVESFNVK1ZGc0RodTF2SHV3QTJBWFZQNUcveUhI?=
 =?utf-8?B?VnZqUE5oeGRZSE5Rd3JjUitPYzlSMytHNHBQbmlpWk1Vdk9LUDZZS3MrbnpP?=
 =?utf-8?B?T1JUSVRwaGlqTXQvZG9DaVZmd2g4L3hOckYxZDRnVzB4dW01a3Jockx5SnRn?=
 =?utf-8?B?cFFrMGN3alh2VFd4NzhJSWxkbklsZTIvMFg4b3FIVGZmWDFnRGVsV0lSUmVR?=
 =?utf-8?B?c1hReXNuelo5OVhPM0NqWkNrTTZrUEtseXorTmZFckd0Y0p6TTF3Zm1QYkto?=
 =?utf-8?B?UXNyV0FFakx6cUE0SnNZbm9DYzNVemVBTHY5VUtPb3VXZENQSkFRSkYwNFNH?=
 =?utf-8?B?TGxUK0hBTGF3QjRhcHB5cnM2bkprZVcwdDBydVZ4YzlseWFncU1mMGczVGRD?=
 =?utf-8?B?cnVqNFNhc25Cc2IyZjFpM2RtdlArdjM1NFNvRzg1ZjlNWjJLemRBdUs4N2Ni?=
 =?utf-8?B?NVc1dWF3ejU1SHFmdkZJOVZxSDVZTFlFK2R0cHhxYzFtaHhYdmRMbWN5NkMx?=
 =?utf-8?B?eG5PYUkrTmxhYWFrTDRkUUdISmJzRkEwcmltMUpZcDRJMVk2OXR6WjhhWFBX?=
 =?utf-8?B?ZEsyeWh6dmVrUUU3UkU2MElqSTd5THJWYW1WdTJRTjFxWHpsajlOeURZTEFQ?=
 =?utf-8?B?K3VBeUxNY0tTL01EWUxmSis2VU9DbzZ3VWRQZEJhOERZQlBJaFhJY3FxZHhx?=
 =?utf-8?B?RmRWVkwva0c5OTZVNzVSRVZIOTM0TlpoNUlUOVUrUlNPc1RvajQxQW01WW1V?=
 =?utf-8?B?amVSYWJSNTJ0Wk1FWTZvTHIvdlVrOXQzQW9pd0s0Zmt4SjFlVVpzMWxjRnFC?=
 =?utf-8?B?eThyUUZsNThubm9MMFpNdUxrR2Zza3R5RE1Ydm55RjlzTisvYzdIOFI0V3Z3?=
 =?utf-8?B?ZWsybFdyOUxlekpERC9icnFFcTZVMk1VVVduRGlNVUVtVEQ2dXNHRFI4WkRq?=
 =?utf-8?B?cGxOaHNqN2VUWU1sYWlta1QzcnljOEQvSXBsYVhqK1pQMVRubW93SElTb0tz?=
 =?utf-8?B?bk5tZnJDeHBHU3RHOHp4b2NGWW5DU2tZeTBEZGZWY09NVUZNRFRsSHFEd3FO?=
 =?utf-8?B?ay8wUTFiMVUyOEozeGdSb2lVVGJwTmNSR3ZPZ0lkdjFsNHBkcGlueTA0ZlYz?=
 =?utf-8?B?R0tsaUpOTm56UlBSM0FsNEdKUnBTbXdUbVFiS0l0MEpFWnZSVy81QzMyOGxH?=
 =?utf-8?B?dDdtdlpzbGxlVGVKRzhGSEltQTY3R3hMckpJajdHb0RhVUovcGxid1hJb3lw?=
 =?utf-8?B?M3pRQjRrQWhRSG9rUGRoNWFtTXN5ZkR0UkR5cEVmOWtpOVBLMUYzNTNwOTlK?=
 =?utf-8?B?aVBQNEhCV3J4VWp3TXRKTFg3Z3FXMVV0V2wzeWZHbmtxUnoxT3lkTFU5bGRz?=
 =?utf-8?B?Y01TV1Q0OFBLM1g1MXNZZzVOdHBvd3hVeEpzZ3E5RDR4bWduczdxVlB2ZXJs?=
 =?utf-8?B?QllpQ3B5MGZRVm5ITFNkRytPYldTSEFybkhVWXQzRFFENzNJTnBMUmZONjdl?=
 =?utf-8?B?YXRZVjJhdEEvaWVqODUzQnhnbWVFWE80bEVGNGFoWjlPcDdVT1NNR3VHNlhS?=
 =?utf-8?B?WW8xZ2FRUkNUb29NM1ZXam02aHRJWkNQZytDeFB2OWRKWk9Pdi9NTnJNcmU2?=
 =?utf-8?Q?vs5BQ16PZejmiH/8=3D?=
X-Exchange-RoutingPolicyChecked: EeQsBwQVFSJnqrfbQuk2Mn7azX3eZJfWs0nPK6pu2jzLiu58YZXvF0UrMv87G+HD+CrFkiIhEXaqMHJpLaH8wo3cQiJK7ZI+XhKJedxK07IbAF4Z358+NS4LxYgRSm4sA+cQa3tKcHZMV4OPg/HHxKSf7uiDLrx8F61hVZaI0k7DHwbpOkkuSjW1vXUK2gnMs+kMXpMLntiZBRQFZPj4nvCsjUhSNseeG2E6ITLRIV3lG55qNa7KdrkTPZ+zBYDcShHn9fhYIhS8jJPYOLAylbqbIaxPKsD3LD/sdzmDG+wI5Sp9hXpI9dstXTs1AMHBky6mFD3paF22KS18eqBnOg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab29aa0-1c6b-4b43-93c6-08dec3035c43
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 13:07:15.6732 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GL7VaYP5210A7QzPxAIsLuIY1QLd5GblqNODTUwnJKB/OLkdk0Zant0Cu33JDQqFiSLUYvfzcIm5QSUfpgVr/FZkLx00mR+K0BgU0eEpIS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB9743
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

On 3/16/2026 1:05 PM, Andrew Rybchenko wrote:
> mem_name was built, but not used when memory is allocated.
>
> Fixes: c3e12e0f0354 ("fib: add dataplane algorithm for IPv6")
> Signed-off-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
> ---
>   lib/fib/trie.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/fib/trie.c b/lib/fib/trie.c
> index fa5d9ec6b0..cd61446dd3 100644
> --- a/lib/fib/trie.c
> +++ b/lib/fib/trie.c
> @@ -678,7 +678,7 @@ trie_create(const char *name, int socket_id,
>   	num_tbl8 = conf->trie.num_tbl8;
>   
>   	snprintf(mem_name, sizeof(mem_name), "DP_%s", name);
> -	dp = rte_zmalloc_socket(name, sizeof(struct rte_trie_tbl) +
> +	dp = rte_zmalloc_socket(mem_name, sizeof(struct rte_trie_tbl) +
>   		TRIE_TBL24_NUM_ENT * (1 << nh_sz) + sizeof(uint32_t),
>   		RTE_CACHE_LINE_SIZE, socket_id);
>   	if (dp == NULL) {

-- 
Regards,
Vladimir

