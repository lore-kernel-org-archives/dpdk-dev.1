Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F67F30928
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 10:12:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 27ED24029D;
	Thu,  5 Mar 2026 11:12:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 082644027A
 for <dev@dpdk.org>; Thu,  5 Mar 2026 11:12:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772705570; x=1804241570;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=CTJoJWmrVjANy+mTzxGI/1nvEsMj8pDcZcG5hYsIUTo=;
 b=K6jgBEhM27MDkTU+gg0dwj3EumXoCJFyESG208AjqCTlRqDt6cN6aHpI
 9lS4u5RZUht1/5ui9Z//u+OEKHC6NP5khrq19RpeppQnXkfoWM7AnsnuW
 kucFIW/3eYY60e8BKl4we4KbPzhNFjphEAYmdCkSFIVwuY+bPIjxxDksg
 7vXHZAvmXdNMT60uGi3cnFOoalWMx+SdZ1VIAjrtRhZiLTsusDYtGEOlq
 MIMw11xQx/3OkzT88o/Iha/vorrqs0wgx2mfoNy4uzcXmlhH+RI3YHs7f
 ZC5tkQqjbtt3RenZkyl16RiQhnJ0U9CI3ZS8vyKp0xeetNNfOJAdnPcqo A==;
X-CSE-ConnectionGUID: INL9OuReRKCeEryKJD0NTg==
X-CSE-MsgGUID: EJcwbnl+STiGaSTGGwoADw==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="84123266"
X-IronPort-AV: E=Sophos;i="6.23,102,1770624000"; d="scan'208";a="84123266"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 02:12:48 -0800
X-CSE-ConnectionGUID: cr2xo9sKQf6Mp8VrERQMrQ==
X-CSE-MsgGUID: RbF1gOAfQ9Op4n/1UHUQHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,102,1770624000"; d="scan'208";a="215890726"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 02:12:48 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 5 Mar 2026 02:12:47 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 5 Mar 2026 02:12:47 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.16) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 5 Mar 2026 02:12:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdjDospQdkAqIB5grZ9R74h3UxAxTSxU788WkgqEoUBWPfiX27AV1KVL3OTfBkNeOewJseVt2MBK8irX8eWwPNYXrWIZZtPFZ/Z6HxcWh7lInzSO2VE71L7rva0iV0RyOCLtb2Sfs4MTf7hxUvl/++H9IsntrI8feCvKnGixrl6JJU1fQ5E7k4SZ5ocKVB4UoK4e1p7Iu5rbx20Ff1xBskXtQH5IVHeV2UQQHIY+Y7Tj6tJQ5U6hecOaPm2S6PJRVGu9pLJPO6IH0PTayuxSSplGORAY4pcajrPNgg2ibjIB/JKVNkz/x6LHI4Mca2vWLnyCnuT8BdhV3gtM8PwEcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTJoJWmrVjANy+mTzxGI/1nvEsMj8pDcZcG5hYsIUTo=;
 b=iw1GjahaBcxTYQ4/yyY/0mxK4+U5yFwzTTF11wc8jEZjtciwiOFnP9Pi6VkgvDI2g7kpwKnKPP4d9oh0hKrpgkWdraYXZciuFxT9Hta66CA1Vxw4hxeRFQMoPRvbN2QQ6F8OX6wCkJygMSgwMTydemKLhj4v/gfdDNeut+9TiY+tiimZxqgGKcI0KtWFRsViFtcRNny4kwplX1bHHmBN9dwL/4RKtPlicGpyaEEZcpTMwahXOHpfcINPoGt885np3/agXVsX2UAvF5rx0YXwe8APyYhtwGMK1gvByWgsYL6nZdeQRZQSZNnubWsnlH7lHQc8yUiZ7zGWtYwMwyGw9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF00BBED10C.namprd11.prod.outlook.com (2603:10b6:f:fc02::5)
 by IA0PR11MB7789.namprd11.prod.outlook.com (2603:10b6:208:400::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 10:12:42 +0000
Received: from DS4PPF00BBED10C.namprd11.prod.outlook.com
 ([fe80::5e26:d110:9a24:7a9e]) by DS4PPF00BBED10C.namprd11.prod.outlook.com
 ([fe80::5e26:d110:9a24:7a9e%5]) with mapi id 15.20.9632.017; Thu, 5 Mar 2026
 10:12:42 +0000
From: "Xu, HailinX" <hailinx.xu@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>, dev <dev@dpdk.org>
CC: "Mcnamara, John" <john.mcnamara@intel.com>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, Ferruh Yigit <ferruh.yigit@xilinx.com>,
 "Puttaswamy, Rajesh T" <rajesh.t.puttaswamy@intel.com>, "Thakur, Sham Singh"
 <sham.singh.thakur@intel.com>
Subject: RE: DPDK release candidate 26.03-rc1
Thread-Topic: DPDK release candidate 26.03-rc1
Thread-Index: AQHcoF0sg1AI3Zo0/Um7jXCNjvr0rLWfuTBA
Date: Thu, 5 Mar 2026 10:12:42 +0000
Message-ID: <DS4PPF00BBED10C579FE2AB4E9F9B4AA5CB9F7DA@DS4PPF00BBED10C.namprd11.prod.outlook.com>
References: <13563702.xXuK6brfV6@thomas>
In-Reply-To: <13563702.xXuK6brfV6@thomas>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF00BBED10C:EE_|IA0PR11MB7789:EE_
x-ms-office365-filtering-correlation-id: 2555fa4f-1741-430f-def7-08de7a9fbd4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: tEN2XR8OfIsno36QGsBYgR8xcH0DdBZkCsFaWKnmTwxQiHkURUiQ9oaDzH5NkR59HUGz/EExg/bUbBRfCGV3Bzhb00TO57wQkw3VXHSu42hRgGDf4FBHNhi294BFr7Vp3s2T8OBrgHQeMzdiRHFfJ1oR9G5jIJlvGosWFttAn1D8ZXSuIp3buL+PbZ6uLRD2c1j/1p8oCYCOg1Z2mQ/c3RhZVaPoib6lWSFCdrE7UiOV4VUN6YLXuvu0iCDvZxa6gwE/WBMCTyBjuFI2weZFHx67ILpk1TyFY9lqD7hoae5doaufqB6Z9v4oLzd6u8H/q53SfGtwL/68oxSgkk7zLCJtUlNsaMMDsEm+dzkQ73tl41N2UPfBojvTJyO+rx9h8Mk8to1/doQhoMFCd8DKg3t91NYJndPbneVk9NZqfK91yHV2b6P+iYm3CIbBtmVORB4xE5T5NLFQy/BEP1ixMSfDJ/ev542GXe1dupgItgYWud3yyZ5lvhSLy0zm3TMVqT2GJqhacb7SzgY5u8BoVz1wGPs3kNYJ5OXXrjWj2Wzt7mx9SqB2UawS0/yxcnUnGlLY9KCdSqmIdwPTkYwvog8vdStWJWCicxqPjS7eRmmrNpX0LLhMrNLRc0ET7oA+CsxGueLeGj2mq+u7v4tl/yUUIq6DI3lJI4q/wkwIHyIeJgk4qpqtZhitpIFL7iGsiXOtwa816nu5nQtGYGt/cRPgP80SnTyYsdhPBSQIFHFI/vt9m5afpkQoB1yA73SG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF00BBED10C.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmtGQjBPaUhXOGc5cklReDdqZEJpQUtBdmxQNDNueFV0d1pOOGE1NGk2eCtu?=
 =?utf-8?B?eUFNY241R2Q3S29PakkySHFMamZlcXFyQUxTZ3p6UE11Mkt6MFFUNGpBRXZa?=
 =?utf-8?B?NE1HTGdjQ2d0dXRWV25vMkJBM01RdG5Cc2JGd25kRllWdEMycHErVXE1OGdi?=
 =?utf-8?B?MzJoNDBzRk9ndVZxaGFMUlJnZktDZUhpaWd4RXJFeld1T0kyb0FNc0M5T2ZC?=
 =?utf-8?B?NEVlcmNmRGVNclNoR2d0L212eS9wS0VKUEMzWUluWHRvSkdPTGdEeHZGeXpo?=
 =?utf-8?B?SkhaamFVMjVRM2dPajFNN0NaekRsaEpDbjI4THMvTWpxclpPL2lMcDNQMWhF?=
 =?utf-8?B?RTJlMmdrVFZWME1vaGh5YlRkYytXbU9kTEc5MjI3RzNUZXRhSHZOa3h6d3BS?=
 =?utf-8?B?cVNFU0NTdVhlR1dhSkx0WThCengzMDJHdnN2OVhWWFkvWVg3eGl4QTBHUW9V?=
 =?utf-8?B?R1JLMFBHMGFucHArcFJ0Z24zT0RpcUdzdFZjRW10Yk1qTGIydWpJRHErUHU1?=
 =?utf-8?B?R1U4aEVzd1BzRzVpQks0b29TdTU5NGFhVi9qS0lqek0xNjNBZFBMTitWaHh6?=
 =?utf-8?B?aWxNRjB1U1hmRVloK3lKUHFOUEU5OHA0TnRZd0JlbEdIQnpXM0pYZEhtVTlF?=
 =?utf-8?B?bmtpNUxlSGp0Y21DaEVPdEtEc2hDUXFHNnBieklnR3FPUDVJZURScERsRzAw?=
 =?utf-8?B?QWJDejRYZGNoWkM1aGduSUgwbklZVldkTnZtbGE4WENRTUdvQkJacmZiKy9K?=
 =?utf-8?B?OVpsWjdJVzFkbTBxQzRUT1VMZFZXUE1UZ00yMW8xaW80RlV2NjVUa001UlV2?=
 =?utf-8?B?TzA0M1FqUUYvcFRwWmdVaEgvT0I4aFlyL3hJSVlEMTdYczZUM3JCWER6eitZ?=
 =?utf-8?B?eGoxVy8vRnZSVUhqSnIyTm1idWN1bGtjSmxBRGozM2FSVEkyenNFQTNsWXd2?=
 =?utf-8?B?K1ZPQkdzd1l0dFdpUmhTdytVdHBVa050M21ZOVJySGhuUzdWMWIxMWE0OHda?=
 =?utf-8?B?eStaL1R4TnpoM01nbVhhb1hBRFJJMkUreVp6bTcxdUZHb2wvRk42aTVjWExP?=
 =?utf-8?B?R01KeGpvWHVxRjdRVFNIaDJQZitVOFMya2RWaXdGUThUN1g3N1FBM3JpODk3?=
 =?utf-8?B?Ukw5dDNSVFFmL1lYM0tLRnZoN1UvZ1dFTm5pYmEzWUduY3o4bzJ1eDlmMXoz?=
 =?utf-8?B?Tm5xN2JlZFQ5N0drcTE4Q3pmWEttZjRoTjZFVmJmT09hRW0xYnFpSHpyTTNn?=
 =?utf-8?B?SVB2OGhvMXpXM1YrUzAzWHRwdURTNkFsbG1CeFNWQnlSZVF0dEZIQ0liQ3hx?=
 =?utf-8?B?enR0alo1SXo5S0JZV1JRYk03K01PRGlCQ0pKclRGb2IvRU9qZnFRcE1HRXJl?=
 =?utf-8?B?MldBNGxKNEJVMGw2Y3YreCt2Q1ZwTzZaVUgzOFBBYXpsMDJTeStCdTlVU0Nr?=
 =?utf-8?B?MWVpSkV3NENRRGZtcEwyRHpJZXlQVENiaURHd1duRFhHVU5SWFFZZ1RPSHhR?=
 =?utf-8?B?Y0cwZncrR3h2aENlTS8xdlNTNWk5ODNVQktrVytwVTM4dE53ZXlxMUQ5R1Fn?=
 =?utf-8?B?ZUYyc25zR0xBTEFDK0pJSGlFSkJRbThIL0ViY0lwT1FRUnhNMXRxU0ZuQXlQ?=
 =?utf-8?B?UnkzVStmMm9TOG5nZVR3cEhOYTJXRXN4c3RYZkZWd0hLWnJEZGdhWitzLzU0?=
 =?utf-8?B?ZkNmZWRCUHZDbERMOFdzUlI2SzBDdzVlQVRtWDh0YUtvWVlJRjRWZTRGYWdj?=
 =?utf-8?B?SlVZaDd1Tm40OFpMV0NRVjRibFoycUlKK0RobVdUU1pvMGVsRTU0bzBMOTZB?=
 =?utf-8?B?RFhpUlNseWdnbGxKR3lTTjJ4by9YY3FSY0V5aEdEcHh2ZVlvVkg3ZnNWTnJs?=
 =?utf-8?B?dHVUWFVDS2UxamJaU1ZMVk5jZ2t3U0ZiVUU3NGM4cXovUmFvUzEvV2kwdXRQ?=
 =?utf-8?B?WENyYkpuY09aK21FWTF6VjVTS2hQcTZFY1d6Y3ltK2VQS1hYVndGQ3oxZnMx?=
 =?utf-8?B?elUxUFJtNmovM0ZUUnF0Nlo4ZkdxTGY5QUJXTGF4K2NQdlI4NHVCT2V0aEVp?=
 =?utf-8?B?akFBbFVhS1RGdTN2U3MxOU12aTV1eGFyNnBvZEl2NDRYRFZJNlZ2TzNtTjAr?=
 =?utf-8?B?akxmbVBpRmNxYmNrZnVSVm50UHdRNHJ6bC9GRGMvRklTR0ZZRmRaR1B2d0to?=
 =?utf-8?B?VFBLSlF5UWwyNUE4Uk9JcjJWM3dEM1d0d0RhVEF4T0ZwWUh0MlIwNDBRTXNN?=
 =?utf-8?B?V0JQaG5LWlBWOWxucGVlQUNoNGRCQjN2Q1R3c2xXQVJlaHZYbTE5Qk5GdUlL?=
 =?utf-8?B?MXhoR3NEM1d0OE9NSFhuOG9HQmIzd2lFUUZVc01GWGcyUnlLVkxGdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: b+jayNHGCMh/dTdQBVQJVu+5JxxSmrqrSITwwvDzBGKkl3InrxRHuotIOHZT7wOVDXVD2fgcOmAnHOm2FS9+XoTFWiAkL0a16kpKRtz2clkJ8zanzLFUjUu5CTaAyxyQ2J9wA9T7lpnWNN2DE+V/p1RwS0oFurUD3IG49ORZshgq82P0slrDAIbTRFjhPiBpH2n28Nw/ESFaucC+JESZVDl1BB1BMlmDJZqx3mpu8OKfomYR2F5v6EjiiCtXz1SZvYyKZWD0hMNxcCHrhkyAs5oxBqdnH5HD0WBNzoUqFw1gzrdZ2hIh1qeZLkHD2W87Xn6Zz8+aDkLi3AP+sfwhSw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF00BBED10C.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2555fa4f-1741-430f-def7-08de7a9fbd4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 10:12:42.7321 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JRWH0vV7V+6MoGhmXMj0NsXn5/DwKQ1Wjj8lk5k5ChsD5XBKCHYhFjWl3zbXu7jVvpbIFvY7eMiXnSxMQkaisQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7789
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
b21hc0Btb25qYWxvbi5uZXQ+DQo+IFNlbnQ6IFdlZG5lc2RheSwgRmVicnVhcnkgMTgsIDIwMjYg
NjozMSBBTQ0KPiBUbzogYW5ub3VuY2VAZHBkay5vcmcNCj4gU3ViamVjdDogRFBESyByZWxlYXNl
IGNhbmRpZGF0ZSAyNi4wMy1yYzENCj4gDQo+IEEgbmV3IERQREsgcmVsZWFzZSBjYW5kaWRhdGUg
aXMgcmVhZHkgZm9yIHRlc3Rpbmc6DQo+IAlodHRwczovL2dpdC5kcGRrLm9yZy9kcGRrL3RhZy8/
aWQ9djI2LjAzLXJjMQ0KPiANCj4gVGhlcmUgYXJlIDM1NiBuZXcgcGF0Y2hlcyBpbiB0aGlzIHNu
YXBzaG90Lg0KPiANCj4gUmVsZWFzZSBub3RlczoNCj4gCWh0dHBzOi8vZG9jLmRwZGsub3JnL2d1
aWRlcy9yZWxfbm90ZXMvcmVsZWFzZV8yNl8wMy5odG1sDQo+IA0KPiBIaWdobGlnaHRzIG9mIDI2
LjAzLXJjMToNCj4gCS0gQUNMIGN1c3RvbSBtZW1vcnkgYWxsb2NhdGlvbg0KPiAJLSBjcnlwdG9k
ZXYgMjU2LWJpdCBORUEvTkNBL05JQSBhbGdvcml0aG1zDQo+IAktIE9wZW5TU0wgQUVTLVhUUyBh
bmQgU0hBS0UgYWxnb3JpdGhtcw0KPiAJLSBCUEYgYXRvbWljIFhDSEcgaW5zdHJ1Y3Rpb24NCj4g
CS0gbm8gbW9yZSBmb3JtYXQgb3ZlcmZsb3cgaW4gbGlicmFyaWVzDQo+IAktIG5vIG1vcmUgdmFy
aWFibGUgc2hhZG93aW5nDQo+IA0KPiBQbGVhc2UgdGVzdCBhbmQgcmVwb3J0IGlzc3VlcyBvbiBi
dWdzLmRwZGsub3JnLg0KPiANCj4gV2UgcGxhbiB0byByZWxlYXNlIC1yYzIgaW4gMiB3ZWVrcy4N
Cj4gDQo+IFRoYW5rIHlvdSBldmVyeW9uZQ0KPiANClVwZGF0ZSB0aGUgdGVzdCBzdGF0dXMgZm9y
IEludGVsIHBhcnQuIGRwZGsyNi4wMy1yYzEgYWxsIHZhbGlkYXRpb24gdGVzdCBkb25lLiBmb3Vu
ZCAzIG5ldyBpc3N1ZXMuDQoNCk5ldyBpc3N1ZXM6DQogIDEuIHBtZF9ib25kZWRfODAyM2FkOnRl
c3RfY29tbWFuZF9saW5lX29wdGlvbjogZmFpbGVkIHRvIHNldCBib25kIHBvcnQgcmVhZHkgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgLT4gaGFzIGZpeCBwYXRjaA0KICAgICBQYXRjaCBs
aW5rOiBodHRwczovL3BhdGNoZXMuZHBkay5vcmcvcHJvamVjdC9kcGRrL3BhdGNoLzIwMjYwMjI0
MTIxMzU4LjMxMDI3NDAtMS1icnVjZS5yaWNoYXJkc29uQGludGVsLmNvbS8NCiAgMi4gZXZlbnRk
ZXZfcGlwZWxpbmU6dGVzdF9jaGVja19sb2FkX2JhbGFuY2VfYmVoYXZpb3Jfd2l0aF9kZWZhdWx0
X3R5cGU6IFRoZSBudW1iZXIgb2YgY2FwdHVyZWQgcGFja2V0cyBpcyBub3QgYXMgZXhwZWN0ZWQg
ICAgICAtPiBoYXMgZml4IHBhdGNoDQogICAgUGF0Y2ggbGluazogaHR0cHM6Ly9wYXRjaGVzLmRw
ZGsub3JnL3Byb2plY3QvZHBkay9wYXRjaC8yMDI2MDIyNjE1MzYzNi4zOTI1Mzg3LTEtYnJ1Y2Uu
cmljaGFyZHNvbkBpbnRlbC5jb20vDQogIDMuIG1lc29uX3Rlc3RzL2RyaXZlcjogZXZlbnRfaW5s
aW5lX2lwc2VjX2F1dG90ZXN0IGNhc2UgdGVzdCBmYWlsZWQgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtPiBoYXMgZml4IHBhdGNoDQog
ICAgUGF0Y2ggbGluazogaHR0cHM6Ly9wYXRjaGVzLmRwZGsub3JnL3Byb2plY3QvZHBkay9wYXRj
aC8yMDI2MDMwMjE2MDc0MC4xMjkyNjQyLTEtYnJ1Y2UucmljaGFyZHNvbkBpbnRlbC5jb20vDQoN
CiogQnVpbGQgJiBDRkxBRyBjb21waWxlOiBjb3ZlciB0aGUgYnVpbGQgdGVzdCB3aXRoIGxhdGVz
dCBHQ0MvQ2xhbmcgdmVyc2lvbiBvbiB0aGUgZm9sbG93aW5nIE9TKGFsbCBwYXNzZWQpDQogIC0g
VWJ1bnR1MjUuMTAvVWJ1bnR1MjQuMDQuMw0KICAtIFJIRUw5LjYvUkhFTDEwDQogIC0gRmVkb3Jh
NDMNCiAgLSBGcmVlQlNEMTUuMA0KICAtIFNVU0UxNg0KICAtIE9wZW5Bbm9saXM4LjEwDQogIC0g
T3BlbkV1bGVyMjQuMDQtU1AyDQogIC0gQXp1cmVMaW51eDMuMA0KDQoqIEZ1bmN0aW9uIHRlc3Rz
OiBBbGwgdGVzdCBkb25lIGFuZCBmb3VuZCAzIGlzc3Vlcy4NCiAgLSBJQ0UtKEU4MTAsIEU4MjUs
IEU4MzAsIEUyMTAwKSBQRi9WRjogdGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5nIGJhc2ljL1JURV9G
TE9XL1RTTy9KdW1ib2ZyYW1lL2NoZWNrc3VtIG9mZmxvYWQvbWFjX2ZpbHRlci9WTEFOL1ZYTEFO
L1JTUy9Td2l0Y2gvUGFja2FnZSBNYW5hZ2VtZW50L0Zsb3cgRGlyZWN0b3IvQWR2YW5jZWQgVHgv
QWR2YW5jZWQgUlNTL0FDTC9EQ0YvRmxleGlibGUgRGVzY3JpcHRvciwgZXRjLg0KICAtIGk0MEUt
KFhYVjcxMCwgWDcyMikgUEYvVkY6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBiYXNpYy9SVEVf
RkxPVy9UU08vSnVtYm9mcmFtZS9jaGVja3N1bSBvZmZsb2FkL21hY19maWx0ZXIvVkxBTi9WWExB
Ti9SU1MsIGV0Yy4gDQogIC0gSVhHQkUtKEU2MTApIFBGL1ZGOiB0ZXN0IHNjZW5hcmlvcyBpbmNs
dWRpbmcgYmFzaWMvVFNPL0p1bWJvZnJhbWUvY2hlY2tzdW0gb2ZmbG9hZC9tYWNfZmlsdGVyL1ZM
QU4vVlhMQU4vUlNTLCBldGMuIA0KICAtIElHQy0oaTIyNikgUEY6IHRlc3Qgc2NlbmFyaW9zIGlu
Y2x1ZGluZyBiYXNpYy9SVEVfRkxPVy9UU08vSnVtYm9mcmFtZS9jaGVja3N1bSBvZmZsb2FkL21h
Y19maWx0ZXIvVkxBTi9WWExBTi9SU1MsIGV0Yy4NCiAgLSBJR0ItKGkzNTApIFBGOiB0ZXN0IHNj
ZW5hcmlvcyBpbmNsdWRpbmcgYmFzaWMvUlRFX0ZMT1cvVFNPL0p1bWJvZnJhbWUvY2hlY2tzdW0g
b2ZmbG9hZC9tYWNfZmlsdGVyL1ZMQU4vVlhMQU4vUlNTLCBldGMuDQogIC0gSVBzZWM6IHRlc3Qg
c2NlbmFyaW9zIGluY2x1ZGluZyBpcHNlYy9pcHNlYy1ndy9pcHNlYyBsaWJyYXJ5IGJhc2ljIHRl
c3QgLSBRQVQmU1cvRklCIGxpYnJhcnksIGV0Yy4NCiAgLSBWaXJ0aW86IGJvdGggZnVuY3Rpb24g
YW5kIHBlcmZvcm1hbmNlIHRlc3QgYXJlIGNvdmVyZWQuIFN1Y2ggYXMgUFZQL1ZpcnRpb19sb29w
YmFjay92aXJ0aW8tdXNlciBsb29wYmFjay92aXJ0aW8tbmV0IFZNMlZNIHBlcmYgdGVzdGluZy9W
TUFXQVJFIEVTWEkgOS4wLCBldGMuDQogIC0gQ3J5cHRvZGV2OiB0ZXN0IHNjZW5hcmlvcyBpbmNs
dWRpbmcgQ3J5cHRvZGV2IEFQSSB0ZXN0aW5nL0NvbXByZXNzRGV2IElTQS1ML1FBVC9aTElCIFBN
RCBUZXN0aW5nL0ZJUFMsIGV0Yy4NCiAgLSBETEI6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBE
TEIyLjAgYW5kIERMQjIuNQ0KICAtIE90aGVyOiB0ZXN0IHNjZW5hcmlvcyBpbmNsdWRpbmcgQUZf
WERQLCBQb3dlciwgQ0JETUEsIERTQQ0KDQoqIFBlcmZvcm1hbmNlIHRlc3Q6IEFsbCB0ZXN0IGRv
bmUgYW5kIHBhc3NlZA0KICAtIFRob3VnaHB1dCBQZXJmb3JtYW5jZQ0KICAtIENyeXB0b2RldiBM
YXRlbmN5DQoNCg0KUmVnYXJkcywNClh1LCBIYWlsaW4NCg==
