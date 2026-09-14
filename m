Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1412DC88E72
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 14:19:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38D7140A87;
	Mon, 14 Sep 2026 16:19:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 9A3A1402F1
 for <dev@dpdk.org>; Mon, 14 Sep 2026 16:19:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789395543; x=1820931543;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uTy53iab5PqqkRVwxvrkfRsvXSs5MNtwCFxrXD3Sbck=;
 b=ggJYusiQXzxvHLJgAqvPStRwJCsNdgFV1hrwCXqSHjsbFDyoOjrrfT4d
 35T+HfHWGFurqLaR/tj19V7GXj8mmNlwIb4mPU+pJ/N40MFTyCkvq4vjC
 /OKUPprcZWMVnpi9q0eMMRnKWjlwM3PfB5FMfdRI2FJpnOOfibK8rkuSQ
 9YxdFcPxQ6lDEtKf5ZrwJ6Na1mklePYQWi+dq9LyJuDegcBaOd+CwJ2iQ
 IqFWX+oaJmqQPkMjVij+6R0IptqgkGtuHPHIorZS+NUiWxd3Yuwj+u1g+
 1QFLAxyNqrBrkZDhCh1uqtk++mTSvy/GMgA16JWiZGJJC9xlrMo6fyQ6u Q==;
X-CSE-ConnectionGUID: EuK6V33USnGVnJy/ePuQOQ==
X-CSE-MsgGUID: qWcZdgcuTY2T0aGH6CPQNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="112517641"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="112517641"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 07:19:02 -0700
X-CSE-ConnectionGUID: 3j2zn/aFSi+NqYZTfpVZNA==
X-CSE-MsgGUID: fEB5iP/2SFedMKMO6c6O9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="857631"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 07:19:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 07:19:00 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 07:19:00 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.5) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 07:18:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pRM9fVxBGFggd6tpaoMi7auqxJm7fWnpZdXzSMfMx8T/AZy+KjwR524y4gm5PpVZHxFlKAXX/onv6R2h5Jt18WbMdrqDOjiprE8xshsgxZJ8WWLYVasObgPv8COuJYUFDYB5B7d2kZMI1wCCHs6DgK5+7/E3POLyz3wQ5ClTua5GnT2BsvsvFSCzvaw+6TU5TAyu6MwVMGKeDdxycTSatZpC9mLqJputQNBXyu9ZNfNcx68EBJ17v8JtCNodbgfbLI1Qu9YA25LIGsxB7YcsyorwGz2smyisEtiuQEgHCKWNTX6aHSzJ3MZhvg2Nyfy3NnYoL0o/TNvjiM4wSqq96A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTy53iab5PqqkRVwxvrkfRsvXSs5MNtwCFxrXD3Sbck=;
 b=joPFQ00OVWipJE9Ffvu5PmOE9V85+poNgTKq8ltKbokwauwaJektew0QplhsVdbkQUt0y21ixSY7I8Bau8o9oB/jaiMFKm+WHbbmw/e7CVS7E2rGP8cDQ26kZB+hZ5qqpuSnV5eHpU41REqTJtWiFlaC0kqx6NH+p2iX5suibbNrp2cc5ybkb7A/8r/XtnVyaRf2UWYhpqwoVna2TOBaw7YBWrQ53GsfYCSS+V7ZEw8cFsH9OpTX2Ge43Bdk1dYHODYcvFiCv5AKM+n5KHo5Z+yq3F3PVOOhXRkBIAcknFpj7wMGl3tAy5EX8SoFxjdi+di1rHWeYrcad8BE59bypg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by EA3PR11MB028977.namprd11.prod.outlook.com (2603:10b6:303:2eb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 14:18:57 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 14:18:57 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>
Subject: RE: [PATCH 13/13] net/ice: enable context desc offloads for vector Tx
Thread-Topic: [PATCH 13/13] net/ice: enable context desc offloads for vector Tx
Thread-Index: AQHdQQZxuC/6dfDbf0at4R1TYCOGt7bOJeaA
Date: Mon, 14 Sep 2026 14:18:57 +0000
Message-ID: <IA4PR11MB9278B0B20DE99B28512414EF8EBB2@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260903170140.360477-1-bruce.richardson@intel.com>
 <20260903170421.361293-1-bruce.richardson@intel.com>
In-Reply-To: <20260903170421.361293-1-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|EA3PR11MB028977:EE_
x-ms-office365-filtering-correlation-id: 26b245d7-608e-42ee-af4a-08df126b1d6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: Bpqwon0xxxtvfb/jYhEnOahZq8eIIHpipcU1ULLxo92qZpeTUJef/BVezaRzX9xe2KFC+XikistAYQwOHT/bVBjEoRLhc0FVFJKfCbf8h22/QeuPn4pSXPTZqECY3j7dOceK19RO41cfB0B6agiGJCgT7aaKrZyRor1S6vNYYk39ybjd8vCHhjc3sV7CLlbXtDkxPIK64z3V4/d96nfvcNefhEbUgKYBLk8Jo+Q4MnkoP4F+MzwapVedH9H5XYjqufwDR29f94lut6skihq6em1FwJPMIdICwQUhOwB6uEITLKmEFkBKIIoO3VYXxLgzdd5xjllCD0JDUro5fvQoo9uAvA0QZuQe34E6ohA6T6mewKqF1j5U2DR0LqwsTSvw5FgAtnZ3UeZXo7ROYWhegOarCDELgS9dPrkFdZsa98ubYaySxIEnw+nBGesYuskZ38qcQma5NAKDw0xnSz58OFnS+Gj+gs+yJFPKjExULVWmamhX2NAEVQYZxBThBU2Fh8tsgaxIsdDwk1ott31+5j9Dw7bZK7jYIF09ukxX2Nlkx3TRUQiIzF/0WKMh5oHIDtFzRtSPulLB7VktTTawXFjf2+WWcv7AhcDBIjG9iEEG6annZVAgeFt0MTXEKS/SdZ3yN8gZkdzwnugyhmovV1l8TK9C7vCTaBmYbHJUZK7j7RLnJDBbXgsoDJp29NUsz4CtFBVkLTF1efhBEBq7Nw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NW1ZWWZtdWUrT3FXdXAvU1c5N2VvbWIvbzlGeUorSlJ2SGhQcHNJRWFwbHNo?=
 =?utf-8?B?OTNnKytMY1J2NGJkQkdtQktPQzlRTDdPblVZTEtaQlVJT2NNdFdaU3ZRaG1Q?=
 =?utf-8?B?T3lkWUxJK2YvUjdyaWYwck1UQmYvUjBaTEw2NlBPZUxNMFFNcS9uVGFwL2ht?=
 =?utf-8?B?WXhwMHZEKzU5Sy9pZ3dmbHQ5OHJlMXI4U20zcUJNdTlJUlVUbjJJcEpRZzZ1?=
 =?utf-8?B?Y1F2dHNZbkhxNkRETzhIdENlK0hwbDlUVDBTVytwN1VWbGVZODJZY3E0dFdS?=
 =?utf-8?B?VVpFWCtPb0tKNHFtYWJFdk1FT2pUMFhZeGYxazlSSU12UVFzUjhTa0cvUGRT?=
 =?utf-8?B?SW9IUHBPd2dtMTUrQlduOFhiL1VFZ0MrbDBLMTJyUWlIQ2pMMi9DMi9yZmV6?=
 =?utf-8?B?U0hPR3dvRk4rZE9LQ21UVHJWZ29RSGVwRi8rcHlpTGw5dFZZdG5hbzV1RkI3?=
 =?utf-8?B?MVAwWHd6Rkx2bGo0aTMzSEhKc1J4ejllM1hUcmN4OEd1aXIrWTg4M202N2tl?=
 =?utf-8?B?b1pMT0pBd0pnMXFvSnZDY0Y1Uld1RmZyclNtMlI5cUdraDFzTzkvc3ZZZEN2?=
 =?utf-8?B?MUhOdEVmWERvRytzV1NTTUsxRXdsczQ4MGVucXJCcC96ZFZRelJKS3N1V3Z2?=
 =?utf-8?B?dEJXT2NEOHdjWmUzUmhpM3NrUFlER3hrQ2NRWVpvTXN1REwrLzh1WXg0dEls?=
 =?utf-8?B?YlUzdGx1MnFqb0VKdE8xa0hVbFBjUENheGVJdkxJdkdtUG5heVpQbHNyalcz?=
 =?utf-8?B?d2RxcTlnOTNoT3RxQW5sZk9lYWd5bmQyaWlaMFBhUEwxaUZRUkw0NTFQZitw?=
 =?utf-8?B?ZUZLbXNLQWFyNWU1NUNJUGtuK2NqbHRvaUlWWDQvOGFBUGw2bjBwVk1HTTU1?=
 =?utf-8?B?SENsNnFycmpqaGlJSnV5eFVjeTJyZEg2U3pwdDJaU3E5SURmTFR0czZ2U093?=
 =?utf-8?B?RTlYK2FvZ2xReDA0V0JHQXlxT1NCRFAvNVFLaGluM3hTUzNHTXpLcFJlMjN0?=
 =?utf-8?B?NWJpUWlRZ2psWTV3NEhZUTQwRUdHRnJ4OWtiekxuR0RlVlA0amtocy9Td1I4?=
 =?utf-8?B?QUdRSmlDdElFTVVyR0pBcUlveVdWZFduQjBjS015bHo2NGhMSDdPN3pjSkZL?=
 =?utf-8?B?UGhEZjZSVUozdmhTd2FzYjV1Lzh0Ymd1YytQbjJkdWpJd2dUY05OaERUc1J6?=
 =?utf-8?B?RE1jQ3pxN00wYk9SWTBqdUI5cDQxSi9qWE9jRlY4MG1La2VXanNzVk1OVzhK?=
 =?utf-8?B?SHZUaGI3NWlIMmJBK0dXeDVGRUpXeEdQL3JhRSs2cGlpQThOR0QwRnA4b29p?=
 =?utf-8?B?dEtteXpCa2lNR2ZQZ25ud1RsSEdRU0laN0VrNFlmamFHVGxML0xNNkwyYXZG?=
 =?utf-8?B?dUNuS2VPRFVNVjJmcDJVY2pJMEZkdklPck5kaGlBa3ZtaHBrdmFsNDhGNldk?=
 =?utf-8?B?WVkrbkxCWGdQUSsvRW9zMDJrdVROaGZoYllvbXp4eG9hOFRndU0wSHd5L0lD?=
 =?utf-8?B?T1NBdUx5YWFCZnRoNW5RWU1neTQyUE1lOHQ0dXN6V0svYWFrVHg1N1h2eGQy?=
 =?utf-8?B?K1A3ejhPeUZROE5UMXpRZVpaK1JyZHVkVFJqY25aMnRDa1JCdVZDeHdhSnFF?=
 =?utf-8?B?TXhEZTlrbGlMb3lKd2EyajY3V3ZNcXhaSHNaTERzbnVTcFBKd3Q0c09aaHdn?=
 =?utf-8?B?YnVSdDRRQ08xU011SSsybFNBSUczSEFPMDYrS2FFTVJaNmd0YVd2N1VHM2dr?=
 =?utf-8?B?OUkyYUpPTm1yeGZkanY2b2paQy9jT25aWkViQ2VhU1pwNDJDMHc3dzBRMmxN?=
 =?utf-8?B?STlSUE1SU3ppNXE5ZWUrc2dLVWhNYmEzTU56TTg1bzNWcGlzMmNKcDE4MFpY?=
 =?utf-8?B?WTQ2V3VCb0lkSDBEVkJJVWp2VTFvMWRBV2liamJ4MFVUNzNic0pSak5lazVG?=
 =?utf-8?B?bmdQQzg4OXJMVitmbjZxbGhYb3Jzck5oRFRnUzFmMGdTNFRaMFM4MmpVUnBq?=
 =?utf-8?B?M1dwVkJoMllJVjRWUGZRVlZQUUI2dDZ0N3pKc1NFSlJmZGRIdDhDTHdXckNO?=
 =?utf-8?B?dHhFQk8xRDRmcVl6d2NYZnBxamF1RDlCY3hxTEltc1l6aVpTQ09xNXZzUk95?=
 =?utf-8?B?WkhlY0JFZnU2UkhoMnZmdnJvVU5kamtDWEpsalFTNnNjaWs1U1FJSitHaVll?=
 =?utf-8?B?ZGwydk1Bd1RvY09YOUJYVGNwL3pOWnNoazZoeWQvL2pkMW1mc2NuL3BXejM5?=
 =?utf-8?B?bFZybHljMzhoU2xnZGk3VGtkQ2g4WTNIOU5SRlZCVzZ2T0svWXhDbEFzOWVV?=
 =?utf-8?Q?gnYOtoGI6taZLrTyka?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MzwDCpmLAPHVZ7rwodtG9wbm67KepqWVJILG/P4PsvuE0u+9IeNIs+pl25haRGh9lmRyEOW2ZIJ0aY9slL//jJ9OmicRCZED0PTSX7qh0rO4J0FxUyfYAAhZUiRc6qnR1/l1HVIIB0lgNPZI5F6gJu6+oWBu7hulISrcSN4HnxPxg46jpPt2u0jgYldPH8LUXV7bYCjuP55rodYHtROQggbLnEvhxrINlIVt7cTwiqqHIz8PnMN78Xto3+1KteesjE8/f67q81XcmBKSsF94P0NiW26Z6+Swz88/EXF7Mj2tpLlPQxePoRntvUycxHsQiAmbKwrNMpwn6vhY+XSHMg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b245d7-608e-42ee-af4a-08df126b1d6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 14:18:57.3566 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1+9WNHWZ5eF/YcVZ6xJ/FE48WaXponZG8n0hp65ZNQPzlVs1pGnErH5WDAgqMZfDb9rEjQ64z8tuqQ1v9bRDVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA3PR11MB028977
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

PiBTdWJqZWN0OiBbUEFUQ0ggMTMvMTNdIG5ldC9pY2U6IGVuYWJsZSBjb250ZXh0IGRlc2Mgb2Zm
bG9hZHMgZm9yIHZlY3RvciBUeA0KPiANCj4gVXNlIHRoZSBjb250ZXh0IGRlc2NyaXB0b3IgVHgg
dmVjdG9yIHBhdGhzIGZyb20gaW50ZWwvY29tbW9uIGluIGljZQ0KPiBkcml2ZXIgdG8gZW5hYmxl
IG1vcmUgb2ZmbG9hZHMgb24gdGhlIHZlY3RvciBwYXRoIGZvciBpY2UgZHJpdmVyLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogQnJ1Y2UgUmljaGFyZHNvbiA8YnJ1Y2UucmljaGFyZHNvbkBpbnRlbC5j
b20+DQo+IC0tLQ0KPiAgZG9jL2d1aWRlcy9yZWxfbm90ZXMvcmVsZWFzZV8yNl8xMS5yc3QgICAg
ICB8ICA2ICsrKysNCj4gIGRyaXZlcnMvbmV0L2ludGVsL2ljZS9pY2VfZXRoZGV2LmggICAgICAg
ICAgfCAgMyArKw0KPiAgZHJpdmVycy9uZXQvaW50ZWwvaWNlL2ljZV9yeHR4LmMgICAgICAgICAg
ICB8IDMxICsrKysrKysrKysrKysrKysrKy0tLQ0KPiAgZHJpdmVycy9uZXQvaW50ZWwvaWNlL2lj
ZV9yeHR4LmggICAgICAgICAgICB8IDExICsrKysrKysrDQo+ICBkcml2ZXJzL25ldC9pbnRlbC9p
Y2UvaWNlX3J4dHhfdmVjX2F2eDIuYyAgIHwgMjQgKysrKysrKysrKysrKysrKw0KPiAgZHJpdmVy
cy9uZXQvaW50ZWwvaWNlL2ljZV9yeHR4X3ZlY19hdng1MTIuYyB8IDI0ICsrKysrKysrKysrKysr
KysNCj4gIDYgZmlsZXMgY2hhbmdlZCwgOTUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkN
Cj4gDQoNCjxzbmlwPg0KDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9pbnRlbC9pY2UvaWNl
X3J4dHguaCBiL2RyaXZlcnMvbmV0L2ludGVsL2ljZS9pY2Vfcnh0eC5oDQo+IGluZGV4IDk5OWI2
YjMwZDYuLmJlZThhNDY0ZjUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2ludGVsL2ljZS9p
Y2Vfcnh0eC5oDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2ludGVsL2ljZS9pY2Vfcnh0eC5oDQo+IEBA
IC0xMzUsNiArMTM1LDEyIEBADQo+ICAJUlRFX0VUSF9UWF9PRkZMT0FEX1VEUF9DS1NVTSB8CQlc
DQo+ICAJUlRFX0VUSF9UWF9PRkZMT0FEX1RDUF9DS1NVTSB8CQlcDQo+ICAJUlRFX0VUSF9UWF9P
RkZMT0FEX1NDVFBfQ0tTVU0pDQo+ICsvKiB2ZWN0b3IgY3R4IG9mZmxvYWQgcGF0aDogUWluUSBv
dXRlciB0YWcgKyBvdXRlci90dW5uZWwgY2hlY2tzdW0gdmlhIGN0eA0KPiBkZXNjICovDQo+ICsj
ZGVmaW5lIElDRV9UWF9WRUNUT1JfQ1RYX09GRkxPQURfT0ZGTE9BRFMgKAlcDQo+ICsJSUNFX1RY
X1ZFQ1RPUl9PRkZMT0FEX09GRkxPQURTIHwJXA0KPiArCVJURV9FVEhfVFhfT0ZGTE9BRF9PVVRF
Ul9JUFY0X0NLU1VNIHwJXA0KPiArCVJURV9FVEhfVFhfT0ZGTE9BRF9PVVRFUl9VRFBfQ0tTVU0g
fAlcDQo+ICsJUlRFX0VUSF9UWF9PRkZMT0FEX1FJTlFfSU5TRVJUKQ0KDQpOb3cgdGhhdCB0aGUg
cGF0aHMgYW5kIHRodXMgb2ZmbG9hZHMgYXJlIHNoYXJlZCwgaXMgaXQgd29ydGggY3JlYXRpbmcN
CmNvbW1vbiBPRkZMT0FEUyBtYXNrcz8gSSBhc3N1bWUNCklBVkZfVFhfVkVDVE9SX0NUWF9PRkZM
T0FEX09GRkxPQURTIGlzIGFuIGV4YWN0IG1hdGNoIGZvcg0KSUNFX1RYX1ZFQ1RPUl9DVFhfT0ZG
TE9BRF9PRkZMT0FEUw0KDQo+IA0KDQo=
