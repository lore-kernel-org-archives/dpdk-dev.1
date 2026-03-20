Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1905E1099B31
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 17:38:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E0F8402BB;
	Fri, 20 Mar 2026 18:38:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 34912402B2;
 Fri, 20 Mar 2026 18:38:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774028319; x=1805564319;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=PVhfyuWvzINOMprofSwixXl1Wuj2QVasuP1Ac6Y6mOk=;
 b=FnaACZ5ydEP7bxJqal8aIHLv+3tbGPCVXwgExEorRaeiAnVyjXNDmzUy
 dAQMz5y6E4GGefOb0czYUSXRAUYJ9f34kp68NpzUDBtuBObe3TkrjHZhT
 heEO0BnXW8oNOB4Jz/xcSkqCWAA1u6gmF2/jaAiE+6RpYZCiXAHHZ+OmE
 GfOYE+mLLbY0foC0g7sghUP0Suywz6yh+0VA7Yet8b00kiJ43QhODyJIP
 NCdlfKCofy4IT1EjvPA1c9Qmyuscy6QoFs89rrnQWtm2VrKZTFO6pynbr
 yXtEHA+vkDyGVwSQfB7zIRcm62IG3bv0CJH5uZL666vFf4cbpm4v4SQj1 Q==;
X-CSE-ConnectionGUID: hIwg5cTHRnyjfGDm8fjmJQ==
X-CSE-MsgGUID: 6Csh4xEeTnqQP7FnLDtzaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="85746680"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="85746680"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 10:38:37 -0700
X-CSE-ConnectionGUID: mE7DY6KoTkyLcAnl0QDgDA==
X-CSE-MsgGUID: YhPYApX5S8WyvJcV+ozy/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="222449568"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 10:38:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 10:38:36 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 20 Mar 2026 10:38:36 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.0) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 10:38:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPPBD2lRLdV+jCllTXMnfzEYV1bInaCo656ap1/qua7I7lH0wU1dHdjMk3ztTTrl8dHZr+IffWQyOZy7hzvOgwSBW5yDa2IhLLeyucCkyN7uiwO2GhgAXlWM8uGD1DjLAKIdzp249FYOu/1NoCnpzLuplcCUjzUzJR0fYpkiVliYLjJZNVnS3v11sZ++6UCoMHi6Xkutr0eEr3tQVDtEgdnV5YlzDAultdX16HrA2Cs9+g19qRrg0J7LDJphlOE1QmxuZA69IWkBefolvYedXZjfw6NHPnAoTvFygrTMss2XdSBtcmwtjiEa90dm6aDNlq4ZOCVRWg5t9KSCr6YiYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVhfyuWvzINOMprofSwixXl1Wuj2QVasuP1Ac6Y6mOk=;
 b=e44JMZyP6GC+KZS6IwZrm5nioec8/DGRURxMuQgPZ9SbjGXXhgLvUh2yYCUGHvCoF5yG0cwFJJ4AlEEsXZsngUuqvDi51vcW4usK6FGunybHhTmvWIgfFNZCx75CLuhOSFCA1OoJdP5k1ABTvr04iaoiRfguN/1gY+GGd3mvZIqydInc5AbbitY8emaGu4IWP/CTjdsYHxPnV7CmPcY+TxcpFC7mMXFmjCmBHr/w21x5nG5LqEu+YHavzCKNBYKZnwwAGIGrz8l5HwrHD861sDmz10sDyL1qJibJ7Vwz9x8r1gctY4z1c8suXUx4war4Lj+wU1bYu9lod2se3uWLpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7442.namprd11.prod.outlook.com (2603:10b6:8:14d::22)
 by SJ1PR11MB6131.namprd11.prod.outlook.com (2603:10b6:a03:45e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Fri, 20 Mar
 2026 17:38:32 +0000
Received: from DS0PR11MB7442.namprd11.prod.outlook.com
 ([fe80::cc14:6cc7:5da1:8282]) by DS0PR11MB7442.namprd11.prod.outlook.com
 ([fe80::cc14:6cc7:5da1:8282%5]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 17:38:32 +0000
From: "Dumitrescu, Cristian" <cristian.dumitrescu@intel.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] pipeline: fix build with sanitizers or debug options
Thread-Topic: [PATCH] pipeline: fix build with sanitizers or debug options
Thread-Index: AQHcuG4s6NpSInsrDkynFnRRvpcl67W3r6+g
Date: Fri, 20 Mar 2026 17:38:31 +0000
Message-ID: <DS0PR11MB74428B95BC221BC7F5FBE7B5EB4CA@DS0PR11MB7442.namprd11.prod.outlook.com>
References: <20260320133309.1015506-1-david.marchand@redhat.com>
In-Reply-To: <20260320133309.1015506-1-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7442:EE_|SJ1PR11MB6131:EE_
x-ms-office365-filtering-correlation-id: 28ec9e55-4fb8-41d3-9e33-08de86a7815b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: dwiCN/kblc/dAIYQgCnBJiSHLxUe4uL8fiHeYaLRUXOtErVWA7CUzRyoihL0lMAh84Fg8kCojo9STLagIPMHjpvotJXFeblTZcP/bhDaq11SdVwFlc1vFQhv5mHm8+H2WfWw18EGPu5eD0WVF3mtYNQPV/xddlEy9YVfV97izz3ILYRa11V3VIG2MipRqaQPvboZ6cEO2EmAMbOFAGxJm538GDV2z91qRFvH6xAyEmxnpevmRL46r/a6qenNjHy39K4JD/LSmDeIYrhxCljDs0k/Mb6xLsXBTOvnxGV6++sn4520B0eS5VeoOFTWEC1FGeODn61Sk4G3ZriLrOmm/RjQZwzbcwusR2jt/q3ZV4jfu+NpvQg5vx4UcNR4u3QzaOLc8MolWOGlalt+Ay0D31x+FGwAYSr6yCan0xA36a7PZnMESl9Y66BPGRESfRbSeCY0sycGTQVe1ovN/UDF1YRqFQnWNWuKDz83PdgR3j4lh/L/MaSGZi+nM6u1hYzIoYh/h5mB8W9Sc5O2UFBVOJP2Gdca2ZBE7Eqm1cXIDEymHYr/pW3OzD9MfNy0zlXmu+abtAkgU6I9NmCmHhvYahRKsOnMgv0/IKXju1X6LOmCIspVzs5JFxj81pUNEX1Ng1BE37s1M8shhIxNmdjDSEWkzQIaChW0oaQbmvNNqR4Re7fz/8XAajiXWAT0NsBYQpHDFlM/zJdDmXYkOhYNLmTIRAWUgeA9MsqV2rWt6zZw/v3VEO4+gGrgff5wPcTxndijA73/S1SVc7a7lJ9xj5FsxlPIxGtERwSokMhu2Rc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7442.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVVqNFNmZmVGYjJCR1FrSVEzcGk0RGZ5UjZBblgzYU9JMDlWM2RsS3lwaHpo?=
 =?utf-8?B?UUJpSXkrZ0ZpWjAvZHd2WU11c0RLVDZhekluRlV5b0l0NndMaEh3eWRXTlpD?=
 =?utf-8?B?U2tmQlUwaGJNMDRRdzRpNmRTdDhBQ0hQT1E4aU1LWUxzYlc2dDBrd0c2S2l0?=
 =?utf-8?B?QWNvbkNGTFBXODN1QWM2RTFyUHdLbTF0RzZ6ZHBCUUltelozSTZTUW9mR0Uw?=
 =?utf-8?B?QWtoaCtRc0llZHVCaWQvdk1JanY2eFNsZ0Y2MEJWT2RXWG5IOHMwQU1WWm9u?=
 =?utf-8?B?eGU1c2tMZjRsL0RWS1dxbWFSdldNNmN3aVd1MUxtNmk4TmVrcjFJL3BGRWRC?=
 =?utf-8?B?djB1WUV4UlZucEFORUxaZjRSTVE1TUt1a3lSSnBaSjV6blVBQlFJbFlOR051?=
 =?utf-8?B?NzBvTCt5VDZJUURZMkFhdFNtbks2SW51QzNhMFlLVG1wV1FNa09PSGdUTU1s?=
 =?utf-8?B?RlJnOFZJRDBzbGc5VnIxajcvM3dpWEM2RlQ3MkZoa1EzYjl5Z0pXekFwZjNN?=
 =?utf-8?B?b0kvMGRCYUV5UW5zMHJXTzRxY0xCcGsxTzhpbjFreW5wR0hrT1hwWDQrZnBW?=
 =?utf-8?B?cFpVK0RBdjZncVNXMnRza28weWg4NElEUUhJRzB5bVp5djZJb3M0YjBZd08x?=
 =?utf-8?B?VU9yVkIxQ3ROdjIzK1lNTXMzR2dMbGpSdy9TNkF2NHRNYUJqL0RZWlpFZ1pu?=
 =?utf-8?B?clpyek9wY3IzK3lyZWU5THBsRmc2QjNndTY5bENwdlE4YVhjeHpUenZreFVp?=
 =?utf-8?B?dVB6dEdCdlhEYTZhYmFRTGtRQ0ZFd2llQlBxWGhzSnYxb3MraXdnTEpxMWZF?=
 =?utf-8?B?djRic3RqVm45b29vVEdCRTZrb1p1R0pBM2syY2EzMkJvS0VuK1lycUptVUJN?=
 =?utf-8?B?WXFXUUhBZE00ZFY1Y1IwZktVSjB5TW9rMS93K2YxdnJ6YWhwSVJXN2NuN1Ju?=
 =?utf-8?B?MUpBL1ZMUjVWaXROdEJFc0RTQmdsQ1Y0UWtjb0xuYS90UkpWWUl4TTc2cWJU?=
 =?utf-8?B?U09XTmpBeXAvZk5YVWVUWVNTUnNveFZhQjBFNTVERStOdUFEa012ZlJMSUtj?=
 =?utf-8?B?dW5aMmtkU3lhQU9VT2JxbXZDcXYyZm5aTWx5bzh4Wm8zWjVrZ0JHR3pMV01q?=
 =?utf-8?B?anh6Y3BFQ25Yd1hGZXhnVCt0NXNzeURmZHBOT2w3QUNia0p6R1dzV3FtcElT?=
 =?utf-8?B?ajI0S0FmalFtR1A2bjl6UTlZbFkxd25oUlp6WWlNaG5SNndubGpqZDU0QzNP?=
 =?utf-8?B?clpyS001eDhmZDlBTmpWWThiNEVlUDBTV1Zzd090eWJnMHUvUi96MEpOekFV?=
 =?utf-8?B?cnNPMVY0czVvY1lrVDFmRWUyc2YyMWR3VnZlSFExTDY4ZjFWNDJ2VmlaMFQz?=
 =?utf-8?B?aGgyUndsbFFZZThVaEgrVzFHVEliQ0hUYUhRNWFic0MrZFNSMTgxRjc3NG1u?=
 =?utf-8?B?c1lhTzQwSk83U2tqVnNEV1hJOUR3d2lXYjcwOFp5RnRRYnh5dHBldmpQMncx?=
 =?utf-8?B?MXM2cDZxNUN1YmhwSXczUTk0UEFoQUFSWFRHNXdHa3gyanZPMllDUVF2aFdK?=
 =?utf-8?B?WkhoWVNpN3VKU3h3ODFkNC9MVGgwMlFOeGpYdU16QTJyWTEyQTgzTlNJZEpw?=
 =?utf-8?B?MkNRV3ZhT1BzbTlIR3picGRyVVg5ZVRZSjFKa0owaFE3MWk3Vkk5QitrZ1di?=
 =?utf-8?B?OEwxYXhPTGRFaFh6Q2hJTzFvRVgrU0NjZFRPVXE3dWpJbEQwc2t1Wkp4NGRK?=
 =?utf-8?B?azlOZEJPOW8rTnArOU1HYWgyVTdCYTN4dElrd3g2RnZpaW9OL1RUcXluQVBT?=
 =?utf-8?B?L1Yxb1JSZmVVbElhYXZnWVhjcEg4TnFDODE2M1paR25QTU5Pa2J0TE1oT21Y?=
 =?utf-8?B?RWdqT3JvRzBlYjNoektuR0RLQjZZSTRRN1JMb2xTcUZYeDZVbENMZ2YxZWhM?=
 =?utf-8?B?UVhvQzlPbHZzcWRDeGY0QkE2UEoyUFJsSGNyQnBCZk16R05oa2Q0Nm13OWhx?=
 =?utf-8?B?dFdlelRFMndGeENIQWVUUjZMZDA5czBoNGRaK3BXOGVSMUNUWTUwMmFnK0xv?=
 =?utf-8?B?T0hBV01tZE1CUzdSMjJIVTBQcVFuUFlVbWZ6UUZDR3poejEyaGc3Rkl4ZVE0?=
 =?utf-8?B?cFRuekl5VnNWYWhmUnBDenplcXhFRUhLNzNCQnlZc3VxVjlPYjlTd3kzVmR6?=
 =?utf-8?B?K1FRMXV1TU02dnRHVTFjOXI2OW5rVmNLNmpXaGRKcFN6UmxLSjhJL3gvdnZp?=
 =?utf-8?B?S21tS2poekNhaks2Rm1HNjdEMkIzcmUrZUorWjF1UytXK0E1c1lOSHdNTXZX?=
 =?utf-8?B?SlV2MTRTeEVqSWk0VC9lQVBBVnB3MFJja3Y0Z1VTNEVJbmtuTkc2dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bArhNGGINnxRKIh23IcCmZrZzr0sJHES4YaVDmEx1OZ1FVY2Sbt/ned7P3bDFNkrtM9t1+PHuNupuHiXUAnHDoNMj5UX37sptoXQW7/h7YRMGzQmoEeu2TGewFf+0dEiSbMjrsw+VZk3tdAt+LgoocfOjja6ixEMlC1xVOWHipSBoYpWuq6MeheaCkfdY9wCaMy1aVP0Sqs/Q3tOAOeQs3I3waz0o80HrN/4F8KQ4awdTwwu34xIrHlich0h4qdlFSjiPz7w3pbail0Fb+xiYIUFNKwEbKR/s+uJI83uatcVsMx/lyauY3Sx3zLIaOHxbAxJj7WO29FLF12X1iRjZw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7442.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ec9e55-4fb8-41d3-9e33-08de86a7815b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 17:38:32.0656 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zvFia6fsge5VGTzmnJjuxrOEVBpoUVK2qm4mpsh2plXqAHwf9I2WsHZ0GX8pemmqWsHRW9kpQQrPGkqdrpPcN1osFaOY3EcR5lbbJEeoFG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6131
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgTWFyY2hhbmQg
PGRhdmlkLm1hcmNoYW5kQHJlZGhhdC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgTWFyY2ggMjAsIDIw
MjYgMTozMyBQTQ0KPiBUbzogZGV2QGRwZGsub3JnDQo+IENjOiBzdGFibGVAZHBkay5vcmc7IER1
bWl0cmVzY3UsIENyaXN0aWFuIDxjcmlzdGlhbi5kdW1pdHJlc2N1QGludGVsLmNvbT4NCj4gU3Vi
amVjdDogW1BBVENIXSBwaXBlbGluZTogZml4IGJ1aWxkIHdpdGggc2FuaXRpemVycyBvciBkZWJ1
ZyBvcHRpb25zDQo+IA0KPiBTaW1pbGFyIHRvIGNvbW1pdCA4NGY1YWM5NDE4ZWEgKCJwaXBlbGlu
ZTogZml4IGJ1aWxkIHdpdGggQVNhbiIpLg0KPiANCj4gSGVyZSB3ZSBhcmUgYWdhaW4uIERlcGVu
ZGluZyBvbiBvcHRpb25zIChsaWtlIGRlYnVnLCBvciBBU2FuLCBvciBVQlNhbiksDQo+IGNvbXBp
bGF0aW9uIGNhbiBmYWlsIGJlY2F1c2Ugb2YgZHVtYiBjb25zdHJ1Y3QgbGlrZSBDSEVDSygwLCBY
WFgpLg0KPiBEdW1iLCBiZWNhdXNlIHN1Y2ggYW4gZXhwcmVzc2lvbiBtYWNybyBleHBhbmRzIGFz
OiBpZiAoMCkgcmV0dXJuIC1YWFg7DQo+IA0KPiAuLi9saWIvcGlwZWxpbmUvcnRlX3N3eF9waXBl
bGluZS5jOiBJbiBmdW5jdGlvbiDigJhpbnN0cl9tb3ZoX3RyYW5zbGF0ZeKAmToNCj4gLi4vbGli
L3BpcGVsaW5lL3J0ZV9zd3hfcGlwZWxpbmUuYzozNDYxOjE6IGVycm9yOiBjb250cm9sIHJlYWNo
ZXMgZW5kIG9mDQo+IAlub24tdm9pZCBmdW5jdGlvbiBbLVdlcnJvcj1yZXR1cm4tdHlwZV0NCj4g
IDM0NjEgfCB9DQo+ICAgICAgIHwgXg0KPiANCj4gUmVtb3ZlIGFueSBzdWNoIGNhbGwgd2hlbiBh
dCB0aGUgZW5kIG9mIGZ1bmN0aW9ucywgdXNpbmcgYSByZWdleHA6DQo+ICVzL0NIRUNLKDAsIFwo
LipcKSlcKDtcbn1cKS9yZXR1cm4gLVwxXDIvDQo+IA0KPiBDYzogc3RhYmxlQGRwZGsub3JnDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBNYXJjaGFuZCA8ZGF2aWQubWFyY2hhbmRAcmVkaGF0
LmNvbT4NCj4gLS0tDQoNCkFja2VkLWJ5OiBDcmlzdGlhbiBEdW1pdHJlc2N1IDxjcmlzdGlhbi5k
dW1pdHJlc2N1QGludGVsLmNvbT4NCg==
