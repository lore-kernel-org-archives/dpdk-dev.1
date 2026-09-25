Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CFDC9830E
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 09:37:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E62C740DD3;
	Fri, 25 Sep 2026 11:37:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 387E440BA6;
 Fri, 25 Sep 2026 11:37:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790329059; x=1821865059;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=fmdzDznc4NFZRgnCFswXajXKDy+J+Ea755ksTgjfUX4=;
 b=FvFkXyjF3Bb5JvN/pVQzKi7UmPa3qBxLFL1NEOlrW0gMNpxK8MBLhw0c
 Y0JXCDsyfzvginJlsqsqNXGXab/uruLM6l7uNdgOdU466z1QIp070Zrqf
 dndE98JuIK4hFR7Xi/YJskwtYfoEFnBQOxpFnuFhWBDgKQM/hY/VNd/E7
 kZMh/+163Ex4wAf7v2zMFt0hPpejHnSFgZ5QPmV3glP3bU2cvKXraXWPc
 Lt7nqWD4wI2u51ytGsPFbN7EXysdeaECDoSIJVnwGBRrUFENiNusD/zDV
 ges1y4+F1sycskiyp2jWyG56iTs25VuLFXXi27BgP83ubJBkmZtAiZbIO A==;
X-CSE-ConnectionGUID: 6EdkRyhQS2aqD8kRslizlg==
X-CSE-MsgGUID: zC/bhMncQN2JIZfy5Cgvpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="107493125"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="107493125"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 02:37:07 -0700
X-CSE-ConnectionGUID: olpFTlFrTuqy9Lej3sGswA==
X-CSE-MsgGUID: oEO4ZK86RTeCmCYNwn6UpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="302226878"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 02:37:07 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 02:37:06 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 02:37:06 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.64) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 02:37:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KqyPcJWS8wEKLTm+v4ZJZoNi9HFSXN6fUvVRgZxc5INBKn82WdLegyO8pIM9BgajnR3dAcqrB0Z3pKUfWy5B0HqgQPJ6jTkK+gGAA/g7gqt8gYm7kmnkwYp0fwRvnkm4LU9qofVzsocWxfo8N3PNNsQmNhOrBYglgMObSmhpBEdGDNL502dWgHspAs+Qq+rmqUNdfwXQwlmhJqh2iSaYAdDrAFktJRX2ceYW+KLOuf/5px38ZpwACHwpiTUXbZ+Ho2MM2CGbuqexzq89zV9gF1qeDCpoISI8NCDSQZGegbOYVLcd7BsFQTn22MkubXSN8nAPQ/qaWg7rrHtsl01CvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n19xvjN4oCwLHMO64KDJ0hMJHWSwU75xT601go+h81E=;
 b=WbLHqJpVK0c9vXNE2o08Q9TeeeLax+Kbo/5IWpXjtdI/m521D7B4wGelg+JagW/C9xGDtTh9m6do5GKtczkreIT1gYxrvOn6VhnZngGZd7y6H4Cnjlyrrz/nUdAHpY2pqLIrKzVdBJce9VCtSU+oqluptTzC/lVii6zeddWKajqJrfzKvAUZrEisKt0lm4GtHHvtyAXwXdUt32YYpRgHDJ5f1RZXyLyLlNNhgJaW6bKUUAoz/k1g0im+jHD3t9N0/9jrKqxbtdl0MiDcYP0fKqvgeUxbubxgp80Hb6hRAi06RY0LV6MUMjlN0dbegW46k8K2pYMVly2aiY0211//vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SA1PR11MB6685.namprd11.prod.outlook.com (2603:10b6:806:258::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 09:36:58 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 09:36:57 +0000
Message-ID: <eb5d85c9-ef87-457f-8966-8b5b7b742636@intel.com>
Date: Fri, 25 Sep 2026 11:36:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ice: fix overflow on storing device args
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: <stable@dpdk.org>
References: <bug-2037-3@https.bugs.dpdk.org>
 <20260914153019.4034539-1-bruce.richardson@intel.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20260914153019.4034539-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0074.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2de::8) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SA1PR11MB6685:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eef6022-d872-4015-3d39-08df1ae88abe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10067099003|56012099006|4143699003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: ryVmjbIaFLM+pf0/JtkoYGeWwTu9zrrP/eBHugbsrZMPbumPfZuTqAQLFPvomwyGURlxbxLbdtPpVA80gpYGnwO2BNOg+Zu6jZLEnxiVT12CaI54T2PKcAD83TkUkHfGDZ8Yl00ajr6nW4XWaSjvU42PCuLlQCLp0UtbWUEb5b4K13aLO/E00DSmjRVagfaJvbJxXdt31pOxs1mdGz0SFCIyEzDEuhzvrYlqnktXe6vlKdtPKsjSRKdVRSsSwVi29OuiRk4qa95ZmiPS9OAux56b/h7cB/RBZtjGXutGafzg7OIMt3VKNteajtsfmn4dQfuwY2Iys+48XaAg+8C/b8Btba3f7xJOQ91KWeT1BMFrN3JRrooysdpqvkgdh4qUkHHhf7dri1Mi7LRsNexIzzCEuULn1uAtuh2Zy463iFG3zPzPmfuBd9eaXomd1KVgalANASa5ljdzBtZeFSC4EZRgKveHVuYxty9O5Zswj5ogVd4quhuOTahqtoVPlipgwbq33jC2f0IAR4GSxEPdp1YVVEDwnFmNdBiVa+CWZ2TjBfks78Ty87LewxaKxN9AT0xp7YyHphVOjIim6lrNz2ElGUZL1Ogmx7rhTuQbMU6ZXAYfyvWdHtbDli/1K89hgAk319yvcn3d3QUIN+XFBahHz0eayn3ot98DQ0HdLiE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUNoZWZtYUc3TW1jUlM1QjlaK3dNNTdzMVk2QitEWkl1VEloTWg4MHNWeXlH?=
 =?utf-8?B?TzdsMHFTMjlFMXVtNUJid1hnWlVaYW1FdHNNM2tyaDN0VEJiejVXa1Y4QjI5?=
 =?utf-8?B?SVlQL2JnN3ZGcHlWM2sxM3QrYzd2akVXank3Q0txRDQ5bEdLY21BVW14VFo5?=
 =?utf-8?B?N2RUanFCVHdZR1k4R0M3REwyMHluQ29jOFRiY2FzSWxjYVNuUHNiNzNWVE1v?=
 =?utf-8?B?aFRMdjEyU01tNCtTUUdCSVMvV2k0elJjVmU1ZXBtVDNOazVjZmxOZ3V0RmJu?=
 =?utf-8?B?U29mT0Z4elpqcU4wY0x6SnhkdHZqb0laNFh2OGpFdjBkTVI0eG1xU3Z5cjMy?=
 =?utf-8?B?dGRCWnRyQTUzanFxQ253WS9SWDMzN0tXV2diV2RKcDR3aXBybXVuNVkwVWlS?=
 =?utf-8?B?bUtTOWRpME95TG5SdTR1YUNXQXdGWVpRbUlKUjdoT2VWeFQxd2d4NjVLckxx?=
 =?utf-8?B?T2R5WkJLL0RacVZoZDluZGdFYUlxUDlYOXVXVXY3anF2RFA1VTdIUEtaNDdk?=
 =?utf-8?B?Y2tqdldMNFpPb1ZUVVgyS1MzNjVPUXQwbjRLZVZ3OFVOWmh6QlhCQ1MwaThl?=
 =?utf-8?B?T05VaFB5M2xnMWRNMjkxZDNLcmhjN3E1SGd3VFRvVFBCMkpobW1FS0lTNnhr?=
 =?utf-8?B?MnhmUUJLZDBXYTZwWjNFM0M5VGpvblp6eXZLWk1lMGFJRXRYYTNMRzRPaWcy?=
 =?utf-8?B?Q0kxLzVVd3BuY2gzYzZwZHR6dkYxcTR1WlE1b2h1b1p4S0dUczhxaTBTVkEr?=
 =?utf-8?B?bytlaG5ZMUxLR0VLQ3g0MGozZUxRRGJYb01Ld21KSXBwa1NpVXpLeXptVFd5?=
 =?utf-8?B?QmNTWmZWdmlIa1Z4RHFUeTlWbnI4M2tQQ3RCTldzMVdvVHFYMmdVVTA2VGlV?=
 =?utf-8?B?Tzc1ejNwcnJnZ1kyT0YzQW1YblJxcW1VdDFVZnpwa1RYVnczNWhBVU5ZdExI?=
 =?utf-8?B?OGV0ZG9kbVhxUFVTYkdDRlBYc0pudiszNm41ZS91VVI0Ym03N0I4WWxIcGRW?=
 =?utf-8?B?dEVWQUVIVEkvTHF1TkhEeFlSTk0zVlVqdHRTVkNoSm5TOWFaRzYrVWE0dGZE?=
 =?utf-8?B?Zm00OG1WZDNLTUdEODM0Nk42MVhkQUZKS1E0YnFhTXhneWwyTHJSTzFCTWxL?=
 =?utf-8?B?M2Jya2h6emx1aGlvb05URm56SkN2bzhlaDRPTy9nL0tjcXIwZTh2YzM0Zzlj?=
 =?utf-8?B?Y2RXY3FpT2U3aXJpSURxUThtWnU4c0xtUi84NFFPR3hoVVBaekVTeEJQaDJZ?=
 =?utf-8?B?ZFZ2RjNHZkt3anpOUy85b3Y2N3J1aU1KM2NXbklaK01EWWtMN09QWTVzZVlO?=
 =?utf-8?B?ck5ZNldZcWYrNVk1QnU4MCtvYmZMbkxHRW5hdlVkUXBVMStMM3ZJalAyc3RU?=
 =?utf-8?B?SFM1Zlc1S1hzcXJlZ2tvMEFLc1JBVnpHTlJCVDg4RXJpR29nOXQvNEI1bG5R?=
 =?utf-8?B?U3grd0g4UUdlcTZ4UnhPMFF1aFVoOWtxa3lmRDRNQmFRRmIvUG1PYmZWd0wy?=
 =?utf-8?B?b3oxKy9zU3lwWDZLQWpOVFhpbEFNK056czVZdk5EK2NyTzFxYldpTWpOQWVR?=
 =?utf-8?B?K2o0cmd2NEMvRCtpaXc0S2E1bCtyZHRvRC8zaHFleFpaaCtlREU5cmM1UjVP?=
 =?utf-8?B?THpSOFlEaUN6eUU0RDJPa1NEUUYwZXVmSnBHTTNhT3Z6b1YyQnRqNklrT01h?=
 =?utf-8?B?RW9hbXlGUXM4eGZZclRYb0xyNkVLckVUOUt0TEFhNHRoM2hEbDd2NDFDbDBi?=
 =?utf-8?B?eGhPNE1teEZDTmo0ZzEzOFZoUEExV0RXV3MxT0ZXSXBqamF5TFRMU0xicXpk?=
 =?utf-8?B?VG92RHllN1NyR09VcERiemJDaUdjc0JUVUwzUXRDNGpxRHIrdWdZd2h1OW5r?=
 =?utf-8?B?b2NtdjUxN2cvRGhuS0x0Q2RpaThVZGFTb2wxUGpRdWdxM2RsLy93TlkwakJ4?=
 =?utf-8?B?K3Q4cXZjSGl1c1R1TVB6NmdXRm1PblA0U0tsL3AvaHhpVy9jelpLQkR6bXhW?=
 =?utf-8?B?LzVuVVBnVVpTT1VJa1FFbXRQVTVGS2FXbGJucUs1VmQ1aDVieGpDcHI5YkVv?=
 =?utf-8?B?WlVVSm1CY0NrTUNTcWpDUnlJWFJpdWhtVmhabldjM2pVdzZwZE1rUHk5TUhs?=
 =?utf-8?B?cG5sYTQycmMyeXBGK1dVNitJNGljSTBZZDZUQ2dZY2UrN3plWTRRUXNZNUxR?=
 =?utf-8?B?RkVHTmdmWmRzQVFhSlBxWDN4ZzlwdnZxMHZ1NDdSYlYyc3gvRFhkWlRrZVlu?=
 =?utf-8?B?STYvaUdZeXBOL3hxdjdJQ0R2UmhobUFmQmt5UHg2emlIL1dUQ0Q1NnFSeXBE?=
 =?utf-8?B?ZUZQNnhJa0dCcmhDZW4rQWtLVWk5ZkhRSG1SZ2MzTzl2azErQUJtVnJ0bFRR?=
 =?utf-8?Q?FnAM4fLVZBkVDGcw=3D?=
X-Exchange-RoutingPolicyChecked: hL79BzVNtNsCfzBhja6TOI4/x0bfm+qsR3KUM8ugwzoSkXQCpQw8B9AI0nd6uW+Vs4WUQFUVce3FyFb5kJAjjyB4YrSXN39ptzrDezDZ/YCCRrrpU7lcOZnx7tENh2rOEinZnE6IVGTLnYHXD2neJ8PpsTSyLM25Y7N9F+OMpqK4R9dB8Y2NrIywmI9Jyz1xAE2X323rInUvj8dTi0stKwFiwGDs17D4dEZxcerWUFvZeQogYxowlEkc2RAv+iSea9ue1mkH1Uu9hZxJ2kLiodUr7KzI3r852M22bQ9V+6p7lChD++roahNL50Jmbht0Lmn6OontMt+l1t40ElMb7A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eef6022-d872-4015-3d39-08df1ae88abe
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 09:36:57.5094 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aE7ewiCxZD1fFeL0a/ETGEEn++jhhdWgYmOBsRWw6zmQ0gggHh1+X72V8fNqJdB/0tmONktoloV901okqY65BKM4qe3thAEnxDgMCxsjXRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6685
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

On 9/14/2026 5:30 PM, Bruce Richardson wrote:
> Boolean device args to ice driver are sometimes stored as an int and
> sometimes as a uint8_t. The parse bool function stores them as an int,
> leading to overflow when storing a uint8_t value.
> 
> Fix all these by standardizing on "bool" type, both for the arg values
> in the structure and inside the parsing function.
> 
> Bugzilla ID: 2037
> Fixes: 603beeb970b5 ("net/ice: add safe mode devarg")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
> Note: this fix is superceded by the kvargs numeric args patchset [1].
> However, that patchset relies on new kvargs features unlikely to be
> backported, so this standalone fix is useful for backporting or if the
> whole other set doesn't make the 26.11 release.
> 
> [1] https://patches.dpdk.org/project/dpdk/list/?series=39247
> ---


Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
