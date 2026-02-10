Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DFDEA811B
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 14:14:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78794400D7;
	Tue, 10 Feb 2026 15:14:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 7E506400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 15:14:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770732883; x=1802268883;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1tQ0qkBJXjaOOH96cQcYkWouauMGf7kYE7A6YdiwM5w=;
 b=WitLmiQUqd5duCGGlUOjD2UbWImve3iqIxPcinJVWvFUIH+U0UqtpJUv
 aBDqiQlZJFjGJNKsAKcL+Du6TWzDamaprYmj+whnm8UCpRnhWsVF2b7Bv
 PmdtufCJD8fKuLDMsgSqOiIDQPHayLoDJvUX7OKUaxrFRWTAdXk/VOysA
 mg/b0i5UxF4p8dg75TltgJ0pJZIXNg1vIVaanLhdEmHiddrwCFV9V34xK
 2+7/stXWrkLjr8D1yr1mYZTH0Zxj3qgn6qgpDJJMyb2qBxhPBpyqTx4NQ
 6WsVZonWHt2ZskrFAycfTRsbpqw3bDYCSZOfurh9rh/K7KnnbIr45C5bk g==;
X-CSE-ConnectionGUID: yFkn5dNYQu2evwJzKkuJtQ==
X-CSE-MsgGUID: bYPbBbSHQtGYZ4NGbY+7dA==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="75707399"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75707399"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 06:14:42 -0800
X-CSE-ConnectionGUID: ZrwwApyvQ7+Rhnl4iHGKaA==
X-CSE-MsgGUID: ttoFrLMvSlaUfTdX4SaNlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216267040"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 06:14:41 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 06:14:41 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 06:14:41 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.20) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 06:14:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O4D19SIPB1Kcj/U0ibknOk4z4i/LaWExqIX/zK/EOJng8T+TRkr7wq7bacOGR0OXujnjYGNXAtBr9+3Vr5Af4lh/ZseLQC6v+oJAG0drPL7tQ8RLYzm9th6FLQea8EEXi6se2IUJ237qZ6OQUIzfc5jlN8B03qElfAlIGnoqvhjEr1xU8v6+6E9K7Cqp7d3HtXbxokRk/5QjdorzKNubIVqa4aO19lrwM4cCoi+FrWqoLRgIgJYnbOi05D5wLmBVy3SGQU2Jqg9CnU6lGhufCdFGwpWBwTjHB7e62KpYKS8VFrOETOtSRgpg5naMdnjrMY42gjtzd+lqisZu4XKrsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tK1j75fo91sC+WOHril5JN/uaT3nnDNj+eout0gaXo0=;
 b=yYFAkDq8O7K5SRA83+x52ri8+M+ZzrM4n5E/Ym1BHyLX236Tg8uYnO8RtgQds67Z+gSsZKvHkdh3P5FPr4H3/su44me/xQ0vaMlzcpCx3Ktk1SC89A2MQRGh/ti6QtUDY/YJXhMr6IAlSD2fR+wnyoBxia1lkoOFIhey7joRcxfGQzb/3Wog8oKhOCFk8hkZ8JDYpEfJd5AIuCvYZlNNrN0pVt2kVbZRmkPGIn/XF8EMqhzuIfq9/MMDroP15kYh5NUrZQG1flKhcc5J/JObbNfWm4xr8PMiudDmGvmFxrd/KbvljI9NforrkZ5SFyhKF1PlbptIujcDtOgWUyoJkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DS0PR11MB6472.namprd11.prod.outlook.com (2603:10b6:8:c0::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8; Tue, 10 Feb 2026 14:14:36 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 14:14:36 +0000
Message-ID: <3252ccd2-6c0f-4bd4-ab53-3d54aec2e425@intel.com>
Date: Tue, 10 Feb 2026 15:14:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 26/35] net/intel: drop unused Tx queue used count
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: Vladimir Medvedkin <vladimir.medvedkin@intel.com>, Jingjing Wu
 <jingjing.wu@intel.com>, Praveen Shetty <praveen.shetty@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-27-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260209164538.1428499-27-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0025.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::25) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DS0PR11MB6472:EE_
X-MS-Office365-Filtering-Correlation-Id: bc4aca5b-b0be-43a0-b233-08de68aeb89a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXY2TDJndW9maDFMQzdVUXVqZkN3NU1ITlEzc0IvWThnODNoeGdFRkxVQUQ2?=
 =?utf-8?B?eW1WazhzTUxmbDlray9MZGtWdVlnWUFVS3U2N2Z6R3J0MjQ0c1U5TitUUUVk?=
 =?utf-8?B?ZXBHQXpiOElOOTdTZURUNFlxOUlzb21hVDlNTjBZaW11dkZ2NmwwdUllZnE5?=
 =?utf-8?B?Q1FZcWtOZ3RKRFF2Y1pjUHlSZFpuT3pJNmYrVWNML3hsVHB2Umd4WU1hNHZo?=
 =?utf-8?B?bDMvb1ZSbE9FODNqSEFvcXRObUNOcUhTVW5EdmFJTWFYWWt6ZGswMTR1aXg5?=
 =?utf-8?B?TDRjSnhLT3d3d2dHeVdXYVIrNzZ3emRyd2RZam9PdmQ1a1ByVG9XdzN2NGEw?=
 =?utf-8?B?RThFVlJSL0ZkNWpydUxYeTBKc1BDNi9uSTJ3UlhuMXIvZ21DNWdCR2FKRHBk?=
 =?utf-8?B?dTY1MWJ6SzFHclZvQjgvbURnVEsyM1pjWmIzbHFYdzNlb2U3OXQ0NEpnRW54?=
 =?utf-8?B?d1FTb3NuVFNTSTY1Rm1HSmNPWWdmOFZBZGN3U2Y4Smk2VW9SK1NwK0NTSmlP?=
 =?utf-8?B?MERCY3hvTG93U3F5SUtyNnZFZTVpbWp1akp0ZVcwSUpOcHpBY05iYmJqcVV3?=
 =?utf-8?B?ZlpmT0dvSjFHNDF3akN4aWY5RXZ1VzR1Zi9nWmNmYWxrdEEzSDFVd3c1ZW9B?=
 =?utf-8?B?L0IrWkVOMXM3ckVsVS9tZkE4Zi9lOVlxVmtCUHBqWSt4WGUzelRCMmNKWFRo?=
 =?utf-8?B?OG44aUFlMlQ5bUZCM1FaVHhwd2tvU3ZCNXpsT3BabHMxZjlsN2lOV2tmRkY3?=
 =?utf-8?B?cFU1SE1acmZQNnk4NkVGZ2F1bHM5bWlBVjZDQ0lLUGxqd1FIMndCWk5JSGhH?=
 =?utf-8?B?R2N5SmxpQm5xV1lVS3pJQ1pGdm1YelVLSk5WOHZybGh6Q1RSaUJ1UW5lU2VH?=
 =?utf-8?B?UzBMZklsVnloMDBwbGdud1JWKzZoMHJGN3pPbmpnL1hiMU9KUkUyMDV2WFg4?=
 =?utf-8?B?cEJBcHRPRVozcDEwWTJ6U2E0TmRkUXFKK29vZmg4KzhDeWM0aDljckh5VE1X?=
 =?utf-8?B?c01pTWNHREhxaHBwZGxPeW4yNm0xTG9IanpnckRwVVoxanFIYTkxRUpyMDI1?=
 =?utf-8?B?L1BjN3NRNW54S05oMUlhNHRyVnlpQTkxMUdsUW1ySFpCNzRIWWIyMlh5Z1Q2?=
 =?utf-8?B?aWNqRm92Y3FBRTBKM0NRK3pxSXl1dGdqWUd4YmVTRmpHOTRGWUFUR2RxK01u?=
 =?utf-8?B?dG9yRC9mRzV3eW9KTUd2QUU1NWZuam9oZURnbHc1cnVxWjA3NUpoa3UyNjFJ?=
 =?utf-8?B?Rlpjb2tSdmM5ZkgyMHl3YWFMeVZ6ZFBGdTNWazhPYjN3VzhJaHNwa3MrNHJ3?=
 =?utf-8?B?Mnk4UkUyWU9KRWE4eG1ET2FsZ2ovZTh0bFFUYzBxZ29GNlZ2VGlGVXpOY1p2?=
 =?utf-8?B?LzhidkZWVlJIZ2F4aGxGNDc1YkZOVkk0UWlBVzllMkRXTU5vOXZpWGhzakVj?=
 =?utf-8?B?alRwUytaUGlVMGdhUUliaUYyczlHWlZCVVhwZG1SMkhPbmthYWpJK2htM1R1?=
 =?utf-8?B?SmVzWE04VkIvSDNvbVdlcFNGblc4ZnZLbDRvMEE1UjNUbGY2VmZ1b051SlZr?=
 =?utf-8?B?cjE4cm45S2VtZTRDTGNMbkE2TjFsR2xjOUI5TnkyZmdRK21RR0xJZUtvVUhI?=
 =?utf-8?B?NUNuZC9Oc1hiZ2h6YTU5Nytub0JlTzZTdEFkKzRkaUdFaVBtdjkzUXFnSnZN?=
 =?utf-8?B?d21tcjlYOVowREczemFlbng3V2M1MUhJQ3laV1ZTKzVmRjM3OTZEcDNxdEJo?=
 =?utf-8?B?dm9pa0JpMzd4czlQODgwaUtOb2F2TnZMcjUrTzVpVGJ0M2tOcHNsQWpCS3pQ?=
 =?utf-8?B?UzR4S3ZOZXYvK2hkeW45K0M5VWhTM2V6U1ZxMi9nTUJMZUxoZXk2c2dIdWpJ?=
 =?utf-8?B?S1ZoMHNSaUgva2lqeE9ENzZ1aWhaallJdWx4UEgrWDlUY0paVUt0S1BLU1dM?=
 =?utf-8?B?SVhKY1MraWxRbVVtaU1jdzAyT1RnUjBhZDdodlZrcVlFWXF2QnloS3IzWnpi?=
 =?utf-8?B?d25VeTRRZjA3YS83VTMrZnZrT2grNmpHelRxVm1mcFk4enFpMC9zV0svTjB6?=
 =?utf-8?B?cFdGbTJDb2FOaEQ2RnEwdkk4cm5nWmVleGU1RWtyMkZic2pvZnVTZTN3TEZw?=
 =?utf-8?Q?m86Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1k1dWROL005S3R0ajI1RDg0Tnpnb045Z0Jaakc5RGxKdFJtNG0zV2d5NGNn?=
 =?utf-8?B?RWRvaHR1SW9JRy83Y3VyUCsxR2FGTm5MbWdVMFBvejJ1QXB5czI4dmd4Wk9V?=
 =?utf-8?B?UzR0bm5ZaXBjR2FoQklpL3RSZURhOHhBYjVNR2hNSzFOMHlsUThhMnBYU1JQ?=
 =?utf-8?B?am9BcHM1SHlqQVUzS29CRC9lQlh6bXg4ZVZjU1l0eDF5ZkphZGwvVFZqSGhv?=
 =?utf-8?B?UUdCQmo1Undzbis3bmNhTWNvbEM1MnVEQm81TTI5UXhKWE5idWpYUUtFdkdG?=
 =?utf-8?B?bmprVDQraG40TDc5b294eWtXTG9kU2t4d0NXSUZOZEhnOHh6dHRoRkp4aDlU?=
 =?utf-8?B?WUZYTjloalgyaU52UlBmaGZwV2lmR3JJa3R5U3pkT280RlVaUXBmRkRCMlJl?=
 =?utf-8?B?U1hPY3I4bUZhV3UrRGJ3ZE4yS0VuMWFMLzVVQm44UTE0ZTBpd1VNbGo4YkRj?=
 =?utf-8?B?V1FBekp0NEdYQ1JLTk5ob0lVQ0c3aHVHNWxoTmlYQmRoaEUxL2p6V3Fya0E0?=
 =?utf-8?B?WTE1RVBnWDhPNitCOXhnTldMN3VFWjlzbHlJUXBsZE45dTdlMnlRUENMbTF5?=
 =?utf-8?B?ckwxRjBQamM2c0prdW02aVVrOVQwdmo2a1RTc2tmdURsTTBiQXZxQlJaalBa?=
 =?utf-8?B?WHc4MWszMmJDajM0MHRyME01QVhIMmVJVVQzWEFXM2pJQjZvVThmeHByOFdU?=
 =?utf-8?B?bG9CcGpobGlNZzNGYXZKZ3JFeTV1T1lwVndodWFzWkJVbGcyNFVIZFdTN3Zy?=
 =?utf-8?B?SnBwNS9Cb3FWYmJhclZndDRKbnhZQzJ2UWRmWnNaMy9pb2U3ZEZJWGNVRDRl?=
 =?utf-8?B?RGRadWtMRHVxV1Qrc3FuOUQ0VW1ZdHQ3VWdwbGhCT1E3S25zVTdmYk1YcFlL?=
 =?utf-8?B?MUNVRzJsVUN3Y2lTMHhKbW5FYnR4RWJWUzhPVFBMM3g2TzQyNzNWS3czWkE1?=
 =?utf-8?B?bFE3dzY4Qng5bDljMU9DTEgyZ1NQbXZMM2cxVEM5anNzOTVoMS9iVnlUUzgx?=
 =?utf-8?B?RnFQZkhSZ3d6bldHd21oZEFINER0TFU1enZYYzhSVVV0U0QxZ3Bjc1dTYjNK?=
 =?utf-8?B?aXJCUW1sYlNuSTJTWnZYNEdzVW5JekQ0WWl1NmgvSXg0dXQ4M2hoTE42SEYz?=
 =?utf-8?B?MkhldzV6RFkwTVpFdnVLT3VvcDdzWDFxc1Z5YWxNUjk5ajlFL3FwMEVtK2l1?=
 =?utf-8?B?MXZNR1VSN0VzZWhhK1d5cUJMdkc0OHo0ZUZXMmVoZURCNkNKdEZxaWZTTnVx?=
 =?utf-8?B?VnN0QXAzT2J5Rk1QaFdWWit1cFM5ejMzNFY2R1Jyai94eGdENDIrbTlONzlq?=
 =?utf-8?B?S2FpS2g4L3JRWE8zR2pTclM1WHNmTGxyam9uejZHaUtaWGkzTmhJa2xNcERw?=
 =?utf-8?B?ME5la29oV0NPY2F0L0xVS1VFQWVpNGZzTUw0Z3BScm5OY254ZkIzUXJLOTk2?=
 =?utf-8?B?UDFLd1Vxc2tST3BTaUN1YWZwUG96blVvdWQ5VzlzOUlCbmZWUnZsZjVLZzVO?=
 =?utf-8?B?SngxZStsNXJHQTFBcTNVdmVlM3NFckkzM1ZyaWhFRy9jdWowTytSNEVYbXF5?=
 =?utf-8?B?endBaHNXY1o2MWV0dFM1QkhuTVdKbFNhODNJa1Z4T2FyUktvSHZiLzEvZ0xO?=
 =?utf-8?B?M290S1k4MXpKR244S2prM2syazlyaVVrdHJPK2loVExITFc3QlRKTUpKOGtm?=
 =?utf-8?B?dVdVVnArdU42U1lMR3pXam4wMmpSd3ArOEwrSnV1M2FVS2tXWnRzcVlSYm42?=
 =?utf-8?B?bkduUThRcDdWcVhMWHdFOHJ3akttcytGS1ZkYmM4ZTV3QWU3RlZwTW00akJl?=
 =?utf-8?B?clE2VDRnRWNpY3FFdGdnb21LNlNPMDUwRThuYnQxZ25vNzczblNlUlY4emRQ?=
 =?utf-8?B?b0hQZW5PT01laWc1QmhzY0NTOU02L3VzaEJqWi9WczNJKy9YWkcwMy9scEF2?=
 =?utf-8?B?b2FzZXd4aTJtdFlvS3UvZFh6V2p5ZjIvRWZZQ2VDOWc5RjhKWGg2Q3R3aG9U?=
 =?utf-8?B?d2pwK29mMlA4WGNUTVdsR1UxQTJYK2lrWjZwbGx3QTJCbnFMNGJlRml5SW1X?=
 =?utf-8?B?UnNEdXB6d0U2WmcvZU9zeDJTcGRZRnpabVF6RXNMQkJOMXd6NkUwR1FGUldz?=
 =?utf-8?B?OTJFTUg2ZTdDZHI4eWE2MUVZcmZrMmtMaWhGV05SYnYvQzc2YlBuUTZBcnBh?=
 =?utf-8?B?MjJSTjJrTk8weS9Fb01DMUo3Q3V2T3JUdUxsdTR3RDErVFVMTEsxalVRWDBH?=
 =?utf-8?B?Nlh4UDF1VGJobnZCTkY3TzVrWGExeVZOdFlMTUJOZWJSNnZTeGI5MzQva2lG?=
 =?utf-8?B?OHpueHEwNU5tdExWaEN4S2p3Q0VnR3FTQW50SFJTNTkrcVlUTUFNVzR6TE5j?=
 =?utf-8?Q?kORh5rx4WRz6qIzg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc4aca5b-b0be-43a0-b233-08de68aeb89a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 14:14:36.6130 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YMuPhBL25LQUUsEaLVTymhqbPiasRtVtOg8chWrbv+6CqQZGbpU8S1WgLX5BuVBvV2N7ieGxbgriiokEFqHTb78wF602F+v1Mkq6jNZXWcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6472
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

On 2/9/2026 5:45 PM, Bruce Richardson wrote:
> Since drivers now track the setting of the RS bit based on fixed
> thresholds rather than after a fixed number of descriptors, we no longer
> need to track the number of descriptors used from one call to another.
> Therefore we can remove the tx_used value in the Tx queue structure.
> 
> This value was still being used inside the IDPF splitq scalar code,
> however, the ipdf driver-specific section of the Tx queue structure also
> had an rs_compl_count value that was only used for the vector code
> paths, so we can use it to replace the old tx_used value in the scalar
> path.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

>   		txd->qw1.cmd_dtype |= IDPF_TXD_FLEX_FLOW_CMD_EOP;
>   
>   		txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_used);
> -		txq->nb_tx_used = (uint16_t)(txq->nb_tx_used + nb_used);
> +		txq->rs_compl_count += nb_used;
>   
> -		if (txq->nb_tx_used >= 32) {
> +		if (txq->rs_compl_count >= 32) {

Should 32 perpahs be a macro?

>   			txd->qw1.cmd_dtype |= IDPF_TXD_FLEX_FLOW_CMD_RE;
>   			/* Update txq RE bit counters */
> -			txq->nb_tx_used = 0;
> +			txq->rs_compl_count = 0;
>   		}
>   	}
>   

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
