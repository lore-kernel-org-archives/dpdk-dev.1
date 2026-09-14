Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98901C88E72
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 14:24:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C976440A87;
	Mon, 14 Sep 2026 16:24:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 43401402F1
 for <dev@dpdk.org>; Mon, 14 Sep 2026 16:24:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789395870; x=1820931870;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ireCoqy9hjR++xNTHc5vJbIt1LO08dSRMWuCdATw2nE=;
 b=jg94KAKEWj9ZflLnRrShyLN08M2bDPz2X0pC1xkPWlgQlsdIt4KWWM4K
 gmrBp3DRFwpTm07TTk/66lpJF9YKy45Cg/8HX+V5PYZ6/0D87ahrJYxkp
 2gsbDXMOLHz4HLit3e7V4PSe78yN8DEug4zHv8z7sxmZLUCBnOiKkoouh
 PiIiFZD/XGb+M7Mo1TFCROq+a3wvDQkC1i2JUR5dAuCw/GjmUdoHsqynT
 V6te8G/9yoqhYVd+gjMR/H9+0OXd1dKghyNKCV1bkNuM6y4I5zwXPTd46
 kLiz+AdG1q2Nz8008YGxdOMztwQPX7jFhNhQVSMoZOYPryLz2WdO4Mi6b w==;
X-CSE-ConnectionGUID: Gx10f21hQDG5ZgfHVqX12Q==
X-CSE-MsgGUID: BCs0iuDUQtmINduVwVkfig==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="89876650"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89876650"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 07:24:29 -0700
X-CSE-ConnectionGUID: oMkWE+6RRzS0i1tMIMf3xA==
X-CSE-MsgGUID: ecjhvY7JRQCjgpGIEWg2vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="276807282"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 07:24:29 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 07:24:28 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 07:24:28 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.31) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 07:24:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FYj/OVjn/+nVzX5vTCeeESkuqKqcM3DesmBxnHPK9NNJ2RpTSXQqACpEzOxnJo2KstCkyfg5wBlxjDYte5wc/dqDWktB9OXEvlc7bqUbmO5XhWkg6mr3kOg6BUOMUorsQG/fZFSGqX0prFJ1GE6pJx7PXsZUDESL9tNqispDXUTm1THnqvRoTSJYzKPgMpS2riHo85sVdn1kFdb5OJxvsrsN7jdQNF3IksnIfuXNA0GRe13IoQEJSMwToV/2knPUsyCQvgyHy+3ZAlFgkavigTTRSk+cC+NrN42YtXM1rnAmaCGL+XG/qRAFE0b7VBKB6aDXAHhP2ldJqXo0xH3Ciw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ireCoqy9hjR++xNTHc5vJbIt1LO08dSRMWuCdATw2nE=;
 b=MB8HV3L7iCz+IW4xf+GW3c0J+gFJqfrtyqMmJHshy3cOszEWo9fzVS43GcUfPypawFSLb4F63eYrswCjd3IsxoawL1gGdA/1GmOfGusktkOXV7cZVuO7xevgg291CatD8WeHYBGtSSknnAYHHnuFjAyf5vJZLAhcs81AjgkyPNpT/JlGeXTCgHp3KMzimCnPw4cYk2qAqpdbtPm0+B77vkJFNU87WMPcNpenatk6xiMqj5fse33eWSmlt/QP4ZM81Ssl1MNEmDaptNZ0HxMC/X9Aa3AOAF7aOn2NMo0JXgDUSHYLJIA+E7iRxr0217dQxk5Vsohm6NlSMsR6kmkD1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by DM3PPFE9E88246B.namprd11.prod.outlook.com (2603:10b6:f:fc00::f5b)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 14:24:25 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 14:24:25 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>
Subject: RE: [PATCH 03/13] net/iavf: use separate params for VLAN and QinQ
 position
Thread-Topic: [PATCH 03/13] net/iavf: use separate params for VLAN and QinQ
 position
Thread-Index: AQHdQQYeDFN2rVDbbkC60fZNKydeDLbOJ24A
Date: Mon, 14 Sep 2026 14:24:25 +0000
Message-ID: <IA4PR11MB92788B8E74D83FA2397C1A238EBB2@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260903170140.360477-1-bruce.richardson@intel.com>
 <20260903170140.360477-4-bruce.richardson@intel.com>
In-Reply-To: <20260903170140.360477-4-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|DM3PPFE9E88246B:EE_
x-ms-office365-filtering-correlation-id: cccd1d4f-f0d4-4d78-73a2-08df126be112
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|38070700021|3023799007|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: azGyyUQtAUySsnDIQcb6VAdYO3EujIw0qnfH5cjGbKoH+aIaOQEQVrPtpdSji2fS5AFZ9KE4H28caMT6fEdiFdYVIn0VcvwJ/hfOjWelOSxNoivvKv2fpwa35zGp/eKeflkJhvG5RCfp153VPX0bBC7ocswNVAd/o0Sp0RcHuNmJ7DcrdPTHkmjEUx+KjFBi8ts69wy664fCsPflTmIRWcqY7cHmATj14ZNLObncVu9I73sb7E67hGfxjGg+bBqMAor4WNDDXINH8zKrwaPfG0YxGGUzGhF7pyP89FUU+MSmluZmtIR/hKtb3jw1/Rkc0Y1rmaSOU0z1ulsjvGzUsaG/guY5NRCGVh56m23zmh3vVY2pQhD9QaiT4ZKgS6/pwAubba8b/89R2w+babRnWBrWstM/KFX9m4x+zOI7WRonW8W3q10S3A5hUK5qBtbNp6JfxxW09P98ZPR280MX/SejCX7+nbCXUAvq1tRiHoeje6fXiDJTHb9yyJ/3mDnkCphv+sr6PceibDMxodH/4RGt0f/lxTmTx03D8yjE0ZvL0QUNdUbZNPV6FCwBPEGZbfS5+D5GLg1pwz7DMEuo/zOtArIpkx+K8QK5DYH+0o3Fq7vjaOW7QOVEJaXNQXkwImzZI+xer/41IG+5QMrpFnB8SBQ6S9xrmdIxYZt/F0yOGuaz0j8aT8PR/fws0Q4VyUJt2SEELgVU9kQ2PETRKz9V0jbobaT+ychqwdhBv84=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(3023799007)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVQ5QXZKdUtQVEJ3bWwrRFJKM3laYThhY0hNUVRiZG5KQ1NTR3h4YzRUSUxK?=
 =?utf-8?B?ck1OakdVdWVSNmh6NE9ldFZoWmNta2s2MWpTbmZJdm1wclpmMHNzNWhUbmtv?=
 =?utf-8?B?bkFQWjJXd2JLUjMwcEZtR0lEOFNheEJEVHVvUmdvVkQzbi92d3BqVGNLYlEz?=
 =?utf-8?B?dnE5dkc5ZG5MNDBuNWNYUktkdk1HZU9Yd0dTbFpoaFhWWkt3ZjRkWkZrNXYz?=
 =?utf-8?B?V01XQkRLelJ6MWozb1I4aitxYzhjZXZwOWZCbFZIVXdQZ21VeFgwYVZDL2tY?=
 =?utf-8?B?aStZZWQyeis5MWthajViS0tXTy9Va0ZNZGRCay9wRjhqMUNGUlQ0UnBKRXRM?=
 =?utf-8?B?bjAyM0ZxQ1RoYkNmYm5TNitBK0hvMklSWUh1Q0k0ZFdxWk9Rd0RqeWk5U1hu?=
 =?utf-8?B?OXR3eDZ3WkdDWDhIdUNSYWl1MTFkTnQ2RkxMSWRPKytVT0F4WXNJeVF4dmNJ?=
 =?utf-8?B?VS9hSnlySnFxS1RLVDZFRC9pV1haOVJsSjZmdk1FY2pFZDVrNmdsSVJxdmt4?=
 =?utf-8?B?SkF3SVAxVG10bXFydG5aSXRkT3pBUnljNUhyMGw2OWxFaDlZbzB4MWZKQlp1?=
 =?utf-8?B?VGM5S2JtUGgvemc4aU01dytrYkFKL1hMYXdvRFpQejdJMVA3Nkdma0I4TjFj?=
 =?utf-8?B?b3kwMG1paFlnRFQyNFRBdndHODhYSCtPYWJmbDVFNVQwL1dCWTRpSER4RmtE?=
 =?utf-8?B?Ri92YkNhb3ZwTHJ5dGNqMFp5VUNuRk1tLzJ1eS9xazVzUnd0K2J1VnpKVXYz?=
 =?utf-8?B?V1FXQlRGQm1QMmt6Z204bStzcjFneFAvRG0yRFZjZEErS1JtYlRHZTdXMW45?=
 =?utf-8?B?YXV4QVhxeGlhOUdVOEliMlJtRWxQd3dqNUtLb0ppckEwUThyRE96bG82dnhn?=
 =?utf-8?B?aWc4aFl6VjVHTTU3WGlTS2l0aGdyWDlEdndhZ3oxNVJSYWNKS0NCTkNqay9O?=
 =?utf-8?B?eFhIME85cXRGZzlGN0IyWjNKdUJFaUxYSXFRUXpUMGVXamdRYTBUOUUzS1dQ?=
 =?utf-8?B?WnVyV3JMUE0vTnMySytJd01IMnZYTU5OSmF0V2plUXZrNTJqWXpmNUdyUTNO?=
 =?utf-8?B?RzRoQkM3am9xZDMyTVdqM2pkNzVZL1oxTVlIRm4yMVNibU14UTA5MDY0ajBt?=
 =?utf-8?B?U082VW5OSm9QUmJKN0ozV1RqbU0rVEFZa1dwcTZMQzlWNnFETGRwWnFqbm9o?=
 =?utf-8?B?N0VPMTJrT0dEL0wyZ2hrcGUwSksrN1IwNCttMGZjc3JVUWRPQTc2NjIrVlVl?=
 =?utf-8?B?YU5UMVZGa0o5ejRMUDkvMjVoejUxNUFWS1dxWVk4WVI2L3BtMWFvUEV3WTI3?=
 =?utf-8?B?NHlpOUZKU2wwQnY1di9jc2grbjk0Q09EaW9rR3ovblR2MldxUDhGeDJOMTRy?=
 =?utf-8?B?UjFWSnJJTC9DT25SVWRxcGZJZnA3SU9zS0pRQmpWY1Z1SVNTZnZPaGszRlZu?=
 =?utf-8?B?VVlacEpzMHdOb1F2aTM4NDV0SGNOSG5VSmJnL2x6TTZ0d0JSVENtSFYxMlgz?=
 =?utf-8?B?ZXV1RzBkYzVHSGl4SGtaY1dmbUl2cGg1S1ZnNUxNS3VkOUcxZDRiS2hvOEdQ?=
 =?utf-8?B?SjdWUFcrdVdLN0U5ZXdLRWVCc3dxc2gxay9xQ1RjaWYzRDNMenFteXpjbDY5?=
 =?utf-8?B?cnRySmQ3akU4WnJsL1ltb0JNTWRjeFoxTDl5MUVhckgzN0dGZ2p5aFV2Z0RC?=
 =?utf-8?B?dnlaZFhwVG1wS3NLZGx6V0pPRHlCbFF5bGc1eFpHaWJnNGVMdHVsTzdLOVZo?=
 =?utf-8?B?dUozYlB2c3R1YWJhQVdLK2oreDNMSFVFK0ZKK3VrMng4by9WendRclNLaEpz?=
 =?utf-8?B?TGdta0x5dlZwMWFVVnd5Mk02SU9CK3dGVTVnenlGdWRXclBhR2RQRUpDTUV6?=
 =?utf-8?B?b2UzQy9nWnlJYWhjb1p2OXp5ZFRmd3E2TUtMTHR5TkYwcWE0V2ZuYmdzR0x4?=
 =?utf-8?B?U3R6Z3JUcUtrU2RZM05GejRwUVd3YXFsdS9kbjlSNzUzaUcyUFdZYW5BN2Ns?=
 =?utf-8?B?YUxwRWg0ajRla1NRQXVTRUljOWI4T205a2tPYnh6RWV4Q2Y5UTRWenliY0pL?=
 =?utf-8?B?TGhXSW9ZalkyQ0F5MXZpelJ5OHR3TGtjSVBxOUtGczFRV3prMDJuT1hXMDQ1?=
 =?utf-8?B?Z0FScGI2L0pka3doSkVpTGY0SVZyWkgzZElRcXBlK0RIdENqTzRVSnpPbjRp?=
 =?utf-8?B?dDVtVFJCVEYvb1Z0NW5ZYzFiVkJmNmEwT0pzeFBYbFNkazBMaWNOUUFQM0RD?=
 =?utf-8?B?WFIxY0JHaDFtUVI0clcxL3NRSEo5M0QrYld2VGorbFZvczlYLzlSdHBDYTh4?=
 =?utf-8?Q?tdDpIbvBl4Suf0E1V0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: i2adao9LXrnnd+Caym1g0TLTQm5HidN0uCcnv4dmZ1fxuucGj6cNyLB9IOYUG7KTpyGaUmKGVnPTwoEuDjrJj3OY0iHvVIYZGgQAlcPT72zlniOJEHe5Xll6u6gE4FJDhPBhW+E9hoUaLElgQlAuCTD13NkpzaPgTqB68nhhThSj7dNcFXaWnicrhPCJiFuA2x+Dx7gZNheYKOjRMgrBaJG4/8MN6cVxhDTw7i/VAX/w6Rjer7jo/Q05+ahgnGg4yadZUk4AyNBH92ARyxD5ap5289rPZYHdG6tYYBRVjNVzeT1hM1cBhRJTwAbqCXYsAO0AiRAeWEBGrlLqyZtKeg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cccd1d4f-f0d4-4d78-73a2-08df126be112
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 14:24:25.6625 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UpI+6giXksAGfGaEmjcErsQqNIVcw/XN4puJyOsOPfKIo2tyxyGKkZcfRipA8s0ekYeiXHiGdmmlYyIVX9DhiA==
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

PiBTdWJqZWN0OiBbUEFUQ0ggMDMvMTNdIG5ldC9pYXZmOiB1c2Ugc2VwYXJhdGUgcGFyYW1zIGZv
ciBWTEFOIGFuZCBRaW5RDQo+IHBvc2l0aW9uDQo+IA0KPiBMaWtlIGlzIHRoZSBjYXNlIHdpdGgg
dGhlIHNjYWxhciBwYXRoLCB1c2Ugc2VwYXJhdGUgb2ZmbG9hZCBwYXJhbWV0ZXJzDQo+IGZvciB0
aGUgdmVjdG9yIHBhdGggdG8gZGlzdGluZ3Vpc2ggYmV0d2VlbiB0aGUgcG9zaXRpb24gb2YgdGhl
IHNpbmdsZQ0KPiBWTEFOIHRhZyBhbmQgdGhlIFFpblEgb3V0ZXIgdGFnLiBXaXRoIGlhdmYgdGhl
c2UgYXJlIGN1cnJlbnRseSBhbHdheXMNCj4gdGhlIHNhbWUsIGJ1dCBvdGhlciBkcml2ZXJzIC0g
d2l0aCB3aG9tIHdlIG1heSB3YW50IHRvIHNoYXJlIGNvZGUgLSBoYXZlDQo+IGRpZmZlcmVudCBw
b3NpdGlvbnMgZm9yIHRoZXNlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQnJ1Y2UgUmljaGFyZHNv
biA8YnJ1Y2UucmljaGFyZHNvbkBpbnRlbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvaW50
ZWwvaWF2Zi9pYXZmX3J4dHhfdmVjX2F2eDIuYyAgIHwgNjQgKysrKysrKysrKystLS0tLS0tLQ0K
PiAgZHJpdmVycy9uZXQvaW50ZWwvaWF2Zi9pYXZmX3J4dHhfdmVjX2F2eDUxMi5jIHwgNjIgKysr
KysrKysrKy0tLS0tLS0tDQo+ICBkcml2ZXJzL25ldC9pbnRlbC9pYXZmL2lhdmZfcnh0eF92ZWNf
Y29tbW9uLmggfCAxMyArKy0tDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDc5IGluc2VydGlvbnMoKyks
IDYwIGRlbGV0aW9ucygtKQ0KPiANCg0KPHNuaXA+DQoNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bmV0L2ludGVsL2lhdmYvaWF2Zl9yeHR4X3ZlY19jb21tb24uaA0KPiBiL2RyaXZlcnMvbmV0L2lu
dGVsL2lhdmYvaWF2Zl9yeHR4X3ZlY19jb21tb24uaA0KPiBpbmRleCAxZTljZTkyNGVlLi43NDQ0
NmZjZjRhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9pbnRlbC9pYXZmL2lhdmZfcnh0eF92
ZWNfY29tbW9uLmgNCj4gKysrIGIvZHJpdmVycy9uZXQvaW50ZWwvaWF2Zi9pYXZmX3J4dHhfdmVj
X2NvbW1vbi5oDQo+IEBAIC0xMjEsMTQgKzEyMSwxMyBAQCBpYXZmX3R4X3ZlY19kZXZfY2hlY2tf
ZGVmYXVsdChzdHJ1Y3QgcnRlX2V0aF9kZXYNCj4gKmRldikNCj4gDQo+ICBzdGF0aWMgX19ydGVf
YWx3YXlzX2lubGluZSB2b2lkDQo+ICBpYXZmX3R4ZF9lbmFibGVfb2ZmbG9hZChfX3J0ZV91bnVz
ZWQgc3RydWN0IHJ0ZV9tYnVmICp0eF9wa3QsDQo+IC0JCQl1aW50NjRfdCAqdHhkX2hpLCB1aW50
OF90IHZsYW5fZmxhZykNCj4gKwkJCXVpbnQ2NF90ICp0eGRfaGksIGVudW0gY2lfbDJ0YWdfcG9z
IHNpbmdsZV92bGFuX3BvcywNCj4gKwkJCWVudW0gY2lfbDJ0YWdfcG9zIHFpbnFfb3V0ZXJfcG9z
KQ0KPiAgew0KPiAgCXVpbnQ2NF90IG9sX2ZsYWdzID0gdHhfcGt0LT5vbF9mbGFnczsNCj4gIAl1
aW50MzJfdCB0ZF9jbWQgPSAwOw0KPiAgCXVpbnQzMl90IHRkX29mZnNldCA9IDA7DQo+IA0KPiAt
CVJURV9TRVRfVVNFRCh2bGFuX2ZsYWcpOw0KPiAtDQo+ICAJLyogU2V0IE1BQ0xFTiAqLw0KPiAg
CWlmIChvbF9mbGFncyAmIFJURV9NQlVGX0ZfVFhfVFVOTkVMX01BU0spDQo+ICAJCXRkX29mZnNl
dCB8PSAodHhfcGt0LT5vdXRlcl9sMl9sZW4gPj4gMSkNCj4gQEAgLTE3OSwxMiArMTc4LDE0IEBA
IGlhdmZfdHhkX2VuYWJsZV9vZmZsb2FkKF9fcnRlX3VudXNlZCBzdHJ1Y3QNCj4gcnRlX21idWYg
KnR4X3BrdCwNCj4gDQo+ICAJaWYgKG9sX2ZsYWdzICYgUlRFX01CVUZfRl9UWF9RSU5RKSB7DQo+
ICAJCXRkX2NtZCB8PSBJQVZGX1RYX0RFU0NfQ01EX0lMMlRBRzE7DQo+IC0JCS8qIHZsYW5fZmxh
ZyBzcGVjaWZpZXMgb3V0ZXIgdGFnIGxvY2F0aW9uIGZvciBRaW5RLiAqLw0KPiAtCQlpZiAodmxh
bl9mbGFnICYgSUFWRl9UWF9GTEFHU19WTEFOX1RBR19MT0NfTDJUQUcxKQ0KPiArCQkvKiBMMlRh
ZzEgYWx3YXlzIGNhcnJpZXMgYSB0YWcgZm9yIFFpblE6IHRoZSBvdXRlciB0YWcgaWYgdGhhdCdz
DQo+ICsJCSAqIHdoZXJlIGl0IGlzIHBsYWNlZCwgb3RoZXJ3aXNlIHRoZSBpbm5lci4NCj4gKwkJ
ICovDQoNCk5pdDogSSBmZWVsIGxpa2UgdGhlIHNlbnRlbmNlIGFmdGVyIHRoZSBjb2xvbiBpcyB1
bm5lY2Vzc2FyeSBhbmQgc3RhdGVzIHRoZQ0Kb2J2aW91cy4gQ29kZSBMR1RNLg0KDQpBY2tlZC1i
eTogQ2lhcmEgTG9mdHVzIDxjaWFyYS5sb2Z0dXNAaW50ZWwuY29tPg0KDQo+ICsJCWlmIChxaW5x
X291dGVyX3BvcyA9PSBDSV9UQUdfSU5fREFUQV9ERVNDKQ0KPiAgCQkJKnR4ZF9oaSB8PSAoKHVp
bnQ2NF90KXR4X3BrdC0+dmxhbl90Y2lfb3V0ZXIgPDwNCj4gQ0lfVFhEX1FXMV9MMlRBRzFfUyk7
DQo+ICAJCWVsc2UNCj4gIAkJCSp0eGRfaGkgfD0gKCh1aW50NjRfdCl0eF9wa3QtPnZsYW5fdGNp
IDw8DQo+IENJX1RYRF9RVzFfTDJUQUcxX1MpOw0KPiAtCX0gZWxzZSBpZiAob2xfZmxhZ3MgJiBS
VEVfTUJVRl9GX1RYX1ZMQU4gJiYgdmxhbl9mbGFnICYNCj4gSUFWRl9UWF9GTEFHU19WTEFOX1RB
R19MT0NfTDJUQUcxKSB7DQo+ICsJfSBlbHNlIGlmIChvbF9mbGFncyAmIFJURV9NQlVGX0ZfVFhf
VkxBTiAmJiBzaW5nbGVfdmxhbl9wb3MgPT0NCj4gQ0lfVEFHX0lOX0RBVEFfREVTQykgew0KPiAg
CQl0ZF9jbWQgfD0gQ0lfVFhfREVTQ19DTURfSUwyVEFHMTsNCj4gIAkJKnR4ZF9oaSB8PSAoKHVp
bnQ2NF90KXR4X3BrdC0+dmxhbl90Y2kgPDwNCj4gQ0lfVFhEX1FXMV9MMlRBRzFfUyk7DQo+ICAJ
fQ0K
