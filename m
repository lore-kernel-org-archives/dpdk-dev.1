Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7A5C88E73
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 14:25:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B6C340E15;
	Mon, 14 Sep 2026 16:25:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 06D2A40A87
 for <dev@dpdk.org>; Mon, 14 Sep 2026 16:25:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789395932; x=1820931932;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=F804bj4N2uqEYTQizY1ytUpPYKQkVSBrv/T1kO+t+aU=;
 b=ihuT7K6mHsR/rKHxe5h1+uOQXXQDZDSS/3Exe1OsYSUJuqjmQIndvlB5
 jnRzbb95NejiA3Aav9hDVbNq/upF6ec/hl9rODl/rGc1cjM9LSbT03K8g
 XYf2SrFHaVQ6KNKvHCnsuyzhroh1s53m2+VK03lusMJ99PoKtz8NWP/6D
 19SXPHOXMUOFlcSeMD+lMeqW0bqLnj/yrg815rNGhHl1PrDwBbYCDoIys
 hkr5p9Mmwe4WiedE+tfuJUZZ/9EDbNuFE504h1FMnzN6/pN3s56GFxZPf
 +Mat3mOJtRppA6NIQB1XO90uquVgze7QnG+l+6WC5OK0Y8TiHZnKeFGdV g==;
X-CSE-ConnectionGUID: Vy3W/6Q5Q26cfY9+LiLTnw==
X-CSE-MsgGUID: 3Ugzq5JuTnOnVzmcZT9UcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="89876768"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89876768"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 07:25:31 -0700
X-CSE-ConnectionGUID: EVogIHFGQAi7SsQaJHEZLw==
X-CSE-MsgGUID: zzSYkTF4TrSs07RkJYLuFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="276807397"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 07:25:31 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 07:25:30 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 07:25:30 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.47) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 07:25:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Klu9rnP3Ue/PQNbtydnF2nL9dc9yXkMPPV759iP5K7wyD6t7YQylAs6Ire3vFw8q4V6cCZFen0rGLHHz0sAvBrVia1/v1DkugO43AxgmbK+rC5C1NZ2YU64mETnacfrw7CsQRV5KcpOoxTIELSTk0CvvQBaouNRxKPx5dsuv3YyIq7K9Y8PZ4/3kBPffIEIPnXII+v8o1c0PjplUwGC4BrJjkoqcVDQqAI7Rl6rf2T3eIsFyf7Ye9uQbpsoonOF1QRtP/ZDSm3TR9kw1eCcWaw8gytSvogzhQgfPa7yz7B/1w2/tfyGQeUc3W7bHoTlUIzqJmvyYl6S8MQkFCLXSzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F804bj4N2uqEYTQizY1ytUpPYKQkVSBrv/T1kO+t+aU=;
 b=g+I/yrD5EROTjs4vmBgQ6jaIlsIPQXjGeIQHilUY2v6fpZ+Ve04NcXL6WzmGKpcQJzyv6o0LhFGTfyJr9k4E+ZZnxV7BrfviAT5LjMGT35MqUv5tqVE15dR2oDhj1vdsBGU+NnoaChOOhHva/wNRsgvc6rypeaRPuzlv3I/SGPnaGAPrw+C2b7HUgO01swEnI7NynhvxaKsDWVhoTeGL76g2Du7l5zkziYRZjtZ2ge+Q2w9qUP7rdSCqNz2gqYshafYlzUMNGMvLOX1B2aFM1TX53/lfxQmfVHtTLJqQ99OkxP3/QkOPcl8x+pkMwbHnfXG0KRoQWGfvONTp9IRRtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by DM3PPFE9E88246B.namprd11.prod.outlook.com (2603:10b6:f:fc00::f5b)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 14:25:25 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 14:25:25 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>
Subject: RE: [PATCH 05/13] net/intel: define common macros for tunneling
 bit-shifts
Thread-Topic: [PATCH 05/13] net/intel: define common macros for tunneling
 bit-shifts
Thread-Index: AQHdQQa6FwrgCnmNw0KpsrW9J0JlwbbOJ7Vg
Date: Mon, 14 Sep 2026 14:25:25 +0000
Message-ID: <IA4PR11MB9278D0DE7FCDB29E4EE3030E8EBB2@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260903170140.360477-1-bruce.richardson@intel.com>
 <20260903170140.360477-6-bruce.richardson@intel.com>
In-Reply-To: <20260903170140.360477-6-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|DM3PPFE9E88246B:EE_
x-ms-office365-filtering-correlation-id: c9736e99-6975-46b4-92c4-08df126c04ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|38070700021|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: DhY1YcowOHY17xUmxYCRUhwJM8oVIq6ZVyfHDWh7xIPT0xISFQqU2HeTK+hhMrbDLvJJkXj6G8J/FX8WFt7q/tr+40gNIDWo3Vo0wCQ79XYDSUF8PCJnKBIp8204PnRlkrQvn7EvJtUzKSKYc8Z3um8G/yWrSUVHncMYG53d78IDHNwOK8yE0V+sggXT2Mub09l/q7xmFsWWFx5nc7j5uid9sSgI0n5Ey36agAOa0fYGJgaHkHWHBfUTrgyZhUUpW/EQAakqD+HhEded92fmeZJM+vhRzqwtqrpH+/e+ENvn5KEvLhr9WaLcWvZWBoFv1LuIbLS4TCGFwZms9kvMkGD24p7V8AyBrRJ63Rm5Yxhb9aRN0uBNAaJ0P7rYziNL8MbYXO4zWjNSQBWEWKqZdiJFbv57+nXrFZHPHyv+Y3cJegH1qX8VwI/qyVDRJrWyXqMOEhfMm2zY6TZpG7x52LHHHdB3xwmqFZAROY5Cqcm+kGNkGzr+Ky+PDi11y4rPt9hbA3zxReHHAm6qTvFnHLgyKyvOT4F5OZnkRIbriTb0Fc7i1i2SRdBlb4L2PvB5TK46CGw90bxs8FwYcFG9mZkURRi7lhV87UU2PGqvHrQjrL6iWycgnPHTI9od0m5QDXcG1Ld9iFP5HYMdD/mKuBE4m6yM0dSlCrYT0fwlwGW+YE4/xQejn0URKi3BW/XF+Qat2R6E6F67klwXcMhgmhH31oAYoDGOSAsfEsTQyi4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MlJ6c1RVQnZNek9wcDdyVlZXMit2b3VnbzRSak1JS1M1NDM5UDVGMm9NRUNO?=
 =?utf-8?B?dE5CK3h3VGVLVWFtdDZLRjRyT2k4cUowa2o0SUZ6UTVHdnA0Q0NYMVE3SHc2?=
 =?utf-8?B?di93STdMM3ducDJRcEFNS3A1NUxvbEYwSENiZUZJK0dXdlFCTjQ3NGJxaWkz?=
 =?utf-8?B?UkVkOTRHVFJBVGVGUzhFaTZ2VnllTFR3aHBQMHZFZktpdWltVzE5ZXI2bU51?=
 =?utf-8?B?emJzR2NwU2JlbVNPbW91SExMVS9xQWJJV3RMeSt6eDRhNTFHR1g4T0lkT0lh?=
 =?utf-8?B?ZlNPSUZYc0ZzM0FlWGVOM2ViVVc3OUZ6WkxrU3Nobi94TDBTRmppekQrc3JB?=
 =?utf-8?B?RnN3NjNWYkpXVmVnMXJxTncxYit5T3dQaFZ2Mk4xTEJUbW1vK0Rmd0I3dDlz?=
 =?utf-8?B?bmVVWTJ2dTN3ZWl5TzZzaXlFMXBYbEN2d1YrZzhZNWtrWW9TVER6RFpwQ2Uv?=
 =?utf-8?B?U2VKeElxbkRUOGJUUkFHRk5NVjlaOU96UmpRaTlMeWZHc1F4dERSRXlNMWJq?=
 =?utf-8?B?V1FuUW9FVnVkL0NYYjJIc2xtL0FyS3BLZTJCUlhLWHg1VFhuOUJTOWNwZ3Z4?=
 =?utf-8?B?Q2k0Tk4zZjNBV2ZGb2xOekFuM2p6T29OOWlvd052SFE5TExZVXc3M0M4M3lO?=
 =?utf-8?B?eWhtKzcycHJpcmlOWnhXSWVvYnV3dnlQUjFtbjFEaG1uMitnSEJrMkFlc3M5?=
 =?utf-8?B?SWh1WDdlNE0zVXBOQTdlTk5CaWY3V1kvVk9ZK0dzT2EvV1pEU1NsVld4RVY1?=
 =?utf-8?B?UjF5d0dkUTFjRXV4TGNVemp2OUpiMkpTMnRBS2sxUjRYYXAwY0svc1ZPdG1N?=
 =?utf-8?B?NDNxb0RjNHg4VjRLMSt6cm9MNTEwUUZBYzNod2ZSN1JtRXdGMlVrTE1YYUVo?=
 =?utf-8?B?OUpuU2t3bE5YTmdoeUZvUytSbXhNTWdlYy9vZUhDQjNuQlRzZ0dXaVI3bDRp?=
 =?utf-8?B?NjVaTTN5emd3cStOTkZuc0p6blBUN2QxZThYUDQxbWFVVTFZSjIyS2ZuWklR?=
 =?utf-8?B?Si84K1lKZjJTcFo3UGRSL0t6WVJZcHU3QkR6N05UdGd5LyszQ2dDU1J2S0Zv?=
 =?utf-8?B?VG80WFllUm5PWEQ4b05SVXo1MkkwNVpJb1l3cVVwUVZ0S2pIR3NqSWsrTkhw?=
 =?utf-8?B?NEhId2wxODdDWXBmTGppQmNwcG52bXpmT3d2ejJhSFh4TmtNOHhXRWUycnRK?=
 =?utf-8?B?bU1INGZkRGpVdHpIOU9manZTdXE3UFY4VkIrS2pIK1l3Yy8zME5RTm0zc3U3?=
 =?utf-8?B?SDJ3NlpZQWRYZEhkRXpLS3hJYWZNOVh5WGl5ckdEakdGMzhGVnFBYVVSSk01?=
 =?utf-8?B?SlZMbEM0SHc4b29mZEtuWGc2WXJNMjcvRFN4d1BUcHl3ZVhhUE9ueFhsUDJN?=
 =?utf-8?B?V0NNRFEyYk5rS2lEcVNxSSs5ZHhPemFDd2JnOW5IcFRlV3Uxc1AxM2pxdXUx?=
 =?utf-8?B?VDBZU21qdE4vWWZ0NFZWdlFjWjlNNXM2TlRZQUlBYTBDaTg2MjRWNkNNQ2NN?=
 =?utf-8?B?TEJDeXNOM2VJZnZkVjR0MDFuRlhWYnRmR04vRGtTVW5Pak9vUWJuQWZuOGk4?=
 =?utf-8?B?aURKc3RpMkoyL2JWMG5LeXZvS2JESGpWYXBuQnp3NVRCdDVYc3ZRN1NqZ2Qz?=
 =?utf-8?B?R0RxaVNtaklxZW5zdkwxa0dFN2pwcUhGSGRiOUo3S2l1QXN2NjJVWUZYQnc3?=
 =?utf-8?B?ZTlyRm43VEMxclluZ25GeXA5V3IxcCtiODdHNkYrem82WnNZY3JiV3AvcjJh?=
 =?utf-8?B?REZxQlIvSXlINVdJd2ZmYzZOK1B2M2tDN1gyUVRDNnNoSUZyQ2F6bDdPcDVr?=
 =?utf-8?B?TnlaeXBoL2F5UWliS2xSUjVsVnEybmZDK1oweCtkbjFkM0JqYnQzdWZQMnlH?=
 =?utf-8?B?bHJvOGVOS08rY0lRVWFQMXNwYkluZitELzI4RDJ5bHNBMjU1ck5lMmgrcTI5?=
 =?utf-8?B?VVlmTGlkdmZqNzFuTXQ5dkJoTlBhZ2xNSG4yUTdPbjVCM3p0VHhLbFVJNlIy?=
 =?utf-8?B?NVpqQjk0ajduVS9SMVVDYWZGS2c1M1EwbnkrU3pzcExsUXZKZGpEWjJKeDdp?=
 =?utf-8?B?RlgvYnlwcFJKd1V0S1hPSGtvNTRPV0NKU3ZIYTd2MW1QL25mMXQrYS9OaUl2?=
 =?utf-8?B?QkRUWVREckh6MmR5bE9CblVQc2lmS2V6QSt0TmxSZTdrdW95aDhPM2NoU1ND?=
 =?utf-8?B?dDBGQkNHSk1kRlArL0t2b2JJOHliZ2JLYkZlaHBjY2RVN29hK2hBQ3FFc01G?=
 =?utf-8?B?cFd6enFma0VpeDMvM1ZVRDhMcEh1VFVEZGwzZzM4UlloV2ZmbDRpWVhaemU5?=
 =?utf-8?Q?vLQlHPMv4fFSVsSdd5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YAvnelt6ki9QyEGVWi8Xr4TyA2x6zns1h7UnGvIbZjyvbI+SKMA2ov1udSINIoNqRk/Ql+sfqNvDgnlrWXB9cp4E/pEqNLeA0gwxBaIWHifm8AseFtbAyRNhRT2Q8aisJvWl5/7MLClJnCkcasVCvufpglbMCLlxW4KH0iPXr5cZOgfBlZomI5uTFdVr+QkkSfmM8fLgMcjOJEH5DbHaEjT3MyKsYop6hDwJDaQgeHJu6vGqogvaZnq8+1WVIQdebOJvOZGftiBQEt1UJZ43Mk/zy8FaccPAVYeFFtRnnX6oHwFvbB64tFWGr0vLpowCk9kDfH6IPmXwJA4MdIlnAg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9736e99-6975-46b4-92c4-08df126c04ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 14:25:25.7977 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +v1myng1CTeuB2geSaNozRoS1hcZZx7OK+4WsKA2G3XQmwJkfbLCXnujz+JCJLsU5cVvRerv9yzlile3eazkng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFE9E88246B
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

PiBTdWJqZWN0OiBbUEFUQ0ggMDUvMTNdIG5ldC9pbnRlbDogZGVmaW5lIGNvbW1vbiBtYWNyb3Mg
Zm9yIHR1bm5lbGluZyBiaXQtDQo+IHNoaWZ0cw0KPiANCj4gRGVmaW5lIGNvbW1vbiBtYWNyb3Mg
Zm9yIHVzZSBpbiBpYXZmIChmb3Igbm93KSBhbmQgb3RoZXIgZHJpdmVycw0KPiAoZnV0dXJlKSBk
ZWZpbmluZyB0aGUgc2hpZnRzIG5lZWRlZCBmb3IgdHVubmVsIHBhY2tldCBUeA0KPiANCj4gU2ln
bmVkLW9mZi1ieTogQnJ1Y2UgUmljaGFyZHNvbiA8YnJ1Y2UucmljaGFyZHNvbkBpbnRlbC5jb20+
DQoNCkFja2VkLWJ5OiBDaWFyYSBMb2Z0dXMgPGNpYXJhLmxvZnR1c0BpbnRlbC5jb20+DQoNCj4g
LS0tDQo+ICBkcml2ZXJzL25ldC9pbnRlbC9jb21tb24vdHguaCAgICAgICAgICAgICAgICAgfCAy
NCArKysrKysrKysrKysrDQo+ICBkcml2ZXJzL25ldC9pbnRlbC9pYXZmL2lhdmZfcnh0eC5jICAg
ICAgICAgICAgfCAzMCArKysrKysrKy0tLS0tLS0tDQo+ICBkcml2ZXJzL25ldC9pbnRlbC9pYXZm
L2lhdmZfcnh0eC5oICAgICAgICAgICAgfCAzNCAtLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICBkcml2
ZXJzL25ldC9pbnRlbC9pYXZmL2lhdmZfcnh0eF92ZWNfYXZ4Mi5jICAgfCAzMCArKysrKysrKy0t
LS0tLS0tDQo+ICBkcml2ZXJzL25ldC9pbnRlbC9pYXZmL2lhdmZfcnh0eF92ZWNfYXZ4NTEyLmMg
fCAzMCArKysrKysrKy0tLS0tLS0tDQo+ICA1IGZpbGVzIGNoYW5nZWQsIDY5IGluc2VydGlvbnMo
KyksIDc5IGRlbGV0aW9ucygtKQ0KPiANCg0K
