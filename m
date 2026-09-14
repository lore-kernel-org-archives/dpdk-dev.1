Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2654C88E73
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 14:20:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81BC540A87;
	Mon, 14 Sep 2026 16:20:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 5E56A402F1
 for <dev@dpdk.org>; Mon, 14 Sep 2026 16:20:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789395612; x=1820931612;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=D4yDMLDII2AQ3H3r8czxVkp8cWjgK6l8yMm4f48UTHg=;
 b=NXuHtuofBelQ++eHUaT7Mn28UwoRxKVeAxhyUwRggQgDi5QV9FqP7Cjh
 eRJ4Ea+no3mSrNHXymirq7SCUIjttZGt/LLq2948pbsHWzZu9E38TBjM0
 43zn05Yb9LHKALLJxahB24My+c3pihnnNZwgpwudQOqa6SCHXvSJ82CM6
 Nm8alaRZ5CwTU2lJNBG8Y0oC4rB7SfeLB6fdzl0Ic0sTXV/8bjoAtiBth
 HOEQz2Ymc3A0rPZQCX8RlQTgevdkP4rVszjFtWEDSlgfZsvhZbKD1yXMP
 PzeVN2IARzyxWlS1lBXWD0/Rjg7vISeSIo1LgNISKXQCcvcUsEqioY+8L Q==;
X-CSE-ConnectionGUID: XHSa8c6EQoG7ABDAqPeRKQ==
X-CSE-MsgGUID: M7631YRhS1CFKerYWs9hbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="88688073"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="88688073"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 07:20:11 -0700
X-CSE-ConnectionGUID: JLvt8fP+SwaBqLnQu6lqHg==
X-CSE-MsgGUID: Xq81eSLwRvyfDmFpQ1wqMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="296141090"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 07:20:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 07:20:11 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 07:20:10 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.35) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 07:20:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eo9Q21NsSBCgCnG4pBHECqgWBfDeqRQrOrkSww4qErJHa/BFhNI7w2XqRdbWSrW9hodRCDhcF/rtaDpUse3FJo3dgTqlIH3ErrkfJlnIIu1SYX4QIEtb74wJcb2bcleJ6DYTHtZd1FBMTBnMUNqaiSkI3PWgkgRbIAHqYQY06Q1iHP5WAkBV2sih7i5JmHt7gfbGrEibbnaUjsyiosuFSmJ2fFjWfDNJYDyL1mDo1abyJKFXKyuuG3q/qbQ4SzPyBs3nbqLeU+IQmCTVLZAbCWgITe+fVJq2lRsHwI/NyNxiLipFh7h4WFgOkNisWQJ49BCrChNgaXtIIEcQ4Lqa6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4yDMLDII2AQ3H3r8czxVkp8cWjgK6l8yMm4f48UTHg=;
 b=I66oeshJqw9cLc1mwb1fVh5EP9xFwD0n+be+P9IyLq1HSC3xUgsUll2h6HRHwOwrA9XPDZ3mf3rGgW8QAJwZ/A6HjjYvUt+IdT20E77FbzoKxDb0vuzPDmlzjI2/tYYw+ceHTLyK3piWeUrGOKbQonD9TeK1Aqy/0g/MyVE6/xLRB+RemXxhvr3k9OmwuZSlL2i3+NmJ7fcMZhwrR55tz5N2N09gagY1kpTOvcNV8Fbo3uVLZF+lS9VvBc5L+3nuY6exvLAcJJhEitBmpIeMHtpQ5cFRKOnBzC8e4FE81xM1Bk67uxBFXrPy4ywzFevGAcWD8myM5NQ+AY6sYseUfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by LVTPR11MB9912.namprd11.prod.outlook.com (2603:10b6:408:3c6::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 14:20:08 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 14:20:08 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>
Subject: RE: [PATCH 01/13] net/iavf: remove unnecessary alignment calls
Thread-Topic: [PATCH 01/13] net/iavf: remove unnecessary alignment calls
Thread-Index: AQHdQQRozd3VzbihpEaLBv9yEVIFArbOJkDg
Date: Mon, 14 Sep 2026 14:20:08 +0000
Message-ID: <IA4PR11MB92785FF9D79BB6E7B8EE455B8EBB2@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260903170140.360477-1-bruce.richardson@intel.com>
 <20260903170140.360477-2-bruce.richardson@intel.com>
In-Reply-To: <20260903170140.360477-2-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|LVTPR11MB9912:EE_
x-ms-office365-filtering-correlation-id: 88f52ea6-036b-47a1-84c9-08df126b47fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|38070700021|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: HcC+a53JfNxErZvd+rq9U5ocvs9QzagcjHg5UPhxkDurmk03J08OtpugFZzbG251lj9BA2fl2v95rLHL+A9xSkeOVhNHQWWkW58zzj0BfiZamTmriw+9rQgYpSdAxAN0mIDeofp9kNJop1nDP5GqAm110eVCjbjb7EIPXew7YpMZ74SBzku2va5cGYpN3OmfG6AULq1oEUF5jRyLioA0F+9krVXa5drBzCOzgwhdsBYlxXjxqz5+egQiYms5eok6sz+pXu+4ICUIh1QwercrE6wbZqlM31i2808cIWNvoW1GJBYaTTV2Gljh2nsSsSv/H2Yp+ccZdN+F6LD8DGLujWjDTgjJPQo166bxhLq+vyfsJbn7UkOaZ34vjn7jA7nm94EwnZJZ0Rc9E9a1OtYDL8lTrnSdt6Ou/gS5FXpNONH9oGw4VXmWSS4ZMkCrqLodSnEbjxzms13gtxpTl7jk7mzj72xXk9HwZN388VGeGWzAg1MljS+/gEEZ/kp6D9x1bOD8LScEbG0BBX1Jd2CE0QMQ0SzAFM8b1AzBhzUvDYU7jeDlB/v09ZM73GKqqBSsaaaT//5947lKvIBHUTvcbpuCFVVM2g36P73X055icuiyykXB8w/or1YlCQgIjf54oxn7CEYgCYrr4W/ltM8m+DLNhHEi5bV6WYmXXC+vlttlS/RsETvIEvNB4IA3GemAG82XqWLuPw9G/ZvE4rJXhw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlkxUXRQTEc4UmtJd0FrYU1CVDBseHg4U0tiVGkvbjRvNzFBTGRNb2N2SkFN?=
 =?utf-8?B?clVPNTBEWDB4Y3lHOGdMNmhETlJvN1hRaVVrOFI2bG9rdnJSV2xjcU1FNFJW?=
 =?utf-8?B?UXdSRWZBYlZKS3M2TG9lUVJIVVU1Tys3cVR3Y0FFdXRmd3pOaWNRMnh6U1Iw?=
 =?utf-8?B?ai9WVlZEdm5lQXB2cGFCWS91UnV2eHUzTXN1dUYxMFpISEFHNUFqK2N2MGtG?=
 =?utf-8?B?ekhTbUlVUnRyZWtlNXVObmZnOVpuRVF6V0tZVVJ0aEVwcll3K0h2SElORUFJ?=
 =?utf-8?B?clRSaW5OcVh1eGRLYm1rYVRIOWpDRlBRZWlUcHBzT3lWVW9PV0R1alZEZklP?=
 =?utf-8?B?eFVXKzczUWM4Y1BudGRWQmNwTXdwbjZud1dSS3hwMko4Tm9wU0R3Z242ZTZV?=
 =?utf-8?B?ZzNBLzBLTWJvR0JTRmtrNVlTd3dTYjQyNVVFbW5IeFB4cTdUeU5YazRNWDhU?=
 =?utf-8?B?VktXL2k1cEJxR2IvNVZJMkhMcjJPSmNiYnNXYjJMUFhHUG1IS0xVSDhJWUV0?=
 =?utf-8?B?Q1R1UW1SVXlYd1YxQkRBdlRBZk4vMHhYRUU2Q3lUQ3hTYXhNamtmSEcrR1pU?=
 =?utf-8?B?LzFhZ1ZMR08vQUkweWNIbTM4SUoySk1NSkw1TnZ0bWIwVjNjbmFuQ1NOZmdV?=
 =?utf-8?B?dm9sUkcxRzFvNEZpSnpUeE5aZ2lIMXZRMHFnZFhaeE0vQWJka0g0eno5TFZs?=
 =?utf-8?B?K3lZRUp1VWo1eEEvRjN6WTBKOENhN2xYQUN6ek8vYWhFdzdDejJ6YnpWcDN4?=
 =?utf-8?B?TTJ4SnVkd2ZhRUNVeEo2QTBZNWZpbnNCV3FOZkdrUDhRcGtxRlNzWFN3aXB4?=
 =?utf-8?B?Y2VBbEVXaTNGZ3VFejNWMnA1Nm5uVWxOdDRQUXNMN3U0L3RIRjhjZm1QVm1t?=
 =?utf-8?B?OU5qS3pJOWE4OE5OYkY3TmQ5VUR4V20ydmNBMUJxeFFDUjVicytVUGNYdlhs?=
 =?utf-8?B?WTQxSm9WYU53dlBIQWhrWThZNnFPUXRnK2FKdnB4VTZCeXUxZktYTUxBUEFy?=
 =?utf-8?B?NThzSmRsN0NqOXZCRm1rNlkvZlNETGpIUTc3WFJKekVtY3B5TkhOSlJTKzBH?=
 =?utf-8?B?UHc0YVZBTVArZGxPTG1jRkxLV0ttbFVKbmtmUXNUS1JMRy9pQkdsZUpNRVZx?=
 =?utf-8?B?MXhkQWJMbkpMUHdMOEdKWEtTQTFtSW56NFc0cFVwaWRkc1FULzd4M25ERTlY?=
 =?utf-8?B?Tk9jRHNUdDhPM2l1YU1wQ3dJdVhFc2t0dmtEQXdxL1FCK2tGL0g5ZEtlYzVX?=
 =?utf-8?B?Rm55UzBOZ3R6Um55UklHTFFKUkZvQkFOcmpkM3dQWnpFaExtNjhOZGhaMkV1?=
 =?utf-8?B?UnNHWEd3eXQxcW90SDFKa3ZDUzdtcnh2dEVOR2dsUlNpdnhZdER3NEJoUW9E?=
 =?utf-8?B?NXpVR3JrS0F0TmhYbU5aZ3o3WUZIemJDM1QxYWJub2Z1MW5CNzlyZ2MzOHF5?=
 =?utf-8?B?WjFOTldOU09INWtjM016VEhTQlBVNFJvUGhYbkQxS1Ivd29UTkRmNkptZEJ6?=
 =?utf-8?B?S0srYlZYYjcyY3JJb2Y1UFpHMkJXWUFYMU55Z2JxU056Q05FN3NIM25RVldn?=
 =?utf-8?B?Tm01WXBlQzFwTUFLaEw2ejE1SXMwWnZtOUd5QnVrd0xpcmI1TzgybkxwNU1p?=
 =?utf-8?B?NnEvTlRYOHBTV0g1Nm5lNDYxa282ckJRbExQNnVNM0ZyYzFoQjN2MTlOY2R0?=
 =?utf-8?B?VFY3OC8wV3I5VTJ4WU9NOVU4UTZud3A5R2FXOWZQVDVBV2xtVTd5cEd2Wkpr?=
 =?utf-8?B?Tm1XSi9NT0NSZ1dQeVhsSkNEVVFXUHl4YkRSRWkwMTI3V3gxbWdic2hpWHpo?=
 =?utf-8?B?NjFUOVgxNWVtcFVKUjFoNHdQVWpaRUlxNWlRclhNVlJqbVJTbnUrWU9sc05k?=
 =?utf-8?B?cFRyY1NJOFVrSExnQkVGaU9oZkFmV090OWF6TnhBWkQxQ3QwVUxKZm56RFJu?=
 =?utf-8?B?QnBZYWpkdW1qZjZGNHBlUFE3WkZxbW5IMUVNTFBmVnBuS1RWc1lYdGlUWnZZ?=
 =?utf-8?B?Mkdmb2RBdlBDbm9pZHBGMFd0MGkxS2pva0haUW5iY0JMTWdnbHZkdkFzVFpx?=
 =?utf-8?B?SHd1OHJkY0lud0ZZTkQrR3NVVHVVRnR0RFRxM09QSU1LZVRaRWVBQy9GQ0Q5?=
 =?utf-8?B?QlBvVE4ybGhxMncycDcxaWdLNWUxQU9hY1VQOG5XYUFZS0JkRHV3TDV3NHlw?=
 =?utf-8?B?TTZRODJUem83VUs3bUI0M2l1N1ZKNDhNM2dJTU1oUWdvUDVlODErUTkwbVNZ?=
 =?utf-8?B?dHpKVDhnaHA2dDNHbUM2TTFkQUVFUDJPQTVYalZyUkVJYWQzVVY0QkI5RVcx?=
 =?utf-8?Q?pdjL82av7jHVfV/d2E?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JjWA4wj13rjzBhnz3k5iSwa6VzDvLCRvF0SwgD/9O3tUwhbydR7i2vjJQ6K4vFQKTcXBpWJ4eC+xigNFin3V8syjtizl1y1AQwitrOGiNjhf2tCL1ebUv6JDYNWJvjCLIS9txyQfVNM+5tobiVZ2SwwKzwHfGU2XvrKqOrMceELsZ+EuapU6YGDX1qhLPqP7RFpiGqkEtl2I8W8j0qofd4FG21RboEtbBSx8Sms0QBW+AvQ2H334eNlpmkuvuOphHSowNpzz1k6YblqGqtr1UEMZEegAFOjHoX4mJorbEWEMHhz/s8pMcINnjoWTESjnQ0uZ4EG0TOT+YsDF0GfYVg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f52ea6-036b-47a1-84c9-08df126b47fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 14:20:08.7687 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3TtZng81GgdUXiGAzjqvBl5dPyXenAA76j3xzTer6ETQ43DPQ3OTlayBxsLgdhVVsaEs0TAnhZ4aVsf8AkZmOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVTPR11MB9912
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

PiBTdWJqZWN0OiBbUEFUQ0ggMDEvMTNdIG5ldC9pYXZmOiByZW1vdmUgdW5uZWNlc3NhcnkgYWxp
Z25tZW50IGNhbGxzDQo+IA0KPiBXaGVuIHdlIGhhdmUgYSBjb250ZXh0IGRlc2NyaXB0b3Igb24g
VHggb2YgYSBwYWNrZXQgZnJvbSB0aGUgdmVjdG9yDQo+IHBhdGhzLCB0aGF0IG1lYW5zIHRoYXQg
d2UgYWx3YXlzIGhhdmUgMzItYnl0ZXMgYmVpbmcgd3JpdHRlbiBwZXINCj4gZGVzY3JpcHRvci9w
ZXIgcGFja2V0LCBzbyB0aGUgc3RvcmVzIGFyZSBhbHdheXMgMzItYml0IGFsaWduZWQuIFRoaXMN
Cj4gbWVhbnMgd2UgY2FuIHVzZSBhbGlnbmVkIHN0b3JlcyBmb3IgZWFjaCBzaW5nbGUgZGVzY3Jp
cHRvciBzdG9yZSwgYW5kDQo+IHRoYXQgd2UgbmV2ZXIgbmVlZCB0byBkbyBhbiBpbml0aWFsIGRl
c2NyaXB0b3Igd3JpdGUgZm9yIGFsaWdubWVudCB3aGVuDQo+IGRvaW5nIGEgYnVyc3Qgb2YgZGVz
Y3JpcHRvcnMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCcnVjZSBSaWNoYXJkc29uIDxicnVjZS5y
aWNoYXJkc29uQGludGVsLmNvbT4NCg0KQWNrZWQtYnk6IENpYXJhIExvZnR1cyA8Y2lhcmEubG9m
dHVzQGludGVsLmNvbT4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2ludGVsL2lhdmYvaWF2Zl9y
eHR4X3ZlY19hdngyLmMgICB8IDkgKystLS0tLS0tDQo+ICBkcml2ZXJzL25ldC9pbnRlbC9pYXZm
L2lhdmZfcnh0eF92ZWNfYXZ4NTEyLmMgfCA5ICsrLS0tLS0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2Vk
LCA0IGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQ0KPiANCg0K
