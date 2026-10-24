Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD99606A31B
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Oct 2026 14:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KndX0X4T
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0395740269;
	Sat, 24 Oct 2026 16:07:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 05B124021F
 for <dev@dpdk.org>; Sat, 24 Oct 2026 16:07:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792850872; x=1824386872;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=8i4KN4/DwLoiDRaLlQFThjlOnxC3CZcTnhmhiVKtKSA=;
 b=KndX0X4T+zcR6y/NRX4yARlaS1T7PjR4BRLk/pPBiEDmchhUN8ErU3tj
 ebhYyO8+V3sQBRtIzGGGYlI5uXUpxcNMl18UC2wpL21f3hooR6Qe5iUA/
 PcgsF0jW6udAyKQgvnld6Q0uCd9Y1RLlsjVswvf66Wsm0TbEK68ucXTQu
 h9G+17dwKF6IwzyvaFBmqrzB49LAaRuW6LouA1Nq3FBIqpjbmIsdNiE4D
 N+RU4gmrzC/n3I9fnq6UwRHDrFbLdFT482KA0KwjnsR1jO+mvviF9I3za
 3jOtqPfHGBebsNhSrPkhR8OsFqySHVpEFNrD3bSIwicP5hfoKid+vgiA/ g==;
X-CSE-ConnectionGUID: OuCRFP22SxyeypPG6yFQ2Q==
X-CSE-MsgGUID: 1dgtYzteQAOAQiuahNy1cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1478406"
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="1478406"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2026 07:07:51 -0700
X-CSE-ConnectionGUID: 5UzgxnfMQ5ekUZzjhKIjQg==
X-CSE-MsgGUID: FqLT+2f1Tu6h5ExNNt1Pag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="3743912"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2026 07:07:51 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 24 Oct 2026 07:07:50 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sat, 24 Oct 2026 07:07:50 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.32) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 24 Oct 2026 07:07:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXPOX6Oei/d9dpl8/+GSOttx//YonkD1NFU0CoxP4BEMn1rTy9f8W5hYwEnQ44j+IDJ9kEvUBg2k2artMB8jz2PUqvQVW5BbRDVTqIyE2fW/y5C2fRWikNXHYw+VPsNWtWhQZiDm0+vGVo72ReaKNTSzEAb6mpfKqoap48I+pgUNdwe8KF69KTwG/7xxXjeAtVHYRrV5fQuOq9Yrd+SEpwhmWvqo0MnWS0Uy2V6rUoldcT4e2RcXds+JnctKhOYCxQNrB5fioq2/eFpBMtG0esUXiuprIQYSFq68Da3jfcIYbEZy6RaTw8uOYmt9fwkuChluB9eITyxCo4heDaRHvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SOqvW6BL0mPoYyrrOiaFV9gz+LVU5zQsFUnhLh2XMQ=;
 b=hoLhuY21BxVWOJez8oHtD+DnGwTJqrwBORhhgymIWeXAWLKFeo/FwG1qfbgiUeXh5LeOgIZx88nVKraIHQQaPdi0T5NF0xBeq3Au2M68x6ccD+wCFoO6lnh9GECwY4PG9xcsucCHDYGt7+w1q7sB5YTSPbIsXpZQO672qIr4Qc3ZjjS28S6hdgt7fMBV8slV77veX9F7h5/SbpWTpkfFzio/2ZfzBGxakJzPj0vEkJ8DnbFX7FKEEuFv+C+OGkKBeai68/TJqWs/sSSVOGsvLl4KuYnTYZz3zXlyMmn+kvlkhJ+lnPU6zz18JZtEXD8s7TGpgCMIBKS4jywp2GFn4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SJ0PR11MB4880.namprd11.prod.outlook.com (2603:10b6:a03:2af::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Sat, 24 Oct
 2026 14:07:47 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0546.017; Sat, 24 Oct 2026
 14:07:47 +0000
Message-ID: <6b23ff9d-af6d-4b12-9bba-b21d92ff29b1@intel.com>
Date: Sat, 24 Oct 2026 16:07:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] eal/linux: reset FD in interrupt handle for
 uevent
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <hkalra@marvell.com>, Thomas Monjalon
 <thomas@monjalon.net>
References: <20261021092318.1554295-1-david.marchand@redhat.com>
 <20261024132138.7239-1-david.marchand@redhat.com>
 <20261024132138.7239-3-david.marchand@redhat.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20261024132138.7239-3-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0261.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::14) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SJ0PR11MB4880:EE_
X-MS-Office365-Filtering-Correlation-Id: bf717e8b-753f-4055-3351-08df31d82e36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|11063799006|4143699003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0tI1Rp1ERoCIQS2lGaIIZNpoY5l9NO9TBwwVfHoQW6HAwYiHqQQMRQkfDPw10VtXDw0ehUo3cr8Ze67CxhtCBZ+CNQzQ3yiQl5NL6GgdG1K7O4mRFPCvleHcDwEyc8IUHMXW4cnlGgC1Eo9jYVi1baEsnroliIW6V3mxPF5DR3qci0cfd59nhuPAwNPQKLdk49qTJZser0TCEBbwLnXOZXBkKgBI5yTgC0K8aLrk95SsAyDhkez0PK2V9PCV3xVQ1ero8ZvQG1r5UeBvk0nBBdtGqfMay+tp/uO1ezgx2sHw+6NL1h6FIKD+nBSaJE4yL324cC47XdBFb4KNKVYvxTkAQwL3FY6WfE6BH0CoTTkB/3dtQpH+mAzTtlekEvFEz4UHSQWghLWhwtnrV9mxTTlXp+HMEulRPB+CoWHyJu24ETeYiiNxLE4thwFZKBH3kkmin0RuQO7lf6l8StEZr6pmLTNnn31d1SMOw99LAqhQIeobMBtC1YO8bi92ZzDdpphM24tFXF/OuGFTDzgnvaE8xiWilUDUwqJtI0IW4lsHAinREJz4NUicy5gaFtu05i8lwIgd/uxLuRIAE5wBUodk9LwF261cIEPS0NleHU2uTzrQWWhTINdHF/Rqeyu3SFrMbpoWB6qg6HLN3ZzxtRf8kf3m5L1f+a8vNLiovr4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(11063799006)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmoydlNSamdBMDJLMytaUitucTZZWStBUGhuVk9FSVlJL01nOVVTcW1aemlH?=
 =?utf-8?B?UW15YkRoOERtbmNLaGZxQXNVZUlYamFyMXM5RUNPTlp0MkdpZG5iNDJWUjB4?=
 =?utf-8?B?bEhIaVNOQWxXMUJhZEFUelhxd21KUE53UEVlMnVEZFJxZlhJVGRLZ0Q5NGRo?=
 =?utf-8?B?ZGxCS3laTDNvOFZIbjBKbnFhaDhiNkV0ZDRjcHBZZUhaK21qS3ZMRkduM3NH?=
 =?utf-8?B?QUZPTmhGQ1ZUSGtET21yK0pTc2tTTjdUWmhDcjV0YjhmeEdhekduT3RiaWM4?=
 =?utf-8?B?a1VpeG1IMWlIak4xOFRJdWxYbTk4OFlGOHk3U1UrZVVnaEpldy9SclVreTNn?=
 =?utf-8?B?OWxTb0FvdXdHWURtQm5xV0NTRzdpdnpEOVlQOWRmcElGVk4wQ2FsMUJHaFhH?=
 =?utf-8?B?c2xzVUpUSlZLMTUzT2VZMnhEQjRPZjNWem9XTVlUK1ErZlVFd2lGeFJvelVu?=
 =?utf-8?B?bUFVeHBmSUJFUXZKV2NRYmwzUzFaUUhOejREbE9EN0FUNEErdDk2cnY4TlRJ?=
 =?utf-8?B?Zkh1cDQ2elNvbUQvSnBGSW1GMUUyOTJQRVM4bTkxQThCTS9EWTdWcFhtem1V?=
 =?utf-8?B?Mm5vQXJtWVJuNjdUT3RUVTBCYVFzUWhoY0VHbWVGZWR4VkI5cm5QbjU2Vkp1?=
 =?utf-8?B?WkYrS3VWK1htcVEzeW03ck8rdXVGaFRHV1RjMk8wRnEycU02VXFqM1ROd3NP?=
 =?utf-8?B?ZzBQdUZ5SUtxRHFKdkQ3NSs2V2UvWEFCMUlKcUVHcGFHajhUNkw5VmdoNEhh?=
 =?utf-8?B?MVhiMDA1YytrckFhQzJDVjkwWHdTRTFSaEVNTmdwL2ZQVzM5UHAzVUN6Z1Ev?=
 =?utf-8?B?NHNoTmxYeHVoYTAreGpUOUJsUmVscVp6S1ZDck9YZTN1YmVOaGlFc3FVU2Iy?=
 =?utf-8?B?c1ZiOG9taUVucjlWNzdFRi9sUlpqYXlFTEVMRElqUDFiODFzcG9xUTVidVdj?=
 =?utf-8?B?ZS9VcklyU2ZmTmtxazlLSjF2ckVINVhLOEMrc3FrZEZNTDFGMmdFQ3dEcVhV?=
 =?utf-8?B?NDQ3ai9Ob0NERG52dFZpVUZGU1NjUzh4Tm9Va3N2cThJcVZERE9HZE91SmJY?=
 =?utf-8?B?YkdVL2RnVHlnV2NxTU1KbE5GMGk0NlJ5K0ZwWDNFOWU2cVU3dEpPSEsxeHRK?=
 =?utf-8?B?QVJyUGw2b0hMTnVrZzdlQ3JYZ0xwK1o3VjBTbjVCZ2dUTlJ1aFFRQ1JkTEpU?=
 =?utf-8?B?Q1NTaEhrTDl1cDBDaGRFdFJqL0s1MGpHWDZFekJtcENtUWJkVGdJM0V2NTBZ?=
 =?utf-8?B?cEJrM0oyL2NMQUE5R29MZWY2dWs4eFNLZUlOaEFNQUxIZS9OdldhaGRkYkMw?=
 =?utf-8?B?aEs2OW1XM0cvdlZjYnZ3bjViYzhpL2hwTWdNZkJUMkZoalVSbldJR1VjSWRw?=
 =?utf-8?B?bDl2Z1ZTWXpRcGpXSCtOVGZUVlMwQ1VnS0ljWlc1Q05MMmNQOGNzcUdHc2hj?=
 =?utf-8?B?RzBEWS90L2hDUUxhdG5ZMThPZWczd2lhaUZZYnVaZDZuYklKeEhIbmxnQjNL?=
 =?utf-8?B?RndiQ2lmQmtNSnVtOS8vdWlXTHkvYjg4VHZGOHJJK0IwRVNOZDhNS3dLeisx?=
 =?utf-8?B?SVpSbjFuelJEWCtSb1BEc3pyWVFLOHlPbk5naXR6UFBodVZ4bEFtemFrQ1Fw?=
 =?utf-8?B?K3ZJV2V3WEVMbytieWdWakd5R1RiekgvUTJlWG15cmhZR051TVFjRFA0R0lR?=
 =?utf-8?B?R3o2OFdGUElKTng5aU9SMlF1Y0xLc3hlWHZtTnRYL3ZnVEFsc3JlaEY4a01B?=
 =?utf-8?B?dUZTelZsc2krVGRtOVpIQ2dMbHZzdXQvQWdsSVNKSnVuaTlNYWdmQVV1TnZD?=
 =?utf-8?B?UWlZeGlGVDNGSTV0a1NRanJrb08xdTI3dUdvbGxyL3Q3enNvcVMvQ1lNTDVH?=
 =?utf-8?B?bXFjd2pBUTN6a0ROZFdUZFlna0tWd2xLRkJUV2lTdjBmVElEbkc0NTk5SVVQ?=
 =?utf-8?B?L2w2dHo3UjBvSUZRNzhJYTBzcWlISHRFKzBSWXZoSDZXVXpRTW9nL0VMYTR0?=
 =?utf-8?B?SjdodzlOOFpoUDg5c3EvQXQvckVtbUMyY3NLLzRJSzFnM3BKNE80Yzg1Mlgw?=
 =?utf-8?B?MmcwS0x2aG83NVdoYkdkMm9JakUzOHVQR2NQb281YTh1WlUvR2JQaHcvbUQ3?=
 =?utf-8?B?YTMxc2QvTzNEdWtKcDQ5Mld1dFJhQnM1WkJHSHZOVU4yemQ4NDByS1VOT3p3?=
 =?utf-8?B?ODhOQUFXOTdpZnZsSFJGZGdIVjVKNDVMeFpkTXhvQTd1Q3RVVi9leUcyZHF2?=
 =?utf-8?B?dm5zUmlHZ25KVldHRHV2YmM4ekhDZUhkcGkxL2tVc2xRZk8rT0ttcWZ4MDly?=
 =?utf-8?B?UXBDWHFucTMxR2U3c2QrWmhweVFId2NQTm1HMitRbmdydFZ3T2duZE11b2JX?=
 =?utf-8?Q?aQ0XSsD2B8RJtHmQ=3D?=
X-Exchange-RoutingPolicyChecked: j1eXsWQycAEf5jiWxPOoJuBfkiZ8Jd6fGwlUyTXwZdDKg5Yr3pm5Ru833Oo3v/ur7NaLWzY/+clrSiWaGvdmTL+nt0aw/N6gU6DnqMbpwghqBnxzNMSI83jHQiPx5td5CUNd1gmiBd2c4NzGpeVPMNzha+VDBEWwjprz6boLuH6PVkkks8ABG7/fy6kWRW1Whf7WCrAzzZMH70msRac0U//2I///F+IcAQFmO7C54WjYFAt1a8zZ3ar+a18THhkzZMGAlmRXIE1GibbiaWlAFccLdhLZ2iII7gSLQppshdbAbMt+OTgvILorUhavi2RC7kbefobjh4WPtWm3nT43Ow==
X-MS-Exchange-CrossTenant-Network-Message-Id: bf717e8b-753f-4055-3351-08df31d82e36
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2026 14:07:46.9245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N0KDPOLIkOfXlWRkitGETjki423gh8x+x+TCer4vKGiip3vMLJ6nh7UgPZBjLxeyZs8GAJZCB33SH/Da2LO9NW4zOPzkPCFiDbUNTHicp3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4880
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
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/24/2026 3:21 PM, David Marchand wrote:
> Clear the warning when freeing the interrupt handle used for the uevent
> handler.
> 
> Fixes: d770ee9caed0 ("interrupts: warn on leaked FDs")
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
