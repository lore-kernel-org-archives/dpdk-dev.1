Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87F5CAC583
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Sep 2025 15:18:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB7A940281;
	Tue,  9 Sep 2025 17:17:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 2D43F4026D
 for <dev@dpdk.org>; Tue,  9 Sep 2025 17:17:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757431079; x=1788967079;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=V8QdLBQiCiKNH+vYtLFCFJvfi7JIb8cmw2zr2y3DKaM=;
 b=DtKXuflwuNzN1o63UoYtovV4ng3UfEuTWLR/XmMlPTucLlY0E5sNwx6T
 M4Cht6rVQhEKUT27JisjFfj/zx7FFEKYRxzDjgkiBIdBH0bGOzOFsfYvM
 2wXcgmOsrnc+16kpp9X2ZlZ3O/UcvXpka9zR2VyG0P1A9qWEbOh8PoAfF
 0Sid1WCCv6huJ/agmccjB1TeWiyxuxQAtiO7OqyX9lz2FnxriwVMuJVPQ
 h0KywjQJblyqVLomruOVG400zdtPEN77urXJmzhmLoiJxG9aFdKQFx4mH
 MTcJp9t6CAFk0P6CJjVLRdXrowZ6Jkr8JPcez7ASYgaNYwqFA4v8nFiVq Q==;
X-CSE-ConnectionGUID: mti/utxeQku6tJ9dT1CKVg==
X-CSE-MsgGUID: Pn4pbvf/S724LC+svhqq6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59783676"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="59783676"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2025 08:17:57 -0700
X-CSE-ConnectionGUID: 4GZJbU0xTJyHj0W50AT+OQ==
X-CSE-MsgGUID: IMIEKut0SP+6j5eb2vK4uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; d="scan'208";a="177171789"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2025 08:17:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 08:17:56 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 9 Sep 2025 08:17:56 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.47)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 08:17:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+9sbgeBJ0uOuh8//ZarkZIvdvcmu3i/lhkS7TpIXA3eU6ZylvXUzCcjw6GmLORV2u3xiYS02Tvz5q0nzgfp3zGBPvb+8EBEcdxGIMTmatm6kP62Lg5fN1JfanLVL9siWrAt/iJolfhrbX7wIVJmt9zWBTsChthHe5Rk1hhhrLLeqYf1FKH/+sKDgoia4bVV4NdMgH5Y3JGUPhoeWyPz17vjBSyt7SwTwfwGXIXtLcB1G11lgkVp3A5wDsUOxl9Tuscy3kJ4+TsuxUoUVLSwZt0osCb1hXEsSRNmnSyMwCqM5JDHKt0VpjlKZrIGJhKCTtKA/2zxfEgrnhNowZ29tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l37fkKpvj8hsC3XYU5p8ZVjn+nUtIjyBxcmtXbLFMDg=;
 b=u1u7381BBmzwV90Bg33IbmixNqLig7H/ZdBUWgYhsxwzkakJDSwO04XHpBDTpcC8kZL2T8SCC6nmyDEQ4d2wGok5ONem6+6Cn7jqZN6cyjWfYQrA7YUT6apEC833uj/f9Rk46rmh/mr9YqHHV6a6BuDc5QczAoDQdxzm8LMNlAEVZVjrafXgyv0vgXPCFkzwrXqiRZI+yuT3ydtdSvEGWp2W+zXs7m7uFQjjaZ3hE7uv1JJQQtxPttT65yD5Nu106ZrZMu7v8W7Z5VdmM1jveprmP4T+3zI0daTh7j5OeiByTwNY8LoM9T98l4kehi5wWEKvSi3BrMbU5p1ZrhGSAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 MN2PR11MB4614.namprd11.prod.outlook.com (2603:10b6:208:268::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 15:17:53 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 15:17:53 +0000
Message-ID: <fc0358aa-57c8-4725-a7dd-c0591906fda0@intel.com>
Date: Tue, 9 Sep 2025 17:17:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 3/9] vfio: assume VFIO is always and only present on Linux
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: <thomas@monjalon.net>, <maxime.coquelin@redhat.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Vikas Gupta <vikas.gupta@broadcom.com>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>
References: <20250903072826.1727004-1-david.marchand@redhat.com>
 <20250903151800.1965006-1-david.marchand@redhat.com>
 <20250903151800.1965006-4-david.marchand@redhat.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20250903151800.1965006-4-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DBBPR09CA0025.eurprd09.prod.outlook.com
 (2603:10a6:10:d4::13) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|MN2PR11MB4614:EE_
X-MS-Office365-Filtering-Correlation-Id: a71ab7e3-9eaf-46e9-7cb7-08ddefb40bd8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MS90MFlzVVNYOWg5WFJTaEdFQUNZSVNybmZMenFURTBqRFRGbm51N3VTNEUy?=
 =?utf-8?B?VEwwRG9ha0tnTDZvUjZHQ0dzdGZoeDI1V2dETG92TGNhWjZKYjJNSGdwSWN0?=
 =?utf-8?B?N1VrRDJVV0t4WHg0RmUzcS9sYzNkdyszKzNmUTZSZFQ1SFc1T2QzNE5uZm9o?=
 =?utf-8?B?cEE0WWdsOGtiSGFaRFJMbmh0dld4WWhxRTFsZ3k0dXRDdE9Ha3JIcEU4UGcx?=
 =?utf-8?B?b042Nnd0RjFWWGEzaytvYUZoTU5rSU94bHhwcnFhQWRmOUFJNkdKSXpNb01i?=
 =?utf-8?B?RmpRYjF3ZEdxamk1RFMxT0hnMGlpTmRRTlBnRmY2TUxQcVdPRXBHaU5MRklC?=
 =?utf-8?B?bW1SYWZyM2VlYTNGSGhKRWdFQnlOYittZzk4aVQvY3VhNEhvS2VjMHdOeGJi?=
 =?utf-8?B?d2t0emRxc3JIb3hoMmJRZDVkSGllVFBRZXA0cTNwZjVVWng1emZhN2VWWUtj?=
 =?utf-8?B?ai9aVnB5dkJvYW9abFdnZkpBRGY1QUZsR3NCTk8wMUpqY0QzMHBHbUpiSTNl?=
 =?utf-8?B?Rks5Zy95cXJXbEdKR2pqcFg5VFhaa3BJd3d4ZUUzVUpxUVYrUHA1a2dSSjJO?=
 =?utf-8?B?QXV2QWJQSC9NSUVsUmpFaW9EQ1V0UVpUenlURGthc3EwZzRQbjUwZG5LYnZZ?=
 =?utf-8?B?ZDR3R2RJRnhXS2k3REFVN004UUZPVDBtRmcyd0laTmxTSlVxZ1FWd0hSdHla?=
 =?utf-8?B?UHBCSHluOFZ4bkxqRUdOdWJpK3F1N1hJeUd4Z2oveHEwaitKeTdlRHNCWEdv?=
 =?utf-8?B?Y3BSNEpEQ08rQ1NSZGRhaVg2VitvdWQzQkJGN3AxaXRidU8wYkt6bVAxSFhK?=
 =?utf-8?B?YzF4dTdaVVdoakRvQXJXYkNzNmMyRDlIN2VoTFNuc0pRaVArZmZPcG9xa2Mz?=
 =?utf-8?B?ZVdWaGhKd0ZNS2huME9RRmJVVll2eUdIc3pISWRGeUNkVCt5SmlHbFNXOGl3?=
 =?utf-8?B?OS8rNWM4RC95UDlqNWpXMFFNS3U1MFhEeE0wU1hlZWZJcnEzdW96dVNiWThz?=
 =?utf-8?B?U29aV1BTR0pReFpCdGZyeThyVitCSUd6eEZZdEpXaTBWVzh2R1V3am4rZGZl?=
 =?utf-8?B?SzhUZkhOUHh6dDQwZ3hXanV1eC9zSVRheHIxeFU2ZXdVZno1ZTA3SERRMlJU?=
 =?utf-8?B?anovck9jUTFvRVdPZDlTV2lqVjBEbFZJOGIvc2ttMzVBQ0JZVnRSWHNMRDhD?=
 =?utf-8?B?R3Y1Tld3RkdRTnhRcWpOU2xQKzdvSXZ2QnVyNTREVUxad0tLYWI5b0t3bEx5?=
 =?utf-8?B?MWVPNURxcFVMeFpOUzFBQW54eW54UlJCRlZuRGlndjdsS0hkV3V1WFRIUURq?=
 =?utf-8?B?Z3JQV1JBazNHWFUwL3IzRi9qVEVKeDNtTjJjY2NYZUNKVU5EZUdmRTFWczVt?=
 =?utf-8?B?L0pqczZTODAvR3luYmhGR1V2Tmx5NjF6NmVUQTBwK2loSTBnSDhLTWF3MHQ4?=
 =?utf-8?B?UlFYZTM3MDZnaUlpeWlZVDhjZEx6OTR1NmdCSzE3anN6YkZRV3hiK0pIVzNM?=
 =?utf-8?B?WE1hSFhISkw0NTZ2S2xVSHdGM1lxSVBPMmRpZ0pzK3RNWEtFT3RJdUE3cElt?=
 =?utf-8?B?TmJza0UrYWFyVDM5eS9IMzlnMkdxRXJzVFBJbEM3WlU5SER4ak8rNG0xa1hl?=
 =?utf-8?B?dkdVN05ZdUVocitEN0ZydlNidDd3SlZRaWJvRGFaL0ZkTTlBWGR6dGJHZDF3?=
 =?utf-8?B?NmRjYVlYcjBMeU55cTd6LzFCODM1QzhMN0R3ZysxRlBrdUtLZy9Xc04rbWdN?=
 =?utf-8?B?OHN6UGF6STJKMnU3RTlySFNRUFk5Vk5xSWV5UUM5ckpNekJkNWJqSzNNd1RK?=
 =?utf-8?B?bWdOWjNscGVYdTBCNUg3a1NXOTN6bzZWYk5HOS9GODFQN1hrWE1sWndSMjlW?=
 =?utf-8?B?ZW5LSk0yRm4weHliNDk0cHhsczZSUitjSFRlbW96U3BzdFJKYXoxSXpvdkRk?=
 =?utf-8?Q?86BK+m7ES18=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFFpdEJhb0ZualNhK2dkWnJta0tsSi9tdTNNNkZNZWJ2WUpsRVhxckJ1VlZN?=
 =?utf-8?B?WjNJU0hDdVdOK3h5ZzcxZDBIdW9hdFRIN1NHcy9abG9zaTR4KzN5UEtLeTdU?=
 =?utf-8?B?VlpiRVVKME1NY2dTdyt3WnRlc0w2YWZCOTRjTTdTNGhJeTl4TVN3YXBBL1Qr?=
 =?utf-8?B?aWhMRlBkVm5tQ2g2c01pVWI4bVNTYUtzRm0rcHU3SkJLQ24zOEdBR05FdVZR?=
 =?utf-8?B?Zy9mc3BmdzN1Mzl2aEx5OHpSQ1FOK2h0bnQxaE5RT3RtaFUyUzJ3QllNUGdu?=
 =?utf-8?B?Vk13c1FsTlNGRkwxbTBHZldkZ2NNdExNL1RCMnFFQmVsZFVzREprelRiSjBv?=
 =?utf-8?B?U0JSMlgxUVlTS2FraFp4ZCtkOThjTDVJY2l6R1NvdjUvK0ZGK2M1T0lYTDhK?=
 =?utf-8?B?NTQ5d0VSOGFVMlcwYUJ5dThaWmdNS1VUc1hza1JvQ2paVTJpMHJlV1NyVWFr?=
 =?utf-8?B?OExLWWxETnpZRkxDODhsZE1Nd0NMdktEUmU1ZzZZK1BiZ2JxQVNiVjBjSkJG?=
 =?utf-8?B?S2JWdWdVM29mdU1BcGVkY01RK3JCNENYayt2c05lUFJFdHVvWUpMWHZPSE1J?=
 =?utf-8?B?Z1RvQ0VJTXhhVVA2QWx3NGJWTUcwNUZiYlI1V25WV1Z3T0ZNQlpKcjJqY2pE?=
 =?utf-8?B?SzRzVWJmQWhmVGhOSUNlOFA3NkhZU2MxZHJYcjA1cVZ0OUpMSFhIWnZJdkY2?=
 =?utf-8?B?bDhVSncrUkVhTlFKWi8vMHVJb09XN21xQTRiaDlLWUdkb1RpcjJlU0NpRTNh?=
 =?utf-8?B?Nitod0l2WElyTzY5Mmw4ZTI4QlhyTk5DbHlrLzl0L2xsM25mL2FBMGxFNHhW?=
 =?utf-8?B?MDA1UjNkbWZ2OS9XZ3VqTkMwRWhNbDExdE1pOUREWFhwbk5HenF2eitDNG1K?=
 =?utf-8?B?Y1BxV0VwMWFuRDNwVTg2N1FMdHhRRDJIOXJzQnhMMTBCNzFBeWdPV3A2U3R5?=
 =?utf-8?B?L1V1MUU1aVkzWnhOWTFiL1hqL0Z6OTlxeCtSQ3dDNlpwM3VMSTJMTkFPR2hM?=
 =?utf-8?B?NnRRaVNjSGtVblJoN1ZtMmxNeTN5QVowV0ViVlljaEs1b3ArWnVUYzBnT1Vn?=
 =?utf-8?B?ZjNKQzhkVXZKUjhCM0ZoS0dWd0Q4cHpCcGN4TDREWXhqQmtRZDJWSUFVVEF3?=
 =?utf-8?B?bTZpbkFCN2pnWmxKOEh2T2NyZzQ4aHBTbGxUMUpjQkpXa2VkbHF3UU8zQk8w?=
 =?utf-8?B?bUVZSGRNdHdUVFNnWFNjZVB4bVV2OFpSU2hMSEc4bzhxWG01NWtaVWIrVENq?=
 =?utf-8?B?bVhYdzVoNGhMV21QWWFoWktCK3EwNnhWQm90NkpKQStPWDBRWjBmUXNKdG11?=
 =?utf-8?B?UlZ2L052aU5RS3ZiRmxPUFlPeFpPSllKQ1NEbkFmajgzN1dBV3VYWDNaRHJB?=
 =?utf-8?B?RHZLSUh4NzllTmVtcnJqVE9TSEtqTWJ2VDU3QTJIaGJML0Z5SEhMVkZQOE9z?=
 =?utf-8?B?b3RXRThlK3ErcG44ekJKQjBiaU9ZQ1FaTmxsN0FDU05zVFNKVEZabGJ6eDk4?=
 =?utf-8?B?cGZUcEd2TW5OZ3NKa1NEdUx6cUxURnNQUmZFQ3gvSWwrM0FhSmM2aWU1YkVK?=
 =?utf-8?B?d29Jd3F5NzJjd3FGNFVRaWR1c3RncHF1S1I1VE1xQmVMTGx5WkV5TGtnYVJX?=
 =?utf-8?B?Y083VzdVUEpReUpkZnJ4T1dSR3FUcHJiUXpqdmNTWVlhU0s0WmwwNGxhWFVL?=
 =?utf-8?B?eGlCUlhkL0dMbEFqNUp1TlQzeXR6cWl4SlZsYkd6SmJRZnZvbVptdjAybWkz?=
 =?utf-8?B?amlzUFlDNldmZkRuV002cmRLNk9YS05vWGY2Vks1ZUpOWmZBenB5MU5PR1g3?=
 =?utf-8?B?M1Y4YmZVbFJTczF4YlBGMnd1U2JHdGlXUUZyUFZqa3FoOVpxT3pmSWN1Si85?=
 =?utf-8?B?SVIrY0lWcHBBNGkxK2dHbkZNYXBiRG9PSkxvVW1SVDF0YXRhQzlhTlZJYUN2?=
 =?utf-8?B?KzZpTCtGQktSOUp5c28zRlhVRk5jcXQ1SDdreUR5STAyUVF2QlNKbzIzcnRY?=
 =?utf-8?B?TWpaWmFhTkpLbjRsNlFiZTZVRWIxNVJwNERIbjVPblBWZGtWM0hzSkZ0Nitu?=
 =?utf-8?B?R2lOMm02RDJCdXR2bjR5TUQzYktFT0luMmZjcTVtbWx0c1RPd2tKVW4vakJQ?=
 =?utf-8?B?RlJ4VjNMZENGc3hEZk02OW9CemtPNXl3aHVUeFV2cDBFMkVQeEk1ZzlXWXpP?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a71ab7e3-9eaf-46e9-7cb7-08ddefb40bd8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 15:17:52.9525 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HCkKkyc3iap+Jp9hjEhRnr+Gqr1VKAizcBTCHmJJFUwUuqWLB83PmVkeHSBI5eItFKpv+aPIWFmZdDLQ/rqZ1cQ6orrL9OMvxBr6HAvjNOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4614
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

On 9/3/2025 5:17 PM, David Marchand wrote:
> RTE_EAL_VFIO is directly mapped to is_linux in meson.
> Replace this intermediate build knob with RTE_EXEC_ENV_LINUX.
> This is an intermediate state before importing the VFIO uapi header.
> 
> Note: crypto/bcmfs was functional only for OSes supporting VFIO iow
> Linux. Stop compiling it on other OSes.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
