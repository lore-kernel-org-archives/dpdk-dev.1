Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281F1606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 10:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XFWg+3Ai
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B11540299;
	Fri, 23 Oct 2026 12:17:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id B7F9740268
 for <dev@dpdk.org>; Fri, 23 Oct 2026 12:17:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792750654; x=1824286654;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FrOgVeAU6NTQnhj8BAD/9knNBt/P+1prW8fLpsZbgHg=;
 b=XFWg+3Ai8N/3a2u6WgH1ucndRdHsUVbxr9/70692cTANTm0mbCoS27dk
 Var15dO2LzMuJc8LZxytW4ZOsKwOX7TG5OrhEs505gSlJV6XEmP0kkOVq
 PPf+c/VjlAE63+P55NWP3JY9qL9GE092uwLWMmPgkdf4RiDOI/yY5qebD
 fW5sqNpby4gge1gJw8t9hrNG/uk6pWSOqe43Z6ozTQLxaNMAX5fKzC/E1
 sAQSl+439e592bhtYS5+2vlxEH716IojxWc0nYqATAlaXTNcEypJORKth
 yIbd4HVgWUjaL22CQLM1c2brQqVQQ82K+qfOkjIDkQRc4in5RDgM5nvCR w==;
X-CSE-ConnectionGUID: aL4eyDASQLyrVB8QuO10ng==
X-CSE-MsgGUID: 4GvnHxlhSuqCZBaTRQMc0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1498925"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1498925"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 03:17:33 -0700
X-CSE-ConnectionGUID: Qr/8Vav2RdqFFElQRIagig==
X-CSE-MsgGUID: 5i0hubKKSzuLiv4S6rbdow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3699903"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 03:17:33 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 03:17:32 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 23 Oct 2026 03:17:32 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.35) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 03:17:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HA1jyI9HiJb2XA42mJcTHVyBteLUiCdm+T7vSFCHfXss0VZYcD2XsLX4iOwMmYv4+h3loXDsMbsNjfEO44U8+YnbodOn2m9pxxubVCmXbyvxdxR/27ILGJOSJO2lD9cfsoYw740CE8jfcnZAI/59cFc+x6ud2Jj2TDwASU9owoGZhioamg8qgTj8eC395ZbpKrrqAg8Nm5ZHKZ8DORwkezjuttRe8AZO+kmUdHbAvNptXO113QBAu1mu0+SORFfZ0dHQI4UJfTFqa4R3GapKnaK1SDtXo4a7KzOx/Qbo6u+jWLWORJ3fzSKSxBZuoooy7c7BepnDaoCOH41GVp8snQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBZniWYr8hFbmTC8mPlgV9QyizLOeOwGmlMrwCdrjh8=;
 b=dxhD8VO1aIkvPmGmSOGUd0YSy3QR0tif3jVFlAgb4+PjlF9byNXFSMzhEEU7b5pq7RuqDZLuhmvVKDez+UnCh3OgtpzHcBUxUocRsrVj1ri9XV5zL9KAHf38gf4ds4ngZhpt4Kjb81SfekGd8JUu3plzmwLXTG2D90dt1bvlMby69gf8/WzPjElgTbmvgMyBw0vex3M8hRDb+GEnyUTMQ7wq7uPDp5BenIofrgWcq7XJSyD9H5jnAwaQnTeGTnap+g1HPb4+cTx/uBr1Czk0pq4arwd8XmkeP/oDan5ifAUQy1nDSHp+6j9kIQp1TClJFYrV7HwjJtoKZb8TRzq2Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 IA3PR11MB311547.namprd11.prod.outlook.com (2603:10b6:208:53e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 10:17:31 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0522.017; Fri, 23 Oct 2026
 10:17:30 +0000
Message-ID: <25893dcd-99b0-44d0-a9dc-2947f2da59f8@intel.com>
Date: Fri, 23 Oct 2026 12:17:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] Update ICE base driver
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>, <dev@dpdk.org>
CC: <bruce.richardson@intel.com>
References: <20261022165205.1830735-1-vladimir.medvedkin@intel.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20261022165205.1830735-1-vladimir.medvedkin@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0034.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::11) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|IA3PR11MB311547:EE_
X-MS-Office365-Filtering-Correlation-Id: 8af7130f-f3a9-4ea4-9e07-08df30eed8a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|56012099006|11063799006|22082099003|18002099003|10067099003|261022105027099003|261021123027099003|261021121427099003|261009223027099003|3023799007;
X-Microsoft-Antispam-Message-Info: QOn9c4fTDLCHAgw+8EaLwvhRfYbFO6Lg1pNxIKVizXZOIB9vcx0TrjQzwSb8IUSt+xWH4j0AumO7IvXfUg4eVyANw/PPz3JEYMcx2YBSPlwFgDC8ifYu5y3WF11paFsDxDaxj8pyx2o4bflQqcGRoZVfNveNwT/t2MD5ASAgfQfiPIiECs5UnayQ/DBE0GHgXA3ORSGkwdka6siuUg/V7Gu5HmEonzWpZEWjebhyVyYJ2nhWMDpVPYyt0FiGwN5CxOpIgGTEcsHAQW6Wk2Y+GrOliQBo1/Xzmwl0mmOPk7kbdr9kHdSoZga50g+7Bl5sn1PQv7G+3310t0B7lHAIPge94tu7PTmoLwlF65b9n1d28onPK5sgUaFnqU81BaS4oOM2yhlnkntvg1RJ6nONHo0su9taKRD0hNj9XpKXaaAoYCbYbuyrq78XouS2PvvF8KsjS8qaQOCLA97lHvhu/59Jg44v5rmZxi75P0IcyH6HVFim48dFji5h7S4xO3iizkURblJnVpMhJxPpSbhLSC+fyacvcxH7yoxXB7a9zY+b68Vpe6lzw0TOJvFYyA0wP8k1AW88G2TmBAsXqTFNPn0Twu5KKyVPU9wbdrMGyYweOaGaKAgpFXufLZdJsLPWR+BZs3H/4Gaih6zWXyYvlNDPDzYTyIi/vEnMniKHEL4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(56012099006)(11063799006)(22082099003)(18002099003)(10067099003)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0dBSW5aZEt1SEVlKy96UzJEQmRSR3dyelBiMzltSzNSSHFJZ1BEWCtnR05m?=
 =?utf-8?B?bTc0THJZM1lsTTdCcnczVHJpa0hLcE5pdnl0Vk0vYlBrZitPSWNDek5tWmtC?=
 =?utf-8?B?a2VVcWtXdTUvcXYvdmxwdUpFUWgyMitVcEVBa1lOV2JwMk5MOXJnWEd1V2dI?=
 =?utf-8?B?RG9NNHhLRk5uNmFERFdlSmxpaVJoZWM5YjYxbG1UaWxVRnhRMHZ4Tks2ZWww?=
 =?utf-8?B?ckVnOWNnRWRET3Q3NVRoamkvS2hhVGl0aWNqZ2hLc29wa2ZZWFljRzJCQlUx?=
 =?utf-8?B?NDMxVjVlR0JUUG1xTllhZDkxeDNMQnQ4MGszOUtqZ3Z3cVZFMmdmVnpaMWZR?=
 =?utf-8?B?bmpCbWVmN1F6VEpQSVZlSEoraWF0UDZSQ2dvOU9RNGVCbHRBWWYrN1pWSGpQ?=
 =?utf-8?B?elNBMHEvU1RkS3VTVHhSYlpCVHhEQ2gwa2JGTktUeG5KblEySDVEWVlpWkl3?=
 =?utf-8?B?VVUyWU9kMTFMeHp5aDk0N3Y2TlRZTkJ3M3hlelBpdkY5ajMvUVozSjZEV1p6?=
 =?utf-8?B?d0UzRzFON1l5enRudmJWNS9Na0pLR1lnSk45eGwyMEhvSitzaTZ0RjdEU3oy?=
 =?utf-8?B?L21BVUNCQXplOXVURVMwQ1VDblAxT3d4SlRORWhoNVVkRzRxanYzTmhIcmZZ?=
 =?utf-8?B?VTlwTFpvUUtOUVpwMjJ2L05oRXdQaXdVbUVuSnRGajJzdTArL2lBT2NlNmJJ?=
 =?utf-8?B?b1pyV3QzUEk0TDVCelB3L2JITm9FdEdBSVBQQmZVd1RQMVpUK21vR3Y0VXox?=
 =?utf-8?B?UUtJUzlsSXlFa081WHgxREpBcW5USk1aSnNzM2JKWS9vN3FpUWF2MTJHS1Zo?=
 =?utf-8?B?R0xkVXZrbWl6YUorVWxBQnFEaFc0UGxicHpFUzNSaDBzc2RUSUd1YVZORzUy?=
 =?utf-8?B?RWJjaFpvN0tVdFMwZjdveTU5ekw1RzdYcUpEQVlFT3Q4REJEQkd5OFFvT3BC?=
 =?utf-8?B?LysrT21SN0E5UTJaRjhtcFJNVFRuMnNvNVRkRmN5WG1Ja3NOMlU1M2NLK2hG?=
 =?utf-8?B?RWlWc2dQQ1Y3dHkwUTQ0Y3lYc3pMMWExR2NjTENuKytFdlh3cDJsYm9uZVZD?=
 =?utf-8?B?MU03eHNmTjdCaGxRV1RwUjRnK2tBVXcvQ0xaS3dyTWIwZzM0V3paVHBXbmZ4?=
 =?utf-8?B?UU4zZUJXUCsrdGp4MGNnSVlWZUtUdWllV3I3eUQ2WU13T2p2UCt1SWgzUjBP?=
 =?utf-8?B?UFArZ2VwN01wZ2xXT29pQjVUNGJBbUlDWUovOVhHQUNHM1JMZGlKTkhLWkIr?=
 =?utf-8?B?WlFIN2FieG5oMXllS0EyQ0Q4OExxMFlzMnI5RHZUQmE0TkxCUFp1MTlrM0ZN?=
 =?utf-8?B?TDN3cjJiUlpFUGNFYU1sVEp4dkZXQlRxMUNwS3llbGZLUTIxVURpdkxlK0hi?=
 =?utf-8?B?V0FPR3FvbDJSNFoySjhGSXNWOTBlMGNpMFluRFpJS2ZnbU9ObjFCQWVNVWNF?=
 =?utf-8?B?blRGaHFuQnJlQVVQeG5hMjlPSHV1d1NRMUlWc1NSL1Q5UEIraldtZUZha1BZ?=
 =?utf-8?B?M00rVGs1WTF6THB0Ym5oUytZU3BPZmk2L2Nwc2loZ0VjbkU0UGVLY2tKMG94?=
 =?utf-8?B?SmpVNWhBbC9HSnJuWUczRWlkMUtna1AvaGtXc1VrQlhhYW5tNjNTYm5RRml5?=
 =?utf-8?B?cUY5UGRnNWlZbVlIYUhpZkdZZGQ5MHFhK0tFTTY4UkNkMlVMOTROTFNFS2NO?=
 =?utf-8?B?S2FVNGVHelZBRGJyTGlRWGJVcmt1bktkeE8vTW41SFcreDVoQmNHd3Z3dlVp?=
 =?utf-8?B?OXdlbGlid1BnL2I5cXNrbXYxdGU4UnBqOS9ybzlIUHB2UllCRVQxOXgzN0lv?=
 =?utf-8?B?dGZUVWtVQ25sQTk2bFhiUnhGUmp3VDM2SG1qRjFNWlBoaXZ6aXY4eUdBZHI4?=
 =?utf-8?B?UndMQS92SlcyaGZzRmtwanVuNU1yNS8yYkphL0poUzFqaXNKRWRWd21TR242?=
 =?utf-8?B?bFZaWDFpT1kwZmFsMHkybzZ6Y1MxZXk0UVpBaGZvbU9ycEN0dUkvcVJLQldk?=
 =?utf-8?B?eU44aUpGNm1iVWY3UkZjdjhrS0pqWGRhZjljdTljaVFLUjlYSzJ2R29KNkla?=
 =?utf-8?B?dWpyYS9uUFVua3dTajFZM2RFamozeEtCYWVBbFNReCtBQlg3ZWZqYUh3WkZn?=
 =?utf-8?B?aFdmTkE3ZThwUmRzdEc0cklTcTZpTi9DYllLQzV4T043NTUzTkF2NU9lUnY5?=
 =?utf-8?B?alFFeGYzY1B5OExyR3p2dlJ6bXNVQTVReDh5TkNuVkk0UUVtM3RhTmpMV2pG?=
 =?utf-8?B?TkxRZnR6aSsvQktLYm1MVkFpeW5XSFp3cFI2K1k4SzF4dklIU0xZQnpMZ3Fz?=
 =?utf-8?B?a1MwVmpDcHNsaFlPbG1tWnkvQmgrQXdTdzNhdmIxazVRMWxZTEtCZklZV295?=
 =?utf-8?Q?LdoyjQuSdci8L8W8=3D?=
X-Exchange-RoutingPolicyChecked: YIj27d9yLe+rTEGIuzqQYldYGfz13fnro9KGbzAKKzm5H2zpWiKoO/r3kddcs1GPJTfaTRe2ds/SD8DhMmLmc/PNpmYuRtGOwuZABK/qsJrQK/050ocXpu/C3L4w2tMkUhcNSf57011X1cIjoP0h+y3diz3N5aGLupqGzcKiXxoNgubnTbzcefoxlH7u1Mv4DKp1nU4z6b16VKQQsk4YLP0uEni8/Lm5GLqQcqkHsS7u9NZzjSUkLu3HQMaa164X018kecTwAHrrZc+hmpRAGdm85UG4+TDiQxagOoaJXddWp/K9R6K2x9/eHcJF8xVb6LrLvd//gDpY9hqFy4xyIQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af7130f-f3a9-4ea4-9e07-08df30eed8a9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 10:17:30.6406 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S0YoT06YNY2dScwA0RHzZ3Gug98R+fBqxIpR9cBoy+CBx2oY4pWYEeIjQpWJEWh3hh5pY54ZBU5PpkNxetVj8UGNpyC1tOvxhZAEOfkVnSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB311547
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/22/2026 6:51 PM, Vladimir Medvedkin wrote:
> Update the ICE base driver to the latest shared code snapshot:
> 
> - Bounds check, integer overflow and type fixes
> - New capability and NVM definitions
> - New E835 10GBASE-T device ID
> 
> Chinh Cao (2):
>    net/ice/base: add NVM definitions for Wake-on-LAN config
>    net/ice/base: add E835 10GBASE-T device ID
> 
> Deepthi Kavalur (1):
>    net/ice/base: fix loop counter type in recipe creation
> 
> Janardhanan Arumugam (1):
>    net/ice/base: fix out-of-bounds accesses in DDP and NVM code
> 
> Krzysztof Galazka (1):
>    net/ice/base: fix integer overflow in RL profile calculation
> 
> Przemyslaw Gierszynski (1):
>    net/ice/base: add RDE WoL override capability bit
> 
> Stefan Wegrzyn (2):
>    net/ice/base: add PQC certificate provisioning capability
>    net/ice/base: add NVM write flags for eRoT minSREV update
> 
> Vladimir Medvedkin (1):
>    net/ice/base: update version info
> 
>   drivers/net/intel/ice/base/README           |  2 +-
>   drivers/net/intel/ice/base/ice_adminq_cmd.h |  6 ++++++
>   drivers/net/intel/ice/base/ice_common.c     |  6 ++++++
>   drivers/net/intel/ice/base/ice_ddp.c        | 19 ++++++++++++-------
>   drivers/net/intel/ice/base/ice_devids.h     | 14 ++++++++------
>   drivers/net/intel/ice/base/ice_nvm.c        |  4 ++--
>   drivers/net/intel/ice/base/ice_sched.c      | 18 ++++++++----------
>   drivers/net/intel/ice/base/ice_switch.c     |  2 +-
>   drivers/net/intel/ice/base/ice_type.h       | 16 +++++++++++++++-
>   drivers/net/intel/ice/ice_ethdev.c          |  1 +
>   10 files changed, 60 insertions(+), 28 deletions(-)
> 
Series-acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
