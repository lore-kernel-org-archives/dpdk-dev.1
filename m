Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A022CA0FED
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Sep 2025 09:17:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15BEB4021F;
	Fri,  5 Sep 2025 11:17:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 71D62400D5
 for <dev@dpdk.org>; Fri,  5 Sep 2025 11:17:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757063874; x=1788599874;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=ivRCzjopnj9KRTuAnQK1OFUp1j07gkkO6XQ93I/teck=;
 b=dOEMf5aTt7KY3CMd6jmikTdGcQfqZULt66+DWGtPYmkiXXUzMPBBZt+c
 5MUEcZ5gClfdjer/fpzHEKZkghGvQcEM63CGU2jm2L8mfkrqU/ga1qmvq
 ibVSMUovW2AJXJSBKBHpubX9/y8OO+m6Dy7ZqCM3qcWYuupLUaXPTElmp
 CR+SQZr4Etg5bLg5RNU5vQsdJVL6RA5wOIZyUW9Ja3F3ttgxtkBihnqUF
 XC1yjVz4kGrpsWi6+7nQqSUKestxgvAiKbelPUlJb0CWBBAqGG+bLTliE
 OFJSGXpkG4jwY3tQcedJxktyOpCynOVmOzsG96srM1IefMHTzxQ2PBHr9 A==;
X-CSE-ConnectionGUID: FPOXOj2yRmaJpcEY5SlorA==
X-CSE-MsgGUID: D5cZdOZcTJC8H3hubnuWJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="59352584"
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; d="scan'208";a="59352584"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2025 02:17:52 -0700
X-CSE-ConnectionGUID: HOMvfZUsRBO0S+VM8Zn4qQ==
X-CSE-MsgGUID: UU0Ec0zdQuWZnu/vDVr5uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; d="scan'208";a="172931329"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2025 02:17:51 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 02:17:51 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Sep 2025 02:17:51 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.50)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 02:17:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YFDPgbhBWQYAfeqmkLKSI3s/q0X4mhMcKg27opJ2hPCuHtyjthrzX1E1xVbV7N8H/PJoe492JVfk+yJ4a9KiTng0Hv3yyCoLaAny291w9vkmfIWSWrs+bk+K92DKpbJHTSMzjDLfbaTfrSTj3sP/NlbJy7sw070+qiXomlDZB1Nqp0q0Gmw2ByaAooCAO9Pzyai3IK83pQcLl/GgFrHyydPZY6vqovnlGNEAevgWBuqosnHhdg4rGzsPWG5xdgg1KK8M7XtOmtg3j3MlRJN91lc40ghaQiFWdcV4Lh+1hePl1GcthEvzVipc7Ngngiv46gj8SIaapGK0trAXZqjUiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8FnvNjL8FhN6lFH+WZjVXFjcBiwdUkIEC3IyrJ/SUI=;
 b=mhEsKPC2XOOgo4yq9HgDItGEUYwkgqrHGM9I3rXWII2qvXajZyaRJZEx6nZ6qaMr3UJbCQoaizH+ThoQLSjwsHTHIqNFhporJcT+P2LKTz7g1Qv6ekP5SDQ3q9sCNqdB0ZElc/XQpU4iC9D+POKebrih384QHh0x93RKuwr5+MN5b/WT0GWp2+q04YtCrJWL6SOfaIFlRbBW+cH1gVUoaJf6MVQVpa9ZwvE3BBGBoUzgSpadm45oXg4Rc9bTugzU93dMQy0FS4Ec8+Mxn9+QD0gzMiDqHP2bykg7ClBc1C7KdayT0m/HTS0Zgt0CCXueiIGWFXZLVChIb3yAq6/hig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6498.namprd11.prod.outlook.com (2603:10b6:510:1f1::21)
 by IA4PR11MB8943.namprd11.prod.outlook.com (2603:10b6:208:569::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Fri, 5 Sep
 2025 09:17:49 +0000
Received: from PH7PR11MB6498.namprd11.prod.outlook.com
 ([fe80::999a:425d:a211:5d30]) by PH7PR11MB6498.namprd11.prod.outlook.com
 ([fe80::999a:425d:a211:5d30%6]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 09:17:49 +0000
Message-ID: <45a59471-a515-4595-bf07-a74d1c6e8482@intel.com>
Date: Fri, 5 Sep 2025 11:17:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Error with --no-huge when compiled with -fsanitize=address from
 gcc 15
To: Robin Jarry <rjarry@redhat.com>, <dev@dpdk.org>
References: <D9WNYZDZHISG.3091PEP8Y34QL@redhat.com>
 <DAIPCY7NIG04.2Z0S17M8BPQUH@redhat.com>
 <9d2e0536-98af-4532-aa57-dd1605d6e070@intel.com>
 <DCK3KYFOL7EF.1CBE546ZJUS04@redhat.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <DCK3KYFOL7EF.1CBE546ZJUS04@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0070.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::18) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6498:EE_|IA4PR11MB8943:EE_
X-MS-Office365-Filtering-Correlation-Id: d3ec6e7b-fe17-40e1-c76f-08ddec5d1464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YklBSFNCVEdxVmdnWHJtU2p0ejZrMmhkaG91OXMyMEtKUEJGcHJMRWhhdXhH?=
 =?utf-8?B?TWRCdEhDNmN6SEJzSGZRZFYwNjVzL29XanU3UzBCWk5lRU8yQ0N6SUVnR0JI?=
 =?utf-8?B?TW5yWGVsakZaZGZSQlZneFZCS05MM1pudS9waGNFYjQ5dFdiUTNlQWxyeGF0?=
 =?utf-8?B?NHZGVFVWU0poaGdhUnpRRDFrc2lsMG1CRytkYlQ3K0JONHprUnQ4ZWhheXJQ?=
 =?utf-8?B?QzBibVp2eFV2eko5Sndjb0QzNzNoV0NMTnJJZFlYRms4TXNmY0ttRzdFTEFS?=
 =?utf-8?B?KzMzOS9jZVNSK0NCNHh6T2RuRnJkT1Awd2xWdzhJWFRNczVQeUVRcFJmVExJ?=
 =?utf-8?B?UlR3YjJZZllRelFIYVgvN1d3WnBXUG5GZ3ovT3FDME40RnFqeEt3NTlFUVpp?=
 =?utf-8?B?VHdIU3hkWDF4eUJVVUozem05SktTTGZ3WGFya3BqNkQ4emVUWHBXN0xCNnRo?=
 =?utf-8?B?bG9QVUQxRlNscHliR2xqbC9SYis5SEJFeDlnMVFyWmFrR2hjeThWRWJpU2Fy?=
 =?utf-8?B?VFVOQU5FYTNhNUJFWDJnT3JqZUVEZ0dvUHlFMDBYbGF3a25CZzVwYWVaZHgy?=
 =?utf-8?B?VjQ4L2tMMGtnaG1tWTVyak5rRnZvZ2l0a2NHdHBKc01xT1pwcXVWc2MxNUN2?=
 =?utf-8?B?aFY3MnBEbzdBbEwrQm41RC81NVVvTU1sdEJwSjVMVjI4aG5tN2JianAyRjNO?=
 =?utf-8?B?Tml6ekI2TXA2QTJrZVR0Z3hJcFVScFdVM3duRWZPUlhuZ043UjVqTUJTdERX?=
 =?utf-8?B?VWUzanpvelJWbG1uNXc2Y1VVM05Jc3FwQUNyeHd2NllXM2MyaDVUT0VyQktJ?=
 =?utf-8?B?SEFsemJRMkNDMWVXK3Q4MmZQWDIvYSsxcTVmUGdaM3N1M2h0SEEvaTg5Qm90?=
 =?utf-8?B?ZnlZQmF4UnJoL0JEdjdzMGRhM3pqeUx6NTVtYTlDaWVzT05RNmNLYnRhamd3?=
 =?utf-8?B?bG9QMk53cGk0RFlMb245Yk1SVjVpYy93M1Y1bURRSUJGTVVQRnRDS0FpY3Nr?=
 =?utf-8?B?blNSMXJYTCtiNlBmbzkyMWhvaytVUVpkakUzRGNzM2x0ZE1wVTVtejFhd1Jh?=
 =?utf-8?B?QXp6TVZWTCt1VE1DUzlKcHM4OXJ1clVKYzVxNnhuZ2JrMTYwdlFKbGVxTTha?=
 =?utf-8?B?TmIrbFk2NzhmK2NUQUllS1VPTU5UTGkwNnEzNDU4S1NRSTE0eStmTURIODVa?=
 =?utf-8?B?YkJyRnFuSmowV1NCVUlOY05CcVFkZXFkYmp0VFFPdXA2VDkzdGdSVElPNm9Z?=
 =?utf-8?B?ZVVGUUh6VmRLR1ZybFlRNFJVRGh2OFR1QUZabm9zUjhibks2SjJSRXlRQ2s3?=
 =?utf-8?B?SFRoaXlYWS8rc211V1l0US8wWHd5UzErT1FaQ242WHRoampDSHN1Umc0bkFv?=
 =?utf-8?B?cktvTE9RbzNHemdLVlpRTWlXWGZGWXNjc00rSHZiQ3pUZjRKNXZPcmVCdVdj?=
 =?utf-8?B?RHh1UjdtNm5TeDBJeDlRM1AwRW9jWTJuVDNNU0FJaEpJMDJmdmVSVjgveVYy?=
 =?utf-8?B?NkpkaDRJanZlckd0ZlQ3SFg1bFVHaE5hMExlT0lMM0FjZ1EyazhjS1pjQmZl?=
 =?utf-8?B?c3B3SzFXSVhGTVBBNWI3TGZZVkM5NjV5d21aMjUvWmlHeS9QUFFOZFlKMkh2?=
 =?utf-8?B?SXJFcDlJUUsrSG5wZXJ2anhxaXh4dGJIZWpBZjk2RndQQ1FaT0N6SCtaQWRU?=
 =?utf-8?B?NTFPR2oxeUZjL3ByR0t6Q1NxQk4vYTBqTlJIVmZONHUyQ0R2VGV3bE1ROHV4?=
 =?utf-8?B?cXo4TDBFVTZaUjAvRzV2cFB1Q1pxd1VQdlI1RVJvSTA0TVpoMGhaVEJmd3dL?=
 =?utf-8?B?RkFZclhVVUtmaGVLRXY0QjFjY2ovOWswd0lZM1JnMzdMT3hpYTNicVdFK2pE?=
 =?utf-8?B?ektramlVaDViS1lERXdaN25rV1BvU0FERm11c3JGTmg3alExWkRqWjdLRHFk?=
 =?utf-8?Q?d5VE82JBL6s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6498.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bm8ybDd4S1JyMlFSdmZ4bzlmYjJod2lNWWtpY1BqN0tOWlBsY09ZeW91WHJy?=
 =?utf-8?B?UmVCUnp5alFpTHpjVkxXU0xoWFJ3NEZlZXp6VUEvTGFTTWdLOXlnUDBPb005?=
 =?utf-8?B?TGFZbDdDQVpsZUtNT1hoTEovaE1TYlU5WktadVhDRnhCN0E5VS96WXZCU2hw?=
 =?utf-8?B?Z2Y2K1YxZmFWQ09OUzl5aGRYeFZVR2VmVjZsZG5CdmdrbW1kdTNDbHNZcmZr?=
 =?utf-8?B?RVRQS0NvckVlRS80WjRlVVAxMFZJRXVOWVNsbHV3aGsxMmJQQjhVTUFxam5L?=
 =?utf-8?B?N0h5RFFDKzBLeTlqZDA4YUZJbER5VW1ic3U2ekRnSWpUODRlSHVMZlFOUVov?=
 =?utf-8?B?aHQ3aXI4UW9ZWHZvNTlYL2piWnZDOWhFQ2g3eGowOElXck10aldYdXJ3MWZG?=
 =?utf-8?B?OFZRKzkvVE1aUnlLa1lFTWZudzQ3RnpXQ2lMTGpBQjdZNkRJV042UXVrSnZE?=
 =?utf-8?B?T1J0QzdMZXZPOWNTNGg5dWRMM0RBaEUrbkJkMlN3dFpqekk5NkZadUhDRkhK?=
 =?utf-8?B?Mm1FWWtZK1d5RW11YVI3Y0sxSEZBQm5ZK2JHWHo2eE5EelNWZ2VJTlB2ellB?=
 =?utf-8?B?c1RQUGhUWjE5bWJVRkV6KzlGaHNVNSs1eWYyOWM1K1JOQXRkbllUS0I4R212?=
 =?utf-8?B?ekkxRnhCMitHdE4wa1Z6MWpGU1ZnTDRwUGRINmFYWUd1ZitwZUM3ZjZBdk0z?=
 =?utf-8?B?UEp1WGRNTWxCbk9wUHR3ZzVFZ2N3a3dvQkVGYURyU2hvRFBFVjJCZmFxS0JG?=
 =?utf-8?B?OE9XT0FJNUVJT0tNU0FlTHgxR284SHJKVis5MHdjd0dkeG5VN0FQYWhVWHZ3?=
 =?utf-8?B?eEhiRThyY281Z2ZkTUp6cHRyMVVPZ0lvcmxCTDdLZjl2dnY3QitWNVVDb216?=
 =?utf-8?B?L2hsK2d4QUZKaFMwc09GV1pYdlBZWWdLcEoxa01DWVRCV0lURmFaOG15ZWRn?=
 =?utf-8?B?WmdyNEhySkxDaERnY2pLUjM0bjRMYS9pWUx0NEU3WTM1b1RMUVkxVVpqb09s?=
 =?utf-8?B?dlpicUtMY0h2bEFWWmRsSkJ3VE9UTDVFdWQvaHl3MWtuYkdsaWNKdmgwRitJ?=
 =?utf-8?B?MDFJbEtNbG1tY3ZmZTBQZ3k4WWQ3emlXVTBOOUZxbUJsajdZZ3JMZnNLaFE0?=
 =?utf-8?B?Z0RUY2VTOXJkdlk3RzVtUDJIelByb2lhdTRBdTJNd2ZLMm1hRHgwV3JNTDJS?=
 =?utf-8?B?dzQxVzVJZzZEb3I3d291RWgvRit1K1g1N1o2WDBIbmp3aFZERDFSVkZpR21I?=
 =?utf-8?B?RStzYXZYRmpXc3dZNnZGN2dMczNHamMzYkFHRE84dGpYcEk4WVhUUHhkVHQ4?=
 =?utf-8?B?Z0ZZZmF4emxpREJZOHRON0dhcS92YTdHSDZESEV0eHArendhdHd0NUpVaUhK?=
 =?utf-8?B?ZU83WEVqUG1rWmlmcXpmeXBvb2ltNWxuUUVLV04yV0xEcUZnNmk5bDhjdldy?=
 =?utf-8?B?OUIyK3R5RUwyRnI4N2tZR0lsSjlxRXdzSTlxamZST1JoQzJLcTAzTmhZdUtk?=
 =?utf-8?B?UExHSU15ZC9mcDZzRFd0SXFQVjgyZ2dUS1ZLYld5QktVZC9hQTNDN2xrdFRw?=
 =?utf-8?B?TElPbFlsS2gxRTFuRzFLU0NmMmtvbHp6T1JZUEtsVWZTdXlqMUN2QkdCT2dG?=
 =?utf-8?B?elByVkZUTnFzRFMrY0ZVUjdLdWtLdUNUbHU0WXljbFpQN0UzSmsrYXVKaHlQ?=
 =?utf-8?B?akkyN2RoNk9rQU5oVXdHdVN3cG85VEtIVzlhMmgxZG9ySUsycG10eFhyeTNE?=
 =?utf-8?B?a3NwSTdWNy9CU3U3cGFRZXRaMHRYdGgzR1VUbGQ1QzR2UVJkNi95YjRmdks1?=
 =?utf-8?B?R0NxQk44ZVprMWdzVnJBcWdKRzhNYmROSVVDa3IxV2hBVjE4bEJCWnljR1JB?=
 =?utf-8?B?TFdNVGllbk8yZEdzWi9iNzFnV0pSS2hpZVQzQnRVaGRxUDNGTFJ5Ujlpelpz?=
 =?utf-8?B?ZG02VmR0dklUdVNHUU1PUEkxa0dtYzZlTmQwZGg2L1MrQTVXZTNPODhqNzNk?=
 =?utf-8?B?NFVpR0tESGMxZXJtbVU2eW1KaHBDR0U4dmRuWUtYaGxiNGU0T2tZQVY3OXht?=
 =?utf-8?B?WVExaG5xNFg1U1FoakNvamV6M0MwN0VCQXZiQU5QK3dpQkE0WmZHTUY3RlZx?=
 =?utf-8?B?YnJZbjZPM010Rzd0TmliY1FFcS8wUmY5NndodFpYOFd1SE9GdHhCTlBrTVh5?=
 =?utf-8?B?ZXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ec6e7b-fe17-40e1-c76f-08ddec5d1464
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 09:17:48.9406 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kRVnP6nl+71LQS8Si3RqymEv35j2g3CNbl6m5K+eLC/x9Vc5OJxmWnGLwxELDA2SUF0F2LLF0I6EAxzLTNZoWKhK2g/6yoh/F1Z0RqR2+8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8943
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

On 9/4/2025 4:49 PM, Robin Jarry wrote:
> Hey Anatoly,
> 
> Burakov, Anatoly, Sep 04, 2025 at 16:35:
>> I have been trying to reproduce this but I'm unable to. I run some old
>> CentOS so I built GCC15 manually and tried reproducing with that. The
>> version I'm using is 15.2, could you please retest with latest GCC15 and
>> see if it was fixed?
> 
> I am running on Fedora 42 that has GCC 15.2.1 and the problem persists.
> 
>> (if not, I'll try to get a more recent distro and reproduce again)
>>
>> The DMA mask checking you're referring to is there for cases where e.g.
>> in a VM the emulated IOMMU will not have full address width (39 bits was
>> common at the time), and thus we couldn't use the full VA space for IOVA
>> addressing, and had to resort to using real physical addresses (because
>> kernel ensure those are to be within support range of IOMMU). Were you
>> running this test in a VM, by any chance?
> 
> No I am running on a physical machine. I tested again without --no-huge
> and 2M/1G huge pages, and the issue persists as well.
> 
> I tried both as root, and as a regular user.
> 

It should work if you use --iova-mode=pa (even for VM case), this will 
require root though. However, I don't quite get how you get the error 
that you do.

Specifically, it's weird that your DMA width is 42 bits (indicated by 
"using dma mask fffffc0000000000" log), running on a physical machine - 
mine sits at 57 bits, so despite having VA's within the same range as 
yours, this works on my machine because my DMA mask is much wider. Maybe 
there's a kernel command-line of some sort that limits your DMA width?

At first glance I don't think the issue has anything to do with DPDK, at 
least it doesn't look like it does to me. I do not see how DMA mask 
width would be affected by libasan or GCC15, to me it sounds more like a 
kernel configuration/HW setup problem.

-- 
Thanks,
Anatoly
