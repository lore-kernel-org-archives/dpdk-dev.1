Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF1AC88E72
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 14:41:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F4BC40E1C;
	Mon, 14 Sep 2026 16:41:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 8304240A87
 for <dev@dpdk.org>; Mon, 14 Sep 2026 16:41:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789396912; x=1820932912;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=n59JRjG6gBN4gpaxmA44CVeiwdnocJmOiJ4jkF+zN6M=;
 b=e7Pc4pV6I7KkdFueiFG4YodhTJ2Z8cqUqwfPGqzZkYR3SBQdQPgsZfDr
 gah29uzuw0Z96+zsbHHbTPLPyi8tV1lNhiIb6EgNh2DLkBmD6YDTA3n28
 saiwj8gn0xFSojm6IpdLnP6H0oAaqfX6Q+6VTJpx3cEQVXcSn/1J4FhlI
 +n2JS5OdoI806UnxX9qeKiBgxGkxqbQ04OVVmoLzGaxs8fqJfn7PpJahp
 11QtXyVlcQag9g/HwmKAYj2r6bxVZhfWSh25a8h1XL7Klk5aFe0HskQpq
 mpUq88eSSxI0E37f5mvtLIDvb9aZx5aUTIaKzIlK1hL4+4jf/6PEzfvGT w==;
X-CSE-ConnectionGUID: 4xPXJNBWSCauJfvpYkr/IQ==
X-CSE-MsgGUID: BicNkrJ/Q0ihEcPv/Pni8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="89791189"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89791189"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 07:41:51 -0700
X-CSE-ConnectionGUID: /ND6mNdkQxmx8IttQXNXFQ==
X-CSE-MsgGUID: MaHmsMCyR62Q3ICdhM3LSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="270850697"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 07:41:52 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 07:41:51 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 07:41:51 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.30) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 07:41:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=psiRVHUucWYwqsbqW4L3uHX/1mLLuGGHnJZJOyYrg/JC/+hl0j848149hihaByfdilvghWfOy4e1DW9yqdMYQc0fDh01bqo6+LXdZ9oL6jKqBaLb3cdJpL5nuyX7SDOxHU/B6ewUPGJwPeZa0EBuEJcNOc5EzTUMBemM7nVRvZ7pnWduu+t9u7FREs3rVuJGamiOEsYlcjYOrdAeyQdoBg988yfFuzfDWbaVkKPMRWbzrJYxKM98Szd150d1gYXijoGlH+rbecfM9SrHvdwGuc0mn1ewu2RSsb2ygzl8SaOH4krnHqNzHu7MYJ7ArazLbAVFwKKUTVCFAYLC071A7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n59JRjG6gBN4gpaxmA44CVeiwdnocJmOiJ4jkF+zN6M=;
 b=d3atvDHzVBHOqHOjxIm4Pv8rOw1eR3BulDZnRAkXLZ9hO5ZSYlFpbWjLLDgvYvuifP+5UMa2/G1rwCKIOvCjsNeAOSaGkuvulpjK6bGLmP5On6gTyPqR0fyzV5IkRS9QEZQO4oJOmXNUEWypjbEOLqNxRiSlWjpulco7fPWa2+08pyWGgBtQcHsl0BBOFBktdwZ3DdfYVfM1FmODnGjjChvu3L+5gaI3WiTGqzQfM71FEveUD2wFYkvMPi7EvfvXpa+w4GoXr90ghRsE6RW8TwsOVGFEVp+kJJgI31+0iJkR5hAcg5egskBP0dSQ79VSeDsJC74Eam9Wy2pkA13WLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by LV2PR11MB573934.namprd11.prod.outlook.com (2603:10b6:408:412::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Mon, 14 Sep
 2026 14:41:48 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 14:41:48 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>
Subject: RE: [PATCH 10/13] net/ice: use common AVX Tx functions
Thread-Topic: [PATCH 10/13] net/ice: use common AVX Tx functions
Thread-Index: AQHdQQa9zJrtduiev024uwuDKvchVbbOLEmw
Date: Mon, 14 Sep 2026 14:41:48 +0000
Message-ID: <IA4PR11MB9278FCFD021D73217C4620E98EBB2@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260903170140.360477-1-bruce.richardson@intel.com>
 <20260903170351.360967-1-bruce.richardson@intel.com>
In-Reply-To: <20260903170351.360967-1-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|LV2PR11MB573934:EE_
x-ms-office365-filtering-correlation-id: 6470a2a0-d49d-4bf5-76f3-08df126e4eab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|22082099003|10067099003|6133799003|18002099003|56012099006|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: AWORqwkgYurFaoNt4lbMBy6aok280Huh/vmhPRCCaYozkigyFkn9lqR2GD+FR0dV3X8MzXJvWn4GiIfeYwNjhX32CJAjbx24PXqsHdC0n1+XgUAvd3qMgFD1+Jgs0Yly0I9bJuIH7RErTUqbTk+RGLfnrtDCzHYbXjYMSkdAmsOTGpfe2GnL7JvCGYtTk8a7Q/PFSrH9Jo34TuHIG4Xr5UwWJXgHpqKW8N5x83NHZBbKewq63eHb/VtqyFmaIfcjN8UleEbN+PNj/TBBPcnAPdxRYi68RiATLyPsqB4HKACNQTHF8OleeeLxAdSyJw6A7jQh1OYpQ9w+9TvVaUAMj5AWW8VggzKdpDP27JZjfbgQrO8xu40F0geSJf56n2BiWP0TTa0YeuTVPiXZNoyhDgisRU/JHpTRqIwF5UohnblRBVWI/N7sssVbySWF24ZC5ZOjt0Q3KrNiTUcB1NazfMFnZOz7ROpI7MQ1JGY/FnLfrxJ9C9tcaC9BPH8+47sm84XHZ/viLdygJgsGQDG0WSoE3Z8+8XX3asb/4JxFq3wIieN5qT/v5RAf1yk7sz5sz69S5yJZJq3+pLmqxWU2/jDbhR1yHxOlY1cIc7X4RmgCvRVu/a4HiRAJY8US17NSk4YOTdUIB92yRsGWtybUbEyHusA3Me7G8RcftMX7MrDwU0dhMKJMOeOfl5opdK+j72UYQ0s8wZbZ3QXw7TFt8O3P08bRLX1YY1mLWCuXX0s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(10067099003)(6133799003)(18002099003)(56012099006)(11063799006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0tUS0Y4OFJKZUtUZ09vZ1hZd2NKMS9xSlBBRXBseEp4V2FTZi9xclVuNlNr?=
 =?utf-8?B?NEthcldUSjdFTy9RK25SNkZ5eDFjSmdRcUMwTy9QdDhmWnpDMURqR1FIUys0?=
 =?utf-8?B?cVZQR1RWQjhVbUZLa0JWTzR3OFVkM3N5VllUanF4WTlzNVpQSzlQTTFaem11?=
 =?utf-8?B?RExmQ1ArYmJRdGdiRHlFRmRUZGlXMm9VQ2tIRDV1cFhtQXVwSWtvWUxmbVRK?=
 =?utf-8?B?R2h3bjl1cUFKYkFVOC9IdjVCZUxXZjVDU1p5OS83REJKWWhtdXNtQWJSTTk5?=
 =?utf-8?B?RWZXd3JoQnRqQUdvdk1vb1V3dHRkTjZjZ2R6QjY5bzN5U0VBcGxFVmFHRFpl?=
 =?utf-8?B?Nk1LTDE3U0hSL1IwWmUrWVhLR2QvZEkzSG1XSWg0djBsTE01eEFUWG1hUHNz?=
 =?utf-8?B?c0FleUFGQ1hUaGE1K1ZCQ25MNHl2L0xVS0phaW8rckJDN3ZGVERiV011Q25p?=
 =?utf-8?B?M3hKTC9NSVhHc1YvN3Fnb1RUVGJNekhPR213ckVkRXB2emQ1djg4OU0yTlFq?=
 =?utf-8?B?RE44ZUpHYjJvdktDcUhYUFk4eEcyTmZtb0VjQnBORnlBTnVtK05MOGhGTjA3?=
 =?utf-8?B?bGhOTTRaVWFqN1o2S2dLcWZBTUx4UVpHMmNCbVgxVFNjblU2UWRqTzhzRno2?=
 =?utf-8?B?bGxZWDZQVndReCt5TVgvMmN6TFFHVnUyZStHTjBJQVFIQUdHU1ZUN1Yva0xi?=
 =?utf-8?B?SU9CREFhMXUyaDU2ZjVrc1B0UjFzZG9Jb3BTRGZWaHpHWGV0cklIcXViMHlr?=
 =?utf-8?B?U29CT25LY2Vlb2pZdDY5YWI3NFhIdEtmNjBQUFJEVTliWTVYdUR6eE5SSThC?=
 =?utf-8?B?R3FYSUdIc0gycXp6elN0SVFERzhYMUIwSmtpR2lneEp3dzAzU3FvbnRhb3Ev?=
 =?utf-8?B?YjFadUpwQ2RyTWl3Smd6MkxGWE5NUTc0NFdxVENOVFQ2cTBpcUgxeTNTeVVl?=
 =?utf-8?B?bHIwZXo1SVJlZWlzVnp2TWx0VVJ6d2ZzeGpzMEl0YVhudVRBRnJEK2ZObGIy?=
 =?utf-8?B?RDRmZCswQ1Y5VHkxa2RqNWdPUjhrd2hSdnRZa3E5UjVObW5Rc21qV3dzVnBV?=
 =?utf-8?B?bkE4ZXJVWVlnL1BjanZyTWJaZU8xK05nVm1IWVJiLzJSU3Rjd1lxeHEya0Q5?=
 =?utf-8?B?NEZ4MXhHRjdnWTNIdlJQekFJM2ovV1d4Nnd2Y05NQmVNZFNLSXZpQVRhRzVm?=
 =?utf-8?B?cWUwZTRNeE54MVI3dm5ZVWVRTXdvWDFQNXBpc1lub1pleVdDeHhPaGtQdFV2?=
 =?utf-8?B?ekRPVDBEWUwwOFlmd25zdDM0eXpETm5EM1hLNFlSMU5zTURXd3ZFc29lbDJ4?=
 =?utf-8?B?NVhXVzlBVjFheUdkSW0wNWhrSytSbVgvY29KU3Q3emc2YkQ3T2pXS0FETEIz?=
 =?utf-8?B?RmZzOWdBdC9pR0RBTHlCVGxkbGlFRE16d0ZBeHVtZ0IvT1lnMnlHcFhHeDNN?=
 =?utf-8?B?emdqcllic1N3QVJVamgwMXlqdzVyR0VvdkJRcmUxaC90OGxsWHgrSW9vVGJV?=
 =?utf-8?B?Q1dveXlIRTl4aU5FYVBxTGJqa1I2cmYrRWJmRC9RamVPMUZZQ214aXdhTUZD?=
 =?utf-8?B?Q2diNXBPOWMyVE5NWW8zVTFUcUVXZk94YUtiQktwdC9kUkI1T1ROSndHaGlQ?=
 =?utf-8?B?MEZReE55ODd0NVNUVEJwaFZDVVpMYi9sV2kvc0JWeUhMMEJNZ013b3BXVWpk?=
 =?utf-8?B?cmdtQXBPL3JMQXhiQlQyb1JOYzlJRHJ5Rm9saWNlOHY5RHNKcTEzcENRUHoz?=
 =?utf-8?B?TnNneEk5M0JJS0pyS0V2RFRFb3hwcUdrNDd5dFc1cmRqTlF1V1B0RXp5QkVk?=
 =?utf-8?B?MDVPSThnREx2cnE1UitTL1NPSUtyRCtQNWcwRUFZSkQyaVdXcndMbklQSW9s?=
 =?utf-8?B?UDlzTVZEUk9WUUwrZFc1dFhqc0JaY3JDRFNESEYySElRV1pQZlJOVVRvSjd1?=
 =?utf-8?B?bEVBWEFPTmdUVGZyV2JKcnNTeCtudDVFRFBjSk1qZmtGTGRkbllLZ2tQUnpC?=
 =?utf-8?B?VVdrZEdpQkkzS0Nzc2ZiNjJzM2tRU05QdEFjalg1UWE5N3BQUy9IajVtcGNV?=
 =?utf-8?B?cW5nUGNRbDBRN2t6ZVNpZmF3cEVITkZtMmR1eVgxdTBISXloUG1Tc09nblFO?=
 =?utf-8?B?Nkwzc2crRmJrdllBKzloOFhHZXllUUVJdlRZbnQ4bVBMT2MyN01EaFpodkpS?=
 =?utf-8?B?SzRhOE1kbHloeHpxQnBqL3ZHdkJRSW5Tc2tRa3BMZ2dqN1Q4ZW9tamxWWldV?=
 =?utf-8?B?NVZYVk9mUkxoVXZVV3QrTjZwbWhTZUkzY2IvdFB6bTFMdit5Znl3eVY0b09I?=
 =?utf-8?B?UmpHMW9JNWh4UTR2NDJRZWMzWTZaUDhIdUk1Z2VHejlmV2oxMk9HQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Cg3Ilb9NXxjm0H3w6b0Aa0RnUETkYKZJgvJjMppFd/RwtNgnM1OtfK1AFqWfZQTuS6RhEY1/VSiJ1CNKapJdkVywjo+H7kLhHcngJhr8xOoJaX4Zv59hot8cuA3h4rQ0bu7aCLOCHxrPb2wbcpJKCw36TIldJV2YwoYU9ht7T10ALrSiakN6FuB4trnhGX1mvFwKrxOl4tg2LlGrKHLEKakq+IL+WMJ9uC9B1oxED+PF07vOCN4hv6ZiTS3s3axIWchsCPHCu7rLL0xyDuN3KnWKAN88iLZgu5jvWLYA//s9w9cXf8SjYutZoNJm8BqXDz+pDbWpihFdZ6s//mAL7w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6470a2a0-d49d-4bf5-76f3-08df126e4eab
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 14:41:48.5135 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uSufZ2zD/+ztMSLn+4Zju+ofar23E/J/H4w3XZZLXoY9oAQFhaXdhGMBE15f4OhVSPR4r6hM4qqp2wUFMCdUCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB573934
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

PiBTdWJqZWN0OiBbUEFUQ0ggMTAvMTNdIG5ldC9pY2U6IHVzZSBjb21tb24gQVZYIFR4IGZ1bmN0
aW9ucw0KPiANCj4gVXNlIHRoZSBuZXdseSBjcmVhdGVkIGNvbW1vbiBUeCBmdW5jdGlvbnMgaW4g
dGhlIHZlY3RvciBwYXRoLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQnJ1Y2UgUmljaGFyZHNvbiA8
YnJ1Y2UucmljaGFyZHNvbkBpbnRlbC5jb20+DQoNCkFja2VkLWJ5OiBDaWFyYSBMb2Z0dXMgPGNp
YXJhLmxvZnR1c0BpbnRlbC5jb20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9pbnRlbC9pY2Uv
aWNlX3J4dHhfdmVjX2F2eDIuYyAgIHwgIDcyICstLS0tLS0tLS0tLS0tDQo+ICBkcml2ZXJzL25l
dC9pbnRlbC9pY2UvaWNlX3J4dHhfdmVjX2F2eDUxMi5jIHwgMTAyICsrKy0tLS0tLS0tLS0tLS0t
LS0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDE2MCBkZWxldGlvbnMo
LSkNCj4gDQoNCg==
