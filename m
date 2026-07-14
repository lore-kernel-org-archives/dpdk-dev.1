Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21C9C43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Jul 2026 09:24:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9BADB40289;
	Tue, 14 Jul 2026 11:24:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id D5BF74026E;
 Tue, 14 Jul 2026 11:24:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784021044; x=1815557044;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5QHCAD+7dl6cs8rJ6dm3e86tixogVJ0e95Qu7ThW4oI=;
 b=nzeseNenlDNneWheGhs/jWC5XxO4TdkbQA26dZ4eGS+7ZVuUfxlMnXfN
 mdTvhmcAqbCvpTX3s7CxIN0cIbaeKyUn4PYwxpqdhQaSRuWp9DyYQIK/w
 rqE3wknoqwmWWvGlvVW4UMm5yAqHgna30TjnZ2kjXLk0/IhZbeBUYTahM
 mlOTe1hupFfQjcwhKXeSacKMga7eTt2kWhyPKxYG6JNI9LOOYejqI0Ftz
 670nRjthBE9jNaWu/Qz80VgPxEn7FB6LSoWTAVoPavpwmPzWK+N1gcJIr
 wygwOO5Tq7r88NKT6fpVKOwf+CJXTXOk6BPxeJVWxmLxQ1r0JByykK3oL A==;
X-CSE-ConnectionGUID: /cDtuUslQLuJBhCudf5Gpg==
X-CSE-MsgGUID: 6GEU9JO0RXWKqVLa4T0mFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="84494497"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; d="scan'208";a="84494497"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2026 02:24:03 -0700
X-CSE-ConnectionGUID: lpVYZ92jTOGLguC5CFB0Cw==
X-CSE-MsgGUID: 7QeMVjM3TkSku2SyVNwnRg==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2026 02:24:02 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 02:24:02 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 14 Jul 2026 02:24:02 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.3) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 02:24:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=glw8zncY0MO5TfWR2Yci84U9v0Bmu2aOHsSjCQlINPsRXGIMStkxNYcOumhacCtcfhMW/HjI9p/W2IYfoYAOyiitTSwXPv74vC0DR7cL+GBybfjABs46AwOvL7+ahdosXegNbMQ74BsrUb/bOeA7OAaxF0PhDisU6bILBfDxlgOiNfgJgdGyYgVUVrG43zqESqSgPWNSlv1i6Y1GV7aPf1V5kd5fIfY3UTXsgsMZIFP3ganJzt99ugRUniRjHci2lmOTIKWFTX4hRSgocYAu9DDR/3E9DuUO6eH36OJu1Zvw1JNei6Pfhjgi7TwNN/cG+e0XV7J4FW7ciWcDypjCUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QHCAD+7dl6cs8rJ6dm3e86tixogVJ0e95Qu7ThW4oI=;
 b=cgiTGAefOsKKs2dbxdQAwFXMH78ToxStSs3TKI61X88WlGTVRWohEO2kylhxOZ2JsnSS4hoHkP7mmP4PaqvmZxswGvw5zHdUz0zIKhPBvsHop+md1eWoi8joWxQrmdUjpV9FjiytaKmJYoLhdr0raoO3pzekUTbYrUF+3f2xuk23XwiPOmGqzaEPNZ8LgBQFLFvEzB38vrBGEF3Jj02xhql4r/rUZUIzohJfJo8eLWy3r+xDpP9Jh7Z97Kot7HM3FY7+KkSkP7NuPcJhxSnlmlA819GoK2pMcoFjAYxkpahH4iVTnK8yIULeYKhfaxKaNn9Lj7Zv/bgBw49Ly+B6eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by CY8PR11MB7009.namprd11.prod.outlook.com (2603:10b6:930:57::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Tue, 14 Jul
 2026 09:23:59 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 09:23:59 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "rjarry@redhat.com" <rjarry@redhat.com>,
 "cfontain@redhat.com" <cfontain@redhat.com>, "stable@dpdk.org"
 <stable@dpdk.org>, "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>,
 "Richardson, Bruce" <bruce.richardson@intel.com>
Subject: RE: [PATCH v4 05/10] net/iavf: fix duplicate MAC addresses install
Thread-Topic: [PATCH v4 05/10] net/iavf: fix duplicate MAC addresses install
Thread-Index: AQHdD7yRMPZEvmkPIkeO0heIdQg0xrZrbArQgAAXPwCAAUFX8A==
Date: Tue, 14 Jul 2026 09:23:59 +0000
Message-ID: <IA4PR11MB9278CB00E23A751802B6B8F88EF92@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260709160247.1798575-1-david.marchand@redhat.com>
 <20260709160247.1798575-6-david.marchand@redhat.com>
 <IA4PR11MB92781CFE503B95525EC366AF8EFA2@IA4PR11MB9278.namprd11.prod.outlook.com>
 <CAJFAV8xbkajqm+BPF+-+24NvT7XG4Rv=tB7ci4M6BSg+0roD8w@mail.gmail.com>
In-Reply-To: <CAJFAV8xbkajqm+BPF+-+24NvT7XG4Rv=tB7ci4M6BSg+0roD8w@mail.gmail.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|CY8PR11MB7009:EE_
x-ms-office365-filtering-correlation-id: 1e058db5-b7ab-47f2-268a-08dee189a326
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|38070700021|4143699003|11063799006|6133799003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: +l6eV8yDFPztGtNr1B/efJu3mawEu5eqX8XVnx1wZHk9mlE5QRpKE9D8eTu74rIJxr1RxAz1tS/ePt1whLmRdMzxtGSAaWHxC9Rz3o3CZ5yYLR+lM13NnMwqNJ36z2gM7WvIooxT1bNRKhqhpsDzjHGHMm3gWdf5vl5GLEKLyh9QmanbXvcuLpIdPmMF52kEdbLHz3x7FgqgqPHx1xvuVsLZlz62xx5GW3meg4CExRt7JClY8HHJR21KkCFUcy4F9bRbi4h03hmT2T95TA7UgUUBbs4Z9Q9bwCQd3Qqvkjt5Uln5V6UBD2wDIkeSsmSqxWyXaVAo5er91KVxF+SFBljQHI45WvoHozSjHWYk+d+d1dSXjM8rOlQH/G4hCr7BnzE/XZea6wFerN+aW1htOe3MGTeBCmHdK1Psyh57UO1utpVfVHmFoIxXOxexxjqRB/H9HO664hdI3HpKl+FHp7E9Y06hACL48anJtD8WFTBIXd1zuE7EfvsMlaEEBnpEBHzixJkH1CDWvnkx6k/KHJoVG36Ut0HNiU6zUaTm57VN7r57HzQPEg4WYCZs4Um45RRKoDnjoERQZNfmUKsBURUETlJlFRrwMDDAWC0Se7GYHyxTmHIIwZU+P0MlAfwvByccbiAKBpY7vCiMlBSchNpY1c4RPt70darZiNZZhVMNGpKhRJN6LopivAANNkFW7jvy8+911rGlyhfnEr3SnveASAFBCKrsoitM6d3m7eA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(38070700021)(4143699003)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWh4T1llTHhOSCt2S1hvR1N6NXl0M2E1Zy9wditiODhmcEozT1VzYVhwMGE2?=
 =?utf-8?B?U3Z4Zk5OK0NnaFJUK1MxOU44NEc2M0xuSnRqaitNZWhvbWpWL0pHdHJZVHZp?=
 =?utf-8?B?eG53WWIrdFBoYXg2ZExVZjhaWXBSNWRTdWJWQjViUXdhWmxHY2wyZ0tOdmZS?=
 =?utf-8?B?TG5na3N2WFdLYkdnV1ovZ2RIeDBNMExWeC90Q0tJSjFSODlSVXFFUWNVMm5q?=
 =?utf-8?B?bmw1dDMrcEJ1QnFFQkF2dWFpMzYvMzJzUlRtOU5hWmU1eTFGZWs1UVFpNmJh?=
 =?utf-8?B?ZVdrazJzUDBGbC9nT1RncTBhODZGNVRVMWhqRGVXYzYyT3hPNzVsTktJdVFu?=
 =?utf-8?B?Q05rZGJScER2cEI1Q2hsbUsvWE5FNGxjTlhPTU0xMFZ5UkZKSHFQY1lEcGYz?=
 =?utf-8?B?NkY2RC84TFFuVk0wdG9BQUE1L0Z4UnlyZ00wWWl6RFVGMXdVaGhTd0Z5L283?=
 =?utf-8?B?NGdpM1Rpa21yWG9kSDg0UlJjb1JGdkowMmUxT2I1NnZWLzRPMUE3NjgyK3Jq?=
 =?utf-8?B?bFlYWCt5TG5EdHo3VGY2ck5maXFFY1NjV3BwVWl6SXV3L1hIanBNeEUya21n?=
 =?utf-8?B?YlhMOFJTem41SlAzdnh0eFF4Qk1LS0ZNSStMbm5sU3U3UjNMSDd3bmxGT0Fr?=
 =?utf-8?B?OEpscERJdnpaWFprZ3lub3NPaDI0b1Y1UUthR3A5N2JiYk1Xek5Da0tZeGll?=
 =?utf-8?B?M2dhb2o1M014Q1k2aEllNDRpQlh0WnNzaFQ0NXpqU0UyaVV4NStlOUZHdXlt?=
 =?utf-8?B?ZXozUFAxR3YyWENOWndZd3I2c1htZ2pqUGl3eXpiOXVHL1JBaDc2ZStYSlEr?=
 =?utf-8?B?a3gxM0Vmc3ROTWlXNGlKUUVHbzgyZ1FJQmlldXFFb2lKUElVUDZhZXFEaWYv?=
 =?utf-8?B?dWZiZXVzMHZvclgyWnFsSnpWWC8xNWlPR3BaRGg4WHdnY0N1WmRObGhJMXV1?=
 =?utf-8?B?b3FuUTRWdUhxb0tzbHpEbzNTN21VYkg3M3ZYbkUvMVI5cTUydTQrbGNMQmlE?=
 =?utf-8?B?NWQwY09iczNZQzc5RGtsUmNzZy82NHZYZjhPWldoejU4bWNvYTBlaHp2eXpL?=
 =?utf-8?B?WEJmaUhUUWJJcHFzcE5SUnk0QlJoeG1GSHRlbjBzMFNsYjNkQ01MUndFVWNp?=
 =?utf-8?B?aEF0NWFpTVk5TUJJYnBQSjRIVEFTa21UcWVYUjRELzNXOFpQOFBIYTVPREl3?=
 =?utf-8?B?cExlaXdOMHc0SjA5VXI3N3VsdkVsKy9oSnVaWmxBbFFoR3NJdGUvVEVyNVVl?=
 =?utf-8?B?YzRYVnNPcWVraHY2Vk15b1UrZndwODk2NDB4bXJ6SkNvZWx0Z2RVZVRWRVlY?=
 =?utf-8?B?VGg2TWJsMUtUWHV3d1p1ODYvZUpkR3lnSHJmMS9yWVVycnJ0RjBUNjVDckwx?=
 =?utf-8?B?QlNVbXc0Z3gyaFQzMVNRSHJGSDZiTnl4UUdOblBjZ0pPbmFFZFdSbzEySEtN?=
 =?utf-8?B?dFUxdE1Od2dvZm55dFFVV2N3Zy80VFU4S2pZUU9QY0t3elIzSnMwZC9ZcnIw?=
 =?utf-8?B?S2tsd3l4RmEwbjZwRm9vZ1F3K29PUXkycmJUSnhFMzlTWnBEQXN0Q3hWaTda?=
 =?utf-8?B?ZGxIVXh3WEVlZW9tZ1FPeDdsTTgraHFZREFlOUVaT2E2SmdZUXp3aTJTNmNV?=
 =?utf-8?B?czl4UEF1RVVGMyt3SVBmTEYrcExmY1g4aE0ydWdGS2ZNcjJQUXN5YjJrVUQ1?=
 =?utf-8?B?OVAvcDZnMXdFMklNRUpORWFjM05BKzZad0RYRGcxZ0x5OHEwNENDZG9UZ3lP?=
 =?utf-8?B?a1R6VDdjUGNDSHFZdDc4RUY5ZXB5ZUNNaW01V1ltSUJtSU50V1pWbFptcEhK?=
 =?utf-8?B?L0VvR0g4OHAyNkgxTHRnc1FoQUk5TUJXclNZM0ZTZWZkam9CaVl0M1hFc2ZO?=
 =?utf-8?B?aCtkam5DdnRBS1VLc1VYNkNrNVlhNFAxcDNRMWRObHQ5T20xMWRrdlBLSWI0?=
 =?utf-8?B?VGlqazd0cVEyMjhqaDI3NGdodmZwYlg2U3o3K3Nyc3JUTDVYL2IwVG5HL2li?=
 =?utf-8?B?NjV1T1pSdzkzOGhmTGxkNnRVNEtLcGhjdlBEYlpFdDRoRXF0ckxPWmFKMWlX?=
 =?utf-8?B?VWkyNFppN1VVK0p2dzNQR2l1S1VqOTZTRVBrbnVOWXBqVFEyVi83UXJ1dTBM?=
 =?utf-8?B?bGVzKzhSbVpoc1REU3RYRGR5d2wzSlNnQ01jNTNaTWNPa2ZnVUtvS2hRdGhv?=
 =?utf-8?B?Mlk1ejc3Yk9mNStkMVBQMklueklmMURYdlhlb3VzODFHM2huL0s0ekFETHhI?=
 =?utf-8?B?aHZXSDRKN0toZTg5TFliZWNudHZFVXdNeW1GekduaHpNUWw3NnExWGw3MVA1?=
 =?utf-8?B?NmM1Y3c2Y3JzN2pOVUFkOVB0WlVJYTNVWnlmMWIvWXgrUW11b0psdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VK8KBuHAi6QAg14YbiSwPTD8uJNvWoFDHGqMeKt9H7IRaeSamuktYb3tLiPpZK+cH1km7cyQ2F2w6CMwXLGIlCagdscKghTDIKLT209Bl4LWA5dqlqS8XILkvVY8/Ppouel1UhCUKyNuEG2ymLoGcRsBc/Gvyte/06J5d727Qw3ui30fDaBXptgdXwYXA3a8Bv1D1eOEn6qOpisLMvFF3brU3CnlGZjrx8sCKH2xWFgP6mIXld89a1szZB55ZY2xEDUaLDF59MayCIDWtYquTIHOj2bn+DCLeunZ/Hg32kVQ3SejgoP7vvWY+OPQFucxBirGeLyMCKOc7oltjLOrRQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e058db5-b7ab-47f2-268a-08dee189a326
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 09:23:59.6497 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZoPzbzC6DQel27S/WyJrZAPqKN+GMDawQhnIsPC55umkYAksZ+30H6siW2siz+Izw1e6WyQifdpc5X3JDkJs5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7009
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDA1LzEwXSBuZXQvaWF2ZjogZml4IGR1cGxpY2F0ZSBN
QUMgYWRkcmVzc2VzIGluc3RhbGwNCj4gDQo+IE9uIE1vbiwgMTMgSnVsIDIwMjYgYXQgMTU6MTQs
IExvZnR1cywgQ2lhcmEgPGNpYXJhLmxvZnR1c0BpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4g
PiBTdWJqZWN0OiBbUEFUQ0ggdjQgMDUvMTBdIG5ldC9pYXZmOiBmaXggZHVwbGljYXRlIE1BQyBh
ZGRyZXNzZXMgaW5zdGFsbA0KPiA+ID4NCj4gPiA+IE9uIHBvcnQgcmVzdGFydCwgYWxsIE1BQyBh
ZGRyZXNzZXMgZ2V0IHB1c2hlZCAqdHdpY2UqIHRvIHRoZSBoYXJkd2FyZSwNCj4gPiA+IG9uY2Ug
YnkgdGhlIGRyaXZlciBhbmQgb25jZSBieSB0aGUgZXRoX2Rldl9tYWNfcmVzdG9yZSgpIGluIGV0
aGRldi4NCj4gPiA+DQo+ID4gPiBPbiB0aGUgb3RoZXIgaGFuZCwgTUFDIGFkZHJlc3MgZmlsdGVy
cyBhcmUgcmVzZXQgaW4gdGhlIGhhcmR3YXJlDQo+ID4gPiBieSB0aGUgUEYgb25seSB3aGVuIGEg
VkYgcmVzZXQgaXMgdHJpZ2dlcmVkLg0KPiA+ID4NCj4gPiA+IFN0cmljdGx5IHNwZWFraW5nLCB0
aGUgbWFjIHJlc3RvcmUgb24gcG9ydCAocmUpc3RhcnQgaXMgdW5uZWVkZWQsDQo+ID4gPiBpZiBu
byBWRiByZXNldCBoYXBwZW5lZCwgc28gd2UgY2FuIGFubm91bmNlIHRvIGV0aGRldiB0aGF0IG5v
IG1hYw0KPiA+ID4gcmVzdG9yYXRpb24gaXMgbmVlZGVkIHZpYSBhIGdldF9yZXN0b3JlX2ZsYWdz
IGNhbGxiYWNrLg0KPiA+ID4NCj4gPiA+IFRoZW4sIG1vdmUgdGhlIG1hYyByZXN0b3JhdGlvbiB0
byB0aGUgVkYgcmVzZXQgaGFuZGxlci4NCj4gPiA+DQo+ID4gPiBGaXhlczogM2Q0MjA4NmRlZjMw
ICgibmV0L2lhdmY6IHByZXNlcnZlIE1BQyBhZGRyZXNzIHdpdGggaTQwZSBQRiBMaW51eA0KPiA+
ID4gZHJpdmVyIikNCj4gPiA+IENjOiBzdGFibGVAZHBkay5vcmcNCj4gPiA+DQo+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBEYXZpZCBNYXJjaGFuZCA8ZGF2aWQubWFyY2hhbmRAcmVkaGF0LmNvbT4NCj4g
PiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvbmV0L2ludGVsL2lhdmYvaWF2Zl9ldGhkZXYuYyB8IDMx
ICsrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjIg
aW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvaW50ZWwvaWF2Zi9pYXZmX2V0aGRldi5jDQo+ID4gPiBiL2RyaXZlcnMvbmV0
L2ludGVsL2lhdmYvaWF2Zl9ldGhkZXYuYw0KPiA+ID4gaW5kZXggMTc5ZDkwZWM1NS4uZmU1NGRm
NGI5ZiAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2ludGVsL2lhdmYvaWF2Zl9ldGhk
ZXYuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvaW50ZWwvaWF2Zi9pYXZmX2V0aGRldi5jDQo+
ID4gPiBAQCAtMTM0LDYgKzEzNCw4IEBAIHN0YXRpYyBpbnQgaWF2Zl9kZXZfdmxhbl9maWx0ZXJf
c2V0KHN0cnVjdA0KPiBydGVfZXRoX2Rldg0KPiA+ID4gKmRldiwNCj4gPiA+ICBzdGF0aWMgaW50
IGlhdmZfdmxhbl90cGlkX3NldChzdHJ1Y3QgcnRlX2V0aF9kZXYgKmRldiwNCj4gPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGVudW0gcnRlX3ZsYW5fdHlwZSB2bGFuX3R5cGUsIHVpbnQx
Nl90IHRwaWQpOw0KPiA+ID4gIHN0YXRpYyBpbnQgaWF2Zl9kZXZfdmxhbl9vZmZsb2FkX3NldChz
dHJ1Y3QgcnRlX2V0aF9kZXYgKmRldiwgaW50IG1hc2spOw0KPiA+ID4gK3N0YXRpYyB1aW50NjRf
dCBpYXZmX2dldF9yZXN0b3JlX2ZsYWdzKHN0cnVjdCBydGVfZXRoX2RldiAqZGV2LA0KPiA+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVudW0gcnRlX2V0aF9kZXZfb3Bl
cmF0aW9uIG9wKTsNCj4gPiA+ICBzdGF0aWMgaW50IGlhdmZfZGV2X3Jzc19yZXRhX3VwZGF0ZShz
dHJ1Y3QgcnRlX2V0aF9kZXYgKmRldiwNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHN0cnVjdCBydGVfZXRoX3Jzc19yZXRhX2VudHJ5NjQgKnJldGFfY29uZiwNCj4gPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQxNl90IHJldGFfc2l6ZSk7DQo+
ID4gPiBAQCAtMjY0LDYgKzI2Niw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZXRoX2Rldl9vcHMg
aWF2Zl9ldGhfZGV2X29wcw0KPiA9IHsNCj4gPiA+ICAgICAgIC50eF9kb25lX2NsZWFudXAgICAg
ICAgICAgICA9IGlhdmZfZGV2X3R4X2RvbmVfY2xlYW51cCwNCj4gPiA+ICAgICAgIC5nZXRfbW9u
aXRvcl9hZGRyICAgICAgICAgICA9IGlhdmZfZ2V0X21vbml0b3JfYWRkciwNCj4gPiA+ICAgICAg
IC50bV9vcHNfZ2V0ICAgICAgICAgICAgICAgICA9IGlhdmZfdG1fb3BzX2dldCwNCj4gPiA+ICsg
ICAgIC5nZXRfcmVzdG9yZV9mbGFncyAgICAgICAgICA9IGlhdmZfZ2V0X3Jlc3RvcmVfZmxhZ3Ms
DQo+ID4gPiAgfTsNCj4gPiA+DQo+ID4gPiAgc3RhdGljIGludA0KPiA+ID4gQEAgLTI4NCw2ICsy
ODcsMTMgQEAgaWF2Zl90bV9vcHNfZ2V0KHN0cnVjdCBydGVfZXRoX2RldiAqZGV2LA0KPiA+ID4g
ICAgICAgcmV0dXJuIDA7DQo+ID4gPiAgfQ0KPiA+ID4NCj4gPiA+ICtzdGF0aWMgdWludDY0X3QN
Cj4gPiA+ICtpYXZmX2dldF9yZXN0b3JlX2ZsYWdzKF9fcnRlX3VudXNlZCBzdHJ1Y3QgcnRlX2V0
aF9kZXYgKmRldiwNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgIF9fcnRlX3VudXNlZCBlbnVt
IHJ0ZV9ldGhfZGV2X29wZXJhdGlvbiBvcCkNCj4gPiA+ICt7DQo+ID4gPiArICAgICByZXR1cm4g
UlRFX0VUSF9SRVNUT1JFX0FMTCAmIH5SVEVfRVRIX1JFU1RPUkVfTUFDX0FERFI7DQo+ID4gPiAr
fQ0KPiA+ID4gKw0KPiA+ID4gIF9fcnRlX3VudXNlZA0KPiA+ID4gIHN0YXRpYyBpbnQNCj4gPiA+
ICBpYXZmX3Zmcl9pbnByb2dyZXNzKHN0cnVjdCBpYXZmX2h3ICpodykNCj4gPiA+IEBAIC0xMDc0
LDE1ICsxMDg0LDE0IEBAIGlhdmZfZGV2X3N0YXJ0KHN0cnVjdCBydGVfZXRoX2RldiAqZGV2KQ0K
PiA+ID4gICAgICAgICAgICAgICBydGVfaW50cl9lbmFibGUoaW50cl9oYW5kbGUpOw0KPiA+ID4g
ICAgICAgfQ0KPiA+ID4NCj4gPiA+IC0gICAgIC8qIFNldCBhbGwgbWFjIGFkZHJzICovDQo+ID4g
PiAtICAgICBpYXZmX2FkZF9kZWxfYWxsX21hY19hZGRyKGFkYXB0ZXIsIHRydWUpOw0KPiA+ID4g
LQ0KPiA+ID4gLSAgICAgaWYgKCFhZGFwdGVyLT5tYWNfcHJpbWFyeV9zZXQpDQo+ID4gPiAtICAg
ICAgICAgICAgIGFkYXB0ZXItPm1hY19wcmltYXJ5X3NldCA9IHRydWU7DQo+ID4gPiAtDQo+ID4g
PiAtICAgICAvKiBTZXQgYWxsIG11bHRpY2FzdCBhZGRyZXNzZXMgKi8NCj4gPiA+IC0gICAgIGlh
dmZfYWRkX2RlbF9tY19hZGRyX2xpc3QoYWRhcHRlciwgdmYtPm1jX2FkZHJzLCB2Zi0NCj4gPiA+
ID5tY19hZGRyc19udW0sDQo+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRy
dWUpOw0KPiA+ID4gKyAgICAgaWYgKCFhZGFwdGVyLT5tYWNfcHJpbWFyeV9zZXQpIHsNCj4gPiA+
ICsgICAgICAgICAgICAgaWYgKGlhdmZfYWRkX2RlbF9ldGhfYWRkcihhZGFwdGVyLCAmZGV2LT5k
YXRhLQ0KPiA+ID4gPm1hY19hZGRyc1swXSwgdHJ1ZSwNCj4gPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFZJUlRDSE5MX0VUSEVSX0FERFJfUFJJTUFSWSkgIT0gMCkNCj4gPiA+ICsg
ICAgICAgICAgICAgICAgICAgICBQTURfRFJWX0xPRyhFUlIsICJmYWlsZWQgdG8gYWRkIHByaW1h
cnkgTUFDOiINCj4gPiA+IFJURV9FVEhFUl9BRERSX1BSVF9GTVQsDQo+ID4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBSVEVfRVRIRVJfQUREUl9CWVRFUygmZGV2LT5kYXRhLQ0KPiA+
ID4gPm1hY19hZGRyc1swXSkpOw0KPiA+ID4gKyAgICAgICAgICAgICBlbHNlDQo+ID4gPiArICAg
ICAgICAgICAgICAgICAgICAgYWRhcHRlci0+bWFjX3ByaW1hcnlfc2V0ID0gdHJ1ZTsNCj4gPiA+
ICsgICAgIH0NCj4gPiA+DQo+ID4gPiAgICAgICBydGVfc3BpbmxvY2tfaW5pdCgmdmYtPnBoY190
aW1lX2FxX2xvY2spOw0KPiA+ID4NCj4gPiA+IEBAIC0zNDI0LDYgKzM0MzMsMTAgQEAgaWF2Zl9o
YW5kbGVfaHdfcmVzZXQoc3RydWN0IHJ0ZV9ldGhfZGV2DQo+ICpkZXYsDQo+ID4gPiBib29sIHZm
X2luaXRpYXRlZF9yZXNldCkNCj4gPiA+ICAgICAgICAgICAgICAgaWYgKHJldCkNCj4gPiA+ICAg
ICAgICAgICAgICAgICAgICAgICBnb3RvIGVycm9yOw0KPiA+ID4NCj4gPiA+ICsgICAgICAgICAg
ICAgLyogYWZ0ZXIgYSBWRiByZXNldCwgYWxsIG1hYyBhZGRyZXNzZXMgZ290IGZsdXNoZWQsIHJl
c3RvcmUgdGhlbQ0KPiA+ID4gKi8NCj4gPiA+ICsgICAgICAgICAgICAgaWF2Zl9hZGRfZGVsX2Fs
bF9tYWNfYWRkcihhZGFwdGVyLCB0cnVlKTsNCj4gPiA+ICsgICAgICAgICAgICAgaWF2Zl9hZGRf
ZGVsX21jX2FkZHJfbGlzdChhZGFwdGVyLCB2Zi0+bWNfYWRkcnMsIHZmLQ0KPiA+ID4gPm1jX2Fk
ZHJzX251bSwgdHJ1ZSk7DQo+ID4gPiArDQo+ID4NCj4gPiBUaGlzIHJlc3RvcmUgYmxvY2sgb25s
eSBydW5zIGlmIHRoZSBkZXZpY2Ugd2FzIHN0YXJ0ZWQgd2hlbiB0aGUgaGFuZGxlciB3YXMNCj4g
PiBlbnRlcmVkLiBJdCBtaWdodCBtYWtlIG1vcmUgc2Vuc2UgdG8gbW92ZSBpdCBpbnRvIGlhdmZf
cG9zdF9yZXNldF9yZWNvbmZpZw0KPiA+IHdoaWNoIHdpbGwgcnVuIGZvciBWRi1pbml0aWF0ZWQg
cmVzZXRzIHJlZ2FyZGxlc3Mgb2Ygc3RhcnRlZCBzdGF0ZSwgYW5kIGZvcg0KPiA+IFBGLWluaXRp
YXRlZCB3aWxsIHJ1biBpZiB0aGUgZGV2aWNlIHdhcyBzdGFydGVkIG9uIGVudHJ5Lg0KPiA+IEZv
ciBQRi1pbml0aWF0ZWQgaWYgdGhlIGRldmljZSB3YXMgbm90IHN0YXJ0ZWQgd2UgcmV0dXJuIGZy
b20NCj4gPiBpYXZmX2hhbmRsZV9od19yZXNldCgpIGltbWVkaWF0ZWx5LCBzbyB0aGVyZSdzIG5v
IG9wcG9ydHVuaXR5IHRvIHJlc3RvcmUNCj4gPiB0aGUgTUFDIGFkZHJlc3NlcyBhdCBhbGwuIEl0
IG5lZWRzIHRvIGJlIGNvbnNpZGVyZWQgaG93IHRvIHJlc3RvcmUgdGhlIG1hY3MNCj4gPiBpbiB0
aGF0IGNhc2UuDQo+ID4gTmVlZCB0byBjb25zaWRlciBhcyB3ZWxsIGhvdyB0aGUgcmVzdG9yZV9m
bGFncyBhbmQgYXV0b19yZWNvbmZpZyBmZWF0dXJlcw0KPiA+IHdvcmsgd2l0aCBvbmUgYW5vdGhl
ci4gSWYgdGhlIGF1dG9fcmVjb25maWcgZGV2YXJnIGlzIHNldCB0byB6ZXJvIGl0IG1lYW5zDQo+
ID4gdGhlIHVzZXIgZG9lc24ndCB3YW50IGFueSByZXN0b3JhdGlvbiBvZiBzZXR0aW5ncyB1cG9u
IHJlc2V0Lg0KPiANCj4gSSB3YXMgbm90IGF3YXJlIG9mIHRoaXMga25vYi4NCj4gSXQgc2VlbXMg
Y3JhenkgdG8gbWUgdG8gaGF2ZSBzdWNoIHNwZWNpZmljIGZsYWcgdG8gZGlzYWJsZSBzb21ldGhp
bmcNCj4gdGhhdCBJIHRha2UgZm9yZWdyYW50ZWQgZHVyaW5nIHRoZSBsaWZlIG9mIGEgRFBESyBw
b3J0Lg0KPiBJIHJlYWxseSBob3BlIG5vIGFwcGxpY2F0aW9uIHJlbGllcyBvbiB0aGUgbWFjIGFk
ZHJlc3NlcyBsaXN0IGJlaW5nDQo+IGZsdXNoZWQgZHVyaW5nIGEgVkYgcmVzZXQuLi4NCg0KSSB0
aGluayBpdCdzIHJlYXNvbmFibGUgdG8ga2VlcCB0aGUgTUFDIHJlc3RvcmUgb3V0c2lkZSBvZiBh
dXRvX3JlY29uZmlnLA0KdGhhdCBhbHNvIHByZXNlcnZlcyB0aGUgZXhpc3RpbmcgYmVoYXZpb3Vy
IG9mIHJlc3RvcmluZyBNQUNzIG9uIHJlc2V0Lg0KQnV0IHdpdGggeW91ciBwYXRjaCB0aGUgcmVz
dG9yZSBpcyBza2lwcGVkIHdoZW5ldmVyIHRoZSBwb3J0IHdhcyBzdG9wcGVkIGF0DQpyZXNldCBl
bnRyeS4gV2lsbCB0aGUgTUFDcyBiZSByZXN0b3JlZCBvbiB0aGUgbmV4dCBkZXZfc3RhcnQ/DQoN
Cj4gDQo+IFdoaWxlIG1vdmluZyB0aGUgY29kZSB0byBpYXZmX3Bvc3RfcmVzZXRfcmVjb25maWcg
a2luZCBvZiBtYWtlcyBzZW5zZQ0KPiB0byBtZSwgSSBob25lc2x5IGRvbid0IGtub3cgd2hhdCB0
byBkbyB3cnQgcmVzdG9yZV9mbGFncy4NCj4gSXQgc2VlbXMgb3J0aG9nb25hbCB0byBtZS4NCj4g
SWYgZXRoZGV2IGRlY2lkZXMgdG8gcmVzdG9yZSB0aGUgbWFjIGFkZHJlc3NlcywgSSBkb24ndCBz
ZWUgd2h5IHNvbWUNCj4gZGV2YXJncyB3b3VsZCBoYXZlIHNvbWV0aGluZyB0byBzYXkgYWJvdXQg
aXQuDQoNCkkgYWdyZWUgZXRoZGV2IHNob3VsZCB0YWtlIHByZWNlZGVuY2Ugb3ZlciB0aGUgZGV2
YXJnLiBPbmUgb3B0aW9uIGlzIHRvDQpoYXZlIGlhdmZfcG9zdF9yZXNldF9yZWNvbmZpZyBob25v
dXIgdGhlIHNhbWUgcmVzdG9yZV9mbGFncyBtYXNrIHRoZSBub3JtYWwNCnN0YXJ0IHBhdGggdXNl
cywgc28gdGhlIHR3byBwYXRocyBkb24ndCBkaXZlcmdlLiBJIGRvbid0IHRoaW5rIHlvdSBuZWVk
IHRvDQphZGRyZXNzIHRoYXQgaW4geW91ciBzZXQsIGl0J3Mgc29tZXRoaW5nIEkgY2FuIGxvb2sg
aW50by4NCg0KQW5kIEkgYWdyZWUgdGhlIGZsYWcgaXMgcXVpdGUgc3BlY2lmaWMuIEkgdGhpbmsg
aXRzIG1haW4gdXNlIGlzIGR1cmluZyBhIFZGDQppbml0aWF0ZWQgcmVzZXQsIHRoZSB1c2VyIG1h
eSB3YW50IHRvIHJlc2V0IHRoZSBWRiBjb21wbGV0ZWx5IGFuZCBub3QNCnJlc3RvcmUgYW55dGhp
bmcuIEkgdGhpbmsgaW5zdGVhZCBvZiBhIGRldmFyZyBJIGNvdWxkIGFkZHJlc3MgdGhpcyBieQ0K
YWRkaW5nIGEgcGFyYW1ldGVyIHRvIHRoZSBkZXYtcHJpdmF0ZSBydGVfcG1kX2lhdmZfcmVpbml0
IEFQSS4gSSdsbCBsb29rDQppbnRvIHRoaXMgdG9vLiBEZWZpbml0ZWx5IHJvb20gZm9yIGltcHJv
dmVtZW50IGhlcmUgYXJvdW5kIHRoZSByZXNldCBwYXRoLg0KDQo+IA0KPiANCj4gLS0NCj4gRGF2
aWQgTWFyY2hhbmQNCg0K
