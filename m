Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0BDC88E77
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 14:59:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACC7C40DDD;
	Mon, 14 Sep 2026 16:59:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id ED4BF40DD7
 for <dev@dpdk.org>; Mon, 14 Sep 2026 16:59:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789397950; x=1820933950;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Wudusd6VUQInuKsEKwLYv+x7VCJ8j+1i571B4nkAkDw=;
 b=O8LEgi0BFUDy14vH0sZcIalrfmEax0Spxv+xpibbgErnXVfnKkvziXsI
 Z9EgCcZ5FiMK4u14Vs+jJD9JKldd1ctnAcKJfkTJso+GZvk7GSmb0Lqxj
 rR2mgORV6DsOT/h4O2Tq6mkiFwu9W9tppnD3bWqQJ9ik0MhmBzkSLMA6r
 zADZKnLNZgBNvlaCApv7bsFr5I7TtCiSn+6vOY97ayHfXyrKmdol98/Lk
 faTjd+WwJGBdUy85FKmmHbawTL4n4iZtd7cV/5h8226H0hXac115h5GxF
 GyVctThjFieXxRlL5JIH0QMxD2bjNKf5H3WKXc0XW6IftnXp2nPSzXEsC A==;
X-CSE-ConnectionGUID: pd/WhpnURB63mNfOIRGBpw==
X-CSE-MsgGUID: dmzW1PRMQ6C6r8vRuS1xsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89687997"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89687997"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 07:59:09 -0700
X-CSE-ConnectionGUID: tQkWsiX+SU2qJHzvzHdZ1g==
X-CSE-MsgGUID: SWaXeGQ9SOGYMprUTg5SQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="273178316"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 07:59:08 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 07:59:07 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 07:59:07 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.37) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 07:59:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f64LLQSZB12vgtvuT1aD/82nlKB6ui+eMwyJuZYyVybtXnDkfndWd863IW1u7JSZ/sqsFLoyK7peR6hVIwzvhQ8WHi175VNf2Fy+hfaSr7ZEcUWKqP+a1rR0ZnwRxtm9XAQPaRkQIlUYn/vPhXcho0ScA3m8eFDePtYbebAXWl07pGNS660ON+0CC1lqw4FP150jLOs5Eg6+7V3ylUToyTnIORPc0qr6VsXiLUG9TlvJ4A0t+gD8rrZrjSmx3O1R2Z/5nAJAoX/1NAmviUTOA8XmZ+1XYlMbwX2g3egcsQqmVcv4RH9q4uAEpXBwVQtM5tmFseRSPaiKKpM0YsTSiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wudusd6VUQInuKsEKwLYv+x7VCJ8j+1i571B4nkAkDw=;
 b=fTasQhCTDEBSktqIH27fdhyjrKeVoPRbDEAKn3jCakzkBCCFaB5SediziXd+y816pjmexYMN6CpCNA+VXYhtliNFirn/mjeckwxyMGMNgrXryobHH36b1FV+3333I79FzUoQU5/QbuQj5lAAzxJSSBfXHE8ZaJuW/mpjAQN0PRu9FewJ9oI6WsgUYqJkadCIzbMuM3UIfD49rMUAHADZL8JSHL7CjCGGnb+bt/YofcJxQ3Qqgg+PJOdE0QM0r0zmOSooff9agxVstkXrZyLXPYjVyfVsNaM8ED+nhAHt+qBvD4qjYNAYtrDI+BPsHItY2QujbcqpOnSOpuNJ12wNkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by SA3PR11MB7980.namprd11.prod.outlook.com (2603:10b6:806:2fc::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Mon, 14 Sep
 2026 14:59:05 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 14:59:05 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Shetty, Praveen"
 <praveen.shetty@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>, "Wu, Jingjing" <jingjing.wu@intel.com>
Subject: RE: [PATCH 12/13] net/intel: improve Tx path selection logic
Thread-Topic: [PATCH 12/13] net/intel: improve Tx path selection logic
Thread-Index: AQHdQQa+rPKlKh9C60GyjKnBRtjUgLbOMRyA
Date: Mon, 14 Sep 2026 14:59:04 +0000
Message-ID: <IA4PR11MB9278EB38C0F55891E35DA1858EBB2@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260903170140.360477-1-bruce.richardson@intel.com>
 <20260903170415.361188-1-bruce.richardson@intel.com>
In-Reply-To: <20260903170415.361188-1-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|SA3PR11MB7980:EE_
x-ms-office365-filtering-correlation-id: ee1e87ce-72cd-49e3-b69a-08df1270b870
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|38070700021|4143699003|10067099003|18002099003|11063799006|56012099006|22082099003;
x-microsoft-antispam-message-info: F2tPc8Owmu64uc3/zh6F8pHi1xYR1q0Ji1hbziCwe0pa8+hbV/Gka8x3i3YwunlOchI8/FaifeZeXmMUcAtrKxkMTLBg83H1bDNWTtp7heaKuTFrp8jLpVx9CnNwy/IParTM6XS0BuOVgM4qIP6EtVDBjl8jKqWing80Mh3nqZE8T+CORPgAEX2vWFPxS2RkZyagmGOrUXeKqEHQp3CRW53p3f9mEnqo1IiD07Rp+kHGllHdTY5tkyw/421ftogJj4HywnhuH5leHpQRraakl02N9JEijV0GK/NVxK52N8Jl25p1arfGnQVEzuxdWafhbv7+V1ltPIriAy3iK5Zht6AhtWsCJVc1M1HUB6prPZzcPntTLM14amSwbpeu+Zb0m3yJM+w/ODDzeIQQsOAAFaNulb6kPJ5Ze5NgD8c4DKAZVYNqZusoO4H+cwcyMqBdYOLG0VEn1nJBNBT4BcoIxyjXpDDq1qMwCfRqgdD/EuYS80LcCnFuq5QrizD7BoD+71Roz1BjvsTmt7fh3t5NP0knN6cHRXOTovwHnDdC0yDeKqzf2YkpzuKMgM7ZmW2EB4sCvS11r62WIwgn236QqWmFYTeV0iFWHJLNeuAn8e8GN3R22HKEeCrbQ0cHC/wyTBba5MrpwwDSOCFHARka3BSrI/CHxLa4+FR7LVxULXHLs1y4tD3/63S63AQ+fMqtRGtHkcKvXyiOgGluiGuPUBDxbwppu53Y538CQUU/GvE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(4143699003)(10067099003)(18002099003)(11063799006)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzVmR0x1MXhFaU1kaGxaSytOKzl0Ri8yRk4velgrajdrcDk2NnAxTW9NaVBM?=
 =?utf-8?B?YXUxVkd0UVdDZm4wTTliZ01NOXlDQWFNMGlPTUdZNkQxZmRTeVlVcGxkNGdI?=
 =?utf-8?B?ci96SzhCQ0tvY3ZUc0lGMzRVQjNEQkh6MU4yS21uRkRRcitQM0dPTVlsOSta?=
 =?utf-8?B?R0xwNnlqdXE3S3RLRWZGMy84Qnc3U3Z0cjB4LzM3bFM0dUxvYWJkYzdBU3NS?=
 =?utf-8?B?YWRpMUZpemJUUUkwWEpUVjV4TjBTOEZYSTBOaTBhcVR4MWhKTkRCYzM1cG02?=
 =?utf-8?B?NzRCMEFGK0E2VWdoUGlkcmkzSW5tQSt6b29EaXNkdWd4ak5GWkR3SEFtSEFa?=
 =?utf-8?B?cy9JL0tpK3BteU94MjR2OC9oVWRZbVNjRWNaL2k4RDNXWUZoV0loMWsraUUx?=
 =?utf-8?B?K0VrZktWd0ZWYkh1b1g0WEgwSVA1Y3VoNW1wbFZCYldTMUZ4WGQ5NEFUMW5P?=
 =?utf-8?B?Tjdvd0JrRllqR25pT1BsemJRN2hYUEE2OG0xN2dCRUpIQjhFZHVDQ3NVbXBP?=
 =?utf-8?B?WjNWTWZwNzAwcXQwQkZLS3pWcjNmUzJKTms4dmtQVWNyeW1kVWdtN3BDdWRP?=
 =?utf-8?B?QlNNaFFMVWVSaC9VNk42STdHT096QWNTUE9XaG4rR3JtTTZZN0NTWU55KzBO?=
 =?utf-8?B?aXRvZWRMNEtNR3lQdVBqcVJzSStlWGdUZWVaTDFGT3cwcGRJMW1OM0FLckdy?=
 =?utf-8?B?UldUeGVkM1hBbHlVQ01TLzIwbHBOZlBWTFFoS25TYjV3L2EvaFp6b25WQmI4?=
 =?utf-8?B?R2ozaHZPdktOTkRlZXY4QjM5UWVNemxNTXNjbUtoMm9XaGVYSXoxR0d0am1x?=
 =?utf-8?B?SjNXTlZCWVFIa2NBK1V2YlpXdWl4aG1McjhZajNhV0dGT1ZuQnRQY0lLeTI0?=
 =?utf-8?B?UXBFMzZ3dTgrWlJNenhDUWhqeENQZjJnRUpHYkVxdjVPeG4yMTRYOVRrQ3Jt?=
 =?utf-8?B?b3FuekRHSGdjN1IzeXJuNXNiSmxGdWxjSVQ2NTAwRE03UFAwVzQ2ZjV5a0F5?=
 =?utf-8?B?VWdvSEkrSllWdTZLMzU1RFFleWxtSVRBaDJITUNBeThDQ0FYRDBZZ1U5YTY0?=
 =?utf-8?B?bVpJMkNScDYxVXJKUE1YRFNZTDdreWsyZW5kbVM0VDNXeTh5THEwMW95Z3A1?=
 =?utf-8?B?RzdrVFpiK250V3AwbjdldEJiQWhsdzA3SlNlRktDcGVtS0dVVVFXWUh3S0px?=
 =?utf-8?B?WXJJTVR3cURGRWVWd1RxUElyNjJ1Wk5rVysrbXY0NTdGRmg5MVhYN0M5RGp3?=
 =?utf-8?B?Nk5xOG8xUVRGSDFOZ0F2c3NTRjZGSlExQklDZ3JhOE1WT2UwQTh2S2VaK1Zs?=
 =?utf-8?B?ZkdoSDdhUXVWVHIvcnhobDRYRzh6dWxCeDNPT2E1SzVnTXlHNXBtTFRRc0J6?=
 =?utf-8?B?VjJHaHFEd3hDbjh5aS8vNWJqYnVtcElPbmxpYnltNjEyTGhFMEVGR21rL25w?=
 =?utf-8?B?OEcwaWZBRkd0aVk5dlUyRUFBbzdud2hiUkwvdVdlUFZPU1JlRWUvN2d5UmVS?=
 =?utf-8?B?eFRpenhTSUo0UVhpYmxHMVVERTV1Z0ZBL3hDY2dkY1NHSWlnTFBONjNTN0dI?=
 =?utf-8?B?K0J0YjVZN3lsdkFEVkU1R3JOWTEyTk1mTUd5VStsTlQ3enh2eDZkbm40YXVX?=
 =?utf-8?B?dUFwT3U0OTFmTG1nWHVJUitkTjR4Q2N0dHZkeWNUSXlCYzRCVzM0WFI4YVRR?=
 =?utf-8?B?elNuS2JEVnhPMGM0NDk1SEh2NXlzOG0xUjdFNXhLYUZkbm9vUk12WkRBaXZU?=
 =?utf-8?B?VkNIL2o5THM1MXo2aXdySWNKVGZiYjZETjFCM24wMWUxMVhQOXBZaEVZZGNn?=
 =?utf-8?B?eEF0UjhQYU14QlpyMDRPei94NHFqNGVUcDNZNWUzQzB2bDl5WHJyZ0NSZHRU?=
 =?utf-8?B?c2JFNm1zNWNEU0FudUJOd0tuWDlrdTUxU0tCUFBCNUpoS3ZIcDVIUUtGUkFY?=
 =?utf-8?B?K0pTQnpNZ1dpMThEMGd2WXlHMWJjdlhsVnR1TU9YRWlnaW9SdEJHcm9wZVBv?=
 =?utf-8?B?VGYvZmVmZmovUnl6bGZINytEUGYvc1Y0czBrcnpQeFJMeXdXUEFzWGNWMGtl?=
 =?utf-8?B?ZUNUM1RIUndqajVqYUNld3l3eHU3dnkzMSsrWXVNMkVKajNJVTVOLzYxelM4?=
 =?utf-8?B?eVRzOUtLdTJMWVFSaSt4VVBYNjFlMzFXZUkzYXhHbGFFMmVGR1VZSXJTZGJH?=
 =?utf-8?B?U00xbVFIWnVxMmozQ283a25KbHQvV0p4aldIZUpSQ3dEZWtnSnNVbmUvN3NG?=
 =?utf-8?B?Zk9UdThUc0k5ajRsRXBRblNxZnRJQmFtYzBPY3QvVDR0OHZsMXkrSjJqK0d6?=
 =?utf-8?B?d29HTENONmhUL1FmTjNSakx0VTdicnF0aVdHTzhKUC9aWjd1N2k3QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: yoxIqkSiQCV4VaU/gkQnfm3zKXShwLRBz9g+WjIdj5G/Z+RHW7lecLsT7MC+xz0Jf+uUg0Gry0suU3ewCD7MNAfrFcC04Wy+2OxqkVwXU1PHDEmops0XzJA+yU1I9YnTu3Oh0nRqqifFuBSspejL/kbzq1gol15xkbDuNO4ratFMebiAZ0WDmVlVjTl0aHnIZJvlNCBV8UwA5qXmJgh6n5KEE/4WU9rXOSZMdPXZg3I13U/BX4+de/EfeZeFbcyUOa96BlO6bNojkV5ji7ci7wGmFljTQQT691FOhM79+rxAqb0dLYpbDXsEREMXIkf3Miw60KPwjc9xKazSicqtjg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee1e87ce-72cd-49e3-b69a-08df1270b870
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 14:59:04.9387 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uraaQFdUqqfsG3aLN3M1+f7gClnjSDemPxjXxjMbNB4/gvVYslO3aoH0lnZ18oT0Nd349nWyjMV0hRDN2sBipg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7980
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

PiBTdWJqZWN0OiBbUEFUQ0ggMTIvMTNdIG5ldC9pbnRlbDogaW1wcm92ZSBUeCBwYXRoIHNlbGVj
dGlvbiBsb2dpYw0KPiANCj4gUmV3b3JrIHRoZSByZWxldmFudCBwcmlvcml0eSBvZiBjb250ZXh0
IGRlc2NyaXB0b3IgdnMgU0lNRCB3aWR0aCB3aGVuDQo+IHNlbGVjdGluZyBhIFR4IHBhdGggc28g
dGhhdCBwcmVzZW5jZSBvZiBjb250ZXh0IGRlc2NyaXB0b3JzIGlzIG9ubHkNCj4gY29uc2lkZXJl
ZCB3aGVuIGFsbCBlbHNlIGlzIGVxdWFsLg0KPiANCj4gTm9ybWFsbHksIHBhdGggc2VsZWN0IHRh
a2VzIHBsYWNlIHdpdGhvdXQgaGF2aW5nIHRvIHdvcnJ5IGFib3V0IGNvbnRleHQNCj4gZGVzY3Jp
cHRvcnMsIHNpbmNlIG9mZmxvYWRzIHJlcXVpcmluZyBjb250ZXh0IGRlc2NyaXB0b3JzIGFyZSBz
cGVjaWZpZWQNCj4gdXNpbmcgdGhlIG9mZmxvYWRzIGJpdG1hcCBmb3IgZWFjaCBUeCBwYXRoLiBI
b3dldmVyLCBpbiBzb21lIGNhc2VzLCB0aGUNCj4gbmVlZCB0byB1c2UgYSBjb250ZXh0IGRlc2Ny
aXB0b3IgaXMgbm90IGVuY29kYWJsZSB2aWEgdGhpcyBvZmZsb2FkIHBhdGgsDQo+IGUuZy4gVkxB
TiBvZmZsb2FkIGZvciBpYXZmIGNhbiBzb21ldGltZXMgdXNlIHRoZSBkYXRhIGRlc2NyaXB0b3Ig
YW5kDQo+IHNvbWV0aW1lcyB0aGUgY29udGV4dCBkZXBlbmRpbmcgb24gd2hhdCBQRiBzcGVjaWZp
ZXMgYXQgcnVudGltZS4gVG8NCj4gYWNjb3VudCBmb3IgdGhvc2UgY2FzZXMsIHdlIHNlcGFyYXRl
IG91dCB0aGUgdXNlIG9mIGNvbnRleHRzIGZyb20gdGhlDQo+IHBhdGggZmVhdHVyZXMsIGJ1dCBp
bnN0ZWFkIG5vdGUgaXQgYXMgcGFydCBvZiB0aGUgcGF0aCBpbmZvcm1hdGlvbiwgYW5kDQo+IGFk
ZCBhbiBhZGRpdGlvbmFsIHBhcmFtZXRlciB0byB0aGUgVHggcGF0aCBzZWxlY3Rpb24gZm9yIGRy
aXZlcnMgdG8NCj4gbWFuZGF0ZSBhIGNvbnRleHQgZGVzY3JpcHRvciBiZSBwcmVzZW50LiBPdGhl
cndpc2UsIGN0eCBpcyBsYXJnZWx5DQo+IGlnbm9yZWQgaW4gcGF0aCBzZWxlY3Rpb24sIGV4Y2Vw
dCBhcyBhIGxhc3QtcmVzb3J0IHRpZS1icmVha2VyIGJldHdlZW4NCj4gdHdvIHBhdGhzLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogQnJ1Y2UgUmljaGFyZHNvbiA8YnJ1Y2UucmljaGFyZHNvbkBpbnRl
bC5jb20+DQoNCkFja2VkLWJ5OiBDaWFyYSBMb2Z0dXMgPGNpYXJhLmxvZnR1c0BpbnRlbC5jb20+
DQoNCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9pbnRlbC9jb21tb24vdHguaCAgICAgIHwgNDEgKysr
KysrKysrKysrKysrKystLS0tLS0tLS0NCj4gIGRyaXZlcnMvbmV0L2ludGVsL2NwZmwvY3BmbF9y
eHR4LmMgfCAgMyArLQ0KPiAgZHJpdmVycy9uZXQvaW50ZWwvaTQwZS9pNDBlX3J4dHguYyB8ICAy
ICstDQo+ICBkcml2ZXJzL25ldC9pbnRlbC9pYXZmL2lhdmZfcnh0eC5jIHwgNDYgKysrKysrKysr
KysrKysrKy0tLS0tLS0tLS0tLS0tDQo+ICBkcml2ZXJzL25ldC9pbnRlbC9pY2UvaWNlX3J4dHgu
YyAgIHwgIDMgKy0NCj4gIGRyaXZlcnMvbmV0L2ludGVsL2lkcGYvaWRwZl9yeHR4LmMgfCAgMyAr
LQ0KPiAgNiBmaWxlcyBjaGFuZ2VkLCA1OCBpbnNlcnRpb25zKCspLCA0MCBkZWxldGlvbnMoLSkN
Cj4gDQoNCg==
