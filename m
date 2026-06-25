Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3756CDE008
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 10:51:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D55D240280;
	Thu, 25 Jun 2026 12:51:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id E64894025F
 for <dev@dpdk.org>; Thu, 25 Jun 2026 12:51:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782384712; x=1813920712;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vLcfCoFdeWPtdZbLF56GcTIWgEMXR4PDhDKB3ndVtCU=;
 b=Daa/9Q+h8pfcZBhVQ5Gojmvoh4ZCea+riIV/sCeC76Rru5UIy8CiLdlo
 MINhrdxtAYmSXybnOGyoksO4a+cuNXrzZWw2vMiF/OdyJ7u/8TMzuzxc/
 8D9I1quzAvAvN8ILoQt4I0Wi4JBOG7L0qEqVulqgi8yFVo4QDJPN7Wufz
 cS1nm+dI343F7Ktj7xLKkZOKywYo3Sr6FxwcyxJ9jID/ILwnw9xDAU5iZ
 0HzAeki1YW91ZNlu8rkjATwV3hDPgkZzZ1E9pZ7C53QffDX6dCaBNwJ2r
 0KFW2819Jv5U48CDzpv/yedtcSX/6N0ekQ8ScRsRphimebUWCnGSvEPY1 g==;
X-CSE-ConnectionGUID: 1iwPdBFcRs29SuyvavBwGA==
X-CSE-MsgGUID: gauyinNMTn2OXKdF/wTBkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="82144070"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="82144070"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 03:51:50 -0700
X-CSE-ConnectionGUID: UM1Yhao+Qkql8Ipd48EMyw==
X-CSE-MsgGUID: Iw4CSNA+TDKU3O1ixtMkNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="249124472"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 03:51:50 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 03:51:49 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 25 Jun 2026 03:51:49 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.69) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 03:51:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CH7nOz9CK8vKr2yXYVAh0B6zWtatR3xTnCvCzTi6tq2uEz7RXLv6L09rH21m1p58JDcLpL8TPhIkh/wef6SxgKpgmvIf5w9d1ktpquUQpPxjI4MHvuwtFqtf0wSGF7hRS06ZvBLvqSoBSHWS3nkRbEoQfZI+aw7/OBmr13GKD87piUVORLuXg8/c/ALJc68JQfW3roK+qH18Nb+eP+5cxk0ZgHnj1QbuaLdkZYN0uSIJLplnI6ziveBIt4kBPPZZj5tIyaAXMfvCGdatLUrJznnHIzDxkMHJJ1ztxjYGkUIYj8E4lZFqcqqgJ7WzvxtQlmBHmGJe7ByeJd1ul7XSsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLcfCoFdeWPtdZbLF56GcTIWgEMXR4PDhDKB3ndVtCU=;
 b=Ms3Fp+1H7jlzZZx+mtba10N6dbvpumoi9XyiOwRJV59Sf7zCdtLq2DUzX9+9l9l2hsmGwmyKs3v1Ts0gWdXGzIC0vPlAH3bxWXEubSG9m74tBtNyYXScdWg0dxUrqFHRbldHS8/iTkq2L1dJ2z3vnqnu3hWfrEvLVDHMbsjn8v8t/kkusVFJl/6gpPs5IY8yYw2ApTMWAQluuoZWdiuwdhM5+84KwJaOfTZLHopj6NRC43sp+4QWmakq9GIYazjNVFfTFH3Btjtx/tryQwv2IqulaYAOwTzSAaxw5Qv3k9V4IMESY24/6VScosJIRVzuJ3isHWh+jd4kSx3Kh/unEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF00BBED10C.namprd11.prod.outlook.com (2603:10b6:f:fc02::5)
 by PH7PR11MB8453.namprd11.prod.outlook.com (2603:10b6:510:308::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Thu, 25 Jun
 2026 10:51:47 +0000
Received: from DS4PPF00BBED10C.namprd11.prod.outlook.com
 ([fe80::39c3:b214:8d57:23fa]) by DS4PPF00BBED10C.namprd11.prod.outlook.com
 ([fe80::39c3:b214:8d57:23fa%8]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 10:51:47 +0000
From: "Xu, HailinX" <hailinx.xu@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>, dev <dev@dpdk.org>
CC: "Puttaswamy, Rajesh T" <rajesh.t.puttaswamy@intel.com>, "Hosamani,
 Manjunathgouda" <manjunathgouda.hosamani@intel.com>, "Mcnamara, John"
 <john.mcnamara@intel.com>, "Richardson, Bruce" <bruce.richardson@intel.com>,
 Ferruh Yigit <ferruh.yigit@xilinx.com>
Subject: RE: DPDK release candidate 26.07-rc1
Thread-Topic: DPDK release candidate 26.07-rc1
Thread-Index: AQHc+U1mkLbEXkwm7ECkESFicLLaZrZO+JPg
Date: Thu, 25 Jun 2026 10:51:46 +0000
Message-ID: <DS4PPF00BBED10C6E26A0D64A6995A0885B9FEC2@DS4PPF00BBED10C.namprd11.prod.outlook.com>
References: <EE7NFX47QzqKRvGYzs3QUA@monjalon.net>
In-Reply-To: <EE7NFX47QzqKRvGYzs3QUA@monjalon.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF00BBED10C:EE_|PH7PR11MB8453:EE_
x-ms-office365-filtering-correlation-id: 5b9fc1db-ee9c-4bfa-75c4-08ded2a7c0de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|38070700021|18002099003|22082099003|11063799006|56012099006|6133799003;
x-microsoft-antispam-message-info: 5EGG95813B0/2O567XPk/6Oqc61y1eTFjNJ/lJT7gxjC8pLaSqAR7iFc+usUwS85Hxf43cpRMiZMXz9jR4uSnc8kPbLH/gYydqS0mP2qOmIj6DmSNm+YyDkQG2abuWROuqbDWOCwX04fZeuf7hrFOi5N9bvEYrfRPEa0/2sic33IOwjbrzk16VvQ3wxi4yZE/TBhWy/wkjxgZyzJCW6Nl+Al6CbK9rwa9CN2A8/coROwGWFg1bC6U7Xf00U/5h5dG2HzkuHUSMhNNtD0KkhbKRGGoPhxeW5dmZOmfdLD3X75xPfxZNXUUf15WLUBNydnRrHBYhLA8h4X8lYnwHRMPQwPvq9CkAFGJu1D57hQk4mMFyiXww1FrqP0030BAoxv9IFUQHFcVgLsQ+dygPOoi4q77YRgLq6ddIYcyEJTlaCe7nlxmh/TCbOUc7AMuN47mlylCLbhr+YxB42fJawvLE3B1t1UlVyL5LbjjEetbuC8YZMv7vG+IaVNU6CopOKUqDa/c2Wp0xo4uHjKsWQgVSzcegGz0SW9FE04VTzr6LCM57ryGJ2KzWNPHw9SVWyMJwgxFjFL+mB3R2pGeEDRQVqkVa1z60LK1RPDYgp+UBdXXaXWzkPzqxfjKiMbAAJfd3US7b7dKPOjkS4lfAmWRc7WTV0Om7weO7C7G0WeMTaLk4/YfRb+0mmRDQV+IfVS0l1LLlPbigZwv/LZWMcJnV/Xzc6uDoX1GdBe9kjhAS0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF00BBED10C.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2tBOWRzNTdvMDBRZEVMRVovS1BRenRVT1haUXZscGNvOVJYU2s5aFo1aXE3?=
 =?utf-8?B?bDZNL2xlOGs0bVd5Sk1LOW5SRFpNekNtZS9yNGJBMVR3Skc2TGk0cnNwZXFB?=
 =?utf-8?B?UDlFVE5hMVBXSFUybnp0VTJ1V0lSN3c5NVA5dW5xQzlGTHVQM21QQzltSXBO?=
 =?utf-8?B?ZGtKcS9hUWhwdjQ0VDdaY3AyOWl1b0d4UWx0SmZLTmtZa2MxSDRVbFd0MG8z?=
 =?utf-8?B?d3lTYjVNQlJGc1hHZmh6cStNdkxIMWU5U0J6SVQ4TmtoY2dwaDZKM3BKdnJi?=
 =?utf-8?B?N0hLT1RPNFVsZWJQRUhKVzc2aXVCS2tGRWgzUGNWK1Y4WnQyVXhZNEVUMS9u?=
 =?utf-8?B?MzU1eWVzcTJEa0kzam1EV0pFUU4vdDc3MEEzb2lwWHNDajJKSzRyZXR1SnJS?=
 =?utf-8?B?RVJGUnk2YXo1S1F6NGE1Z1AxUGZsVXhucnNCVy9MTWhzNGZoYSt0MGt0RWc2?=
 =?utf-8?B?ZlRXSk9pVFZ1ZktUVjdqQUYybTY4ZHFWSHZRak9jVS9PaWFKT3FzT2RaZW9V?=
 =?utf-8?B?RlVTYkRoSFR5eHRaQVF1enhhWXNyMFFBTnFLRzNlRlJMWWl0NTd0OHozTEx1?=
 =?utf-8?B?MHNXZU5NWmRTZS9UajN3UmVjcXJiY0FzWGhvcnp3VmFUS3Z0ZmZwVW1BdzNQ?=
 =?utf-8?B?RytTcUgzQ0VxRU9peVNqVjlmMVN0SitPM0FpeEpxRWVJOVFSaHNXbDB4UmVS?=
 =?utf-8?B?VWRWUlNpZHJBS2NWNzl2cUFGMUtnRTBUZ3B5dTBSZ3pyeXVLL3gxZzhIcTRM?=
 =?utf-8?B?cmdGL2JhUVFTYTJHY00zRFNQK2prNkcvK00wMDVPK1lxUkJGajRyblF0cTdB?=
 =?utf-8?B?dENoM3V5TlFtaEF0cTQ1WlNtSmRPaWoyanBCY3RWWVhlZUM4QnRBVjR0SFF3?=
 =?utf-8?B?aUQxWHJLSWdtK1Vmcjk2SDRkN2E5OTlYeFNMU2hkRXo5VHpCSmsyNXlEZi9C?=
 =?utf-8?B?ejVCK3o4aGRhYzB1RnRGdTJtRmM3RWIvd3ZXSTR6THU0RUoyN2kweHZGS0FT?=
 =?utf-8?B?WVIxaTZVeE5rRzBzRXdYNEx3aTFLR1psSTBJZGdmOXBIRXJVYnc3QXVSYytv?=
 =?utf-8?B?SWY1ZXlJQ1I3M0Z3VituVVVMSk1oeXRxaXFvTHlrUWpyRUJiQ0hnMkZtL0VT?=
 =?utf-8?B?cW1rSXFQWXBFeWVxdXRKMWpWaFpLYzAwZnRyTlpLYUFRZ1N1VkoyK2F5Umpj?=
 =?utf-8?B?ajZPOFFzdCs4ODF5dHpxNXFsZDJudjYvRUUxdFpua1ZBVFpVVENtVExVTjZ4?=
 =?utf-8?B?eVRQeGdkZG55MGdzSWwva3pGRTlmMEVYM1IzQVV0eXpqSDFiWkgxbVE4Qzdv?=
 =?utf-8?B?a0hRUTIwclhzeWswdHFRTUxQSGdLcjVwbkN4RSthcWxJbW9HdjJiWDd2RVFB?=
 =?utf-8?B?L0Y5c1NEMUxKS0Y4S0ppbTFQbHpKa0dKemdlMVJXaFE2ZXY3M3pGd3RGMXFr?=
 =?utf-8?B?SVduV2I3VXVMRFgzd0dGQ1NlS0FrYldmeEZLQjNGQ0kxM2JkbERITlJLNWpw?=
 =?utf-8?B?cC9lRnVEWXBtUHpJWkxxSHU2QVAyS1RlMXMvUXBVSFBZT2pxQ21TNGFBMWdB?=
 =?utf-8?B?eklMMVBJMlZsQ2hGUEZvOVZKbldLVjI1dGlHSVJuSG1LL1lQa0p6cGNzVWtX?=
 =?utf-8?B?cy9rZlAwanNabnFVNEd3N2pGMTkwazYrYUNUM1dmY3JMVW1KSFF2TFRCUWtD?=
 =?utf-8?B?OUI0NmlMdW9IS25lSFR6b0Nmd2lMU0dBaUJZWWpLaFFvTkZoRzg4ZTEwakli?=
 =?utf-8?B?RGlEc2cyaC9kK2RrQUphNG1aYmtIUG8rQThVWG01bDFwTnFaUFc1S2pUejRU?=
 =?utf-8?B?UjdPZHdIRE04cWIyQkQ1N2taSG1zMTRId2xZK3AxSEJla2Q1WFJldWVndkZa?=
 =?utf-8?B?STQ4aGgvK0ZBMFlTbnJnNUlsNnc5dW5kK2hhQ1FONFNIdUpmMTZ4azJibUlE?=
 =?utf-8?B?b0dHM0RFQlZMMXl4WG44YUJmcysrY0Q0aVRzSFpBdEo5dmszYnY3SWYzUnQ0?=
 =?utf-8?B?TlJJTnNkOE9namVrN1FkMWdIQlNYbGxZa21ZTlNKOXpiaEhxZStpdzlKVmZO?=
 =?utf-8?B?aU5IUjVCQ3RocUFIUGtSazhZZ2VXOVFUdlk3aG5pQkRvdUtvVFpYeUVYaTFV?=
 =?utf-8?B?M2RSOVJKWUtrMFhoVUkvYlpTQXR1MURZSkdtbk5TRzE4V2FGK0gwdndlRksv?=
 =?utf-8?B?YTRzMnlnSWlPV0ZrdEo5MUNFeVdJYmZuOFpKNFVFdjliUW5tcllPaWRPTWw1?=
 =?utf-8?B?cFdFS05Cb0xYYzJBWTU5YmJtem1IZGhiT0NJdG9Oc3FDZ2hKWG5kUE1OM29y?=
 =?utf-8?Q?sd1AO6Gcb10UBQjb31?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ESdPsED8SqEZUi2sSPtOcsmZjlHYN6PbnSG01mpuJ5i+0QvwgVxpXS4+ct8DYBIuzwxro3PQmdccrLraKbqI+kBQL+Rj4Tp7t+NvEAUdStBwqMsLiEetz1Gkeh4tvlMeO6MP59aWmHbNuCfJoWDjzUk1AwESos1UzZe/QErCFrVGD4D96KMey1zo4k8wCkdU6TzLnrMBSaBwKnF6Nuh63scr8E3qKMWyIlQ3/SPYGna1DNxSg2wj9Nr0QtkboV7WH+uaQPPKCoJ1hquSGjwMXC42LvPt/wtVU3T5Nj09yneKkqS7xw6xAhzkmdwp0XlwijzAkTfyw8zHaUDMtr/e1w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF00BBED10C.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9fc1db-ee9c-4bfa-75c4-08ded2a7c0de
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2026 10:51:47.0119 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ierQ0OO9XJIO+rrgT8oGoc99gFGIuddyXE+fIizqm064O2hKS/n25LToC4gcj/WXhfO8EEjmllq8qgvAQQ54lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8453
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaG9tYXMgTW9uamFsb24gPHRo
b21hc0Btb25qYWxvbi5uZXQ+DQo+IFNlbnQ6IFRodXJzZGF5LCBKdW5lIDExLCAyMDI2IDEwOjUy
IEFNDQo+IFRvOiBhbm5vdW5jZUBkcGRrLm9yZw0KPiBTdWJqZWN0OiBEUERLIHJlbGVhc2UgY2Fu
ZGlkYXRlIDI2LjA3LXJjMQ0KPiANCj4gQSBuZXcgRFBESyByZWxlYXNlIGNhbmRpZGF0ZSBpcyBy
ZWFkeSBmb3IgdGVzdGluZzoNCj4gCWh0dHBzOi8vZ2l0LmRwZGsub3JnL2RwZGsvdGFnLz9pZD12
MjYuMDctcmMxDQo+IA0KPiBUaGVyZSBhcmUgNDMyIG5ldyBwYXRjaGVzIGluIHRoaXMgc25hcHNo
b3QuDQo+IA0KPiBSZWxlYXNlIG5vdGVzOg0KPiAJaHR0cHM6Ly9kb2MuZHBkay5vcmcvZ3VpZGVz
L3JlbF9ub3Rlcy9yZWxlYXNlXzI2XzA3Lmh0bWwNCj4gDQo+IEhpZ2hsaWdodHMgb2YgMjYuMDct
cmMxOg0KPiAJLSBvcHRpb24gLS1wYWdlc3otbWVtIGZvciBwZXItcGFnZS1zaXplIG1heGltdW0N
Cj4gCS0gb3B0aW9uIC0tbm8tYXV0by1wcm9iaW5nIGZvciBubyBkZXZpY2UgYXQgaW5pdA0KPiAJ
LSBsZXNzIG1lbXBvb2wgY2FjaGUgbWlzc2VzIGluIHJ1bi10by1jb21wbGV0aW9uDQo+IAktIHBl
ZWsgc3R5bGUgQVBJIGZvciBzdGFnZWQtb3JkZXJlZCByaW5nDQo+IAktIFJJU0MtViB2ZWN0b3Ig
cGF0aHMNCj4gCS0gUFRQIGhlbHBlcnMgYW5kIGNsb2NrIHJlbGF5IGV4YW1wbGUNCj4gCS0gc2Vs
ZWN0aXZlIFJ4IEFQSSB0byBzYXZlIFBDSSBiYW5kd2lkdGgNCj4gCS0gdmhvc3QgbWVtb3J5IGhv
dHBsdWcNCj4gCS0gcGNhcCBkcml2ZXIgZW5oYW5jZWQNCj4gCS0gTGlua0RhdGEgc3hlMiBOSUMg
ZHJpdmVyDQo+IAktIEFJIHJldmlldyBoZWxwZXJzDQo+IA0KPiBJbXBvcnRhbnQgbm90ZToNCj4g
UGlwZWxpbmVkIGFwcGxpY2F0aW9ucywgd2hlcmUgZXRoZGV2IFJ4IGFuZCBUeCBydW4gb24gc2Vw
YXJhdGUgbGNvcmVzLCBzaG91bGQNCj4gYWRhcHQgdG8gdGhlIG5ldyBhbGdvcml0aG0gYnkgZG91
YmxpbmcgdGhlaXIgY29uZmlndXJlZCBtZW1wb29sIGNhY2hlIHNpemUsDQo+IHRvIGF2b2lkIGRv
dWJsaW5nIHRoZWlyIG1lbXBvb2wgY2FjaGUgbWlzcyByYXRlLg0KPiANCj4gUGxlYXNlIHRlc3Qg
YW5kIHJlcG9ydCBpc3N1ZXMgb24gYnVncy5kcGRrLm9yZy4NCj4gDQo+IFdlIHBsYW4gdG8gcmVs
ZWFzZSAtcmMyIGluIDIgd2Vla3MuDQo+IA0KPiBUaGFuayB5b3UgZXZlcnlvbmUNCj4gDQpVcGRh
dGUgdGhlIHRlc3Qgc3RhdHVzIGZvciBJbnRlbCBwYXJ0LiBkcGRrMjYuMDctcmMxIGFsbCB2YWxp
ZGF0aW9uIHRlc3QgZG9uZS4gZm91bmQgNiBuZXcgaXNzdWVzLg0KDQpOZXcgaXNzdWVzOg0KICAx
LiBbZHBkay0yNi4wNy1yYzFdIGljZV9kY2Y6IGNvcmUgZHVtcCBvY2N1cnMgd2hlbiBjcmVhdGlu
ZyBhIHN3aXRjaCBydWxlIG9uIERDRiAgICAgICAgICAgIAktPiBJbnRlbCBkZXZlbG9wbWVudCBp
cyBpbnZlc3RpZ2F0aW5nDQogIDIuIFtkcGRrLTI2LjA3XSBBQkkgdGVzdGluZyBkcGRrMjYuMDdy
YzErZHBkazI1LjExIHNob3dzIGVycm9yOiAidW5kZWZpbmVkIHN5bWJvbDogcnRlX2Zsb3dfZHlu
Zl9tZXRhZGF0YV9vZmZzLCB2ZXJzaW9uIEVYUEVSSU1FTlRBTCIgICAgICAtPiBoYXMgZml4IHBh
dGNoDQogICAgICBodHRwczovL3BhdGNod29yay5kcGRrLm9yZy9wcm9qZWN0L2RwZGsvbGlzdC8/
c2VyaWVzPTM4NTY5DQogIDMuIFsyNi4wN11yc3NfdG9fcnRlX2Zsb3cvdGVzdF9zZXRfa2V5X2tl
eWxlbjogY3JlYXRlIGluZ3Jlc3MgZmFpbGVkICAgICAgICAgICAgICAgICAgICAgICAgCQktPiBo
YXMgZml4IHBhdGNoDQogICAgICBodHRwczovL3BhdGNoZXMuZHBkay5vcmcvcHJvamVjdC9kcGRr
L3BhdGNoLzdmNmYxMWZiMDdiYzU1MDc4NDMzNTEyM2FmNmEyNzBjZDUxNGY3ZDcuMTc4MTY5Mjgx
Ny5naXQuYW5hdG9seS5idXJha292QGludGVsLmNvbS8NCiAgNC4gW2RwZGstMjYuMDctcmMxXSBp
Y2VfZmxvd19wcmlvcml0eTp0ZXN0X2Zsb3dfcHJpb3JpdHlfZmlsdGVyIGNyZWF0ZSBmbG93IGZh
aWxlZCAgICAgICAgICAJCS0+IEludGVsIGRldmVsb3BtZW50IGlzIGludmVzdGlnYXRpbmcNCiAg
NS4gWzI2LjA3LXJjMV0gSWNlIHBvcnRzIHN0YXR1cyBpcyBpbmNvcnJlY3QgaW4gdGVzdHBtZCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAJCQktPiBJbnRlbCBkZXZlbG9wbWVu
dCBpcyBpbnZlc3RpZ2F0aW5nDQogIDYuIFtkcGRrLTI2LjA3XVtYNTUwXW1lc29uX3Rlc3RzL2Ry
aXZlcjogZXZlbnRfaW5saW5lX2lwc2VjX2F1dG8gdGVzdCBjYXNlIHRlc3QgZmFpbGVkICAgICAg
CS0+IGhhcyBmaXggcGF0Y2gNCiAgICAgIGh0dHBzOi8vcGF0Y2hlcy5kcGRrLm9yZy9wcm9qZWN0
L2RwZGsvbGlzdC8/c2VyaWVzPTM4NTMwDQoNCiogQnVpbGQgJiBDRkxBRyBjb21waWxlOiBjb3Zl
ciB0aGUgYnVpbGQgdGVzdCB3aXRoIGxhdGVzdCBHQ0MvQ2xhbmcgdmVyc2lvbiBvbiB0aGUgZm9s
bG93aW5nIE9TKGFsbCBwYXNzZWQpDQogIC0gVWJ1bnR1MjUuMTAvVWJ1bnR1MjYuMDQNCiAgLSBS
SEVMOS42L1JIRUwxMA0KICAtIEZlZG9yYTQzDQogIC0gRnJlZUJTRDE1LjANCiAgLSBTVVNFMTYN
CiAgLSBPcGVuQW5vbGlzOC4xMA0KICAtIE9wZW5FdWxlcjI0LjA0LVNQMg0KICAtIEF6dXJlTGlu
dXgzLjANCg0KKiBGdW5jdGlvbiB0ZXN0czogQWxsIHRlc3QgZG9uZSBhbmQgZm91bmQgMyBpc3N1
ZXMuDQogIC0gSUNFLShFODEwLCBFODI1LCBFODMwLCBFMjEwMCkgUEYvVkY6IHRlc3Qgc2NlbmFy
aW9zIGluY2x1ZGluZyBiYXNpYy9SVEVfRkxPVy9UU08vSnVtYm9mcmFtZS9jaGVja3N1bSBvZmZs
b2FkL21hY19maWx0ZXIvVkxBTi9WWExBTi9SU1MvU3dpdGNoL1BhY2thZ2UgTWFuYWdlbWVudC9G
bG93IERpcmVjdG9yL0FkdmFuY2VkIFR4L0FkdmFuY2VkIFJTUy9BQ0wvRENGL0ZsZXhpYmxlIERl
c2NyaXB0b3IsIGV0Yy4NCiAgLSBpNDBFLShYWFY3MTAsIFg3MjIpIFBGL1ZGOiB0ZXN0IHNjZW5h
cmlvcyBpbmNsdWRpbmcgYmFzaWMvUlRFX0ZMT1cvVFNPL0p1bWJvZnJhbWUvY2hlY2tzdW0gb2Zm
bG9hZC9tYWNfZmlsdGVyL1ZMQU4vVlhMQU4vUlNTLCBldGMuIA0KICAtIElYR0JFLShFNjEwLCBY
NTUwKSBQRi9WRjogdGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5nIGJhc2ljL1RTTy9KdW1ib2ZyYW1l
L2NoZWNrc3VtIG9mZmxvYWQvbWFjX2ZpbHRlci9WTEFOL1ZYTEFOL1JTUywgZXRjLiANCiAgLSBJ
R0MtKGkyMjYpIFBGOiB0ZXN0IHNjZW5hcmlvcyBpbmNsdWRpbmcgYmFzaWMvUlRFX0ZMT1cvVFNP
L0p1bWJvZnJhbWUvY2hlY2tzdW0gb2ZmbG9hZC9tYWNfZmlsdGVyL1ZMQU4vVlhMQU4vUlNTLCBl
dGMuDQogIC0gSVBzZWM6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBpcHNlYy9pcHNlYy1ndy9p
cHNlYyBsaWJyYXJ5IGJhc2ljIHRlc3QgLSBRQVQmU1cvRklCIGxpYnJhcnksIGV0Yy4NCiAgLSBW
aXJ0aW86IGJvdGggZnVuY3Rpb24gYW5kIHBlcmZvcm1hbmNlIHRlc3QgYXJlIGNvdmVyZWQuIFN1
Y2ggYXMgUFZQL1ZpcnRpb19sb29wYmFjay92aXJ0aW8tdXNlciBsb29wYmFjay92aXJ0aW8tbmV0
IFZNMlZNIHBlcmYgdGVzdGluZy9WTUFXQVJFIEVTWEkgOS4wLCBldGMuDQogIC0gQ3J5cHRvZGV2
OiB0ZXN0IHNjZW5hcmlvcyBpbmNsdWRpbmcgQ3J5cHRvZGV2IEFQSSB0ZXN0aW5nL0NvbXByZXNz
RGV2IElTQS1ML1FBVC9aTElCIFBNRCBUZXN0aW5nL0ZJUFMsIGV0Yy4NCiAgLSBETEI6IHRlc3Qg
c2NlbmFyaW9zIGluY2x1ZGluZyBETEIyLjAgYW5kIERMQjIuNQ0KICAtIE90aGVyOiB0ZXN0IHNj
ZW5hcmlvcyBpbmNsdWRpbmcgQUZfWERQLCBQb3dlciwgQ0JETUEsIERTQQ0KDQoqIFBlcmZvcm1h
bmNlIHRlc3Q6IEFsbCB0ZXN0IGRvbmUgYW5kIHBhc3NlZA0KICAtIFRob3VnaHB1dCBQZXJmb3Jt
YW5jZQ0KICAtIENyeXB0b2RldiBMYXRlbmN5DQogIC0gUEYvVkYgTklDIHNpbmdsZSBjb3JlDQog
IC0gWFhWNzEwL0U4MTAvRTgyNS9FMjEwMCBOSUMgUGVyZm9ybWFuY2UNCg0KDQpSZWdhcmRzLA0K
WHUsIEhhaWxpbg0K
