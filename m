Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D1B606A31D
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 09:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=X+GUDw6M
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C455402CE;
	Wed, 21 Oct 2026 11:55:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 00AA040041
 for <dev@dpdk.org>; Wed, 21 Oct 2026 11:55:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792576543; x=1824112543;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HmWo7gb8psbcZsH92o4LSsHgqC5mK84XhXC06tfSgMk=;
 b=X+GUDw6MV7AxYXZ0RTUHfnpp5V1a0spP4fSlUub5WQCR+Cr71qjSWKZ2
 LG/PDuScX2X2BkRSQi0PZlfjF+2rmBY78wpU272lFIgnhPO72/F8XsIAz
 CjPNOI9gKxuq0AugQR0BfWus8YMU+aLzUM+xRs8mxbu5GDOsYERQxwFy6
 GRet84qwUxwq/a/lar/pqVVhH/IkssjcRu30pUYuKC09WhbfgKqZlNBW8
 cf+na9SWgD1b5Q8+PtD1wBPxnWXWXzFuPvrbhm0v/Y3UMgi0C/3U1HDUS
 KLhlcN+nUqo0ZhkaFvhknxFnxKAFCn7uiZBX0gCB9ViEzPjJ/2hEUjZqX g==;
X-CSE-ConnectionGUID: 0OFgsszZTl2z96MyxebjTQ==
X-CSE-MsgGUID: stVg0WXFTWW/ptTj1X0y2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1184829"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1184829"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 02:55:42 -0700
X-CSE-ConnectionGUID: AT7+3Jo7QRCsXO/h2nG86g==
X-CSE-MsgGUID: Y0wB4KzhTCqXE1vUQj1XFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3370584"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 02:55:42 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 02:55:41 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 02:55:41 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.70) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 02:55:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hwBdkQR6clEZIOTc1yLLcm86SUIWTY5iaJycBkzvFwus4lbPCxjDGlGGOx5jKAvw2pCIrfLdoSoZpYb8mXzZnRlPARIv0WM3nMWjSVrrmTuN+2rNT5Hj5mfri1DCv+ZrDNbSNlZ5pE87x/SQC2RcXa5w+0Q1KeFVPSuvJhGK8mGaxZ/RxBwf8pDJf67ln1eQISwwDdWvWMv+Xc7Wd8pBGqsj/7JMxpL2Pa52VZb20um6omV3LeZXlhTvQqHm+HtSQnLPUBmURGd9vn+PEuQGzX6jD51pFj9yMeFAPEvOf03AODNH5dXXriMO86MQWRsrFzSmF3AqftC62nbimo9R9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMitYKlkQKCAR51Stps+p1eH1wzEgn0wA8qh1Z4h3Ts=;
 b=H2IkTtMPC7XoE1pWTYuuHG/PWfB/5u6mtec9+yTe1vLuXlHcE1mQY+pBcV7KuNdavvORsrcYbuzalQTNdUGrDhYu9HCOi3WVPahJf4u5mL6fCe2Pc6M7nGEPAKROOGd1a42Pyu7YAo0ouRW/hK+wzxTmHQYElUq/n1bx45G3JnQYeTUR7to/xsJiWRaR8yPy5/vOXDN5frIaQ2n1qFOy+SoZwrp8OdrVrSG0EMzgWkqjw8/jQgrFsjcOBWua8q9EtFFjxDMlIWBZrMVv/AbW/8Z5KlGN1MLkIJtgQvDLm5hb4j3CdmsOC05KK5Q6Bldb9tPw2Ya6Eq14hUvo/P8Cvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 CH3PR11MB7796.namprd11.prod.outlook.com (2603:10b6:610:121::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 09:55:39 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 09:55:39 +0000
Message-ID: <3c6bee19-388a-4c8f-8918-40b8afed4e5e@intel.com>
Date: Wed, 21 Oct 2026 11:55:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/6] net/ice: use caller-owned pattern match storage
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>
References: <cover.1792498154.git.anatoly.burakov@intel.com>
 <c28b60359f98c25af67e95d90d1f17d55d90309e.1792498154.git.anatoly.burakov@intel.com>
 <atiFJHpIIhwH_AHh@bricha3-mobl1.ger.corp.intel.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <atiFJHpIIhwH_AHh@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0057.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::6) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|CH3PR11MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: 52198558-de16-4a22-8395-08df2f5975fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|18002099003|22082099003|11063799006|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: EHkEFqdXINUErS44KjZ3TGrbM4PCyj4P1QQ7EHQIufNLFKtkfUftyfY2Kopjb4G/kITyDP10v2MSo7zy/iI+5hBQ3V8FpQBDPJHHtxmdn2LuMPiN0mw0+OkbYzw4ZbhA3YgtFEO0msNwwQWwZ01PGCsAVwwEQG7kNS6JBBkduIFL1WHwsq/JHWPHSngqjdy7b+I98hPgf42Y9clEwtZG0aGajrWrzOLvU/zqrjqwHiIOmuXysT2Ne2HQY16M2b6Kp/po5yYkMgQCP/PXWqvc2RS3PiAVpI+bkjZQtmnvzAXvh3qTh+fe6zb8NDfTGUZTdNaRVpAlRU+vQqkOyZpVIEHgjlQOoxaWfohN0QhFEpX+2OpYjPy4iGUMbESKuloZvDK+j/uuVcYWvz4vAhKfJ4MSQsV2xfP3WLTDH+iW+8JqgU1sLBC9cef3ujACxFdWeTvAWaD+vnuF0bVH4XfWkOoE9qe6HWB+V7yfzDPdsk5cOW1AYQGr2grLQGFx+wAr4MnzRnqh3K3rxIGgBigyBqTpZMPcqDzA5lDJKThgsZ6nAZOXg73qB1/Mu4FWa1u2ZEPEtOAGokSgnh4zt1hj7ALb4Zbhbp5f3cE+dvrwOamnZRgusHk4VymI9J5tojglBAHB2zG1dj/3N6CGvy7acGmoUoXxY7gsCXJV82Xk9+M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(18002099003)(22082099003)(11063799006)(261009223027099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dk1hYUdyYXpYVnJXOVc1a0k5aE9xWWFHOHF5ckJXQVNzVnFTbFRyTEx4YzQ5?=
 =?utf-8?B?cXJwbU9ycmFXZU93bVB6U01ZZ0Zrc29ydFgwVWJBWlhuNXh2OXJiY2l1cjFL?=
 =?utf-8?B?YW11bFl0N2Jva2ovQjh4UlRoNG9IT3FYQTd6SGtLM2dGcXM1WUEzUFFBV283?=
 =?utf-8?B?U3ZXTDdNaXNyUEdrME90dWxEVmUvNWdRNDdHbUNzUVMrQmo3YTFYOUJVYkF4?=
 =?utf-8?B?K1gxZnhPVFIwd0dXWDR5cGhHL1lHa0wraWZmTXVuNVdVNWJ2SUxWRmhVUndT?=
 =?utf-8?B?ME5SMmt6WmU4MDh3dU9EOFRrTHZiWTl2dklmUFdpbWh0d2ljU2R2ZHNzSUZr?=
 =?utf-8?B?TlEvY0tKdzBzKy9hTlZGYnhFQm5LV21rZURJRzJ1anRYeU1iOWp1ak04cW1s?=
 =?utf-8?B?NUVIYmUzR2NSK1BXaUFEeCtBd0RXekFZdmY0ekhUTEp3bm4rSHprTk8xdHRm?=
 =?utf-8?B?WGdNZm5RWW1LMTdaTHF1M1FrcEQvSlpOUEljSUZzamp4OWNnWUlJdm13UHY0?=
 =?utf-8?B?QXRLTmxydzJKVDF0ajQyaTd3OWVYZ0swVm9tS0crd0ppUUQzSUkrVmNYQjJU?=
 =?utf-8?B?Ykd5U1hCa2J1Zjh6NXR6YUM4SGh2ck9rL2pyQWNKVDJaWmM0cWZaUEU1M3p2?=
 =?utf-8?B?T3dTTm1DYzZydzdpYkhQNklLN29GaSs1cnNydDNvZ1p3YlZPS1luQUsyenov?=
 =?utf-8?B?MnNaUlhtME94QWpObEVuSjdGTHBIejhVZy9sS1djT2F6QzltY05qRjRqaEtp?=
 =?utf-8?B?ajArSjAyUTNpYnRtQ3U4ZzZjWG85Nmx4QWMyK01VbGQ5MzJIY2pLbDM1YVlF?=
 =?utf-8?B?VzdLemlRdE9BNktYb29Pa2tzNzZLOHV6M3QrbE1ZZGtLSEMrODRielk1aGNY?=
 =?utf-8?B?U0NKTTMwRmNnT0RRZkRvc3kvMm1qWEptT0dSbXFneUpuYVVpTFUwZlpqa3FZ?=
 =?utf-8?B?NnJFUjAxYjlJSUV6eVQ3UkdYNWkxOWo2TVRPZ3lIckNjM1MvRVpnc0RKd0la?=
 =?utf-8?B?cWRGWm1ZQVMwcjM5S29GdmhhTjI2dEZkd1R6NTRKZHdiOWswcldhMW8wbDN0?=
 =?utf-8?B?S3doUWREYlNiRjk5dlNJT2ZUTjlOM2Fwa2pMV3JJZko1QzRhV2cyN2N5azRz?=
 =?utf-8?B?emRUaGV4RFNTQSt5b3pzWmttOFhNbElSY2R1U05JWE01dmdWMG5ySTdwVVY2?=
 =?utf-8?B?YU1wK3RPdTFINzF6KzRlMVp5bWo4dFFjalhXL1o2WGZrZnAwYUhRaG4wcTlp?=
 =?utf-8?B?SjFVRTRCbXlBempjT0lKSUhybXErNE5KUG9MdzVIZGxtdkVwT3pjeXQvUkQx?=
 =?utf-8?B?WVJVN0xMWDhNV1VITUJWU1pUa1duQ2ZhRHkzY284R2JKNjBvTUxQdnFwd1pl?=
 =?utf-8?B?TjNBdFlxSTBBYjllU3FlL09xQjR4VW1SU2JlMFNzYTJsSDhicGNVU0hUQW91?=
 =?utf-8?B?RE1DMkxMS09aa3R4Zkdqbm1CQVlRc1NmamFhRzJDM3o2RGMydnZWZnBPZU94?=
 =?utf-8?B?Nkd6SXNFTURQYk1TZXBuZkxTbFNSNjhpTFVybEs3T2pKcTR2TzY4WVg3QjBw?=
 =?utf-8?B?QzVaM1V4bm80N3hFTTBvMFBZZVhrclJkeVhrUGs4azFkUTVLYzlDVkZib1cv?=
 =?utf-8?B?MWIrU1JPTGoyWVN5MWdDMHQ0UHJtS2ticldzTzREallGSjYzVktyazN6d1NH?=
 =?utf-8?B?NlcrV3VFdkV4ZzBuOHZkcTJMckRyU1ppUVJ3dndORXBFS2dnUzlFZHpQcGpR?=
 =?utf-8?B?anhPNWdNQkNjenk2ZUFtUEY5TUVMNG03RzBsUjRqWjRudy9Ib1drNEorVnBT?=
 =?utf-8?B?OHVCSW5vZ3N0cE4yQ3ZYWmRyK3hteVRrSVpIU0M2bGI3QmdpRjhBSnR0SzdX?=
 =?utf-8?B?VVJLZFg2eVpLZ0hWTFZIa04rdjQ5Zms2bkZYMHdQQlpWQkMyVTB4ckpzZUJY?=
 =?utf-8?B?N2FwYnBGazcwREhNTFRLS3UrZkhaMUtqRVQxL2ZnVFhvUnJITjdhU1lBa0sv?=
 =?utf-8?B?c3hDNnZtQUNHbTE3YU8zeVRRd05mSHNwV3dJclFMWSs5bTBqd1RnTTlvYTIz?=
 =?utf-8?B?QVoyTmYyV3g0SkNld1MzSzhyT1NsUGErQXpudVNMN2xXWjlQYkRTRHhhakxi?=
 =?utf-8?B?UlZ5bDZ6KzZTcnNhUUNkZzVGeXE2dVNFSTBQa045cms5amt6S3JETUUzbHVo?=
 =?utf-8?B?M3J3czhoRFhadHFyS05oRSsvVUJ0UysxOVhzdjhoOEtHcG1hMWVkOXpXcEFv?=
 =?utf-8?B?RGpYeSszY0VzM01sNlp5QUVwRi8yWkZzUy82ZEVoMzJWZWRPNVpCZTlMb2RO?=
 =?utf-8?B?Rjh4UlAyTnVwcStIM21WcjhRdlN6V2hGdU5mWEd3cUdJOHBiZW5LS2Y3L0J1?=
 =?utf-8?Q?NfDX1WhOF0Y6UyZg=3D?=
X-Exchange-RoutingPolicyChecked: QWfu8IrHtno8Jx9dE6+SrlJ8BRcbgSU+am9Emwr+xK/AZWVkT9I80lzx+9VPQ95fezyw60msqmn1ehGEeHQvWrMUKaqmijA38oQ18u2i/tvMY4eMtCPvx+YiiM8VG0jASwhW4otZ1Q24uoC9BFDziFn/Xm+Yf/H+BgOy5+aMiPXfETp4iQTPLfH6e74YdcvEkC8TncwpTSMazfENVzLRrR5cMfngtX8IGl2m9uEbRUy5Gl8IY5S8iXug4QRGzLfAZWi0SjUXIpBN8R51VSpQVpTUYhhPf2EPmLQMVIu8f+hue9zAGPY1u2taXimrgIr3BYA5fJXALvF/aTwa65oeCw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 52198558-de16-4a22-8395-08df2f5975fe
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 09:55:38.9542 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xzoXx1c5bYJbIClKqSrl2CtI60y9K+jnOE1Q/Jvrc4DZVpsnQmLfrrrL5dOB2QPeUi6IZNF+raSf6turVwmDGLzh4JP1OSBLXNgquxjCO7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7796
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/21/2026 11:25 AM, Bruce Richardson wrote:
> On Tue, Oct 20, 2026 at 01:11:08PM +0100, Anatoly Burakov wrote:
>> Pattern lookup allocates a match item just to copy an entry from the
>> engine's supported-pattern table. Each engine must then free this
>> temporary object after parsing.
>>
>> Make `ice_search_pattern_match_item()` fill caller-provided storage
>> and return a status code. Use stack-local match items in all four
>> engines, removing the allocation and corresponding cleanup paths.
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> I'm sure there are still plenty more cleanups that can be done converting
> dynamic to stack storage. Even a quick review of this change shows that the
> "rss_meta_ptr" value in ice_hash_parse_pattern_action can be just put on
> stack to simplify the code.

If you mean allocate the meta on the stack, that particular fix wouldn't 
pan out because of the way engines manage memory (basically, 
rss_meta_ptr is the one that has to persist, so it has to be allocated 
on the heap). If you mean allocate the meta on the stack *in the 
caller*, that would work but require some re-plumbing because we'd need 
a union of all possible metadatas to pass into the parse function. So, 
doable, but a bit more work than just putting things on the stack.

This suggestion is also nullified by patch 6, because it makes it so 
that the final flow object is allocated by the parse function, so 
there's no more "metadata" passing between pattern matcher and the 
engine - the heap-allocated object is the one we store in the flow list.

However, you're right that there's plenty of things we could've done 
differently when it comes to memory management, and future work porting 
ice to flow_engine framework will fix all of these issues in flow our 
API (and will get rid of the nested allocations that are still kept in 
patch 6).

>> ---
>>   drivers/net/intel/ice/ice_acl_filter.c    | 22 ++++++++------------
>>   drivers/net/intel/ice/ice_fdir_filter.c   | 18 ++++++++--------
>>   drivers/net/intel/ice/ice_generic_flow.c  | 25 +++++------------------
>>   drivers/net/intel/ice/ice_generic_flow.h  |  3 ++-
>>   drivers/net/intel/ice/ice_hash.c          | 13 +++++-------
>>   drivers/net/intel/ice/ice_switch_filter.c | 14 +++++--------
>>   6 files changed, 34 insertions(+), 61 deletions(-)
>>


-- 
Thanks,
Anatoly
