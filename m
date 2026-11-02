Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F81F606A908
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 17:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DRMDq4Xf
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22E4A40EE7;
	Mon,  2 Nov 2026 18:37:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTPS id 15A334028D;
 Mon,  2 Nov 2026 18:37:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793641024; x=1825177024;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=658mfJw9XXD8kdstU324av4LlvjAy2CSAsEXb8B5SuM=;
 b=DRMDq4XfQpPyRz7bu2t/nCdbfDc0qkXL9VeZoZLebyXyvn1b5BttIS8p
 fGFDaEcZ/KNEG5WW3ZT/UNontslj1r+MAJl+SlmZAoTInOG+6DRke/PD1
 gqb6tLHexyuxgHQ08lWAG7D9Gh5k+7/252BgBCdc+KqXb+W7qRjq5LLav
 cuHdPRIMNJSK+f+q+pfWXNFkxaic1aRcDKlnO/f67KeXDE0v2g4z9aPgJ
 ip9b+4M572RxdZYPiVKi9BMKUo13wp2P2XffDnKq8GL1fnMc97YsJPo0U
 xfvOE4V21LqcXePxNU80TYxdBwRhPdzpoWG2eGZin3mL8b/zNFGckz+FY g==;
X-CSE-ConnectionGUID: 6L6WFmtlSjKsZO41okFbng==
X-CSE-MsgGUID: 8ccMb+tWQ2ePjx5TLCbwUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2354616"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2354616"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 09:37:02 -0800
X-CSE-ConnectionGUID: wyEw6h87Tc6y3h9HSel5qw==
X-CSE-MsgGUID: BH3r7k6ERS+7/UJwRlTzMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6161214"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 09:37:01 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 09:37:00 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 09:37:00 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.67) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 09:37:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMInXSavhdnGjSowMwPlLiulq6IK4Io6M9Nj5yE25T15Rh5cJbuqEGgvmnFfa/++EF3rAtP2EYyFCrAsUK3Imk8y6kH1vuuOQ7PGA0bQfFYyJYJiKpQ4qcWFnORENV7gy/cbm93Ne3n182bSwjTgP0p7YV+SxkTQAdHIlS+Z/eL23mPqsbKvivFX5M9bEtD/p6zleQ4mujla1n+5T7glJ7D+ve5eE7pe/bftVFnTREV+npPqYo3Urh5DsQ7hv7G97B7OCZFE25E1JYAz+Ix3HWcu3BoeVjH8TXrCiPKIdNyy/7lbeTImCftxiwvzdG4anAz938QnuNJncKPXQFm0iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/N/yFTGAfGQ4YF+1yw8qoCItCZUU4HE/JFliFV56ufY=;
 b=gtoFGTx/Y0IM/skCeXww/vSoDngmyVEWYhnNFsP7qxb9aY9V8bf5efcyNZQFB+CmGYP/PiOmEntFM8cRuKw82/S7f876TthLbs2wSpSlYtNcy50sktarX4ClZzQ0Scm87ES5qqyl2PZhMg42lcf12SGEyaPDspwuOKvYC4jyKT+Abifb811In72/BXPVR8Vr3sLF++Fep4B+dUZ3aG4oAxF2+8xqxn9QHrFjYFEp6pJtRMrHfSlWaFkgYPHk/iAv1sUpfGZde9fyTmXyR85jrkkdx/H8yB9tWiV/Hrjb3CNmXtyCqlscwrPJ/ISBs2P5GwR6AalBZMr/FuuBqAQvkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9444.namprd11.prod.outlook.com (2603:10b6:208:563::22)
 by MN0PR11MB6301.namprd11.prod.outlook.com (2603:10b6:208:3c3::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 17:36:58 +0000
Received: from IA4PR11MB9444.namprd11.prod.outlook.com
 ([fe80::8b6d:87bf:4926:f0c1]) by IA4PR11MB9444.namprd11.prod.outlook.com
 ([fe80::8b6d:87bf:4926:f0c1%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 17:36:58 +0000
Message-ID: <5f260c1a-3f03-4e7d-aa38-15b8d6cdaeff@intel.com>
Date: Mon, 2 Nov 2026 17:36:55 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fib6: fix sign conversion of tbl8 indexes
To: Robert Sanford <rsanford2@gmail.com>, <dev@dpdk.org>
CC: Robert Sanford <rsanford@akamai.com>, <stable@dpdk.org>
References: <20261021172030.3824657-1-rsanford2@gmail.com>
 <20261021181848.3850548-1-rsanford2@gmail.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20261021181848.3850548-1-rsanford2@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR06CA0061.eurprd06.prod.outlook.com
 (2603:10a6:10:120::35) To IA4PR11MB9444.namprd11.prod.outlook.com
 (2603:10b6:208:563::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9444:EE_|MN0PR11MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: f1d7fc54-cdbf-4a0f-d312-08df3907e548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|6133799003|22082099003|18002099003|261102123227099003|56012099006|4143699003|11063799006|261026121527099003|261022105027099003|261021121427099003|261026140227099003|261028144727099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: UxwQMRwJk9aBgV6FEM+kWlv79mv3NvM/IFL53A1z+MaC3U1ho9OT0J3hXFMhzwKBrnp27GDE+qEtI+xrvRrPVDPmaBeCwuw5aoHYHxlQsTHqPUln+sSPAali4KH7EWh7HdWm8/oHNCs9ZXvUq+V0EUFoozAA6kQsEhJ1RziWEa4FcoE8TrwePsW0Frgl2kMry8issX5RCVM22Tzjih7iUFHFAuGnH/FdbhlEQOMUI/VNHq3Inp5wNeo9R0LR9HHbKh4IPJOhtHUn0O5sJ1vRk69mbJEV9ieP8r2nG8Kxxquvz2rd+yZuTGr0/i5Bn6h6KwUH8jmuWcVy3PY7AisJtND5SgMR0t9bFmGVb9mIwCurZEjwZrY5+hlmIVp/t8z4QBXBSnKPX6+17DwVZKwxYZm4aZO/e84J/igfPoW7eylycWRIU1ereTh0ckovJ28q2+/xqyyBq9+t+heKDWaXI3fUp1+MIQQjsBYBQdp1qPXvljzmc9fD4KVwg68p2LGTAgnSYssKq9GzOQi34Y5dSCxmNdKRKfhst2ovlzA0u0LJFMduI/gRUfSAXZIbj6us/6JaVcSbwVJJ9HP7vzJ0j4xlbrV5ucdiQ0XlmeV+3aqdkfbTtgcP8iaYZQ6CTF7c/5jfaSdJIsMd/MnKcUYN0ubuVX1u6wwo2V6ZS8OPQAI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9444.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(6133799003)(22082099003)(18002099003)(261102123227099003)(56012099006)(4143699003)(11063799006)(261026121527099003)(261022105027099003)(261021121427099003)(261026140227099003)(261028144727099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3lvdnFzK3pSTExzTjhWeGVWU3dNMDVNOWJIbHBIQzkzU3JuNUMxbTJkNklE?=
 =?utf-8?B?RmRUVkJOcmdJdVFvbTFDTkg4dTFLa1M1d0U2aU1DZnVkSXBsZWtjR2xUdmpj?=
 =?utf-8?B?aUFvMG5QSlJ0QytDSnNuOW5wVEsrc083Y0o1SnhlekhSSStqLzFlMndFVjFv?=
 =?utf-8?B?NTE1UXNYOGdSckZMaWV1WVl0NmVKdFVvaytydVZROVpIWkViUUpQS0NzU2VM?=
 =?utf-8?B?MFhCYnBEVWFidlhXRWQwUFlzS0tDaTJGQm9rYXR6dUZXVFpWNGxua2czaUtQ?=
 =?utf-8?B?cXlDSjJEMXNML0JlMEplUFNzMDg3cUkxQzNtSXM4amlTWWFNM2wvNXl1aERh?=
 =?utf-8?B?YytvK3F6RDAxWURPQ3hkSDZ0SCszNlBLaCt2ZGE0TTZEY3g2c1pTazhTQUhY?=
 =?utf-8?B?ZE1SSXdMRjhpYjVuVTJUZ3hDYnBKTGx2aGQ5WXNnZjZxaFNIRlA3UmhQOXRE?=
 =?utf-8?B?WE1qQTlXSWxFUWpuNjNsVm9pS2x4U2l1WjRTbjNHc05kRXZRV3Jia0JVRHlT?=
 =?utf-8?B?aVdlRlZ6eFBteC9ac0RRaTZLc1lBSmlTT29rbGVCb3RHUG1JaHErdEF5TEdv?=
 =?utf-8?B?MEVXZSt0SDdYSjFnNGQzWVBXbVM2QkpOb2ZDVU5kMGthSTlHdWNJYU91cnhQ?=
 =?utf-8?B?TXFhdXQvNkZLUEVrbE1sMFlGTVBTNmJEaXNHaDRDcFRyVXZ2aE1qY202TEdw?=
 =?utf-8?B?dW51bC9qalVUYVRzS0xqcHBvRUJKOG9WamdKOTdWMmYxdTFMdG9UcXUwOGNt?=
 =?utf-8?B?b0l5bzNrWTh4aDVPQlIwTkJ3NEF0Q3l3Z2ZnVzRlbHRvTEtVcExad1c0Y2ZN?=
 =?utf-8?B?NnUxeFNKVThxcHlWcVhDNC9RS3ovQkRvbTRsOUJCMlYyWlNEU01HaXVJL3Zu?=
 =?utf-8?B?NXUrMlFlTXJlWWM1SGNwS1hndDF0UFVDa3VSWkgrTmYzQ0lCaHZkT2QrUVNt?=
 =?utf-8?B?aGsraUF4YWVjaE1CNUlwczNrQUM5TkpqN1NMUGRhY0M2Z0gwQTRrQTlYaFht?=
 =?utf-8?B?M0pORXVQSDk3Z3VhQjFrbVhNeW5yVUdPY3I2bHIycHNFeVZnSENJcTlXMzFJ?=
 =?utf-8?B?L3lXaHhSSW56d0I2Mi9qRHpZaktSc1lLNk1INkwwWUdDOXJKUjBCeCs1ZnMr?=
 =?utf-8?B?QWI4VFlrZS9mS1ZRRDBmeWpORUhCRHdXTWhUY28rK1dBZ3FNR3RNMXFZYlJ5?=
 =?utf-8?B?U1NHOG1VVzc2c05vd1g2bTh0ajRsK0FOeGZUcmZxbUNyc1JvaUY5MG9HSlpw?=
 =?utf-8?B?aithenBka3NENkswV1dLTXNucXNzcDFFbDliR1JBWVVxYUtzZzVRT0pteXcy?=
 =?utf-8?B?SGQxcS9vWW4ycW43aTEzNlA3Wm92UkpLbzFnNmx0Kyt5OThvblRwYTkrL2Uw?=
 =?utf-8?B?TktTQXUwTzZDbytOMHMrWkl0NVNVTXVoOUtlSjdvekI2Q3VJczFXVUc2eTFL?=
 =?utf-8?B?VkRDZjR6Q3ZnNGNLT2tKckJCS05FUTRvZ3ErVlROckpLZUtYNGxOclpmaDMv?=
 =?utf-8?B?Vkc2RG42c0JDWFdkZ1JHeDJqM2loMmRXTUw5SU40N3FkOVdWSjNTenNiZkNY?=
 =?utf-8?B?WmFDTW5SRkdUTzNta3IyN0xDTG9rT1dTZjNWRjlTKzYzNUg0RW9rYk9qME1l?=
 =?utf-8?B?UVRXL0g2aDRYK0IvZmNpdlo1bjh6aERVYWN1d1huUWpKUkx6V1I4N0xUVHpE?=
 =?utf-8?B?YVA2K2pCSUZRZjY2d2wwbGhEWFk4cU5wVElVd0FFeGhyQVpXZ2QxcDl6S0E3?=
 =?utf-8?B?aS9iR3ZhVW9PTGcwSWNwS1JZWmNTbGUwQ09NcDJVSWRhOUpUbmwyRVVRTVZR?=
 =?utf-8?B?eldISUtzVHpJc3R3MkFBWmRHVENlY2hmQ1VYQ29wbW5wQ3J1Zmx2YU55aFF1?=
 =?utf-8?B?OWJpbzRsclhVcEdqc3FlNDBnT3h5d1ZQeEFZZ2F6bTh5WHlLNCtLeEZkYmo5?=
 =?utf-8?B?ZVIyeGNOUFVDMTh1UEgxQXV6a3pvdmJ1MnBmdS84czFGRDdqUW50NFMzZStl?=
 =?utf-8?B?ZnRBc0pJUXk3SDFUWGFRRjNMYTBMQVdxVDNzY0Y2UWFBRzZ0S1BaejJQL0N4?=
 =?utf-8?B?V0FLL3N0U3oyMVA2eHpOQzB0bHptK1lzSXU2NEJEcVAyU3RlMEUwdGJwdTZB?=
 =?utf-8?B?d0FFb1BTRGVOa3RjVk5WanRKRVRGOGErZ3BPeFJOdGIydkZqU3dOVWc0Rng1?=
 =?utf-8?B?WElwZFNpRTRTTFR3TkRtWkY1b0gxN1F2ekVWaENxRVhhTkpXTjN6Yy9sZkkw?=
 =?utf-8?B?UklwbEo2a0h0dW12Nnd5YWNPRHltNk5CNUkrTjl5ai9RVHVqZWNVQUw5NXRS?=
 =?utf-8?B?UHJFNGhmc2JiQTZUOUZvU1VlbE5TMUlKcjB1eGJRc1BNWCsvZmJ0dUJuc0V0?=
 =?utf-8?Q?sCGQNHs2OefRs3gk=3D?=
X-Exchange-RoutingPolicyChecked: Cbt+sQPnT+ItqGCLQqXrmq6QpCyuJ1oqSsTwEKzCeYJoKi9qsopTDdKv9Q7kAnfAIrwehTkpgiUDp6mRHE1IqN2rLKxz+jTxsNZFkjVFq9RvIL2BGSrRN3jJqPaBGpSgmJk1I/FoCpDfA1I2Ap9BDeA+9WPAKD6wiC0w1MK1dOkXv+x7uhWFJ5HHJPfh6QI6wqm93ZVDaKzX4HFUjG5EQVGik9eLPcc0Sy1gh1icr34bc8oBIcsdgspznPwezl8QCZ5HqOqoN660154AhYBrb7azaIGit6Dd70gd+FklXp8FjrFK6ofHzDzQuLT0UbEfkwGdOEX2xiKBjs7UqvWv+Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d7fc54-cdbf-4a0f-d312-08df3907e548
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9444.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 17:36:58.6008 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1VbyYCVXeGTdn2kGMIMAkbSV6R6EXPmZTdLVdgEEpqHIsk51XD1iz8ZV285cKLDCA/bZ4Np7MVRlDyLnVs+EWX+xXwNeVF9+tN3FTG64oI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6301
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Robert,

Thanks for the patch

I see two ways to fix this: either add a check at creation time so that 
no more than 2^23 tbl8 groups are accepted (which should generally be 
fine, although there may be exceptions, hence option 2), or widen the 
variables holding tbl8 indexes, as this patch does.

This patch fixes the issue in the "roughly 630,000 to 650,000 routes" 
range, but not completely. It only gains a single bit, so the problem 
reappears at tbl8 group 2^24. With /128 routes as in your test, that is 
at about 1.3M routes, and this time lookups silently return wrong next 
hops instead of crashing. I'd encourage you to widen these indexes to 
uint64_t, not only in build_common_root(), but also in get_idx(), 
get_tbl_pos() and get_tbl_val_by_idx().

On 10/21/2026 7:18 PM, Robert Sanford wrote:
> From: Robert Sanford <rsanford@akamai.com>
>
> In build_common_root(), get_idx() returns a uint32_t, but the result
> was stored in an int. Once the tbl8 group index reaches 2^23
> (prev_idx * 256 reaches 2^31), the value has its high bit set and
> goes negative. It is then sign-extended when converted to the
> uint64_t index passed to get_tbl_val_by_idx() and
> get_tbl_p_by_idx(), which yields a bogus table pointer.
>
> This was hit in practice: a modified fib6_perf_autotest with 750,000
> random /128 routes crashed with SIGSEGV in install_to_dp(), where
> build_common_root() is inlined, when tbl8 group 0x800001 was
> allocated (after roughly 630,000 to 650,000 routes). The faulting
> store went to the table base plus the sign-extended index 0x800000a4
> (a negative int), which wrapped to an unmapped address. With this
> change the same test runs to completion.
>
> Make idx and prev_idx unsigned, and use a separate signed tbl8_idx
> for the tbl8_alloc() result, which returns a negative value on error.
>
> Also cast tbl8_idx to uint64_t before shifting it left, in
> build_common_root() and in write_edge(). The shift was done in int,
> which can overflow before the result is widened.
>
> The problem is also visible at compile time: GCC's -Wsign-conversion
> reports the original get_idx() assignment, without having to build a
> table large enough to hit it.
>
> Fixes: c3e12e0f0354 ("fib: add dataplane algorithm for IPv6")
> Cc: stable@dpdk.org
>
> Signed-off-by: Robert Sanford <rsanford@akamai.com>
> ---
> v2: use a 12-character sha in the Fixes tag.
>
>   lib/fib/trie.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/lib/fib/trie.c b/lib/fib/trie.c
> index 187360d1c8..95f79e26a5 100644
> --- a/lib/fib/trie.c
> +++ b/lib/fib/trie.c
> @@ -317,7 +317,8 @@ build_common_root(struct rte_trie_tbl *dp, const struct rte_ipv6_addr *ip,
>   	void *tbl_ptr = NULL;
>   	uint64_t *cur_tbl;
>   	uint64_t val;
> -	int i, j, idx, prev_idx = 0;
> +	uint32_t idx, prev_idx = 0;
> +	int i, j, tbl8_idx;
>   
>   	cur_tbl = dp->tbl24;
>   	for (i = 3, j = 0; i <= common_bytes; i++) {
> @@ -325,12 +326,12 @@ build_common_root(struct rte_trie_tbl *dp, const struct rte_ipv6_addr *ip,
>   		val = get_tbl_val_by_idx(cur_tbl, idx, dp->nh_sz);
>   		tbl_ptr = get_tbl_p_by_idx(cur_tbl, idx, dp->nh_sz);
>   		if ((val & TRIE_EXT_ENT) != TRIE_EXT_ENT) {
> -			idx = tbl8_alloc(dp, val);
> -			if (unlikely(idx < 0))
> -				return idx;
> -			write_to_dp(tbl_ptr, (idx << 1) |
> +			tbl8_idx = tbl8_alloc(dp, val);
> +			if (unlikely(tbl8_idx < 0))
> +				return tbl8_idx;
> +			write_to_dp(tbl_ptr, ((uint64_t)tbl8_idx << 1) |
>   				TRIE_EXT_ENT, dp->nh_sz, 1);
> -			prev_idx = idx;
> +			prev_idx = (uint32_t)tbl8_idx;
>   		} else
>   			prev_idx = val >> 1;
>   
> @@ -359,7 +360,7 @@ write_edge(struct rte_trie_tbl *dp, const uint8_t *ip_part, uint64_t next_hop,
>   			tbl8_idx = tbl8_alloc(dp, val);
>   			if (tbl8_idx < 0)
>   				return tbl8_idx;
> -			val = (tbl8_idx << 1)|TRIE_EXT_ENT;
> +			val = ((uint64_t)tbl8_idx << 1) | TRIE_EXT_ENT;
>   		}
>   		p = get_tbl_p_by_idx(dp->tbl8, (tbl8_idx *
>   			TRIE_TBL8_GRP_NUM_ENT) + *ip_part, dp->nh_sz);

-- 
Regards,
Vladimir

