Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6E2C83F17
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Jul 2025 15:12:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0125F402EE;
	Mon, 28 Jul 2025 17:12:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id A0C174025A;
 Mon, 28 Jul 2025 17:12:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753715532; x=1785251532;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=HzjZnEP/f3z5viRiqWxq2edhrS7/KM/LMs+LEnncRXE=;
 b=RaPU/T1iHZ/ksOMChOlaNEhYnefXExRbGwvw55wB00lq/vZHaT96EcVQ
 RZ/uCzFs2jSW4DgyYf+3HHun3GULnmJLIcbz/CkQ6HekeOwujd4JLGypg
 /1Qn7ZJ7yNYdzByImNXKWdnnGlg4D167wmZycaaTfUAeFdYuCG1CnINMJ
 FVsulMgiuv5iuA9G3SGmnSluh6xGuzRM4aYfcLYO3lnmN0tqT6y5v6gyg
 abetKT65KAZAqPhVLtAS1OCD4//bLHBR61xWJZrk+iHcDbrHPTvgCdYje
 VwcgkUilI8dMo0SmQkOhyCx+Gk+GvWeF1oJ5OR5Gz4OubPYhOOb7554xZ w==;
X-CSE-ConnectionGUID: JLUcqfR3SKCVtJnpt3jueg==
X-CSE-MsgGUID: 2AOetcONR4mz5HjSe/vJzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="81407602"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="81407602"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2025 08:11:57 -0700
X-CSE-ConnectionGUID: ip5hI1HtR/+Fp1nquW/5RA==
X-CSE-MsgGUID: 0QzjD5KbTlm6A5jQeVpfDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="166682582"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2025 08:11:56 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 08:11:55 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 28 Jul 2025 08:11:55 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.52) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 08:11:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBZezKfSi7ZriBPj5DikMUJPjiUB3ilD16hbQG98AQvWbXQP54ESk9z3k5B0HUg0yuiZq6QaH/u5l0QKsp0amCwTdFChQpl42/yhLUC4+m9fl/RV1K1ny1ijPfMwWybDzu0k+p2BJt0jkRFwsY+nDGmzAw/XSvwcVGB9o4szPebOnIqPzHrgNRfXSSj00UTpvu6QuO5cCqEmHcA055CE9x8aBITSUJiwBXev69Dj/tuj+xmIXgcJUxyE+J5TcwkwIOlXEh4yi7IaTpn2QEhYT5D+pHkMxNWa6BpKVOWohdZozaYzh3bCdOV9gSbhqOC9+l8zBtdGl3ILCk8NM6KFpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfWLGyJqGALI851EapDdHII8tyU3Y3SLHmgE9Fc+UKA=;
 b=pf9vS2B35eyg6v0hB5RfdUxM5Vs454CbyBFy7IHOBpxIXXgtelz506Lq5L3PydmzD83xzETV6a5Os0hbsfxM4jRMhonB05LSxGVeXsVlIZnbqZYWZJ7a24hzDl0M3FCYKo8abx56ggrckJO7OJLzxYEEyQ1U8bhQYq6nOFO5r25KHIzw3X2kt0Bo8eNS7BGfAA0AxbT7RslPGF33bKE4+vqxOQ7Nsum2M7kWKeq0Nb4kIZXmgx36dSGTzLlTUb11DXDbfuA7QGq+XojR1QbJKUJ8NPu/cnJVtvuEc1z2zKpjHbuMJRZtC2B8vtsl17r5wLMYP1kaEslB+Jh+xGOp8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB8433.namprd11.prod.outlook.com (2603:10b6:610:168::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 15:11:13 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 15:11:13 +0000
Date: Mon, 28 Jul 2025 16:11:05 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, Dengdui Huang <huangdengdui@huawei.com>, "Vladimir
 Medvedkin" <medvedkinv@gmail.com>, <techboard@dpdk.org>, Patrick Robb
 <probb@iol.unh.edu>, fengchengwen <fengchengwen@huawei.com>,
 <stephen@networkplumber.org>, <jasvinder.singh@intel.com>,
 <thomas@monjalon.net>, <aman.deep.singh@intel.com>, <lihuisong@huawei.com>,
 <liuyonglong@huawei.com>, Dean Marx <dmarx@iol.unh.edu>
Subject: Re: [RFC PATCH] doc: clarify VLAN and QinQ stripping behaviour
Message-ID: <aIeTCX3KbnxIvDJP@bricha3-mobl1.ger.corp.intel.com>
References: <20250714133014.44597-1-bruce.richardson@intel.com>
 <CABD7UXPVg56UwvmtOsssBwV2HzmgV4ZJZCb=FrnVQKkggtD2+Q@mail.gmail.com>
 <aHd6x3kT053EvX2g@bricha3-mobl1.ger.corp.intel.com>
 <CABD7UXPtChUUOdz3gfiyKqY4Rn2_0F8Ck4O6ypq9woATD7hfCw@mail.gmail.com>
 <aHgBs5DGU48mTnwz@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FDB8@smartserver.smartshare.dk>
 <CABD7UXPccao=o1O=SessoAdEKUyA-dXP6HG5mnkpFSVNL_3dxw@mail.gmail.com>
 <aHoEUmesrg9Y8qtM@bricha3-mobl1.ger.corp.intel.com>
 <CABD7UXOqkROef0_BreD1GHC_R+7EwxRTL8LF-fXQJBECp7J9SA@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FDCD@smartserver.smartshare.dk>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FDCD@smartserver.smartshare.dk>
X-ClientProxiedBy: DU2PR04CA0353.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB8433:EE_
X-MS-Office365-Filtering-Correlation-Id: 25bbf889-1ee3-4e0b-388a-08ddcde8fd87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NkpVS3U3VHBaY1NIZVlIRDhrL2F1VHB3SjJBK3BobnErcDlVdnpPVTRhRUpR?=
 =?utf-8?B?b0V3bU5DRW9STjY1ZW81K25jS0tUV04rVHViZExVbmRhNkNIWWVaS1k4SFFs?=
 =?utf-8?B?YWgxd1dNTEZ1bTVjZDA0TE82dEFwVGVYTlhBTjlsQzlCSTd4UkxFMkNpVnRP?=
 =?utf-8?B?ZjN3end5d2ZSUmV5RWwzdU5XRmdyOEFwaXM0ZTBDeWFpTFQxQ3JLZExtWTVn?=
 =?utf-8?B?aFJ1UVVFU001dTloZlIzQUtZN3VpSkZVNVI4N3JxTktxandidUZIdXA4cUds?=
 =?utf-8?B?VzVWcGZDK1Jjemg1dHNqc093WkRjU3RQL2h1aXdRNExBb2xxOWFYZFpjc0dr?=
 =?utf-8?B?RnRJdy8ySmlabE10ODdjcFNrampGNys4YlR4ZnNyeGdSYXZTZkNvQmtZc1Zk?=
 =?utf-8?B?dlhNeGNJTndSVHZQZ2M0UlJvb0xQZDVoVkdMaG5ocGY1U2dGY3ltbktGeVRZ?=
 =?utf-8?B?cFY0NFNLRjFqeHk0ZVpoRnNCOXovVW9vZUtvdnZ3M0xRb2dnNEFOcUFXRDB2?=
 =?utf-8?B?S0FTaTlrNzI1VXBnSmZIbkhBSWFmRTB5SkxlU1cvQkIvRVNHb25jamttTVRJ?=
 =?utf-8?B?TE1wenlsYytJdkxSb1pCZXMzN1hLempjMWVkSndQdERXaStmWTdwZTZuZ1Ir?=
 =?utf-8?B?aHJMMGJnSlNwY3M5ckVxMXovRksyOHgwWmRKRHJiWmNiNDBvalNFaHFzeUp2?=
 =?utf-8?B?L3h3Um52UzRzWTdHdk1WNG1UU09iOFFZVU1mU1JmSWhQSjhoZjJYaXVaaFMw?=
 =?utf-8?B?WXJJVVJBSlhuZkc3OHJOdXlMaklaako3NG5DbDR6U2hLVjYzRFhmMDJQTS9W?=
 =?utf-8?B?Y0ZwcFZsbm1DUWlNRVFCaCtUZ0NYOFp2SStuamxWbk1PWW1HTWx5T09UN1Rp?=
 =?utf-8?B?c1lJWmR3ZkFVQXoxLy9EckgyUDErSTFiTnJKUFhvcElYcEVQREpObzVBRUN1?=
 =?utf-8?B?eGVyZ0FwbEZZSEUrUUlwSU0wNHhtMVNwZGxNNVp1QWkyWExtMWZoRi9WNFJm?=
 =?utf-8?B?Vyt2REJuclR2V0R3NGhpckFCNHVQaFZMSWNLdjZlMWJYWHFvbjZzNi9qVkVX?=
 =?utf-8?B?LzhKRmdLQXhRN3N6engxSUN6UkU3OVRIV080T0RhekZGSkVHeFFyU3UvNGZB?=
 =?utf-8?B?eHZ5OVI0TlV3c05Iajc3V3ZMUWhseUNmTmUvTFBWMTRUaEdXQ3hyc2o5NTdw?=
 =?utf-8?B?TkE0QlBHeDQybGlvUklwTUNEMVhwUEY3K1hqVURNTDlRbXd3QjJHVGtqMHBK?=
 =?utf-8?B?NlBneWdCUnBlMWZRQ1k3ZUR0NTluMFd3aWpoVGdiWTBJbEtXTlU4K2oyZGxD?=
 =?utf-8?B?S3lST2lwZlRuQWhFRkc5OEwremhFTWJRS2tSRDVsbThSdmIyaW03cWdvb3A2?=
 =?utf-8?B?MTNyNi8yUHNHeGpUZjMvYURNdTNQTjdEQ2VPa3MrLzB1UGQ5aXBOR2I1V2VV?=
 =?utf-8?B?blh0YlZBL1kzOWF2ZUZTcExvdklZSXB0K1A5UUFDdFR6enlEeWdMZm5SelNG?=
 =?utf-8?B?UkpkZEF4bUZWMThhdE1pWGRGUXJoR2dIWFF0LzBUUDAzWWNLSWRaWlV4RWd5?=
 =?utf-8?B?WXB6WTU5cVNSQ3RzbVhHYmwvNmFlNUp4Wk9pTmJYQ3RZWmkzbEJYUTZYZkhz?=
 =?utf-8?B?Tm5Bd293Q25QaWZ0QlNqRWltdXFWcHlnR08yRDk4VkVkSnRmLzhBTitmcU44?=
 =?utf-8?B?a1MrQWxhNDZTSE1oM0p0T3pYR0VYUHR2eE85cURTVm5hQ1VoTWtrYU5FS0pQ?=
 =?utf-8?B?Syt5dGMyV2tDaW9nbFVxYXFsWG9sNUh2MVZYQnFEbGFRcGJkUzR6cXIzd0pl?=
 =?utf-8?B?VWJRK1ZBdnc4MENjWWkzSXpsWmsrVWxNZjhxTmQ3ZkpIRHZ1cEs1Z2tzVUhI?=
 =?utf-8?Q?w2oj5vPv5UkWE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjlxNlNaNEhweDlYTjVLODBUTEVhcVRveDB3eDR3MEg1N3YrYW5YcGROYWRj?=
 =?utf-8?B?c2VkT1hSU3RJdklwbE1LVGxWb1Q5bi9CYnNJSnFIREU2eXJVWVMxd0FXaEdG?=
 =?utf-8?B?NnNzeERleXBVcWc5dEVoUmhaYmh3REVqb2txZnlSeis1RjFzb3FTbUgvMDBI?=
 =?utf-8?B?YnNvbHFObktOOWE1UEY2WVlNUlpOODk2YU52RDR3RVJ4dTZKOHJXdmM4cWV2?=
 =?utf-8?B?V3cyZzNGb3k0Qm5zY1RJa01nVmV1bzYwbUlSSWgrNTQzWkQvQ0ZhSUZJcXl3?=
 =?utf-8?B?dmE3bzdvbDUrdVBwaEd6ZXBlN3NvMjZxd2lINnYvdDlwVGFhT1JGYll4UDFj?=
 =?utf-8?B?L1RPNEhoWmN3QkRJTzhOZjNsRS9PV2tXSkdLS3ArNDljZUZhTEZJMzFqaGtR?=
 =?utf-8?B?YjREdTZUVzhuMXhjbWhQSzRFK2EzeFZBTENNS2I4NUpzbjRZZFVtSWpSZEZC?=
 =?utf-8?B?NXdCQUh6alhBNW1IRDA0cDhOYWo5dE8xMWVnd3dTY1oyOHVyYk1kOEhtdldL?=
 =?utf-8?B?WVd2YnV5NXJnamZaMkJmZUhOdFkvK0o5cTVoUng2Yk5lUzZTMVF1QWtnVnMv?=
 =?utf-8?B?MXFTTXNSWlcrV056bkNuTDNhdUErRzVSb0NKSzJhZURZdWJlNUIwbzlVUVNv?=
 =?utf-8?B?endnMVUvYVBqOU5WNzFXZjlWSzJ5OUhiMzdPZExXTXN1SlVtaXJuZ2VzN0lj?=
 =?utf-8?B?L215TXRWOExZRzdHMGFYLzVUSjUzZDY1U2xPaW0xaitlcVVuZjR5bDhlelZ6?=
 =?utf-8?B?eFMvSXpHWUs2bXZST0d5aU8wOWZscDV2dUZoYzRpQ05ROFhDNWthVk5UVld0?=
 =?utf-8?B?MWV3dzNZbW9sMndMb1RBL3RTaTN2dTNmaWp5UUtPWmFDL1ZCOEZlaEJWRFUx?=
 =?utf-8?B?M0dsVzc2UVFOSi8ycWEzdndIS3c4bnJ4NXZDZExIdUlQNWhob1NnVVd6Q2dH?=
 =?utf-8?B?RWh1anE2TmRSeGIzUzZwakdMbTlQUjZvMi9UdStTcDk0cjVrUHJSa2M4Z0ty?=
 =?utf-8?B?N29EMGJ4MEs0S1dSRjVWSWxkSm9wSUhqVmJZRVhlTm1sRnE1NUNQaXZHM3Zh?=
 =?utf-8?B?WmgxUGk5czFGRHljK3lTWHFsOW54ZlBraXBxQUl1cm9nMzB2aUtVT05vTVNz?=
 =?utf-8?B?aVA0ODIwVFkzVGV1NjRRQXIrZlhNR1ZQWjBNYnhxUVlKUEhHeVVyODI5bUVy?=
 =?utf-8?B?bnFTZkVxWjdIRUtzbUx2RUorbkYzc2UrVUFISFRLZ25odDNwMlJ4VzNMYkZG?=
 =?utf-8?B?Zms1Qncyc0J0OGVyNnlVaHZaQkJxM1BSd0s4eXBRSEx0djdyb1Uwc1pFQUxp?=
 =?utf-8?B?KzZnWWpwMUhETjN5M1JzWllGamExaDR3MWRTUldhZWVzM0x2aVV2QXUzNzdQ?=
 =?utf-8?B?WGg4ZmVWb3l1MHhaaEx2cW8xaDllYWhERkwxalBsZUQzV3dqZlFvS1ZXOFFk?=
 =?utf-8?B?U2REeEVTRnJSTEI2MjUzL29ZWlpBcGJsQUV6U3c3R09STnVuUDZ6TDJCMm91?=
 =?utf-8?B?SG1pOTZWL0JUTllhNEt3VEZPc3l4UTl1cGJkcUIxMkxJWWYyRWVxVGROa1F3?=
 =?utf-8?B?enYvbjRlNGdGbnk4emNuaURJZHdoZ2x5U0lzVjRSMW00SVVVVjVUTjJ0aCth?=
 =?utf-8?B?eHBmaWx3RlBPRDJqMUY1ZEU2WFI3Zk82ODYvemRWdkw4V1F2QTFCSmJDWU4x?=
 =?utf-8?B?cU9qamh0Ni9Hays4R0tSY1B3SWhaL0Rva2NwU0N0TzBIV3dzNGx6K2dxSWNl?=
 =?utf-8?B?QktPV012NlRxRHdPWnJ3Qk9pYjZYWE16dHhLWUJVajdKNjlDOXYrVElxdWJQ?=
 =?utf-8?B?dXE4c0RFdEZtcjFTMUFsaEhiVkZoL2hHRDNZdm42clFLcDhlbXlxNjRIeldY?=
 =?utf-8?B?N3RjRzhPVXZJajFmN2JuQU1pZzNZN3RieEtkSk1PVnM1a0d4MEpGVENHT3Jy?=
 =?utf-8?B?YnBUYU5hRDYyWWJzMW03ZExlNXJpVURXK295YzU3Q2JIT0VEbXMvMWlGdENE?=
 =?utf-8?B?eEo3blZLaVlJdGpUZTQ5SVlONmxiYUtCZHpPejV5QmkvYVphOXdkTm9vU2hv?=
 =?utf-8?B?VWk1dTgrVFo2QkthZDhTODNROWRCZ00xekNnTlZHVExQOGFvdCt6NGdsZTFQ?=
 =?utf-8?B?bEo0S0FGMFRkVjhQK0pNNUlYWWRPeWZaMGxUNWRUVkxuTHRJY3RrK1BVVDFB?=
 =?utf-8?B?Umc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25bbf889-1ee3-4e0b-388a-08ddcde8fd87
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 15:11:12.9939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4WlNK4QufzvwZWSxcAM3I4dt5eBQS+P1cNrIBLNvSGfneBrCZge1bhFoUwcPC8kl0qhYXNUdcLmTHy+FeyZyD1sufYfztTxlM4Q/AfjYDDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8433
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

On Mon, Jul 28, 2025 at 04:51:30PM +0200, Morten Brørup wrote:
> > From: Dean Marx [mailto:dmarx@iol.unh.edu]
> > Sent: Friday, 18 July 2025 15.18
> > 
> > On Fri, Jul 18, 2025 at 4:23 AM Bruce Richardson
> > <bruce.richardson@intel.com> wrote:
> > >
> > > On Thu, Jul 17, 2025 at 05:03:13PM -0400, Dean Marx wrote:
> > > > I've created a v1 of a QinQ test suite around the set of test cases
> > > > discussed earlier (which is not set in stone, and I expect it to
> > > > change significantly across many future versions.) The PASS/FAIL
> > > > values can be mostly disregarded in the context of this conversation,
> > > > but I've added logging to explain which packets are sent, and what
> > > > happened upon reception, which I hope will be more informative. After
> > > > running on mlx5/i40e drivers, I got the following results:
> > > >
> > > > test_vlan_strip: QinQ strip OFF and VLAN strip ON
> > > > test_qinq_strip: QinQ strip ON and VLAN strip ON
> > > >
> > > > i40e:
> > > >     test_qinq_strip (sent packet: Single VLAN): FAIL
> > > >       reason: VLAN tags found in packet when should have been
> > > > stripped: Ether / Dot1Q / 802.1q (0x1c) vlan 1280 / LLC / Raw /
> > > > Padding
> > > >     test_qinq_strip (sent packet: Stacked VLAN): FAIL
> > > >       reason: Expected one VLAN tag but found 2: Ether / Dot1Q / Dot1Q
> > > > / 802.1q (0x1c) vlan 1280 / LLC / Raw / Padding
> > > >     test_qinq_strip (sent packet: Single S-VLAN): FAIL
> > > >       reason: VLAN tags found in packet when should have been
> > > > stripped: Ether / Dot1Q / 802.1q (??) vlan ?? / LLC / Raw / Padding
> > > >     test_qinq_strip (sent packet: QinQ): FAIL
> > > >       reason: VLAN tags found in packet when should have been
> > > > stripped: Ether / Dot1Q / Dot1AD / 802.1q (0x1c) vlan 1280 / LLC / Raw
> > > > / Padding
> > > >     test_vlan_strip (sent packet: Single VLAN): PASS
> > > >       reason: VLAN tag stripped from packet
> > > >     test_vlan_strip (sent packet: Stacked VLAN): PASS
> > > >       reason: Received packet had outer VLAN stripped, with inner VLAN
> > intact
> > > >     test_vlan_strip (sent packet: Single S-VLAN): PASS
> > > >       reason: S-VLAN tag stripped from packet
> > > >     test_vlan_strip (sent packet: QinQ): FAIL
> > > >       reason: Neither tag stripped
> > > >
> > >
> > > Can you confirm exactly what is being sent in each case for the ethertype
> > > of the VLAN tag? When you say single and stacked VLANs, that is VLANs with
> > > 0x8100 type, correct? Is single S-VLAN a tag with ethertype 0x88a8, and
> > > QinQ packet a packet with one 0x88a8 and one 0x8100? No other type options,
> > > e.g. 0x9100 were checked, right?
> > >
> > > /Bruce
> > 
> > That's correct, single VLAN is one 0x8100 tag, stacked is two, single
> > S-VLAN is one 0x88a8, and QinQ is 0x88a8 and 0x8100. No other types
> > were tested in the stripping case
> 
> 
> Bruce,
> 
> It seems the drivers have the ability to set the EtherType of the Outer (and sometimes Inner) tag:
> https://elixir.bootlin.com/dpdk/v25.07/source/lib/ethdev/rte_ethdev.h#L3752
> https://elixir.bootlin.com/dpdk/v25.07/source/drivers/net/intel/e1000/igb_ethdev.c#L2739
> https://elixir.bootlin.com/dpdk/v25.07/source/drivers/net/intel/i40e/i40e_ethdev.c#L4038
> 
> -Morten
>
Thanks. Question is, does this help us to clarify the behaviour for these
tags? Based on the fact that the comment for the tag_type says that the
outer is the same as single for vlan types, then should the behaviour be:

* VLAN strip - strip at most one tag as defined by the "outer/single" VLAN
  type.
* QinQ strip:
  - if outer/single VLAN tag matches the outer tag type, strip it
  - if outer tag has been stripped, and inner tag matches the tag type,
    strip that also.
  - if a single VLAN tag is present, it gets stripped only if it's tag type
    matches outer type - it is left alone if it matches the inner type
  - if two VLAN tags are present, and the inner tag matches, it is not
    stripped if the outer tag does not match/has not been stripped.

Also, should we specify for DPDK what the default tags should be for the
two cases. It seems for the Intel NICs that I tried, that both inner and
outer tags always start with 0x8100. That's probably a good default for
VLAN strip, but for QinQ strip, we probably want hardware to default to
0x88a8 and 0x8100. Alternatively, we could/should mandate that drivers
explicitly set the required tags before starting the port.

/Bruce
