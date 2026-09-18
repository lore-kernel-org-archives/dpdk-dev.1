Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9891AC982D7
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 09:21:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA0E54027C;
	Fri, 18 Sep 2026 11:21:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 6360B40276
 for <dev@dpdk.org>; Fri, 18 Sep 2026 11:21:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789723267; x=1821259267;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uQQ3diMeKMEh/cyfyVEJkpi7h96gYiH/L8EFVO0PmZY=;
 b=dTBjWhwh6+Vgp5FaahbdWdUvuTmMuoGmcmlqqOpOZtq0DHgTCRDw12X0
 ZrqkWJYkERV/jYvLw3ONiaixafYodWg4VpD6mk/cOcq6TVFirIm+Pu7sl
 41koQy3nrm1F7LkGS8c6Ze4XSCcCpl4roioh4KaPmhhN7trsSNvBmenUq
 uhVAhviEpGu2ixobhPbhq1Uebloqnj2igAhkdYMXEas4FRCwQSvwKxqKT
 r01lVvFqJXgn50qemx/C2d3a7FrYkdqLKAgsnNUKRx+nog8NwjmFgAlxM
 YwNAI+A84es8QqpE0I/Ix7M2hnsfPCH2/yzMtjsZQzC3IKyuqtWr4DxP3 g==;
X-CSE-ConnectionGUID: ++1YyOs+TKui5MEZHnLZiA==
X-CSE-MsgGUID: 1IGnAgqVSlWXvRY55lyHhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89352839"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89352839"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 02:21:05 -0700
X-CSE-ConnectionGUID: unD5pdylRIWYzL+mpZa95Q==
X-CSE-MsgGUID: d6lnuKv3T1ymVgC4P7D/DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="276277628"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 02:21:05 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 02:21:04 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 02:21:04 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.67) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 02:21:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GI2IE/DVmVNV0r18oVvfZ4bDVrZIROA9uDNBtjOrZKWoKifBj/rVAJ1zn5hT2g/VI4icv0QtplQSkVjZovxD6dWP4TsKW+EihBzjp/D6THWTldmLqKMes3IrWeIwuKSbqR812BzRjcLGEc0GH8F/usHQlP9OW6uW7SNnLnpcYeTjP8FLptHkfQUn1fXYQ0vUcQh5+YIu1mw2OOP7QWTRkNEXIsLszZSaGJAPXEB57WMakJCc90rwERiHaJtj2KL478ZJmA1Jsz/vzTUSuOEeSEKEg2S0WXqx8I+BbWc9+2kbdbk8OZUFBwhyKQSpWFOdvu6rzWLoSMe+ReaQcSpQXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15f5m+uUy9vA6vsB2gYPVGnnkEA61itpy4xGuAop0Pk=;
 b=S3iezB9+5+b+kzMWJ7RraRTxF0aZvmBA7A8P6rV/y9/jybpei1Ac6Bz2n8QzM5iFCpmRFQCr8D85SGPRKDMBIP8Bl84HzQPqPTPpRM9fT/qBgxHrB/RH5blmsm+gqM7EPcAWk9aqkNKiVc2bCIg5Qkoxuxa/wG9nIfFk4kzY1aBBoclkIxNezJfzgTSNNwx+9gQ1PIXgyi1RmIM13wJ6Ue/bYByAUA1vYi+VsjMWL+XMlgYiuTm3iIpeTSH97rvbZzX9ytbjqGD1gLoIqjlE9RxzAFXQ6UhbmD2/4DJ7E/L4XdBmdkVzdexkcdy11EYDb2fqhMj9j2scDbJOdgJLVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH0PR11MB5159.namprd11.prod.outlook.com (2603:10b6:510:3c::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.12; Fri, 18 Sep 2026 09:20:55 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 09:20:55 +0000
Message-ID: <a584b2c1-0256-492d-80d5-8169b770cd29@intel.com>
Date: Fri, 18 Sep 2026 11:20:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/19] net/intel/common: add utility functions
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Bruce Richardson <bruce.richardson@intel.com>
References: <cover.1789560943.git.anatoly.burakov@intel.com>
 <6f960051c1dbc0c9361ceec0d7a060398131f559.1789560945.git.anatoly.burakov@intel.com>
 <20260916173029.462e7fc2@phoenix.local>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20260916173029.462e7fc2@phoenix.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0386.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::13) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH0PR11MB5159:EE_
X-MS-Office365-Filtering-Correlation-Id: da985ee3-78cb-4171-e964-08df15662485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: kryGBwFxASoIG7QUJAzdEoSuiLpGesFD3NnZJxTKOQaJvK0xIzfllgLxznpemgVa3dUGynZRk2D6hikaYFl+ePLo/ulLhLByJqLaOF8Fe+BZVEuHSTPWaOFW8T4eEU5hzA5SeCLM27N+TZkk/VSa+Mup3oiwmbjuQO3STmdsr06KiqJxjMLQJUY0ngA3TJCLTFZkq8nRK9rKM/QI0Zyw7dZxH4jkAfqNlryV6gCVj2DFr4l8sH0/xXQ1PDQFx9COJAX1923HjhWCJDyRvuHbcRZhvVlr2/9ja3mKWreMa5IFs2wFBceDe2XssQpbM3JbB6KOFYW1GFxjQj9wdMu766YjuRs/BWJLQM6NOB56YbnB/Vci4izfwHlr8DrwMMecSTUPG5OVuXmEESPjec7HJSsexmn7/1ePqdMjtOmCq4Tx8yEPlgrNrbSi78nR20clODTztXNagluM8rBIA+evcp5HqQA9S+UtiMPAXmG2UZ5ewNS4a9y73WB5lVlduJ84GoT+p8EuFDCSmNum94i9QIZGMs3HTCrszvX55vG9v113K9uMLu7jRkoMPnEZfzN3asOaxfN0i8/3NNydc5oJs7n/foSgHxE5I1WM5OqwxfHW+098ypBgYAN9GZmolW/VhpdE16ZBSnGLxXkm+d6n5G9iTWD2SOJxIPgVjlMCUwQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWIwZWkwM1BDb1NiazhWZWpSTDRXMG9reVM3QXNObVdPNm9RSVdPaVJ1eCtX?=
 =?utf-8?B?SGl3ZXplMGhtSXFMUTRqNEZmRHpZZnJPV1c0UEJySURmZFNVVEhtMk4xUDJM?=
 =?utf-8?B?Tlc5U1RFb3RCTFVYcGZlcDhLZE1LMURhRzRLZEFNVktFbWkzOHNiL0Rnc29u?=
 =?utf-8?B?RDNvVXhST0VrTjd5ZFllZEU2WFBETkxNY0d1L0RGbEZaWENySHIzTHQ0d1FM?=
 =?utf-8?B?YWcyR3pQdnZpQk5MaFkvM3diTmxsSlh1QVRjc2RxQmNyNis5Z3BLUW5jWXJ3?=
 =?utf-8?B?TUR0Z2czSWp5VU55aGJvUUJLcW5JdERzL1pFOTdEdnZ0U2dWcHlQLzdDSDhZ?=
 =?utf-8?B?dG5zTURqOWVsaEhtY3phM3lyRVZEeVpiMnM4ZmpxWWRHUGR6NUd5UTRibVVx?=
 =?utf-8?B?bUp3enc5ODRyS2sxZTZHYjVrT011aUJZWk84dXBXNWNDRU5IdmtJbUpMRzB6?=
 =?utf-8?B?cUFrQ2FCRHhYUlRlVUFGTmIyR0lrQmo1MGNhcGx0dVpiN3hCS1YyNXlWTlhy?=
 =?utf-8?B?aE1RVkVsZ3BZMXZ5c2JIMzZ0Ym9Ta2pxNjhMcGFhSkU0aDdweTc1VnNUUzVF?=
 =?utf-8?B?WkpiOUVtYjh0RTRVYU9CbUFRSE43Q3d3QlpBbXRDWklHM2dES1M3NTZRNEMw?=
 =?utf-8?B?Z0U4ZkZTRmdXTWhjaGlWOWVZUUx1K1dhVWhrSlFpVDU3akRHajJuSVVUSzlz?=
 =?utf-8?B?OExIdUx0OFBSTE9WTzFxajk3d01JVHN2YThXWW5GSU1VSi9uNWJJOFlMZDNS?=
 =?utf-8?B?U1lFSzE0cW1QejZLbGVRLzNWQzc4S0hoQmFEK28wYUlOTEMxSWllM3J3VEpu?=
 =?utf-8?B?M3ZwVU9XZ3RjVWVSd0lFMmJKMUhSMHBEYlV5OFlsd0RtSjRva3FPYmFTaHNa?=
 =?utf-8?B?UjN3aS9URDg1aDd1K2cyT08ycDdVQmRhdDBtNU54YkFQNENuNG03OGlPcTRn?=
 =?utf-8?B?aVNCNm93TG9jK0t3Nkxnc3NpNm9zVVQrekxlVWlqT3JUR1kvUllRUHNrbGZZ?=
 =?utf-8?B?SWZlbEkwZG9DQldEeHVLdTVtZENueVdhdUs5YURuWXBVMXc2bllGVmdSUHpW?=
 =?utf-8?B?SmxqTEpkR29GSTFRTzNjd080dzdscGh5cmdoNUkzVHErM3VRT205TEdoditq?=
 =?utf-8?B?TGIxcHhlNkxDanFvY0NXdi9BZnZWU0xmeThlSWFzTGw3MS9EOGd5SlM5emV6?=
 =?utf-8?B?MWhDMUxyaTJjNlNSOUN0ZVVLZk40N0RpeTNwK283engxcHlyR09aUm82ZHNO?=
 =?utf-8?B?SkdwbnpoV3JlMEt2THpmc0RWK1V6ekFuVTlySS9PdlVBN3FaZTdFWTFVWmp1?=
 =?utf-8?B?M0NVbWRpQ2doUFJQb215UnFNeVkxVVk5cDBqOXRMeUZXSllydEsyYTJMTFlx?=
 =?utf-8?B?cTJSaGhNVm9FVnV6ZGtvNXQzVFVWdTJzaG5HdGN6a0l4dEhPWHlSUmlhN1RD?=
 =?utf-8?B?c1lxWlZONWJYWmd0aTEvYitvS3RYS3A4R0pWN1d1K2NacndBTGZEM1FWdVFG?=
 =?utf-8?B?K3ZMTllHeHY4UktweE9VL09Dd0VIclNuajUyaFRZaGk2N0h6bkx6TldWVlI2?=
 =?utf-8?B?eUZuVTUvMFUzKzVQa24ybC91WHBZV0JqbTFEUjNWdUI0c1ZiUXZmTXQzN3d6?=
 =?utf-8?B?dkV2VkJHSGNOaEdkSUk1QmprdVB0ekx2ckhNQjVkV2czVzM2VjJVcHVZRFhx?=
 =?utf-8?B?NGtLMFdoNWdJMlBXKzkzZU9uN0svSWJuc2VmTFdGRUo3SVpPRWdIc2lBU0xt?=
 =?utf-8?B?cUhtKzFsdk9iVnNsc2tqZHRHUGpvdXFvekc1T2NtMC9Qa3dPMlZaaXhxNDJm?=
 =?utf-8?B?L0ZwVWNybkQrSVNmcWI1cm5LbXhNYUw2UlRPcGdnclBzWlJQZFRPYUROZGpw?=
 =?utf-8?B?OUNFZ25hWmplN3l1aFkrZEM0QTYxVXVYYXkxQXBrQ0FwUW5EbGU5TEJXSWhs?=
 =?utf-8?B?UDRudGtGYW90S2N6R0lvQmthNHFkeGludHdRTFlOSE5weXZsWGdPZ1VJd2JY?=
 =?utf-8?B?QkNCcHR6eHJDRDZWblZ4b3dPZ1dHeGF1S2FlR3hmVUVwWGdNNXNVME96U1pO?=
 =?utf-8?B?NHBZRXRkV1MwTmZkbmxXc0Zpa2dVb0g1OTJWUXBZWksvS1RXbFJER29TNVlE?=
 =?utf-8?B?NzQzbmhEanN6dEZzU3YxU21scUtwNnMwTEtqam9xOERaeDNSbkdVb2hOVlVa?=
 =?utf-8?B?b3JwY0RoRVJUR014T2Z5bmtBZnlOejFaSlpkd0wyZTFYZ3dhSlFFTWZ3WFZs?=
 =?utf-8?B?TEVlaG43WUpOa3BsZldZM3phcmdwZitsb1BrS0grbWJkVXIxam1xbUJCMTVP?=
 =?utf-8?B?NlplRmpYUzhMOWV1TUtoVDFITTBQMGtJS3daZ1VqWmRXeDR2SVNXRHQ5VTFT?=
 =?utf-8?Q?Nj8yMNuyFCpekEtI=3D?=
X-Exchange-RoutingPolicyChecked: LwKAjNgpV4FSkzSOf5GSy4DkShsQ5FXyXQxduEYVXYQPq5rLh4Lyj2+ZIs1NqconOCrYI8Ch6zbQ4OHd7i4Eq/JXm/FB4BPnhTkNv5JLtJNQaaOvdx5do7uhO0uYoU/Nbl+D2mcSBuJ1xX0fsujfgRZ18u4PvvkBW3xnB62kDvQmN7Mba7GSRqYQ3Pn+kcZ+rBeHfEmOlWGIu3sTmr5Ne4zmvE7R0C8QytVCtBH+P6OiEjqSdhK0WmUOYL1xshXV6qUddcK85vxr291/eIwzWtzgeI7KBxX1qD+tnY0V5oSwG4Hyq96T5DHi3PIkvEl4GOurVkGTYsXCS7fm6S2Stw==
X-MS-Exchange-CrossTenant-Network-Message-Id: da985ee3-78cb-4171-e964-08df15662485
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 09:20:55.4618 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l6vTR881Q3srXaHpSbjAiFyC00LVLE+CeAc9dIj0QGYxJSVAX/pDc6ozw+b/XAP/hAqwmLzAbdwW+DiVBYLIeGjiKcgHP9GQlDP5ds0plLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5159
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

On 9/17/2026 2:30 AM, Stephen Hemminger wrote:
> On Wed, 16 Sep 2026 13:18:09 +0100
> Anatoly Burakov <anatoly.burakov@intel.com> wrote:
> 
>> +/*
>> + * Simplistic reference counter. Not thread-safe, not atomic.
>> + */
>> +struct ci_refcount {
>> +	uint32_t count;
>> +};
>> +
>> +/**
>> + * Take a reference. Returns true if this is the first reference.
>> + *
>> + * @param ref
>> + *   Reference count to acquire.
>> + * @return
>> + *   true if this is the first reference, false otherwise.
>> + */
>> +static inline bool
>> +ci_refcount_acquire(struct ci_refcount *ref)
>> +{
>> +#ifdef CI_DEBUG
>> +	if (ref->count == UINT32_MAX)
>> +		rte_panic("ci_refcount overflow\n");
>> +#endif
>> +	return ref->count++ == 0;
>> +}
>> +
> 
> Would it help if EAL has a generic refcount?
> I would make the refcount overflow/underflow still fatal, should never happen.

In the next revision I changed the name to `ci_usage_count_t` which is a 
more descriptive name than a refcount (less connotations), and made it a 
direct uint32_t instead of a struct.

It would be nice to have this in EAL, but I'm not sure of the scope of 
such work and what sort of use cases should this cover. It can be 
promoted to EAL later if you think it's worth doing, and I'll gladly 
submit a patch for the next release and we can work both towards 
defining what sorts of use cases we want to cover and convert the 
codebase to use those, but I would defer it to next release.

-- 
Thanks,
Anatoly
