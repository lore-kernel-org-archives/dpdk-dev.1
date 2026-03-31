Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7A4FF60FA
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 09:51:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5D244042F;
	Tue, 31 Mar 2026 11:51:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 5FE3D4026A
 for <dev@dpdk.org>; Tue, 31 Mar 2026 11:50:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774950658; x=1806486658;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=J7ekTsfbxiC0cOR3AC2f9rd30fqSV8Q1S99HDvi7Lb0=;
 b=WzE3krHNuE/DBuoqQ1/nq0VyU/lbMtAVOQ5UDk0QWg8dRS55Wtbufyqy
 Ivew1wFG/KBkc8mlWX/9Pm0nYiJiAdF8xG8OfDK3RCNpT8Hcrk6DTg/Wv
 5GK5Qno0Ybr3ULkteOwlGKsS+sQ/B7SntJN9oTy2+DVxEBvnWg/c1xkip
 7xyZO3Zey5A+UUjtg/goId9aDcJ1Z0W4xpDONrQ1ZamEdkHtOEdacP1FX
 l+PAES9VIIimDbGiULm50mFXP+eH397g7vNVwDCdI/F1ZzNX4ZXUtpAiU
 0Oz7LaWa+fcgRaCcil89mxbT+eskxgQJGR97e0n54GjThGnW4UKP9OBdn w==;
X-CSE-ConnectionGUID: ZJm/OjGzQ8OHoLGpdYWAeQ==
X-CSE-MsgGUID: SLhitdaqSEeoLW3kf9NyjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="74991286"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="74991286"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 02:50:57 -0700
X-CSE-ConnectionGUID: EmjbETqRSOaDApHb2l4RqA==
X-CSE-MsgGUID: FI1F5YMvSQS0Yc5LzkTEfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="264256265"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 02:50:57 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 02:50:56 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 02:50:56 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.50) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 02:50:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IKqJ0A5IfMGLgDhygjdJwHDLxoZyOKWKdNMqfosMJgcU8f3OME+HDRsZS6CywYSN1/f2CB4fA2fBfxzOeNabDSI6kEZ2hUod8C+T9kK0FaTcYHcEPk44AUU6TjgAKKLaRRla/ces/r6aSwG3vWM4VtsrmQ7CxlX4ryX4nRkv0PcgXVcut9C6FG3/3PZaTmQ1fvlNA3lwm3k9OhBjmtlE0S7lZfjttrjFyaTdvgqIKqaN/4r1ws1aksJVp4bWFOin66ycEpi2IzTnHEldJ7VXTV/jxrPH/6ezfO1V5ObJn279SlFVzuzpZjLCqAcWmq7Zt7NPGSa/T2jEDuWGyIkU5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7ekTsfbxiC0cOR3AC2f9rd30fqSV8Q1S99HDvi7Lb0=;
 b=FoYDwA2zDwVJcQlaH4J4YUoqcWMXLyIUhiQYRHRMXjeAFsL5G9RxRO9PJujDaQULloJ9XGwX8+JezZF7MdyPX0UcmlHrTnv+O7sd24aqmb0zxkiOYhW1qEcHkmxZ5D8qM9y7l5SfP2QlaqUoUW5dbtFyPiwKRqlP+n2hmv8l8QzWScLR+MsC2Z4dejX0DD+hMZY2och2lGWw1kYI9ghcM3XXdHwdYraPvbkY33B+CCFYQUInb3hMt0YKKnkXckcu66eWTvdltENN4IO6M4X2VoMCAspQL5+EKK3FRcKnGnQg+jIcixntpsTemBxFV8U+/vrOo6FNjhjWK/tVM5vFVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF00BBED10C.namprd11.prod.outlook.com (2603:10b6:f:fc02::5)
 by BL3PR11MB6482.namprd11.prod.outlook.com (2603:10b6:208:3bd::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 09:50:47 +0000
Received: from DS4PPF00BBED10C.namprd11.prod.outlook.com
 ([fe80::345a:4216:d548:1510]) by DS4PPF00BBED10C.namprd11.prod.outlook.com
 ([fe80::345a:4216:d548:1510%3]) with mapi id 15.20.9769.011; Tue, 31 Mar 2026
 09:50:46 +0000
From: "Xu, HailinX" <hailinx.xu@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>, dpdk <dev@dpdk.org>
CC: "Mcnamara, John" <john.mcnamara@intel.com>, "Puttaswamy, Rajesh T"
 <rajesh.t.puttaswamy@intel.com>, "Richardson, Bruce"
 <bruce.richardson@intel.com>
Subject: RE: DPDK release candidate 26.03-rc3
Thread-Topic: DPDK release candidate 26.03-rc3
Thread-Index: AQHcvLW1qkWQ8JOJn0qwbLVqvulN5bXAJXGAgAgwpYA=
Date: Tue, 31 Mar 2026 09:50:46 +0000
Message-ID: <DS4PPF00BBED10C895CF32C887BC4916CB29F53A@DS4PPF00BBED10C.namprd11.prod.outlook.com>
References: <4340093.KlZ2vcFHjT@thomas>
 <MW4PR11MB5799CA8B1E076690F4BA4E109D56A@MW4PR11MB5799.namprd11.prod.outlook.com>
In-Reply-To: <MW4PR11MB5799CA8B1E076690F4BA4E109D56A@MW4PR11MB5799.namprd11.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF00BBED10C:EE_|BL3PR11MB6482:EE_
x-ms-office365-filtering-correlation-id: 2c136e31-8eae-4094-1fc3-08de8f0afbc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: wchCJCR/a4Cm9R30FKIHW9J6UxIFUwp/UjVE+CiQvDMf5HGG4crgt1dsv1kWL6eKdsonlXgFtF3iTpF6fIWxtTNR+tHw7rREmQJjqc4NdHgNRWTbbqGdny3XlZ646/x79Xt53SdMZg4U0H8utDjwJIpj8XBMWTv9hYFMnxGKcmQK/oDyP8Ko/PBPSd33GFkxj/ccCvLUKNS5/SHALw2dXA063pNplBEBQcdZibgycufSD0G1z2CEKcMgRax1WIwQ0ZEGmrl6Bx1qu/zClSvBFFkkq3Dw5X1+wQz7NjRxbHUP9yi9rH1hVWE4fytW4PKauNnacVL6vFIU++CbniVsxrsjqQ5cYlQqBgOECmb2Pd0SeFmPuslF7glW9NvUX6xKc11gV76hYHV2EUXnYIpUJa8mZ6qYPf6/TOzVMg5sCCxQrVbRNznzSkMQdvbIdif8cH6jSIAMjQ1Zx7qFIne+ofyd+jNWEzVvfKqdPTVYnXqAjzbEeFlj/2ahKjFC2hW7ixzKYimQsmqaQoQakwLiatdGrh3cImT6APrxjLFz+mF1pB2ZOedtyoeCxrFBw+BvqgkNokVQyzriVzxcjJEGy8KWS25y/VR8/VuqGEfW4naT9NjMXM+G7RMuCt8Oc/saOTSqR+6CbXeMg3kPxVszB7QXDAmthosxmunzZ/ddJgR5chkxl9z9zbptasgXc1b4PcpVER2BY0gsVG68H0lSlmTJXh3WJGhlzPSnhuE5UBQdKwFBbGKMsEJCvS1YDIzs
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF00BBED10C.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWZ3QU1XdmV5N29lMHZvNWRsQ2NHYTQ2RjFxV21VMUUwaWw5bVdJYlN4cmdB?=
 =?utf-8?B?SGsvODdnWWJ6RkFzckJ6aFlrYnovVXJoN1Q4b0NTTFY4WGZ3Wnc5eE1mNGE3?=
 =?utf-8?B?dlRVNi9QaVQ5bUVKMS9vS0t0UHdsU2JTSENOa2hXdEQ1Zkd1Q3NhTTZjNVk3?=
 =?utf-8?B?Q2d5UDZveDRJcmVuYWxxMDB6U1hRbWs3eWlQTjJDdFE0anVFeTBxTU1IME1u?=
 =?utf-8?B?QzNQWXBsbzhHYjNPaUp1T3JZNURzZWVxaURJNWtTVlBkMjdVSzdDZHpaamNP?=
 =?utf-8?B?eG5zUnVNM0pDRkFKV1N0aDRqVGx2RWlIUUZJa1JJWklacWJjbTFHOHMrQ3Bs?=
 =?utf-8?B?UlJTUmh6T2JjR2ZENVA2QnB4eEtKYlUvNklYS20vbjFuUC9aU3lrODROeUlz?=
 =?utf-8?B?blhsQXAzTXdMclZvQjRIa2hlTGlKNm5YTHZPSGsyMDBSZnBON1A3aUZJdm9Q?=
 =?utf-8?B?REZTbUNXc0tTTXI0Wnl2S1J2T3VmMW02R05xQms5eXo2R2dtbkc1d3pHMkNL?=
 =?utf-8?B?Q1hubWFXQ2orTHdRemFEdVZJYkhqQW02V3dJem5jdDhoclhERi9KZDR2a2pY?=
 =?utf-8?B?aWh5MkNqMmhwUVloR0gya2lWMVl3RGJDcG1OTkE3c1NtVTJVV0ttTWRpU3B1?=
 =?utf-8?B?VVc2UmZ6N1F6T21HNElEaXcxU2hsZ2Y1WDFpODFra0dGeW5tL05yU2ZFWW5h?=
 =?utf-8?B?YnFiazNxUVBEWlN0TXMxYm5vVkxLOXVJNWFNUjNSeEJFaDNHb2N6aFVpM3VM?=
 =?utf-8?B?UTlORUx3dTlYNTFQV1p4V1BCV04yR2RFQzRSSWc1V09vaXpkM21UWkVNSDJZ?=
 =?utf-8?B?ODZqSWk1S3d2NkxxQnpwRHA0NlN6SXZaczZ6T3B2bkZxOWU3K2lTVTdQZEJm?=
 =?utf-8?B?Q1h0V3dIVVY1Y2tKcU1oNHBQNTU2NnE5UlNxa0xwSUJ2OGZEamZoVHlxR0Fh?=
 =?utf-8?B?bTNIRVlFN1pQYWt4R2ROdlloWXRXOUZUNWgwcnV3Nm9tUWFKbXVvWVR2a1Bi?=
 =?utf-8?B?TUQvVFZFczk1aHl3RktPOE9hY2hxc1FZeW9mZW04cnQvYlZ4bXhNZitaUE5a?=
 =?utf-8?B?Z0tQQTZoRi9UaFB6RkkzTGJvSzVONTlJcWZjVGpaVDRkTmY2Z2RXT2NFTmlj?=
 =?utf-8?B?NWQ1N24yUEk2MGd3THk4WXMzbmV6K1lQdm5PK3M2ell1cDcyL0t1ektvWTd4?=
 =?utf-8?B?ZUdLMm5uTk4zTnl4YWZUamRHbGd6NWk5UEUrM2c3Rjh0UEdGS3Q1ekVHWW5p?=
 =?utf-8?B?L2RVaGJOa2pBc043NHh3YmJuMlJrWnczU2NqaEdSd0p5dUQxa0piRWtoQVpN?=
 =?utf-8?B?ek9uZkVPY0dxS3JCcUNBaUpld1hzSDhWNVJKaDVobGpjNTdVa1ppdFRBZnUz?=
 =?utf-8?B?eUJYdkoxRi9VUGl3Nm5HWUZNUm84NFdyc3o2T2JiblJIYTdqUkIvMWZCRUtw?=
 =?utf-8?B?SjdHZGtmK2pGVUlNczRrYWl2dk9Yekw4SFJydXhhMTlObzU1VFZ1VEdJSlhu?=
 =?utf-8?B?WUdRbUxsSzFkditnYXBKaHYzeC9NWEltcWRHVFdMODBqV1ZHbElKM3BXbnE4?=
 =?utf-8?B?OXN6eE41RHdnL3RoWlBjZE1wbjgzcXVmUDVoN2l4S01xYVZxRUJEcWMxMGRl?=
 =?utf-8?B?N1BLVnpyemhWREdTcytoQkZWUlluNTRIcUpES2pUQ1d6SjVVSkRkN1Nrckpw?=
 =?utf-8?B?VW1NWmE1Skx2bHJsU1J3eGtNME82VHlwcHdxSUpCTkdWS29MN0JJNlRmVWsv?=
 =?utf-8?B?SmFHUUJBczlEaHBONVRxaE81K0toa0xyWmptMXZpTytvWTFkTC8vMTBJd1lB?=
 =?utf-8?B?QXIySDNSK2FjeWZuUDVxempKMk9pS1VHRnhFY0tseXhTbDF0VHdBNGkvRTFt?=
 =?utf-8?B?ZWxyZFREdkJSN2U4M0EyNUx0bENrclNSUjFONmtBTURyMmM3SFpyL0k4WnFI?=
 =?utf-8?B?M1g3TzNkdHp5SEpXVlJ6S0dVQmpSWjM2THY1U0FaQkxndU12Wlo2L2Nrdm1u?=
 =?utf-8?B?MVdDZUJrWjNNdmRwa1ZpQU1tL1hXd1h5M2JHOERndHU2Mm5HMk50bFUycE5P?=
 =?utf-8?B?eFlvQzE4WTdlazEvbUNNSitnbk8zUFBWYlFIZGtNRU41c0VVb1JCOGZOZVVa?=
 =?utf-8?B?c0V5akxwOWtGRDFoVWtXTllma09hcGRIaSt6U2FxVFlUT0Z3OHNWMElwNktK?=
 =?utf-8?B?UTcxa1N5TXNZRXpoWTNzYXNKTGpsMWdrWUY1L2ljMFBiR1plVERhZHNlemdm?=
 =?utf-8?B?VmFYVHoyY0hkRkx0RGJYWEV6SzZSLzU2VmNJU0VIcUFqY3lsT3hzVTdKTEJJ?=
 =?utf-8?B?OWViVEU4ZVdwbFd0YUNnR2kxOHptZVhqN2Z2VEtZOWdkWkxZMkVOZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Oa1+P21UUvB5KUzbqzNHb4oMKOU4SGzzwxt26cCKZMhvG+kbddFXJaPquKwjy6vaGNqYCrWnjjQ1NHeW4iLKB7XUTQlpjpDrwh4dLzdCGFJlm/LjqbxvgLtpxVK01rnIDOuafG/eQWXOGqJBumD9Mhxqlv8cMBj2cqxe2wxFh0pA3uwQJbXjl1fShdrbCMDujuYZoktCKh+pjb5JBjR2i8B/qwNuJiu7EAikTgzPTAkpzEUJYOMD4x1VzBkkHT8heWn9SjlcIYH7faGejT5v3kZxZvrCAHLRfLFekGxVCkSbjLoYHgm+zjoeq6lTIclTs/a4NsxBf2s22m5TTWWkhA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF00BBED10C.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c136e31-8eae-4094-1fc3-08de8f0afbc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 09:50:46.9207 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: thXI1LAwoHrn2o/+B1ds3rq/9RdMmrGHei9pzfP2FOhUXHCwxhUbva9Q6Jj2RkE1HGn3hvXMU1vzbN9sP0C92A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6482
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
b21hc0Btb25qYWxvbi5uZXQ+DQo+IFNlbnQ6IDIwMjblubQz5pyIMjbml6UgODoxNQ0KPiBUbzog
YW5ub3VuY2VAZHBkay5vcmcNCj4gU3ViamVjdDogRFBESyByZWxlYXNlIGNhbmRpZGF0ZSAyNi4w
My1yYzMNCj4gDQo+IEEgbmV3IERQREsgcmVsZWFzZSBjYW5kaWRhdGUgaXMgcmVhZHkgZm9yIHRl
c3Rpbmc6DQo+IAlodHRwczovL2dpdC5kcGRrLm9yZy9kcGRrL3RhZy8/aWQ9djI2LjAzLXJjMw0K
PiANCj4gVGhlcmUgYXJlIDY1IG5ldyBwYXRjaGVzIGluIHRoaXMgc25hcHNob3QuDQo+IA0KPiBS
ZWxlYXNlIG5vdGVzOg0KPiAJaHR0cHM6Ly9kb2MuZHBkay5vcmcvZ3VpZGVzL3JlbF9ub3Rlcy9y
ZWxlYXNlXzI2XzAzLmh0bWwNCj4gDQo+IFBsZWFzZSB0ZXN0IGFuZCByZXBvcnQgaXNzdWVzIG9u
IGh0dHBzOi8vYnVncy5kcGRrLm9yZw0KPiANCj4gWW91IG1heSBzaGFyZSBzb21lIHJlbGVhc2Ug
dmFsaWRhdGlvbiByZXN1bHRzIGJ5IHJlcGx5aW5nIHRvIHRoaXMgbWVzc2FnZSBhdA0KPiBkZXZA
ZHBkay5vcmcgYW5kIGJ5IGFkZGluZyB0ZXN0ZWQgaGFyZHdhcmUgaW4gdGhlIHJlbGVhc2Ugbm90
ZXMuDQo+IA0KPiBNb3JlIHRvb2xpbmcgYW5kIGRvY3VtZW50YXRpb24gY291bGQgYmUgYWRkZWQg
YmVmb3JlIGNsb3NpbmcgMjYuMDMuDQo+IFRoZSBmaW5hbCByZWxlYXNlIHdpbGwgaGFwcGVuIGlu
IGEgZmV3IGRheXMsIGF0IHRoZSBlbmQgb2YgdGhlIG1vbnRoLg0KPiANCj4gVGhhbmsgeW91IGV2
ZXJ5b25lDQo+IA0KVXBkYXRlIHRoZSB0ZXN0IHN0YXR1cyBmb3IgSW50ZWwgcGFydC4gZHBkazI2
LjAzLXJjMyBhbGwgdmFsaWRhdGlvbiB0ZXN0IGRvbmUuIG5vIG5ldyBpc3N1ZXMgZm91bmQuDQoN
CiogQnVpbGQgJiBDRkxBRyBjb21waWxlOiBjb3ZlciB0aGUgYnVpbGQgdGVzdCB3aXRoIGxhdGVz
dCBHQ0MvQ2xhbmcgdmVyc2lvbiBvbiB0aGUgZm9sbG93aW5nIE9TKGFsbCBwYXNzZWQpDQogIC0g
VWJ1bnR1MjUuMTAvVWJ1bnR1MjQuMDQuMw0KICAtIFJIRUw5LjYvUkhFTDEwDQogIC0gRmVkb3Jh
NDMNCiAgLSBGcmVlQlNEMTUuMA0KICAtIFNVU0UxNg0KICAtIE9wZW5Bbm9saXM4LjEwDQogIC0g
T3BlbkV1bGVyMjQuMDQtU1AyDQogIC0gQXp1cmVMaW51eDMuMA0KDQoqIEZ1bmN0aW9uIHRlc3Rz
OiBBbGwgdGVzdCBkb25lLg0KICAtIElDRS0oRTgxMCwgRTgyNSwgRTgzMCwgRTIxMDApIFBGL1ZG
OiB0ZXN0IHNjZW5hcmlvcyBpbmNsdWRpbmcgYmFzaWMvUlRFX0ZMT1cvVFNPL0p1bWJvZnJhbWUv
Y2hlY2tzdW0gb2ZmbG9hZC9tYWNfZmlsdGVyL1ZMQU4vVlhMQU4vUlNTL1N3aXRjaC9QYWNrYWdl
IE1hbmFnZW1lbnQvRmxvdyBEaXJlY3Rvci9BZHZhbmNlZCBUeC9BZHZhbmNlZCBSU1MvQUNML0RD
Ri9GbGV4aWJsZSBEZXNjcmlwdG9yLCBldGMuDQogIC0gaTQwRS0oWFhWNzEwLCBYNzIyKSBQRi9W
RjogdGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5nIGJhc2ljL1JURV9GTE9XL1RTTy9KdW1ib2ZyYW1l
L2NoZWNrc3VtIG9mZmxvYWQvbWFjX2ZpbHRlci9WTEFOL1ZYTEFOL1JTUywgZXRjLiANCiAgLSBJ
WEdCRS0oRTYxMCwgWDU1MCkgUEYvVkY6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBiYXNpYy9U
U08vSnVtYm9mcmFtZS9jaGVja3N1bSBvZmZsb2FkL21hY19maWx0ZXIvVkxBTi9WWExBTi9SU1Ms
IGV0Yy4gDQogIC0gSUdDLShpMjI2KSBQRjogdGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5nIGJhc2lj
L1JURV9GTE9XL1RTTy9KdW1ib2ZyYW1lL2NoZWNrc3VtIG9mZmxvYWQvbWFjX2ZpbHRlci9WTEFO
L1ZYTEFOL1JTUywgZXRjLg0KICAtIElHQi0oaTM1MCkgUEY6IHRlc3Qgc2NlbmFyaW9zIGluY2x1
ZGluZyBiYXNpYy9SVEVfRkxPVy9UU08vSnVtYm9mcmFtZS9jaGVja3N1bSBvZmZsb2FkL21hY19m
aWx0ZXIvVkxBTi9WWExBTi9SU1MsIGV0Yy4NCiAgLSBJUHNlYzogdGVzdCBzY2VuYXJpb3MgaW5j
bHVkaW5nIGlwc2VjL2lwc2VjLWd3L2lwc2VjIGxpYnJhcnkgYmFzaWMgdGVzdCAtIFFBVCZTVy9G
SUIgbGlicmFyeSwgZXRjLg0KICAtIFZpcnRpbzogYm90aCBmdW5jdGlvbiBhbmQgcGVyZm9ybWFu
Y2UgdGVzdCBhcmUgY292ZXJlZC4gU3VjaCBhcyBQVlAvVmlydGlvX2xvb3BiYWNrL3ZpcnRpby11
c2VyIGxvb3BiYWNrL3ZpcnRpby1uZXQgVk0yVk0gcGVyZiB0ZXN0aW5nL1ZNQVdBUkUgRVNYSSA5
LjAsIGV0Yy4NCiAgLSBDcnlwdG9kZXY6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBDcnlwdG9k
ZXYgQVBJIHRlc3RpbmcvQ29tcHJlc3NEZXYgSVNBLUwvUUFUL1pMSUIgUE1EIFRlc3RpbmcvRklQ
UywgZXRjLg0KICAtIERMQjogdGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5nIERMQjIuMCBhbmQgRExC
Mi41DQogIC0gT3RoZXI6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBBRl9YRFAsIFBvd2VyLCBD
QkRNQSwgRFNBDQoNCiogUGVyZm9ybWFuY2UgdGVzdDogQWxsIHRlc3QgZG9uZS4NCiAgLSBUaG91
Z2hwdXQgUGVyZm9ybWFuY2UNCiAgLSBDcnlwdG9kZXYgTGF0ZW5jeQ0KDQoNClJlZ2FyZHMsDQpY
dSwgSGFpbGluDQo=
