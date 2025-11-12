Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E482CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 09:01:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48F534065A;
	Wed, 12 Nov 2025 10:01:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 0B92F40659;
 Wed, 12 Nov 2025 10:01:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762938105; x=1794474105;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7Y5JcEMJ8DmTw/uhExTveRYL41i0xVtbxz4/ashLN9k=;
 b=NxzSKiS0qipgtASoT+NFbMcE/JNhNKXTqPeQTtoWUh8GpuXvpesyVGX+
 41gww1yJYzFkiWgUrTAw/X+Z+fZw5/8xAmRGx+gMVKjrMWRn35Oor9rSJ
 B9jFnVIp76n7HigqyLR85aIXhUJQKeMje+jZNzs5mK7y7Ug66vHdeaJfI
 GwinTssSyCvlSjm2oKMK4n/y+URuU+oTQmxWbW/jHkJ5NYi/W43j7NXWY
 lvINH10D3QQQmwA2IBVcfwvPBlhr9mVDZA4puwphJzkR96BfRAQGi8mQJ
 CnqZ4dYAw/cdpcRwyQ2BMw6lVgw5247FeTZHm3CB5YUFyTnA347aAehlq g==;
X-CSE-ConnectionGUID: 2TLms0RaTnyM+YBXKyPgAg==
X-CSE-MsgGUID: NfZc/oKPTLavk3o8ODqNbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="64901705"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; d="scan'208";a="64901705"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 01:01:44 -0800
X-CSE-ConnectionGUID: dTOTvhF0TPGMjoV3gvOq1Q==
X-CSE-MsgGUID: h6aW2VBHQCiI2qDdgyhtzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; d="scan'208";a="219897375"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 01:01:45 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 01:01:44 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 12 Nov 2025 01:01:44 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.67) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 01:01:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HelWHL8ECVxisOJZCfaiNWGe+Ggdy0HdtW7WKGo6+n8IfR1Lib5UIaaiFauUDUaVjxOzZTCWX0fh+dyGC03U8EctoxfdwWbi+S7oPGsL6dRB7OPTP6i1hqzfm/BpwAheLXFEdso2As+vE+HwIY8Ry0oqn2POQpNKkUeefH8lvHuhuvglKe8bBW0VwsiXyOPcyUgBY3IadT9mtu5t7UoWFm6C4tjVGf6CvHh6atEIAnmYD7fFzMSlHo46mwKQyZL+HtBxxoOwvfqKgdtPkilgaEnO5be2NQPtffXzv1F630xUQPRPdBbJVPOUidhgmi+hYnVxm6+MN1ChhYDDds4lXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Y5JcEMJ8DmTw/uhExTveRYL41i0xVtbxz4/ashLN9k=;
 b=kuHbdu5NQDRNzSY/2bUFFUrsUe+qlPogMXYWVoBylA8W35wJq9dXwmUGLehUfbiN5c74x+EMlMmTRuYSnvXkU9Qd2aH8hNFL9ILViiqtHd2bRLnuj19acUv6Kdppz3jD/40e/l+aVlNJmyw2B8HF5ekNsJ1CBXJ56UU2F5We8t6amiYFQy60Emc53GK9J/IA207WgUFDOOfDoY8/I5N4I5cMLEux9HuER3VHIrxH3ngXcAcAt1SNdVetn1P2953gb4xVssie7Wy+qbZZ9atbbiHPVjFBQB0RlfhiiG8Ay+XwsUlgq0XixLP2u6+/faWPVSLzhPVA6sJQCkUDC25JKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8601.namprd11.prod.outlook.com (2603:10b6:408:1b8::8)
 by CYYPR11MB8332.namprd11.prod.outlook.com (2603:10b6:930:be::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 09:01:42 +0000
Received: from LV3PR11MB8601.namprd11.prod.outlook.com
 ([fe80::7878:b054:82bf:b5b]) by LV3PR11MB8601.namprd11.prod.outlook.com
 ([fe80::7878:b054:82bf:b5b%7]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 09:01:42 +0000
From: "Ye, MingjinX" <mingjinx.ye@intel.com>
To: fengchengwen <fengchengwen@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, "Singh, Aman Deep"
 <aman.deep.singh@intel.com>
Subject: RE: [PATCH 1/2] app/testpmd: revert L4 protocol retrieval from L3
 header
Thread-Topic: [PATCH 1/2] app/testpmd: revert L4 protocol retrieval from L3
 header
Thread-Index: AQHcTgMv5FL4YyMyxU2U5XNMIREtprTrtG6AgAMUFrA=
Date: Wed, 12 Nov 2025 09:01:42 +0000
Message-ID: <LV3PR11MB86016920D48D0E6E7C13C3ECE5CCA@LV3PR11MB8601.namprd11.prod.outlook.com>
References: <20251105024724.830304-1-mingjinx.ye@intel.com>
 <20251105024724.830304-2-mingjinx.ye@intel.com>
 <6bf71e03-6492-44d5-8361-c5879f25abf9@huawei.com>
In-Reply-To: <6bf71e03-6492-44d5-8361-c5879f25abf9@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8601:EE_|CYYPR11MB8332:EE_
x-ms-office365-filtering-correlation-id: 44f3cc67-f227-4f4a-9ab1-08de21ca1970
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?alNMQVViVkhrNzhCUXpvenhxWklGeUx5M0FzbG1QanhnejVOejl6TDRsSlpR?=
 =?utf-8?B?MGRBY2tOeU5QN1Q1VXpjaTNXVFdTeW8rVHkwRXpQNzc1aFMxbStEV3d3SVZL?=
 =?utf-8?B?ejhRVlhxN25WNlNCcjhEMXpGc2JOUmdzYnI3QUlTNmFYY3F0L2FNdGVEWjVz?=
 =?utf-8?B?MDVlMEdiMVl1M1FvL1hzK05HcHRYRDg5K2gvTFYzVm13UVUvcGJGeHZrUlcr?=
 =?utf-8?B?QXduSnZOZnkyRjUyNk15RVJVQThLS2tWczhBeEU4TlFiaGlTbW0yMHcwQXF6?=
 =?utf-8?B?d3JzbG1kbHQrazV6U2t5elk5SkdIMzdIUk1ncnJYNTNWV2NaSURYM1EweUdr?=
 =?utf-8?B?d2VOd3J6ZHd1SzB5dGN2MjZ0anJRN01MQTZ5N3N4Q1ZQS0tBQ3FDNkovUENn?=
 =?utf-8?B?YzcvQTBTbjl5MXRiV3Z2bnJhcDRpRm5kR2tRdGFrY242d1pKcmd1U05kalV5?=
 =?utf-8?B?dThtTlluQTAyZ1Y2WTVoeUoyajFLNGZnYnpiTy9WUzI5K3U2Tzd3b0lQd3pk?=
 =?utf-8?B?QWhucmlYSE1rb1hJS3R0WXZkNm1FaFpiNUxIaENrU3VhQlNtcVpiSEhoSEJz?=
 =?utf-8?B?MmV6SVFBQVo5NFhHdVFzQWs3aU1rY28wVlowZTV0V0szeDFUcnBmSmc4Ym1W?=
 =?utf-8?B?NFdLNFc4U2puQkRleVpXak1kSTg3eTZPdSsweG04QlYzUCtSUkk4QmliZUJv?=
 =?utf-8?B?RnJqeCsyRCt0TVFYSGpYTjhHeXVlU1ByY09iL3BDNXJ6RE40WFBJb2pQeG1z?=
 =?utf-8?B?azE2WEFJS1RSMGRFVytQRlJ2SnFYOHFvOGR2c05JeDMvTkh0NHZTQzJkYWNG?=
 =?utf-8?B?YnNHZXlPaU9UZWZpRmNyTG5Xbkh0d1VXTmtQb0VyY0RMZ2piYlN4SVNva2tk?=
 =?utf-8?B?K0x2cXBxOStZL3FGa0J3cnBzSWJZVW9qZTc5VU43ZjdDRmE3ZDFxcGplNlZB?=
 =?utf-8?B?QURTTU1KZjIzS250Mkx1ZFArbENmZ0RUZktiYVpZVVJHMkFXT1dmRmZuQVFE?=
 =?utf-8?B?TW9NNC9uaE8waG9RNkNPMEFmUkNiS252eWF5K2RUaDFlSGVKTVdPbjZMdnJW?=
 =?utf-8?B?alFxUG0yZi9CVTNPaFF6ZlV1SlRib0Y2ZEYxN28rV2V3NloyVkZaRCtLdUFW?=
 =?utf-8?B?S2lBRnpaVlRoTjZscjMrMm9KQU8zcnJrWVRtWnBVNGpvejV6aG55L1hJWkZQ?=
 =?utf-8?B?YzZ6VnplZWlQalZ6WmJVWWF5Q1IveFAzbEpzMnl1OGhnTVFteXpaaTZ2VTVL?=
 =?utf-8?B?WS9LYlFqSmk2TWNFa3ZTY0gzdkk1QlJwc1E5c2dFOWZOMUlRQ1BvcXNnYVI4?=
 =?utf-8?B?KzNkYWVPaDZzVXNiWnp6R3ZHY08yNnBpYzczTXRRNE1Oa1NUQmN2U3Q4a2pT?=
 =?utf-8?B?SHVzWkphRFRnOEx1RHlWVlZFQkJLTkwwRzJGMXF2N2Q5a2ptR2NKY1RtQnFG?=
 =?utf-8?B?bUdLcGxFV0NqRGhTRFJVUEdKcVpHcm1TNDJiQmhSTnhXSWVuNWEyVXIza2J5?=
 =?utf-8?B?b3JYM2ZLaVhWN29vMFp3anlWUy9zRFpQN0lWS3ZnRjNGMEFCYnAxZ0VQdVRl?=
 =?utf-8?B?NWtBa1hRZ1B5d2NOUE0wZ1JkMHJJcVc2c0tzVWFVbmFPOVQvbHlEWVorcDJL?=
 =?utf-8?B?M2U5ay9wU2FPNERHcGVJVGIwTnFZRGZBTElNbGRNQkRNWCtyVC9Kdi84dUk4?=
 =?utf-8?B?WktXOWRibGJvREM1S08yYksyWW9pMllCYTNDMzdJdTZ1ZWkwWDk0eFlrVE94?=
 =?utf-8?B?eFFGak5ZZVRnaGZHN2NScUFrL1pYVktyTkFmUHUwT2tHNzZ3bGlZQ2pTZDFL?=
 =?utf-8?B?OVY4empNa014UWVwK1l4THlQYmQ0ZEgwT2hYR1NJcllLRTZSaHBhcG9wbjBu?=
 =?utf-8?B?WGNQZGxNeWhjT1VCQ3BDd3kyZ3I2eDg3dWNrUFVYMEVIdHNGN3Bxd0F0WkhY?=
 =?utf-8?B?MVlKSXNOZGRLbDR5VjJlR29JNnM0cHJpMHJHUlcybEQxek44Mm9XeUtPUHBy?=
 =?utf-8?B?R2RJOXNGK2ZRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8601.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDdaU2tSY1hJZHB5ejJuOGJ5U3RUTnQxZlBxRy96OHM0bFcrUEV5NW9jeDl3?=
 =?utf-8?B?KzgvaWlUMHVQZWp3UFZvY1k0b0lHa0locUpyZVJKYlE0bm9mZGhucU00c2hK?=
 =?utf-8?B?VDJDYzNiUmNOcTh2ZHFLdys2Z3pzRzF3Mk9PWlRyMVp6UnRpV0RhZFZ6TDhS?=
 =?utf-8?B?MXB2aXppWmxHVmo3MHdtYnBET0QwTStHajIvNEMxMTU3WkVqc3VqdmVZdjhK?=
 =?utf-8?B?SmNVakZWT2I4RkE3KysxeU5xSVlwY2ZoWm5SUTl0eWF3M3YvdTJvbGwvZ2xX?=
 =?utf-8?B?WFd2MEFKZ3hXVmJPN2NiY3JkTkROTlRRTytTZjB1eGFUUzRrVlQ1MVlpV3lG?=
 =?utf-8?B?Z0dIVUY3WGZGeDhUd2V4M0JVZnVnaUpLM3NaVW9xNWR3Y3VsSXJ5UFNZUURR?=
 =?utf-8?B?c1l6VkFZZnNpZXNmVjQvSWIvK1JGZGdqZVdLWnB2aDZiZ1hTenduUTVEL1Iv?=
 =?utf-8?B?QkZHaXRTZGl1cm5vbnlEVW5Mb28wWmhFejZIbGtkTnQ3ekNPZkE2R3E3SnNI?=
 =?utf-8?B?UlZ4UUtwNm5vd0J5SjZ1RlBKZFY2OHY5M2FPdERDeThZZGZud1VnenRpWTly?=
 =?utf-8?B?M0VtVlR6UHBtM0gyU09IVytLV1o4ZndHS0Vnc3VZZUNxc1dkM0YrZnJ4WjF4?=
 =?utf-8?B?SEFOL3ROVDVxVzAyQmFNNDh3TEpkU2tqVnVxY3hyeENaM1VqYXVENjhpYjA1?=
 =?utf-8?B?VGttU21DTlpmTUtSejhHNitHelQvM2pEVmN4NS9BMXhqUGdaNXhRaUNwdjRt?=
 =?utf-8?B?SXp1aFR0SDFVREdBNmFkRFJyV2s4a3phTTlub1ByRWZWSzVCdzQ4MFd1TEpo?=
 =?utf-8?B?R3k2aG9pQytWcHJjOGlCUUYzYUcxZU9UZ1FVMHgvV0tRUTllQllvdkZ0K2xl?=
 =?utf-8?B?aHorTWdYU3lva2RjNUpseDZPaldwbkNiWWdQbkRwR0NxVDVRVEFuczFtZDN0?=
 =?utf-8?B?d1dhbVB6VW1zcDh5NmkzcU9XMjFkbUtqVmpRNVZzSGRNamJ3bTRtUm5BWDFY?=
 =?utf-8?B?L0VoVk5iZHplbGRFaUU1bUM3MzNLNjZrNG5yNS9jUU9YRGcwSzg3WHZJRGJl?=
 =?utf-8?B?RUR6dWJjdi9KWEJBN3RXcVJVYjBrVjRSb280ODA4ZjVCam41RTVTcWR0bWE4?=
 =?utf-8?B?N3pHNGYxWGlyT1FlTzBBNjdRMEVaTktEakZGWlFpdlo0cUxZVEVhSWdTTWRz?=
 =?utf-8?B?aUI5RjU1cFVpaVdabVFzaVdla2NpUUd0YzhmaEF6eTdoT3RLTktpN0kzaFpr?=
 =?utf-8?B?dGF2U2ZpbUdPNUwzckVjUU5sRlkrN3F5aWJOZTI2MVJDWHpQNlcvU3V1WGtN?=
 =?utf-8?B?UGRhM2U5RWhmcTJqYTlhdll6QWdZTEhXY0kvVmNRUXNZM0FKbjN0WDhzQmVL?=
 =?utf-8?B?M2JVLzNnN3JLL3g3TEFUM2lQOGlZZ1lrNktqSkVVbmZBZldUTFg0NXVSWlJO?=
 =?utf-8?B?dHhHNzNFWVJ3U2Y1RUFnT1BlQ1BIWUg5TVgrblpNQXRPeTFJT1drSUFJbjRw?=
 =?utf-8?B?R2VsMmJtKzRLV0JhSEoyUnZHOGh6MFNCWUJYc1gyam9mYUp4UUZZZ2szaG0z?=
 =?utf-8?B?L2tmclM4eVFkbHoyMkYvVWJOL09mZ0lINmY3MTZyOEpOSlJuVit0L0xhMU5S?=
 =?utf-8?B?VjhKMzIwb1dDNzZyY25uM0s3cUM0NjB2TEhiSHFSRHpmaWxVQ1NOMVVWcGRh?=
 =?utf-8?B?WEtmbWJyZmdpSDM3VFlSYjZFTmhvdEJhdm9ObXpDS09XaGhRWDlBWTFjMHcy?=
 =?utf-8?B?SEgwZjh2djkvVG42Y296cGREeVBoVTdSMzd2MVg2UDczUmRHZGtvNVNxbFFh?=
 =?utf-8?B?RVErR1d3SlBBN0QyTnpEbk5iZWFMVnVEZ0Fubmt2M2VJRXYyMUM0ak8vbmda?=
 =?utf-8?B?Q3ZJbkppTTdTZVFQYlQvL3pKeGQ2VFZKbFF0S3UvWkhiSkRYQzhCczBEa2Ft?=
 =?utf-8?B?ZEYzUzJ2K0VoQUc5WG9xVjVOR1BLckdFMWRwUjVaQlBNaS9DU043UlZVbHZU?=
 =?utf-8?B?WnV0anN6ZFF0TkR5VEs3WUZHN3FwK3BZQUcxVnRWVkswazdSYkt1Tm0zbVpE?=
 =?utf-8?B?SmxUSFU4ekFBQlJBSWxJQzdxRWRaMDNuYS9RbnlmOHkxb0tsMEJldGxPOUNz?=
 =?utf-8?Q?wE+z3DQbuGz72gHn41zBCdJMf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8601.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f3cc67-f227-4f4a-9ab1-08de21ca1970
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 09:01:42.6857 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: af2uy87VGzz7qwxn5u3Dl45Rh7B1LKzfp8QWM+5LVqefbOZma80uweRQnoHi7kJztTYvAcEiM58qWb3g24Ovog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8332
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

SGkgQ2hlbmd3ZW4sDQoNClBsZWFzZSByZWZlciB0byBCdWd6aWxsYSBmb3IgbW9yZSBpbmZvcm1h
dGlvbi4NCkJ1Z3ppbGxhOiBodHRwczovL2J1Z3MuZHBkay5vcmcvc2hvd19idWcuY2dpP2lkPTE4
MTMNCg0KVGhhbmtzfg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGZl
bmdjaGVuZ3dlbiA8ZmVuZ2NoZW5nd2VuQGh1YXdlaS5jb20+DQo+IFNlbnQ6IE1vbmRheSwgTm92
ZW1iZXIgMTAsIDIwMjUgNTo1NiBQTQ0KPiBUbzogWWUsIE1pbmdqaW5YIDxtaW5namlueC55ZUBp
bnRlbC5jb20+OyBkZXZAZHBkay5vcmcNCj4gQ2M6IHN0YWJsZUBkcGRrLm9yZzsgU2luZ2gsIEFt
YW4gRGVlcCA8YW1hbi5kZWVwLnNpbmdoQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRD
SCAxLzJdIGFwcC90ZXN0cG1kOiByZXZlcnQgTDQgcHJvdG9jb2wgcmV0cmlldmFsIGZyb20gTDMN
Cj4gaGVhZGVyDQo+IA0KPiBIaSBNaW5namluLA0KPiANCj4gQ291bGQgeW91IHBsZWFzZSBkZXRh
aWwgdGhlIHN0ZXAgb2YgdGVzdGNhc2U/IHdlIHdpbGwgdHJ5IHRvIHJlcHJvZHVjZSBpdCBhbmQN
Cj4gc2VlIGhvdyB0byBzb2x2ZSBpdC4NCj4gDQo+IFRoYW5rcy4NCj4gDQo+IE9uIDExLzUvMjAy
NSAxMDo0NyBBTSwgTWluZ2ppbiBZZSB3cm90ZToNCj4gPiBUaGlzIHJldmVydHMgY29tbWl0IDQ5
NjE1OTYxM2ZmYzdiNmJhNTkyNDMyYTFiYTRkMWEzOGY2OTM1ZGUuDQo+ID4NCj4gPiBXaGVuIHRo
ZSBUWCBJUCBjaGVja3N1bSBvZmZsb2FkIGZlYXR1cmUgaXMgZW5hYmxlZCwgaXQgbWF5IHJlc3Vs
dCBpbg0KPiA+IGludGVybmFsIFVEUCBjaGVja3N1bSBlcnJvcnMgaW4gVlhMQU4gdHVubmVsIHBh
Y2tldHMuDQo+ID4NCj4gPiBGaXhlczogNDk2MTU5NjEzZmZjICgiYXBwL3Rlc3RwbWQ6IGZpeCBM
NCBwcm90b2NvbCByZXRyaWV2YWwgZnJvbSBMMw0KPiA+IGhlYWRlciIpDQo+ID4gQ2M6IHN0YWJs
ZUBkcGRrLm9yZw0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWluZ2ppbiBZZSA8bWluZ2ppbngu
eWVAaW50ZWwuY29tPg0KDQo=
