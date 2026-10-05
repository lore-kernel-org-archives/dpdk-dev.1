Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC86ECA5FFC
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 14:46:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A36CF402EB;
	Mon,  5 Oct 2026 16:46:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id DB7074029D
 for <dev@dpdk.org>; Mon,  5 Oct 2026 16:46:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791211587; x=1822747587;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=lsl6nUrWezzshSgAtu9jzzsn5WDhpB40y7A9CIOmt+4=;
 b=Cp0P5jIgr3lrGpbZ2QrRaikgpFlbBjKcQRn4d08Ky95M+CgKHbZ6ppWy
 24K4BAcM6QVQRWrA5EFOYxN9si7Ug2yRiH/EWuYsDM/ZUX3cvcvvM4XZj
 UIKNg+ZOqfTV4JcxAAicxdG/u27VK0SP9C8T0EVK5rYt3ZbnjqtAHU3W5
 BKmoLHWoGePpzplnGDstrMktesyjI9/yk8wLCRb0CBpsmXTHjduHXyrBI
 hE2LBpwrjYEUOaS+LC+m4X+xwA2MTz1ql3xCqtALEcutetibJUV2UHQmw
 JdTlIdEmQfKLPni3sKLJLOvNCKmap2EyUkYKVtq3jsHJxbrk8l/Y3eB3J Q==;
X-CSE-ConnectionGUID: OAPCy6scTfWXWBiTzaCaXA==
X-CSE-MsgGUID: YWrevLeVQn+A4JlcjFht/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="91744873"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="91744873"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 07:46:25 -0700
X-CSE-ConnectionGUID: bPUXJy2ATtSBR9egh3fIxg==
X-CSE-MsgGUID: sXeQ7+JVSIC3WnlMyWj68w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="280575441"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 07:46:25 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 07:46:25 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 07:46:25 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.49) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 07:46:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uGwTw9zbttuluR2WfKGUWRm70hL9teTwan0NtX5m2nl/tefu3aOhGj6fH5TQa1Api1gHaSKwzShIy3SbPZTk+XSMAAWuPIEXHZJVvcITF8LHdQdTncVDValBEhWV4G6kJW6RJW7OPGlBLKk3YNaM71ox/UYBkF6BYK7KmzuOSuSqU0lqsJ8SW5+vrS78TlrGLwjHMRM9fC6hn6gvDxfAoghTLjm9NTDFeqCVVS0Xfp8HzDT5vn9EuC3CXw+usnN7M00mLkVpWS7FqZ6xiqcq5cr7L700pLgovwZFROXV9k9rKt+SR256wjtFJ3puhth+hh4guFzBg/GZORLglRr21g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nd0ZwDb2T5anV06cwVfP+bmOa2bLbUYfnlwBhLs93sA=;
 b=EJQCz2DNvUn7Kt3oBC8BY/udez2P0BzygQYE4uRk0f9uk3lEhELL5eNif5M0toNptgvDKcw7kd2FsvoKbWxzDu4eB6kzcL6Fz9sgqxWkc2jL6EN3eOmWK81HoLDUD7j+nk5d2L6G/KLO5XV4eaD37OT/bKJjn5nuai0G5Z1HECUyZOmmM610htX6uAANq29V3TZukxo9xzK9KM6HyUqixTnfuGCUBbDmeVBe14zpLN/VwL1w4M7mLa0duKY/PZqnIhVyM11hp3C2uREBnfusVKng0pJjses0UJ2E17gsXlqpJboDOMboxDVTx+wSJSjfpAyzTk+2jiQBvc15NVewhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 LVTPR11MB9909.namprd11.prod.outlook.com (2603:10b6:408:3c6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Mon, 5 Oct
 2026 14:46:16 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 14:46:16 +0000
Message-ID: <14800b6d-5de7-4831-b887-b6b744ba4ec6@intel.com>
Date: Mon, 5 Oct 2026 16:46:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/19] net/i40e: refactor FDIR engine infrastructure
To: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>, <dev@dpdk.org>,
 Bruce Richardson <bruce.richardson@intel.com>
References: <fb21ee962d3321518e396810887c759e7fba27bc.1789560946.git.anatoly.burakov@intel.com>
 <46e66110-5473-400e-abec-fc60e4f5f033@intel.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <46e66110-5473-400e-abec-fc60e4f5f033@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0151.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::13) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|LVTPR11MB9909:EE_
X-MS-Office365-Filtering-Correlation-Id: 03fbdf50-f7d7-4871-32d6-08df22ef68b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|22082099003|18002099003|4143699003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: jW/hmpOoCIlI05kcLd3w+zaqbgrtlcTpf0QEWnECpxQ48UbqgRDmiqTS158YtSxLGoYZKUwoInnHZHNcBd7f9zQ/5wdc2Fm4o5z1ziO5TcM6K7NvFdrkRB0ciSfYIJMs/5qSnh472f8z1firZGqilk57ot8cArRqBofw8UEe4E10FZ4ip09fIzukU3SsgSr/6q6RuDOAX3+b0AcNhSE8i6qKmuwkzIv6oLka2/SZbcLNKuPtZwK9M81l8wT7IzCpnYs036SYtGsUddwU6UG6PF1KoAxrGv1K71zqQfFF7UDY+6Cs102NopSkC0AUdumqFesgYeaS0aLaZ2lrn/Jy53OPjHXZZHpR4IZogWPMlo3O6O1lwuOf44tz8/PF7prBP+eoNWkm5WQ/ZQjkAbT/plsNChwBGFo5py9wIy6wtmOnogxzd3CU6ZYCsyFP4yxKk1ZKVrBw0qBNA6swVMFLq2cBaTVK9LegD65D55i43sP5Jc0H0rqXiFxvKN4zJFJQ1zosu/B0e45C4Y2SU5Q7hFAmd9fn5H2MFAtMSKOUAof5CJI8TJ5EYSRH0I0pMifSmD78MhXomE6d2zE5f6HVVeLkQAzyAXpULDWDsGQ8aHbDtsCOb9emVKNPcfnZNkY3gYvW1z+Xlx+5Pp6imFj1lZBRdEuU8r2ogQetebATtSg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(4143699003)(6133799003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SElOLzdIaEUrM0IwMG9FTU1OakdKcGJqQmZsdWp5aDBKRFplRHdDOSt4aUJh?=
 =?utf-8?B?Mk90cWNyVm0rUG5icjdzd0VSRFhrbVRMUmwwbFVlcUMwd3BzR0ZPMWFCOFBo?=
 =?utf-8?B?L1UzSjViVWYzM3F1SjJmbnI0anFMNGFsNVp5a0REcENFelByNGswU0ZOcER0?=
 =?utf-8?B?S3RDc1FTUkdIeHJMMFkwSGI1eFVDVEpwMVFrQTNqNFFxWlprZE9UVW83WnpU?=
 =?utf-8?B?WWZ6amw2OGFIcmdYenNVeGpOT1VjVVAxNytMUFlzbXNueVBFcnR5c3Q1UDMz?=
 =?utf-8?B?di82Qkcvdll1UDZuaXVqQVA5SkFmajBOR3BwNDk4bElIcmNXNWswOHFncGZI?=
 =?utf-8?B?aFBYaW5HclAyNHN4RGErYkt2YlN6UXpiMXV5QWV3YmFUVWtMWmV4ZUt4QkRU?=
 =?utf-8?B?SFU5Tm1nZjJxUTNLOTNVRnc2UkU2WGhFaURRRkFFUFNkV1pxVDdVaGpOWFNh?=
 =?utf-8?B?Qy9tUUFDVVVmWVZlaFpxRkUxZ0VzSVBPNlNFOGplaDEvZWgxNklaY2RxWVRo?=
 =?utf-8?B?LzVHQXhLeGgyVE9MdzZpNVVNYk1NTFhaYWxaVXBTcnpBeXk2VWpiYy8xYjZ2?=
 =?utf-8?B?c2JSenhvQ01sdzNVaUhzTXgrQnFYM1JUNWxHazhOU3RTM3pOQ3UyL25kcTJv?=
 =?utf-8?B?NXFoMkJHenZPTUF5ZHRHR0V1N2hBWkorTlFrWE1SVHRVb0JqNmJ0WHl3dzZU?=
 =?utf-8?B?SE0xb0RvVnhoRVFNUmtDVC8vR3BZRzdUejUvQkRCZml6OUQ2R1RQL1NvdXRJ?=
 =?utf-8?B?cUU1dTN1ZlplSm1Yejc2aHAvd2lkc0pFbFIwVUNYYXM0WmcrenRLUXlrWDVa?=
 =?utf-8?B?c09ka2FrQlE0T0cybWJ3TElSUEMvdGRoeFV0YzE5MWFCZy9aalRtQkkwODVn?=
 =?utf-8?B?angyWUJPTmpQMUJzOHpJZGFwQnZIc3FWL3hZYXJxMGFsVU1kUitHT1BkY1dE?=
 =?utf-8?B?SkZDVWNKZjhIeTFscUM1UWpWUGVoekQvTlRiTE5SMFdrSTdoVEFmc3NSUXVG?=
 =?utf-8?B?cXZ2VmJ1M2FzeHJ5cGRKa2ZpT2ZoY3NEcTBDS2xZQXZGOTdEYzBCL1AyRGh0?=
 =?utf-8?B?YXJrUXE0Mi9xdzJ2djVlVzYrQUlPS1N1QlozYWdjKzdscU0yM0NobHc4SS9B?=
 =?utf-8?B?cU0xanRJbjVCQ25Qb1pWbHc1alJsYVRjTGEvRk5CV2kxTWREaEViWFdHSEx2?=
 =?utf-8?B?VHNJTGovUWIzZGtSQWtMQUwrbXoydnZoTjhiaHIxc3JlUmh5WjBSaVRDcnYy?=
 =?utf-8?B?QWpxMXk0WUJHOU9NcU9NNENwSHVrTWFqbGlIbnhJM3o2Vy9ZcFR1dXorMjBK?=
 =?utf-8?B?MDFkMkk3M3lJVWxEa1RGWnBXbGh3Q2FsRlJoQjgyZTNkUVd3bHliN1RhUGVw?=
 =?utf-8?B?L1MrUlcvYzFMQmF5NHUyd01IeS8vTyttYWN5UkRJRGVza2QxSm9VTHVnRS9w?=
 =?utf-8?B?RjByR280Mkd5RXM2NkN4d2RRQUphbnZGVDgwR29TdFhPa0tzbjZrSTJXVHNh?=
 =?utf-8?B?MmdJamczV1l0SVB5alprczEwNzkvdjlibHdRaWRJcmlFcjQrN3RnVXVFemgw?=
 =?utf-8?B?NGVGbTVBRHFITUxDeHdURlgvVnhWd0FndmJ4d2tQV1pzREozNE8rUW1QQ0sz?=
 =?utf-8?B?WmhwRExlOFlpRkRZajRpUk1VOVJUOEtCeDBLU1dUZVpodW1OK3dpOTMwZzJj?=
 =?utf-8?B?SkozOFFyWUl0cHV4b3d0Wkt1bW5rMWRMdEw2amdBWmc1NmVMMklBTFgvaTJL?=
 =?utf-8?B?RVM4L1liUXpOeU5DekwraXZ6TVdTVHIrbFcydjJxVnBQSTI4RWVGSEN3bk5o?=
 =?utf-8?B?UGkyQ2lQR3NhQnc3QjFOQjRyOHpkTTNrcGEyNVhnT1pxQXdyZHpMeFRXWnc1?=
 =?utf-8?B?NGdIZ2pRcHh1ZHNSekNxU3FvNS9EMDZITDFTYy9tVk5XK3Qzanl4Q2JDZTBW?=
 =?utf-8?B?cWNtdXJsdGozY0haR1Nob1VPQ1p4YVlabExqL2FzMnYxWW1BVGg5ZlZDaldT?=
 =?utf-8?B?TWJzaGt1UWp2bFJHeVBha3IvUW5zVUtSNnJQU2hoZFkwNnF3RjRJdnl6RkVF?=
 =?utf-8?B?dDQ4L085M1o4NGVwbHEwMjJob25wZ2RzamRBNGpsd2Q2ajBxTWtPZlJTZmo3?=
 =?utf-8?B?OEltY0lGL0F1dXhqaENENFBhcXcxQlBPai9QSlI2TXFNWHgvcjdTMTVyRzdV?=
 =?utf-8?B?ajdxMWpiUDJvM1VNMHRRR0N5bmtDUElzNTVGT1ROL0pwVU1MbDVpS21oR0pY?=
 =?utf-8?B?REhoeTR6RnU4TytrNWJmWGVYbXY0enJySjM2eXlwbGRpaE1YUVRPUENYZnAz?=
 =?utf-8?B?VUFNZm5hVEt4OFhLeE1FNmVUaUJqbEp1SkVqUVJwMU9RMzNhSzBSTTlaTVdH?=
 =?utf-8?Q?lGGj17twzJ5xUzEk=3D?=
X-Exchange-RoutingPolicyChecked: dOEIhsy809YaoUO34hLmL8Yi9m6dPmULhrwxRwLV5TJ6CJs/dWhX6lkfr4mqZHsSPUaKwtY982IMCjv5sCz5qggpsE5ZH+JcQEf8uRg7Opz8E1FktzMazXljXoEo4xPMGKktIU92Gqw4Ag8mu3X1xm7ztwBEm/ZNUAURg3I1vupgblzbe2aAbvJ0kijqWzLasiPCYi2Cx4UTSYDpbYRaVcuG2D5fkcZf49QsvJKyL8E69nFVw3NyvcKci5WuNmLwb0fEDJz/hTPfzJVdXBroIWzI85n2xXYxTHyz241HVCWfyG1jtk0SvlJcans/4goJWF96C44qT2Cybon3ljaxlw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 03fbdf50-f7d7-4871-32d6-08df22ef68b2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 14:46:16.1152 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: purU0Jf4RIlqwKqG5+9f7XyG/cNY5mevdfskHVgidq1BnbohuO8LzIwsT/s9R4unOIbqRyO43l1AGq7p9ZzPiW54d02GiJMzPXk7hsXa3k0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVTPR11MB9909
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

On 9/19/2026 6:13 PM, Medvedkin, Vladimir wrote:
> 
> On 9/16/2026 1:18 PM, Anatoly Burakov wrote:
>> Currently, there are multiple problems with how i40e flow directory 
>> feature
>> is implemented, both in terms of how it works with rte_flow, and how it
>> integrates with the PMD-specific packet template API.
>>
>> For one, these two subsystems, while using shared infrastructure, do not
>> really interact or cooperate, and are built on top of special cases in 
>> FDIR
>> path. More specifically, the packet template code does not store its
>> packet in the hash map, and has a different hashing scheme, yet it still
>> registers itself in FDIR flow list, hash table, and hash map. This list
>> is then used by `dev_start` to restore FDIR filters that user has
>> inserted into the list. These filters, as written, cannot be reprogrammed
>> that way because the information a filter restore function would need is
>> lost on insert (the packet pointer is not added to the hash map).
>>
>> Another issue is that while rte_flow FDIR code does lazy FDIR init on 
>> first
>> added flow, the packet template API does not, even though it too 
>> relies on
>> the same hardware feature, nor does it ever do teardown on last FDIR 
>> flow.
>>
>> Yet another issue is how the "filter restore" code itself is implemented,
>> namely that currently it simply does not work. When doing filter restore,
>> the driver will walk every FDIR filter stored in the TAILQ, and 
>> attempt to
>> program it. However, inside the program function, there is a 
>> deduplication
>> check (to see if flow being installed is already present in the flow hash
>> table), which fails because the flows we are programming come from the 
>> same
>> list that is being checked for deduplication, which makes the entire 
>> filter
>> restore a no-op.
>>
>> The FDIR filter programming code itself also has a number of readability
>> problems as well as being otherwise hard to use - SW bookkeeping,
>> validation, and flow programming is interspersed within the code, and it
>> is difficult to reason about what happens when the code is called from
>> this or that context.
>>
>> So, this refactor does the following:
>>
>> - Reorganize FDIR internals to track packet templates and rte_flow FDIR
>>    flows separately
>> - Refactor FDIR init/teardown to always happen on first/last rule, so 
>> that
>>    whichever API happens to call FDIR first, the state is consistent
> nit: it seems you've moved it to the next patch



>> - Rework the FDIR code to disentangle FDIR flow rule programming, Flex 
>> PIT
>>    checks, SW bookkeeping, etc. from each other
>> - Remove both the rte_flow FDIR TAILQ and the hash map (filter array)
>>    structure, because they are redundant (information about the flow is
>>    already stored in the rte_flow flow list, and hash_map structure only
>>    stored pointers to data we also have in that same list)
>> - Fix FDIR filter restore to replay all configuration correctly, as 
>> well as
>>    re-init the FDIR queue enablement tracking
>> - Rework the internal FDIR global state data structure to make a little
>>    more sense by grouping things that belong together into structures
>>
>> Additionally, there was a delay mechanism at flow director rule program
>> time, as when programming a rule we might not know if it's actually
>> possible to install the rule, because space for the rules may come either
>> from our own pool, or it may come from a pool that is shared with other
>> VSI's. However, it only makes sense to wait on rule create (i.e. when 
>> it is
>> programmed into the hardware for the first time), but not when we are
>> replaying or removing these rules. So, adjust the waiting mechanism to 
>> only
>> wait on FDIR rule creation.
>>
>> Signed-off-by: Anatoly Burakov<anatoly.burakov@intel.com>
>> ---
> <snip>
>> @@ -3860,16 +3851,15 @@ i40e_flow_destroy(struct rte_eth_dev *dev,
>>           ret = i40e_flow_destroy_tunnel_filter(pf,
>>                     (struct i40e_tunnel_filter *)flow->rule);
>>           break;
>> -    case RTE_ETH_FILTER_FDIR:
>> -        ret = i40e_flow_add_del_fdir_filter(dev,
>> -                &((struct i40e_fdir_filter *)flow->rule)->fdir,
>> -                0);
>> +    case RTE_ETH_FILTER_FDIR: {
>> +        struct i40e_fdir_filter *node = flow->rule;
>> -        /* If the last flow is destroyed, disable fdir. */
>> -        if (!ret && TAILQ_EMPTY(&pf->fdir.fdir_list)) {
>> -            i40e_fdir_rx_proc_enable(dev, 0);
>> -        }
>> +        ret = i40e_fdir_filter_program(dev, node, 0, false);
> previous implementation set wait_status depending on fdir_info- 
>  >fdir_invalprio. Do we really need to wait here?

We do not, and wait is false here. We used to set wait_status here 
depending on fdir_info->fdir_invalprio, but in actuality we can avoid 
waiting here (see commit message).

-- 
Thanks,
Anatoly
