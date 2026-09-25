Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E353EC98321
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 14:33:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1FBD402AD;
	Fri, 25 Sep 2026 16:33:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 8529940294
 for <dev@dpdk.org>; Fri, 25 Sep 2026 16:33:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790346800; x=1821882800;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YahSuAIqLyU+Re/6LyNciNL+sD76EKd1/TY6CMeBuiw=;
 b=gpaXDjDBDZEszFWQoNUf/RJjzG67NHzmIsd5wtSDDkkAH5+McCr3gCpq
 w+VvAvAh+ZKJFuL+xio4CSfXD9Iwz2uGJ6o8R5nC+a7G+ypGftkn4OZ+n
 hsI1SWFRn8aZwU1uMGsL8/MrdgBpVEgYH/GJpVaU4RUpa9gmg7Masnk2/
 yJZTZV6wGnGDimlFd3mGsJ0gJ8nwPE4NB5H78hj9yhFkCulYJuEvkSKQ1
 3M0qQonOy6JBTmhr5pDti09OjnwFpSnz1l5zLhSC/InKHtyz5mBoUVfeZ
 snB1CPUYsxORV6UxXC9zTGkCClZlyYrZvhC6MI5BHZ68na9bcFUMbRVNA g==;
X-CSE-ConnectionGUID: VBva3HpBSOKFcbNlIS7yLQ==
X-CSE-MsgGUID: NIyGUYJKShK09S2J1h40Bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="116661861"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="116661861"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 07:33:18 -0700
X-CSE-ConnectionGUID: 4nJttWeYRby8Ih2Apw9uAQ==
X-CSE-MsgGUID: Tc8oyu/tTXe/IQcLA1S+pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="303855446"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 07:33:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 07:33:17 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 07:33:17 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.14)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 07:33:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lr9XtNOZ+jnspo8PCJQmewyuz8skwA+/TYD4D5cyTWaARyzyHLSQeYS1Ikkxi9IK96YJZ7gXG0Trvz4L1MCZDMFStUxpsXEKo8iurGxlgFiSOVYGHP3TzjSHzi2TWNUIZpcBM3FDvn3DBHk3Q+8GZh6Elo5YHIDf9Ur0xwop8yIbMFWakpPWYrvC0RUhcQPPMCx0aAa5W+XW5ljb64OIQ5ny+iEfbVoQZthKBqe+b/GKZQzaYX3Ph/nGEmvFxEUegx3cQcKRGkYAPWl7Hh7X5yovB6D75ORDup0SwkUQJQu9IXUroumVantYCLNq3KlVUAm8obyPCg29Xrnwk9ANrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YahSuAIqLyU+Re/6LyNciNL+sD76EKd1/TY6CMeBuiw=;
 b=b0Q+zioVFhjHU3fg/f5ik3R3OnOqAItQnXIPW+Xr+Zs5R4Jb+8AAZMIEkR0yY3IvRa7G4AQ3w90NU9ndpG7cmY1WlDHHSlftcdvzpkZZ4BfJvW/zCdRAVeJSxSkGPomHureOYCO+40xf4miQ2tOM6AM//WhTrY1tyFulD7vHT+MG7uozsltKfg8kQNkixtZf94/O7fzZdTgTWMTFyiYWIZznXhxkh+87s0MiLYLRSj7se+QDFgaEf7if6X7x3Fz8G+td/BvunSpgV7HLMb/EB5E+Ouw/vIH+kwAP52Xk0iqeRN0UNH6lChHuRmwaUy4RFeQY64ARGThql+fJbsIKIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by SAWPR11MB9898.namprd11.prod.outlook.com (2603:10b6:806:54c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 14:33:09 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 14:33:09 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Mandal, Anurag" <anurag.mandal@intel.com>, "Richardson, Bruce"
 <bruce.richardson@intel.com>
Subject: RE: [PATCH] net/iavf: fix dead store on reset path
Thread-Topic: [PATCH] net/iavf: fix dead store on reset path
Thread-Index: AQHdTMwnymiCsnKYKEukq1j+9CtHnLbfMocAgAAo/9A=
Date: Fri, 25 Sep 2026 14:33:08 +0000
Message-ID: <IA4PR11MB927850A9B5619F4035DF06A58E802@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260925085832.6780-1-ciara.loftus@intel.com>
 <fc8d48f2-d451-4113-8c25-ba1df670cff7@intel.com>
In-Reply-To: <fc8d48f2-d451-4113-8c25-ba1df670cff7@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|SAWPR11MB9898:EE_
x-ms-office365-filtering-correlation-id: d43a302e-9257-4f09-3b9e-08df1b11eb84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|10067099003|56012099006|6133799003|18002099003|4143699003|11063799006|38070700021;
x-microsoft-antispam-message-info: DY8LrL9gUSQEGLu7Xvvif71CzZw0zlnpuboSEd09DKS1QAJQXG/+MlXjFZfxzzYQlIB6uuYpiLNq44yIT0S2fvhQ4ZqRZOJ0DJED170g/HXf2stk3/vfYPscdSXiEuUeNcX3mR4cFjNrN2XfFoUHIOWJimiOF22WCZgpLj9S5U9G80MoazUyzQgXiMaJrq0RUe+w/jeF2g1USzsWrqAZwgyuzSteVSeEfYIXbUgD6OAXspQbPQ/S0v8h2mke/s+8Uo9MW50bqp7yuyklC7VAwUV1wJCbIMSWLk35vdkz4/AMR93Lf7Cb6u16I9vZHR0tOvFG7+yqkrGvKpRfM2bbpd+VaFhuEWyzEHiRcji1s5CyirA/wq0ogGdUgRNo7ivgKZPSf2rutQ1E+oY1nvhW6GsuKPmKZV4FUdOIK4peIPGj4cZJAx/IDnuPHFJXubbJnQELizX0FA4ORM9NYlM23aiQ/ilKOkZ4IMfC8w68csGqUMjMvK804jkE0qS03QPIm4qxq3O46ktmdux3WnXRF8kV7/michGuk3xeYREaxN5CmV3I6K5utjTtSE0LXFvq3JVhBfC42jIf93Fs1sWZ6UcJ5c8ecL2pLNYrdRYl4R4R3Hm2Zu4pHFmfrHyH6AMcEj2ItXj/F3E2ZZG4HYjAqBfi8WUzVZAdPiQev+XVO6uO2rzYSBksU4OiamoLMB0JJjabRt+L6b1q/ZqvwxOd0tInnLn1ihJMxdODKpRCOXg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(10067099003)(56012099006)(6133799003)(18002099003)(4143699003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkFwZUVVZUdLRUZjU2szY3VHYVg2VVd1RzFlbEsrb3NrOEdEbnRnYnhlc0g1?=
 =?utf-8?B?bDNhYXlZYWJhT2J6U2ZYRDg4U3VRd3dOZHRsaVJPY1FIajNRYTFlQWMvVlBl?=
 =?utf-8?B?d0NYMysxKzJUSm1STXFrYnBiZGN5Q0lxTllSekIxdHAzbzJDOGg5aldrOU02?=
 =?utf-8?B?aWJSUVRhVXNkdWdvMlRtQWF3YmowaXhXMFJQKzlvWFMyVEg3WVd3ME5Mbk8z?=
 =?utf-8?B?K3o0ZHhJeXNiRERqUGM1d3kxcXB6K0x0eURlZEJIeXZzZDYwc2lNdDZYZ0lI?=
 =?utf-8?B?TnV2S1p6aHVDd01QS3RrY2EreHI5d0V6MTduTHBrME5LSExqMCtDQTQ2UGJs?=
 =?utf-8?B?eU9PamVjTSsxUjJyZG9NTUlYRFM5SlRLK1pvaVE4NUZJVjdtTWN5TGJGWFNO?=
 =?utf-8?B?OUJkK29sK2szNEoxUGkzRU83SVNzV3dFY2tRcjNZZk9zZk5FUjZXNFJFV29J?=
 =?utf-8?B?YW04dThwVFVjZ09VbHFkNk8xRms5UzNDUjd6amVZQVRBZlIwN1lYVzU3U1BN?=
 =?utf-8?B?WEZZcDdGSmVLNFY3SnFCYWpJR0dlcU1XWE13WFVOR3E4UjZKejFoUXBPN3Nw?=
 =?utf-8?B?L3Y0YTk0Ry9UZkw0NVNmeFp4WXd5VmNKdDZRelc0Wm9nMHo0d3NiUVJYSnFI?=
 =?utf-8?B?OEpTUEczeG9Kd2M5RzVuWEU1eWlGV1pqUzZjL2NCUGFULzZkT2x0TU9sMWk2?=
 =?utf-8?B?RkNUZU9TajU5RTdLQk9PbWlQUEhhdVRNU2xYUUFtVjVyMm9CQXRwL2RIZHF3?=
 =?utf-8?B?L2IybUdaaU1pSlAyVjlsaGxJNEhoNERyWEUwL1p2T1RhN1FCR3dPQ3pTRUlF?=
 =?utf-8?B?SjFlMDlnY0VSYzlNNTZSaHYzRG9odWJBZ3BaWVByZXlwMG9JTDhJZk9zbEIr?=
 =?utf-8?B?VlBwTUlUb0ZabjQvRXMwQThKRE1vb3pzTFNiVmxHWmpGbDZ2Q1p4OUdYQzlh?=
 =?utf-8?B?UFd6ekl2Mlhmc0UyM3VQVllXUGpPUmhYMzZOSUcyY1VjdHE5bDlqYVRBT0cr?=
 =?utf-8?B?dTBQTTVHWVFJUVN3N1hMNmtrRloyQlZ4OTdHUWl1Tm9pbENLQVIvQ0xNUFVm?=
 =?utf-8?B?YVBvOGRIWDdsYXJUUzZneGFKTmxBWThZaG5mQ1NwTUN3SzZpbVdDalE2dG5F?=
 =?utf-8?B?NDVJMjE2bmRUdUlGdEM5Q29LMFhrMlRHdmpyL1hKcjloVzBWY20vdDZlaFNY?=
 =?utf-8?B?MVhvaENtNXRrOStTOGZpSGZ6cWZXYzVJanV4aWs2ZFUrMzlBaHA4TW9sZDJ4?=
 =?utf-8?B?YXh0NXNHZm9ZdVh0N3kxMHFFVC9mbWV0MHZDdkR4dllPTVNWUVJqQjZyLytN?=
 =?utf-8?B?dWlxWXcza1RjbyszZHZZbW1BRTkzR3h2a2UvRXJoNkNaaTFuaHRrRTRWem5k?=
 =?utf-8?B?YW12ZDFveUhTSzZ2Nys3VmlxWmhnZFh6ajNqc1lSUXA1dkZ2YzJWYkV2VlAw?=
 =?utf-8?B?OWkvQVlWS2JFMmNSU1IySGtONmUwci92ZEk3czFLRThkWSt5NWdsOVNNdkhJ?=
 =?utf-8?B?dUNER2ZNRWJMNUR3Ymk0ODA3N1VydnlKMjNTMFRSYXhML0xLMW9ZbEk3dmE2?=
 =?utf-8?B?Z2VKRjI0MEpwVENMWUgzQmFWQzlpeTRET0JWY1FzTkdrM2pDVllwdDNQakEv?=
 =?utf-8?B?d3ZlR3VXbGNpVVpaVkJNMDRuWVpldEpzZkRjSk1mbGZRTjZsa0R6NnQwa0Z2?=
 =?utf-8?B?aHIvZ0xzemVJUi8rVzMvWTFJYytWRGZQcDlST0Z3UW41U21SMXBLMkVSSEVN?=
 =?utf-8?B?NEdLeWhlSGl2cHRtQWZSaDZRYXV6VUltemUzMUsxam5hMWhmaVFWZ1BncnRZ?=
 =?utf-8?B?dDlXMTVoc1Q2MG5jdVlQWE5YZUlZSFVFYmthRldMTVJOTmlNNkpsUHB4dWxC?=
 =?utf-8?B?bmtSREFVUnhDNXh0aTBOWlcycStkSjlwaTJQS0RnOXNwY3ZhRVNydXVYQk9w?=
 =?utf-8?B?Q1ZxZjJ6MUp0YkNrOUlHamhlTUdNNzdkSzcwWVlsRWxuZTRUTktWZGg3Wk5r?=
 =?utf-8?B?bWpzS2pjNWN4ZzhkTWhCWHA0cDV5Z3BmNElqWGh4ZUNza2RWNmZ5T3dmdzlG?=
 =?utf-8?B?amZNU1B1ZmVBc09hTk5YL1EwVWNqR1BLUEF5bkpwN2xVdHdPRmg2alVkWGZz?=
 =?utf-8?B?YWhhbTBTQ1lyRGxvSkJhdy83cDl4bWp5bkRGMWtmR3p3MUZzU3RVQ3VhNHUw?=
 =?utf-8?B?eFpBaWdYYUdSUWl2ZURzTE5vRHBFRjIzaVc4Wit3ZTNzcDlFZ3lxTnlnM2Nz?=
 =?utf-8?B?SXFCc2pkK2M2b0NydjJOU2xZYlFUQTgrRjRTUURvU2xOVGo5dXUvK2xubjN4?=
 =?utf-8?B?UFdxaEpvbVZNKzc3ZitwK1grekR1Rmo4LzQwaU5POGw1c1c0WS9JQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: O6dAfaaoh6GJZXSFXoh7InD1NBkxkmHwfQlZ9PETf9dd1a02pg1ZCI2iRZcaufie5jbLiDkYGTD4ob60p64wxIFHy8wjceslUP9TfaC0ocWZ3vW9oOnR9BV4gAOiGFCSbqIJk0MjxdcKbKNjSiqSjzKmwSbSBbw1SfgQ2nJNkUJVKSSe2Z+uhzStkXrWDsTgwpAJXYUB66V58tHt9nNFkaoqX11zrl0dvKaoaud3pIBeNlA8j52NgUr8bB7B8YNnXxdspCo+XtAFLsyipnQDSC/m5a7SBsQ3CH/rX1revSYQOp7Tvxs2bhHOiAWRHHbEY/y4VZifzy0+5YEi4FEOrw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d43a302e-9257-4f09-3b9e-08df1b11eb84
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2026 14:33:08.9065 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5N6vUmbhNtw3YoN5/C72Hlj/VfiAt9Hw8lZDbEJJ6HmmPxP0komcoD0+ksUrU/cgF03ZLxPtMp58HsRjatqIhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9898
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

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBuZXQvaWF2ZjogZml4IGRlYWQgc3RvcmUgb24gcmVzZXQg
cGF0aA0KPiANCj4gT24gOS8yNS8yMDI2IDEwOjU4IEFNLCBDaWFyYSBMb2Z0dXMgd3JvdGU6DQo+
ID4gV2hlbiBkZXZfc3RhcnQgZmFpbHMgZHVyaW5nIHJlc2V0IHJlY292ZXJ5LCB0aGUgY29kZSBk
ZWZlcnMgdGhlIHN0YXJ0DQo+ID4gdG8gdGhlIG5leHQgbGluay11cCBldmVudCBhbmQgcmVzZXRz
IHJldCB0byAwIHRvIGF2b2lkIHRyZWF0aW5nIHRoaXMNCj4gPiBhcyBhbiBlcnJvci4gVGhpcyBp
cyByZWR1bmRhbnQgc2luY2UgcmV0IGlzIHVuY29uZGl0aW9uYWxseQ0KPiA+IG92ZXJ3cml0dGVu
IGJ5IHRoZSByZXR1cm4gdmFsdWUgb2YgaWF2Zl9wb3N0X3Jlc2V0X3JlY29uZmlnKCkNCj4gPiBp
bW1lZGlhdGVseSBhZnRlci4gUmVtb3ZlIHRoZSBkZWFkIGFzc2lnbm1lbnQuDQo+ID4NCj4gPiBG
aXhlczogOWFhYzIyMTlkYzJhICgibmV0L2lhdmY6IGRlZmVyIGRldmljZSBzdGFydCB3aGVuIFBG
IFZTSSBub3QgcmVhZHkiKQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQ2lhcmEgTG9mdHVzIDxj
aWFyYS5sb2Z0dXNAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiANCj4gSSB3b3VsZG4ndCByZWFsbHkg
cXVhbGlmeSB0aGlzIGFzIGEgYnVnIGZpeCBleGNlcHQgbWF5YmUgc3RhdGljIGFuYWx5c2lzDQo+
IHRvb2xzIG1pZ2h0IGZsYWcgaXQgc28gcGVyaGFwcyBoYXZpbmcgYSBGaXhlcyB0YWcgaXMgd29y
dGggaXQuDQoNCkFwb2xvZ2llcyB0aGlzIHdhcyBpbmRlZWQgZm91bmQgYnkgc3RhdGljIGFuYWx5
c2lzIGFuZCBzaG91bGQgaGF2ZQ0KaW5jbHVkZWQgdGhlIGZvbGxvd2luZyB0YWcsIGlmIGl0IGNh
biBiZSBhZGRlZCBvbiBhcHBseToNCg0KQ292ZXJpdHkgaXNzdWU6IDUwNjE1MA0KDQo+IA0KPiBB
Y2tlZC1ieTogQW5hdG9seSBCdXJha292IDxhbmF0b2x5LmJ1cmFrb3ZAaW50ZWwuY29tPg0KPiAN
Cj4gLS0NCj4gVGhhbmtzLA0KPiBBbmF0b2x5DQo=
