Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5ECFC3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 10:51:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F42E406BC;
	Thu, 27 Mar 2025 11:51:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 812B24069D;
 Thu, 27 Mar 2025 11:51:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743072696; x=1774608696;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=h5OQHQD9s1egfMBd6CJFZ17P/xuj82g+n4LVJntPqP0=;
 b=cxHrMtPEhFc976ublFYtedjHZ1SuUfEKyrwK02GaGGG5bDdfeo8WKt0t
 /dd/JZm+jFAxP3afgchzH2CLV2wktLK4WfXZR3GcJuSUyae2lq/OAAmvk
 1jJ6cSoofkMG7M9dDt6fdQi/uTUj3mymhS377NbcybpuJ756SArrk7ssR
 9HGkcY4HjgAzbkA8gIT7Jf68ryAazvuH9xuQb+2nWCKGInEphX+Ud6hLY
 R2wh2TLSdF1U4bMK1HcIrZdZOs8WjyuGd2dnZ7sS4mvDcgtrww1fL4ffw
 emEUphUItQUHMguBqaI7kTbqAvC/h/Hxy2rGRqrEv8qj502LXbL56CyfS A==;
X-CSE-ConnectionGUID: RWVo23+0TUCcsE+AVzUPFg==
X-CSE-MsgGUID: KDGUlCm6RP6yBwf27rgu8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44286369"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="44286369"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 03:51:34 -0700
X-CSE-ConnectionGUID: 0ADYIu/xTP+5f1xwOdbc8Q==
X-CSE-MsgGUID: 2OOg7aaRT8W4H/AKzgt9Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="125618683"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 03:51:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Mar 2025 03:51:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 03:51:33 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 03:51:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNVimVgtj6v72J0wAefaP4NnoLkRPDLWqJGaf7bKcK3bFASDlota8nYVaIuJRu+VFDqVjUcMobMupJZtXwwTejuJQb5X14SNzxQqZNliNr0IBS5P3ZJzHJOxIXMTfowtf1C6CiBh+Ar0RAOXUtp97EPgX3pzBuTHZDp2tEHZ1gTsJRVUcjDwokZCSW/uf6kf2+Kqjx8svVr8rAbrhqpT6+w9d/pyh4TM33KM6X9Bss0hSsYCgFdq0YAkxX64uMOKFur25lCdxS3FESrl8igqb9kq9D8tITq8/X4Hs+1+gZazJOqFUg1IBbeNzD848qYw73ubXaD6w6EMj8i8XGKrUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgRT8/K9etC3aSvxiuKB4yHwIaKcQp/yWiJNNEmGp8o=;
 b=pLRiJugoNRWrMYcTGYSOks1E7/Wc8xt7Cyn7w9czSZpgMFNsmzjyREyuxdwWEcQQcKpwtkzud77pKazStFjMszuD3vY/dpRu5WRuNjKeWt0UkDa+9u49qbIehljJ5Wv+g6OcX3yBq4Qg/B7q7vAKiqGVZmOqWlp1kiqR7qT2bdng20m+E2XrKRhCR1F25lf03cC3gaHWkbC7/EQ+fq7s5zOrHUTwJjv9qGqkMLCc9ifzQhUxSl3Z2PtiXcO9WJ7EBDiQKkmSAfZOhvO8Xl56eyW6YV8S72eKnuNQDyKk8RD8+Bh0+7EtnUZcX6/H2LCI9w56B6WieUCVgUQQvUBr/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB6917.namprd11.prod.outlook.com (2603:10b6:806:2bd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 10:51:30 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 10:51:30 +0000
Date: Thu, 27 Mar 2025 10:51:25 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>, 
 "bluca@debian.org" <bluca@debian.org>, "stable@dpdk.org" <stable@dpdk.org>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, David Christensen
 <drc@linux.ibm.com>, Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: Re: [PATCH] acl: fix build with GCC 15 on aarch64
Message-ID: <Z-UtrQn9cud4oNA8@bricha3-mobl1.ger.corp.intel.com>
References: <20250326103928.1189243-1-david.marchand@redhat.com>
 <Z-USgmK7lRZsjcIn@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8xLbR_UD3=i_fR3aLzuciuWbbkkV8DgiXYm6Y1C7RXQug@mail.gmail.com>
 <243684416b27483b89f1c5e5ffcc249c@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <243684416b27483b89f1c5e5ffcc249c@huawei.com>
X-ClientProxiedBy: DU2PR04CA0343.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: 33a0a385-b875-4014-7d8a-08dd6d1d550c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MjlWcVpubEVtMHV2YlRsQ21NRE5VRlJ4Z3FFSTdjS2dRbVBuWVJCSzFOcmJj?=
 =?utf-8?B?eGZlMVU0MzAzWiswNDFuVTM2SGtuL1lBeGJGd3NIOE9xbTRaYmhFVTNpNEhx?=
 =?utf-8?B?YjZyWkQxRGd5Z05yUXVISUo0RjkwcnBvUTNwOEw4QndKeXo2YlFEaHAxb002?=
 =?utf-8?B?c3JuVW1WcUpzcy9tMHZqZTJMeGJINy81ZkRrOWthb1RjTjNxRXJuU0pHa3Iz?=
 =?utf-8?B?dElPWWdLUTlSWUU2YjRRQjh1TkdnaDVrU0U4dkkzZGk5TGhXR3dZMmpTQ2Jl?=
 =?utf-8?B?V1o4ZFFvOW1FN3p2bnkrZDEyUWZSOGtidCtFUVJGenAxR2ZoNldoRFZMRnpj?=
 =?utf-8?B?RWZjQU5XU2pIZENaUnhrSjZUZ2N4aGdDRHgwZE85ekxhS25yRjRCVUJ6NU82?=
 =?utf-8?B?QUdLVGJNTVJndjRsYUZvRWoyZHljdEZQTjJZb3k3OFRBWjVFSEluU2NqRk5E?=
 =?utf-8?B?TC9wcnJUR0J5STlrdWtDRVRrd1VjVk9waHpIWGdkdTEwbjlkYW9EUlZWSmZN?=
 =?utf-8?B?YUZoY2ZwOEZ2WXdreXVkTGp0bkRONXBXWmFGNmZIYWVGZUtHTW1YcEJ4eXhM?=
 =?utf-8?B?NWNHQUNyVFRWc3VrNTNqSFZ0bnJ0OVdrbEEzK3Fpd0ZzTnRIbVhvMVBVZmxT?=
 =?utf-8?B?MVBpL3IzcWNXckYxTkdKTmFSNVBSYmx6RjVaM0owNWdBYW14WVlUWWhCVUx3?=
 =?utf-8?B?OVR2cnM3aXpVcXlKUkc5ZGMvNndGd0UrK2p1WFh5bXRxR2JFc1hlZ0Z5VUxI?=
 =?utf-8?B?WUYxVTI4Z0x4K0lWaWluVEFNWmNRZkhJbnY4TFYvblh5T28wcEZjSmV1byt2?=
 =?utf-8?B?UHF1R21kOU9EazgycEQvTithNTZsYWh5ZVhpalVNckUxNEhsRlpVNXlBNGJM?=
 =?utf-8?B?NDIzVnY0dzRzazVxTTBxN2F6d1JJYWVYakR6RUhzVUlEaTVoYUsvZXpwaHUy?=
 =?utf-8?B?YXROeGI5VnA3V3JHWWtmbG5lTnEvQWlBU1lIN0lFMjQzK3M0RGdyeW9qdE92?=
 =?utf-8?B?SC9kTEtHYmlFZmVQUDdoNzlVa2JIR2pzeFl6enZBZitlVFNUZWFKVGMyNE5q?=
 =?utf-8?B?eW9ydGNoOElTTzU3cHI3UFI3ZEV0dERSQXFqUDRWTkQyYkE0d3BHMjhQZWhk?=
 =?utf-8?B?RGd5UkVHU3RkbXMycEdsMjQ5ckc0MG1PRDJtblM3U1ZJajV4SWlCOUE3RFFS?=
 =?utf-8?B?TVJ6cFV3ZzE3amdtWVpLWHd3OXAraFhLQXRaV2NmcWRPK3crSVl1YjBqODF5?=
 =?utf-8?B?OE1PS2ZJY2d4WUF4NWhpSzBNRnFJTDlOMit0M2d4N0Y4ZE15VG5lUmZNQnhu?=
 =?utf-8?B?WWQ3TWlyT1c5RFRQMWpTcmpyVnR6MXNKbGZsc3FhaFdGOG9VNjIya2lNRXNi?=
 =?utf-8?B?MFFnQm5WcUNZK2U3aUwra1hVMmJ4cXYzNjVmUWdJNFlUbUVHZDh3NXlIN2E2?=
 =?utf-8?B?azFwR3BlRzVGMU5lRmkxUlhwbUtGb2wvNUpLWXZVcDlMc3Rja21RR1NuVks0?=
 =?utf-8?B?eFVocW9LTm5SaHVWOVU0NVgvREkyVHFJSHJxZi9qREZZYkdxbjU0QXMvSzVk?=
 =?utf-8?B?NFY0N0E4aUFEeGhHYUFkS1ozc0dTa1g3NjFNZ1k1K2VWZGh2dFRyYmN5bWda?=
 =?utf-8?B?REdSR2xYUFEvNWZScWR3b0FTaHNwL2tvWUtaRWE0T3hORzl0aGlsb1BHeGhU?=
 =?utf-8?B?SytOdDNVdndGT3Vlcm5CQkhudmU5ZlhyQlQzUG1VZk1nOWRxYnJFWDh6WXhL?=
 =?utf-8?B?MVFpcnE2U2pXR0J4cFRIcnc5ZXZURS9BV1VHMzE1YkZPQmdZVDVBdVhoUmlu?=
 =?utf-8?B?YS90MFBkUDc5d292NEZYdk42dUNHRm1SZ2tVY2RXT05IMkV2Y3d2N0dWZVM0?=
 =?utf-8?Q?LRvBSIjw35IRK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVdpMUo5cFZDUVdTTUh2dWdKM2VCYXRvK1hDdDZWaDYvOHJuWitYc0gzWUpU?=
 =?utf-8?B?RjByR2pUeDBtc2t2SXZsdGRTSEE4WmIxNVA3ZUloWXM3dGkxNFZVcklRRHds?=
 =?utf-8?B?LzhaYUpSMG1Od0kveXp5a1d1Rld5MHVxREhCRDVqbkVheUJJMmNIUGlWamtw?=
 =?utf-8?B?amJndHlUcXlWNzB4NGk5WUhvOGVmaTc3ZW91czJJc2p6L3B3VG1LaFhZT3RS?=
 =?utf-8?B?cWw0NURsK01aTjU5ZE9WcERUQnFxb1pwK3ZXUThub2FXRU9SR3RvSXJyWDVx?=
 =?utf-8?B?OTRKclQrRnVLYXRxbTFSWFZPd1htMk56VlNzZ0t1dkx2YmVGS3gvNmlEejdU?=
 =?utf-8?B?MVJ2Tm5PMTRVL21tbjMvakNvTUJ6eXljNjRUcUJQS0hxWDEvb09raG1JbWlI?=
 =?utf-8?B?SjF2bnJIOWhCbk1yRUx0Q1Ard3ZtYnpmTzhzNklpcjlKOWozSCtTS0MrcWVT?=
 =?utf-8?B?NmNCMW5va2FLcHptNUc5Rk1ZUUJUN1dzb3J5Z01YcVhvNCs4SmF3dFdCR0Y2?=
 =?utf-8?B?REM3MEEwNHpoNWtpek5weFVEbktTUFJBMENhejZPTjhwcTRSblhWWDRMREd6?=
 =?utf-8?B?b2l3ZXRiTnRlM0QxZzEvOGxFKzVUREZWUmozemswZzhyQS9ESlJaNXE3VUhv?=
 =?utf-8?B?RHB1ckZwc3RtbnFhaWR5a0w5YmxLQVUvNU5jMXVramhSRTBMSjVvOE1GdSsr?=
 =?utf-8?B?WWUwellGbVcvNjRnNXlJcWtJS1R6ckgxRUNOSUZKaGVMbHFvTmIzL0NTdjFN?=
 =?utf-8?B?WEFNUHRKcTZDdlFmRzh0eExKNHR4eVkyaHkyc3U5SjI3cDhrQWVDaEFGWnlh?=
 =?utf-8?B?NWVYS0hJOEFPT2lBMmkrWmN5b2JHVHJoMnVJcTZoRG1uYXprNjdGZzRQMElu?=
 =?utf-8?B?MzZIUFVjenhTWDB5RHhuQTdnNlpZVFBORWc1WHNJMFhQWkFaanVsbUpnVmZ6?=
 =?utf-8?B?WmRNQnFWUDIvUmkzNW9rZzlhemlDcEExemwyZ0RLbndMTGZxNmlsdUlNczJX?=
 =?utf-8?B?dVVCMDlwa0xaZGdvQTg1dGtQWWN0eC8xd0xSTmlyZXl2Q0tDTnlVUWs3aTdU?=
 =?utf-8?B?Q1VuUzNBZEEwYXJoc010bmNGM08rY1pxYkoxZzhXZm5tNS9RaS9MaDZITzBL?=
 =?utf-8?B?QjhLN3dZQlFJSFhBeHRCNTBNQm1xSTFqRDZVZjZNWHhGbUxXQlU3OVZvWmgr?=
 =?utf-8?B?UWNvMUl4WkJaQ2dxQUZQUWdxSmFMZ29ERVMzRGp4eHFTQXYzOC84MlMwOTJ3?=
 =?utf-8?B?ZW9QWEMxY2ZsQjU5VnhjdVZDNXExaVNqNk0xb1dVQjJFT2Q3bDYvR1k2SUJG?=
 =?utf-8?B?QUZQWnZmL0RLcEptckNLak5yREZjOTdmSHVrM2FQVE02K1NJdWUxZ0V6bngy?=
 =?utf-8?B?bXpjNklkeEsyQjR5bFZmL2EzQ1dYM2FEMG5FSzBpZHV4UDF6SzhwMFR2bXM5?=
 =?utf-8?B?R0Mwb1h5WnRXNExvYzFlYXVucW9wblc2bG5UUGxRMzd4RWl3MU9Id2c1TmM4?=
 =?utf-8?B?cXBFYUlac3UwRGkvMDQ2N2ZOcWUvUy9Td09SWHNYM1lkdGw3U01VTGVpUE9Y?=
 =?utf-8?B?WVJCeHA3RXhNRm1BQVF0REVvdGt1M29yQUFZZXk4bU95SWRuZmxzemhEdzAy?=
 =?utf-8?B?RlVDa2dXbWtoRDB4YW1yempRays3YXBrUVZDUWhHcnhaVzUvV1JRdTRMR0Rt?=
 =?utf-8?B?djVaRWlIYnlnVFVVL1QxMHpheVdIaWNpRUV6Y1F6TkpieVc5OXFocEhDOW00?=
 =?utf-8?B?eWJZbkE5NkhTM1lCNXZEeVdoRWt0clJhYm1qQUpNWWxmVzM4VFBWTVpkU2Jt?=
 =?utf-8?B?em9mN1BFZ3d2ZGVMcVMwSmVIUXA1c05yVnFuODhSWlBPUzZoU1dVYW85Wmdh?=
 =?utf-8?B?Y0R6OExsbXJNM3Nyem1XQzVwblBhRzRXMnViamZCN3dtS3YzNElCM0ZaR3dY?=
 =?utf-8?B?ZDRrdlZTRHFjN2FLVDEzT3RTK2RmbmpKNXQ1SFg3MDVQcFpZYVVPZlhMRmFx?=
 =?utf-8?B?QWgxb3lZbU5LRlRoTDRXUDlCa3d3eDA1YWRqYjc5YXZmT2dUVmNmVWlITThB?=
 =?utf-8?B?Ry9YbXJQeVFOZGtmSnVodnNJVmVrMlVlT0lKSnRDVjNCSHcrTTlGWDFFMFRF?=
 =?utf-8?B?aksvUU5GUEsvZytVaXNFNUxacHF0MDBpSGNDZE9TZTErTTU4Ty9OWjkxV3JT?=
 =?utf-8?B?Zmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a0a385-b875-4014-7d8a-08dd6d1d550c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 10:51:30.7163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ztgCYPiCnqQipviMPiimF9wmU9xVJiF2EO01X8BruyzZr7/vMuRLr2xt1gbH9a/RrdW6LB8RuaCgnBsvEf/zMl9QzOF0GY+suJgIhfLxSfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6917
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

On Thu, Mar 27, 2025 at 10:39:09AM +0000, Konstantin Ananyev wrote:
> 
> 
> > -----Original Message-----
> > From: David Marchand <david.marchand@redhat.com>
> > Sent: Thursday, March 27, 2025 10:37 AM
> > To: Bruce Richardson <bruce.richardson@intel.com>
> > Cc: dev@dpdk.org; bluca@debian.org; stable@dpdk.org; Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>; David Christensen
> > <drc@linux.ibm.com>; Wathsala Vithanage <wathsala.vithanage@arm.com>
> > Subject: Re: [PATCH] acl: fix build with GCC 15 on aarch64
> > 
> > On Thu, Mar 27, 2025 at 9:55 AM Bruce Richardson
> > <bruce.richardson@intel.com> wrote:
> > >
> > > On Wed, Mar 26, 2025 at 11:39:28AM +0100, David Marchand wrote:
> > > > Caught in OBS for Fedora Rawhide on aarch64:
> > > >
> > > > [  198s] In file included from ../lib/acl/acl_run_neon.h:7,
> > > > [  198s]                  from ../lib/acl/acl_run_neon.c:5:
> > > > [  198s] In function ‘alloc_completion’,
> > > > [  198s]     inlined from ‘acl_start_next_trie’ at
> > > >       ../lib/acl/acl_run.h:140:24,
> > > > [  198s]     inlined from ‘search_neon_4.isra’ at
> > > >       ../lib/acl/acl_run_neon.h:239:20:
> > > > [  198s] ../lib/acl/acl_run.h:93:25: error: ‘cmplt’ may be used
> > > >       uninitialized [-Werror=maybe-uninitialized]
> > > > [  198s]    93 |                 if (p[n].count == 0) {
> > > > [  198s]       |                     ~~~~^~~~~~
> > > > [  198s] ../lib/acl/acl_run_neon.h: In function ‘search_neon_4.isra’:
> > > > [  198s] ../lib/acl/acl_run_neon.h:230:27: note: ‘cmplt’ declared here
> > > > [  198s]   230 |         struct completion cmplt[4];
> > > > [  198s]       |                           ^~~~~
> > > >
> > > > The code was resetting sequentially cmpl[].count at the exact index that
> > > > later call to alloc_completion uses.
> > > > While this code seems correct, GCC 15 does not understand this (probably
> > > > when applying some optimisations).
> > > >
> > > > Instead, reset cmpl[].count all at once in acl_set_flow, and cleanup the
> > > > various vectorized implementations accordingly.
> > > >
> > > > Bugzilla ID: 1678
> > > > Cc: stable@dpdk.org
> > > >
> > > > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > > > ---
> > > >  lib/acl/acl_run.h         | 5 +++++
> > > >  lib/acl/acl_run_altivec.h | 8 ++------
> > > >  lib/acl/acl_run_avx2.h    | 4 +---
> > > >  lib/acl/acl_run_neon.h    | 8 ++------
> > > >  lib/acl/acl_run_scalar.c  | 4 +---
> > > >  lib/acl/acl_run_sse.h     | 8 ++------
> > > >  6 files changed, 13 insertions(+), 24 deletions(-)
> > > >
> > > > diff --git a/lib/acl/acl_run.h b/lib/acl/acl_run.h
> > > > index 7f092413cd..9fd3e60021 100644
> > > > --- a/lib/acl/acl_run.h
> > > > +++ b/lib/acl/acl_run.h
> > > > @@ -176,6 +176,8 @@ acl_set_flow(struct acl_flow_data *flows, struct completion *cmplt,
> > > >       uint32_t cmplt_size, const uint8_t **data, uint32_t *results,
> > > >       uint32_t data_num, uint32_t categories, const uint64_t *trans)
> > > >  {
> > > > +     unsigned int i;
> > > > +
> > > >       flows->num_packets = 0;
> > > >       flows->started = 0;
> > > >       flows->trie = 0;
> > > > @@ -187,6 +189,9 @@ acl_set_flow(struct acl_flow_data *flows, struct completion *cmplt,
> > > >       flows->data = data;
> > > >       flows->results = results;
> > > >       flows->trans = trans;
> > > > +
> > > > +     for (i = 0; i < cmplt_size; i++)
> > > > +             cmplt[i].count = 0;
> > > >  }
> > >
> > > Minor nit, but since we are using c11 standard, is it not better to declare
> > > "i" inside the "for" statement. Keeps diffs simpler for adding/removing
> > > code, I think.
> > 
> > I still have this (bad) habit but yes, it looks nicer with declaring
> > in for() itself.
> 
> My vote would be to keep it in an old fashioned way.
> Nothing is wrong in defining variable to use at the start of the function :) 
>  

No, there isn't. However, there is also a reason why later GCC revisions
and modern languages allow use of a temporary variable defined within the
loop itself. Cognitively, it's easier to have variables defined at point of
use, as it saves the user having to mentally track them or move up and down the
code. Furthermore, when debugging or reworking the code, it's far easier to
have the variable inside the "for" statement as it means that as we
comment/uncomment, or remove/re-add, the code block, the variable definition
also gets commented/uncommented too, without having to constantly scroll up
to make changes in two places. Lastly, it makes for smaller git diffs too.

/Bruce
