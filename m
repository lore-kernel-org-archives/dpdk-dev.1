Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E81F46102
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 12:49:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F58440268;
	Mon, 23 Mar 2026 13:49:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id BD5574025F
 for <dev@dpdk.org>; Mon, 23 Mar 2026 13:49:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774270160; x=1805806160;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZgYqh22QecMzcKexZJNf51v2YMgP0uk/CUFmUNWlPrc=;
 b=nYgKZXFM1z7EnqH9/IusRD1J19jCV5EeA3BtLJ7USvn4BN9oki7dIwbS
 IbkPe8XVrdAjULOUJtBZbHJ1koMzdneAbeokjt6WC315Ulwkn+lA7LBxi
 gXjzRjvU0G6LUPbXKOyvxfl0IT1PaQnqA2OXdC+0XGLvLlRqGhznab/nu
 UcMFbOsLbTENku53i20B9l2rdkfLq6gPrNJqZATNbf9uHRxFl+sU0EQgW
 QJqap4QXHTOW5fpecRGTx1Ckf8DNByVUhaNBqPIsEZMoXwHiVVZMxQl/Z
 dxgIQmuRzAIFObqfH1Bcc9v8RbeW49GBvXIrd0p72dDHtYruWPaQ9RDcQ A==;
X-CSE-ConnectionGUID: tZKopx7/QFKPJLEL7o8zpg==
X-CSE-MsgGUID: o9Z7hjTxRsOvukXZxYiVdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="74445087"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="74445087"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 05:49:19 -0700
X-CSE-ConnectionGUID: KDVp50uvTOaq0JeR9kJosg==
X-CSE-MsgGUID: w/VCLTjURAuZwgFp9BIecw==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 05:49:19 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 05:49:18 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 05:49:18 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.60) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 05:49:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U02VKVD3nU9trEaqCf/0JUdnTL1eDpgPnYZMyxQkcr8tDhvj48pUGmOf97Bv1gATa6kpEzeRGlZdvBLvpkmLuoP1x5B/Tei77pGaEIXdXFQFCNf9jkTMy0bkFPbF8Oe87Xi655fOoOtqJlJypJiRv0F6T7gLkDrSdiUru1OeF4y6E+gr+e6RF5eiYdftnLRCTjONwEwGtbtyxE78jnR97zvyJEX7usifkSLYxiOhPjWu7zfEDzhK7gaJCX2Hfqto8e1K4cfucqv6dbXXNtEaJ45ovxL+lSG0VTaepWRAnHO/wfgybm01v46dXAzvOQl+uivLDyH4oB1rHEV+l6earg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOs6q2hsonwEVhqmObbvBsOh34+VJsb/XFQpwUu/LS0=;
 b=HW/zEvWV/P2e0v6GkoI3Hjc2cmzlm6C82qE4rribnX4iO0K5F6naLo4W8592B0rsDbOIoZSInduwrolXINzolUJZQyuFzlPko6wr2lNmhcvx4NqkNIMgVk6GnNbNAV7gWnK8gUjmvrzgxEKtaFjV0ffixo8hp6sl+4S7PNW+OIjPIZPzzFsXOkWokD8w0aulUXYJ98WPn6tRXV96HsWJzfJTVO+j0sI2mH5cP0JlEvXDHsPxZt/yzopQ8d9ewOwSAC5dIo83A9czrXIrTaiwGzk3lJBVJaNEOfcHrlolxP0pH4cH20UcH6VP+QkWni58OuElJVSU6bkbx2fjR/sm3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by LV1PR11MB8789.namprd11.prod.outlook.com (2603:10b6:408:2b4::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 12:49:14 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9745.007; Mon, 23 Mar 2026
 12:49:14 +0000
Message-ID: <22bebf4a-3801-45e9-8ac5-726cb6c89721@intel.com>
Date: Mon, 23 Mar 2026 12:49:11 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] VRF support in FIB library
To: Maxime Leroy <maxime@leroys.fr>
CC: <dev@dpdk.org>, <rjarry@redhat.com>, <nsaxena16@gmail.com>,
 <mb@smartsharesystems.com>, <adwivedi@marvell.com>, <jerinjacobk@gmail.com>
References: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
 <CAHHRULVmnHih3BqoCnMv-FEj=aC3LehgCFaVhh=0eQ-SLsovXg@mail.gmail.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <CAHHRULVmnHih3BqoCnMv-FEj=aC3LehgCFaVhh=0eQ-SLsovXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZP191CA0032.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::10) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|LV1PR11MB8789:EE_
X-MS-Office365-Filtering-Correlation-Id: c0333231-44e8-40e9-d601-08de88da96a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: mjYDjsPIm63oBwk6mYt9ESrILewjVtKhYfjcar2oBQlneitf41vv2ImFVjAZfak15nMFvbruKjeuSTnhQaJoyMqn3kD6lAG5IDENMp5dPlSfzlRJm+ckVV9/8b5NQDnqHPO51R+KsbJqSS1NXdmIsExVwCbXFBSi4Co4mMr1Tjy6foGNCRF7WK4i/DjbqAylI9U6xvKzgwx0mz2hymEpDEAFAwm4QSn+Nb3+QyhmwtS58iNBFhVi2JGBXfkKZkBDmj6wldJ3GQLdqGbuhT/F3a65iI9ajXp9IQrQTL8A48hQmIdf42Q45WtficDCpfTEeM3LiPIY2NmiBStpL89jhjeYFhZXpKmSsFl1U9MyQNLVFphOBxNqgB+jgc7UC7eZKmbA/87dC4PY149Yy6uwI1eyPwAGqQ5urjoa5HPTrzpQncaR7hMg8SZCc03YxAP90NyCePl5T/7Spg6WowQanZpH66yJUAGpbqjw0nAW5x/NW8Ba5YkAy8XjxG+rDKRaXhedL8hTkBpr2RK8J4vKC8tTEKQOucCoM2axSrFe6Aaq5SMg7z4qeRICBsBrtRUiwDAsgGusgdasMgzf91Rh7rRz3enosLJFV4KC359w8xIoC/fqbhze6pVr/ep9BO5DYYudG7YLL2B+xXYLZ/wlSJOCt59RuGRE3m+2BMsDHsA2g5yHaV8ZIgMmjDBZlt8Awnj//dSzlsBxiIy4J4zE1llxoQOUQN4fUcdt0k/9coI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkNtRUJRTE12ekxYUUFCREpKNG91eFRBQlFIL0dxd3FZbzVSSE1DT25mcTRY?=
 =?utf-8?B?MXl3eDNBOUpzdFRGdGlIYisvMHhJbUtOdXFhblA0RzJlUFduSUJTSG1MZ2JP?=
 =?utf-8?B?UW5TZzNUV0c1cS9Jbk9iT2NzeGNwUzVXOGFUQm9IdUhEN1Nxa0kvUjk4SlJN?=
 =?utf-8?B?TEhwMXZyUmJTL2YwbUYwc050YTBjc25seVBxNnVCcGk4THdITHdISmFiVGVP?=
 =?utf-8?B?VmplbUlSRFZtN0s0Q0ZNbDg2WHM3SDJsV3lyQXZNeXpuQmVITC9xU25BeFJQ?=
 =?utf-8?B?WVBJN0RJeG15NkJZVVRFZzRNTDlRRk92dmhrUGlaWDZLNHJqQXRSbW80S2Mx?=
 =?utf-8?B?WldvYnlDYy9pRjhyZU16M1ZReXhQd0JkNTN2ejA5bFZ5SVQvQjNLVkxvK2FO?=
 =?utf-8?B?ODVMTHpPQm4rSElEUHhxVXUyLyswaXlqTlRwS0tYODE2c1FsemNxVDhDMlE3?=
 =?utf-8?B?N2lTYUg0NEd2OW5LRWo0QnFORGEvS0tPTGQzbHlzMmxWNkJSTGFBWjJUMHMy?=
 =?utf-8?B?Sk14cE5wNkp2OXhPZjFJNFNteVdyaEg1ODBOUkFRTFI3NTUzRzBtOTcxek5v?=
 =?utf-8?B?LzNTZmtXZW0vMHIwQ21pQXJmNkFUc3VXY25rZEg2RmV5cndRMUU4aVNJNG5z?=
 =?utf-8?B?N2ZhOXlQbjRVZnAycWk0WUZFMkxsUWk3Z1NQY1ZMWUUzenNhTXJ6ZU5LbnFR?=
 =?utf-8?B?cjMwV0gvdE5wYTN5Zk5GSzdmaEo1MDF4UFBJNjhLcW5qNWNvZU9yTUloWUo2?=
 =?utf-8?B?cStKTmFOb25IVjFDVWJlZlJqNVpLTzJpS1VIUjZvTmMvbDFmcThCdGJxSkl3?=
 =?utf-8?B?K2dPVlNyVjdFWmYvOEpRaFQ1QnpYaWxJeDJINm95dU9QK1J2TTk1cU9XZE1j?=
 =?utf-8?B?L1RUWUM4VitLMTk1aklIMDdrQ1ZZbVhUTmVycUF4YmhUYlVSdmgxSnBtOEtR?=
 =?utf-8?B?bWZtanZPbnpiT1l2VDYwTmhjNklrUm0rL3UyYm1JRXpsMmJRVmMrd2dnUDdG?=
 =?utf-8?B?N1NVRkRidDEyL3d5K214bnZYelJkcGMrMm5xUEp3eXA4dEFVTGcyS2ljSWl4?=
 =?utf-8?B?WHVpQVNPdXl0R1ZyY2VqZnZZRGpVTFBiTW1JK243Tnd5WGQxbEwyaXJpakpB?=
 =?utf-8?B?Q1JHakpNamRVMXNDeXh0bzBlUmNlQTJMM2xFcGxjZ2NPR3dxSzUyUHljS3Jx?=
 =?utf-8?B?bE01MlhPbnRQQkZRM1ZTNWQ3bWV1dWFCc2pwSmlNL1REWVMxVnp1KzR3eEY2?=
 =?utf-8?B?K3VlZ3lIanl4cm9IVVduVVRPMmlLWlNsRWRFQVloR1g0UkVMWmNxaFpUUXhT?=
 =?utf-8?B?aXp0VFQyRnFWK3FSdVJrRDhPQ2tvdUc0RE9lR3JDMnptVWw2Uk9iR3hOWk02?=
 =?utf-8?B?RmZsUHAzam90cjdlcHgzMVYwNkFIbEZaU05KeVFqYUw1SUNZMElSQkt2Z2NU?=
 =?utf-8?B?WUpmdlRMVS8rd0w3Zkwxc1labURPOCs2T1RQSVBJWWJUMVJPUEpuSkY5OUNu?=
 =?utf-8?B?ZWFJWk00cW9LNkk3SGFscks0WUFocnV1Ylh5YXBCOEJJVlZ4NkZXQ0NHV0ti?=
 =?utf-8?B?TjdScVY5bEFMc05TdnlVS3E3TUczK2lxSXZtK0pvRk1aVXZFV3NsTEtBRzlZ?=
 =?utf-8?B?NE9VTjUzWGh5a0krNkVwREkrWk93RVVEZE1kNTNGVWVXMXlMcm9WVGdETzRL?=
 =?utf-8?B?cUhGamRxb3RIT0dZREo2Qmx0ZUFwQkRzK2Q1NGwzMEJkVjJoT25UZGNSTUFQ?=
 =?utf-8?B?ck5WOWoxUVFVRGlKa3hyZlFOZk1nbTEzL2JDaitNM2poRVRTTHRGQ01memlj?=
 =?utf-8?B?bFBmdW9NNmdrYTc4RjhpaVVOM25ES2ZadFZublcyKzRwa253YkFQNVFQeExW?=
 =?utf-8?B?UnFVQ0hqNUdoNUxVa3kwUW8reTJtZWNBRnRUTGNNS1RQOWt4VksxSmNQMFJS?=
 =?utf-8?B?a0MrWVdId3ZnTWxBTHVDZnJPR3krN3p3U1F4czhDV1ZPNUVpWEJLU1RubndY?=
 =?utf-8?B?WFMybXRsdHpLZVg1NG1HRDlJVXQwdkxIbG9jWlhiS0VjakxMZ3c5Zmdvb09E?=
 =?utf-8?B?ZVVmcTJVYUNMSXl1azVENjJ6RHlvVm13QzFGaWx3elFiakh1UDFxdHZ5dU1J?=
 =?utf-8?B?Q1FBZGUzQlUyZjYvWWVYS0UvdkRXY3Y4akJDVm02MGF6dWUySHJUODJ0dUU3?=
 =?utf-8?B?RHExMlBiR3hEY1pQWlU0UFo5UWdvNkZjS0xKVHNZOWZaMGJ2bGdvSXphWDBm?=
 =?utf-8?B?RWdkUTZKSnFxNzJkM2hVZVR6dmwwd3VmV3pYMHhvSmVtdUw0WG9HWGQraDRR?=
 =?utf-8?B?ajF2OTgzZUgwVEx5dElpMHZMYmptWTVkMEZzd3FzUUNNclBFOUpBU05jNE9T?=
 =?utf-8?Q?D/q/B1bJusKtZwXc=3D?=
X-Exchange-RoutingPolicyChecked: VmTNbsgL2czhvrezVUsq7D5+pO8PTJOOwucAGC2bzbt/e0WKYrZfQPI+eK/IaY0jtqD2o9IxBecaFwt1+hvpvAdejvU0DAws3kuFS7Jn46GqcBj8rqWnbBLWh70obg7AvDn9EAxX3qRgIBxk7jjfpSTJjsej7b5QX/Z4yltnc0+3jY6oMSh2KVejvWsHqpFUfXniPqHqG0ZYdEkMQHiqSG7lIrOuMYcUxKvIIGYh6P3MGB2IyVyiFkj1NbccUgkqRFIsNb+7emvUDVVJiLBMRV9bAfUCHCSPewyzt0NKm7kUi/XLi2jtMbJ7YmZIIq9aS2uh3NUgPoDWn1oOMF+EyQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: c0333231-44e8-40e9-d601-08de88da96a6
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 12:49:14.6419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJZm5qN4biDRnBdR4MGYTbtcqun+JxlwRcPWIiAqAASjZ15L4wdi7RD5uCQtjze14cpoccWYPrTd0vSvRW1cKZTC+cSfCVht49Gwpaak9Es=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8789
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

Hi Maxime,

On 3/23/2026 11:27 AM, Maxime Leroy wrote:
>   Hi Vladimir,
>
>
> On Sun, Mar 22, 2026 at 4:42 PM Vladimir Medvedkin
> <vladimir.medvedkin@intel.com> wrote:
>> This series adds multi-VRF support to both IPv4 and IPv6 FIB paths by
>> allowing a single FIB instance to host multiple isolated routing domains.
>>
>> Currently FIB instance represents one routing instance. For workloads that
>> need multiple VRFs, the only option is to create multiple FIB objects. In a
>> burst oriented datapath, packets in the same batch can belong to different VRFs, so
>> the application either does per-packet lookup in different FIB instances or
>> regroups packets by VRF before lookup. Both approaches are expensive.
>>
>> To remove that cost, this series keeps all VRFs inside one FIB instance and
>> extends lookup input with per-packet VRF IDs.
>>
>> The design follows the existing fast-path structure for both families. IPv4 and
>> IPv6 use multi-ary trees with a 2^24 associativity on a first level (tbl24). The
>> first-level table scales per configured VRF. This increases memory usage, but
>> keeps performance and lookup complexity on par with non-VRF implementation.
>>
> Thanks for the RFC. Some thoughts below.
>
> Memory cost: the flat TBL24 replicates the entire table for every VRF
> (num_vrfs * 2^24 * nh_size). With 256 VRFs and 8B nexthops that is
> 32 GB for TBL24 alone. In grout we support up to 256 VRFs allocated
> on demand -- this approach forces the full cost upfront even if most
> VRFs are empty.

Yes, increased memory consumption is the 
trade-off.WemakethischoiceinDPDKquite often,such as pre-allocatedmbufs, 
mempoolsand many other stuff allocated in advance to gain performance. 
For FIB, I chose to replicate TBL24 per VRF for this same reason.

And, as Morten mentioned earlier, if memory is the priority, a table 
instance per VRF allocated on-demand is still supported.

The high memory cost stems from TBL24's design: for IPv4, it was 
justified by the BGP filtering convention (no prefixes more specific 
than /24 in BGPv4 full view), ensuring most lookups hit with just one 
random memory access. For IPv6, we should likely switch to a 16-bit TRIE 
scheme on all layers. For IPv4, alternative algorithms with smaller 
footprints (like DXR or DIR16-8-8, as used in VPP) may be worth 
exploring if BGP full view is not required for those VRFs.

>
> Per-packet VRF lookup: Rx bursts come from one port, thus one VRF.
> Mixed-VRF bulk lookups do not occur in practice. The three AVX512
> code paths add complexity for a scenario that does not exist, at
> least for a classic router. Am I missing a use-case?

That's not true, you're missing out on a lot of established core use 
cases that are at least 2 decades old:

- VLAN subinterface abstraction. Each subinterface may belong to a 
separate VRF

- MPLS VPN

- Policy based routing

>
> I am not too familiar with DPDK FIB internals, but would it be
> possible to keep a separate TBL24 per VRF and only share the TBL8
> pool?
it is how it is implemented right now with one note - TBL24 are pre 
allocated.
> Something like pre-allocating an array of max_vrfs TBL24
> pointers, allocating each TBL24 on demand at VRF add time,
and you suggesting to allocate TBL24 on demand by adding an extra 
indirection layer. Thiswill leadtolowerperformance,whichIwouldliketo avoid.
>   and
> having them all point into a shared TBL8 pool. The TBL8 index in
> TBL24 entries seems to already be global, so would that work without
> encoding changes?
>
> Going further: could the same idea extend to IPv6? The dir24_8 and
> trie seem to use the same TBL8 block format (256 entries, same
> (nh << 1) | ext_bit encoding, same size). Would unifying the TBL8
> allocator allow a single pool shared across IPv4, IPv6, and all
> VRFs? That could be a bigger win for /32-heavy and /128-heavy tables
> and maybe a good first step before multi-VRF.

So, you are suggesting merging IPv4 and IPv6 into a single unified FIB?
I'm not sure how this can be a bigger win, could you please elaborate 
more on this?

> Regards,
>
> Maxime Leroy
>
>> Vladimir Medvedkin (4):
>>    fib: add multi-VRF support
>>    fib: add VRF functional and unit tests
>>    fib6: add multi-VRF support
>>    fib6: add VRF functional and unit tests
>>
>>   app/test-fib/main.c      | 257 ++++++++++++++++++++++--
>>   app/test/test_fib.c      | 298 +++++++++++++++++++++++++++
>>   app/test/test_fib6.c     | 319 ++++++++++++++++++++++++++++-
>>   lib/fib/dir24_8.c        | 241 ++++++++++++++++------
>>   lib/fib/dir24_8.h        | 255 ++++++++++++++++--------
>>   lib/fib/dir24_8_avx512.c | 420 +++++++++++++++++++++++++++++++--------
>>   lib/fib/dir24_8_avx512.h |  80 +++++++-
>>   lib/fib/rte_fib.c        | 158 ++++++++++++---
>>   lib/fib/rte_fib.h        |  94 ++++++++-
>>   lib/fib/rte_fib6.c       | 166 +++++++++++++---
>>   lib/fib/rte_fib6.h       |  88 +++++++-
>>   lib/fib/trie.c           | 158 +++++++++++----
>>   lib/fib/trie.h           |  51 +++--
>>   lib/fib/trie_avx512.c    | 225 +++++++++++++++++++--
>>   lib/fib/trie_avx512.h    |  39 +++-
>>   15 files changed, 2453 insertions(+), 396 deletions(-)
>>
>> --
>> 2.43.0
>>
>
-- 
Regards,
Vladimir

