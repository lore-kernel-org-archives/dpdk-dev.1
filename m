Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4DB606A31E
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Oct 2026 14:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UaWHLKzO
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F320340269;
	Sat, 24 Oct 2026 16:11:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 7CA8D4021F
 for <dev@dpdk.org>; Sat, 24 Oct 2026 16:11:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792851086; x=1824387086;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QPiiomFwhZACJ6V6CGjCic47s955qUm0CiYoFgdJl1A=;
 b=UaWHLKzOskcBSpQ7crjjHJfzh4F3Aytq3q65FpVkcMa1vFDOrh1bgbna
 qSpXMLgfUO7y+wyUKaWmWR+Ke3K7dauvmcAwbKi6ZQaOUseKgX3lwDduQ
 iB5tNDsqeJh3m5q0Qw0tGaK2gfDoMi0tUulQtEP0fNhNXrWb0Ge63JNPZ
 sTziB8F0ifS+jK67K5ttQ/hEJWbo/8HTypTMDuPbAq1GR5VbHeVs77svp
 2Z5ioZQ5zQQSTxMZzOBHIM3ziGH+gSqjHskvXZaoSMyKW2ih1+7FTJ6Hh
 iTsubK9CpY6i1b5M726TS923WimakPJuEtFi2RLCHONa+iIXM2zCzMTRR A==;
X-CSE-ConnectionGUID: xwu0CSiuRaKqoeCQ4NQN3Q==
X-CSE-MsgGUID: DzSwTzFDSjiPqoh4FlWl6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1473478"
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="1473478"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2026 07:11:25 -0700
X-CSE-ConnectionGUID: 6ahSDuRSQe6+J6Kx40b7Ug==
X-CSE-MsgGUID: /cPtydFmTeaWePPe38oD0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="4218867"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2026 07:11:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 24 Oct 2026 07:11:25 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sat, 24 Oct 2026 07:11:25 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.14) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 24 Oct 2026 07:11:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OH54Mvc3NTZD7y4NH8h1/YIonVHyMLZun3Sryt2qUtx4DcHCMXbrc+PjKvXfdmgxHrqIHD4hQF5QfktVVgPJl53LR3qZX0udRzlPbKSiqu4lf+WWx8W6xllD2Z8rCE+dpay5aTzjahjoCIwCcWQCvD7dbqLW0SbgFXtRxmay3LUZBIzREJB5kUN5+CZOPNHjMHkpX/esnAzt6q8FTUBhCTOhfDgDm9ACw7h7u4t57u596HDetUtYWpc46yo8xXHDUxOxA5m5ys8ypYHYgGCbO6PBohSpRbOg+cRP8Go2AsGteRi6cUOcr90qIxWApQWhiKY9SO0d4FYN6lPY9/ipYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwT03+qTNe8loZoOkQ0To4RbogpW3aC3LySqtna4JOc=;
 b=ZtrttA/xZX0SdmZM1LAZdU/Ft8kmS2suQZENP7Oq2VNdAiqLkFr8aFIjwM4pfVn7BAF/s2E4RteFP28BOnNvCQxiDI12dxt9u8XwZXrZ/qPP9M2PGbuQRFhT54iMElY6xvyvvA8gQTDH86+WXIAYz0mHi4rbC6MVrDsg9khMTxZULKfKLDQHncbkybYkK6ZuQjdxylfAhV/2uozzb1xmtozj1lka2XjgSyKVzL8oCFK/SzCt/qevFtHO0QSOrUMVM7qQ5Rv1lBoU7lWOYfz7A9EpSXIIuUlSSwfxgf0xgWwIs+JYyekwI9x/P8F4lHV4sWCHb/IdFeeRnTW/JFbLwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SJ0PR11MB4880.namprd11.prod.outlook.com (2603:10b6:a03:2af::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Sat, 24 Oct
 2026 14:11:21 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0546.017; Sat, 24 Oct 2026
 14:11:20 +0000
Message-ID: <b0870d53-0555-43a2-a5e8-8b4cf5917048@intel.com>
Date: Sat, 24 Oct 2026 16:11:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/12] interrupts: do not duplicate interrupt handles
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <hkalra@marvell.com>, Nithin Dabilpuram
 <ndabilpuram@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, "Sunil
 Kumar Kori" <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, "Sriram
 Yagnaraman" <sriram.yagnaraman@ericsson.com>, Jakub Grajciar
 <jgrajcia@cisco.com>, Bruce Richardson <bruce.richardson@intel.com>
References: <20261021092318.1554295-1-david.marchand@redhat.com>
 <20261024132138.7239-1-david.marchand@redhat.com>
 <20261024132138.7239-4-david.marchand@redhat.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20261024132138.7239-4-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0044.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::23) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SJ0PR11MB4880:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ad0a766-9925-4809-0bc1-08df31d8adb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|23010399003|11063799006|4143699003|56012099006|261009223027099003|261021121427099003|261022113327099003|261022105027099003|261022075727099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: Ixz8DUHPCzbGwEwrkMldKheW+sgV60gD65Nlx/as1mJadcI52/3emSV1xamjFRjhB8Y4Hvuo7Eu1nAa32nkmOgeXHt+x8saP6KMURvgRu2pyzBdJq3jc+ymJo4oxTCZAt8kLzrPpAwiVNfmHnr6FeDDS/sN2ZWRfIvFMkskpu7s+EXdSelx2pZ0FbAf8oTh89/uygrlNc5gXR7rnIZRQWzxNkZdsmUa7Zm0/k/08QEeWk3dJVKXGW22XEH00U54eJpV11KfeUiGJkwwsRJ2c3pdeOsB4YIxLvCeKk2kI/Km7R1c0/cJrQ5aWFlCR1oa0vlvm4TUUll1uqS62XB0ds43xJKkCSRbh75v0+2w/fzk9XeQp9Cx2qDx4Vxg+t6C9mEJEq3Aj1Z/zemHczA464iAdAxDFJpLb7TTce/bgZXw9ltJmF8OLFkYykwjYcYyDPqVOm6DaKu2+B67M1s8LuoxOEfKiEqLEAuO8H9HyKRqn8KrUAWBZ+wigo1N2Are4YIHqpK2tuH/7GioSAQAkiqqSCJoi+1mqHXY1oOKMTS4mxEFh1f8K5+hqNxknxRrhSMFOWFLzO/yJ2KT4WI209ExubXYnB87Qz977T9NNDWqCCyDCpohK0BcLY6x13iDqnHUqOF+9g9JT0Rj88KTo/BIldk7KUDi0FQEoI6QBUb4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(11063799006)(4143699003)(56012099006)(261009223027099003)(261021121427099003)(261022113327099003)(261022105027099003)(261022075727099003)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVBDOW5OdldoOSsyVHE1cGNkYnZWRzlzQXNycVd6RTl6QnJsNHhNamphaVJB?=
 =?utf-8?B?dXcxbzl4SWZkaEpRZVNnY3ZuMkZYYU5BMWo3NCt2dnUydWdRV0lwU0FhejRV?=
 =?utf-8?B?bjhlSUNYTHZEalpqTURTQzZNZ25nQ0hKS2s0eWY3RnlGekhXaUpjRVdXRUdL?=
 =?utf-8?B?ZG5uVEtvc0xsU0xIeWZmd2drQnlaNEhYWkVRNGRYb1lncVRnV0FxRkx0MVdY?=
 =?utf-8?B?dmNkVGpvcXkydzJhMUp1Qk4xQ28zQzZER0VEaXZNL1p4OEt1QkttSzF4SFFv?=
 =?utf-8?B?U29VNWZ1MUFwMFdlS1lEYys1K3NsTkhhdHRqN2FqYUtGY1JBREVqd1VOK3ZE?=
 =?utf-8?B?VXNDNGlRNzRGMnMwcEN2SEw3UHlPczdNZW4wRlhBb0daQmh1NEhPQVU1cS9t?=
 =?utf-8?B?czVKRStQaW5lN1Q4NGpEbktXbXZlOVhYRDl0d3ZUZzlrRTd5bjd0cnczL1ZI?=
 =?utf-8?B?ekNsZ0NuSVlrTHZ5aGJ6SkNiQjg4SXFPL0lFclJWcWs2MStWSjlpRlMzUDMz?=
 =?utf-8?B?emZzbGhuaXJlSk1OeEp2R0hhKzVzUGMreHlTZkdVeFp3UjVFcDJ2MmdYQUto?=
 =?utf-8?B?c0ZIZ0JPcDdyVXdHc1dUa2pHaVJJaWV0UmZqb3ZKakRYaTFab1ZOTTNBNmFH?=
 =?utf-8?B?dmhwTGZoMVBpN2FFVGpSTm15Q3NJK090T3Z3Tjg0ZlJ3cUJxUW9hSWdQSlpS?=
 =?utf-8?B?S0ZwZ0ZjTjNlU1J2RWxuMmhDUUNWcGpJeTZ5TlBEL3NxTXJvMElVTnBVUlU4?=
 =?utf-8?B?VE80Y0d5clh0ZWoydDhScENTejRtbitkZFpET0YzbW9YOE5KbWdUZHZVaVJP?=
 =?utf-8?B?d2FPbmNIQ01QT1FFaW51TWFlVG9tRWlEMHlIdEtVZ3RuNHA5NnVpQVY3RzVj?=
 =?utf-8?B?dDZ0cDdzdldZeWU5VWZCblJTQUU1K0xncXI5WGdqbEIvditMTjV5MzlQZyth?=
 =?utf-8?B?MCsxWjczK21Pbi95WEdRbnBZVmNnMGNTWCt4dlZzVytmZy92K25CeEUwLzZy?=
 =?utf-8?B?TEUweDUxck9oUDZDbjMwcGpzME5OeEVCT3ZRRUhjZzFEcWcyTGtwS0ZhSVpj?=
 =?utf-8?B?VUxoWjd3aUV5c0JJUTFPYkwwZ3ZDbllFRklvUGJwYXVSMTI5UGwwTjhReU4v?=
 =?utf-8?B?VUY0a21TOHZHdURiL3B0aUVpM1FCd1g5Q0RGdUdRSmJ6YkZTdnNPbHBHcHIv?=
 =?utf-8?B?ZHZVTUU1Q3U5YjgwSHJWbUxVR1dTbnkvMElrbFlBMHJYNDlWdVl1YUh4OUx3?=
 =?utf-8?B?T2JvUll0cmJvdkhHMGx3RGdLL1YxaVVsZko5Sko4bk9nVFg4VGVlRFl2bzJD?=
 =?utf-8?B?Sk44RTh5c2lnNm5jWDV0MXVDaU43OHozN3AvbkFOOUZOUWN2VElrU29VcWVJ?=
 =?utf-8?B?ckdBeXlwby91bE9GWXEzSTJkY3BHdjRVcm0wYThRYXhud2x6dFJTeEFwR2gx?=
 =?utf-8?B?U0NydlRWQXQwOW1yRjdIZ1ZaR2p3eHh0cW9QRklWOWZkbmdPYU96Q1cwcm1r?=
 =?utf-8?B?NGNYM0ZyTG1CVGE3MjR2VDAzQkZsWVQxVndVQUNVU0Y3b3hjRkxEcklUcVcz?=
 =?utf-8?B?T09WTDgwS0grckZzYmY4VkNkbjFBWGdWaGxaY3Y4OTdVaWx3ZEUzaDNqRkI1?=
 =?utf-8?B?bC9DYTM4a04zdlNIZEpMRklSb2VwaGRjNnpFWk8yMUFwM25Va2lSS1V2WWxl?=
 =?utf-8?B?a2dLOVdaWU9hY2JwcFBYa3hsRzlHbVNpd09WVUR2dWhqc25UTHFFVnA5Q29C?=
 =?utf-8?B?NFlIV0xYdk5wRlphYzlITFJ5MW1rUnRCOFcxSUhkcmZHNXJabW5jSUVtdnBx?=
 =?utf-8?B?Wkcza2k2NVJLNkZGUXRLTmVycXY4VVh1NVVpcE9WUTZmeEFWb1JOYnRUMXEv?=
 =?utf-8?B?OWNuWCtLbW1yQmxGZURRK0RxRFk4TnJiamorZVEzMEErT3R6MzdWY1dpNURD?=
 =?utf-8?B?WHRSck52UXVXQjNxOXFLOVY5SmVrVjcveWs5QXZuTEVZRG44K3NldTk0WDZO?=
 =?utf-8?B?aFQ2RGtmNldCYUp4TkxIZ1VVVWxlUUhoMUtoM1ZwUzVJKzYzVTl2MG9vRkxa?=
 =?utf-8?B?ajBMemZRUTNJZUo3bmJTZ1JoYndOdys2UXc2OTZEUzM2MENOMWtZZkM3WlNH?=
 =?utf-8?B?RjBCNmk0ZkdLL2Q3NlpWdEhjdFdHSU1HSnBOOWJFM0NtSmhvU1UwTDVHQ2hU?=
 =?utf-8?B?aWFQaCtyYVh2Q05uTitvVUxXbEVFbWNKYTNNSDBYcVA1Qml4WjRMTkk3bFdC?=
 =?utf-8?B?ZDNzbVdRR2Y0S2xjdDVxaUV3RDJCd1ZNS05mNjFZZ0F3UUtLbU01eFF5bnZT?=
 =?utf-8?B?cnovVW81QnJ4SVJQZTJWNVRwZEdUN3cyNTVDRUk1NkZUd0VFbmM2d1ZBZGR3?=
 =?utf-8?Q?StUHDMK05gZyPTsM=3D?=
X-Exchange-RoutingPolicyChecked: AGlYMaeTru65t8eNm0jGX4zylnRNQ0idvTrdDx9D1gawcPnP/GivwoJpB2TkLtkSD/pamMFa6PqW6vva52jYy2+gsRc/c8n9r5HEEa6q4HuXT/u8Edz7nEjCpxM2iDVySRbXafCBhDrsmxvynaXb+ruEt/UdE/t0kp30qMFoUVV/tQofgN2MqwyxC5ZI+g0Dvt9f2LeZVObVnv7jC8VrZg7zQhJLpam/R9KI3e5ZfTENdXOCO6DbckEHBMfDAXyS50S1XTm/hJniCb2TxZx7cdB233j4B1XIjLKE2IokMYgIu9ask6Wda0zhD1cgdtVWuZ2j69UuokFK+9td9LGRHg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad0a766-9925-4809-0bc1-08df31d8adb2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2026 14:11:20.7685 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EB7bjgza8wmkRP5v5DgBpVt4JTGfgyHtlnGO31N0xQG6n9OTzFjbBfmEOdFvtt8UPUGE95W+ZxHbcRpjWgmsRKSA7/Slgp4Zt8NfvxyoOTU=
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
> The FD leak warnings recently added have revealed an interesting issue.
> 
> An interrupt handle is allocated and living usually in a bus device object
> (or some standalone code, like the alarm code).
> All the logic around the referenced FDs in this object are specific to
> the callers, and those FDs must then be closed in the callers context.
> 
> On the other hand, the interrupt subsystem works with copies of interrupt
> handle objects passed to it via rte_intr_callback_register/unregister.
> 
> When releasing this clone of the interrupt handle, the FDs are reported
> as leaked, though there is no way for the interrupt subsystem itself to
> know what to do with those FDs.
> 
> Instead of creating a clone, reference the interrupt handle directly.
> The callers are responsible for unregistering those handles,
> closing the FDs and freeing the handles.
> 
> This change also switches the interrupt source lookup from FD based
> matching to pointer based matching.
> The original FD based matching allowed different intr_handle objects
> with the same FD to share an interrupt source.
> However, this was problematic:
> * the cloned handle stored in the source came from the first registrant,
> * the ucb_fn callback would receive this clone, not the (const)
>    caller's handle,
> * with multiple handles for the same FD, later registrants would get
>    the wrong handle in their callback,
> 
> In practice, DPDK components use one intr_handle per FD, so pointer
> based matching simply enforces this existing invariant.
> The interrupt dispatch code continues to use FD based matching since
> epoll returns the FD, not the handle pointer.
> 
> The unregister callback (ucb_fn) signature is updated to take a const
> pointer, reflecting that the interrupt subsystem no longer owns the
> handle. Note that with this change, the intr_handle parameter passed
> to ucb_fn is the same pointer the caller registered with, callers
> can simply use their own handle from cb_arg instead.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

However, my patches fixed the issue in instance_dup without removing the 
API. Those fixes should probably be backported to stable in some form.

-- 
Thanks,
Anatoly
